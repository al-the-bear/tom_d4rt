// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests NavigationDestination from Flutter material
// Deep Demo: Visual demonstration of NavigationDestination, NavigationBar, NavigationRail and label behaviors
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NavigationDestination Deep Demo executing');

  // ============================================================
  // SECTION 1: NavigationDestination Concept Overview
  // ============================================================
  print('=== Section 1: NavigationDestination Concept Overview ===');

  Widget conceptCard({
    required IconData icon,
    required String title,
    required String body,
    required Color tint,
  }) {
    return Container(
      width: 220.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [tint.withValues(alpha: 0.12), tint.withValues(alpha: 0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: tint.withValues(alpha: 0.6), width: 2.0),
        boxShadow: [
          BoxShadow(
            color: tint.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 44.0, color: tint),
          SizedBox(height: 10.0),
          Text(
            title,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: tint,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            body,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: tint),
          ),
        ],
      ),
    );
  }

  final conceptCards = <Widget>[
    conceptCard(
      icon: Icons.dashboard_customize,
      title: 'NavigationDestination',
      body: 'A single destination tile\n'
          'used inside NavigationBar.\n'
          'Holds icon, selectedIcon, label,\n'
          'tooltip, enabled.',
      tint: Colors.indigo.shade700,
    ),
    conceptCard(
      icon: Icons.view_carousel,
      title: 'NavigationBar',
      body: 'Bottom rail container.\n'
          'Hosts a row of\n'
          'NavigationDestinations.\n'
          'Tracks selectedIndex.',
      tint: Colors.teal.shade700,
    ),
    conceptCard(
      icon: Icons.vertical_split,
      title: 'NavigationRail',
      body: 'Side rail variant for\n'
          'tablets and desktops.\n'
          'Uses NavigationRailDestination\n'
          'with icon + Text label.',
      tint: Colors.deepPurple.shade700,
    ),
  ];
  print('Created ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: NavigationBar Gallery (selectedIndex 0..3)
  // ============================================================
  print('=== Section 2: NavigationBar Gallery ===');

  // Build a quartet of NavigationBars, each with a different selectedIndex
  // showing how selection state changes the highlighted tile and selectedIcon.

  Widget galleryCard({
    required int selected,
    required String title,
    required IconData numIcon,
    required Color tint,
    required List<NavigationDestination> destinations,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.blueGrey.shade200, width: 1.5),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(numIcon, color: tint, size: 22.0),
                SizedBox(width: 8.0),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: tint,
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(13.0)),
            child: NavigationBar(
              selectedIndex: selected,
              backgroundColor: tint.withValues(alpha: 0.08),
              indicatorColor: tint.withValues(alpha: 0.3),
              destinations: destinations,
            ),
          ),
        ],
      ),
    );
  }

  // Each gallery item has its own uniquely composed destination list
  // (different tooltip attached to whichever destination is selected).
  final galleryItems = <Widget>[
    galleryCard(
      selected: 0,
      title: 'selectedIndex: 0  -  Home',
      numIcon: Icons.looks_one,
      tint: Colors.blue.shade800,
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home',
          tooltip: 'Go home',
        ),
        NavigationDestination(
          icon: Icon(Icons.search_outlined),
          selectedIcon: Icon(Icons.search),
          label: 'Search',
        ),
        NavigationDestination(
          icon: Icon(Icons.notifications_outlined),
          selectedIcon: Icon(Icons.notifications),
          label: 'Alerts',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    ),
    galleryCard(
      selected: 1,
      title: 'selectedIndex: 1  -  Search',
      numIcon: Icons.looks_two,
      tint: Colors.green.shade800,
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.search_outlined),
          selectedIcon: Icon(Icons.search),
          label: 'Search',
          tooltip: 'Search content',
        ),
        NavigationDestination(
          icon: Icon(Icons.notifications_outlined),
          selectedIcon: Icon(Icons.notifications),
          label: 'Alerts',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    ),
    galleryCard(
      selected: 2,
      title: 'selectedIndex: 2  -  Alerts',
      numIcon: Icons.looks_3,
      tint: Colors.orange.shade800,
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.search_outlined),
          selectedIcon: Icon(Icons.search),
          label: 'Search',
        ),
        NavigationDestination(
          icon: Icon(Icons.notifications_outlined),
          selectedIcon: Icon(Icons.notifications),
          label: 'Alerts',
          tooltip: 'View notifications',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    ),
    galleryCard(
      selected: 3,
      title: 'selectedIndex: 3  -  Profile',
      numIcon: Icons.looks_4,
      tint: Colors.purple.shade800,
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.search_outlined),
          selectedIcon: Icon(Icons.search),
          label: 'Search',
        ),
        NavigationDestination(
          icon: Icon(Icons.notifications_outlined),
          selectedIcon: Icon(Icons.notifications),
          label: 'Alerts',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Profile',
          tooltip: 'Your profile',
        ),
      ],
    ),
  ];
  print('Created ${galleryItems.length} NavigationBar gallery rows');

  // ============================================================
  // SECTION 3: icon vs selectedIcon Swap Demo
  // ============================================================
  print('=== Section 3: icon vs selectedIcon Swap Demo ===');

  // A single three-destination bar repeated three times with each possible
  // selectedIndex, so the selectedIcon "fills in" for the active item.

  Widget swapRow({
    required int selected,
    required String title,
    required Color tint,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: tint.withValues(alpha: 0.4), width: 1.5),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.swap_horiz, color: tint, size: 20.0),
                SizedBox(width: 8.0),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: tint,
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(13.0)),
            child: NavigationBar(
              selectedIndex: selected,
              backgroundColor: tint.withValues(alpha: 0.08),
              indicatorColor: tint.withValues(alpha: 0.3),
              destinations: [
                NavigationDestination(
                  icon: Icon(Icons.music_note_outlined),
                  selectedIcon: Icon(Icons.music_note),
                  label: 'Music',
                ),
                NavigationDestination(
                  icon: Icon(Icons.movie_outlined),
                  selectedIcon: Icon(Icons.movie),
                  label: 'Movies',
                ),
                NavigationDestination(
                  icon: Icon(Icons.menu_book_outlined),
                  selectedIcon: Icon(Icons.menu_book),
                  label: 'Books',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final swapItems = <Widget>[
    swapRow(
      selected: 0,
      title: 'selectedIndex: 0  -  music filled',
      tint: Colors.pink.shade700,
    ),
    swapRow(
      selected: 1,
      title: 'selectedIndex: 1  -  movies filled',
      tint: Colors.amber.shade800,
    ),
    swapRow(
      selected: 2,
      title: 'selectedIndex: 2  -  books filled',
      tint: Colors.lightGreen.shade800,
    ),
  ];
  print('Created ${swapItems.length} icon-swap rows');

  // ============================================================
  // SECTION 4: NavigationDestinationLabelBehavior Variants
  // ============================================================
  print('=== Section 4: NavigationDestinationLabelBehavior Variants ===');

  Widget behaviorRow({
    required NavigationDestinationLabelBehavior behavior,
    required int selected,
    required IconData badgeIcon,
    required String name,
    required String summary,
    required Color tint,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: tint.withValues(alpha: 0.5), width: 2.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Icon(badgeIcon, color: tint, size: 22.0),
                SizedBox(width: 8.0),
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                    color: tint,
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    summary,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.0)),
            child: NavigationBar(
              selectedIndex: selected,
              labelBehavior: behavior,
              backgroundColor: tint.withValues(alpha: 0.08),
              indicatorColor: tint.withValues(alpha: 0.3),
              destinations: [
                NavigationDestination(
                  icon: Icon(Icons.cloud_outlined),
                  selectedIcon: Icon(Icons.cloud),
                  label: 'Cloud',
                ),
                NavigationDestination(
                  icon: Icon(Icons.folder_outlined),
                  selectedIcon: Icon(Icons.folder),
                  label: 'Files',
                ),
                NavigationDestination(
                  icon: Icon(Icons.share_outlined),
                  selectedIcon: Icon(Icons.share),
                  label: 'Share',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final labelBehaviorRows = <Widget>[
    behaviorRow(
      behavior: NavigationDestinationLabelBehavior.alwaysShow,
      selected: 1,
      badgeIcon: Icons.label_important,
      name: 'alwaysShow',
      summary: '- labels visible for every destination, always',
      tint: Colors.cyan.shade800,
    ),
    behaviorRow(
      behavior: NavigationDestinationLabelBehavior.alwaysHide,
      selected: 2,
      badgeIcon: Icons.visibility_off,
      name: 'alwaysHide',
      summary: '- labels suppressed, icons only',
      tint: Colors.red.shade700,
    ),
    behaviorRow(
      behavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      selected: 3,
      badgeIcon: Icons.center_focus_strong,
      name: 'onlyShowSelected',
      summary: '- label appears under the active item only',
      tint: Colors.deepOrange.shade700,
    ),
  ];
  print('Created ${labelBehaviorRows.length} label behavior rows');

  // ============================================================
  // SECTION 5: NavigationRail (Vertical Side-Rail Variant)
  // ============================================================
  print('=== Section 5: NavigationRail (vertical) ===');

  // Rail variant 1: compact label behavior selected, padding per destination
  final railSelected = NavigationRail(
    selectedIndex: 1,
    backgroundColor: Colors.indigo.shade50,
    labelType: NavigationRailLabelType.selected,
    indicatorColor: Colors.indigo.shade200,
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    onDestinationSelected: (int index) {
      print('Rail (selected-label) - tapped index $index');
    },
    destinations: [
      NavigationRailDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home),
        label: Text('Home'),
        padding: EdgeInsets.symmetric(vertical: 6.0),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.work_outline),
        selectedIcon: Icon(Icons.work),
        label: Text('Work'),
        padding: EdgeInsets.symmetric(vertical: 6.0),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.school_outlined),
        selectedIcon: Icon(Icons.school),
        label: Text('Learn'),
        padding: EdgeInsets.symmetric(vertical: 6.0),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.settings_outlined),
        selectedIcon: Icon(Icons.settings),
        label: Text('Setup'),
        padding: EdgeInsets.symmetric(vertical: 6.0),
      ),
    ],
  );

  // Rail variant 2: always-labels, extended layout vibe via compact icons
  final railAlways = NavigationRail(
    selectedIndex: 2,
    backgroundColor: Colors.teal.shade50,
    labelType: NavigationRailLabelType.all,
    indicatorColor: Colors.teal.shade200,
    onDestinationSelected: (int index) {
      print('Rail (all-labels) - tapped index $index');
    },
    destinations: [
      NavigationRailDestination(
        icon: Icon(Icons.dashboard_outlined),
        selectedIcon: Icon(Icons.dashboard),
        label: Text('Board'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.list_alt_outlined),
        selectedIcon: Icon(Icons.list_alt),
        label: Text('Tasks'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.bar_chart_outlined),
        selectedIcon: Icon(Icons.bar_chart),
        label: Text('Stats'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.help_outline),
        selectedIcon: Icon(Icons.help),
        label: Text('Help'),
      ),
    ],
  );

  // Rail variant 3: no labels (icon-only)
  final railNone = NavigationRail(
    selectedIndex: 0,
    backgroundColor: Colors.grey.shade100,
    labelType: NavigationRailLabelType.none,
    indicatorColor: Colors.grey.shade300,
    onDestinationSelected: (int index) {
      print('Rail (no labels) - tapped index $index');
    },
    destinations: [
      NavigationRailDestination(
        icon: Icon(Icons.inbox_outlined),
        selectedIcon: Icon(Icons.inbox),
        label: Text('Inbox'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.send_outlined),
        selectedIcon: Icon(Icons.send),
        label: Text('Sent'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.delete_outline),
        selectedIcon: Icon(Icons.delete),
        label: Text('Trash'),
      ),
    ],
  );

  final railWidget = Container(
    height: 320.0,
    margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.5),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(13.0),
      child: Row(
        children: [
          railSelected,
          VerticalDivider(width: 1.0, color: Colors.indigo.shade100),
          railAlways,
          VerticalDivider(width: 1.0, color: Colors.indigo.shade100),
          railNone,
          VerticalDivider(width: 1.0, color: Colors.indigo.shade100),
          Expanded(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Three rails, three labelType modes',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Left: NavigationRailLabelType.selected\n'
                    'Middle: NavigationRailLabelType.all\n'
                    'Right: NavigationRailLabelType.none',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade700,
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      'NavigationRailDestination supports:\n'
                      'icon, selectedIcon, label, padding,\n'
                      'and (since 3.x) indicatorColor / shape\n'
                      'on the containing NavigationRail.',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.indigo.shade900,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
  print('Created NavigationRail demo (3 rails)');

  // ============================================================
  // SECTION 6: Real-world App Shell Mock
  // ============================================================
  print('=== Section 6: Real-world App Shell Mock ===');

  // A faux app: a content panel with a "current page name" and a
  // NavigationBar pinned at the bottom. Two snapshots show selection drift.

  Widget buildAppShellSnapshot({
    required int selected,
    required String title,
    required IconData heroIcon,
    required Color tint,
    required String body,
  }) {
    return Container(
      width: 320.0,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: tint.withValues(alpha: 0.5), width: 2.0),
        boxShadow: [
          BoxShadow(
            color: tint.withValues(alpha: 0.25),
            blurRadius: 12.0,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Faux app bar
            Container(
              color: tint,
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
              child: Row(
                children: [
                  Icon(Icons.menu, color: Colors.white, size: 20.0),
                  SizedBox(width: 10.0),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.more_vert, color: Colors.white, size: 20.0),
                ],
              ),
            ),
            // Content area
            Container(
              height: 200.0,
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(heroIcon, size: 64.0, color: tint),
                  SizedBox(height: 12.0),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: tint,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    body,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            // Bottom NavigationBar
            NavigationBar(
              selectedIndex: selected,
              height: 64.0,
              backgroundColor: tint.withValues(alpha: 0.08),
              indicatorColor: tint.withValues(alpha: 0.3),
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              destinations: [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                  tooltip: 'Home tab',
                ),
                NavigationDestination(
                  icon: Icon(Icons.explore_outlined),
                  selectedIcon: Icon(Icons.explore),
                  label: 'Explore',
                  tooltip: 'Explore tab',
                ),
                NavigationDestination(
                  icon: Icon(Icons.shopping_cart_outlined),
                  selectedIcon: Icon(Icons.shopping_cart),
                  label: 'Cart',
                  tooltip: 'Your cart',
                ),
                NavigationDestination(
                  icon: Icon(Icons.account_circle_outlined),
                  selectedIcon: Icon(Icons.account_circle),
                  label: 'Account',
                  tooltip: 'Your account',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final appShellRow = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildAppShellSnapshot(
        selected: 0,
        title: 'Home',
        heroIcon: Icons.home,
        tint: Colors.blue,
        body: 'Selected tab drives the page name shown\n'
            'in the content area above the NavigationBar.',
      ),
      buildAppShellSnapshot(
        selected: 1,
        title: 'Explore',
        heroIcon: Icons.explore,
        tint: Colors.teal,
        body: 'Each NavigationDestination has its own\n'
            'tooltip for screen readers and long-press.',
      ),
      buildAppShellSnapshot(
        selected: 2,
        title: 'Cart',
        heroIcon: Icons.shopping_cart,
        tint: Colors.orange,
        body: 'selectedIcon swaps automatically when\n'
            'selectedIndex points at this destination.',
      ),
    ],
  );
  print('Created 3 app shell snapshots');

  // ============================================================
  // SECTION 7: Accessibility / Tooltip Story
  // ============================================================
  print('=== Section 7: Accessibility / Tooltip Story ===');

  final accessibilityCards = <Widget>[];

  accessibilityCards.add(
    Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade50,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.lightBlue.shade300, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.accessibility_new, color: Colors.lightBlue.shade800),
              SizedBox(width: 8.0),
              Text(
                'tooltip parameter',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue.shade900,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Text(
            'Each NavigationDestination accepts a tooltip\n'
            'string. The tooltip surfaces:\n'
            '  - on long press (mobile)\n'
            '  - on hover (desktop / web)\n'
            '  - to screen readers as accessibility label',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.lightBlue.shade900,
              height: 1.5,
            ),
          ),
          SizedBox(height: 8.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: NavigationBar(
              selectedIndex: 1,
              labelBehavior:
                  NavigationDestinationLabelBehavior.alwaysHide,
              backgroundColor: Colors.lightBlue.shade100,
              indicatorColor: Colors.lightBlue.shade300,
              destinations: [
                NavigationDestination(
                  icon: Icon(Icons.translate),
                  label: 'Translate',
                  tooltip: 'Translate the current page',
                ),
                NavigationDestination(
                  icon: Icon(Icons.record_voice_over),
                  label: 'Read aloud',
                  tooltip: 'Read the page aloud (TTS)',
                ),
                NavigationDestination(
                  icon: Icon(Icons.contrast),
                  label: 'High contrast',
                  tooltip: 'Toggle high-contrast mode',
                ),
                NavigationDestination(
                  icon: Icon(Icons.text_increase),
                  label: 'Larger text',
                  tooltip: 'Increase font size',
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  accessibilityCards.add(
    Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.deepPurple.shade300, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.block, color: Colors.deepPurple.shade800),
              SizedBox(width: 8.0),
              Text(
                'enabled: false',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.shade900,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Text(
            'A destination can be disabled. It still renders\n'
            'but the user cannot select it and the icon is\n'
            'shown in a muted style. The third tile below\n'
            'is disabled.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.deepPurple.shade900,
              height: 1.5,
            ),
          ),
          SizedBox(height: 8.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: NavigationBar(
              selectedIndex: 0,
              backgroundColor: Colors.deepPurple.shade100,
              indicatorColor: Colors.deepPurple.shade300,
              destinations: [
                NavigationDestination(
                  icon: Icon(Icons.lock_open_outlined),
                  selectedIcon: Icon(Icons.lock_open),
                  label: 'Open',
                  enabled: true,
                  tooltip: 'Available',
                ),
                NavigationDestination(
                  icon: Icon(Icons.edit_outlined),
                  selectedIcon: Icon(Icons.edit),
                  label: 'Edit',
                  enabled: true,
                  tooltip: 'Available',
                ),
                NavigationDestination(
                  icon: Icon(Icons.lock_outline),
                  selectedIcon: Icon(Icons.lock),
                  label: 'Locked',
                  enabled: false,
                  tooltip: 'Sign in to unlock',
                ),
                NavigationDestination(
                  icon: Icon(Icons.delete_outline),
                  selectedIcon: Icon(Icons.delete),
                  label: 'Delete',
                  enabled: true,
                  tooltip: 'Delete this item',
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
  print('Created ${accessibilityCards.length} accessibility cards');

  // ============================================================
  // SECTION 8: Code Examples Panel
  // ============================================================
  print('=== Section 8: Code Examples Panel ===');

  Widget codeBlock(String body, Color color) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        body,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.0,
          color: color,
        ),
      ),
    );
  }

  final codeExamples = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade400, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'NavigationDestination construction patterns',
              style: TextStyle(
                color: Colors.cyan.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        codeBlock(
          '// Minimal destination\n'
          'NavigationDestination(\n'
          '  icon: Icon(Icons.home),\n'
          '  label: "Home",\n'
          ');',
          Colors.green.shade300,
        ),
        codeBlock(
          '// With selectedIcon + tooltip\n'
          'NavigationDestination(\n'
          '  icon: Icon(Icons.home_outlined),\n'
          '  selectedIcon: Icon(Icons.home),\n'
          '  label: "Home",\n'
          '  tooltip: "Go to home",\n'
          ');',
          Colors.yellow.shade300,
        ),
        codeBlock(
          '// Disabled destination\n'
          'NavigationDestination(\n'
          '  icon: Icon(Icons.lock),\n'
          '  label: "Locked",\n'
          '  enabled: false,\n'
          ');',
          Colors.orange.shade300,
        ),
        codeBlock(
          '// In a NavigationBar with label behavior\n'
          'NavigationBar(\n'
          '  selectedIndex: 1,\n'
          '  labelBehavior:\n'
          '    NavigationDestinationLabelBehavior.onlyShowSelected,\n'
          '  destinations: [\n'
          '    NavigationDestination(icon: Icon(Icons.home), label: "Home"),\n'
          '    NavigationDestination(icon: Icon(Icons.search), label: "Search"),\n'
          '  ],\n'
          ');',
          Colors.purple.shade300,
        ),
        codeBlock(
          '// NavigationRailDestination (side rail variant)\n'
          'NavigationRailDestination(\n'
          '  icon: Icon(Icons.home_outlined),\n'
          '  selectedIcon: Icon(Icons.home),\n'
          '  label: Text("Home"),\n'
          '  padding: EdgeInsets.symmetric(vertical: 8),\n'
          ');',
          Colors.cyan.shade300,
        ),
      ],
    ),
  );
  print('Created code examples panel');

  // ============================================================
  // SECTION 9: Summary Takeaways
  // ============================================================
  print('=== Section 9: Summary Takeaways ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.cyan.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Key Takeaways',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        _buildSummaryItem(
          Icons.swap_horiz,
          'icon vs selectedIcon',
          'The selected destination swaps to its filled-in icon variant',
          Colors.blue,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.label_important,
          'label is required',
          'Every NavigationDestination needs a label, used for layout and a11y',
          Colors.green,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.accessibility_new,
          'tooltip for context',
          'Tooltip surfaces on hover, long-press, and to screen readers',
          Colors.orange,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.block,
          'enabled toggles input',
          'Pass enabled: false to render a muted, untappable destination',
          Colors.red,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.format_align_center,
          'labelBehavior on NavigationBar',
          'alwaysShow / alwaysHide / onlyShowSelected control label visibility',
          Colors.deepPurple,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.vertical_split,
          'NavigationRailDestination',
          'Vertical sibling: Text label + padding for desktop / tablet layouts',
          Colors.teal,
        ),
      ],
    ),
  );
  print('Created summary panel');

  print('NavigationDestination Deep Demo completed successfully');

  // ============================================================
  // Return complete visual layout
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header banner
        Container(
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.cyan],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              Icon(
                Icons.dashboard_customize,
                size: 56.0,
                color: Colors.white,
              ),
              SizedBox(height: 8.0),
              Text(
                'NavigationDestination',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'NavigationBar - NavigationRail - LabelBehavior',
                style: TextStyle(fontSize: 14.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),

        // Section 1: Concepts
        Text(
          '1. NavigationDestination Concept Overview',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: conceptCards,
        ),
        SizedBox(height: 32.0),

        // Section 2: NavigationBar Gallery
        Text(
          '2. NavigationBar Gallery (selection drift)',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        ...galleryItems,
        SizedBox(height: 32.0),

        // Section 3: icon vs selectedIcon swap
        Text(
          '3. icon vs selectedIcon Swap Demo',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        ...swapItems,
        SizedBox(height: 32.0),

        // Section 4: Label behaviors
        Text(
          '4. NavigationDestinationLabelBehavior Variants',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        ...labelBehaviorRows,
        SizedBox(height: 32.0),

        // Section 5: NavigationRail
        Text(
          '5. NavigationRail (vertical side-rail)',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        railWidget,
        SizedBox(height: 32.0),

        // Section 6: App shell mock
        Text(
          '6. Real-world App Shell Mock',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: appShellRow,
        ),
        SizedBox(height: 32.0),

        // Section 7: Accessibility
        Text(
          '7. Accessibility & Tooltip Story',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        ...accessibilityCards,
        SizedBox(height: 32.0),

        // Section 8: Code examples
        Text(
          '8. Code Examples',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        codeExamples,
        SizedBox(height: 32.0),

        // Section 9: Summary
        Text(
          '9. Summary',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        summaryPanel,
      ],
    ),
  );
}

// Helper: Build summary item
Widget _buildSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
