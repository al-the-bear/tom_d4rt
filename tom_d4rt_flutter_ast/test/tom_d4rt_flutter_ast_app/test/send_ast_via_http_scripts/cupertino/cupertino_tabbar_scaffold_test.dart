// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: deep visual demo of CupertinoTabBar / CupertinoTabScaffold.
//
// Shows the capability surface of CupertinoTabBar, CupertinoTabScaffold,
// CupertinoTabView, and BottomNavigationBarItem. Because the demo is hosted
// inside a CupertinoPageScaffold + ListView (so the user can scroll), the
// CupertinoTabBar instances are placed inside fixed-size containers and the
// CupertinoTabScaffold is approximated by a "scaffold surrogate" Stack so the
// scrolling shell remains intact.
//
// Constraints: static `dynamic build(BuildContext context)`, no setState,
// no animations, no controllers with state, no `.value` on Tween.animate,
// no for-in over BridgedInstance, all `onTap: (i) {}` callbacks empty,
// must pass `dart analyze` with zero issues.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Icons;

dynamic build(BuildContext context) {
  return CupertinoApp(
    title: 'CupertinoTabBar Demo',
    debugShowCheckedModeBanner: false,
    theme: const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: CupertinoColors.systemBlue,
    ),
    home: CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Cupertino Tabs'),
        backgroundColor: Color(0xF8F8F8FA),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildIntroCard(),
            _buildBasicTabBarSection(),
            _buildIconAndLabelVariants(),
            _buildColorCustomizationSection(),
            _buildTabBarItemVariants(),
            _buildAnatomyDiagram(),
            _buildScaffoldSurrogateSection(),
            _buildVsMaterialSection(),
            _buildUsageGuide(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// Shared helpers
// ============================================================================

Widget _heroChip(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: CupertinoColors.white.withOpacity(0.22),
      borderRadius: BorderRadius.circular(999),
      border: Border.all(
        color: CupertinoColors.white.withOpacity(0.45),
        width: 0.5,
      ),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: CupertinoColors.white,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
    ),
  );
}

Widget _sectionTitle(String title, String subtitle, IconData icon, Color tint) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [tint.withOpacity(0.85), tint.withOpacity(0.55)],
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: tint.withOpacity(0.35),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: CupertinoColors.white, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1C1C1E),
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6E6E73),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _explanatory(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 12, bottom: 4),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 13.5,
        height: 1.45,
        color: Color(0xFF3A3A3C),
      ),
    ),
  );
}

Widget _captionLabel(String label, Color color) {
  return Padding(
    padding: const EdgeInsets.only(top: 8, bottom: 6),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.45),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1C1C1E),
            letterSpacing: 0.2,
          ),
        ),
      ],
    ),
  );
}

Widget _cardShell({required Widget child, EdgeInsets? padding}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    padding: padding ?? const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: CupertinoColors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFFE5E5EA)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: child,
  );
}

// ============================================================================
// Section: Intro Card
// ============================================================================

Widget _buildIntroCard() {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF0A84FF),
          Color(0xFF5E5CE6),
        ],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Color(0x330A84FF),
          blurRadius: 18,
          offset: Offset(0, 10),
        ),
      ],
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: CupertinoColors.white.withOpacity(0.22),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: CupertinoColors.white.withOpacity(0.35),
                  width: 0.6,
                ),
              ),
              alignment: Alignment.center,
              child: const Icon(
                CupertinoIcons.square_grid_2x2,
                color: CupertinoColors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CupertinoTabBar',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.4,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'iOS-style bottom tab navigation',
                    style: TextStyle(
                      color: Color(0xCCFFFFFF),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'CupertinoTabBar renders an iOS-style row of icon+label items at '
          'the bottom of the screen. CupertinoTabScaffold pairs it with a '
          'CupertinoTabView per tab so each tab keeps its own navigator '
          'stack. This demo shows a wide range of styling options, anatomy, '
          'and a side-by-side comparison with Material BottomNavigationBar.',
          style: TextStyle(
            color: CupertinoColors.white,
            fontSize: 14,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _heroChip('CupertinoTabBar'),
            _heroChip('CupertinoTabScaffold'),
            _heroChip('CupertinoTabView'),
            _heroChip('BottomNavigationBarItem'),
            _heroChip('currentIndex'),
            _heroChip('activeColor'),
            _heroChip('inactiveColor'),
            _heroChip('iconSize'),
            _heroChip('height'),
            _heroChip('border'),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// Section: Basic Tab Bar
// ============================================================================

Widget _buildBasicTabBarSection() {
  return _cardShell(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Basic CupertinoTabBar',
          'Standard 4-tab and 5-tab layouts',
          CupertinoIcons.square_grid_2x2,
          const Color(0xFF0A84FF),
        ),
        _explanatory(
          'A CupertinoTabBar in its default form shows an icon and label per '
          'tab. The bar has a translucent background and a hairline top '
          'border. The currently selected tab is tinted with activeColor '
          '(default systemBlue), and inactive tabs use inactiveColor.',
        ),
        const SizedBox(height: 12),
        _captionLabel('4-tab default (currentIndex: 0)', const Color(0xFF0A84FF)),
        _tabBarHost(
          child: CupertinoTabBar(
            currentIndex: 0,
            onTap: (i) {},
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.house),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.bell),
                label: 'Alerts',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
        _captionLabel('4-tab default (currentIndex: 2)', const Color(0xFF0A84FF)),
        _tabBarHost(
          child: CupertinoTabBar(
            currentIndex: 2,
            onTap: (i) {},
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.house),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.bell),
                label: 'Alerts',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
        _captionLabel('5-tab default (currentIndex: 4)', const Color(0xFF34C759)),
        _tabBarHost(
          child: CupertinoTabBar(
            currentIndex: 4,
            onTap: (i) {},
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.house),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.compass),
                label: 'Discover',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.add_circled),
                label: 'Create',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.chat_bubble_2),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Section: Icon and Label Variants
// ============================================================================

Widget _buildIconAndLabelVariants() {
  return _cardShell(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Icon & Label Variants',
          'Filled, outlined, label-less, icon-less',
          CupertinoIcons.tag,
          const Color(0xFFFF9500),
        ),
        _explanatory(
          'Each BottomNavigationBarItem accepts an icon, an optional '
          'activeIcon (rendered when the item is selected), an optional '
          'label, and a tooltip. CupertinoTabBar respects the icon/label '
          'pair the same way Material BottomNavigationBar does.',
        ),
        const SizedBox(height: 12),
        _captionLabel('Outlined when inactive, filled when active', const Color(0xFFFF9500)),
        _tabBarHost(
          child: CupertinoTabBar(
            currentIndex: 1,
            onTap: (i) {},
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.house),
                activeIcon: Icon(CupertinoIcons.house_fill),
                label: 'Home',
                tooltip: 'Open home tab',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.heart),
                activeIcon: Icon(CupertinoIcons.heart_fill),
                label: 'Favorites',
                tooltip: 'Open favorites tab',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.bookmark),
                activeIcon: Icon(CupertinoIcons.bookmark_fill),
                label: 'Saved',
                tooltip: 'Open saved tab',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person),
                activeIcon: Icon(CupertinoIcons.person_fill),
                label: 'Account',
                tooltip: 'Open account tab',
              ),
            ],
          ),
        ),
        _captionLabel('Icons only (label hidden via empty string)', const Color(0xFFAF52DE)),
        _tabBarHost(
          child: CupertinoTabBar(
            currentIndex: 2,
            onTap: (i) {},
            iconSize: 28,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.play_arrow),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.pause),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.stop),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.forward),
                label: '',
              ),
            ],
          ),
        ),
        _captionLabel('Mixed: text-style label with custom icon widget', const Color(0xFF5E5CE6)),
        _tabBarHost(
          child: CupertinoTabBar(
            currentIndex: 0,
            onTap: (i) {},
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.bag),
                activeIcon: Icon(CupertinoIcons.bag_fill),
                label: 'Shop',
              ),
              BottomNavigationBarItem(
                icon: _badgeIcon(CupertinoIcons.bell, 3),
                activeIcon: _badgeIcon(CupertinoIcons.bell_fill, 3),
                label: 'Inbox',
              ),
              BottomNavigationBarItem(
                icon: _badgeIcon(CupertinoIcons.cart, 12),
                activeIcon: _badgeIcon(CupertinoIcons.cart_fill, 12),
                label: 'Cart',
              ),
              const BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person_circle),
                activeIcon: Icon(CupertinoIcons.person_circle_fill),
                label: 'Me',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _badgeIcon(IconData icon, int count) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Icon(icon),
      Positioned(
        right: -6,
        top: -4,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
          decoration: BoxDecoration(
            color: CupertinoColors.systemRed,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: CupertinoColors.white, width: 1),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33FF3B30),
                blurRadius: 4,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Text(
            count > 99 ? '99+' : '$count',
            style: const TextStyle(
              color: CupertinoColors.white,
              fontSize: 9,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    ],
  );
}

// ============================================================================
// Section: Color Customization
// ============================================================================

Widget _buildColorCustomizationSection() {
  return _cardShell(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Color Customization',
          'activeColor, inactiveColor, backgroundColor',
          CupertinoIcons.paintbrush,
          const Color(0xFFFF2D55),
        ),
        _explanatory(
          'CupertinoTabBar exposes activeColor, inactiveColor, and '
          'backgroundColor properties. The defaults are systemBlue / '
          'inactiveGray / a translucent system background. Override these '
          'to match a brand palette or to provide a custom dark variant.',
        ),
        const SizedBox(height: 12),
        _captionLabel('Brand palette: pink active, gray inactive', const Color(0xFFFF2D55)),
        _tabBarHost(
          child: CupertinoTabBar(
            currentIndex: 1,
            onTap: (i) {},
            activeColor: const Color(0xFFFF2D55),
            inactiveColor: const Color(0xFF8E8E93),
            backgroundColor: const Color(0xFFFFF1F4),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.flame),
                label: 'Trending',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.heart),
                label: 'Loved',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.star),
                label: 'Top',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person_2),
                label: 'Friends',
              ),
            ],
          ),
        ),
        _captionLabel('Mint active, soft mint background', const Color(0xFF00C7BE)),
        _tabBarHost(
          child: CupertinoTabBar(
            currentIndex: 2,
            onTap: (i) {},
            activeColor: const Color(0xFF00C7BE),
            inactiveColor: const Color(0xFF6E6E73),
            backgroundColor: const Color(0xFFE8FBF8),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.tree),
                label: 'Plants',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.cloud),
                label: 'Weather',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.sun_max),
                label: 'Daylight',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.moon_stars),
                label: 'Night',
              ),
            ],
          ),
        ),
        _captionLabel('Dark variant (currentIndex: 3)', const Color(0xFF1C1C1E)),
        _tabBarHost(
          background: const Color(0xFF1C1C1E),
          child: CupertinoTabBar(
            currentIndex: 3,
            onTap: (i) {},
            activeColor: const Color(0xFFFFD60A),
            inactiveColor: const Color(0xFF6E6E73),
            backgroundColor: const Color(0xFF1C1C1E),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.house),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.music_note),
                label: 'Library',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.headphones),
                label: 'Listen',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.profile_circled),
                label: 'You',
              ),
            ],
          ),
        ),
        _captionLabel('Custom border + custom height + iconSize', const Color(0xFF5856D6)),
        _tabBarHost(
          height: 64,
          child: CupertinoTabBar(
            currentIndex: 0,
            onTap: (i) {},
            activeColor: const Color(0xFF5856D6),
            inactiveColor: const Color(0xFFAEAEB2),
            backgroundColor: const Color(0xFFF6F4FF),
            iconSize: 26,
            height: 64,
            border: const Border(
              top: BorderSide(color: Color(0xFF5856D6), width: 1.5),
            ),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.collections),
                label: 'Collections',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.photo),
                label: 'Photos',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.video_camera),
                label: 'Video',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.music_albums),
                label: 'Albums',
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _colorPropertyTable(),
      ],
    ),
  );
}

Widget _colorPropertyTable() {
  return Container(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFF8F8FA), Color(0xFFEFEFF4)],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFE5E5EA)),
    ),
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          'Color properties at a glance',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
          ),
        ),
        SizedBox(height: 8),
        _ColorPropRow(
          name: 'activeColor',
          desc: 'Tint for the selected item icon and label.',
          fallback: 'CupertinoTheme.primaryColor',
        ),
        _ColorPropRow(
          name: 'inactiveColor',
          desc: 'Color for non-selected items.',
          fallback: 'CupertinoColors.inactiveGray',
        ),
        _ColorPropRow(
          name: 'backgroundColor',
          desc: 'Background of the tab bar; supports translucency.',
          fallback: 'CupertinoTheme.barBackgroundColor',
        ),
        _ColorPropRow(
          name: 'border',
          desc: 'Optional Border above the bar (default hairline top).',
          fallback: 'Border(top: BorderSide(color: tabBarBorderColor))',
        ),
      ],
    ),
  );
}

class _ColorPropRow extends StatelessWidget {
  const _ColorPropRow({
    required this.name,
    required this.desc,
    required this.fallback,
  });

  final String name;
  final String desc;
  final String fallback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 96,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C1E),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              name,
              style: const TextStyle(
                color: Color(0xFFA8E1FF),
                fontSize: 11,
                fontFamily: 'Menlo',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF1C1C1E),
                    height: 1.35,
                  ),
                ),
                Text(
                  'fallback: $fallback',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF6E6E73),
                    fontStyle: FontStyle.italic,
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

// ============================================================================
// Section: Tab Bar Item Variants
// ============================================================================

Widget _buildTabBarItemVariants() {
  return _cardShell(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'BottomNavigationBarItem Variants',
          '5 themed bars × varied icon/label combos',
          CupertinoIcons.layers_alt,
          const Color(0xFF34C759),
        ),
        _explanatory(
          'Below are five fully themed CupertinoTabBar configurations that '
          'demonstrate domain-specific palettes. Each bar exercises a '
          'different combination of activeIcon, label, tooltip, and '
          'currentIndex. The same BottomNavigationBarItem class works for '
          'both Cupertino and Material bottom nav bars.',
        ),
        const SizedBox(height: 12),
        _captionLabel('Music app theme', const Color(0xFFFF2D55)),
        _tabBarHost(
          child: CupertinoTabBar(
            currentIndex: 1,
            onTap: (i) {},
            activeColor: const Color(0xFFFF2D55),
            inactiveColor: const Color(0xFF8E8E93),
            backgroundColor: const Color(0xFFFFF8F9),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.music_note_2),
                activeIcon: Icon(CupertinoIcons.music_note_list),
                label: 'Listen',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.music_albums),
                activeIcon: Icon(CupertinoIcons.music_albums_fill),
                label: 'Browse',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.waveform),
                label: 'Radio',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.collections),
                label: 'Library',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.search),
                label: 'Search',
              ),
            ],
          ),
        ),
        _captionLabel('Travel / map app theme', const Color(0xFF30B0C7)),
        _tabBarHost(
          child: CupertinoTabBar(
            currentIndex: 0,
            onTap: (i) {},
            activeColor: const Color(0xFF30B0C7),
            inactiveColor: const Color(0xFF8E8E93),
            backgroundColor: const Color(0xFFEFFBFC),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.map),
                activeIcon: Icon(CupertinoIcons.map_fill),
                label: 'Map',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.location),
                activeIcon: Icon(CupertinoIcons.location_solid),
                label: 'Nearby',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.compass),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.bookmark),
                activeIcon: Icon(CupertinoIcons.bookmark_fill),
                label: 'Saved',
              ),
            ],
          ),
        ),
        _captionLabel('Finance / banking theme', const Color(0xFF34C759)),
        _tabBarHost(
          child: CupertinoTabBar(
            currentIndex: 3,
            onTap: (i) {},
            activeColor: const Color(0xFF34C759),
            inactiveColor: const Color(0xFF6E6E73),
            backgroundColor: const Color(0xFFF1FAEF),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.creditcard),
                activeIcon: Icon(CupertinoIcons.creditcard_fill),
                label: 'Cards',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.money_dollar_circle),
                label: 'Pay',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.chart_bar),
                label: 'Invest',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.bell),
                activeIcon: Icon(CupertinoIcons.bell_fill),
                label: 'Alerts',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.gear),
                label: 'Settings',
              ),
            ],
          ),
        ),
        _captionLabel('Social / messaging theme', const Color(0xFF5E5CE6)),
        _tabBarHost(
          child: CupertinoTabBar(
            currentIndex: 2,
            onTap: (i) {},
            activeColor: const Color(0xFF5E5CE6),
            inactiveColor: const Color(0xFF8E8E93),
            backgroundColor: const Color(0xFFF6F4FF),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.chat_bubble_2),
                activeIcon: Icon(CupertinoIcons.chat_bubble_2_fill),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.phone),
                activeIcon: Icon(CupertinoIcons.phone_fill),
                label: 'Calls',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person_2),
                activeIcon: Icon(CupertinoIcons.person_2_fill),
                label: 'Contacts',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.envelope),
                activeIcon: Icon(CupertinoIcons.envelope_fill),
                label: 'Mail',
              ),
            ],
          ),
        ),
        _captionLabel('News / reading theme', const Color(0xFFFF9500)),
        _tabBarHost(
          child: CupertinoTabBar(
            currentIndex: 0,
            onTap: (i) {},
            activeColor: const Color(0xFFFF9500),
            inactiveColor: const Color(0xFF8E8E93),
            backgroundColor: const Color(0xFFFFF8EE),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.news),
                activeIcon: Icon(CupertinoIcons.news_solid),
                label: 'Today',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.book),
                activeIcon: Icon(CupertinoIcons.book_fill),
                label: 'Stories',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.bookmark),
                label: 'Saved',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.gear),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Section: Anatomy Diagram
// ============================================================================

Widget _buildAnatomyDiagram() {
  return _cardShell(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'CupertinoTabBar Anatomy',
          'Icon area • Label area • Indicator • Border',
          CupertinoIcons.rectangle_grid_2x2,
          const Color(0xFFAF52DE),
        ),
        _explanatory(
          'Each CupertinoTabBar item is laid out as an icon stacked on top '
          'of a label. The bar paints a hairline top border by default and '
          'lets you supply a custom Border. Although CupertinoTabBar does '
          'not paint an indicator pill the way some Material variants do, '
          'the active tab is communicated through activeColor on both the '
          'icon and the label.',
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFFFFF), Color(0xFFF2F2F7)],
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE5E5EA)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Border line annotation
              _annotatedRow(
                color: const Color(0xFFAF52DE),
                title: 'Top hairline border',
                desc: 'Optional Border with default 0.5px top side.',
              ),
              const SizedBox(height: 8),
              _anatomyMockTabBar(),
              const SizedBox(height: 8),
              _annotatedRow(
                color: const Color(0xFF0A84FF),
                title: 'Icon area',
                desc: 'Holds icon (or activeIcon when selected).',
              ),
              _annotatedRow(
                color: const Color(0xFF34C759),
                title: 'Label area',
                desc: 'Optional text rendered under the icon.',
              ),
              _annotatedRow(
                color: const Color(0xFFFF9500),
                title: 'Active tint',
                desc: 'activeColor applied to icon + label of currentIndex.',
              ),
              _annotatedRow(
                color: const Color(0xFF8E8E93),
                title: 'Inactive tint',
                desc: 'inactiveColor applied to all other tabs.',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyMockTabBar() {
  return Container(
    height: 86,
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      border: const Border(
        top: BorderSide(color: Color(0xFFAF52DE), width: 1.2),
      ),
      borderRadius: BorderRadius.circular(8),
      boxShadow: const [
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: <Widget>[
        Expanded(child: _anatomyTab('Home', CupertinoIcons.house, true)),
        Expanded(child: _anatomyTab('Search', CupertinoIcons.search, false)),
        Expanded(child: _anatomyTab('Alerts', CupertinoIcons.bell, false)),
        Expanded(child: _anatomyTab('Profile', CupertinoIcons.person, false)),
      ],
    ),
  );
}

Widget _anatomyTab(String label, IconData icon, bool active) {
  final color = active ? const Color(0xFFFF9500) : const Color(0xFF8E8E93);
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF0A84FF).withOpacity(0.4)),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.all(2),
        child: Icon(icon, color: color, size: 24),
      ),
      const SizedBox(height: 4),
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF34C759).withOpacity(0.4)),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}

Widget _annotatedRow({
  required Color color,
  required String title,
  required String desc,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 14,
          height: 14,
          margin: const EdgeInsets.only(top: 2),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1C1C1E),
                ),
              ),
              Text(
                desc,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF6E6E73),
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Section: Scaffold Surrogate (CupertinoTabScaffold + CupertinoTabView)
// ============================================================================

Widget _buildScaffoldSurrogateSection() {
  return _cardShell(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'CupertinoTabScaffold Surrogate',
          'Body + persistent tab bar layout',
          CupertinoIcons.rectangle_3_offgrid,
          const Color(0xFF0A84FF),
        ),
        _explanatory(
          'CupertinoTabScaffold pairs a CupertinoTabBar with a tabBuilder '
          'that returns one CupertinoTabView per tab. Each CupertinoTabView '
          'owns its own Navigator so deep-linked navigation inside one tab '
          'does not affect the others. Below we mock that layout with a '
          'Stack so the tab bar visually persists below a fake tab body.',
        ),
        const SizedBox(height: 12),
        _captionLabel('Tab 0 selected — "Home" CupertinoTabView body', const Color(0xFF0A84FF)),
        _scaffoldSurrogate(
          activeIndex: 0,
          activeColor: const Color(0xFF0A84FF),
          inactiveColor: const Color(0xFF8E8E93),
          background: const Color(0xFFF2F2F7),
          body: _surrogateHomeBody(),
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
              icon: Icon(CupertinoIcons.bell),
              label: 'Alerts',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person),
              label: 'You',
            ),
          ],
        ),
        _captionLabel('Tab 2 selected — "Alerts" CupertinoTabView body', const Color(0xFFFF3B30)),
        _scaffoldSurrogate(
          activeIndex: 2,
          activeColor: const Color(0xFFFF3B30),
          inactiveColor: const Color(0xFF8E8E93),
          background: const Color(0xFFFFF1F0),
          body: _surrogateAlertsBody(),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.house),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.bell),
              activeIcon: Icon(CupertinoIcons.bell_fill),
              label: 'Alerts',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person),
              label: 'You',
            ),
          ],
        ),
        _captionLabel('CupertinoTabView API surface', const Color(0xFF5856D6)),
        _tabViewApiPanel(),
      ],
    ),
  );
}

Widget _surrogateHomeBody() {
  return Padding(
    padding: const EdgeInsets.all(14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0A84FF), Color(0xFF5E5CE6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0x330A84FF),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: const Row(
            children: <Widget>[
              Icon(CupertinoIcons.sparkles,
                  color: CupertinoColors.white, size: 22),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Welcome back — your day at a glance',
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _surrogateListRow(CupertinoIcons.calendar, 'Today, May 3', '4 events scheduled'),
        _surrogateListRow(CupertinoIcons.cloud_sun, 'Weather', 'Sunny • 22°C'),
        _surrogateListRow(CupertinoIcons.chart_bar_alt_fill, 'Steps', '6,432 of 10,000'),
      ],
    ),
  );
}

Widget _surrogateAlertsBody() {
  return Padding(
    padding: const EdgeInsets.all(14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF3B30), Color(0xFFFF9500)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33FF3B30),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: const Row(
            children: <Widget>[
              Icon(CupertinoIcons.bell_fill,
                  color: CupertinoColors.white, size: 22),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  '3 new alerts since you last checked',
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _surrogateListRow(CupertinoIcons.exclamationmark_triangle,
            'Server warning', 'CPU at 87% on web-3'),
        _surrogateListRow(CupertinoIcons.envelope_badge,
            'New mention', '@team-builds replied to your thread'),
        _surrogateListRow(CupertinoIcons.calendar_badge_plus,
            'Meeting', 'Sprint planning at 14:00'),
      ],
    ),
  );
}

Widget _surrogateListRow(IconData icon, String title, String subtitle) {
  return Container(
    margin: const EdgeInsets.only(top: 6),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: CupertinoColors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFFE5E5EA)),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFFEFEFF4),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 18, color: const Color(0xFF1C1C1E)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1C1C1E),
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF6E6E73),
                ),
              ),
            ],
          ),
        ),
        const Icon(CupertinoIcons.chevron_right,
            size: 14, color: Color(0xFFC7C7CC)),
      ],
    ),
  );
}

Widget _scaffoldSurrogate({
  required int activeIndex,
  required Color activeColor,
  required Color inactiveColor,
  required Color background,
  required Widget body,
  required List<BottomNavigationBarItem> items,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    height: 280,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFD1D1D6)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x18000000),
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    clipBehavior: Clip.hardEdge,
    child: Column(
      children: <Widget>[
        Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(
            color: Color(0xF8F8F8FA),
            border: Border(
              bottom: BorderSide(color: Color(0xFFD1D1D6), width: 0.5),
            ),
          ),
          alignment: Alignment.center,
          child: const Text(
            'CupertinoNavigationBar (per CupertinoTabView)',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1C1C1E),
            ),
          ),
        ),
        Expanded(child: body),
        CupertinoTabBar(
          currentIndex: activeIndex,
          onTap: (i) {},
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          backgroundColor: const Color(0xF8F8F8FA),
          items: items,
        ),
      ],
    ),
  );
}

Widget _tabViewApiPanel() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFF6F4FF), Color(0xFFEFE9FF)],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFD8D2F3)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x205E5CE6),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          'CupertinoTabView properties',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
          ),
        ),
        SizedBox(height: 6),
        _ApiPropRow(
          name: 'builder',
          desc: 'WidgetBuilder that returns the root widget for this tab.',
        ),
        _ApiPropRow(
          name: 'defaultTitle',
          desc: 'String shown in the navigation bar when no title is set.',
        ),
        _ApiPropRow(
          name: 'navigatorKey',
          desc: 'Optional GlobalKey<NavigatorState> for programmatic nav.',
        ),
        _ApiPropRow(
          name: 'navigatorObservers',
          desc: 'List<NavigatorObserver> attached to this tab\'s navigator.',
        ),
        _ApiPropRow(
          name: 'onGenerateRoute',
          desc: 'RouteFactory called for unknown route names within the tab.',
        ),
        _ApiPropRow(
          name: 'onUnknownRoute',
          desc: 'Fallback RouteFactory for routes onGenerateRoute returns null.',
        ),
        _ApiPropRow(
          name: 'restorationScopeId',
          desc: 'Restoration id used for the tab\'s navigator state.',
        ),
      ],
    ),
  );
}

class _ApiPropRow extends StatelessWidget {
  const _ApiPropRow({required this.name, required this.desc});

  final String name;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 130,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C1E),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              name,
              style: const TextStyle(
                color: Color(0xFFA8E1FF),
                fontSize: 11,
                fontFamily: 'Menlo',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              desc,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF1C1C1E),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Section: Cupertino vs Material comparison
// ============================================================================

Widget _buildVsMaterialSection() {
  return _cardShell(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Cupertino vs Material',
          'CupertinoTabBar / Scaffold side-by-side with Material',
          CupertinoIcons.rectangle_split_3x1,
          const Color(0xFFFF9500),
        ),
        _explanatory(
          'Both ecosystems offer a tab-bar idiom but with different visual '
          'language. CupertinoTabBar uses a translucent, hairline-bordered '
          'bar with text labels under monochrome icons; Material '
          'BottomNavigationBar offers an indicator pill and Material 3 '
          'ripple. Below we mock both side-by-side using static widgets so '
          'the contrast is obvious.',
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _cupertinoMockColumn()),
            const SizedBox(width: 10),
            Expanded(child: _materialMockColumn()),
          ],
        ),
        const SizedBox(height: 12),
        _vsTable(),
      ],
    ),
  );
}

Widget _cupertinoMockColumn() {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xFFF2F2F7),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFD1D1D6)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Cupertino',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0A84FF),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 120,
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFD1D1D6)),
          ),
          alignment: Alignment.center,
          child: const Icon(
            CupertinoIcons.house_fill,
            size: 36,
            color: Color(0xFF0A84FF),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 60,
          child: CupertinoTabBar(
            currentIndex: 0,
            onTap: (i) {},
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
                icon: Icon(CupertinoIcons.bell),
                label: 'Alerts',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person),
                label: 'You',
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Translucent bar, hairline border, monochrome active tint.',
          style: TextStyle(fontSize: 10.5, color: Color(0xFF6E6E73), height: 1.3),
        ),
      ],
    ),
  );
}

Widget _materialMockColumn() {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xFFF6F2FB),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFE0D6F2)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x205E5CE6),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Material',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(0xFF6750A4),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 120,
          decoration: BoxDecoration(
            color: const Color(0xFFFEFBFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE0D6F2)),
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.home,
            size: 36,
            color: Color(0xFF6750A4),
          ),
        ),
        const SizedBox(height: 8),
        _materialBottomBarMock(),
        const SizedBox(height: 6),
        const Text(
          'Indicator pill behind active icon, Material 3 ripple, no top border.',
          style: TextStyle(fontSize: 10.5, color: Color(0xFF6E6E73), height: 1.3),
        ),
      ],
    ),
  );
}

Widget _materialBottomBarMock() {
  return Container(
    height: 60,
    decoration: const BoxDecoration(
      color: Color(0xFFFEFBFF),
      border: Border(
        top: BorderSide(color: Color(0xFFE0D6F2), width: 0.5),
      ),
    ),
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: <Widget>[
        Expanded(child: _materialMockTab(Icons.home, 'Home', true)),
        Expanded(child: _materialMockTab(Icons.search, 'Search', false)),
        Expanded(child: _materialMockTab(Icons.notifications, 'Alerts', false)),
        Expanded(child: _materialMockTab(Icons.person, 'You', false)),
      ],
    ),
  );
}

Widget _materialMockTab(IconData icon, String label, bool active) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        width: 40,
        height: 22,
        decoration: BoxDecoration(
          color: active ? const Color(0xFFE8DEF8) : null,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: 16,
          color: active ? const Color(0xFF6750A4) : const Color(0xFF49454F),
        ),
      ),
      const SizedBox(height: 2),
      Text(
        label,
        style: TextStyle(
          fontSize: 9.5,
          fontWeight: active ? FontWeight.w700 : FontWeight.w500,
          color: active ? const Color(0xFF1D1B20) : const Color(0xFF49454F),
        ),
      ),
    ],
  );
}

Widget _vsTable() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFFFFFF), Color(0xFFFFF8EE)],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFE5E5EA)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          'Property mapping',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1C1C1E),
          ),
        ),
        SizedBox(height: 8),
        _VsRow(
          property: 'Container widget',
          cupertino: 'CupertinoTabScaffold',
          material: 'Scaffold',
        ),
        _VsRow(
          property: 'Bottom widget',
          cupertino: 'CupertinoTabBar',
          material: 'BottomNavigationBar',
        ),
        _VsRow(
          property: 'Tab pages',
          cupertino: 'CupertinoTabView (1 navigator each)',
          material: 'IndexedStack with body widgets',
        ),
        _VsRow(
          property: 'Active tint',
          cupertino: 'activeColor',
          material: 'selectedItemColor',
        ),
        _VsRow(
          property: 'Inactive tint',
          cupertino: 'inactiveColor',
          material: 'unselectedItemColor',
        ),
        _VsRow(
          property: 'Item type',
          cupertino: 'BottomNavigationBarItem',
          material: 'BottomNavigationBarItem',
        ),
        _VsRow(
          property: 'Shape',
          cupertino: 'flat hairline-bordered bar',
          material: 'flat or with indicator pill (M3)',
        ),
        _VsRow(
          property: 'Selection feedback',
          cupertino: 'tint change only',
          material: 'tint + ripple + indicator',
        ),
      ],
    ),
  );
}

class _VsRow extends StatelessWidget {
  const _VsRow({
    required this.property,
    required this.cupertino,
    required this.material,
  });

  final String property;
  final String cupertino;
  final String material;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 110,
            child: Text(
              property,
              style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1C1C1E),
              ),
            ),
          ),
          Expanded(
            child: Text(
              cupertino,
              style: const TextStyle(
                fontSize: 11.5,
                color: Color(0xFF0A84FF),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              material,
              style: const TextStyle(
                fontSize: 11.5,
                color: Color(0xFF6750A4),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Section: Usage Guide
// ============================================================================

Widget _buildUsageGuide() {
  return _cardShell(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Usage Guide',
          'When and how to reach for Cupertino tabs',
          CupertinoIcons.book,
          const Color(0xFF34C759),
        ),
        _explanatory(
          'Use CupertinoTabScaffold + CupertinoTabBar for iOS-style apps '
          'where each top-level destination should keep its own navigator '
          'stack. Use a CupertinoTabController if you need to programmatic-'
          'ally drive the active tab; otherwise the scaffold owns it for '
          'you. Pair it with CupertinoPageScaffold inside each '
          'CupertinoTabView when you also need a per-tab navigation bar.',
        ),
        const SizedBox(height: 12),
        _doDontGrid(),
        const SizedBox(height: 12),
        _codeRecipeCard(),
      ],
    ),
  );
}

Widget _doDontGrid() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(child: _doColumn()),
      const SizedBox(width: 10),
      Expanded(child: _dontColumn()),
    ],
  );
}

Widget _doColumn() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFE7F8EC), Color(0xFFCFF1D8)],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFF34C759).withOpacity(0.4)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x2034C759),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Row(
          children: <Widget>[
            Icon(CupertinoIcons.check_mark_circled_solid,
                color: Color(0xFF34C759), size: 18),
            SizedBox(width: 6),
            Text(
              'Do',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1C1C1E),
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        _GuideBullet(text: 'Use 3–5 top-level destinations.'),
        _GuideBullet(text: 'Keep labels short and noun-based.'),
        _GuideBullet(text: 'Provide an activeIcon for stronger feedback.'),
        _GuideBullet(text: 'Match activeColor to your brand or theme primary.'),
        _GuideBullet(text: 'Keep one CupertinoTabView per tab.'),
      ],
    ),
  );
}

Widget _dontColumn() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFFEEEC), Color(0xFFFFD6D2)],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFFF3B30).withOpacity(0.4)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x20FF3B30),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Row(
          children: <Widget>[
            Icon(CupertinoIcons.xmark_circle_fill,
                color: Color(0xFFFF3B30), size: 18),
            SizedBox(width: 6),
            Text(
              'Don\'t',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1C1C1E),
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        _GuideBullet(text: 'Cram more than five tabs into the bar.'),
        _GuideBullet(text: 'Use long, multi-word labels that wrap.'),
        _GuideBullet(text: 'Hide labels entirely without strong icons.'),
        _GuideBullet(text: 'Drop critical actions (save, send) into a tab.'),
        _GuideBullet(text: 'Re-create state on every tab switch.'),
      ],
    ),
  );
}

class _GuideBullet extends StatelessWidget {
  const _GuideBullet({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 5, right: 6),
            child: Icon(CupertinoIcons.circle_fill,
                size: 5, color: Color(0xFF1C1C1E)),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF1C1C1E),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _codeRecipeCard() {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFF1C1C1E),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x331C1C1E),
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Row(
          children: <Widget>[
            Icon(CupertinoIcons.chevron_left_slash_chevron_right,
                color: Color(0xFFA8E1FF), size: 16),
            SizedBox(width: 6),
            Text(
              'Recipe — minimal CupertinoTabScaffold',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFFA8E1FF),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        _CodeLine(text: 'CupertinoTabScaffold('),
        _CodeLine(text: '  tabBar: CupertinoTabBar('),
        _CodeLine(text: '    items: <BottomNavigationBarItem>['),
        _CodeLine(
            text:
                '      BottomNavigationBarItem(icon: Icon(CupertinoIcons.house), label: \'Home\'),'),
        _CodeLine(
            text:
                '      BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: \'Search\'),'),
        _CodeLine(
            text:
                '      BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), label: \'Me\'),'),
        _CodeLine(text: '    ],'),
        _CodeLine(text: '  ),'),
        _CodeLine(text: '  tabBuilder: (context, index) {'),
        _CodeLine(text: '    return CupertinoTabView('),
        _CodeLine(text: '      builder: (ctx) => HomePage(tab: index),'),
        _CodeLine(text: "      defaultTitle: 'Tab \$index',"),
        _CodeLine(text: '    );'),
        _CodeLine(text: '  },'),
        _CodeLine(text: ');'),
      ],
    ),
  );
}

class _CodeLine extends StatelessWidget {
  const _CodeLine({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 11,
        fontFamily: 'Menlo',
        color: Color(0xFFE5E5EA),
        height: 1.45,
      ),
    );
  }
}

// ============================================================================
// Tab bar host helper (keeps the CupertinoTabBar at a fixed visible height)
// ============================================================================

Widget _tabBarHost({required Widget child, double? height, Color? background}) {
  final hostHeight = (height ?? 50) + 8;
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    height: hostHeight + 16,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          (background ?? const Color(0xFFF8F8FA)),
          (background ?? const Color(0xFFEFEFF4)),
        ],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFD1D1D6)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
    alignment: Alignment.bottomCenter,
    child: child,
  );
}
