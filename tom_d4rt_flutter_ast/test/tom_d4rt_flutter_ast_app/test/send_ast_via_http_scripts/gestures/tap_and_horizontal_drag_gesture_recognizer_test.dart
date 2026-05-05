// D4rt deep-demo script: TapAndHorizontalDragGestureRecognizer
//
// Visual, hand-authored exploration of the *horizontal-axis-locked* variant
// of TapAndDragGestureRecognizer. This demo focuses on what the axis lock
// changes vs the general TapAndDrag recognizer: the dot-product / direction
// test, arena resolution against vertical scrolling parents, and why this
// is the recognizer of choice for sliders, page-views, and swipe rows.
//
// Companion file: tap_and_drag_gesture_recognizer_test.dart (general).
// Palette: rose -> orange (distinct from the cobalt/indigo of the general
// demo). API surface is shown as text only; no recognizer is instantiated.

import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ---------------------------------------------------------------
  // Section 1: Hero header (gradient, horizontal-arrow icon).
  // ---------------------------------------------------------------
  final Widget heroHeader = Container(
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Colors.pink.shade600,
          Colors.deepOrange.shade500,
          Colors.orange.shade400,
        ],
      ),
      borderRadius: BorderRadius.circular(22.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.pink.withValues(alpha: 0.45),
          blurRadius: 20.0,
          offset: const Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.30),
          blurRadius: 28.0,
          offset: const Offset(0.0, 16.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(Icons.arrow_back, size: 36.0, color: Colors.white),
            SizedBox(width: 6.0),
            Icon(Icons.swap_horiz, size: 56.0, color: Colors.white),
            SizedBox(width: 6.0),
            Icon(Icons.arrow_forward, size: 36.0, color: Colors.white),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'TapAndHorizontalDragGestureRecognizer',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 6.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 6.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.5),
              width: 1.0,
            ),
          ),
          child: const Text(
            'tap + horizontal-only drag • axis-locked',
            style: TextStyle(
              fontSize: 12.0,
              fontStyle: FontStyle.italic,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        Text(
          'Same callbacks as TapAndDragGestureRecognizer, but the drag '
          'phase is ONLY entered when motion is predominantly horizontal. '
          'Vertical motion bows out of the arena and lets a parent '
          'recognizer (e.g. a vertical PageView) take the gesture.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13.0,
            height: 1.45,
            color: Colors.white.withValues(alpha: 0.95),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------
  // Section 2: What the axis-lock does (prose card).
  // ---------------------------------------------------------------
  final Widget lockCard = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.pink.shade200, width: 1.4),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.pink.withValues(alpha: 0.10),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 38.0,
              height: 38.0,
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(
                Icons.lock_outline,
                size: 22.0,
                color: Colors.pink.shade600,
              ),
            ),
            const SizedBox(width: 12.0),
            Text(
              'What the axis lock actually does',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Text(
          'On every pointer move, Flutter takes the cumulative drag '
          'offset and asks: is |dx| >= the recognizer\'s slop AND is '
          '|dx| > |dy| (with a small tolerance)? Only then does the '
          'recognizer accept the drag. Pure vertical motion is rejected '
          'outright; a near-45-degree drag is borderline and depends on '
          'the exact pre-acceptedSlopTolerance.',
          style: TextStyle(
            fontSize: 13.0,
            height: 1.5,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.orange.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Mental model',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange.shade700,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'TapAndHorizontalDrag = TapAndDrag + dot(motion, xAxis) > 0 '
                'gate. The tap branch is identical; the drag branch is '
                'gated by direction.',
                style: TextStyle(
                  fontSize: 12.5,
                  height: 1.4,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------
  // Section 3: Direction test diagram (5 sample drag vectors).
  // ---------------------------------------------------------------
  final Widget directionDiagram = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Colors.pink.shade50, Colors.orange.shade50],
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.pink.shade200, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Direction test: which drags are accepted?',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.pink.shade900,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Five sample vectors from the touch-down origin; only those '
          'whose horizontal component dominates pass the axis-lock gate.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 14.0),
        Center(
          child: SizedBox(
            width: 320.0,
            height: 220.0,
            child: CustomPaint(
              painter: const DirectionTestPainter(),
              child: const SizedBox.expand(),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            buildVectorChip('A', '0 deg', 'accepted', Colors.green),
            buildVectorChip('B', '90 deg', 'rejected', Colors.red),
            buildVectorChip('C', '45 deg', 'boundary', Colors.amber),
            buildVectorChip('D', '20 deg up', 'accepted', Colors.green),
            buildVectorChip('E', '70 deg up', 'rejected', Colors.red),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.pink.shade100),
          ),
          child: Text(
            'Rule of thumb: if the angle from the horizontal axis is '
            'less than ~45 degrees, the recognizer claims the drag. '
            'Beyond that, it loses to any vertical recognizer '
            'in the arena.',
            style: TextStyle(
              fontSize: 12.5,
              height: 1.4,
              color: Colors.grey.shade800,
            ),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------
  // Section 4: State machine (6 phases, with Direction Check gate).
  // ---------------------------------------------------------------
  final Widget stateMachine = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.pink.shade200, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'State machine (with axis-lock gate)',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.pink.shade900,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Six phases. The Direction Check phase is the unique '
          'addition vs the general TapAndDragGestureRecognizer.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 14.0),
        buildPhaseRow(
          1,
          'Pointer Down',
          'addPointer / addAllowedPointer; recognizer enters arena.',
          Icons.fiber_manual_record,
          Colors.pink.shade300,
        ),
        buildPhaseRow(
          2,
          'Tap Tracking',
          'onTapDown invoked; tap timer + slop tolerance start.',
          Icons.touch_app,
          Colors.pink.shade400,
        ),
        buildPhaseRow(
          3,
          'Slop Exceeded',
          'cumulative |delta| > kPanSlop; tap is invalidated.',
          Icons.compare_arrows,
          Colors.deepOrange.shade300,
        ),
        buildPhaseRow(
          4,
          'Direction Check',
          'is |dx| > |dy|? If no -> rejectGesture; if yes -> continue.',
          Icons.lock_open,
          Colors.deepOrange.shade500,
          highlight: true,
        ),
        buildPhaseRow(
          5,
          'Drag Active',
          'onDragStart fires; subsequent moves drive onDragUpdate.',
          Icons.drag_handle,
          Colors.orange.shade500,
        ),
        buildPhaseRow(
          6,
          'Drag End / Tap Up',
          'pointer up -> onDragEnd or onTapUp depending on path taken.',
          Icons.flag,
          Colors.orange.shade700,
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.deepOrange.shade50,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.deepOrange.shade200),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.bolt,
                size: 18.0,
                color: Colors.deepOrange.shade700,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Phase 4 is what makes this recognizer suitable for '
                  'horizontal sliders inside vertical scroll views: it '
                  'voluntarily yields the arena on vertical motion.',
                  style: TextStyle(
                    fontSize: 12.5,
                    height: 1.4,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------
  // Section 5: Callback grid (7 callbacks, axis-aware annotations).
  // ---------------------------------------------------------------
  final List<Widget> callbackCards = <Widget>[
    buildCallbackCard(
      'onTapDown',
      'TapDragDownDetails',
      'Identical to TapAndDrag. Fires on first contact regardless of '
          'eventual direction.',
      'details.consecutiveTapCount, kind, globalPosition',
      Icons.south_east,
      Colors.pink.shade400,
    ),
    buildCallbackCard(
      'onTapUp',
      'TapDragUpDetails',
      'Fires when pointer lifts WITHOUT exceeding slop in any direction. '
          'Axis-lock has no effect on the tap branch.',
      'details.kind, globalPosition, consecutiveTapCount',
      Icons.north_east,
      Colors.pink.shade500,
    ),
    buildCallbackCard(
      'onTapCancel',
      'VoidCallback',
      'Fires when tap is cancelled. With axis-lock, cancellation may '
          'come from either the slop-exceeded path OR the direction-check '
          'rejection (vertical drag).',
      'no payload',
      Icons.cancel,
      Colors.deepOrange.shade400,
    ),
    buildCallbackCard(
      'onDragStart',
      'TapDragStartDetails',
      'Fires only after BOTH slop is exceeded AND the direction check '
          'passes. Until then, the recognizer holds the gesture in arena '
          'but does not commit.',
      'globalPosition, kind, consecutiveTapCount',
      Icons.play_arrow,
      Colors.deepOrange.shade500,
    ),
    buildCallbackCard(
      'onDragUpdate',
      'TapDragUpdateDetails',
      'Per-move callback during the drag. delta.dx is meaningful; '
          'delta.dy is reported as-is but you typically ignore it for '
          'horizontal-locked UIs.',
      'delta, globalPosition, primaryDelta (dx-only via subclass)',
      Icons.swap_horiz,
      Colors.orange.shade600,
    ),
    buildCallbackCard(
      'onDragEnd',
      'TapDragEndDetails',
      'Fires when the drag ends. velocity.pixelsPerSecond.dx is the '
          'horizontal fling component used by Slider for snap behaviour.',
      'velocity, primaryVelocity (dx component)',
      Icons.stop,
      Colors.orange.shade700,
    ),
    buildCallbackCard(
      'onCancel',
      'VoidCallback',
      'Fires when arena rejects the gesture (e.g. parent vertical drag '
          'wins after the direction check fails). Use to roll back any '
          'preview state.',
      'no payload',
      Icons.block,
      Colors.red.shade400,
    ),
  ];

  // ---------------------------------------------------------------
  // Section 6: Arena interaction (horizontal list inside PageView).
  // ---------------------------------------------------------------
  final Widget arenaSection = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.pink.shade200, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Arena interaction: horizontal list inside vertical PageView',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.pink.shade900,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'A common nesting that without axis-lock would fight badly. '
          'With this recognizer, each axis claims its own gestures.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.pink.shade50, Colors.orange.shade50],
            ),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.pink.shade200),
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.swap_vert,
                    color: Colors.pink.shade400,
                    size: 22.0,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    'Outer: PageView (vertical drag)',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink.shade900,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.deepOrange.shade300),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.swap_horiz,
                          color: Colors.deepOrange.shade400,
                          size: 22.0,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          'Inner: ListView (horizontal carousel)',
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange.shade900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.touch_app,
                            color: Colors.orange.shade700,
                            size: 18.0,
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Text(
                              'Card: TapAndHorizontalDrag '
                              '(this recognizer)',
                              style: TextStyle(
                                fontSize: 12.5,
                                color: Colors.orange.shade900,
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
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        buildArenaResolutionRow(
          'Horizontal swipe',
          'Card recognizer wins',
          'Vertical PageView yields after direction check passes',
          Icons.east,
          Colors.green,
        ),
        buildArenaResolutionRow(
          'Vertical swipe',
          'PageView wins',
          'Card recognizer rejects on direction check',
          Icons.south,
          Colors.blue,
        ),
        buildArenaResolutionRow(
          'Quick tap',
          'Card recognizer wins',
          'Tap branch never enters direction check',
          Icons.touch_app,
          Colors.purple,
        ),
        buildArenaResolutionRow(
          'Diagonal swipe (steep)',
          'PageView wins',
          'Card recognizer cedes; |dy| > |dx|',
          Icons.south_east,
          Colors.indigo,
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------
  // Section 7: eagerVictoryOnDrag — 2 cards.
  // ---------------------------------------------------------------
  final Widget eagerVictorySection = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.pink.shade200, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'eagerVictoryOnDrag: more conservative under axis-lock',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.pink.shade900,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'When eagerVictoryOnDrag = true, the recognizer claims the '
          'arena the moment slop is exceeded. With axis-lock, that '
          'eagerness is tempered by the direction gate.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 14.0),
        buildEagerCard(
          true,
          'eagerVictoryOnDrag: true',
          'Recognizer accepts arena as soon as |dx| > slop AND '
              '|dx| > |dy|. Vertical drag still cedes.',
          'Use for sliders where you want immediate visual feedback '
              'and have no competing horizontal recognizer.',
          Colors.green,
          Icons.flash_on,
        ),
        const SizedBox(height: 10.0),
        buildEagerCard(
          false,
          'eagerVictoryOnDrag: false (default)',
          'Recognizer waits for arena resolution; competing horizontal '
              'recognizers may still win or split the gesture.',
          'Use inside swipe-to-dismiss rows where the row should give '
              'way to a more specific child swipe target.',
          Colors.blue,
          Icons.hourglass_bottom,
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------
  // Section 8: Real-world examples (4 cards).
  // ---------------------------------------------------------------
  final List<Widget> realWorldCards = <Widget>[
    buildRealWorldCard(
      'Slider',
      'Material Slider thumb drag',
      'Slider uses TapAndHorizontalDrag so a tap on the track jumps '
          'the value and a drag scrubs it. Vertical motion is ignored.',
      Icons.tune,
      Colors.pink.shade400,
    ),
    buildRealWorldCard(
      'Swipe-to-dismiss list row',
      'Email/inbox list patterns',
      'Each row has its own TapAndHorizontalDrag. The list itself is '
          'a vertical scroller; the axis-lock keeps both working.',
      Icons.delete_sweep,
      Colors.deepOrange.shade400,
    ),
    buildRealWorldCard(
      'Horizontal carousel inside vertical scroll',
      'Streaming home pages, app stores',
      'A row of cards scrolls horizontally inside a column that '
          'scrolls vertically; this recognizer disambiguates at the '
          'card level.',
      Icons.view_carousel,
      Colors.orange.shade500,
    ),
    buildRealWorldCard(
      'Calendar day/week navigation',
      'Day strip swipe',
      'Swipe left/right to advance the day; vertical swipe scrolls '
          'the agenda. The recognizer makes the intent unambiguous.',
      Icons.calendar_view_week,
      Colors.amber.shade700,
    ),
  ];

  // ---------------------------------------------------------------
  // Section 9: Comparison panel (3 cards).
  // ---------------------------------------------------------------
  final Widget comparisonSection = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.pink.shade200, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Comparison: pick the right recognizer',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.pink.shade900,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Three recognizers occupy adjacent niches. Choose by tap '
          'requirement and axis sensitivity.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 14.0),
        buildComparisonCard(
          'TapAndDragGestureRecognizer',
          'tap + drag, any direction',
          'Use when both tap and free-direction drag matter on the same '
              'target (e.g. text-selection caret).',
          Colors.grey.shade600,
          false,
        ),
        const SizedBox(height: 10.0),
        buildComparisonCard(
          'TapAndHorizontalDragGestureRecognizer',
          'tap + horizontal-only drag',
          'This recognizer. Use when the target lives inside a vertical '
              'scroller and must coexist with it.',
          Colors.pink.shade500,
          true,
        ),
        const SizedBox(height: 10.0),
        buildComparisonCard(
          'HorizontalDragGestureRecognizer',
          'horizontal drag only (no tap)',
          'Use when there is no meaningful tap behaviour, only a drag '
              '(e.g. dedicated swipe gestures with a separate tap area).',
          Colors.deepOrange.shade400,
          false,
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------
  // Section 10: Caveats (5 cards).
  // ---------------------------------------------------------------
  final List<Widget> caveatCards = <Widget>[
    buildCaveatCard(
      'Angle threshold is implicit',
      'Flutter does not expose the exact tolerance; it depends on '
          'PointerEvent slop and pre-acceptedSlopTolerance. Don\'t hard-'
          'code expectations about a specific angle.',
      Icons.percent,
      Colors.pink.shade500,
    ),
    buildCaveatCard(
      'Arena ordering matters',
      'If multiple horizontal recognizers compete (e.g. nested swipe '
          'rows), the one that exceeds slop first usually wins. Use '
          'team-based recognizers if you need parent priority.',
      Icons.format_list_numbered,
      Colors.deepOrange.shade500,
    ),
    buildCaveatCard(
      'RTL still means horizontal',
      'Axis-lock is geometric, not directional. In RTL contexts the '
          'recognizer fires on the same horizontal axis; you must flip '
          'delta.dx semantics in your callbacks.',
      Icons.format_textdirection_r_to_l,
      Colors.orange.shade600,
    ),
    buildCaveatCard(
      'Kind filter applies pre-arena',
      'allowedDeviceKind / supportedDevices restrict pointer kinds. '
          'A trackpad pan event may not pass; use TapAndPan for those.',
      Icons.devices_other,
      Colors.amber.shade700,
    ),
    buildCaveatCard(
      'Two axis-locked recognizers can coexist',
      'A TapAndHorizontal + a VerticalDrag on the same widget will '
          'each claim their own axis without fighting; this is the '
          'intended composition pattern.',
      Icons.compare_arrows,
      Colors.red.shade400,
    ),
  ];

  // ---------------------------------------------------------------
  // Section 11: Footer (rose-accent takeaways).
  // ---------------------------------------------------------------
  final Widget footer = Container(
    margin: const EdgeInsets.only(top: 12.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Colors.pink.shade700,
          Colors.deepOrange.shade500,
        ],
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.pink.withValues(alpha: 0.35),
          blurRadius: 16.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.bookmark, size: 22.0, color: Colors.white),
            SizedBox(width: 8.0),
            Text(
              'Takeaways',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        buildTakeawayBullet(
          'Axis-lock is implemented as a direction gate after slop. '
          'Tap branch is unaffected.',
        ),
        buildTakeawayBullet(
          'Use this recognizer whenever the target sits inside a '
          'vertical scroller and must coexist with it.',
        ),
        buildTakeawayBullet(
          'Vertical motion is rejected, freeing the parent to take '
          'the gesture cleanly.',
        ),
        buildTakeawayBullet(
          'eagerVictoryOnDrag is more conservative here than on '
          'TapAndDrag because of the direction gate.',
        ),
        buildTakeawayBullet(
          'Slider, swipe-to-dismiss rows, horizontal carousels, and '
          'calendar day strips are the canonical use cases.',
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------
  // API surface (text-only, no instantiation).
  // ---------------------------------------------------------------
  final Widget apiSurface = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.code, size: 18.0, color: Colors.pink.shade200),
            const SizedBox(width: 8.0),
            Text(
              'API surface (read-only reference)',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade100,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        const SelectableText(
          'class TapAndHorizontalDragGestureRecognizer\n'
          '    extends TapAndDragGestureRecognizer {\n'
          '  TapAndHorizontalDragGestureRecognizer({super.debugOwner});\n'
          '\n'
          '  // Inherited from TapAndDragGestureRecognizer:\n'
          '  GestureTapDragDownCallback?   onTapDown;\n'
          '  GestureTapDragUpCallback?     onTapUp;\n'
          '  GestureCancelCallback?        onTapCancel;\n'
          '  GestureTapDragStartCallback?  onDragStart;\n'
          '  GestureTapDragUpdateCallback? onDragUpdate;\n'
          '  GestureTapDragEndCallback?    onDragEnd;\n'
          '  GestureCancelCallback?        onCancel;\n'
          '  bool eagerVictoryOnDrag;\n'
          '\n'
          '  // Override: only accepts predominantly horizontal motion.\n'
          '  @override\n'
          '  bool hasSufficientGlobalDistanceToAccept(...) =>\n'
          '      _globalDistanceMoved.abs() > computeHitSlop(...);\n'
          '}',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            height: 1.45,
            color: Color(0xFFE0E0E0),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'Note: TapDragDownDetails, TapDragUpDetails, '
          'TapDragStartDetails, TapDragUpdateDetails and TapDragEndDetails '
          'are all imported from package:flutter/gestures.dart.',
          style: TextStyle(
            fontSize: 10.5,
            color: Colors.pink.shade100,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  // Touch the gestures import so the analyzer keeps it alive.
  final Type recognizerType = TapAndHorizontalDragGestureRecognizer;
  final Widget importBadge = Padding(
    padding: const EdgeInsets.only(top: 6.0, bottom: 12.0),
    child: Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 6.0,
        ),
        decoration: BoxDecoration(
          color: Colors.pink.shade50,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.pink.shade200),
        ),
        child: Text(
          'imports flutter/gestures.dart -> $recognizerType',
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.pink.shade800,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    ),
  );

  // ---------------------------------------------------------------
  // Final assembly.
  // ---------------------------------------------------------------
  return Scaffold(
    backgroundColor: Colors.grey.shade100,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          heroHeader,
          const SizedBox(height: 20.0),
          buildSectionLabel('1. What the axis lock does'),
          lockCard,
          const SizedBox(height: 8.0),
          buildSectionLabel('2. Direction test diagram'),
          directionDiagram,
          const SizedBox(height: 8.0),
          buildSectionLabel('3. State machine (with direction gate)'),
          stateMachine,
          const SizedBox(height: 8.0),
          buildSectionLabel('4. Callback grid'),
          ...callbackCards,
          const SizedBox(height: 8.0),
          buildSectionLabel('5. Arena interaction'),
          arenaSection,
          const SizedBox(height: 8.0),
          buildSectionLabel('6. eagerVictoryOnDrag'),
          eagerVictorySection,
          const SizedBox(height: 8.0),
          buildSectionLabel('7. Real-world examples'),
          ...realWorldCards,
          const SizedBox(height: 8.0),
          buildSectionLabel('8. Comparison'),
          comparisonSection,
          const SizedBox(height: 8.0),
          buildSectionLabel('9. Caveats'),
          ...caveatCards,
          const SizedBox(height: 8.0),
          buildSectionLabel('10. API surface'),
          apiSurface,
          importBadge,
          footer,
          const SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}

// ===================================================================
// Top-level helper widgets and CustomPainter.
// Kept top-level (not closures) for readability and reuse across
// sections. Names are public-style (no leading underscore) per the
// authoring contract.
// ===================================================================

Widget buildSectionLabel(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
    child: Row(
      children: <Widget>[
        Container(
          width: 6.0,
          height: 26.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Colors.pink.shade600,
                Colors.deepOrange.shade400,
              ],
            ),
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        const SizedBox(width: 10.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 19.0,
            fontWeight: FontWeight.bold,
            color: Colors.pink.shade900,
          ),
        ),
      ],
    ),
  );
}

Widget buildVectorChip(
  String label,
  String angle,
  String verdict,
  MaterialColor color,
) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color.shade400, width: 1.2),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 22.0,
          height: 22.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.shade600,
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Text(
          angle,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            color: color.shade800,
          ),
        ),
        const SizedBox(width: 6.0),
        Text(
          '-> $verdict',
          style: TextStyle(
            fontSize: 11.5,
            color: color.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget buildPhaseRow(
  int index,
  String title,
  String body,
  IconData icon,
  Color color, {
  bool highlight = false,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: highlight ? color.withValues(alpha: 0.10) : Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: color.withValues(alpha: highlight ? 0.7 : 0.35),
        width: highlight ? 1.6 : 1.0,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 30.0,
          height: 30.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Text(
            '$index',
            style: const TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Icon(icon, color: color, size: 20.0),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade900,
                ),
              ),
              const SizedBox(height: 3.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
                  height: 1.4,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildCallbackCard(
  String name,
  String typeName,
  String description,
  String fields,
  IconData icon,
  Color color,
) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.3),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.08),
          blurRadius: 8.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 36.0,
              height: 36.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(icon, color: color, size: 20.0),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                      fontFamily: 'monospace',
                    ),
                  ),
                  Text(
                    '($typeName details)',
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.grey.shade600,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 12.5,
            height: 1.45,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 6.0,
          ),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'fields: $fields',
            style: TextStyle(
              fontSize: 11.0,
              color: color,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildArenaResolutionRow(
  String trigger,
  String winner,
  String reason,
  IconData icon,
  MaterialColor color,
) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.shade300, width: 1.1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 36.0,
          height: 36.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.shade100,
          ),
          child: Icon(icon, color: color.shade700, size: 18.0),
        ),
        const SizedBox(width: 10.0),
        SizedBox(
          width: 110.0,
          child: Text(
            trigger,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
              color: color.shade800,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                winner,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade900,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                reason,
                style: TextStyle(
                  fontSize: 11.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildEagerCard(
  bool flagValue,
  String title,
  String body,
  String guidance,
  MaterialColor color,
  IconData icon,
) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.shade300, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: color.shade700, size: 20.0),
            const SizedBox(width: 8.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.bold,
                color: color.shade900,
                fontFamily: 'monospace',
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: color.shade600,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                flagValue ? 'TRUE' : 'FALSE',
                style: const TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          body,
          style: TextStyle(
            fontSize: 12.5,
            height: 1.45,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'When to choose: $guidance',
          style: TextStyle(
            fontSize: 11.5,
            fontStyle: FontStyle.italic,
            color: color.shade800,
          ),
        ),
      ],
    ),
  );
}

Widget buildRealWorldCard(
  String headline,
  String subhead,
  String body,
  IconData icon,
  Color color,
) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Colors.white,
          color.withValues(alpha: 0.06),
        ],
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.35), width: 1.2),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 44.0,
          height: 44.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Icon(icon, color: color, size: 24.0),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                headline,
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                subhead,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.5,
                  height: 1.45,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildComparisonCard(
  String name,
  String tagline,
  String body,
  Color color,
  bool isThis,
) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: isThis ? color.withValues(alpha: 0.10) : Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: color.withValues(alpha: isThis ? 0.7 : 0.4),
        width: isThis ? 1.8 : 1.2,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            if (isThis)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 3.0,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Text(
                  'this demo',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          tagline,
          style: TextStyle(
            fontSize: 12.5,
            color: Colors.grey.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          body,
          style: TextStyle(
            fontSize: 12.5,
            height: 1.45,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    ),
  );
}

Widget buildCaveatCard(
  String title,
  String body,
  IconData icon,
  Color color,
) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.45), width: 1.2),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 32.0,
          height: 32.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withValues(alpha: 0.18),
          ),
          child: Icon(icon, color: color, size: 18.0),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
                  height: 1.45,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildTakeawayBullet(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Icon(Icons.check_circle, color: Colors.white, size: 16.0),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13.0,
              height: 1.45,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===================================================================
// Direction-test diagram painter.
//
// Draws a 320x220 stage with:
//   - axis cross-hairs through the touch-down origin (centre)
//   - the 45-degree diagonal boundary (faint, dashed)
//   - five labelled vectors A..E illustrating accept/reject results
//
// This is a pure CustomPainter; no animation, no state.
// ===================================================================

class DirectionTestPainter extends CustomPainter {
  const DirectionTestPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Offset origin = Offset(size.width / 2.0, size.height / 2.0);

    // Background panel.
    final Paint background = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final RRect panel = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(12.0),
    );
    canvas.drawRRect(panel, background);

    // Border.
    final Paint border = Paint()
      ..color = Colors.pink.shade200
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    canvas.drawRRect(panel, border);

    // Subtle grid.
    final Paint grid = Paint()
      ..color = Colors.pink.shade50
      ..strokeWidth = 1.0;
    for (double x = 20.0; x < size.width; x += 20.0) {
      canvas.drawLine(Offset(x, 0.0), Offset(x, size.height), grid);
    }
    for (double y = 20.0; y < size.height; y += 20.0) {
      canvas.drawLine(Offset(0.0, y), Offset(size.width, y), grid);
    }

    // Axis cross-hairs (horizontal axis emphasised).
    final Paint hAxis = Paint()
      ..color = Colors.pink.shade400
      ..strokeWidth = 2.0;
    final Paint vAxis = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1.0;
    canvas.drawLine(
      Offset(10.0, origin.dy),
      Offset(size.width - 10.0, origin.dy),
      hAxis,
    );
    canvas.drawLine(
      Offset(origin.dx, 10.0),
      Offset(origin.dx, size.height - 10.0),
      vAxis,
    );

    // 45-degree boundary lines (dashed-ish via short segments).
    final Paint boundary = Paint()
      ..color = Colors.amber.shade400
      ..strokeWidth = 1.2;
    drawDashedLine(
      canvas,
      origin,
      Offset(origin.dx + 100.0, origin.dy - 100.0),
      boundary,
    );
    drawDashedLine(
      canvas,
      origin,
      Offset(origin.dx + 100.0, origin.dy + 100.0),
      boundary,
    );
    drawDashedLine(
      canvas,
      origin,
      Offset(origin.dx - 100.0, origin.dy - 100.0),
      boundary,
    );
    drawDashedLine(
      canvas,
      origin,
      Offset(origin.dx - 100.0, origin.dy + 100.0),
      boundary,
    );

    // Origin marker.
    final Paint originDot = Paint()..color = Colors.grey.shade800;
    canvas.drawCircle(origin, 4.0, originDot);

    // Five vectors.
    drawVector(
      canvas,
      origin,
      const Offset(110.0, 0.0),
      'A',
      Colors.green,
      true,
    );
    drawVector(
      canvas,
      origin,
      const Offset(0.0, -90.0),
      'B',
      Colors.red,
      false,
    );
    drawVector(
      canvas,
      origin,
      const Offset(80.0, 80.0),
      'C',
      Colors.amber.shade700,
      false,
    );
    drawVector(
      canvas,
      origin,
      const Offset(110.0, -38.0),
      'D',
      Colors.green,
      true,
    );
    drawVector(
      canvas,
      origin,
      const Offset(38.0, -90.0),
      'E',
      Colors.red,
      false,
    );

    // Axis labels.
    drawTextAt(
      canvas,
      'x (accepted axis)',
      Offset(size.width - 110.0, origin.dy + 6.0),
      Colors.pink.shade700,
      11.0,
    );
    drawTextAt(
      canvas,
      'y (rejected)',
      Offset(origin.dx + 6.0, 8.0),
      Colors.grey.shade600,
      11.0,
    );
  }

  void drawDashedLine(
    Canvas canvas,
    Offset start,
    Offset end,
    Paint paint,
  ) {
    const double dashLength = 5.0;
    const double gapLength = 4.0;
    final double dx = end.dx - start.dx;
    final double dy = end.dy - start.dy;
    final double total = math.sqrt(dx * dx + dy * dy);
    final double stepCount = total / (dashLength + gapLength);
    final double ux = dx / total;
    final double uy = dy / total;
    for (int i = 0; i < stepCount.floor(); i++) {
      final double s = i * (dashLength + gapLength);
      final double e = s + dashLength;
      canvas.drawLine(
        Offset(start.dx + ux * s, start.dy + uy * s),
        Offset(start.dx + ux * e, start.dy + uy * e),
        paint,
      );
    }
  }

  void drawVector(
    Canvas canvas,
    Offset origin,
    Offset vector,
    String label,
    Color color,
    bool accepted,
  ) {
    final Offset tip = origin + vector;
    final Paint shaft = Paint()
      ..color = color
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(origin, tip, shaft);

    // Arrow head.
    final double angle = math.atan2(vector.dy, vector.dx);
    const double headLen = 9.0;
    const double headAngle = 0.45;
    final Offset h1 = Offset(
      tip.dx - headLen * math.cos(angle - headAngle),
      tip.dy - headLen * math.sin(angle - headAngle),
    );
    final Offset h2 = Offset(
      tip.dx - headLen * math.cos(angle + headAngle),
      tip.dy - headLen * math.sin(angle + headAngle),
    );
    canvas.drawLine(tip, h1, shaft);
    canvas.drawLine(tip, h2, shaft);

    // Label bubble at tip.
    final Paint bubble = Paint()
      ..color = accepted ? Colors.green.shade600 : Colors.red.shade500;
    final Offset bubbleCentre = tip + const Offset(8.0, -8.0);
    canvas.drawCircle(bubbleCentre, 9.0, bubble);
    drawTextAt(
      canvas,
      label,
      bubbleCentre + const Offset(-3.5, -5.5),
      Colors.white,
      11.0,
      bold: true,
    );
  }

  void drawTextAt(
    Canvas canvas,
    String text,
    Offset position,
    Color color,
    double size, {
    bool bold = false,
  }) {
    final TextPainter painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    painter.layout();
    painter.paint(canvas, position);
  }

  @override
  bool shouldRepaint(covariant DirectionTestPainter oldDelegate) => false;
}

// dart:math is imported with the `math.` prefix at the top of the file
// for the painter's sqrt / atan2 / cos / sin operations.
