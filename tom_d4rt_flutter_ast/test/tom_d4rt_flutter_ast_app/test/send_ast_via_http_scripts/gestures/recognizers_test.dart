// =============================================================================
//  GESTURE ARENA  --  See Who Wins the Touch
// =============================================================================
//
//  Theme        : Imagine a Roman amphitheatre at noon. Several recognizers
//                 enter the sand, each one a contender for the same stream of
//                 pointer events. The crowd watches. One by one some declare
//                 themselves unfit ("reject"), some declare themselves the
//                 only possible interpretation ("accept"), and exactly one
//                 walks out with the gesture stream in hand. This is the
//                 Flutter gesture arena, and the contenders rendered below
//                 are the recognizer classes from package:flutter/gestures.dart.
//
//  Subject      : The static surface of the most commonly used recognizers
//                 from `package:flutter/gestures.dart`:
//
//                   - TapGestureRecognizer
//                   - DoubleTapGestureRecognizer
//                   - LongPressGestureRecognizer
//                   - PanGestureRecognizer
//                   - HorizontalDragGestureRecognizer
//                   - VerticalDragGestureRecognizer
//                   - ScaleGestureRecognizer
//                   - MultiTapGestureRecognizer
//                   - ForcePressGestureRecognizer  (mention only)
//                   - EagerGestureRecognizer
//                   - SerialTapGestureRecognizer
//
//                 Plus the two consumers most engineers will touch first:
//                   - GestureDetector (convenience wrapper)
//                   - RawGestureDetector (custom recognizer factories)
//                       via GestureRecognizerFactoryWithHandlers<T>.
//
//  D4rt notes   : `build()` is invoked exactly ONCE under the d4rt smoke
//                 harness. The returned widget tree is rendered as a static
//                 snapshot. We therefore CANNOT rely on real pointer events,
//                 setState, timers, or animation tickers to mutate the
//                 displayed "event log" rows. Instead, every event-log strip
//                 is a precomputed snapshot, captioned as such, paired with
//                 a clearly-labelled "Try It Yourself" section near the end
//                 that contains live GestureDetector wiring so a human
//                 inspecting the rendered tree in a real Flutter window can
//                 still interact with it. No StatefulWidgets are constructed
//                 here; we instantiate recognizers in build() to exercise
//                 the constructor + property surface, set callbacks for
//                 shape, and immediately dispose them before returning the
//                 widget tree.
//
//  Audience     : Flutter engineers writing custom gesture handling, anyone
//                 weighing GestureDetector vs RawGestureDetector vs a custom
//                 recognizer subclass, and the curious reader of the Tom AI
//                 flutter ast harness who wants to see the arena drawn as a
//                 dusty Roman pit rather than a wall of chips.
//
//  Length goal  : 900+ lines so the file reads like a small field guide
//                 rather than a one-screen demo.
//
// -----------------------------------------------------------------------------
//  Palette (referenced throughout)
//
//    sandPale    #F2E6CB   the bright sand of the arena floor
//    sandDeep    #C7A267   sand in shadow under the stands
//    archStone   #8E7553   warm stone of the amphitheatre arches
//    archShadow  #5E4A33   deep shadow inside each arch
//    crowdTone   #B7A78A   the murmuring crowd seen from a distance
//    laurelDark  #2F5D3C   victor's laurel, deep green
//    laurelMid   #4F8F65   mid green of fresh leaves
//    bloodRust   #A6452E   the rusty red of a rejected contender's cloak
//    coinGold    #C99E45   gold awarded to the arena winner
//    inkDeep     #2A2118   the ink the historian uses
//    inkSoft     #5C4D3A   softer ink for sub-headings
//    parchment   #F8F1E0   parchment of the arena programme
//    chimeMint   #B6CFA8   the herald's banner colour
//    chimeRose   #E5B6BD   the loser's banner, faded
//    chimeSky    #A8C2DA   sky over the arena
//
// -----------------------------------------------------------------------------
//  Diagram (rendered later as a Stack of positioned chips):
//
//                    +------------------- ARENA ------------------+
//                    |                                            |
//   pointer down --> |  [Tap]   [DoubleTap]   [Pan]   [Scale]  ...|
//                    |   |           |          |        |        |
//                    |   v           v          v        v        |
//                    |  reject     accept    reject    reject     |
//                    |                                            |
//                    |     winner walks out with the stream       |
//                    +--------------------------------------------+
//
//  - eager wins early by self-declaring "I accept right now" on the first
//    pointer event;
//  - default recognizers wait for disambiguation (movement threshold,
//    timer expiry, lift-up);
//  - the LAST remaining contender wins by elimination even if it never
//    self-accepted.
//
// =============================================================================

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
//  Palette constants -- all const so the analyzer is happy.
// -----------------------------------------------------------------------------

const Color _sandPale = Color(0xFFF2E6CB);
const Color _sandDeep = Color(0xFFC7A267);
const Color _archStone = Color(0xFF8E7553);
const Color _archShadow = Color(0xFF5E4A33);
const Color _crowdTone = Color(0xFFB7A78A);
const Color _laurelDark = Color(0xFF2F5D3C);
const Color _laurelMid = Color(0xFF4F8F65);
const Color _bloodRust = Color(0xFFA6452E);
const Color _coinGold = Color(0xFFC99E45);
const Color _inkDeep = Color(0xFF2A2118);
const Color _inkSoft = Color(0xFF5C4D3A);
const Color _parchment = Color(0xFFF8F1E0);
const Color _chimeMint = Color(0xFFB6CFA8);
const Color _chimeRose = Color(0xFFE5B6BD);
const Color _chimeSky = Color(0xFFA8C2DA);

// -----------------------------------------------------------------------------
//  build(BuildContext) -- the single entry point invoked by the d4rt harness.
// -----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  debugPrint('GestureArena deep demo: build() invoked');

  // ---------------------------------------------------------------------------
  // PROBE PHASE: instantiate each recognizer once, exercise its callback
  // surface, then dispose. This proves the constructor and property surface
  // is reachable under the d4rt interpreter without leaking recognizers into
  // the rendered widget tree.
  // ---------------------------------------------------------------------------

  _probeTapRecognizer();
  _probeDoubleTapRecognizer();
  _probeLongPressRecognizer();
  _probePanRecognizer();
  _probeHorizontalDragRecognizer();
  _probeVerticalDragRecognizer();
  _probeScaleRecognizer();
  _probeMultiTapRecognizer();
  _probeEagerRecognizer();
  _probeSerialTapRecognizer();

  debugPrint('GestureArena deep demo: probes complete');

  // ---------------------------------------------------------------------------
  // SECTION 1: Hero header
  // ---------------------------------------------------------------------------

  final Widget heroHeader = Container(
    margin: const EdgeInsets.only(bottom: 24.0),
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_archShadow, _archStone, _sandDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _inkDeep.withValues(alpha: 0.25),
          blurRadius: 12.0,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.sports_kabaddi, size: 48.0, color: _parchment),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Gesture Arena',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: _parchment,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'See who wins the touch.',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontStyle: FontStyle.italic,
                      color: _parchment.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: _parchment.withValues(alpha: 0.92),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Text(
            'Every pointer that touches the screen enters an arena where '
            'one or more recognizers compete to interpret it. The recognizer '
            'that first declares itself the only valid interpretation wins '
            'the gesture stream; the others are notified that the stream is '
            'no longer theirs to handle. GestureDetector is a thin convenience '
            'wrapper that wires a fixed set of recognizers for you. When you '
            'need a recognizer GestureDetector does not expose, drop down to '
            'RawGestureDetector and supply your own GestureRecognizerFactory.',
            style: TextStyle(
              fontSize: 13.0,
              height: 1.45,
              color: _inkDeep,
            ),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 2: Static demos for tap, double-tap, long-press.
  // Each card includes a coloured target zone and a precomputed event-log
  // strip below; the captions explain that the log is illustrative.
  // ---------------------------------------------------------------------------

  final Widget tapDemoCard = _buildStaticDemoCard(
    title: 'Tap',
    icon: Icons.touch_app,
    accent: _laurelMid,
    targetLabel: 'TAP HERE',
    caption: 'A single, decisive contact. The recognizer accepts when the '
        'pointer is released within the tap-slop radius before the long-press '
        'timeout fires.',
    exampleEvents: const <_EventEntry>[
      _EventEntry('onTapDown', '(120, 88)', _chimeSky),
      _EventEntry('onTapUp', '(121, 89)', _laurelMid),
      _EventEntry('onTap', 'fired', _coinGold),
    ],
    callbackHints: const <String>[
      'onTapDown(TapDownDetails)',
      'onTapUp(TapUpDetails)',
      'onTap()',
      'onTapCancel()',
      'onSecondaryTap()',
      'onTertiaryTapDown()',
    ],
  );

  final Widget doubleTapDemoCard = _buildStaticDemoCard(
    title: 'Double Tap',
    icon: Icons.touch_app_outlined,
    accent: _chimeSky,
    targetLabel: 'TAP TWICE',
    caption: 'Two taps in the same place within kDoubleTapTimeout (300ms by '
        'default). The recognizer holds a brief timer between the first and '
        'second tap to disambiguate from a plain tap.',
    exampleEvents: const <_EventEntry>[
      _EventEntry('onTapDown #1', '(64, 64)', _chimeSky),
      _EventEntry('release', 'within slop', _laurelMid),
      _EventEntry('onTapDown #2', '(65, 63)', _chimeSky),
      _EventEntry('onDoubleTap', 'fired', _coinGold),
    ],
    callbackHints: const <String>[
      'onDoubleTapDown(TapDownDetails)',
      'onDoubleTap()',
      'onDoubleTapCancel()',
    ],
  );

  final Widget longPressDemoCard = _buildStaticDemoCard(
    title: 'Long Press',
    icon: Icons.pan_tool_alt,
    accent: _bloodRust,
    targetLabel: 'HOLD',
    caption: 'A single contact held without movement for kLongPressTimeout '
        '(500ms). Once accepted, you can also observe drag-after-press '
        'updates via onLongPressMoveUpdate.',
    exampleEvents: const <_EventEntry>[
      _EventEntry('onLongPressDown', '(48, 48)', _chimeSky),
      _EventEntry('timer 500ms', 'elapsed', _bloodRust),
      _EventEntry('onLongPressStart', '(48, 48)', _bloodRust),
      _EventEntry('onLongPressMoveUpdate', 'dx=2 dy=1', _coinGold),
      _EventEntry('onLongPressEnd', 'release', _laurelMid),
    ],
    callbackHints: const <String>[
      'onLongPressDown(LongPressDownDetails)',
      'onLongPressStart(LongPressStartDetails)',
      'onLongPress()',
      'onLongPressMoveUpdate(LongPressMoveUpdateDetails)',
      'onLongPressEnd(LongPressEndDetails)',
      'onLongPressCancel()',
    ],
  );

  // ---------------------------------------------------------------------------
  // SECTION 3: PanGestureRecognizer demo.
  // A 280x180 dotted area with a coloured dot positioned mid-path and a
  // dashed "path" rendered as a row of tiny chips to imply animation.
  // ---------------------------------------------------------------------------

  const double panAreaWidth = 280.0;
  const double panAreaHeight = 180.0;
  const Offset panDotOffset = Offset(140.0, 96.0);

  final Widget panPathTrail = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      for (int i = 0; i < 7; i += 1)
        Container(
          width: 10.0,
          height: 10.0,
          margin: const EdgeInsets.symmetric(horizontal: 3.0),
          decoration: BoxDecoration(
            color: _coinGold.withValues(alpha: 0.3 + i * 0.08),
            shape: BoxShape.circle,
          ),
        ),
    ],
  );

  final Widget panDemo = Container(
    margin: const EdgeInsets.only(bottom: 24.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _parchment,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _archStone, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.open_with, color: _archStone, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'PanGestureRecognizer',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: _inkDeep,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          'A two-dimensional drag with no constraint on the axis. The '
          'recognizer waits for the pointer to travel kTouchSlop before '
          'accepting the gesture; the dot below shows where the dragging '
          'finger would currently be on an illustrative path.',
          style: TextStyle(fontSize: 12.0, height: 1.4, color: _inkSoft),
        ),
        const SizedBox(height: 12.0),
        Center(
          child: Container(
            width: panAreaWidth,
            height: panAreaHeight,
            decoration: BoxDecoration(
              color: _sandPale,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: _sandDeep, width: 1.5),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: panDotOffset.dx - 14.0,
                  top: panDotOffset.dy - 14.0,
                  child: Container(
                    width: 28.0,
                    height: 28.0,
                    decoration: BoxDecoration(
                      gradient: const RadialGradient(
                        colors: <Color>[_coinGold, _bloodRust],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: _bloodRust.withValues(alpha: 0.35),
                          blurRadius: 6.0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 8.0,
                  bottom: 8.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: _inkDeep.withValues(alpha: 0.75),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      'offset: (${panDotOffset.dx.toStringAsFixed(0)}, '
                      '${panDotOffset.dy.toStringAsFixed(0)})',
                      style: const TextStyle(
                        fontSize: 11.0,
                        fontFamily: 'monospace',
                        color: _parchment,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        panPathTrail,
        const SizedBox(height: 8.0),
        const Center(
          child: Text(
            'illustrative path -- no real pointer is active',
            style: TextStyle(
              fontSize: 10.5,
              fontStyle: FontStyle.italic,
              color: _inkSoft,
            ),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 4: ScaleGestureRecognizer demo with paired slider snapshot.
  // ---------------------------------------------------------------------------

  const double scaleValue = 1.45;
  final Widget scaleDemo = Container(
    margin: const EdgeInsets.only(bottom: 24.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _parchment,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _archStone, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.zoom_out_map, color: _archStone, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'ScaleGestureRecognizer',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: _inkDeep,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Two or more pointers move together. The recognizer tracks the '
          'focal point, the scale factor relative to the initial distance, '
          'and the rotation in radians. The square below is rendered at '
          'scale=1.45 to show what a 45% zoom-in would look like.',
          style: TextStyle(fontSize: 12.0, height: 1.4, color: _inkSoft),
        ),
        const SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                color: _sandPale,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: _sandDeep, width: 1.0),
              ),
              child: const Center(
                child: Text(
                  '1.00x',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _inkDeep,
                  ),
                ),
              ),
            ),
            const Icon(Icons.arrow_forward, color: _archStone),
            Container(
              width: 80.0 * scaleValue,
              height: 80.0 * scaleValue,
              decoration: BoxDecoration(
                color: _coinGold.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: _bloodRust, width: 1.5),
              ),
              child: Center(
                child: Text(
                  '${scaleValue.toStringAsFixed(2)}x',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _inkDeep,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        // Slider snapshot -- a static bar with a knob positioned where the
        // gesture-driven value would be.
        Stack(
          children: <Widget>[
            Container(
              height: 8.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: _crowdTone.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            Positioned(
              left: (scaleValue - 0.5) / 2.5 * 260.0,
              top: 0.0,
              child: Container(
                width: 22.0,
                height: 22.0,
                decoration: BoxDecoration(
                  color: _coinGold,
                  shape: BoxShape.circle,
                  border: Border.all(color: _bloodRust, width: 1.5),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        const Text(
          'A linked slider would drive the same scale value programmatically.',
          style: TextStyle(
            fontSize: 10.5,
            fontStyle: FontStyle.italic,
            color: _inkSoft,
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 5: HorizontalDrag vs VerticalDrag, side-by-side.
  // ---------------------------------------------------------------------------

  final Widget hvDragRow = Container(
    margin: const EdgeInsets.only(bottom: 24.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _buildAxisDragCard(
            title: 'HorizontalDrag',
            icon: Icons.swap_horiz,
            arrowIcon: Icons.east,
            accent: _laurelMid,
            description:
                'Drags along the x-axis only. Wins arena against vertical '
                'siblings as soon as kTouchSlop is exceeded horizontally.',
            callbackHints: const <String>[
              'onDown(DragDownDetails)',
              'onStart(DragStartDetails)',
              'onUpdate(DragUpdateDetails)',
              'onEnd(DragEndDetails)',
              'onCancel()',
            ],
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: _buildAxisDragCard(
            title: 'VerticalDrag',
            icon: Icons.swap_vert,
            arrowIcon: Icons.south,
            accent: _chimeSky,
            description:
                'Drags along the y-axis only. Useful inside a horizontally '
                'scrolling parent so that vertical drags can escape upward.',
            callbackHints: const <String>[
              'onDown(DragDownDetails)',
              'onStart(DragStartDetails)',
              'onUpdate(DragUpdateDetails)',
              'onEnd(DragEndDetails)',
              'onCancel()',
            ],
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 6: MultiTapGestureRecognizer.
  // ---------------------------------------------------------------------------

  final Widget multiTapDemo = Container(
    margin: const EdgeInsets.only(bottom: 24.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _parchment,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _archStone, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.fingerprint, color: _archStone, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'MultiTapGestureRecognizer',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: _inkDeep,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Tracks each finger independently with a per-pointer tap timeout. '
          'Each pointer down/up pair fires its own onTapDown/onTapUp; the '
          'recognizer can dispatch many simultaneous tap events from a '
          'single gesture.',
          style: TextStyle(fontSize: 12.0, height: 1.4, color: _inkSoft),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: <Widget>[
            for (int n = 1; n <= 5; n += 1) _buildFingerCountChip(n),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _chimeMint.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'Tip: use MultiTapGestureRecognizer when each finger should '
            'produce an independent event (e.g. a music keyboard). For a '
            'count-based "tap N fingers" gesture, supply a custom recognizer '
            'subclass instead.',
            style: TextStyle(fontSize: 11.5, color: _inkDeep, height: 1.4),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 7: SerialTapGestureRecognizer.
  // ---------------------------------------------------------------------------

  final Widget serialTapDemo = Container(
    margin: const EdgeInsets.only(bottom: 24.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _parchment,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _archStone, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.repeat, color: _archStone, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'SerialTapGestureRecognizer',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: _inkDeep,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          'A counter-based recognizer: each successive tap within the timeout '
          'increments the count, letting you distinguish single, double, '
          'triple, and quadruple tap explicitly. Each tap fires onSerialTapUp '
          'with the running count.',
          style: TextStyle(fontSize: 12.0, height: 1.4, color: _inkSoft),
        ),
        const SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            for (int count = 1; count <= 4; count += 1)
              _buildSerialTapStep(count),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Each step shows the cumulative count delivered to onSerialTapUp.',
          style: TextStyle(
            fontSize: 10.5,
            fontStyle: FontStyle.italic,
            color: _inkSoft,
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 8: EagerGestureRecognizer
  // ---------------------------------------------------------------------------

  final Widget eagerDemo = Container(
    margin: const EdgeInsets.only(bottom: 24.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _parchment,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _bloodRust, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.bolt, color: _bloodRust, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'EagerGestureRecognizer',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: _inkDeep,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          'A recognizer that claims the gesture arena on the very first '
          'pointer event. It does not interpret the gesture; it simply '
          'prevents any ancestor recognizer (such as a parent scroll view) '
          'from claiming the pointer. Use it sparingly: it disables sibling '
          'and ancestor gesture handling for the affected pointer.',
          style: TextStyle(fontSize: 12.0, height: 1.4, color: _inkSoft),
        ),
        const SizedBox(height: 12.0),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: _crowdTone.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'DEFAULT',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: _inkDeep,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Recognizer waits for disambiguation: slop threshold, '
                      'timeout, or sibling rejection.',
                      style: TextStyle(fontSize: 11.0, color: _inkSoft),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: _bloodRust.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'EAGER',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: _inkDeep,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Recognizer self-accepts on the first pointer event, '
                      'cutting all competition out of the arena instantly.',
                      style: TextStyle(fontSize: 11.0, color: _inkSoft),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 9: RawGestureDetector with a custom factory.
  // ---------------------------------------------------------------------------

  final Map<Type, GestureRecognizerFactory<GestureRecognizer>> customFactories =
      <Type, GestureRecognizerFactory<GestureRecognizer>>{
    TapGestureRecognizer:
        GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
      () => TapGestureRecognizer(),
      (TapGestureRecognizer instance) {
        instance.onTap = () {
          debugPrint('RawGestureDetector: custom tap factory fired');
        };
        instance.onTapDown = (TapDownDetails details) {
          debugPrint(
            'RawGestureDetector: tapDown at ${details.globalPosition}',
          );
        };
      },
    ),
  };

  final Widget rawDetectorDemo = Container(
    margin: const EdgeInsets.only(bottom: 24.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _parchment,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _archStone, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.handyman, color: _archStone, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'RawGestureDetector + Factory',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: _inkDeep,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          'When GestureDetector does not expose a recognizer you need (e.g. '
          'EagerGestureRecognizer, SerialTapGestureRecognizer, a custom '
          'subclass), drop down to RawGestureDetector and supply a map of '
          'GestureRecognizerFactory<T> -- typically '
          'GestureRecognizerFactoryWithHandlers<T> -- keyed by recognizer '
          'type. The framework will instantiate, configure, and dispose '
          'each recognizer for you.',
          style: TextStyle(fontSize: 12.0, height: 1.4, color: _inkSoft),
        ),
        const SizedBox(height: 12.0),
        Center(
          child: RawGestureDetector(
            gestures: customFactories,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 240.0,
              height: 80.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    _coinGold.withValues(alpha: 0.85),
                    _bloodRust.withValues(alpha: 0.85),
                  ],
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Center(
                child: Text(
                  'Tap this RawGestureDetector',
                  style: TextStyle(
                    color: _parchment,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _inkDeep.withValues(alpha: 0.92),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            "gestures: <Type, GestureRecognizerFactory>{\n"
            "  TapGestureRecognizer:\n"
            "      GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(\n"
            "    () => TapGestureRecognizer(),\n"
            "    (TapGestureRecognizer instance) {\n"
            "      instance.onTap = () => debugPrint('tap');\n"
            "    },\n"
            "  ),\n"
            "}",
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: _chimeMint,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 10: Arena visualization diagram.
  // ---------------------------------------------------------------------------

  final Widget arenaDiagram = Container(
    margin: const EdgeInsets.only(bottom: 24.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[_sandPale, _sandDeep.withValues(alpha: 0.5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _archStone, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.account_balance, color: _archShadow, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'How the Arena Resolves Conflicts',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: _inkDeep,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          'A single pointer event enters the arena and every recognizer in '
          'the same hit-test path becomes a contender. Each contender can '
          'self-reject (give up), self-accept (claim the stream), or wait. '
          'The first to self-accept wins immediately and notifies the '
          'others. If no one self-accepts before all but one have rejected, '
          'the last survivor wins by elimination.',
          style: TextStyle(fontSize: 12.0, height: 1.4, color: _inkSoft),
        ),
        const SizedBox(height: 14.0),
        SizedBox(
          height: 220.0,
          child: Stack(
            children: <Widget>[
              // Outer arena ring
              Positioned.fill(
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: _sandPale,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: _archShadow, width: 2.0),
                  ),
                ),
              ),
              // Contestant chips around the ring
              const Positioned(
                left: 20.0,
                top: 22.0,
                child: _ArenaChip(
                  label: 'Tap',
                  status: _ArenaStatus.rejected,
                ),
              ),
              const Positioned(
                left: 110.0,
                top: 22.0,
                child: _ArenaChip(
                  label: 'DoubleTap',
                  status: _ArenaStatus.waiting,
                ),
              ),
              const Positioned(
                right: 20.0,
                top: 22.0,
                child: _ArenaChip(
                  label: 'Pan',
                  status: _ArenaStatus.winner,
                ),
              ),
              const Positioned(
                left: 20.0,
                bottom: 22.0,
                child: _ArenaChip(
                  label: 'LongPress',
                  status: _ArenaStatus.rejected,
                ),
              ),
              const Positioned(
                left: 110.0,
                bottom: 22.0,
                child: _ArenaChip(
                  label: 'Scale',
                  status: _ArenaStatus.rejected,
                ),
              ),
              const Positioned(
                right: 20.0,
                bottom: 22.0,
                child: _ArenaChip(
                  label: 'Eager',
                  status: _ArenaStatus.waiting,
                ),
              ),
              // Middle banner
              Positioned(
                left: 0.0,
                right: 0.0,
                top: 90.0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: _coinGold,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: _archShadow, width: 1.5),
                    ),
                    child: const Text(
                      'WINNER: Pan',
                      style: TextStyle(
                        color: _inkDeep,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            _buildLegendDot(_laurelMid, 'winner'),
            const SizedBox(width: 12.0),
            _buildLegendDot(_chimeSky, 'waiting'),
            const SizedBox(width: 12.0),
            _buildLegendDot(_bloodRust, 'rejected'),
            const SizedBox(width: 12.0),
            _buildLegendDot(_chimeRose, 'tied / late'),
          ],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 11: Cheat-sheet card.
  // ---------------------------------------------------------------------------

  final Widget cheatSheet = Container(
    margin: const EdgeInsets.only(bottom: 24.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _inkDeep,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.menu_book, color: _coinGold, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Recognizer Cheat-Sheet',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: _parchment,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _buildCheatRow(
          'TapGestureRecognizer',
          'onTap / onTapDown / onTapUp / onTapCancel',
          'Single quick contact; the default for buttons.',
        ),
        _buildCheatRow(
          'DoubleTapGestureRecognizer',
          'onDoubleTap / onDoubleTapDown / onDoubleTapCancel',
          'Two taps within kDoubleTapTimeout.',
        ),
        _buildCheatRow(
          'LongPressGestureRecognizer',
          'onLongPress / onLongPressStart / onLongPressMoveUpdate / '
              'onLongPressEnd',
          'Hold without movement for ~500ms; supports drag-after-press.',
        ),
        _buildCheatRow(
          'PanGestureRecognizer',
          'onDown / onStart / onUpdate / onEnd / onCancel',
          'Free 2D drag, no axis constraint.',
        ),
        _buildCheatRow(
          'HorizontalDragGestureRecognizer',
          'same as Pan, x-axis only',
          'Wins arena once kTouchSlop is crossed horizontally.',
        ),
        _buildCheatRow(
          'VerticalDragGestureRecognizer',
          'same as Pan, y-axis only',
          'Use inside horizontal scrollers to escape upward.',
        ),
        _buildCheatRow(
          'ScaleGestureRecognizer',
          'onStart / onUpdate(ScaleUpdateDetails) / onEnd',
          'Two-finger pinch + rotation tracking.',
        ),
        _buildCheatRow(
          'MultiTapGestureRecognizer',
          'onTapDown(pointer) / onTapUp(pointer)',
          'Each finger fires its own tap independently.',
        ),
        _buildCheatRow(
          'ForcePressGestureRecognizer',
          'onStart / onPeak / onUpdate / onEnd',
          '3D-touch pressure; supported only on devices that report it.',
        ),
        _buildCheatRow(
          'EagerGestureRecognizer',
          '(no callbacks)',
          'Self-accepts immediately; blocks ancestor recognizers.',
        ),
        _buildCheatRow(
          'SerialTapGestureRecognizer',
          'onSerialTapDown / onSerialTapUp / onSerialTapCancel',
          'Counter-based; distinguishes 1st, 2nd, 3rd, ... taps explicitly.',
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 12: Interactive "Try It Yourself" block (clearly labelled).
  // This is the genuinely interactive part. Logs start empty.
  // ---------------------------------------------------------------------------

  final Widget tryItYourself = Container(
    margin: const EdgeInsets.only(bottom: 24.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _chimeMint.withValues(alpha: 0.35),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _laurelDark, width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.handshake, color: _laurelDark, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Try It Yourself',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: _inkDeep,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          'The widgets below are wired with real GestureDetectors. The event '
          'logs would update if this script were run inside a live Flutter '
          'window with a pointer device; under the static d4rt snapshot '
          'harness they render empty.',
          style: TextStyle(fontSize: 12.0, height: 1.4, color: _inkSoft),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            _buildLiveDetector(
              label: 'Tap',
              icon: Icons.touch_app,
              detector: GestureDetector(
                onTap: () {
                  debugPrint('live: onTap');
                },
                onTapDown: (TapDownDetails details) {
                  debugPrint('live: onTapDown ${details.globalPosition}');
                },
                onTapUp: (TapUpDetails details) {
                  debugPrint('live: onTapUp ${details.globalPosition}');
                },
                onTapCancel: () {
                  debugPrint('live: onTapCancel');
                },
                child: _buildLiveTarget(_laurelMid, 'TAP'),
              ),
            ),
            _buildLiveDetector(
              label: 'Double Tap',
              icon: Icons.touch_app_outlined,
              detector: GestureDetector(
                onDoubleTap: () {
                  debugPrint('live: onDoubleTap');
                },
                onDoubleTapDown: (TapDownDetails details) {
                  debugPrint('live: onDoubleTapDown ${details.globalPosition}');
                },
                onDoubleTapCancel: () {
                  debugPrint('live: onDoubleTapCancel');
                },
                child: _buildLiveTarget(_chimeSky, 'DOUBLE TAP'),
              ),
            ),
            _buildLiveDetector(
              label: 'Long Press',
              icon: Icons.pan_tool_alt,
              detector: GestureDetector(
                onLongPress: () {
                  debugPrint('live: onLongPress');
                },
                onLongPressStart: (LongPressStartDetails details) {
                  debugPrint(
                    'live: onLongPressStart ${details.globalPosition}',
                  );
                },
                onLongPressMoveUpdate: (LongPressMoveUpdateDetails details) {
                  debugPrint(
                    'live: onLongPressMoveUpdate ${details.localPosition}',
                  );
                },
                onLongPressEnd: (LongPressEndDetails details) {
                  debugPrint('live: onLongPressEnd ${details.globalPosition}');
                },
                child: _buildLiveTarget(_bloodRust, 'HOLD'),
              ),
            ),
            _buildLiveDetector(
              label: 'Pan',
              icon: Icons.open_with,
              detector: GestureDetector(
                onPanDown: (DragDownDetails details) {
                  debugPrint('live: onPanDown ${details.globalPosition}');
                },
                onPanStart: (DragStartDetails details) {
                  debugPrint('live: onPanStart ${details.globalPosition}');
                },
                onPanUpdate: (DragUpdateDetails details) {
                  debugPrint('live: onPanUpdate ${details.delta}');
                },
                onPanEnd: (DragEndDetails details) {
                  debugPrint('live: onPanEnd ${details.velocity}');
                },
                onPanCancel: () {
                  debugPrint('live: onPanCancel');
                },
                child: _buildLiveTarget(_coinGold, 'DRAG'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _parchment.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'event log: (no live pointer events captured under d4rt snapshot)',
            style: TextStyle(
              fontSize: 11.5,
              fontStyle: FontStyle.italic,
              color: _inkSoft,
            ),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // Final assembly
  // ---------------------------------------------------------------------------

  debugPrint('GestureArena deep demo: assembling root tree');

  return Scaffold(
    backgroundColor: _crowdTone.withValues(alpha: 0.25),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            heroHeader,
            // -----------------------------------------------------------------
            // SECTION 2: Static demos -- tap, double-tap, long-press.
            // -----------------------------------------------------------------
            const _SectionHeader(
              index: 2,
              title: 'Tap, Double-Tap, Long-Press',
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Three recognizers that share an interest in single contacts '
              'but disambiguate by timing and movement. Each card below shows '
              'a target zone, a precomputed example event log, and a list of '
              'the callbacks that recognizer exposes.',
              style: TextStyle(fontSize: 13.0, height: 1.45, color: _inkSoft),
            ),
            const SizedBox(height: 12.0),
            tapDemoCard,
            doubleTapDemoCard,
            longPressDemoCard,
            // -----------------------------------------------------------------
            // SECTION 3: Pan.
            // -----------------------------------------------------------------
            const _SectionHeader(index: 3, title: 'Pan'),
            const SizedBox(height: 10.0),
            const Text(
              'A free two-dimensional drag with no axis constraint. The '
              'illustrative dot sits mid-path to suggest motion.',
              style: TextStyle(fontSize: 13.0, height: 1.45, color: _inkSoft),
            ),
            const SizedBox(height: 12.0),
            panDemo,
            // -----------------------------------------------------------------
            // SECTION 4: Scale.
            // -----------------------------------------------------------------
            const _SectionHeader(index: 4, title: 'Scale'),
            const SizedBox(height: 10.0),
            const Text(
              'Two-finger pinch and rotate. The scale value can also be '
              'driven programmatically from a slider to show what the '
              'gesture would produce.',
              style: TextStyle(fontSize: 13.0, height: 1.45, color: _inkSoft),
            ),
            const SizedBox(height: 12.0),
            scaleDemo,
            // -----------------------------------------------------------------
            // SECTION 5: Axis drags.
            // -----------------------------------------------------------------
            const _SectionHeader(
              index: 5,
              title: 'Horizontal vs Vertical Drag',
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Axis-constrained drags. Useful for nested scroll situations '
              'where you want a child to claim one axis while the parent '
              'keeps the other.',
              style: TextStyle(fontSize: 13.0, height: 1.45, color: _inkSoft),
            ),
            const SizedBox(height: 12.0),
            hvDragRow,
            // -----------------------------------------------------------------
            // SECTION 6: MultiTap.
            // -----------------------------------------------------------------
            const _SectionHeader(index: 6, title: 'MultiTap'),
            const SizedBox(height: 10.0),
            const Text(
              'Each finger is tracked as an independent tap. The chips below '
              'illustrate the number of simultaneous fingers and the '
              'callbacks that would fire for each.',
              style: TextStyle(fontSize: 13.0, height: 1.45, color: _inkSoft),
            ),
            const SizedBox(height: 12.0),
            multiTapDemo,
            // -----------------------------------------------------------------
            // SECTION 7: SerialTap.
            // -----------------------------------------------------------------
            const _SectionHeader(index: 7, title: 'SerialTap'),
            const SizedBox(height: 10.0),
            const Text(
              'A counter-based recognizer that distinguishes 1st, 2nd, 3rd, '
              'and 4th taps explicitly, rather than collapsing everything '
              'into a single "double-tap" event.',
              style: TextStyle(fontSize: 13.0, height: 1.45, color: _inkSoft),
            ),
            const SizedBox(height: 12.0),
            serialTapDemo,
            // -----------------------------------------------------------------
            // SECTION 8: EagerGestureRecognizer.
            // -----------------------------------------------------------------
            const _SectionHeader(index: 8, title: 'EagerGestureRecognizer'),
            const SizedBox(height: 10.0),
            const Text(
              'A specialist tool for shutting down ancestor gesture handling '
              'on a particular pointer. Use only when nothing else solves '
              'the conflict.',
              style: TextStyle(fontSize: 13.0, height: 1.45, color: _inkSoft),
            ),
            const SizedBox(height: 12.0),
            eagerDemo,
            // -----------------------------------------------------------------
            // SECTION 9: RawGestureDetector.
            // -----------------------------------------------------------------
            const _SectionHeader(
              index: 9,
              title: 'RawGestureDetector + Custom Factory',
            ),
            const SizedBox(height: 10.0),
            const Text(
              'When you need recognizers that GestureDetector does not '
              'expose, or recognizer instances with custom configuration, '
              'use RawGestureDetector and supply a map of factories.',
              style: TextStyle(fontSize: 13.0, height: 1.45, color: _inkSoft),
            ),
            const SizedBox(height: 12.0),
            rawDetectorDemo,
            // -----------------------------------------------------------------
            // SECTION 10: Arena diagram.
            // -----------------------------------------------------------------
            const _SectionHeader(index: 10, title: 'Arena Resolution'),
            const SizedBox(height: 10.0),
            const Text(
              'A schematic of the gesture arena resolving a single pointer '
              'event among six contenders.',
              style: TextStyle(fontSize: 13.0, height: 1.45, color: _inkSoft),
            ),
            const SizedBox(height: 12.0),
            arenaDiagram,
            // -----------------------------------------------------------------
            // SECTION 11: Cheat-sheet.
            // -----------------------------------------------------------------
            const _SectionHeader(index: 11, title: 'Cheat-Sheet'),
            const SizedBox(height: 10.0),
            const Text(
              'One row per recognizer: name, callbacks, typical use.',
              style: TextStyle(fontSize: 13.0, height: 1.45, color: _inkSoft),
            ),
            const SizedBox(height: 12.0),
            cheatSheet,
            // -----------------------------------------------------------------
            // SECTION 12: Try It Yourself (interactive).
            // -----------------------------------------------------------------
            const _SectionHeader(
              index: 12,
              title: 'Try It Yourself (Interactive)',
            ),
            const SizedBox(height: 10.0),
            const Text(
              'The only block of widgets in this file that actually responds '
              'to pointer input. Logs would populate live in a real Flutter '
              'window; they are empty under the d4rt static snapshot.',
              style: TextStyle(fontSize: 13.0, height: 1.45, color: _inkSoft),
            ),
            const SizedBox(height: 12.0),
            tryItYourself,
            // -----------------------------------------------------------------
            // Footer.
            // -----------------------------------------------------------------
            Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: _inkDeep,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.flag, color: _coinGold, size: 20.0),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      'End of the field guide. Pick a recognizer, drop it '
                      'into a RawGestureDetector, and let the arena do the '
                      'rest.',
                      style: TextStyle(
                        fontSize: 12.0,
                        height: 1.45,
                        color: _parchment.withValues(alpha: 0.92),
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

// =============================================================================
//  Probes -- create each recognizer, wire shape callbacks, dispose.
// =============================================================================

void _probeTapRecognizer() {
  debugPrint('probe: TapGestureRecognizer');
  final TapGestureRecognizer tap = TapGestureRecognizer();
  tap.onTapDown = (TapDownDetails details) {
    debugPrint('  tap onTapDown ${details.globalPosition}');
  };
  tap.onTapUp = (TapUpDetails details) {
    debugPrint('  tap onTapUp ${details.globalPosition}');
  };
  tap.onTap = () {
    debugPrint('  tap fired');
  };
  tap.onTapCancel = () {
    debugPrint('  tap cancelled');
  };
  debugPrint('  runtimeType=${tap.runtimeType}');
  debugPrint('  debugDescription=${tap.debugDescription}');
  tap.dispose();
}

void _probeDoubleTapRecognizer() {
  debugPrint('probe: DoubleTapGestureRecognizer');
  final DoubleTapGestureRecognizer dt = DoubleTapGestureRecognizer();
  dt.onDoubleTapDown = (TapDownDetails details) {
    debugPrint('  dt onDoubleTapDown ${details.globalPosition}');
  };
  dt.onDoubleTap = () {
    debugPrint('  dt fired');
  };
  dt.onDoubleTapCancel = () {
    debugPrint('  dt cancelled');
  };
  debugPrint('  runtimeType=${dt.runtimeType}');
  dt.dispose();
}

void _probeLongPressRecognizer() {
  debugPrint('probe: LongPressGestureRecognizer');
  final LongPressGestureRecognizer lp = LongPressGestureRecognizer();
  lp.onLongPressDown = (LongPressDownDetails details) {
    debugPrint('  lp onLongPressDown ${details.globalPosition}');
  };
  lp.onLongPressStart = (LongPressStartDetails details) {
    debugPrint('  lp onLongPressStart ${details.globalPosition}');
  };
  lp.onLongPress = () {
    debugPrint('  lp fired');
  };
  lp.onLongPressMoveUpdate = (LongPressMoveUpdateDetails details) {
    debugPrint('  lp move ${details.localPosition}');
  };
  lp.onLongPressEnd = (LongPressEndDetails details) {
    debugPrint('  lp end ${details.globalPosition}');
  };
  lp.onLongPressCancel = () {
    debugPrint('  lp cancelled');
  };
  debugPrint('  runtimeType=${lp.runtimeType}');
  lp.dispose();
}

void _probePanRecognizer() {
  debugPrint('probe: PanGestureRecognizer');
  final PanGestureRecognizer pan = PanGestureRecognizer();
  pan.onDown = (DragDownDetails details) {
    debugPrint('  pan onDown ${details.globalPosition}');
  };
  pan.onStart = (DragStartDetails details) {
    debugPrint('  pan onStart ${details.globalPosition}');
  };
  pan.onUpdate = (DragUpdateDetails details) {
    debugPrint('  pan onUpdate ${details.delta}');
  };
  pan.onEnd = (DragEndDetails details) {
    debugPrint('  pan onEnd ${details.velocity}');
  };
  pan.onCancel = () {
    debugPrint('  pan onCancel');
  };
  debugPrint('  runtimeType=${pan.runtimeType}');
  pan.dispose();
}

void _probeHorizontalDragRecognizer() {
  debugPrint('probe: HorizontalDragGestureRecognizer');
  final HorizontalDragGestureRecognizer hd = HorizontalDragGestureRecognizer();
  hd.onStart = (DragStartDetails details) {
    debugPrint('  hd onStart ${details.globalPosition}');
  };
  hd.onUpdate = (DragUpdateDetails details) {
    debugPrint('  hd onUpdate ${details.delta}');
  };
  hd.onEnd = (DragEndDetails details) {
    debugPrint('  hd onEnd ${details.velocity}');
  };
  debugPrint('  runtimeType=${hd.runtimeType}');
  hd.dispose();
}

void _probeVerticalDragRecognizer() {
  debugPrint('probe: VerticalDragGestureRecognizer');
  final VerticalDragGestureRecognizer vd = VerticalDragGestureRecognizer();
  vd.onStart = (DragStartDetails details) {
    debugPrint('  vd onStart ${details.globalPosition}');
  };
  vd.onUpdate = (DragUpdateDetails details) {
    debugPrint('  vd onUpdate ${details.delta}');
  };
  vd.onEnd = (DragEndDetails details) {
    debugPrint('  vd onEnd ${details.velocity}');
  };
  debugPrint('  runtimeType=${vd.runtimeType}');
  vd.dispose();
}

void _probeScaleRecognizer() {
  debugPrint('probe: ScaleGestureRecognizer');
  final ScaleGestureRecognizer scale = ScaleGestureRecognizer();
  scale.onStart = (ScaleStartDetails details) {
    debugPrint('  scale onStart focal=${details.focalPoint}');
  };
  scale.onUpdate = (ScaleUpdateDetails details) {
    debugPrint('  scale onUpdate scale=${details.scale}');
  };
  scale.onEnd = (ScaleEndDetails details) {
    debugPrint('  scale onEnd velocity=${details.velocity}');
  };
  debugPrint('  runtimeType=${scale.runtimeType}');
  scale.dispose();
}

void _probeMultiTapRecognizer() {
  debugPrint('probe: MultiTapGestureRecognizer');
  final MultiTapGestureRecognizer mt = MultiTapGestureRecognizer();
  mt.onTapDown = (int pointer, TapDownDetails details) {
    debugPrint('  mt onTapDown pointer=$pointer pos=${details.globalPosition}');
  };
  mt.onTapUp = (int pointer, TapUpDetails details) {
    debugPrint('  mt onTapUp pointer=$pointer pos=${details.globalPosition}');
  };
  mt.onTap = (int pointer) {
    debugPrint('  mt onTap pointer=$pointer');
  };
  mt.onTapCancel = (int pointer) {
    debugPrint('  mt onTapCancel pointer=$pointer');
  };
  debugPrint('  runtimeType=${mt.runtimeType}');
  mt.dispose();
}

void _probeEagerRecognizer() {
  debugPrint('probe: EagerGestureRecognizer');
  final EagerGestureRecognizer eager = EagerGestureRecognizer();
  debugPrint('  runtimeType=${eager.runtimeType}');
  debugPrint('  debugDescription=${eager.debugDescription}');
  eager.dispose();
}

void _probeSerialTapRecognizer() {
  debugPrint('probe: SerialTapGestureRecognizer');
  final SerialTapGestureRecognizer serial = SerialTapGestureRecognizer();
  serial.onSerialTapDown = (SerialTapDownDetails details) {
    debugPrint('  serial onSerialTapDown count=${details.count}');
  };
  serial.onSerialTapUp = (SerialTapUpDetails details) {
    debugPrint('  serial onSerialTapUp count=${details.count}');
  };
  serial.onSerialTapCancel = (SerialTapCancelDetails details) {
    debugPrint('  serial onSerialTapCancel count=${details.count}');
  };
  debugPrint('  runtimeType=${serial.runtimeType}');
  serial.dispose();
}

// =============================================================================
//  Static-demo helper builders.
// =============================================================================

Widget _buildStaticDemoCard({
  required String title,
  required IconData icon,
  required Color accent,
  required String targetLabel,
  required String caption,
  required List<_EventEntry> exampleEvents,
  required List<String> callbackHints,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 18.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _parchment,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withValues(alpha: 0.6), width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: accent, size: 22.0),
            const SizedBox(width: 8.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: _inkDeep,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        // Target zone
        Center(
          child: Container(
            width: 200.0,
            height: 80.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  accent.withValues(alpha: 0.85),
                  accent.withValues(alpha: 0.6),
                ],
              ),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: accent.withValues(alpha: 0.3),
                  blurRadius: 6.0,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                targetLabel,
                style: const TextStyle(
                  color: _parchment,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        // Event log strip
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _sandPale.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: const <Widget>[
                  Icon(Icons.list_alt, size: 14.0, color: _inkSoft),
                  SizedBox(width: 6.0),
                  Text(
                    'example event log (last 5)',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontStyle: FontStyle.italic,
                      color: _inkSoft,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: <Widget>[
                  for (final _EventEntry entry in exampleEvents)
                    _buildEventChip(entry),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        // Caption
        Text(
          caption,
          style: const TextStyle(
            fontSize: 12.0,
            height: 1.45,
            color: _inkSoft,
          ),
        ),
        const SizedBox(height: 10.0),
        // Callback list
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _inkDeep.withValues(alpha: 0.92),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'callbacks',
                style: TextStyle(
                  fontSize: 10.5,
                  color: _coinGold,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 6.0),
              for (final String hint in callbackHints)
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Text(
                    '- $hint',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: _chimeMint,
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

Widget _buildEventChip(_EventEntry entry) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: entry.color.withValues(alpha: 0.85),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          entry.label,
          style: const TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.bold,
            color: _inkDeep,
          ),
        ),
        const SizedBox(width: 6.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
          decoration: BoxDecoration(
            color: _parchment.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            entry.payload,
            style: const TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              color: _inkDeep,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildAxisDragCard({
  required String title,
  required IconData icon,
  required IconData arrowIcon,
  required Color accent,
  required String description,
  required List<String> callbackHints,
}) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _parchment,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withValues(alpha: 0.6), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: accent, size: 20.0),
            const SizedBox(width: 6.0),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: _inkDeep,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        // Pulsing direction indicator (static, captioned)
        Container(
          height: 60.0,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (int i = 0; i < 3; i += 1)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Icon(
                    arrowIcon,
                    size: 20.0 + i * 4.0,
                    color: accent.withValues(alpha: 0.4 + i * 0.2),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          description,
          style: const TextStyle(fontSize: 11.5, height: 1.4, color: _inkSoft),
        ),
        const SizedBox(height: 8.0),
        for (final String hint in callbackHints)
          Padding(
            padding: const EdgeInsets.only(bottom: 1.5),
            child: Text(
              '- $hint',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                color: accent.withValues(alpha: 0.95),
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _buildFingerCountChip(int fingers) {
  final Color tone = fingers == 1
      ? _laurelMid
      : fingers == 2
          ? _chimeSky
          : fingers == 3
              ? _coinGold
              : fingers == 4
                  ? _bloodRust
                  : _archShadow;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: tone.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: tone, width: 1.5),
    ),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            for (int i = 0; i < fingers; i += 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.0),
                child: Icon(Icons.circle, size: 10.0, color: tone),
              ),
          ],
        ),
        const SizedBox(height: 4.0),
        Text(
          '$fingers finger${fingers == 1 ? '' : 's'}',
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: tone,
          ),
        ),
        Text(
          '$fingers onTap events',
          style: const TextStyle(fontSize: 9.5, color: _inkSoft),
        ),
      ],
    ),
  );
}

Widget _buildSerialTapStep(int count) {
  final Color tone = count == 1
      ? _laurelMid
      : count == 2
          ? _chimeSky
          : count == 3
              ? _coinGold
              : _bloodRust;
  return Column(
    children: <Widget>[
      Container(
        width: 56.0,
        height: 56.0,
        decoration: BoxDecoration(
          color: tone.withValues(alpha: 0.2),
          shape: BoxShape.circle,
          border: Border.all(color: tone, width: 2.0),
        ),
        child: Center(
          child: Text(
            '$count',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: tone,
            ),
          ),
        ),
      ),
      const SizedBox(height: 6.0),
      Text(
        count == 1
            ? 'single'
            : count == 2
                ? 'double'
                : count == 3
                    ? 'triple'
                    : 'quad',
        style: const TextStyle(
          fontSize: 11.0,
          fontWeight: FontWeight.bold,
          color: _inkDeep,
        ),
      ),
      Text(
        'count=$count',
        style: const TextStyle(
          fontSize: 9.5,
          fontFamily: 'monospace',
          color: _inkSoft,
        ),
      ),
    ],
  );
}

Widget _buildLegendDot(Color color, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 12.0,
        height: 12.0,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 5.0),
      Text(
        label,
        style: const TextStyle(fontSize: 11.5, color: _inkSoft),
      ),
    ],
  );
}

Widget _buildCheatRow(String name, String callbacks, String note) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 6.0,
          height: 6.0,
          margin: const EdgeInsets.only(top: 6.0, right: 8.0),
          decoration: const BoxDecoration(
            color: _coinGold,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: _coinGold,
                ),
              ),
              Text(
                callbacks,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.5,
                  color: _chimeMint.withValues(alpha: 0.95),
                ),
              ),
              Text(
                note,
                style: TextStyle(
                  fontSize: 11.0,
                  color: _parchment.withValues(alpha: 0.85),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildLiveDetector({
  required String label,
  required IconData icon,
  required Widget detector,
}) {
  return Container(
    width: 140.0,
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: _parchment,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _laurelDark.withValues(alpha: 0.5), width: 1.5),
    ),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 16.0, color: _laurelDark),
            const SizedBox(width: 4.0),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: _inkDeep,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        detector,
      ],
    ),
  );
}

Widget _buildLiveTarget(Color color, String label) {
  return Container(
    width: 120.0,
    height: 60.0,
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.8),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Center(
      child: Text(
        label,
        style: const TextStyle(
          color: _parchment,
          fontWeight: FontWeight.bold,
          fontSize: 11.0,
          letterSpacing: 1.0,
        ),
      ),
    ),
  );
}

// =============================================================================
//  Small private classes
// =============================================================================

class _EventEntry {
  const _EventEntry(this.label, this.payload, this.color);
  final String label;
  final String payload;
  final Color color;
}

enum _ArenaStatus { winner, waiting, rejected }

class _ArenaChip extends StatelessWidget {
  const _ArenaChip({required this.label, required this.status});

  final String label;
  final _ArenaStatus status;

  @override
  Widget build(BuildContext context) {
    final Color tone;
    final String suffix;
    switch (status) {
      case _ArenaStatus.winner:
        tone = _laurelMid;
        suffix = 'WIN';
        break;
      case _ArenaStatus.waiting:
        tone = _chimeSky;
        suffix = '...';
        break;
      case _ArenaStatus.rejected:
        tone = _bloodRust;
        suffix = 'REJ';
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: tone.withValues(alpha: 0.4),
            blurRadius: 4.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: _parchment,
            ),
          ),
          const SizedBox(width: 6.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
            decoration: BoxDecoration(
              color: _inkDeep.withValues(alpha: 0.65),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              suffix,
              style: const TextStyle(
                fontSize: 9.0,
                fontWeight: FontWeight.bold,
                color: _parchment,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.index, required this.title});

  final int index;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: _archStone,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 28.0,
            height: 28.0,
            decoration: const BoxDecoration(
              color: _coinGold,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$index',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _inkDeep,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: _parchment,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
