// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo of BaseTapGestureRecognizer
// (abstract base for tap-style gesture recognizers in package:flutter/gestures)
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BaseTapGestureRecognizer Deep Demo executing');

  // ============================================================
  // Palette
  // ============================================================
  final indigoDeep = Colors.indigo.shade900;
  final indigoMid = Colors.indigo.shade600;
  final indigoSoft = Colors.indigo.shade100;
  final tealDeep = Colors.teal.shade800;
  final tealMid = Colors.teal.shade500;
  final tealSoft = Colors.teal.shade100;
  final amberAccent = Colors.amber.shade700;
  final crimson = Colors.red.shade700;
  final slateBg = Color(0xFF1B1F2A);
  final slateMid = Color(0xFF2A3040);
  final slateLine = Color(0xFF3D455A);

  print('=== Palette built ===');

  // ============================================================
  // SECTION 1: Title Banner
  // ============================================================
  print('=== Section 1: Title banner ===');

  final titleBanner = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [indigoDeep, tealDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: indigoDeep.withValues(alpha: 0.5),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: tealDeep.withValues(alpha: 0.3),
          blurRadius: 36.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Icon(
                Icons.touch_app_outlined,
                size: 44.0,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BaseTapGestureRecognizer',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/gestures.dart',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontFamily: 'monospace',
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'Abstract base class powering TapGestureRecognizer, '
            'DoubleTapGestureRecognizer and friends. Manages a single '
            'primary pointer through the Flutter gesture arena.',
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy / Lifecycle
  // ============================================================
  print('=== Section 2: Anatomy lifecycle ===');

  final lifecycleSteps = [
    {
      'icon': Icons.south_east,
      'label': 'PointerDown',
      'detail': 'addAllowedPointer captures the primary pointer.',
      'color': indigoMid,
    },
    {
      'icon': Icons.adjust,
      'label': 'Primary tracked',
      'detail': 'PrimaryPointerGestureRecognizer monitors slop & deadline.',
      'color': tealMid,
    },
    {
      'icon': Icons.north_east,
      'label': 'PointerUp / Cancel',
      'detail': 'Either an up event arrives or the pointer is cancelled.',
      'color': amberAccent,
    },
    {
      'icon': Icons.balance,
      'label': 'Arena resolves',
      'detail': 'Gesture arena picks a winner among competing recognizers.',
      'color': Colors.purple.shade600,
    },
    {
      'icon': Icons.flash_on,
      'label': 'Hook fires',
      'detail': 'handleTapUp / handleTapCancel runs in the subclass.',
      'color': crimson,
    },
  ];

  final lifecycleCards = <Widget>[];
  for (final step in lifecycleSteps) {
    final color = step['color'] as Color;
    lifecycleCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.10),
              color.withValues(alpha: 0.22),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color.withValues(alpha: 0.6), width: 1.4),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.2),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44.0,
              height: 44.0,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(
                step['icon'] as IconData,
                color: Colors.white,
                size: 24.0,
              ),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step['label'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    step['detail'] as String,
                    style: TextStyle(fontSize: 12.0, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final lifecycleSection = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: indigoSoft.withValues(alpha: 0.45),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: indigoMid.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.timeline, color: indigoDeep, size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'Lifecycle: down -> primary -> up/cancel -> arena -> fire',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                color: indigoDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        ...lifecycleCards,
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Class Hierarchy
  // ============================================================
  print('=== Section 3: Class hierarchy ===');

  final hierarchyNodes = [
    {
      'name': 'OneSequenceGestureRecognizer',
      'role': 'Tracks a single sequence of pointer events.',
      'color': indigoDeep,
      'leaf': false,
    },
    {
      'name': 'PrimaryPointerGestureRecognizer',
      'role': 'Adds primary-pointer tracking, slop, deadline.',
      'color': indigoMid,
      'leaf': false,
    },
    {
      'name': 'BaseTapGestureRecognizer (abstract)',
      'role': 'Tap-shape lifecycle: handleTapDown/Up/Cancel.',
      'color': tealDeep,
      'leaf': false,
    },
  ];

  final leaves = [
    {'name': 'TapGestureRecognizer', 'note': 'Single tap'},
    {'name': 'DoubleTapGestureRecognizer', 'note': 'Two taps'},
    {'name': 'SerialTapGestureRecognizer', 'note': 'N rapid taps'},
  ];

  final hierarchyCards = <Widget>[];
  for (var i = 0; i < hierarchyNodes.length; i++) {
    final node = hierarchyNodes[i];
    final color = node['color'] as Color;
    hierarchyCards.add(
      Container(
        margin: EdgeInsets.only(left: i * 16.0, right: 4.0, bottom: 6.0),
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.18),
              color.withValues(alpha: 0.06),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color, width: 1.4),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.25),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              node['name'] as String,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                color: color,
                fontFamily: 'monospace',
              ),
            ),
            SizedBox(height: 3.0),
            Text(
              node['role'] as String,
              style: TextStyle(fontSize: 11.5, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
    hierarchyCards.add(
      Padding(
        padding: EdgeInsets.only(left: i * 16.0 + 12.0),
        child: Icon(Icons.south, size: 16.0, color: color),
      ),
    );
  }

  final leafCards = <Widget>[];
  for (final leaf in leaves) {
    leafCards.add(
      Container(
        width: 150.0,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [tealMid, tealDeep],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: tealDeep.withValues(alpha: 0.4),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              leaf['name'] as String,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              leaf['note'] as String,
              style: TextStyle(color: Colors.white70, fontSize: 10.5),
            ),
          ],
        ),
      ),
    );
  }

  final hierarchySection = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: indigoDeep, size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'Class Hierarchy',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: indigoDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        ...hierarchyCards,
        SizedBox(height: 8.0),
        Text(
          'Concrete subclasses:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
            color: tealDeep,
          ),
        ),
        SizedBox(height: 8.0),
        Wrap(spacing: 10.0, runSpacing: 10.0, children: leafCards),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Abstract Methods
  // ============================================================
  print('=== Section 4: Abstract methods ===');

  final methodSpecs = [
    {
      'name': 'handleTapDown',
      'sig': 'void handleTapDown({required PointerDownEvent down})',
      'desc':
          'Called when the recognizer first registers a tap-style press. '
          'Use it to capture initial position or schedule a deadline.',
      'icon': Icons.south_east,
      'color': indigoMid,
    },
    {
      'name': 'handleTapUp',
      'sig':
          'void handleTapUp({required PointerDownEvent down, '
          'required PointerUpEvent up})',
      'desc':
          'Fires when the gesture is fully accepted and the pointer is '
          'lifted. Use it to dispatch the user-facing onTap callback.',
      'icon': Icons.north_east,
      'color': tealDeep,
    },
    {
      'name': 'handleTapCancel',
      'sig':
          'void handleTapCancel({required PointerDownEvent down, '
          'PointerCancelEvent? cancel, required String reason})',
      'desc':
          'Fires when the recognizer rejects the gesture. The reason '
          'string explains why (forced, slop, deadline, lost arena).',
      'icon': Icons.cancel_outlined,
      'color': crimson,
    },
  ];

  final methodCards = <Widget>[];
  for (final spec in methodSpecs) {
    final color = spec['color'] as Color;
    methodCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color.withValues(alpha: 0.5), width: 1.4),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.18),
              blurRadius: 10.0,
              offset: Offset(0.0, 5.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withValues(alpha: 0.7)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.0),
                  topRight: Radius.circular(14.0),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    spec['icon'] as IconData,
                    color: Colors.white,
                    size: 22.0,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    spec['name'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: slateBg,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      spec['sig'] as String,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.5,
                        color: Colors.cyanAccent.shade100,
                        height: 1.4,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    spec['desc'] as String,
                    style: TextStyle(fontSize: 12.5, color: Colors.black87),
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
  // SECTION 5: Pointer Event Timeline
  // ============================================================
  print('=== Section 5: Pointer event timeline ===');

  final timelineSteps = [
    {
      'time': 't0',
      'event': 'PointerDownEvent',
      'note': 'addAllowedPointer; deadline timer starts.',
      'color': indigoMid,
    },
    {
      'time': 't1',
      'event': 'PointerMoveEvent (small)',
      'note': 'Inside slop tolerance; gesture still alive.',
      'color': tealMid,
    },
    {
      'time': 't2',
      'event': 'PointerUpEvent',
      'note': 'Recognizer resolves accepted in arena.',
      'color': amberAccent,
    },
    {
      'time': 't3',
      'event': 'onTap fired',
      'note': 'User-facing callback runs in handleTapUp.',
      'color': crimson,
    },
  ];

  final timelineWidgets = <Widget>[];
  for (var i = 0; i < timelineSteps.length; i++) {
    final t = timelineSteps[i];
    final color = t['color'] as Color;
    timelineWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.08),
              Colors.white,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
        ),
        child: Row(
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [color, color.withValues(alpha: 0.6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.4),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                t['time'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t['event'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: color,
                    ),
                  ),
                  Text(
                    t['note'] as String,
                    style: TextStyle(fontSize: 11.5, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final timelineSection = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [tealSoft, indigoSoft],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: tealDeep.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.linear_scale, color: tealDeep, size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'Pointer Event Timeline',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: tealDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        ...timelineWidgets,
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Gesture Arena
  // ============================================================
  print('=== Section 6: Gesture arena ===');

  final arenaContestants = [
    {
      'name': 'BaseTapGestureRecognizer',
      'wins': 'On quick down/up within slop & deadline.',
      'color': tealDeep,
      'icon': Icons.touch_app,
      'highlight': true,
    },
    {
      'name': 'HorizontalDragGestureRecognizer',
      'wins': 'When pointer moves past kTouchSlop horizontally.',
      'color': Colors.purple.shade700,
      'icon': Icons.swap_horiz,
      'highlight': false,
    },
    {
      'name': 'LongPressGestureRecognizer',
      'wins': 'When pointer stays still past kLongPressTimeout.',
      'color': amberAccent,
      'icon': Icons.timer,
      'highlight': false,
    },
    {
      'name': 'VerticalDragGestureRecognizer',
      'wins': 'When pointer moves past kTouchSlop vertically.',
      'color': indigoMid,
      'icon': Icons.swap_vert,
      'highlight': false,
    },
  ];

  final arenaCards = <Widget>[];
  for (final c in arenaContestants) {
    final color = c['color'] as Color;
    final highlight = c['highlight'] as bool;
    arenaCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: highlight
                ? [color.withValues(alpha: 0.30), color.withValues(alpha: 0.10)]
                : [Colors.white, Colors.grey.shade100],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: color.withValues(alpha: highlight ? 0.9 : 0.4),
            width: highlight ? 2.0 : 1.0,
          ),
          boxShadow: highlight
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.35),
                    blurRadius: 12.0,
                    offset: Offset(0.0, 5.0),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Icon(c['icon'] as IconData, color: color, size: 26.0),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    c['name'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    c['wins'] as String,
                    style: TextStyle(fontSize: 11.5, color: Colors.black87),
                  ),
                ],
              ),
            ),
            if (highlight)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'FOCUS',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  final arenaSection = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, tealSoft.withValues(alpha: 0.5)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: tealMid.withValues(alpha: 0.4), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: indigoDeep.withValues(alpha: 0.10),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.stadium_outlined, color: indigoDeep, size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'Gesture Arena Competition',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: indigoDeep,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'BaseTapGestureRecognizer competes for the same pointer with '
          'drags and long-presses. The arena resolves a single winner.',
          style: TextStyle(fontSize: 12.5, color: Colors.black87),
        ),
        SizedBox(height: 12.0),
        ...arenaCards,
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Implementing a custom subclass
  // ============================================================
  print('=== Section 7: Custom subclass skeleton ===');

  final tripleTapSkeleton =
      'class TripleTapRecognizer extends BaseTapGestureRecognizer {\n'
      '  int _count = 0;\n'
      '  VoidCallback? onTripleTap;\n'
      '\n'
      '  @override\n'
      '  void handleTapDown({required PointerDownEvent down}) {\n'
      '    _count = _count + 1;\n'
      '  }\n'
      '\n'
      '  @override\n'
      '  void handleTapUp({\n'
      '    required PointerDownEvent down,\n'
      '    required PointerUpEvent up,\n'
      '  }) {\n'
      '    if (_count >= 3) {\n'
      '      _count = 0;\n'
      '      onTripleTap?.call();\n'
      '    }\n'
      '  }\n'
      '\n'
      '  @override\n'
      '  void handleTapCancel({\n'
      '    required PointerDownEvent down,\n'
      '    PointerCancelEvent? cancel,\n'
      '    required String reason,\n'
      '  }) {\n'
      '    _count = 0;\n'
      '  }\n'
      '\n'
      '  @override\n'
      '  String get debugDescription => \'tripleTap\';\n'
      '}\n';

  final subclassSection = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: slateBg,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: slateLine, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyanAccent.shade100, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Custom subclass skeleton',
              style: TextStyle(
                color: Colors.cyanAccent.shade100,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: slateMid,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            tripleTapSkeleton,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.white,
              height: 1.45,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'The arena protocol is inherited; only the three abstract '
          'hooks need overriding for a tap-shaped gesture.',
          style: TextStyle(color: Colors.white70, fontSize: 12.0),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Real-world use cases
  // ============================================================
  print('=== Section 8: Real-world use cases ===');

  final useCases = [
    {
      'title': 'Use TapGestureRecognizer directly',
      'cases':
          'Buttons, ListTile rows, simple onTap callbacks, '
          'GestureDetector wiring.',
      'icon': Icons.check_circle_outline,
      'color': tealDeep,
    },
    {
      'title': 'Subclass BaseTapGestureRecognizer',
      'cases':
          'Triple-tap to debug, multi-finger taps, taps with custom '
          'haptic timing, taps that need extra metadata.',
      'icon': Icons.extension,
      'color': indigoDeep,
    },
    {
      'title': 'Compose with arena teams',
      'cases':
          'Adopt GestureArenaTeam to share victory between custom '
          'tap and existing scrolling recognizers.',
      'icon': Icons.group_work,
      'color': amberAccent,
    },
  ];

  final useCaseCards = <Widget>[];
  for (final u in useCases) {
    final color = u['color'] as Color;
    useCaseCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.10),
              Colors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color.withValues(alpha: 0.5), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.18),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(u['icon'] as IconData, color: color, size: 26.0),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    u['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.5,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    u['cases'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black87,
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
  // SECTION 9: Footguns
  // ============================================================
  print('=== Section 9: Footguns ===');

  final footguns = [
    {
      'title': 'Forgetting to call resolve()',
      'detail':
          'A subclass that never calls resolve(GestureDisposition.accepted) '
          'will hang on every tap and starve other recognizers.',
    },
    {
      'title': 'Mismatched supportedDevices',
      'detail':
          'Setting supportedDevices to a kind that the input layer never '
          'produces silently disables the recognizer.',
    },
    {
      'title': 'Accept/Reject ordering',
      'detail':
          'Calling resolve before enough information arrived can leak '
          'into the next frame; rely on PointerUp to drive resolution.',
    },
    {
      'title': 'Slop tolerance misuse',
      'detail':
          'Setting preAcceptSlopTolerance too high turns drags into '
          'taps; too low causes flaky taps on touch devices.',
    },
    {
      'title': 'Holding onto pointers',
      'detail':
          'Always call stopTrackingPointer in cancel paths so the arena '
          'can release the pointer to other recognizers.',
    },
  ];

  final footgunCards = <Widget>[];
  for (final f in footguns) {
    footgunCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              crimson.withValues(alpha: 0.08),
              Colors.white,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: crimson.withValues(alpha: 0.5), width: 1.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.warning_amber_rounded, color: crimson, size: 22.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    f['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: crimson,
                    ),
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    f['detail'] as String,
                    style: TextStyle(fontSize: 11.5, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final footgunSection = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: crimson.withValues(alpha: 0.4), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: crimson.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.dangerous_outlined, color: crimson, size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'Footguns',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: crimson,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        ...footgunCards,
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Recap card
  // ============================================================
  print('=== Section 10: Recap ===');

  final recapItems = [
    'Abstract: never instantiated directly; use TapGestureRecognizer.',
    'Inherits PrimaryPointerGestureRecognizer (single primary pointer).',
    'Three hooks: handleTapDown, handleTapUp, handleTapCancel.',
    'Lives inside the gesture arena; competes with drag/long-press.',
    'Use when you need a tap-shaped recognizer with custom semantics.',
    'Always call resolve()/stopTrackingPointer() in cancel paths.',
  ];

  final recapTiles = <Widget>[];
  for (var i = 0; i < recapItems.length; i++) {
    recapTiles.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.25),
            width: 1.0,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 24.0,
              height: 24.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.18),
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.0,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                recapItems[i],
                style: TextStyle(
                  fontSize: 12.5,
                  color: Colors.white,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final recapSection = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [tealDeep, indigoDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: indigoDeep.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: tealDeep.withValues(alpha: 0.25),
          blurRadius: 26.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book_outlined, color: Colors.white, size: 24.0),
            SizedBox(width: 10.0),
            Text(
              'Recap',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        ...recapTiles,
      ],
    ),
  );

  // ============================================================
  // Verify abstract type identity (cheap runtime touch)
  // ============================================================
  final probe = TapGestureRecognizer();
  print('Probe runtimeType: ${probe.runtimeType}');
  print('Probe debugDescription: ${probe.debugDescription}');
  print('Probe deadline: ${probe.deadline}');
  probe.dispose();

  print('BaseTapGestureRecognizer Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return Scaffold(
    backgroundColor: Colors.grey.shade50,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 28.0),
          _sectionLabel('1. Anatomy & Lifecycle', indigoDeep),
          SizedBox(height: 10.0),
          lifecycleSection,
          SizedBox(height: 28.0),
          _sectionLabel('2. Class Hierarchy', indigoDeep),
          SizedBox(height: 10.0),
          hierarchySection,
          SizedBox(height: 28.0),
          _sectionLabel('3. Abstract Methods', indigoDeep),
          SizedBox(height: 10.0),
          ...methodCards,
          SizedBox(height: 28.0),
          _sectionLabel('4. Pointer Event Timeline', indigoDeep),
          SizedBox(height: 10.0),
          timelineSection,
          SizedBox(height: 28.0),
          _sectionLabel('5. Gesture Arena', indigoDeep),
          SizedBox(height: 10.0),
          arenaSection,
          SizedBox(height: 28.0),
          _sectionLabel('6. Custom Subclass', indigoDeep),
          SizedBox(height: 10.0),
          subclassSection,
          SizedBox(height: 28.0),
          _sectionLabel('7. Real-world Use Cases', indigoDeep),
          SizedBox(height: 10.0),
          ...useCaseCards,
          SizedBox(height: 28.0),
          _sectionLabel('8. Footguns', indigoDeep),
          SizedBox(height: 10.0),
          footgunSection,
          SizedBox(height: 28.0),
          _sectionLabel('9. Recap', indigoDeep),
          SizedBox(height: 10.0),
          recapSection,
          SizedBox(height: 32.0),
        ],
      ),
    ),
  );
}

// Helper: section label with accent bar
Widget _sectionLabel(String text, Color color) {
  return Row(
    children: [
      Container(
        width: 6.0,
        height: 22.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3.0),
        ),
      ),
      SizedBox(width: 10.0),
      Text(
        text,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    ],
  );
}
