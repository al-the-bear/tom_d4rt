// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import, avoid_print
// D4rt test script: Deep visual demo of DragGestureRecognizer.
// Showcases the abstract base class shared by HorizontalDragGestureRecognizer,
// VerticalDragGestureRecognizer and PanGestureRecognizer in
// package:flutter/gestures.dart, including its callbacks, configuration and
// lifecycle.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // SECTION 0: Construct sample recognizers (no real input pumped)
  // ============================================================
  final vd = VerticalDragGestureRecognizer()
    ..dragStartBehavior = DragStartBehavior.down
    ..supportedDevices = <PointerDeviceKind>{
      PointerDeviceKind.touch,
      PointerDeviceKind.mouse,
    }
    ..onDown = (DragDownDetails d) {}
    ..onStart = (DragStartDetails d) {}
    ..onUpdate = (DragUpdateDetails d) {}
    ..onEnd = (DragEndDetails d) {}
    ..onCancel = () {};
  final hd = HorizontalDragGestureRecognizer()
    ..dragStartBehavior = DragStartBehavior.start
    ..onUpdate = (DragUpdateDetails d) {};
  final pan = PanGestureRecognizer()
    ..multitouchDragStrategy = MultitouchDragStrategy.latestPointer
    ..onStart = (DragStartDetails d) {};

  final String vdLabel = vd.runtimeType.toString();
  final String hdLabel = hd.runtimeType.toString();
  final String panLabel = pan.runtimeType.toString();

  vd.dispose();
  hd.dispose();
  pan.dispose();

  // ============================================================
  // SECTION 1: Hero header
  // ============================================================
  final Widget heroHeader = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade700, Colors.purple.shade500, Colors.pink.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.4),
          blurRadius: 18.0,
          spreadRadius: 2.0,
          offset: Offset(0.0, 8.0),
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
                gradient: LinearGradient(
                  colors: [Colors.white24, Colors.white10],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.25),
                    blurRadius: 12.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: Icon(Icons.pan_tool_alt, size: 56.0, color: Colors.white),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DragGestureRecognizer',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/gestures.dart',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Abstract base class powering Horizontal-, Vertical- and PanGestureRecognizer.',
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _heroChip('onDown', Icons.touch_app),
            _heroChip('onStart', Icons.play_arrow),
            _heroChip('onUpdate', Icons.swipe),
            _heroChip('onEnd', Icons.flag),
            _heroChip('onCancel', Icons.cancel),
            _heroChip('dragStartBehavior', Icons.tune),
            _heroChip('supportedDevices', Icons.devices_other),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy of the drag arena
  // ============================================================
  final Widget anatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue.shade50, Colors.cyan.shade50],
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.architecture, color: Colors.blue.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Anatomy of a Drag Arena',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'A pointer enters the GestureArena. The recognizer accumulates motion '
          'and competes against siblings until it wins or yields.',
          style: TextStyle(fontSize: 13.0, color: Colors.blueGrey.shade800),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _anatomyNode('Pointer', Icons.touch_app, Colors.blue),
            _anatomyArrow(),
            _anatomyNode('Arena', Icons.gavel, Colors.indigo),
            _anatomyArrow(),
            _anatomyNode('Recognizer', Icons.gesture, Colors.purple),
            _anatomyArrow(),
            _anatomyNode('Callback', Icons.bolt, Colors.pink),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.blue.shade100.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'The recognizer holds onDown / onStart / onUpdate / onEnd / onCancel '
            'as nullable function fields. Assigning at least one keeps the '
            'recognizer alive in the arena.',
            style: TextStyle(fontSize: 12.0, color: Colors.blue.shade900),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Per-callback cards
  // ============================================================
  final List<Map<String, Object>> callbacks = [
    {
      'name': 'onDown',
      'type': 'GestureDragDownCallback?',
      'payload': 'DragDownDetails',
      'fields': 'globalPosition · localPosition',
      'fires': 'A pointer has contacted the screen and may begin dragging.',
      'icon': Icons.touch_app,
      'color': Colors.teal,
      'progress': 0.1,
    },
    {
      'name': 'onStart',
      'type': 'GestureDragStartCallback?',
      'payload': 'DragStartDetails',
      'fields': 'globalPosition · localPosition · sourceTimeStamp · kind',
      'fires': 'Drag is recognised — slop is exceeded or the recognizer wins the arena.',
      'icon': Icons.play_arrow,
      'color': Colors.green,
      'progress': 0.3,
    },
    {
      'name': 'onUpdate',
      'type': 'GestureDragUpdateCallback?',
      'payload': 'DragUpdateDetails',
      'fields': 'delta · primaryDelta · globalPosition · localPosition',
      'fires': 'Pointer moved while the drag is active; called many times per second.',
      'icon': Icons.swipe,
      'color': Colors.orange,
      'progress': 0.6,
    },
    {
      'name': 'onEnd',
      'type': 'GestureDragEndCallback?',
      'payload': 'DragEndDetails',
      'fields': 'velocity · primaryVelocity · globalPosition',
      'fires': 'Pointer is lifted; carries fling velocity for momentum animations.',
      'icon': Icons.flag,
      'color': Colors.deepPurple,
      'progress': 0.95,
    },
    {
      'name': 'onCancel',
      'type': 'GestureDragCancelCallback?',
      'payload': '() => void',
      'fields': 'no payload',
      'fires': 'The pointer is cancelled, or the recognizer lost the arena after onDown.',
      'icon': Icons.cancel,
      'color': Colors.red,
      'progress': 0.0,
    },
  ];

  final List<Widget> callbackCards = [
    for (final cb in callbacks) _callbackCard(cb),
  ];

  // ============================================================
  // SECTION 4: Subclass comparison
  // ============================================================
  final Widget subclassComparison = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade50, Colors.indigo.shade50, Colors.blue.shade50],
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows, color: Colors.deepPurple, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Concrete Subclasses',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _subclassCard(
                title: hdLabel,
                axisIcon: Icons.swap_horiz,
                axisLabel: 'Horizontal axis',
                color: Colors.blue,
                primaryDelta: 'dx',
                useCases: const [
                  'Swipe to dismiss list tiles',
                  'Slide-over drawers (left ↔ right)',
                  'Carousel page transitions',
                ],
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _subclassCard(
                title: vdLabel,
                axisIcon: Icons.swap_vert,
                axisLabel: 'Vertical axis',
                color: Colors.green,
                primaryDelta: 'dy',
                useCases: const [
                  'Pull-to-refresh',
                  'Bottom sheet drag handle',
                  'Scrollable.drag',
                ],
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _subclassCard(
                title: panLabel,
                axisIcon: Icons.open_with,
                axisLabel: 'Both axes',
                color: Colors.purple,
                primaryDelta: 'null (use delta)',
                useCases: const [
                  'Free-form drawing',
                  'Map panning',
                  'Drag-and-drop in 2D',
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade100.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Horizontal and Vertical recognizers populate primaryDelta / primaryVelocity. '
            'PanGestureRecognizer reports null primary fields and exposes the full delta vector.',
            style: TextStyle(fontSize: 12.0, color: Colors.deepPurple.shade900),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: dragStartBehavior + supportedDevices configuration
  // ============================================================
  final Widget configurationCards = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.orange.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.18),
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
            Icon(Icons.settings, color: Colors.orange.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Configuration knobs',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _configBlock(
                title: 'dragStartBehavior',
                color: Colors.orange,
                rows: const [
                  ['DragStartBehavior.down', 'onStart fires at the down event position.'],
                  ['DragStartBehavior.start', 'onStart fires at the position drag was recognised (default).'],
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _configBlock(
                title: 'supportedDevices',
                color: Colors.deepOrange,
                rows: const [
                  ['null', 'Recognise from any pointer device.'],
                  ['{touch}', 'Touchscreen only.'],
                  ['{mouse, stylus}', 'Desktop + pen input.'],
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _configBlock(
                title: 'multitouchDragStrategy',
                color: Colors.amber,
                rows: const [
                  ['latestPointer', 'Track most recent finger (default).'],
                  ['averageBoundaryPointers', 'Use the average of the boundary pointers.'],
                  ['sumAllPointers', 'Sum every active pointer.'],
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _configBlock(
                title: 'fling thresholds',
                color: Colors.brown,
                rows: const [
                  ['minFlingDistance', 'Pixels needed to be a fling.'],
                  ['minFlingVelocity', 'Lower bound (px/s) for fling.'],
                  ['maxFlingVelocity', 'Velocity is clamped to this.'],
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Recipes
  // ============================================================
  final Widget recipes = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.green.shade50, Colors.lightGreen.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.green.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.18),
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
            Icon(Icons.restaurant_menu, color: Colors.green.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Recipes',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _recipeBlock(
          icon: Icons.unfold_more,
          color: Colors.green,
          title: 'Bottom sheet drag handle',
          recognizer: 'VerticalDragGestureRecognizer',
          code:
              'final v = VerticalDragGestureRecognizer()\n'
              '  ..onStart = (d) => controller.value = sheetExtent\n'
              '  ..onUpdate = (d) {\n'
              '    controller.value -= d.primaryDelta! / maxHeight;\n'
              '  }\n'
              '  ..onEnd = (d) => _settle(d.primaryVelocity);',
        ),
        SizedBox(height: 12.0),
        _recipeBlock(
          icon: Icons.swipe,
          color: Colors.blue,
          title: 'Swipe-to-dismiss',
          recognizer: 'HorizontalDragGestureRecognizer',
          code:
              'final h = HorizontalDragGestureRecognizer()\n'
              '  ..dragStartBehavior = DragStartBehavior.down\n'
              '  ..onUpdate = (d) {\n'
              '    offset += d.primaryDelta!;\n'
              '  }\n'
              '  ..onEnd = (d) {\n'
              '    if (d.primaryVelocity!.abs() > 800) dismiss();\n'
              '  };',
        ),
        SizedBox(height: 12.0),
        _recipeBlock(
          icon: Icons.gesture,
          color: Colors.purple,
          title: 'Two-axis drawing surface',
          recognizer: 'PanGestureRecognizer',
          code:
              'final p = PanGestureRecognizer()\n'
              '  ..onStart = (d) => path.moveTo(d.localPosition.dx, d.localPosition.dy)\n'
              '  ..onUpdate = (d) {\n'
              '    path.relativeLineTo(d.delta.dx, d.delta.dy);\n'
              '    setState(() {});\n'
              '  }\n'
              '  ..onEnd = (_) => commitStroke();',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Pitfalls
  // ============================================================
  final Widget pitfalls = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.15),
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
            Icon(Icons.report_problem, color: Colors.red.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls & gotchas',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _pitfall(
          'Dispose every recognizer.',
          'If you build a recognizer in a State, call dispose() in State.dispose() — they hold timers and pointer subscriptions.',
        ),
        _pitfall(
          'onUpdate alone is not enough.',
          'You typically need onStart to capture the initial position; without it, the first delta is reported relative to whatever the previous gesture left behind.',
        ),
        _pitfall(
          'primaryDelta is null on Pan.',
          'PanGestureRecognizer always sets primaryDelta and primaryVelocity to null. Read delta and velocity instead.',
        ),
        _pitfall(
          'Arena conflicts with scrollables.',
          'Vertical drag inside a vertical Scrollable will lose the arena. Wrap in RawGestureDetector with custom GestureRecognizerFactory to win.',
        ),
        _pitfall(
          'DragStartBehavior.down breaks slop.',
          'Setting dragStartBehavior to down makes onStart fire before slop is exceeded; that can make taps feel like drags.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Lifecycle diagram
  // ============================================================
  final Widget lifecycle = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade50, Colors.lightBlue.shade100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.cyan.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.2),
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
            Icon(Icons.timeline, color: Colors.cyan.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Drag lifecycle',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            _lifeNode('addPointer', Icons.add_circle_outline, Colors.cyan, 0.0),
            _lifeBar(0.0),
            _lifeNode('onDown', Icons.touch_app, Colors.teal, 0.1),
            _lifeBar(0.1),
            _lifeNode('onStart', Icons.play_arrow, Colors.green, 0.3),
            _lifeBar(0.3),
            _lifeNode('onUpdate*', Icons.swipe, Colors.orange, 0.6),
            _lifeBar(0.6),
            _lifeNode('onEnd', Icons.flag, Colors.deepPurple, 0.95),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          height: 14.0,
          decoration: BoxDecoration(
            color: Colors.cyan.shade100,
            borderRadius: BorderRadius.circular(7.0),
          ),
          child: Row(
            children: [
              _lifeSegment(0.10, Colors.teal, 'down'),
              _lifeSegment(0.20, Colors.green, 'start'),
              _lifeSegment(0.55, Colors.orange, 'update*'),
              _lifeSegment(0.15, Colors.deepPurple, 'end'),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.cyan.shade100.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'If the recognizer loses the arena before onStart, onCancel is invoked instead of onEnd. '
            'onUpdate may fire many times between onStart and onEnd.',
            style: TextStyle(fontSize: 12.0, color: Colors.cyan.shade900),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Quick reference table
  // ============================================================
  final Widget quickReference = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade100, Colors.blueGrey.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blueGrey.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.withValues(alpha: 0.15),
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
            Icon(Icons.menu_book, color: Colors.blueGrey.shade800, size: 22.0),
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
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              _refHeader('Member', 180.0),
              _refHeader('Type', 170.0),
              _refHeader('Notes', 220.0),
            ],
          ),
        ),
        _refRow('onDown', 'GestureDragDownCallback?', 'Pointer contact, gesture not yet decided.'),
        _refRow('onStart', 'GestureDragStartCallback?', 'Drag accepted; carries first position.'),
        _refRow('onUpdate', 'GestureDragUpdateCallback?', 'Movement frame; called many times.'),
        _refRow('onEnd', 'GestureDragEndCallback?', 'Pointer up; carries velocity.'),
        _refRow('onCancel', 'GestureDragCancelCallback?', 'Cancel after onDown.'),
        _refRow('dragStartBehavior', 'DragStartBehavior', 'When onStart fires (down/start).'),
        _refRow('supportedDevices', 'Set<PointerDeviceKind>?', 'Filter pointer devices.'),
        _refRow('multitouchDragStrategy', 'MultitouchDragStrategy', 'How multiple fingers combine.'),
        _refRow('minFlingDistance', 'double?', 'Min pixels to count as fling.'),
        _refRow('minFlingVelocity', 'double?', 'Min velocity (px/s) for fling.'),
        _refRow('maxFlingVelocity', 'double?', 'Velocity ceiling.'),
        _refRow('velocityTrackerBuilder', 'GestureVelocityTrackerBuilder', 'Plug a custom tracker.'),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: ASCII footer
  // ============================================================
  final Widget asciiFooter = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.black87, Colors.grey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
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
            Icon(Icons.terminal, color: Colors.greenAccent, size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'drag.ascii',
              style: TextStyle(
                fontFamily: 'monospace',
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          '  +-----------+      +-----------+      +-----------+\n'
          '  |  POINTER  | ---> |   ARENA   | ---> | RECOGNIZER|\n'
          '  +-----------+      +-----------+      +-----------+\n'
          '                                              |\n'
          '         onDown -- onStart -- onUpdate* -- onEnd / onCancel\n'
          '\n'
          '  Horizontal : ---> dx  primaryDelta = dx  primaryVelocity = vx\n'
          '  Vertical   :  |   dy  primaryDelta = dy  primaryVelocity = vy\n'
          '                v\n'
          '  Pan        : <-/->  delta = (dx, dy)  velocity = (vx, vy)\n',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: Colors.greenAccent,
            height: 1.4,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // Compose the final layout
  // ============================================================
  final Widget body = SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        heroHeader,
        SizedBox(height: 24.0),
        Text(
          '1. Anatomy',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        anatomy,
        SizedBox(height: 24.0),
        Text(
          '2. Callbacks',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        ...callbackCards,
        SizedBox(height: 24.0),
        Text(
          '3. Subclasses',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        subclassComparison,
        SizedBox(height: 24.0),
        Text(
          '4. Configuration',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        configurationCards,
        SizedBox(height: 24.0),
        Text(
          '5. Recipes',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        recipes,
        SizedBox(height: 24.0),
        Text(
          '6. Pitfalls',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        pitfalls,
        SizedBox(height: 24.0),
        Text(
          '7. Lifecycle',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        lifecycle,
        SizedBox(height: 24.0),
        Text(
          '8. Quick reference',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        quickReference,
        SizedBox(height: 24.0),
        Text(
          '9. ASCII footer',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        asciiFooter,
      ],
    ),
  );

  return MaterialApp(home: Scaffold(body: body));
}

// ============================================================
// Helpers
// ============================================================

Widget _heroChip(String label, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white.withValues(alpha: 0.25), Colors.white.withValues(alpha: 0.1)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.white.withValues(alpha: 0.6), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.white.withValues(alpha: 0.15),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 14.0),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'monospace',
            fontSize: 12.0,
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyNode(String label, IconData icon, MaterialColor color) {
  return Container(
    width: 78.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.2),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(icon, color: color.shade700, size: 24.0),
        SizedBox(height: 4.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color.shade900,
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyArrow() {
  return Icon(Icons.arrow_forward, color: Colors.blueGrey.shade400, size: 18.0);
}

Widget _callbackCard(Map<String, Object> cb) {
  final String name = cb['name'] as String;
  final String type = cb['type'] as String;
  final String payload = cb['payload'] as String;
  final String fields = cb['fields'] as String;
  final String fires = cb['fires'] as String;
  final IconData icon = cb['icon'] as IconData;
  final MaterialColor color = cb['color'] as MaterialColor;
  final double progress = cb['progress'] as double;

  // Static motion only — capture the same value via a stopped animation.
  final Animation<double> stopped = AlwaysStoppedAnimation<double>(progress);
  final Duration zero = Duration.zero;

  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.shade50, color.shade100.withValues(alpha: 0.5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.2),
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
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color.shade200,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.3),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: Icon(icon, color: color.shade900, size: 22.0),
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
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: color.shade900,
                    ),
                  ),
                  Text(
                    type,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      color: color.shade700,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: color.shade700,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                't = ${stopped.value.toStringAsFixed(2)}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: color.shade200, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.bolt, color: color.shade700, size: 14.0),
                  SizedBox(width: 6.0),
                  Text(
                    'Fires when',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: color.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                fires,
                style: TextStyle(fontSize: 12.0, color: Colors.black87),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(Icons.inbox, color: color.shade700, size: 14.0),
                  SizedBox(width: 6.0),
                  Text(
                    'Payload',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: color.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: color.shade50,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  '$payload  ·  $fields',
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
        SizedBox(height: 10.0),
        // Progress bar showing approximate position in the lifecycle.
        ClipRRect(
          borderRadius: BorderRadius.circular(6.0),
          child: Container(
            height: 8.0,
            color: color.shade100,
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: stopped.value.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color.shade400, color.shade700],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'lifecycle position · throttled at ${zero.inMilliseconds}ms',
          style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700),
        ),
      ],
    ),
  );
}

Widget _subclassCard({
  required String title,
  required IconData axisIcon,
  required String axisLabel,
  required MaterialColor color,
  required String primaryDelta,
  required List<String> useCases,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.2),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(axisIcon, color: color.shade800, size: 22.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                axisLabel,
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: color.shade900,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color.shade900,
          ),
        ),
        SizedBox(height: 6.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: color.shade100,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            'primary: $primaryDelta',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: color.shade900,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        for (final uc in useCases)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check, color: color.shade700, size: 12.0),
                SizedBox(width: 4.0),
                Expanded(
                  child: Text(
                    uc,
                    style: TextStyle(fontSize: 10.0, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _configBlock({
  required String title,
  required MaterialColor color,
  required List<List<String>> rows,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.shade300, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: color.shade900,
          ),
        ),
        SizedBox(height: 6.0),
        for (final row in rows)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: color.shade100,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    row[0],
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.0,
                      color: color.shade900,
                    ),
                  ),
                ),
                SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    row[1],
                    style: TextStyle(fontSize: 11.0, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _recipeBlock({
  required IconData icon,
  required MaterialColor color,
  required String title,
  required String recognizer,
  required String code,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.shade300, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color.shade700, size: 18.0),
            SizedBox(width: 6.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: color.shade900,
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: color.shade100,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                recognizer,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: color.shade900,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.greenAccent.shade100,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _pitfall(String title, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.warning_amber, color: Colors.red.shade700, size: 18.0),
        SizedBox(width: 8.0),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 12.0, color: Colors.black87),
              children: [
                TextSpan(
                  text: '$title  ',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red.shade900),
                ),
                TextSpan(text: description),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _lifeNode(String label, IconData icon, MaterialColor color, double t) {
  final Animation<double> stopped = AlwaysStoppedAnimation<double>(t);
  return Container(
    width: 60.0,
    padding: EdgeInsets.all(6.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color, width: 1.0),
    ),
    child: Column(
      children: [
        Icon(icon, color: color.shade700, size: 20.0),
        SizedBox(height: 2.0),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 9.0,
            fontWeight: FontWeight.bold,
            color: color.shade900,
          ),
        ),
        Text(
          't=${stopped.value.toStringAsFixed(2)}',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 8.0,
            color: color.shade700,
          ),
        ),
      ],
    ),
  );
}

Widget _lifeBar(double t) {
  return Expanded(
    child: Container(
      height: 4.0,
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      decoration: BoxDecoration(
        color: Colors.cyan.shade300,
        borderRadius: BorderRadius.circular(2.0),
      ),
    ),
  );
}

Widget _lifeSegment(double flex, MaterialColor color, String label) {
  final int flexInt = (flex * 100).round();
  return Expanded(
    flex: flexInt,
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.shade300, color.shade600],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 9.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}

Widget _refHeader(String label, double width) {
  return SizedBox(
    width: width,
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey.shade900,
      ),
    ),
  );
}

Widget _refRow(String member, String type, String notes) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.blueGrey.shade100, width: 1.0),
      ),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 180.0,
          child: Text(
            member,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900,
            ),
          ),
        ),
        SizedBox(
          width: 170.0,
          child: Text(
            type,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.purple.shade800,
            ),
          ),
        ),
        SizedBox(
          width: 220.0,
          child: Text(
            notes,
            style: TextStyle(fontSize: 11.0, color: Colors.black87),
          ),
        ),
      ],
    ),
  );
}
