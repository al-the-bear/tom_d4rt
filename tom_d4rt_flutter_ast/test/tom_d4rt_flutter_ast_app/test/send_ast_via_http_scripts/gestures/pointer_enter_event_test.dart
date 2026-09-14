// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import
// D4rt deep visual demo: PointerEnterEvent from package:flutter/gestures.dart.
// Hand-authored corpus piece showcasing every meaningful field on the
// hover-enter pointer event, its lifecycle position, and recipes that produce
// or consume it.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // SAMPLE EVENTS used across the demo
  // ============================================================
  final mouseEnter = PointerEnterEvent(
    timeStamp: Duration(milliseconds: 1234),
    pointer: 42,
    kind: PointerDeviceKind.mouse,
    device: 1,
    position: Offset(120.0, 64.0),
    delta: Offset(4.0, 2.0),
    buttons: kPrimaryMouseButton,
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
    down: false,
    synthesized: false,
    embedderId: 9001,
    viewId: 0,
  );

  final stylusEnter = PointerEnterEvent(
    timeStamp: Duration(milliseconds: 2500),
    pointer: 88,
    kind: PointerDeviceKind.stylus,
    device: 2,
    position: Offset(220.0, 140.0),
    delta: Offset(1.0, -3.0),
    buttons: 0,
    pressureMin: 0.0,
    pressureMax: 1.0,
    distance: 12.0,
    distanceMax: 24.0,
    radiusMajor: 1.0,
    radiusMinor: 1.0,
    radiusMin: 0.0,
    radiusMax: 4.0,
    orientation: 0.5,
    tilt: 0.2,
  );

  final touchEnter = PointerEnterEvent(
    timeStamp: Duration(milliseconds: 4096),
    pointer: 7,
    kind: PointerDeviceKind.touch,
    device: 3,
    position: Offset(58.0, 320.0),
    delta: Offset.zero,
    pressureMin: 0.0,
    pressureMax: 1.0,
    size: 0.25,
    radiusMajor: 18.0,
    radiusMinor: 14.0,
  );

  final hoverSource = PointerHoverEvent(
    timeStamp: Duration(milliseconds: 1000),
    kind: PointerDeviceKind.mouse,
    device: 1,
    position: Offset(110.0, 60.0),
    delta: Offset(2.0, 1.0),
  );
  final synthesizedFromHover = PointerEnterEvent.fromMouseEvent(hoverSource);

  // ============================================================
  // SECTION 1: Hero header
  // ============================================================
  final hero = Container(
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade700, Colors.purple.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.4),
          blurRadius: 24.0,
          offset: Offset(0.0, 10.0),
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
                  colors: [Colors.white, Colors.indigo.shade50],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 12.0,
                    offset: Offset(0.0, 6.0),
                  ),
                ],
              ),
              child: Icon(
                Icons.mouse,
                size: 56.0,
                color: Colors.indigo.shade700,
              ),
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PointerEnterEvent',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'package:flutter/gestures.dart',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Synthetic event dispatched once when a pointer\n'
                    'crosses into the bounds of a hit-tested widget.',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _heroChip('extends PointerEvent', Colors.white),
            _heroChip('with _PointerEventDescription', Colors.white),
            _heroChip('with _CopyPointerEnterEvent', Colors.white),
            _heroChip('synthesized by MouseTracker', Colors.amberAccent),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Anatomy of a pointer event
  // ============================================================
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
          color: Colors.blueGrey.withValues(alpha: 0.2),
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
            Icon(Icons.account_tree, color: Colors.blueGrey.shade700),
            SizedBox(width: 8.0),
            Text(
              'Anatomy of a PointerEnterEvent',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        _anatomyRow(
          'where', 'position / localPosition',
          mouseEnter.position.toString(),
          Colors.indigo,
          Icons.place,
        ),
        _anatomyRow(
          'how it moved', 'delta / localDelta',
          mouseEnter.delta.toString(),
          Colors.green,
          Icons.timeline,
        ),
        _anatomyRow(
          'who', 'kind + device + pointer',
          '${mouseEnter.kind.name} #${mouseEnter.device}/${mouseEnter.pointer}',
          Colors.orange,
          Icons.devices,
        ),
        _anatomyRow(
          'when', 'timeStamp',
          '${mouseEnter.timeStamp.inMilliseconds}ms',
          Colors.teal,
          Icons.access_time,
        ),
        _anatomyRow(
          'buttons', 'buttons (bitmask)',
          '0x${mouseEnter.buttons.toRadixString(16)}',
          Colors.red,
          Icons.toggle_on,
        ),
        _anatomyRow(
          'down?', 'down (bool)',
          mouseEnter.down.toString(),
          Colors.purple,
          Icons.touch_app,
        ),
        _anatomyRow(
          'synthesized?', 'synthesized (bool)',
          mouseEnter.synthesized.toString(),
          Colors.brown,
          Icons.auto_awesome,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Per-field cards
  // ============================================================
  final fieldCards = <Widget>[
    _fieldCard(
      'position',
      'Offset',
      mouseEnter.position.toString(),
      'Logical-pixel coordinates of the pointer in the global coordinate space.',
      Icons.place,
      Colors.indigo,
    ),
    _fieldCard(
      'localPosition',
      'Offset',
      mouseEnter.localPosition.toString(),
      'position transformed into the receiver\'s local space (uses transform).',
      Icons.center_focus_strong,
      Colors.indigo.shade300,
    ),
    _fieldCard(
      'delta',
      'Offset',
      mouseEnter.delta.toString(),
      'Movement since the previous hover/move event in global coords.',
      Icons.timeline,
      Colors.green,
    ),
    _fieldCard(
      'localDelta',
      'Offset',
      mouseEnter.localDelta.toString(),
      'delta transformed into the receiver\'s local space.',
      Icons.swap_calls,
      Colors.green.shade300,
    ),
    _fieldCard(
      'kind',
      'PointerDeviceKind',
      mouseEnter.kind.name,
      'mouse / touch / stylus / invertedStylus / trackpad / unknown.',
      Icons.devices_other,
      Colors.deepOrange,
    ),
    _fieldCard(
      'device',
      'int',
      mouseEnter.device.toString(),
      'Stable id for the pointing device, reused across interactions.',
      Icons.fingerprint,
      Colors.orange,
    ),
    _fieldCard(
      'pointer',
      'int',
      mouseEnter.pointer.toString(),
      'Per-stroke id, fresh on every new "down" sequence.',
      Icons.numbers,
      Colors.amber.shade800,
    ),
    _fieldCard(
      'buttons',
      'int (bitmask)',
      '0x${mouseEnter.buttons.toRadixString(16).padLeft(2, '0')}',
      'Bitmask of pressed buttons (kPrimaryMouseButton, kSecondaryButton...).',
      Icons.toggle_on,
      Colors.red,
    ),
    _fieldCard(
      'down',
      'bool',
      mouseEnter.down.toString(),
      'False for hover/enter; true while a contact/click is in progress.',
      Icons.touch_app,
      Colors.purple,
    ),
    _fieldCard(
      'pressure',
      'double',
      mouseEnter.pressure.toStringAsFixed(2),
      'Forced to 0.0 by the PointerEnterEvent constructor (see super-call).',
      Icons.compress,
      Colors.cyan,
    ),
    _fieldCard(
      'pressureMin',
      'double',
      mouseEnter.pressureMin.toStringAsFixed(2),
      'Minimum reportable pressure for this pointer (1.0 for mice).',
      Icons.south,
      Colors.cyan.shade300,
    ),
    _fieldCard(
      'pressureMax',
      'double',
      mouseEnter.pressureMax.toStringAsFixed(2),
      'Maximum reportable pressure for this pointer (1.0 for mice).',
      Icons.north,
      Colors.cyan.shade700,
    ),
    _fieldCard(
      'distance',
      'double',
      stylusEnter.distance.toStringAsFixed(1),
      'How far above the surface the pointer floats (hover-touch).',
      Icons.height,
      Colors.lightBlue,
    ),
    _fieldCard(
      'distanceMax',
      'double',
      stylusEnter.distanceMax.toStringAsFixed(1),
      'Maximum hover distance the device can detect.',
      Icons.unfold_more,
      Colors.lightBlue.shade700,
    ),
    _fieldCard(
      'size',
      'double',
      touchEnter.size.toStringAsFixed(2),
      'Android-only normalized contact size (0.0 - 1.0).',
      Icons.aspect_ratio,
      Colors.brown,
    ),
    _fieldCard(
      'radiusMajor',
      'double',
      touchEnter.radiusMajor.toStringAsFixed(1),
      'Major axis of the contact ellipse, in logical pixels.',
      Icons.radio_button_checked,
      Colors.pink,
    ),
    _fieldCard(
      'radiusMinor',
      'double',
      touchEnter.radiusMinor.toStringAsFixed(1),
      'Minor axis of the contact ellipse, in logical pixels.',
      Icons.radio_button_unchecked,
      Colors.pink.shade300,
    ),
    _fieldCard(
      'radiusMin',
      'double',
      touchEnter.radiusMin.toStringAsFixed(1),
      'Lower bound this pointer can ever report for radius.',
      Icons.south_west,
      Colors.pink.shade700,
    ),
    _fieldCard(
      'radiusMax',
      'double',
      touchEnter.radiusMax.toStringAsFixed(1),
      'Upper bound this pointer can ever report for radius.',
      Icons.north_east,
      Colors.pink.shade900,
    ),
    _fieldCard(
      'orientation',
      'double (radians)',
      stylusEnter.orientation.toStringAsFixed(2),
      'Angle of contact ellipse / stylus around the y-axis.',
      Icons.rotate_right,
      Colors.deepPurple,
    ),
    _fieldCard(
      'tilt',
      'double (radians)',
      stylusEnter.tilt.toStringAsFixed(2),
      'Stylus tilt away from perpendicular (0 = upright).',
      Icons.architecture,
      Colors.deepPurple.shade300,
    ),
    _fieldCard(
      'obscured',
      'bool',
      mouseEnter.obscured.toString(),
      'Set when another security domain may be hiding this window.',
      Icons.visibility_off,
      Colors.grey.shade700,
    ),
    _fieldCard(
      'synthesized',
      'bool',
      synthesizedFromHover.synthesized.toString(),
      'True when generated by Flutter (e.g. via fromMouseEvent), not the OS.',
      Icons.auto_awesome,
      Colors.amber.shade700,
    ),
    _fieldCard(
      'embedderId',
      'int',
      mouseEnter.embedderId.toString(),
      'Platform-event id used to correlate with the embedder.',
      Icons.qr_code_2,
      Colors.blueGrey,
    ),
    _fieldCard(
      'viewId',
      'int',
      mouseEnter.viewId.toString(),
      'Originating FlutterView id for multi-view applications.',
      Icons.web,
      Colors.blueGrey.shade700,
    ),
    _fieldCard(
      'timeStamp',
      'Duration',
      '${mouseEnter.timeStamp.inMilliseconds} ms',
      'Time of dispatch relative to an arbitrary timeline.',
      Icons.access_time,
      Colors.teal,
    ),
    _fieldCard(
      'transform',
      'Matrix4?',
      mouseEnter.transform == null ? 'null' : 'set',
      'Set on transformed copies; affects localPosition / localDelta.',
      Icons.transform,
      Colors.lime.shade800,
    ),
    _fieldCard(
      'original',
      'PointerEvent?',
      mouseEnter.original == null ? 'null' : 'present',
      'Reference to the untransformed source event after transformed().',
      Icons.layers,
      Colors.lime.shade600,
    ),
  ];

  // ============================================================
  // SECTION 4: Hover scenarios (mouse / stylus / synthesized)
  // ============================================================
  final scenarios = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade50, Colors.blue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.cyan.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.2),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Common scenarios',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.cyan.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        _scenarioCard(
          'Mouse cursor enters a card',
          mouseEnter,
          Icons.mouse,
          Colors.indigo,
        ),
        _scenarioCard(
          'Stylus hovers over a canvas',
          stylusEnter,
          Icons.brush,
          Colors.deepPurple,
        ),
        _scenarioCard(
          'Touch contact enters a button bounds',
          touchEnter,
          Icons.touch_app,
          Colors.pink,
        ),
        _scenarioCard(
          'Synthesized via fromMouseEvent(hover)',
          synthesizedFromHover,
          Icons.auto_awesome,
          Colors.amber.shade800,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Recipe gallery for MouseRegion / Listener
  // ============================================================
  final recipes = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.black87],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
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
              'Recipes that produce PointerEnterEvent',
              style: TextStyle(
                color: Colors.cyan.shade300,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _codeBlock(
          '// 1. MouseRegion catches the synthesized enter event\n'
          'MouseRegion(\n'
          '  onEnter: (PointerEnterEvent e) {\n'
          '    debugPrint("Entered at \${e.localPosition}");\n'
          '  },\n'
          '  onHover: (PointerHoverEvent e) {/* track movement */},\n'
          '  onExit:  (PointerExitEvent e) {/* leave */},\n'
          '  child: Card(child: Text("Hover me")),\n'
          ')',
          Colors.lightBlue.shade200,
        ),
        SizedBox(height: 12.0),
        _codeBlock(
          '// 2. Listener handles raw pointer events\n'
          'Listener(\n'
          '  onPointerHover: (PointerHoverEvent e) {/* per move */},\n'
          '  child: Container(width: 200, height: 200),\n'
          ')',
          Colors.greenAccent.shade200,
        ),
        SizedBox(height: 12.0),
        _codeBlock(
          '// 3. Manually constructing for tests / synthetics\n'
          'final synthetic = PointerEnterEvent(\n'
          '  kind: PointerDeviceKind.mouse,\n'
          '  position: Offset(120, 64),\n'
          '  delta: Offset(4, 2),\n'
          ');',
          Colors.amberAccent.shade100,
        ),
        SizedBox(height: 12.0),
        _codeBlock(
          '// 4. Synthesizing from a hover/move event\n'
          'final hover = PointerHoverEvent(position: Offset(110, 60));\n'
          'final enter = PointerEnterEvent.fromMouseEvent(hover);\n'
          'assert(enter is PointerEnterEvent);',
          Colors.pinkAccent.shade100,
        ),
        SizedBox(height: 12.0),
        _codeBlock(
          '// 5. Walking the bitmask of buttons\n'
          'if (e.buttons & kPrimaryMouseButton != 0)   { /* L */ }\n'
          'if (e.buttons & kSecondaryMouseButton != 0) { /* R */ }\n'
          'if (e.buttons & kMiddleMouseButton != 0)    { /* M */ }',
          Colors.orangeAccent.shade100,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Pitfalls & gotchas
  // ============================================================
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
            Icon(Icons.warning_amber, color: Colors.red.shade700),
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
          'pressure is always 0.0',
          'The constructor super-calls with pressure: 0.0. Use a different '
          'event type if you need pressure.',
          Icons.compress,
          Colors.red,
        ),
        _pitfallTile(
          'kind cannot be PointerDeviceKind.trackpad',
          'An assert forbids trackpad — trackpad uses dedicated PointerPanZoom '
          'events instead.',
          Icons.swipe,
          Colors.deepOrange,
        ),
        _pitfallTile(
          'down is always false',
          'Enter events fire whether or not a button is pressed; down stays '
          'false until a real PointerDownEvent.',
          Icons.touch_app,
          Colors.orange,
        ),
        _pitfallTile(
          'synthesized may be true',
          'Enter events created by MouseTracker for view/widget bookkeeping '
          'have synthesized = true.',
          Icons.auto_awesome,
          Colors.amber.shade800,
        ),
        _pitfallTile(
          'localPosition needs a transform',
          'Without a transform, localPosition == position. Inside a transformed '
          'subtree, prefer localPosition / localDelta.',
          Icons.transform,
          Colors.purple,
        ),
        _pitfallTile(
          'No buttons on touch hover',
          'Touch and stylus hover usually report buttons == 0; do not gate '
          'enter behavior on the button bitmask alone.',
          Icons.toggle_off,
          Colors.brown,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Comparison with siblings
  // ============================================================
  final comparison = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.green.shade50, Colors.teal.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PointerEnterEvent vs siblings',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade900,
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          children: [
            _siblingCard(
              'PointerEnterEvent',
              'fires once on entering bounds',
              Icons.login,
              Colors.indigo,
              true,
            ),
            SizedBox(width: 10.0),
            _siblingCard(
              'PointerHoverEvent',
              'fires while moving inside bounds',
              Icons.mouse,
              Colors.blue,
              false,
            ),
            SizedBox(width: 10.0),
            _siblingCard(
              'PointerExitEvent',
              'fires once on leaving bounds',
              Icons.logout,
              Colors.red,
              false,
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade100, Colors.green.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'Lifecycle: Enter -> Hover* (zero or more) -> Exit. '
            'Down/Move/Up may be interleaved when the mouse is clicked.',
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.teal.shade900,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Quick reference table
  // ============================================================
  final quickRef = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade400, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick reference',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              _refHeader('Field', 130.0),
              _refHeader('Type', 110.0),
              _refHeader('Default', 90.0),
              _refHeader('Notes', 220.0),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        ..._refRows(),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: ASCII footer
  // ============================================================
  final asciiFooter = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.black87, Colors.indigo.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.4),
          blurRadius: 16.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '   *--------- mouse path ---------*\n'
          '   |   o                          |\n'
          '   |    \\                         |\n'
          '   |     \\  PointerEnterEvent     |\n'
          '   |      *  position (x,y)       |\n'
          '   |       \\                      |\n'
          '   |        +---> hover hover ... |\n'
          '   |                              |\n'
          '   *------------------------------*\n',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: Colors.greenAccent.shade100,
            height: 1.3,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          '// PointerEnterEvent demo - corpus piece for tom_d4rt_flutter_ast',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.white70,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // Static driver state (no real animation)
  // ============================================================
  final progress = AlwaysStoppedAnimation<double>(0.42);
  final progressOpacity = AlwaysStoppedAnimation<double>(0.85);
  final zeroDelay = Duration.zero;

  // ============================================================
  // Compose the page
  // ============================================================
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            hero,
            SizedBox(height: 24.0),
            _sectionTitle('1. Anatomy'),
            anatomy,
            SizedBox(height: 24.0),
            _sectionTitle('2. Per-field cards (every meaningful field)'),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.grey.shade50, Colors.grey.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(color: Colors.grey.shade300, width: 1.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: Wrap(
                spacing: 12.0,
                runSpacing: 12.0,
                children: fieldCards,
              ),
            ),
            SizedBox(height: 24.0),
            _sectionTitle('3. Hover scenarios'),
            scenarios,
            SizedBox(height: 24.0),
            _sectionTitle('4. Recipes'),
            recipes,
            SizedBox(height: 24.0),
            _sectionTitle('5. Pitfalls'),
            pitfalls,
            SizedBox(height: 24.0),
            _sectionTitle('6. Comparison with siblings'),
            comparison,
            SizedBox(height: 24.0),
            _sectionTitle('7. Quick reference'),
            quickRef,
            SizedBox(height: 24.0),
            _sectionTitle('8. ASCII footer'),
            asciiFooter,
            SizedBox(height: 24.0),
            // Static progress strip rendered with AlwaysStoppedAnimation
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo.shade50, Colors.purple.shade50],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withValues(alpha: 0.15),
                    blurRadius: 8.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Static progress (AlwaysStoppedAnimation)',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade900,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Opacity(
                    opacity: progressOpacity.value,
                    child: LinearProgressIndicator(
                      value: progress.value,
                      backgroundColor: Colors.indigo.shade100,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.indigo.shade400,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'value=${progress.value.toStringAsFixed(2)} '
                    'duration=${zeroDelay.inMilliseconds}ms',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: Colors.indigo.shade700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.0),
          ],
        ),
      ),
    ),
  );
}

// ------------------------------------------------------------------
// Helpers
// ------------------------------------------------------------------

Widget _heroChip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: color,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _sectionTitle(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.indigo.shade900,
      ),
    ),
  );
}

Widget _anatomyRow(
  String role,
  String fieldName,
  String value,
  Color color,
  IconData icon,
) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      children: [
        Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: 0.25),
                color.withValues(alpha: 0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 6.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Icon(icon, size: 20.0, color: color),
        ),
        SizedBox(width: 12.0),
        SizedBox(
          width: 80.0,
          child: Text(
            role,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade700,
            ),
          ),
        ),
        SizedBox(
          width: 200.0,
          child: Text(
            fieldName,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(
                color: color.withValues(alpha: 0.3),
                width: 1.0,
              ),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _fieldCard(
  String name,
  String type,
  String value,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    width: 220.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.08),
          color.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
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
            Icon(icon, color: color, size: 18.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            type,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'value:',
          style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 10.5,
            color: Colors.grey.shade800,
            height: 1.3,
          ),
        ),
      ],
    ),
  );
}

Widget _scenarioCard(
  String title,
  PointerEnterEvent event,
  IconData icon,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.15),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44.0,
          height: 44.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: 0.15),
                color.withValues(alpha: 0.4),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 22.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 4.0),
              Wrap(
                spacing: 6.0,
                runSpacing: 4.0,
                children: [
                  _eventChip('kind=${event.kind.name}', color),
                  _eventChip('pos=${event.position}', color),
                  _eventChip('delta=${event.delta}', color),
                  _eventChip('device=${event.device}', color),
                  _eventChip('buttons=0x${event.buttons.toRadixString(16)}', color),
                  _eventChip('synth=${event.synthesized}', color),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _eventChip(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 0.7),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 10.0,
        color: color,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _codeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.white24, width: 1.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: textColor,
        height: 1.4,
      ),
    ),
  );
}

Widget _pitfallTile(
  String title,
  String body,
  IconData icon,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 20.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: color,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.grey.shade800,
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

Widget _siblingCard(
  String name,
  String description,
  IconData icon,
  Color color,
  bool highlighted,
) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: highlighted
              ? [color.withValues(alpha: 0.4), color.withValues(alpha: 0.18)]
              : [color.withValues(alpha: 0.1), color.withValues(alpha: 0.04)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: color.withValues(alpha: highlighted ? 0.9 : 0.4),
          width: highlighted ? 2.0 : 1.0,
        ),
        boxShadow: highlighted
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.35),
                  blurRadius: 10.0,
                  offset: Offset(0.0, 4.0),
                ),
              ]
            : null,
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28.0),
          SizedBox(height: 6.0),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.grey.shade800,
              height: 1.3,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _refHeader(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 11.0,
        color: Colors.indigo.shade900,
      ),
    ),
  );
}

Widget _refCell(String text, double width, {bool mono = false}) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      style: TextStyle(
        fontFamily: mono ? 'monospace' : null,
        fontSize: 10.5,
        color: Colors.grey.shade900,
      ),
    ),
  );
}

List<Widget> _refRows() {
  final rows = <List<String>>[
    ['position', 'Offset', 'Offset.zero', 'Global pointer location.'],
    ['localPosition', 'Offset', '== position', 'Receiver-local; needs transform.'],
    ['delta', 'Offset', 'Offset.zero', 'Movement since prior hover/move.'],
    ['localDelta', 'Offset', '== delta', 'delta in local space.'],
    ['kind', 'PointerDeviceKind', 'touch', 'mouse / touch / stylus / ...'],
    ['device', 'int', '0', 'Stable per-device id.'],
    ['pointer', 'int', '0', 'Stroke id, fresh each down sequence.'],
    ['buttons', 'int', '0', 'Bitmask of pressed buttons.'],
    ['down', 'bool', 'false', 'Always false on enter.'],
    ['pressure', 'double', '0.0', 'Forced to 0.0 by constructor.'],
    ['pressureMin', 'double', '1.0', 'Min reportable pressure.'],
    ['pressureMax', 'double', '1.0', 'Max reportable pressure.'],
    ['distance', 'double', '0.0', 'Hover-touch distance.'],
    ['distanceMax', 'double', '0.0', 'Max hover distance.'],
    ['size', 'double', '0.0', 'Android contact size.'],
    ['radiusMajor', 'double', '0.0', 'Contact ellipse major axis.'],
    ['radiusMinor', 'double', '0.0', 'Contact ellipse minor axis.'],
    ['radiusMin', 'double', '0.0', 'Lower radius bound.'],
    ['radiusMax', 'double', '0.0', 'Upper radius bound.'],
    ['orientation', 'double', '0.0', 'Radians around y-axis.'],
    ['tilt', 'double', '0.0', 'Stylus tilt from perpendicular.'],
    ['obscured', 'bool', 'false', 'Window may be obscured.'],
    ['synthesized', 'bool', 'false', 'True if Flutter-generated.'],
    ['embedderId', 'int', '0', 'Platform-event correlation.'],
    ['viewId', 'int', '0', 'Originating FlutterView id.'],
    ['timeStamp', 'Duration', 'Duration.zero', 'Dispatch time.'],
    ['transform', 'Matrix4?', 'null', 'Set on transformed copies.'],
    ['original', 'PointerEvent?', 'null', 'Source event before transform.'],
  ];
  final out = <Widget>[];
  for (var i = 0; i < rows.length; i++) {
    final r = rows[i];
    out.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
        decoration: BoxDecoration(
          color: i.isEven ? Colors.white : Colors.grey.shade50,
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200, width: 1.0),
          ),
        ),
        child: Row(
          children: [
            _refCell(r[0], 130.0, mono: true),
            _refCell(r[1], 110.0, mono: true),
            _refCell(r[2], 90.0, mono: true),
            _refCell(r[3], 220.0),
          ],
        ),
      ),
    );
  }
  return out;
}
