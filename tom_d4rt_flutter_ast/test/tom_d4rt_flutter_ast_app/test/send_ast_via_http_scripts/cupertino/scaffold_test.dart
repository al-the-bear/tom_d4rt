// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo for CupertinoPageScaffold and related
// Cupertino structural widgets (CupertinoNavigationBar, CupertinoTabScaffold,
// CupertinoTabBar). Static AST execution - all preview frames are inline.

// DESIGN PLAN
// ===========
// Goal: build a thorough, hand-authored visual reference for the structural
// widgets that make up an iOS-style Flutter app: CupertinoPageScaffold,
// CupertinoNavigationBar, CupertinoTabScaffold and CupertinoTabBar.
//
// Outer chrome (Material 3 ColorScheme) wraps everything in a scrollable
// timeline. Inside that timeline, every section renders one or more
// "mini-phone" frames (SizedBox of fixed dimensions) that contain real
// Cupertino widgets so the AST evaluator exercises the full Cupertino
// structural tree without any navigation or async work.
//
// Sections:
//   1. Gradient banner + concept legend
//   2. CupertinoPageScaffold anatomy (child / backgroundColor / nav / inset)
//   3. CupertinoNavigationBar variants (leading/middle/trailing, border,
//      padding, automaticallyImplyLeading, transitionBetweenRoutes)
//   4. Mini-app: iOS Settings page (grouped list inside scaffold)
//   5. Mini-app: iOS Contacts list page (cupertino list section)
//   6. Mini-app: iOS Profile page (custom hero + content)
//   7. CupertinoTabScaffold + CupertinoTabBar preview (items, currentIndex,
//      backgroundColor, activeColor, inactiveColor, onTap=null)
//   8. Light vs Dark theming comparison strip (CupertinoColors)
//   9. Recipe book (common scaffold patterns as code-styled cards)
//  10. Glossary of structural-widget properties
//
// The root widget is a StatelessWidget returning MaterialApp -> Scaffold ->
// SingleChildScrollView -> Column. The terminal line is runApp().

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) => const CupertinoScaffoldDemoApp();

// ---------------------------------------------------------------------------
// Root app
// ---------------------------------------------------------------------------

class CupertinoScaffoldDemoApp extends StatelessWidget {
  const CupertinoScaffoldDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('CupertinoPageScaffold Deep Demo executing');
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF0A84FF),
      brightness: Brightness.light,
    );
    final ThemeData theme = ThemeData(useMaterial3: true, colorScheme: scheme);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cupertino Scaffold Deep Demo',
      theme: theme,
      home: Scaffold(
        backgroundColor: scheme.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildHeaderBanner(scheme),
                const SizedBox(height: 28.0),
                _buildSection1Legend(scheme),
                const SizedBox(height: 28.0),
                _buildSection2Anatomy(scheme),
                const SizedBox(height: 28.0),
                _buildSection3NavBars(scheme),
                const SizedBox(height: 28.0),
                _buildSection4SettingsApp(scheme),
                const SizedBox(height: 28.0),
                _buildSection5ContactsApp(scheme),
                const SizedBox(height: 28.0),
                _buildSection6ProfileApp(scheme),
                const SizedBox(height: 28.0),
                _buildSection7TabScaffold(scheme),
                const SizedBox(height: 28.0),
                _buildSection8ThemingCompare(scheme),
                const SizedBox(height: 28.0),
                _buildSection9Recipes(scheme),
                const SizedBox(height: 28.0),
                _buildSection10Glossary(scheme),
                const SizedBox(height: 32.0),
                _buildFooter(scheme),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared layout primitives
// ---------------------------------------------------------------------------

// A reusable mini-phone bezel: SizedBox(height: 600) wrapping a stack of
// status bar + Cupertino content. We use this everywhere so every preview
// has identical dimensions and so the AST evaluator builds the entire
// CupertinoPageScaffold subtree.
Widget _miniPhone({
  required String label,
  required Widget content,
  Color? bezel,
  double height = 600.0,
}) {
  final Color bezelColor = bezel ?? const Color(0xFF1C1C1E);
  return Container(
    margin: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            color: Color(0xFF3C3C43),
          ),
        ),
        const SizedBox(height: 6.0),
        Container(
          width: 280.0,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: bezelColor,
            borderRadius: BorderRadius.circular(36.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.22),
                blurRadius: 18.0,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28.0),
            child: SizedBox(
              height: height,
              width: 264.0,
              child: content,
            ),
          ),
        ),
      ],
    ),
  );
}

// Tiny fake iOS status bar that sits above the navigation bar inside frames.
Widget _statusBar({Brightness brightness = Brightness.light}) {
  final Color fg = brightness == Brightness.light
      ? const Color(0xFF000000)
      : const Color(0xFFFFFFFF);
  return Container(
    height: 28.0,
    padding: const EdgeInsets.symmetric(horizontal: 14.0),
    color: Colors.transparent,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          '9:41',
          style: TextStyle(
            color: fg,
            fontWeight: FontWeight.w600,
            fontSize: 13.0,
          ),
        ),
        Row(
          children: <Widget>[
            Icon(CupertinoIcons.antenna_radiowaves_left_right, color: fg, size: 12.0),
            const SizedBox(width: 4.0),
            Icon(CupertinoIcons.wifi, color: fg, size: 14.0),
            const SizedBox(width: 4.0),
            Icon(CupertinoIcons.battery_full, color: fg, size: 18.0),
          ],
        ),
      ],
    ),
  );
}

// A reusable section header pill.
Widget _sectionTitle(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.40), width: 1.2),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        color: color,
      ),
    ),
  );
}

// A small property chip displayed under each preview.
Widget _propChip(String text, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color.withValues(alpha: 0.35), width: 1.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 10.0,
        color: color,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Header banner
// ---------------------------------------------------------------------------

Widget _buildHeaderBanner(ColorScheme scheme) {
  print('=== Banner: Cupertino Scaffold Deep Demo ===');
  return Container(
    padding: const EdgeInsets.all(26.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF0A84FF),
          Color(0xFF5E5CE6),
          Color(0xFFBF5AF2),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: scheme.primary.withValues(alpha: 0.30),
          blurRadius: 18.0,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 64.0,
          height: 64.0,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.40),
              width: 1.5,
            ),
          ),
          child: const Icon(
            CupertinoIcons.device_phone_portrait,
            color: Colors.white,
            size: 36.0,
          ),
        ),
        const SizedBox(width: 18.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'CupertinoPageScaffold',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 0.2,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Deep visual demo: nav bars, tab bars, mini iOS app frames,\n'
                'theming, recipes and a property glossary.',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.white,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildFooter(ColorScheme scheme) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: scheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Row(
      children: <Widget>[
        Icon(CupertinoIcons.checkmark_seal_fill, color: scheme.primary),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            'End of demo. All previews built statically with Cupertino widgets.',
            style: TextStyle(color: scheme.onSurface, fontSize: 12.5),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 1: Legend + concept cards
// ---------------------------------------------------------------------------

Widget _buildSection1Legend(ColorScheme scheme) {
  print('=== Section 1: Concept legend ===');
  final List<Map<String, dynamic>> cards = <Map<String, dynamic>>[
    <String, dynamic>{
      'title': 'CupertinoPageScaffold',
      'desc': 'Top-level structure for a single iOS page. Hosts a child and\n'
          'an optional navigationBar; manages background color and bottom\n'
          'inset behaviour when the keyboard appears.',
      'icon': CupertinoIcons.square_stack_3d_up,
      'color': const Color(0xFF0A84FF),
    },
    <String, dynamic>{
      'title': 'CupertinoNavigationBar',
      'desc': 'Translucent iOS-style header. Slots leading, middle and\n'
          'trailing widgets, supports borders, padding and automatic back\n'
          'button inference.',
      'icon': CupertinoIcons.rectangle_grid_2x2,
      'color': const Color(0xFF30D158),
    },
    <String, dynamic>{
      'title': 'CupertinoTabScaffold',
      'desc': 'Hosts a tab bar at the bottom and a content area for the\n'
          'currently selected tab. Often combined with CupertinoTabBar.',
      'icon': CupertinoIcons.square_split_2x2,
      'color': const Color(0xFFFF9F0A),
    },
    <String, dynamic>{
      'title': 'CupertinoTabBar',
      'desc': 'iOS-style bottom bar with selectable items. Each item has\n'
          'an icon and label; active/inactive colors are configurable.',
      'icon': CupertinoIcons.rectangle_stack_badge_person_crop,
      'color': const Color(0xFFBF5AF2),
    },
  ];

  final List<Widget> tiles = <Widget>[];
  for (final Map<String, dynamic> c in cards) {
    final Color color = c['color'] as Color;
    tiles.add(
      Container(
        width: 240.0,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color.withValues(alpha: 0.40), width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Icon(c['icon'] as IconData, color: color, size: 22.0),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    c['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Text(
              c['desc'] as String,
              style: const TextStyle(
                fontSize: 11.5,
                height: 1.40,
                color: Color(0xFF3C3C43),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionTitle('=== Section 1: Concept Legend ===', scheme.primary),
      const SizedBox(height: 14.0),
      Wrap(children: tiles),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 2: CupertinoPageScaffold anatomy
// ---------------------------------------------------------------------------

Widget _buildSection2Anatomy(ColorScheme scheme) {
  print('=== Section 2: CupertinoPageScaffold anatomy ===');

  // Frame A: bare child only.
  final Widget frameA = _miniPhone(
    label: 'A. child only',
    content: Column(
      children: <Widget>[
        _statusBar(),
        Expanded(
          child: CupertinoPageScaffold(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(
                    CupertinoIcons.doc_plaintext,
                    size: 56.0,
                    color: CupertinoColors.activeBlue,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Bare scaffold',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Just a child widget',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );

  // Frame B: with navigation bar.
  final Widget frameB = _miniPhone(
    label: 'B. + navigationBar',
    content: Column(
      children: <Widget>[
        _statusBar(),
        Expanded(
          child: CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text('Inbox'),
            ),
            child: ListView(
              children: <Widget>[
                for (int i = 0; i < 6; i++)
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: CupertinoColors.separator,
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          CupertinoIcons.envelope,
                          color: CupertinoColors.activeBlue,
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Subject $i',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                'Lorem ipsum dolor sit amet...',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 11.0,
                                  color: CupertinoColors.systemGrey,
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
          ),
        ),
      ],
    ),
  );

  // Frame C: backgroundColor variant.
  final Widget frameC = _miniPhone(
    label: 'C. + backgroundColor',
    content: Column(
      children: <Widget>[
        _statusBar(),
        Expanded(
          child: CupertinoPageScaffold(
            backgroundColor: CupertinoColors.systemGroupedBackground,
            navigationBar: const CupertinoNavigationBar(
              middle: Text('Grouped'),
            ),
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemBackground,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      for (int i = 0; i < 4; i++)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14.0,
                            vertical: 12.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: CupertinoColors.separator
                                    .withValues(alpha: i == 3 ? 0.0 : 1.0),
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Row ${i + 1}',
                                style: const TextStyle(fontSize: 13.0),
                              ),
                              const Spacer(),
                              const Icon(
                                CupertinoIcons.right_chevron,
                                size: 14.0,
                                color: CupertinoColors.systemGrey,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionTitle(
        '=== Section 2: CupertinoPageScaffold anatomy ===',
        scheme.primary,
      ),
      const SizedBox(height: 8.0),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
        child: Text(
          'Three side-by-side previews showing the core CupertinoPageScaffold\n'
          'properties: a bare child, the same scaffold with navigationBar,\n'
          'and a grouped-background variant.',
          style: TextStyle(fontSize: 12.5, height: 1.4),
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: <Widget>[frameA, frameB, frameC]),
      ),
      const SizedBox(height: 8.0),
      Wrap(
        children: <Widget>[
          _propChip('child', scheme.primary),
          _propChip('navigationBar', scheme.primary),
          _propChip('backgroundColor', scheme.primary),
          _propChip('resizeToAvoidBottomInset', scheme.primary),
        ],
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 3: CupertinoNavigationBar variants
// ---------------------------------------------------------------------------

Widget _buildSection3NavBars(ColorScheme scheme) {
  print('=== Section 3: CupertinoNavigationBar variants ===');

  Widget bareNavFrame() {
    return _miniPhone(
      label: 'A. middle only',
      content: Column(
        children: <Widget>[
          _statusBar(),
          Expanded(
            child: CupertinoPageScaffold(
              navigationBar: const CupertinoNavigationBar(
                middle: Text('Home'),
              ),
              child: const Center(
                child: Text(
                  'middle: Text(...)',
                  style: TextStyle(color: CupertinoColors.systemGrey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget leadingTrailingFrame() {
    return _miniPhone(
      label: 'B. leading + trailing',
      content: Column(
        children: <Widget>[
          _statusBar(),
          Expanded(
            child: CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                leading: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  child: const Icon(CupertinoIcons.back),
                ),
                middle: const Text('Detail'),
                trailing: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  child: const Icon(CupertinoIcons.share),
                ),
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'leading + middle + trailing\nslots filled with CupertinoButton',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget noImplyLeadingFrame() {
    return _miniPhone(
      label: 'C. automaticallyImplyLeading=false',
      content: Column(
        children: <Widget>[
          _statusBar(),
          Expanded(
            child: CupertinoPageScaffold(
              navigationBar: const CupertinoNavigationBar(
                automaticallyImplyLeading: false,
                middle: Text('No back arrow'),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      Icon(
                        CupertinoIcons.nosign,
                        size: 36.0,
                        color: CupertinoColors.systemGrey,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'No back arrow is added even\nwhen pushed onto a route',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget noTransitionFrame() {
    return _miniPhone(
      label: 'D. transitionBetweenRoutes=false',
      content: Column(
        children: <Widget>[
          _statusBar(),
          Expanded(
            child: CupertinoPageScaffold(
              navigationBar: const CupertinoNavigationBar(
                transitionBetweenRoutes: false,
                middle: Text('Static nav'),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      Icon(
                        CupertinoIcons.lock_shield,
                        size: 36.0,
                        color: CupertinoColors.activeBlue,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Nav bar does not animate\nwhen pushing/popping routes',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget borderFrame() {
    return _miniPhone(
      label: 'E. custom border + padding',
      content: Column(
        children: <Widget>[
          _statusBar(),
          Expanded(
            child: CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                border: Border(
                  bottom: BorderSide(
                    color: const Color(0xFFFF9500).withValues(alpha: 0.8),
                    width: 2.0,
                  ),
                ),
                padding: const EdgeInsetsDirectional.only(
                  start: 8.0,
                  end: 8.0,
                ),
                leading: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  child: const Icon(CupertinoIcons.line_horizontal_3),
                ),
                middle: const Text('Styled'),
                trailing: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  child: const Icon(CupertinoIcons.search),
                ),
              ),
              child: const Center(
                child: Text(
                  'Custom Border + padding',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionTitle(
        '=== Section 3: CupertinoNavigationBar variants ===',
        const Color(0xFF30D158),
      ),
      const SizedBox(height: 8.0),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
        child: Text(
          'Five hand-built mini-phone frames covering nav-bar slot usage,\n'
          'automatic back-arrow inference, transitionBetweenRoutes and\n'
          'custom border + padding.',
          style: TextStyle(fontSize: 12.5, height: 1.4),
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            bareNavFrame(),
            leadingTrailingFrame(),
            noImplyLeadingFrame(),
            noTransitionFrame(),
            borderFrame(),
          ],
        ),
      ),
      const SizedBox(height: 8.0),
      Wrap(
        children: <Widget>[
          _propChip('leading', const Color(0xFF30D158)),
          _propChip('middle', const Color(0xFF30D158)),
          _propChip('trailing', const Color(0xFF30D158)),
          _propChip('automaticallyImplyLeading', const Color(0xFF30D158)),
          _propChip('transitionBetweenRoutes', const Color(0xFF30D158)),
          _propChip('border', const Color(0xFF30D158)),
          _propChip('padding', const Color(0xFF30D158)),
          _propChip('backgroundColor', const Color(0xFF30D158)),
        ],
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 4: Settings mini-app
// ---------------------------------------------------------------------------

Widget _buildSection4SettingsApp(ColorScheme scheme) {
  print('=== Section 4: iOS Settings mini-app ===');

  Widget row({
    required IconData icon,
    required Color iconBg,
    required String title,
    String? trailing,
    bool showChevron = true,
    bool isLast = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isLast
                ? CupertinoColors.transparent
                : CupertinoColors.separator,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 28.0,
            height: 28.0,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Icon(icon, color: CupertinoColors.white, size: 18.0),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 14.0),
            ),
          ),
          if (trailing != null)
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Text(
                trailing,
                style: const TextStyle(
                  fontSize: 13.0,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ),
          if (showChevron)
            const Icon(
              CupertinoIcons.right_chevron,
              size: 14.0,
              color: CupertinoColors.systemGrey,
            ),
        ],
      ),
    );
  }

  Widget group(List<Widget> rows) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(children: rows),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionTitle(
        '=== Section 4: iOS Settings mini-app ===',
        const Color(0xFF8E8E93),
      ),
      const SizedBox(height: 8.0),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
        child: Text(
          'A full iOS-style settings page inside a CupertinoPageScaffold with\n'
          'grouped background and a translucent navigation bar.',
          style: TextStyle(fontSize: 12.5, height: 1.4),
        ),
      ),
      Center(
        child: _miniPhone(
          label: 'CupertinoPageScaffold + grouped list',
          content: Column(
            children: <Widget>[
              _statusBar(),
              Expanded(
                child: CupertinoPageScaffold(
                  backgroundColor: CupertinoColors.systemGroupedBackground,
                  navigationBar: const CupertinoNavigationBar(
                    middle: Text('Settings'),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    children: <Widget>[
                      // Profile row
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemBackground,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 56.0,
                              height: 56.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Color(0xFF0A84FF),
                                    Color(0xFF5E5CE6),
                                  ],
                                ),
                              ),
                              child: const Icon(
                                CupertinoIcons.person_fill,
                                color: Colors.white,
                                size: 32.0,
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const <Widget>[
                                  Text(
                                    'Demo User',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  SizedBox(height: 2.0),
                                  Text(
                                    'Apple ID, iCloud, Media & Purchases',
                                    style: TextStyle(
                                      fontSize: 11.0,
                                      color: CupertinoColors.systemGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              CupertinoIcons.right_chevron,
                              size: 14.0,
                              color: CupertinoColors.systemGrey,
                            ),
                          ],
                        ),
                      ),
                      group(<Widget>[
                        row(
                          icon: CupertinoIcons.airplane,
                          iconBg: const Color(0xFFFF9500),
                          title: 'Airplane Mode',
                          showChevron: false,
                          trailing: 'Off',
                        ),
                        row(
                          icon: CupertinoIcons.wifi,
                          iconBg: const Color(0xFF007AFF),
                          title: 'Wi-Fi',
                          trailing: 'Home',
                        ),
                        row(
                          icon: CupertinoIcons.bluetooth,
                          iconBg: const Color(0xFF007AFF),
                          title: 'Bluetooth',
                          trailing: 'On',
                          isLast: true,
                        ),
                      ]),
                      group(<Widget>[
                        row(
                          icon: CupertinoIcons.bell,
                          iconBg: const Color(0xFFFF3B30),
                          title: 'Notifications',
                        ),
                        row(
                          icon: CupertinoIcons.speaker_2_fill,
                          iconBg: const Color(0xFFFF2D55),
                          title: 'Sounds & Haptics',
                        ),
                        row(
                          icon: CupertinoIcons.moon_fill,
                          iconBg: const Color(0xFF5E5CE6),
                          title: 'Focus',
                          isLast: true,
                        ),
                      ]),
                      group(<Widget>[
                        row(
                          icon: CupertinoIcons.lock_fill,
                          iconBg: const Color(0xFF34C759),
                          title: 'Privacy & Security',
                        ),
                        row(
                          icon: CupertinoIcons.cloud_fill,
                          iconBg: const Color(0xFF5AC8FA),
                          title: 'iCloud',
                          isLast: true,
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 5: Contacts mini-app
// ---------------------------------------------------------------------------

Widget _buildSection5ContactsApp(ColorScheme scheme) {
  print('=== Section 5: iOS Contacts mini-app ===');

  final List<Map<String, String>> contacts = <Map<String, String>>[
    <String, String>{'name': 'Alex Andersen', 'sub': 'mobile'},
    <String, String>{'name': 'Beatrice Brown', 'sub': 'work'},
    <String, String>{'name': 'Carlos Cruz', 'sub': 'mobile'},
    <String, String>{'name': 'Diana Diaz', 'sub': 'home'},
    <String, String>{'name': 'Evan Evans', 'sub': 'work'},
    <String, String>{'name': 'Felicia Foster', 'sub': 'mobile'},
    <String, String>{'name': 'George Garcia', 'sub': 'mobile'},
    <String, String>{'name': 'Hannah Hill', 'sub': 'home'},
    <String, String>{'name': 'Ivan Ivanov', 'sub': 'work'},
    <String, String>{'name': 'Jenna Johnson', 'sub': 'mobile'},
  ];

  Widget contactRow(Map<String, String> c, bool isLast) {
    final String name = c['name'] ?? '';
    final String initials = name.isNotEmpty
        ? name
            .split(' ')
            .map((String w) => w.isNotEmpty ? w[0] : '')
            .join()
        : '?';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isLast
                ? CupertinoColors.transparent
                : CupertinoColors.separator,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 36.0,
            height: 36.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFD1D1D6),
            ),
            child: Center(
              child: Text(
                initials,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1C1C1E),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  c['name'] ?? '',
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  c['sub'] ?? '',
                  style: const TextStyle(
                    fontSize: 11.0,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            CupertinoIcons.phone,
            color: CupertinoColors.activeBlue,
            size: 18.0,
          ),
        ],
      ),
    );
  }

  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < contacts.length; i++) {
    rows.add(contactRow(contacts[i], i == contacts.length - 1));
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionTitle(
        '=== Section 5: iOS Contacts mini-app ===',
        const Color(0xFF34C759),
      ),
      const SizedBox(height: 8.0),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
        child: Text(
          'A list-driven CupertinoPageScaffold with leading + trailing buttons\n'
          'in the navigation bar and a long scrollable list of contact rows.',
          style: TextStyle(fontSize: 12.5, height: 1.4),
        ),
      ),
      Center(
        child: _miniPhone(
          label: 'Contacts (leading + trailing + scroll)',
          content: Column(
            children: <Widget>[
              _statusBar(),
              Expanded(
                child: CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    leading: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      child: const Text(
                        'Groups',
                        style: TextStyle(color: CupertinoColors.activeBlue),
                      ),
                    ),
                    middle: const Text('Contacts'),
                    trailing: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      child: const Icon(CupertinoIcons.add),
                    ),
                  ),
                  child: Container(
                    color: CupertinoColors.systemBackground,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        // Search bar lookalike
                        Container(
                          margin: const EdgeInsets.all(10.0),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5E5EA),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: const <Widget>[
                              Icon(
                                CupertinoIcons.search,
                                size: 14.0,
                                color: CupertinoColors.systemGrey,
                              ),
                              SizedBox(width: 6.0),
                              Text(
                                'Search',
                                style: TextStyle(
                                  color: CupertinoColors.systemGrey,
                                  fontSize: 13.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...rows,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 6: Profile mini-app
// ---------------------------------------------------------------------------

Widget _buildSection6ProfileApp(ColorScheme scheme) {
  print('=== Section 6: iOS Profile mini-app ===');

  Widget statColumn(String label, String value, Color color) {
    return Column(
      children: <Widget>[
        Text(
          value,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.0,
            color: CupertinoColors.systemGrey,
          ),
        ),
      ],
    );
  }

  Widget activityRow(IconData icon, String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 32.0,
            height: 32.0,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(icon, color: color, size: 18.0),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(label, style: const TextStyle(fontSize: 13.0)),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionTitle(
        '=== Section 6: iOS Profile mini-app ===',
        const Color(0xFFBF5AF2),
      ),
      const SizedBox(height: 8.0),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
        child: Text(
          'Profile-style page demonstrating a hero header inside a\n'
          'CupertinoPageScaffold with custom backgroundColor and a styled\n'
          'navigation bar.',
          style: TextStyle(fontSize: 12.5, height: 1.4),
        ),
      ),
      Center(
        child: _miniPhone(
          label: 'Profile (hero + stats + activity)',
          content: Column(
            children: <Widget>[
              _statusBar(),
              Expanded(
                child: CupertinoPageScaffold(
                  backgroundColor: const Color(0xFFF2F2F7),
                  navigationBar: CupertinoNavigationBar(
                    backgroundColor:
                        const Color(0xFFF2F2F7).withValues(alpha: 0.85),
                    border: Border(
                      bottom: BorderSide(
                        color: CupertinoColors.separator.withValues(alpha: 0.6),
                        width: 0.4,
                      ),
                    ),
                    leading: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      child: const Icon(CupertinoIcons.back),
                    ),
                    middle: const Text('Profile'),
                    trailing: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      child: const Icon(CupertinoIcons.ellipsis),
                    ),
                  ),
                  child: ListView(
                    children: <Widget>[
                      // Hero block
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 84.0,
                              height: 84.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Color(0xFFBF5AF2),
                                    Color(0xFF0A84FF),
                                  ],
                                ),
                              ),
                              child: const Icon(
                                CupertinoIcons.person_alt_circle,
                                size: 60.0,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            const Text(
                              'Demo User',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const Text(
                              '@demouser',
                              style: TextStyle(
                                color: CupertinoColors.systemGrey,
                              ),
                            ),
                            const SizedBox(height: 14.0),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                statColumn(
                                  'Posts',
                                  '128',
                                  const Color(0xFF0A84FF),
                                ),
                                statColumn(
                                  'Followers',
                                  '2.4k',
                                  const Color(0xFF30D158),
                                ),
                                statColumn(
                                  'Following',
                                  '312',
                                  const Color(0xFFBF5AF2),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Activity card
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemBackground,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Activity',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14.0,
                              ),
                            ),
                            const SizedBox(height: 6.0),
                            activityRow(
                              CupertinoIcons.flame_fill,
                              'Daily streak',
                              '7 days',
                              const Color(0xFFFF9500),
                            ),
                            activityRow(
                              CupertinoIcons.heart_fill,
                              'Likes given',
                              '482',
                              const Color(0xFFFF2D55),
                            ),
                            activityRow(
                              CupertinoIcons.chat_bubble_2_fill,
                              'Messages',
                              '36',
                              const Color(0xFF0A84FF),
                            ),
                            activityRow(
                              CupertinoIcons.star_fill,
                              'Saved items',
                              '14',
                              const Color(0xFFFFD60A),
                            ),
                          ],
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
  );
}

// ---------------------------------------------------------------------------
// Section 7: CupertinoTabScaffold preview
// ---------------------------------------------------------------------------

Widget _buildSection7TabScaffold(ColorScheme scheme) {
  print('=== Section 7: CupertinoTabScaffold preview ===');

  // Build static previews of CupertinoTabScaffold. We never tap anything;
  // currentIndex is fixed and onTap is intentionally null so the AST runner
  // sees the constructed object without requiring callback execution.
  Widget tabFrame(int currentIndex, String label, Color activeColor) {
    return _miniPhone(
      label: 'currentIndex=$currentIndex, active=$label',
      content: Column(
        children: <Widget>[
          _statusBar(),
          Expanded(
            child: CupertinoTabScaffold(
              tabBar: CupertinoTabBar(
                currentIndex: currentIndex,
                activeColor: activeColor,
                inactiveColor: CupertinoColors.systemGrey,
                backgroundColor:
                    CupertinoColors.systemBackground.withValues(alpha: 0.85),
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.house_fill),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.search),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.bell_fill),
                    label: 'Alerts',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.person_fill),
                    label: 'Profile',
                  ),
                ],
              ),
              tabBuilder: (BuildContext context, int index) {
                final List<String> titles = <String>[
                  'Home',
                  'Search',
                  'Alerts',
                  'Profile',
                ];
                final List<IconData> icons = <IconData>[
                  CupertinoIcons.house_fill,
                  CupertinoIcons.search,
                  CupertinoIcons.bell_fill,
                  CupertinoIcons.person_fill,
                ];
                return CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    middle: Text(titles[index]),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          icons[index],
                          size: 64.0,
                          color: activeColor,
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          'Tab #$index',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          titles[index],
                          style: const TextStyle(
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionTitle(
        '=== Section 7: CupertinoTabScaffold preview ===',
        const Color(0xFFFF9F0A),
      ),
      const SizedBox(height: 8.0),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
        child: Text(
          'Three static previews showing different active tabs. onTap is null\n'
          '- this is a render-only preview, not an interactive demo.',
          style: TextStyle(fontSize: 12.5, height: 1.4),
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            tabFrame(0, 'Home', const Color(0xFF0A84FF)),
            tabFrame(1, 'Search', const Color(0xFF30D158)),
            tabFrame(3, 'Profile', const Color(0xFFBF5AF2)),
          ],
        ),
      ),
      const SizedBox(height: 8.0),
      Wrap(
        children: <Widget>[
          _propChip('items', const Color(0xFFFF9F0A)),
          _propChip('currentIndex', const Color(0xFFFF9F0A)),
          _propChip('onTap', const Color(0xFFFF9F0A)),
          _propChip('backgroundColor', const Color(0xFFFF9F0A)),
          _propChip('activeColor', const Color(0xFFFF9F0A)),
          _propChip('inactiveColor', const Color(0xFFFF9F0A)),
        ],
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 8: Light vs Dark theming comparison
// ---------------------------------------------------------------------------

Widget _buildSection8ThemingCompare(ColorScheme scheme) {
  print('=== Section 8: Light vs Dark theming comparison ===');

  // Use CupertinoTheme + CupertinoThemeData to switch brightness. Each
  // frame renders the same scaffold structure under a different theme to
  // illustrate the dynamic-color behaviour of CupertinoColors.
  Widget themedFrame({required Brightness brightness, required String label}) {
    final CupertinoThemeData themeData = CupertinoThemeData(
      brightness: brightness,
      primaryColor: const Color(0xFF0A84FF),
    );
    return _miniPhone(
      label: label,
      bezel: brightness == Brightness.light
          ? const Color(0xFF1C1C1E)
          : const Color(0xFF3A3A3C),
      content: CupertinoTheme(
        data: themeData,
        child: Column(
          children: <Widget>[
            _statusBar(brightness: brightness),
            Expanded(
              child: CupertinoPageScaffold(
                backgroundColor: brightness == Brightness.light
                    ? const Color(0xFFF2F2F7)
                    : const Color(0xFF1C1C1E),
                navigationBar: CupertinoNavigationBar(
                  backgroundColor: (brightness == Brightness.light
                          ? const Color(0xFFF2F2F7)
                          : const Color(0xFF1C1C1E))
                      .withValues(alpha: 0.85),
                  middle: Text(
                    'Theming',
                    style: TextStyle(
                      color: brightness == Brightness.light
                          ? CupertinoColors.black
                          : CupertinoColors.white,
                    ),
                  ),
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(12.0),
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: brightness == Brightness.light
                            ? CupertinoColors.systemBackground
                            : const Color(0xFF2C2C2E),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            label,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.0,
                              color: brightness == Brightness.light
                                  ? const Color(0xFF1C1C1E)
                                  : CupertinoColors.white,
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          Text(
                            'CupertinoColors adapt to the current brightness.\n'
                            'Surfaces, separators and labels swap automatically.',
                            style: TextStyle(
                              fontSize: 11.5,
                              height: 1.35,
                              color: brightness == Brightness.light
                                  ? const Color(0xFF3C3C43)
                                  : const Color(0xFFEBEBF5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    for (int i = 0; i < 4; i++)
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14.0,
                          vertical: 10.0,
                        ),
                        decoration: BoxDecoration(
                          color: brightness == Brightness.light
                              ? CupertinoColors.systemBackground
                              : const Color(0xFF2C2C2E),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              <IconData>[
                                CupertinoIcons.sun_max_fill,
                                CupertinoIcons.moon_fill,
                                CupertinoIcons.cloud_fill,
                                CupertinoIcons.bolt_fill,
                              ][i],
                              color: const Color(0xFF0A84FF),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Text(
                                <String>[
                                  'Light mode',
                                  'Dark mode',
                                  'Automatic',
                                  'High contrast',
                                ][i],
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color: brightness == Brightness.light
                                      ? const Color(0xFF1C1C1E)
                                      : CupertinoColors.white,
                                ),
                              ),
                            ),
                            Icon(
                              CupertinoIcons.right_chevron,
                              size: 14.0,
                              color: brightness == Brightness.light
                                  ? CupertinoColors.systemGrey
                                  : const Color(0xFF8E8E93),
                            ),
                          ],
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
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionTitle(
        '=== Section 8: Light vs Dark theming ===',
        const Color(0xFF5E5CE6),
      ),
      const SizedBox(height: 8.0),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
        child: Text(
          'Same scaffold rendered under CupertinoTheme with Brightness.light\n'
          'and Brightness.dark to visualise color adaptation.',
          style: TextStyle(fontSize: 12.5, height: 1.4),
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            themedFrame(brightness: Brightness.light, label: 'Light theme'),
            themedFrame(brightness: Brightness.dark, label: 'Dark theme'),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 9: Recipe book
// ---------------------------------------------------------------------------

Widget _buildSection9Recipes(ColorScheme scheme) {
  print('=== Section 9: Recipes ===');

  Widget recipeCard({
    required String title,
    required String when,
    required String code,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.45), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 10.0,
            ),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.22),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
            ),
            child: Row(
              children: <Widget>[
                Icon(icon, color: color, size: 18.0),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w700,
                      fontSize: 13.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14.0, 10.0, 14.0, 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'When: $when',
                  style: const TextStyle(
                    color: Color(0xFFE5E5EA),
                    fontSize: 11.5,
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C2C2E),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    code,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.5,
                      height: 1.4,
                      color: Color(0xFF34C759),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionTitle(
        '=== Section 9: Recipe book ===',
        const Color(0xFF5AC8FA),
      ),
      const SizedBox(height: 8.0),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
        child: Text(
          'A small recipe collection: common iOS-style scaffold compositions\n'
          'that you can copy directly into your own code.',
          style: TextStyle(fontSize: 12.5, height: 1.4),
        ),
      ),
      recipeCard(
        title: 'Recipe 1: Simple titled page',
        when: 'You only need a header with a title and scrollable content.',
        color: const Color(0xFF0A84FF),
        icon: CupertinoIcons.doc_text,
        code: 'CupertinoPageScaffold(\n'
            '  navigationBar: const CupertinoNavigationBar(\n'
            '    middle: Text("Inbox"),\n'
            '  ),\n'
            '  child: ListView(children: items),\n'
            ');',
      ),
      recipeCard(
        title: 'Recipe 2: Detail page with back + action',
        when: 'A pushed page that needs an explicit action in the trailing slot.',
        color: const Color(0xFF30D158),
        icon: CupertinoIcons.square_arrow_right,
        code: 'CupertinoPageScaffold(\n'
            '  navigationBar: CupertinoNavigationBar(\n'
            '    leading: CupertinoButton(\n'
            '      padding: EdgeInsets.zero,\n'
            '      onPressed: () => Navigator.pop(context),\n'
            '      child: const Icon(CupertinoIcons.back),\n'
            '    ),\n'
            '    middle: const Text("Detail"),\n'
            '    trailing: CupertinoButton(\n'
            '      padding: EdgeInsets.zero,\n'
            '      onPressed: onSave,\n'
            '      child: const Text("Save"),\n'
            '    ),\n'
            '  ),\n'
            '  child: body,\n'
            ');',
      ),
      recipeCard(
        title: 'Recipe 3: Grouped settings list',
        when: 'A settings-style screen with a grouped background.',
        color: const Color(0xFFFF9500),
        icon: CupertinoIcons.gear_alt,
        code: 'CupertinoPageScaffold(\n'
            '  backgroundColor: CupertinoColors.systemGroupedBackground,\n'
            '  navigationBar: const CupertinoNavigationBar(\n'
            '    middle: Text("Settings"),\n'
            '  ),\n'
            '  child: ListView(children: groups),\n'
            ');',
      ),
      recipeCard(
        title: 'Recipe 4: Tabbed application shell',
        when: 'The root of an iOS-style app with bottom-tab navigation.',
        color: const Color(0xFFBF5AF2),
        icon: CupertinoIcons.rectangle_grid_2x2,
        code: 'CupertinoTabScaffold(\n'
            '  tabBar: CupertinoTabBar(\n'
            '    items: const <BottomNavigationBarItem>[\n'
            '      BottomNavigationBarItem(\n'
            '        icon: Icon(CupertinoIcons.house_fill),\n'
            '        label: "Home"),\n'
            '      BottomNavigationBarItem(\n'
            '        icon: Icon(CupertinoIcons.person_fill),\n'
            '        label: "Profile"),\n'
            '    ],\n'
            '  ),\n'
            '  tabBuilder: (ctx, i) => buildTab(i),\n'
            ');',
      ),
      recipeCard(
        title: 'Recipe 5: Static (no transition) nav bar',
        when: 'You explicitly want the nav bar to stay in place across routes.',
        color: const Color(0xFFFF2D55),
        icon: CupertinoIcons.lock_shield,
        code: 'CupertinoNavigationBar(\n'
            '  transitionBetweenRoutes: false,\n'
            '  middle: Text("Static"),\n'
            ');',
      ),
      recipeCard(
        title: 'Recipe 6: Keyboard-friendly form',
        when: 'A form-heavy page that should resize when the keyboard appears.',
        color: const Color(0xFFFFD60A),
        icon: CupertinoIcons.keyboard,
        code: 'CupertinoPageScaffold(\n'
            '  resizeToAvoidBottomInset: true,\n'
            '  navigationBar: const CupertinoNavigationBar(\n'
            '    middle: Text("New Message"),\n'
            '  ),\n'
            '  child: form,\n'
            ');',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 10: Glossary
// ---------------------------------------------------------------------------

Widget _buildSection10Glossary(ColorScheme scheme) {
  print('=== Section 10: Glossary ===');

  final List<Map<String, dynamic>> entries = <Map<String, dynamic>>[
    <String, dynamic>{
      'widget': 'CupertinoPageScaffold',
      'prop': 'child',
      'desc': 'The body of the page, drawn below the navigationBar.',
      'color': const Color(0xFF0A84FF),
    },
    <String, dynamic>{
      'widget': 'CupertinoPageScaffold',
      'prop': 'navigationBar',
      'desc': 'Optional top bar; pinned regardless of scroll position.',
      'color': const Color(0xFF0A84FF),
    },
    <String, dynamic>{
      'widget': 'CupertinoPageScaffold',
      'prop': 'backgroundColor',
      'desc': 'Background color; defaults to CupertinoTheme.scaffoldBg.',
      'color': const Color(0xFF0A84FF),
    },
    <String, dynamic>{
      'widget': 'CupertinoPageScaffold',
      'prop': 'resizeToAvoidBottomInset',
      'desc': 'Whether the body should resize when the keyboard appears.',
      'color': const Color(0xFF0A84FF),
    },
    <String, dynamic>{
      'widget': 'CupertinoNavigationBar',
      'prop': 'leading',
      'desc': 'Widget in the left slot. Usually a back button or a label.',
      'color': const Color(0xFF30D158),
    },
    <String, dynamic>{
      'widget': 'CupertinoNavigationBar',
      'prop': 'middle',
      'desc': 'Widget in the centre slot. Typically a page title.',
      'color': const Color(0xFF30D158),
    },
    <String, dynamic>{
      'widget': 'CupertinoNavigationBar',
      'prop': 'trailing',
      'desc': 'Widget in the right slot. Often a button or icon.',
      'color': const Color(0xFF30D158),
    },
    <String, dynamic>{
      'widget': 'CupertinoNavigationBar',
      'prop': 'automaticallyImplyLeading',
      'desc': 'If true, infers a back button when a route can pop.',
      'color': const Color(0xFF30D158),
    },
    <String, dynamic>{
      'widget': 'CupertinoNavigationBar',
      'prop': 'transitionBetweenRoutes',
      'desc': 'If true, the nav bar animates between adjacent routes.',
      'color': const Color(0xFF30D158),
    },
    <String, dynamic>{
      'widget': 'CupertinoNavigationBar',
      'prop': 'border',
      'desc': 'The bottom border of the nav bar; set to null for none.',
      'color': const Color(0xFF30D158),
    },
    <String, dynamic>{
      'widget': 'CupertinoNavigationBar',
      'prop': 'padding',
      'desc': 'Padding applied around the leading/trailing slots.',
      'color': const Color(0xFF30D158),
    },
    <String, dynamic>{
      'widget': 'CupertinoTabScaffold',
      'prop': 'tabBar',
      'desc': 'The bottom tab bar widget (typically CupertinoTabBar).',
      'color': const Color(0xFFFF9F0A),
    },
    <String, dynamic>{
      'widget': 'CupertinoTabScaffold',
      'prop': 'tabBuilder',
      'desc': 'Builds the content for the currently selected tab index.',
      'color': const Color(0xFFFF9F0A),
    },
    <String, dynamic>{
      'widget': 'CupertinoTabBar',
      'prop': 'items',
      'desc': 'A list of BottomNavigationBarItem entries (icon + label).',
      'color': const Color(0xFFBF5AF2),
    },
    <String, dynamic>{
      'widget': 'CupertinoTabBar',
      'prop': 'currentIndex',
      'desc': 'Index of the currently-selected item.',
      'color': const Color(0xFFBF5AF2),
    },
    <String, dynamic>{
      'widget': 'CupertinoTabBar',
      'prop': 'onTap',
      'desc': 'Callback fired when an item is tapped (null in this preview).',
      'color': const Color(0xFFBF5AF2),
    },
    <String, dynamic>{
      'widget': 'CupertinoTabBar',
      'prop': 'activeColor',
      'desc': 'Tint colour applied to the selected item.',
      'color': const Color(0xFFBF5AF2),
    },
    <String, dynamic>{
      'widget': 'CupertinoTabBar',
      'prop': 'inactiveColor',
      'desc': 'Colour for non-selected items.',
      'color': const Color(0xFFBF5AF2),
    },
    <String, dynamic>{
      'widget': 'CupertinoTabBar',
      'prop': 'backgroundColor',
      'desc': 'Translucent background of the tab bar.',
      'color': const Color(0xFFBF5AF2),
    },
  ];

  final List<Widget> rows = <Widget>[];
  for (final Map<String, dynamic> e in entries) {
    final Color color = e['color'] as Color;
    rows.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: color.withValues(alpha: 0.30), width: 1.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 120.0,
              padding: const EdgeInsets.symmetric(
                horizontal: 6.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                e['widget'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Container(
              width: 100.0,
              padding: const EdgeInsets.symmetric(
                horizontal: 6.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                e['prop'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.5,
                  color: color,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                e['desc'] as String,
                style: const TextStyle(fontSize: 11.5, height: 1.40),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionTitle(
        '=== Section 10: Glossary ===',
        const Color(0xFFFF2D55),
      ),
      const SizedBox(height: 8.0),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
        child: Text(
          'Quick reference for every property exercised across the previous\n'
          'sections, grouped visually by parent widget colour.',
          style: TextStyle(fontSize: 12.5, height: 1.4),
        ),
      ),
      ...rows,
    ],
  );
}
