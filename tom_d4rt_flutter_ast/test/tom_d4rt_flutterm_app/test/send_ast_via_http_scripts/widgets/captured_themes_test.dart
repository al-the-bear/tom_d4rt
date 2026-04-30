// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — CapturedThemes
// Demonstrates CapturedThemes, the mechanism that captures
// InheritedTheme data from an ancestor context and wraps a
// subtree so it can access those themes even when detached
// from the original tree (e.g. in routes, overlays, dialogs).
// Covers the capture problem, InheritedTheme.capture(),
// CapturedThemes.of(), route integration, and common patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('CapturedThemes Deep Demo executing');

  // ============================================================
  // SECTION 1: The Problem — Why Capture Themes?
  // ============================================================
  print('=== Section 1: The Problem ===');

  final problemCards = <Map<String, dynamic>>[
    {
      'icon': Icons.route,
      'title': 'Routes Live Outside the Tree',
      'body': 'When you push a new route (showDialog, Navigator.push), '
          'the route\'s widget is inserted into an Overlay above the '
          'Navigator — it does not sit underneath your page\'s widget '
          'subtree. This means InheritedWidgets from the page (Theme, '
          'DefaultTextStyle, IconTheme, etc.) are NOT visible to the '
          'route\'s content by default.',
      'accent': Colors.indigo[700]!,
    },
    {
      'icon': Icons.palette,
      'title': 'Lost Theme Data',
      'body': 'Imagine a page that applies a custom Theme with a '
          'purple color scheme. When you open a dialog from that page, '
          'the dialog may not see purple — it falls back to the app '
          'Theme because the Overlay ancestor has no knowledge of your '
          'page\'s local theme overrides.',
      'accent': Colors.indigo[800]!,
    },
    {
      'icon': Icons.save,
      'title': 'CapturedThemes to the Rescue',
      'body': 'CapturedThemes captures a snapshot of all Inherited'
          'Theme widgets between two contexts (from ancestor down to '
          'current). It then wraps a child widget with those themes, '
          'making them available in any subtree — even one outside '
          'the original tree branch.',
      'accent': Colors.deepPurple[600]!,
    },
    {
      'icon': Icons.architecture,
      'title': 'How the Framework Uses It',
      'body': 'Navigator internally calls InheritedTheme.capture() '
          'when pushing routes, so route transitions automatically '
          'carry the themes from the source page. This is why a '
          'Material page\'s theme usually reaches its dialogs. '
          'CapturedThemes is the container that holds the captured data.',
      'accent': Colors.deepPurple[700]!,
    },
  ];

  print('  Prepared ${problemCards.length} problem cards');

  // ============================================================
  // SECTION 2: How Capture Works — Step by Step
  // ============================================================
  print('=== Section 2: How Capture Works ===');

  final captureSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'title': 'Identify the Source Context',
      'body': 'The context where the route is being pushed from — '
          'this is where the themes are "alive". Every InheritedTheme '
          'above this context is a candidate for capture.',
      'color': Colors.indigo[400]!,
    },
    {
      'step': 2,
      'title': 'Walk Up to Navigator',
      'body': 'InheritedTheme.capture() walks from the source context '
          'up to a specified ancestor context (usually the Navigator\'s '
          'context). It collects every InheritedTheme it encounters.',
      'color': Colors.indigo[500]!,
    },
    {
      'step': 3,
      'title': 'Create CapturedThemes',
      'body': 'The collected themes are stored in a CapturedThemes '
          'object. This object can wrap any widget, re-creating the '
          'InheritedTheme layers around it.',
      'color': Colors.indigo[600]!,
    },
    {
      'step': 4,
      'title': 'Wrap the Route Content',
      'body': 'When the route builds its page, CapturedThemes.wrap() '
          'is called with the route\'s child widget. The child is '
          'nested inside re-created InheritedTheme widgets, so '
          'Theme.of() and similar calls work as expected.',
      'color': Colors.indigo[700]!,
    },
    {
      'step': 5,
      'title': 'Route Sees the Themes',
      'body': 'The dialog/page/overlay content can now call '
          'Theme.of(context) and get the same theme data that '
          'existed at the source context — even though the route '
          'is mounted in the Overlay, not under the original page.',
      'color': Colors.indigo[800]!,
    },
  ];

  print('  Prepared ${captureSteps.length} capture steps');

  // ============================================================
  // SECTION 3: API Surface
  // ============================================================
  print('=== Section 3: API Surface ===');

  final apiMembers = <Map<String, String>>[
    {
      'member': 'InheritedTheme.capture()',
      'signature': 'static CapturedThemes capture(\n'
          '  {required BuildContext from,\n'
          '   required BuildContext? to})',
      'description': 'The factory method. Walks from "from" context '
          'up to "to" context, collecting InheritedTheme widgets. '
          'Returns a CapturedThemes instance. The "to" parameter is '
          'typically the Navigator\'s context.',
    },
    {
      'member': 'CapturedThemes.wrap()',
      'signature': 'Widget wrap(Widget child)',
      'description': 'Wraps the given child widget with the captured '
          'InheritedTheme layers, outermost first. Returns the wrapped '
          'widget tree. This is how route content gets access to the '
          'themes.',
    },
    {
      'member': 'InheritedTheme (abstract)',
      'signature': 'abstract class InheritedTheme\n'
          '  extends InheritedWidget',
      'description': 'The base class for theme InheritedWidgets that '
          'participate in capture. Theme, IconTheme, DefaultTextStyle, '
          'CupertinoTheme all extend InheritedTheme. Custom widgets '
          'can too.',
    },
    {
      'member': 'InheritedTheme.wrap()',
      'signature': 'Widget wrap(BuildContext context,\n'
          '  Widget child)',
      'description': 'Each InheritedTheme subclass implements wrap() — '
          'it creates a new Theme/IconTheme/etc. widget that injects '
          'the captured data. CapturedThemes.wrap() calls each '
          'InheritedTheme.wrap() in order.',
    },
  ];

  print('  Documented ${apiMembers.length} API members');

  // ============================================================
  // SECTION 4: Visual — Theme Capture in Action
  // ============================================================
  print('=== Section 4: Visual Theme Demonstration ===');

  // We'll show what themes look like captured vs non-captured
  // by displaying widgets styled with different theme contexts

  final themeScenarios = <Map<String, dynamic>>[
    {
      'title': 'Page Theme (Source)',
      'description': 'The page applies a deep-purple theme. All '
          'widgets under this page see deepPurple as the primary '
          'color via Theme.of(context).',
      'primaryColor': Colors.deepPurple,
      'textColor': Colors.deepPurple[900]!,
      'bgColor': Colors.deepPurple[50]!,
      'icon': Icons.home,
    },
    {
      'title': 'Dialog With Captured Theme',
      'description': 'A dialog opened from the page, where themes '
          'were captured. The dialog sees deepPurple — it feels '
          'like part of the same visual context.',
      'primaryColor': Colors.deepPurple,
      'textColor': Colors.deepPurple[900]!,
      'bgColor': Colors.deepPurple[50]!,
      'icon': Icons.chat_bubble,
    },
    {
      'title': 'Dialog Without Captured Theme',
      'description': 'A dialog where themes were NOT captured. It '
          'falls back to the app-level default (blue). The visual '
          'disconnect is jarring.',
      'primaryColor': Colors.blue,
      'textColor': Colors.blue[900]!,
      'bgColor': Colors.blue[50]!,
      'icon': Icons.chat_bubble_outline,
    },
  ];

  print('  Prepared ${themeScenarios.length} theme scenarios');

  // ============================================================
  // SECTION 5: Which InheritedThemes Are Captured?
  // ============================================================
  print('=== Section 5: Captured InheritedThemes ===');

  final inheritedThemes = <Map<String, dynamic>>[
    {
      'name': 'Theme (MaterialApp)',
      'icon': Icons.palette,
      'color': Colors.purple[600]!,
      'captures': 'ThemeData — primaryColor, colorScheme, textTheme, '
          'iconTheme, all Material design tokens.',
    },
    {
      'name': 'CupertinoTheme',
      'icon': Icons.phone_iphone,
      'color': Colors.blue[600]!,
      'captures': 'CupertinoThemeData — brightness, primaryColor, '
          'barBackgroundColor, scaffoldBackgroundColor.',
    },
    {
      'name': 'IconTheme',
      'icon': Icons.star,
      'color': Colors.amber[700]!,
      'captures': 'IconThemeData — color, size, opacity. Affects all '
          'Icon widgets below.',
    },
    {
      'name': 'DefaultTextStyle',
      'icon': Icons.text_fields,
      'color': Colors.teal[600]!,
      'captures': 'TextStyle — default font, size, weight, color for '
          'Text widgets that don\'t specify their own style.',
    },
    {
      'name': 'Custom InheritedTheme',
      'icon': Icons.extension,
      'color': Colors.green[600]!,
      'captures': 'Any class extending InheritedTheme that implements '
          'wrap() will be captured automatically. Great for design '
          'system tokens.',
    },
  ];

  print('  Listed ${inheritedThemes.length} InheritedTheme types');

  // ============================================================
  // SECTION 6: Tree Diagram — Before and After Capture
  // ============================================================
  print('=== Section 6: Tree Diagram ===');

  // Visual ASCII-style tree showing widget placement
  final treeBefore = [
    '  MaterialApp',
    '    └── Theme (blue)',
    '        └── Navigator',
    '            ├── Page',
    '            │   └── Theme (purple)',
    '            │       └── Button [pushes dialog]',
    '            └── Overlay',
    '                └── Dialog ← cannot see purple Theme!',
  ];

  final treeAfter = [
    '  MaterialApp',
    '    └── Theme (blue)',
    '        └── Navigator',
    '            ├── Page',
    '            │   └── Theme (purple)',
    '            │       └── Button [pushes dialog]',
    '            └── Overlay',
    '                └── CapturedThemes.wrap()',
    '                    └── Theme (purple) ← re-injected!',
    '                        └── Dialog ← sees purple Theme!',
  ];

  print('  Built tree diagrams');

  // ============================================================
  // SECTION 7: Real-World Patterns
  // ============================================================
  print('=== Section 7: Real-World Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Navigator & Routes (Built-in)',
      'icon': Icons.navigation,
      'color': Colors.indigo[600]!,
      'body': 'Navigator.push automatically captures themes from the '
          'source context. MaterialPageRoute, CupertinoPageRoute, '
          'and DialogRoute all use CapturedThemes internally. You '
          'benefit from this without writing any capture code.',
    },
    {
      'title': 'showDialog / showModalBottomSheet',
      'icon': Icons.open_in_new,
      'color': Colors.deepPurple[500]!,
      'body': 'These convenience functions call Navigator.push with '
          'a DialogRoute that captures themes. This is why a dialog '
          'from a themed page looks right. The capture happens inside '
          'the route implementation.',
    },
    {
      'title': 'Custom Overlay Entries',
      'icon': Icons.layers,
      'color': Colors.purple[500]!,
      'body': 'If you create OverlayEntries manually (tooltips, '
          'dropdowns, popups), you need to capture themes yourself '
          'because there is no Navigator involved:\n\n'
          'final themes = InheritedTheme.capture(\n'
          '  from: context, to: navigator.context);\n'
          'overlay.insert(OverlayEntry(builder: (ctx) {\n'
          '  return themes.wrap(MyPopup());\n'
          '}));',
    },
    {
      'title': 'Design System Tokens',
      'icon': Icons.design_services,
      'color': Colors.teal[600]!,
      'body': 'Custom InheritedTheme subclasses let you capture '
          'design tokens (spacing, border radii, shadows) alongside '
          'Material/Cupertino themes. Implement wrap() to re-create '
          'the provider, and the capture system handles the rest.',
    },
    {
      'title': 'PopupMenuButton Theming',
      'icon': Icons.menu,
      'color': Colors.blue[600]!,
      'body': 'PopupMenuButton opens a route for the menu. Themes '
          'are captured so the popup items match the button\'s '
          'context. Without capture, popup menus might appear with '
          'the wrong colors if the button is inside a themed subtree.',
    },
  ];

  print('  Prepared ${patterns.length} real-world patterns');

  // ============================================================
  // SECTION 8: CapturedThemes vs Theme.of()
  // ============================================================
  print('=== Section 8: CapturedThemes vs Theme.of() ===');

  final comparisonRows = <Map<String, String>>[
    {
      'aspect': 'Scope',
      'captured': 'Captures ALL InheritedThemes '
          '(Theme, IconTheme, DefaultText'
          'Style, CupertinoTheme, custom).',
      'themeOf': 'Returns only the nearest Theme '
          'data. Other InheritedThemes '
          'need separate calls.',
    },
    {
      'aspect': 'Context Requirement',
      'captured': 'Needs source and ancestor '
          'contexts at capture time. Can '
          'be used later in any context.',
      'themeOf': 'Needs a BuildContext that is a '
          'descendant of the Theme widget '
          'at call time.',
    },
    {
      'aspect': 'Use Case',
      'captured': 'Routes, overlays, and detached '
          'subtrees that need full theme '
          'continuity.',
      'themeOf': 'Normal widgets that live in the '
          'same subtree as their Theme '
          'ancestor.',
    },
    {
      'aspect': 'Reactivity',
      'captured': 'Snapshot at capture time. If '
          'the source theme changes later, '
          'the captured version is stale.',
      'themeOf': 'Live lookup. Always returns the '
          'current theme. Rebuilds when '
          'the theme changes.',
    },
    {
      'aspect': 'Framework Usage',
      'captured': 'Used automatically by Navigator, '
          'DialogRoute, ModalRoute. You '
          'rarely call it manually.',
      'themeOf': 'Used everywhere in widget build '
          'methods to style content.',
    },
  ];

  print('  Prepared ${comparisonRows.length} comparison rows');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips & Gotchas ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Usually Automatic',
      'body': 'You rarely need to use CapturedThemes directly. '
          'Navigator routes capture themes automatically. Only '
          'reach for manual capture when creating custom overlay '
          'entries or popup systems.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Snapshot, Not Live',
      'body': 'Captured themes are a snapshot taken at push time. '
          'If the source page\'s theme changes while the dialog '
          'is open, the dialog won\'t update. For live updates '
          'across routes, use a global state management solution.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Custom InheritedTheme',
      'body': 'To participate in capture, your InheritedWidget must '
          'extend InheritedTheme (not InheritedWidget directly) and '
          'implement wrap(). This is the contract that '
          'InheritedTheme.capture() relies on.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Ancestor Context Matters',
      'body': 'The "to" context in capture() defines the upper '
          'boundary. Only themes between "from" and "to" are captured. '
          'If "to" is too low, you miss themes. If it\'s the root, '
          'you capture everything — but that\'s usually wasteful.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Debugging Theme Issues',
      'body': 'If a dialog shows the wrong theme, check whether '
          'the page applies Theme below the Navigator context. '
          'Themes above Navigator are already visible to the '
          'Overlay; themes below need capture.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Builder for Local Themes',
      'body': 'Use Builder to create a context that sits below '
          'a Theme override. Then pass that context to your route '
          'push to ensure the local theme is captured.',
      'severity': 'tip',
    },
  ];

  print('  Prepared ${tips.length} tips');

  // ============================================================
  // BUILD THE VISUAL LAYOUT
  // ============================================================
  print('=== Building visual layout ===');

  return Scaffold(
    backgroundColor: Colors.grey[50],
    appBar: AppBar(
      title: Text('CapturedThemes'),
      backgroundColor: Colors.indigo[700],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header banner ──
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo[700]!, Colors.deepPurple[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.save_alt, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'CapturedThemes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Captures InheritedTheme data from a source context '
                  'and re-injects it into detached subtrees like '
                  'routes, dialogs, and overlays — ensuring visual '
                  'consistency across the widget tree.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 1: The Problem ──
          _sectionTitle('1', 'The Problem — Why Capture Themes?'),
          SizedBox(height: 12),
          ...problemCards.map((card) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                        color: card['accent'] as Color,
                        width: 4,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(card['icon'] as IconData,
                            color: card['accent'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(card['title'] as String,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(card['body'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 2: How Capture Works ──
          _sectionTitle('2', 'How Capture Works — Step by Step'),
          SizedBox(height: 12),
          ...captureSteps.map((step) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: step['color'] as Color,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text('${step['step']}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 3,
                                offset: Offset(0, 1))
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(step['title'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.grey[900])),
                            SizedBox(height: 6),
                            Text(step['body'] as String,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                    height: 1.4)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: API Surface ──
          _sectionTitle('3', 'API Surface'),
          SizedBox(height: 12),
          ...apiMembers.map((m) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.indigo[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.indigo[50],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(m['member']!,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo[900])),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(m['signature']!,
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: Colors.grey[800],
                                height: 1.4)),
                      ),
                      SizedBox(height: 8),
                      Text(m['description']!,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: Theme Capture Visual ──
          _sectionTitle('4', 'Visual — Theme Capture in Action'),
          SizedBox(height: 8),
          Text(
            'Three contexts shown side by side: the source page, a '
            'dialog with captured themes, and a dialog without. '
            'Notice how color consistency breaks without capture.',
            style: TextStyle(
                fontSize: 13, color: Colors.grey[600], height: 1.5),
          ),
          SizedBox(height: 12),
          ...themeScenarios.map((ts) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: ts['bgColor'] as Color,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: (ts['primaryColor'] as MaterialColor)[300]!,
                        width: 2),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(ts['icon'] as IconData,
                            color: ts['primaryColor'] as Color, size: 26),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(ts['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: ts['textColor'] as Color)),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(ts['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: ts['textColor'] as Color,
                              height: 1.4)),
                      SizedBox(height: 12),
                      // Mini "button" styled with the theme color
                      Row(children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: ts['primaryColor'] as Color,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text('Primary Button',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(width: 12),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: ts['primaryColor'] as Color, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text('Outline Button',
                              style: TextStyle(
                                  color: ts['primaryColor'] as Color,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ]),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Captured InheritedThemes ──
          _sectionTitle('5', 'Which InheritedThemes Are Captured?'),
          SizedBox(height: 12),
          ...inheritedThemes.map((it) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: (it['color'] as Color).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(it['icon'] as IconData,
                            color: it['color'] as Color, size: 22),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(it['name'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.grey[900])),
                            SizedBox(height: 4),
                            Text(it['captures'] as String,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                    height: 1.4)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Tree Diagram ──
          _sectionTitle('6', 'Widget Tree — Before & After Capture'),
          SizedBox(height: 12),
          _buildTreeDiagram(
            title: 'WITHOUT Capture (Theme Lost)',
            lines: treeBefore,
            headerColor: Colors.red[600]!,
            bgColor: Colors.red[50]!,
          ),
          SizedBox(height: 16),
          _buildTreeDiagram(
            title: 'WITH Capture (Theme Preserved)',
            lines: treeAfter,
            headerColor: Colors.green[600]!,
            bgColor: Colors.green[50]!,
          ),

          SizedBox(height: 24),

          // ── Section 7: Real-World Patterns ──
          _sectionTitle('7', 'Real-World Patterns'),
          SizedBox(height: 12),
          ...patterns.map((p) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: p['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(p['icon'] as IconData,
                            color: p['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(p['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(p['body'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: CapturedThemes vs Theme.of() comparison ──
          _sectionTitle('8', 'CapturedThemes vs Theme.of()'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2))
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.indigo[700],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(children: [
                    _tCell('Aspect', bold: true, white: true, flex: 2),
                    _tCell('CapturedThemes', bold: true, white: true, flex: 3),
                    _tCell('Theme.of()', bold: true, white: true, flex: 3),
                  ]),
                ),
                ...comparisonRows.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final row = entry.value;
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    color: idx.isEven ? Colors.grey[50] : Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _tCell(row['aspect']!, bold: true, flex: 2),
                        _tCell(row['captured']!, flex: 3),
                        _tCell(row['themeOf']!, flex: 3),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 9: Tips & Gotchas ──
          _sectionTitle('9', 'Tips, Pitfalls & Gotchas'),
          SizedBox(height: 12),
          ...tips.map((tip) {
            Color bgColor;
            Color borderColor;
            switch (tip['severity']) {
              case 'warning':
                bgColor = Colors.amber[50]!;
                borderColor = Colors.amber[400]!;
                break;
              case 'tip':
                bgColor = Colors.green[50]!;
                borderColor = Colors.green[400]!;
                break;
              default:
                bgColor = Colors.blue[50]!;
                borderColor = Colors.blue[300]!;
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                      left: BorderSide(color: borderColor, width: 4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(tip['icon'] as IconData,
                          color: borderColor, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(tip['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.grey[900])),
                      ),
                    ]),
                    SizedBox(height: 6),
                    Text(tip['body'] as String,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[800],
                            height: 1.4)),
                  ],
                ),
              ),
            );
          }),

          SizedBox(height: 32),

          // ── Footer ──
          Center(
            child: Text(
              'End of CapturedThemes Deep Demo',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[400],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    ),
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Section title
// ──────────────────────────────────────────────────────────
Widget _sectionTitle(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.indigo[700],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(number,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Text(title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900])),
      ),
    ],
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Table cell
// ──────────────────────────────────────────────────────────
Widget _tCell(String text,
    {bool bold = false, bool white = false, int flex = 1}) {
  return Expanded(
    flex: flex,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        color: white ? Colors.white : Colors.grey[800],
        height: 1.3,
      ),
    ),
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Tree diagram card
// ──────────────────────────────────────────────────────────
Widget _buildTreeDiagram({
  required String title,
  required List<String> lines,
  required Color headerColor,
  required Color bgColor,
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: headerColor.withOpacity(0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          decoration: BoxDecoration(
            color: headerColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(11),
              topRight: Radius.circular(11),
            ),
          ),
          child: Text(title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13)),
        ),
        Padding(
          padding: EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: lines
                .map((line) => Padding(
                      padding: EdgeInsets.only(bottom: 3),
                      child: Text(line,
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'monospace',
                              color: Colors.grey[800],
                              height: 1.3)),
                    ))
                .toList(),
          ),
        ),
      ],
    ),
  );
}
