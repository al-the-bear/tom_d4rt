// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element
// D4rt deep-demo test script: Navigation Badge Gallery
// Comprehensive visual showcase of Material Badge, BadgeThemeData, and
// badge-decorated NavigationBar/NavigationRail destination patterns.
import 'package:flutter/material.dart';

// ============================================================================
// PALETTE HELPERS
// ============================================================================

const Color _ink = Color(0xFF1A1330);
const Color _inkSoft = Color(0xFF453974);
const Color _inkMuted = Color(0xFF6E5FA0);
const Color _paper = Color(0xFFFFF8F1);
const Color _paperWarm = Color(0xFFFCEDD8);
const Color _line = Color(0xFFE5DBCB);

// Section palettes (each section has its own unique hue family)
const Color _s1Primary = Color(0xFFE63946);
const Color _s1Soft = Color(0xFFFFD6DA);
const Color _s2Primary = Color(0xFFF77F00);
const Color _s2Soft = Color(0xFFFFE5C7);
const Color _s3Primary = Color(0xFFFCBF49);
const Color _s3Soft = Color(0xFFFFF1CB);
const Color _s4Primary = Color(0xFF06A77D);
const Color _s4Soft = Color(0xFFC8F3E3);
const Color _s5Primary = Color(0xFF118AB2);
const Color _s5Soft = Color(0xFFCCEAF4);
const Color _s6Primary = Color(0xFF7B2CBF);
const Color _s6Soft = Color(0xFFE6D4F5);
const Color _s7Primary = Color(0xFFE85D75);
const Color _s7Soft = Color(0xFFFCDCE3);
const Color _s8Primary = Color(0xFF2EC4B6);
const Color _s8Soft = Color(0xFFCEF2EE);
const Color _s9Primary = Color(0xFFFF8E72);
const Color _s9Soft = Color(0xFFFFE0D5);
const Color _s10Primary = Color(0xFF8338EC);
const Color _s10Soft = Color(0xFFE0CEF9);
const Color _s11Primary = Color(0xFF3A86FF);
const Color _s11Soft = Color(0xFFCFE0FF);
const Color _s12Primary = Color(0xFFFF006E);
const Color _s12Soft = Color(0xFFFFCFE1);

// ============================================================================
// SECTION HEADER WIDGETS
// ============================================================================

Widget _sectionBanner({
  required int number,
  required String title,
  required String subtitle,
  required Color primary,
  required Color soft,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [primary, soft],
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: primary.withOpacity(0.30),
          blurRadius: 18.0,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 64.0,
          height: 64.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            number.toString().padLeft(2, '0'),
            style: TextStyle(
              color: primary,
              fontSize: 24.0,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
        ),
        SizedBox(width: 18.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.92),
                  fontSize: 13.5,
                  height: 1.35,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _recipeCard({
  required String title,
  required String body,
  required Widget preview,
  required Color accent,
  required Color soft,
}) {
  return Container(
    width: 280.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: soft, width: 1.4),
      boxShadow: [
        BoxShadow(
          color: accent.withOpacity(0.12),
          blurRadius: 10.0,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: soft,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.w800,
              fontSize: 12.5,
              letterSpacing: 0.5,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          height: 96.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: soft.withOpacity(0.40),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: preview,
        ),
        SizedBox(height: 12.0),
        Text(
          body,
          style: TextStyle(
            color: _inkSoft,
            fontSize: 12.5,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _glyphChip({
  required IconData icon,
  required String label,
  required Color accent,
  required Color soft,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: soft,
      borderRadius: BorderRadius.circular(22.0),
      border: Border.all(color: accent.withOpacity(0.40), width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: accent, size: 16.0),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            color: accent,
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

Widget _table({
  required List<String> headers,
  required List<List<String>> rows,
  required Color accent,
  required Color soft,
}) {
  final headerRow = TableRow(
    decoration: BoxDecoration(color: accent),
    children: headers
        .map(
          (h) => Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              h,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 12.5,
              ),
            ),
          ),
        )
        .toList(),
  );

  final bodyRows = <TableRow>[];
  for (int i = 0; i < rows.length; i++) {
    final r = rows[i];
    bodyRows.add(
      TableRow(
        decoration: BoxDecoration(
          color: (i % 2 == 0) ? soft.withOpacity(0.35) : Colors.white,
        ),
        children: r
            .map(
              (c) => Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  c,
                  style: TextStyle(
                    color: _ink,
                    fontSize: 12.5,
                    height: 1.4,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _line, width: 1.0),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Table(
        columnWidths: const {0: FlexColumnWidth(2.0), 1: FlexColumnWidth(3.0)},
        children: [headerRow, ...bodyRows],
      ),
    ),
  );
}

Widget _calloutBox({
  required String title,
  required String body,
  required Color accent,
  required Color soft,
  required IconData icon,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: soft,
      borderRadius: BorderRadius.circular(12.0),
      border: Border(left: BorderSide(color: accent, width: 5.0)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: accent, size: 22.0),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.w800,
                  fontSize: 13.0,
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                body,
                style: TextStyle(
                  color: _ink,
                  fontSize: 12.5,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _previewBadge(Badge badge, {String? caption}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      badge,
      if (caption != null) ...[
        SizedBox(height: 8.0),
        Text(
          caption,
          style: TextStyle(
            color: _inkSoft,
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ],
  );
}

// ============================================================================
// MAIN BUILD ENTRY
// ============================================================================

dynamic build(BuildContext context) {
  // ============================================================================
  // SECTION 1: BADGE BASICS
  // ============================================================================

  final basicDot = Badge(
    child: Icon(Icons.notifications_outlined, size: 30.0, color: _ink),
  );

  final basicLabel = Badge(
    label: Text('3'),
    child: Icon(Icons.mail_outline, size: 30.0, color: _ink),
  );

  final basicColored = Badge(
    label: Text('5'),
    backgroundColor: _s1Primary,
    textColor: Colors.white,
    child: Icon(Icons.message_outlined, size: 30.0, color: _ink),
  );

  final basicLargeText = Badge(
    label: Text('New'),
    backgroundColor: _s4Primary,
    textColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 6.0),
    child: Icon(Icons.local_offer_outlined, size: 30.0, color: _ink),
  );

  // ============================================================================
  // SECTION 2: BADGE.COUNT FACTORY
  // ============================================================================

  final countOne = Badge.count(
    count: 1,
    child: Icon(Icons.email_outlined, size: 30.0, color: _ink),
  );
  final countSeven = Badge.count(
    count: 7,
    child: Icon(Icons.chat_bubble_outline, size: 30.0, color: _ink),
  );
  final countNinety = Badge.count(
    count: 90,
    child: Icon(Icons.inbox_outlined, size: 30.0, color: _ink),
  );
  final countOverflow = Badge.count(
    count: 1234,
    child: Icon(Icons.markunread_mailbox_outlined, size: 30.0, color: _ink),
  );

  // ============================================================================
  // SECTION 3: SIZE VARIANTS (smallSize vs largeSize)
  // ============================================================================

  final tinyDot = Badge(
    smallSize: 4.0,
    child: Icon(Icons.circle_notifications, size: 30.0, color: _ink),
  );
  final smallDot = Badge(
    smallSize: 8.0,
    child: Icon(Icons.notifications_active, size: 30.0, color: _ink),
  );
  final mediumDot = Badge(
    smallSize: 12.0,
    child: Icon(Icons.notifications_paused, size: 30.0, color: _ink),
  );
  final largeDot = Badge(
    smallSize: 16.0,
    child: Icon(Icons.notifications, size: 30.0, color: _ink),
  );

  final largeLabel = Badge(
    label: Text('42'),
    largeSize: 22.0,
    textStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w800),
    backgroundColor: _s3Primary,
    textColor: _ink,
    child: Icon(Icons.shopping_cart_outlined, size: 30.0, color: _ink),
  );
  final compactLabel = Badge(
    label: Text('9'),
    largeSize: 14.0,
    textStyle: TextStyle(fontSize: 8.0, fontWeight: FontWeight.w800),
    backgroundColor: _s3Primary,
    textColor: _ink,
    child: Icon(Icons.local_mall_outlined, size: 30.0, color: _ink),
  );

  // ============================================================================
  // SECTION 4: COLOR & STYLE CUSTOMIZATION
  // ============================================================================

  final stylePalette = <Map<String, dynamic>>[
    {'bg': _s1Primary, 'fg': Colors.white, 'label': '1'},
    {'bg': _s2Primary, 'fg': Colors.white, 'label': '2'},
    {'bg': _s4Primary, 'fg': Colors.white, 'label': '3'},
    {'bg': _s5Primary, 'fg': Colors.white, 'label': '4'},
    {'bg': _s6Primary, 'fg': Colors.white, 'label': '5'},
    {'bg': _s10Primary, 'fg': Colors.white, 'label': '6'},
  ];

  final styledBadges = <Widget>[];
  for (final p in stylePalette) {
    styledBadges.add(
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Badge(
          label: Text(p['label'] as String),
          backgroundColor: p['bg'] as Color,
          textColor: p['fg'] as Color,
          textStyle: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.4,
          ),
          padding: EdgeInsets.symmetric(horizontal: 6.0),
          child: Icon(Icons.bookmark, size: 32.0, color: _inkSoft),
        ),
      ),
    );
  }

  // ============================================================================
  // SECTION 5: ALIGNMENT, OFFSET, PADDING
  // ============================================================================

  final alignTopEnd = Badge(
    label: Text('TE'),
    alignment: AlignmentDirectional.topEnd,
    backgroundColor: _s5Primary,
    textColor: Colors.white,
    textStyle: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w800),
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Icon(Icons.image_outlined, size: 44.0, color: _ink),
  );

  final alignTopStart = Badge(
    label: Text('TS'),
    alignment: AlignmentDirectional.topStart,
    backgroundColor: _s5Primary,
    textColor: Colors.white,
    textStyle: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w800),
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Icon(Icons.image_outlined, size: 44.0, color: _ink),
  );

  final alignBottomEnd = Badge(
    label: Text('BE'),
    alignment: AlignmentDirectional.bottomEnd,
    backgroundColor: _s5Primary,
    textColor: Colors.white,
    textStyle: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w800),
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Icon(Icons.image_outlined, size: 44.0, color: _ink),
  );

  final alignBottomStart = Badge(
    label: Text('BS'),
    alignment: AlignmentDirectional.bottomStart,
    backgroundColor: _s5Primary,
    textColor: Colors.white,
    textStyle: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w800),
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Icon(Icons.image_outlined, size: 44.0, color: _ink),
  );

  final offsetNudged = Badge(
    label: Text('!'),
    backgroundColor: _s5Primary,
    textColor: Colors.white,
    offset: Offset(6, -6),
    textStyle: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w800),
    padding: EdgeInsets.symmetric(horizontal: 6.0),
    child: Icon(Icons.account_circle_outlined, size: 44.0, color: _ink),
  );

  final paddedBadge = Badge(
    label: Text('PAD'),
    backgroundColor: _s5Primary,
    textColor: Colors.white,
    textStyle: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w800),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
    child: Icon(Icons.account_circle_outlined, size: 44.0, color: _ink),
  );

  // ============================================================================
  // SECTION 6: VISIBILITY TOGGLE (isLabelVisible)
  // ============================================================================

  final visibleBadge = Badge(
    label: Text('ON'),
    isLabelVisible: true,
    backgroundColor: _s6Primary,
    textColor: Colors.white,
    textStyle: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w800),
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Icon(Icons.toggle_on, size: 36.0, color: _s6Primary),
  );

  final hiddenBadge = Badge(
    label: Text('HIDDEN'),
    isLabelVisible: false,
    backgroundColor: _s6Primary,
    textColor: Colors.white,
    child: Icon(Icons.toggle_off, size: 36.0, color: _inkMuted),
  );

  final hiddenDot = Badge(
    isLabelVisible: false,
    child: Icon(Icons.visibility_off_outlined, size: 30.0, color: _ink),
  );

  // ============================================================================
  // SECTION 7: BADGETHEMEDATA SHOWCASE
  // ============================================================================

  final themeWarm = BadgeThemeData(
    backgroundColor: _s2Primary,
    textColor: Colors.white,
    smallSize: 7.0,
    largeSize: 18.0,
    textStyle: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w800),
    padding: EdgeInsets.symmetric(horizontal: 5.0),
    alignment: AlignmentDirectional.topEnd,
    offset: Offset(0, -2),
  );

  final themeCool = BadgeThemeData(
    backgroundColor: _s5Primary,
    textColor: Colors.white,
    smallSize: 6.0,
    largeSize: 16.0,
    textStyle: TextStyle(
      fontSize: 9.0,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.2,
    ),
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    alignment: AlignmentDirectional.topEnd,
    offset: Offset(0, 0),
  );

  final themeBold = BadgeThemeData(
    backgroundColor: _s12Primary,
    textColor: Colors.white,
    smallSize: 10.0,
    largeSize: 22.0,
    textStyle: TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w900,
      letterSpacing: 0.4,
    ),
    padding: EdgeInsets.symmetric(horizontal: 8.0),
    alignment: AlignmentDirectional.topEnd,
    offset: Offset(2, -2),
  );

  Widget themedSample(BadgeThemeData theme, String tag) {
    return Theme(
      data: ThemeData(badgeTheme: theme),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Badge(
              label: Text('12'),
              child: Icon(Icons.notifications, size: 32.0, color: _ink),
            ),
            SizedBox(height: 6.0),
            Text(
              tag,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
                color: _inkSoft,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================================
  // SECTION 8: NAVIGATIONBAR WITH BADGES
  // ============================================================================

  final navBarBasic = NavigationBar(
    selectedIndex: 0,
    onDestinationSelected: (_) {},
    backgroundColor: _paper,
    indicatorColor: _s7Soft,
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    destinations: [
      NavigationDestination(
        icon: Badge(
          label: Text('2'),
          backgroundColor: _s7Primary,
          textColor: Colors.white,
          child: Icon(Icons.home_outlined),
        ),
        selectedIcon: Badge(
          label: Text('2'),
          backgroundColor: _s7Primary,
          textColor: Colors.white,
          child: Icon(Icons.home),
        ),
        label: 'Home',
      ),
      NavigationDestination(
        icon: Badge(
          child: Icon(Icons.search),
        ),
        label: 'Search',
      ),
      NavigationDestination(
        icon: Badge(
          label: Text('14'),
          backgroundColor: _s1Primary,
          textColor: Colors.white,
          child: Icon(Icons.notifications_outlined),
        ),
        selectedIcon: Badge(
          label: Text('14'),
          backgroundColor: _s1Primary,
          textColor: Colors.white,
          child: Icon(Icons.notifications),
        ),
        label: 'Alerts',
      ),
      NavigationDestination(
        icon: Icon(Icons.person_outline),
        selectedIcon: Icon(Icons.person),
        label: 'Profile',
      ),
    ],
  );

  final navBarHeavy = NavigationBar(
    selectedIndex: 2,
    onDestinationSelected: (_) {},
    backgroundColor: _paperWarm,
    indicatorColor: _s8Soft,
    labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
    destinations: [
      NavigationDestination(
        icon: Badge(
          label: Text('99+'),
          backgroundColor: _s12Primary,
          textColor: Colors.white,
          textStyle: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w800),
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Icon(Icons.mail_outline),
        ),
        label: 'Inbox',
      ),
      NavigationDestination(
        icon: Badge(
          label: Text('NEW'),
          backgroundColor: _s4Primary,
          textColor: Colors.white,
          textStyle: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w800),
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Icon(Icons.local_fire_department_outlined),
        ),
        label: 'Trending',
      ),
      NavigationDestination(
        icon: Badge(
          label: Text('3'),
          backgroundColor: _s5Primary,
          textColor: Colors.white,
          child: Icon(Icons.shopping_bag_outlined),
        ),
        selectedIcon: Badge(
          label: Text('3'),
          backgroundColor: _s5Primary,
          textColor: Colors.white,
          child: Icon(Icons.shopping_bag),
        ),
        label: 'Cart',
      ),
      NavigationDestination(
        icon: Badge(
          smallSize: 10.0,
          backgroundColor: _s9Primary,
          child: Icon(Icons.favorite_outline),
        ),
        label: 'Saved',
      ),
    ],
  );

  // ============================================================================
  // SECTION 9: NAVIGATIONRAIL WITH BADGES
  // ============================================================================

  final navRailCompact = NavigationRail(
    selectedIndex: 0,
    onDestinationSelected: (_) {},
    labelType: NavigationRailLabelType.all,
    backgroundColor: _paper,
    indicatorColor: _s10Soft,
    useIndicator: true,
    destinations: [
      NavigationRailDestination(
        icon: Badge(
          label: Text('4'),
          backgroundColor: _s10Primary,
          textColor: Colors.white,
          child: Icon(Icons.dashboard_outlined),
        ),
        selectedIcon: Badge(
          label: Text('4'),
          backgroundColor: _s10Primary,
          textColor: Colors.white,
          child: Icon(Icons.dashboard),
        ),
        label: Text('Board'),
      ),
      NavigationRailDestination(
        icon: Badge(
          child: Icon(Icons.task_outlined),
        ),
        selectedIcon: Badge(
          child: Icon(Icons.task),
        ),
        label: Text('Tasks'),
      ),
      NavigationRailDestination(
        icon: Badge(
          label: Text('12'),
          backgroundColor: _s11Primary,
          textColor: Colors.white,
          child: Icon(Icons.calendar_today_outlined),
        ),
        label: Text('Calendar'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.settings_outlined),
        selectedIcon: Icon(Icons.settings),
        label: Text('Settings'),
      ),
    ],
  );

  final navRailExtended = NavigationRail(
    selectedIndex: 1,
    onDestinationSelected: (_) {},
    extended: true,
    minExtendedWidth: 200.0,
    backgroundColor: _paperWarm,
    indicatorColor: _s11Soft,
    destinations: [
      NavigationRailDestination(
        icon: Badge(
          label: Text('5'),
          backgroundColor: _s11Primary,
          textColor: Colors.white,
          child: Icon(Icons.email_outlined),
        ),
        selectedIcon: Badge(
          label: Text('5'),
          backgroundColor: _s11Primary,
          textColor: Colors.white,
          child: Icon(Icons.email),
        ),
        label: Text('Mail'),
      ),
      NavigationRailDestination(
        icon: Badge(
          label: Text('99+'),
          backgroundColor: _s1Primary,
          textColor: Colors.white,
          textStyle: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w800),
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Icon(Icons.notifications_outlined),
        ),
        selectedIcon: Badge(
          label: Text('99+'),
          backgroundColor: _s1Primary,
          textColor: Colors.white,
          textStyle: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w800),
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Icon(Icons.notifications),
        ),
        label: Text('Notifications'),
      ),
      NavigationRailDestination(
        icon: Badge(
          smallSize: 10.0,
          backgroundColor: _s4Primary,
          child: Icon(Icons.cloud_outlined),
        ),
        label: Text('Cloud Sync'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.help_outline),
        label: Text('Help'),
      ),
    ],
  );

  // ============================================================================
  // SECTION 10: OVERFLOW & LARGE COUNTS
  // ============================================================================

  final overflowSamples = <Map<String, dynamic>>[
    {'count': 1, 'tag': '1'},
    {'count': 10, 'tag': '10'},
    {'count': 99, 'tag': '99'},
    {'count': 100, 'tag': '100'},
    {'count': 999, 'tag': '999'},
    {'count': 9999, 'tag': '9999'},
  ];

  final overflowBadges = <Widget>[];
  for (final s in overflowSamples) {
    overflowBadges.add(
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Badge.count(
              count: s['count'] as int,
              backgroundColor: _s12Primary,
              textColor: Colors.white,
              child: Icon(Icons.mail, size: 30.0, color: _ink),
            ),
            SizedBox(height: 8.0),
            Text(
              'n=${s['tag']}',
              style: TextStyle(
                color: _inkSoft,
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================================
  // SECTION 11: REAL-WORLD NOTIFICATION COMPOSITIONS
  // ============================================================================

  Widget appBarMock(String title, int alerts, int messages) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: _line),
        boxShadow: [
          BoxShadow(
            color: _ink.withOpacity(0.05),
            blurRadius: 8.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.menu, color: _ink, size: 24.0),
          SizedBox(width: 14.0),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: _ink,
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Badge.count(
            count: alerts,
            backgroundColor: _s1Primary,
            textColor: Colors.white,
            child: Icon(Icons.notifications_outlined, color: _ink, size: 24.0),
          ),
          SizedBox(width: 16.0),
          Badge.count(
            count: messages,
            backgroundColor: _s5Primary,
            textColor: Colors.white,
            child: Icon(Icons.chat_bubble_outline, color: _ink, size: 24.0),
          ),
          SizedBox(width: 12.0),
          CircleAvatar(
            radius: 16.0,
            backgroundColor: _s10Soft,
            child: Icon(Icons.person, color: _s10Primary, size: 18.0),
          ),
        ],
      ),
    );
  }

  Widget contactTile(String name, int unread, IconData icon, Color tint) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: _line)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: tint.withOpacity(0.25),
            child: Icon(icon, color: tint),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: _ink,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.5,
                  ),
                ),
                SizedBox(height: 3.0),
                Text(
                  unread > 0
                      ? '$unread new message${unread == 1 ? '' : 's'}'
                      : 'All caught up',
                  style: TextStyle(
                    color: _inkMuted,
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
          if (unread > 0)
            Badge.count(
              count: unread,
              backgroundColor: tint,
              textColor: Colors.white,
              child: Icon(Icons.message_outlined, color: _inkSoft, size: 22.0),
            )
          else
            Icon(Icons.check_circle_outline, color: _s4Primary, size: 22.0),
        ],
      ),
    );
  }

  final inboxComposition = Container(
    margin: EdgeInsets.symmetric(horizontal: 24.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _line, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: _ink.withOpacity(0.08),
          blurRadius: 14.0,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Column(
        children: [
          Container(
            color: _s7Soft,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                Icon(Icons.inbox, color: _s7Primary, size: 22.0),
                SizedBox(width: 10.0),
                Text(
                  'Inbox',
                  style: TextStyle(
                    color: _s7Primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 16.0,
                  ),
                ),
                Spacer(),
                Badge.count(
                  count: 23,
                  backgroundColor: _s7Primary,
                  textColor: Colors.white,
                  child: Icon(Icons.mark_email_unread_outlined,
                      color: _s7Primary, size: 22.0),
                ),
              ],
            ),
          ),
          contactTile('Anya Sharma', 3, Icons.person, _s5Primary),
          contactTile('Marcus Lee', 12, Icons.person, _s2Primary),
          contactTile('Ines Diaz', 0, Icons.person, _s4Primary),
          contactTile('Otto Renz', 1, Icons.person, _s6Primary),
          contactTile('Wei Chen', 7, Icons.person, _s10Primary),
        ],
      ),
    ),
  );

  // ============================================================================
  // SECTION 12: BADGE + AVATAR & STATUS COMPOSITIONS
  // ============================================================================

  Widget statusAvatar(IconData face, Color tint, Color statusColor,
      {String? count}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
      child: Badge(
        alignment: AlignmentDirectional.bottomEnd,
        backgroundColor: statusColor,
        label: count != null ? Text(count) : null,
        textColor: Colors.white,
        textStyle: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w800),
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        smallSize: 12.0,
        child: CircleAvatar(
          radius: 26.0,
          backgroundColor: tint.withOpacity(0.25),
          child: Icon(face, color: tint, size: 28.0),
        ),
      ),
    );
  }

  final avatarRow = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      statusAvatar(Icons.person, _s5Primary, _s4Primary),
      statusAvatar(Icons.person_2, _s2Primary, _s1Primary, count: '3'),
      statusAvatar(Icons.person_3, _s6Primary, _s3Primary, count: '!'),
      statusAvatar(Icons.person_4, _s10Primary, _inkMuted),
      statusAvatar(Icons.person_outline, _s11Primary, _s12Primary, count: 'NEW'),
    ],
  );

  // ============================================================================
  // HERO
  // ============================================================================

  final hero = Container(
    margin: EdgeInsets.all(24.0),
    padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 32.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_ink, _s10Primary, _s12Primary],
      ),
      borderRadius: BorderRadius.circular(22.0),
      boxShadow: [
        BoxShadow(
          color: _s10Primary.withOpacity(0.35),
          blurRadius: 24.0,
          offset: Offset(0, 10),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Colors.white.withOpacity(0.25)),
              ),
              child: Text(
                'MATERIAL  •  BADGE  •  NAVIGATION',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                  letterSpacing: 1.4,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Spacer(),
            Badge.count(
              count: 12,
              backgroundColor: Colors.white,
              textColor: _ink,
              child: Icon(Icons.notifications_active,
                  color: Colors.white, size: 28.0),
            ),
            SizedBox(width: 16.0),
            Badge.count(
              count: 99,
              backgroundColor: Colors.white,
              textColor: _ink,
              child:
                  Icon(Icons.mark_chat_unread, color: Colors.white, size: 28.0),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Text(
          'Navigation Badge Gallery',
          style: TextStyle(
            color: Colors.white,
            fontSize: 38.0,
            fontWeight: FontWeight.w900,
            height: 1.05,
            letterSpacing: 0.3,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'A Notification Indicator Atelier for Flutter\'s Badge widget,\n'
          'BadgeThemeData, NavigationBar, and NavigationRail destinations.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.92),
            fontSize: 15.0,
            height: 1.5,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 20.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _glyphChip(
              icon: Icons.circle,
              label: 'DOT BADGES',
              accent: _s1Primary,
              soft: _s1Soft,
            ),
            _glyphChip(
              icon: Icons.numbers,
              label: 'COUNT BADGES',
              accent: _s2Primary,
              soft: _s2Soft,
            ),
            _glyphChip(
              icon: Icons.label,
              label: 'TEXT LABELS',
              accent: _s4Primary,
              soft: _s4Soft,
            ),
            _glyphChip(
              icon: Icons.format_paint,
              label: 'THEMING',
              accent: _s5Primary,
              soft: _s5Soft,
            ),
            _glyphChip(
              icon: Icons.view_quilt,
              label: 'NAV BAR',
              accent: _s7Primary,
              soft: _s7Soft,
            ),
            _glyphChip(
              icon: Icons.view_sidebar,
              label: 'NAV RAIL',
              accent: _s10Primary,
              soft: _s10Soft,
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================================
  // OVERVIEW / CONCEPTS
  // ============================================================================

  final overview = Container(
    margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _line, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: _ink.withOpacity(0.05),
          blurRadius: 10.0,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Concept Overview',
          style: TextStyle(
            color: _ink,
            fontSize: 22.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Badge decorates a child widget with a small marker — either a '
          'simple dot or a label such as a number or short string. Badges '
          'are typically used on icons, avatars, and especially navigation '
          'destinations to indicate unread or pending items.',
          style: TextStyle(
            color: _inkSoft,
            fontSize: 13.5,
            height: 1.55,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(
              child: _conceptCell(
                title: 'Badge',
                detail:
                    'Default constructor — controls label, colors, alignment, padding, and sizes.',
                accent: _s1Primary,
                soft: _s1Soft,
                icon: Icons.label_outline,
              ),
            ),
            Expanded(
              child: _conceptCell(
                title: 'Badge.count',
                detail:
                    'Convenience factory that renders n or 999+ for overflow counts.',
                accent: _s2Primary,
                soft: _s2Soft,
                icon: Icons.numbers,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Row(
          children: [
            Expanded(
              child: _conceptCell(
                title: 'BadgeThemeData',
                detail:
                    'Theme-level defaults: colors, sizes, padding, alignment, offset.',
                accent: _s5Primary,
                soft: _s5Soft,
                icon: Icons.palette_outlined,
              ),
            ),
            Expanded(
              child: _conceptCell(
                title: 'NavigationBar',
                detail:
                    'Bottom bar with NavigationDestinations — wrap icons with Badge to show indicators.',
                accent: _s7Primary,
                soft: _s7Soft,
                icon: Icons.view_quilt_outlined,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Row(
          children: [
            Expanded(
              child: _conceptCell(
                title: 'NavigationRail',
                detail:
                    'Side rail navigation, compact or extended; badges decorate the destination icon.',
                accent: _s10Primary,
                soft: _s10Soft,
                icon: Icons.view_sidebar_outlined,
              ),
            ),
            Expanded(
              child: _conceptCell(
                title: 'Composition',
                detail:
                    'Combine Badge with avatars, app bars, and tiles for rich notification UIs.',
                accent: _s6Primary,
                soft: _s6Soft,
                icon: Icons.dashboard_customize_outlined,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================================
  // SECTION BODIES
  // ============================================================================

  final section1Body = Container(
    margin: EdgeInsets.symmetric(horizontal: 24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recipe Cards',
          style: TextStyle(
            color: _s1Primary,
            fontWeight: FontWeight.w800,
            fontSize: 14.0,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 8.0),
        Wrap(
          children: [
            _recipeCard(
              title: 'DOT INDICATOR',
              body:
                  'Badge() with no label renders a default-sized dot. Use it for '
                  '"has unread" indicators without a count.',
              preview: _previewBadge(basicDot, caption: 'Unread'),
              accent: _s1Primary,
              soft: _s1Soft,
            ),
            _recipeCard(
              title: 'NUMERIC LABEL',
              body:
                  'Pass label: Text("3") to render the count. Defaults to the '
                  'theme color scheme error tone.',
              preview: _previewBadge(basicLabel, caption: '3 messages'),
              accent: _s1Primary,
              soft: _s1Soft,
            ),
            _recipeCard(
              title: 'COLORED LABEL',
              body:
                  'Override backgroundColor and textColor for branded badges; '
                  'pairs well with iconography.',
              preview: _previewBadge(basicColored, caption: 'Branded'),
              accent: _s1Primary,
              soft: _s1Soft,
            ),
            _recipeCard(
              title: 'TEXT LABEL',
              body:
                  'Use a short word like "NEW" or "HOT" instead of a number to '
                  'highlight new content.',
              preview: _previewBadge(basicLargeText, caption: 'Sale'),
              accent: _s1Primary,
              soft: _s1Soft,
            ),
          ],
        ),
      ],
    ),
  );

  final section2Body = Container(
    margin: EdgeInsets.symmetric(horizontal: 24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Badge.count(count: n)',
          style: TextStyle(
            color: _s2Primary,
            fontWeight: FontWeight.w800,
            fontSize: 14.0,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 8.0),
        Wrap(
          children: [
            _recipeCard(
              title: 'COUNT 1',
              body: 'Badge.count handles a single new item gracefully.',
              preview: _previewBadge(countOne, caption: '1 unread'),
              accent: _s2Primary,
              soft: _s2Soft,
            ),
            _recipeCard(
              title: 'COUNT 7',
              body: 'Small two-digit counts feel natural inside the chip.',
              preview: _previewBadge(countSeven, caption: '7 unread'),
              accent: _s2Primary,
              soft: _s2Soft,
            ),
            _recipeCard(
              title: 'COUNT 90',
              body:
                  'Two-digit counts up to 99 are displayed exactly as provided.',
              preview: _previewBadge(countNinety, caption: '90 unread'),
              accent: _s2Primary,
              soft: _s2Soft,
            ),
            _recipeCard(
              title: 'OVERFLOW',
              body:
                  'Above 999, Badge.count renders 999+ to keep the badge tidy.',
              preview: _previewBadge(countOverflow, caption: '1234 unread'),
              accent: _s2Primary,
              soft: _s2Soft,
            ),
          ],
        ),
      ],
    ),
  );

  final section3Body = Container(
    margin: EdgeInsets.symmetric(horizontal: 24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'smallSize controls the dot diameter; largeSize sets the label chip\'s height.',
          style: TextStyle(
            color: _inkSoft,
            fontSize: 13.0,
            height: 1.4,
          ),
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(child: _previewBadge(tinyDot, caption: 'smallSize 4')),
            Expanded(child: _previewBadge(smallDot, caption: 'smallSize 8')),
            Expanded(child: _previewBadge(mediumDot, caption: 'smallSize 12')),
            Expanded(child: _previewBadge(largeDot, caption: 'smallSize 16')),
          ],
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: _previewBadge(largeLabel, caption: 'largeSize 22'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: _previewBadge(compactLabel, caption: 'largeSize 14'),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        _table(
          headers: ['Field', 'Effect'],
          rows: [
            ['smallSize', 'Diameter of the dot when no label is set.'],
            ['largeSize', 'Height of the rounded chip when label is set.'],
            ['textStyle', 'TextStyle for the label; scale font with chip.'],
            ['padding', 'Horizontal/vertical inset around the label.'],
          ],
          accent: _s3Primary,
          soft: _s3Soft,
        ),
      ],
    ),
  );

  final section4Body = Container(
    margin: EdgeInsets.symmetric(horizontal: 24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Custom backgroundColor + textColor palette',
          style: TextStyle(
            color: _s4Primary,
            fontWeight: FontWeight.w800,
            fontSize: 14.0,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          decoration: BoxDecoration(
            color: _s4Soft.withOpacity(0.35),
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: _s4Soft, width: 1.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: styledBadges,
          ),
        ),
        SizedBox(height: 12.0),
        _calloutBox(
          title: 'TIP — KEEP CONTRAST HIGH',
          body:
              'Badges are small — make sure the textColor maintains AA contrast '
              'against the backgroundColor or the label becomes unreadable.',
          accent: _s4Primary,
          soft: _s4Soft,
          icon: Icons.contrast,
        ),
      ],
    ),
  );

  final section5Body = Container(
    margin: EdgeInsets.symmetric(horizontal: 24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'alignment, offset, and padding tune badge positioning.',
          style: TextStyle(color: _inkSoft, fontSize: 13.0),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 18.0,
          runSpacing: 14.0,
          children: [
            _previewBadge(alignTopStart, caption: 'topStart'),
            _previewBadge(alignTopEnd, caption: 'topEnd'),
            _previewBadge(alignBottomStart, caption: 'bottomStart'),
            _previewBadge(alignBottomEnd, caption: 'bottomEnd'),
            _previewBadge(offsetNudged, caption: 'offset(6,-6)'),
            _previewBadge(paddedBadge, caption: 'padding H10/V2'),
          ],
        ),
        SizedBox(height: 12.0),
        _table(
          headers: ['Property', 'Type & Default'],
          rows: [
            ['alignment', 'AlignmentGeometry, default top-end'],
            ['offset', 'Offset; positive y nudges down, negative up'],
            ['padding', 'EdgeInsets around the label only'],
          ],
          accent: _s5Primary,
          soft: _s5Soft,
        ),
      ],
    ),
  );

  final section6Body = Container(
    margin: EdgeInsets.symmetric(horizontal: 24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Toggle visibility without unmounting children',
          style: TextStyle(
            color: _s6Primary,
            fontWeight: FontWeight.w800,
            fontSize: 14.0,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _previewBadge(visibleBadge, caption: 'visible'),
            _previewBadge(hiddenBadge, caption: 'isLabelVisible=false'),
            _previewBadge(hiddenDot, caption: 'dot hidden'),
          ],
        ),
        SizedBox(height: 14.0),
        _calloutBox(
          title: 'WHY isLabelVisible?',
          body:
              'Use isLabelVisible to toggle the indicator without changing the '
              'subtree — the child icon does not jitter or rebuild when the '
              'badge appears or disappears.',
          accent: _s6Primary,
          soft: _s6Soft,
          icon: Icons.visibility_outlined,
        ),
      ],
    ),
  );

  final section7Body = Container(
    margin: EdgeInsets.symmetric(horizontal: 24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'BadgeThemeData applies defaults via ThemeData.badgeTheme',
          style: TextStyle(
            color: _s7Primary,
            fontWeight: FontWeight.w800,
            fontSize: 14.0,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            themedSample(themeWarm, 'Warm'),
            themedSample(themeCool, 'Cool'),
            themedSample(themeBold, 'Bold'),
          ],
        ),
        SizedBox(height: 12.0),
        _table(
          headers: ['Theme', 'Highlights'],
          rows: [
            ['Warm', 'Orange, top-end, soft offset, padding H5'],
            ['Cool', 'Sky-blue, no offset, compact text'],
            ['Bold', 'Hot-pink, larger chip, offset(2,-2), padding H8'],
          ],
          accent: _s7Primary,
          soft: _s7Soft,
        ),
      ],
    ),
  );

  final section8Body = Container(
    margin: EdgeInsets.symmetric(horizontal: 24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'NavigationBar destinations wrap icons with Badge',
          style: TextStyle(
            color: _s8Primary,
            fontWeight: FontWeight.w800,
            fontSize: 14.0,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          height: 92.0,
          decoration: BoxDecoration(
            color: _paper,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: _line),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14.0),
            child: navBarBasic,
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          height: 92.0,
          decoration: BoxDecoration(
            color: _paperWarm,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: _line),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14.0),
            child: navBarHeavy,
          ),
        ),
        SizedBox(height: 12.0),
        _calloutBox(
          title: 'SELECTED VS UNSELECTED',
          body:
              'Provide both icon and selectedIcon wrapped in Badge so the '
              'indicator persists when the destination becomes selected and '
              'the icon swaps from outlined to filled.',
          accent: _s8Primary,
          soft: _s8Soft,
          icon: Icons.swap_horiz,
        ),
      ],
    ),
  );

  final section9Body = Container(
    margin: EdgeInsets.symmetric(horizontal: 24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'NavigationRail in compact and extended modes',
          style: TextStyle(
            color: _s9Primary,
            fontWeight: FontWeight.w800,
            fontSize: 14.0,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          height: 280.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: _line),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14.0),
            child: Row(
              children: [
                navRailCompact,
                Expanded(
                  child: Container(
                    color: _paper,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.dashboard,
                            size: 56.0, color: _s9Primary),
                        SizedBox(height: 10.0),
                        Text(
                          'Compact NavigationRail',
                          style: TextStyle(
                            color: _ink,
                            fontWeight: FontWeight.w800,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'labelType: NavigationRailLabelType.all',
                          style: TextStyle(
                            color: _inkMuted,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          height: 280.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: _line),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14.0),
            child: Row(
              children: [
                navRailExtended,
                Expanded(
                  child: Container(
                    color: _paperWarm,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications_active,
                            size: 56.0, color: _s9Primary),
                        SizedBox(height: 10.0),
                        Text(
                          'Extended NavigationRail',
                          style: TextStyle(
                            color: _ink,
                            fontWeight: FontWeight.w800,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          'extended: true with full destination labels',
                          style: TextStyle(
                            color: _inkMuted,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  final section10Body = Container(
    margin: EdgeInsets.symmetric(horizontal: 24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Count overflow behavior (Badge.count)',
          style: TextStyle(
            color: _s10Primary,
            fontWeight: FontWeight.w800,
            fontSize: 14.0,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          decoration: BoxDecoration(
            color: _s10Soft.withOpacity(0.30),
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: _s10Soft),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: overflowBadges,
          ),
        ),
        SizedBox(height: 12.0),
        _table(
          headers: ['count', 'Rendered Label'],
          rows: [
            ['1', '1'],
            ['10', '10'],
            ['99', '99'],
            ['100', '100'],
            ['999', '999'],
            ['9999', '999+'],
          ],
          accent: _s10Primary,
          soft: _s10Soft,
        ),
      ],
    ),
  );

  final section11Body = Container(
    margin: EdgeInsets.symmetric(horizontal: 24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Real-world composition: app bar + inbox tiles',
          style: TextStyle(
            color: _s11Primary,
            fontWeight: FontWeight.w800,
            fontSize: 14.0,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 10.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0),
          child: appBarMock('Notification Atelier', 5, 12),
        ),
        SizedBox(height: 14.0),
      ],
    ),
  );

  final section12Body = Container(
    margin: EdgeInsets.symmetric(horizontal: 24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Badge + CircleAvatar status indicators',
          style: TextStyle(
            color: _s12Primary,
            fontWeight: FontWeight.w800,
            fontSize: 14.0,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: _line),
          ),
          child: avatarRow,
        ),
        SizedBox(height: 12.0),
        _calloutBox(
          title: 'PATTERN — STATUS DOT ON AVATAR',
          body:
              'Set alignment: AlignmentDirectional.bottomEnd and choose a '
              'small smallSize so the dot reads as a presence marker rather '
              'than a count chip.',
          accent: _s12Primary,
          soft: _s12Soft,
          icon: Icons.fiber_manual_record,
        ),
      ],
    ),
  );

  // ============================================================================
  // GLOSSARY
  // ============================================================================

  final glossary = Container(
    margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: _line, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Glossary',
          style: TextStyle(
            color: _ink,
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
          ),
        ),
        SizedBox(height: 12.0),
        _glossaryRow(
          'Badge',
          'A Material widget that decorates a child with a label or dot indicator.',
        ),
        _glossaryRow(
          'Badge.count',
          'Factory that formats an int count, rendering 999+ for overflow.',
        ),
        _glossaryRow(
          'BadgeThemeData',
          'Default theming for Badge widgets, applied via ThemeData.badgeTheme.',
        ),
        _glossaryRow(
          'smallSize',
          'Diameter used for the empty (dot) form factor.',
        ),
        _glossaryRow(
          'largeSize',
          'Height of the rounded label chip when a label is provided.',
        ),
        _glossaryRow(
          'isLabelVisible',
          'Boolean flag controlling whether the badge layer renders.',
        ),
        _glossaryRow(
          'NavigationBar',
          'Material 3 bottom navigation bar consuming NavigationDestination items.',
        ),
        _glossaryRow(
          'NavigationDestination',
          'Item used by NavigationBar — icon, selectedIcon, and label.',
        ),
        _glossaryRow(
          'NavigationRail',
          'Side navigation widget supporting compact, all-labels, and extended modes.',
        ),
        _glossaryRow(
          'NavigationRailDestination',
          'Item used by NavigationRail — icon, selectedIcon, and label Widget.',
        ),
        _glossaryRow(
          'NavigationRailLabelType',
          'Enum: none, selected, all — controls when labels appear in compact mode.',
        ),
      ],
    ),
  );

  // ============================================================================
  // EPILOGUE
  // ============================================================================

  final epilogue = Container(
    margin: EdgeInsets.all(24.0),
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_s12Primary, _s10Primary, _ink],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: _s12Primary.withOpacity(0.30),
          blurRadius: 16.0,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.auto_awesome, color: Colors.white, size: 26.0),
            SizedBox(width: 10.0),
            Text(
              'Epilogue',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Badge is small but mighty — the difference between an app that feels '
          'attentive and one that feels mute often hinges on a single red dot. '
          'Combined with NavigationBar and NavigationRail destinations it forms '
          'the spine of modern notification UX. Tune colors, padding, and '
          'alignment via BadgeThemeData to keep the indicator family consistent '
          'across the surface.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.94),
            fontSize: 13.5,
            height: 1.6,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          children: [
            _epilogueChip(label: 'Badge'),
            _epilogueChip(label: 'Badge.count'),
            _epilogueChip(label: 'BadgeTheme'),
            _epilogueChip(label: 'NavBar'),
            _epilogueChip(label: 'NavRail'),
          ],
        ),
      ],
    ),
  );

  // ============================================================================
  // FINAL TREE
  // ============================================================================

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Navigation Badge Gallery',
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _s10Primary,
      scaffoldBackgroundColor: _paper,
    ),
    home: Scaffold(
      backgroundColor: _paper,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            hero,
            overview,
            _sectionBanner(
              number: 1,
              title: 'Badge Basics',
              subtitle: 'Dot, label, color, and short text variants.',
              primary: _s1Primary,
              soft: _s1Soft,
            ),
            section1Body,
            _sectionBanner(
              number: 2,
              title: 'Badge.count Factory',
              subtitle: 'Numeric counts with built-in overflow handling.',
              primary: _s2Primary,
              soft: _s2Soft,
            ),
            section2Body,
            _sectionBanner(
              number: 3,
              title: 'Size Variants',
              subtitle: 'smallSize for dots, largeSize for label chips.',
              primary: _s3Primary,
              soft: _s3Soft,
            ),
            section3Body,
            _sectionBanner(
              number: 4,
              title: 'Color & Style Customization',
              subtitle: 'Branded palettes via backgroundColor/textColor/textStyle.',
              primary: _s4Primary,
              soft: _s4Soft,
            ),
            section4Body,
            _sectionBanner(
              number: 5,
              title: 'Alignment, Offset & Padding',
              subtitle: 'Position the badge precisely around its child.',
              primary: _s5Primary,
              soft: _s5Soft,
            ),
            section5Body,
            _sectionBanner(
              number: 6,
              title: 'Visibility Toggle',
              subtitle: 'isLabelVisible without remounting the subtree.',
              primary: _s6Primary,
              soft: _s6Soft,
            ),
            section6Body,
            _sectionBanner(
              number: 7,
              title: 'BadgeThemeData',
              subtitle: 'Theme-level defaults for an entire app section.',
              primary: _s7Primary,
              soft: _s7Soft,
            ),
            section7Body,
            _sectionBanner(
              number: 8,
              title: 'NavigationBar Badges',
              subtitle: 'Material 3 bottom bar with Badge-wrapped destinations.',
              primary: _s8Primary,
              soft: _s8Soft,
            ),
            section8Body,
            _sectionBanner(
              number: 9,
              title: 'NavigationRail Badges',
              subtitle: 'Compact and extended rails with badge indicators.',
              primary: _s9Primary,
              soft: _s9Soft,
            ),
            section9Body,
            _sectionBanner(
              number: 10,
              title: 'Overflow & Large Counts',
              subtitle: '999+ rendering for high-volume notification counts.',
              primary: _s10Primary,
              soft: _s10Soft,
            ),
            section10Body,
            _sectionBanner(
              number: 11,
              title: 'Real-World Compositions',
              subtitle: 'App bar and inbox tiles with cohesive badge usage.',
              primary: _s11Primary,
              soft: _s11Soft,
            ),
            section11Body,
            inboxComposition,
            _sectionBanner(
              number: 12,
              title: 'Avatar Status Patterns',
              subtitle: 'Presence dots and tiny labels on CircleAvatar.',
              primary: _s12Primary,
              soft: _s12Soft,
            ),
            section12Body,
            glossary,
            epilogue,
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// SMALL LOCAL HELPERS (top-level, not nested in build)
// ============================================================================

Widget _conceptCell({
  required String title,
  required String detail,
  required Color accent,
  required Color soft,
  required IconData icon,
}) {
  return Container(
    margin: EdgeInsets.all(6.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: soft.withOpacity(0.55),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: soft, width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: accent, size: 18.0),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.w800,
                  fontSize: 13.5,
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                detail,
                style: TextStyle(
                  color: _inkSoft,
                  fontSize: 12.0,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _glossaryRow(String term, String definition) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 160.0,
          padding: EdgeInsets.only(right: 12.0),
          child: Text(
            term,
            style: TextStyle(
              color: _s10Primary,
              fontWeight: FontWeight.w800,
              fontSize: 12.5,
            ),
          ),
        ),
        Expanded(
          child: Text(
            definition,
            style: TextStyle(
              color: _inkSoft,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _epilogueChip({required String label}) {
  return Container(
    margin: EdgeInsets.only(right: 8.0),
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.18),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.white.withOpacity(0.35)),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w800,
        fontSize: 11.5,
        letterSpacing: 0.5,
      ),
    ),
  );
}
