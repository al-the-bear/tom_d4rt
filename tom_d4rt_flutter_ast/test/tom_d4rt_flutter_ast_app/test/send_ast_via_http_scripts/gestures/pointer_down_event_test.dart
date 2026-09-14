// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last
// D4rt test script: Deep visual demo of PointerDownEvent from gestures.dart.
// Demonstrates every documented field of PointerDownEvent across hero header,
// anatomy diagram, per-field cards, Listener / RawGestureDetector recipes,
// pitfalls, comparison with sibling pointer events, kind/buttons matrix,
// quick-reference and ASCII footer.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // SAMPLE EVENT INSTANCES
  // ============================================================
  // We construct a handful of representative PointerDownEvent values so each
  // field has a concrete number to display in the visual cards below.
  final eventTouch = PointerDownEvent(
    timeStamp: Duration(milliseconds: 1234),
    pointer: 17,
    kind: PointerDeviceKind.touch,
    device: 0,
    position: Offset(220.0, 340.0),
    buttons: kPrimaryButton,
    obscured: false,
    pressure: 0.62,
    pressureMin: 0.0,
    pressureMax: 1.0,
    distanceMax: 0.0,
    size: 0.18,
    radiusMajor: 12.0,
    radiusMinor: 9.0,
    radiusMin: 0.0,
    radiusMax: 24.0,
    orientation: 0.25,
    tilt: 0.10,
    embedderId: 0,
    viewId: 0,
  );

  final eventMouse = PointerDownEvent(
    timeStamp: Duration(milliseconds: 7777),
    pointer: 42,
    kind: PointerDeviceKind.mouse,
    device: 1,
    position: Offset(120.0, 80.0),
    buttons: kSecondaryMouseButton,
    obscured: false,
    pressure: 1.0,
    pressureMin: 1.0,
    pressureMax: 1.0,
    distanceMax: 0.0,
    size: 0.0,
    radiusMajor: 0.0,
    radiusMinor: 0.0,
    radiusMin: 0.0,
    radiusMax: 0.0,
    orientation: 0.0,
    tilt: 0.0,
    embedderId: 0,
    viewId: 0,
  );

  final eventStylus = PointerDownEvent(
    timeStamp: Duration(milliseconds: 9999),
    pointer: 99,
    kind: PointerDeviceKind.stylus,
    device: 2,
    position: Offset(310.0, 410.0),
    buttons: kStylusContact,
    obscured: false,
    pressure: 0.85,
    pressureMin: 0.0,
    pressureMax: 1.0,
    distanceMax: 8.0,
    size: 0.05,
    radiusMajor: 4.0,
    radiusMinor: 3.0,
    radiusMin: 0.0,
    radiusMax: 6.0,
    orientation: -0.5,
    tilt: 0.45,
    embedderId: 1,
    viewId: 0,
  );

  // ============================================================
  // SECTION 1: HERO HEADER
  // ============================================================
  final heroHeader = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade700, Colors.indigo.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.4),
          blurRadius: 18.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.touch_app, size: 56.0, color: Colors.white),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PointerDownEvent',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'A pointer has made contact with the device.\n'
            'Always has down == true and distance == 0.0.',
            style: TextStyle(color: Colors.white, fontSize: 13.0),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: ANATOMY OF A POINTER-DOWN EVENT
  // ============================================================
  final anatomyDiagram = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade50, Colors.blue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.cyan.shade300, width: 2.0),
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
        Text(
          'Anatomy of PointerDownEvent',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.cyan.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        _buildAnatomyRow(Icons.access_time, 'timeStamp', 'when the engine dispatched the event', Colors.indigo),
        _buildAnatomyRow(Icons.fingerprint, 'pointer', 'unique identifier per finger / stylus / cursor', Colors.purple),
        _buildAnatomyRow(Icons.devices, 'kind', 'PointerDeviceKind: touch, mouse, stylus, ...', Colors.blue),
        _buildAnatomyRow(Icons.usb, 'device', 'physical device id from the embedder', Colors.teal),
        _buildAnatomyRow(Icons.place, 'position', 'global coordinates in logical pixels', Colors.green),
        _buildAnatomyRow(Icons.location_searching, 'localPosition', 'coordinates inside the receiving widget', Colors.lightGreen),
        _buildAnatomyRow(Icons.mouse, 'buttons', 'bitmask of pressed buttons / contact bits', Colors.orange),
        _buildAnatomyRow(Icons.visibility_off, 'obscured', 'true if the pointer was over an obscured area', Colors.brown),
        _buildAnatomyRow(Icons.compress, 'pressure', 'normalized pressure in [pressureMin, pressureMax]', Colors.red),
        _buildAnatomyRow(Icons.swap_vert, 'distance / distanceMax', 'down == 0.0; max for hover-capable devices', Colors.pink),
        _buildAnatomyRow(Icons.crop_square, 'size', 'normalized contact area in [0, 1]', Colors.deepOrange),
        _buildAnatomyRow(Icons.radio_button_checked, 'radiusMajor / Minor', 'ellipse axes of contact patch', Colors.amber),
        _buildAnatomyRow(Icons.rotate_right, 'orientation', 'angle of the major axis (radians)', Colors.lime),
        _buildAnatomyRow(Icons.architecture, 'tilt', 'stylus tilt off the screen normal (radians)', Colors.deepPurple),
        _buildAnatomyRow(Icons.code, 'embedderId / viewId', 'engine-side identifiers', Colors.grey),
        _buildAnatomyRow(Icons.transform, 'transform', 'matrix mapping global → local coords', Colors.blueGrey),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: PER-FIELD CARDS (using eventTouch as canonical sample)
  // ============================================================
  final fieldCards = <Widget>[
    _buildFieldCard(
      label: 'timeStamp',
      icon: Icons.access_time,
      color: Colors.indigo,
      value: '${eventTouch.timeStamp.inMilliseconds} ms',
      meaning: 'Engine timestamp at which the embedder generated the event.',
      typeText: 'Duration',
    ),
    _buildFieldCard(
      label: 'pointer',
      icon: Icons.fingerprint,
      color: Colors.purple,
      value: '#${eventTouch.pointer}',
      meaning: 'Unique id for this contact. Stable from down to up/cancel.',
      typeText: 'int',
    ),
    _buildFieldCard(
      label: 'kind',
      icon: Icons.devices,
      color: Colors.blue,
      value: eventTouch.kind.name,
      meaning: 'Kind of input device. trackpad is invalid for PointerDown.',
      typeText: 'PointerDeviceKind',
    ),
    _buildFieldCard(
      label: 'device',
      icon: Icons.usb,
      color: Colors.teal,
      value: '${eventTouch.device}',
      meaning: 'Hardware-level device id from the platform.',
      typeText: 'int',
    ),
    _buildFieldCard(
      label: 'position',
      icon: Icons.place,
      color: Colors.green,
      value: '(${eventTouch.position.dx.toStringAsFixed(1)}, ${eventTouch.position.dy.toStringAsFixed(1)})',
      meaning: 'Global coordinate of the contact in logical pixels.',
      typeText: 'Offset',
    ),
    _buildFieldCard(
      label: 'localPosition',
      icon: Icons.location_searching,
      color: Colors.lightGreen,
      value: '(${eventTouch.localPosition.dx.toStringAsFixed(1)}, ${eventTouch.localPosition.dy.toStringAsFixed(1)})',
      meaning: 'Same as position when no transform is set.',
      typeText: 'Offset',
    ),
    _buildFieldCard(
      label: 'buttons',
      icon: Icons.mouse,
      color: Colors.orange,
      value: '0x${eventTouch.buttons.toRadixString(16)}',
      meaning: 'Bitmask of pressed buttons (kPrimaryButton, kSecondaryButton ...).',
      typeText: 'int',
    ),
    _buildFieldCard(
      label: 'obscured',
      icon: Icons.visibility_off,
      color: Colors.brown,
      value: '${eventTouch.obscured}',
      meaning: 'True if some other UI obscured the receiver at dispatch time.',
      typeText: 'bool',
    ),
    _buildFieldCard(
      label: 'pressure',
      icon: Icons.compress,
      color: Colors.red,
      value: eventTouch.pressure.toStringAsFixed(2),
      meaning: 'Normalized pressure within [pressureMin, pressureMax].',
      typeText: 'double',
    ),
    _buildFieldCard(
      label: 'pressureMin',
      icon: Icons.expand_more,
      color: Colors.pink,
      value: eventTouch.pressureMin.toStringAsFixed(2),
      meaning: 'Minimum pressure the device can report.',
      typeText: 'double',
    ),
    _buildFieldCard(
      label: 'pressureMax',
      icon: Icons.expand_less,
      color: Colors.pinkAccent,
      value: eventTouch.pressureMax.toStringAsFixed(2),
      meaning: 'Maximum pressure the device can report.',
      typeText: 'double',
    ),
    _buildFieldCard(
      label: 'distance',
      icon: Icons.straighten,
      color: Colors.cyan,
      value: eventTouch.distance.toStringAsFixed(2),
      meaning: 'Always 0.0 for PointerDown — the pointer is in contact.',
      typeText: 'double',
    ),
    _buildFieldCard(
      label: 'distanceMax',
      icon: Icons.height,
      color: Colors.lightBlue,
      value: eventTouch.distanceMax.toStringAsFixed(2),
      meaning: 'Maximum hover distance the device can report.',
      typeText: 'double',
    ),
    _buildFieldCard(
      label: 'size',
      icon: Icons.crop_square,
      color: Colors.deepOrange,
      value: eventTouch.size.toStringAsFixed(2),
      meaning: 'Normalized contact area in [0, 1]. 0 if not reported.',
      typeText: 'double',
    ),
    _buildFieldCard(
      label: 'radiusMajor',
      icon: Icons.radio_button_checked,
      color: Colors.amber,
      value: eventTouch.radiusMajor.toStringAsFixed(2),
      meaning: 'Length of the major axis of the contact ellipse.',
      typeText: 'double',
    ),
    _buildFieldCard(
      label: 'radiusMinor',
      icon: Icons.radio_button_unchecked,
      color: Colors.amberAccent,
      value: eventTouch.radiusMinor.toStringAsFixed(2),
      meaning: 'Length of the minor axis of the contact ellipse.',
      typeText: 'double',
    ),
    _buildFieldCard(
      label: 'radiusMin',
      icon: Icons.unfold_less,
      color: Colors.yellow.shade700,
      value: eventTouch.radiusMin.toStringAsFixed(2),
      meaning: 'Minimum radius the device can report.',
      typeText: 'double',
    ),
    _buildFieldCard(
      label: 'radiusMax',
      icon: Icons.unfold_more,
      color: Colors.yellow.shade900,
      value: eventTouch.radiusMax.toStringAsFixed(2),
      meaning: 'Maximum radius the device can report.',
      typeText: 'double',
    ),
    _buildFieldCard(
      label: 'orientation',
      icon: Icons.rotate_right,
      color: Colors.lime,
      value: '${eventTouch.orientation.toStringAsFixed(2)} rad',
      meaning: 'Angle of the major axis. Touch: [-π, π]. Stylus: [-π, π].',
      typeText: 'double',
    ),
    _buildFieldCard(
      label: 'tilt',
      icon: Icons.architecture,
      color: Colors.deepPurple,
      value: '${eventTouch.tilt.toStringAsFixed(2)} rad',
      meaning: 'Stylus angle from the screen normal in [0, π/2].',
      typeText: 'double',
    ),
    _buildFieldCard(
      label: 'embedderId',
      icon: Icons.code,
      color: Colors.grey,
      value: '${eventTouch.embedderId}',
      meaning: 'Embedder-supplied identifier for cross-engine plumbing.',
      typeText: 'int',
    ),
    _buildFieldCard(
      label: 'viewId',
      icon: Icons.window,
      color: Colors.blueGrey,
      value: '${eventTouch.viewId}',
      meaning: 'Identifier of the FlutterView that received the event.',
      typeText: 'int',
    ),
    _buildFieldCard(
      label: 'transform',
      icon: Icons.transform,
      color: Colors.indigo,
      value: eventTouch.transform == null ? 'null' : 'Matrix4',
      meaning: 'Optional matrix mapping global to local coordinates.',
      typeText: 'Matrix4?',
    ),
  ];

  // ============================================================
  // SECTION 4: LISTENER RECIPE
  // ============================================================
  final listenerRecipe = _buildRecipeCard(
    title: 'Recipe: Listener widget',
    color: Colors.green,
    headerIcon: Icons.headset_mic,
    bodyText:
        'Listener exposes raw pointer events without arena negotiation.\n'
        'Use it for low-level hit-testing or custom gesture systems.',
    code: '// Listener gives you the raw PointerDownEvent.\n'
        'Listener(\n'
        '  onPointerDown: (PointerDownEvent ev) {\n'
        '    debugPrint(\'down @ \${ev.position}\');\n'
        '    debugPrint(\'kind=\${ev.kind} pressure=\${ev.pressure}\');\n'
        '  },\n'
        '  child: const SizedBox.expand(),\n'
        ');\n',
  );

  // ============================================================
  // SECTION 5: RAW GESTURE DETECTOR RECIPE
  // ============================================================
  final rawDetectorRecipe = _buildRecipeCard(
    title: 'Recipe: RawGestureDetector',
    color: Colors.indigo,
    headerIcon: Icons.handyman,
    bodyText:
        'Wire a custom recognizer to a PointerDownEvent. The recognizer is\n'
        'fed via addPointer(event) inside a RawGestureDetector.',
    code: 'final recognizer = TapGestureRecognizer()\n'
        '  ..onTap = () => debugPrint(\'tap!\');\n\n'
        'RawGestureDetector(\n'
        '  gestures: <Type, GestureRecognizerFactory>{\n'
        '    TapGestureRecognizer:\n'
        '        GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(\n'
        '      () => TapGestureRecognizer(),\n'
        '      (TapGestureRecognizer instance) {},\n'
        '    ),\n'
        '  },\n'
        '  child: Listener(\n'
        '    onPointerDown: (PointerDownEvent e) => recognizer.addPointer(e),\n'
        '    child: const SizedBox.expand(),\n'
        '  ),\n'
        ');\n',
  );

  // ============================================================
  // SECTION 6: PITFALLS
  // ============================================================
  final pitfallsCard = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade300, width: 2.0),
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
            Icon(Icons.warning_amber_rounded, color: Colors.red.shade700, size: 28.0),
            SizedBox(width: 10.0),
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
          'PointerDeviceKind.trackpad is rejected by the constructor (assert).',
        ),
        _buildPitfallRow(
          'distance is always 0.0 — read distanceMax for hover capability.',
        ),
        _buildPitfallRow(
          'localPosition equals position only when no transform is supplied.',
        ),
        _buildPitfallRow(
          'pressure on devices without pressure sensing is reported as 1.0.',
        ),
        _buildPitfallRow(
          'pointer is the logical id; device is the physical id — they differ!',
        ),
        _buildPitfallRow(
          'buttons is a bitmask, not an enum — combine kPrimaryButton | kSecondaryButton.',
        ),
        _buildPitfallRow(
          'orientation can be NaN on devices that do not report it.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: COMPARISON WITH SIBLING POINTER EVENTS
  // ============================================================
  final comparisonCard = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade50, Colors.green.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade300, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.2),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PointerDown vs siblings',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            _buildComparisonChip('PointerDownEvent', 'down=true,\ndistance=0', Icons.touch_app, Colors.green),
            SizedBox(width: 8.0),
            _buildComparisonChip('PointerMoveEvent', 'while down,\ndelta != 0', Icons.swipe, Colors.blue),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          children: [
            _buildComparisonChip('PointerUpEvent', 'down=false,\ncontact end', Icons.upload, Colors.orange),
            SizedBox(width: 8.0),
            _buildComparisonChip('PointerCancelEvent', 'aborted by\nsystem', Icons.cancel, Colors.red),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: KIND × BUTTONS MATRIX
  // ============================================================
  final matrixHeader = Container(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade100, Colors.blue.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      children: [
        _buildHeaderCell('kind', 90.0),
        _buildHeaderCell('typical buttons', 150.0),
        _buildHeaderCell('pressure', 80.0),
        _buildHeaderCell('hover', 60.0),
      ],
    ),
  );

  final matrixRows = <Widget>[
    _buildMatrixRow(
      'touch',
      'kPrimaryButton (1)',
      '0..1',
      'no',
      Colors.green,
    ),
    _buildMatrixRow(
      'mouse',
      'kPrimary | kSecondary | kMiddle',
      '1.0',
      'yes',
      Colors.blue,
    ),
    _buildMatrixRow(
      'stylus',
      'kStylusContact (4)',
      '0..1',
      'yes',
      Colors.purple,
    ),
    _buildMatrixRow(
      'invertedStylus',
      'kStylusContact',
      '0..1',
      'yes',
      Colors.deepPurple,
    ),
    _buildMatrixRow(
      'trackpad',
      '— (PointerPanZoom*)',
      '—',
      'yes',
      Colors.grey,
    ),
    _buildMatrixRow(
      'unknown',
      'varies',
      'varies',
      'maybe',
      Colors.brown,
    ),
  ];

  final kindButtonsMatrix = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 8.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PointerDeviceKind × buttons',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        matrixHeader,
        SizedBox(height: 4.0),
        ...matrixRows,
      ],
    ),
  );

  // ============================================================
  // SECTION 9: SAMPLE EVENT VISUALS (touch / mouse / stylus)
  // ============================================================
  final samplesRow = Wrap(
    spacing: 12.0,
    runSpacing: 12.0,
    children: [
      _buildSampleCard(
        title: 'Touch sample',
        icon: Icons.fingerprint,
        color: Colors.green,
        event: eventTouch,
      ),
      _buildSampleCard(
        title: 'Mouse sample',
        icon: Icons.mouse,
        color: Colors.blue,
        event: eventMouse,
      ),
      _buildSampleCard(
        title: 'Stylus sample',
        icon: Icons.edit,
        color: Colors.purple,
        event: eventStylus,
      ),
    ],
  );

  // ============================================================
  // SECTION 10: QUICK REFERENCE
  // ============================================================
  final quickReference = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade100, Colors.orange.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.amber.shade400, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.2),
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
            Icon(Icons.menu_book, color: Colors.amber.shade900, size: 26.0),
            SizedBox(width: 8.0),
            Text(
              'Quick Reference',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildQuickRow('Class', 'PointerDownEvent extends PointerEvent'),
        _buildQuickRow('Mixin', '_CopyPointerDownEvent for copyWith'),
        _buildQuickRow('Constants', 'down = true, distance = 0.0'),
        _buildQuickRow('Forbidden', 'kind == PointerDeviceKind.trackpad'),
        _buildQuickRow('Transform', 'transformed(Matrix4) → mapped event'),
        _buildQuickRow('Companion', 'PointerUpEvent, PointerCancelEvent'),
      ],
    ),
  );

  // ============================================================
  // SECTION 11: ASCII FOOTER
  // ============================================================
  final asciiFooter = Container(
    margin: EdgeInsets.only(top: 24.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.black],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '+----------------------------------------------------+\n'
          '|  PointerDownEvent — pointer touched the surface    |\n'
          '|  down=true   distance=0.0   kind != trackpad       |\n'
          '|  position --[transform]--> localPosition           |\n'
          '|  buttons = bitmask of pressed buttons              |\n'
          '|  pressure ∈ [pressureMin, pressureMax]            |\n'
          '+----------------------------------------------------+',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: Colors.greenAccent.shade400,
            height: 1.4,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // FINAL LAYOUT
  // ============================================================
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            heroHeader,
            SizedBox(height: 24.0),
            _buildSectionTitle('1. Anatomy', Icons.account_tree),
            anatomyDiagram,
            SizedBox(height: 16.0),
            _buildSectionTitle('2. Per-field cards', Icons.dashboard_customize),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: fieldCards,
            ),
            SizedBox(height: 16.0),
            _buildSectionTitle('3. Listener recipe', Icons.headset_mic),
            listenerRecipe,
            SizedBox(height: 16.0),
            _buildSectionTitle('4. RawGestureDetector recipe', Icons.handyman),
            rawDetectorRecipe,
            SizedBox(height: 16.0),
            _buildSectionTitle('5. Pitfalls', Icons.warning_amber_rounded),
            pitfallsCard,
            SizedBox(height: 16.0),
            _buildSectionTitle('6. Comparison', Icons.compare_arrows),
            comparisonCard,
            SizedBox(height: 16.0),
            _buildSectionTitle('7. Kind × buttons matrix', Icons.grid_on),
            kindButtonsMatrix,
            SizedBox(height: 16.0),
            _buildSectionTitle('8. Sample events', Icons.science),
            samplesRow,
            SizedBox(height: 16.0),
            _buildSectionTitle('9. Quick reference', Icons.menu_book),
            quickReference,
            SizedBox(height: 16.0),
            _buildSectionTitle('10. ASCII footer', Icons.terminal),
            asciiFooter,
            SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}

// ============================================================
// HELPER WIDGETS
// ============================================================

Widget _buildSectionTitle(String text, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Icon(icon, size: 22.0, color: Colors.deepPurple),
        SizedBox(width: 8.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade900,
          ),
        ),
      ],
    ),
  );
}

Widget _buildAnatomyRow(IconData icon, String label, String text, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, size: 18.0, color: color),
        ),
        SizedBox(width: 10.0),
        SizedBox(
          width: 150.0,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade800),
          ),
        ),
      ],
    ),
  );
}

Widget _buildFieldCard({
  required String label,
  required IconData icon,
  required Color color,
  required String value,
  required String meaning,
  required String typeText,
}) {
  return Container(
    width: 220.0,
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
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
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
            Icon(icon, color: color, size: 22.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: color,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                typeText,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 9.0,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          meaning,
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade800),
        ),
      ],
    ),
  );
}

Widget _buildRecipeCard({
  required String title,
  required MaterialColor color,
  required IconData headerIcon,
  required String bodyText,
  required String code,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.shade400, color.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Row(
            children: [
              Icon(headerIcon, color: Colors.white, size: 22.0),
              SizedBox(width: 8.0),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(14.0),
          color: color.shade50,
          child: Text(
            bodyText,
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade900),
          ),
        ),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
            ),
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

Widget _buildPitfallRow(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.error_outline, color: Colors.red.shade700, size: 18.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade900),
          ),
        ),
      ],
    ),
  );
}

Widget _buildComparisonChip(String title, String desc, IconData icon, Color color) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.12),
            color.withValues(alpha: 0.25),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
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
          Icon(icon, size: 26.0, color: color),
          SizedBox(height: 4.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 2.0),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.0, color: Colors.grey.shade800),
          ),
        ],
      ),
    ),
  );
}

Widget _buildHeaderCell(String text, double width) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 11.0,
        color: Colors.deepPurple.shade900,
      ),
    ),
  );
}

Widget _buildMatrixRow(String kind, String buttons, String pressure, String hover, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.grey.shade200, width: 1.0),
      ),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 90.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              kind,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 150.0,
          child: Text(
            buttons,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'monospace', fontSize: 10.0),
          ),
        ),
        SizedBox(
          width: 80.0,
          child: Text(
            pressure,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'monospace', fontSize: 10.0),
          ),
        ),
        SizedBox(
          width: 60.0,
          child: Text(
            hover,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'monospace', fontSize: 10.0),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSampleCard({
  required String title,
  required IconData icon,
  required MaterialColor color,
  required PointerDownEvent event,
}) {
  return Container(
    width: 240.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.shade50, color.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.25),
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
            Icon(icon, color: color.shade700, size: 22.0),
            SizedBox(width: 8.0),
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
        SizedBox(height: 8.0),
        _kv('kind', event.kind.name),
        _kv('pointer', '${event.pointer}'),
        _kv('device', '${event.device}'),
        _kv('position', '(${event.position.dx.toStringAsFixed(1)}, ${event.position.dy.toStringAsFixed(1)})'),
        _kv('buttons', '0x${event.buttons.toRadixString(16)}'),
        _kv('pressure', event.pressure.toStringAsFixed(2)),
        _kv('size', event.size.toStringAsFixed(2)),
        _kv('radiusMajor', event.radiusMajor.toStringAsFixed(2)),
        _kv('orientation', event.orientation.toStringAsFixed(2)),
        _kv('tilt', event.tilt.toStringAsFixed(2)),
        _kv('viewId', '${event.viewId}'),
      ],
    ),
  );
}

Widget _kv(String key, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.5),
    child: Row(
      children: [
        SizedBox(
          width: 80.0,
          child: Text(
            key,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildQuickRow(String key, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90.0,
          child: Text(
            key,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              color: Colors.amber.shade900,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.grey.shade900,
            ),
          ),
        ),
      ],
    ),
  );
}

// Demonstrate static motion explicitly with AlwaysStoppedAnimation and Duration.zero.
// These are reference declarations, kept for documentation purposes.
final Animation<double> _staticMotion = AlwaysStoppedAnimation<double>(0.5);
final Duration _zeroDuration = Duration.zero;
