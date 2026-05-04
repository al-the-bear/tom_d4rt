// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import, unnecessary_cast
// D4rt test script: Deep visual demo of the Drag abstract interface from
// package:flutter/gestures.dart. Drag is the per-pointer callback bundle that
// MultiDragGestureRecognizer hands out: update(DragUpdateDetails),
// end(DragEndDetails), and cancel(). This demo visualises the lifecycle, the
// payload structures, recipes for implementing it, and pitfalls.
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // PRE-COMPUTED DETAIL OBJECTS — referenced across sections
  // ============================================================
  final updateA = DragUpdateDetails(
    globalPosition: Offset(120.0, 240.0),
    localPosition: Offset(40.0, 80.0),
    delta: Offset(6.0, 4.0),
    primaryDelta: null,
    sourceTimeStamp: Duration(milliseconds: 16),
  );
  final updateB = DragUpdateDetails(
    globalPosition: Offset(140.0, 244.0),
    localPosition: Offset(60.0, 84.0),
    delta: Offset(20.0, 4.0),
    sourceTimeStamp: Duration(milliseconds: 32),
  );
  final updateC = DragUpdateDetails(
    globalPosition: Offset(180.0, 250.0),
    localPosition: Offset(100.0, 90.0),
    delta: Offset(40.0, 6.0),
    sourceTimeStamp: Duration(milliseconds: 48),
  );

  final endFling = DragEndDetails(
    velocity: Velocity(pixelsPerSecond: Offset(1200.0, 80.0)),
    primaryVelocity: 1200.0,
  );
  final endSlow = DragEndDetails(
    velocity: Velocity(pixelsPerSecond: Offset(60.0, 0.0)),
    primaryVelocity: 60.0,
  );
  final endZero = DragEndDetails(
    velocity: Velocity.zero,
    primaryVelocity: 0.0,
  );

  // ============================================================
  // SECTION 1: HERO HEADER
  // ============================================================
  final heroHeader = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF1A237E),
          Color(0xFF6A1B9A),
          Color(0xFFAD1457),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF1A237E).withValues(alpha: 0.4),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Color(0xFFAD1457).withValues(alpha: 0.25),
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
            Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.30),
                    Colors.white.withValues(alpha: 0.10),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 1.0,
                ),
              ),
              child: Icon(
                Icons.swipe,
                size: 56.0,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'abstract class Drag',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14.0,
                      color: Colors.white70,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Drag Interface',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Per-pointer callback bundle for MultiDragGestureRecognizer',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _heroChip('package:flutter/gestures.dart', Icons.inventory_2_outlined),
            _heroChip('update()', Icons.timeline),
            _heroChip('end()', Icons.flag_outlined),
            _heroChip('cancel()', Icons.cancel_outlined),
            _heroChip('per-pointer', Icons.touch_app),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: ANATOMY OF THE DRAG STATE MACHINE
  // ============================================================
  final anatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 20.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.indigo.shade50,
          Colors.blue.shade50,
          Colors.cyan.shade50,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.10),
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
            Icon(Icons.account_tree, color: Colors.indigo.shade700, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Drag Lifecycle',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'The recogniser instantiates a Drag when the pointer wins the arena. '
          'It then drives the object via three methods until exactly one '
          'terminal call (end or cancel) is made.',
          style: TextStyle(fontSize: 13.0, color: Colors.indigo.shade900),
        ),
        SizedBox(height: 20.0),
        Row(
          children: [
            Expanded(child: _stateNode('CREATED', Colors.grey, Icons.add_circle_outline, 'recogniser hands you a Drag')),
            _arrow('onStart', Colors.indigo),
            Expanded(child: _stateNode('UPDATING', Colors.green, Icons.timeline, 'pointer moves; update() fires')),
          ],
        ),
        SizedBox(height: 12.0),
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.amber.shade100, Colors.deepOrange.shade100],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.deepOrange.shade300, width: 1.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.fork_right, size: 16.0, color: Colors.deepOrange.shade700),
                SizedBox(width: 6.0),
                Text(
                  'either path',
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange.shade700,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(child: _stateNode('ENDED', Colors.blue, Icons.flag, 'pointer lifted; end() with velocity')),
            SizedBox(width: 12.0),
            Expanded(child: _stateNode('CANCELLED', Colors.red, Icons.cancel, 'system stole the pointer')),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: PER-METHOD CARDS — update / end / cancel
  // ============================================================
  final updateCard = _methodCard(
    name: 'update(DragUpdateDetails details)',
    tagline: 'pointer has moved',
    color: Colors.green,
    icon: Icons.timeline,
    fires: 'every frame the pointer changes position while the drag owns the arena',
    payload: 'DragUpdateDetails',
    bullets: [
      'globalPosition — pointer in screen coords',
      'localPosition — pointer relative to your render box',
      'delta — Offset moved since the last update',
      'primaryDelta — set only for 1-D recognisers (H or V)',
      'sourceTimeStamp — event time, useful for velocity tracking',
    ],
    samples: [updateA, updateB, updateC],
    gradient: LinearGradient(
      colors: [Colors.green.shade100, Colors.teal.shade50],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  final endCard = _endCard(
    color: Colors.blue,
    samples: [endFling, endSlow, endZero],
  );

  final cancelCard = _cancelCard(color: Colors.red);

  // ============================================================
  // SECTION 4: DRAGUPDATEDETAILS PAYLOAD INSPECTOR
  // ============================================================
  final updateInspector = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.green.shade50, Colors.lime.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.green.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.18),
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
            Icon(Icons.search, color: Colors.green.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'DragUpdateDetails — payload inspector',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        for (final entry in <List<dynamic>>[
          ['globalPosition', updateA.globalPosition.toString(), 'screen coords'],
          ['localPosition', updateA.localPosition.toString(), 'render-box coords'],
          ['delta', updateA.delta.toString(), 'movement since last update'],
          ['primaryDelta', '${updateA.primaryDelta}', 'null unless 1-D recogniser'],
          ['sourceTimeStamp', '${updateA.sourceTimeStamp}', 'PointerMoveEvent.timeStamp'],
        ])
          _kvRow(entry[0] as String, entry[1] as String, entry[2] as String, Colors.green.shade700),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: DRAGENDDETAILS — VELOCITY VECTOR DIAGRAM
  // ============================================================
  final velocityDiagram = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.blue.shade50,
          Colors.lightBlue.shade50,
          Colors.cyan.shade50,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blue.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withValues(alpha: 0.18),
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
            Icon(Icons.rocket_launch, color: Colors.blue.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'DragEndDetails — velocity at lift-off',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _velocityCard('Fling', endFling, Colors.deepOrange),
            _velocityCard('Slow lift', endSlow, Colors.amber),
            _velocityCard('Stationary', endZero, Colors.blueGrey),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'primaryVelocity is the scalar projection on the recogniser\u2019s '
            'axis; null for 2-D pan recognisers. Use velocity.pixelsPerSecond '
            'to drive momentum simulations.',
            style: TextStyle(fontSize: 12.0, color: Colors.blue.shade900),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: RECIPES — IMPLEMENTING DRAG
  // ============================================================
  final recipes = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.purple.shade50,
          Colors.deepPurple.shade50,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.purple.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.purple.withValues(alpha: 0.18),
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
            Icon(Icons.menu_book, color: Colors.purple.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Recipes — implementing Drag',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _recipeBlock(
          'Minimal subclass',
          'class TileDrag extends Drag {\n'
              '  final void Function(Offset) onDelta;\n'
              '  TileDrag(this.onDelta);\n'
              '  @override void update(DragUpdateDetails d) => onDelta(d.delta);\n'
              '  @override void end(DragEndDetails d) {/* settle */}\n'
              '  @override void cancel() {/* snap back */}\n'
              '}',
          Colors.green.shade300,
        ),
        SizedBox(height: 10.0),
        _recipeBlock(
          'Hand it to MultiDragGestureRecognizer',
          'final r = ImmediateMultiDragGestureRecognizer()\n'
              '  ..onStart = (Offset p) => TileDrag((delta) {\n'
              '        position = position + delta;\n'
              '      });',
          Colors.cyan.shade300,
        ),
        SizedBox(height: 10.0),
        _recipeBlock(
          'Compose with VelocityTracker for inertia',
          'class InertialDrag extends Drag {\n'
              '  final VelocityTracker tracker = VelocityTracker.withKind(\n'
              '      PointerDeviceKind.touch);\n'
              '  @override void update(DragUpdateDetails d) {\n'
              '    tracker.addPosition(d.sourceTimeStamp!, d.localPosition);\n'
              '  }\n'
              '  @override void end(DragEndDetails d) =>\n'
              '      simulateFling(d.velocity);\n'
              '  @override void cancel() => simulateFling(Velocity.zero);\n'
              '}',
          Colors.amber.shade300,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: PITFALLS — COMMON MISTAKES
  // ============================================================
  final pitfalls = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.red.shade50,
          Colors.orange.shade50,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.18),
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
            Icon(Icons.warning_amber, color: Colors.red.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _pitfallTile(
          'Forgetting cancel()',
          'A drag can be cancelled at any time (system modal, route push, '
              'pointer steal). If your subclass only handles end(), state can '
              'leak — always reset/snap-back in cancel().',
          Icons.error_outline,
          Colors.red,
        ),
        SizedBox(height: 8.0),
        _pitfallTile(
          'Reading primaryDelta on a 2-D recogniser',
          'primaryDelta is non-null only for HorizontalDragGestureRecognizer '
              'and VerticalDragGestureRecognizer-style pipelines. For pan, '
              'use delta and project yourself.',
          Icons.swap_horiz,
          Colors.deepOrange,
        ),
        SizedBox(height: 8.0),
        _pitfallTile(
          'Calling end() and cancel() both',
          'The contract is exactly one terminal call. Implementations should '
              'be idempotent — guard with a bool flag if you wire your own '
              'recogniser.',
          Icons.do_not_disturb_on,
          Colors.pink,
        ),
        SizedBox(height: 8.0),
        _pitfallTile(
          'Ignoring sourceTimeStamp',
          'Without it, VelocityTracker cannot estimate velocity properly and '
              'end() will see Velocity.zero on real devices.',
          Icons.timer_off,
          Colors.amber,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: COMPARISON — Drag vs DragGestureRecognizer
  // ============================================================
  final comparison = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.teal.shade50,
          Colors.cyan.shade50,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.18),
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
            Icon(Icons.compare_arrows, color: Colors.teal.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Drag vs DragGestureRecognizer',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Row(
          children: [
            Expanded(
              child: _compareColumn(
                'Drag (interface)',
                Colors.indigo,
                Icons.touch_app,
                [
                  'Per-pointer object',
                  'Created by MultiDragGestureRecognizer',
                  'Three methods: update / end / cancel',
                  'You implement it',
                  'Used for parallel multi-finger drags',
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _compareColumn(
                'DragGestureRecognizer',
                Colors.deepPurple,
                Icons.gesture,
                [
                  'Single drag at a time',
                  'Subclassed by Horizontal/Vertical/Pan',
                  'Callbacks: onStart/onUpdate/onEnd',
                  'You configure callbacks',
                  'Used by GestureDetector',
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: TIMELINE — synthetic stream of update() calls
  // ============================================================
  final timeline = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.deepPurple.shade50,
          Colors.indigo.shade50,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.18),
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
            Icon(Icons.show_chart, color: Colors.deepPurple.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Synthetic update() stream',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'A real drag delivers an update() per move-event. Below is a synthetic '
          'three-frame trace.',
          style: TextStyle(fontSize: 12.0, color: Colors.deepPurple.shade900),
        ),
        SizedBox(height: 14.0),
        _timelineRow(0, updateA, Colors.green),
        _timelineRow(1, updateB, Colors.teal),
        _timelineRow(2, updateC, Colors.indigo),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade100, Colors.cyan.shade100],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Icon(Icons.flag, color: Colors.blue.shade900, size: 18.0),
              SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  'frame 3 → end(velocity: ${endFling.velocity.pixelsPerSecond})',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: PROGRESS BARS — animation of an in-progress drag
  // ============================================================
  final progress = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.lightGreen.shade50,
          Colors.green.shade50,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.lightGreen.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.lightGreen.withValues(alpha: 0.18),
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
            Icon(Icons.trending_up, color: Colors.green.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Animated drag progress (static snapshot)',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _progressRow('horizontal', 0.25, Colors.green),
        _progressRow('horizontal', 0.55, Colors.teal),
        _progressRow('horizontal', 0.85, Colors.indigo),
        SizedBox(height: 8.0),
        Text(
          'Each bar shows the cumulative offset / total swipe distance after '
          'a sequence of update() calls.',
          style: TextStyle(fontSize: 11.0, color: Colors.green.shade900),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 11: QUICK REFERENCE TABLE
  // ============================================================
  final quickRef = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.blueGrey.shade50,
          Colors.grey.shade100,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blueGrey.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.withValues(alpha: 0.18),
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
            Icon(Icons.menu_book_outlined,
                color: Colors.blueGrey.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Quick reference',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _refRow('update(d)', 'pointer moved', 'every frame', Colors.green),
        _refRow('end(d)', 'pointer lifted', 'once, terminal', Colors.blue),
        _refRow('cancel()', 'arena lost / preempted', 'once, terminal', Colors.red),
      ],
    ),
  );

  // ============================================================
  // SECTION 12: ASCII FOOTER
  // ============================================================
  final asciiFooter = Container(
    margin: EdgeInsets.only(top: 24.0, bottom: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade700, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
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
            Icon(Icons.terminal, color: Colors.greenAccent, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              '\$ man drag',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 14.0,
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          '   +-----------+   onStart    +-----------+\n'
          '   | recognise |------------> |   Drag    |\n'
          '   +-----------+              +-----+-----+\n'
          '                                    |\n'
          '              update(details) <-----+----- pointer move\n'
          '                                    |\n'
          '              end(velocity)   <-----+----- pointer up\n'
          '              cancel()        <-----+----- system steal\n',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: Colors.greenAccent.shade100,
            height: 1.4,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          '// per-pointer; created by MultiDragGestureRecognizer',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.cyanAccent,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // ASSEMBLE
  // ============================================================
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            heroHeader,
            anatomy,
            Text(
              '3. Per-method cards',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            updateCard,
            SizedBox(height: 12.0),
            endCard,
            SizedBox(height: 12.0),
            cancelCard,
            updateInspector,
            velocityDiagram,
            recipes,
            pitfalls,
            comparison,
            timeline,
            progress,
            quickRef,
            asciiFooter,
          ],
        ),
      ),
    ),
  );
}

// ============================================================
// HELPERS
// ============================================================

Widget _heroChip(String label, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.25),
          Colors.white.withValues(alpha: 0.10),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.4),
        width: 1.0,
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.0, color: Colors.white),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

Widget _stateNode(String label, Color color, IconData icon, String subtitle) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.20),
          color.withValues(alpha: 0.08),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color, width: 2.0),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 28.0),
        SizedBox(height: 6.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10.0, color: Colors.black87),
        ),
      ],
    ),
  );
}

Widget _arrow(String label, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 6.0),
    child: Column(
      children: [
        Icon(Icons.arrow_forward, color: color, size: 28.0),
        Text(
          label,
          style: TextStyle(fontSize: 10.0, color: color),
        ),
      ],
    ),
  );
}

Widget _methodCard({
  required String name,
  required String tagline,
  required MaterialColor color,
  required IconData icon,
  required String fires,
  required String payload,
  required List<String> bullets,
  required List<DragUpdateDetails> samples,
  required Gradient gradient,
}) {
  return Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color.shade400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
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
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color.shade100,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: color.shade400, width: 1.0),
              ),
              child: Icon(icon, color: color.shade800, size: 22.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: color.shade900,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    tagline,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontStyle: FontStyle.italic,
                      color: color.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            Icon(Icons.bolt, color: color.shade700, size: 14.0),
            SizedBox(width: 4.0),
            Expanded(
              child: Text(
                'fires: $fires',
                style: TextStyle(fontSize: 11.0, color: color.shade900),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Row(
          children: [
            Icon(Icons.inventory_2_outlined, color: color.shade700, size: 14.0),
            SizedBox(width: 4.0),
            Text(
              'payload: $payload',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: color.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        for (final b in bullets)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.fiber_manual_record,
                    size: 8.0, color: color.shade700),
                SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    b,
                    style:
                        TextStyle(fontSize: 11.0, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: 10.0),
        for (final s in samples)
          Container(
            margin: EdgeInsets.symmetric(vertical: 3.0),
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: color.shade200, width: 1.0),
            ),
            child: Text(
              'delta=${s.delta}, primary=${s.primaryDelta}, t=${s.sourceTimeStamp}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: color.shade900,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _endCard({
  required MaterialColor color,
  required List<DragEndDetails> samples,
}) {
  return Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.shade100, Colors.lightBlue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color.shade400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
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
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color.shade100,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: color.shade400, width: 1.0),
              ),
              child: Icon(Icons.flag_outlined,
                  color: color.shade800, size: 22.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'end(DragEndDetails details)',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: color.shade900,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    'pointer is no longer in contact with the screen',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontStyle: FontStyle.italic,
                      color: color.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'fires: exactly once when the user lifts; this is your cue to settle, '
          'fling, or commit. The velocity is computed from recent samples.',
          style: TextStyle(fontSize: 12.0, color: color.shade900),
        ),
        SizedBox(height: 12.0),
        for (final s in samples)
          Container(
            margin: EdgeInsets.symmetric(vertical: 4.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: color.shade200, width: 1.0),
            ),
            child: Row(
              children: [
                Icon(Icons.speed, size: 14.0, color: color.shade700),
                SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    'velocity=${s.velocity.pixelsPerSecond} primaryVelocity=${s.primaryVelocity}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: color.shade900,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _cancelCard({required MaterialColor color}) {
  return Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.shade100, Colors.pink.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color.shade400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
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
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color.shade100,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: color.shade400, width: 1.0),
              ),
              child: Icon(Icons.cancel_outlined,
                  color: color.shade800, size: 22.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'cancel()',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: color.shade900,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    'input is no longer directed towards this receiver',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontStyle: FontStyle.italic,
                      color: color.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Receives no payload — just the signal that you should snap back, '
          'release locks, dispose VelocityTrackers, or otherwise undo any '
          'in-progress visual changes.',
          style: TextStyle(fontSize: 12.0, color: color.shade900),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: color.shade200, width: 1.0),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, size: 14.0, color: color.shade700),
              SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  'Typical triggers: route push, system modal, '
                  'GestureBinding.cancelPointer, parent recogniser steal.',
                  style: TextStyle(fontSize: 11.0, color: color.shade900),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _kvRow(String key, String value, String comment, Color accent) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130.0,
          child: Text(
            key,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: accent,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            comment,
            style: TextStyle(fontSize: 10.0, color: accent),
          ),
        ),
      ],
    ),
  );
}

Widget _velocityCard(String label, DragEndDetails d, MaterialColor color) {
  final magnitude = d.velocity.pixelsPerSecond.distance;
  // Normalise magnitude to a 0..1 fraction for the bar visual; cap at 1500 px/s.
  final fraction =
      (magnitude / 1500.0).clamp(0.0, 1.0) as double;
  final anim = AlwaysStoppedAnimation<double>(fraction);
  return Container(
    width: 100.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.shade100,
          color.shade50,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.shade400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.bolt, color: color.shade800, size: 20.0),
        SizedBox(height: 4.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color.shade900,
          ),
        ),
        SizedBox(height: 6.0),
        Container(
          height: 40.0,
          width: 16.0,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 40.0 * anim.value,
              decoration: BoxDecoration(
                color: color.shade700,
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          '${magnitude.toStringAsFixed(0)} px/s',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            color: color.shade900,
          ),
        ),
      ],
    ),
  );
}

Widget _recipeBlock(String title, String code, Color accent) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, size: 14.0, color: accent),
            SizedBox(width: 6.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: accent,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          code,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.greenAccent.shade100,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _pitfallTile(
  String title,
  String body,
  IconData icon,
  MaterialColor color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.shade300, width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color.shade700, size: 22.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color.shade900,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.black87,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _compareColumn(
  String title,
  MaterialColor color,
  IconData icon,
  List<String> bullets,
) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.shade100, color.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.shade400, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color.shade800, size: 20.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color.shade900,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        for (final b in bullets)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.chevron_right,
                    size: 14.0, color: color.shade700),
                SizedBox(width: 4.0),
                Expanded(
                  child: Text(
                    b,
                    style:
                        TextStyle(fontSize: 11.0, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _timelineRow(int frame, DragUpdateDetails d, MaterialColor color) {
  // Normalise the cumulative x distance to 0..1 for the bar.
  final cumulative = d.globalPosition.dx;
  final fraction = (cumulative / 240.0).clamp(0.0, 1.0) as double;
  final anim = AlwaysStoppedAnimation<double>(fraction);
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      children: [
        Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: color.shade200,
            borderRadius: BorderRadius.circular(18.0),
            border: Border.all(color: color.shade500, width: 1.5),
          ),
          alignment: Alignment.center,
          child: Text(
            '$frame',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color.shade900,
              fontSize: 13.0,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Container(
            height: 14.0,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(7.0),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: anim.value,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color.shade400, color.shade700],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(7.0),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10.0),
        SizedBox(
          width: 130.0,
          child: Text(
            'delta=${d.delta}\nt=${d.sourceTimeStamp}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: color.shade900,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _progressRow(String axis, double pct, MaterialColor color) {
  final anim = AlwaysStoppedAnimation<double>(pct);
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      children: [
        SizedBox(
          width: 80.0,
          child: Text(
            axis,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: color.shade900,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Container(
            height: 18.0,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(9.0),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.25),
                  blurRadius: 6.0,
                  offset: Offset(0.0, 2.0),
                ),
              ],
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: anim.value,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color.shade300, color.shade700],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(9.0),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Text(
          '${(anim.value * 100).toStringAsFixed(0)}%',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: color.shade900,
          ),
        ),
      ],
    ),
  );
}

Widget _refRow(
  String method,
  String when,
  String cardinality,
  MaterialColor color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.shade300, width: 1.0),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 110.0,
          child: Text(
            method,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: color.shade900,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            when,
            style: TextStyle(fontSize: 11.0, color: Colors.black87),
          ),
        ),
        SizedBox(width: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: color.shade100,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            cardinality,
            style: TextStyle(
              fontSize: 10.0,
              color: color.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
