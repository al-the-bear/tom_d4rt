// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt visual demo: OneSequenceGestureRecognizer (abstract base class)
// from package:flutter/gestures.dart.
//
// OneSequenceGestureRecognizer is the abstract intermediate layer between
// the very low-level GestureRecognizer and the concrete recognisers a Flutter
// app actually uses (TapGestureRecognizer, LongPressGestureRecognizer, the
// drag recognisers, ScaleGestureRecognizer, etc.). Its defining property is
// embedded in its name: it tracks exactly one pointer sequence — i.e. one
// ongoing finger-on-screen lifecycle from the moment the framework decides
// "this gesture might apply" to the moment all relevant pointers have lifted
// or been cancelled. Anything that needs to track multiple simultaneous
// pointers as independent sequences (multi-touch tap counters, custom
// pinch logic) inherits from a different branch of the hierarchy.
//
// This file renders a single static frame that explains the shape of the
// class, its lifecycle, the gesture arena, the catalogue of subclasses,
// and a few classic pitfalls. It is not interactive — the harness invokes
// build() once and renders the resulting widget tree.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('OneSequenceGestureRecognizer Deep Demo executing');
  print('Library: package:flutter/gestures.dart');
  print('Abstract base — instantiated only via subclasses');

  // ------------------------------------------------------------------
  // We instantiate a few concrete subclasses purely to demonstrate that
  // they really do extend OneSequenceGestureRecognizer. We do NOT attach
  // them to a real input stream at the top level — we hand them off to a
  // RawGestureDetector below, which manages their lifetime, so the
  // harness never has to care about disposal timing.
  // ------------------------------------------------------------------
  final List<Object> probes = <Object>[
    TapGestureRecognizer(),
    LongPressGestureRecognizer(),
    VerticalDragGestureRecognizer(),
    HorizontalDragGestureRecognizer(),
    PanGestureRecognizer(),
    ScaleGestureRecognizer(),
  ];
  final probeNames = <String>[
    'TapGestureRecognizer',
    'LongPressGestureRecognizer',
    'VerticalDragGestureRecognizer',
    'HorizontalDragGestureRecognizer',
    'PanGestureRecognizer',
    'ScaleGestureRecognizer',
  ];

  for (var i = 0; i < probes.length; i++) {
    final probe = probes[i];
    final name = probeNames[i];
    print('$name isOneSeq: ${probe is OneSequenceGestureRecognizer}');
  }

  // We dispose the probes immediately — they never received a pointer
  // event, so cleaning them up here is safe.
  for (final probe in probes) {
    if (probe is OneSequenceGestureRecognizer) {
      probe.dispose();
    }
  }

  // ==================================================================
  // SECTION 1: Hero Header
  // ==================================================================
  print('=== Section 1: Hero header ===');

  final heroHeader = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1A237E), Color(0xFF4527A0), Color(0xFF6A1B9A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: Colors.purple.withValues(alpha: 0.25),
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
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 1.0,
                ),
              ),
              child: Icon(Icons.touch_app, size: 40.0, color: Colors.white),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'OneSequenceGestureRecognizer',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/gestures.dart  ·  abstract class',
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
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'Tracks a single pointer sequence from initial accept-or-reject\n'
            'decision through pointer-up. The base class for Tap, LongPress,\n'
            'all Drag/Pan/Scale recognisers, and Force-press. Subclasses do\n'
            'not manage arena membership directly — they call resolve(),\n'
            'startTrackingPointer(), and stopTrackingPointer() and let the\n'
            'arena coordinate competing recognisers.',
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white,
              height: 1.5,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _heroChip('abstract', Colors.deepOrange),
            _heroChip('one pointer sequence', Colors.cyan),
            _heroChip('arena participant', Colors.lightGreen),
            _heroChip('mixin: GestureArenaMember', Colors.amber),
          ],
        ),
      ],
    ),
  );

  // ==================================================================
  // SECTION 2: Class hierarchy tree
  // ==================================================================
  print('=== Section 2: Class hierarchy tree ===');

  final hierarchyTree = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade50, Colors.indigo.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.15),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Class Hierarchy',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Where OneSequenceGestureRecognizer sits inside the gesture system.',
          style: TextStyle(fontSize: 12.0, color: Colors.indigo.shade400),
        ),
        SizedBox(height: 16.0),
        _hierarchyNode(
          depth: 0,
          label: 'GestureRecognizer',
          subtitle: 'abstract — base of all recognisers',
          color: Colors.deepPurple,
          icon: Icons.account_tree,
        ),
        _hierarchyConnector(depth: 0),
        _hierarchyNode(
          depth: 1,
          label: 'OneSequenceGestureRecognizer',
          subtitle: 'abstract — single pointer sequence',
          color: Colors.indigo,
          icon: Icons.touch_app,
          highlighted: true,
        ),
        _hierarchyConnector(depth: 1),
        _hierarchyNode(
          depth: 2,
          label: 'PrimaryPointerGestureRecognizer',
          subtitle: 'abstract — locks onto the first qualifying pointer',
          color: Colors.teal,
          icon: Icons.fiber_manual_record,
        ),
        _hierarchyConnector(depth: 2),
        _hierarchyNode(
          depth: 3,
          label: 'BaseTapGestureRecognizer',
          subtitle: 'abstract — primitive tap state machine',
          color: Colors.cyan.shade700,
          icon: Icons.ads_click,
        ),
        _hierarchyConnector(depth: 3),
        _hierarchyNode(
          depth: 4,
          label: 'TapGestureRecognizer',
          subtitle: 'concrete — onTap, onTapDown, onTapUp',
          color: Colors.green,
          icon: Icons.check_circle_outline,
        ),
        SizedBox(height: 12.0),
        _hierarchyConnector(depth: 1),
        _hierarchyNode(
          depth: 2,
          label: 'DragGestureRecognizer',
          subtitle: 'abstract — common drag bookkeeping',
          color: Colors.orange,
          icon: Icons.open_with,
        ),
        _hierarchyConnector(depth: 2),
        _hierarchyNode(
          depth: 3,
          label: 'HorizontalDragGestureRecognizer',
          subtitle: 'concrete — left/right swipes',
          color: Colors.deepOrange,
          icon: Icons.swap_horiz,
        ),
        _hierarchyConnector(depth: 2),
        _hierarchyNode(
          depth: 3,
          label: 'VerticalDragGestureRecognizer',
          subtitle: 'concrete — up/down swipes',
          color: Colors.red,
          icon: Icons.swap_vert,
        ),
        _hierarchyConnector(depth: 2),
        _hierarchyNode(
          depth: 3,
          label: 'PanGestureRecognizer',
          subtitle: 'concrete — free 2-D drag',
          color: Colors.pink,
          icon: Icons.pan_tool,
        ),
        SizedBox(height: 12.0),
        _hierarchyConnector(depth: 1),
        _hierarchyNode(
          depth: 2,
          label: 'ScaleGestureRecognizer',
          subtitle: 'concrete — pinch + rotate (focal point sequence)',
          color: Colors.blue,
          icon: Icons.zoom_out_map,
        ),
        _hierarchyConnector(depth: 1),
        _hierarchyNode(
          depth: 2,
          label: 'LongPressGestureRecognizer',
          subtitle: 'concrete — long-press cluster',
          color: Colors.amber.shade800,
          icon: Icons.timer,
        ),
      ],
    ),
  );

  // ==================================================================
  // SECTION 3: Lifecycle flow diagram
  // ==================================================================
  print('=== Section 3: Lifecycle flow ===');

  final lifecycleSteps = <Widget>[];
  final lifecycleData = <Map<String, Object>>[
    {
      'step': '1',
      'name': 'addAllowedPointer(event)',
      'desc':
          'Called by the framework when a PointerDownEvent matches this '
              'recognizer’s filters (kind, button, debugOwner).',
      'color': Colors.blue,
      'icon': Icons.input,
    },
    {
      'step': '2',
      'name': 'startTrackingPointer(p)',
      'desc':
          'The recognizer registers a route with GestureBinding.pointerRouter '
              'and joins the gesture arena for that pointer.',
      'color': Colors.cyan,
      'icon': Icons.route,
    },
    {
      'step': '3',
      'name': 'handleEvent(event)',
      'desc':
          'Stream of PointerMoveEvent / PointerUpEvent / PointerCancelEvent '
              'is delivered. Subclasses inspect them and decide.',
      'color': Colors.teal,
      'icon': Icons.input,
    },
    {
      'step': '4',
      'name': 'resolve(GestureDisposition)',
      'desc':
          'Either accepted (we won) or rejected (someone else won, or we '
              'gave up). Triggers acceptGesture/rejectGesture callbacks.',
      'color': Colors.amber.shade800,
      'icon': Icons.gavel,
    },
    {
      'step': '5',
      'name': 'stopTrackingPointer(p)',
      'desc':
          'Removes the pointer route. When the last tracked pointer is gone '
              'the recognizer transitions to its terminal state.',
      'color': Colors.deepOrange,
      'icon': Icons.stop_circle,
    },
    {
      'step': '6',
      'name': 'didStopTrackingLastPointer(p)',
      'desc':
          'The hook subclasses override to fire onTap, onLongPress, '
              'onDragEnd, etc. and reset internal state.',
      'color': Colors.purple,
      'icon': Icons.flag,
    },
    {
      'step': '7',
      'name': 'dispose()',
      'desc':
          'Releases the recognizer and cancels any outstanding pointer '
              'tracking. Always call dispose() from the owning state.',
      'color': Colors.red,
      'icon': Icons.delete_forever,
    },
  ];

  for (var i = 0; i < lifecycleData.length; i++) {
    final d = lifecycleData[i];
    final color = d['color'] as Color;
    lifecycleSteps.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.12),
              color.withValues(alpha: 0.04),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.5), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.18),
              blurRadius: 6.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.6),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Text(
                d['step'] as String,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Icon(d['icon'] as IconData, color: color, size: 22.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    d['name'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    d['desc'] as String,
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
    if (i != lifecycleData.length - 1) {
      lifecycleSteps.add(
        Center(
          child: Icon(
            Icons.arrow_downward,
            color: color.withValues(alpha: 0.7),
            size: 22.0,
          ),
        ),
      );
    }
  }

  final lifecycleDiagram = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade50, Colors.blueGrey.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blueGrey.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lifecycle of a single pointer sequence',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'From PointerDownEvent acceptance to didStopTrackingLastPointer.',
          style: TextStyle(fontSize: 12.0, color: Colors.blueGrey.shade400),
        ),
        SizedBox(height: 12.0),
        ...lifecycleSteps,
      ],
    ),
  );

  // ==================================================================
  // SECTION 4: Subclass catalogue grid
  // ==================================================================
  print('=== Section 4: Subclass catalogue ===');

  final subclassData = <Map<String, Object>>[
    {
      'name': 'TapGestureRecognizer',
      'fires': 'onTap, onTapDown, onTapUp, onTapCancel',
      'note': 'Wins arena on pointer-up if pointer stayed near initial spot.',
      'icon': Icons.ads_click,
      'color': Colors.green,
    },
    {
      'name': 'LongPressGestureRecognizer',
      'fires': 'onLongPress, onLongPressMoveUpdate, onLongPressEnd',
      'note': 'Wins after a kLongPressTimeout-long stationary hold.',
      'icon': Icons.timer,
      'color': Colors.amber.shade800,
    },
    {
      'name': 'HorizontalDragGestureRecognizer',
      'fires': 'onStart, onUpdate, onEnd, onCancel',
      'note': 'Resolves accepted only after a horizontal slop is exceeded.',
      'icon': Icons.swap_horiz,
      'color': Colors.deepOrange,
    },
    {
      'name': 'VerticalDragGestureRecognizer',
      'fires': 'onStart, onUpdate, onEnd, onCancel',
      'note': 'Mirror of horizontal drag for the Y axis.',
      'icon': Icons.swap_vert,
      'color': Colors.red,
    },
    {
      'name': 'PanGestureRecognizer',
      'fires': 'onStart, onUpdate, onEnd, onCancel',
      'note': 'Free 2-D drag — accepts after total slop is exceeded.',
      'icon': Icons.pan_tool,
      'color': Colors.pink,
    },
    {
      'name': 'ScaleGestureRecognizer',
      'fires': 'onStart, onUpdate, onEnd',
      'note':
          'Tracks one focal-point sequence even when several pointers are '
              'down — the focal point is the "single sequence".',
      'icon': Icons.zoom_out_map,
      'color': Colors.blue,
    },
    {
      'name': 'ForcePressGestureRecognizer',
      'fires': 'onStart, onPeak, onUpdate, onEnd',
      'note': 'Reads PointerEvent.pressure on supporting platforms.',
      'icon': Icons.touch_app,
      'color': Colors.deepPurple,
    },
    {
      'name': 'EagerGestureRecognizer',
      'fires': '— (immediately accepts every pointer)',
      'note':
          'Used to claim the arena and prevent ancestors from competing. '
              'A canonical "always wins" implementation.',
      'icon': Icons.flash_on,
      'color': Colors.teal,
    },
  ];

  final subclassCards = <Widget>[];
  for (final s in subclassData) {
    final color = s['color'] as Color;
    subclassCards.add(
      Container(
        width: 240.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.10),
              color.withValues(alpha: 0.22),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color, width: 1.4),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(s['icon'] as IconData, color: color, size: 26.0),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    s['name'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                'fires: ${s['fires']}',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.black87,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              s['note'] as String,
              style: TextStyle(
                fontSize: 11.5,
                color: Colors.grey.shade800,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final subclassCatalogue = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Subclass catalogue',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Each card lists the public callbacks the subclass exposes and the '
          'condition under which it claims the arena.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        Wrap(children: subclassCards),
      ],
    ),
  );

  // ==================================================================
  // SECTION 5: Gesture arena diagram
  // ==================================================================
  print('=== Section 5: Gesture arena ===');

  final arenaDiagram = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: RadialGradient(
        colors: [Colors.amber.shade50, Colors.orange.shade100],
        center: Alignment.center,
        radius: 1.1,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.amber.shade400, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.35),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'Gesture Arena',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.orange.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Multiple OneSequenceGestureRecognizers compete for one pointer.',
          style: TextStyle(fontSize: 12.0, color: Colors.orange.shade700),
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.orange.shade200, width: 1.0),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _arenaContestant('Tap', Colors.green, Icons.ads_click),
                  SizedBox(width: 12.0),
                  _arenaContestant(
                    'LongPress',
                    Colors.amber.shade800,
                    Icons.timer,
                  ),
                  SizedBox(width: 12.0),
                  _arenaContestant(
                    'HDrag',
                    Colors.deepOrange,
                    Icons.swap_horiz,
                  ),
                  SizedBox(width: 12.0),
                  _arenaContestant('VDrag', Colors.red, Icons.swap_vert),
                ],
              ),
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.orange.shade300,
                      Colors.deepOrange.shade400,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepOrange.withValues(alpha: 0.4),
                      blurRadius: 8.0,
                      offset: Offset(0.0, 3.0),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.sports_kabaddi,
                      color: Colors.white,
                      size: 22.0,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'GestureArenaManager',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.0),
              Icon(
                Icons.arrow_downward,
                color: Colors.orange.shade700,
                size: 22.0,
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade400,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withValues(alpha: 0.4),
                      blurRadius: 6.0,
                      offset: Offset(0.0, 2.0),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.emoji_events,
                      color: Colors.white,
                      size: 18.0,
                    ),
                    SizedBox(width: 6.0),
                    Text(
                      'winner.acceptGesture(pointer)',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'losers.rejectGesture(pointer) on everyone else',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.orange.shade200, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _arenaRule(
                Colors.green,
                'A recogniser calls resolve(GestureDisposition.accepted) when '
                    'it is sure the gesture is its own.',
              ),
              SizedBox(height: 6.0),
              _arenaRule(
                Colors.red,
                'It calls resolve(rejected) when it knows the gesture is not '
                    'its own (e.g. user moved beyond the slop tolerance).',
              ),
              SizedBox(height: 6.0),
              _arenaRule(
                Colors.blueGrey,
                'If only one recogniser remains in the arena when the pointer '
                    'is released, it wins by default ("sweep").',
              ),
              SizedBox(height: 6.0),
              _arenaRule(
                Colors.deepPurple,
                'GestureArenaTeam can group several recognisers so they '
                    'collectively yield to a captain decision.',
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ==================================================================
  // SECTION 6: How to subclass — pseudocode listing
  // ==================================================================
  print('=== Section 6: How-to subclass ===');

  final subclassRecipe = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF0D1B2A), Color(0xFF1B263B)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
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
            Icon(Icons.code, color: Colors.cyan.shade300, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'recipe: subclassing OneSequenceGestureRecognizer',
              style: TextStyle(
                color: Colors.cyan.shade300,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        DefaultTextStyle(
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: Colors.white,
            height: 1.5,
          ),
          child: Text.rich(
            TextSpan(
              children: <InlineSpan>[
                _kw('class '),
                _id('MySwipeRecognizer '),
                _kw('extends '),
                _ty('OneSequenceGestureRecognizer'),
                _pl(' {\n'),
                _pl('  Offset? _start;\n'),
                _pl('  '),
                _kw('void '),
                _fn('Function'),
                _pl('()? onSwipe;\n\n'),
                _pl('  '),
                _an('@override\n'),
                _pl('  '),
                _kw('void '),
                _fn('addAllowedPointer'),
                _pl('(PointerDownEvent event) {\n'),
                _pl('    _start = event.position;\n'),
                _pl('    '),
                _fn('startTrackingPointer'),
                _pl('(event.pointer);\n'),
                _pl('    '),
                _fn('resolve'),
                _pl('(GestureDisposition.accepted); '),
                _co('// or postpone\n'),
                _pl('  }\n\n'),
                _pl('  '),
                _an('@override\n'),
                _pl('  '),
                _kw('void '),
                _fn('handleEvent'),
                _pl('(PointerEvent event) {\n'),
                _pl('    '),
                _kw('if '),
                _pl('(event '),
                _kw('is '),
                _ty('PointerMoveEvent'),
                _pl(') {\n'),
                _pl('      '),
                _co('// inspect deltas, decide accept/reject\n'),
                _pl('    } '),
                _kw('else if '),
                _pl('(event '),
                _kw('is '),
                _ty('PointerUpEvent'),
                _pl(') {\n'),
                _pl('      '),
                _fn('stopTrackingPointer'),
                _pl('(event.pointer);\n'),
                _pl('    } '),
                _kw('else if '),
                _pl('(event '),
                _kw('is '),
                _ty('PointerCancelEvent'),
                _pl(') {\n'),
                _pl('      '),
                _fn('stopTrackingPointer'),
                _pl('(event.pointer);\n'),
                _pl('    }\n'),
                _pl('  }\n\n'),
                _pl('  '),
                _an('@override\n'),
                _pl('  '),
                _kw('void '),
                _fn('didStopTrackingLastPointer'),
                _pl('(int pointer) {\n'),
                _pl('    onSwipe?.call();\n'),
                _pl('    _start = '),
                _kw('null'),
                _pl(';\n'),
                _pl('  }\n\n'),
                _pl('  '),
                _an('@override\n'),
                _pl('  '),
                _ty('String '),
                _kw('get '),
                _id('debugDescription'),
                _pl(' => '),
                _st("'mySwipe'"),
                _pl(';\n'),
                _pl('}\n'),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.cyan.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colors.cyan.shade700,
              width: 1.0,
            ),
          ),
          child: Text(
            'Always implement debugDescription, override didStopTrackingLastPointer\n'
            'to fire your callbacks, and remember resolve() can be called at any\n'
            'point — not only inside handleEvent.',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.cyan.shade100,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  // ==================================================================
  // SECTION 7: Live RawGestureDetector demo
  // ==================================================================
  print('=== Section 7: RawGestureDetector demo ===');

  final liveDemo = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.lightGreen.shade50, Colors.green.shade100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.green.shade400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.3),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Live RawGestureDetector',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Wires two real OneSequenceGestureRecognizer subclasses through '
          'RawGestureDetector — the harness manages dispose for us.',
          style: TextStyle(fontSize: 12.0, color: Colors.green.shade800),
        ),
        SizedBox(height: 14.0),
        Center(
          child: RawGestureDetector(
            gestures: <Type, GestureRecognizerFactory>{
              TapGestureRecognizer:
                  GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
                () => TapGestureRecognizer(),
                (TapGestureRecognizer instance) {
                  instance.onTap = () {
                    print('RawGestureDetector: tap fired');
                  };
                },
              ),
              LongPressGestureRecognizer:
                  GestureRecognizerFactoryWithHandlers<
                      LongPressGestureRecognizer>(
                () => LongPressGestureRecognizer(),
                (LongPressGestureRecognizer instance) {
                  instance.onLongPress = () {
                    print('RawGestureDetector: long-press fired');
                  };
                },
              ),
            },
            child: Container(
              width: 260.0,
              height: 120.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade400, Colors.teal.shade500],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withValues(alpha: 0.4),
                    blurRadius: 10.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.touch_app, color: Colors.white, size: 32.0),
                  SizedBox(height: 6.0),
                  Text(
                    'Tap or long-press here',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    '(static screenshot — events go to print)',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 11.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.green.shade300, width: 1.0),
          ),
          child: Text(
            'When two OneSequenceGestureRecognizers share a hit-tested region, '
            'the arena resolves between them. Tap rejects itself once '
            'long-press passes its threshold; long-press rejects itself if '
            'the user lifts early.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.green.shade900,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  // ==================================================================
  // SECTION 8: Pitfalls
  // ==================================================================
  print('=== Section 8: Pitfalls ===');

  final pitfalls = <Map<String, Object>>[
    {
      'title': 'Forgetting dispose()',
      'detail':
          'A recogniser owns route subscriptions in PointerRouter. Leaking '
              'one keeps the State alive after the widget is gone.',
      'icon': Icons.warning_amber,
      'color': Colors.red,
    },
    {
      'title': 'Calling resolve() after dispose()',
      'detail':
          'resolve() during a teardown can target a freed arena entry. Only '
              'resolve while the recogniser still tracks at least one pointer.',
      'icon': Icons.dangerous,
      'color': Colors.red.shade700,
    },
    {
      'title': 'Treating multi-touch as one sequence',
      'detail':
          'Need per-finger state? Use MultiTapGestureRecognizer or '
              'ImmediateMultiDragGestureRecognizer instead — they extend a '
              'different branch and track each pointer independently.',
      'icon': Icons.fingerprint,
      'color': Colors.deepOrange,
    },
    {
      'title': 'Ignoring the arena',
      'detail':
          'Always go through resolve()/startTrackingPointer(). Bypassing '
              'them by manually firing callbacks short-circuits the arena and '
              'corrupts other gestures in the same hit region.',
      'icon': Icons.block,
      'color': Colors.purple,
    },
    {
      'title': 'Acceptance on PointerDown',
      'detail':
          'Calling resolve(accepted) immediately turns the recogniser into '
              'an EagerGestureRecognizer-style arena bully. Usually you want '
              'to delay acceptance until you have evidence (slop, timer).',
      'icon': Icons.flash_on,
      'color': Colors.amber.shade800,
    },
    {
      'title': 'Forgetting didStopTrackingLastPointer',
      'detail':
          'Subclasses must reset internal state in didStopTrackingLastPointer '
              '(or override it directly), otherwise the second sequence will '
              'inherit stale offsets and timers.',
      'icon': Icons.refresh,
      'color': Colors.indigo,
    },
  ];

  final pitfallCards = <Widget>[];
  for (final p in pitfalls) {
    final color = p['color'] as Color;
    pitfallCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10.0),
          border: Border(
            left: BorderSide(color: color, width: 4.0),
            top: BorderSide(color: color.withValues(alpha: 0.3), width: 1.0),
            right: BorderSide(color: color.withValues(alpha: 0.3), width: 1.0),
            bottom:
                BorderSide(color: color.withValues(alpha: 0.3), width: 1.0),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(p['icon'] as IconData, color: color, size: 22.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    p['detail'] as String,
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

  final pitfallSection = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.orange.shade50],
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
            Icon(Icons.report_gmailerrorred, color: Colors.red.shade700),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls and gotchas',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        ...pitfallCards,
      ],
    ),
  );

  // ==================================================================
  // SECTION 9: Footer with file path + ASCII source-location box
  // ==================================================================
  print('=== Section 9: Footer ===');

  const sourcePath =
      'tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/'
      'send_ast_via_http_scripts/gestures/'
      'one_sequence_gesture_recognizer_test.dart';
  const flutterPath =
      'package:flutter/src/gestures/recognizer.dart  '
      '(class OneSequenceGestureRecognizer)';

  final footer = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade900, Colors.blueGrey.shade700],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.35),
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
            Icon(Icons.insert_drive_file, color: Colors.cyan.shade200),
            SizedBox(width: 8.0),
            Text(
              'source location',
              style: TextStyle(
                fontFamily: 'monospace',
                color: Colors.cyan.shade200,
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.cyan.shade700, width: 1.0),
          ),
          child: Text(
            '+--------------------------------------------------------------+\n'
            '|  demo file                                                   |\n'
            '|    $sourcePath\n'
            '|                                                              |\n'
            '|  flutter symbol                                              |\n'
            '|    $flutterPath\n'
            '+--------------------------------------------------------------+',
            style: TextStyle(
              fontFamily: 'monospace',
              color: Colors.cyan.shade100,
              fontSize: 10.0,
              height: 1.45,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'rendered statically — build() runs once, no setState/Timer/Stream.',
          style: TextStyle(
            fontFamily: 'monospace',
            color: Colors.white60,
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  print('OneSequenceGestureRecognizer Deep Demo completed successfully');

  // ==================================================================
  // Compose the final scrolling layout.
  // ==================================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        heroHeader,
        SizedBox(height: 28.0),
        _sectionTitle('1. Class Hierarchy', Icons.account_tree),
        SizedBox(height: 8.0),
        hierarchyTree,
        SizedBox(height: 28.0),
        _sectionTitle('2. Lifecycle', Icons.timeline),
        SizedBox(height: 8.0),
        lifecycleDiagram,
        SizedBox(height: 28.0),
        _sectionTitle('3. Subclass Catalogue', Icons.dashboard),
        SizedBox(height: 8.0),
        subclassCatalogue,
        SizedBox(height: 28.0),
        _sectionTitle('4. Gesture Arena', Icons.sports_kabaddi),
        SizedBox(height: 8.0),
        arenaDiagram,
        SizedBox(height: 28.0),
        _sectionTitle('5. How to Subclass', Icons.code),
        SizedBox(height: 8.0),
        subclassRecipe,
        SizedBox(height: 28.0),
        _sectionTitle('6. Live Demo', Icons.touch_app),
        SizedBox(height: 8.0),
        liveDemo,
        SizedBox(height: 28.0),
        _sectionTitle('7. Pitfalls', Icons.report_gmailerrorred),
        SizedBox(height: 8.0),
        pitfallSection,
        SizedBox(height: 28.0),
        _sectionTitle('8. Source Location', Icons.insert_drive_file),
        SizedBox(height: 8.0),
        footer,
        SizedBox(height: 32.0),
      ],
    ),
  );
}

// ====================================================================
// Helpers
// ====================================================================

Widget _heroChip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.25),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color, width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        fontFamily: 'monospace',
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _sectionTitle(String text, IconData icon) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo.shade400, Colors.purple.shade400],
          ),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.indigo.withValues(alpha: 0.3),
              blurRadius: 6.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 18.0),
      ),
      SizedBox(width: 10.0),
      Text(
        text,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.indigo.shade900,
        ),
      ),
    ],
  );
}

Widget _hierarchyNode({
  required int depth,
  required String label,
  required String subtitle,
  required Color color,
  required IconData icon,
  bool highlighted = false,
}) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 18.0),
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: highlighted
              ? [color, color.withValues(alpha: 0.6)]
              : [
                  color.withValues(alpha: 0.18),
                  color.withValues(alpha: 0.05),
                ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: color,
          width: highlighted ? 2.0 : 1.0,
        ),
        boxShadow: highlighted
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.55),
                  blurRadius: 10.0,
                  offset: Offset(0.0, 3.0),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: highlighted ? Colors.white : color,
            size: 20.0,
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    color: highlighted ? Colors.white : color,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11.0,
                    color: highlighted
                        ? Colors.white70
                        : Colors.grey.shade700,
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

Widget _hierarchyConnector({required int depth}) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 18.0 + 18.0),
    child: Container(
      width: 2.0,
      height: 12.0,
      color: Colors.indigo.shade200,
    ),
  );
}

Widget _arenaContestant(String label, Color color, IconData icon) {
  return Container(
    width: 64.0,
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.35),
          blurRadius: 5.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 22.0),
        SizedBox(height: 4.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _arenaRule(Color dotColor, String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(top: 5.0),
        width: 8.0,
        height: 8.0,
        decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
      ),
      SizedBox(width: 8.0),
      Expanded(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade800,
            height: 1.4,
          ),
        ),
      ),
    ],
  );
}

// Tiny syntax-highlight token helpers for the recipe block.
TextSpan _kw(String s) =>
    TextSpan(text: s, style: TextStyle(color: Color(0xFFFF7AB6)));
TextSpan _ty(String s) =>
    TextSpan(text: s, style: TextStyle(color: Color(0xFF7AD0FF)));
TextSpan _id(String s) =>
    TextSpan(text: s, style: TextStyle(color: Color(0xFFFFE08A)));
TextSpan _fn(String s) =>
    TextSpan(text: s, style: TextStyle(color: Color(0xFF9CDCFE)));
TextSpan _co(String s) => TextSpan(
      text: s,
      style: TextStyle(
        color: Color(0xFF8AE6A1),
        fontStyle: FontStyle.italic,
      ),
    );
TextSpan _st(String s) =>
    TextSpan(text: s, style: TextStyle(color: Color(0xFFFFB199)));
TextSpan _an(String s) =>
    TextSpan(text: s, style: TextStyle(color: Color(0xFFCBA6F7)));
TextSpan _pl(String s) =>
    TextSpan(text: s, style: TextStyle(color: Colors.white));
