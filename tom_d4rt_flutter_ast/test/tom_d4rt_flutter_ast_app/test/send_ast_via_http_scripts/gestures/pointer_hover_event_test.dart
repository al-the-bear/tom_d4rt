// D4rt test script: Deep visual demo of PointerHoverEvent from gestures.dart.
// Demonstrates every documented field of PointerHoverEvent across hero header,
// what-it-is prose, cursor-path visualizer, per-field cards, delta vs
// localDelta showcase, hover-vs-move comparison, MouseRegion integration,
// cursor showcase, construction sample, real-world usage, caveats and footer.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // SAMPLE EVENT INSTANCES
  // ============================================================
  // Several representative PointerHoverEvent values so each visual section
  // can show concrete numbers rather than placeholders. Note that
  // PointerHoverEvent forces down: false and pressure: 0.0 in its constructor.
  const eventMouse = PointerHoverEvent(
    timeStamp: Duration(milliseconds: 1234),
    pointer: 1,
    device: 0,
    position: Offset(150.0, 96.0),
    delta: Offset(5.0, 3.0),
    buttons: 0,
    obscured: false,
    pressureMin: 1.0,
    pressureMax: 1.0,
    distance: 0.0,
    distanceMax: 0.0,
    size: 0.0,
    radiusMajor: 0.0,
    radiusMinor: 0.0,
    radiusMin: 0.0,
    radiusMax: 0.0,
    orientation: 0.0,
    tilt: 0.0,
    synthesized: false,
    embedderId: 0,
  );

  const eventStylus = PointerHoverEvent(
    timeStamp: Duration(milliseconds: 4040),
    pointer: 17,
    kind: PointerDeviceKind.stylus,
    device: 2,
    position: Offset(220.0, 140.0),
    delta: Offset(2.0, -3.0),
    buttons: 0,
    obscured: false,
    pressureMin: 0.0,
    pressureMax: 1.0,
    distance: 12.0,
    distanceMax: 24.0,
    size: 0.05,
    radiusMajor: 4.0,
    radiusMinor: 3.0,
    radiusMin: 0.0,
    radiusMax: 6.0,
    orientation: 0.5,
    tilt: 0.2,
    synthesized: false,
    embedderId: 1,
  );

  const eventSynth = PointerHoverEvent(
    timeStamp: Duration(milliseconds: 9999),
    pointer: 99,
    kind: PointerDeviceKind.mouse,
    device: 0,
    position: Offset(310.0, 410.0),
    delta: Offset.zero,
    buttons: 0,
    obscured: false,
    synthesized: true,
    embedderId: 0,
  );

  // ============================================================
  // SECTION 1: Hero header
  // ============================================================
  final heroHeader = Container(
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade700, Colors.lightBlue.shade300],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.4),
          blurRadius: 18.0,
          offset: const Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.7),
                  width: 2.0,
                ),
              ),
              child: const Icon(
                Icons.mouse,
                size: 36.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16.0),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PointerHoverEvent',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.6,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/gestures.dart',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13.0,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Text(
            'Pointer moved while NOT pressed (mouse / stylus only).',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 8.0,
          children: [
            buildHeroChip('extends PointerEvent', Icons.account_tree),
            buildHeroChip('down == false', Icons.arrow_upward),
            buildHeroChip('mouse + stylus', Icons.brush),
            buildHeroChip('MouseRegion.onHover', Icons.touch_app),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: What it is / when it fires
  // ============================================================
  final introCard = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.lightBlue.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.cyan.shade200, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.lightbulb, color: Colors.cyan.shade700, size: 22.0),
            const SizedBox(width: 8.0),
            const Text(
              'When does PointerHoverEvent fire?',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'A PointerHoverEvent is dispatched whenever a pointer that is NOT '
          'pressed against the surface moves across it. In practice that means '
          'a mouse cursor moving over the window, or a stylus hovering above a '
          'digitiser. Touch fingers cannot hover, so they never produce hover '
          'events.',
          style: TextStyle(fontSize: 13.5, height: 1.45),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.cyan.shade100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLifecycleRow(
                Icons.login,
                'PointerEnter',
                'crosses the boundary into the region',
                Colors.green,
              ),
              const SizedBox(height: 6.0),
              buildLifecycleRow(
                Icons.mouse,
                'PointerHover',
                'moves while inside, NOT pressed (this event)',
                Colors.cyan,
              ),
              const SizedBox(height: 6.0),
              buildLifecycleRow(
                Icons.touch_app,
                'PointerDown',
                'presses the surface (button down)',
                Colors.blue,
              ),
              const SizedBox(height: 6.0),
              buildLifecycleRow(
                Icons.swap_horiz,
                'PointerMove',
                'moves while pressed (different event!)',
                Colors.indigo,
              ),
              const SizedBox(height: 6.0),
              buildLifecycleRow(
                Icons.logout,
                'PointerExit',
                'crosses the boundary out of the region',
                Colors.deepOrange,
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Cursor path visualizer
  // ============================================================
  final cursorPathSection = Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.cyan.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.10),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timeline, color: Colors.cyan.shade700, size: 22.0),
            const SizedBox(width: 8.0),
            const Text(
              'Conceptual cursor trail',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          'Eight successive hover events form a snaking path. Each dot is the '
          'position field of one PointerHoverEvent; arrows show the direction '
          'and magnitude of delta between successive events.',
          style: TextStyle(
            fontSize: 12.5,
            color: Colors.grey.shade700,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12.0),
        Center(
          child: Container(
            width: 320.0,
            height: 220.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.cyan.shade50, Colors.lightBlue.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(color: Colors.cyan.shade200, width: 1.0),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 24.0,
                  top: 30.0,
                  child: buildPathDot(1, Colors.cyan, Icons.fiber_manual_record),
                ),
                Positioned(
                  left: 50.0,
                  top: 22.0,
                  child: buildPathArrow(0.0),
                ),
                Positioned(
                  left: 76.0,
                  top: 30.0,
                  child: buildPathDot(2, Colors.cyan, Icons.fiber_manual_record),
                ),
                Positioned(
                  left: 102.0,
                  top: 38.0,
                  child: buildPathArrow(0.4),
                ),
                Positioned(
                  left: 128.0,
                  top: 56.0,
                  child: buildPathDot(3, Colors.cyan, Icons.fiber_manual_record),
                ),
                Positioned(
                  left: 138.0,
                  top: 80.0,
                  child: buildPathArrow(1.2),
                ),
                Positioned(
                  left: 144.0,
                  top: 110.0,
                  child: buildPathDot(4, Colors.lightBlue, Icons.fiber_manual_record),
                ),
                Positioned(
                  left: 168.0,
                  top: 118.0,
                  child: buildPathArrow(0.0),
                ),
                Positioned(
                  left: 196.0,
                  top: 110.0,
                  child: buildPathDot(5, Colors.lightBlue, Icons.fiber_manual_record),
                ),
                Positioned(
                  left: 220.0,
                  top: 120.0,
                  child: buildPathArrow(0.5),
                ),
                Positioned(
                  left: 240.0,
                  top: 144.0,
                  child: buildPathDot(6, Colors.lightBlue, Icons.fiber_manual_record),
                ),
                Positioned(
                  left: 234.0,
                  top: 168.0,
                  child: buildPathArrow(1.7),
                ),
                Positioned(
                  left: 220.0,
                  top: 184.0,
                  child: buildPathDot(7, Colors.blue, Icons.fiber_manual_record),
                ),
                Positioned(
                  left: 200.0,
                  top: 188.0,
                  child: buildPathArrow(3.1),
                ),
                Positioned(
                  left: 168.0,
                  top: 184.0,
                  child: buildPathDot(8, Colors.blue, Icons.fiber_manual_record),
                ),
                const Positioned(
                  left: 12.0,
                  bottom: 8.0,
                  child: Text(
                    'time \u2192',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const Positioned(
                  right: 12.0,
                  top: 8.0,
                  child: Text(
                    'position (px)',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 6.0,
          children: [
            buildLegendDot(Colors.cyan, 'early'),
            buildLegendDot(Colors.lightBlue, 'middle'),
            buildLegendDot(Colors.blue, 'late'),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Field grid
  // ============================================================
  final fieldGridSection = Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.cyan.shade200, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.grid_view, color: Colors.cyan.shade700, size: 22.0),
            const SizedBox(width: 8.0),
            const Text(
              'Field reference (grouped)',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        buildFieldGroup(
          'Identity',
          Colors.cyan,
          Icons.fingerprint,
          [
            buildFieldCard(
              name: 'pointer',
              type: 'int',
              value: '1',
              note: 'Sequence number assigned to this pointer.',
            ),
            buildFieldCard(
              name: 'device',
              type: 'int',
              value: '0',
              note: 'Hardware ID of the input device.',
            ),
            buildFieldCard(
              name: 'kind',
              type: 'PointerDeviceKind',
              value: 'mouse',
              note: 'Mouse / stylus / unknown. Touch never hovers.',
            ),
            buildFieldCard(
              name: 'embedderId',
              type: 'int',
              value: '0',
              note: 'Opaque ID assigned by the platform embedder.',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        buildFieldGroup(
          'Position',
          Colors.lightBlue,
          Icons.place,
          [
            buildFieldCard(
              name: 'position',
              type: 'Offset',
              value: '(150.0, 96.0)',
              note: 'Logical pixels in the global coordinate space.',
            ),
            buildFieldCard(
              name: 'localPosition',
              type: 'Offset',
              value: '(150.0, 96.0)',
              note: 'Position relative to the receiving render object.',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        buildFieldGroup(
          'Motion',
          Colors.blue,
          Icons.swap_horiz,
          [
            buildFieldCard(
              name: 'delta',
              type: 'Offset',
              value: '(5.0, 3.0)',
              note: 'Change in global position since the previous hover.',
            ),
            buildFieldCard(
              name: 'localDelta',
              type: 'Offset',
              value: '(5.0, 3.0)',
              note: 'Same delta, mapped through local transform.',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        buildFieldGroup(
          'Pressure',
          Colors.indigo,
          Icons.compress,
          [
            buildFieldCard(
              name: 'pressureMin',
              type: 'double',
              value: '1.0',
              note: 'Minimum reportable pressure (mouse: typically 1.0).',
            ),
            buildFieldCard(
              name: 'pressureMax',
              type: 'double',
              value: '1.0',
              note: 'Maximum reportable pressure.',
            ),
            buildFieldCard(
              name: 'pressure',
              type: 'double',
              value: '0.0 (forced)',
              note: 'Always 0.0 for hover; the pointer is not pressed.',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        buildFieldGroup(
          'Geometry',
          Colors.teal,
          Icons.square_foot,
          [
            buildFieldCard(
              name: 'size',
              type: 'double',
              value: '0.0',
              note: 'Normalised contact patch size [0..1].',
            ),
            buildFieldCard(
              name: 'radiusMajor',
              type: 'double',
              value: '0.0',
              note: 'Major axis of the contact ellipse.',
            ),
            buildFieldCard(
              name: 'radiusMinor',
              type: 'double',
              value: '0.0',
              note: 'Minor axis of the contact ellipse.',
            ),
            buildFieldCard(
              name: 'radiusMin',
              type: 'double',
              value: '0.0',
              note: 'Lowest reportable radius for this device.',
            ),
            buildFieldCard(
              name: 'radiusMax',
              type: 'double',
              value: '0.0',
              note: 'Highest reportable radius for this device.',
            ),
            buildFieldCard(
              name: 'orientation',
              type: 'double',
              value: '0.0',
              note: 'Orientation of the major axis, radians.',
            ),
            buildFieldCard(
              name: 'tilt',
              type: 'double',
              value: '0.0',
              note: 'Stylus tilt angle from perpendicular (radians).',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        buildFieldGroup(
          'Distance',
          Colors.deepPurple,
          Icons.height,
          [
            buildFieldCard(
              name: 'distance',
              type: 'double',
              value: '0.0',
              note: 'Stylus distance above the surface (mouse: 0).',
            ),
            buildFieldCard(
              name: 'distanceMax',
              type: 'double',
              value: '0.0',
              note: 'Maximum sensed hover distance.',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        buildFieldGroup(
          'State',
          Colors.blueGrey,
          Icons.flag,
          [
            buildFieldCard(
              name: 'buttons',
              type: 'int',
              value: '0',
              note: 'Bitfield: 0 because nothing is pressed during hover.',
            ),
            buildFieldCard(
              name: 'obscured',
              type: 'bool',
              value: 'false',
              note: 'Whether another window obscures the pointer.',
            ),
            buildFieldCard(
              name: 'synthesized',
              type: 'bool',
              value: 'false',
              note: 'True if Flutter generated this event itself.',
            ),
            buildFieldCard(
              name: 'down',
              type: 'bool',
              value: 'false (forced)',
              note: 'PointerHoverEvent always has down == false.',
            ),
            buildFieldCard(
              name: 'timeStamp',
              type: 'Duration',
              value: '1234 ms',
              note: 'Embedder timestamp for ordering.',
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: delta vs localDelta showcase
  // ============================================================
  final deltaShowcase = Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.lightBlue.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.cyan.shade200, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows, color: Colors.cyan.shade700, size: 22.0),
            const SizedBox(width: 8.0),
            const Text(
              'delta vs localDelta',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          'localDelta differs from delta only when an ancestor RenderObject '
          'applies a Transform (rotation, scale, etc.). For hovers in a plain '
          'box, the two are identical.',
          style: TextStyle(
            fontSize: 12.5,
            color: Colors.grey.shade700,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: buildDeltaPanel(
                title: 'Pure horizontal',
                delta: const Offset(8.0, 0.0),
                localDelta: const Offset(8.0, 0.0),
                color: Colors.cyan,
                icon: Icons.east,
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: buildDeltaPanel(
                title: 'Pure vertical',
                delta: const Offset(0.0, 6.0),
                localDelta: const Offset(0.0, 6.0),
                color: Colors.lightBlue,
                icon: Icons.south,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: buildDeltaPanel(
                title: 'Diagonal',
                delta: const Offset(5.0, 4.0),
                localDelta: const Offset(5.0, 4.0),
                color: Colors.blue,
                icon: Icons.south_east,
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: buildDeltaPanel(
                title: 'Transformed (rotated 90 deg)',
                delta: const Offset(5.0, 4.0),
                localDelta: const Offset(-4.0, 5.0),
                color: Colors.indigo,
                icon: Icons.rotate_right,
                highlight: true,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Hover vs Move
  // ============================================================
  final hoverVsMoveSection = Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.cyan.shade200, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare, color: Colors.cyan.shade700, size: 22.0),
            const SizedBox(width: 8.0),
            const Text(
              'PointerHoverEvent vs PointerMoveEvent',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: buildVsCard(
                title: 'PointerHoverEvent',
                color: Colors.cyan,
                rows: const [
                  ['down', 'false (forced)'],
                  ['fired when', 'pointer not pressed, moves'],
                  ['who emits', 'mouse / stylus only'],
                  ['Listener cb', 'onPointerHover'],
                  ['MouseRegion', 'onHover'],
                  ['pressure', '0.0 (always)'],
                  ['button bits', '0 (none down)'],
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: buildVsCard(
                title: 'PointerMoveEvent',
                color: Colors.indigo,
                rows: const [
                  ['down', 'true'],
                  ['fired when', 'pointer pressed, moves'],
                  ['who emits', 'touch / mouse / stylus'],
                  ['Listener cb', 'onPointerMove'],
                  ['MouseRegion', 'n/a'],
                  ['pressure', '> 0 typically'],
                  ['button bits', 'reflects active button'],
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.amber.shade300),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.warning_amber,
                color: Colors.amber.shade800,
                size: 18.0,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Common bug: handling onPointerMove and expecting hover '
                  'updates to land there too. Hover events come through '
                  'onPointerHover, never onPointerMove.',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Colors.amber.shade900,
                    height: 1.4,
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
  // SECTION 7: MouseRegion integration
  // ============================================================
  const mouseRegionSnippet = '''MouseRegion(
  onEnter: (PointerEnterEvent event) {
    // first crossing of the boundary
  },
  onHover: (PointerHoverEvent event) {
    // every move while NOT pressed
    // event.localPosition is what you usually want
  },
  onExit: (PointerExitEvent event) {
    // pointer leaves, or button goes down
  },
  cursor: SystemMouseCursors.click,
  child: child,
)''';

  final mouseRegionSection = Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.cyan.shade200, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade700, size: 22.0),
            const SizedBox(width: 8.0),
            const Text(
              'MouseRegion integration',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          'MouseRegion is the typical entry point for hover events in '
          'application code. The Listener widget is the lower-level '
          'alternative.',
          style: TextStyle(
            fontSize: 12.5,
            color: Colors.grey.shade700,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2A38),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.cyan.shade700, width: 1.0),
          ),
          width: double.infinity,
          child: const Text(
            mouseRegionSnippet,
            style: TextStyle(
              fontFamily: 'monospace',
              color: Colors.white,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        Row(
          children: [
            Expanded(
              child: MouseRegion(
                cursor: SystemMouseCursors.basic,
                child: Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.cyan.shade50,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.cyan.shade300),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Live MouseRegion (static demo)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                        ),
                      ),
                      SizedBox(height: 6.0),
                      Text(
                        'On a real desktop run, hovering this card would emit '
                        'PointerHoverEvent objects via onHover.',
                        style: TextStyle(fontSize: 12.0, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Cursor changes
  // ============================================================
  final cursorSection = Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.cyan.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.cyan.shade200, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.mouse, color: Colors.cyan.shade700, size: 22.0),
            const SizedBox(width: 8.0),
            const Text(
              'Cursor changes follow hover',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          'When the OS reports a new hover position, MouseTracker decides which '
          'MouseRegion is now under the pointer and updates SystemMouseCursors '
          'accordingly.',
          style: TextStyle(
            fontSize: 12.5,
            color: Colors.grey.shade700,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 14.0),
        Row(
          children: [
            Expanded(
              child: buildCursorCard(
                label: 'click',
                description: 'Pointer / hand. Used for buttons.',
                icon: Icons.touch_app,
                color: Colors.cyan,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: buildCursorCard(
                label: 'text',
                description: 'I-beam. Editable text fields.',
                icon: Icons.text_fields,
                color: Colors.lightBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: buildCursorCard(
                label: 'grab',
                description: 'Open hand for draggable handles.',
                icon: Icons.pan_tool,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: buildCursorCard(
                label: 'forbidden',
                description: 'Disabled regions or no-drop zones.',
                icon: Icons.block,
                color: Colors.indigo,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Construction sample
  // ============================================================
  const constructionSnippet = '''const event = PointerHoverEvent(
  timeStamp: Duration(milliseconds: 1234),
  pointer: 1,
  kind: PointerDeviceKind.mouse,
  device: 0,
  position: Offset(150.0, 96.0),
  delta: Offset(5.0, 3.0),
  buttons: 0,
  obscured: false,
  pressureMin: 1.0,
  pressureMax: 1.0,
  distance: 0.0,
  distanceMax: 0.0,
  size: 0.0,
  radiusMajor: 0.0,
  radiusMinor: 0.0,
  radiusMin: 0.0,
  radiusMax: 0.0,
  orientation: 0.0,
  tilt: 0.0,
  synthesized: false,
  embedderId: 0,
);
// down is forced false; pressure is forced 0.0''';

  final constructionSection = Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.cyan.shade200, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.construction, color: Colors.cyan.shade700, size: 22.0),
            const SizedBox(width: 8.0),
            const Text(
              'Construction sample',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2A38),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.cyan.shade700, width: 1.0),
          ),
          width: double.infinity,
          child: const Text(
            constructionSnippet,
            style: TextStyle(
              fontFamily: 'monospace',
              color: Colors.white,
              fontSize: 12.0,
              height: 1.45,
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Live readout from eventMouse',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 8.0),
        buildReadoutGrid(eventMouse, 'mouse'),
        const SizedBox(height: 12.0),
        const Text(
          'Live readout from eventStylus',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 8.0),
        buildReadoutGrid(eventStylus, 'stylus'),
        const SizedBox(height: 12.0),
        const Text(
          'Live readout from eventSynth',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 8.0),
        buildReadoutGrid(eventSynth, 'synthesized'),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Real-world usage
  // ============================================================
  final realWorldSection = Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.cyan.shade200, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.workspaces, color: Colors.cyan.shade700, size: 22.0),
            const SizedBox(width: 8.0),
            const Text(
              'Real-world usage patterns',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: buildUsageCard(
                title: 'Tooltip on hover',
                icon: Icons.info,
                color: Colors.cyan,
                description:
                    'Tooltip widget tracks hover via MouseRegion and shows '
                    'after a hold delay. Each PointerHoverEvent resets the '
                    'tooltip timer.',
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: buildUsageCard(
                title: 'Row highlight in DataTable',
                icon: Icons.table_rows,
                color: Colors.lightBlue,
                description:
                    'A custom DataTable row uses onHover to set a hovered flag '
                    'and paint a faint background. localPosition narrows the '
                    'highlight to the cell under the cursor.',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: buildUsageCard(
                title: 'Drag-handle hover state',
                icon: Icons.drag_handle,
                color: Colors.blue,
                description:
                    'A list reorder handle changes its cursor to grab and its '
                    'opacity to full when hover is detected, signalling that '
                    'a drag would begin.',
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: buildUsageCard(
                title: 'Palette hover preview',
                icon: Icons.palette,
                color: Colors.indigo,
                description:
                    'A colour swatch grid uses hover to preview the colour in '
                    'a large preview pane without committing the selection '
                    'until a tap.',
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 11: Caveats
  // ============================================================
  final caveatsSection = Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.amber.shade300, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.warning_amber,
              color: Colors.amber.shade800,
              size: 22.0,
            ),
            const SizedBox(width: 8.0),
            const Text(
              'Caveats',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        buildCaveat(
          title: 'Touch never hovers',
          body:
              'Only PointerDeviceKind.mouse and PointerDeviceKind.stylus emit '
              'hover events. Phone-only apps will never see one.',
        ),
        buildCaveat(
          title: 'First delta after enter may be zero',
          body:
              'When the framework synthesises an initial hover after a '
              'PointerEnterEvent, delta is often Offset.zero. Do not gate '
              'work on a non-zero delta.',
        ),
        buildCaveat(
          title: 'Synthesized events from the framework',
          body:
              'Flutter may dispatch hover events with synthesized: true to '
              'keep MouseTracker in sync after layout changes (e.g. a widget '
              'moved under the cursor).',
        ),
        buildCaveat(
          title: 'Performance in dense lists',
          body:
              'Each MouseRegion in a long ListView pays a hit-test on every '
              'hover frame. Wrap the row content, not each cell, and avoid '
              'unnecessary rebuilds in onHover.',
        ),
        buildCaveat(
          title: 'Hover during scroll',
          body:
              'Scrolling does not emit hover events; it changes which widget '
              'sits under a stationary cursor. Mark dependent state dirty in '
              'response to scroll, not hover.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 12: Footer
  // ============================================================
  final footer = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade800, Colors.lightBlue.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Takeaways',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12.0),
        buildTakeaway(
          'PointerHoverEvent fires while a non-pressed pointer moves.',
        ),
        buildTakeaway(
          'down is always false and pressure is always 0.0.',
        ),
        buildTakeaway(
          'Mouse and stylus emit hover; touch never does.',
        ),
        buildTakeaway(
          'MouseRegion.onHover is the canonical entry point.',
        ),
        buildTakeaway(
          'Do not confuse with PointerMoveEvent (down == true).',
        ),
        buildTakeaway(
          'Use localPosition for hit-testing inside transformed widgets.',
        ),
      ],
    ),
  );

  // ============================================================
  // ASSEMBLY
  // ============================================================
  return Scaffold(
    backgroundColor: Colors.cyan.shade50,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          heroHeader,
          const SizedBox(height: 18.0),
          introCard,
          const SizedBox(height: 18.0),
          cursorPathSection,
          const SizedBox(height: 18.0),
          fieldGridSection,
          const SizedBox(height: 18.0),
          deltaShowcase,
          const SizedBox(height: 18.0),
          hoverVsMoveSection,
          const SizedBox(height: 18.0),
          mouseRegionSection,
          const SizedBox(height: 18.0),
          cursorSection,
          const SizedBox(height: 18.0),
          constructionSection,
          const SizedBox(height: 18.0),
          realWorldSection,
          const SizedBox(height: 18.0),
          caveatsSection,
          const SizedBox(height: 18.0),
          footer,
          const SizedBox(height: 20.0),
        ],
      ),
    ),
  );
}

// ============================================================
// HELPER BUILDERS
// ============================================================

Widget buildHeroChip(String label, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 14.0),
        const SizedBox(width: 6.0),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12.0,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget buildLifecycleRow(
  IconData icon,
  String name,
  String desc,
  MaterialColor color,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 26.0,
        height: 26.0,
        decoration: BoxDecoration(
          color: color.shade100,
          shape: BoxShape.circle,
          border: Border.all(color: color.shade400),
        ),
        child: Icon(icon, size: 14.0, color: color.shade800),
      ),
      const SizedBox(width: 10.0),
      SizedBox(
        width: 110.0,
        child: Text(
          name,
          style: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            fontSize: 12.5,
            color: color.shade900,
          ),
        ),
      ),
      Expanded(
        child: Text(
          desc,
          style: const TextStyle(fontSize: 12.0, height: 1.4),
        ),
      ),
    ],
  );
}

Widget buildPathDot(int index, MaterialColor color, IconData icon) {
  return Container(
    width: 22.0,
    height: 22.0,
    decoration: BoxDecoration(
      color: color.shade100,
      shape: BoxShape.circle,
      border: Border.all(color: color.shade600, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.35),
          blurRadius: 6.0,
        ),
      ],
    ),
    child: Center(
      child: Text(
        '$index',
        style: TextStyle(
          color: color.shade900,
          fontSize: 10.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget buildPathArrow(double rotation) {
  return Transform.rotate(
    angle: rotation,
    child: Icon(
      Icons.arrow_forward,
      size: 16.0,
      color: Colors.cyan.shade700,
    ),
  );
}

Widget buildLegendDot(MaterialColor color, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 12.0,
        height: 12.0,
        decoration: BoxDecoration(
          color: color.shade400,
          shape: BoxShape.circle,
        ),
      ),
      const SizedBox(width: 6.0),
      Text(
        label,
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.grey.shade800,
        ),
      ),
    ],
  );
}

Widget buildFieldGroup(
  String title,
  MaterialColor color,
  IconData icon,
  List<Widget> cards,
) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18.0, color: color.shade800),
            const SizedBox(width: 8.0),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: color.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: cards,
        ),
      ],
    ),
  );
}

Widget buildFieldCard({
  required String name,
  required String type,
  required String value,
  required String note,
}) {
  return Container(
    width: 230.0,
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.cyan.shade100),
      boxShadow: [
        BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.08),
          blurRadius: 4.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
            color: Colors.cyan.shade900,
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          type,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 4.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Colors.cyan.shade50,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Colors.cyan.shade900,
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          note,
          style: const TextStyle(
            fontSize: 11.5,
            color: Colors.black87,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

Widget buildDeltaPanel({
  required String title,
  required Offset delta,
  required Offset localDelta,
  required MaterialColor color,
  required IconData icon,
  bool highlight = false,
}) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: highlight ? color.shade600 : color.shade200,
        width: highlight ? 2.0 : 1.0,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color.shade700, size: 18.0),
            const SizedBox(width: 6.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5,
                  color: color.shade900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        buildDeltaRow('delta', '$delta', color),
        const SizedBox(height: 4.0),
        buildDeltaRow('localDelta', '$localDelta', color),
        if (highlight) ...[
          const SizedBox(height: 6.0),
          Text(
            'differs because of ancestor Transform',
            style: TextStyle(
              fontSize: 11.0,
              color: color.shade800,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ],
    ),
  );
}

Widget buildDeltaRow(String label, String value, MaterialColor color) {
  return Row(
    children: [
      SizedBox(
        width: 76.0,
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            color: color.shade700,
          ),
        ),
      ),
      Expanded(
        child: Text(
          value,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            fontSize: 11.5,
            color: Colors.black87,
          ),
        ),
      ),
    ],
  );
}

Widget buildVsCard({
  required String title,
  required MaterialColor color,
  required List<List<String>> rows,
}) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: color.shade900,
          ),
        ),
        const SizedBox(height: 8.0),
        for (final row in rows) buildVsRow(row[0], row[1], color),
      ],
    ),
  );
}

Widget buildVsRow(String key, String value, MaterialColor color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90.0,
          child: Text(
            key,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: color.shade700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 11.5,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildCursorCard({
  required String label,
  required String description,
  required IconData icon,
  required MaterialColor color,
}) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.shade300),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.10),
          blurRadius: 6.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: color.shade50,
                shape: BoxShape.circle,
                border: Border.all(color: color.shade300),
              ),
              child: Icon(icon, size: 18.0, color: color.shade700),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                'SystemMouseCursors.$label',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: color.shade900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          description,
          style: const TextStyle(
            fontSize: 11.5,
            color: Colors.black87,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

Widget buildReadoutGrid(PointerHoverEvent event, String label) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.cyan.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.cyan.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.bug_report, size: 16.0, color: Colors.cyan.shade700),
            const SizedBox(width: 6.0),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        buildReadoutRow('pointer', '${event.pointer}'),
        buildReadoutRow('device', '${event.device}'),
        buildReadoutRow('kind', '${event.kind}'),
        buildReadoutRow('position', '${event.position}'),
        buildReadoutRow('localPosition', '${event.localPosition}'),
        buildReadoutRow('delta', '${event.delta}'),
        buildReadoutRow('localDelta', '${event.localDelta}'),
        buildReadoutRow('buttons', '${event.buttons}'),
        buildReadoutRow('down', '${event.down}'),
        buildReadoutRow('pressure', '${event.pressure}'),
        buildReadoutRow('pressureMin', '${event.pressureMin}'),
        buildReadoutRow('pressureMax', '${event.pressureMax}'),
        buildReadoutRow('distance', '${event.distance}'),
        buildReadoutRow('distanceMax', '${event.distanceMax}'),
        buildReadoutRow('size', '${event.size}'),
        buildReadoutRow('radiusMajor', '${event.radiusMajor}'),
        buildReadoutRow('radiusMinor', '${event.radiusMinor}'),
        buildReadoutRow('radiusMin', '${event.radiusMin}'),
        buildReadoutRow('radiusMax', '${event.radiusMax}'),
        buildReadoutRow('orientation', '${event.orientation}'),
        buildReadoutRow('tilt', '${event.tilt}'),
        buildReadoutRow('synthesized', '${event.synthesized}'),
        buildReadoutRow('embedderId', '${event.embedderId}'),
        buildReadoutRow('timeStamp', '${event.timeStamp}'),
      ],
    ),
  );
}

Widget buildReadoutRow(String name, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1.5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110.0,
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 10.5,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildUsageCard({
  required String title,
  required IconData icon,
  required MaterialColor color,
  required String description,
}) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: color.shade100,
                shape: BoxShape.circle,
                border: Border.all(color: color.shade400),
              ),
              child: Icon(icon, size: 16.0, color: color.shade800),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: color.shade900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          description,
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.black87,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget buildCaveat({
  required String title,
  required String body,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0, right: 8.0),
          child: Icon(
            Icons.info_outline,
            size: 16.0,
            color: Colors.amber.shade800,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Colors.amber.shade900,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.amber.shade900,
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

Widget buildTakeaway(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 4.0, right: 8.0),
          child: Icon(Icons.check_circle, size: 16.0, color: Colors.white),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13.0,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}
