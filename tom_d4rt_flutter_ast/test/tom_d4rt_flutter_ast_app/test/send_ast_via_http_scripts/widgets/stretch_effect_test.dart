// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — StretchingOverscrollIndicator / Stretch Effect
// Demonstrates the stretching overscroll effect introduced as the default
// overscroll behavior on Android 12+. Unlike the classic glow indicator,
// the stretch effect deforms the scroll view content itself, pulling it
// as if it were a rubber sheet. This demo covers concepts, configuration,
// platform behavior, and comparison with the classic glow approach.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('StretchEffect Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.expand,
      'title': 'What is the Stretch Effect?',
      'body': 'The stretch overscroll effect visually deforms the scroll '
          'view content when the user scrolls past the edge. Instead of '
          'painting a colored glow overlay, the content itself stretches '
          'and snaps back like a rubber band. This is the default '
          'behavior on Android 12 (API 31) and later.',
      'accent': Colors.cyan,
    },
    {
      'icon': Icons.phone_android,
      'title': 'Platform Default',
      'body': 'On Android 12+, Flutter automatically uses '
          'StretchingOverscrollIndicator instead of the classic '
          'GlowingOverscrollIndicator. On iOS, the rubber-band bounce '
          'of BouncingScrollPhysics handles overscroll natively, so '
          'neither indicator is used.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.compare,
      'title': 'Stretch vs Glow',
      'body': 'The glow effect paints a semi-transparent radial gradient '
          'overlay at the scroll edge. The stretch effect applies a matrix '
          'transform to the entire content viewport, physically distorting '
          'the rendered pixels. Stretch feels more tactile.',
      'accent': Colors.orange,
    },
    {
      'icon': Icons.settings,
      'title': 'Configuration',
      'body': 'The stretch effect is controlled by the ScrollBehavior of '
          'the nearest ScrollConfiguration ancestor. You can override '
          'buildOverscrollIndicator() to switch between stretch and glow, '
          'or disable overscroll indicators entirely.',
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
                child: Icon(e['icon'] as IconData, color: accent, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      e['body'] as String,
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
  // SECTION 2: API Surface
  // ============================================================
  print('=== Section 2: API ===');

  final apiRows = <Map<String, String>>[
    {
      'member': 'StretchingOverscrollIndicator',
      'kind': 'Widget',
      'desc': 'The widget that applies the rubber-sheet stretch transform. '
          'Wraps a scroll view child and intercepts overscroll '
          'notifications to compute the stretch amount.',
    },
    {
      'member': 'axisDirection',
      'kind': 'Property',
      'desc': 'The direction of the scroll axis. Determines which edge '
          'stretches — top/bottom for vertical, left/right for horizontal.',
    },
    {
      'member': 'clipBehavior',
      'kind': 'Property',
      'desc': 'How the content is clipped during stretch. Defaults to '
          'Clip.hardEdge. Set to Clip.none to let stretched content '
          'overflow its bounds.',
    },
    {
      'member': 'notificationPredicate',
      'kind': 'Property',
      'desc': 'A callback that filters which ScrollNotifications trigger '
          'the stretch. Defaults to defaultScrollNotificationPredicate '
          '(depth == 0).',
    },
    {
      'member': 'ScrollBehavior.buildOverscrollIndicator()',
      'kind': 'Method',
      'desc': 'Override this in a custom ScrollBehavior to control '
          'which indicator is used. Return StretchingOverscrollIndicator '
          'or GlowingOverscrollIndicator.',
    },
  ];

  final apiWidgets = <Widget>[];
  for (var i = 0; i < apiRows.length; i++) {
    final row = apiRows[i];
    print('API ${i + 1}: ${row['member']}');
    apiWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.cyan.withOpacity(0.05)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.cyan.withOpacity(0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.cyan.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      row['member']!,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.cyan,
                      ),
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
                    row['kind']!,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              row['desc']!,
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

  // ============================================================
  // SECTION 3: Stretch Visualization
  // ============================================================
  print('=== Section 3: Visualization ===');

  final stretchStages = <Map<String, dynamic>>[
    {
      'label': 'At Rest',
      'desc': 'Content is within scroll bounds. No deformation applied. '
          'Items render at their natural positions.',
      'stretchPct': 0.0,
      'color': Colors.grey,
    },
    {
      'label': 'Light Overscroll (5%)',
      'desc': 'User drags slightly past the edge. Content begins to '
          'stretch. Items near the edge spread apart subtly.',
      'stretchPct': 0.05,
      'color': Colors.cyan,
    },
    {
      'label': 'Medium Overscroll (15%)',
      'desc': 'Noticeable rubber-band deformation. Items at the edge '
          'are clearly separated. The stretch transform is visible.',
      'stretchPct': 0.15,
      'color': Colors.blue,
    },
    {
      'label': 'Heavy Overscroll (30%)',
      'desc': 'Maximum visual stretch. Content looks like a pulled '
          'rubber sheet. Release triggers snap-back animation.',
      'stretchPct': 0.30,
      'color': Colors.deepPurple,
    },
  ];

  final stretchWidgets = <Widget>[];
  for (var i = 0; i < stretchStages.length; i++) {
    final ss = stretchStages[i];
    final ssColor = ss['color'] as Color;
    final pct = ss['stretchPct'] as double;
    print('Stretch ${i + 1}: ${ss['label']}');

    // Build visual simulation: 4 item bars with increasing spacing
    final bars = <Widget>[];
    for (var j = 0; j < 4; j++) {
      final extraSpacing = pct * 10.0 * (j + 1);
      if (j > 0) {
        bars.add(SizedBox(height: 4 + extraSpacing));
      }
      bars.add(
        Container(
          height: 20 + pct * 6,
          decoration: BoxDecoration(
            color: ssColor.withOpacity(0.15 + j * 0.05),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              'Item ${j + 1}',
              style: TextStyle(fontSize: 9, color: ssColor),
            ),
          ),
        ),
      );
    }

    stretchWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: ssColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ssColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.expand, color: ssColor, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        ss['label'] as String,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: ssColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    ss['desc'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade700,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 70,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.withOpacity(0.15)),
              ),
              child: Column(
                children: bars,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Stretch vs Glow Comparison
  // ============================================================
  print('=== Section 4: Comparison ===');

  final compRows = <Map<String, dynamic>>[
    {
      'aspect': 'Visual',
      'stretch': 'Content deforms like rubber',
      'glow': 'Colored gradient overlay at edge',
      'icon': Icons.visibility,
    },
    {
      'aspect': 'Rendering',
      'stretch': 'Matrix transform on viewport',
      'glow': 'Additional paint layer on top',
      'icon': Icons.brush,
    },
    {
      'aspect': 'Platform',
      'stretch': 'Android 12+ default',
      'glow': 'Android < 12 default',
      'icon': Icons.phone_android,
    },
    {
      'aspect': 'Feel',
      'stretch': 'Tactile, physical',
      'glow': 'Subtle, ethereal',
      'icon': Icons.touch_app,
    },
    {
      'aspect': 'Performance',
      'stretch': 'Transform + repaint',
      'glow': 'Overlay paint only',
      'icon': Icons.speed,
    },
    {
      'aspect': 'Content impact',
      'stretch': 'Distorts child widgets',
      'glow': 'Overlays without distortion',
      'icon': Icons.layers,
    },
  ];

  final compWidgets = <Widget>[];
  for (var i = 0; i < compRows.length; i++) {
    final cr = compRows[i];
    print('Compare ${i + 1}: ${cr['aspect']}');
    compWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                cr['icon'] as IconData,
                color: Colors.grey.shade600,
                size: 16,
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 60,
              child: Text(
                cr['aspect'] as String,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  cr['stretch'] as String,
                  style: const TextStyle(fontSize: 10, color: Colors.cyan),
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  cr['glow'] as String,
                  style: const TextStyle(fontSize: 10, color: Colors.orange),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Platform Behavior
  // ============================================================
  print('=== Section 5: Platforms ===');

  final platforms = <Map<String, dynamic>>[
    {
      'platform': 'Android 12+ (API 31+)',
      'behavior': 'StretchingOverscrollIndicator is the default. The '
          'MaterialScrollBehavior returns it from '
          'buildOverscrollIndicator().',
      'icon': Icons.phone_android,
      'color': Colors.green,
    },
    {
      'platform': 'Android < 12',
      'behavior': 'GlowingOverscrollIndicator is the default. The classic '
          'blue/theme-color glow appears at scroll edges.',
      'icon': Icons.phone_android,
      'color': Colors.blue,
    },
    {
      'platform': 'iOS / macOS',
      'behavior': 'BouncingScrollPhysics provides native overscroll bounce. '
          'No overscroll indicator widget is used — the physics '
          'handle everything.',
      'icon': Icons.apple,
      'color': Colors.grey,
    },
    {
      'platform': 'Web / Desktop',
      'behavior': 'Depends on the ScrollBehavior configured by the '
          'framework. MaterialApp typically uses ClampingScrollPhysics '
          'with glow or stretch depending on version.',
      'icon': Icons.desktop_windows,
      'color': Colors.purple,
    },
  ];

  final platformWidgets = <Widget>[];
  for (var i = 0; i < platforms.length; i++) {
    final p = platforms[i];
    final pColor = p['color'] as Color;
    print('Platform ${i + 1}: ${p['platform']}');
    platformWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: pColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: pColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: pColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(p['icon'] as IconData, color: pColor, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['platform'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: pColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    p['behavior'] as String,
                    style: TextStyle(
                      fontSize: 12,
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
  // SECTION 6: Configuration Patterns
  // ============================================================
  print('=== Section 6: Config ===');

  final configs = <Map<String, dynamic>>[
    {
      'title': 'Force Stretch Everywhere',
      'code': 'ScrollConfiguration(\n'
          '  behavior: MyBehavior(), // always stretch\n'
          '  child: ListView(...),\n'
          ')\n\n'
          'class MyBehavior extends ScrollBehavior {\n'
          '  Widget buildOverscrollIndicator(\n'
          '    context, child, details,\n'
          '  ) {\n'
          '    return StretchingOverscrollIndicator(\n'
          '      axisDirection: details.direction,\n'
          '      child: child,\n'
          '    );\n'
          '  }\n'
          '}',
      'note': 'Override ScrollBehavior to force the stretch effect '
          'on all platforms, even pre-Android 12.',
      'color': Colors.cyan,
    },
    {
      'title': 'Disable Overscroll Indicator',
      'code': 'ScrollConfiguration(\n'
          '  behavior: ScrollBehavior().copyWith(\n'
          '    overscroll: false,\n'
          '  ),\n'
          '  child: ListView(...),\n'
          ')',
      'note': 'Remove all overscroll visual effects. Useful for custom '
          'scroll views that handle overscroll manually.',
      'color': Colors.orange,
    },
    {
      'title': 'Force Glow Effect',
      'code': 'ScrollConfiguration(\n'
          '  behavior: MyGlowBehavior(),\n'
          '  child: ListView(...),\n'
          ')\n\n'
          'class MyGlowBehavior extends ScrollBehavior {\n'
          '  Widget buildOverscrollIndicator(\n'
          '    context, child, details,\n'
          '  ) {\n'
          '    return GlowingOverscrollIndicator(\n'
          '      axisDirection: details.direction,\n'
          '      color: Theme.of(context).colorScheme.primary,\n'
          '      child: child,\n'
          '    );\n'
          '  }\n'
          '}',
      'note': 'Force the classic glow effect, even on Android 12+.',
      'color': Colors.blue,
    },
  ];

  final configWidgets = <Widget>[];
  for (var i = 0; i < configs.length; i++) {
    final cfg = configs[i];
    final cfgColor = cfg['color'] as Color;
    print('Config ${i + 1}: ${cfg['title']}');
    configWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: cfgColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cfgColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: cfgColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: cfgColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    cfg['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: cfgColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: cfgColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  cfg['code'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: cfgColor,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                cfg['note'] as String,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 7: Use Cases
  // ============================================================
  print('=== Section 7: Use Cases ===');

  final useCases = <Map<String, dynamic>>[
    {
      'title': 'Material 3 Lists',
      'desc': 'The default stretch effect on Android 12+ Material apps. '
          'Every ListView, GridView, and CustomScrollView gets it '
          'automatically via MaterialScrollBehavior.',
      'icon': Icons.list,
      'color': Colors.cyan,
    },
    {
      'title': 'Chat Scrolling',
      'desc': 'Chat message lists with stretch overscroll feel natural '
          'and responsive. Users pulling past the latest message get '
          'satisfying tactile feedback.',
      'icon': Icons.chat_bubble_outline,
      'color': Colors.green,
    },
    {
      'title': 'Image Galleries',
      'desc': 'Photo browsing with horizontal scroll. The stretch effect '
          'at the first and last images signals the boundary clearly.',
      'icon': Icons.photo_library,
      'color': Colors.purple,
    },
    {
      'title': 'Pull-to-Refresh',
      'desc': 'Combine with RefreshIndicator. The stretch deformation '
          'provides visual feedback while the refresh spinner appears.',
      'icon': Icons.refresh,
      'color': Colors.blue,
    },
    {
      'title': 'Horizontal Carousels',
      'desc': 'PageView and horizontal ListViews get stretch at the '
          'first and last pages, reinforcing that the user has reached '
          'the boundary.',
      'icon': Icons.view_carousel,
      'color': Colors.orange,
    },
  ];

  final useCaseWidgets = <Widget>[];
  for (var i = 0; i < useCases.length; i++) {
    final uc = useCases[i];
    final ucColor = uc['color'] as Color;
    print('UseCase ${i + 1}: ${uc['title']}');
    useCaseWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: ucColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ucColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ucColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(uc['icon'] as IconData, color: ucColor, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    uc['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: ucColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    uc['desc'] as String,
                    style: TextStyle(
                      fontSize: 12,
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
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.expand,
      'text': 'The stretch effect deforms scroll content like a rubber '
          'sheet when overscrolling, replacing the classic glow overlay.',
    },
    {
      'icon': Icons.phone_android,
      'text': 'Default on Android 12+ (API 31). Older Android uses '
          'GlowingOverscrollIndicator. iOS uses native bounce physics.',
    },
    {
      'icon': Icons.settings,
      'text': 'Controlled via ScrollBehavior.buildOverscrollIndicator(). '
          'Override to force stretch, glow, or none on any platform.',
    },
    {
      'icon': Icons.touch_app,
      'text': 'Provides a more tactile, physical feel than the glow '
          'effect. The content itself responds to the user\'s pull.',
    },
    {
      'icon': Icons.compare,
      'text': 'Stretch uses matrix transform on the viewport. Glow '
          'paints an overlay. Stretch distorts content, glow does not.',
    },
    {
      'icon': Icons.auto_mode,
      'text': 'No code changes needed for apps targeting Android 12+. '
          'MaterialApp handles the default automatically via '
          'MaterialScrollBehavior.',
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
          color: Colors.cyan.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.cyan.withOpacity(0.12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.cyan.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.cyan,
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
        title: const Text('Stretch Effect'),
        backgroundColor: Colors.cyan.shade800,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.expand), text: 'Visual'),
            Tab(icon: Icon(Icons.compare), text: 'vs Glow'),
            Tab(icon: Icon(Icons.phone_android), text: 'Platforms'),
            Tab(icon: Icon(Icons.settings), text: 'Config'),
            Tab(icon: Icon(Icons.dashboard), text: 'Use Cases'),
            Tab(icon: Icon(Icons.summarize), text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1: Concept
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Stretch Effect: the rubber-band overscroll visual '
                  'that deforms scroll view content on Android 12+.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),

          // Tab 2: API
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key classes and properties for controlling the '
                  'stretch overscroll indicator.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
            ],
          ),

          // Tab 3: Visual
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How content deforms at different overscroll amounts.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...stretchWidgets,
            ],
          ),

          // Tab 4: vs Glow
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Side-by-side comparison of stretch vs glow overscroll.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              // Header row
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  children: [
                    const SizedBox(width: 102),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.cyan.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Center(
                          child: Text(
                            'Stretch',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.cyan,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Center(
                          child: Text(
                            'Glow',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ...compWidgets,
            ],
          ),

          // Tab 5: Platforms
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Overscroll behavior varies by platform and OS version.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...platformWidgets,
            ],
          ),

          // Tab 6: Config
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Override ScrollBehavior to control which overscroll '
                  'indicator is used.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...configWidgets,
            ],
          ),

          // Tab 7: Use Cases
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Apps and screens that benefit from the stretch effect.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...useCaseWidgets,
            ],
          ),

          // Tab 8: Summary
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.cyan.withOpacity(0.12),
                      Colors.teal.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about the stretch overscroll effect.',
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
