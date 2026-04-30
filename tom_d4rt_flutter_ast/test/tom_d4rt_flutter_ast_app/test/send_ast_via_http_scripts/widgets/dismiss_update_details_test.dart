// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — DismissUpdateDetails
// Demonstrates DismissUpdateDetails — the data class passed to
// Dismissible.onUpdate during a dismiss gesture.  It reports the
// swipe direction, current progress, whether the dismiss threshold
// has been reached, and whether it was reached in the previous frame.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DismissUpdateDetails Deep Demo executing');

  // ============================================================
  // SECTION 1: What is DismissUpdateDetails?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.swipe,
      'title': 'Swipe Progress Reporter',
      'body': 'DismissUpdateDetails is an immutable data class that '
          'Dismissible passes to its onUpdate callback during every '
          'frame of a dismiss gesture. It tells you exactly how far '
          'the item has been swiped, in which direction, and whether '
          'the dismiss threshold has been crossed.',
      'accent': Colors.orange[700]!,
    },
    {
      'icon': Icons.speed,
      'title': 'Real-Time Feedback Loop',
      'body': 'Unlike onDismissed (fires once at the end), onUpdate '
          'fires continuously as the user drags. Each call delivers '
          'a new DismissUpdateDetails with the latest progress '
          'value. This enables live visual feedback: fading, '
          'scaling, background color changes, haptic feedback.',
      'accent': Colors.amber[700]!,
    },
    {
      'icon': Icons.compare_arrows,
      'title': 'Direction Awareness',
      'body': 'The direction property reports the active swipe '
          'direction as a DismissDirection value. If the user '
          'reverses mid-swipe, the direction updates accordingly. '
          'Combined with progress, you can build directional '
          'visual cues (red for delete-left, green for archive-right).',
      'accent': Colors.orange[600]!,
    },
    {
      'icon': Icons.flag,
      'title': 'Threshold Tracking',
      'body': 'The reached property is true when the swipe has '
          'passed the dismiss threshold (default 0.4). The '
          'previousReached property was true in the last frame. '
          'By comparing reached vs previousReached, you can detect '
          'the exact moment the threshold is crossed — perfect '
          'for triggering haptic feedback or animations.',
      'accent': Colors.amber[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Properties Deep Dive
  // ============================================================
  print('=== Section 2: Properties ===');

  final properties = <Map<String, dynamic>>[
    {
      'name': 'direction',
      'type': 'DismissDirection',
      'color': Colors.orange[700]!,
      'detail': 'The direction the Dismissible is currently being '
          'swiped. Values include: DismissDirection.endToStart, '
          'DismissDirection.startToEnd, .up, .down, .horizontal, '
          '.vertical. Updates in real time as the user changes '
          'swipe direction.',
      'example': 'if (details.direction ==\n'
          '    DismissDirection.endToStart) {\n'
          '  // User swiping left → delete\n'
          '} else {\n'
          '  // User swiping right → archive\n'
          '}',
    },
    {
      'name': 'progress',
      'type': 'double',
      'color': Colors.amber[700]!,
      'detail': 'A value from 0.0 to 1.0 representing how far '
          'the item has been swiped relative to its size. 0.0 = '
          'rest position, 1.0 = fully dismissed. The progress '
          'can decrease if the user pulls back. Always non-negative.',
      'example': '// Fade background by progress:\n'
          'backgroundColor = Color.lerp(\n'
          '  Colors.transparent,\n'
          '  Colors.red,\n'
          '  details.progress,\n'
          ')!;',
    },
    {
      'name': 'reached',
      'type': 'bool',
      'color': Colors.orange[600]!,
      'detail': 'Whether the current progress has passed the dismiss '
          'threshold. When true, releasing will complete the dismiss. '
          'When false, releasing will snap back. The threshold is '
          'set via Dismissible\'s dismissThresholds parameter.',
      'example': '// Visual snap at threshold:\n'
          'if (details.reached) {\n'
          '  icon = Icons.check_circle;\n'
          '  iconColor = Colors.green;\n'
          '} else {\n'
          '  icon = Icons.circle_outlined;\n'
          '  iconColor = Colors.grey;\n'
          '}',
    },
    {
      'name': 'previousReached',
      'type': 'bool',
      'color': Colors.amber[600]!,
      'detail': 'Whether the dismiss threshold was reached in the '
          'previous onUpdate call. Compare with "reached" to detect '
          'threshold crossings: reached && !previousReached means '
          '"just crossed". !reached && previousReached means '
          '"just uncrossed".',
      'example': '// Haptic on threshold cross:\n'
          'if (details.reached &&\n'
          '    !details.previousReached) {\n'
          '  HapticFeedback.mediumImpact();\n'
          '}',
    },
  ];

  print('  Prepared ${properties.length} properties');

  // ============================================================
  // SECTION 3: Lifecycle Flow
  // ============================================================
  print('=== Section 3: Lifecycle ===');

  final lifecycle = <Map<String, dynamic>>[
    {
      'step': 1,
      'title': 'User touches item',
      'color': Colors.orange[700]!,
      'detail': 'GestureDetector inside Dismissible recognizes a '
          'horizontal (or vertical) drag start. Internal state '
          'transitions to active. No onUpdate yet.',
    },
    {
      'step': 2,
      'title': 'Drag begins',
      'color': Colors.amber[700]!,
      'detail': 'The user moves their finger. Dismissible calculates '
          'the drag extent and creates a DismissUpdateDetails with '
          'progress near 0.0, direction based on finger movement, '
          'reached = false, previousReached = false.',
    },
    {
      'step': 3,
      'title': 'onUpdate fires each frame',
      'color': Colors.orange[600]!,
      'detail': 'For every pointer-move event, Dismissible recomputes '
          'progress and reached status, then calls onUpdate with '
          'a fresh DismissUpdateDetails. previousReached holds the '
          'value from the prior call. This happens ~60 times/sec.',
    },
    {
      'step': 4,
      'title': 'Threshold crossed',
      'color': Colors.amber[600]!,
      'detail': 'When progress exceeds the threshold (default 0.4), '
          'reached becomes true. If this is the first time, '
          'previousReached is still false. This is the ideal '
          'moment for haptic feedback or visual snap.',
    },
    {
      'step': 5,
      'title': 'User releases',
      'color': Colors.orange[500]!,
      'detail': 'If reached is true → the item animates to full '
          'dismiss (progress → 1.0), then onDismissed fires and '
          'the item is removed. If reached is false → the item '
          'snaps back to rest (progress → 0.0). onUpdate continues '
          'firing during the settle animation.',
    },
    {
      'step': 6,
      'title': 'Final onUpdate',
      'color': Colors.amber[500]!,
      'detail': 'The last onUpdate call has progress = 0.0 (snap-back) '
          'or progress = 1.0 (dismissed). After this, no more '
          'onUpdate calls until the next swipe gesture.',
    },
  ];

  print('  Prepared ${lifecycle.length} lifecycle steps');

  // ============================================================
  // SECTION 4: Common Patterns
  // ============================================================
  print('=== Section 4: Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Background Color by Progress',
      'color': Colors.orange[700]!,
      'code': '// Dismissible(\n'
          '//   onUpdate: (details) {\n'
          '//     setState(() {\n'
          '//       _bgColor = Color.lerp(\n'
          '//         Colors.transparent,\n'
          '//         Colors.red,\n'
          '//         details.progress,\n'
          '//       )!;\n'
          '//     });\n'
          '//   },\n'
          '//   background: Container(\n'
          '//     color: _bgColor,\n'
          '//   ),\n'
          '// )',
    },
    {
      'title': 'Directional Backgrounds',
      'color': Colors.amber[700]!,
      'code': '// onUpdate: (details) {\n'
          '//   final isLeft = details.direction ==\n'
          '//     DismissDirection.endToStart;\n'
          '//   setState(() {\n'
          '//     _bgColor = isLeft\n'
          '//       ? Colors.red.withOpacity(\n'
          '//           details.progress)\n'
          '//       : Colors.green.withOpacity(\n'
          '//           details.progress);\n'
          '//     _icon = isLeft\n'
          '//       ? Icons.delete\n'
          '//       : Icons.archive;\n'
          '//   });\n'
          '// }',
    },
    {
      'title': 'Haptic at Threshold Cross',
      'color': Colors.orange[600]!,
      'code': '// onUpdate: (details) {\n'
          '//   if (details.reached &&\n'
          '//       !details.previousReached) {\n'
          '//     HapticFeedback.mediumImpact();\n'
          '//   }\n'
          '//   if (!details.reached &&\n'
          '//       details.previousReached) {\n'
          '//     HapticFeedback.lightImpact();\n'
          '//   }\n'
          '// }',
    },
    {
      'title': 'Scale Effect on Swipe',
      'color': Colors.amber[600]!,
      'code': '// onUpdate: (details) {\n'
          '//   setState(() {\n'
          '//     // Scale from 1.0 down to 0.8\n'
          '//     _scale = 1.0 -\n'
          '//       (details.progress * 0.2);\n'
          '//   });\n'
          '// },\n'
          '// child: Transform.scale(\n'
          '//   scale: _scale,\n'
          '//   child: ListTile(...),\n'
          '// )',
    },
    {
      'title': 'Icon Transition at Threshold',
      'color': Colors.orange[500]!,
      'code': '// onUpdate: (details) {\n'
          '//   setState(() {\n'
          '//     _showCheck = details.reached;\n'
          '//   });\n'
          '// },\n'
          '// background: Center(\n'
          '//   child: AnimatedSwitcher(\n'
          '//     duration: Duration(ms: 200),\n'
          '//     child: _showCheck\n'
          '//       ? Icon(Icons.check, key: k1)\n'
          '//       : Icon(Icons.delete, key: k2),\n'
          '//   ),\n'
          '// )',
    },
  ];

  print('  Prepared ${patterns.length} patterns');

  // ============================================================
  // SECTION 5: Dismiss Threshold Configuration
  // ============================================================
  print('=== Section 5: Thresholds ===');

  final thresholds = <Map<String, dynamic>>[
    {
      'value': 0.2,
      'label': '20%',
      'desc': 'Very easy to dismiss — quick flick triggers it',
      'color': Colors.green[500]!,
    },
    {
      'value': 0.4,
      'label': '40% (default)',
      'desc': 'Standard feel — moderate intent required',
      'color': Colors.orange[500]!,
    },
    {
      'value': 0.6,
      'label': '60%',
      'desc': 'Harder to dismiss — prevents accidental swipes',
      'color': Colors.orange[700]!,
    },
    {
      'value': 0.8,
      'label': '80%',
      'desc': 'Very deliberate swipe needed — high friction',
      'color': Colors.red[500]!,
    },
  ];

  final thresholdCode = <Map<String, dynamic>>[
    {
      'title': 'Per-Direction Thresholds',
      'color': Colors.orange[700]!,
      'code': '// Dismissible(\n'
          '//   dismissThresholds: {\n'
          '//     DismissDirection.endToStart: 0.6,\n'
          '//     DismissDirection.startToEnd: 0.3,\n'
          '//   },\n'
          '//   onUpdate: (details) {\n'
          '//     // details.reached respects the\n'
          '//     // per-direction threshold above\n'
          '//   },\n'
          '// )',
    },
    {
      'title': 'Default Threshold',
      'color': Colors.amber[600]!,
      'code': '// If dismissThresholds is empty or\n'
          '// does not specify a threshold for\n'
          '// the current direction:\n'
          '//\n'
          '// _kDismissThreshold = 0.4 (40%)\n'
          '//\n'
          '// This means progress >= 0.4 sets\n'
          '// reached = true in the details.',
    },
  ];

  print('  Prepared ${thresholds.length} threshold levels');

  // ============================================================
  // SECTION 6: DismissDirection Enum
  // ============================================================
  print('=== Section 6: DismissDirection ===');

  final directions = <Map<String, dynamic>>[
    {
      'dir': 'startToEnd',
      'visual': '→',
      'desc': 'Left to Right (LTR) or Right to Left (RTL)',
      'color': Colors.green[500]!,
      'use': 'Archive, mark as read, positive action',
    },
    {
      'dir': 'endToStart',
      'visual': '←',
      'desc': 'Right to Left (LTR) or Left to Right (RTL)',
      'color': Colors.red[500]!,
      'use': 'Delete, remove, negative action',
    },
    {
      'dir': 'horizontal',
      'visual': '←→',
      'desc': 'Both horizontal directions allowed',
      'color': Colors.orange[500]!,
      'use': 'Multi-action: swipe left = delete, right = archive',
    },
    {
      'dir': 'up',
      'visual': '↑',
      'desc': 'Bottom to top swipe',
      'color': Colors.blue[500]!,
      'use': 'Remove from stack, dismiss upward',
    },
    {
      'dir': 'down',
      'visual': '↓',
      'desc': 'Top to bottom swipe',
      'color': Colors.blue[400]!,
      'use': 'Dismiss notification, pull down to remove',
    },
    {
      'dir': 'vertical',
      'visual': '↕',
      'desc': 'Both vertical directions allowed',
      'color': Colors.purple[500]!,
      'use': 'Vertical card stacks, tinder-style',
    },
    {
      'dir': 'none',
      'visual': '✕',
      'desc': 'Disable dismissal entirely',
      'color': Colors.grey[500]!,
      'use': 'Temporarily prevent swipe during edit mode',
    },
  ];

  print('  Prepared ${directions.length} directions');

  // ============================================================
  // SECTION 7: Relationship to Dismissible
  // ============================================================
  print('=== Section 7: Dismissible Relationship ===');

  final relationship = <Map<String, dynamic>>[
    {
      'title': 'Dismissible Widget',
      'color': Colors.orange[700]!,
      'desc': 'The parent widget that hosts the gesture. It wraps '
          'a child and detects horizontal/vertical drags. Handles '
          'the drag animation, threshold checking, and removal.',
    },
    {
      'title': 'onUpdate Callback',
      'color': Colors.amber[700]!,
      'desc': 'void Function(DismissUpdateDetails)? — called with '
          'a new DismissUpdateDetails each frame during the drag. '
          'This is where you react to progress changes.',
    },
    {
      'title': 'onDismissed Callback',
      'color': Colors.orange[600]!,
      'desc': 'void Function(DismissDirection)? — called once after '
          'the dismiss animation completes. At this point, the '
          'widget should be removed from the tree.',
    },
    {
      'title': 'confirmDismiss Callback',
      'color': Colors.amber[600]!,
      'desc': 'Future<bool?> Function(DismissDirection)? — called '
          'when the threshold is met and the user releases. Return '
          'false to prevent dismissal. Does NOT receive '
          'DismissUpdateDetails — only direction.',
    },
    {
      'title': 'background / secondaryBackground',
      'color': Colors.orange[500]!,
      'desc': 'Widgets shown behind the child during swipe. '
          'background for startToEnd, secondaryBackground for '
          'endToStart. Use onUpdate to dynamically style these.',
    },
  ];

  print('  Prepared ${relationship.length} items');

  // ============================================================
  // SECTION 8: Common Mistakes
  // ============================================================
  print('=== Section 8: Common Mistakes ===');

  final mistakes = <Map<String, dynamic>>[
    {
      'title': 'Forgetting to Remove the Item',
      'severity': 'error',
      'color': Colors.red[600]!,
      'icon': Icons.error,
      'body': 'onDismissed fires AFTER the dismiss animation. At that '
          'point, you MUST remove the item from your data source '
          'and call setState. If you don\'t, the Dismissible widget '
          'will be rebuilt in place and throw an error.',
    },
    {
      'title': 'Heavy Work in onUpdate',
      'severity': 'warning',
      'color': Colors.amber[600]!,
      'icon': Icons.warning,
      'body': 'onUpdate fires ~60 times per second. Avoid expensive '
          'operations. Use it only for simple state changes like '
          'setting a color, scale, or opacity value. Don\'t make '
          'network calls or heavy computations here.',
    },
    {
      'title': 'Ignoring previousReached',
      'severity': 'tip',
      'color': Colors.blue[500]!,
      'icon': Icons.info,
      'body': 'Many developers only check "reached" and miss the '
          'threshold-crossing moment. Compare reached with '
          'previousReached to trigger one-shot effects (haptics, '
          'sounds) exactly when the threshold is crossed.',
    },
    {
      'title': 'Not Setting a Key on Dismissible',
      'severity': 'error',
      'color': Colors.red[500]!,
      'icon': Icons.error,
      'body': 'Each Dismissible MUST have a unique Key (usually '
          'ValueKey or ObjectKey). Without it, Flutter may reuse '
          'the widget state for a different item after removal, '
          'causing ghost swipes or wrong items being dismissed.',
    },
    {
      'title': 'Using progress as Opacity Directly',
      'severity': 'tip',
      'color': Colors.blue[400]!,
      'icon': Icons.info,
      'body': 'progress ranges 0.0–1.0, so it can be used as opacity. '
          'But consider that opacity 0.0 at rest means invisible. '
          'Instead, use (1.0 - progress) for the child opacity, '
          'or (progress) for the background reveal opacity.',
    },
  ];

  print('  Prepared ${mistakes.length} mistakes');

  // ============================================================
  // SECTION 9: Tips
  // ============================================================
  print('=== Section 9: Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Use for Live Visual Feedback',
      'body': 'The main value of DismissUpdateDetails is enabling '
          'real-time visual feedback: fading backgrounds, scaling '
          'items, revealing icons, and changing colors as the user '
          'swipes. This makes dismissal feel polished.',
      'severity': 'tip',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Threshold Cross = Haptic Moment',
      'body': 'The most satisfying UX pattern: when reached becomes '
          'true and previousReached is false, fire haptic feedback. '
          'This gives the user a tactile confirmation that releasing '
          'now will complete the dismissal.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Keep State Updates Minimal',
      'body': 'Since onUpdate fires every frame, each call should '
          'only update a small number of state values. Avoid '
          'rebuilding complex widget trees. Use ValueNotifier or '
          'AnimatedBuilder for scoped rebuilds.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Combine With confirmDismiss',
      'body': 'Use onUpdate for visual feedback during the drag, '
          'and confirmDismiss for the final "are you sure?" logic. '
          'This creates a two-stage UX: visual hint during drag, '
          'confirmation dialog on release.',
      'severity': 'tip',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Test With Slow Drags',
      'body': 'Test your onUpdate handler with very slow drags to '
          'ensure smooth transitions. Fast flings may skip progress '
          'values (e.g., jump from 0.3 to 0.9). Your code should '
          'handle non-linear progress gracefully.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'progress Can Decrease',
      'body': 'If the user reverses their swipe, progress goes down. '
          'Don\'t assume it only increases. Animations triggered at '
          'a certain progress level should also reverse when progress '
          'drops back below that level.',
      'severity': 'warning',
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
      title: Text('DismissUpdateDetails'),
      backgroundColor: Colors.orange[700],
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
                colors: [Colors.orange[700]!, Colors.amber[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.swipe, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'DismissUpdateDetails',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'An immutable snapshot of a Dismissible widget\'s '
                  'in-progress swipe gesture. Contains direction, '
                  'progress (0.0–1.0), and threshold status flags. '
                  'Delivered via onUpdate every animation frame.',
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
          _duHead('1', 'What is DismissUpdateDetails?'),
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

          // ── Section 2: Properties ──
          _duHead('2', 'Properties Deep Dive'),
          SizedBox(height: 12),
          ...properties.map((p) => Padding(
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
                        _duTag(p['name'] as String,
                            p['color'] as Color),
                        SizedBox(width: 8),
                        Text(p['type'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10,
                                color: Colors.grey[500])),
                      ]),
                      SizedBox(height: 8),
                      Text(p['detail'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(p['example'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: Colors.amber[200],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Lifecycle ──
          _duHead('3', 'Lifecycle Flow'),
          SizedBox(height: 12),
          ...lifecycle.map((lc) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: lc['color'] as Color, width: 4),
                    ),
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
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: lc['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${lc['step']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(lc['title'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                            SizedBox(height: 4),
                            Text(lc['detail'] as String,
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

          // ── Section 4: Patterns ──
          _duHead('4', 'Common Patterns'),
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
                      Text(p['title'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(p['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: Colors.amber[200],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Thresholds ──
          _duHead('5', 'Dismiss Threshold Configuration'),
          SizedBox(height: 12),
          Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Threshold Levels:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.grey[800])),
                SizedBox(height: 12),
                ...thresholds.map((t) => Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            padding: EdgeInsets.symmetric(
                                vertical: 4),
                            decoration: BoxDecoration(
                              color: (t['color'] as Color)
                                  .withOpacity(0.15),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: t['color'] as Color),
                            ),
                            child: Center(
                              child: Text(t['label'] as String,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: t['color'] as Color)),
                            ),
                          ),
                          SizedBox(width: 10),
                          // Progress bar
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:
                                        BorderRadius.circular(4),
                                  ),
                                ),
                                FractionallySizedBox(
                                  widthFactor:
                                      (t['value'] as double),
                                  child: Container(
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: t['color'] as Color,
                                      borderRadius:
                                          BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            flex: 2,
                            child: Text(t['desc'] as String,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[600])),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          SizedBox(height: 10),
          ...thresholdCode.map((tc) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: tc['color'] as Color, width: 4),
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
                      Text(tc['title'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12)),
                      SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(tc['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: Colors.amber[200],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: DismissDirection ──
          _duHead('6', 'DismissDirection Enum'),
          SizedBox(height: 12),
          ...directions.map((d) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: d['color'] as Color, width: 4),
                    ),
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
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: (d['color'] as Color).withOpacity(0.1),
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: d['color'] as Color),
                        ),
                        child: Center(
                          child: Text(d['visual'] as String,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: d['color'] as Color)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _duTag(d['dir'] as String,
                                d['color'] as Color),
                            SizedBox(height: 4),
                            Text(d['desc'] as String,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[700])),
                            SizedBox(height: 2),
                            Text(d['use'] as String,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[500],
                                    fontStyle: FontStyle.italic)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Relationship ──
          _duHead('7', 'Relationship to Dismissible'),
          SizedBox(height: 12),
          ...relationship.map((r) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: r['color'] as Color, width: 4),
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
                      Text(r['title'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: r['color'] as Color)),
                      SizedBox(height: 6),
                      Text(r['desc'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Common Mistakes ──
          _duHead('8', 'Common Mistakes'),
          SizedBox(height: 12),
          ...mistakes.map((m) {
            Color bgColor;
            switch (m['severity']) {
              case 'error':
                bgColor = Colors.red[50]!;
                break;
              case 'warning':
                bgColor = Colors.amber[50]!;
                break;
              default:
                bgColor = Colors.blue[50]!;
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border(
                    left: BorderSide(
                        color: m['color'] as Color, width: 4),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(m['icon'] as IconData,
                          color: m['color'] as Color, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(m['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: m['color'] as Color)),
                      ),
                    ]),
                    SizedBox(height: 6),
                    Text(m['body'] as String,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[800],
                            height: 1.4)),
                  ],
                ),
              ),
            );
          }),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _duHead('9', 'Tips & Best Practices'),
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
              'End of DismissUpdateDetails Deep Demo',
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
Widget _duHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.orange[700],
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
// Helper: Tag/label
// ──────────────────────────────────────────────────────────
Widget _duTag(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(text,
        style: TextStyle(
            color: color,
            fontSize: 9,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace')),
  );
}
