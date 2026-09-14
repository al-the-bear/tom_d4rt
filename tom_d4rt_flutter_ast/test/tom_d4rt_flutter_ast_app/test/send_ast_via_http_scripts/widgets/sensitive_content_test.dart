// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SensitiveContent
// Demonstrates SensitiveContent — a widget that marks its child (and the
// entire screen) as potentially sensitive content that should be obscured
// during media projection (screen sharing) on Android API 35+.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ContentSensitivity;

dynamic build(BuildContext context) {
  print('SensitiveContent Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.shield,
      'title': 'Screen Obscuring Widget',
      'body': 'SensitiveContent wraps child widgets to declare their '
          'content sensitivity. When a sensitive widget is present, '
          'the ENTIRE screen is obscured during media projection '
          '(screen sharing, screen recording) on Android API 35+.',
    },
    {
      'icon': Icons.auto_fix_high,
      'title': 'Three Sensitivity Levels',
      'body': 'sensitive: always obscure. autoSensitive: platform decides. '
          'notSensitive: never obscure. Multiple widgets with different '
          'levels coexist, and the highest priority wins.',
    },
    {
      'icon': Icons.widgets,
      'title': 'StatefulWidget Lifecycle',
      'body': 'On initState, registers with SensitiveContentHost. On '
          'dispose, unregisters. Uses FutureBuilder internally to wait '
          'for the async platform registration before showing the child.',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Known Limitations',
      'body': 'During page transitions, a frame of sensitive content may '
          'be projected before the screen is obscured. This is a known '
          'vulnerability under active development (Flutter #164820).',
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptPoints.length; i++) {
    final p = conceptPoints[i];
    print('Concept ${i + 1}: ${p['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(p['icon'] as IconData, color: Colors.red.shade700, size: 26.0),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['title'] as String,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.red.shade700,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    p['body'] as String,
                    style: TextStyle(fontSize: 12.5, color: Colors.grey.shade800, height: 1.4),
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

  final ctorParams = <Map<String, dynamic>>[
    {
      'name': 'sensitivity',
      'type': 'ContentSensitivity',
      'required': true,
      'desc': 'The sensitivity level for this content. Determines whether '
          'the screen is obscured during projection.',
    },
    {
      'name': 'child',
      'type': 'Widget',
      'required': true,
      'desc': 'The widget subtree that contains sensitive content. '
          'Note: the ENTIRE screen is obscured, not just this child.',
    },
    {
      'name': 'key',
      'type': 'Key?',
      'required': false,
      'desc': 'Standard widget key for identity.',
    },
  ];

  final paramCards = <Widget>[];
  for (final p in ctorParams) {
    paramCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: (p['required'] as bool)
                    ? Colors.red.withValues(alpha: 0.1)
                    : Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                (p['required'] as bool) ? 'required' : 'optional',
                style: TextStyle(
                  fontSize: 9.0,
                  fontWeight: FontWeight.w700,
                  color: (p['required'] as bool) ? Colors.red : Colors.grey.shade600,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(p['name'] as String,
                          style: TextStyle(fontSize: 12.0, fontFamily: 'monospace',
                              fontWeight: FontWeight.w700, color: Colors.red.shade700)),
                      const SizedBox(width: 6.0),
                      Text(p['type'] as String,
                          style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                              color: Colors.grey.shade500)),
                    ],
                  ),
                  const SizedBox(height: 3.0),
                  Text(p['desc'] as String,
                      style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: Sensitivity Comparison
  // ============================================================
  print('=== Section 3: Sensitivity Comparison ===');

  final comparisonDemo = _SCComparisonDemo();

  // ============================================================
  // SECTION 4: Wrapping Patterns
  // ============================================================
  print('=== Section 4: Wrapping Patterns ===');

  final wrapPatterns = <Map<String, dynamic>>[
    {
      'title': 'Whole Page Wrapping',
      'icon': Icons.fullscreen,
      'color': Colors.red,
      'code': 'Scaffold(\n'
          '  body: SensitiveContent(\n'
          '    sensitivity:\n'
          '      ContentSensitivity.sensitive,\n'
          '    child: AccountDetailsPage(),\n'
          '  ),\n'
          ')',
      'pros': 'Simple, clear intent — entire page is sensitive',
      'cons': 'Cannot have non-sensitive sections on the same page',
    },
    {
      'title': 'Section-Level Wrapping',
      'icon': Icons.view_module,
      'color': Colors.orange,
      'code': 'Column(\n'
          '  children: [\n'
          '    PublicHeader(),\n'
          '    SensitiveContent(\n'
          '      sensitivity:\n'
          '        ContentSensitivity.sensitive,\n'
          '      child: PasswordForm(),\n'
          '    ),\n'
          '    PublicFooter(),\n'
          '  ],\n'
          ')',
      'pros': 'Fine-grained: only marks specific sections',
      'cons': 'Entire screen is still obscured when sensitive widgets exist',
    },
    {
      'title': 'Route-Level Wrapping',
      'icon': Icons.route,
      'color': Colors.purple,
      'code': 'MaterialPageRoute(\n'
          '  builder: (context) =>\n'
          '    SensitiveContent(\n'
          '      sensitivity:\n'
          '        ContentSensitivity.sensitive,\n'
          '      child: SettingsPage(),\n'
          '    ),\n'
          ')',
      'pros': 'Natural for per-page sensitivity; unregisters on route pop',
      'cons': 'Transition frame vulnerability (content briefly visible)',
    },
    {
      'title': 'Dynamic Sensitivity',
      'icon': Icons.swap_vert,
      'color': Colors.teal,
      'code': 'SensitiveContent(\n'
          '  sensitivity: isViewing\n'
          '    ? ContentSensitivity.sensitive\n'
          '    : ContentSensitivity.notSensitive,\n'
          '  child: SecretDocument(),\n'
          ')',
      'pros': 'Sensitivity changes with app state; re-registers automatically',
      'cons': 'Brief platform delay during re-registration',
    },
  ];

  final wrapCards = <Widget>[];
  for (final pat in wrapPatterns) {
    final color = pat['color'] as Color;
    wrapCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.06),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(9.0)),
              ),
              child: Row(
                children: [
                  Icon(pat['icon'] as IconData, size: 18.0, color: color),
                  const SizedBox(width: 8.0),
                  Text(pat['title'] as String,
                      style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: color)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Text(pat['code'] as String,
                        style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                            color: Colors.grey.shade700)),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.check_circle, size: 12.0, color: Colors.green),
                            const SizedBox(width: 4.0),
                            Expanded(
                              child: Text(pat['pros'] as String,
                                  style: TextStyle(fontSize: 10.5, color: Colors.green.shade700)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.info_outline, size: 12.0, color: Colors.amber.shade700),
                            const SizedBox(width: 4.0),
                            Expanded(
                              child: Text(pat['cons'] as String,
                                  style: TextStyle(fontSize: 10.5, color: Colors.amber.shade800)),
                            ),
                          ],
                        ),
                      ),
                    ],
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
  // SECTION 5: Live Demo
  // ============================================================
  print('=== Section 5: Live Demo ===');

  final liveDemo = _SCLiveDemo();

  // ============================================================
  // SECTION 6: Internal Build Method
  // ============================================================
  print('=== Section 6: Internals ===');

  final internalSteps = <Map<String, dynamic>>[
    {
      'step': 'initState()',
      'code': 'SensitiveContentHost.register(\n  widget.sensitivity\n);',
      'desc': 'Async registration with the singleton host. Returns a Future.',
      'color': Colors.blue,
    },
    {
      'step': 'build()',
      'code': 'FutureBuilder<void>(\n'
          '  future: registrationFuture,\n'
          '  builder: (context, snapshot) {\n'
          '    if (snapshot.connectionState\n'
          '        == ConnectionState.done)\n'
          '      return widget.child;\n'
          '    return SizedBox.shrink();\n'
          '  },\n'
          ')',
      'desc': 'Shows nothing (SizedBox.shrink) until platform registration completes. '
          'Then renders the child widget.',
      'color': Colors.green,
    },
    {
      'step': 'didUpdateWidget()',
      'code': 'if (newSensitivity != old) {\n'
          '  register(newSensitivity);\n'
          '  unregister(oldSensitivity);\n'
          '}',
      'desc': 'When sensitivity changes, re-registers with the new level '
          'and unregisters the old one.',
      'color': Colors.orange,
    },
    {
      'step': 'dispose()',
      'code': 'SensitiveContentHost.unregister(\n  widget.sensitivity\n);',
      'desc': 'Removes this widget from the host registry. If no widgets remain, '
          'the fallback sensitivity is restored.',
      'color': Colors.red,
    },
  ];

  final internalCards = <Widget>[];
  for (final step in internalSteps) {
    final color = step['color'] as Color;
    internalCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.06),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(9.0)),
              ),
              child: Text(step['step'] as String,
                  style: TextStyle(fontSize: 12.0, fontFamily: 'monospace',
                      fontWeight: FontWeight.w700, color: color)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(step['code'] as String,
                        style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                            color: Colors.grey.shade700)),
                  ),
                  const SizedBox(height: 6.0),
                  Text(step['desc'] as String,
                      style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600, height: 1.3)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 7: Known Limitations
  // ============================================================
  print('=== Section 7: Limitations ===');

  final limitations = <Map<String, dynamic>>[
    {
      'title': 'Transition Frame Vulnerability',
      'icon': Icons.error_outline,
      'color': Colors.red,
      'desc': 'When navigating to a page with SensitiveContent, one frame '
          'of the new page may be projected before the platform updates. '
          'This can briefly expose sensitive content during screen sharing.',
    },
    {
      'title': 'Whole Screen Obscuring',
      'icon': Icons.fullscreen,
      'color': Colors.orange,
      'desc': 'When sensitive, the ENTIRE screen is obscured, not just the '
          'wrapped child. There is no per-widget obscuring — it is all '
          'or nothing.',
    },
    {
      'title': 'Android API 35+ Only',
      'icon': Icons.android,
      'color': Colors.teal,
      'desc': 'On iOS, macOS, Windows, Linux, and older Android versions, '
          'this widget does nothing. It is a no-op that is forward-compatible.',
    },
    {
      'title': 'Async Registration',
      'icon': Icons.timer,
      'color': Colors.purple,
      'desc': 'Platform communication is async. The child widget is not shown '
          'until registration completes (uses FutureBuilder internally). '
          'This may cause a brief blank frame.',
    },
    {
      'title': 'Not Production-Ready',
      'icon': Icons.construction,
      'color': Colors.grey,
      'desc': 'The API is still under development. SensitiveContentHost is '
          '@visibleForTesting. Breaking changes may occur. See Flutter '
          'issues #160050 and #164820.',
    },
  ];

  final limitCards = <Widget>[];
  for (final lim in limitations) {
    final color = lim['color'] as Color;
    limitCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(8.0),
          border: Border(left: BorderSide(color: color, width: 3.0)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(lim['icon'] as IconData, size: 20.0, color: color),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(lim['title'] as String,
                      style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: color)),
                  const SizedBox(height: 3.0),
                  Text(lim['desc'] as String,
                      style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700, height: 1.35)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {'icon': Icons.shield, 'text': 'SensitiveContent marks content for screen obscuring during projection'},
    {'icon': Icons.widgets, 'text': 'StatefulWidget: registers on init, unregisters on dispose'},
    {'icon': Icons.fullscreen, 'text': 'Entire screen is obscured, not just the wrapped child'},
    {'icon': Icons.swap_vert, 'text': 'Sensitivity can change dynamically (re-registers automatically)'},
    {'icon': Icons.timer, 'text': 'Child hidden until async platform registration completes'},
    {'icon': Icons.android, 'text': 'Android API 35+ only; no-op on other platforms'},
  ];

  final summaryItems = <Widget>[];
  for (final sp in summaryPoints) {
    summaryItems.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(sp['icon'] as IconData, size: 16.0, color: Colors.red.shade700),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(sp['text'] as String,
                  style: TextStyle(fontSize: 12.5, color: Colors.grey.shade800, height: 1.3)),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BUILD TABBED LAYOUT
  // ============================================================
  print('Building tabbed layout');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('SensitiveContent'),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
        elevation: 2.0,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'Concept'),
            Tab(text: 'Constructor'),
            Tab(text: 'Comparison'),
            Tab(text: 'Wrapping'),
            Tab(text: 'Live Demo'),
            Tab(text: 'Internals'),
            Tab(text: 'Limitations'),
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
                _buildSCBullet('SensitiveContent',
                    'Widget that declares content as sensitive for media '
                    'projection protection on Android API 35+.'),
                const SizedBox(height: 14.0),
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
                _buildSCBullet('Constructor Parameters',
                    'SensitiveContent has a minimal constructor.'),
                const SizedBox(height: 14.0),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  margin: const EdgeInsets.only(bottom: 14.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Text(
                    'const SensitiveContent({\n'
                    '  super.key,\n'
                    '  required this.sensitivity,\n'
                    '  required this.child,\n'
                    '})',
                    style: TextStyle(fontSize: 11.5, fontFamily: 'monospace',
                        color: Colors.red.shade700),
                  ),
                ),
                ...paramCards,
              ],
            ),
          ),
          // Tab 3: Comparison
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSCBullet('Sensitivity Level Comparison',
                    'Visual comparison of all three ContentSensitivity levels.'),
                const SizedBox(height: 14.0),
                comparisonDemo,
              ],
            ),
          ),
          // Tab 4: Wrapping
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSCBullet('Wrapping Patterns',
                    'Different strategies for applying SensitiveContent.'),
                const SizedBox(height: 14.0),
                ...wrapCards,
              ],
            ),
          ),
          // Tab 5: Live Demo
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSCBullet('Interactive Demo',
                    'Toggle SensitiveContent wrapping on different content '
                    'sections to see how the widget behaves.'),
                const SizedBox(height: 14.0),
                liveDemo,
              ],
            ),
          ),
          // Tab 6: Internals
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSCBullet('Internal Implementation',
                    'How SensitiveContent manages its lifecycle.'),
                const SizedBox(height: 14.0),
                ...internalCards,
              ],
            ),
          ),
          // Tab 7: Limitations
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSCBullet('Known Limitations',
                    'Current issues and constraints.'),
                const SizedBox(height: 14.0),
                ...limitCards,
              ],
            ),
          ),
          // Tab 8: Summary
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSCBullet('Key Takeaways', ''),
                const SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red.withValues(alpha: 0.05),
                        Colors.deepOrange.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: summaryItems,
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

// ---------------------------------------------------------------------------
// Helper: section bullet
// ---------------------------------------------------------------------------
Widget _buildSCBullet(String title, String body) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.red.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: Colors.red.shade700, width: 3.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700,
            color: Colors.red.shade700)),
        if (body.isNotEmpty) ...[
          const SizedBox(height: 4.0),
          Text(body, style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700, height: 1.4)),
        ],
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Sensitivity Level Comparison
// ---------------------------------------------------------------------------
class _SCComparisonDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Side-by-Side Comparison',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700)),
          const SizedBox(height: 14.0),
          _buildLevel(
            name: 'ContentSensitivity.sensitive',
            icon: Icons.shield,
            color: Colors.red,
            projectionView: 'OBSCURED',
            projectionIcon: Icons.visibility_off,
            description: 'Screen is blank/obscured during sharing. Users see '
                'a placeholder instead of app content.',
            useFor: 'Passwords, financial data, PII, health records',
          ),
          const SizedBox(height: 12.0),
          _buildLevel(
            name: 'ContentSensitivity.autoSensitive',
            icon: Icons.auto_fix_high,
            color: Colors.orange,
            projectionView: 'PLATFORM DECIDES',
            projectionIcon: Icons.help_outline,
            description: 'The platform (Android) decides whether to obscure. '
                'This is the default on API 35+. May or may not hide content.',
            useFor: 'General app content, default behavior',
          ),
          const SizedBox(height: 12.0),
          _buildLevel(
            name: 'ContentSensitivity.notSensitive',
            icon: Icons.lock_open,
            color: Colors.green,
            projectionView: 'FULLY VISIBLE',
            projectionIcon: Icons.visibility,
            description: 'Content is always visible during projection. '
                'Overrides the platform default to ensure visibility.',
            useFor: 'Public info, marketing pages, help & onboarding',
          ),
        ],
      ),
    );
  }

  Widget _buildLevel({
    required String name,
    required IconData icon,
    required Color color,
    required String projectionView,
    required IconData projectionIcon,
    required String description,
    required String useFor,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(9.0)),
            ),
            child: Row(
              children: [
                Icon(icon, size: 18.0, color: color),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(name,
                      style: TextStyle(fontSize: 11.0, fontFamily: 'monospace',
                          fontWeight: FontWeight.w700, color: color)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Normal view
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Colors.blue.withValues(alpha: 0.15)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.phone_android, size: 12.0, color: Colors.blue),
                            const SizedBox(width: 4.0),
                            Text('On Device', style: TextStyle(fontSize: 9.0,
                                fontWeight: FontWeight.w700, color: Colors.blue)),
                          ],
                        ),
                        const SizedBox(height: 6.0),
                        Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.article, size: 16.0, color: Colors.grey.shade400),
                                Text('Content', style: TextStyle(fontSize: 8.0,
                                    color: Colors.grey.shade500)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                // Projected view
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: color.withValues(alpha: 0.15)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.screen_share, size: 12.0, color: color),
                            const SizedBox(width: 4.0),
                            Text('Projected', style: TextStyle(fontSize: 9.0,
                                fontWeight: FontWeight.w700, color: color)),
                          ],
                        ),
                        const SizedBox(height: 6.0),
                        Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: color == Colors.red
                                ? Colors.grey.shade800
                                : color == Colors.orange
                                    ? Colors.orange.withValues(alpha: 0.1)
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(color: color.withValues(alpha: 0.3)),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(projectionIcon, size: 16.0,
                                    color: color == Colors.red
                                        ? Colors.white
                                        : color),
                                Text(projectionView, style: TextStyle(fontSize: 7.0,
                                    fontWeight: FontWeight.w700,
                                    color: color == Colors.red
                                        ? Colors.white
                                        : color)),
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
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(description,
                    style: TextStyle(fontSize: 10.5, color: Colors.grey.shade600, height: 1.3)),
                const SizedBox(height: 4.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.lightbulb_outline, size: 12.0, color: Colors.grey.shade400),
                    const SizedBox(width: 4.0),
                    Expanded(
                      child: Text('Use for: $useFor',
                          style: TextStyle(fontSize: 10.0, fontStyle: FontStyle.italic,
                              color: Colors.grey.shade500)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Live Demo: Multiple SensitiveContent sections
// ---------------------------------------------------------------------------
class _SCLiveDemo extends StatefulWidget {
  @override
  State<_SCLiveDemo> createState() => _SCLiveDemoState();
}

class _SCLiveDemoState extends State<_SCLiveDemo> {
  bool _wrapBanking = true;
  bool _wrapProfile = false;
  bool _wrapPublic = false;
  bool _simulateSharing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Multi-Section Sensitivity Demo',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: _simulateSharing
                      ? Colors.red.withValues(alpha: 0.1)
                      : Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: _simulateSharing ? Colors.red : Colors.grey.shade300,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.screen_share, size: 12.0,
                        color: _simulateSharing ? Colors.red : Colors.grey),
                    const SizedBox(width: 4.0),
                    Text(
                      _simulateSharing ? 'SHARING' : 'Not sharing',
                      style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w700,
                          color: _simulateSharing ? Colors.red : Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Row(
            children: [
              const Text('Simulate screen sharing: ', style: TextStyle(fontSize: 11.0)),
              Switch(
                value: _simulateSharing,
                activeColor: Colors.red,
                onChanged: (v) => setState(() => _simulateSharing = v),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          // Banking section
          _buildSection(
            title: 'Banking Info',
            icon: Icons.account_balance,
            color: Colors.red,
            sensitivity: ContentSensitivity.sensitive,
            isWrapped: _wrapBanking,
            onToggle: (v) => setState(() => _wrapBanking = v),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Account', '****-****-1234'),
                _buildInfoRow('Balance', '\$12,345.67'),
                _buildInfoRow('Routing', '012345678'),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          // Profile section
          _buildSection(
            title: 'Personal Profile',
            icon: Icons.person,
            color: Colors.orange,
            sensitivity: ContentSensitivity.autoSensitive,
            isWrapped: _wrapProfile,
            onToggle: (v) => setState(() => _wrapProfile = v),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Name', 'Jane Smith'),
                _buildInfoRow('Email', 'jane@example.com'),
                _buildInfoRow('Phone', '+1 555-0123'),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          // Public section
          _buildSection(
            title: 'Public Content',
            icon: Icons.public,
            color: Colors.green,
            sensitivity: ContentSensitivity.notSensitive,
            isWrapped: _wrapPublic,
            onToggle: (v) => setState(() => _wrapPublic = v),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Company', 'Acme Corp'),
                _buildInfoRow('Address', '123 Main St'),
                _buildInfoRow('Founded', '2020'),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          // Status summary
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.amber.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, size: 14.0, color: Colors.amber.shade800),
                    const SizedBox(width: 6.0),
                    Text('Active Registrations:',
                        style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700,
                            color: Colors.amber.shade800)),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  'sensitive: ${_wrapBanking ? 1 : 0}  |  '
                  'autoSensitive: ${_wrapProfile ? 1 : 0}  |  '
                  'notSensitive: ${_wrapPublic ? 1 : 0}',
                  style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                      color: Colors.amber.shade900),
                ),
                Text(
                  'Effective: ${_wrapBanking ? "sensitive (screen obscured)" : _wrapProfile ? "autoSensitive (platform decides)" : _wrapPublic ? "notSensitive (visible)" : "fallback/default"}',
                  style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700,
                      color: Colors.amber.shade900),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Color color,
    required ContentSensitivity sensitivity,
    required bool isWrapped,
    required ValueChanged<bool> onToggle,
    required Widget content,
  }) {
    final showAsObscured = _simulateSharing && isWrapped &&
        sensitivity == ContentSensitivity.sensitive;

    Widget sectionContent = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: showAsObscured ? Colors.grey.shade800 : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: showAsObscured ? Colors.grey.shade600 : Colors.grey.shade200),
      ),
      child: showAsObscured
          ? Center(
              child: Column(
                children: [
                  Icon(Icons.visibility_off, size: 24.0, color: Colors.white54),
                  const SizedBox(height: 4.0),
                  Text('Content obscured during sharing',
                      style: TextStyle(fontSize: 10.0, color: Colors.white54)),
                ],
              ),
            )
          : content,
    );

    if (isWrapped) {
      sectionContent = SensitiveContent(
        sensitivity: sensitivity,
        child: sectionContent,
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: isWrapped ? color.withValues(alpha: 0.4) : Colors.grey.shade200,
          width: isWrapped ? 2.0 : 1.0,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: isWrapped ? color.withValues(alpha: 0.06) : Colors.grey.shade50,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(7.0)),
            ),
            child: Row(
              children: [
                Icon(icon, size: 16.0, color: color),
                const SizedBox(width: 6.0),
                Expanded(
                  child: Text(title,
                      style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700,
                          color: color)),
                ),
                Text('${sensitivity.name}: ',
                    style: TextStyle(fontSize: 9.0, color: Colors.grey.shade500)),
                SizedBox(
                  height: 24.0,
                  child: Switch(
                    value: isWrapped,
                    activeColor: color,
                    onChanged: onToggle,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: sectionContent,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 70.0,
            child: Text(label,
                style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700)),
          ),
          Text(value,
              style: TextStyle(fontSize: 11.0, fontFamily: 'monospace',
                  color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}
