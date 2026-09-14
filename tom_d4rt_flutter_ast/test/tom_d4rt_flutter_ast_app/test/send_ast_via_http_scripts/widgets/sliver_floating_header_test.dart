// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SliverFloatingHeader
// Demonstrates SliverFloatingHeader — a sliver that floats its child header
// back into view when the user starts scrolling backward. It hides on forward
// scroll and reappears on reverse scroll, giving the "floating toolbar" UX
// pattern seen in many mobile apps.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverFloatingHeader Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — What Is SliverFloatingHeader?
  // ============================================================
  print('=== Section 1: Concept ===');

  // Build four concept explanation cards
  final conceptData = <Map<String, dynamic>>[
    {
      'icon': Icons.vertical_align_top,
      'title': 'What Is SliverFloatingHeader?',
      'body': 'SliverFloatingHeader is a sliver widget that wraps a single '
          'child and makes it behave like a floating header inside a '
          'CustomScrollView. The child scrolls out of view normally when '
          'the user scrolls down, but it immediately reappears (floats '
          'back in) when the user begins scrolling upward — even if only '
          'by a pixel.',
      'color': Colors.indigo,
    },
    {
      'icon': Icons.compare_arrows,
      'title': 'Floating vs Persistent vs Pinned',
      'body': 'A pinned header (SliverAppBar pinned:true) stays visible '
          'always. A persistent header (SliverPersistentHeader) remains '
          'visible but can shrink/grow. A floating header (this widget) '
          'disappears on forward scroll and reappears on backward scroll, '
          'giving more content space while keeping the header accessible.',
      'color': Colors.teal,
    },
    {
      'icon': Icons.touch_app,
      'title': 'Scroll Direction Sensitivity',
      'body': 'The floating behavior is driven by scroll direction changes. '
          'When the user reverses direction, the header animates back into '
          'view from the edge where it disappeared. This creates a smooth, '
          'responsive feel. The threshold is very low — even a tiny reverse '
          'gesture brings the header back.',
      'color': Colors.deepOrange,
    },
    {
      'icon': Icons.phone_android,
      'title': 'Common Use Cases',
      'body': 'Navigation bars that hide on scroll down and reappear on '
          'scroll up (YouTube, Chrome mobile). Search bars in list views. '
          'Filter toolbars in e-commerce apps. Date separators in chat '
          'apps that float back when reviewing older messages.',
      'color': Colors.purple,
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptData.length; i++) {
    final item = conceptData[i];
    final color = item['color'] as Color;
    print('Concept ${i + 1}: ${item['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color.withValues(alpha: 0.15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(item['icon'] as IconData, color: color, size: 26.0),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.5,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    item['body'] as String,
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
  // SECTION 2: Constructor & Parameters
  // ============================================================
  print('=== Section 2: Constructor ===');

  final paramCards = <Widget>[];

  // SliverFloatingHeader has a simple constructor with just child and key
  final params = <Map<String, dynamic>>[
    {
      'name': 'child',
      'type': 'Widget',
      'required': true,
      'default': '',
      'desc': 'The header widget to display. This can be any widget: a '
          'Container, an AppBar, a Row of controls, a search field, etc. '
          'It will scroll away on down-scroll and float back on up-scroll.',
    },
    {
      'name': 'key',
      'type': 'Key?',
      'required': false,
      'default': 'null',
      'desc': 'An optional key for the widget. Useful for controlling '
          'identity during rebuilds in lists or conditional layouts.',
    },
  ];

  for (final p in params) {
    final isReq = p['required'] as bool;
    print('  param: ${p['name']} (${p['type']}) required=$isReq');
    paramCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.indigo.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.indigo.withValues(alpha: 0.12)),
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
                        p['name'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.indigo,
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
                          p['type'] as String,
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
                    p['desc'] as String,
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

  // Constructor code snippet card
  final constructorSnippet = Container(
    margin: const EdgeInsets.only(top: 12.0),
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
            Icon(Icons.code, color: Colors.indigo.shade200, size: 16.0),
            const SizedBox(width: 8.0),
            Text(
              'Usage Pattern',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade200,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Text(
          'CustomScrollView(\n'
          '  slivers: [\n'
          '    SliverFloatingHeader(\n'
          '      child: Container(\n'
          '        color: Colors.blue,\n'
          '        height: 56.0,\n'
          '        child: Text(\'I float!\'),\n'
          '      ),\n'
          '    ),\n'
          '    SliverList( ... ),\n'
          '  ],\n'
          ')',
          style: TextStyle(
            fontSize: 12.0,
            fontFamily: 'monospace',
            color: Colors.green.shade300,
            height: 1.45,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Basic Floating Header Demo
  // ============================================================
  print('=== Section 3: Basic Floating Header ===');

  // Build a simple CustomScrollView with SliverFloatingHeader
  final basicFloatingDemo = CustomScrollView(
    slivers: [
      SliverFloatingHeader(
        child: Container(
          color: Colors.indigo,
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 14.0,
          ),
          child: const Row(
            children: [
              Icon(Icons.menu, color: Colors.white, size: 22.0),
              SizedBox(width: 12.0),
              Text(
                'Floating Navigation Bar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(Icons.search, color: Colors.white70, size: 22.0),
              SizedBox(width: 16.0),
              Icon(Icons.more_vert, color: Colors.white70, size: 22.0),
            ],
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final colors = [
              Colors.blue.shade50,
              Colors.indigo.shade50,
              Colors.purple.shade50,
              Colors.teal.shade50,
              Colors.cyan.shade50,
              Colors.green.shade50,
            ];
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 4.0,
              ),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: colors[index % colors.length],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.indigo.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'List item ${index + 1}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Scroll down to hide the header, then scroll up '
                          'to see it float back into view.',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          childCount: 30,
        ),
      ),
    ],
  );
  print('Built basic floating header demo with 30 list items');

  // ============================================================
  // SECTION 4: Rich Content Floating Header
  // ============================================================
  print('=== Section 4: Rich Content Floating Header ===');

  // A more complex header with gradient, search bar, and action icons
  final richHeaderDemo = CustomScrollView(
    slivers: [
      SliverFloatingHeader(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade600, Colors.indigo.shade600],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.withValues(alpha: 0.3),
                blurRadius: 8.0,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.shopping_bag,
                      color: Colors.white,
                      size: 24.0,
                    ),
                    const SizedBox(width: 10.0),
                    const Expanded(
                      child: Text(
                        'Product Catalog',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                            size: 16.0,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            '3',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Search bar row inside the floating header
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 10.0),
                child: Container(
                  height: 36.0,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 14.0),
                      Icon(
                        Icons.search,
                        color: Colors.white.withValues(alpha: 0.7),
                        size: 18.0,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'Search products...',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 13.0,
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
      // Product grid below the floating header
      SliverPadding(
        padding: const EdgeInsets.all(12.0),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 0.85,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final productNames = [
                'Wireless Earbuds',
                'Laptop Stand',
                'USB Hub',
                'Desk Lamp',
                'Webcam HD',
                'Keyboard',
                'Mouse Pad',
                'Monitor Arm',
                'Cable Organizer',
                'Phone Mount',
                'Headphones',
                'Charger',
                'Stylus Pen',
                'Screen Protector',
                'Tablet Case',
                'Power Bank',
              ];
              final productIcons = [
                Icons.headphones,
                Icons.laptop,
                Icons.usb,
                Icons.lightbulb_outline,
                Icons.videocam,
                Icons.keyboard,
                Icons.crop_landscape,
                Icons.desktop_windows,
                Icons.cable,
                Icons.phone_android,
                Icons.headset,
                Icons.battery_charging_full,
                Icons.edit,
                Icons.screen_lock_portrait,
                Icons.tablet,
                Icons.power,
              ];
              final prices = [
                29.99, 49.99, 24.99, 39.99, 59.99, 79.99, 14.99, 89.99,
                9.99, 19.99, 149.99, 29.99, 34.99, 12.99, 29.99, 44.99,
              ];
              final gradients = [
                [Colors.blue.shade100, Colors.blue.shade50],
                [Colors.green.shade100, Colors.green.shade50],
                [Colors.orange.shade100, Colors.orange.shade50],
                [Colors.purple.shade100, Colors.purple.shade50],
              ];
              final grad = gradients[index % gradients.length];
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: grad,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: grad[0].withValues(alpha: 0.5),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      productIcons[index % productIcons.length],
                      size: 36.0,
                      color: Colors.grey.shade700,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      productNames[index % productNames.length],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      '\$${prices[index % prices.length].toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple.shade700,
                      ),
                    ),
                  ],
                ),
              );
            },
            childCount: 16,
          ),
        ),
      ),
    ],
  );
  print('Built rich header demo with product grid (16 items)');

  // ============================================================
  // SECTION 5: Multiple Floating Headers
  // ============================================================
  print('=== Section 5: Multiple Floating Headers ===');

  // Build a scroll view with MULTIPLE SliverFloatingHeaders separating
  // different content sections — each header floats independently
  Widget buildSectionHeader(String title, IconData icon, Color color) {
    return Container(
      color: color.withValues(alpha: 0.9),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20.0),
          const SizedBox(width: 10.0),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionItem(String text, Color accentColor, int num) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: accentColor.withValues(alpha: 0.12)),
      ),
      child: Row(
        children: [
          Container(
            width: 28.0,
            height: 28.0,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$num',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 12.5, color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }

  final multiHeaderDemo = CustomScrollView(
    slivers: [
      // Floating header 1: Favorites
      SliverFloatingHeader(
        child: buildSectionHeader('Favorites', Icons.star, Colors.amber.shade700),
      ),
      SliverList(
        delegate: SliverChildListDelegate([
          buildSectionItem('Star-marked project Alpha', Colors.amber, 1),
          buildSectionItem('Bookmarked article on Flutter', Colors.amber, 2),
          buildSectionItem('Saved color palette "Ocean"', Colors.amber, 3),
          buildSectionItem('Favorite recipe: Pasta', Colors.amber, 4),
          buildSectionItem('Pinned note: Meeting agenda', Colors.amber, 5),
          buildSectionItem('Saved podcast episode', Colors.amber, 6),
        ]),
      ),
      // Floating header 2: Recent
      SliverFloatingHeader(
        child: buildSectionHeader(
          'Recent Activity',
          Icons.history,
          Colors.blue.shade700,
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate([
          buildSectionItem('Edited file: main.dart', Colors.blue, 1),
          buildSectionItem('Viewed dashboard at 2:30pm', Colors.blue, 2),
          buildSectionItem('Ran unit tests (all passed)', Colors.blue, 3),
          buildSectionItem('Updated dependencies', Colors.blue, 4),
          buildSectionItem('Created branch: feature/header', Colors.blue, 5),
          buildSectionItem('Reviewed PR #142', Colors.blue, 6),
          buildSectionItem('Deployed staging build', Colors.blue, 7),
          buildSectionItem('Fixed lint warnings', Colors.blue, 8),
        ]),
      ),
      // Floating header 3: Settings
      SliverFloatingHeader(
        child: buildSectionHeader(
          'Settings',
          Icons.settings,
          Colors.green.shade700,
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate([
          buildSectionItem('Theme: Dark mode', Colors.green, 1),
          buildSectionItem('Language: English', Colors.green, 2),
          buildSectionItem('Notifications: On', Colors.green, 3),
          buildSectionItem('Font size: Medium', Colors.green, 4),
          buildSectionItem('Auto-save: Enabled', Colors.green, 5),
        ]),
      ),
      // Floating header 4: About
      SliverFloatingHeader(
        child: buildSectionHeader(
          'About',
          Icons.info_outline,
          Colors.deepPurple.shade700,
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate([
          buildSectionItem('App version: 2.4.1', Colors.deepPurple, 1),
          buildSectionItem('Build: 20260407', Colors.deepPurple, 2),
          buildSectionItem('License: MIT', Colors.deepPurple, 3),
          buildSectionItem('Author: Deep Demo Team', Colors.deepPurple, 4),
          buildSectionItem('Contributors: 12', Colors.deepPurple, 5),
          buildSectionItem('Dependencies: 38 packages', Colors.deepPurple, 6),
          buildSectionItem('Lines of code: 14,200', Colors.deepPurple, 7),
        ]),
      ),
    ],
  );
  print('Built multi-header demo with 4 floating section headers');

  // ============================================================
  // SECTION 6: Behavior Comparison Visualization
  // ============================================================
  print('=== Section 6: Behavior Comparison ===');

  // Visual diagram showing different header behaviors
  Widget buildBehaviorCard(
    String headerType,
    String behavior,
    IconData icon,
    Color color,
    List<Map<String, String>> phases,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        color: color.withValues(alpha: 0.03),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 24.0),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        headerType,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: color,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        behavior,
                        style: TextStyle(
                          fontSize: 11.5,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: phases.map((phase) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              phase['action']!,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            Text(
                              phase['result']!,
                              style: TextStyle(
                                fontSize: 11.0,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  final behaviorCards = <Widget>[
    buildBehaviorCard(
      'SliverFloatingHeader',
      'Hides on scroll down, reappears on scroll up',
      Icons.vertical_align_top,
      Colors.indigo,
      [
        {
          'action': 'User scrolls DOWN',
          'result': 'Header scrolls out of view and disappears',
        },
        {
          'action': 'User scrolls UP (even slightly)',
          'result': 'Header immediately floats back into view from the top',
        },
        {
          'action': 'User continues scrolling UP',
          'result': 'Header stays visible as long as scroll direction is up',
        },
        {
          'action': 'User scrolls DOWN again',
          'result': 'Header scrolls away again smoothly',
        },
      ],
    ),
    buildBehaviorCard(
      'SliverPersistentHeader (pinned)',
      'Always visible, may shrink/grow',
      Icons.push_pin,
      Colors.teal,
      [
        {
          'action': 'User scrolls DOWN',
          'result': 'Header stays pinned at the top, never disappears',
        },
        {
          'action': 'With floating:false',
          'result': 'Header shrinks to minExtent but remains visible',
        },
        {
          'action': 'User scrolls back UP',
          'result': 'Header grows back to maxExtent',
        },
      ],
    ),
    buildBehaviorCard(
      'SliverAppBar (floating)',
      'Similar floating but with min/max extents',
      Icons.web_asset,
      Colors.deepOrange,
      [
        {
          'action': 'User scrolls DOWN',
          'result': 'AppBar scrolls away (unless pinned)',
        },
        {
          'action': 'floating: true',
          'result': 'Reappears on any upward scroll (like SliverFloatingHeader)',
        },
        {
          'action': 'snap: true + floating: true',
          'result': 'Snaps fully open/closed instead of partial reveal',
        },
      ],
    ),
  ];
  print('Built ${behaviorCards.length} behavior comparison cards');

  // ============================================================
  // SECTION 7: Real-World Patterns
  // ============================================================
  print('=== Section 7: Real-World Patterns ===');

  // Pattern 1: Chat app with floating date header
  final chatPattern = CustomScrollView(
    slivers: [
      SliverFloatingHeader(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  'Today — April 7, 2026',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate(
          _buildChatMessages(),
        ),
      ),
    ],
  );
  print('Built chat date header pattern');

  // Pattern 2: Music player with floating controls
  final musicPattern = CustomScrollView(
    slivers: [
      SliverFloatingHeader(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 4.0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: const Icon(
                  Icons.music_note,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              const SizedBox(width: 12.0),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Now Playing: Midnight Jazz',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'The Blue Quartet',
                      style: TextStyle(color: Colors.white70, fontSize: 11.0),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.skip_previous,
                color: Colors.white.withValues(alpha: 0.7),
                size: 28.0,
              ),
              const SizedBox(width: 8.0),
              Container(
                padding: const EdgeInsets.all(6.0),
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 22.0,
                ),
              ),
              const SizedBox(width: 8.0),
              Icon(
                Icons.skip_next,
                color: Colors.white.withValues(alpha: 0.7),
                size: 28.0,
              ),
            ],
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final trackNames = [
              'Blue Horizon',
              'Cascading Chords',
              'Velvet Night',
              'Gentle Storm',
              'Piano Reverie',
              'Bass Walkdown',
              'Cymbal Whisper',
              'Horn Section Rise',
              'Quiet Improv',
              'Finale Crescendo',
              'Encore: Dawn',
              'Hidden Track',
            ];
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                color: index == 0
                    ? Colors.deepPurple.withValues(alpha: 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: ListTile(
                dense: true,
                leading: Container(
                  width: 32.0,
                  height: 32.0,
                  decoration: BoxDecoration(
                    color: index == 0
                        ? Colors.deepPurple
                        : Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: index == 0
                        ? const Icon(
                            Icons.equalizer,
                            color: Colors.white,
                            size: 16.0,
                          )
                        : Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey.shade600,
                            ),
                          ),
                  ),
                ),
                title: Text(
                  trackNames[index % trackNames.length],
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight:
                        index == 0 ? FontWeight.bold : FontWeight.normal,
                    color: index == 0 ? Colors.deepPurple : null,
                  ),
                ),
                subtitle: Text(
                  '${3 + index % 3}:${(15 + index * 7) % 60}${(15 + index * 7) % 60 < 10 ? '0' : ''}',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.grey.shade500,
                  ),
                ),
                trailing: Icon(
                  Icons.more_horiz,
                  color: Colors.grey.shade400,
                  size: 20.0,
                ),
              ),
            );
          },
          childCount: 12,
        ),
      ),
    ],
  );
  print('Built music player floating controls pattern');

  // Pattern 3: Filter toolbar in e-commerce
  final filterPattern = CustomScrollView(
    slivers: [
      SliverFloatingHeader(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('All', true, Colors.teal),
                _buildFilterChip('Electronics', false, Colors.blue),
                _buildFilterChip('Books', false, Colors.green),
                _buildFilterChip('Clothing', false, Colors.orange),
                _buildFilterChip('Home', false, Colors.purple),
                _buildFilterChip('Sports', false, Colors.red),
                _buildFilterChip('Toys', false, Colors.pink),
              ],
            ),
          ),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.all(12.0),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 1.3,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final itemColors = [
                Colors.teal.shade50,
                Colors.blue.shade50,
                Colors.green.shade50,
                Colors.orange.shade50,
                Colors.purple.shade50,
                Colors.red.shade50,
              ];
              final itemIcons = [
                Icons.laptop,
                Icons.book,
                Icons.checkroom,
                Icons.home,
                Icons.sports_soccer,
                Icons.toys,
                Icons.headphones,
                Icons.watch,
                Icons.camera,
                Icons.phone_android,
              ];
              return Container(
                decoration: BoxDecoration(
                  color: itemColors[index % itemColors.length],
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color:
                        itemColors[index % itemColors.length].withValues(
                          alpha: 0.5,
                        ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      itemIcons[index % itemIcons.length],
                      size: 28.0,
                      color: Colors.grey.shade700,
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      'Product ${index + 1}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      '\$${(9.99 + index * 5.5).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.teal.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
            childCount: 20,
          ),
        ),
      ),
    ],
  );
  print('Built filter toolbar pattern');

  // ============================================================
  // SECTION 8: Summary & Reference
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.check_circle,
      'text': 'SliverFloatingHeader wraps any widget as a floating header',
      'color': Colors.green,
    },
    {
      'icon': Icons.check_circle,
      'text': 'Header hides on forward scroll, reappears on reverse scroll',
      'color': Colors.green,
    },
    {
      'icon': Icons.check_circle,
      'text': 'Only works inside CustomScrollView as a sliver',
      'color': Colors.green,
    },
    {
      'icon': Icons.check_circle,
      'text': 'Can have multiple floating headers in one scroll view',
      'color': Colors.green,
    },
    {
      'icon': Icons.lightbulb_outline,
      'text': 'Use for nav bars, search bars, filter toolbars, date headers',
      'color': Colors.amber,
    },
    {
      'icon': Icons.lightbulb_outline,
      'text': 'Simpler API than SliverAppBar(floating:true) for basic cases',
      'color': Colors.amber,
    },
    {
      'icon': Icons.warning_amber,
      'text': 'No min/max extent control — for that use SliverPersistentHeader',
      'color': Colors.orange,
    },
    {
      'icon': Icons.warning_amber,
      'text': 'No snap behavior — for snapping use SliverAppBar(snap:true)',
      'color': Colors.orange,
    },
  ];

  final summaryCards = <Widget>[];
  for (final pt in summaryPoints) {
    final color = pt['color'] as Color;
    summaryCards.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(pt['icon'] as IconData, color: color, size: 18.0),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                pt['text'] as String,
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

  final referenceTable = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildRefRow('Widget', 'SliverFloatingHeader'),
      _buildRefRow('Library', 'package:flutter/widgets.dart'),
      _buildRefRow('Parent', 'Must be in CustomScrollView.slivers'),
      _buildRefRow('Child', 'Any single Widget'),
      _buildRefRow('Behavior', 'Float-on-reverse-scroll'),
      _buildRefRow('Alternative', 'SliverAppBar(floating: true)'),
      _buildRefRow('Use case', 'Toolbar that hides/shows on scroll direction'),
    ],
  );

  // ============================================================
  // ASSEMBLE TABBED LAYOUT
  // ============================================================
  print('=== Assembling tabbed layout with 8 tabs ===');
  print('SliverFloatingHeader Deep Demo complete');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('SliverFloatingHeader Deep Demo'),
        backgroundColor: Colors.indigo,
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
            Tab(text: 'Basic Float'),
            Tab(text: 'Rich Header'),
            Tab(text: 'Multi Headers'),
            Tab(text: 'Comparison'),
            Tab(text: 'Patterns'),
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
                        Colors.indigo.withValues(alpha: 0.12),
                        Colors.indigo.withValues(alpha: 0.04),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.vertical_align_top,
                        size: 48.0,
                        color: Colors.indigo,
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'SliverFloatingHeader',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        'A sliver that floats its child header back into '
                        'view when scrolling reverses direction.',
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
                const Text(
                  'Constructor Parameters',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  'SliverFloatingHeader has a minimal API — just the '
                  'child widget. The floating behavior is built-in.',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 16.0),
                ...paramCards,
                constructorSnippet,
              ],
            ),
          ),
          // Tab 3: Basic Float
          basicFloatingDemo,
          // Tab 4: Rich Header
          richHeaderDemo,
          // Tab 5: Multi Headers
          multiHeaderDemo,
          // Tab 6: Comparison
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Header Behavior Comparison',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  'How SliverFloatingHeader compares to other header '
                  'widgets in terms of scroll behavior:',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 16.0),
                ...behaviorCards,
              ],
            ),
          ),
          // Tab 7: Patterns
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Container(
                  color: Colors.indigo.withValues(alpha: 0.05),
                  child: const TabBar(
                    labelColor: Colors.indigo,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.indigo,
                    labelStyle: TextStyle(fontSize: 11.5),
                    tabs: [
                      Tab(text: 'Chat Date'),
                      Tab(text: 'Music Player'),
                      Tab(text: 'Filter Bar'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      chatPattern,
                      musicPattern,
                      filterPattern,
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Tab 8: Summary
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Key Takeaways',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 16.0),
                ...summaryCards,
                const SizedBox(height: 24.0),
                const Text(
                  'Quick Reference',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 12.0),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.indigo.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.indigo.withValues(alpha: 0.12),
                    ),
                  ),
                  child: referenceTable,
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
// HELPER: Build chat messages for the chat pattern
// ============================================================
List<Widget> _buildChatMessages() {
  final messages = <Map<String, dynamic>>[
    {'sender': 'Alice', 'text': 'Hey, have you tried the floating header?', 'isMe': false, 'time': '9:01 AM'},
    {'sender': 'You', 'text': 'Yes! It works great in CustomScrollView.', 'isMe': true, 'time': '9:02 AM'},
    {'sender': 'Alice', 'text': 'Does it reappear instantly on reverse scroll?', 'isMe': false, 'time': '9:03 AM'},
    {'sender': 'You', 'text': 'Exactly — even the tiniest upward gesture brings it back.', 'isMe': true, 'time': '9:04 AM'},
    {'sender': 'Alice', 'text': 'What about performance with large lists?', 'isMe': false, 'time': '9:06 AM'},
    {'sender': 'You', 'text': 'Perfectly fine — it is just one sliver in the viewport.', 'isMe': true, 'time': '9:07 AM'},
    {'sender': 'Alice', 'text': 'Can you have multiple?', 'isMe': false, 'time': '9:10 AM'},
    {'sender': 'You', 'text': 'Yep, each SliverFloatingHeader floats independently.', 'isMe': true, 'time': '9:11 AM'},
    {'sender': 'Alice', 'text': 'That is super useful for section headers!', 'isMe': false, 'time': '9:12 AM'},
    {'sender': 'You', 'text': 'Agreed. Simpler than SliverAppBar for basic cases.', 'isMe': true, 'time': '9:13 AM'},
    {'sender': 'Alice', 'text': 'Thanks for the demo!', 'isMe': false, 'time': '9:15 AM'},
    {'sender': 'You', 'text': 'Anytime. Check out the other tabs too.', 'isMe': true, 'time': '9:16 AM'},
  ];

  return messages.map((m) {
    final isMe = m['isMe'] as bool;
    return Container(
      margin: EdgeInsets.fromLTRB(
        isMe ? 60.0 : 12.0,
        3.0,
        isMe ? 12.0 : 60.0,
        3.0,
      ),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe)
            CircleAvatar(
              radius: 14.0,
              backgroundColor: Colors.teal.shade200,
              child: Text(
                (m['sender'] as String)[0],
                style: const TextStyle(fontSize: 12.0, color: Colors.white),
              ),
            ),
          if (!isMe) const SizedBox(width: 6.0),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color: isMe
                    ? Colors.indigo.shade100
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    m['text'] as String,
                    style: const TextStyle(fontSize: 13.0),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    m['time'] as String,
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }).toList();
}

// ============================================================
// HELPER: Filter chip for the filter pattern
// ============================================================
Widget _buildFilterChip(String label, bool selected, Color color) {
  return Container(
    margin: const EdgeInsets.only(right: 8.0),
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: selected ? color : Colors.grey.shade100,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(
        color: selected ? color : Colors.grey.shade300,
      ),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        color: selected ? Colors.white : Colors.grey.shade700,
      ),
    ),
  );
}

// ============================================================
// HELPER: Reference row for the summary table
// ============================================================
Widget _buildRefRow(String label, String value) {
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
