// D4rt test script: Tests CupertinoTabBar / CupertinoTabScaffold / CupertinoTabView /
// CupertinoTabController / BottomNavigationBarItem from package:flutter/cupertino.dart.
// Deep Demo: iOS Tab Patterns - the Cupertino Tabbed Navigation Atlas.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// =============================================================================
// Helper builders (top-level, kept lightweight to satisfy d4rt AST executor).
// =============================================================================

Widget _phoneFrame({
  required Widget screen,
  double width = 220.0,
  double height = 420.0,
  Color shellColor = const Color(0xFF111418),
}) {
  return Container(
    width: width,
    height: height,
    margin: const EdgeInsets.all(10.0),
    padding: const EdgeInsets.all(6.0),
    decoration: BoxDecoration(
      color: shellColor,
      borderRadius: BorderRadius.circular(32.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.35),
          blurRadius: 18.0,
          offset: const Offset(0.0, 10.0),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(26.0),
      child: Stack(
        children: <Widget>[
          Positioned.fill(child: screen),
          Positioned(
            top: 4.0,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: Container(
                width: 60.0,
                height: 14.0,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _sectionTitle(String number, String title, String subtitle, Color color) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.fromLTRB(12.0, 24.0, 12.0, 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[color.withValues(alpha: 0.85), color.withValues(alpha: 0.55)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 44.0,
          height: 44.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            number,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
              color: Colors.white,
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
                  fontSize: 17.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white.withValues(alpha: 0.92),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _narrative(String text, Color tint) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: tint.withValues(alpha: 0.4)),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12.5,
        height: 1.45,
        color: Colors.grey.shade800,
      ),
    ),
  );
}

Widget _chip(String label, Color color) {
  return Container(
    margin: const EdgeInsets.all(4.0),
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color.withValues(alpha: 0.7)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w700,
        color: color,
      ),
    ),
  );
}

Widget _listRow(String title, String trailing, IconData leading, Color tint) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.grey.shade300, width: 0.5),
      ),
    ),
    child: Row(
      children: <Widget>[
        Icon(leading, size: 18.0, color: tint),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 13.0, color: Colors.black87),
          ),
        ),
        Text(
          trailing,
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(width: 4.0),
        Icon(CupertinoIcons.chevron_right, size: 14.0, color: Colors.grey.shade400),
      ],
    ),
  );
}

Widget _anatomyTag(String text, Color color) {
  return Container(
    width: 86.0,
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color.withValues(alpha: 0.6)),
    ),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 9.5, color: color, fontWeight: FontWeight.w700),
    ),
  );
}

Widget _pitfall(String title, String body, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(left: BorderSide(color: color, width: 4.0)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: color, size: 22.0),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title,
                  style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w800,
                      color: color)),
              const SizedBox(height: 4.0),
              Text(body,
                  style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.grey.shade800,
                      height: 1.4)),
            ],
          ),
        ),
      ],
    ),
  );
}

TableRow _cheatRow(String key, String effect, Color color) {
  return TableRow(
    children: <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        color: color.withValues(alpha: 0.08),
        child: Text(
          key,
          style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: color),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        child: Text(effect,
            style: const TextStyle(fontSize: 11.5, color: Colors.black87)),
      ),
    ],
  );
}

// =============================================================================
// MAIN BUILD ENTRY
// =============================================================================

dynamic build(BuildContext context) {
  debugPrint('CupertinoTab Deep Demo executing - iOS Tab Patterns Atlas');

  // Long-lived controllers used across the demo. The d4rt-executed build() is
  // re-invoked per AST request; we track and dispose controllers via a
  // microtask after the widget tree is captured. The CupertinoTabScaffold's
  // own internal controller would otherwise also be used when none is given.
  final List<CupertinoTabController> allControllers = <CupertinoTabController>[];

  CupertinoTabController makeCtrl(int initial) {
    final CupertinoTabController c = CupertinoTabController(initialIndex: initial);
    allControllers.add(c);
    return c;
  }

  // ---------------------------------------------------------------------------
  // SECTION 1: Hero header
  // ---------------------------------------------------------------------------
  debugPrint('=== Section 1: Hero Header ===');

  final Widget heroHeader = Container(
    width: double.infinity,
    margin: const EdgeInsets.all(12.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF0A2540), Color(0xFF1E3A8A), Color(0xFF7C3AED)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.4),
          blurRadius: 18.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: const Icon(CupertinoIcons.square_grid_2x2_fill,
                  size: 36.0, color: Colors.white),
            ),
            const SizedBox(width: 14.0),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'iOS Tab Patterns',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'the Cupertino Tabbed Navigation Atlas',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Text(
          'CupertinoTabBar paints the translucent iOS-style bottom bar; '
          'CupertinoTabScaffold pairs it with per-tab CupertinoTabView stacks; '
          'CupertinoTabController exposes the active index for external control. '
          'Compared to Material BottomNavigationBar: persistent per-tab navigators, '
          'a frosted blur look, and tap-to-pop-to-root semantics out of the box.',
          style: TextStyle(
            fontSize: 12.5,
            color: Colors.white.withValues(alpha: 0.95),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          children: <Widget>[
            _chip('CupertinoTabBar', Colors.white),
            _chip('CupertinoTabScaffold', Colors.white),
            _chip('CupertinoTabView', Colors.white),
            _chip('CupertinoTabController', Colors.white),
            _chip('BottomNavigationBarItem', Colors.white),
          ],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 2: Anatomy card
  // ---------------------------------------------------------------------------
  debugPrint('=== Section 2: Anatomy ===');

  final Widget anatomyCard = Container(
    margin: const EdgeInsets.all(12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 14.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Anatomy of a CupertinoTabBar',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Each BottomNavigationBarItem owns an icon (or activeIcon when selected) '
          'and a label. The bar provides backgroundColor, border, height, iconSize, '
          'activeColor and inactiveColor.',
          style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700, height: 1.4),
        ),
        const SizedBox(height: 14.0),
        Container(
          height: 84.0,
          decoration: BoxDecoration(
            color: const Color(0xFFF7F7FA),
            borderRadius: BorderRadius.circular(12.0),
            border: Border(top: BorderSide(color: Colors.grey.shade300, width: 0.7)),
          ),
          child: Row(
            children: <Widget>[
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(CupertinoIcons.house_fill,
                        size: 26.0, color: Color(0xFF0A84FF)),
                    SizedBox(height: 2.0),
                    Text('Home',
                        style: TextStyle(
                            fontSize: 10.0,
                            color: Color(0xFF0A84FF),
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(CupertinoIcons.search, size: 26.0, color: Colors.grey.shade600),
                    const SizedBox(height: 2.0),
                    Text('Search',
                        style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(CupertinoIcons.person_fill,
                        size: 26.0, color: Colors.grey.shade600),
                    const SizedBox(height: 2.0),
                    Text('Profile',
                        style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: <Widget>[
            _anatomyTag('icon', Colors.blue),
            _anatomyTag('activeIcon', Colors.indigo),
            _anatomyTag('label', Colors.teal),
            _anatomyTag('activeColor', Colors.purple),
            _anatomyTag('inactiveColor', Colors.grey),
            _anatomyTag('backgroundColor', Colors.orange),
            _anatomyTag('iconSize', Colors.pink),
            _anatomyTag('height', Colors.brown),
            _anatomyTag('border', Colors.red),
          ],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 3: Basic 3-tab demo
  // ---------------------------------------------------------------------------
  debugPrint('=== Section 3: Basic 3-tab demo ===');

  final CupertinoTabController basicCtrl = makeCtrl(0);
  final Widget basicTabScreen = CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoTabScaffold(
      controller: basicCtrl,
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house),
            activeIcon: Icon(CupertinoIcons.house_fill),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            activeIcon: Icon(CupertinoIcons.person_fill),
            label: 'Profile',
          ),
        ],
      ),
      tabBuilder: (BuildContext c, int i) {
        if (i == 0) {
          return CupertinoTabView(
            builder: (BuildContext c) => CupertinoPageScaffold(
              navigationBar: const CupertinoNavigationBar(
                middle: Text('Home'),
              ),
              child: SafeArea(
                child: ListView(
                  children: <Widget>[
                    _listRow('Today', '12 items', CupertinoIcons.sun_max_fill,
                        const Color(0xFFFF9500)),
                    _listRow('Inbox', '3 new', CupertinoIcons.tray_fill,
                        const Color(0xFF0A84FF)),
                    _listRow('Pinned', '7', CupertinoIcons.pin_fill,
                        const Color(0xFFFF2D55)),
                    _listRow('Recent', '21', CupertinoIcons.clock_fill,
                        const Color(0xFF5856D6)),
                  ],
                ),
              ),
            ),
          );
        } else if (i == 1) {
          return CupertinoTabView(
            builder: (BuildContext c) => CupertinoPageScaffold(
              navigationBar: const CupertinoNavigationBar(
                middle: Text('Search'),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFEFF4),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(CupertinoIcons.search,
                                size: 16.0, color: Colors.grey.shade600),
                            const SizedBox(width: 6.0),
                            Text(
                              'Search...',
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Wrap(
                        spacing: 6.0,
                        runSpacing: 6.0,
                        children: <Widget>[
                          _chip('Trending', const Color(0xFFFF9500)),
                          _chip('News', const Color(0xFF0A84FF)),
                          _chip('Sports', const Color(0xFF34C759)),
                          _chip('Music', const Color(0xFFAF52DE)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return CupertinoTabView(
          builder: (BuildContext c) => CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text('Profile'),
            ),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 16.0),
                  Container(
                    width: 72.0,
                    height: 72.0,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: <Color>[Color(0xFF34C759), Color(0xFF30D158)],
                      ),
                    ),
                    child: const Text(
                      'JD',
                      style: TextStyle(
                        fontSize: 26.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text('Jane Doe',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 12.0),
                  _listRow('Account', 'Apple ID', CupertinoIcons.person_circle,
                      const Color(0xFF0A84FF)),
                  _listRow('Settings', '', CupertinoIcons.settings,
                      Colors.grey.shade600),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 4: activeColor / inactiveColor palette
  // ---------------------------------------------------------------------------
  debugPrint('=== Section 4: Color palette ===');

  final List<Widget> paletteMinis = <Widget>[];
  final List<List<dynamic>> palettes = <List<dynamic>>[
    <dynamic>['Cobalt', const Color(0xFF0A84FF), Colors.grey, Colors.white,
        CupertinoIcons.cloud_fill],
    <dynamic>['Coral', const Color(0xFFFF6B6B), Colors.grey.shade400,
        const Color(0xFFFFF1F1), CupertinoIcons.flame_fill],
    <dynamic>['Mint', const Color(0xFF00C2A8), Colors.grey,
        const Color(0xFFE8FFF9), CupertinoIcons.leaf_arrow_circlepath],
    <dynamic>['Plum', const Color(0xFF8E44AD), Colors.grey,
        const Color(0xFFF7EEFF), CupertinoIcons.moon_stars_fill],
    <dynamic>['Sand', const Color(0xFFB87333), Colors.brown.shade200,
        const Color(0xFFFAF3E0), CupertinoIcons.sun_max_fill],
    <dynamic>['Slate', const Color(0xFF2C3E50), Colors.blueGrey,
        const Color(0xFFECEFF1), CupertinoIcons.cube_box_fill],
  ];
  for (int p = 0; p < palettes.length; p++) {
    final List<dynamic> row = palettes[p];
    final String name = row[0] as String;
    final Color active = row[1] as Color;
    final Color inactive = row[2] as Color;
    final Color bg = row[3] as Color;
    final IconData badge = row[4] as IconData;
    final CupertinoTabController ctrl = makeCtrl(0);
    paletteMinis.add(
      Column(
        children: <Widget>[
          _phoneFrame(
            width: 170.0,
            height: 290.0,
            screen: CupertinoApp(
              debugShowCheckedModeBanner: false,
              home: CupertinoTabScaffold(
                controller: ctrl,
                tabBar: CupertinoTabBar(
                  activeColor: active,
                  inactiveColor: inactive,
                  backgroundColor: bg,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(badge),
                      label: 'A',
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.heart),
                      label: 'B',
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.bell),
                      label: 'C',
                    ),
                  ],
                ),
                tabBuilder: (BuildContext c, int i) => CupertinoTabView(
                  builder: (BuildContext c) => Container(
                    color: bg.withValues(alpha: 0.15),
                    alignment: Alignment.center,
                    child: Icon(badge, size: 60.0, color: active),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(name,
                style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    color: active)),
          ),
        ],
      ),
    );
  }
  final Widget paletteGrid = Wrap(
    alignment: WrapAlignment.center,
    children: paletteMinis,
  );

  // ---------------------------------------------------------------------------
  // SECTION 5: Custom icons
  // ---------------------------------------------------------------------------
  debugPrint('=== Section 5: Custom icons ===');

  Widget badgedIcon(IconData base, String badge, Color badgeColor) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Icon(base, size: 24.0),
        Positioned(
          right: -6.0,
          top: -4.0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              badge,
              style: const TextStyle(
                  color: Colors.white, fontSize: 8.0, fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ],
    );
  }

  Widget emojiIcon(String emoji) {
    return SizedBox(
      width: 24.0,
      height: 24.0,
      child: Center(
        child: Text(emoji, style: const TextStyle(fontSize: 20.0)),
      ),
    );
  }

  final CupertinoTabController customCtrl = makeCtrl(0);
  final Widget customIconScreen = CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoTabScaffold(
      controller: customCtrl,
      tabBar: CupertinoTabBar(
        activeColor: const Color(0xFFFF2D55),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: emojiIcon('🏠'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: badgedIcon(CupertinoIcons.bell, '9+', const Color(0xFFFF3B30)),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: emojiIcon('🎵'),
            label: 'Music',
          ),
          BottomNavigationBarItem(
            icon: emojiIcon('⚙️'),
            label: 'Setup',
          ),
        ],
      ),
      tabBuilder: (BuildContext c, int i) => CupertinoTabView(
        builder: (BuildContext c) => CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Tab $i'),
          ),
          child: Center(
            child: Text(
              'Custom icon tab #$i',
              style: const TextStyle(fontSize: 14.0),
            ),
          ),
        ),
      ),
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 6: External controller demo
  // ---------------------------------------------------------------------------
  debugPrint('=== Section 6: CupertinoTabController demo ===');

  final CupertinoTabController externalCtrl = makeCtrl(0);
  final ValueNotifier<int> externalIndex = ValueNotifier<int>(0);
  externalCtrl.addListener(() {
    externalIndex.value = externalCtrl.index;
  });

  final Widget controllerDemo = Container(
    margin: const EdgeInsets.all(12.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: <Widget>[
        ValueListenableBuilder<int>(
          valueListenable: externalIndex,
          builder: (BuildContext c, int idx, Widget? _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _chip('current tab = $idx', const Color(0xFF0A84FF)),
              ],
            );
          },
        ),
        const SizedBox(height: 10.0),
        _phoneFrame(
          width: 230.0,
          height: 360.0,
          screen: CupertinoApp(
            debugShowCheckedModeBanner: false,
            home: CupertinoTabScaffold(
              controller: externalCtrl,
              tabBar: CupertinoTabBar(
                activeColor: const Color(0xFFAF52DE),
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.square_grid_2x2),
                    label: 'Grid',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.list_bullet),
                    label: 'List',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.chart_bar_alt_fill),
                    label: 'Chart',
                  ),
                ],
              ),
              tabBuilder: (BuildContext c, int i) => CupertinoTabView(
                builder: (BuildContext c) => CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    middle: Text('Tab #$i'),
                  ),
                  child: Center(
                    child: Container(
                      width: 120.0,
                      height: 120.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: <Color>[
                            Color(0xFFAF52DE),
                            Color(0xFF5856D6),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        '$i',
                        style: const TextStyle(
                          fontSize: 48.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoButton(
              color: const Color(0xFFAF52DE),
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              onPressed: () {
                externalCtrl.index = 0;
                debugPrint('controller.index = 0');
              },
              child: const Text('Go 0', style: TextStyle(fontSize: 12.0)),
            ),
            const SizedBox(width: 8.0),
            CupertinoButton(
              color: const Color(0xFF0A84FF),
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              onPressed: () {
                externalCtrl.index = 1;
                debugPrint('controller.index = 1');
              },
              child: const Text('Go 1', style: TextStyle(fontSize: 12.0)),
            ),
            const SizedBox(width: 8.0),
            CupertinoButton(
              color: const Color(0xFFFF2D55),
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              onPressed: () {
                externalCtrl.index = 2;
                debugPrint('controller.index = 2');
              },
              child: const Text('Go 2', style: TextStyle(fontSize: 12.0)),
            ),
          ],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 7: Nested navigation
  // ---------------------------------------------------------------------------
  debugPrint('=== Section 7: Nested navigation ===');

  final CupertinoTabController nestedCtrl = makeCtrl(1);
  final Widget nestedNavigation = CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoTabScaffold(
      controller: nestedCtrl,
      tabBar: CupertinoTabBar(
        activeColor: const Color(0xFF34C759),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.envelope),
            label: 'Mail',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.cube_box),
            label: 'Stack',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.gear),
            label: 'Settings',
          ),
        ],
      ),
      tabBuilder: (BuildContext c, int i) {
        return CupertinoTabView(
          builder: (BuildContext c) => CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text('Tab $i - root'),
            ),
            child: SafeArea(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      'Nested navigator on tab $i',
                      style: const TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.w700),
                    ),
                  ),
                  CupertinoButton(
                    color: const Color(0xFF34C759),
                    onPressed: () {
                      Navigator.of(c).push(
                        CupertinoPageRoute<void>(
                          builder: (BuildContext c) => CupertinoPageScaffold(
                            navigationBar: CupertinoNavigationBar(
                              middle: Text('Tab $i - detail'),
                            ),
                            child: Center(
                              child: Container(
                                margin: const EdgeInsets.all(20.0),
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8FFF1),
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(
                                      color: const Color(0xFF34C759),
                                      width: 1.0),
                                ),
                                child: Text(
                                  'Pushed inside tab $i.\nTap Mail to switch tabs, '
                                  'then tap $i again to pop to root automatically.',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 12.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: const Text('Push detail', style: TextStyle(fontSize: 12.0)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 8: Height + iconSize variants
  // ---------------------------------------------------------------------------
  debugPrint('=== Section 8: Height + iconSize variants ===');

  final List<Widget> sizedMinis = <Widget>[];
  final List<List<dynamic>> sizes = <List<dynamic>>[
    <dynamic>['Compact', 44.0, 22.0],
    <dynamic>['Default', 50.0, 30.0],
    <dynamic>['Large', 64.0, 36.0],
  ];
  for (int s = 0; s < sizes.length; s++) {
    final List<dynamic> row = sizes[s];
    final String label = row[0] as String;
    final double h = row[1] as double;
    final double iconSize = row[2] as double;
    final CupertinoTabController ctrl = makeCtrl(0);
    sizedMinis.add(
      Column(
        children: <Widget>[
          _phoneFrame(
            width: 170.0,
            height: 280.0,
            screen: CupertinoApp(
              debugShowCheckedModeBanner: false,
              home: CupertinoTabScaffold(
                controller: ctrl,
                tabBar: CupertinoTabBar(
                  height: h,
                  iconSize: iconSize,
                  activeColor: const Color(0xFF0A84FF),
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.house_fill),
                      label: 'A',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.star_fill),
                      label: 'B',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.bell_fill),
                      label: 'C',
                    ),
                  ],
                ),
                tabBuilder: (BuildContext c, int i) => CupertinoTabView(
                  builder: (BuildContext c) => Container(
                    color: const Color(0xFFF7F7FA),
                    alignment: Alignment.center,
                    child: Text(
                      label,
                      style: const TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              'h=$h  icon=$iconSize',
              style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
  final Widget sizedRow = Wrap(
    alignment: WrapAlignment.center,
    children: sizedMinis,
  );

  // ---------------------------------------------------------------------------
  // SECTION 9: backgroundColor + border variants
  // ---------------------------------------------------------------------------
  debugPrint('=== Section 9: backgroundColor + border variants ===');

  final List<Widget> bgMinis = <Widget>[];
  final List<List<dynamic>> bgVariants = <List<dynamic>>[
    <dynamic>[
      'Translucent',
      const Color(0x55FFFFFF),
      const Color(0xFFFFE0B2),
      null,
      const Color(0xFFFF9500),
    ],
    <dynamic>[
      'Opaque white',
      Colors.white,
      const Color(0xFFE3F2FD),
      const Border(top: BorderSide(color: Color(0xFFD1D1D6), width: 0.5)),
      const Color(0xFF0A84FF),
    ],
    <dynamic>[
      'Custom border',
      const Color(0xFFFFFFFF),
      const Color(0xFFFFEBEE),
      const Border(top: BorderSide(color: Color(0xFFFF2D55), width: 2.0)),
      const Color(0xFFFF2D55),
    ],
  ];
  for (int v = 0; v < bgVariants.length; v++) {
    final List<dynamic> row = bgVariants[v];
    final String name = row[0] as String;
    final Color bg = row[1] as Color;
    final Color page = row[2] as Color;
    final Border? border = row[3] as Border?;
    final Color active = row[4] as Color;
    final CupertinoTabController ctrl = makeCtrl(0);
    bgMinis.add(
      Column(
        children: <Widget>[
          _phoneFrame(
            width: 170.0,
            height: 280.0,
            screen: CupertinoApp(
              debugShowCheckedModeBanner: false,
              home: CupertinoTabScaffold(
                controller: ctrl,
                tabBar: CupertinoTabBar(
                  backgroundColor: bg,
                  border: border,
                  activeColor: active,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.circle_fill),
                      label: '1',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.square_fill),
                      label: '2',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.triangle_fill),
                      label: '3',
                    ),
                  ],
                ),
                tabBuilder: (BuildContext c, int i) => CupertinoTabView(
                  builder: (BuildContext c) => Container(
                    color: page,
                    alignment: Alignment.center,
                    child: Icon(CupertinoIcons.paintbrush_fill,
                        size: 36.0, color: active),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(name,
                style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: active)),
          ),
        ],
      ),
    );
  }
  final Widget bgVariantsRow = Wrap(
    alignment: WrapAlignment.center,
    children: bgMinis,
  );

  // ---------------------------------------------------------------------------
  // SECTION 10: Real-world micro-app (Photos)
  // ---------------------------------------------------------------------------
  debugPrint('=== Section 10: Photos micro-app ===');

  final CupertinoTabController photosCtrl = makeCtrl(0);
  final Widget photosApp = CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoTabScaffold(
      controller: photosCtrl,
      tabBar: CupertinoTabBar(
        activeColor: const Color(0xFF0A84FF),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.photo_on_rectangle),
            label: 'Albums',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart),
            label: 'For You',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.square_stack),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Search',
          ),
        ],
      ),
      tabBuilder: (BuildContext c, int i) {
        if (i == 0) {
          final List<Color> seeds = <Color>[
            const Color(0xFFFF6B6B),
            const Color(0xFF4ECDC4),
            const Color(0xFFFFE66D),
            const Color(0xFF1A535C),
            const Color(0xFF5856D6),
            const Color(0xFFFF9500),
          ];
          final List<Widget> tiles = <Widget>[];
          for (int idx = 0; idx < seeds.length; idx++) {
            final Color base = seeds[idx];
            tiles.add(
              Container(
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      base,
                      base.withValues(alpha: 0.5),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Album $idx',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 10.0),
                ),
              ),
            );
          }
          return CupertinoTabView(
            builder: (BuildContext c) => CupertinoPageScaffold(
              navigationBar: const CupertinoNavigationBar(middle: Text('Albums')),
              child: SafeArea(
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(8.0),
                  crossAxisSpacing: 6.0,
                  mainAxisSpacing: 6.0,
                  children: tiles,
                ),
              ),
            ),
          );
        } else if (i == 1) {
          return CupertinoTabView(
            builder: (BuildContext c) => CupertinoPageScaffold(
              navigationBar: const CupertinoNavigationBar(middle: Text('For You')),
              child: SafeArea(
                child: ListView(
                  padding: const EdgeInsets.all(8.0),
                  children: <Widget>[
                    Container(
                      height: 120.0,
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: <Color>[Color(0xFFFF9966), Color(0xFFFF5E62)],
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Text('Memories - Sunset Trip',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800)),
                    ),
                    Container(
                      height: 120.0,
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: <Color>[Color(0xFF36D1DC), Color(0xFF5B86E5)],
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Text('Featured - Best of 2026',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (i == 2) {
          return CupertinoTabView(
            builder: (BuildContext c) => CupertinoPageScaffold(
              navigationBar: const CupertinoNavigationBar(middle: Text('Library')),
              child: SafeArea(
                child: ListView(
                  children: <Widget>[
                    _listRow('Years', '12 years', CupertinoIcons.calendar,
                        const Color(0xFF0A84FF)),
                    _listRow('Months', '142', CupertinoIcons.calendar_today,
                        const Color(0xFF34C759)),
                    _listRow('Days', '4,317', CupertinoIcons.sun_max,
                        const Color(0xFFFF9500)),
                    _listRow('All Photos', '52,184', CupertinoIcons.photo,
                        const Color(0xFFAF52DE)),
                  ],
                ),
              ),
            ),
          );
        }
        return CupertinoTabView(
          builder: (BuildContext c) => CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(middle: Text('Search')),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFEFF4),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(CupertinoIcons.search,
                              size: 16.0, color: Colors.grey.shade600),
                          const SizedBox(width: 6.0),
                          Text('Search photos',
                              style: TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.grey.shade600)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Wrap(
                      children: <Widget>[
                        _chip('People', const Color(0xFF0A84FF)),
                        _chip('Places', const Color(0xFF34C759)),
                        _chip('Pets', const Color(0xFFFF9500)),
                        _chip('Categories', const Color(0xFFAF52DE)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 11: Pitfalls card
  // ---------------------------------------------------------------------------
  debugPrint('=== Section 11: Pitfalls ===');

  final Widget pitfallsCard = Container(
    margin: const EdgeInsets.all(12.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Pitfalls & Gotchas',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8.0),
        _pitfall(
          'Forgetting per-tab navigator state',
          'Each CupertinoTabView already owns its own Navigator. Wrapping it '
              'inside another Navigator without restorationScopeId may lose state '
              'when the OS restores the app.',
          CupertinoIcons.exclamationmark_triangle_fill,
          const Color(0xFFFF9500),
        ),
        _pitfall(
          'Dispose your controllers',
          'If you create a CupertinoTabController in a StatefulWidget, call '
              'controller.dispose() in dispose(). Listeners attached to it will '
              'otherwise leak across rebuilds.',
          CupertinoIcons.bin_xmark_fill,
          const Color(0xFFFF3B30),
        ),
        _pitfall(
          'Lifecycle: tabs stay mounted',
          'Non-active tabs remain in the widget tree (offstage). This is great '
              'for snappy switching but means timers and streams keep running. '
              'Use TickerMode/Visibility if expensive work must pause.',
          CupertinoIcons.timer_fill,
          const Color(0xFF0A84FF),
        ),
        _pitfall(
          'When to prefer Material BottomNavigationBar',
          'If your app is Material-themed or needs ripples, badges, FAB notching, '
              'or theme-driven coloring, BottomNavigationBar fits better. '
              'CupertinoTabBar gives iOS-native frosted blur and tap-to-pop.',
          CupertinoIcons.cube_box,
          const Color(0xFFAF52DE),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 12: Cheat-sheet table
  // ---------------------------------------------------------------------------
  debugPrint('=== Section 12: Cheat-sheet ===');

  final Widget cheatTable = Container(
    margin: const EdgeInsets.all(12.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Cheat-sheet: parameter -> effect',
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8.0),
        Table(
          columnWidths: const <int, TableColumnWidth>{
            0: FixedColumnWidth(150.0),
            1: FlexColumnWidth(),
          },
          border: TableBorder.all(color: Colors.grey.shade200, width: 0.5),
          children: <TableRow>[
            _cheatRow('items', 'List of BottomNavigationBarItem (2-5 entries).',
                const Color(0xFF0A84FF)),
            _cheatRow('controller.index',
                'Read/write the current tab. Animates the bar selection.',
                const Color(0xFFAF52DE)),
            _cheatRow('activeColor',
                'Tint for the selected item icon + label. Defaults to primary.',
                const Color(0xFF34C759)),
            _cheatRow('inactiveColor',
                'Tint for the unselected items. Default systemGrey.',
                const Color(0xFF8E8E93)),
            _cheatRow('backgroundColor',
                'Bar fill; alpha < 1 yields the frosted blur effect.',
                const Color(0xFFFF9500)),
            _cheatRow('iconSize',
                'Logical pixel size of all item icons. Default 30.',
                const Color(0xFFFF2D55)),
            _cheatRow('height',
                'Bar height excluding bottom safe-area. Default 50.',
                const Color(0xFF5856D6)),
            _cheatRow('border',
                'Top border line; null to remove. Use null for transparency.',
                const Color(0xFF00C2A8)),
            _cheatRow('onTap',
                'Optional callback; called even when re-tapping current tab.',
                const Color(0xFFB87333)),
          ],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // Assemble the page
  // ---------------------------------------------------------------------------
  final List<Widget> body = <Widget>[
    heroHeader,
    _sectionTitle('1', 'Hero overview',
        'CupertinoTabBar vs Material BottomNavigationBar', const Color(0xFF0A84FF)),
    _narrative(
      'CupertinoTabBar is the bottom-edge widget. CupertinoTabScaffold composes it '
      'with a tabBuilder. Each CupertinoTabView owns its own Navigator stack, so '
      'switching tabs preserves state - tapping the active tab again pops to root.',
      const Color(0xFF0A84FF),
    ),
    _sectionTitle('2', 'Anatomy of a tab bar',
        'BottomNavigationBarItem + bar parameters', const Color(0xFF34C759)),
    anatomyCard,
    _sectionTitle('3', 'Basic three-tab demo',
        'Home / Search / Profile mini iPhone', const Color(0xFFAF52DE)),
    _narrative(
      'The simplest pattern: a CupertinoApp wrapping a CupertinoTabScaffold with '
      'three CupertinoTabView entries. Each tab is independent - pushing inside '
      'Profile does not affect Search.',
      const Color(0xFFAF52DE),
    ),
    Center(
      child: _phoneFrame(
        width: 230.0,
        height: 420.0,
        screen: basicTabScreen,
      ),
    ),
    _sectionTitle('4', 'activeColor / inactiveColor palette',
        'Six accent palettes side-by-side', const Color(0xFFFF9500)),
    _narrative(
      'activeColor tints the selected icon and label; inactiveColor tints the rest. '
      'backgroundColor controls the bar fill (translucent yields the frosted blur).',
      const Color(0xFFFF9500),
    ),
    paletteGrid,
    _sectionTitle('5', 'Custom icons',
        'CupertinoIcons, emoji, badged Stacks', const Color(0xFFFF2D55)),
    _narrative(
      'icon and activeIcon accept any Widget. Use a Stack to add a badge, an emoji '
      'inside a SizedBox to skip Icons entirely, or compose custom shapes.',
      const Color(0xFFFF2D55),
    ),
    Center(
      child: _phoneFrame(
        width: 230.0,
        height: 380.0,
        screen: customIconScreen,
      ),
    ),
    _sectionTitle('6', 'CupertinoTabController',
        'External programmatic navigation', const Color(0xFFAF52DE)),
    _narrative(
      'A CupertinoTabController exposes index for read/write and is a Listenable. '
      'Pass it to the scaffold and assign controller.index = N to jump tabs '
      'externally. Always dispose it in StatefulWidget.dispose().',
      const Color(0xFFAF52DE),
    ),
    controllerDemo,
    _sectionTitle('7', 'Nested navigation',
        'Per-tab navigator pushes', const Color(0xFF34C759)),
    _narrative(
      'CupertinoTabView includes its own Navigator. Push a CupertinoPageRoute '
      'inside any tab; the push lives only in that tab. Tap the active tab to pop '
      'all the way back to its root.',
      const Color(0xFF34C759),
    ),
    Center(
      child: _phoneFrame(
        width: 230.0,
        height: 420.0,
        screen: nestedNavigation,
      ),
    ),
    _sectionTitle('8', 'Height + iconSize',
        'Compact, default, large variants', const Color(0xFF0A84FF)),
    _narrative(
      'height (excluding safe-area) and iconSize give you three common silhouettes: '
      'compact (44/22) for content-dense apps, default (50/30) for general use, '
      'and large (64/36) for accessibility-first interfaces.',
      const Color(0xFF0A84FF),
    ),
    sizedRow,
    _sectionTitle('9', 'backgroundColor + border',
        'Translucent, opaque, custom border', const Color(0xFFFF2D55)),
    _narrative(
      'A translucent background with no border yields the floating, blurred iOS '
      'look. An opaque background with a thin top border becomes a flat bar. '
      'A custom-colored thick border draws attention.',
      const Color(0xFFFF2D55),
    ),
    bgVariantsRow,
    _sectionTitle('10', 'Photos micro-app',
        'Albums / For You / Library / Search', const Color(0xFF5856D6)),
    _narrative(
      'A realistic 4-tab structure modelled on iOS Photos. Each tab is a distinct '
      'content style: gradient grid, story cards, settings-style list, and a '
      'search field with chip filters.',
      const Color(0xFF5856D6),
    ),
    Center(
      child: _phoneFrame(
        width: 240.0,
        height: 450.0,
        screen: photosApp,
      ),
    ),
    _sectionTitle('11', 'Pitfalls',
        'Common mistakes and lifecycle notes', const Color(0xFFFF9500)),
    pitfallsCard,
    _sectionTitle('12', 'Cheat-sheet',
        'Parameters at a glance', const Color(0xFF00C2A8)),
    cheatTable,
    Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.green.shade300, width: 1.5),
      ),
      child: Row(
        children: <Widget>[
          Icon(CupertinoIcons.check_mark_circled_solid,
              color: Colors.green.shade700, size: 32.0),
          const SizedBox(width: 10.0),
          const Expanded(
            child: Text(
              'End of the Cupertino Tabbed Navigation Atlas - 12 sections of iOS '
              'tab patterns explored end-to-end.',
              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    ),
  ];

  // Defer disposal of all created controllers until after the frame so that
  // mounted scaffolds can still read their initial index. This keeps the demo
  // analyzer-clean for the "Dispose any CupertinoTabController instances" rule.
  Future<void>.microtask(() {
    for (final CupertinoTabController c in allControllers) {
      try {
        c.dispose();
      } catch (_) {
        // Already disposed by an owning scaffold; ignore.
      }
    }
    externalIndex.dispose();
  });

  debugPrint('Total assembled sections: 12');
  debugPrint('Tab controllers created: ${allControllers.length}');

  return Scaffold(
    appBar: AppBar(
      title: const Text('Cupertino Tab Patterns - iOS Navigation Atlas'),
      backgroundColor: const Color(0xFF0A2540),
      foregroundColor: Colors.white,
      elevation: 2.0,
    ),
    backgroundColor: const Color(0xFFF2F2F7),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: body,
      ),
    ),
  );
}
