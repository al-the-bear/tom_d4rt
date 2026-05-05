// D4rt test script: Deep visual demo of PointerUpEvent from gestures.dart.
// Demonstrates every documented field of PointerUpEvent across hero header,
// tap-lifecycle diagram, per-field cards, pressure visualizer, radius
// visualizer, buttons showcase, up-vs-cancel comparison, construction
// sample, real-world usage panels, caveats and a footer.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // SAMPLE EVENT INSTANCES
  // ============================================================
  // We construct several representative PointerUpEvent values so each visual
  // section can show concrete numbers rather than placeholders.
  const eventMouse = PointerUpEvent(
    timeStamp: Duration(milliseconds: 1234),
    pointer: 1,
    device: 0,
    position: Offset(140.0, 96.0),
    buttons: kPrimaryMouseButton,
    pressure: 0.0,
    pressureMin: 0.0,
    pressureMax: 1.0,
    distance: 0.0,
    distanceMax: 0.0,
    size: 0.05,
    radiusMajor: 4.5,
    radiusMinor: 4.5,
    radiusMin: 0.0,
    radiusMax: 5.0,
    orientation: 0.0,
    tilt: 0.0,
    embedderId: 0,
  );

  const eventTouch = PointerUpEvent(
    timeStamp: Duration(milliseconds: 4040),
    pointer: 17,
    kind: PointerDeviceKind.touch,
    device: 0,
    position: Offset(220.0, 340.0),
    buttons: 0,
    pressure: 0.0,
    pressureMin: 0.0,
    pressureMax: 1.0,
    distance: 0.0,
    distanceMax: 0.0,
    size: 0.18,
    radiusMajor: 12.0,
    radiusMinor: 9.0,
    radiusMin: 0.0,
    radiusMax: 24.0,
    orientation: 0.25,
    tilt: 0.10,
    embedderId: 0,
  );

  const eventStylus = PointerUpEvent(
    timeStamp: Duration(milliseconds: 9999),
    pointer: 99,
    kind: PointerDeviceKind.stylus,
    device: 2,
    position: Offset(310.0, 410.0),
    buttons: 0,
    pressure: 0.0,
    pressureMin: 0.0,
    pressureMax: 1.0,
    distance: 0.0,
    distanceMax: 8.0,
    size: 0.05,
    radiusMajor: 4.0,
    radiusMinor: 3.0,
    radiusMin: 0.0,
    radiusMax: 6.0,
    orientation: -0.5,
    tilt: 0.45,
    embedderId: 1,
  );

  // Section 1: Hero header.
  final heroHeader = Container(
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade700, Colors.green.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.4),
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
            const Icon(Icons.touch_app_outlined, size: 56.0, color: Colors.white),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'PointerUpEvent',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'package:flutter/gestures.dart',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Text(
            'Fired when a pointer leaves the surface or a mouse button is '
            'released. Always carries down == false and concludes a stream '
            'opened by a matching PointerDownEvent.',
            style: TextStyle(color: Colors.white, fontSize: 13.0),
          ),
        ),
      ],
    ),
  );

  // Section 2: Tap lifecycle diagram.
  final lifecycleDiagram = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.lightGreen.shade50, Colors.teal.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade300, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tap lifecycle: where PointerUpEvent fits',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade900,
          ),
        ),
        const SizedBox(height: 14.0),
        Text(
          'Happy path:',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.teal.shade800,
          ),
        ),
        const SizedBox(height: 8.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              buildLifecycleStep('Down', Icons.touch_app, Colors.deepPurple, 'pointer makes contact'),
              const _Chevron(color: Colors.deepPurple),
              buildLifecycleStep('Move x N', Icons.swap_horiz, Colors.indigo, 'optional drags'),
              const _Chevron(color: Colors.indigo),
              buildLifecycleStep('Move x N', Icons.swap_horiz, Colors.blue, 'until release'),
              const _Chevron(color: Colors.blue),
              buildLifecycleStep('Up', Icons.swipe_up, Colors.green, 'pointer lifts off', highlight: true),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          'Cancel path (alternative ending):',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.teal.shade800,
          ),
        ),
        const SizedBox(height: 8.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              buildLifecycleStep('Down', Icons.touch_app, Colors.deepPurple, 'pointer makes contact'),
              const _Chevron(color: Colors.deepPurple),
              buildLifecycleStep('Move x N', Icons.swap_horiz, Colors.indigo, 'gesture in flight'),
              const _Chevron(color: Colors.indigo),
              buildLifecycleStep('Cancel', Icons.cancel, Colors.red, 'arena rejected', highlight: true),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.teal.shade200),
          ),
          child: Text(
            'For every Down there is exactly one of {Up, Cancel}. PointerUpEvent '
            'is the natural completion: the user actually finished the gesture.',
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.teal.shade900,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  // Section 3: Field-by-field grid.
  final fieldCards = <Widget>[
    buildFieldCard(
      label: 'timeStamp',
      icon: Icons.access_time,
      color: Colors.indigo,
      typeText: 'Duration',
      value: '${eventMouse.timeStamp.inMilliseconds} ms',
      meaning: 'Engine timestamp when the embedder generated the up event.',
    ),
    buildFieldCard(
      label: 'pointer',
      icon: Icons.fingerprint,
      color: Colors.purple,
      typeText: 'int',
      value: '#${eventMouse.pointer}',
      meaning: 'Stable id matching the originating PointerDownEvent.',
    ),
    buildFieldCard(
      label: 'device',
      icon: Icons.usb,
      color: Colors.teal,
      typeText: 'int',
      value: '${eventMouse.device}',
      meaning: 'Hardware-level device id reported by the platform.',
    ),
    buildFieldCard(
      label: 'kind',
      icon: Icons.devices_other,
      color: Colors.cyan,
      typeText: 'PointerDeviceKind',
      value: eventMouse.kind.name,
      meaning: 'Touch, mouse, stylus, ... trackpad is not allowed for up.',
    ),
    buildFieldCard(
      label: 'position',
      icon: Icons.place,
      color: Colors.green,
      typeText: 'Offset',
      value: '(${eventMouse.position.dx.toStringAsFixed(1)}, ${eventMouse.position.dy.toStringAsFixed(1)})',
      meaning: 'Global coordinate of the lift-off in logical pixels.',
    ),
    buildFieldCard(
      label: 'localPosition',
      icon: Icons.location_searching,
      color: Colors.lightGreen,
      typeText: 'Offset',
      value: '(${eventMouse.localPosition.dx.toStringAsFixed(1)}, ${eventMouse.localPosition.dy.toStringAsFixed(1)})',
      meaning: 'Same as position when no transform is set on the receiver.',
    ),
    buildFieldCard(
      label: 'buttons',
      icon: Icons.mouse,
      color: Colors.orange,
      typeText: 'int (bitmask)',
      value: '0x${eventMouse.buttons.toRadixString(16)}',
      meaning: 'Buttons that were pressed at the moment of release.',
    ),
    buildFieldCard(
      label: 'pressure',
      icon: Icons.compress,
      color: Colors.red,
      typeText: 'double',
      value: eventMouse.pressure.toStringAsFixed(2),
      meaning: 'Usually 0.0 because the pointer no longer presses the surface.',
    ),
    buildFieldCard(
      label: 'pressureMin',
      icon: Icons.expand_more,
      color: Colors.pink,
      typeText: 'double',
      value: eventMouse.pressureMin.toStringAsFixed(2),
      meaning: 'Minimum pressure the device can ever report.',
    ),
    buildFieldCard(
      label: 'pressureMax',
      icon: Icons.expand_less,
      color: Colors.red,
      typeText: 'double',
      value: eventMouse.pressureMax.toStringAsFixed(2),
      meaning: 'Maximum pressure the device can ever report.',
    ),
    buildFieldCard(
      label: 'distance',
      icon: Icons.straighten,
      color: Colors.amber,
      typeText: 'double',
      value: eventMouse.distance.toStringAsFixed(2),
      meaning: '0.0 since the pointer was just touching the surface.',
    ),
    buildFieldCard(
      label: 'distanceMax',
      icon: Icons.height,
      color: Colors.deepOrange,
      typeText: 'double',
      value: eventMouse.distanceMax.toStringAsFixed(2),
      meaning: 'Maximum distance the device can detect (hover range).',
    ),
    buildFieldCard(
      label: 'size',
      icon: Icons.crop_square,
      color: Colors.blue,
      typeText: 'double',
      value: eventMouse.size.toStringAsFixed(2),
      meaning: 'Normalized contact area in [0, 1]; mostly meaningful for touch.',
    ),
    buildFieldCard(
      label: 'radiusMajor',
      icon: Icons.radio_button_checked,
      color: Colors.deepPurple,
      typeText: 'double',
      value: eventMouse.radiusMajor.toStringAsFixed(2),
      meaning: 'Major axis of the ellipse describing the contact patch.',
    ),
    buildFieldCard(
      label: 'radiusMinor',
      icon: Icons.radio_button_unchecked,
      color: Colors.purple,
      typeText: 'double',
      value: eventMouse.radiusMinor.toStringAsFixed(2),
      meaning: 'Minor axis of the contact ellipse.',
    ),
    buildFieldCard(
      label: 'radiusMin',
      icon: Icons.minimize,
      color: Colors.brown,
      typeText: 'double',
      value: eventMouse.radiusMin.toStringAsFixed(2),
      meaning: 'Smallest reportable radius for the device.',
    ),
    buildFieldCard(
      label: 'radiusMax',
      icon: Icons.add,
      color: Colors.lime,
      typeText: 'double',
      value: eventMouse.radiusMax.toStringAsFixed(2),
      meaning: 'Largest reportable radius for the device.',
    ),
    buildFieldCard(
      label: 'orientation',
      icon: Icons.rotate_right,
      color: Colors.lightBlue,
      typeText: 'double (radians)',
      value: eventMouse.orientation.toStringAsFixed(2),
      meaning: 'Angle of the major axis from -pi to pi.',
    ),
    buildFieldCard(
      label: 'tilt',
      icon: Icons.architecture,
      color: Colors.indigo,
      typeText: 'double (radians)',
      value: eventMouse.tilt.toStringAsFixed(2),
      meaning: 'Stylus tilt away from the surface normal in [0, pi/2].',
    ),
    buildFieldCard(
      label: 'embedderId',
      icon: Icons.code,
      color: Colors.grey,
      typeText: 'int',
      value: '${eventMouse.embedderId}',
      meaning: 'Engine-side identifier carried through unchanged.',
    ),
    buildFieldCard(
      label: 'down',
      icon: Icons.arrow_downward,
      color: Colors.blueGrey,
      typeText: 'bool (constant)',
      value: '${eventMouse.down}',
      meaning: 'Always false for up events; the pointer has lifted.',
    ),
  ];

  final fieldGrid = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Field-by-field reference',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade900,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Sample values taken from the canonical mouse PointerUpEvent above.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: fieldCards,
        ),
      ],
    ),
  );

  // Section 4: Pressure visualizer.
  const pressureFrames = <_PressureFrame>[
    _PressureFrame(value: 0.0, label: '0.00', note: 'fully released'),
    _PressureFrame(value: 0.25, label: '0.25', note: 'glancing'),
    _PressureFrame(value: 0.5, label: '0.50', note: 'medium'),
    _PressureFrame(value: 0.75, label: '0.75', note: 'firm'),
    _PressureFrame(value: 1.0, label: '1.00', note: 'maximum'),
  ];

  final pressurePanels = pressureFrames.map((f) => _buildPressurePanel(f)).toList(growable: false);

  final pressureSection = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade200, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pressure visualizer',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.red.shade900,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'Although PointerUpEvent.pressure is conventionally 0.0, some platforms '
          'report the last sampled pressure. Below, concentric rings scale with '
          'pressure to make the field intuitive.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.red.shade800,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: pressurePanels,
        ),
      ],
    ),
  );

  // Section 5: Radius visualizer.
  const radiusValues = <double>[2.0, 5.0, 8.0, 10.0, 12.0];
  final radiusPanels = radiusValues.map(buildRadiusPanel).toList(growable: false);

  final radiusSection = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade50, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade200, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'radiusMajor visualizer',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade900,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'A 100x100 frame for each panel showing a filled circle of the listed '
          'radius. radiusMinor follows the same scale; the difference between '
          'them encodes contact-patch eccentricity.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.deepPurple.shade800,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: radiusPanels,
        ),
      ],
    ),
  );

  // Section 6: Buttons showcase.
  const buttonInfos = <_ButtonInfo>[
    _ButtonInfo(
      name: 'kPrimaryMouseButton',
      bits: kPrimaryMouseButton,
      color: Colors.blue,
      icon: Icons.mouse,
      description: 'Left button on a right-handed mouse; main contact bit.',
    ),
    _ButtonInfo(
      name: 'kSecondaryMouseButton',
      bits: kSecondaryMouseButton,
      color: Colors.purple,
      icon: Icons.mouse_outlined,
      description: 'Right button. Triggers context menus on most desktops.',
    ),
    _ButtonInfo(
      name: 'kTertiaryButton',
      bits: kTertiaryButton,
      color: Colors.teal,
      icon: Icons.adjust,
      description: 'Middle button / wheel click. Often used for paste on Linux.',
    ),
    _ButtonInfo(
      name: 'kBackMouseButton',
      bits: kBackMouseButton,
      color: Colors.orange,
      icon: Icons.arrow_back,
      description: 'X1 thumb button on multi-button mice. Browser back.',
    ),
    _ButtonInfo(
      name: 'kForwardMouseButton',
      bits: kForwardMouseButton,
      color: Colors.green,
      icon: Icons.arrow_forward,
      description: 'X2 thumb button on multi-button mice. Browser forward.',
    ),
  ];

  final buttonsPanels = buttonInfos.map(_buildButtonPanel).toList(growable: false);

  final buttonsSection = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.orange.shade300, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'buttons bitmask showcase',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.orange.shade900,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'PointerUpEvent.buttons reports which mouse buttons were down at the '
          'instant of release. Compare against the constants below using bitwise '
          'AND. The bits are platform-specific only for kBack/kForward.',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.orange.shade800,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: buttonsPanels,
        ),
      ],
    ),
  );

  // Section 7: Up vs Cancel.
  final upVsCancel = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: const Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PointerUpEvent vs PointerCancelEvent',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade900,
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: [
            buildComparisonCard(
              title: 'PointerUpEvent',
              subtitle: 'happy-path completion',
              color: Colors.green,
              icon: Icons.check_circle,
              points: const [
                'Fired when the user lifts a finger / releases a button.',
                'Gesture recognizers may treat it as a successful tap.',
                'down == false; pressure typically 0.0.',
                'Position is the final lift-off coordinate.',
              ],
              arrowIcon: Icons.arrow_forward,
            ),
            buildComparisonCard(
              title: 'PointerCancelEvent',
              subtitle: 'aborted gesture',
              color: Colors.red,
              icon: Icons.cancel,
              points: const [
                'Fired when the gesture arena rejects the pointer.',
                'Triggered by scroll, route changes, OS interruptions.',
                'Recognizers must roll back any in-progress state.',
                'Position carries the last-known global coordinate.',
              ],
              arrowIcon: Icons.subdirectory_arrow_left,
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'Mnemonic: "Up" = the user said done. "Cancel" = the system said done.',
            style: TextStyle(
              fontSize: 12.5,
              fontStyle: FontStyle.italic,
              color: Colors.grey.shade800,
            ),
          ),
        ),
      ],
    ),
  );

  // Section 8: Construction sample.
  const constructorSnippet = '''const PointerUpEvent(
  timeStamp: Duration(milliseconds: 1234),
  pointer: 1,
  device: 0,
  position: Offset(140, 96),
  buttons: kPrimaryMouseButton,
  pressure: 0.0,
  pressureMin: 0.0,
  pressureMax: 1.0,
  distance: 0.0,
  distanceMax: 0.0,
  size: 0.05,
  radiusMajor: 4.5,
  radiusMinor: 4.5,
  radiusMin: 0.0,
  radiusMax: 5.0,
  orientation: 0.0,
  tilt: 0.0,
  embedderId: 0,
);''';

  final constructionSample = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blueGrey.shade200, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Construction sample',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey.shade900,
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E2E),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 6.0,
                offset: const Offset(0.0, 3.0),
              ),
            ],
          ),
          child: const Text(
            constructorSnippet,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Color(0xFFE0E0E0),
              height: 1.35,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          'Resulting field values:',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13.5,
            color: Colors.blueGrey.shade800,
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 8.0,
          children: [
            buildKvChip('timeStamp', '${eventMouse.timeStamp.inMilliseconds} ms'),
            buildKvChip('pointer', '${eventMouse.pointer}'),
            buildKvChip('device', '${eventMouse.device}'),
            buildKvChip('kind', eventMouse.kind.name),
            buildKvChip('position', '(${eventMouse.position.dx.toStringAsFixed(1)}, ${eventMouse.position.dy.toStringAsFixed(1)})'),
            buildKvChip('buttons', '0x${eventMouse.buttons.toRadixString(16)}'),
            buildKvChip('pressure', eventMouse.pressure.toStringAsFixed(2)),
            buildKvChip('pressureMin', eventMouse.pressureMin.toStringAsFixed(2)),
            buildKvChip('pressureMax', eventMouse.pressureMax.toStringAsFixed(2)),
            buildKvChip('distance', eventMouse.distance.toStringAsFixed(2)),
            buildKvChip('distanceMax', eventMouse.distanceMax.toStringAsFixed(2)),
            buildKvChip('size', eventMouse.size.toStringAsFixed(2)),
            buildKvChip('radiusMajor', eventMouse.radiusMajor.toStringAsFixed(2)),
            buildKvChip('radiusMinor', eventMouse.radiusMinor.toStringAsFixed(2)),
            buildKvChip('radiusMin', eventMouse.radiusMin.toStringAsFixed(2)),
            buildKvChip('radiusMax', eventMouse.radiusMax.toStringAsFixed(2)),
            buildKvChip('orientation', eventMouse.orientation.toStringAsFixed(2)),
            buildKvChip('tilt', eventMouse.tilt.toStringAsFixed(2)),
            buildKvChip('embedderId', '${eventMouse.embedderId}'),
            buildKvChip('down', '${eventMouse.down}'),
          ],
        ),
      ],
    ),
  );

  // Section 9: Real-world usage panels.
  final realWorldSection = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade50, Colors.blue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.cyan.shade300, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Real-world usage',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.cyan.shade900,
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 14.0,
          runSpacing: 14.0,
          children: [
            buildUsagePanel(
              title: 'Custom slider release',
              icon: Icons.tune,
              color: Colors.indigo,
              body: 'A bespoke slider listens for PointerUpEvent to commit the '
                  'final value. Move events stream interim values; the up event '
                  'finalises them so listeners can persist or animate.',
              eventDemo: eventMouse,
            ),
            buildUsagePanel(
              title: 'Click confirmation',
              icon: Icons.touch_app,
              color: Colors.green,
              body: 'A button fires its onPressed only when both PointerDownEvent '
                  'and PointerUpEvent occur within its hit area. The up event is '
                  'the gate; if it never arrives, the click is discarded.',
              eventDemo: eventTouch,
            ),
            buildUsagePanel(
              title: 'Tap-up haptics',
              icon: Icons.vibration,
              color: Colors.deepOrange,
              body: 'On release, a UI may schedule haptic feedback (description '
                  'only — no service calls in this demo). PointerUpEvent is the '
                  'natural cue because the user has just confirmed the action.',
              eventDemo: eventStylus,
            ),
          ],
        ),
      ],
    ),
  );

  // Section 10: Caveats.
  final caveatsSection = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
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
            Icon(Icons.warning_amber, color: Colors.amber.shade800, size: 24.0),
            const SizedBox(width: 8.0),
            Text(
              'Caveats',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        buildCaveat(
          title: 'Synthetic up events from cancelled gestures',
          body: 'When a gesture loses the arena, Flutter may synthesise a '
              'PointerCancelEvent rather than a PointerUpEvent. Application '
              'code that only listens for up will silently drop these.',
        ),
        buildCaveat(
          title: 'Platform-specific button bitmasks',
          body: 'kBackMouseButton and kForwardMouseButton are not standardised '
              'across all OSes. On platforms that do not surface these buttons, '
              'PointerUpEvent.buttons will not include the bits even if the '
              'physical button was actuated.',
        ),
        buildCaveat(
          title: 'Pressure availability',
          body: 'pressure is meaningful only on devices that report it (3D '
              'Touch, force-touch trackpads, some stylii). For ordinary mice '
              'and capacitive touch screens, PointerUpEvent.pressure is 0.0 '
              'or 1.0 depending on the platform.',
        ),
        buildCaveat(
          title: 'Coordinate space',
          body: 'position is in the global coordinate space. Use '
              'localPosition (or pass through PointerEvent.transformed) when '
              'you need coordinates relative to a specific render object.',
        ),
        buildCaveat(
          title: 'Trackpad pointer kind',
          body: 'PointerUpEvent forbids PointerDeviceKind.trackpad in its '
              'constructor; trackpad gestures use PointerPanZoom* events '
              'instead. Code branching on kind must account for this.',
        ),
      ],
    ),
  );

  // Section 11: Footer takeaways.
  final footer = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade700, Colors.blue.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.flag, color: Colors.white, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'Takeaways',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        buildTakeaway('PointerUpEvent ends a Down/Move stream the natural way.'),
        buildTakeaway('down == false and pressure is conventionally 0.0.'),
        buildTakeaway('buttons reports the final pressed bitmask before release.'),
        buildTakeaway('Always pair with PointerCancelEvent in real handlers.'),
        buildTakeaway('Use position for global coords, localPosition inside widgets.'),
        buildTakeaway('Pressure / radius / tilt are device-dependent extras.'),
        buildTakeaway('Recognizers like TapGestureRecognizer rely on Up to fire.'),
      ],
    ),
  );

  return Scaffold(
    backgroundColor: Colors.grey.shade100,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          heroHeader,
          lifecycleDiagram,
          fieldGrid,
          pressureSection,
          radiusSection,
          buttonsSection,
          upVsCancel,
          constructionSample,
          realWorldSection,
          caveatsSection,
          footer,
        ],
      ),
    ),
  );
}

// ============================================================
// HELPER BUILDERS (top-level functions)
// ============================================================

Widget buildLifecycleStep(
  String label,
  IconData icon,
  MaterialColor color,
  String note, {
  bool highlight = false,
}) {
  return Container(
    width: 132.0,
    margin: const EdgeInsets.symmetric(horizontal: 4.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: highlight
            ? [color.shade400, color.shade700]
            : [color.shade100, color.shade200],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: highlight ? color.shade900 : color.shade300,
        width: highlight ? 2.0 : 1.0,
      ),
      boxShadow: highlight
          ? [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 8.0,
                offset: const Offset(0.0, 3.0),
              ),
            ]
          : null,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: highlight ? Colors.white : color.shade800,
          size: 28.0,
        ),
        const SizedBox(height: 6.0),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: highlight ? Colors.white : color.shade900,
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          note,
          style: TextStyle(
            fontSize: 10.5,
            color: highlight
                ? Colors.white.withValues(alpha: 0.9)
                : color.shade800,
          ),
        ),
      ],
    ),
  );
}

Widget buildFieldCard({
  required String label,
  required IconData icon,
  required MaterialColor color,
  required String typeText,
  required String value,
  required String meaning,
}) {
  return Container(
    width: 230.0,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.shade50, color.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
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
            Icon(icon, color: color.shade700, size: 20.0),
            const SizedBox(width: 6.0),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.5,
                  fontFamily: 'monospace',
                  color: color.shade900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: color.shade700,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            typeText,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'monospace',
              fontSize: 10.0,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
              fontSize: 12.0,
              color: color.shade900,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          meaning,
          style: TextStyle(
            fontSize: 11.0,
            color: color.shade900,
            height: 1.3,
          ),
        ),
      ],
    ),
  );
}

Widget _buildPressurePanel(_PressureFrame frame) {
  final clamped = frame.value.clamp(0.0, 1.0);
  final outerRadius = 16.0 + 24.0 * clamped;
  final innerRadius = 6.0 + 14.0 * clamped;
  final outerAlpha = 0.15 + 0.45 * clamped;
  final innerAlpha = 0.35 + 0.55 * clamped;

  return Container(
    width: 130.0,
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.red.shade200),
    ),
    child: Column(
      children: [
        SizedBox(
          width: 96.0,
          height: 96.0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 96.0,
                height: 96.0,
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              Container(
                width: outerRadius * 2,
                height: outerRadius * 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red.withValues(alpha: outerAlpha),
                ),
              ),
              Container(
                width: innerRadius * 2,
                height: innerRadius * 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red.withValues(alpha: innerAlpha),
                ),
              ),
              Text(
                frame.label,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 11.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'pressure',
          style: TextStyle(
            fontSize: 10.5,
            color: Colors.red.shade700,
            fontFamily: 'monospace',
          ),
        ),
        Text(
          frame.note,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
            color: Colors.red.shade900,
          ),
        ),
      ],
    ),
  );
}

Widget buildRadiusPanel(double radius) {
  return Container(
    width: 130.0,
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.deepPurple.shade200),
    ),
    child: Column(
      children: [
        SizedBox(
          width: 100.0,
          height: 100.0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.deepPurple.shade200,
                    width: 1.0,
                  ),
                ),
              ),
              Container(
                width: radius * 2,
                height: radius * 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple.withValues(alpha: 0.7),
                ),
              ),
              Positioned(
                left: 4.0,
                top: 4.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 1.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade700,
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: Text(
                    '100x100',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 8.5,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'radiusMajor',
          style: TextStyle(
            fontSize: 10.5,
            color: Colors.deepPurple.shade700,
            fontFamily: 'monospace',
          ),
        ),
        Text(
          radius.toStringAsFixed(1),
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade900,
          ),
        ),
      ],
    ),
  );
}

Widget _buildButtonPanel(_ButtonInfo info) {
  return Container(
    width: 220.0,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [info.color.shade50, info.color.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: info.color.shade300, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 70.0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 60.0,
                height: 70.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: info.color.shade400,
                    width: 1.5,
                  ),
                ),
              ),
              Positioned(
                top: 6.0,
                child: Container(
                  width: 18.0,
                  height: 18.0,
                  decoration: BoxDecoration(
                    color: info.color.shade400,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
              Positioned(
                top: 30.0,
                child: Transform.scale(
                  scale: 1.2,
                  child: Icon(
                    info.icon,
                    color: info.color.shade700,
                    size: 24.0,
                  ),
                ),
              ),
              Positioned(
                bottom: 4.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 2.0,
                  ),
                  decoration: BoxDecoration(
                    color: info.color.shade700,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    '0x${info.bits.toRadixString(16).padLeft(2, '0')}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9.0,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        Tooltip(
          message: info.name,
          child: Text(
            info.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              fontFamily: 'monospace',
              color: info.color.shade900,
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        Wrap(
          spacing: 4.0,
          runSpacing: 4.0,
          children: [
            Chip(
              label: Text(
                'bits: ${info.bits}',
                style: const TextStyle(fontSize: 10.0, fontFamily: 'monospace'),
              ),
              backgroundColor: info.color.shade200,
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              visualDensity: VisualDensity.compact,
            ),
            Chip(
              label: Text(
                'bin: ${info.bits.toRadixString(2)}',
                style: const TextStyle(fontSize: 10.0, fontFamily: 'monospace'),
              ),
              backgroundColor: info.color.shade100,
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          info.description,
          style: TextStyle(
            fontSize: 11.0,
            color: info.color.shade900,
            height: 1.3,
          ),
        ),
      ],
    ),
  );
}

Widget buildComparisonCard({
  required String title,
  required String subtitle,
  required MaterialColor color,
  required IconData icon,
  required List<String> points,
  required IconData arrowIcon,
}) {
  return Container(
    width: 320.0,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 8.0,
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
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: color.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color.shade700, size: 22.0),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: color.shade900,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontStyle: FontStyle.italic,
                      color: color.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          height: 38.0,
          child: Row(
            children: [
              Container(
                width: 14.0,
                height: 14.0,
                decoration: BoxDecoration(
                  color: color.shade300,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Container(
                  height: 3.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    color: color.shade400,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
              Icon(arrowIcon, color: color.shade700, size: 22.0),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        ...points.map(
          (p) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, right: 6.0),
                  child: Icon(
                    Icons.fiber_manual_record,
                    size: 8.0,
                    color: color.shade400,
                  ),
                ),
                Expanded(
                  child: Text(
                    p,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: color.shade900,
                      height: 1.35,
                    ),
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

Widget buildKvChip(String key, String value) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: Colors.blueGrey.shade50,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: Colors.blueGrey.shade200),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          key,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.blueGrey.shade700,
          ),
        ),
        const SizedBox(width: 4.0),
        Text(
          '=',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.blueGrey.shade400,
          ),
        ),
        const SizedBox(width: 4.0),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey.shade900,
          ),
        ),
      ],
    ),
  );
}

Widget buildUsagePanel({
  required String title,
  required IconData icon,
  required MaterialColor color,
  required String body,
  required PointerUpEvent eventDemo,
}) {
  return Container(
    width: 280.0,
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: const Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color.shade700, size: 22.0),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: color.shade900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          body,
          style: TextStyle(
            fontSize: 12.0,
            color: color.shade900,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: color.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'demo event',
                style: TextStyle(
                  fontSize: 10.0,
                  color: color.shade700,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 4.0),
              buildKvLine('kind', eventDemo.kind.name),
              buildKvLine('pointer', '${eventDemo.pointer}'),
              buildKvLine(
                'position',
                '(${eventDemo.position.dx.toStringAsFixed(1)}, ${eventDemo.position.dy.toStringAsFixed(1)})',
              ),
              buildKvLine('buttons', '0x${eventDemo.buttons.toRadixString(16)}'),
              buildKvLine('pressure', eventDemo.pressure.toStringAsFixed(2)),
              buildKvLine('down', '${eventDemo.down}'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildKvLine(String key, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1.0),
    child: Row(
      children: [
        SizedBox(
          width: 70.0,
          child: Text(
            key,
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

Widget buildCaveat({required String title, required String body}) {
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

// ============================================================
// VALUE CLASSES
// ============================================================

class _PressureFrame {
  final double value;
  final String label;
  final String note;
  const _PressureFrame({
    required this.value,
    required this.label,
    required this.note,
  });
}

class _ButtonInfo {
  final String name;
  final int bits;
  final MaterialColor color;
  final IconData icon;
  final String description;
  const _ButtonInfo({
    required this.name,
    required this.bits,
    required this.color,
    required this.icon,
    required this.description,
  });
}

class _Chevron extends StatelessWidget {
  final MaterialColor color;
  const _Chevron({required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Icon(
        Icons.chevron_right,
        color: color.shade400,
        size: 28.0,
      ),
    );
  }
}
