// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — FocusHighlightStrategy
// Demonstrates FocusHighlightStrategy — the enum that controls HOW
// FocusHighlightMode is determined. It acts as the policy layer: either
// automatic (detect from input events) or forced to one mode always.
// Covers all three values, the decision pipeline, runtime switching,
// platform behavior, and practical usage patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FocusHighlightStrategy Deep Demo executing');

  // ============================================================
  // SECTION 1: What is FocusHighlightStrategy?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.tune,
      'title': 'The Policy Behind the Mode',
      'body': 'FocusHighlightStrategy is an enum that tells the '
          'FocusManager HOW to determine the current '
          'FocusHighlightMode. While FocusHighlightMode says '
          '"are we in touch or traditional mode?", '
          'FocusHighlightStrategy says "how do we decide that?"',
      'accent': Colors.indigo[700]!,
    },
    {
      'icon': Icons.auto_fix_high,
      'title': 'Three Choices',
      'body': 'You can let Flutter auto-detect from input events '
          '(automatic), force touch mode regardless of input '
          '(alwaysTouch), or force traditional mode with '
          'highlights always visible (alwaysTraditional). Most '
          'apps use automatic and never think about it.',
      'accent': Colors.deepPurple[600]!,
    },
    {
      'icon': Icons.settings_input_composite,
      'title': 'Set Once, Affects Everything',
      'body': 'FocusHighlightStrategy is set on the FocusManager '
          'and affects ALL focusable widgets in the app. Every '
          'InkWell, every button, every focusable element '
          'respects the strategy. It is a global policy, not a '
          'per-widget setting.',
      'accent': Colors.indigo[600]!,
    },
    {
      'icon': Icons.swap_horiz,
      'title': 'Strategy vs Mode',
      'body': 'Strategy is the RULE (how to decide). Mode is the '
          'RESULT (what was decided). Strategy is set by the '
          'developer. Mode is computed from the strategy plus '
          'input events. Changing strategy instantly updates mode.',
      'accent': Colors.deepPurple[700]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: The Three Values
  // ============================================================
  print('=== Section 2: Enum Values ===');

  final enumValues = <Map<String, dynamic>>[
    {
      'name': 'FocusHighlightStrategy.automatic',
      'index': 0,
      'icon': Icons.auto_fix_high,
      'color': Colors.indigo[700]!,
      'shortLabel': 'DEFAULT',
      'description': 'The highlight mode is determined automatically '
          'from the most recent input event. Touch/stylus events '
          'switch to FocusHighlightMode.touch. Keyboard/mouse '
          'events switch to FocusHighlightMode.traditional. '
          'This is the default strategy for all Flutter apps.',
      'behavior': 'Mode flips dynamically as the user switches '
          'between touch and keyboard. On a tablet with keyboard, '
          'mode alternates with each input type change. Provides '
          'the best UX across all platforms automatically.',
      'useCase': 'Almost every app. Let Flutter handle the '
          'mode switching. Only override when you have a '
          'specific reason (kiosk, TV, accessibility testing).',
    },
    {
      'name': 'FocusHighlightStrategy.alwaysTouch',
      'index': 1,
      'icon': Icons.touch_app,
      'color': Colors.deepPurple[700]!,
      'shortLabel': 'FORCED',
      'description': 'Forces FocusHighlightMode.touch regardless '
          'of input events. Focus highlights are NEVER shown. '
          'Even keyboard input won\'t trigger highlight display. '
          'Focus still works logically (keyboard navigation '
          'still functions), but no visual indicator appears.',
      'behavior': 'All focusable widgets suppress their highlight '
          'overlays. InkWells won\'t show focus rings. Buttons '
          'won\'t display focus borders. Only tap ripples/splashes '
          'and hover effects remain visible.',
      'useCase': 'Kiosk apps with only touchscreen input. '
          'Game UIs where focus rings are distracting. '
          'Full-screen media players. Digital signage.',
    },
    {
      'name': 'FocusHighlightStrategy.alwaysTraditional',
      'index': 2,
      'icon': Icons.keyboard,
      'color': Colors.indigo[800]!,
      'shortLabel': 'FORCED',
      'description': 'Forces FocusHighlightMode.traditional '
          'regardless of input events. Focus highlights are '
          'ALWAYS shown when a widget has focus. Even touch '
          'input won\'t suppress the highlight. This ensures '
          'maximum visibility of the focused element.',
      'behavior': 'Every focused widget shows its highlight '
          'decoration at all times. On a phone, tapping a button '
          'will show a focus ring (unusual but intentional). '
          'This is the most accessible mode.',
      'useCase': 'TV/set-top box apps with d-pad navigation. '
          'Accessibility testing to verify all widgets have '
          'proper focus styles. Desktop-only apps where '
          'keyboard nav is the primary interaction.',
    },
  ];

  print('  Prepared ${enumValues.length} enum values');

  // ============================================================
  // SECTION 3: Decision Pipeline
  // ============================================================
  print('=== Section 3: Decision Pipeline ===');

  final pipeline = <Map<String, dynamic>>[
    {
      'step': 1,
      'label': 'Developer sets strategy',
      'icon': Icons.developer_mode,
      'color': Colors.indigo[700]!,
      'detail': 'FocusManager.instance.highlightStrategy = '
          'FocusHighlightStrategy.automatic (or alwaysTouch, '
          'or alwaysTraditional). This is typically done in '
          'main() or app initialization.',
    },
    {
      'step': 2,
      'label': 'Input event arrives',
      'icon': Icons.input,
      'color': Colors.deepPurple[600]!,
      'detail': 'User touches screen, presses key, or moves '
          'mouse. The framework captures the PointerEvent or '
          'RawKeyEvent before any widget sees it.',
    },
    {
      'step': 3,
      'label': 'Strategy evaluates',
      'icon': Icons.rule,
      'color': Colors.indigo[600]!,
      'detail': 'If automatic: input type maps to mode (touch → '
          'touch, key/mouse → traditional). If alwaysTouch or '
          'alwaysTraditional: input is ignored, mode is forced.',
    },
    {
      'step': 4,
      'label': 'Mode updates',
      'icon': Icons.update,
      'color': Colors.deepPurple[700]!,
      'detail': 'FocusManager.instance.highlightMode changes to '
          'the new value (or stays the same if already correct). '
          'Listeners registered via addHighlightModeListener are '
          'notified of the change.',
    },
    {
      'step': 5,
      'label': 'Widgets react',
      'icon': Icons.widgets,
      'color': Colors.indigo[800]!,
      'detail': 'Focused widgets rebuild and check the mode. '
          'In touch mode they hide focus highlights. In '
          'traditional mode they show them. The visual change '
          'happens within the same frame.',
    },
  ];

  print('  Prepared ${pipeline.length} pipeline steps');

  // ============================================================
  // SECTION 4: Strategy × Input Matrix
  // ============================================================
  print('=== Section 4: Strategy × Input Matrix ===');

  final matrixRows = <Map<String, dynamic>>[
    {
      'input': 'Touch tap',
      'icon': Icons.touch_app,
      'auto': 'touch',
      'autoColor': Colors.pink[700]!,
      'touch': 'touch',
      'touchColor': Colors.pink[700]!,
      'trad': 'traditional',
      'tradColor': Colors.indigo[700]!,
    },
    {
      'input': 'Stylus tap',
      'icon': Icons.edit,
      'auto': 'touch',
      'autoColor': Colors.pink[700]!,
      'touch': 'touch',
      'touchColor': Colors.pink[700]!,
      'trad': 'traditional',
      'tradColor': Colors.indigo[700]!,
    },
    {
      'input': 'Key press',
      'icon': Icons.keyboard,
      'auto': 'traditional',
      'autoColor': Colors.indigo[700]!,
      'touch': 'touch',
      'touchColor': Colors.pink[700]!,
      'trad': 'traditional',
      'tradColor': Colors.indigo[700]!,
    },
    {
      'input': 'Mouse click',
      'icon': Icons.mouse,
      'auto': 'traditional',
      'autoColor': Colors.indigo[700]!,
      'touch': 'touch',
      'touchColor': Colors.pink[700]!,
      'trad': 'traditional',
      'tradColor': Colors.indigo[700]!,
    },
    {
      'input': 'Mouse hover',
      'icon': Icons.near_me,
      'auto': 'traditional',
      'autoColor': Colors.indigo[700]!,
      'touch': 'touch',
      'touchColor': Colors.pink[700]!,
      'trad': 'traditional',
      'tradColor': Colors.indigo[700]!,
    },
    {
      'input': 'Trackpad scroll',
      'icon': Icons.swipe,
      'auto': 'traditional',
      'autoColor': Colors.indigo[700]!,
      'touch': 'touch',
      'touchColor': Colors.pink[700]!,
      'trad': 'traditional',
      'tradColor': Colors.indigo[700]!,
    },
  ];

  print('  Prepared ${matrixRows.length} matrix rows');

  // ============================================================
  // SECTION 5: Platform Scenarios
  // ============================================================
  print('=== Section 5: Platform Scenarios ===');

  final platformScenarios = <Map<String, dynamic>>[
    {
      'platform': 'Phone (touch only)',
      'icon': Icons.phone_android,
      'color': Colors.indigo[700]!,
      'recommended': 'automatic',
      'description': 'Automatic detects all interactions as touch. '
          'Focus highlights never appear. This is the correct '
          'behavior — phone users tap directly on what they want.',
    },
    {
      'platform': 'Phone + BT keyboard',
      'icon': Icons.keyboard,
      'color': Colors.deepPurple[600]!,
      'recommended': 'automatic',
      'description': 'Automatic seamlessly switches between touch '
          'and traditional as the user alternates input devices. '
          'Tab-navigating with keyboard shows highlights; tapping '
          'hides them. Best of both worlds.',
    },
    {
      'platform': 'Desktop (keyboard/mouse)',
      'icon': Icons.desktop_mac,
      'color': Colors.indigo[600]!,
      'recommended': 'automatic',
      'description': 'Automatic stays in traditional mode since '
          'input is keyboard/mouse. Focus highlights always show. '
          'If the desktop has a touchscreen, touching switches to '
          'touch mode momentarily.',
    },
    {
      'platform': 'Smart TV (d-pad/remote)',
      'icon': Icons.tv,
      'color': Colors.deepPurple[700]!,
      'recommended': 'alwaysTraditional',
      'description': 'Force alwaysTraditional. Remote control d-pad '
          'generates key events, so automatic would also work. But '
          'forcing traditional is safer — some TV remotes use '
          'proprietary input methods that might not register as '
          'keyboard events.',
    },
    {
      'platform': 'Kiosk (touchscreen only)',
      'icon': Icons.storefront,
      'color': Colors.indigo[800]!,
      'recommended': 'alwaysTouch',
      'description': 'Force alwaysTouch. No keyboard will ever be '
          'connected. Focus highlights would be confusing for '
          'touchscreen-only users. The kiosk has no way to '
          'navigate by keyboard.',
    },
    {
      'platform': 'Accessibility testing',
      'icon': Icons.accessibility_new,
      'color': Colors.deepPurple[800]!,
      'recommended': 'alwaysTraditional',
      'description': 'Temporarily force alwaysTraditional during '
          'QA to verify every focusable widget properly displays '
          'its focus ring. Reveals widgets that forgot to '
          'implement focus styling.',
    },
  ];

  print('  Prepared ${platformScenarios.length} platform scenarios');

  // ============================================================
  // SECTION 6: Code Patterns
  // ============================================================
  print('=== Section 6: Code Patterns ===');

  final codePatterns = <Map<String, dynamic>>[
    {
      'name': 'Read current strategy',
      'icon': Icons.visibility,
      'color': Colors.indigo[700]!,
      'code': 'final strategy =\n'
          '    FocusManager.instance\n'
          '        .highlightStrategy;',
      'description': 'Access the FocusManager singleton to read '
          'the current strategy. Returns one of the three enum '
          'values. Usually only needed for debugging or logging.',
    },
    {
      'name': 'Set strategy at app start',
      'icon': Icons.play_arrow,
      'color': Colors.deepPurple[600]!,
      'code': 'void main() {\n'
          '  WidgetsFlutterBinding\n'
          '      .ensureInitialized();\n'
          '  FocusManager.instance\n'
          '      .highlightStrategy =\n'
          '    FocusHighlightStrategy\n'
          '        .alwaysTraditional;\n'
          '  runApp(MyApp());\n'
          '}',
      'description': 'Set strategy once in main() before runApp. '
          'This is the most common pattern. The strategy stays '
          'active for the entire app lifecycle. All widgets '
          'respect it immediately.',
    },
    {
      'name': 'Change strategy dynamically',
      'icon': Icons.swap_horiz,
      'color': Colors.indigo[600]!,
      'code': 'void onSettingsChanged(\n'
          '    bool forceHighlights) {\n'
          '  FocusManager.instance\n'
          '      .highlightStrategy =\n'
          '    forceHighlights\n'
          '      ? FocusHighlightStrategy\n'
          '          .alwaysTraditional\n'
          '      : FocusHighlightStrategy\n'
          '          .automatic;\n'
          '}',
      'description': 'Strategy can be changed at any time. The '
          'switch is immediate — all focused widgets update their '
          'highlights in the same frame. Useful for accessibility '
          'settings toggles.',
    },
    {
      'name': 'Listen for mode changes',
      'icon': Icons.notifications,
      'color': Colors.deepPurple[700]!,
      'code': 'FocusManager.instance\n'
          '  .addHighlightModeListener(\n'
          '    (mode) {\n'
          '      debugPrint(\n'
          '        \'Mode: \$mode\');\n'
          '    },\n'
          '  );',
      'description': 'Register a callback that fires when the '
          'resulting FocusHighlightMode changes. Useful for '
          'analytics, logging, or custom widgets that need to '
          'react to mode transitions.',
    },
  ];

  print('  Prepared ${codePatterns.length} code patterns');

  // ============================================================
  // SECTION 7: Comparison with Related APIs
  // ============================================================
  print('=== Section 7: Related APIs ===');

  final relatedApis = <Map<String, dynamic>>[
    {
      'name': 'FocusHighlightMode',
      'icon': Icons.highlight,
      'color': Colors.indigo[700]!,
      'relationship': 'Output',
      'description': 'The RESULT of the strategy. Strategy is the '
          'rule; mode is the current state. Mode has two values '
          '(touch, traditional). Strategy has three values '
          '(automatic, alwaysTouch, alwaysTraditional).',
    },
    {
      'name': 'FocusManager',
      'icon': Icons.manage_accounts,
      'color': Colors.deepPurple[600]!,
      'relationship': 'Owner',
      'description': 'Holds both the strategy and the computed '
          'mode. The FocusManager is the central authority for '
          'all focus-related state. Access via '
          'FocusManager.instance.',
    },
    {
      'name': 'Focus / FocusNode',
      'icon': Icons.center_focus_strong,
      'color': Colors.indigo[600]!,
      'relationship': 'Consumer',
      'description': 'Individual focus nodes query the mode '
          '(not strategy) to decide highlights. They don\'t '
          'interact with the strategy directly. The Focus widget '
          'builder receives hasFocus from its FocusNode.',
    },
    {
      'name': 'InkWell / Material buttons',
      'icon': Icons.water_drop,
      'color': Colors.deepPurple[700]!,
      'relationship': 'Consumer',
      'description': 'Material widgets use the computed mode '
          'internally. When mode is touch, focus overlay is '
          'suppressed. When traditional, the overlay appears. '
          'Developers don\'t need to wire this up — it\'s automatic.',
    },
    {
      'name': 'MediaQuery.platformBrightness',
      'icon': Icons.brightness_6,
      'color': Colors.indigo[800]!,
      'relationship': 'Unrelated',
      'description': 'Sometimes confused with highlight strategy. '
          'PlatformBrightness affects color themes (dark/light). '
          'FocusHighlightStrategy affects focus indicator '
          'visibility. They are completely independent.',
    },
  ];

  print('  Prepared ${relatedApis.length} related API items');

  // ============================================================
  // SECTION 8: Common Pitfalls
  // ============================================================
  print('=== Section 8: Common Pitfalls ===');

  final pitfalls = <Map<String, dynamic>>[
    {
      'icon': Icons.warning_amber,
      'title': 'Setting Strategy Per Widget',
      'bad': 'Trying to set different strategies for different '
          'parts of the widget tree. Strategy is global — it '
          'applies to the entire app.',
      'good': 'Set strategy once in main() or in your app\'s '
          'settings handler. If sections need different behavior, '
          'use custom focus decorators that check conditions.',
      'color': Colors.red[400]!,
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Confusing Strategy with Mode',
      'bad': 'Checking FocusHighlightStrategy.automatic to '
          'determine if highlights should show. Strategy tells '
          'you the RULE, not the current state.',
      'good': 'Check FocusManager.instance.highlightMode to see '
          'the current mode (touch or traditional). That\'s what '
          'determines whether highlights are visible right now.',
      'color': Colors.orange[400]!,
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Forgetting alwaysTouch Hides ALL Highlights',
      'bad': 'Using alwaysTouch on a desktop app, then wondering '
          'why keyboard users can\'t see which element has focus.',
      'good': 'Only use alwaysTouch when you\'re certain no '
          'keyboard/mouse users will interact with the app. '
          'For most apps, automatic is the safest choice.',
      'color': Colors.red[400]!,
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Not Testing All Strategies',
      'bad': 'Developing only with automatic and never checking '
          'how your app looks in alwaysTraditional mode.',
      'good': 'During QA, temporarily set alwaysTraditional to '
          'verify all focusable elements have proper focus '
          'styles. This catches accessibility issues early.',
      'color': Colors.orange[400]!,
    },
  ];

  print('  Prepared ${pitfalls.length} pitfalls');

  // ============================================================
  // SECTION 9: Tips & Best Practices
  // ============================================================
  print('=== Section 9: Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Default Is Almost Always Right',
      'body': 'FocusHighlightStrategy.automatic is the default '
          'and works correctly for 95% of apps. Only override '
          'if you have a specific platform constraint (kiosk, '
          'TV) or need to force behavior for testing.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Accessibility Settings Toggle',
      'body': 'Add an accessibility toggle in your settings that '
          'lets users force traditional mode. Some users with '
          'motor impairments use touch devices with assistive '
          'technology and need visible focus indicators.',
      'severity': 'tip',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Strategy Change Is Instant',
      'body': 'When you change the strategy, the mode updates '
          'immediately. There is no animation. Focused widgets '
          'show or hide their highlights in the very next frame. '
          'No need to call setState or trigger a rebuild.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'TV Apps Need Special Attention',
      'body': 'On Android TV and Apple TV, the remote sends key '
          'events. Automatic strategy would work, but some '
          'custom remotes might send touch events. Force '
          'alwaysTraditional for TV to be safe.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Use with FocusTraversalPolicy',
      'body': 'Strategy controls highlight visibility. '
          'FocusTraversalPolicy controls navigation ORDER. '
          'They work together: policy decides WHERE focus goes, '
          'strategy decides IF it\'s visible. Configure both '
          'for optimal keyboard navigation experience.',
      'severity': 'tip',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Test with Physical Devices',
      'body': 'Emulator input may not accurately represent real '
          'PointerDeviceKind. For strategy testing, use actual '
          'touchscreens and keyboards to verify the automatic '
          'mode switching works as expected.',
      'severity': 'info',
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
      title: Text('FocusHighlightStrategy'),
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
                colors: [Colors.indigo[700]!, Colors.deepPurple[700]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.tune, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'FocusHighlightStrategy',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'The policy enum that controls HOW the '
                  'FocusHighlightMode is determined — automatic '
                  'detection from input events, forced touch (no '
                  'highlights), or forced traditional (always '
                  'show highlights).',
                  style: TextStyle(
                    color: Colors.white70, fontSize: 14, height: 1.5),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 1: Concept ──
          _strHead('1', 'What is FocusHighlightStrategy?'),
          SizedBox(height: 12),
          ...conceptCards.map((card) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: card['accent'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2))
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

          // ── Section 2: Enum Values ──
          _strHead('2', 'The Three Values'),
          SizedBox(height: 12),
          ...enumValues.map((ev) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border(
                      left: BorderSide(
                          color: ev['color'] as Color, width: 5),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(ev['icon'] as IconData,
                            color: ev['color'] as Color, size: 24),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(ev['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                  fontSize: 11,
                                  color: ev['color'] as Color)),
                        ),
                        _strTag(ev['shortLabel'] as String,
                            ev['color'] as Color),
                      ]),
                      SizedBox(height: 10),
                      Text(ev['description'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.4)),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: (ev['color'] as Color).withOpacity(0.06),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: (ev['color'] as Color)
                                  .withOpacity(0.2)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Runtime Behavior:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: ev['color'] as Color)),
                            SizedBox(height: 2),
                            Text(ev['behavior'] as String,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[700],
                                    height: 1.3)),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('Use case: ${ev['useCase']}',
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic,
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Decision Pipeline ──
          _strHead('3', 'Decision Pipeline'),
          SizedBox(height: 12),
          ...pipeline.map((p) => Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: p['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: p['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${p['step']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Icon(p['icon'] as IconData,
                                  color: p['color'] as Color,
                                  size: 16),
                              SizedBox(width: 6),
                              Expanded(
                                child: Text(p['label'] as String,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13)),
                              ),
                            ]),
                            SizedBox(height: 4),
                            Text(p['detail'] as String,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                    height: 1.3)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: Strategy × Input Matrix ──
          _strHead('4', 'Strategy × Input Matrix'),
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
            child: Column(children: [
              Container(
                padding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.indigo[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(children: [
                  Expanded(
                      flex: 3,
                      child: Text('Input',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                  Expanded(
                      flex: 2,
                      child: Text('automatic',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                  Expanded(
                      flex: 2,
                      child: Text('alwaysTouch',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                  Expanded(
                      flex: 2,
                      child: Text('alwaysTrad.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                ]),
              ),
              ...matrixRows.asMap().entries.map((entry) {
                final idx = entry.key;
                final row = entry.value;
                return Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  color: idx.isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(children: [
                          Icon(row['icon'] as IconData,
                              size: 12, color: Colors.grey[600]),
                          SizedBox(width: 3),
                          Text(row['input'] as String,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500)),
                        ]),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: _strTag(row['auto'] as String,
                              row['autoColor'] as Color),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: _strTag(row['touch'] as String,
                              row['touchColor'] as Color),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: _strTag(row['trad'] as String,
                              row['tradColor'] as Color),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 5: Platform Scenarios ──
          _strHead('5', 'Platform Scenarios'),
          SizedBox(height: 12),
          ...platformScenarios.map((s) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: s['color'] as Color, width: 4),
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
                        Icon(s['icon'] as IconData,
                            color: s['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(s['platform'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                        _strTag(s['recommended'] as String,
                            s['color'] as Color),
                      ]),
                      SizedBox(height: 6),
                      Text(s['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Code Patterns ──
          _strHead('6', 'Code Patterns'),
          SizedBox(height: 12),
          ...codePatterns.map((cp) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: cp['color'] as Color, width: 4),
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
                        Icon(cp['icon'] as IconData,
                            color: cp['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(cp['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(cp['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10,
                                color: Colors.green[300],
                                height: 1.4)),
                      ),
                      SizedBox(height: 8),
                      Text(cp['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Related APIs ──
          _strHead('7', 'Related APIs'),
          SizedBox(height: 12),
          ...relatedApis.map((api) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: api['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(api['icon'] as IconData,
                            color: api['color'] as Color, size: 16),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(api['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                        _strTag(api['relationship'] as String,
                            api['color'] as Color),
                      ]),
                      SizedBox(height: 4),
                      Text(api['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Common Pitfalls ──
          _strHead('8', 'Common Pitfalls'),
          SizedBox(height: 12),
          ...pitfalls.map((pit) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: pit['color'] as Color, width: 4),
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
                        Icon(pit['icon'] as IconData,
                            color: pit['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(pit['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('DON\'T:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Colors.red[700])),
                            Text(pit['bad'] as String,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[700],
                                    height: 1.3)),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('DO:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Colors.green[700])),
                            Text(pit['good'] as String,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[700],
                                    height: 1.3)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _strHead('9', 'Tips & Best Practices'),
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
              'End of FocusHighlightStrategy Deep Demo',
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
// Helper: Section heading with numbered badge
// ──────────────────────────────────────────────────────────
Widget _strHead(String number, String title) {
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
// Helper: Small tag/badge
// ──────────────────────────────────────────────────────────
Widget _strTag(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(text,
        style: TextStyle(
            color: Colors.white,
            fontSize: 9,
            fontWeight: FontWeight.bold)),
  );
}
