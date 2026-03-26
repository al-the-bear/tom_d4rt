// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Comprehensive visual demonstration of ListTileStyle enum
// ListTileStyle controls the visual density and styling of ListTile widgets
// Two values: ListTileStyle.list (default, standard list appearance)
//             ListTileStyle.drawer (optimized for navigation drawers)
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// =============================================================================
// SECTION: Helper Widgets for Visual Demonstrations
// =============================================================================

/// Creates a styled section header with a gradient background
/// Used to separate major demo sections for clarity
Widget buildSectionHeader(String title, {IconData? icon, Color? color}) {
  final bgColor = color ?? Colors.indigo;
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
    margin: EdgeInsets.only(bottom: 12, top: 20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [bgColor, bgColor.withAlpha(200)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: bgColor.withAlpha(80),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      children: [
        if (icon != null) ...[
          Icon(icon, color: Colors.white, size: 24),
          SizedBox(width: 12),
        ],
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Creates a subsection header with lighter styling
Widget buildSubsectionHeader(String title, {Color? color}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
    margin: EdgeInsets.only(bottom: 8, top: 12),
    decoration: BoxDecoration(
      color: (color ?? Colors.indigo).withAlpha(30),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: (color ?? Colors.indigo).withAlpha(60),
        width: 1,
      ),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: color ?? Colors.indigo.shade700,
      ),
    ),
  );
}

/// Creates an informational card showing key-value pairs
Widget buildInfoCard(String label, String value, {IconData? icon}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18, color: Colors.indigo.shade400),
          SizedBox(width: 10),
        ],
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    ),
  );
}

/// Creates a comparison card showing two ListTiles side by side
/// Perfect for demonstrating list vs drawer style differences
Widget buildStyleComparisonCard({
  required String title,
  required String description,
  required Widget listStyleTile,
  required Widget drawerStyleTile,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title bar
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              if (description.isNotEmpty) ...[
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ],
          ),
        ),
        // Side-by-side comparison
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // List style column
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'ListTileStyle.list',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      listStyleTile,
                    ],
                  ),
                ),
              ),
              // Drawer style column
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.purple.shade50,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'ListTileStyle.drawer',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.purple.shade700,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      drawerStyleTile,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
      ],
    ),
  );
}

/// Creates a mock drawer container for realistic drawer demonstrations
Widget buildMockDrawer({
  required String title,
  required List<Widget> children,
  Color? headerColor,
  double width = 280,
}) {
  final color = headerColor ?? Colors.indigo;
  return Container(
    width: width,
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(30),
          blurRadius: 12,
          offset: Offset(3, 3),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drawer header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 32, color: color),
                ),
                SizedBox(height: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'drawer@example.com',
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ),
          // Drawer content
          ...children,
          SizedBox(height: 8),
        ],
      ),
    ),
  );
}

/// Creates a mock settings list for list-style demonstrations
Widget buildMockSettingsList({required List<Widget> children}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    ),
  );
}

/// Creates an explanatory note card
Widget buildExplanationCard(String text, {IconData? icon, Color? color}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: (color ?? Colors.amber).withAlpha(25),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: (color ?? Colors.amber).withAlpha(80)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon ?? Icons.lightbulb_outline,
          size: 18,
          color: (color ?? Colors.amber.shade700),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION: Demo Data and Constants
// =============================================================================

/// Navigation items commonly found in drawers
class DrawerNavItem {
  final String title;
  final IconData icon;
  final bool selected;

  const DrawerNavItem({
    required this.title,
    required this.icon,
    this.selected = false,
  });
}

/// Sample drawer navigation items
const List<DrawerNavItem> sampleDrawerItems = [
  DrawerNavItem(title: 'Home', icon: Icons.home_outlined, selected: true),
  DrawerNavItem(title: 'Profile', icon: Icons.person_outline),
  DrawerNavItem(title: 'Messages', icon: Icons.mail_outline),
  DrawerNavItem(title: 'Calendar', icon: Icons.calendar_today_outlined),
  DrawerNavItem(title: 'Settings', icon: Icons.settings_outlined),
];

/// Sample settings items for list-style demos
class SettingsItem {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Widget? trailing;

  const SettingsItem({
    required this.title,
    this.subtitle,
    required this.icon,
    this.trailing,
  });
}

/// Settings items representing a typical settings screen
final List<SettingsItem> sampleSettingsItems = [
  SettingsItem(
    title: 'Account',
    subtitle: 'Privacy, security, change password',
    icon: Icons.person,
  ),
  SettingsItem(
    title: 'Notifications',
    subtitle: 'Message, group & call tones',
    icon: Icons.notifications,
  ),
  SettingsItem(
    title: 'Appearance',
    subtitle: 'Theme, font size, language',
    icon: Icons.palette,
  ),
  SettingsItem(
    title: 'Storage',
    subtitle: 'Network usage, auto-download',
    icon: Icons.storage,
  ),
  SettingsItem(
    title: 'Help',
    subtitle: 'FAQ, contact us, privacy policy',
    icon: Icons.help,
  ),
];

// =============================================================================
// MAIN ENTRY POINT: Visual Demonstration Build Function
// =============================================================================

dynamic build(BuildContext context) {
  print('ListTileStyle comprehensive demo test executing');
  print('========================================');
  print('ListTileStyle enum values:');
  print('  - ListTileStyle.list: Default style for general lists');
  print('  - ListTileStyle.drawer: Optimized style for navigation drawers');
  print('========================================');

  // Track all created widgets for verification
  List<Widget> allDemos = [];

  // =========================================================================
  // SECTION 1: Visual Comparison Side by Side
  // =========================================================================
  print('--- Section 1: Visual Comparison Side by Side ---');

  allDemos.add(
    buildSectionHeader(
      'Section 1: ListTileStyle Visual Comparison',
      icon: Icons.compare_arrows,
      color: Colors.indigo,
    ),
  );

  allDemos.add(
    buildExplanationCard(
      'ListTileStyle is an enum that controls the visual styling of ListTile widgets. '
      'The two values produce subtle but important differences in density, padding, '
      'and overall visual weight. Below we compare them side by side.',
      icon: Icons.info_outline,
      color: Colors.blue,
    ),
  );

  // Basic comparison - simple text tile
  final listStyleBasic = ListTile(
    style: ListTileStyle.list,
    title: Text('Basic Title'),
  );
  final drawerStyleBasic = ListTile(
    style: ListTileStyle.drawer,
    title: Text('Basic Title'),
  );
  print('Created basic ListTile comparison');

  allDemos.add(
    buildStyleComparisonCard(
      title: 'Basic Text Only',
      description: 'Simplest possible ListTile with just a title',
      listStyleTile: listStyleBasic,
      drawerStyleTile: drawerStyleBasic,
    ),
  );

  // Comparison with leading icon
  final listStyleLeading = ListTile(
    style: ListTileStyle.list,
    leading: Icon(Icons.folder, color: Colors.blue),
    title: Text('With Leading Icon'),
  );
  final drawerStyleLeading = ListTile(
    style: ListTileStyle.drawer,
    leading: Icon(Icons.folder, color: Colors.purple),
    title: Text('With Leading Icon'),
  );
  print('Created leading icon comparison');

  allDemos.add(
    buildStyleComparisonCard(
      title: 'With Leading Icon',
      description: 'Notice the spacing differences around the icon',
      listStyleTile: listStyleLeading,
      drawerStyleTile: drawerStyleLeading,
    ),
  );

  // Comparison with title and subtitle
  final listStyleSubtitle = ListTile(
    style: ListTileStyle.list,
    leading: CircleAvatar(
      backgroundColor: Colors.blue.shade100,
      child: Icon(Icons.person, color: Colors.blue),
    ),
    title: Text('John Doe'),
    subtitle: Text('john.doe@example.com'),
  );
  final drawerStyleSubtitle = ListTile(
    style: ListTileStyle.drawer,
    leading: CircleAvatar(
      backgroundColor: Colors.purple.shade100,
      child: Icon(Icons.person, color: Colors.purple),
    ),
    title: Text('John Doe'),
    subtitle: Text('john.doe@example.com'),
  );
  print('Created title with subtitle comparison');

  allDemos.add(
    buildStyleComparisonCard(
      title: 'Title + Subtitle',
      description: 'Observe vertical spacing and text alignment',
      listStyleTile: listStyleSubtitle,
      drawerStyleTile: drawerStyleSubtitle,
    ),
  );

  // Comparison with trailing widget
  final listStyleTrailing = ListTile(
    style: ListTileStyle.list,
    leading: Icon(Icons.wifi, color: Colors.blue),
    title: Text('Wi-Fi'),
    subtitle: Text('Connected to HomeNetwork'),
    trailing: Switch(value: true, onChanged: null),
  );
  final drawerStyleTrailing = ListTile(
    style: ListTileStyle.drawer,
    leading: Icon(Icons.wifi, color: Colors.purple),
    title: Text('Wi-Fi'),
    subtitle: Text('Connected to HomeNetwork'),
    trailing: Switch(value: true, onChanged: null),
  );
  print('Created trailing widget comparison');

  allDemos.add(
    buildStyleComparisonCard(
      title: 'With Trailing Widget',
      description: 'Compare trailing widget alignment and padding',
      listStyleTile: listStyleTrailing,
      drawerStyleTile: drawerStyleTrailing,
    ),
  );

  // Three-line comparison
  final listStyleThreeLine = ListTile(
    style: ListTileStyle.list,
    isThreeLine: true,
    leading: Icon(Icons.email, color: Colors.blue),
    title: Text('Meeting Tomorrow'),
    subtitle: Text(
      'Hi team, just a reminder about our meeting scheduled for tomorrow at 10 AM.',
    ),
  );
  final drawerStyleThreeLine = ListTile(
    style: ListTileStyle.drawer,
    isThreeLine: true,
    leading: Icon(Icons.email, color: Colors.purple),
    title: Text('Meeting Tomorrow'),
    subtitle: Text(
      'Hi team, just a reminder about our meeting scheduled for tomorrow at 10 AM.',
    ),
  );
  print('Created three-line comparison');

  allDemos.add(
    buildStyleComparisonCard(
      title: 'Three-Line Layout',
      description: 'Extended content with isThreeLine: true',
      listStyleTile: listStyleThreeLine,
      drawerStyleTile: drawerStyleThreeLine,
    ),
  );

  // =========================================================================
  // SECTION 2: ListTileStyle.list in Typical List Contexts
  // =========================================================================
  print('--- Section 2: ListTileStyle.list in Typical Contexts ---');

  allDemos.add(
    buildSectionHeader(
      'Section 2: ListTileStyle.list Use Cases',
      icon: Icons.list,
      color: Colors.blue,
    ),
  );

  allDemos.add(
    buildExplanationCard(
      'ListTileStyle.list is the default style optimized for scrollable list content. '
      'It provides comfortable spacing for touch targets while maintaining a clean, '
      'scannable layout. Ideal for settings screens, contact lists, and message lists.',
      icon: Icons.touch_app,
      color: Colors.blue,
    ),
  );

  // Settings list demonstration
  allDemos.add(buildSubsectionHeader('Settings Screen Pattern', color: Colors.blue));

  List<Widget> settingsTiles = [];
  int settingsIndex = 0;
  for (settingsIndex = 0;
      settingsIndex < sampleSettingsItems.length;
      settingsIndex++) {
    final item = sampleSettingsItems[settingsIndex];
    settingsTiles.add(
      ListTile(
        style: ListTileStyle.list,
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(item.icon, color: Colors.blue.shade700, size: 22),
        ),
        title: Text(
          item.title,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: item.subtitle != null ? Text(item.subtitle!) : null,
        trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
      ),
    );
    if (settingsIndex < sampleSettingsItems.length - 1) {
      settingsTiles.add(
        Divider(height: 1, indent: 72, color: Colors.grey.shade200),
      );
    }
  }
  print('Created ${sampleSettingsItems.length} settings list tiles');

  allDemos.add(buildMockSettingsList(children: settingsTiles));

  // Contact list demonstration
  allDemos.add(buildSubsectionHeader('Contact List Pattern', color: Colors.blue));

  List<String> contactNames = [
    'Alice Anderson',
    'Bob Baker',
    'Carol Chen',
    'David Davis',
    'Eva Edwards',
  ];
  List<MaterialColor> avatarColors = [
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.blue,
    Colors.purple,
  ];

  List<Widget> contactTiles = [];
  int contactIndex = 0;
  for (contactIndex = 0; contactIndex < contactNames.length; contactIndex++) {
    contactTiles.add(
      ListTile(
        style: ListTileStyle.list,
        leading: CircleAvatar(
          backgroundColor: avatarColors[contactIndex].shade100,
          child: Text(
            contactNames[contactIndex].substring(0, 1),
            style: TextStyle(
              color: avatarColors[contactIndex].shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(contactNames[contactIndex]),
        subtitle: Text('+1 (555) ${100 + contactIndex}-${1000 + contactIndex}'),
        trailing: IconButton(
          icon: Icon(Icons.phone, color: Colors.green),
          onPressed: () {},
        ),
      ),
    );
    if (contactIndex < contactNames.length - 1) {
      contactTiles.add(
        Divider(height: 1, indent: 72, color: Colors.grey.shade200),
      );
    }
  }
  print('Created ${contactNames.length} contact list tiles');

  allDemos.add(buildMockSettingsList(children: contactTiles));

  // Message list demonstration
  allDemos.add(buildSubsectionHeader('Message List Pattern', color: Colors.blue));

  List<Map<String, String>> messages = [
    {
      'sender': 'Team Chat',
      'preview': 'Sarah: Great work on the presentation!',
      'time': '2:30 PM',
    },
    {
      'sender': 'Project Alpha',
      'preview': 'Deadline reminder: Submit by Friday',
      'time': '1:15 PM',
    },
    {
      'sender': 'Support',
      'preview': 'Your ticket #1234 has been resolved',
      'time': '11:00 AM',
    },
    {
      'sender': 'Newsletter',
      'preview': 'Your weekly digest is here!',
      'time': 'Yesterday',
    },
  ];

  List<Widget> messageTiles = [];
  int msgIndex = 0;
  for (msgIndex = 0; msgIndex < messages.length; msgIndex++) {
    final msg = messages[msgIndex];
    messageTiles.add(
      ListTile(
        style: ListTileStyle.list,
        leading: CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          child: Icon(Icons.group, color: Colors.grey.shade600),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                msg['sender']!,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              msg['time']!,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
            ),
          ],
        ),
        subtitle: Text(
          msg['preview']!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
    if (msgIndex < messages.length - 1) {
      messageTiles.add(
        Divider(height: 1, indent: 72, color: Colors.grey.shade200),
      );
    }
  }
  print('Created ${messages.length} message list tiles');

  allDemos.add(buildMockSettingsList(children: messageTiles));

  // =========================================================================
  // SECTION 3: ListTileStyle.drawer in Navigation Drawer Contexts
  // =========================================================================
  print('--- Section 3: ListTileStyle.drawer in Drawer Contexts ---');

  allDemos.add(
    buildSectionHeader(
      'Section 3: ListTileStyle.drawer Use Cases',
      icon: Icons.menu,
      color: Colors.purple,
    ),
  );

  allDemos.add(
    buildExplanationCard(
      'ListTileStyle.drawer is specifically designed for navigation drawers. '
      'It features slightly altered density and styling to match Material Design '
      'drawer specifications. Navigation items should feel distinct from list content.',
      icon: Icons.navigation,
      color: Colors.purple,
    ),
  );

  // Standard navigation drawer
  allDemos.add(
    buildSubsectionHeader('Standard Navigation Drawer', color: Colors.purple),
  );

  List<Widget> drawerNavTiles = [];
  int navIndex = 0;
  for (navIndex = 0; navIndex < sampleDrawerItems.length; navIndex++) {
    final item = sampleDrawerItems[navIndex];
    drawerNavTiles.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: ListTile(
          style: ListTileStyle.drawer,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          selected: item.selected,
          selectedTileColor: Colors.indigo.shade50,
          selectedColor: Colors.indigo,
          leading: Icon(item.icon),
          title: Text(item.title),
        ),
      ),
    );
  }
  drawerNavTiles.add(Divider(indent: 16, endIndent: 16));
  drawerNavTiles.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: ListTile(
        style: ListTileStyle.drawer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        leading: Icon(Icons.logout),
        title: Text('Logout'),
      ),
    ),
  );
  print('Created ${sampleDrawerItems.length + 1} drawer nav tiles');

  allDemos.add(
    buildMockDrawer(
      title: 'Standard Navigation',
      headerColor: Colors.indigo,
      children: drawerNavTiles,
    ),
  );

  // Drawer with badges
  allDemos.add(
    buildSubsectionHeader('Drawer with Notification Badges', color: Colors.purple),
  );

  List<Widget> badgedDrawerTiles = [];
  List<String> badgedLabels = ['Inbox', 'Drafts', 'Sent', 'Spam', 'Trash'];
  List<IconData> badgedIcons = [
    Icons.inbox,
    Icons.drafts,
    Icons.send,
    Icons.report,
    Icons.delete,
  ];
  List<int?> badgeCounts = [12, 3, null, 5, null];

  int badgeIndex = 0;
  for (badgeIndex = 0; badgeIndex < badgedLabels.length; badgeIndex++) {
    Widget? trailingWidget;
    if (badgeCounts[badgeIndex] != null) {
      trailingWidget = Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: badgeIndex == 0 ? Colors.red : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          '${badgeCounts[badgeIndex]}',
          style: TextStyle(
            color: badgeIndex == 0 ? Colors.white : Colors.grey.shade700,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    badgedDrawerTiles.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: ListTile(
          style: ListTileStyle.drawer,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          selected: badgeIndex == 0,
          selectedTileColor: Colors.deepPurple.shade50,
          selectedColor: Colors.deepPurple,
          leading: Icon(badgedIcons[badgeIndex]),
          title: Text(badgedLabels[badgeIndex]),
          trailing: trailingWidget,
        ),
      ),
    );
  }
  print('Created ${badgedLabels.length} badged drawer tiles');

  allDemos.add(
    buildMockDrawer(
      title: 'Email Navigation',
      headerColor: Colors.deepPurple,
      children: badgedDrawerTiles,
    ),
  );

  // Sectioned drawer
  allDemos.add(
    buildSubsectionHeader('Sectioned Navigation Drawer', color: Colors.purple),
  );

  List<Widget> sectionedDrawerTiles = [];

  // Section: Workspace
  sectionedDrawerTiles.add(
    Padding(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Text(
        'WORKSPACE',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade500,
          letterSpacing: 1.2,
        ),
      ),
    ),
  );

  List<String> workspaceLabels = ['Dashboard', 'Projects', 'Tasks', 'Team'];
  List<IconData> workspaceIcons = [
    Icons.dashboard,
    Icons.folder,
    Icons.check_circle,
    Icons.people,
  ];
  int wsIndex = 0;
  for (wsIndex = 0; wsIndex < workspaceLabels.length; wsIndex++) {
    sectionedDrawerTiles.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
        child: ListTile(
          style: ListTileStyle.drawer,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          selected: wsIndex == 0,
          selectedTileColor: Colors.teal.shade50,
          selectedColor: Colors.teal.shade700,
          leading: Icon(workspaceIcons[wsIndex], size: 22),
          title: Text(workspaceLabels[wsIndex]),
          dense: true,
        ),
      ),
    );
  }

  sectionedDrawerTiles.add(Divider(indent: 16, endIndent: 16, height: 16));

  // Section: Personal
  sectionedDrawerTiles.add(
    Padding(
      padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: Text(
        'PERSONAL',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade500,
          letterSpacing: 1.2,
        ),
      ),
    ),
  );

  List<String> personalLabels = ['Calendar', 'Notes', 'Reminders'];
  List<IconData> personalIcons = [
    Icons.calendar_month,
    Icons.note,
    Icons.alarm,
  ];
  int pIndex = 0;
  for (pIndex = 0; pIndex < personalLabels.length; pIndex++) {
    sectionedDrawerTiles.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
        child: ListTile(
          style: ListTileStyle.drawer,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          leading: Icon(personalIcons[pIndex], size: 22),
          title: Text(personalLabels[pIndex]),
          dense: true,
        ),
      ),
    );
  }
  print('Created sectioned drawer with workspace and personal sections');

  allDemos.add(
    buildMockDrawer(
      title: 'Productivity App',
      headerColor: Colors.teal,
      children: sectionedDrawerTiles,
    ),
  );

  // =========================================================================
  // SECTION 4: Style Differences in Density, Padding, and Visual Weight
  // =========================================================================
  print('--- Section 4: Style Differences Analysis ---');

  allDemos.add(
    buildSectionHeader(
      'Section 4: Density, Padding & Visual Weight',
      icon: Icons.straighten,
      color: Colors.green,
    ),
  );

  allDemos.add(
    buildExplanationCard(
      'The visual differences between list and drawer styles are subtle but intentional. '
      'Drawer style tiles typically have optimized spacing for navigation contexts, '
      'while list style tiles are designed for content browsing and selection.',
      icon: Icons.visibility,
      color: Colors.green,
    ),
  );

  // Dense mode comparison
  allDemos.add(buildSubsectionHeader('Dense Mode Interaction', color: Colors.green));

  final listDense = ListTile(
    style: ListTileStyle.list,
    dense: true,
    leading: Icon(Icons.settings, color: Colors.blue),
    title: Text('Dense List Style'),
    subtitle: Text('With dense: true'),
  );
  final drawerDense = ListTile(
    style: ListTileStyle.drawer,
    dense: true,
    leading: Icon(Icons.settings, color: Colors.purple),
    title: Text('Dense Drawer Style'),
    subtitle: Text('With dense: true'),
  );
  print('Created dense mode comparison');

  allDemos.add(
    buildStyleComparisonCard(
      title: 'Dense Mode (dense: true)',
      description: 'How each style responds to the dense property',
      listStyleTile: listDense,
      drawerStyleTile: drawerDense,
    ),
  );

  // VisualDensity comparison
  allDemos.add(
    buildSubsectionHeader('Visual Density Variations', color: Colors.green),
  );

  final listCompact = ListTile(
    style: ListTileStyle.list,
    visualDensity: VisualDensity.compact,
    leading: Icon(Icons.compress, color: Colors.blue),
    title: Text('Compact Density'),
  );
  final drawerCompact = ListTile(
    style: ListTileStyle.drawer,
    visualDensity: VisualDensity.compact,
    leading: Icon(Icons.compress, color: Colors.purple),
    title: Text('Compact Density'),
  );

  allDemos.add(
    buildStyleComparisonCard(
      title: 'VisualDensity.compact',
      description: 'Minimum vertical spacing',
      listStyleTile: listCompact,
      drawerStyleTile: drawerCompact,
    ),
  );

  final listComfortable = ListTile(
    style: ListTileStyle.list,
    visualDensity: VisualDensity.comfortable,
    leading: Icon(Icons.unfold_more, color: Colors.blue),
    title: Text('Comfortable Density'),
  );
  final drawerComfortable = ListTile(
    style: ListTileStyle.drawer,
    visualDensity: VisualDensity.comfortable,
    leading: Icon(Icons.unfold_more, color: Colors.purple),
    title: Text('Comfortable Density'),
  );

  allDemos.add(
    buildStyleComparisonCard(
      title: 'VisualDensity.comfortable',
      description: 'Maximum vertical spacing',
      listStyleTile: listComfortable,
      drawerStyleTile: drawerComfortable,
    ),
  );
  print('Created visual density comparisons');

  // Content padding comparison
  allDemos.add(buildSubsectionHeader('Content Padding Override', color: Colors.green));

  final listPadded = ListTile(
    style: ListTileStyle.list,
    contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    leading: Icon(Icons.padding, color: Colors.blue),
    title: Text('Custom Padding'),
    subtitle: Text('24px horizontal, 8px vertical'),
  );
  final drawerPadded = ListTile(
    style: ListTileStyle.drawer,
    contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    leading: Icon(Icons.padding, color: Colors.purple),
    title: Text('Custom Padding'),
    subtitle: Text('24px horizontal, 8px vertical'),
  );

  allDemos.add(
    buildStyleComparisonCard(
      title: 'Custom Content Padding',
      description: 'Explicit padding overrides default style padding',
      listStyleTile: listPadded,
      drawerStyleTile: drawerPadded,
    ),
  );
  print('Created content padding comparison');

  // Min leading width comparison
  allDemos.add(buildSubsectionHeader('Leading Width Control', color: Colors.green));

  final listMinLeading = ListTile(
    style: ListTileStyle.list,
    minLeadingWidth: 56,
    leading: Icon(Icons.star, color: Colors.blue),
    title: Text('Min Leading Width: 56'),
  );
  final drawerMinLeading = ListTile(
    style: ListTileStyle.drawer,
    minLeadingWidth: 56,
    leading: Icon(Icons.star, color: Colors.purple),
    title: Text('Min Leading Width: 56'),
  );

  allDemos.add(
    buildStyleComparisonCard(
      title: 'Min Leading Width',
      description: 'Ensuring consistent icon alignment',
      listStyleTile: listMinLeading,
      drawerStyleTile: drawerMinLeading,
    ),
  );
  print('Created min leading width comparison');

  // =========================================================================
  // SECTION 5: ListTileTheme Integration
  // =========================================================================
  print('--- Section 5: ListTileTheme Integration ---');

  allDemos.add(
    buildSectionHeader(
      'Section 5: ListTileTheme Integration',
      icon: Icons.palette,
      color: Colors.orange,
    ),
  );

  allDemos.add(
    buildExplanationCard(
      'ListTileTheme allows you to set the default style for all ListTile descendants. '
      'Setting ListTileThemeData(style: ListTileStyle.drawer) applies drawer styling '
      'to all children without needing to specify it on each tile individually.',
      icon: Icons.format_paint,
      color: Colors.orange,
    ),
  );

  // Theme with list style
  allDemos.add(
    buildSubsectionHeader('ListTileTheme with ListTileStyle.list', color: Colors.orange),
  );

  Widget listThemedSection = ListTileTheme(
    data: ListTileThemeData(
      style: ListTileStyle.list,
      tileColor: Colors.blue.shade50,
      selectedTileColor: Colors.blue.shade100,
      iconColor: Colors.blue.shade700,
      textColor: Colors.blue.shade900,
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.inbox),
              title: Text('Themed Inbox'),
              trailing: Text('5', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Divider(height: 1),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Themed Starred'),
            ),
            Divider(height: 1),
            ListTile(
              leading: Icon(Icons.send),
              title: Text('Themed Sent'),
            ),
          ],
        ),
      ),
    ),
  );
  print('Created list-themed section');

  allDemos.add(listThemedSection);
  allDemos.add(SizedBox(height: 12));

  // Theme with drawer style
  allDemos.add(
    buildSubsectionHeader(
      'ListTileTheme with ListTileStyle.drawer',
      color: Colors.orange,
    ),
  );

  Widget drawerThemedSection = ListTileTheme(
    data: ListTileThemeData(
      style: ListTileStyle.drawer,
      tileColor: Colors.purple.shade50,
      selectedTileColor: Colors.purple.shade100,
      iconColor: Colors.purple.shade700,
      textColor: Colors.purple.shade900,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    child: Container(
      width: 280,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple.shade200),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Themed Home'),
            selected: true,
          ),
          ListTile(
            leading: Icon(Icons.explore),
            title: Text('Themed Explore'),
          ),
          ListTile(
            leading: Icon(Icons.subscriptions),
            title: Text('Themed Subscriptions'),
          ),
        ],
      ),
    ),
  );
  print('Created drawer-themed section');

  allDemos.add(drawerThemedSection);

  // Theme with selection state
  allDemos.add(
    buildSubsectionHeader('Theme Selection State Styling', color: Colors.orange),
  );

  Widget selectionThemedSection = ListTileTheme(
    data: ListTileThemeData(
      style: ListTileStyle.drawer,
      selectedColor: Colors.green.shade800,
      selectedTileColor: Colors.green.shade100,
      iconColor: Colors.grey.shade600,
      textColor: Colors.grey.shade800,
    ),
    child: Container(
      width: 280,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.check_box),
            title: Text('Option One'),
            selected: true,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          ListTile(
            leading: Icon(Icons.check_box_outline_blank),
            title: Text('Option Two'),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          ListTile(
            leading: Icon(Icons.check_box_outline_blank),
            title: Text('Option Three'),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ],
      ),
    ),
  );
  print('Created selection-themed section');

  allDemos.add(selectionThemedSection);

  // =========================================================================
  // SECTION 6: Mixed Usage Scenarios
  // =========================================================================
  print('--- Section 6: Mixed Usage Scenarios ---');

  allDemos.add(
    buildSectionHeader(
      'Section 6: Mixed Usage Scenarios',
      icon: Icons.merge_type,
      color: Colors.red,
    ),
  );

  allDemos.add(
    buildExplanationCard(
      'In complex applications, you may need both styles in different parts of the UI. '
      'Here we demonstrate scenarios where style switching is appropriate and how to '
      'maintain visual consistency when mixing styles.',
      icon: Icons.swap_horiz,
      color: Colors.red,
    ),
  );

  // Scaffold with drawer and list content
  allDemos.add(
    buildSubsectionHeader('App with Drawer and List Content', color: Colors.red),
  );

  Widget scaffoldDiagram = Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300, width: 2),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drawer side
          Container(
            width: 200,
            color: Colors.purple.shade50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  color: Colors.purple.shade200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DRAWER',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple.shade700,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Uses ListTileStyle.drawer',
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.purple.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  child: Column(
                    children: [
                      ListTile(
                        style: ListTileStyle.drawer,
                        dense: true,
                        selected: true,
                        selectedTileColor: Colors.purple.shade100,
                        leading: Icon(Icons.home, size: 20, color: Colors.purple),
                        title: Text('Home', style: TextStyle(fontSize: 13)),
                      ),
                      ListTile(
                        style: ListTileStyle.drawer,
                        dense: true,
                        leading: Icon(Icons.person, size: 20),
                        title: Text('Profile', style: TextStyle(fontSize: 13)),
                      ),
                      ListTile(
                        style: ListTileStyle.drawer,
                        dense: true,
                        leading: Icon(Icons.settings, size: 20),
                        title: Text('Settings', style: TextStyle(fontSize: 13)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Divider
          Container(width: 1, height: 250, color: Colors.grey.shade300),
          // Main content side
          Expanded(
            child: Container(
              color: Colors.blue.shade50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    color: Colors.blue.shade200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MAIN CONTENT',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Uses ListTileStyle.list',
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.blue.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    style: ListTileStyle.list,
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.blue.shade100,
                      child: Text('A', style: TextStyle(fontSize: 12)),
                    ),
                    title: Text('Item One', style: TextStyle(fontSize: 13)),
                    subtitle: Text(
                      'Description text',
                      style: TextStyle(fontSize: 11),
                    ),
                    trailing: Icon(Icons.chevron_right, size: 20),
                  ),
                  Divider(height: 1),
                  ListTile(
                    style: ListTileStyle.list,
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.blue.shade100,
                      child: Text('B', style: TextStyle(fontSize: 12)),
                    ),
                    title: Text('Item Two', style: TextStyle(fontSize: 13)),
                    subtitle: Text(
                      'More description',
                      style: TextStyle(fontSize: 11),
                    ),
                    trailing: Icon(Icons.chevron_right, size: 20),
                  ),
                  Divider(height: 1),
                  ListTile(
                    style: ListTileStyle.list,
                    leading: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.blue.shade100,
                      child: Text('C', style: TextStyle(fontSize: 12)),
                    ),
                    title: Text('Item Three', style: TextStyle(fontSize: 13)),
                    subtitle: Text(
                      'Additional info',
                      style: TextStyle(fontSize: 11),
                    ),
                    trailing: Icon(Icons.chevron_right, size: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
  print('Created scaffold diagram with mixed styles');

  allDemos.add(scaffoldDiagram);

  // Style switching based on context
  allDemos.add(buildSubsectionHeader('Context-Based Style Selection', color: Colors.red));

  // Build a demonstration of programmatic style selection
  // The following variables demonstrate how you might select style programmatically:
  // ignore: unused_local_variable
  final ListTileStyle selectedStyleExample = ListTileStyle.list;
  // ignore: unused_local_variable
  final bool isDrawerContextExample = false;

  Widget contextDemo = Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Programmatic Style Selection',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '''// Select style based on context
ListTileStyle getStyleForContext(bool isDrawer) {
  return isDrawer 
    ? ListTileStyle.drawer 
    : ListTileStyle.list;
}

// Usage in build method
ListTile(
  style: getStyleForContext(isInDrawer),
  leading: Icon(Icons.home),
  title: Text('Adaptive Tile'),
)''',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'isInDrawer: false',
                    style: TextStyle(fontSize: 11, color: Colors.blue),
                  ),
                  SizedBox(height: 4),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue.shade200),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      style: ListTileStyle.list,
                      dense: true,
                      leading: Icon(Icons.home, color: Colors.blue),
                      title: Text('Adaptive', style: TextStyle(fontSize: 13)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'isInDrawer: true',
                    style: TextStyle(fontSize: 11, color: Colors.purple),
                  ),
                  SizedBox(height: 4),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple.shade200),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      style: ListTileStyle.drawer,
                      dense: true,
                      leading: Icon(Icons.home, color: Colors.purple),
                      title: Text('Adaptive', style: TextStyle(fontSize: 13)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
  print('Created context-based style selection demo');

  allDemos.add(contextDemo);

  // Transitioning between styles
  allDemos.add(
    buildSubsectionHeader('Maintaining Consistency Across Styles', color: Colors.red),
  );

  allDemos.add(
    buildExplanationCard(
      'When using both styles in an app, maintain visual consistency through shared '
      'theme values. Use ListTileTheme at different tree levels to apply appropriate '
      'styling without repeating configuration on every tile.',
      icon: Icons.sync,
      color: Colors.red,
    ),
  );

  Widget consistencyDemo = Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Shared Design Tokens',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Drawer Navigation',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          style: ListTileStyle.drawer,
                          dense: true,
                          selected: true,
                          selectedTileColor: Colors.teal.shade100,
                          selectedColor: Colors.teal.shade800,
                          leading: Icon(Icons.dashboard, size: 20),
                          title: Text('Dashboard', style: TextStyle(fontSize: 13)),
                        ),
                        ListTile(
                          style: ListTileStyle.drawer,
                          dense: true,
                          leading: Icon(
                            Icons.analytics,
                            size: 20,
                            color: Colors.teal,
                          ),
                          title: Text('Analytics', style: TextStyle(fontSize: 13)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Content List',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.teal.shade200),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          style: ListTileStyle.list,
                          dense: true,
                          leading: CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.teal.shade100,
                            child: Icon(
                              Icons.insert_chart,
                              size: 14,
                              color: Colors.teal,
                            ),
                          ),
                          title: Text('Q1 Report', style: TextStyle(fontSize: 13)),
                          trailing: Icon(
                            Icons.chevron_right,
                            size: 18,
                            color: Colors.teal,
                          ),
                        ),
                        Divider(height: 1, indent: 56),
                        ListTile(
                          style: ListTileStyle.list,
                          dense: true,
                          leading: CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.teal.shade100,
                            child: Icon(
                              Icons.insert_chart,
                              size: 14,
                              color: Colors.teal,
                            ),
                          ),
                          title: Text('Q2 Report', style: TextStyle(fontSize: 13)),
                          trailing: Icon(
                            Icons.chevron_right,
                            size: 18,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'Both use the same teal color palette for visual cohesion',
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
  print('Created consistency maintenance demo');

  allDemos.add(consistencyDemo);

  // =========================================================================
  // SECTION 7: Platform Considerations and Material Design Guidelines
  // =========================================================================
  print('--- Section 7: Platform & Material Design Guidelines ---');

  allDemos.add(
    buildSectionHeader(
      'Section 7: Platform & Material Design',
      icon: Icons.design_services,
      color: Colors.cyan,
    ),
  );

  allDemos.add(
    buildExplanationCard(
      'Material Design provides specific guidance for list and drawer components. '
      'ListTileStyle.drawer aligns with Material navigation drawer specifications, '
      'featuring optimized touch targets and visual hierarchy for navigation contexts.',
      icon: Icons.menu_book,
      color: Colors.cyan,
    ),
  );

  // Material Design guidelines summary
  allDemos.add(
    buildSubsectionHeader('Material Design Recommendations', color: Colors.cyan),
  );

  Widget guidelinesCard = Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.cyan.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 20),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Use ListTileStyle.list for:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.only(left: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('• Scrollable content lists', style: TextStyle(fontSize: 12)),
              Text('• Settings screens', style: TextStyle(fontSize: 12)),
              Text('• Contact and message lists', style: TextStyle(fontSize: 12)),
              Text('• Search results', style: TextStyle(fontSize: 12)),
              Text('• Data tables and grids', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Icon(Icons.check_circle, color: Colors.purple, size: 20),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Use ListTileStyle.drawer for:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.only(left: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '• Navigation drawer destinations',
                style: TextStyle(fontSize: 12),
              ),
              Text('• Bottom sheet navigation', style: TextStyle(fontSize: 12)),
              Text('• App menu structures', style: TextStyle(fontSize: 12)),
              Text(
                '• Modal navigation selections',
                style: TextStyle(fontSize: 12),
              ),
              Text(
                '• Primary navigation patterns',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created guidelines card');

  allDemos.add(guidelinesCard);

  // Touch target considerations
  allDemos.add(buildSubsectionHeader('Touch Target Considerations', color: Colors.cyan));

  Widget touchTargetDemo = Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Minimum Touch Target: 48x48 dp',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Both ListTileStyle values ensure adequate touch targets per Material '
          'Design accessibility guidelines. The visual differences are primarily '
          'in padding and visual weight, not in interactivity.',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  border: Border.all(color: Colors.blue.shade300),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    '48dp min height',
                    style: TextStyle(fontSize: 11, color: Colors.blue.shade700),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                border: Border.all(color: Colors.green.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  '48',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
  print('Created touch target demo');

  allDemos.add(touchTargetDemo);

  // Responsive considerations
  allDemos.add(buildSubsectionHeader('Responsive Layout Patterns', color: Colors.cyan));

  Widget responsiveDemo = Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Responsive Navigation Patterns',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        // Mobile pattern
        Container(
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.phone_android, color: Colors.grey.shade600, size: 24),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mobile (< 600dp)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Modal drawer with ListTileStyle.drawer',
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Tablet pattern
        Container(
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.tablet_android, color: Colors.grey.shade600, size: 24),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tablet (600-840dp)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Rail or mini drawer with ListTileStyle.drawer',
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Desktop pattern
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                Icons.desktop_windows,
                color: Colors.grey.shade600,
                size: 24,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Desktop (> 840dp)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Persistent drawer with ListTileStyle.drawer',
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created responsive layout demo');

  allDemos.add(responsiveDemo);

  // Accessibility considerations
  allDemos.add(buildSubsectionHeader('Accessibility Considerations', color: Colors.cyan));

  Widget accessibilityDemo = Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.cyan.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.accessibility_new, color: Colors.cyan, size: 24),
            SizedBox(width: 8),
            Text(
              'Accessibility Best Practices',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        buildInfoCard(
          'Semantic Labels',
          'Use semanticLabel for screen readers',
          icon: Icons.record_voice_over,
        ),
        buildInfoCard(
          'Focus Traversal',
          'Ensure logical tab order',
          icon: Icons.keyboard_tab,
        ),
        buildInfoCard(
          'Color Contrast',
          'Maintain 4.5:1 ratio for text',
          icon: Icons.contrast,
        ),
        buildInfoCard(
          'Selected State',
          'Provide clear visual indication',
          icon: Icons.check_box,
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.cyan.shade50,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'Both ListTileStyle values support the same accessibility features. '
            'The style choice is primarily visual and doesn\'t affect accessibility behavior.',
            style: TextStyle(fontSize: 11, color: Colors.cyan.shade800),
          ),
        ),
      ],
    ),
  );
  print('Created accessibility demo');

  allDemos.add(accessibilityDemo);

  // =========================================================================
  // SECTION 8: Edge Cases and Special Scenarios
  // =========================================================================
  print('--- Section 8: Edge Cases and Special Scenarios ---');

  allDemos.add(
    buildSectionHeader(
      'Section 8: Edge Cases & Special Scenarios',
      icon: Icons.warning_amber,
      color: Colors.amber,
    ),
  );

  // Long text handling
  allDemos.add(buildSubsectionHeader('Long Text Overflow', color: Colors.amber));

  final listLongText = ListTile(
    style: ListTileStyle.list,
    leading: Icon(Icons.description, color: Colors.blue),
    title: Text(
      'This is a very long title that might overflow the available space',
      overflow: TextOverflow.ellipsis,
    ),
    subtitle: Text(
      'And this is an even longer subtitle text that demonstrates text wrapping behavior',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ),
  );
  final drawerLongText = ListTile(
    style: ListTileStyle.drawer,
    leading: Icon(Icons.description, color: Colors.purple),
    title: Text(
      'This is a very long title that might overflow the available space',
      overflow: TextOverflow.ellipsis,
    ),
    subtitle: Text(
      'And this is an even longer subtitle text that demonstrates text wrapping behavior',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ),
  );
  print('Created long text handling demo');

  allDemos.add(
    buildStyleComparisonCard(
      title: 'Long Text Handling',
      description: 'How text overflow behaves in each style',
      listStyleTile: listLongText,
      drawerStyleTile: drawerLongText,
    ),
  );

  // Disabled state
  allDemos.add(buildSubsectionHeader('Disabled State', color: Colors.amber));

  final listDisabled = ListTile(
    style: ListTileStyle.list,
    enabled: false,
    leading: Icon(Icons.block),
    title: Text('Disabled List Item'),
    subtitle: Text('Cannot be interacted with'),
    trailing: Switch(value: false, onChanged: null),
  );
  final drawerDisabled = ListTile(
    style: ListTileStyle.drawer,
    enabled: false,
    leading: Icon(Icons.block),
    title: Text('Disabled Drawer Item'),
    subtitle: Text('Cannot be interacted with'),
    trailing: Switch(value: false, onChanged: null),
  );
  print('Created disabled state demo');

  allDemos.add(
    buildStyleComparisonCard(
      title: 'Disabled State (enabled: false)',
      description: 'Visual treatment when tile is disabled',
      listStyleTile: listDisabled,
      drawerStyleTile: drawerDisabled,
    ),
  );

  // Rich leading widgets
  allDemos.add(buildSubsectionHeader('Rich Leading Widgets', color: Colors.amber));

  final listRichLeading = ListTile(
    style: ListTileStyle.list,
    leading: Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(Icons.image, color: Colors.white),
    ),
    title: Text('Rich Media'),
    subtitle: Text('With gradient container'),
  );
  final drawerRichLeading = ListTile(
    style: ListTileStyle.drawer,
    leading: Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple, Colors.pink],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(Icons.image, color: Colors.white),
    ),
    title: Text('Rich Media'),
    subtitle: Text('With gradient container'),
  );
  print('Created rich leading widget demo');

  allDemos.add(
    buildStyleComparisonCard(
      title: 'Rich Leading Widget',
      description: 'Complex leading widget alignment',
      listStyleTile: listRichLeading,
      drawerStyleTile: drawerRichLeading,
    ),
  );

  // Complex trailing widgets
  allDemos.add(buildSubsectionHeader('Complex Trailing Widgets', color: Colors.amber));

  final listComplexTrailing = ListTile(
    style: ListTileStyle.list,
    leading: Icon(Icons.timer, color: Colors.blue),
    title: Text('Task Progress'),
    subtitle: Text('75% complete'),
    trailing: SizedBox(
      width: 80,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: LinearProgressIndicator(
              value: 0.75,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            ),
          ),
          SizedBox(width: 8),
          Text('75%', style: TextStyle(fontSize: 11)),
        ],
      ),
    ),
  );
  final drawerComplexTrailing = ListTile(
    style: ListTileStyle.drawer,
    leading: Icon(Icons.timer, color: Colors.purple),
    title: Text('Task Progress'),
    subtitle: Text('75% complete'),
    trailing: SizedBox(
      width: 80,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: LinearProgressIndicator(
              value: 0.75,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation(Colors.purple),
            ),
          ),
          SizedBox(width: 8),
          Text('75%', style: TextStyle(fontSize: 11)),
        ],
      ),
    ),
  );
  print('Created complex trailing widget demo');

  allDemos.add(
    buildStyleComparisonCard(
      title: 'Complex Trailing Widget',
      description: 'Progress indicator in trailing position',
      listStyleTile: listComplexTrailing,
      drawerStyleTile: drawerComplexTrailing,
    ),
  );

  // No leading widget
  allDemos.add(buildSubsectionHeader('Without Leading Widget', color: Colors.amber));

  final listNoLeading = ListTile(
    style: ListTileStyle.list,
    title: Text('No Leading Icon'),
    subtitle: Text('Sometimes you just need text'),
    trailing: Icon(Icons.chevron_right),
  );
  final drawerNoLeading = ListTile(
    style: ListTileStyle.drawer,
    title: Text('No Leading Icon'),
    subtitle: Text('Sometimes you just need text'),
    trailing: Icon(Icons.chevron_right),
  );
  print('Created no leading widget demo');

  allDemos.add(
    buildStyleComparisonCard(
      title: 'No Leading Widget',
      description: 'Content alignment without leading',
      listStyleTile: listNoLeading,
      drawerStyleTile: drawerNoLeading,
    ),
  );

  // Custom shape
  allDemos.add(buildSubsectionHeader('Custom Shapes', color: Colors.amber));

  final listCustomShape = ListTile(
    style: ListTileStyle.list,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: Colors.blue.shade200, width: 2),
    ),
    tileColor: Colors.blue.shade50,
    leading: Icon(Icons.rounded_corner, color: Colors.blue),
    title: Text('Rounded List Tile'),
  );
  final drawerCustomShape = ListTile(
    style: ListTileStyle.drawer,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: Colors.purple.shade200, width: 2),
    ),
    tileColor: Colors.purple.shade50,
    leading: Icon(Icons.rounded_corner, color: Colors.purple),
    title: Text('Rounded Drawer Tile'),
  );
  print('Created custom shape demo');

  allDemos.add(
    buildStyleComparisonCard(
      title: 'Custom Shape',
      description: 'RoundedRectangleBorder with border',
      listStyleTile: listCustomShape,
      drawerStyleTile: drawerCustomShape,
    ),
  );

  // =========================================================================
  // SECTION 9: Summary and Enum Values Reference
  // =========================================================================
  print('--- Section 9: Summary and Reference ---');

  allDemos.add(
    buildSectionHeader(
      'Section 9: ListTileStyle Summary',
      icon: Icons.summarize,
      color: Colors.deepOrange,
    ),
  );

  Widget summaryCard = Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepOrange.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.deepOrange.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ListTileStyle Enum Reference',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange.shade800,
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'ListTileStyle.list',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text('(default)', style: TextStyle(fontSize: 11)),
                ],
              ),
              SizedBox(height: 6),
              Text(
                'Standard list item styling for content lists, settings, and general-purpose scrollable content.',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
              SizedBox(height: 12),
              Divider(height: 1),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'ListTileStyle.drawer',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple.shade800,
                  ),
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Optimized styling for navigation drawer destinations, with adjusted density and visual weight for navigation contexts.',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Key Takeaways:',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.deepOrange.shade700,
          ),
        ),
        SizedBox(height: 8),
        _buildTakeawayItem('✓ Use list style for scrollable content'),
        _buildTakeawayItem('✓ Use drawer style for navigation'),
        _buildTakeawayItem('✓ Apply via ListTile.style or ListTileTheme'),
        _buildTakeawayItem('✓ Both maintain proper touch targets'),
        _buildTakeawayItem('✓ Style is purely visual, same accessibility'),
      ],
    ),
  );
  print('Created summary card');

  allDemos.add(summaryCard);

  // Final spacing
  allDemos.add(SizedBox(height: 32));

  print('========================================');
  print('ListTileStyle comprehensive demo completed');
  print('Total sections: 9');
  print('Total demo widgets: ${allDemos.length}');
  print('========================================');

  // Return the complete demo UI
  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: allDemos,
    ),
  );
}

/// Helper widget for takeaway list items
Widget _buildTakeawayItem(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Text(
      text,
      style: TextStyle(fontSize: 12, color: Colors.grey.shade800),
    ),
  );
}

// =============================================================================
// TEST SECTION: Unit Tests Using testWidgets
// =============================================================================

void main() {
  // Group 1: Basic ListTileStyle Enum Verification
  group('ListTileStyle Enum Values', () {
    testWidgets('ListTileStyle.list exists and is usable', (
      WidgetTester tester,
    ) async {
      // Arrange: Create a ListTile with list style
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListTile(
              style: ListTileStyle.list,
              title: Text('List Style Tile'),
            ),
          ),
        ),
      );

      // Assert: Tile is rendered
      expect(find.text('List Style Tile'), findsOneWidget);
      print('ListTileStyle.list test passed');
    });

    testWidgets('ListTileStyle.drawer exists and is usable', (
      WidgetTester tester,
    ) async {
      // Arrange: Create a ListTile with drawer style
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListTile(
              style: ListTileStyle.drawer,
              title: Text('Drawer Style Tile'),
            ),
          ),
        ),
      );

      // Assert: Tile is rendered
      expect(find.text('Drawer Style Tile'), findsOneWidget);
      print('ListTileStyle.drawer test passed');
    });

    testWidgets('Both enum values are distinct', (WidgetTester tester) async {
      // Verify enum values are not equal
      expect(ListTileStyle.list != ListTileStyle.drawer, isTrue);
      expect(ListTileStyle.values.length, equals(2));
      print('Enum distinctness test passed');
    });
  });

  // Group 2: Side-by-Side Visual Comparison Tests
  group('Visual Comparison: List vs Drawer Style', () {
    testWidgets('Basic ListTile renders with both styles', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ListTile(
                  style: ListTileStyle.list,
                  title: Text('List Style'),
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  title: Text('Drawer Style'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('List Style'), findsOneWidget);
      expect(find.text('Drawer Style'), findsOneWidget);
      print('Side-by-side basic test passed');
    });

    testWidgets('ListTile with leading icon in both styles', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ListTile(
                  style: ListTileStyle.list,
                  leading: Icon(Icons.home),
                  title: Text('Home List'),
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  leading: Icon(Icons.home),
                  title: Text('Home Drawer'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.home), findsNWidgets(2));
      expect(find.text('Home List'), findsOneWidget);
      expect(find.text('Home Drawer'), findsOneWidget);
      print('Leading icon comparison test passed');
    });

    testWidgets('ListTile with subtitle in both styles', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ListTile(
                  style: ListTileStyle.list,
                  title: Text('Title List'),
                  subtitle: Text('Subtitle List'),
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  title: Text('Title Drawer'),
                  subtitle: Text('Subtitle Drawer'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Subtitle List'), findsOneWidget);
      expect(find.text('Subtitle Drawer'), findsOneWidget);
      print('Subtitle comparison test passed');
    });

    testWidgets('ListTile with trailing widget in both styles', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ListTile(
                  style: ListTileStyle.list,
                  title: Text('Trailing List'),
                  trailing: Icon(Icons.arrow_forward),
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  title: Text('Trailing Drawer'),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_forward), findsNWidgets(2));
      print('Trailing widget comparison test passed');
    });
  });

  // Group 3: ListTileStyle.list Specific Use Cases
  group('ListTileStyle.list Use Cases', () {
    testWidgets('Settings screen pattern with list style', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                ListTile(
                  style: ListTileStyle.list,
                  leading: Icon(Icons.person),
                  title: Text('Account'),
                  subtitle: Text('Privacy, security'),
                  trailing: Icon(Icons.chevron_right),
                ),
                ListTile(
                  style: ListTileStyle.list,
                  leading: Icon(Icons.notifications),
                  title: Text('Notifications'),
                  subtitle: Text('Message tones'),
                  trailing: Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Account'), findsOneWidget);
      expect(find.text('Notifications'), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsNWidgets(2));
      print('Settings screen pattern test passed');
    });

    testWidgets('Contact list pattern with list style', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                ListTile(
                  style: ListTileStyle.list,
                  leading: CircleAvatar(child: Text('A')),
                  title: Text('Alice Anderson'),
                  subtitle: Text('+1 555-0001'),
                ),
                ListTile(
                  style: ListTileStyle.list,
                  leading: CircleAvatar(child: Text('B')),
                  title: Text('Bob Baker'),
                  subtitle: Text('+1 555-0002'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Alice Anderson'), findsOneWidget);
      expect(find.text('Bob Baker'), findsOneWidget);
      expect(find.byType(CircleAvatar), findsNWidgets(2));
      print('Contact list pattern test passed');
    });

    testWidgets('Message list with timestamp in list style', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListTile(
              style: ListTileStyle.list,
              leading: CircleAvatar(child: Icon(Icons.group)),
              title: Row(
                children: [
                  Expanded(child: Text('Team Chat')),
                  Text('2:30 PM', style: TextStyle(fontSize: 12)),
                ],
              ),
              subtitle: Text('Great work on the project!'),
            ),
          ),
        ),
      );

      expect(find.text('Team Chat'), findsOneWidget);
      expect(find.text('2:30 PM'), findsOneWidget);
      expect(find.text('Great work on the project!'), findsOneWidget);
      print('Message list pattern test passed');
    });
  });

  // Group 4: ListTileStyle.drawer Specific Use Cases
  group('ListTileStyle.drawer Use Cases', () {
    testWidgets('Navigation drawer pattern with drawer style', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            drawer: Drawer(
              child: ListView(
                children: [
                  DrawerHeader(child: Text('App Name')),
                  ListTile(
                    style: ListTileStyle.drawer,
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    selected: true,
                  ),
                  ListTile(
                    style: ListTileStyle.drawer,
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                ],
              ),
            ),
            body: Container(),
          ),
        ),
      );

      // Open drawer
      final scaffoldState = tester.state<ScaffoldState>(find.byType(Scaffold));
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
      print('Navigation drawer pattern test passed');
    });

    testWidgets('Drawer with badge notifications', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ListTile(
                  style: ListTileStyle.drawer,
                  leading: Icon(Icons.inbox),
                  title: Text('Inbox'),
                  trailing: Badge(
                    label: Text('12'),
                    child: SizedBox.shrink(),
                  ),
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  leading: Icon(Icons.drafts),
                  title: Text('Drafts'),
                  trailing: Badge(
                    label: Text('3'),
                    child: SizedBox.shrink(),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Inbox'), findsOneWidget);
      expect(find.text('12'), findsOneWidget);
      expect(find.text('Drafts'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      print('Drawer with badges test passed');
    });

    testWidgets('Sectioned drawer with labels', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('WORKSPACE'),
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  leading: Icon(Icons.dashboard),
                  title: Text('Dashboard'),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('PERSONAL'),
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  leading: Icon(Icons.calendar_month),
                  title: Text('Calendar'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('WORKSPACE'), findsOneWidget);
      expect(find.text('Dashboard'), findsOneWidget);
      expect(find.text('PERSONAL'), findsOneWidget);
      expect(find.text('Calendar'), findsOneWidget);
      print('Sectioned drawer test passed');
    });
  });

  // Group 5: Density and Padding Tests
  group('Density, Padding, and Visual Weight', () {
    testWidgets('Dense mode with both styles', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ListTile(
                  style: ListTileStyle.list,
                  dense: true,
                  title: Text('Dense List'),
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  dense: true,
                  title: Text('Dense Drawer'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Dense List'), findsOneWidget);
      expect(find.text('Dense Drawer'), findsOneWidget);
      print('Dense mode test passed');
    });

    testWidgets('VisualDensity.compact with both styles', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ListTile(
                  style: ListTileStyle.list,
                  visualDensity: VisualDensity.compact,
                  title: Text('Compact List'),
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  visualDensity: VisualDensity.compact,
                  title: Text('Compact Drawer'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Compact List'), findsOneWidget);
      expect(find.text('Compact Drawer'), findsOneWidget);
      print('VisualDensity.compact test passed');
    });

    testWidgets('VisualDensity.comfortable with both styles', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ListTile(
                  style: ListTileStyle.list,
                  visualDensity: VisualDensity.comfortable,
                  title: Text('Comfortable List'),
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  visualDensity: VisualDensity.comfortable,
                  title: Text('Comfortable Drawer'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Comfortable List'), findsOneWidget);
      expect(find.text('Comfortable Drawer'), findsOneWidget);
      print('VisualDensity.comfortable test passed');
    });

    testWidgets('Custom contentPadding with both styles', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ListTile(
                  style: ListTileStyle.list,
                  contentPadding: EdgeInsets.all(24),
                  title: Text('Padded List'),
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  contentPadding: EdgeInsets.all(24),
                  title: Text('Padded Drawer'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Padded List'), findsOneWidget);
      expect(find.text('Padded Drawer'), findsOneWidget);
      print('Custom contentPadding test passed');
    });

    testWidgets('minLeadingWidth with both styles', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ListTile(
                  style: ListTileStyle.list,
                  minLeadingWidth: 56,
                  leading: Icon(Icons.star),
                  title: Text('MinLeading List'),
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  minLeadingWidth: 56,
                  leading: Icon(Icons.star),
                  title: Text('MinLeading Drawer'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('MinLeading List'), findsOneWidget);
      expect(find.text('MinLeading Drawer'), findsOneWidget);
      print('minLeadingWidth test passed');
    });
  });

  // Group 6: ListTileTheme Integration
  group('ListTileTheme Integration', () {
    testWidgets('ListTileTheme applies list style to children', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListTileTheme(
              data: ListTileThemeData(
                style: ListTileStyle.list,
                tileColor: Colors.blue.shade50,
              ),
              child: Column(
                children: [
                  ListTile(title: Text('Themed List 1')),
                  ListTile(title: Text('Themed List 2')),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Themed List 1'), findsOneWidget);
      expect(find.text('Themed List 2'), findsOneWidget);
      print('ListTileTheme list style test passed');
    });

    testWidgets('ListTileTheme applies drawer style to children', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListTileTheme(
              data: ListTileThemeData(
                style: ListTileStyle.drawer,
                tileColor: Colors.purple.shade50,
              ),
              child: Column(
                children: [
                  ListTile(title: Text('Themed Drawer 1')),
                  ListTile(title: Text('Themed Drawer 2')),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Themed Drawer 1'), findsOneWidget);
      expect(find.text('Themed Drawer 2'), findsOneWidget);
      print('ListTileTheme drawer style test passed');
    });

    testWidgets('ListTile style overrides theme style', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListTileTheme(
              data: ListTileThemeData(style: ListTileStyle.list),
              child: Column(
                children: [
                  ListTile(title: Text('Uses Theme')),
                  ListTile(
                    style: ListTileStyle.drawer,
                    title: Text('Overrides Theme'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Uses Theme'), findsOneWidget);
      expect(find.text('Overrides Theme'), findsOneWidget);
      print('Style override test passed');
    });

    testWidgets('Nested ListTileTheme with different styles', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListTileTheme(
              data: ListTileThemeData(style: ListTileStyle.list),
              child: Column(
                children: [
                  ListTile(title: Text('Outer List')),
                  ListTileTheme(
                    data: ListTileThemeData(style: ListTileStyle.drawer),
                    child: ListTile(title: Text('Inner Drawer')),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Outer List'), findsOneWidget);
      expect(find.text('Inner Drawer'), findsOneWidget);
      print('Nested theme test passed');
    });
  });

  // Group 7: Selection State Tests
  group('Selection State with Styles', () {
    testWidgets('Selected state with list style', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListTile(
              style: ListTileStyle.list,
              selected: true,
              selectedColor: Colors.blue,
              selectedTileColor: Colors.blue.shade50,
              leading: Icon(Icons.check),
              title: Text('Selected List'),
            ),
          ),
        ),
      );

      expect(find.text('Selected List'), findsOneWidget);
      print('Selected list style test passed');
    });

    testWidgets('Selected state with drawer style', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListTile(
              style: ListTileStyle.drawer,
              selected: true,
              selectedColor: Colors.purple,
              selectedTileColor: Colors.purple.shade50,
              leading: Icon(Icons.check),
              title: Text('Selected Drawer'),
            ),
          ),
        ),
      );

      expect(find.text('Selected Drawer'), findsOneWidget);
      print('Selected drawer style test passed');
    });

    testWidgets('Multiple selection states in list', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ListTile(
                  style: ListTileStyle.drawer,
                  selected: true,
                  title: Text('Selected'),
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  selected: false,
                  title: Text('Not Selected 1'),
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  selected: false,
                  title: Text('Not Selected 2'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Selected'), findsOneWidget);
      expect(find.text('Not Selected 1'), findsOneWidget);
      expect(find.text('Not Selected 2'), findsOneWidget);
      print('Multiple selection states test passed');
    });
  });

  // Group 8: Edge Cases
  group('Edge Cases and Special Scenarios', () {
    testWidgets('Long text with ellipsis in both styles', (
      WidgetTester tester,
    ) async {
      const longText =
          'This is a very long title that should overflow and be truncated';
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              child: Column(
                children: [
                  ListTile(
                    style: ListTileStyle.list,
                    title: Text(longText, overflow: TextOverflow.ellipsis),
                  ),
                  ListTile(
                    style: ListTileStyle.drawer,
                    title: Text(longText, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text(longText), findsNWidgets(2));
      print('Long text ellipsis test passed');
    });

    testWidgets('Disabled state with both styles', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ListTile(
                  style: ListTileStyle.list,
                  enabled: false,
                  title: Text('Disabled List'),
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  enabled: false,
                  title: Text('Disabled Drawer'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Disabled List'), findsOneWidget);
      expect(find.text('Disabled Drawer'), findsOneWidget);
      print('Disabled state test passed');
    });

    testWidgets('Three-line layout with both styles', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ListTile(
                  style: ListTileStyle.list,
                  isThreeLine: true,
                  title: Text('Three Line List'),
                  subtitle: Text('Line 2\nLine 3'),
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  isThreeLine: true,
                  title: Text('Three Line Drawer'),
                  subtitle: Text('Line 2\nLine 3'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Three Line List'), findsOneWidget);
      expect(find.text('Three Line Drawer'), findsOneWidget);
      print('Three-line layout test passed');
    });

    testWidgets('Custom shape with both styles', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ListTile(
                  style: ListTileStyle.list,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  tileColor: Colors.blue.shade50,
                  title: Text('Shaped List'),
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  tileColor: Colors.purple.shade50,
                  title: Text('Shaped Drawer'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Shaped List'), findsOneWidget);
      expect(find.text('Shaped Drawer'), findsOneWidget);
      print('Custom shape test passed');
    });

    testWidgets('Without leading widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ListTile(
                  style: ListTileStyle.list,
                  title: Text('No Leading List'),
                  trailing: Icon(Icons.chevron_right),
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  title: Text('No Leading Drawer'),
                  trailing: Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('No Leading List'), findsOneWidget);
      expect(find.text('No Leading Drawer'), findsOneWidget);
      print('Without leading widget test passed');
    });

    testWidgets('Complex trailing widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ListTile(
                  style: ListTileStyle.list,
                  title: Text('Progress List'),
                  trailing: SizedBox(
                    width: 60,
                    child: LinearProgressIndicator(value: 0.7),
                  ),
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  title: Text('Progress Drawer'),
                  trailing: SizedBox(
                    width: 60,
                    child: LinearProgressIndicator(value: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Progress List'), findsOneWidget);
      expect(find.text('Progress Drawer'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsNWidgets(2));
      print('Complex trailing widget test passed');
    });
  });

  // Group 9: Interaction Tests
  group('Interaction Behavior', () {
    testWidgets('onTap callback works with list style', (
      WidgetTester tester,
    ) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListTile(
              style: ListTileStyle.list,
              title: Text('Tap List'),
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap List'));
      expect(tapped, isTrue);
      print('onTap list style test passed');
    });

    testWidgets('onTap callback works with drawer style', (
      WidgetTester tester,
    ) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListTile(
              style: ListTileStyle.drawer,
              title: Text('Tap Drawer'),
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap Drawer'));
      expect(tapped, isTrue);
      print('onTap drawer style test passed');
    });

    testWidgets('onLongPress callback works with both styles', (
      WidgetTester tester,
    ) async {
      bool longPressedList = false;
      bool longPressedDrawer = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ListTile(
                  style: ListTileStyle.list,
                  title: Text('LongPress List'),
                  onLongPress: () {
                    longPressedList = true;
                  },
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  title: Text('LongPress Drawer'),
                  onLongPress: () {
                    longPressedDrawer = true;
                  },
                ),
              ],
            ),
          ),
        ),
      );

      await tester.longPress(find.text('LongPress List'));
      expect(longPressedList, isTrue);

      await tester.longPress(find.text('LongPress Drawer'));
      expect(longPressedDrawer, isTrue);
      print('onLongPress test passed');
    });

    testWidgets('Disabled tiles do not respond to tap', (
      WidgetTester tester,
    ) async {
      bool listTapped = false;
      bool drawerTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                ListTile(
                  style: ListTileStyle.list,
                  enabled: false,
                  title: Text('Disabled List'),
                  onTap: () {
                    listTapped = true;
                  },
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  enabled: false,
                  title: Text('Disabled Drawer'),
                  onTap: () {
                    drawerTapped = true;
                  },
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.text('Disabled List'));
      await tester.tap(find.text('Disabled Drawer'));

      expect(listTapped, isFalse);
      expect(drawerTapped, isFalse);
      print('Disabled interaction test passed');
    });
  });

  // Group 10: Comprehensive Visual Demo Test
  group('Comprehensive Visual Demonstration', () {
    testWidgets('Build function creates complete demo UI', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                final result = build(context);
                return result as Widget;
              },
            ),
          ),
        ),
      );

      // Verify key sections exist
      expect(find.text('Section 1: ListTileStyle Visual Comparison'), findsOneWidget);
      expect(find.text('Section 2: ListTileStyle.list Use Cases'), findsOneWidget);
      expect(find.text('Section 3: ListTileStyle.drawer Use Cases'), findsOneWidget);
      expect(find.text('Section 4: Density, Padding & Visual Weight'), findsOneWidget);
      expect(find.text('Section 5: ListTileTheme Integration'), findsOneWidget);
      expect(find.text('Section 6: Mixed Usage Scenarios'), findsOneWidget);
      expect(find.text('Section 7: Platform & Material Design'), findsOneWidget);

      print('Complete demo UI verification passed');
    });

    testWidgets('All comparison cards render correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Builder(
                builder: (context) {
                  final result = build(context);
                  return result as Widget;
                },
              ),
            ),
          ),
        ),
      );

      // Check for style labels in comparison cards
      expect(find.text('ListTileStyle.list'), findsWidgets);
      expect(find.text('ListTileStyle.drawer'), findsWidgets);

      print('Comparison cards render test passed');
    });

    testWidgets('Mock drawers render in demo', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Builder(
                builder: (context) {
                  final result = build(context);
                  return result as Widget;
                },
              ),
            ),
          ),
        ),
      );

      // Check for drawer demos
      expect(find.text('Standard Navigation'), findsOneWidget);
      expect(find.text('Email Navigation'), findsOneWidget);
      expect(find.text('Productivity App'), findsOneWidget);

      print('Mock drawers render test passed');
    });

    testWidgets('Settings and contact list patterns render', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Builder(
                builder: (context) {
                  final result = build(context);
                  return result as Widget;
                },
              ),
            ),
          ),
        ),
      );

      // Check for list pattern content
      expect(find.text('Account'), findsOneWidget);
      expect(find.text('Notifications'), findsWidgets);
      expect(find.text('Alice Anderson'), findsOneWidget);

      print('List patterns render test passed');
    });
  });

  print('All ListTileStyle tests defined');
}
