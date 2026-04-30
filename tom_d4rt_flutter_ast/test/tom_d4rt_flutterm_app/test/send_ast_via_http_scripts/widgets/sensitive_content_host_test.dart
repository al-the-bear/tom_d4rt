// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SensitiveContentHost
// Demonstrates the SensitiveContentHost singleton — the internal management
// hub that tracks content sensitivity registrations from SensitiveContent
// widgets in the widget tree. Controls whether screens are obscured during
// media projection (screen sharing) on Android API 35+.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ContentSensitivity;

dynamic build(BuildContext context) {
  print('SensitiveContentHost Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.security,
      'title': 'Content Sensitivity Management',
      'body': 'SensitiveContentHost is a singleton that manages content '
          'sensitivity for the entire widget tree. It tracks how many '
          'SensitiveContent widgets are active and their sensitivity '
          'levels, then communicates with the platform to obscure screens '
          'during media projection.',
    },
    {
      'icon': Icons.hub,
      'title': 'Singleton Pattern',
      'body': 'Accessed via SensitiveContentHost.instance, it is the '
          'central registry that all SensitiveContent widgets '
          'register with and unregister from. Only one instance '
          'exists per application.',
    },
    {
      'icon': Icons.android,
      'title': 'Platform Integration',
      'body': 'On Android API 35+, the host communicates with '
          'SensitiveContentService to set the native View content '
          'sensitivity. On other platforms, it is a no-op. The screen '
          'is hidden from screen sharing when set to sensitive.',
    },
    {
      'icon': Icons.construction,
      'title': 'Testing & Experimental',
      'body': 'Marked @visibleForTesting — not yet production-ready. '
          'Known vulnerabilities exist during page transitions where '
          'sensitive content can briefly be visible. Active development '
          'is ongoing (Flutter issues #160050, #164820).',
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
          color: Colors.deepOrange.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.deepOrange.withValues(alpha: 0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(p['icon'] as IconData, color: Colors.deepOrange.shade700, size: 26.0),
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
                      color: Colors.deepOrange.shade700,
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
  // SECTION 2: Architecture
  // ============================================================
  print('=== Section 2: Architecture ===');

  final archLayers = <Map<String, dynamic>>[
    {
      'layer': 'SensitiveContent Widgets',
      'desc': 'Placed in widget tree by developers to mark sensitive areas. '
          'Each registers with the host on initState and unregisters on dispose.',
      'color': Colors.blue,
      'icon': Icons.widgets,
    },
    {
      'layer': 'SensitiveContentHost (Singleton)',
      'desc': 'Tracks widget counts per sensitivity level. Calculates '
          'the effective sensitivity and communicates with the platform.',
      'color': Colors.deepOrange,
      'icon': Icons.hub,
    },
    {
      'layer': '_ContentSensitivitySetting',
      'desc': 'Internal counter tracking how many widgets of each sensitivity '
          'level are registered. Returns the highest priority sensitivity.',
      'color': Colors.purple,
      'icon': Icons.calculate,
    },
    {
      'layer': 'SensitiveContentService',
      'desc': 'Platform channel that communicates with the native Android API. '
          'Calls setContentSensitivity() and getContentSensitivity().',
      'color': Colors.green,
      'icon': Icons.phonelink,
    },
    {
      'layer': 'Android View (API 35+)',
      'desc': 'The native View that hosts the Flutter content. Its content '
          'sensitivity property controls screen obscuring during projection.',
      'color': Colors.teal,
      'icon': Icons.android,
    },
  ];

  final archCards = <Widget>[];
  for (var i = 0; i < archLayers.length; i++) {
    final layer = archLayers[i];
    final color = layer['color'] as Color;
    archCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 2.0),
        child: Row(
          children: [
            Container(
              width: 30.0,
              alignment: Alignment.center,
              child: Column(
                children: [
                  if (i > 0)
                    Container(width: 2, height: 8, color: Colors.grey.shade300),
                  Container(
                    width: 24.0,
                    height: 24.0,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                      border: Border.all(color: color, width: 2.0),
                    ),
                    child: Center(
                      child: Text('${i + 1}',
                          style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700,
                              color: color)),
                    ),
                  ),
                  if (i < archLayers.length - 1)
                    Container(width: 2, height: 8, color: Colors.grey.shade300),
                ],
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: color.withValues(alpha: 0.2)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(layer['icon'] as IconData, size: 18.0, color: color),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(layer['layer'] as String,
                              style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700,
                                  color: color)),
                          const SizedBox(height: 2.0),
                          Text(layer['desc'] as String,
                              style: TextStyle(fontSize: 10.5, color: Colors.grey.shade600,
                                  height: 1.3)),
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

  // ============================================================
  // SECTION 3: ContentSensitivity Enum
  // ============================================================
  print('=== Section 3: ContentSensitivity Enum ===');

  final sensitivityLevels = <Map<String, dynamic>>[
    {
      'level': 'ContentSensitivity.sensitive',
      'priority': '1 (Highest)',
      'color': Colors.red,
      'icon': Icons.shield,
      'behavior': 'Screen is ALWAYS obscured during media projection. '
          'Use for passwords, financial data, personal information.',
      'example': 'Password fields, credit card forms, medical records',
    },
    {
      'level': 'ContentSensitivity.autoSensitive',
      'priority': '2 (Medium)',
      'color': Colors.orange,
      'icon': Icons.auto_fix_high,
      'behavior': 'Platform decides whether to obscure. On Android API 35+, '
          'this is the default behavior — the system may choose to obscure.',
      'example': 'Default app content, general text, non-critical data',
    },
    {
      'level': 'ContentSensitivity.notSensitive',
      'priority': '3 (Lowest)',
      'color': Colors.green,
      'icon': Icons.lock_open,
      'behavior': 'Screen is NEVER obscured during projection. Content is '
          'always visible during screen sharing.',
      'example': 'Public information, marketing, help pages, onboarding',
    },
  ];

  final levelCards = <Widget>[];
  for (final lvl in sensitivityLevels) {
    final color = lvl['color'] as Color;
    levelCards.add(
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
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.06),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(9.0)),
              ),
              child: Row(
                children: [
                  Icon(lvl['icon'] as IconData, color: color, size: 22.0),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lvl['level'] as String,
                          style: TextStyle(fontSize: 12.0, fontFamily: 'monospace',
                              fontWeight: FontWeight.w700, color: color),
                        ),
                        Text(
                          'Priority: ${lvl['priority']}',
                          style: TextStyle(fontSize: 10.0, color: color.withValues(alpha: 0.7)),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lvl['behavior'] as String,
                    style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.35),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.lightbulb_outline, size: 14.0, color: Colors.grey.shade500),
                        const SizedBox(width: 6.0),
                        Expanded(
                          child: Text(
                            'Use cases: ${lvl['example']}',
                            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600,
                                fontStyle: FontStyle.italic),
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
    );
  }

  // ============================================================
  // SECTION 4: Registration Lifecycle
  // ============================================================
  print('=== Section 4: Registration Lifecycle ===');

  final lifecycleSteps = <Map<String, dynamic>>[
    {
      'step': '1. Widget Created',
      'desc': 'SensitiveContent widget enters the tree. initState() '
          'calls SensitiveContentHost.register(sensitivity).',
      'icon': Icons.add_circle_outline,
      'color': Colors.blue,
    },
    {
      'step': '2. Platform Check',
      'desc': 'Host checks _sensitiveContentService.isSupported(). '
          'If not supported (non-Android or API < 35), registration is a no-op.',
      'icon': Icons.verified,
      'color': Colors.purple,
    },
    {
      'step': '3. Fallback Captured',
      'desc': 'On first registration, host captures the current platform '
          'sensitivity as a fallback for when all widgets are removed.',
      'icon': Icons.save,
      'color': Colors.teal,
    },
    {
      'step': '4. Counter Updated',
      'desc': '_ContentSensitivitySetting increments the count for the '
          'requested sensitivity level (sensitive, auto, or notSensitive).',
      'icon': Icons.exposure_plus_1,
      'color': Colors.green,
    },
    {
      'step': '5. Platform Notified',
      'desc': 'If the effective sensitivity changed, host calls '
          'setContentSensitivity() on the platform service.',
      'icon': Icons.send,
      'color': Colors.orange,
    },
    {
      'step': '6. Widget Disposed',
      'desc': 'SensitiveContent.dispose() calls SensitiveContentHost.unregister(). '
          'Counter decremented. If no widgets remain, fallback is restored.',
      'icon': Icons.remove_circle_outline,
      'color': Colors.red,
    },
  ];

  final lifecycleCards = <Widget>[];
  for (var i = 0; i < lifecycleSteps.length; i++) {
    final step = lifecycleSteps[i];
    final color = step['color'] as Color;
    lifecycleCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(8.0),
          border: Border(left: BorderSide(color: color, width: 3.0)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(step['icon'] as IconData, size: 20.0, color: color),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(step['step'] as String,
                      style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: color)),
                  const SizedBox(height: 3.0),
                  Text(step['desc'] as String,
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
  // SECTION 5: Live Demo
  // ============================================================
  print('=== Section 5: Live Demo ===');

  final liveDemo = _SCHLiveDemo();

  // ============================================================
  // SECTION 6: Priority Resolution
  // ============================================================
  print('=== Section 6: Priority Resolution ===');

  final priorityDemo = _SCHPriorityDemo();

  // ============================================================
  // SECTION 7: Patterns
  // ============================================================
  print('=== Section 7: Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Wrapping Sensitive Forms',
      'color': Colors.red,
      'icon': Icons.lock,
      'code': 'SensitiveContent(\n'
          '  sensitivity: ContentSensitivity.sensitive,\n'
          '  child: Column(\n'
          '    children: [\n'
          '      TextField(obscureText: true),  // password\n'
          '      TextField(),  // username\n'
          '      ElevatedButton(onPressed: login),\n'
          '    ],\n'
          '  ),\n'
          ')',
      'desc': 'Wrap the entire login form so the password field plus '
          'all related inputs are obscured during screen sharing.',
    },
    {
      'title': 'Mixed Sensitivity in Routing',
      'color': Colors.orange,
      'icon': Icons.route,
      'code': '// Public page:\n'
          'MaterialPageRoute(\n'
          '  builder: (_) => SensitiveContent(\n'
          '    sensitivity:\n'
          '      ContentSensitivity.notSensitive,\n'
          '    child: AboutPage(),\n'
          '  ),\n'
          ')\n'
          '// Private page:\n'
          'MaterialPageRoute(\n'
          '  builder: (_) => SensitiveContent(\n'
          '    sensitivity:\n'
          '      ContentSensitivity.sensitive,\n'
          '    child: AccountPage(),\n'
          '  ),\n'
          ')',
      'desc': 'Different pages can have different sensitivities. The host '
          'tracks all active widgets and uses the highest priority.',
    },
    {
      'title': 'Checking Host State',
      'color': Colors.purple,
      'icon': Icons.monitor,
      'code': '// In tests or debugging:\n'
          'final host =\n'
          '  SensitiveContentHost.instance;\n'
          'final sensitivity =\n'
          '  host.calculatedContentSensitivity;\n'
          'print(sensitivity);\n'
          '// ContentSensitivity.sensitive\n'
          '// (if any sensitive widgets exist)',
      'desc': 'During testing, inspect the singleton to verify which '
          'sensitivity level is currently active.',
    },
    {
      'title': 'Conditional Sensitivity',
      'color': Colors.blue,
      'icon': Icons.settings_applications,
      'code': 'SensitiveContent(\n'
          '  sensitivity: userSettings.hideData\n'
          '    ? ContentSensitivity.sensitive\n'
          '    : ContentSensitivity.notSensitive,\n'
          '  child: DataDashboard(),\n'
          ')',
      'desc': 'Let users control sensitivity via app settings. The widget '
          'will re-register when the sensitivity property changes.',
    },
  ];

  final patternCards = <Widget>[];
  for (final pat in patterns) {
    final color = pat['color'] as Color;
    patternCards.add(
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
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Text(
                      pat['code'] as String,
                      style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                          color: Colors.grey.shade700),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(pat['desc'] as String,
                      style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600, height: 1.35)),
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
    {'icon': Icons.hub, 'text': 'SensitiveContentHost is a singleton managing content sensitivity'},
    {'icon': Icons.security, 'text': 'Tracks registrations from SensitiveContent widgets in the tree'},
    {'icon': Icons.sort, 'text': 'Priority: sensitive > autoSensitive > notSensitive'},
    {'icon': Icons.android, 'text': 'Only functional on Android API 35+ via SensitiveContentService'},
    {'icon': Icons.construction, 'text': '@visibleForTesting — not production-ready, active development'},
    {'icon': Icons.refresh, 'text': 'Restores fallback sensitivity when all widgets are removed'},
  ];

  final summaryItems = <Widget>[];
  for (final sp in summaryPoints) {
    summaryItems.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(sp['icon'] as IconData, size: 16.0, color: Colors.deepOrange.shade700),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                sp['text'] as String,
                style: TextStyle(fontSize: 12.5, color: Colors.grey.shade800, height: 1.3),
              ),
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
        title: const Text('SensitiveContentHost'),
        backgroundColor: Colors.deepOrange.shade700,
        foregroundColor: Colors.white,
        elevation: 2.0,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'Concept'),
            Tab(text: 'Architecture'),
            Tab(text: 'Sensitivity Levels'),
            Tab(text: 'Lifecycle'),
            Tab(text: 'Live Demo'),
            Tab(text: 'Priority'),
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
                _buildSCHBullet('SensitiveContentHost',
                    'The singleton hub managing screen content sensitivity for '
                    'media projection on Android API 35+.'),
                const SizedBox(height: 14.0),
                ...conceptCards,
              ],
            ),
          ),
          // Tab 2: Architecture
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSCHBullet('Architecture Stack',
                    'How SensitiveContent widgets communicate with the platform.'),
                const SizedBox(height: 14.0),
                ...archCards,
                const SizedBox(height: 14.0),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.amber.shade300),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline, size: 16.0, color: Colors.amber.shade800),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          'The host uses a priority system: if any widget '
                          'requests "sensitive", the entire screen is obscured '
                          'regardless of other widgets requesting lower levels.',
                          style: TextStyle(fontSize: 11.5, color: Colors.amber.shade900,
                              height: 1.35),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Tab 3: Sensitivity Levels
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSCHBullet('ContentSensitivity Values',
                    'Three levels with descending priority.'),
                const SizedBox(height: 14.0),
                ...levelCards,
              ],
            ),
          ),
          // Tab 4: Lifecycle
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSCHBullet('Registration Lifecycle',
                    'How SensitiveContent widgets register and unregister.'),
                const SizedBox(height: 14.0),
                ...lifecycleCards,
              ],
            ),
          ),
          // Tab 5: Live Demo
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSCHBullet('Live Demo',
                    'Wrapping content with SensitiveContent. On non-Android '
                    'platforms, the visual indicators show what would happen.'),
                const SizedBox(height: 14.0),
                liveDemo,
              ],
            ),
          ),
          // Tab 6: Priority
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSCHBullet('Priority Resolution',
                    'How the host resolves conflicting sensitivities from '
                    'multiple SensitiveContent widgets.'),
                const SizedBox(height: 14.0),
                priorityDemo,
              ],
            ),
          ),
          // Tab 7: Patterns
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSCHBullet('Usage Patterns',
                    'Common patterns for using SensitiveContentHost.'),
                const SizedBox(height: 14.0),
                ...patternCards,
              ],
            ),
          ),
          // Tab 8: Summary
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSCHBullet('Key Takeaways', ''),
                const SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepOrange.withValues(alpha: 0.05),
                        Colors.red.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.deepOrange.withValues(alpha: 0.2)),
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
Widget _buildSCHBullet(String title, String body) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.deepOrange.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: Colors.deepOrange.shade700, width: 3.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700,
            color: Colors.deepOrange.shade700)),
        if (body.isNotEmpty) ...[
          const SizedBox(height: 4.0),
          Text(body, style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700, height: 1.4)),
        ],
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Live Demo: SensitiveContent wrapping with visual indicators
// ---------------------------------------------------------------------------
class _SCHLiveDemo extends StatefulWidget {
  @override
  State<_SCHLiveDemo> createState() => _SCHLiveDemoState();
}

class _SCHLiveDemoState extends State<_SCHLiveDemo> {
  ContentSensitivity _selectedSensitivity = ContentSensitivity.sensitive;
  bool _wrapEnabled = true;

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
          const Text(
            'SensitiveContent Wrapping',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6.0),
          Text(
            'Toggle SensitiveContent wrapping and change the sensitivity '
            'level to see how the host manages registrations.',
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600, height: 1.3),
          ),
          const SizedBox(height: 14.0),
          // Controls
          Row(
            children: [
              const Text('Wrap with SensitiveContent: ',
                  style: TextStyle(fontSize: 12.0)),
              Switch(
                value: _wrapEnabled,
                activeColor: Colors.deepOrange,
                onChanged: (v) => setState(() => _wrapEnabled = v),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          // Sensitivity selector
          Row(
            children: [
              const Text('Sensitivity: ', style: TextStyle(fontSize: 12.0)),
              const SizedBox(width: 8.0),
              ...ContentSensitivity.values.map((s) {
                final isSelected = s == _selectedSensitivity;
                final color = s == ContentSensitivity.sensitive
                    ? Colors.red
                    : s == ContentSensitivity.autoSensitive
                        ? Colors.orange
                        : Colors.green;
                return Padding(
                  padding: const EdgeInsets.only(right: 6.0),
                  child: InkWell(
                    onTap: () => setState(() => _selectedSensitivity = s),
                    borderRadius: BorderRadius.circular(6.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        color: isSelected ? color.withValues(alpha: 0.15)
                            : Colors.grey.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(
                          color: isSelected ? color : Colors.grey.shade300,
                          width: isSelected ? 2.0 : 1.0,
                        ),
                      ),
                      child: Text(
                        s.name,
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                          color: isSelected ? color : Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
          const SizedBox(height: 14.0),
          // The content that would be wrapped
          _buildWrappedContent(),
          const SizedBox(height: 12.0),
          // State display
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Generated Widget Tree:',
                    style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700,
                        color: Colors.grey.shade700)),
                const SizedBox(height: 4.0),
                Text(
                  _wrapEnabled
                      ? 'SensitiveContent(\n'
                        '  sensitivity: ContentSensitivity.${_selectedSensitivity.name},\n'
                        '  child: loginForm,\n'
                        ')'
                      : '// No SensitiveContent wrapper\nloginForm',
                  style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                      color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWrappedContent() {
    final sensitiveColor = _selectedSensitivity == ContentSensitivity.sensitive
        ? Colors.red
        : _selectedSensitivity == ContentSensitivity.autoSensitive
            ? Colors.orange
            : Colors.green;

    final content = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_circle, size: 20.0, color: Colors.grey.shade600),
              const SizedBox(width: 8.0),
              Text('Username', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 4.0, bottom: 8.0),
            height: 32.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('user@example.com',
                    style: TextStyle(fontSize: 12.0, color: Colors.grey.shade500)),
              ),
            ),
          ),
          Row(
            children: [
              Icon(Icons.lock, size: 20.0, color: Colors.grey.shade600),
              const SizedBox(width: 8.0),
              Text('Password', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 4.0, bottom: 10.0),
            height: 32.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('••••••••', style: TextStyle(fontSize: 14.0)),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: const Center(
                child: Text('Sign In',
                    style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );

    if (!_wrapEnabled) {
      return content;
    }

    return SensitiveContent(
      sensitivity: _selectedSensitivity,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: sensitiveColor, width: 2.0),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: sensitiveColor.withValues(alpha: 0.1),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
              ),
              child: Row(
                children: [
                  Icon(
                    _selectedSensitivity == ContentSensitivity.sensitive
                        ? Icons.shield
                        : _selectedSensitivity == ContentSensitivity.autoSensitive
                            ? Icons.auto_fix_high
                            : Icons.lock_open,
                    size: 14.0,
                    color: sensitiveColor,
                  ),
                  const SizedBox(width: 6.0),
                  Text(
                    'SensitiveContent: ${_selectedSensitivity.name}',
                    style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700,
                        color: sensitiveColor),
                  ),
                ],
              ),
            ),
            content,
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Priority Resolution Demo
// ---------------------------------------------------------------------------
class _SCHPriorityDemo extends StatelessWidget {
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
          const Text(
            'How Priority Works',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6.0),
          Text(
            'When multiple SensitiveContent widgets coexist, the host '
            'always uses the highest priority level. Sensitive trumps all.',
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600, height: 1.3),
          ),
          const SizedBox(height: 14.0),
          // Scenario 1
          _buildPriorityScenario(
            scenario: 'Scenario 1: Single sensitive widget',
            widgets: ['sensitive'],
            result: 'sensitive',
            resultColor: Colors.red,
            explanation: 'One sensitive widget means the entire screen is obscured.',
          ),
          const SizedBox(height: 10.0),
          // Scenario 2
          _buildPriorityScenario(
            scenario: 'Scenario 2: Mixed levels',
            widgets: ['notSensitive', 'autoSensitive', 'sensitive'],
            result: 'sensitive',
            resultColor: Colors.red,
            explanation: 'Sensitive always wins regardless of other widgets.',
          ),
          const SizedBox(height: 10.0),
          // Scenario 3
          _buildPriorityScenario(
            scenario: 'Scenario 3: Only autoSensitive',
            widgets: ['autoSensitive', 'autoSensitive'],
            result: 'autoSensitive',
            resultColor: Colors.orange,
            explanation: 'No sensitive widgets, so autoSensitive is effective.',
          ),
          const SizedBox(height: 10.0),
          // Scenario 4
          _buildPriorityScenario(
            scenario: 'Scenario 4: Only notSensitive',
            widgets: ['notSensitive'],
            result: 'notSensitive',
            resultColor: Colors.green,
            explanation: 'Screen is never obscured during projection.',
          ),
          const SizedBox(height: 10.0),
          // Scenario 5
          _buildPriorityScenario(
            scenario: 'Scenario 5: No widgets registered',
            widgets: [],
            result: 'fallback',
            resultColor: Colors.grey,
            explanation: 'Restores the platform default (usually autoSensitive).',
          ),
          const SizedBox(height: 14.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Text(
              '// _ContentSensitivitySetting logic:\n'
              'if (sensitiveCount > 0) return sensitive;\n'
              'if (autoSensitiveCount > 0) return autoSensitive;\n'
              'if (notSensitiveCount > 0) return notSensitive;\n'
              'return null; // fallback used',
              style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                  color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityScenario({
    required String scenario,
    required List<String> widgets,
    required String result,
    required Color resultColor,
    required String explanation,
  }) {
    final widgetColors = {
      'sensitive': Colors.red,
      'autoSensitive': Colors.orange,
      'notSensitive': Colors.green,
    };

    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: resultColor.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: resultColor.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(scenario,
              style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700,
                  color: resultColor)),
          const SizedBox(height: 6.0),
          if (widgets.isEmpty)
            Text('(no SensitiveContent widgets)',
                style: TextStyle(fontSize: 10.0, fontStyle: FontStyle.italic,
                    color: Colors.grey.shade500))
          else
            Wrap(
              spacing: 4.0,
              runSpacing: 4.0,
              children: widgets.map((w) {
                final c = widgetColors[w] ?? Colors.grey;
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
                  decoration: BoxDecoration(
                    color: c.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: c.withValues(alpha: 0.3)),
                  ),
                  child: Text(w, style: TextStyle(fontSize: 9.0, fontFamily: 'monospace',
                      color: c, fontWeight: FontWeight.w700)),
                );
              }).toList(),
            ),
          const SizedBox(height: 6.0),
          Row(
            children: [
              Icon(Icons.arrow_forward, size: 12.0, color: resultColor),
              const SizedBox(width: 4.0),
              Text('Effective: ',
                  style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: resultColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(result,
                    style: TextStyle(fontSize: 10.0, fontFamily: 'monospace',
                        fontWeight: FontWeight.w700, color: resultColor)),
              ),
            ],
          ),
          const SizedBox(height: 3.0),
          Text(explanation,
              style: TextStyle(fontSize: 10.0, color: Colors.grey.shade500,
                  fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}
