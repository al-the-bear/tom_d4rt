// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — Title
// Demonstrates the Title widget which sets the application title
// displayed in the OS task switcher, browser tab, and accessibility tree.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Title Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.title,
      'title': 'What is Title?',
      'body': 'Title is a widget that sets the application\u0027s title and '
          'primary color for the operating system. On Android it sets '
          'the task-switcher label and header color. On the web it '
          'sets document.title (the browser tab text).',
      'accent': Colors.brown,
    },
    {
      'icon': Icons.phone_android,
      'title': 'Platform Integration',
      'body': 'Title communicates with the platform through system channels. '
          'On Android it calls SystemChrome.setApplicationSwitcherDescription. '
          'On iOS the title appears via accessibility. On web it sets '
          'the HTML document title.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.auto_awesome,
      'title': 'Built Into MaterialApp',
      'body': 'MaterialApp and CupertinoApp internally use Title. When you '
          'set MaterialApp(title: "My App"), it wraps the navigator '
          'with a Title widget. You rarely need to use Title directly.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.palette,
      'title': 'Color Property',
      'body': 'The color parameter sets the primary swatch used by the OS '
          'in the task switcher. On Android, this colors the app\u0027s '
          'header bar in the recent-apps view. It should match your '
          'app\u0027s brand color.',
      'accent': Colors.deepOrange,
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptItems.length; i++) {
    final item = conceptItems[i];
    final accent = item['accent'] as Color;
    print('Concept ${i + 1}: ${item['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accent.withOpacity(0.12), accent.withOpacity(0.03)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: accent.withOpacity(0.3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(item['icon'] as IconData, color: accent, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item['body'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade800,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 2: API
  // ============================================================
  print('=== Section 2: API ===');

  final apiEntries = <Map<String, String>>[
    {
      'name': 'title',
      'type': 'String',
      'desc': 'The application title shown by the OS. On Android it appears '
          'in the task switcher. On web it becomes the browser tab text. '
          'Must not be null.',
    },
    {
      'name': 'color',
      'type': 'Color',
      'desc': 'Primary color for the application in the OS UI. On Android '
          'this colors the task-switcher header bar. Required parameter. '
          'Typically matches your app\u0027s primary brand color.',
    },
    {
      'name': 'child',
      'type': 'Widget',
      'desc': 'The widget below this Title in the tree. Title itself has '
          'no visual output — it only communicates with the platform. '
          'The child is your actual app content.',
    },
  ];

  final apiWidgets = <Widget>[];
  for (var i = 0; i < apiEntries.length; i++) {
    final ae = apiEntries[i];
    print('API ${i + 1}: ${ae['name']}');
    apiWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.brown.withOpacity(0.06)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.brown.withOpacity(0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.brown.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ae['name']!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.brown,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    ae['type']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              ae['desc']!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // A visual showing the Title widget in the widget tree
  final treeViz = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E2E),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Title in the Widget Tree:',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFFA6E3A1),
          ),
        ),
        const SizedBox(height: 8),
        ...[
          'MaterialApp',
          '  \u2514\u2500 Title(title: "My App", color: blue)',
          '      \u2514\u2500 Navigator',
          '          \u2514\u2500 Routes...',
        ].map((line) => Text(
              line,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Color(0xFFCDD6F4),
                height: 1.5,
              ),
            )),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Platform Behaviors
  // ============================================================
  print('=== Section 3: Platform Behaviors ===');

  final platformData = <Map<String, dynamic>>[
    {
      'platform': 'Android',
      'icon': Icons.android,
      'color': Colors.green,
      'titleEffect': 'Shows in Recent Apps (task switcher) as the app label',
      'colorEffect': 'Colors the header bar in the task switcher view',
      'notes': 'Uses SystemChrome.setApplicationSwitcherDescription. '
          'Updated whenever Title rebuilds with new values.',
    },
    {
      'platform': 'iOS',
      'icon': Icons.phone_iphone,
      'color': Colors.grey,
      'titleEffect': 'Used by assistive technologies (VoiceOver) to announce the app',
      'colorEffect': 'No visible effect on iOS (no task-switcher header color)',
      'notes': 'iOS does not have a colored task switcher. The title is '
          'primarily for accessibility purposes.',
    },
    {
      'platform': 'Web',
      'icon': Icons.web,
      'color': Colors.blue,
      'titleEffect': 'Sets document.title — appears in the browser tab',
      'colorEffect': 'Sets the theme-color meta tag (colors the browser toolbar on mobile)',
      'notes': 'Browser tab text updates immediately. On mobile Chrome '
          'the address bar can pick up the theme-color.',
    },
    {
      'platform': 'Desktop (Windows/macOS/Linux)',
      'icon': Icons.desktop_windows,
      'color': Colors.purple,
      'titleEffect': 'Sets the window title bar text on some configurations',
      'colorEffect': 'Limited effect — desktop title bars use OS theme colors',
      'notes': 'Desktop behavior varies. Some implementations use the '
          'title for the window title text.',
    },
  ];

  final platformWidgets = <Widget>[];
  for (var i = 0; i < platformData.length; i++) {
    final pd = platformData[i];
    final pColor = pd['color'] as Color;
    print('Platform ${i + 1}: ${pd['platform']}');
    platformWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [pColor.withOpacity(0.08), Colors.transparent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: pColor.withOpacity(0.25)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(pd['icon'] as IconData, color: pColor, size: 24),
                  const SizedBox(width: 10),
                  Text(
                    pd['platform'] as String,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: pColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildPlatformRow('Title Effect', pd['titleEffect'] as String, pColor),
              const SizedBox(height: 6),
              _buildPlatformRow('Color Effect', pd['colorEffect'] as String, pColor),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: pColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  pd['notes'] as String,
                  style: TextStyle(
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade600,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Color Showcase
  // ============================================================
  print('=== Section 4: Color Showcase ===');

  final colorExamples = <Map<String, dynamic>>[
    {'name': 'Blue Brand', 'color': Colors.blue, 'hex': '#2196F3'},
    {'name': 'Red Brand', 'color': Colors.red, 'hex': '#F44336'},
    {'name': 'Green Brand', 'color': Colors.green, 'hex': '#4CAF50'},
    {'name': 'Purple Brand', 'color': Colors.purple, 'hex': '#9C27B0'},
    {'name': 'Orange Brand', 'color': Colors.orange, 'hex': '#FF9800'},
    {'name': 'Teal Brand', 'color': Colors.teal, 'hex': '#009688'},
    {'name': 'Indigo Brand', 'color': Colors.indigo, 'hex': '#3F51B5'},
    {'name': 'Brown Brand', 'color': Colors.brown, 'hex': '#795548'},
  ];

  final colorWidgets = <Widget>[];
  for (var i = 0; i < colorExamples.length; i++) {
    final ce = colorExamples[i];
    final color = ce['color'] as Color;
    print('Color ${i + 1}: ${ce['name']}');
    colorWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            // Simulated task switcher header bar
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(9),
                  topRight: Radius.circular(9),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.apps, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'My ${ce['name']} App',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    ce['hex'] as String,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white.withOpacity(0.7),
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
            // Simulated app content below
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.04),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(9),
                  bottomRight: Radius.circular(9),
                ),
              ),
              child: Text(
                'Title(title: "My ${ce['name']} App", color: ${ce['hex']})',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Composition
  // ============================================================
  print('=== Section 5: Composition ===');

  final compositionItems = <Map<String, dynamic>>[
    {
      'title': 'Inside MaterialApp (auto)',
      'desc': 'MaterialApp creates a Title widget automatically from the '
          'title and color properties. You do not need to add one.',
      'code': 'MaterialApp(\n'
          '  title: "My App",\n'
          '  color: Colors.blue,\n'
          '  // Title widget is created internally\n'
          '  home: MyHomePage(),\n'
          ')',
      'note': 'Recommended for most apps',
      'color': Colors.blue,
    },
    {
      'title': 'Standalone Title',
      'desc': 'Use Title directly when building a custom app shell without '
          'MaterialApp. This is rare but useful for minimal apps.',
      'code': 'Title(\n'
          '  title: "Custom Shell",\n'
          '  color: Colors.teal,\n'
          '  child: MyCustomApp(),\n'
          ')',
      'note': 'For custom app shells only',
      'color': Colors.teal,
    },
    {
      'title': 'Dynamic Title Updates',
      'desc': 'Rebuilding Title with a new title string updates the OS. '
          'Useful for showing the current page name in the browser tab.',
      'code': 'Title(\n'
          '  title: "\\\$currentPageName - My App",\n'
          '  color: Colors.indigo,\n'
          '  child: Navigator(\n'
          '    onGenerateRoute: ...,\n'
          '  ),\n'
          ')',
      'note': 'Good for web apps with deep linking',
      'color': Colors.indigo,
    },
    {
      'title': 'Nested Titles',
      'desc': 'If multiple Title widgets exist in the tree, the deepest '
          'one wins. Inner routes can override the outer title.',
      'code': 'Title(title: "App", color: blue,\n'
          '  child: Title(\n'
          '    title: "Settings - App",\n'
          '    color: blue,\n'
          '    child: SettingsPage(),\n'
          '  ),\n'
          ')',
      'note': 'Inner Title overrides outer for the platform',
      'color': Colors.deepOrange,
    },
  ];

  final compositionWidgets = <Widget>[];
  for (var i = 0; i < compositionItems.length; i++) {
    final ci = compositionItems[i];
    final ciColor = ci['color'] as Color;
    print('Composition ${i + 1}: ${ci['title']}');
    compositionWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: ciColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ciColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      ci['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ciColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: ciColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      ci['note'] as String,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: ciColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                ci['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E2E),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  ci['code'] as String,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: Color(0xFFCDD6F4),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 6: Accessibility
  // ============================================================
  print('=== Section 6: Accessibility ===');

  final a11yItems = <Map<String, dynamic>>[
    {
      'icon': Icons.record_voice_over,
      'title': 'Screen Reader Announcement',
      'body': 'The Title widget sets the semantics label for the window. '
          'When a screen reader user switches to the app, the title '
          'is announced. A clear, descriptive title helps users '
          'understand which app they are in.',
      'tip': 'Use concise, descriptive titles — "Photo Editor" not "App"',
      'color': Colors.blue,
    },
    {
      'icon': Icons.language,
      'title': 'Localized Titles',
      'body': 'Titles should be localized to match the user\u0027s language. '
          'Wrap with Localizations: Title(title: S.of(context).appTitle). '
          'This ensures the task switcher and browser tab show '
          'translated text.',
      'tip': 'Use AppLocalizations for multi-language support',
      'color': Colors.green,
    },
    {
      'icon': Icons.contrast,
      'title': 'Color Contrast',
      'body': 'The color property affects the task-switcher header. Choose '
          'a color with good contrast against the white title text '
          'that the OS renders. Light colors may make text unreadable.',
      'tip': 'Use dark or saturated colors (blue, red, green, not yellow)',
      'color': Colors.deepOrange,
    },
    {
      'icon': Icons.route,
      'title': 'Route-Based Titles',
      'body': 'Update the title as the user navigates routes. This helps '
          'screen readers announce the current page. On web, it helps '
          'users identify tabs in the browser.',
      'tip': 'Pattern: "[PageName] - [AppName]" for each route',
      'color': Colors.purple,
    },
  ];

  final a11yWidgets = <Widget>[];
  for (var i = 0; i < a11yItems.length; i++) {
    final ai = a11yItems[i];
    final aiColor = ai['color'] as Color;
    print('A11y ${i + 1}: ${ai['title']}');
    a11yWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: aiColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: aiColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: aiColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(ai['icon'] as IconData, color: aiColor, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      ai['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: aiColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                ai['body'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: aiColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: aiColor.withOpacity(0.15)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.lightbulb_outline, size: 14, color: aiColor),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        ai['tip'] as String,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: aiColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 7: Patterns
  // ============================================================
  print('=== Section 7: Patterns ===');

  final patternItems = <Map<String, dynamic>>[
    {
      'title': 'Static Title',
      'desc': 'Most common: set once and forget. MaterialApp.title handles it.',
      'code': 'MaterialApp(\n'
          '  title: "My Photo Editor",\n'
          '  color: Colors.blue,\n'
          '  home: EditorScreen(),\n'
          ')',
      'color': Colors.brown,
    },
    {
      'title': 'Page-Aware Title (Web)',
      'desc': 'For web apps, update the browser tab text on each route change.',
      'code': 'Widget build(BuildContext context) {\n'
          '  return Title(\n'
          '    title: "\\\$pageName - My App",\n'
          '    color: Colors.blue,\n'
          '    child: pageContent,\n'
          '  );\n'
          '}',
      'color': Colors.blue,
    },
    {
      'title': 'Document Title (Multi-Window)',
      'desc': 'Desktop apps with multiple windows can set per-window titles.',
      'code': 'Title(\n'
          '  title: "Editor - Document.txt",\n'
          '  color: Colors.teal,\n'
          '  child: DocumentEditor(\n'
          '    file: currentFile,\n'
          '  ),\n'
          ')',
      'color': Colors.teal,
    },
    {
      'title': 'Notification Count',
      'desc': 'Show unread counts in the browser tab — common SaaS pattern.',
      'code': 'Title(\n'
          '  title: unread > 0\n'
          '    ? "(\\\$unread) Messages - App"\n'
          '    : "Messages - App",\n'
          '  color: Colors.indigo,\n'
          '  child: MessagesPage(),\n'
          ')',
      'color': Colors.indigo,
    },
    {
      'title': 'Brand Color Theming',
      'desc': 'Match the Title color to your theme so the task switcher feels branded.',
      'code': 'Title(\n'
          '  title: appName,\n'
          '  color: Theme.of(context).primaryColor,\n'
          '  child: child,\n'
          ')',
      'color': Colors.deepOrange,
    },
  ];

  final patternWidgets = <Widget>[];
  for (var i = 0; i < patternItems.length; i++) {
    final pi = patternItems[i];
    final piColor = pi['color'] as Color;
    print('Pattern ${i + 1}: ${pi['title']}');
    patternWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: piColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: piColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pi['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: piColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                pi['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E2E),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  pi['code'] as String,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: Color(0xFFCDD6F4),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.title,
      'text': 'Title sets the app\u0027s name in the OS task switcher, '
          'browser tab, and accessibility announcements.',
    },
    {
      'icon': Icons.palette,
      'text': 'The color property themes the task-switcher header on Android. '
          'Use a saturated brand color for best visual effect.',
    },
    {
      'icon': Icons.auto_awesome,
      'text': 'MaterialApp creates Title automatically. Use standalone Title '
          'only for custom app shells.',
    },
    {
      'icon': Icons.phone_android,
      'text': 'Behavior varies by platform: Android shows title+color in task '
          'switcher, web sets browser tab, iOS uses accessibility.',
    },
    {
      'icon': Icons.web,
      'text': 'On web, dynamic titles help with tab identification and SEO. '
          'Update per route for best UX.',
    },
    {
      'icon': Icons.record_voice_over,
      'text': 'Keep titles concise and localized. Screen readers announce the '
          'title when users switch to your app.',
    },
  ];

  final summaryWidgets = <Widget>[];
  for (var i = 0; i < summaryPoints.length; i++) {
    final sp = summaryPoints[i];
    print('Summary ${i + 1}: ${(sp['text'] as String).substring(0, 40)}...');
    summaryWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.brown.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.brown.withOpacity(0.15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.brown.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.brown,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                sp['text'] as String,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade800,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ASSEMBLE TABBED LAYOUT
  // ============================================================
  print('Assembling tabbed layout');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.phone_android), text: 'Platform'),
            Tab(icon: Icon(Icons.palette), text: 'Color'),
            Tab(icon: Icon(Icons.layers), text: 'Composition'),
            Tab(icon: Icon(Icons.accessibility), text: 'Accessibility'),
            Tab(icon: Icon(Icons.code), text: 'Patterns'),
            Tab(icon: Icon(Icons.summarize), text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1 — Concept
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Title: sets the app name and color for the OS task switcher, '
                  'browser tab, and accessibility layer.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),
          // Tab 2 — API
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Title has three properties: title, color, and child.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
              treeViz,
            ],
          ),
          // Tab 3 — Platform
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How Title behaves on each platform.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...platformWidgets,
            ],
          ),
          // Tab 4 — Color
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'The color property appears in the Android task switcher header.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...colorWidgets,
            ],
          ),
          // Tab 5 — Composition
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Ways to compose Title into your app architecture.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...compositionWidgets,
            ],
          ),
          // Tab 6 — Accessibility
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Title and assistive technology considerations.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...a11yWidgets,
            ],
          ),
          // Tab 7 — Patterns
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Common patterns for using Title in real apps.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...patternWidgets,
            ],
          ),
          // Tab 8 — Summary
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.brown.withOpacity(0.12),
                      Colors.orange.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about the Title widget.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ...summaryWidgets,
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildPlatformRow(String label, String value, Color color) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 90,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
      Expanded(
        child: Text(
          value,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade700,
            height: 1.3,
          ),
        ),
      ),
    ],
  );
}
