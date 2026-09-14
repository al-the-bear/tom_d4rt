// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable
// D4rt test script: Tests MultiDragGestureRecognizer (abstract) + subclasses
// from package:flutter/gestures.dart
//
// Deep Demo: Visual encyclopedia of MultiDragGestureRecognizer — the abstract
// base class for recognizers that handle multiple simultaneous pointer drags.
// Covers the four canonical subclasses, the multi-pointer flow, the lifecycle
// timeline, recipes built around `onStart` returning a `Drag`, and the most
// common pitfalls when mixing single-pointer and multi-pointer recognizers
// inside the same gesture arena.
//
// All visuals use Duration.zero + AlwaysStoppedAnimation<double> to remain
// deterministic when sent over the AST channel — there is no real animation
// or interaction; we render a static, instructive snapshot.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MultiDragGestureRecognizer Deep Demo executing');

  // ============================================================
  // SECTION 0: Construct one of every concrete subclass
  // ============================================================
  // We touch every concrete subclass of MultiDragGestureRecognizer so that
  // the AST stream covers their constructors. We dispose them immediately;
  // none of them are wired to a hit-testable widget, so no real gesture
  // arena participation occurs.
  print('=== Section 0: Subclass instantiation sweep ===');

  final immediateProbe = ImmediateMultiDragGestureRecognizer();
  print('ImmediateMultiDragGestureRecognizer: ${immediateProbe.debugDescription}');
  immediateProbe.dispose();

  final delayedProbe = DelayedMultiDragGestureRecognizer(
    delay: kPressTimeout,
  );
  print('DelayedMultiDragGestureRecognizer: ${delayedProbe.debugDescription}');
  delayedProbe.dispose();

  final horizontalProbe = HorizontalMultiDragGestureRecognizer();
  print('HorizontalMultiDragGestureRecognizer: ${horizontalProbe.debugDescription}');
  horizontalProbe.dispose();

  final verticalProbe = VerticalMultiDragGestureRecognizer();
  print('VerticalMultiDragGestureRecognizer: ${verticalProbe.debugDescription}');
  verticalProbe.dispose();

  // ============================================================
  // SECTION 1: Hero header
  // ============================================================
  print('=== Section 1: Hero header ===');

  final hero = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF0F2027),
          Color(0xFF203A43),
          Color(0xFF2C5364),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
          blurRadius: 22.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.25),
          blurRadius: 36.0,
          offset: Offset(0.0, 0.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.cyanAccent, Colors.tealAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withValues(alpha: 0.6),
                    blurRadius: 18.0,
                    offset: Offset(0.0, 6.0),
                  ),
                ],
              ),
              child: Icon(Icons.touch_app, size: 44.0, color: Colors.black87),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MultiDragGestureRecognizer',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'abstract base for recognizing multiple simultaneous drags',
                    style: TextStyle(fontSize: 13.5, color: Colors.cyan.shade100),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.cyan.shade400, width: 1.0),
          ),
          child: Text(
            'Each pointer that hits the recognizer becomes its own MultiDragPointerState. '
            'When onStart returns a non-null Drag, that Drag receives update/end/cancel '
            'callbacks for that pointer alone. Many fingers, many independent drags.',
            style: TextStyle(
              color: Colors.cyan.shade50,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy / abstract API surface
  // ============================================================
  print('=== Section 2: Anatomy / abstract API surface ===');

  final anatomyEntries = <Map<String, Object>>[
    {
      'symbol': 'GestureMultiDragStartCallback? onStart',
      'role':
          'Called for each pointer once the recognizer accepts it. Return a Drag (or null to ignore).',
      'icon': Icons.flag,
      'tone': Colors.green,
    },
    {
      'symbol': 'void addAllowedPointer(PointerDownEvent event)',
      'role':
          'Entry point from the gesture binding. Creates a MultiDragPointerState for the new pointer.',
      'icon': Icons.input,
      'tone': Colors.blue,
    },
    {
      'symbol': 'MultiDragPointerState createNewPointerState(...)',
      'role':
          'Subclass hook. Each subclass returns its own state object that decides when to win the arena.',
      'icon': Icons.extension,
      'tone': Colors.indigo,
    },
    {
      'symbol': 'void acceptGesture(int pointer)',
      'role':
          'Called by the arena. Triggers onStart(initialPosition) and stores the resulting Drag.',
      'icon': Icons.check_circle,
      'tone': Colors.teal,
    },
    {
      'symbol': 'void rejectGesture(int pointer)',
      'role':
          'Called by the arena when another recognizer wins. The pointer state is torn down quietly.',
      'icon': Icons.block,
      'tone': Colors.deepOrange,
    },
    {
      'symbol': 'void dispose()',
      'role':
          'Tears down every active pointer state. Always call when the host widget is disposed.',
      'icon': Icons.delete_sweep,
      'tone': Colors.red,
    },
  ];

  final anatomyRows = <Widget>[];
  for (final entry in anatomyEntries) {
    final tone = entry['tone'] as Color;
    anatomyRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              tone.withValues(alpha: 0.10),
              tone.withValues(alpha: 0.02),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: tone.withValues(alpha: 0.55), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: tone.withValues(alpha: 0.18),
              blurRadius: 10.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: tone.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(entry['icon'] as IconData, color: tone, size: 22.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry['symbol'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: tone,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    entry['role'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade800,
                      height: 1.35,
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

  final anatomySection = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.architecture, color: Colors.indigo, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Abstract API surface',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'MultiDragGestureRecognizer cannot be instantiated directly — these are the '
          'pieces every subclass either overrides or relies on.',
          style: TextStyle(fontSize: 12.5, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12.0),
        ...anatomyRows,
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Subclass tree
  // ============================================================
  print('=== Section 3: Subclass tree ===');

  Widget treeNode({
    required String label,
    required Color color,
    required IconData icon,
    String? sub,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.0),
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.85),
            color.withValues(alpha: 0.55),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.45),
            blurRadius: 9.0,
            offset: Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 22.0),
          SizedBox(height: 4.0),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (sub != null) ...[
            SizedBox(height: 2.0),
            Text(
              sub,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 9.5),
            ),
          ],
        ],
      ),
    );
  }

  final subclassTree = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade50, Colors.indigo.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.12),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'Subclass Tree',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade900,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Each subclass differs only in *when* its MultiDragPointerState declares victory.',
          style: TextStyle(fontSize: 12.0, color: Colors.deepPurple.shade700),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 18.0),
        // Root
        treeNode(
          label: 'MultiDragGestureRecognizer',
          color: Colors.deepPurple,
          icon: Icons.account_tree,
          sub: 'abstract',
        ),
        SizedBox(height: 8.0),
        Icon(Icons.south, color: Colors.deepPurple.shade400),
        SizedBox(height: 6.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            treeNode(
              label: 'Immediate',
              color: Colors.green.shade700,
              icon: Icons.flash_on,
              sub: 'wins on any move',
            ),
            treeNode(
              label: 'Delayed',
              color: Colors.orange.shade700,
              icon: Icons.timer,
              sub: 'wins after delay',
            ),
            treeNode(
              label: 'Horizontal',
              color: Colors.blue.shade700,
              icon: Icons.swap_horiz,
              sub: 'wins on dx > slop',
            ),
            treeNode(
              label: 'Vertical',
              color: Colors.teal.shade700,
              icon: Icons.swap_vert,
              sub: 'wins on dy > slop',
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Multi-pointer trajectory diagram (CustomPainter)
  // ============================================================
  print('=== Section 4: Multi-pointer trajectory diagram ===');

  final trajectoryDiagram = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.purple.withValues(alpha: 0.35),
          blurRadius: 18.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.gesture, color: Colors.pinkAccent, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Three pointers, three independent drags',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'The recognizer creates one MultiDragPointerState per pointer. Each '
          'state independently tracks displacement and competes in the arena.',
          style: TextStyle(color: Colors.white70, fontSize: 11.5, height: 1.4),
        ),
        SizedBox(height: 12.0),
        SizedBox(
          height: 220.0,
          child: CustomPaint(
            painter: _MultiDragTrajectoryPainter(
              progress: AlwaysStoppedAnimation<double>(1.0),
            ),
            size: Size.infinite,
          ),
        ),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 12.0,
          children: [
            _legendDot('pointer #1 (immediate)', Colors.greenAccent),
            _legendDot('pointer #2 (horizontal)', Colors.lightBlueAccent),
            _legendDot('pointer #3 (delayed)', Colors.orangeAccent),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Per-subclass cards
  // ============================================================
  print('=== Section 5: Per-subclass cards ===');

  final subclassCards = <Widget>[];
  final subclassData = <Map<String, Object>>[
    {
      'name': 'ImmediateMultiDragGestureRecognizer',
      'short': 'Immediate',
      'icon': Icons.flash_on,
      'tone': Colors.green,
      'wins': 'on the first PointerMoveEvent — even before slop is crossed',
      'use':
          'Rearranging items in a freeform canvas, finger painting, multi-finger transform pads.',
      'avoid':
          'Lists that must scroll: ImmediateMultiDrag will steal pointers from the ListView.',
      'sample': '0.05',
    },
    {
      'name': 'DelayedMultiDragGestureRecognizer',
      'short': 'Delayed',
      'icon': Icons.timer,
      'tone': Colors.orange,
      'wins': 'after the configured delay (default kPressTimeout = 100ms) elapses with the pointer down',
      'use':
          'Long-press-then-drag interactions: ReorderableListView, Trello-like cards, drag handles.',
      'avoid':
          'Snappy controls — users will perceive the delay as lag if you set it too high.',
      'sample': '0.30',
    },
    {
      'name': 'HorizontalMultiDragGestureRecognizer',
      'short': 'Horizontal',
      'icon': Icons.swap_horiz,
      'tone': Colors.blue,
      'wins': 'when |dx| exceeds kTouchSlop on a per-pointer basis',
      'use':
          'Multi-finger horizontal swipe boards, side-scrolling editors that allow several fingers at once.',
      'avoid':
          'Vertical lists — competes badly with vertical scroll if your layout is mostly vertical.',
      'sample': '0.55',
    },
    {
      'name': 'VerticalMultiDragGestureRecognizer',
      'short': 'Vertical',
      'icon': Icons.swap_vert,
      'tone': Colors.teal,
      'wins': 'when |dy| exceeds kTouchSlop on a per-pointer basis',
      'use':
          'Pull-to-action lanes, multi-finger vertical pickers, parallel column reordering.',
      'avoid':
          'Combining with PageView for horizontal paging without explicit gesture team.',
      'sample': '0.80',
    },
  ];

  for (final s in subclassData) {
    final tone = s['tone'] as Color;
    final sample = double.parse(s['sample'] as String);
    subclassCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              tone.withValues(alpha: 0.06),
              tone.withValues(alpha: 0.18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: tone, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: tone.withValues(alpha: 0.25),
              blurRadius: 12.0,
              offset: Offset(0.0, 5.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: tone,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: tone.withValues(alpha: 0.6),
                        blurRadius: 10.0,
                        offset: Offset(0.0, 3.0),
                      ),
                    ],
                  ),
                  child: Icon(s['icon'] as IconData, color: Colors.white, size: 22.0),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s['short'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: tone,
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        s['name'] as String,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11.5,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            _kvLine('Wins arena', s['wins'] as String, Icons.emoji_events, tone),
            SizedBox(height: 6.0),
            _kvLine('Use for', s['use'] as String, Icons.thumb_up, Colors.green.shade700),
            SizedBox(height: 6.0),
            _kvLine('Watch out', s['avoid'] as String, Icons.warning_amber, Colors.red.shade700),
            SizedBox(height: 12.0),
            // Mini progress visualization for "how far the pointer travels
            // before this recognizer claims victory" — purely illustrative.
            Row(
              children: [
                Text(
                  'arena win threshold',
                  style: TextStyle(
                    fontSize: 10.5,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Container(
                    height: 10.0,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: sample,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [tone.withValues(alpha: 0.6), tone],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Text(
                  '${(sample * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.5,
                    color: tone,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 6: Lifecycle timeline
  // ============================================================
  print('=== Section 6: Lifecycle timeline ===');

  final lifecycleSteps = <Map<String, Object>>[
    {
      'phase': 'PointerDown',
      'desc':
          'GestureBinding routes the event. addAllowedPointer is invoked; createNewPointerState builds a state object.',
      'icon': Icons.fiber_manual_record,
      'tone': Colors.indigo,
    },
    {
      'phase': 'Tracking',
      'desc':
          'PointerMoveEvents are forwarded to the pointer state. It accumulates displacement and decides if/when to claim the arena.',
      'icon': Icons.timeline,
      'tone': Colors.blue,
    },
    {
      'phase': 'Arena resolved',
      'desc':
          'On accept: acceptGesture(pointer) -> onStart(initialPosition) -> the returned Drag becomes the active client for that pointer.',
      'icon': Icons.gavel,
      'tone': Colors.green,
    },
    {
      'phase': 'Drag.update',
      'desc':
          'For each subsequent move, the recognizer calls drag.update(DragUpdateDetails(...)) on the per-pointer Drag.',
      'icon': Icons.compare_arrows,
      'tone': Colors.teal,
    },
    {
      'phase': 'Drag.end / Drag.cancel',
      'desc':
          'PointerUp -> drag.end(velocity). If the gesture is rejected mid-stream the recognizer calls drag.cancel().',
      'icon': Icons.stop_circle,
      'tone': Colors.deepOrange,
    },
    {
      'phase': 'State teardown',
      'desc':
          'The MultiDragPointerState is removed from the recognizer\'s internal map; recognizer keeps living for other pointers.',
      'icon': Icons.cleaning_services,
      'tone': Colors.brown,
    },
  ];

  final lifecycleNodes = <Widget>[];
  for (var i = 0; i < lifecycleSteps.length; i++) {
    final step = lifecycleSteps[i];
    final tone = step['tone'] as Color;
    lifecycleNodes.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 36.0,
                height: 36.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [tone, tone.withValues(alpha: 0.6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: tone.withValues(alpha: 0.55),
                      blurRadius: 8.0,
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
              if (i != lifecycleSteps.length - 1)
                Container(
                  width: 2.0,
                  height: 56.0,
                  color: tone.withValues(alpha: 0.45),
                ),
            ],
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 12.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: tone.withValues(alpha: 0.5), width: 1.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(step['icon'] as IconData, color: tone, size: 18.0),
                      SizedBox(width: 6.0),
                      Text(
                        step['phase'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: tone,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    step['desc'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade800,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  final lifecycleSection = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.orange.shade200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.18),
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
            Icon(Icons.access_time, color: Colors.deepOrange, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Lifecycle of a single pointer',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'This timeline runs once per active pointer. With three fingers down, three of these pipelines run in parallel.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.deepOrange.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 14.0),
        ...lifecycleNodes,
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Recipes (using onStart returning a Drag)
  // ============================================================
  print('=== Section 7: Recipes ===');

  final recipeBlocks = <Widget>[
    _recipeCard(
      title: 'Recipe 1 — minimal Drag delegate',
      tone: Colors.green,
      icon: Icons.restaurant_menu,
      blurb:
          'A bare-bones Drag implementation. onStart returns it; the recognizer drives it for that pointer\'s lifetime.',
      code:
          'class _PrintingDrag implements Drag {\n'
          '  @override void update(DragUpdateDetails d) =>\n'
          '      print(\'move \${d.delta}\');\n'
          '  @override void end(DragEndDetails d) =>\n'
          '      print(\'end \${d.velocity}\');\n'
          '  @override void cancel() => print(\'cancel\');\n'
          '}\n'
          '\n'
          'final r = ImmediateMultiDragGestureRecognizer()\n'
          '  ..onStart = (Offset p) => _PrintingDrag();',
    ),
    _recipeCard(
      title: 'Recipe 2 — long-press then drag',
      tone: Colors.orange,
      icon: Icons.timer_outlined,
      blurb:
          'DelayedMultiDragGestureRecognizer is what ReorderableListView uses internally. The pointer must hold still for `delay` before the drag begins.',
      code:
          'final reorder = DelayedMultiDragGestureRecognizer(\n'
          '  delay: const Duration(milliseconds: 300),\n'
          ')..onStart = (Offset p) {\n'
          '  HapticFeedback.lightImpact();\n'
          '  return _CardDrag(p);\n'
          '};',
    ),
    _recipeCard(
      title: 'Recipe 3 — axis-locked multi-finger',
      tone: Colors.blue,
      icon: Icons.straighten,
      blurb:
          'HorizontalMultiDragGestureRecognizer waits for kTouchSlop along x. Many fingers can swipe horizontally in parallel without fighting a vertical scroller.',
      code:
          'final swipe = HorizontalMultiDragGestureRecognizer()\n'
          '  ..onStart = (Offset p) {\n'
          '    return _LaneSwipeDrag(\n'
          '      laneIndexFor(p),\n'
          '    );\n'
          '  };',
    ),
    _recipeCard(
      title: 'Recipe 4 — wiring into RawGestureDetector',
      tone: Colors.purple,
      icon: Icons.cable,
      blurb:
          'Multi-drag recognizers are typically registered via RawGestureDetector\'s gestures map.',
      code:
          'RawGestureDetector(\n'
          '  gestures: {\n'
          '    ImmediateMultiDragGestureRecognizer:\n'
          '      GestureRecognizerFactoryWithHandlers<\n'
          '        ImmediateMultiDragGestureRecognizer>(\n'
          '        () => ImmediateMultiDragGestureRecognizer(),\n'
          '        (r) => r.onStart =\n'
          '            (Offset p) => _MyDrag(p),\n'
          '      ),\n'
          '  },\n'
          '  child: child,\n'
          ')',
    ),
  ];

  // ============================================================
  // SECTION 8: Pitfalls (single vs multi competition)
  // ============================================================
  print('=== Section 8: Pitfalls ===');

  final pitfallEntries = <Map<String, Object>>[
    {
      'title': 'Immediate steals from Scrollables',
      'detail':
          'ImmediateMultiDragGestureRecognizer wins on the first move event. Inside a ListView this beats the vertical drag recognizer and disables scrolling. Prefer Delayed* or Horizontal* unless you really want to override scrolling.',
      'tone': Colors.red,
    },
    {
      'title': 'Single-pointer Pan vs MultiDrag',
      'detail':
          'PanGestureRecognizer accepts only one pointer; MultiDrag spawns one Drag per pointer. They compete in the arena per-pointer. If both are registered, only one will win for each pointer — usually the more eager one (Immediate* or whichever has a smaller threshold).',
      'tone': Colors.deepOrange,
    },
    {
      'title': 'Forgetting to dispose',
      'detail':
          'Each pointer state holds timers and pointer routes. Always call recognizer.dispose() when the host widget is disposed; otherwise pointers leak and reappear on the next gesture.',
      'tone': Colors.amber,
    },
    {
      'title': 'Returning null from onStart',
      'detail':
          'A null return value means "I don\'t want this pointer". The recognizer still wins the arena slot, suppressing other recognizers, but no Drag is driven. Use this intentionally — never accidentally.',
      'tone': Colors.indigo,
    },
    {
      'title': 'Delay too high feels like a bug',
      'detail':
          'DelayedMultiDragGestureRecognizer with delay > ~400ms is widely perceived as broken. Stick to 100-300ms unless you have a strong UX reason.',
      'tone': Colors.teal,
    },
    {
      'title': 'Mixing Horizontal and Vertical Multi',
      'detail':
          'When both are registered without a custom gesture team, the first axis to cross slop wins. This usually does the right thing, but if a finger arrives at exactly 45° both can race; use a custom team or pick one axis to be authoritative.',
      'tone': Colors.purple,
    },
  ];

  final pitfallCards = <Widget>[];
  for (final p in pitfallEntries) {
    final tone = p['tone'] as Color;
    pitfallCards.add(
      Container(
        width: 280.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              tone.withValues(alpha: 0.18),
              tone.withValues(alpha: 0.04),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: tone.withValues(alpha: 0.6), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: tone.withValues(alpha: 0.25),
              blurRadius: 9.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.warning_amber, color: tone, size: 20.0),
                SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    p['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: tone,
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Text(
              p['detail'] as String,
              style: TextStyle(
                fontSize: 11.5,
                color: Colors.grey.shade800,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final pitfallsSection = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.pink.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.report_problem, color: Colors.red, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls (single vs multi-recognizer competition)',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'These are the failure modes that show up the second a gesture-rich screen ships to real fingers.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.red.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: pitfallCards,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: ASCII footer
  // ============================================================
  print('=== Section 9: ASCII footer ===');

  const String asciiArt =
      '+---------------------------------------------------------+\n'
      '|       MultiDragGestureRecognizer  -- gesture arena      |\n'
      '+---------------------------------------------------------+\n'
      '|                                                         |\n'
      '|   pointer #1 ---->  [ImmediateState]  --(move)--> WIN   |\n'
      '|   pointer #2 ---->  [HorizontalState] --(|dx|>slop)-> WIN|\n'
      '|   pointer #3 ---->  [DelayedState]    --(t>=delay)--> WIN|\n'
      '|                                                         |\n'
      '|        |               |                |               |\n'
      '|        v               v                v               |\n'
      '|   onStart(p1)     onStart(p2)      onStart(p3)          |\n'
      '|        |               |                |               |\n'
      '|        v               v                v               |\n'
      '|     Drag #1         Drag #2          Drag #3            |\n'
      '|   .update/.end    .update/.end     .update/.end         |\n'
      '|                                                         |\n'
      '+---------------------------------------------------------+';

  final asciiFooter = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF0B0F19), Color(0xFF1B2030)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.18),
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
            Icon(Icons.terminal, color: Colors.greenAccent, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'ascii :: arena snapshot',
              style: TextStyle(
                color: Colors.greenAccent,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          asciiArt,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.greenAccent.shade100,
            height: 1.25,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Three pointers, three independent state machines, three Drag callbacks.\n'
          'That is the entire abstraction in one picture.',
          style: TextStyle(
            color: Colors.greenAccent.withValues(alpha: 0.85),
            fontFamily: 'monospace',
            fontSize: 10.5,
          ),
        ),
      ],
    ),
  );

  print('MultiDragGestureRecognizer Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            hero,
            SizedBox(height: 22.0),
            _sectionLabel('1. Anatomy of the abstract base', Icons.architecture, Colors.indigo),
            anatomySection,
            SizedBox(height: 22.0),
            _sectionLabel('2. Subclass tree', Icons.account_tree, Colors.deepPurple),
            subclassTree,
            SizedBox(height: 22.0),
            _sectionLabel('3. Multi-pointer trajectory diagram', Icons.gesture, Colors.pink),
            trajectoryDiagram,
            SizedBox(height: 22.0),
            _sectionLabel('4. Per-subclass cards', Icons.style, Colors.blueGrey),
            ...subclassCards,
            SizedBox(height: 22.0),
            _sectionLabel('5. Lifecycle timeline', Icons.access_time, Colors.deepOrange),
            lifecycleSection,
            SizedBox(height: 22.0),
            _sectionLabel('6. Recipes (onStart returning a Drag)', Icons.restaurant_menu, Colors.green),
            ...recipeBlocks,
            SizedBox(height: 22.0),
            _sectionLabel('7. Pitfalls', Icons.report_problem, Colors.red),
            pitfallsSection,
            SizedBox(height: 22.0),
            _sectionLabel('8. ASCII footer', Icons.terminal, Colors.teal),
            asciiFooter,
            SizedBox(height: 22.0),
            // Bottom credit strip
            Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo.shade400, Colors.purple.shade400],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withValues(alpha: 0.35),
                    blurRadius: 12.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.white, size: 18.0),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      'Reference: package:flutter/gestures.dart — MultiDragGestureRecognizer '
                      'and its four canonical subclasses.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
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

// ----------------------------------------------------------------
// Helpers
// ----------------------------------------------------------------

Widget _sectionLabel(String text, IconData icon, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: color, size: 18.0),
        ),
        SizedBox(width: 8.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _kvLine(String key, String value, IconData icon, Color tone) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, color: tone, size: 16.0),
      SizedBox(width: 6.0),
      SizedBox(
        width: 90.0,
        child: Text(
          key,
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.bold,
            color: tone,
          ),
        ),
      ),
      Expanded(
        child: Text(
          value,
          style: TextStyle(
            fontSize: 11.5,
            color: Colors.grey.shade800,
            height: 1.35,
          ),
        ),
      ),
    ],
  );
}

Widget _legendDot(String label, Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 12.0,
        height: 12.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.7),
              blurRadius: 6.0,
            ),
          ],
        ),
      ),
      SizedBox(width: 6.0),
      Text(
        label,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 11.0,
          fontFamily: 'monospace',
        ),
      ),
    ],
  );
}

Widget _recipeCard({
  required String title,
  required Color tone,
  required IconData icon,
  required String blurb,
  required String code,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          tone.withValues(alpha: 0.10),
          tone.withValues(alpha: 0.02),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: tone.withValues(alpha: 0.5), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: tone.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: tone, size: 20.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.5,
                  color: tone,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          blurb,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade800,
            height: 1.4,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF1E1E2F),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: tone.withValues(alpha: 0.3), width: 1.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Colors.greenAccent.shade100,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------
// CustomPainter: multi-pointer trajectory diagram
// ----------------------------------------------------------------

class _MultiDragTrajectoryPainter extends CustomPainter {
  _MultiDragTrajectoryPainter({required this.progress}) : super(repaint: progress);

  final Animation<double> progress;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final t = progress.value;

    // Soft background grid
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1.0;
    for (double x = 0.0; x <= w; x += 28.0) {
      canvas.drawLine(Offset(x, 0.0), Offset(x, h), gridPaint);
    }
    for (double y = 0.0; y <= h; y += 28.0) {
      canvas.drawLine(Offset(0.0, y), Offset(w, y), gridPaint);
    }

    // Three trajectories representing three pointers
    _drawTrajectory(
      canvas: canvas,
      from: Offset(w * 0.10, h * 0.80),
      to: Offset(w * 0.45, h * 0.20),
      color: Colors.greenAccent,
      label: 'P1',
      t: t,
    );
    _drawTrajectory(
      canvas: canvas,
      from: Offset(w * 0.10, h * 0.50),
      to: Offset(w * 0.85, h * 0.50),
      color: Colors.lightBlueAccent,
      label: 'P2',
      t: t,
    );
    _drawTrajectory(
      canvas: canvas,
      from: Offset(w * 0.55, h * 0.85),
      to: Offset(w * 0.85, h * 0.20),
      color: Colors.orangeAccent,
      label: 'P3',
      t: t,
    );

    // Arena box outline
    final arenaPaint = Paint()
      ..color = Colors.purpleAccent.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(6.0, 6.0, w - 12.0, h - 12.0),
        Radius.circular(10.0),
      ),
      arenaPaint,
    );

    // Arena label
    final tp = TextPainter(
      text: TextSpan(
        text: 'gesture arena',
        style: TextStyle(
          color: Colors.purpleAccent.withValues(alpha: 0.9),
          fontSize: 10.0,
          fontFamily: 'monospace',
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(12.0, 8.0));
  }

  void _drawTrajectory({
    required Canvas canvas,
    required Offset from,
    required Offset to,
    required Color color,
    required String label,
    required double t,
  }) {
    final segPaint = Paint()
      ..color = color.withValues(alpha: 0.85)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    final endPoint = Offset.lerp(from, to, t)!;
    canvas.drawLine(from, endPoint, segPaint);

    // Glow
    final glowPaint = Paint()
      ..color = color.withValues(alpha: 0.25)
      ..strokeWidth = 9.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawLine(from, endPoint, glowPaint);

    // Start dot (touch-down)
    final downPaint = Paint()..color = color;
    canvas.drawCircle(from, 6.0, downPaint);
    final downRing = Paint()
      ..color = color.withValues(alpha: 0.4)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(from, 11.0, downRing);

    // End dot (current position)
    final upPaint = Paint()..color = color.withValues(alpha: 0.95);
    canvas.drawCircle(endPoint, 5.0, upPaint);

    // Label near start
    final tp = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: color,
          fontFamily: 'monospace',
          fontSize: 11.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, from + Offset(10.0, -16.0));
  }

  @override
  bool shouldRepaint(covariant _MultiDragTrajectoryPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
