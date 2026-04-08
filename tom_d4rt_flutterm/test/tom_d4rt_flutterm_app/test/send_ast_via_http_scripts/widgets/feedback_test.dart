// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_first, prefer_const_constructors
// D4rt test script: Deep Demo — Feedback
// Demonstrates the Feedback class — a static utility that provides
// haptic and audio feedback for common user interactions. Covers
// forTap(), forLongPress(), wrapForTap(), wrapForLongPress(), the
// platform feedback pipeline, practical integration patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Feedback Deep Demo executing');

  // ============================================================
  // SECTION 1: What is Feedback?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.vibration,
      'title': 'Platform Feedback Utility',
      'body': 'The Feedback class provides static methods that trigger '
          'platform-appropriate haptic and audio responses for user '
          'interactions. On Android it uses HapticFeedback and '
          'SystemSound; on iOS it uses the Taptic Engine. The feedback '
          'adapts automatically to the platform.',
      'accent': Colors.brown[700]!,
    },
    {
      'icon': Icons.touch_app,
      'title': 'Two Interaction Types',
      'body': 'Feedback distinguishes between two gesture types: '
          'taps (short, light feedback) and long-presses (heavier '
          'vibration or click). Each has a static method (forTap, '
          'forLongPress) and a callback wrapper (wrapForTap, '
          'wrapForLongPress).',
      'accent': Colors.orange[800]!,
    },
    {
      'icon': Icons.settings_applications,
      'title': 'Respects System Settings',
      'body': 'Feedback respects the user\'s system-level haptics '
          'settings. If the user has disabled vibration or haptic '
          'feedback in their device settings, Feedback calls produce '
          'no output. You don\'t need to check this yourself.',
      'accent': Colors.brown[600]!,
    },
    {
      'icon': Icons.widgets,
      'title': 'Used by Material Widgets Internally',
      'body': 'Material widgets like InkWell, InkResponse, and '
          'ListTile already use Feedback internally for their haptic '
          'responses. When you build custom widgets outside Material, '
          'use Feedback to provide the same consistent feel.',
      'accent': Colors.orange[700]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Static Methods
  // ============================================================
  print('=== Section 2: Static Methods ===');

  final methods = <Map<String, dynamic>>[
    {
      'name': 'Feedback.forTap(context)',
      'icon': Icons.ads_click,
      'color': Colors.brown[700]!,
      'returns': 'Future<void>',
      'description': 'Provides haptic feedback appropriate for a tap. '
          'On Android this triggers HapticFeedback.lightImpact. On iOS '
          'it triggers a light Taptic Engine response. Requires a '
          'BuildContext to determine the current platform.',
      'when': 'After confirming a tap gesture — call this in onTap '
          'before executing the action',
    },
    {
      'name': 'Feedback.forLongPress(context)',
      'icon': Icons.back_hand,
      'color': Colors.orange[800]!,
      'returns': 'Future<void>',
      'description': 'Provides haptic and audio feedback for a long '
          'press. Triggers a medium-impact vibration and plays the '
          'system "click" sound. Stronger than forTap to signal that '
          'a significant action is about to occur.',
      'when': 'When a long-press gesture is recognized — typically '
          'triggers a context menu or selection mode',
    },
    {
      'name': 'Feedback.wrapForTap(callback, context)',
      'icon': Icons.wrap_text,
      'color': Colors.brown[600]!,
      'returns': 'VoidCallback?',
      'description': 'Returns a new VoidCallback that calls '
          'Feedback.forTap and then invokes your original callback. '
          'Returns null if the input callback is null (preserving '
          'the disabled widget pattern). Convenience wrapper.',
      'when': 'Pass directly to onTap/onPressed parameters: '
          'onTap: Feedback.wrapForTap(myHandler, context)',
    },
    {
      'name': 'Feedback.wrapForLongPress(callback, context)',
      'icon': Icons.wrap_text,
      'color': Colors.orange[700]!,
      'returns': 'GestureLongPressCallback?',
      'description': 'Returns a new callback that provides long-press '
          'feedback before invoking your handler. Like wrapForTap but '
          'for long presses. Returns null if input is null.',
      'when': 'Pass directly to onLongPress parameters: '
          'onLongPress: Feedback.wrapForLongPress(myHandler, context)',
    },
  ];

  print('  Prepared ${methods.length} methods');

  // ============================================================
  // SECTION 3: Platform Feedback Pipeline
  // ============================================================
  print('=== Section 3: Pipeline ===');

  final pipelineSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'label': 'Widget calls Feedback.forTap(context)',
      'icon': Icons.play_arrow,
      'color': Colors.brown[700]!,
      'detail': 'Your widget triggers feedback after detecting a '
          'gesture. The BuildContext is needed to determine the '
          'current TargetPlatform via Theme.of(context).platform.',
    },
    {
      'step': 2,
      'label': 'Platform determined',
      'icon': Icons.phone_android,
      'color': Colors.orange[800]!,
      'detail': 'Feedback reads Theme.of(context).platform. This '
          'determines which native feedback mechanism to invoke. '
          'On Android: HapticFeedback channel. On iOS: Taptic Engine.',
    },
    {
      'step': 3,
      'label': 'Platform channel message sent',
      'icon': Icons.send,
      'color': Colors.brown[600]!,
      'detail': 'A platform channel message is sent to the native '
          'side: HapticFeedback.lightImpact() for taps, '
          'HapticFeedback.mediumImpact() + SystemSound.click() for '
          'long presses. This is asynchronous.',
    },
    {
      'step': 4,
      'label': 'Native feedback executes',
      'icon': Icons.vibration,
      'color': Colors.orange[700]!,
      'detail': 'The native OS triggers the actual hardware response: '
          'vibration motor, Taptic Engine, or audio playback. The user '
          'feels/hears the feedback. Duration and intensity are '
          'controlled by the OS, not Flutter.',
    },
    {
      'step': 5,
      'label': 'System settings honored',
      'icon': Icons.settings,
      'color': Colors.brown[800]!,
      'detail': 'If the user has disabled haptic feedback in device '
          'settings, the native side silently ignores the request. '
          'No error is thrown — the feedback simply doesn\'t happen. '
          'Your code doesn\'t need to handle this case.',
    },
  ];

  print('  Prepared ${pipelineSteps.length} pipeline steps');

  // ============================================================
  // SECTION 4: Tap vs Long Press Comparison
  // ============================================================
  print('=== Section 4: Tap vs LongPress ===');

  final comparisonRows = <Map<String, dynamic>>[
    {
      'aspect': 'Haptic Intensity',
      'tap': 'Light — subtle vibration',
      'longPress': 'Medium — noticeable vibration',
    },
    {
      'aspect': 'Audio Feedback',
      'tap': 'None — silent',
      'longPress': 'System click sound',
    },
    {
      'aspect': 'Typical Use Case',
      'tap': 'Button press, item selection',
      'longPress': 'Context menu, enter selection mode',
    },
    {
      'aspect': 'Static Method',
      'tap': 'Feedback.forTap(context)',
      'longPress': 'Feedback.forLongPress(context)',
    },
    {
      'aspect': 'Wrapper Method',
      'tap': 'Feedback.wrapForTap(cb, ctx)',
      'longPress': 'Feedback.wrapForLongPress(cb, ctx)',
    },
    {
      'aspect': 'Return Type',
      'tap': 'Future<void>',
      'longPress': 'Future<void>',
    },
    {
      'aspect': 'Wrapper Returns',
      'tap': 'VoidCallback?',
      'longPress': 'GestureLongPressCallback?',
    },
    {
      'aspect': 'Material Usage',
      'tap': 'InkWell.onTap',
      'longPress': 'InkWell.onLongPress',
    },
  ];

  print('  Prepared ${comparisonRows.length} comparison rows');

  // ============================================================
  // SECTION 5: Wrapper Pattern Deep Dive
  // ============================================================
  print('=== Section 5: Wrapper Pattern ===');

  final wrapperCards = <Map<String, dynamic>>[
    {
      'label': 'Without Wrapper',
      'icon': Icons.code,
      'color': Colors.brown[700]!,
      'code': 'GestureDetector(\n'
          '  onTap: () {\n'
          '    Feedback.forTap(context);\n'
          '    doSomething();\n'
          '  },\n'
          '  onLongPress: () {\n'
          '    Feedback.forLongPress(context);\n'
          '    showContextMenu();\n'
          '  },\n'
          ')',
      'note': 'Manual: call Feedback inside each handler',
    },
    {
      'label': 'With Wrapper',
      'icon': Icons.auto_fix_high,
      'color': Colors.orange[800]!,
      'code': 'GestureDetector(\n'
          '  onTap: Feedback.wrapForTap(\n'
          '    doSomething, context),\n'
          '  onLongPress: Feedback.wrapForLongPress(\n'
          '    showContextMenu, context),\n'
          ')',
      'note': 'Clean: wrapper adds feedback automatically',
    },
    {
      'label': 'Null Safety Benefit',
      'icon': Icons.security,
      'color': Colors.brown[600]!,
      'code': '// If handler is null, wrapper returns null\n'
          '// Widget will be visually disabled\n'
          'onTap: Feedback.wrapForTap(\n'
          '  enabled ? doSomething : null, context),',
      'note': 'Preserves null→disabled widget pattern',
    },
  ];

  print('  Prepared ${wrapperCards.length} wrapper patterns');

  // ============================================================
  // SECTION 6: Material Widget Integration
  // ============================================================
  print('=== Section 6: Material Integration ===');

  final materialWidgets = <Map<String, dynamic>>[
    {
      'widget': 'InkWell',
      'icon': Icons.water_drop,
      'color': Colors.brown[700]!,
      'feedback': 'Uses Feedback.forTap on tap, Feedback.forLongPress '
          'on long press. Controlled by the enableFeedback parameter '
          '(default: true). The ripple animation plus haptic feedback '
          'creates the signature Material feel.',
    },
    {
      'widget': 'InkResponse',
      'icon': Icons.radio_button_on,
      'color': Colors.orange[800]!,
      'feedback': 'Similar to InkWell but with a circular highlight '
          'shape. Also uses Feedback internally with the same '
          'enableFeedback parameter. Used as the base for many '
          'Material components.',
    },
    {
      'widget': 'ListTile',
      'icon': Icons.list,
      'color': Colors.brown[600]!,
      'feedback': 'Uses InkWell internally, which provides feedback. '
          'The enableFeedback property is passed through. Tapping and '
          'long-pressing a ListTile provides standard Material haptics.',
    },
    {
      'widget': 'ElevatedButton / TextButton',
      'icon': Icons.smart_button,
      'color': Colors.orange[700]!,
      'feedback': 'Button widgets use InkWell or InkResponse '
          'internally. Feedback is provided on tap. The '
          'enableFeedback property on ButtonStyle controls this.',
    },
    {
      'widget': 'Checkbox / Switch / Radio',
      'icon': Icons.check_box,
      'color': Colors.brown[800]!,
      'feedback': 'Toggle widgets provide haptic feedback when their '
          'value changes. This helps users confirm that a toggle '
          'was registered, especially important for accessibility.',
    },
  ];

  print('  Prepared ${materialWidgets.length} material widgets');

  // ============================================================
  // SECTION 7: Custom Widget Patterns
  // ============================================================
  print('=== Section 7: Custom Patterns ===');

  final customPatterns = <Map<String, dynamic>>[
    {
      'name': 'Custom Button with Feedback',
      'icon': Icons.smart_button,
      'color': Colors.brown[700]!,
      'description': 'When building a custom button that doesn\'t use '
          'InkWell (e.g., a canvas-drawn button or a Cupertino-style '
          'button), use Feedback.wrapForTap to add haptic feedback. '
          'This gives your custom widget the same tactile response '
          'users expect from standard widgets.',
    },
    {
      'name': 'Drag Start Feedback',
      'icon': Icons.drag_handle,
      'color': Colors.orange[800]!,
      'description': 'Trigger Feedback.forLongPress when a drag '
          'operation begins (not on every drag update — that would '
          'be overwhelming). A single haptic pulse at drag start '
          'confirms to the user that the item has been "picked up."',
    },
    {
      'name': 'Selection Mode Entry',
      'icon': Icons.select_all,
      'color': Colors.brown[600]!,
      'description': 'When the user long-presses an item to enter '
          'multi-select mode, call Feedback.forLongPress. The audio '
          'click plus vibration signals a mode change. Additional '
          'selections should use forTap for lighter confirmation.',
    },
    {
      'name': 'Slider Tick Feedback',
      'icon': Icons.tune,
      'color': Colors.orange[700]!,
      'description': 'For a custom slider that snaps to discrete '
          'values, call Feedback.forTap each time the slider crosses '
          'a tick mark. This creates a clicky feel similar to a '
          'physical dial. Debounce to avoid rapid-fire vibrations.',
    },
    {
      'name': 'Pull-to-Refresh Threshold',
      'icon': Icons.refresh,
      'color': Colors.brown[800]!,
      'description': 'When the user pulls past the refresh threshold, '
          'call Feedback.forTap to signal "release to refresh." This '
          'subtle haptic pulse tells the user they\'ve pulled far '
          'enough, improving the gesture\'s discoverability.',
    },
  ];

  print('  Prepared ${customPatterns.length} custom patterns');

  // ============================================================
  // SECTION 8: enableFeedback Pattern
  // ============================================================
  print('=== Section 8: enableFeedback ===');

  final enableCards = <Map<String, dynamic>>[
    {
      'title': 'The enableFeedback Parameter',
      'icon': Icons.toggle_on,
      'color': Colors.brown[700]!,
      'body': 'Many Material widgets have an enableFeedback parameter '
          '(default: true). When false, the widget skips calling '
          'Feedback methods. This is useful for widgets that appear '
          'in rapid succession (list items during scroll) or when '
          'feedback would be distracting.',
    },
    {
      'title': 'Implementing in Custom Widgets',
      'icon': Icons.code,
      'color': Colors.orange[800]!,
      'body': 'Follow the same pattern in your custom widgets: add '
          'a bool enableFeedback = true parameter. In your tap '
          'handler, check if (enableFeedback) before calling '
          'Feedback.forTap. This gives consumers full control.',
    },
    {
      'title': 'App-Wide Feedback Control',
      'icon': Icons.settings_applications,
      'color': Colors.brown[600]!,
      'body': 'For an app-wide setting, create a provider or inherited '
          'widget that tracks whether haptics are enabled. Widgets '
          'can check this before calling Feedback methods. This is '
          'separate from the OS-level settings and gives your app '
          'its own haptic preference.',
    },
    {
      'title': 'Performance Consideration',
      'icon': Icons.speed,
      'color': Colors.orange[700]!,
      'body': 'Each Feedback call sends a platform channel message. '
          'For most interactions this cost is negligible. But avoid '
          'calling Feedback on every frame of an animation or on '
          'every pixel of a drag. Batch or debounce for continuous '
          'gestures.',
    },
  ];

  print('  Prepared ${enableCards.length} enable cards');

  // ============================================================
  // SECTION 9: Tips & Best Practices
  // ============================================================
  print('=== Section 9: Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Use Wrappers for Cleaner Code',
      'body': 'Prefer Feedback.wrapForTap over manually calling '
          'Feedback.forTap inside your handler. The wrapper is more '
          'concise and handles the null case automatically, keeping '
          'your widget tree readable.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Don\'t Overuse Haptics',
      'body': 'Not every interaction needs haptic feedback. Reserve '
          'it for meaningful actions: button taps, mode changes, '
          'threshold crossings, confirmations. Excessive vibration '
          'annoys users and drains battery.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Test on Real Devices',
      'body': 'Haptic feedback cannot be tested in simulators or '
          'emulators — they lack vibration hardware. Always test '
          'feedback behavior on physical Android and iOS devices '
          'to verify intensity and appropriateness.',
      'severity': 'tip',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Feedback Is Automatic in Material',
      'body': 'If you use InkWell, ElevatedButton, ListTile, or '
          'other Material widgets, haptic feedback is already built '
          'in. Only add Feedback calls for custom gesture detectors '
          'or non-Material widgets.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Avoid forLongPress on Simple Taps',
      'body': 'forLongPress produces stronger feedback than forTap. '
          'Using strong feedback for a simple tap feels wrong to '
          'users. Match the feedback intensity to the gesture: light '
          'for tap, medium for long-press.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Combine with Visual Feedback',
      'body': 'Haptic feedback works best alongside visual feedback '
          '(ripple, highlight, scale animation). The combination of '
          'touch, sight, and sometimes sound creates a cohesive '
          'interaction that feels natural.',
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
      title: Text('Feedback'),
      backgroundColor: Colors.brown[700],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.brown[700]!, Colors.orange[800]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.vibration, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'Feedback',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Static utility class that provides platform-appropriate '
                  'haptic and audio feedback for tap and long-press '
                  'interactions. Used by Material widgets internally and '
                  'available for custom widget implementations.',
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
          _fbHead('1', 'What is Feedback?'),
          SizedBox(height: 12),
          ...conceptCards.map((c) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: c['accent'] as Color, width: 4),
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
                        Icon(c['icon'] as IconData,
                            color: c['accent'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(c['title'] as String,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(c['body'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 2: Static Methods ──
          _fbHead('2', 'Static Methods'),
          SizedBox(height: 12),
          ...methods.map((m) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: m['color'] as Color, width: 4),
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
                        Icon(m['icon'] as IconData,
                            color: m['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(m['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  fontFamily: 'monospace',
                                  color: m['color'] as Color)),
                        ),
                        _fbPill(m['returns'] as String,
                            m['color'] as Color),
                      ]),
                      SizedBox(height: 6),
                      Text(m['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                      SizedBox(height: 4),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: (m['color'] as Color).withOpacity(0.08),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(m['when'] as String,
                            style: TextStyle(
                                fontSize: 10,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[700])),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Pipeline ──
          _fbHead('3', 'Platform Feedback Pipeline'),
          SizedBox(height: 12),
          ...pipelineSteps.map((ps) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: ps['color'] as Color, width: 4),
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
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: ps['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${ps['step']}',
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
                              Icon(ps['icon'] as IconData,
                                  size: 14,
                                  color: ps['color'] as Color),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(ps['label'] as String,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                              ),
                            ]),
                            SizedBox(height: 3),
                            Text(ps['detail'] as String,
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

          // ── Section 4: Comparison ──
          _fbHead('4', 'Tap vs Long Press'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
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
            child: Column(children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.brown[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(children: [
                  SizedBox(
                      width: 80,
                      child: Text('Aspect',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                  Expanded(
                      child: Text('forTap',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                  Expanded(
                      child: Text('forLongPress',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                ]),
              ),
              ...comparisonRows.asMap().entries.map((entry) {
                final r = entry.value;
                final isEven = entry.key.isEven;
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  color: isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 80,
                          child: Text(r['aspect'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9,
                                  color: Colors.grey[800]))),
                      Expanded(
                          child: Text(r['tap'] as String,
                              style: TextStyle(
                                  fontSize: 9,
                                  color: Colors.grey[700]))),
                      Expanded(
                          child: Text(r['longPress'] as String,
                              style: TextStyle(
                                  fontSize: 9,
                                  color: Colors.orange[800]))),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 5: Wrapper Pattern ──
          _fbHead('5', 'Wrapper Pattern'),
          SizedBox(height: 12),
          ...wrapperCards.map((wc) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: wc['color'] as Color, width: 4),
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
                        Icon(wc['icon'] as IconData,
                            color: wc['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(wc['label'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
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
                        child: Text(wc['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10,
                                color: Colors.orange[200],
                                height: 1.4)),
                      ),
                      SizedBox(height: 6),
                      Text(wc['note'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Material Integration ──
          _fbHead('6', 'Material Widget Integration'),
          SizedBox(height: 12),
          ...materialWidgets.map((mw) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: mw['color'] as Color, width: 4),
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
                        Icon(mw['icon'] as IconData,
                            color: mw['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(mw['widget'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(mw['feedback'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Custom Patterns ──
          _fbHead('7', 'Custom Widget Patterns'),
          SizedBox(height: 12),
          ...customPatterns.map((cp) => Padding(
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
                            color: cp['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(cp['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(cp['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: enableFeedback ──
          _fbHead('8', 'The enableFeedback Pattern'),
          SizedBox(height: 12),
          ...enableCards.map((ec) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: ec['color'] as Color, width: 4),
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
                        Icon(ec['icon'] as IconData,
                            color: ec['color'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(ec['title'] as String,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(ec['body'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _fbHead('9', 'Tips & Best Practices'),
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
          Center(
            child: Text(
              'End of Feedback Deep Demo',
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
// Helper: Section heading
// ──────────────────────────────────────────────────────────
Widget _fbHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.brown[700],
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
// Helper: Pill badge
// ──────────────────────────────────────────────────────────
Widget _fbPill(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color.withOpacity(0.15),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(text,
        style: TextStyle(
            color: color,
            fontSize: 9,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace')),
  );
}
