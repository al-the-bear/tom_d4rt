// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — TextSelectionGestureDetector
// Demonstrates TextSelectionGestureDetector, the widget that recognises
// gestures used during text selection: single tap, double tap,
// long press, force press, and drag selection. It maps raw gestures
// to text-editing semantics and delegates to callbacks.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextSelectionGestureDetector Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.gesture,
      'title': 'What is TextSelectionGestureDetector?',
      'body': 'TextSelectionGestureDetector is a stateful widget that '
          'wraps a child with gesture recognizers tuned for text '
          'editing. It translates raw pointer events into high-level '
          'text-selection callbacks like onSingleTapUp, '
          'onDoubleTapDown, and onDragSelectionStart.',
      'accent': Colors.indigo,
    },
    {
      'icon': Icons.layers,
      'title': 'Layered Architecture',
      'body': 'EditableText → TextSelectionGestureDetectorBuilder → '
          'TextSelectionGestureDetector → GestureDetector. The detector '
          'sits at the bottom, translating finger/mouse actions into '
          'meaningful text operations. The builder creates the detector '
          'with appropriate callbacks.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.mouse,
      'title': 'Supported Gestures',
      'body': 'Single tap (position cursor), double tap (select word), '
          'long press (show magnifier / select word), force press '
          '(3D-touch selection on iOS), and drag (extend selection). '
          'Each gesture has start/update/end callbacks.',
      'accent': Colors.teal,
    },
    {
      'icon': Icons.phone_android,
      'title': 'Platform Awareness',
      'body': 'The gesture detector is platform-agnostic, but the '
          'callbacks wired up by TextField differ per platform. For '
          'example, long-press shows a magnifier on mobile and '
          'selects a word on desktop.',
      'accent': Colors.orange,
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptItems.length; i++) {
    final e = conceptItems[i];
    final accent = e['accent'] as Color;
    print('Concept ${i + 1}: ${e['title']}');
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
  // SECTION 2: API
  // ============================================================
  print('=== Section 2: API ===');

  final apiEntries = <Map<String, String>>[
    {
      'name': 'onTapDown',
      'type': 'GestureTapDownCallback?',
      'desc': 'Fires when the pointer first contacts the screen inside '
          'the detector. Provides the TapDownDetails with global/local '
          'position. Always fires before any specialised callback.',
    },
    {
      'name': 'onSingleTapUp',
      'type': 'GestureTapUpCallback?',
      'desc': 'Fires when a single tap completes (pointer up within time '
          'limit, no double-tap follow-up). Used to place the cursor '
          'at the tapped position.',
    },
    {
      'name': 'onSingleTapCancel',
      'type': 'GestureTapCancelCallback?',
      'desc': 'Fires when a single tap is aborted — for example because '
          'a second tap arrived (turning it into a double-tap) or the '
          'gesture was cancelled by the system.',
    },
    {
      'name': 'onDoubleTapDown',
      'type': 'GestureTapDownCallback?',
      'desc': 'Fires when two taps arrive within the double-tap time '
          'window. Typical action: select the tapped word.',
    },
    {
      'name': 'onSingleLongTapStart',
      'type': 'GestureLongPressStartCallback?',
      'desc': 'Fires when a long-press is confirmed (finger held down '
          'past the threshold). Used to show the magnifier and begin '
          'word selection on mobile.',
    },
    {
      'name': 'onSingleLongTapMoveUpdate',
      'type': 'GestureLongPressMoveUpdateCallback?',
      'desc': 'Fires as the finger moves during a long-press. The app '
          'tracks the finger and updates the magnifier position and '
          'the selection in real time.',
    },
    {
      'name': 'onSingleLongTapEnd',
      'type': 'GestureLongPressEndCallback?',
      'desc': 'Fires when the long-press ends (finger lifted). The '
          'magnifier is hidden and the selection toolbar is shown.',
    },
    {
      'name': 'onDragSelectionStart',
      'type': 'GestureDragStartCallback?',
      'desc': 'Fires when a drag gesture begins within the text. Used '
          'to start an extended selection from the drag origin.',
    },
    {
      'name': 'onDragSelectionUpdate',
      'type': 'DragSelectionUpdateCallback?',
      'desc': 'Fires as the drag moves. Receives start position and '
          'current position — the selection extends between them.',
    },
    {
      'name': 'onDragSelectionEnd',
      'type': 'GestureDragEndCallback?',
      'desc': 'Fires when the drag gesture ends. The selection is '
          'finalized and the toolbar may appear.',
    },
    {
      'name': 'onForcePressStart',
      'type': 'GestureForcePressStartCallback?',
      'desc': 'Fires when force (3D Touch) exceeds the start threshold. '
          'iPhone-specific: begins force-touch word selection.',
    },
    {
      'name': 'onForcePressEnd',
      'type': 'GestureForcePressEndCallback?',
      'desc': 'Fires when force drops below the threshold or the finger '
          'lifts. Ends force-touch selection mode.',
    },
    {
      'name': 'child',
      'type': 'Widget',
      'desc': 'The widget to wrap with text-selection gesture detection. '
          'Typically the rendered text or editing surface.',
    },
  ];

  final apiWidgets = <Widget>[];
  for (var i = 0; i < apiEntries.length; i++) {
    final ae = apiEntries[i];
    print('API ${i + 1}: ${ae['name']}');
    apiWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.indigo.withOpacity(0.05)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.indigo.withOpacity(0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.indigo.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    ae['name']!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.indigo,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      ae['type']!,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 9,
                        color: Colors.grey.shade600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              ae['desc']!,
              style: TextStyle(
                fontSize: 11,
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
  // SECTION 3: Single Tap
  // ============================================================
  print('=== Section 3: Single Tap ===');

  final singleTapSteps = <Map<String, dynamic>>[
    {
      'step': '1',
      'title': 'Pointer Down',
      'desc': 'User touches the text. onTapDown fires immediately with '
          'the position. The system determines whether this will become '
          'a single tap, double tap, or long press.',
      'icon': Icons.touch_app,
      'color': Colors.indigo,
    },
    {
      'step': '2',
      'title': 'Pointer Up (Single Tap)',
      'desc': 'If the finger lifts quickly and no second tap follows, '
          'onSingleTapUp is called. The cursor is placed at the '
          'tapped text offset. Focus is acquired.',
      'icon': Icons.arrow_upward,
      'color': Colors.blue,
    },
    {
      'step': '3',
      'title': 'Cursor Placement',
      'desc': 'The callback receives TapUpDetails containing the global '
          'position. The text editing state converts this position to '
          'a text offset and moves the cursor there.',
      'icon': Icons.text_format,
      'color': Colors.teal,
    },
    {
      'step': 'X',
      'title': 'Tap Cancelled',
      'desc': 'If the system cancels the gesture (e.g. a second tap begins, '
          'turning it into a double-tap), onSingleTapCancel fires '
          'instead of onSingleTapUp.',
      'icon': Icons.cancel_outlined,
      'color': Colors.red,
    },
  ];

  final singleTapWidgets = <Widget>[];
  for (var i = 0; i < singleTapSteps.length; i++) {
    final st = singleTapSteps[i];
    final stColor = st['color'] as Color;
    print('SingleTap ${i + 1}: ${st['title']}');
    singleTapWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: stColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: stColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: stColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    st['step'] as String,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: stColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(st['icon'] as IconData,
                            size: 18, color: stColor),
                        const SizedBox(width: 6),
                        Text(
                          st['title'] as String,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: stColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      st['desc'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        height: 1.35,
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
  // SECTION 4: Double Tap
  // ============================================================
  print('=== Section 4: Double Tap ===');

  final doubleTapItems = <Map<String, dynamic>>[
    {
      'title': 'Word Selection',
      'desc': 'Double-tapping a word triggers onDoubleTapDown. The text '
          'field selects the entire word under the tap. The selection '
          'handles and toolbar appear immediately.',
      'visual': 'Hello |world| today',
      'color': Colors.indigo,
    },
    {
      'title': 'Timing Window',
      'desc': 'The system waits a brief interval (platform-specific, '
          'typically 300ms) after the first tap. If a second tap '
          'arrives in that window at roughly the same location, it '
          'is classified as a double-tap.',
      'visual': 'Tap 1 →  300ms  → Tap 2',
      'color': Colors.blue,
    },
    {
      'title': 'Triple Tap (Paragraph)',
      'desc': 'Some platforms support triple-tap to select a paragraph '
          'or line. This is handled by waiting for a third tap within '
          'the timing window after a double-tap.',
      'visual': 'Tap 1 → Tap 2 → Tap 3 = Para',
      'color': Colors.green,
    },
  ];

  final doubleTapWidgets = <Widget>[];
  for (var i = 0; i < doubleTapItems.length; i++) {
    final dt = doubleTapItems[i];
    final dtColor = dt['color'] as Color;
    print('DoubleTap ${i + 1}: ${dt['title']}');
    doubleTapWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: dtColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: dtColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dt['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: dtColor,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: dtColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  dt['visual'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: dtColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                dt['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Long Press
  // ============================================================
  print('=== Section 5: Long Press ===');

  final longPressPhases = <Map<String, dynamic>>[
    {
      'phase': 'Start',
      'callback': 'onSingleLongTapStart',
      'desc': 'Finger held down past the threshold (usually ~500ms). '
          'The magnifier appears and word selection begins. On '
          'Android this selects the word under the finger; on iOS '
          'it initially shows just the magnifier.',
      'icon': Icons.timer,
      'color': Colors.indigo,
    },
    {
      'phase': 'Move',
      'callback': 'onSingleLongTapMoveUpdate',
      'desc': 'Finger drags while still held down. The magnifier tracks '
          'the finger position. The selection extends as the finger '
          'moves over text — word-by-word on mobile, character-by-character '
          'on desktop.',
      'icon': Icons.swipe,
      'color': Colors.purple,
    },
    {
      'phase': 'End',
      'callback': 'onSingleLongTapEnd',
      'desc': 'Finger lifts. The magnifier disappears and the selection '
          'toolbar (cut/copy/paste) appears. The final selection is '
          'retained.',
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
  ];

  final longPressWidgets = <Widget>[];
  for (var i = 0; i < longPressPhases.length; i++) {
    final lp = longPressPhases[i];
    final lpColor = lp['color'] as Color;
    print('LongPress ${i + 1}: ${lp['phase']}');

    longPressWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              lpColor.withOpacity(0.08),
              lpColor.withOpacity(0.02),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: lpColor.withOpacity(0.2)),
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
                      color: lpColor.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      lp['icon'] as IconData,
                      color: lpColor,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lp['phase'] as String,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: lpColor,
                        ),
                      ),
                      Text(
                        lp['callback'] as String,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          color: lpColor.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                lp['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Timeline visual
  final timelineVisual = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.indigo.withOpacity(0.04),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.indigo.withOpacity(0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Long-Press Timeline',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              width: 60,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.indigo.withOpacity(0.12),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text('Touch',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: Container(
                height: 2,
                color: Colors.indigo.withOpacity(0.2),
              ),
            ),
            Container(
              width: 60,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.12),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text('~500ms',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: Container(
                height: 2,
                color: Colors.purple.withOpacity(0.2),
              ),
            ),
            Container(
              width: 60,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.12),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text('Lift',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Drag Selection
  // ============================================================
  print('=== Section 6: Drag ===');

  final dragPhases = <Map<String, dynamic>>[
    {
      'title': 'Drag Start',
      'callback': 'onDragSelectionStart',
      'desc': 'After an initial tap-down, if the finger moves beyond a '
          'small threshold, the system transitions to drag mode. The '
          'selection anchor is placed at the initial tap position.',
      'icon': Icons.open_with,
      'color': Colors.indigo,
    },
    {
      'title': 'Drag Update',
      'callback': 'onDragSelectionUpdate',
      'desc': 'As the finger moves, onDragSelectionUpdate fires '
          'continuously. It provides both the start position and the '
          'current drag position. The selection extends between these '
          'two offsets.',
      'icon': Icons.swipe,
      'color': Colors.blue,
    },
    {
      'title': 'Drag End',
      'callback': 'onDragSelectionEnd',
      'desc': 'When the finger lifts, drag selection ends. The final '
          'selection is retained and the selection handles / toolbar '
          'appear as appropriate.',
      'icon': Icons.stop_circle,
      'color': Colors.green,
    },
  ];

  final dragWidgets = <Widget>[];
  for (var i = 0; i < dragPhases.length; i++) {
    final dp = dragPhases[i];
    final dpColor = dp['color'] as Color;
    print('Drag ${i + 1}: ${dp['title']}');
    dragWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: dpColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: dpColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(dp['icon'] as IconData, color: dpColor, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dp['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: dpColor,
                      ),
                    ),
                    Text(
                      dp['callback'] as String,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10,
                        color: dpColor.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      dp['desc'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        height: 1.35,
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

  // Drag visual
  final dragVisual = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.indigo.withOpacity(0.04),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.indigo.withOpacity(0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Drag Selection Visual',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
            children: [
              const TextSpan(text: 'The quick '),
              TextSpan(
                text: 'brown fox jumps',
                style: TextStyle(
                  backgroundColor: Colors.indigo.withOpacity(0.2),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(text: ' over the lazy dog.'),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Drag from "brown" to "jumps" — selection covers the range.',
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade600,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Force Press
  // ============================================================
  print('=== Section 7: Force Press ===');

  final forcePressItems = <Map<String, dynamic>>[
    {
      'title': 'What is Force Press?',
      'desc': '3D Touch / Force Touch on devices that support pressure '
          'sensitivity. When the user presses harder than a threshold, '
          'onForcePressStart fires. Lifting or reducing pressure fires '
          'onForcePressEnd.',
      'color': Colors.indigo,
    },
    {
      'title': 'iOS Behavior',
      'desc': 'On iPhone with 3D Touch, a force press on text triggers '
          'a "Peek" into the word — selecting it and showing a '
          'context menu. This is an alternative to long-press for '
          'faster interaction.',
      'color': Colors.blue,
    },
    {
      'title': 'Android / Desktop',
      'desc': 'Most Android devices and desktop platforms do not support '
          'force press. The callbacks are simply never called. The '
          'detector gracefully falls back to long-press behavior.',
      'color': Colors.green,
    },
    {
      'title': 'Pressure Threshold',
      'desc': 'The system defines a start threshold (typically 0.4 of '
          'max pressure) and an end threshold. The gesture detector '
          'monitors the PointerEvent.pressure field to trigger the '
          'callbacks.',
      'color': Colors.orange,
    },
  ];

  final forcePressWidgets = <Widget>[];
  for (var i = 0; i < forcePressItems.length; i++) {
    final fp = forcePressItems[i];
    final fpColor = fp['color'] as Color;
    print('ForcePress ${i + 1}: ${fp['title']}');
    forcePressWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: fpColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: fpColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fp['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: fpColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                fp['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Force pressure visual
  final pressureVisual = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.indigo.withOpacity(0.04),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.indigo.withOpacity(0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Force Pressure Scale',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Text('Light', style: TextStyle(fontSize: 10)),
            const SizedBox(width: 6),
            Expanded(
              child: Container(
                height: 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.withOpacity(0.3),
                      Colors.orange.withOpacity(0.5),
                      Colors.red.withOpacity(0.7),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 80,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: 2,
                        color: Colors.indigo,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 6),
            const Text('Hard', style: TextStyle(fontSize: 10)),
          ],
        ),
        const SizedBox(height: 4),
        Align(
          alignment: const Alignment(-0.3, 0),
          child: Text(
            'Start threshold',
            style: TextStyle(
              fontSize: 9,
              color: Colors.indigo.shade400,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.gesture,
      'text': 'TextSelectionGestureDetector translates raw pointer events '
          'into text-selection callbacks: tap, double-tap, long-press, '
          'drag, and force press.',
    },
    {
      'icon': Icons.touch_app,
      'text': 'Single tap places the cursor. Double-tap selects a word. '
          'Long-press shows magnifier and starts selection.',
    },
    {
      'icon': Icons.swipe,
      'text': 'Drag selection extends from the anchor point. Three '
          'callbacks track start, update, and end.',
    },
    {
      'icon': Icons.security,
      'text': 'Force press is iOS-specific (3D Touch). Other platforms '
          'fall back to long-press behavior.',
    },
    {
      'icon': Icons.architecture,
      'text': 'Used by TextSelectionGestureDetectorBuilder internally. '
          'TextField and CupertinoTextField wire it up automatically.',
    },
    {
      'icon': Icons.tune,
      'text': 'Each callback is optional. Provide only those you need '
          'for your custom text editing experience.',
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
          color: Colors.indigo.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.indigo.withOpacity(0.12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.indigo.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.indigo,
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
        title: const Text('TextSelectionGestureDetector'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.touch_app), text: 'Single Tap'),
            Tab(icon: Icon(Icons.looks_two), text: 'Double Tap'),
            Tab(icon: Icon(Icons.pan_tool), text: 'Long Press'),
            Tab(icon: Icon(Icons.swipe), text: 'Drag'),
            Tab(icon: Icon(Icons.compress), text: 'Force Press'),
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
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'TextSelectionGestureDetector: the gesture-recognition '
                  'layer for text-selection interactions.',
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
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'All callbacks and the child parameter.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
            ],
          ),

          // Tab 3: Single Tap
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'The single-tap flow: down → up → cursor placement.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...singleTapWidgets,
            ],
          ),

          // Tab 4: Double Tap
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Double-tap to select a word. Triple-tap for a paragraph.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...doubleTapWidgets,
            ],
          ),

          // Tab 5: Long Press
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Long-press phases: start → move → end.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...longPressWidgets,
              timelineVisual,
            ],
          ),

          // Tab 6: Drag
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Drag-to-select: start from tap and extend selection.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...dragWidgets,
              dragVisual,
            ],
          ),

          // Tab 7: Force Press
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Force press: 3D Touch text selection on supported devices.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...forcePressWidgets,
              pressureVisual,
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
                      Colors.indigo.withOpacity(0.12),
                      Colors.blue.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about TextSelectionGestureDetector.',
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
