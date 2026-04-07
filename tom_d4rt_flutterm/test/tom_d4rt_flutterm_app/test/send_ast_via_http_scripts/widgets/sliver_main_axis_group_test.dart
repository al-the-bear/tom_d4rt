// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SliverMainAxisGroup
// Demonstrates SliverMainAxisGroup — a sliver that groups multiple child
// slivers along the main axis so they act as one unit for scroll physics.
// This is essential for pinned headers that belong to a specific content
// section: when a group scrolls out, its pinned header scrolls away too.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverMainAxisGroup Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.view_agenda,
      'title': 'What Is SliverMainAxisGroup?',
      'body': 'SliverMainAxisGroup wraps a list of slivers so they behave '
          'as a single composite sliver. The framework treats the group\'s '
          'total extent as one unit — when the group scrolls out, all its '
          'children (including pinned headers) scroll away together.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.push_pin,
      'title': 'Pinned Headers That Scroll Away',
      'body': 'Without grouping, a SliverPersistentHeader(pinned: true) stays '
          'at the top forever. Inside a SliverMainAxisGroup, the header '
          'only stays pinned while its group is still visible. The next '
          'group\'s header pushes it out — like iOS-style section headers.',
      'accent': Colors.orange,
    },
    {
      'icon': Icons.layers,
      'title': 'Multiple Sections',
      'body': 'Create distinct content sections (e.g., "Favorites", "Recent", '
          '"All Items") where each section has its own header and content '
          'slivers. Groups keep the header associated with the right content.',
      'accent': Colors.teal,
    },
    {
      'icon': Icons.build_circle,
      'title': 'Typical Use Cases',
      'body': 'Alphabetical contact lists with sticky letter headers. Settings '
          'pages with category sections. Multi-category product catalogs. '
          'Any UI with grouped scrollable sections that need independent '
          'pinned headers.',
      'accent': Colors.purple,
    },
  ];

  final conceptCards = <Widget>[];
  for (var idx = 0; idx < conceptItems.length; idx++) {
    final e = conceptItems[idx];
    final accent = e['accent'] as Color;
    print('Concept ${idx + 1}: ${e['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: accent.withValues(alpha: 0.15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(e['icon'] as IconData, color: accent, size: 26.0),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.5,
                      color: accent,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    e['body'] as String,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 2: Constructor
  // ============================================================
  print('=== Section 2: Constructor ===');

  final constructorCode = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.blue.shade200, size: 16.0),
            const SizedBox(width: 8.0),
            Text(
              'Constructor & Usage',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade200,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Text(
          'CustomScrollView(\n'
          '  slivers: [\n'
          '    SliverMainAxisGroup(\n'
          '      slivers: [\n'
          '        SliverPersistentHeader(\n'
          '          pinned: true,\n'
          '          delegate: MySectionHeader(\'A\'),\n'
          '        ),\n'
          '        SliverList(...), // Items A-Azz\n'
          '      ],\n'
          '    ),\n'
          '    SliverMainAxisGroup(\n'
          '      slivers: [\n'
          '        SliverPersistentHeader(\n'
          '          pinned: true,\n'
          '          delegate: MySectionHeader(\'B\'),\n'
          '        ),\n'
          '        SliverList(...), // Items B-Bzz\n'
          '      ],\n'
          '    ),\n'
          '  ],\n'
          ')',
          style: TextStyle(
            fontSize: 11.5,
            fontFamily: 'monospace',
            color: Colors.green.shade300,
            height: 1.45,
          ),
        ),
      ],
    ),
  );

  final paramExplanations = <Map<String, dynamic>>[
    {
      'name': 'slivers',
      'type': 'List<Widget>',
      'desc': 'The child slivers to group along the main axis. Typically '
          'includes a SliverPersistentHeader (pinned) plus one or more '
          'content slivers (SliverList, SliverGrid, etc.).',
      'required': true,
    },
    {
      'name': 'key',
      'type': 'Key?',
      'desc': 'Optional widget key for identity during rebuilds.',
      'required': false,
    },
  ];

  final paramCards = <Widget>[];
  for (final cp in paramExplanations) {
    final isReq = cp['required'] as bool;
    paramCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.blue.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.blue.withValues(alpha: 0.1)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: isReq
                    ? Colors.red.withValues(alpha: 0.1)
                    : Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                isReq ? 'REQUIRED' : 'OPTIONAL',
                style: TextStyle(
                  fontSize: 9.0,
                  fontWeight: FontWeight.bold,
                  color: isReq ? Colors.red : Colors.green.shade700,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        cp['name'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.blue,
                          fontFamily: 'monospace',
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        child: Text(
                          cp['type'] as String,
                          style: TextStyle(
                            fontSize: 11.0,
                            fontFamily: 'monospace',
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    cp['desc'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade700,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: Basic Grouping
  // ============================================================
  print('=== Section 3: Basic Grouping ===');

  // Two groups, each with a pinned header + list
  final basicDemo = CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.blue.withValues(alpha: 0.06),
          child: Text(
            'Two groups below: "Fruits" and "Vegetables". Each header '
            'stays pinned until its group scrolls out, then the next '
            'header pushes it away.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.blue.shade700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
      SliverMainAxisGroup(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _SectionHeaderDelegate(
              title: 'Fruits',
              color: Colors.green,
              icon: Icons.eco,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              _magBuildItems([
                {'name': 'Apple', 'detail': 'Crisp and sweet', 'icon': Icons.circle},
                {'name': 'Banana', 'detail': 'Rich in potassium', 'icon': Icons.circle},
                {'name': 'Cherry', 'detail': 'Small and tangy', 'icon': Icons.circle},
                {'name': 'Date', 'detail': 'Naturally sweet', 'icon': Icons.circle},
                {'name': 'Elderberry', 'detail': 'Immune support', 'icon': Icons.circle},
                {'name': 'Fig', 'detail': 'Soft and honeyed', 'icon': Icons.circle},
                {'name': 'Grape', 'detail': 'Juicy clusters', 'icon': Icons.circle},
                {'name': 'Honeydew', 'detail': 'Refreshing melon', 'icon': Icons.circle},
              ], Colors.green),
            ),
          ),
        ],
      ),
      SliverMainAxisGroup(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _SectionHeaderDelegate(
              title: 'Vegetables',
              color: Colors.orange,
              icon: Icons.grass,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              _magBuildItems([
                {'name': 'Artichoke', 'detail': 'Hearty flavor', 'icon': Icons.circle},
                {'name': 'Broccoli', 'detail': 'Vitamin-packed', 'icon': Icons.circle},
                {'name': 'Carrot', 'detail': 'Beta carotene', 'icon': Icons.circle},
                {'name': 'Daikon', 'detail': 'Mild radish', 'icon': Icons.circle},
                {'name': 'Eggplant', 'detail': 'Versatile cooking', 'icon': Icons.circle},
                {'name': 'Fennel', 'detail': 'Anise-like taste', 'icon': Icons.circle},
                {'name': 'Garlic', 'detail': 'Aromatic bulb', 'icon': Icons.circle},
                {'name': 'Horseradish', 'detail': 'Spicy root', 'icon': Icons.circle},
              ], Colors.orange),
            ),
          ),
        ],
      ),
    ],
  );
  print('Built basic grouping demo');

  // ============================================================
  // SECTION 4: Multi-Section Categories
  // ============================================================
  print('=== Section 4: Multi-Section ===');

  final categories = <Map<String, dynamic>>[
    {
      'title': 'Getting Started',
      'color': Colors.blue,
      'icon': Icons.play_arrow,
      'items': [
        'Installation Guide',
        'Quick Start Tutorial',
        'Configuration Options',
        'First Project Setup',
      ],
    },
    {
      'title': 'Core Concepts',
      'color': Colors.teal,
      'icon': Icons.school,
      'items': [
        'Widget Tree Architecture',
        'State Management',
        'Build Context',
        'Layout Constraints',
        'Rendering Pipeline',
      ],
    },
    {
      'title': 'Advanced Topics',
      'color': Colors.purple,
      'icon': Icons.auto_awesome,
      'items': [
        'Custom Render Objects',
        'Platform Channels',
        'Isolate Communication',
        'Plugin Development',
        'Performance Profiling',
        'Memory Management',
      ],
    },
    {
      'title': 'Testing',
      'color': Colors.red,
      'icon': Icons.bug_report,
      'items': [
        'Widget Testing',
        'Integration Testing',
        'Golden Tests',
        'Mocking Dependencies',
      ],
    },
  ];

  final multiSectionSlivers = <Widget>[
    SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.indigo.withValues(alpha: 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.menu_book, color: Colors.indigo, size: 20.0),
                const SizedBox(width: 8.0),
                Text(
                  'Documentation Sections',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: Colors.indigo.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Text(
              'Four independent sections with pinned headers that '
              'push each other out as you scroll.',
              style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    ),
  ];
  for (final cat in categories) {
    final color = cat['color'] as Color;
    final items = cat['items'] as List<String>;
    multiSectionSlivers.add(
      SliverMainAxisGroup(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _SectionHeaderDelegate(
              title: cat['title'] as String,
              color: color,
              icon: cat['icon'] as IconData,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 14.0, vertical: 3.0,
                  ),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: color.withValues(alpha: 0.1)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 28.0,
                        height: 28.0,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Text(
                          items[index],
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: color.withValues(alpha: 0.4),
                        size: 20.0,
                      ),
                    ],
                  ),
                );
              },
              childCount: items.length,
            ),
          ),
        ],
      ),
    );
  }

  final multiSectionDemo = CustomScrollView(slivers: multiSectionSlivers);
  print('Built multi-section demo');

  // ============================================================
  // SECTION 5: Contacts App
  // ============================================================
  print('=== Section 5: Contacts App ===');

  final contactData = <String, List<Map<String, String>>>{
    'A': [
      {'name': 'Alice Anderson', 'phone': '+1 555-0101'},
      {'name': 'Andrew Adams', 'phone': '+1 555-0102'},
      {'name': 'Amy Archer', 'phone': '+1 555-0103'},
    ],
    'B': [
      {'name': 'Bob Baker', 'phone': '+1 555-0201'},
      {'name': 'Beth Brown', 'phone': '+1 555-0202'},
    ],
    'C': [
      {'name': 'Charlie Clark', 'phone': '+1 555-0301'},
      {'name': 'Carol Chen', 'phone': '+1 555-0302'},
      {'name': 'Chris Cooper', 'phone': '+1 555-0303'},
      {'name': 'Cathy Cheng', 'phone': '+1 555-0304'},
    ],
    'D': [
      {'name': 'David Davis', 'phone': '+1 555-0401'},
      {'name': 'Diana Diaz', 'phone': '+1 555-0402'},
      {'name': 'Derek Dunn', 'phone': '+1 555-0403'},
    ],
    'E': [
      {'name': 'Eva Evans', 'phone': '+1 555-0501'},
      {'name': 'Edward Ellis', 'phone': '+1 555-0502'},
    ],
    'F': [
      {'name': 'Frank Foster', 'phone': '+1 555-0601'},
      {'name': 'Fiona Fisher', 'phone': '+1 555-0602'},
      {'name': 'Felix Frost', 'phone': '+1 555-0603'},
    ],
    'G': [
      {'name': 'George Garcia', 'phone': '+1 555-0701'},
      {'name': 'Grace Green', 'phone': '+1 555-0702'},
    ],
  };

  final contactColors = [
    Colors.blue, Colors.red, Colors.green, Colors.purple,
    Colors.orange, Colors.teal, Colors.indigo,
  ];

  final contactSlivers = <Widget>[
    SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.contacts, color: Colors.indigo, size: 22.0),
                const SizedBox(width: 8.0),
                Text(
                  'Contacts',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Text(
              'Alphabetical groups with pinned letter headers',
              style: TextStyle(fontSize: 12.0, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    ),
  ];

  var colorIdx = 0;
  for (final entry in contactData.entries) {
    final letter = entry.key;
    final contacts = entry.value;
    final accent = contactColors[colorIdx % contactColors.length];
    colorIdx++;

    contactSlivers.add(
      SliverMainAxisGroup(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _LetterHeaderDelegate(
              letter: letter,
              color: accent,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final c = contacts[index];
                final initials = c['name']!.split(' ').map((w) => w[0]).join();
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 14.0, vertical: 2.0,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: accent.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          initials,
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: accent,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade100,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                c['name']!,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                              Text(
                                c['phone']!,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Icon(
                        Icons.phone,
                        color: Colors.grey.shade300,
                        size: 20.0,
                      ),
                    ],
                  ),
                );
              },
              childCount: contacts.length,
            ),
          ),
        ],
      ),
    );
  }

  final contactsDemo = CustomScrollView(slivers: contactSlivers);
  print('Built contacts demo');

  // ============================================================
  // SECTION 6: Grouped + Grid
  // ============================================================
  print('=== Section 6: Grouped Grid ===');

  final galleryCategories = <Map<String, dynamic>>[
    {
      'title': 'Landscapes',
      'color': Colors.green,
      'icon': Icons.landscape,
      'count': 6,
    },
    {
      'title': 'Portraits',
      'color': Colors.orange,
      'icon': Icons.portrait,
      'count': 4,
    },
    {
      'title': 'Architecture',
      'color': Colors.blue,
      'icon': Icons.apartment,
      'count': 8,
    },
  ];

  final gallerySlivers = <Widget>[
    SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.photo_library, color: Colors.pink, size: 22.0),
                const SizedBox(width: 8.0),
                Text(
                  'Photo Gallery',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Text(
              'Groups can contain grids too — each category has a '
              'pinned header and a photo grid.',
              style: TextStyle(fontSize: 12.0, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    ),
  ];
  for (final cat in galleryCategories) {
    final color = cat['color'] as Color;
    final count = cat['count'] as int;
    gallerySlivers.add(
      SliverMainAxisGroup(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _SectionHeaderDelegate(
              title: cat['title'] as String,
              color: color,
              icon: cat['icon'] as IconData,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(10.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 6.0,
                mainAxisSpacing: 6.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.08 + (index * 0.03)),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: color.withValues(alpha: 0.15),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          cat['icon'] as IconData,
                          color: color,
                          size: 28.0,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Photo ${index + 1}',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: count,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final galleryDemo = CustomScrollView(slivers: gallerySlivers);
  print('Built gallery demo');

  // ============================================================
  // SECTION 7: Settings Page
  // ============================================================
  print('=== Section 7: Settings Page ===');

  final settingSections = <Map<String, dynamic>>[
    {
      'title': 'Account',
      'color': Colors.blue,
      'icon': Icons.person,
      'items': [
        {'name': 'Profile', 'subtitle': 'Name, email, photo', 'icon': Icons.account_circle},
        {'name': 'Security', 'subtitle': 'Password, 2FA', 'icon': Icons.lock},
        {'name': 'Privacy', 'subtitle': 'Data sharing preferences', 'icon': Icons.privacy_tip},
      ],
    },
    {
      'title': 'App Settings',
      'color': Colors.teal,
      'icon': Icons.settings,
      'items': [
        {'name': 'Appearance', 'subtitle': 'Theme, colors, font size', 'icon': Icons.palette},
        {'name': 'Notifications', 'subtitle': 'Push, email, in-app', 'icon': Icons.notifications},
        {'name': 'Language', 'subtitle': 'English (US)', 'icon': Icons.language},
        {'name': 'Storage', 'subtitle': 'Cache, downloads', 'icon': Icons.storage},
      ],
    },
    {
      'title': 'Advanced',
      'color': Colors.deepPurple,
      'icon': Icons.tune,
      'items': [
        {'name': 'Developer Options', 'subtitle': 'Debug, logging', 'icon': Icons.code},
        {'name': 'Experimental', 'subtitle': 'Beta features', 'icon': Icons.science},
        {'name': 'Reset', 'subtitle': 'Factory defaults', 'icon': Icons.restart_alt},
      ],
    },
    {
      'title': 'About',
      'color': Colors.grey,
      'icon': Icons.info,
      'items': [
        {'name': 'Version', 'subtitle': '2.5.0 (build 1842)', 'icon': Icons.info_outline},
        {'name': 'Licenses', 'subtitle': 'Open source licenses', 'icon': Icons.description},
        {'name': 'Help & Feedback', 'subtitle': 'Support center', 'icon': Icons.help},
      ],
    },
  ];

  final settingsSlivers = <Widget>[
    SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.settings, color: Colors.blueGrey, size: 24.0),
            const SizedBox(width: 10.0),
            Text(
              'Settings',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    ),
  ];
  for (final section in settingSections) {
    final color = section['color'] as Color;
    final items = section['items'] as List<Map<String, dynamic>>;
    settingsSlivers.add(
      SliverMainAxisGroup(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _SectionHeaderDelegate(
              title: section['title'] as String,
              color: color,
              icon: section['icon'] as IconData,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = items[index];
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 14.0, vertical: 2.0,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36.0,
                        height: 36.0,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Icon(
                          item['icon'] as IconData,
                          color: color,
                          size: 18.0,
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey.shade100),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'] as String,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                              Text(
                                item['subtitle'] as String,
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.grey.shade300,
                        size: 20.0,
                      ),
                    ],
                  ),
                );
              },
              childCount: items.length,
            ),
          ),
        ],
      ),
    );
  }

  final settingsDemo = CustomScrollView(slivers: settingsSlivers);
  print('Built settings demo');

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final keyPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.check_circle,
      'text': 'SliverMainAxisGroup groups slivers as one scroll unit',
      'color': Colors.green,
    },
    {
      'icon': Icons.check_circle,
      'text': 'Pinned headers inside a group scroll away when the group exits',
      'color': Colors.green,
    },
    {
      'icon': Icons.check_circle,
      'text': 'Essential for iOS-style sticky section headers',
      'color': Colors.green,
    },
    {
      'icon': Icons.lightbulb_outline,
      'text': 'Group can contain any sliver — lists, grids, adapters',
      'color': Colors.amber,
    },
    {
      'icon': Icons.lightbulb_outline,
      'text': 'Use SliverPersistentHeader(pinned: true) inside the group',
      'color': Colors.amber,
    },
    {
      'icon': Icons.warning_amber,
      'text': 'Groups cannot be nested — only top-level grouping',
      'color': Colors.orange,
    },
    {
      'icon': Icons.warning_amber,
      'text': 'The slivers list must be non-empty',
      'color': Colors.orange,
    },
  ];

  final summaryPoints = <Widget>[];
  for (final kp in keyPoints) {
    final color = kp['color'] as Color;
    summaryPoints.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(kp['icon'] as IconData, color: color, size: 18.0),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                kp['text'] as String,
                style: TextStyle(
                  fontSize: 12.5,
                  color: Colors.grey.shade800,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final refTable = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _magRefRow('Widget', 'SliverMainAxisGroup'),
      _magRefRow('Library', 'package:flutter/widgets.dart'),
      _magRefRow('Parent', 'CustomScrollView.slivers'),
      _magRefRow('Key param', 'slivers (List<Widget>)'),
      _magRefRow('Behavior', 'Children act as one scroll unit'),
      _magRefRow('Key combo', '+ SliverPersistentHeader(pinned: true)'),
      _magRefRow('Use case', 'Section headers, grouped content'),
    ],
  );

  // ============================================================
  // ASSEMBLE TABBED LAYOUT
  // ============================================================
  print('=== Assembling tabbed layout ===');
  print('SliverMainAxisGroup Deep Demo complete');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('SliverMainAxisGroup Deep Demo'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        elevation: 2.0,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 11.0),
          tabs: [
            Tab(text: 'Concept'),
            Tab(text: 'Constructor'),
            Tab(text: 'Basic'),
            Tab(text: 'Sections'),
            Tab(text: 'Contacts'),
            Tab(text: 'Gallery'),
            Tab(text: 'Settings'),
            Tab(text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1: Concept
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.withValues(alpha: 0.1),
                        Colors.blue.withValues(alpha: 0.03),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.view_agenda,
                        size: 48.0,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'SliverMainAxisGroup',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        'Group slivers so they scroll as one unit — '
                        'enabling true section-based sticky headers.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ...conceptCards,
              ],
            ),
          ),
          // Tab 2: Constructor
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Constructor & Parameters',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  'SliverMainAxisGroup takes a list of child slivers that '
                  'will be grouped along the main scroll axis.',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 16.0),
                ...paramCards,
                const SizedBox(height: 12.0),
                constructorCode,
              ],
            ),
          ),
          // Tab 3: Basic
          basicDemo,
          // Tab 4: Multi-section
          multiSectionDemo,
          // Tab 5: Contacts
          contactsDemo,
          // Tab 6: Gallery
          galleryDemo,
          // Tab 7: Settings
          settingsDemo,
          // Tab 8: Summary
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Key Takeaways',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
                const SizedBox(height: 16.0),
                ...summaryPoints,
                const SizedBox(height: 24.0),
                Text(
                  'Quick Reference',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
                const SizedBox(height: 12.0),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.blue.withValues(alpha: 0.1),
                    ),
                  ),
                  child: refTable,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// ============================================================
// DELEGATE: Section header for group demos
// ============================================================
class _SectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final Color color;
  final IconData icon;

  _SectionHeaderDelegate({
    required this.title,
    required this.color,
    required this.icon,
  });

  @override
  double get minExtent => 44.0;

  @override
  double get maxExtent => 44.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: color.withValues(alpha: 0.95),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 18.0),
          const SizedBox(width: 8.0),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _SectionHeaderDelegate oldDelegate) {
    return title != oldDelegate.title ||
        color != oldDelegate.color ||
        icon != oldDelegate.icon;
  }
}

// ============================================================
// DELEGATE: Letter header for contacts
// ============================================================
class _LetterHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String letter;
  final Color color;

  _LetterHeaderDelegate({required this.letter, required this.color});

  @override
  double get minExtent => 32.0;

  @override
  double get maxExtent => 32.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.grey.shade100,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Text(
        letter,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _LetterHeaderDelegate oldDelegate) {
    return letter != oldDelegate.letter || color != oldDelegate.color;
  }
}

// ============================================================
// HELPER: Build list items for basic demo
// ============================================================
List<Widget> _magBuildItems(
  List<Map<String, dynamic>> items,
  Color accent,
) {
  return items.map((item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 3.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: accent.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 32.0,
            height: 32.0,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              item['icon'] as IconData,
              color: accent,
              size: 14.0,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    color: Colors.grey.shade800,
                  ),
                ),
                Text(
                  item['detail'] as String,
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();
}

// ============================================================
// HELPER: Reference row
// ============================================================
Widget _magRefRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90.0,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ],
    ),
  );
}
