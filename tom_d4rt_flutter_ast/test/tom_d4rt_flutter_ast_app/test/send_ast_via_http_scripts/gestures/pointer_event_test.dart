// D4rt test script: Deep visual demo of PointerEvent (the abstract base class
// of every concrete pointer event in package:flutter/gestures.dart).
//
// Unlike the sibling demos that focus on a single concrete subclass
// (PointerHoverEvent, PointerUpEvent, PointerScrollEvent, ...) this demo is a
// *base class deep-dive*: it concentrates on the common API surface that every
// PointerEvent shares — viewId, embedderId, timeStamp, pointer, kind, device,
// position, localPosition, delta, localDelta, buttons, down, obscured,
// pressure, pressureMin, pressureMax, distance, distanceMax, size, radiusMajor,
// radiusMinor, radiusMin, radiusMax, orientation, tilt, synthesized, transform
// and original — together with the four canonical methods toString,
// toDiagnosticsNode, transformed and copyWith, and the inheritance hierarchy
// of all concrete subclasses.
//
// The visual structure intentionally avoids per-subclass specifics; it lays
// down the conceptual map that every other pointer-event demo specialises.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // SAMPLE EVENT INSTANCES
  // ============================================================
  // Three representative events used throughout the demo. Because PointerEvent
  // itself is abstract, we instantiate concrete subclasses (PointerDownEvent,
  // PointerHoverEvent, PointerMoveEvent) but only ever look at members that
  // are declared on PointerEvent — the same API surface every subclass shares.
  const sampleDown = PointerDownEvent(
    viewId: 0,
    timeStamp: Duration(milliseconds: 1234),
    pointer: 42,
    kind: PointerDeviceKind.touch,
    device: 0,
    position: Offset(100.0, 50.0),
    buttons: kPrimaryButton,
    obscured: false,
    pressure: 0.85,
    pressureMin: 0.0,
    pressureMax: 1.0,
    size: 0.12,
    radiusMajor: 8.0,
    radiusMinor: 6.0,
    radiusMin: 0.0,
    radiusMax: 12.0,
    orientation: 0.0,
    tilt: 0.0,
    embedderId: 0,
  );

  const sampleHover = PointerHoverEvent(
    viewId: 0,
    timeStamp: Duration(milliseconds: 1300),
    pointer: 17,
    kind: PointerDeviceKind.mouse,
    device: 1,
    position: Offset(220.0, 140.0),
    delta: Offset(4.0, 2.0),
    buttons: 0,
    obscured: false,
    pressureMin: 1.0,
    pressureMax: 1.0,
    embedderId: 1,
  );

  const sampleMove = PointerMoveEvent(
    viewId: 0,
    timeStamp: Duration(milliseconds: 1450),
    pointer: 42,
    kind: PointerDeviceKind.touch,
    device: 0,
    position: Offset(132.0, 78.0),
    delta: Offset(32.0, 28.0),
    buttons: kPrimaryButton,
    obscured: false,
    pressure: 0.91,
    pressureMin: 0.0,
    pressureMax: 1.0,
    embedderId: 0,
  );

  // ============================================================
  // SECTION 1: Hero header — gradient + nested-arrows icon
  // ============================================================
  final heroHeader = Container(
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade700, Colors.indigo.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.45),
          blurRadius: 20.0,
          offset: const Offset(0.0, 12.0),
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
                Icons.account_tree,
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
                    'PointerEvent',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.6,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'abstract base — package:flutter/gestures.dart',
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
            'PointerEvent (abstract base) — common API for every pointer '
            'event the engine ever dispatches to your widget tree.',
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
            buildHeroChip('extends Diagnosticable', Icons.account_tree),
            buildHeroChip('abstract', Icons.lock_outline),
            buildHeroChip('14+ subclasses', Icons.call_split),
            buildHeroChip('immutable', Icons.shield),
            buildHeroChip('Listener / MouseRegion', Icons.touch_app),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Inheritance map — tall tree diagram
  // ============================================================
  final inheritanceSection = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.10),
          blurRadius: 12.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.account_tree,
              color: Colors.deepPurple.shade700,
              size: 22.0,
            ),
            const SizedBox(width: 8.0),
            const Text(
              'Inheritance map',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          'PointerEvent is the root of a fan-out hierarchy. Every concrete '
          'pointer event you receive in a Listener, MouseRegion or '
          'GestureBinding hit-test is one of the leaves below.',
          style: TextStyle(
            fontSize: 12.5,
            color: Colors.grey.shade700,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16.0),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 14.0,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple.shade700,
                  Colors.indigo.shade500,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Text(
              'PointerEvent (abstract)',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        Center(
          child: Container(
            width: 2.0,
            height: 22.0,
            color: Colors.deepPurple.shade300,
          ),
        ),
        Container(
          height: 2.0,
          margin: const EdgeInsets.symmetric(horizontal: 24.0),
          color: Colors.deepPurple.shade300,
        ),
        const SizedBox(height: 12.0),
        const Text(
          'lifecycle (every pointer)',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 13.5,
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            buildLeafChip(
              'PointerAddedEvent',
              'pointer arrives in the system',
              Colors.green,
            ),
            buildLeafChip(
              'PointerRemovedEvent',
              'pointer leaves the system',
              Colors.red,
            ),
            buildLeafChip(
              'PointerDownEvent',
              'pointer presses surface',
              Colors.blue,
            ),
            buildLeafChip(
              'PointerMoveEvent',
              'pointer drags while pressed',
              Colors.indigo,
            ),
            buildLeafChip(
              'PointerHoverEvent',
              'pointer moves NOT pressed',
              Colors.cyan,
            ),
            buildLeafChip(
              'PointerUpEvent',
              'pointer releases surface',
              Colors.teal,
            ),
            buildLeafChip(
              'PointerCancelEvent',
              'sequence aborted by system',
              Colors.deepOrange,
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'enter / exit (mouse + stylus)',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 13.5,
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            buildLeafChip(
              'PointerEnterEvent',
              'cursor enters MouseRegion',
              Colors.lightBlue,
            ),
            buildLeafChip(
              'PointerExitEvent',
              'cursor exits MouseRegion',
              Colors.amber,
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'PointerSignalEvent (no buttons; informational)',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 13.5,
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            buildLeafChip(
              'PointerScrollEvent',
              'mouse wheel / trackpad scroll',
              Colors.purple,
            ),
            buildLeafChip(
              'PointerScaleEvent',
              'pinch / smart-zoom signal',
              Colors.deepPurple,
            ),
            buildLeafChip(
              'PointerScrollInertiaCancelEvent',
              'inertia interrupted',
              Colors.pink,
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'PointerPanZoom* (trackpad gestures)',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 13.5,
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            buildLeafChip(
              'PointerPanZoomStartEvent',
              'two-finger trackpad begins',
              Colors.lime,
            ),
            buildLeafChip(
              'PointerPanZoomUpdateEvent',
              'two-finger trackpad updates',
              Colors.green,
            ),
            buildLeafChip(
              'PointerPanZoomEndEvent',
              'two-finger trackpad ends',
              Colors.teal,
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.deepPurple.shade200),
          ),
          child: Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: Colors.deepPurple.shade700,
                size: 18.0,
              ),
              const SizedBox(width: 8.0),
              const Expanded(
                child: Text(
                  'Each subclass adds 0-3 specialised fields, but inherits '
                  'the entire ~25-field API of PointerEvent unchanged.',
                  style: TextStyle(fontSize: 12.5, height: 1.4),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: PointerDeviceKind taxonomy
  // ============================================================
  final deviceKindSection = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.indigo.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.devices_other,
              color: Colors.indigo.shade700,
              size: 22.0,
            ),
            const SizedBox(width: 8.0),
            const Text(
              'PointerDeviceKind taxonomy',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Every PointerEvent.kind is exactly one of these six values. The '
          'kind is fixed across the lifetime of a pointer id.',
          style: TextStyle(fontSize: 12.5, height: 1.4),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: [
            buildKindChip(
              'touch',
              Icons.touch_app,
              'Finger on a capacitive screen. Cannot hover. Pressure may be '
              'available or simulated as 1.0.',
              Colors.blue,
            ),
            buildKindChip(
              'mouse',
              Icons.mouse,
              'Pointing device with a cursor. Hovers, scrolls, has buttons. '
              'Pressure is fixed to 1.0 while pressed, else 0.0.',
              Colors.indigo,
            ),
            buildKindChip(
              'stylus',
              Icons.brush,
              'Active pen. Reports pressure, tilt, orientation. May hover '
              'above the surface (distance > 0).',
              Colors.deepPurple,
            ),
            buildKindChip(
              'invertedStylus',
              Icons.swap_vert,
              'Stylus held with the eraser-end down. Same data shape as '
              'stylus, distinguished only by kind.',
              Colors.purple,
            ),
            buildKindChip(
              'trackpad',
              Icons.touch_app_outlined,
              'Indirect surface that produces PointerPanZoom* events instead '
              'of regular down/move/up.',
              Colors.teal,
            ),
            buildKindChip(
              'unknown',
              Icons.help_outline,
              'Engine could not classify the source. Treat as touch by '
              'default.',
              Colors.grey,
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Common-fields grid (24-26 cards, grouped)
  // ============================================================
  final fieldGridSection = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.08),
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
            Icon(
              Icons.list_alt,
              color: Colors.deepPurple.shade700,
              size: 22.0,
            ),
            const SizedBox(width: 8.0),
            const Text(
              'Common-fields grid (~26 fields)',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Every concrete subclass inherits these. Subclasses may override '
          'defaults, but the field still exists and is queryable on a value '
          'typed as PointerEvent.',
          style: TextStyle(fontSize: 12.5, height: 1.4),
        ),
        const SizedBox(height: 16.0),
        buildFieldGroup(
          'identity (4)',
          Icons.fingerprint,
          Colors.deepPurple,
          [
            buildFieldCard(
              'pointer',
              'int',
              '${sampleDown.pointer}',
              'Unique id assigned by the engine when the pointer was added. '
              'Stable until the corresponding PointerRemovedEvent.',
              Colors.deepPurple,
            ),
            buildFieldCard(
              'device',
              'int',
              '${sampleDown.device}',
              'Hardware-level device id. Two pointers from the same physical '
              'device share this.',
              Colors.deepPurple,
            ),
            buildFieldCard(
              'kind',
              'PointerDeviceKind',
              '${sampleDown.kind}',
              'Discriminator between touch / mouse / stylus / trackpad / '
              'invertedStylus / unknown.',
              Colors.deepPurple,
            ),
            buildFieldCard(
              'embedderId',
              'int',
              '${sampleDown.embedderId}',
              'Opaque identifier supplied by the platform embedder; useful '
              'for round-tripping events to native code.',
              Colors.deepPurple,
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        buildFieldGroup(
          'viewport (3)',
          Icons.window,
          Colors.indigo,
          [
            buildFieldCard(
              'viewId',
              'int',
              '${sampleDown.viewId}',
              'The FlutterView that received this event. Critical for '
              'multi-window apps.',
              Colors.indigo,
            ),
            buildFieldCard(
              'timeStamp',
              'Duration',
              '${sampleDown.timeStamp}',
              'Engine clock offset since pointer-input subsystem started. '
              'Monotonic, NOT wall-clock.',
              Colors.indigo,
            ),
            buildFieldCard(
              'transform',
              'Matrix4?',
              sampleDown.transform == null ? 'null' : 'present',
              'World-to-local transform applied while routing to a hit '
              'render object. null at the engine boundary.',
              Colors.indigo,
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        buildFieldGroup(
          'motion (4)',
          Icons.timeline,
          Colors.blue,
          [
            buildFieldCard(
              'position',
              'Offset',
              '${sampleDown.position}',
              'Logical-pixel coordinates in the global (root) coordinate '
              'system.',
              Colors.blue,
            ),
            buildFieldCard(
              'localPosition',
              'Offset',
              '${sampleDown.localPosition}',
              'Same point but expressed in the local coordinate space of '
              'the receiving render object.',
              Colors.blue,
            ),
            buildFieldCard(
              'delta',
              'Offset',
              '${sampleHover.delta}',
              'Movement since the previous event, in the global coordinate '
              'system. Always Offset.zero on Down/Up/Hover-first.',
              Colors.blue,
            ),
            buildFieldCard(
              'localDelta',
              'Offset',
              '${sampleHover.localDelta}',
              'Same delta, but transformed into the local coordinate space.',
              Colors.blue,
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        buildFieldGroup(
          'pressure (3)',
          Icons.speed,
          Colors.red,
          [
            buildFieldCard(
              'pressure',
              'double',
              '${sampleDown.pressure}',
              'Normalised current pressure (typically [pressureMin, '
              'pressureMax]). Hardware-dependent.',
              Colors.red,
            ),
            buildFieldCard(
              'pressureMin',
              'double',
              '${sampleDown.pressureMin}',
              'Lowest pressure reportable by the device. May equal '
              'pressureMax on devices without pressure.',
              Colors.red,
            ),
            buildFieldCard(
              'pressureMax',
              'double',
              '${sampleDown.pressureMax}',
              'Highest pressure reportable by the device. The trio min-cur-'
              'max lets apps normalise to [0, 1] cleanly.',
              Colors.red,
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        buildFieldGroup(
          'geometry (7)',
          Icons.straighten,
          Colors.teal,
          [
            buildFieldCard(
              'distance',
              'double',
              '${sampleDown.distance}',
              'Stylus hover distance above the surface in arbitrary units. '
              '0.0 once the stylus touches.',
              Colors.teal,
            ),
            buildFieldCard(
              'distanceMax',
              'double',
              '${sampleDown.distanceMax}',
              'Maximum distance the device can detect a hovering stylus.',
              Colors.teal,
            ),
            buildFieldCard(
              'size',
              'double',
              '${sampleDown.size}',
              'Area of the contact ellipse, normalised to the screen size. '
              'Touch-only on most platforms.',
              Colors.teal,
            ),
            buildFieldCard(
              'radiusMajor',
              'double',
              '${sampleDown.radiusMajor}',
              'Major axis radius of the contact ellipse, in logical pixels.',
              Colors.teal,
            ),
            buildFieldCard(
              'radiusMinor',
              'double',
              '${sampleDown.radiusMinor}',
              'Minor axis radius of the contact ellipse, in logical pixels.',
              Colors.teal,
            ),
            buildFieldCard(
              'radiusMin',
              'double',
              '${sampleDown.radiusMin}',
              'Smallest radius the device can report. Useful for '
              'normalising radiusMajor.',
              Colors.teal,
            ),
            buildFieldCard(
              'radiusMax',
              'double',
              '${sampleDown.radiusMax}',
              'Largest radius the device can report.',
              Colors.teal,
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        buildFieldGroup(
          'state (5)',
          Icons.flag,
          Colors.deepOrange,
          [
            buildFieldCard(
              'buttons',
              'int (bitmask)',
              '${sampleDown.buttons}',
              'Bitmask of pressed buttons (kPrimaryButton, kSecondaryButton '
              'etc.). 0 means no buttons pressed.',
              Colors.deepOrange,
            ),
            buildFieldCard(
              'down',
              'bool',
              '${sampleDown.down}',
              'true while the pointer is in contact / pressed. Subclasses '
              'fix this — Down/Move are true, Up/Hover/Cancel are false.',
              Colors.deepOrange,
            ),
            buildFieldCard(
              'obscured',
              'bool',
              '${sampleDown.obscured}',
              'true if another platform window covered the surface; the '
              'event is delivered but suspect.',
              Colors.deepOrange,
            ),
            buildFieldCard(
              'orientation',
              'double (rad)',
              '${sampleDown.orientation}',
              'Stylus orientation around its own axis. Touch reports 0.',
              Colors.deepOrange,
            ),
            buildFieldCard(
              'tilt',
              'double (rad)',
              '${sampleDown.tilt}',
              'Stylus tilt angle from perpendicular. Touch reports 0.',
              Colors.deepOrange,
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        buildFieldGroup(
          'provenance (2)',
          Icons.history,
          Colors.brown,
          [
            buildFieldCard(
              'synthesized',
              'bool',
              '${sampleDown.synthesized}',
              'true if the framework (not the engine) fabricated this event '
              '— e.g. enter / exit derived from move.',
              Colors.brown,
            ),
            buildFieldCard(
              'original',
              'PointerEvent?',
              sampleDown.original == null ? 'null' : 'present',
              'For events produced by transformed(), the un-transformed '
              'event from the engine. null at the root.',
              Colors.brown,
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: transformed() showcase
  // ============================================================
  final transformedSection = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.08),
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
            Icon(
              Icons.transform,
              color: Colors.deepPurple.shade700,
              size: 22.0,
            ),
            const SizedBox(width: 8.0),
            const Text(
              'transformed(Matrix4?) showcase',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        const Text(
          'PointerEvent.transformed(matrix) returns a NEW event with '
          'localPosition / localDelta re-projected through the matrix. The '
          'global position is unchanged; original is set to the source.',
          style: TextStyle(fontSize: 12.5, height: 1.4),
        ),
        const SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: buildTransformBox(
                title: 'engine event',
                subtitle: 'transform == null',
                position: 'position = (100, 50)',
                local: 'localPosition = (100, 50)',
                color: Colors.indigo,
                icon: Icons.input,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                Icons.arrow_forward,
                color: Colors.deepPurple.shade400,
                size: 28.0,
              ),
            ),
            Expanded(
              child: buildTransformBox(
                title: 'transformed event',
                subtitle: 'matrix = Matrix4.rotationZ(pi/4)',
                position: 'position = (100, 50)',
                local: 'localPosition = (35.36, 106.07)',
                color: Colors.deepPurple,
                icon: Icons.rotate_right,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.deepPurple.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Identity rules',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                '- transformed(null) returns the receiver unchanged.',
                style: TextStyle(fontSize: 12.0, height: 1.4),
              ),
              Text(
                '- transformed(identity) returns the receiver unchanged.',
                style: TextStyle(fontSize: 12.0, height: 1.4),
              ),
              Text(
                '- transformed(m) is idempotent on the global position.',
                style: TextStyle(fontSize: 12.0, height: 1.4),
              ),
              Text(
                '- The returned event preserves runtimeType — a transformed '
                'PointerDownEvent stays a PointerDownEvent.',
                style: TextStyle(fontSize: 12.0, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: original chain — 3-link diagram
  // ============================================================
  final originalChainSection = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.indigo.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.link,
              color: Colors.indigo.shade700,
              size: 22.0,
            ),
            const SizedBox(width: 8.0),
            const Text(
              'original chain',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        const Text(
          'When an event is routed through nested transformed() calls, each '
          'link sets original to the previous link. Walk original.original '
          '... to find the engine event. Most apps never need this.',
          style: TextStyle(fontSize: 12.5, height: 1.4),
        ),
        const SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: buildChainLink(
                step: '1',
                title: 'engine',
                detail: 'original == null',
                color: Colors.indigo,
              ),
            ),
            Icon(
              Icons.chevron_left,
              color: Colors.indigo.shade400,
            ),
            Expanded(
              child: buildChainLink(
                step: '2',
                title: 'transformed (outer)',
                detail: 'original -> link 1',
                color: Colors.deepPurple,
              ),
            ),
            Icon(
              Icons.chevron_left,
              color: Colors.deepPurple.shade400,
            ),
            Expanded(
              child: buildChainLink(
                step: '3',
                title: 'transformed (inner)',
                detail: 'original -> link 2',
                color: Colors.purple,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.indigo.shade200),
          ),
          child: const Text(
            'Walking the chain: PointerEvent root = e; while (root.original '
            '!= null) root = root.original!; — root is what the engine '
            'emitted.',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: synthesized vs real
  // ============================================================
  final synthesizedSection = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade200, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.compare_arrows,
              color: Colors.deepPurple.shade700,
              size: 22.0,
            ),
            const SizedBox(width: 8.0),
            const Text(
              'synthesized vs real',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        const Text(
          'PointerEvent.synthesized indicates whether the engine actually '
          'emitted the event, or whether the framework fabricated it from '
          'surrounding events to fill a gap.',
          style: TextStyle(fontSize: 12.5, height: 1.4),
        ),
        const SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: buildVersusCard(
                title: 'real (synthesized: false)',
                color: Colors.green,
                icon: Icons.verified,
                points: const [
                  'Came from the platform embedder via the engine.',
                  'Reflects an actual hardware sample.',
                  'PointerDown / Up / Move / Hover / Scroll arrive real.',
                  'PointerAdded / Removed at the start/end of a session.',
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: buildVersusCard(
                title: 'synthesized (synthesized: true)',
                color: Colors.amber,
                icon: Icons.auto_awesome,
                points: const [
                  'Manufactured by GestureBinding to bridge gaps.',
                  'PointerEnter / PointerExit derived from move + hit-test.',
                  'A hover at the new location after a layout change.',
                  'Use carefully when reasoning about real input.',
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: toString sample (code block)
  // ============================================================
  final toStringSection = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.indigo.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.code,
              color: Colors.indigo.shade700,
              size: 22.0,
            ),
            const SizedBox(width: 8.0),
            const Text(
              'toString() sample',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        const Text(
          'PointerEvent overrides toString to print every diagnostic '
          'property. Useful for log-driven debugging of gesture recognizers.',
          style: TextStyle(fontSize: 12.5, height: 1.4),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade900,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Text(
            'PointerMoveEvent(\n'
            '  Offset(132.0, 78.0),\n'
            '  pointer: 42,\n'
            '  kind: touch,\n'
            '  device: 0,\n'
            '  buttons: 0x1,\n'
            '  delta: Offset(32.0, 28.0),\n'
            '  pressure: 0.91,\n'
            '  pressureMin: 0.0,\n'
            '  pressureMax: 1.0,\n'
            '  embedderId: 0,\n'
            ')',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'monospace',
              fontSize: 12.0,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.indigo.shade200),
          ),
          child: Text(
            'event runtimeType: ${sampleMove.runtimeType}\n'
            'event.position:    ${sampleMove.position}\n'
            'event.delta:       ${sampleMove.delta}',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Real-world consumers
  // ============================================================
  final consumersSection = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.08),
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
            Icon(
              Icons.public,
              color: Colors.deepPurple.shade700,
              size: 22.0,
            ),
            const SizedBox(width: 8.0),
            const Text(
              'Real-world consumers',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Four canonical entry points where you actually receive a '
          'PointerEvent in a Flutter app.',
          style: TextStyle(fontSize: 12.5, height: 1.4),
        ),
        const SizedBox(height: 16.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: buildConsumerCard(
                title: 'GestureBinding hit-test',
                icon: Icons.center_focus_strong,
                color: Colors.deepPurple,
                body: 'The engine hands raw events to GestureBinding which '
                    'walks the render tree, dispatches to HitTestTargets and '
                    'feeds gesture arenas.',
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: buildConsumerCard(
                title: 'MouseRegion',
                icon: Icons.mouse,
                color: Colors.indigo,
                body: 'Receives PointerEnter / PointerHover / PointerExit '
                    'and drives cursor changes via SystemMouseCursors.',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: buildConsumerCard(
                title: 'Listener',
                icon: Icons.hearing,
                color: Colors.purple,
                body: 'Low-level widget exposing onPointerDown, onPointerMove, '
                    'onPointerUp, onPointerHover, onPointerCancel and '
                    'onPointerSignal callbacks.',
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: buildConsumerCard(
                title: 'RawGestureDetector',
                icon: Icons.api,
                color: Colors.deepPurple,
                body: 'Composes user-supplied GestureRecognizer instances, '
                    'each of which sees the raw PointerEvent stream.',
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Caveats
  // ============================================================
  final caveatsSection = Container(
    padding: const EdgeInsets.all(20.0),
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
              Icons.warning_amber_rounded,
              color: Colors.amber.shade800,
              size: 22.0,
            ),
            const SizedBox(width: 8.0),
            const Text(
              'Caveats',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        buildCaveat(
          title: 'pressure availability',
          body: 'Most touch hardware does NOT report real pressure; the '
              'engine emits 1.0 while pressed and 0.0 otherwise. Always '
              'inspect pressureMin / pressureMax before normalising.',
        ),
        buildCaveat(
          title: 'viewId for multi-window',
          body: 'In single-window apps viewId is always 0. With multi-view '
              'embedders (web, Linux desktop, custom hosts) you must filter '
              'or transform per-view to avoid mixing windows.',
        ),
        buildCaveat(
          title: 'embedderId semantics',
          body: 'embedderId is opaque — it is meaningful only to the '
              'platform embedder that produced it. Do not parse, compare or '
              'persist it across runs.',
        ),
        buildCaveat(
          title: 'transform vs no-transform performance',
          body: 'transformed() allocates a new event and re-projects '
              'positions. Cheap, but per-frame fan-out in deeply nested '
              'render trees adds up; avoid wrapping in needless Transforms.',
        ),
        buildCaveat(
          title: 'original chain depth',
          body: 'Walking original.original... is rarely required. If you '
              'find yourself doing it from app code, the framework probably '
              'already provides a higher-level callback.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 11: Footer takeaways
  // ============================================================
  final footer = Container(
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade700, Colors.indigo.shade500],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.35),
          blurRadius: 14.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.flag, color: Colors.white, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Takeaways',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        buildTakeaway(
          'PointerEvent is abstract. You always receive a concrete subclass.',
        ),
        buildTakeaway(
          'The ~26-field common API is identical across every subclass.',
        ),
        buildTakeaway(
          'kind classifies the device; viewId scopes to a FlutterView.',
        ),
        buildTakeaway(
          'transformed(matrix) re-projects local* fields; original walks back.',
        ),
        buildTakeaway(
          'synthesized: true means the framework fabricated the event.',
        ),
        buildTakeaway(
          'Listener / MouseRegion / GestureBinding are the four entry points.',
        ),
      ],
    ),
  );

  return Scaffold(
    backgroundColor: Colors.deepPurple.shade50,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          heroHeader,
          const SizedBox(height: 18.0),
          inheritanceSection,
          const SizedBox(height: 18.0),
          deviceKindSection,
          const SizedBox(height: 18.0),
          fieldGridSection,
          const SizedBox(height: 18.0),
          transformedSection,
          const SizedBox(height: 18.0),
          originalChainSection,
          const SizedBox(height: 18.0),
          synthesizedSection,
          const SizedBox(height: 18.0),
          toStringSection,
          const SizedBox(height: 18.0),
          consumersSection,
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
// HELPERS
// ============================================================

Widget buildHeroChip(String label, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.0, color: Colors.white),
        const SizedBox(width: 6.0),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget buildLeafChip(String name, String tooltip, MaterialColor color) {
  return Tooltip(
    message: tooltip,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7.0,
            height: 7.0,
            decoration: BoxDecoration(
              color: color.shade400,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6.0),
          Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: color.shade900,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildKindChip(
  String name,
  IconData icon,
  String body,
  MaterialColor color,
) {
  return SizedBox(
    width: 220.0,
    child: Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
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
                child: Icon(icon, size: 16.0, color: color.shade700),
              ),
              const SizedBox(width: 8.0),
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color.shade900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            body,
            style: const TextStyle(
              fontSize: 11.5,
              height: 1.4,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildFieldGroup(
  String title,
  IconData icon,
  MaterialColor color,
  List<Widget> cards,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(icon, size: 16.0, color: color.shade700),
          const SizedBox(width: 6.0),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color.shade900,
              fontSize: 14.0,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
      const SizedBox(height: 8.0),
      Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        children: cards,
      ),
    ],
  );
}

Widget buildFieldCard(
  String name,
  String type,
  String value,
  String description,
  MaterialColor color,
) {
  return SizedBox(
    width: 240.0,
    child: Container(
      padding: const EdgeInsets.all(11.0),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    color: color.shade900,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6.0,
                  vertical: 2.0,
                ),
                decoration: BoxDecoration(
                  color: color.shade100,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  type,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.0,
                    color: color.shade800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 6.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: color.shade200),
            ),
            child: Text(
              '= $value',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            description,
            style: const TextStyle(
              fontSize: 11.0,
              color: Colors.black87,
              height: 1.35,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildTransformBox({
  required String title,
  required String subtitle,
  required String position,
  required String local,
  required MaterialColor color,
  required IconData icon,
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
              child: Icon(icon, size: 14.0, color: color.shade800),
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
          subtitle,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: color.shade800,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          position,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.black87,
          ),
        ),
        Text(
          local,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget buildChainLink({
  required String step,
  required String title,
  required String detail,
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
          color: color.withValues(alpha: 0.12),
          blurRadius: 6.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24.0,
          height: 24.0,
          decoration: BoxDecoration(
            color: color.shade400,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            step,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12.5,
            color: color.shade900,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          detail,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.5,
            color: color.shade700,
          ),
        ),
      ],
    ),
  );
}

Widget buildVersusCard({
  required String title,
  required MaterialColor color,
  required IconData icon,
  required List<String> points,
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
              child: Icon(icon, size: 14.0, color: color.shade800),
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
        for (final p in points)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, right: 6.0),
                  child: Icon(
                    Icons.circle,
                    size: 6.0,
                    color: color.shade700,
                  ),
                ),
                Expanded(
                  child: Text(
                    p,
                    style: const TextStyle(
                      fontSize: 11.5,
                      height: 1.4,
                      color: Colors.black87,
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

Widget buildConsumerCard({
  required String title,
  required IconData icon,
  required MaterialColor color,
  required String body,
}) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.shade50,
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
          body,
          style: const TextStyle(
            fontSize: 11.5,
            height: 1.4,
            color: Colors.black87,
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
