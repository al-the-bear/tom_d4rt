// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable
// D4rt test script: Tests GestureRecognizer (abstract base) from
// package:flutter/gestures.dart.
// Deep Demo: Visual exploration of the gesture-recognition hierarchy, the
// pointer lifecycle, the gesture arena, and the contract that every concrete
// recognizer must honor (addPointer -> handleEvent -> resolve -> dispose).
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('GestureRecognizer Deep Demo executing');

  // ============================================================
  // SECTION 1: Hero Header
  // ============================================================
  // The header doubles as a quick-reference card. GestureRecognizer is the
  // abstract root from which every Flutter pointer-aware recognizer descends.
  // It owns three core responsibilities: (a) accepting pointers via
  // addPointer, (b) tracking the resulting events with handleEvent, and
  // (c) competing for ownership in the gesture arena via resolve.
  print('=== Section 1: Hero Header ===');

  final hero = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF1A237E),
          Color(0xFF311B92),
          Color(0xFF4A148C),
        ],
        stops: [0.0, 0.55, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF1A237E).withValues(alpha: 0.45),
          blurRadius: 24.0,
          spreadRadius: 2.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.18),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 88.0,
          height: 88.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Colors.deepPurpleAccent, Colors.indigoAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.indigoAccent.withValues(alpha: 0.5),
                blurRadius: 18.0,
                offset: Offset(0.0, 6.0),
              ),
            ],
          ),
          child: Icon(Icons.touch_app, size: 52.0, color: Colors.white),
        ),
        SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GestureRecognizer',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'abstract · package:flutter/gestures.dart',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.white70,
                  fontFamily: 'monospace',
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Root of the gesture-recognition hierarchy. Owns the '
                'pointer lifecycle, competes in the gesture arena, '
                'and emits high-level callbacks (onTap, onLongPress, …) '
                'to the widget tree.',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.white.withValues(alpha: 0.92),
                  height: 1.35,
                ),
              ),
              SizedBox(height: 12.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 6.0,
                children: [
                  _buildHeroChip('addPointer', Colors.tealAccent),
                  _buildHeroChip('handleEvent', Colors.amberAccent),
                  _buildHeroChip('resolve', Colors.pinkAccent),
                  _buildHeroChip('dispose', Colors.redAccent),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Hero header constructed');

  // ============================================================
  // SECTION 2: Anatomy Diagram (Abstract API Surface)
  // ============================================================
  // GestureRecognizer's API surface is small but decisive. Each row in this
  // diagram corresponds to a member every concrete recognizer interacts with.
  // We instantiate two concrete recognizers (TapGestureRecognizer and
  // LongPressGestureRecognizer) only to demonstrate that the contract is
  // honored — no event simulation happens here.
  print('=== Section 2: Anatomy Diagram ===');

  final tapProbe = TapGestureRecognizer(debugOwner: 'AnatomyProbe.tap');
  print('tap.debugOwner: ${tapProbe.debugOwner}');
  print('tap.debugDescription: ${tapProbe.debugDescription}');
  print('tap.toString: ${tapProbe.toString()}');
  tapProbe.dispose();

  final lpProbe = LongPressGestureRecognizer(
    debugOwner: 'AnatomyProbe.longPress',
  );
  print('longPress.debugOwner: ${lpProbe.debugOwner}');
  print('longPress.debugDescription: ${lpProbe.debugDescription}');
  lpProbe.dispose();

  final anatomyRows = <Widget>[
    _buildAnatomyRow(
      'addPointer(PointerDownEvent)',
      'Entry point. The hit-test routes a pointer-down to every recognizer '
          'that opted in; each one decides whether to track the pointer.',
      Icons.input,
      Colors.teal,
    ),
    _buildAnatomyRow(
      'handleEvent(PointerEvent)',
      'Per-event hook. Called for every move/up/cancel of a tracked pointer '
          'so the recognizer can update its internal state machine.',
      Icons.bolt,
      Colors.amber.shade800,
    ),
    _buildAnatomyRow(
      'acceptGesture(int pointer)',
      'The arena has declared this recognizer the winner. Time to fire '
          'public callbacks like onTap, onLongPress, onScaleStart.',
      Icons.check_circle,
      Colors.green.shade700,
    ),
    _buildAnatomyRow(
      'rejectGesture(int pointer)',
      'The arena has declared this recognizer the loser. Reset state, drop '
          'the pointer, and stay silent.',
      Icons.cancel,
      Colors.red.shade700,
    ),
    _buildAnatomyRow(
      'resolve(GestureDisposition)',
      'Voluntarily cast a vote — accepted, rejected, or kept open — once '
          'the recognizer is sure (or sure-enough) about the gesture.',
      Icons.how_to_vote,
      Colors.pink.shade700,
    ),
    _buildAnatomyRow(
      'dispose()',
      'Release any subscriptions to the pointer router. Always call this '
          'from State.dispose to avoid leaks — recognizers hold listeners.',
      Icons.delete_sweep,
      Colors.deepOrange,
    ),
    _buildAnatomyRow(
      'debugOwner / debugDescription',
      'Diagnostics that help developers attribute a recognizer back to its '
          'owning widget when reading dump trees or arena traces.',
      Icons.bug_report,
      Colors.indigo,
    ),
  ];

  final anatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade50, Colors.blueGrey.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blueGrey.shade300, width: 1.5),
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
            Icon(Icons.account_tree, color: Colors.blueGrey.shade800),
            SizedBox(width: 8.0),
            Text(
              'Anatomy of GestureRecognizer',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'Every concrete recognizer below implements (or overrides) the '
          'members shown here. Read top-to-bottom for the typical execution '
          'order during a single gesture.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.blueGrey.shade700,
            height: 1.35,
          ),
        ),
        SizedBox(height: 14.0),
        ...anatomyRows,
      ],
    ),
  );
  print('Anatomy diagram constructed');

  // ============================================================
  // SECTION 3: Class-tree Visualization
  // ============================================================
  // The hierarchy: GestureRecognizer is abstract. OneSequenceGestureRecognizer
  // extends it for recognizers that watch one continuous pointer sequence.
  // PrimaryPointerGestureRecognizer narrows that further to a single primary
  // pointer. Concrete leaves include TapGestureRecognizer,
  // LongPressGestureRecognizer, the various Drag recognizers and Scale.
  print('=== Section 3: Class-tree Visualization ===');

  final classTree = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.purple.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.12),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'Recognizer Class Hierarchy',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        _buildTreeNode('GestureRecognizer', 'abstract',
            Colors.indigo.shade700, 0),
        _buildTreeConnector(0),
        _buildTreeNode('OneSequenceGestureRecognizer', 'abstract',
            Colors.indigo.shade500, 1),
        _buildTreeConnector(1),
        _buildTreeNode('PrimaryPointerGestureRecognizer', 'abstract',
            Colors.purple.shade400, 2),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          alignment: WrapAlignment.center,
          children: [
            _buildLeafNode('TapGestureRecognizer', Icons.touch_app,
                Colors.teal),
            _buildLeafNode('DoubleTapGestureRecognizer',
                Icons.double_arrow, Colors.cyan),
            _buildLeafNode('LongPressGestureRecognizer',
                Icons.timer, Colors.amber.shade800),
            _buildLeafNode('VerticalDragGestureRecognizer',
                Icons.swap_vert, Colors.green),
            _buildLeafNode('HorizontalDragGestureRecognizer',
                Icons.swap_horiz, Colors.blue),
            _buildLeafNode('PanGestureRecognizer',
                Icons.pan_tool_alt, Colors.deepPurple),
            _buildLeafNode('ScaleGestureRecognizer',
                Icons.zoom_out_map, Colors.pink),
            _buildLeafNode('ForcePressGestureRecognizer',
                Icons.compress, Colors.red),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Note: ScaleGestureRecognizer extends OneSequenceGestureRecognizer '
            'directly; it does not need the single-primary-pointer constraint '
            'because it inherently tracks multiple pointers.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.indigo.shade900,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
  print('Class tree constructed');

  // ============================================================
  // SECTION 4: Lifecycle Timeline
  // ============================================================
  // From hit-test to disposal, a recognizer goes through a well-defined
  // sequence of phases. We render these as a vertical timeline so readers can
  // map mental models from input events to recognizer states.
  print('=== Section 4: Lifecycle Timeline ===');

  final lifecycleSteps = <_LifecycleStep>[
    _LifecycleStep(
      'Construction',
      'final tap = TapGestureRecognizer(debugOwner: this);',
      'Recognizer is allocated with deadlines, kinds and owner metadata. '
          'No pointers are tracked yet.',
      Icons.add_circle,
      Colors.green,
    ),
    _LifecycleStep(
      'Hit-test routes pointer down',
      'tap.addPointer(pointerDownEvent);',
      'GestureDetector forwards a PointerDownEvent that intersected its '
          'render box. The recognizer decides whether to track it.',
      Icons.adjust,
      Colors.teal,
    ),
    _LifecycleStep(
      'Pointer router subscribes',
      'GestureBinding.instance.pointerRouter.addRoute(pointer, handleEvent);',
      'Every subsequent move/up/cancel for this pointer flows into '
          'handleEvent until the recognizer drops it.',
      Icons.alt_route,
      Colors.cyan,
    ),
    _LifecycleStep(
      'State machine ticks',
      'handleEvent(PointerMoveEvent / PointerUpEvent / PointerCancelEvent);',
      'Internal state (kPossible -> kHeld -> kReady …) is updated. '
          'Recognizer may call resolve() the moment it is confident.',
      Icons.bolt,
      Colors.amber.shade800,
    ),
    _LifecycleStep(
      'Arena vote cast',
      'resolve(GestureDisposition.accepted);',
      'The recognizer claims (or rejects) the pointer. The arena tallies '
          'votes from every recognizer competing for that pointer.',
      Icons.how_to_vote,
      Colors.pink,
    ),
    _LifecycleStep(
      'acceptGesture / rejectGesture',
      'acceptGesture(pointer); → onTap?.call();',
      'When the arena resolves, it calls one of the two methods on every '
          'participant. Public callbacks fire only on accept.',
      Icons.gavel,
      Colors.deepPurple,
    ),
    _LifecycleStep(
      'Disposal',
      'tap.dispose();',
      'Recognizer unsubscribes from the pointer router and releases held '
          'pointers. Failing to call dispose leaks listeners.',
      Icons.delete_sweep,
      Colors.red,
    ),
  ];

  final lifecycle = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepOrange.shade50, Colors.amber.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepOrange.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.15),
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
            Icon(Icons.timeline, color: Colors.deepOrange.shade800),
            SizedBox(width: 8.0),
            Text(
              'Pointer Lifecycle',
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
          'A single pointer-down event triggers the entire chain. Each step '
          'is observable through diagnostics flags (debugPrintGestureArena, '
          'debugPrintHitTestResults, …).',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.deepOrange.shade900,
            height: 1.3,
          ),
        ),
        SizedBox(height: 14.0),
        for (var i = 0; i < lifecycleSteps.length; i++)
          _buildTimelineRow(lifecycleSteps[i], i, lifecycleSteps.length),
      ],
    ),
  );
  print('Lifecycle timeline constructed');

  // ============================================================
  // SECTION 5: Gesture-arena Diagram
  // ============================================================
  // The gesture arena is a small voting machine, one per pointer. Recognizers
  // vote accepted, rejected, or stay undecided; the arena either resolves on
  // a clear winner or sweeps when the last pointer-up arrives.
  print('=== Section 5: Gesture Arena ===');

  final arena = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.blueGrey.shade900,
          Colors.indigo.shade900,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.shade900.withValues(alpha: 0.4),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.stadium, color: Colors.amberAccent),
            SizedBox(width: 8.0),
            Text(
              'The Gesture Arena',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.amberAccent,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'Pointer 0x1 — three recognizers competing',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.white70,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 16.0),
        SizedBox(
          height: 240.0,
          child: CustomPaint(
            painter: _ArenaPainter(),
            child: Container(),
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          alignment: WrapAlignment.center,
          children: [
            _buildArenaLegend('accepted', Colors.greenAccent),
            _buildArenaLegend('rejected', Colors.redAccent),
            _buildArenaLegend('undecided', Colors.amberAccent),
            _buildArenaLegend('sweep', Colors.cyanAccent),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'When a recognizer votes accepted and is the only remaining '
            'contender (or wins by priority), the arena resolves. All other '
            'recognizers receive rejectGesture and silently bow out.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.white.withValues(alpha: 0.85),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
  print('Arena diagram constructed');

  // ============================================================
  // SECTION 6: Subclass Cards
  // ============================================================
  // Each card showcases a concrete subclass with a representative callback,
  // its primary use case, and the disposition it usually claims with.
  print('=== Section 6: Subclass Cards ===');

  final subclassCards = <Widget>[
    _buildSubclassCard(
      title: 'TapGestureRecognizer',
      tagline: 'single primary pointer · short duration',
      description: 'Detects a quick tap. Wins the arena on PointerUpEvent '
          'when no other recognizer has a stronger claim.',
      callbacks: ['onTapDown', 'onTap', 'onTapCancel'],
      icon: Icons.touch_app,
      gradient: [Colors.teal.shade400, Colors.teal.shade700],
    ),
    _buildSubclassCard(
      title: 'DoubleTapGestureRecognizer',
      tagline: 'two taps within kDoubleTapTimeout',
      description: 'Tracks two consecutive taps. Will reject other tap '
          'recognizers in the same arena to claim the second tap.',
      callbacks: ['onDoubleTapDown', 'onDoubleTap', 'onDoubleTapCancel'],
      icon: Icons.double_arrow,
      gradient: [Colors.cyan.shade400, Colors.cyan.shade700],
    ),
    _buildSubclassCard(
      title: 'LongPressGestureRecognizer',
      tagline: 'pointer held > kLongPressTimeout',
      description: 'Fires after a configurable hold delay. Often paired '
          'with feedback haptics through GestureBinding.',
      callbacks: ['onLongPressStart', 'onLongPress', 'onLongPressEnd'],
      icon: Icons.timer,
      gradient: [Colors.amber.shade600, Colors.orange.shade800],
    ),
    _buildSubclassCard(
      title: 'PanGestureRecognizer',
      tagline: 'arbitrary 2-D drag',
      description: 'Tracks unconstrained drag gestures. Useful for canvases, '
          'reorderable lists, and free-form drawing.',
      callbacks: ['onPanStart', 'onPanUpdate', 'onPanEnd'],
      icon: Icons.pan_tool_alt,
      gradient: [Colors.deepPurple.shade400, Colors.deepPurple.shade800],
    ),
    _buildSubclassCard(
      title: 'HorizontalDragGestureRecognizer',
      tagline: 'horizontal-axis drag',
      description: 'Resolves accepted only after movement crosses the '
          'horizontal slop threshold; rejects on vertical-dominant motion.',
      callbacks: ['onStart', 'onUpdate', 'onEnd'],
      icon: Icons.swap_horiz,
      gradient: [Colors.blue.shade400, Colors.blue.shade800],
    ),
    _buildSubclassCard(
      title: 'VerticalDragGestureRecognizer',
      tagline: 'vertical-axis drag',
      description: 'Mirror of the horizontal drag recognizer. Powers '
          'Scrollable, BottomSheet, RefreshIndicator and similar widgets.',
      callbacks: ['onStart', 'onUpdate', 'onEnd'],
      icon: Icons.swap_vert,
      gradient: [Colors.green.shade500, Colors.green.shade800],
    ),
    _buildSubclassCard(
      title: 'ScaleGestureRecognizer',
      tagline: 'two or more pointers · pinch / zoom',
      description: 'Tracks scale, rotation, and focal-point translation. '
          'Extends OneSequenceGestureRecognizer directly.',
      callbacks: ['onScaleStart', 'onScaleUpdate', 'onScaleEnd'],
      icon: Icons.zoom_out_map,
      gradient: [Colors.pink.shade400, Colors.pink.shade800],
    ),
    _buildSubclassCard(
      title: 'ForcePressGestureRecognizer',
      tagline: '3-D Touch / pressure-sensitive',
      description: 'Fires when pointer pressure crosses startPressure and '
          'peakPressure thresholds. iOS / Apple Pencil oriented.',
      callbacks: ['onStart', 'onPeak', 'onUpdate', 'onEnd'],
      icon: Icons.compress,
      gradient: [Colors.red.shade400, Colors.red.shade800],
    ),
  ];
  print('Built ${subclassCards.length} subclass cards');

  // ============================================================
  // SECTION 7: Recipes
  // ============================================================
  // Pragmatic snippets users will actually copy out of the demo.
  print('=== Section 7: Recipes ===');

  final recipes = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
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
            Icon(Icons.restaurant_menu, color: Colors.cyanAccent),
            SizedBox(width: 8.0),
            Text(
              'Recognizer Recipes',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildRecipeCard(
          'Recipe 1 · Tap with custom debugOwner',
          'final tap = TapGestureRecognizer(debugOwner: this)\n'
              '  ..onTap = () => setState(() => _count++);\n\n'
              '@override\n'
              'void dispose() {\n'
              '  tap.dispose();\n'
              '  super.dispose();\n'
              '}',
          Colors.tealAccent,
        ),
        SizedBox(height: 12.0),
        _buildRecipeCard(
          'Recipe 2 · Long-press feedback with duration',
          'final lp = LongPressGestureRecognizer(\n'
              '  duration: Duration(milliseconds: 600),\n'
              '  debugOwner: this,\n'
              ')\n'
              '  ..onLongPress = _showContextMenu\n'
              '  ..onLongPressEnd = _hideMenu;',
          Colors.amberAccent,
        ),
        SizedBox(height: 12.0),
        _buildRecipeCard(
          'Recipe 3 · Drag that wins via slop tolerance',
          'final pan = PanGestureRecognizer()\n'
              '  ..onStart = (d) => _start(d.localPosition)\n'
              '  ..onUpdate = (d) => _move(d.delta)\n'
              '  ..onEnd = (_) => _commit();',
          Colors.lightGreenAccent,
        ),
        SizedBox(height: 12.0),
        _buildRecipeCard(
          'Recipe 4 · RawGestureDetector composition',
          'RawGestureDetector(\n'
              '  gestures: <Type, GestureRecognizerFactory>{\n'
              '    TapGestureRecognizer: GestureRecognizerFactoryWithHandlers<\n'
              '      TapGestureRecognizer\n'
              '    >(\n'
              '      () => TapGestureRecognizer(),\n'
              '      (TapGestureRecognizer r) => r.onTap = _onTap,\n'
              '    ),\n'
              '  },\n'
              '  child: child,\n'
              ');',
          Colors.lightBlueAccent,
        ),
      ],
    ),
  );
  print('Recipes constructed');

  // ============================================================
  // SECTION 8: Pitfalls
  // ============================================================
  // Where developers most often shoot themselves in the foot.
  print('=== Section 8: Pitfalls ===');

  final pitfalls = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.18),
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
            Icon(Icons.warning_amber, color: Colors.red.shade700),
            SizedBox(width: 8.0),
            Text(
              'Common Pitfalls',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildPitfallRow(
          'Forgetting dispose()',
          'Recognizers retain pointer-router subscriptions. Always dispose '
              'them in State.dispose, otherwise leaked pointers leak callbacks.',
          Icons.delete_outline,
        ),
        _buildPitfallRow(
          'Two recognizers, one ambiguous gesture',
          'A Tap and a HorizontalDrag inside the same widget will compete. '
              'Ensure callbacks make sense on either resolution path.',
          Icons.compare_arrows,
        ),
        _buildPitfallRow(
          'Calling resolve from outside handleEvent',
          'resolve() is meant to be invoked while processing a pointer event. '
              'Calling it from a Timer is fine, but only after addPointer.',
          Icons.timer_off,
        ),
        _buildPitfallRow(
          'Mutating callbacks after disposal',
          'Once dispose() is called, setting onTap, onLongPress, etc. is a '
              'silent no-op and an indicator of leaked references.',
          Icons.block,
        ),
        _buildPitfallRow(
          'Skipping debugOwner',
          'In a complex tree, debugOwner is the only signal in arena traces '
              'that points back to the offending widget.',
          Icons.help_outline,
        ),
      ],
    ),
  );
  print('Pitfalls constructed');

  // ============================================================
  // SECTION 9: ASCII Footer
  // ============================================================
  // Plain-text reminder of the lifecycle that prints cleanly in any console.
  print('=== Section 9: ASCII Footer ===');

  const asciiArt = '''
                                              \n
   ┌─────────────────────────────────────────────┐
   │            GESTURE RECOGNIZER               │
   │   addPointer ─▶ handleEvent ─▶ resolve      │
   │        │              │            │        │
   │        ▼              ▼            ▼        │
   │   pointerRouter   stateMachine   arena      │
   │        └──────────────┬───────────┘         │
   │                       ▼                     │
   │              acceptGesture / rejectGesture  │
   │                       │                     │
   │                       ▼                     │
   │                   dispose()                 │
   └─────────────────────────────────────────────┘
''';

  final footer = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.black87, Colors.blueGrey.shade900],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          asciiArt,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: Colors.greenAccent,
            height: 1.3,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'GestureRecognizer · the contract every Flutter pointer abstraction '
          'eventually obeys.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
  print('Footer constructed');

  // ============================================================
  // Faux animation surface (no interaction, satisfies AlwaysStopped + Duration.zero)
  // ============================================================
  final phaseAnim = AlwaysStoppedAnimation<double>(0.0);
  final glowAnim = AlwaysStoppedAnimation<double>(0.5);
  const stillness = Duration.zero;
  print('phaseAnim.value=${phaseAnim.value} glowAnim.value=${glowAnim.value} '
      'duration=$stillness');

  print('GestureRecognizer Deep Demo completed successfully');

  // ============================================================
  // Compose the page
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'GestureRecognizer Deep Demo',
    home: Scaffold(
      backgroundColor: Color(0xFFF5F4FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              hero,
              SizedBox(height: 24.0),
              _buildSectionTitle(
                  '1. Anatomy of GestureRecognizer', Icons.account_tree),
              anatomy,
              SizedBox(height: 24.0),
              _buildSectionTitle('2. Class Hierarchy', Icons.device_hub),
              classTree,
              SizedBox(height: 24.0),
              _buildSectionTitle('3. Pointer Lifecycle', Icons.timeline),
              lifecycle,
              SizedBox(height: 24.0),
              _buildSectionTitle('4. Gesture Arena', Icons.stadium),
              arena,
              SizedBox(height: 24.0),
              _buildSectionTitle('5. Concrete Subclasses', Icons.dashboard),
              Wrap(
                spacing: 12.0,
                runSpacing: 12.0,
                alignment: WrapAlignment.center,
                children: subclassCards,
              ),
              SizedBox(height: 24.0),
              _buildSectionTitle('6. Recipes', Icons.restaurant_menu),
              recipes,
              SizedBox(height: 24.0),
              _buildSectionTitle('7. Pitfalls', Icons.warning_amber),
              pitfalls,
              SizedBox(height: 24.0),
              _buildSectionTitle('8. Reference Footer', Icons.terminal),
              footer,
              SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================
// Helper: section title
// ============================================================
Widget _buildSectionTitle(String text, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade400, Colors.purple.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withValues(alpha: 0.3),
                blurRadius: 6.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 18.0),
        ),
        SizedBox(width: 12.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            color: Colors.indigo.shade900,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: hero chip
// ============================================================
Widget _buildHeroChip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: color.withValues(alpha: 0.7), width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: color,
        fontFamily: 'monospace',
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// ============================================================
// Helper: anatomy row
// ============================================================
Widget _buildAnatomyRow(
  String name,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border(left: BorderSide(color: color, width: 4.0)),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.12),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: color, size: 20.0),
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
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade800,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: tree node
// ============================================================
Widget _buildTreeNode(
  String name,
  String tag,
  Color color,
  int depth,
) {
  return Container(
    margin: EdgeInsets.only(left: depth * 18.0),
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color, color.withValues(alpha: 0.8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.code, color: Colors.white, size: 16.0),
        SizedBox(width: 8.0),
        Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
          ),
        ),
        SizedBox(width: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            tag,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: tree connector
// ============================================================
Widget _buildTreeConnector(int depth) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 18.0 + 24.0),
    child: SizedBox(
      width: 2.0,
      height: 14.0,
      child: ColoredBox(color: Colors.indigo.shade300),
    ),
  );
}

// ============================================================
// Helper: leaf node card for class hierarchy
// ============================================================
Widget _buildLeafNode(String name, IconData icon, Color color) {
  return Container(
    width: 168.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.withValues(alpha: 0.12), color.withValues(alpha: 0.25)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 5.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 18.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Lifecycle row
// ============================================================
class _LifecycleStep {
  final String title;
  final String snippet;
  final String description;
  final IconData icon;
  final Color color;
  const _LifecycleStep(
    this.title,
    this.snippet,
    this.description,
    this.icon,
    this.color,
  );
}

Widget _buildTimelineRow(_LifecycleStep step, int index, int total) {
  final isLast = index == total - 1;
  return IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 32.0,
          child: Column(
            children: [
              Container(
                width: 28.0,
                height: 28.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [step.color, step.color.withValues(alpha: 0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: step.color.withValues(alpha: 0.4),
                      blurRadius: 6.0,
                      offset: Offset(0.0, 2.0),
                    ),
                  ],
                ),
                child: Icon(step.icon, color: Colors.white, size: 16.0),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2.0,
                    color: step.color.withValues(alpha: 0.4),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: isLast ? 0.0 : 12.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: step.color.withValues(alpha: 0.4),
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: step.color.withValues(alpha: 0.1),
                  blurRadius: 6.0,
                  offset: Offset(0.0, 2.0),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: step.color,
                    fontSize: 13.0,
                  ),
                ),
                SizedBox(height: 6.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    step.snippet,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: Colors.greenAccent,
                    ),
                  ),
                ),
                SizedBox(height: 6.0),
                Text(
                  step.description,
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.grey.shade800,
                    height: 1.3,
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

// ============================================================
// Arena painter
// ============================================================
class _ArenaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Background ring
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..shader = LinearGradient(
        colors: [Colors.amberAccent, Colors.deepPurpleAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromCircle(
        center: Offset(centerX, centerY),
        radius: 90.0,
      ));
    canvas.drawCircle(Offset(centerX, centerY), 90.0, ringPaint);

    // Inner "arena floor"
    final floorPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.indigo.shade700.withValues(alpha: 0.4),
          Colors.deepPurple.shade700.withValues(alpha: 0.6),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromCircle(
        center: Offset(centerX, centerY),
        radius: 80.0,
      ));
    canvas.drawCircle(Offset(centerX, centerY), 80.0, floorPaint);

    // Pointer marker at center
    final pointerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(centerX, centerY), 8.0, pointerPaint);

    final pointerLabel = TextPainter(
      text: TextSpan(
        text: 'pointer 0x1',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10.0,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    pointerLabel.paint(
      canvas,
      Offset(centerX - pointerLabel.width / 2, centerY + 12.0),
    );

    // Recognizer slots around the ring
    final slots = <_ArenaSlot>[
      _ArenaSlot('Tap', -90.0, Colors.greenAccent, 'accepted'),
      _ArenaSlot('LongPress', 30.0, Colors.amberAccent, 'undecided'),
      _ArenaSlot('Pan', 150.0, Colors.redAccent, 'rejected'),
    ];

    for (final slot in slots) {
      final rad = slot.angleDeg * 3.1415926535 / 180.0;
      final x = centerX + 110.0 * _cos(rad);
      final y = centerY + 110.0 * _sin(rad);

      // Connecting line
      final linePaint = Paint()
        ..color = slot.color.withValues(alpha: 0.6)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke;
      canvas.drawLine(Offset(centerX, centerY), Offset(x, y), linePaint);

      // Recognizer chip
      final chipPaint = Paint()
        ..shader = LinearGradient(
          colors: [
            slot.color.withValues(alpha: 0.4),
            slot.color,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(Rect.fromCenter(
          center: Offset(x, y),
          width: 90.0,
          height: 36.0,
        ));
      final chipRect = RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(x, y), width: 96.0, height: 40.0),
        Radius.circular(20.0),
      );
      canvas.drawRRect(chipRect, chipPaint);

      final chipBorder = Paint()
        ..color = Colors.white.withValues(alpha: 0.7)
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;
      canvas.drawRRect(chipRect, chipBorder);

      final namePainter = TextPainter(
        text: TextSpan(
          children: [
            TextSpan(
              text: slot.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: '\n${slot.disposition}',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 9.0,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: 96.0);
      namePainter.paint(
        canvas,
        Offset(x - namePainter.width / 2, y - namePainter.height / 2),
      );
    }
  }

  // Polynomial approximations to keep CustomPainter dependency-free.
  double _cos(double r) {
    // Use a Taylor-ish wrap; good enough for visual placement.
    return _flutterCos(r);
  }

  double _sin(double r) {
    return _flutterSin(r);
  }

  double _flutterCos(double r) {
    // Reduce r to [-pi, pi]
    const pi = 3.1415926535897932;
    while (r > pi) {
      r -= 2 * pi;
    }
    while (r < -pi) {
      r += 2 * pi;
    }
    final r2 = r * r;
    final r4 = r2 * r2;
    final r6 = r4 * r2;
    return 1.0 - r2 / 2.0 + r4 / 24.0 - r6 / 720.0;
  }

  double _flutterSin(double r) {
    const pi = 3.1415926535897932;
    while (r > pi) {
      r -= 2 * pi;
    }
    while (r < -pi) {
      r += 2 * pi;
    }
    final r2 = r * r;
    final r3 = r2 * r;
    final r5 = r3 * r2;
    final r7 = r5 * r2;
    return r - r3 / 6.0 + r5 / 120.0 - r7 / 5040.0;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ArenaSlot {
  final String name;
  final double angleDeg;
  final Color color;
  final String disposition;
  const _ArenaSlot(this.name, this.angleDeg, this.color, this.disposition);
}

// ============================================================
// Helper: arena legend chip
// ============================================================
Widget _buildArenaLegend(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: color, width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 11.0,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: subclass card
// ============================================================
Widget _buildSubclassCard({
  required String title,
  required String tagline,
  required String description,
  required List<String> callbacks,
  required IconData icon,
  required List<Color> gradient,
}) {
  return Container(
    width: 280.0,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: gradient,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: gradient.last.withValues(alpha: 0.4),
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
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(icon, color: Colors.white, size: 22.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          tagline,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 11.0,
            fontFamily: 'monospace',
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          description,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.0,
            height: 1.3,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Callbacks:',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Wrap(
                spacing: 4.0,
                runSpacing: 4.0,
                children: [
                  for (final cb in callbacks)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        cb,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: recipe card
// ============================================================
Widget _buildRecipeCard(String title, String code, Color accent) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.45),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(left: BorderSide(color: accent, width: 3.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: accent,
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          code,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'monospace',
            fontSize: 11.0,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Helper: pitfall row
// ============================================================
Widget _buildPitfallRow(String title, String body, IconData icon) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.red.shade200, width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.red.shade700, size: 20.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade900,
                  fontSize: 12.0,
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.grey.shade800,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
