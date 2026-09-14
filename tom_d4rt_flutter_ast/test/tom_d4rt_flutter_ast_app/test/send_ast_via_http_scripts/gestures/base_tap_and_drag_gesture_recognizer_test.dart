// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests BaseTapAndDragGestureRecognizer from gestures
// Deep Demo: Visual demonstration of the abstract BaseTapAndDragGestureRecognizer
// covering hierarchy, lifecycle, callbacks, slop detection, consecutive tap
// counting, gesture-arena competition, and real-world text-selection patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BaseTapAndDragGestureRecognizer Deep Demo executing');

  // ============================================================
  // SECTION 1: Title Banner
  // ============================================================
  print('=== Section 1: Title Banner ===');

  final titleBanner = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.indigo.shade700,
          Colors.indigo.shade400,
          Colors.teal.shade400,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.3),
          blurRadius: 24.0,
          offset: Offset(0.0, 14.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.touch_app, size: 60.0, color: Colors.white),
        SizedBox(height: 10.0),
        Text(
          'BaseTapAndDragGestureRecognizer',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.6,
          ),
        ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.5),
              width: 1.0,
            ),
          ),
          child: Text(
            'abstract • single primary pointer • tap → drag fusion',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'Deep Demo of the abstract base used by '
          'TapAndPanGestureRecognizer and friends.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
      ],
    ),
  );
  print('Created title banner');

  // ============================================================
  // SECTION 2: Class Hierarchy
  // ============================================================
  print('=== Section 2: Class Hierarchy ===');

  final hierarchy = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.teal.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Class Hierarchy',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 18.0),
        _buildHierarchyNode(
          'GestureRecognizer',
          'package:flutter/gestures.dart',
          Colors.grey.shade400,
          0,
          isAbstract: true,
        ),
        _buildHierarchyArrow(),
        _buildHierarchyNode(
          'OneSequenceGestureRecognizer',
          'one pointer sequence at a time',
          Colors.indigo.shade300,
          1,
          isAbstract: true,
        ),
        _buildHierarchyArrow(),
        _buildHierarchyNode(
          'BaseTapAndDragGestureRecognizer',
          'tap + drag fusion (abstract)',
          Colors.indigo.shade600,
          2,
          isAbstract: true,
          highlight: true,
        ),
        _buildHierarchyArrow(),
        _buildHierarchyNode(
          'TapAndPanGestureRecognizer',
          'concrete: any-direction pan',
          Colors.teal.shade600,
          3,
        ),
      ],
    ),
  );
  print('Created class hierarchy');

  // ============================================================
  // SECTION 3: Lifecycle (5 numbered steps with timeline)
  // ============================================================
  print('=== Section 3: Lifecycle ===');

  final lifecycleSteps = <Map<String, Object>>[
    {
      'n': 1,
      'title': 'Pointer Down',
      'desc':
          'A primary pointer touches the screen. The recognizer registers the '
              'down event and starts tracking position and timestamp.',
      'icon': Icons.fiber_manual_record,
      'color': Colors.indigo,
    },
    {
      'n': 2,
      'title': 'Primary Pointer Accepted',
      'desc':
          'The recognizer claims the gesture-arena slot for this single '
              'primary pointer. Secondary pointers are rejected.',
      'icon': Icons.flag,
      'color': Colors.teal,
    },
    {
      'n': 3,
      'title': 'Slop Check',
      'desc':
          'While the pointer remains within `kTouchSlop` of the origin, the '
              'gesture is still ambiguous (could be tap or drag).',
      'icon': Icons.radio_button_unchecked,
      'color': Colors.amber.shade700,
    },
    {
      'n': 4,
      'title': 'Tap-or-Drag Decision',
      'desc':
          'If the pointer drifts outside slop → onDragStart fires. If it lifts '
              'inside slop → onTapUp fires. Mutually exclusive branches.',
      'icon': Icons.alt_route,
      'color': Colors.deepPurple,
    },
    {
      'n': 5,
      'title': 'End',
      'desc':
          'Either onDragEnd (with velocity) or onTapUp completes the cycle. '
              'consecutiveTapCount may carry into the next sequence.',
      'icon': Icons.flag_circle,
      'color': Colors.pink,
    },
  ];

  final lifecycleCards = <Widget>[];
  for (final step in lifecycleSteps) {
    final n = step['n'] as int;
    final color = step['color'] as Color;
    final isLast = n == lifecycleSteps.length;
    print('Lifecycle step $n: ${step['title']}');
    lifecycleCards.add(
      IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Timeline column with circle and connector line
            SizedBox(
              width: 56.0,
              child: Column(
                children: [
                  Container(
                    width: 44.0,
                    height: 44.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          color.withValues(alpha: 0.6),
                          color,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.5),
                          blurRadius: 8.0,
                          offset: Offset(0.0, 3.0),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '$n',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 4.0,
                        margin: EdgeInsets.symmetric(vertical: 4.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [color, color.withValues(alpha: 0.2)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 12.0),
                padding: EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: color.withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.15),
                      blurRadius: 8.0,
                      offset: Offset(0.0, 2.0),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(step['icon'] as IconData, color: color, size: 20.0),
                        SizedBox(width: 8.0),
                        Text(
                          step['title'] as String,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      step['desc'] as String,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey.shade800,
                        height: 1.35,
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

  final lifecycleSection = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade50, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Lifecycle Timeline',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Pointer Down → Accept → Slop Check → Decision → End',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 18.0),
        ...lifecycleCards,
      ],
    ),
  );
  print('Created ${lifecycleCards.length} lifecycle cards');

  // ============================================================
  // SECTION 4: Callback Signatures (dark monospace cards)
  // ============================================================
  print('=== Section 4: Callback Signatures ===');

  final callbackSignatures = [
    {
      'name': 'onTapDown',
      'sig': 'GestureTapDragDownCallback? onTapDown;\n'
          '\n'
          '// Called when the primary pointer first contacts the screen.\n'
          'typedef GestureTapDragDownCallback =\n'
          '    void Function(TapDragDownDetails details);',
      'color': Colors.cyan,
    },
    {
      'name': 'onTapUp',
      'sig': 'GestureTapDragUpCallback? onTapUp;\n'
          '\n'
          '// Called when the primary pointer lifts WITHIN slop.\n'
          'typedef GestureTapDragUpCallback =\n'
          '    void Function(TapDragUpDetails details);',
      'color': Colors.green,
    },
    {
      'name': 'onDragStart',
      'sig': 'GestureTapDragStartCallback? onDragStart;\n'
          '\n'
          '// Called when the pointer drifts OUTSIDE slop.\n'
          'typedef GestureTapDragStartCallback =\n'
          '    void Function(TapDragStartDetails details);',
      'color': Colors.orange,
    },
    {
      'name': 'onDragUpdate',
      'sig': 'GestureTapDragUpdateCallback? onDragUpdate;\n'
          '\n'
          '// Called for every drag delta during an active drag.\n'
          'typedef GestureTapDragUpdateCallback =\n'
          '    void Function(TapDragUpdateDetails details);',
      'color': Colors.amber,
    },
    {
      'name': 'onDragEnd',
      'sig': 'GestureTapDragEndCallback? onDragEnd;\n'
          '\n'
          '// Called when the drag terminates (with velocity).\n'
          'typedef GestureTapDragEndCallback =\n'
          '    void Function(TapDragEndDetails details);',
      'color': Colors.pink,
    },
  ];

  final callbackCards = <Widget>[];
  for (final cb in callbackSignatures) {
    final color = cb['color'] as Color;
    print('Callback: ${cb['name']}');
    callbackCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: color.withValues(alpha: 0.5),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.25),
              blurRadius: 12.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.18),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
                border: Border(
                  bottom: BorderSide(
                    color: color.withValues(alpha: 0.4),
                    width: 1.0,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.6),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    cb['name'] as String,
                    style: TextStyle(
                      color: color,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
            // Code body
            Padding(
              padding: EdgeInsets.all(14.0),
              child: Text(
                cb['sig'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  color: Colors.grey.shade100,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${callbackCards.length} callback signature cards');

  // ============================================================
  // SECTION 5: ConsecutiveTapCount Explainer
  // ============================================================
  print('=== Section 5: ConsecutiveTapCount ===');

  final tapBlobs = <Widget>[];
  final tapData = [
    {'n': 1, 'label': '1st tap', 'color': Colors.indigo, 'gap': 'origin'},
    {'n': 2, 'label': '2nd tap', 'color': Colors.teal, 'gap': '+120ms'},
    {'n': 3, 'label': '3rd tap', 'color': Colors.deepPurple, 'gap': '+240ms'},
  ];
  for (final tap in tapData) {
    final color = tap['color'] as Color;
    final n = tap['n'] as int;
    print('Tap $n at ${tap['gap']}');
    tapBlobs.add(
      Column(
        children: [
          Container(
            width: 64.0,
            height: 64.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  color.withValues(alpha: 0.9),
                  color.withValues(alpha: 0.3),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.5),
                  blurRadius: 12.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: Center(
              child: Text(
                '$n',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            tap['label'] as String,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            tap['gap'] as String,
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 4.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'count = $n',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final consecutiveTapSection = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade50, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'consecutiveTapCount',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Each tap within kDoubleTapTimeout (~300ms) of the previous '
          'increments consecutiveTapCount.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 18.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: tapBlobs,
        ),
        SizedBox(height: 18.0),
        Container(
          height: 36.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.deepPurple.shade200, width: 1.0),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.indigo.shade300,
                        Colors.indigo.shade400,
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(7.0),
                      bottomLeft: Radius.circular(7.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '0ms',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.teal.shade400,
                  child: Center(
                    child: Text(
                      '120ms',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepPurple.shade400,
                        Colors.deepPurple.shade500,
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(7.0),
                      bottomRight: Radius.circular(7.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '240ms',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.amber.shade300, width: 1.0),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 18.0,
                color: Colors.amber.shade800,
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'A gap > kDoubleTapTimeout RESETS the count back to 1.',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Colors.amber.shade900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created consecutive-tap explainer');

  // ============================================================
  // SECTION 6: Slop / Tolerance Visualisation
  // ============================================================
  print('=== Section 6: Slop / Tolerance ===');

  final slopSection = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade50, Colors.cyan.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Slop Tolerance',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'kTouchSlop (~18 logical pixels) defines the tap-vs-drag boundary.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSlopDiagram(
              'Inside slop\n→ Tap',
              Colors.green,
              0.4,
              Icons.check_circle,
            ),
            _buildSlopDiagram(
              'Crossing slop\n→ Drag',
              Colors.orange,
              1.4,
              Icons.swap_horiz,
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.teal.shade200, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    color: Colors.teal.shade700,
                    size: 18.0,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Mental model',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: Colors.teal.shade900,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.0),
              Text(
                'Imagine a small invisible circle around the touch origin. '
                'A pointer that lifts inside the circle = tap. A pointer that '
                'leaves the circle = drag. The recognizer commits to ONE branch '
                'and never goes back.',
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.grey.shade800,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created slop section');

  // ============================================================
  // SECTION 7: Gesture-Arena Competition
  // ============================================================
  print('=== Section 7: Gesture Arena ===');

  final arenaSection = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.indigo.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.4),
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
            Icon(
              Icons.sports_kabaddi,
              color: Colors.amber.shade300,
              size: 22.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'Gesture Arena Competition',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade300,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildArenaContestant(
              'TapAndPan',
              'tap + any-direction drag',
              Colors.teal.shade300,
              true,
            ),
            _buildArenaContestant(
              'HorizontalDrag',
              'horizontal-only',
              Colors.orange.shade300,
              false,
            ),
            _buildArenaContestant(
              'VerticalDrag',
              'vertical-only',
              Colors.pink.shade300,
              false,
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.amber.withValues(alpha: 0.3),
              width: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Arena resolution rules',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade200,
                ),
              ),
              SizedBox(height: 8.0),
              _buildArenaRule(
                '1.',
                'All recognizers join the arena on pointer-down.',
              ),
              _buildArenaRule(
                '2.',
                'A directional drag (Horizontal/Vertical) wins fast if the '
                    'motion clearly matches its axis.',
              ),
              _buildArenaRule(
                '3.',
                'TapAndPan wins by default if no directional recognizer '
                    'commits — useful for text selection.',
              ),
              _buildArenaRule(
                '4.',
                'Set eagerVictoryOnDrag = true to win the arena as soon as '
                    'a drag is detected, without waiting for sweep.',
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created gesture-arena section');

  // ============================================================
  // SECTION 8: Real-World Mock — Text Selection
  // ============================================================
  print('=== Section 8: Text Selection Mock ===');

  final textSelectionSection = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue.shade50, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blue.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Real-World: Text Selection',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 14.0),
        _buildSelectionRow(
          'Tap',
          'Move caret',
          'consecutiveTapCount = 1, no drag',
          Colors.indigo,
          Icons.touch_app,
        ),
        _buildSelectionRow(
          'Tap + Drag',
          'Select range',
          'tap → slop crossed → onDragUpdate extends selection',
          Colors.teal,
          Icons.swipe,
        ),
        _buildSelectionRow(
          'Double-tap',
          'Select word',
          'consecutiveTapCount = 2',
          Colors.deepPurple,
          Icons.text_fields,
        ),
        _buildSelectionRow(
          'Triple-tap',
          'Select line',
          'consecutiveTapCount = 3',
          Colors.pink,
          Icons.format_align_left,
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.indigo.shade100, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.article_outlined,
                    color: Colors.indigo.shade400,
                    size: 18.0,
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Sample document',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.grey.shade800,
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(text: 'The '),
                    TextSpan(
                      text: 'quick',
                      style: TextStyle(
                        backgroundColor:
                            Colors.deepPurple.withValues(alpha: 0.25),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: ' brown fox '),
                    TextSpan(
                      text: 'jumps over the lazy dog',
                      style: TextStyle(
                        backgroundColor: Colors.teal.withValues(alpha: 0.25),
                      ),
                    ),
                    TextSpan(text: '. '),
                    TextSpan(
                      text: '|',
                      style: TextStyle(
                        color: Colors.indigo.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  _buildSelectionLegend(
                      'caret', Colors.indigo.shade700, isCaret: true),
                  SizedBox(width: 12.0),
                  _buildSelectionLegend('drag-range', Colors.teal),
                  SizedBox(width: 12.0),
                  _buildSelectionLegend('double-tap word', Colors.deepPurple),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created text-selection section');

  // ============================================================
  // SECTION 9: Custom Subclass Skeleton
  // ============================================================
  print('=== Section 9: Custom Subclass Skeleton ===');

  final subclassSkeleton =
      "// Skeleton — do not actually instantiate at runtime.\n"
      "// BaseTapAndDragGestureRecognizer is abstract; concrete subclasses\n"
      "// implement isPointerAllowed and gesture-arena strategy.\n"
      "\n"
      "class _MyTapAndPan extends BaseTapAndDragGestureRecognizer {\n"
      "  _MyTapAndPan({super.debugOwner, super.supportedDevices});\n"
      "\n"
      "  @override\n"
      "  bool isPointerAllowed(PointerDownEvent event) {\n"
      "    // Restrict to primary buttons and accepted devices.\n"
      "    return event.buttons == kPrimaryButton &&\n"
      "        super.isPointerAllowed(event);\n"
      "  }\n"
      "\n"
      "  @override\n"
      "  String get debugDescription => 'my custom tap+pan';\n"
      "\n"
      "  // Override hooks (optional):\n"
      "  //   void handleTapDown({ required PointerDownEvent down }) { ... }\n"
      "  //   void handleTapUp({ required PointerDownEvent down,\n"
      "  //                      required PointerUpEvent up }) { ... }\n"
      "  //   void handleTapCancel({ required PointerDownEvent down,\n"
      "  //                          PointerCancelEvent? cancel,\n"
      "  //                          required String reason }) { ... }\n"
      "  //   void handleDragStart(PointerEvent event) { ... }\n"
      "  //   void handleDragUpdate({ ... }) { ... }\n"
      "  //   void handleDragEnd(PointerEvent event) { ... }\n"
      "}\n";

  final subclassCard = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.teal.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.3),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.teal.withValues(alpha: 0.15),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(13.0),
              topRight: Radius.circular(13.0),
            ),
            border: Border(
              bottom:
                  BorderSide(color: Colors.teal.shade400.withValues(alpha: 0.5)),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.code, size: 20.0, color: Colors.teal.shade300),
              SizedBox(width: 10.0),
              Text(
                'Custom Subclass Skeleton',
                style: TextStyle(
                  color: Colors.teal.shade200,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  'reference only',
                  style: TextStyle(
                    color: Colors.amber.shade300,
                    fontSize: 10.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            subclassSkeleton,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Colors.grey.shade100,
              height: 1.55,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created subclass skeleton');

  // ============================================================
  // SECTION 10: Footgun Cards
  // ============================================================
  print('=== Section 10: Footgun Cards ===');

  final footguns = [
    {
      'title': 'Tap delays accept',
      'desc':
          'onTapUp does NOT fire instantly on pointer-up — the recognizer '
              'waits for the arena to resolve to ensure no drag follows.',
      'icon': Icons.hourglass_bottom,
      'color': Colors.red,
    },
    {
      'title': 'Drag preempts tap',
      'desc':
          'Once slop is crossed, onTapUp will NEVER fire for that sequence. '
              'Plan callbacks for mutual exclusion.',
      'icon': Icons.block,
      'color': Colors.orange,
    },
    {
      'title': 'Slop ≠ tolerance',
      'desc':
          'kTouchSlop is for tap-vs-drag — not for hit-testing. Don\'t conflate '
              'with widget hit-test margins.',
      'icon': Icons.straighten,
      'color': Colors.amber,
    },
    {
      'title': 'consecutiveTapCount resets on slop',
      'desc':
          'Crossing slop in any tap of a sequence cancels the multi-tap. The '
              'next pointer-down restarts at count = 1.',
      'icon': Icons.refresh,
      'color': Colors.deepPurple,
    },
    {
      'title': 'debugOwner uniqueness',
      'desc':
          'Use a distinct debugOwner per recognizer. Sharing breaks logs and '
              'arena diagnostics, especially across selectable widgets.',
      'icon': Icons.label_important_outline,
      'color': Colors.pink,
    },
  ];

  final footgunCards = <Widget>[];
  for (final fg in footguns) {
    final color = fg['color'] as Color;
    print('Footgun: ${fg['title']}');
    footgunCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.08),
              color.withValues(alpha: 0.18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: color.withValues(alpha: 0.5),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.18),
              blurRadius: 8.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.25),
                shape: BoxShape.circle,
              ),
              child: Icon(
                fg['icon'] as IconData,
                color: color,
                size: 24.0,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fg['title'] as String,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    fg['desc'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade800,
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
  print('Created ${footgunCards.length} footgun cards');

  // ============================================================
  // SECTION 11: Recap Card
  // ============================================================
  print('=== Section 11: Recap ===');

  final recapCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.indigo.shade600,
          Colors.indigo.shade400,
          Colors.teal.shade400,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.4),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: Colors.white, size: 26.0),
            SizedBox(width: 10.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildRecapBullet(
            'Abstract base — extend, never instantiate directly.'),
        _buildRecapBullet('Fuses tap and drag in a single primary-pointer flow.'),
        _buildRecapBullet(
            'Slop decides tap vs drag; commitment is one-way.'),
        _buildRecapBullet(
            'consecutiveTapCount enables word/line selection patterns.'),
        _buildRecapBullet(
            'Concrete: TapAndPanGestureRecognizer (used by SelectionContainer).'),
        _buildRecapBullet('eagerVictoryOnDrag tunes arena behavior.'),
      ],
    ),
  );
  print('Created recap card');

  print('BaseTapAndDragGestureRecognizer Deep Demo completed successfully');

  // ============================================================
  // Final assembly
  // ============================================================
  return Scaffold(
    backgroundColor: Colors.grey.shade100,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 24.0),
          _sectionLabel('1. Class Hierarchy'),
          hierarchy,
          SizedBox(height: 24.0),
          _sectionLabel('2. Lifecycle'),
          lifecycleSection,
          SizedBox(height: 24.0),
          _sectionLabel('3. Callback Signatures'),
          ...callbackCards,
          SizedBox(height: 24.0),
          _sectionLabel('4. Consecutive Tap Count'),
          consecutiveTapSection,
          SizedBox(height: 24.0),
          _sectionLabel('5. Slop Tolerance'),
          slopSection,
          SizedBox(height: 24.0),
          _sectionLabel('6. Gesture Arena'),
          arenaSection,
          SizedBox(height: 24.0),
          _sectionLabel('7. Text Selection'),
          textSelectionSection,
          SizedBox(height: 24.0),
          _sectionLabel('8. Custom Subclass Skeleton'),
          subclassCard,
          SizedBox(height: 24.0),
          _sectionLabel('9. Footguns'),
          ...footgunCards,
          SizedBox(height: 24.0),
          _sectionLabel('10. Recap'),
          recapCard,
          SizedBox(height: 32.0),
        ],
      ),
    ),
  );
}

// ============================================================
// Top-level helpers
// ============================================================

Widget _sectionLabel(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
    child: Row(
      children: [
        Container(
          width: 6.0,
          height: 24.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade600, Colors.teal.shade400],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        SizedBox(width: 10.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
      ],
    ),
  );
}

Widget _buildHierarchyNode(
  String name,
  String subtitle,
  Color color,
  int depth, {
  bool isAbstract = false,
  bool highlight = false,
}) {
  return Container(
    margin: EdgeInsets.only(left: depth * 12.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: highlight
          ? LinearGradient(
              colors: [
                color.withValues(alpha: 0.85),
                color.withValues(alpha: 0.6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
          : null,
      color: highlight ? null : Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: highlight ? 2.0 : 1.2),
      boxShadow: highlight
          ? [
              BoxShadow(
                color: color.withValues(alpha: 0.45),
                blurRadius: 10.0,
                offset: Offset(0.0, 4.0),
              ),
            ]
          : null,
    ),
    child: Row(
      children: [
        Icon(
          isAbstract ? Icons.crop_din : Icons.check_box,
          color: highlight ? Colors.white : color,
          size: 20.0,
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: highlight ? Colors.white : color,
                      fontFamily: 'monospace',
                    ),
                  ),
                  SizedBox(width: 8.0),
                  if (isAbstract)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.0, vertical: 1.0),
                      decoration: BoxDecoration(
                        color: highlight
                            ? Colors.white.withValues(alpha: 0.25)
                            : color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: Text(
                        'abstract',
                        style: TextStyle(
                          fontSize: 9.0,
                          color: highlight ? Colors.white : color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 2.0),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11.0,
                  color: highlight
                      ? Colors.white.withValues(alpha: 0.9)
                      : Colors.grey.shade700,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildHierarchyArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Center(
      child: Icon(
        Icons.arrow_downward,
        color: Colors.indigo.shade400,
        size: 22.0,
      ),
    ),
  );
}

Widget _buildSlopDiagram(
  String label,
  Color color,
  double driftFactor,
  IconData icon,
) {
  // driftFactor < 1.0 means pointer stays inside slop, > 1.0 means crosses.
  final slopRadius = 50.0;
  final pointerOffset = slopRadius * driftFactor;
  return Column(
    children: [
      Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
        ),
        child: Stack(
          children: [
            // Slop circle
            Center(
              child: Container(
                width: slopRadius * 2.0,
                height: slopRadius * 2.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withValues(alpha: 0.12),
                  border: Border.all(
                    color: color.withValues(alpha: 0.6),
                    width: 1.5,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
            // Origin dot
            Center(
              child: Container(
                width: 10.0,
                height: 10.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.indigo.shade700,
                ),
              ),
            ),
            // Drift arrow
            Positioned(
              left: 70.0,
              top: 70.0 - 10.0,
              child: Transform.translate(
                offset: Offset(pointerOffset, 0.0),
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.5),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Icon(icon, color: Colors.white, size: 14.0),
                ),
              ),
            ),
            // Slop label
            Positioned(
              top: 4.0,
              left: 0.0,
              right: 0.0,
              child: Text(
                'slop',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10.0,
                  color: color,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 8.0),
      Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    ],
  );
}

Widget _buildArenaContestant(
  String name,
  String subtitle,
  Color color,
  bool winner,
) {
  return Container(
    width: 100.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: winner ? Colors.amber.shade300 : color.withValues(alpha: 0.6),
        width: winner ? 2.0 : 1.2,
      ),
    ),
    child: Column(
      children: [
        Icon(
          winner ? Icons.emoji_events : Icons.shield_outlined,
          color: winner ? Colors.amber.shade300 : color,
          size: 28.0,
        ),
        SizedBox(height: 6.0),
        Text(
          name,
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 2.0),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 9.5,
            color: Colors.white.withValues(alpha: 0.7),
            fontStyle: FontStyle.italic,
          ),
        ),
        if (winner) ...[
          SizedBox(height: 4.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 1.0),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'default win',
              style: TextStyle(
                fontSize: 9.0,
                color: Colors.amber.shade200,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ],
    ),
  );
}

Widget _buildArenaRule(String marker, String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          marker,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.amber.shade300,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 11.5,
              color: Colors.white.withValues(alpha: 0.85),
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSelectionRow(
  String trigger,
  String effect,
  String detail,
  Color color,
  IconData icon,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.2),
    ),
    child: Row(
      children: [
        Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withValues(alpha: 0.18),
          ),
          child: Icon(icon, color: color, size: 18.0),
        ),
        SizedBox(width: 10.0),
        SizedBox(
          width: 90.0,
          child: Text(
            trigger,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                effect,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade900,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                detail,
                style: TextStyle(
                  fontSize: 10.5,
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSelectionLegend(String label, Color color, {bool isCaret = false}) {
  return Row(
    children: [
      Container(
        width: 14.0,
        height: 14.0,
        decoration: BoxDecoration(
          color: isCaret ? Colors.transparent : color.withValues(alpha: 0.3),
          border: isCaret ? Border.all(color: color, width: 2.0) : null,
          borderRadius: BorderRadius.circular(3.0),
        ),
      ),
      SizedBox(width: 4.0),
      Text(
        label,
        style: TextStyle(
          fontSize: 10.0,
          color: Colors.grey.shade700,
        ),
      ),
    ],
  );
}

Widget _buildRecapBullet(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle, color: Colors.white, size: 16.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}
