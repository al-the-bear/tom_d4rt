// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — FocusHighlightMode
// Demonstrates FocusHighlightMode — the enum that indicates whether
// focus highlights should use touch or traditional (keyboard/mouse)
// rendering. Covers the two modes, how Flutter determines the active
// mode, FocusManager integration, widget highlight behavior, platform
// considerations, and practical usage patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FocusHighlightMode Deep Demo executing');

  // ============================================================
  // SECTION 1: What is FocusHighlightMode?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.highlight,
      'title': 'Touch vs Traditional Highlights',
      'body': 'FocusHighlightMode is an enum that tells widgets '
          'whether focus highlights should be drawn for touch '
          'input or for traditional input (keyboard/mouse). '
          'Touch interactions typically don\'t need visible focus '
          'rings, while keyboard navigation requires them for '
          'accessibility.',
      'accent': Colors.pink[700]!,
    },
    {
      'icon': Icons.mouse,
      'title': 'Input-Aware Focus Styling',
      'body': 'When a user taps a button, it gets focus but '
          'showing a focus ring feels wrong — the user knows what '
          'they tapped. When they tab to a button with the '
          'keyboard, a focus ring is essential because there\'s no '
          'other visual cue. FocusHighlightMode differentiates '
          'these two scenarios.',
      'accent': Colors.purple[600]!,
    },
    {
      'icon': Icons.settings_applications,
      'title': 'Managed by FocusManager',
      'body': 'The FocusManager tracks the last input type and '
          'exposes the current FocusHighlightMode. Widgets like '
          'InkWell, Focus, and material buttons query this to '
          'decide whether to show focus highlights. You rarely '
          'set it directly — it\'s automatic.',
      'accent': Colors.pink[600]!,
    },
    {
      'icon': Icons.accessibility,
      'title': 'Accessibility Foundation',
      'body': 'This enum is foundational for accessible apps. '
          'Screen reader users and keyboard navigators need '
          'visible focus indicators. Touch users don\'t. '
          'FocusHighlightMode ensures the right experience '
          'without manual per-widget configuration.',
      'accent': Colors.purple[700]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: The Two Values
  // ============================================================
  print('=== Section 2: Enum Values ===');

  final enumValues = <Map<String, dynamic>>[
    {
      'name': 'FocusHighlightMode.touch',
      'index': 0,
      'icon': Icons.touch_app,
      'color': Colors.pink[700]!,
      'shortLabel': 'touch',
      'highlights': 'Minimal / none',
      'description': 'Indicates the application is in a touch-input '
          'mode. Focus highlights are suppressed or minimized '
          'because the user\'s finger provides the visual cue. '
          'Set automatically when the last input event was a '
          'touch or stylus event.',
      'visual': 'Buttons, text fields, and other focusable widgets '
          'do NOT show focus rings or highlight boxes. Focus still '
          'exists logically, but the visual indicator is hidden. '
          'Material ripple on tap is still shown.',
      'examples': 'Mobile phones, tablets with finger input, '
          'touchscreen laptops during touch interaction.',
    },
    {
      'name': 'FocusHighlightMode.traditional',
      'index': 1,
      'icon': Icons.keyboard,
      'color': Colors.purple[700]!,
      'shortLabel': 'traditional',
      'highlights': 'Full highlights',
      'description': 'Indicates the application is using traditional '
          'input (keyboard, mouse, trackpad). Focus highlights are '
          'shown prominently because the user needs visual feedback '
          'about which element has focus. Set automatically when '
          'the last input was a key press or mouse event.',
      'visual': 'Focused buttons get a highlight border/ring. '
          'Focused text fields may show a thicker border. '
          'Material FocusHighlight draws an overlay on focused '
          'widgets. Essential for keyboard navigation.',
      'examples': 'Desktop apps, web apps with keyboard, TV/remote '
          'control apps, accessibility mode on mobile.',
    },
  ];

  print('  Prepared ${enumValues.length} enum values');

  // ============================================================
  // SECTION 3: How Mode Is Determined
  // ============================================================
  print('=== Section 3: Mode Detection ===');

  final detection = <Map<String, dynamic>>[
    {
      'step': 1,
      'event': 'User touches screen',
      'icon': Icons.touch_app,
      'color': Colors.pink[600]!,
      'result': 'touch',
      'detail': 'Any PointerDownEvent with kind == '
          'PointerDeviceKind.touch sets the mode to touch. '
          'This happens before the tap is even completed.',
    },
    {
      'step': 2,
      'event': 'User presses keyboard key',
      'icon': Icons.keyboard,
      'color': Colors.purple[600]!,
      'result': 'traditional',
      'detail': 'Any RawKeyEvent (key press) switches the mode to '
          'traditional. This includes Tab, arrow keys, Enter, '
          'and any other keyboard input.',
    },
    {
      'step': 3,
      'event': 'User clicks with mouse',
      'icon': Icons.mouse,
      'color': Colors.purple[700]!,
      'result': 'traditional',
      'detail': 'PointerDownEvent with kind == PointerDeviceKind.mouse '
          'sets traditional mode. Mouse users need focus highlights '
          'because they may also be using keyboard to navigate.',
    },
    {
      'step': 4,
      'event': 'User uses stylus',
      'icon': Icons.edit,
      'color': Colors.pink[700]!,
      'result': 'touch',
      'detail': 'PointerDeviceKind.stylus is treated like touch. '
          'Stylus interaction is direct manipulation like finger '
          'touch, so focus highlights are suppressed.',
    },
    {
      'step': 5,
      'event': 'Mode switch is immediate',
      'icon': Icons.flash_on,
      'color': Colors.amber[700]!,
      'result': 'varies',
      'detail': 'The mode switches instantly on each input event. '
          'On a laptop with touchscreen, it flips between touch '
          'and traditional as the user alternates between finger '
          'and keyboard/trackpad.',
    },
  ];

  print('  Prepared ${detection.length} detection steps');

  // ============================================================
  // SECTION 4: FocusManager Integration
  // ============================================================
  print('=== Section 4: FocusManager ===');

  final managerApi = <Map<String, dynamic>>[
    {
      'name': 'FocusManager.instance.highlightMode',
      'kind': 'property',
      'icon': Icons.highlight,
      'color': Colors.pink[700]!,
      'description': 'Returns the current FocusHighlightMode. '
          'Read this to determine whether to show focus '
          'highlights in custom widgets.',
    },
    {
      'name': 'FocusManager.instance.highlightStrategy',
      'kind': 'property',
      'icon': Icons.settings,
      'color': Colors.purple[600]!,
      'description': 'The FocusHighlightStrategy that determines '
          'how highlightMode is set. Can be automatic (detect '
          'from input) or always touch / always traditional.',
    },
    {
      'name': 'FocusHighlightStrategy.automatic',
      'kind': 'enum value',
      'icon': Icons.auto_fix_high,
      'color': Colors.pink[600]!,
      'description': 'Default strategy. Switches mode based on '
          'the most recent input event type. Touch events → touch '
          'mode, key/mouse events → traditional mode.',
    },
    {
      'name': 'FocusHighlightStrategy.alwaysTouch',
      'kind': 'enum value',
      'icon': Icons.touch_app,
      'color': Colors.purple[700]!,
      'description': 'Forces touch mode regardless of input. Focus '
          'highlights never show. Useful for kiosk or game UIs '
          'where focus rings are undesired.',
    },
    {
      'name': 'FocusHighlightStrategy.alwaysTraditional',
      'kind': 'enum value',
      'icon': Icons.keyboard,
      'color': Colors.pink[800]!,
      'description': 'Forces traditional mode. Focus highlights '
          'always show. Useful for accessibility testing or '
          'desktop-only apps where keyboard nav is primary.',
    },
    {
      'name': 'addHighlightModeListener',
      'kind': 'method',
      'icon': Icons.notifications,
      'color': Colors.purple[800]!,
      'description': 'Registers a callback for mode changes. Called '
          'whenever the highlight mode switches. Useful for custom '
          'widgets that need to react to mode transitions.',
    },
  ];

  print('  Prepared ${managerApi.length} manager API items');

  // ============================================================
  // SECTION 5: Widgets That Use This
  // ============================================================
  print('=== Section 5: Widget Integration ===');

  final widgetUsage = <Map<String, dynamic>>[
    {
      'name': 'InkWell / InkResponse',
      'icon': Icons.water_drop,
      'color': Colors.pink[700]!,
      'touchBehavior': 'No focus highlight on tap',
      'traditionalBehavior': 'Shows focus highlight overlay when '
          'focused via keyboard Tab',
      'description': 'Material ink effect widgets check the mode '
          'to decide focus highlight visibility. Ripple on tap is '
          'always shown; focus highlight varies by mode.',
    },
    {
      'name': 'ElevatedButton / TextButton / OutlinedButton',
      'icon': Icons.smart_button,
      'color': Colors.purple[600]!,
      'touchBehavior': 'No focus ring on press',
      'traditionalBehavior': 'Shows focus border/overlay when '
          'tabbed to with keyboard',
      'description': 'All Material buttons inherit InkWell behavior. '
          'The ButtonStyle.overlayColor for focused state respects '
          'the highlight mode.',
    },
    {
      'name': 'TextField / TextFormField',
      'icon': Icons.text_fields,
      'color': Colors.pink[600]!,
      'touchBehavior': 'Cursor + selection; no extra focus indicator',
      'traditionalBehavior': 'Thicker border and/or highlight color '
          'when focused via Tab',
      'description': 'Input fields always show their cursor when '
          'focused. The additional decoration (thicker border, '
          'color change) depends on the highlight mode.',
    },
    {
      'name': 'Focus / FocusScope',
      'icon': Icons.center_focus_weak,
      'color': Colors.purple[700]!,
      'touchBehavior': 'Focus exists logically, no visual change',
      'traditionalBehavior': 'Focus exists and visual builders can '
          'respond via hasFocus',
      'description': 'The Focus widget itself doesn\'t draw highlights, '
          'but its builder receives hasFocus. Custom widgets use '
          'the highlight mode to decide if they should render '
          'focus decorations.',
    },
    {
      'name': 'ListTile / CheckboxListTile',
      'icon': Icons.list,
      'color': Colors.pink[800]!,
      'touchBehavior': 'Tap highlight only (ripple)',
      'traditionalBehavior': 'Focus highlight when navigated to '
          'with keyboard or remote',
      'description': 'List tiles in TV apps need strong focus '
          'highlights. On mobile, the ripple effect is sufficient. '
          'The mode ensures both platforms look right.',
    },
  ];

  print('  Prepared ${widgetUsage.length} widget integrations');

  // ============================================================
  // SECTION 6: Platform Defaults
  // ============================================================
  print('=== Section 6: Platform Defaults ===');

  final platforms = <Map<String, dynamic>>[
    {
      'name': 'Mobile (Android/iOS)',
      'icon': Icons.phone_android,
      'color': Colors.pink[700]!,
      'defaultMode': 'touch',
      'description': 'Primary input is touch. Mode starts as touch. '
          'Switches to traditional if a Bluetooth keyboard is '
          'connected and used. Returns to touch on next tap.',
    },
    {
      'name': 'Desktop (macOS/Windows/Linux)',
      'icon': Icons.desktop_mac,
      'color': Colors.purple[700]!,
      'defaultMode': 'traditional',
      'description': 'Primary input is keyboard/mouse. Mode starts '
          'as traditional. Stays traditional even after mouse '
          'clicks. May switch to touch if a touchscreen is used.',
    },
    {
      'name': 'Web',
      'icon': Icons.web,
      'color': Colors.pink[600]!,
      'defaultMode': 'varies',
      'description': 'Depends on the device. Mobile browser → touch. '
          'Desktop browser → traditional. Switches dynamically '
          'as user alternates between input types.',
    },
    {
      'name': 'TV / Set-top box',
      'icon': Icons.tv,
      'color': Colors.purple[600]!,
      'defaultMode': 'traditional',
      'description': 'D-pad / remote control input maps to keyboard '
          'events. Mode is traditional — focus highlights are '
          'essential for navigation. This is the main visual cue '
          'for the user.',
    },
  ];

  print('  Prepared ${platforms.length} platform entries');

  // ============================================================
  // SECTION 7: Comparison Table
  // ============================================================
  print('=== Section 7: Comparison ===');

  final comparisonTable = <Map<String, dynamic>>[
    {
      'aspect': 'Mode name',
      'touch': 'touch',
      'trad': 'traditional',
    },
    {
      'aspect': 'Focus ring visible',
      'touch': 'No',
      'trad': 'Yes',
    },
    {
      'aspect': 'Focus exists logically',
      'touch': 'Yes',
      'trad': 'Yes',
    },
    {
      'aspect': 'Triggered by',
      'touch': 'Touch, stylus events',
      'trad': 'Keyboard, mouse events',
    },
    {
      'aspect': 'Primary use',
      'touch': 'Mobile, touchscreen',
      'trad': 'Desktop, TV, accessibility',
    },
    {
      'aspect': 'Ripple / splash',
      'touch': 'Still shown',
      'trad': 'Still shown (on click)',
    },
    {
      'aspect': 'Hover highlight',
      'touch': 'No hover on touch',
      'trad': 'Yes (mouse hover)',
    },
  ];

  print('  Prepared ${comparisonTable.length} comparison rows');

  // ============================================================
  // SECTION 8: Real-World Patterns
  // ============================================================
  print('=== Section 8: Real-World Patterns ===');

  final realWorldPatterns = <Map<String, dynamic>>[
    {
      'name': 'Custom Focus Indicator',
      'icon': Icons.crop_square,
      'color': Colors.pink[700]!,
      'description': 'Build a custom widget that only shows a '
          'glow border when FocusHighlightMode is traditional '
          'and the widget has focus. Ignores focus visuals in '
          'touch mode. Read the mode from FocusManager.',
    },
    {
      'name': 'TV App Navigation',
      'icon': Icons.tv,
      'color': Colors.purple[600]!,
      'description': 'Force alwaysTraditional strategy for a TV '
          'app. Every focused widget gets a prominent ring. '
          'This ensures the user always knows which element is '
          'selected via their remote control.',
    },
    {
      'name': 'Kiosk / Game Mode',
      'icon': Icons.gamepad,
      'color': Colors.pink[600]!,
      'description': 'Force alwaysTouch strategy for a kiosk or '
          'game UI where focus rings would be distracting. '
          'Users interact only via touch or gamepad. Focus '
          'highlights are never needed.',
    },
    {
      'name': 'Accessibility Testing',
      'icon': Icons.accessibility_new,
      'color': Colors.purple[700]!,
      'description': 'During development, set alwaysTraditional '
          'to verify that all focusable widgets have proper '
          'highlight styles. This reveals widgets that forgot '
          'to implement focus styling.',
    },
    {
      'name': 'Cross-Platform Consistency',
      'icon': Icons.devices_other,
      'color': Colors.pink[800]!,
      'description': 'For an app that runs on mobile, web, and '
          'desktop, rely on automatic strategy. The mode '
          'switches naturally as the user changes input devices. '
          'Test each platform to verify highlights look correct.',
    },
  ];

  print('  Prepared ${realWorldPatterns.length} patterns');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips & Gotchas ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Mode Switches Instantly',
      'body': 'One tap → touch mode. One key press → traditional. '
          'The switch is immediate. On a touchscreen laptop, '
          'mode flips constantly. This is by design — it provides '
          'the right experience for the current interaction.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Don\'t Assume Platform = Mode',
      'body': 'Mobile doesn\'t always mean touch mode. If the user '
          'has a Bluetooth keyboard, they may be in traditional '
          'mode on a phone. Desktop doesn\'t always mean '
          'traditional — touchscreen monitors exist. Always let '
          'the automatic strategy handle it.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Custom Widgets Should Respect Mode',
      'body': 'If you build focusable custom widgets, check '
          'FocusManager.instance.highlightMode before drawing '
          'focus decorations. Material widgets do this for you. '
          'Custom widgets need manual implementation.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Focus Exists Even in Touch Mode',
      'body': 'In touch mode, hasFocus is still true for the '
          'focused widget. The mode only affects VISUAL highlights, '
          'not logical focus. Focus traversal, shortcuts, and '
          'text input still work the same.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Use addHighlightModeListener for Reactivity',
      'body': 'FocusManager.instance.addHighlightModeListener() '
          'notifies when the mode changes. This is better than '
          'polling. However, most widgets don\'t need this — '
          'they rebuild via Focus builder which already handles it.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Test with Tab Key',
      'body': 'The easiest way to see traditional focus highlights '
          'in action: press Tab on a desktop or web app. Watch '
          'the focus ring appear on each widget as you tab through '
          'them. Then tap the screen and watch it disappear.',
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
      title: Text('FocusHighlightMode'),
      backgroundColor: Colors.pink[700],
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
                colors: [Colors.pink[700]!, Colors.purple[700]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.highlight, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'FocusHighlightMode',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'An enum indicating whether focus highlights '
                  'should be drawn for touch input (hidden) or '
                  'traditional keyboard/mouse input (visible). '
                  'Managed automatically by the FocusManager.',
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

          // ── Section 1: Concept ──
          _focHead('1', 'What is FocusHighlightMode?'),
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
          _focHead('2', 'The Two Values'),
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
                                  fontSize: 12,
                                  color: ev['color'] as Color)),
                        ),
                        _focBadge(ev['highlights'] as String,
                            ev['color'] as Color),
                      ]),
                      SizedBox(height: 10),
                      Text(ev['description'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.4)),
                      SizedBox(height: 8),
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
                            Text('Visual Behavior:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: ev['color'] as Color)),
                            SizedBox(height: 2),
                            Text(ev['visual'] as String,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[700],
                                    height: 1.3)),
                          ],
                        ),
                      ),
                      SizedBox(height: 6),
                      Text('Examples: ${ev['examples']}',
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

          // ── Section 3: Mode Detection ──
          _focHead('3', 'How Mode Is Determined'),
          SizedBox(height: 12),
          ...detection.map((d) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: d['color'] as Color, width: 4),
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
                          color: d['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${d['step']}',
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
                              Icon(d['icon'] as IconData,
                                  color: d['color'] as Color,
                                  size: 16),
                              SizedBox(width: 6),
                              Expanded(
                                child: Text(d['event'] as String,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13)),
                              ),
                              _focBadge(d['result'] as String,
                                  d['color'] as Color),
                            ]),
                            SizedBox(height: 4),
                            Text(d['detail'] as String,
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

          // ── Section 4: FocusManager API ──
          _focHead('4', 'FocusManager Integration'),
          SizedBox(height: 12),
          ...managerApi.map((api) => Padding(
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
                                  fontFamily: 'monospace',
                                  fontSize: 10,
                                  color: api['color'] as Color)),
                        ),
                        _focBadge(
                            api['kind'] as String, Colors.grey[500]!),
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

          // ── Section 5: Widget Integration ──
          _focHead('5', 'Widget Highlight Behavior'),
          SizedBox(height: 12),
          ...widgetUsage.map((w) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: w['color'] as Color, width: 4),
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
                        Icon(w['icon'] as IconData,
                            color: w['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(w['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(w['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                      SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.pink[50],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text('touch mode',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.pink[700],
                                          fontSize: 9)),
                                  SizedBox(height: 2),
                                  Text(
                                      w['touchBehavior'] as String,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey[700],
                                          height: 1.2)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.purple[50],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text('traditional mode',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple[700],
                                          fontSize: 9)),
                                  SizedBox(height: 2),
                                  Text(
                                      w['traditionalBehavior']
                                          as String,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey[700],
                                          height: 1.2)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Platform Defaults ──
          _focHead('6', 'Platform Defaults'),
          SizedBox(height: 12),
          ...platforms.map((p) => Padding(
                padding: EdgeInsets.only(bottom: 10),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(p['icon'] as IconData,
                            color: p['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(p['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                        _focBadge(p['defaultMode'] as String,
                            p['color'] as Color),
                      ]),
                      SizedBox(height: 4),
                      Text(p['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Comparison Table ──
          _focHead('7', 'Touch vs Traditional'),
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
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.pink[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(children: [
                  Expanded(
                      flex: 2,
                      child: Text('Aspect',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                  Expanded(
                      flex: 3,
                      child: Text('Touch',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                  Expanded(
                      flex: 3,
                      child: Text('Traditional',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                ]),
              ),
              ...comparisonTable.asMap().entries.map((entry) {
                final idx = entry.key;
                final row = entry.value;
                return Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 6, horizontal: 10),
                  color: idx.isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(row['aspect'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10))),
                      Expanded(
                          flex: 3,
                          child: Text(row['touch'] as String,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.pink[700],
                                  height: 1.3))),
                      Expanded(
                          flex: 3,
                          child: Text(row['trad'] as String,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.purple[700],
                                  height: 1.3))),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 8: Real-World Patterns ──
          _focHead('8', 'Real-World Patterns'),
          SizedBox(height: 12),
          ...realWorldPatterns.map((p) => Padding(
                padding: EdgeInsets.only(bottom: 12),
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
                          child: Text(p['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(p['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _focHead('9', 'Tips, Pitfalls & Gotchas'),
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
              'End of FocusHighlightMode Deep Demo',
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
Widget _focHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.pink[700],
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
// Helper: Small badge/tag
// ──────────────────────────────────────────────────────────
Widget _focBadge(String text, Color color) {
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
