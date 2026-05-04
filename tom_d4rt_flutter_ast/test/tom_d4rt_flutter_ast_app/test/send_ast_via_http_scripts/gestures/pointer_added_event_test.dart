// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt visual deep-demo: PointerAddedEvent from package:flutter/gestures.dart
//
// PointerAddedEvent is dispatched by the engine when a new pointing device
// becomes known to the framework: a mouse plugged in via USB, a Bluetooth
// stylus paired and woken, a touch screen reporting a brand-new finger
// identifier, a virtual trackpad surfaced by an embedder, etc.
//
// Crucially, a PointerAddedEvent does NOT mean "the user touched the screen"
// or "the mouse moved". It means "we now know about device N of kind K".
// The first interaction (hover, down, scroll) is delivered as separate events.
// On many embedders (Android, iOS), every fresh touch fabricates a
// PointerAddedEvent + PointerDownEvent pair before the gesture begins, then a
// PointerRemovedEvent + ... after the finger lifts. On desktop and web the
// device additions are sticky for the lifetime of the device.
//
// This file constructs sample events at build time and visualises every
// declared field. It does NOT dispatch events; do not confuse construction
// with delivery — the engine owns dispatch.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerAddedEvent Deep Demo executing');
  print('=== Building sample events at build-time only — no dispatch ===');

  // ============================================================
  // SECTION 0: Construct the canonical sample set
  // ============================================================
  // Each PointerAddedEvent below represents a different device kind.
  // We build them once and reference them across multiple sections so
  // readers can correlate the visual cards with the field tables.
  print('=== Section 0: Constructing sample PointerAddedEvent instances ===');

  final mouseAdded = PointerAddedEvent(
    timeStamp: Duration(milliseconds: 1200),
    pointer: 1,
    kind: PointerDeviceKind.mouse,
    device: 100,
    position: Offset(120.0, 80.0),
    pressureMin: 0.0,
    pressureMax: 1.0,
    distance: 0.0,
    distanceMax: 0.0,
    embedderId: 7001,
  );
  print('mouse: device=${mouseAdded.device}, pos=${mouseAdded.position}, '
      'kind=${mouseAdded.kind}');

  final touchAdded = PointerAddedEvent(
    timeStamp: Duration(milliseconds: 2400),
    pointer: 2,
    kind: PointerDeviceKind.touch,
    device: 200,
    position: Offset(220.0, 360.0),
    pressureMin: 0.0,
    pressureMax: 1.0,
    radiusMin: 4.0,
    radiusMax: 24.0,
    embedderId: 7002,
  );
  print('touch: device=${touchAdded.device}, pressureMax=${touchAdded.pressureMax}, '
      'radiusMax=${touchAdded.radiusMax}');

  final stylusAdded = PointerAddedEvent(
    timeStamp: Duration(milliseconds: 3600),
    pointer: 3,
    kind: PointerDeviceKind.stylus,
    device: 300,
    position: Offset(412.0, 290.0),
    pressureMin: 0.0,
    pressureMax: 4096.0,
    distance: 12.0,
    distanceMax: 60.0,
    orientation: 0.523, // ~30 degrees in radians
    tilt: 0.349, // ~20 degrees in radians
    embedderId: 7003,
  );
  print('stylus: orientation=${stylusAdded.orientation}, tilt=${stylusAdded.tilt}, '
      'distanceMax=${stylusAdded.distanceMax}');

  final trackpadAdded = PointerAddedEvent(
    timeStamp: Duration(milliseconds: 4800),
    pointer: 4,
    kind: PointerDeviceKind.trackpad,
    device: 400,
    position: Offset(640.0, 400.0),
    embedderId: 7004,
  );
  print('trackpad: kind=${trackpadAdded.kind}, '
      'embedderId=${trackpadAdded.embedderId}');

  final invertedStylusAdded = PointerAddedEvent(
    timeStamp: Duration(milliseconds: 6000),
    pointer: 5,
    kind: PointerDeviceKind.invertedStylus,
    device: 500,
    position: Offset(180.0, 520.0),
    pressureMin: 0.0,
    pressureMax: 4096.0,
    distance: 24.0,
    distanceMax: 80.0,
    orientation: -0.785, // ~ -45 degrees
    tilt: 0.610, // ~35 degrees
    obscured: true,
    embedderId: 7005,
  );
  print('invertedStylus: obscured=${invertedStylusAdded.obscured}, '
      'distance=${invertedStylusAdded.distance}');

  final unknownAdded = PointerAddedEvent(
    timeStamp: Duration(milliseconds: 7200),
    pointer: 6,
    kind: PointerDeviceKind.unknown,
    device: 600,
    position: Offset.zero,
    embedderId: 0,
  );
  print('unknown: device=${unknownAdded.device}, position=${unknownAdded.position}');

  final samples = <_SampleEntry>[
    _SampleEntry(mouseAdded, 'Mouse', 'USB / Bluetooth mouse plugged in',
        Icons.mouse, Colors.blue),
    _SampleEntry(touchAdded, 'Touch', 'Finger identified by touchscreen',
        Icons.touch_app, Colors.orange),
    _SampleEntry(stylusAdded, 'Stylus', 'Active pen woken near digitizer',
        Icons.edit, Colors.purple),
    _SampleEntry(trackpadAdded, 'Trackpad', 'Trackpad surfaced by embedder',
        Icons.crop_landscape, Colors.teal),
    _SampleEntry(invertedStylusAdded, 'Inverted Stylus',
        'Pen flipped — eraser end engaged', Icons.swap_vert, Colors.deepOrange),
    _SampleEntry(unknownAdded, 'Unknown', 'Embedder reported no kind',
        Icons.help_outline, Colors.grey),
  ];
  print('Constructed ${samples.length} sample events');

  // ============================================================
  // SECTION 1: Hero header
  // ============================================================
  print('=== Section 1: Hero header ===');

  final hero = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF0F2027),
          Color(0xFF203A43),
          Color(0xFF2C5364),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.25),
          blurRadius: 28.0,
          spreadRadius: 2.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.cyanAccent, Colors.blueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withValues(alpha: 0.5),
                    blurRadius: 18.0,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
              child: Icon(Icons.add_circle_outline,
                  size: 36.0, color: Colors.white),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PointerAddedEvent',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'package:flutter/gestures.dart',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13.0,
                      color: Colors.cyanAccent.shade100,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.06),
                Colors.white.withValues(alpha: 0.02),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: Colors.cyanAccent.withValues(alpha: 0.35),
              width: 1.0,
            ),
          ),
          child: Text(
            'Fired by the engine when a new pointing device becomes known to '
            'the framework — a USB mouse plugged in, a stylus paired, a finger '
            'first appearing on a touchscreen. It is NOT a touch and NOT a '
            'movement; it announces the device. The first interaction follows '
            'as a separate event (hover / down / scroll).',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.5,
              height: 1.55,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 8.0,
          children: [
            _heroBadge('extends PointerEvent', Colors.cyanAccent),
            _heroBadge('immutable', Colors.greenAccent),
            _heroBadge('17 fields', Colors.amberAccent),
            _heroBadge('engine-dispatched', Colors.pinkAccent),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Class anatomy — every declared field
  // ============================================================
  print('=== Section 2: Class anatomy — full field inventory ===');

  final fieldRows = <_FieldRow>[
    _FieldRow('timeStamp', 'Duration', 'When the engine recorded the event.',
        '${stylusAdded.timeStamp}', Colors.indigo),
    _FieldRow('pointer', 'int',
        'Unique identifier for this pointer interaction.',
        '${stylusAdded.pointer}', Colors.blue),
    _FieldRow('kind', 'PointerDeviceKind',
        'Kind of input device (mouse, touch, stylus, trackpad, ...).',
        '${stylusAdded.kind}', Colors.purple),
    _FieldRow('device', 'int',
        'Engine-assigned device id (sticky across events).',
        '${stylusAdded.device}', Colors.deepPurple),
    _FieldRow('position', 'Offset',
        'Initial logical position when the device was added.',
        '${stylusAdded.position}', Colors.teal),
    _FieldRow('obscured', 'bool',
        'True if the platform reports the input was obscured.',
        '${stylusAdded.obscured}', Colors.brown),
    _FieldRow('pressureMin', 'double',
        'Minimum reportable pressure for this device (1.0 if unsupported).',
        '${stylusAdded.pressureMin}', Colors.green),
    _FieldRow('pressureMax', 'double',
        'Maximum reportable pressure for this device.',
        '${stylusAdded.pressureMax}', Colors.lightGreen),
    _FieldRow('distance', 'double',
        'Distance from the surface (only meaningful while not down).',
        '${stylusAdded.distance}', Colors.orange),
    _FieldRow('distanceMax', 'double',
        'Maximum reportable distance from the surface.',
        '${stylusAdded.distanceMax}', Colors.deepOrange),
    _FieldRow('radiusMinor', 'double',
        'Computed minor axis radius of the contact (0 on Added).',
        '${stylusAdded.radiusMinor}', Colors.pink),
    _FieldRow('radiusMajor', 'double',
        'Computed major axis radius of the contact (0 on Added).',
        '${stylusAdded.radiusMajor}', Colors.pinkAccent),
    _FieldRow('radiusMin', 'double',
        'Minimum reportable radius for this device.',
        '${stylusAdded.radiusMin}', Colors.red),
    _FieldRow('radiusMax', 'double',
        'Maximum reportable radius for this device.',
        '${stylusAdded.radiusMax}', Colors.redAccent),
    _FieldRow('orientation', 'double',
        'Stylus orientation in radians (compass bearing).',
        '${stylusAdded.orientation.toStringAsFixed(3)} rad',
        Colors.cyan),
    _FieldRow('tilt', 'double',
        'Stylus tilt from perpendicular in radians.',
        '${stylusAdded.tilt.toStringAsFixed(3)} rad',
        Colors.lightBlue),
    _FieldRow('embedderId', 'int',
        'Embedder-assigned identifier (Linux/Win shells, web).',
        '${stylusAdded.embedderId}', Colors.blueGrey),
  ];

  final classAnatomy = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.blue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.10),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: Colors.indigo, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Class Anatomy',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'Every field of PointerAddedEvent. Values shown come from the '
          'stylus sample (device 300, embedderId 7003).',
          style: TextStyle(
            fontSize: 12.5,
            color: Colors.indigo.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 14.0),
        for (final row in fieldRows) _buildFieldRow(row),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: PointerEvent hierarchy diagram
  // ============================================================
  print('=== Section 3: PointerEvent hierarchy diagram ===');

  final hierarchy = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade50, Colors.purple.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.12),
          blurRadius: 18.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.hub, color: Colors.deepPurple, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'PointerEvent hierarchy',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        // Root node
        Container(
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade700, Colors.deepPurple.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.withValues(alpha: 0.4),
                blurRadius: 10.0,
                offset: Offset(0.0, 4.0),
              ),
            ],
          ),
          child: Text(
            'PointerEvent (abstract)',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(height: 4.0),
        Icon(Icons.arrow_drop_down, color: Colors.deepPurple, size: 32.0),
        SizedBox(height: 4.0),
        // Subclasses wrap
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          alignment: WrapAlignment.center,
          children: [
            _hierNode('PointerAddedEvent', Colors.cyan, true),
            _hierNode('PointerRemovedEvent', Colors.blueGrey, false),
            _hierNode('PointerHoverEvent', Colors.teal, false),
            _hierNode('PointerEnterEvent', Colors.green, false),
            _hierNode('PointerExitEvent', Colors.lime.shade700, false),
            _hierNode('PointerDownEvent', Colors.indigo, false),
            _hierNode('PointerMoveEvent', Colors.blue, false),
            _hierNode('PointerUpEvent', Colors.purple, false),
            _hierNode('PointerCancelEvent', Colors.red, false),
            _hierNode('PointerScrollEvent', Colors.orange, false),
            _hierNode('PointerScrollInertiaCancelEvent',
                Colors.deepOrange, false),
            _hierNode('PointerScaleEvent', Colors.pink, false),
            _hierNode('PointerPanZoomStartEvent', Colors.amber.shade700, false),
            _hierNode('PointerPanZoomUpdateEvent', Colors.amber.shade800, false),
            _hierNode('PointerPanZoomEndEvent', Colors.amber.shade900, false),
            _hierNode('PointerSignalEvent', Colors.brown, false),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.deepPurple.shade100),
          ),
          child: Text(
            'PointerAddedEvent is the entry-point sibling: it fires once when '
            'a device is recognised. PointerRemovedEvent is its mirror. The '
            'middle of the lifecycle (hover, down, move, up) belongs to the '
            'other subclasses.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.deepPurple.shade900,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Sample grid — 6 device kinds
  // ============================================================
  print('=== Section 4: Sample grid of PointerAddedEvent instances ===');

  final sampleCards = <Widget>[];
  for (final s in samples) {
    print('Card: ${s.label} -> '
        'pointer=${s.event.pointer}, device=${s.event.device}, '
        'kind=${s.event.kind}, position=${s.event.position}, '
        'embedderId=${s.event.embedderId}');
    sampleCards.add(_buildSampleCard(s));
  }

  final sampleGrid = Wrap(
    spacing: 12.0,
    runSpacing: 12.0,
    alignment: WrapAlignment.start,
    children: sampleCards,
  );

  // ============================================================
  // SECTION 5: Lifecycle of a pointing device — horizontal flow
  // ============================================================
  print('=== Section 5: Lifecycle of a pointing device ===');

  final lifecycle = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade50, Colors.cyan.shade50, Colors.blue.shade50],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.12),
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
            Icon(Icons.timeline, color: Colors.teal.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Device lifecycle',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          'A typical pointing device lives between two announcements. '
          'PointerAddedEvent opens the lifetime; PointerRemovedEvent closes it. '
          'Everything in between is interaction.',
          style: TextStyle(
            fontSize: 12.5,
            fontStyle: FontStyle.italic,
            color: Colors.teal.shade700,
          ),
        ),
        SizedBox(height: 16.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _flowNode('Added', Icons.add_circle, Colors.cyan, isStart: true),
              _flowArrow(),
              _flowNode('Hover', Icons.gps_fixed, Colors.teal),
              _flowArrow(),
              _flowNode('Enter', Icons.login, Colors.green),
              _flowArrow(),
              _flowNode('Down', Icons.arrow_downward, Colors.indigo),
              _flowArrow(),
              _flowNode('Move', Icons.swap_horiz, Colors.blue),
              _flowArrow(),
              _flowNode('Up', Icons.arrow_upward, Colors.purple),
              _flowArrow(),
              _flowNode('Exit', Icons.logout, Colors.lime.shade700),
              _flowArrow(),
              _flowNode('Removed', Icons.remove_circle, Colors.blueGrey,
                  isEnd: true),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.teal.shade100),
          ),
          child: Text(
            'NOTE: Hover / Enter / Exit only apply to hovering devices '
            '(mouse, stylus). For touch, the lifecycle collapses to '
            'Added -> Down -> Move -> Up -> Removed and is often repeated '
            'for every individual finger contact.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.teal.shade900,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Recipes (3 use-cases) — pseudocode
  // ============================================================
  print('=== Section 6: Recipes ===');

  final recipes = Container(
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
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, color: Colors.amber.shade300, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Recipes',
              style: TextStyle(
                color: Colors.amber.shade300,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        _recipeBlock(
          '1. Logging device additions',
          'Subscribe to GestureBinding pointerRouter or override\n'
          'WidgetsFlutterBinding.handlePointerEvent. PointerAddedEvent\n'
          'is purely informational — no hit testing happens.',
          'void onPointerEvent(PointerEvent e) {\n'
          '  if (e is PointerAddedEvent) {\n'
          '    log.info(\n'
          '      "device added id=\${e.device} kind=\${e.kind} "\n'
          '      "embedderId=\${e.embedderId} pos=\${e.position}",\n'
          '    );\n'
          '  }\n'
          '}',
          Colors.cyan.shade300,
          Colors.cyan,
        ),
        SizedBox(height: 14.0),
        _recipeBlock(
          '2. Populating a multi-pointer dashboard',
          'Maintain a Map<int, _DeviceInfo> keyed by event.device.\n'
          'Insert on PointerAddedEvent, remove on PointerRemovedEvent.\n'
          'Use device — not pointer — as the long-lived identifier.',
          'final Map<int, _DeviceInfo> _devices = {};\n'
          '\n'
          'void track(PointerEvent e) {\n'
          '  if (e is PointerAddedEvent) {\n'
          '    _devices[e.device] = _DeviceInfo(\n'
          '      kind: e.kind,\n'
          '      addedAt: e.timeStamp,\n'
          '      embedderId: e.embedderId,\n'
          '    );\n'
          '  } else if (e is PointerRemovedEvent) {\n'
          '    _devices.remove(e.device);\n'
          '  }\n'
          '}',
          Colors.greenAccent,
          Colors.green,
        ),
        SizedBox(height: 14.0),
        _recipeBlock(
          '3. Conditional UI when a stylus appears',
          'Detect stylus presence and reveal a pen-specific panel\n'
          '(brush size, tilt indicator). Use kind to discriminate.',
          'bool stylusPresent = false;\n'
          '\n'
          'void watch(PointerEvent e) {\n'
          '  if (e is PointerAddedEvent &&\n'
          '      e.kind == PointerDeviceKind.stylus) {\n'
          '    stylusPresent = true;\n'
          '    showStylusToolbar();\n'
          '  } else if (e is PointerRemovedEvent &&\n'
          '             e.kind == PointerDeviceKind.stylus) {\n'
          '    stylusPresent = false;\n'
          '    hideStylusToolbar();\n'
          '  }\n'
          '}',
          Colors.pinkAccent,
          Colors.pink,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Comparison vs PointerRemovedEvent and PointerHoverEvent
  // ============================================================
  print('=== Section 7: Comparison table ===');

  final comparison = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.amber.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.18),
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
            Icon(Icons.compare_arrows, color: Colors.amber.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'PointerAddedEvent vs siblings',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Row(
          children: [
            Expanded(
              child: _compareCard(
                'PointerAddedEvent',
                'Device became known.',
                [
                  'Once per device lifetime',
                  'No hit testing',
                  'position is the FIRST known location',
                  'pressure / radius / distance reflect device limits',
                ],
                Icons.add_circle,
                Colors.cyan,
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _compareCard(
                'PointerRemovedEvent',
                'Device went away.',
                [
                  'Mirror of Added',
                  'Cleanup hook',
                  'No new position info',
                  'Always paired with Added',
                ],
                Icons.remove_circle,
                Colors.blueGrey,
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: _compareCard(
                'PointerHoverEvent',
                'Device moved without contact.',
                [
                  'Many per second',
                  'Carries delta',
                  'Hovering devices only',
                  'Hit-tested',
                ],
                Icons.gps_fixed,
                Colors.teal,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Pitfalls and engine-specific quirks
  // ============================================================
  print('=== Section 8: Pitfalls ===');

  final pitfalls = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.pink.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.14),
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
            Icon(Icons.warning_amber_rounded,
                color: Colors.red.shade700, size: 22.0),
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
        _pitfall(
          'Mouse-add events on web',
          'Browsers do not always announce a mouse before its first hover. '
          'Fabricated PointerAddedEvents may carry position == Offset.zero.',
        ),
        _pitfall(
          'Embedder-specific behaviour',
          'Linux / Windows shells, custom embedders, and Android may '
          'duplicate add events on focus changes. Treat re-additions of the '
          'same device id as benign.',
        ),
        _pitfall(
          'Missing PointerRemovedEvent',
          'Crashes, sleep, and embedder bugs can drop the trailing remove. '
          'Don\'t treat it as a strict invariant — periodically GC stale '
          'device entries by timestamp.',
        ),
        _pitfall(
          'Confusing pointer with device',
          'pointer is per-interaction; device is the physical id. '
          'For long-lived dashboards key by device, not pointer.',
        ),
        _pitfall(
          'Treating Added as a touch',
          'PointerAddedEvent is announcement-only. Triggering gesture '
          'logic on it produces phantom interactions.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Footer with file path + ASCII box
  // ============================================================
  print('=== Section 9: Footer ===');

  final footer = Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade900, Colors.black87],
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
            Icon(Icons.description_outlined,
                color: Colors.greenAccent, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'File',
              style: TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts/'
          'gestures/pointer_added_event_test.dart',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'monospace',
            fontSize: 11.5,
          ),
        ),
        SizedBox(height: 14.0),
        Text(
          '+----------------------------------------------------------+\n'
          '|             PointerAddedEvent Deep Demo                  |\n'
          '|         package:flutter/gestures.dart                    |\n'
          '|   announces a new pointing device to the framework       |\n'
          '|   17 fields | 6 sample kinds | construction-only         |\n'
          '+----------------------------------------------------------+',
          style: TextStyle(
            color: Colors.cyanAccent.shade100,
            fontFamily: 'monospace',
            fontSize: 11.0,
            height: 1.3,
          ),
        ),
      ],
    ),
  );

  print('PointerAddedEvent Deep Demo build completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        hero,
        SizedBox(height: 28.0),
        _sectionTitle('1. Class anatomy', Icons.account_tree, Colors.indigo),
        SizedBox(height: 10.0),
        classAnatomy,
        SizedBox(height: 28.0),
        _sectionTitle('2. PointerEvent hierarchy', Icons.hub, Colors.deepPurple),
        SizedBox(height: 10.0),
        hierarchy,
        SizedBox(height: 28.0),
        _sectionTitle('3. Sample grid (6 device kinds)',
            Icons.dashboard, Colors.blue),
        SizedBox(height: 10.0),
        sampleGrid,
        SizedBox(height: 28.0),
        _sectionTitle('4. Device lifecycle', Icons.timeline, Colors.teal),
        SizedBox(height: 10.0),
        lifecycle,
        SizedBox(height: 28.0),
        _sectionTitle('5. Recipes', Icons.menu_book, Colors.amber.shade800),
        SizedBox(height: 10.0),
        recipes,
        SizedBox(height: 28.0),
        _sectionTitle('6. Comparison vs siblings',
            Icons.compare_arrows, Colors.brown),
        SizedBox(height: 10.0),
        comparison,
        SizedBox(height: 28.0),
        _sectionTitle('7. Pitfalls', Icons.warning_amber_rounded, Colors.red),
        SizedBox(height: 10.0),
        pitfalls,
        SizedBox(height: 28.0),
        _sectionTitle('8. Footer', Icons.description_outlined,
            Colors.blueGrey),
        SizedBox(height: 10.0),
        footer,
        SizedBox(height: 24.0),
      ],
    ),
  );
}

// =============================================================================
// Internal data carriers
// =============================================================================

class _SampleEntry {
  final PointerAddedEvent event;
  final String label;
  final String description;
  final IconData icon;
  final Color color;
  const _SampleEntry(
    this.event,
    this.label,
    this.description,
    this.icon,
    this.color,
  );
}

class _FieldRow {
  final String name;
  final String type;
  final String description;
  final String value;
  final Color color;
  const _FieldRow(
    this.name,
    this.type,
    this.description,
    this.value,
    this.color,
  );
}

// =============================================================================
// Helpers
// =============================================================================

Widget _heroBadge(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: color,
        fontSize: 11.5,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.3,
      ),
    ),
  );
}

Widget _sectionTitle(String title, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.16),
          color.withValues(alpha: 0.04),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: color, width: 4.0),
      ),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 22.0),
        SizedBox(width: 10.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 19.0,
            fontWeight: FontWeight.bold,
            color: color,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ),
  );
}

Widget _buildFieldRow(_FieldRow row) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(
        left: BorderSide(color: row.color, width: 4.0),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                row.name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: row.color,
                ),
              ),
              SizedBox(height: 2.0),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 6.0, vertical: 1.5),
                decoration: BoxDecoration(
                  color: row.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  row.type,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.0,
                    color: row.color,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                row.description,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade800,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 4.0),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: Colors.grey.shade300, width: 1.0),
                ),
                child: Text(
                  'sample = ${row.value}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.5,
                    color: Colors.grey.shade900,
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

Widget _hierNode(String label, Color color, bool highlight) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: highlight
          ? color.withValues(alpha: 0.32)
          : color.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: highlight ? color : color.withValues(alpha: 0.5),
        width: highlight ? 2.5 : 1.0,
      ),
      boxShadow: highlight
          ? [
              BoxShadow(
                color: color.withValues(alpha: 0.5),
                blurRadius: 12.0,
                spreadRadius: 1.0,
              ),
            ]
          : null,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (highlight)
          Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: Icon(Icons.star, size: 14.0, color: color),
          ),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            fontWeight: highlight ? FontWeight.bold : FontWeight.w500,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSampleCard(_SampleEntry s) {
  final e = s.event;
  return Container(
    width: 340.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          s.color.withValues(alpha: 0.10),
          s.color.withValues(alpha: 0.22),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: s.color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: s.color.withValues(alpha: 0.25),
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
                color: s.color.withValues(alpha: 0.25),
                shape: BoxShape.circle,
              ),
              child: Icon(s.icon, color: s.color, size: 24.0),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.label,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: s.color,
                    ),
                  ),
                  Text(
                    s.description,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _kv('kind', '${e.kind}', s.color),
              _kv('device', '${e.device}', s.color),
              _kv('pointer', '${e.pointer}', s.color),
              _kv('position', '${e.position}', s.color),
              _kv('timeStamp', '${e.timeStamp}', s.color),
              _kv('embedderId', '${e.embedderId}', s.color),
              _kv('pressureMin..Max',
                  '${e.pressureMin}..${e.pressureMax}', s.color),
              _kv('distance / max',
                  '${e.distance} / ${e.distanceMax}', s.color),
              _kv('radiusMin..Max',
                  '${e.radiusMin}..${e.radiusMax}', s.color),
              _kv('orientation',
                  e.orientation.toStringAsFixed(3), s.color),
              _kv('tilt', e.tilt.toStringAsFixed(3), s.color),
              _kv('obscured', '${e.obscured}', s.color),
              _kv('down', '${e.down}', s.color),
              _kv('synthesized', '${e.synthesized}', s.color),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _kv(String k, String v, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1.5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120.0,
          child: Text(
            k,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            v,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: Colors.grey.shade900,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _flowNode(String label, IconData icon, Color color,
    {bool isStart = false, bool isEnd = false}) {
  return Container(
    width: 92.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.18),
          color.withValues(alpha: 0.32),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: color,
        width: (isStart || isEnd) ? 2.5 : 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.30),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 26.0),
        SizedBox(height: 4.0),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        if (isStart)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: Text(
                'START',
                style: TextStyle(
                  fontSize: 8.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        if (isEnd)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: Text(
                'END',
                style: TextStyle(
                  fontSize: 8.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _flowArrow() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0),
    child: Icon(Icons.chevron_right, color: Colors.teal.shade400, size: 28.0),
  );
}

Widget _recipeBlock(
  String title,
  String summary,
  String code,
  Color codeColor,
  Color accent,
) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.4),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: accent, width: 3.0),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: accent,
            fontWeight: FontWeight.bold,
            fontSize: 13.5,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          summary,
          style: TextStyle(
            color: Colors.grey.shade300,
            fontSize: 11.5,
            height: 1.4,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(6.0),
          ),
          width: double.infinity,
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: codeColor,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _compareCard(
  String title,
  String tagline,
  List<String> bullets,
  IconData icon,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 8.0,
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
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          tagline,
          style: TextStyle(
            fontSize: 11.5,
            fontStyle: FontStyle.italic,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 8.0),
        for (final b in bullets)
          Padding(
            padding: const EdgeInsets.only(bottom: 3.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• ', style: TextStyle(color: color)),
                Expanded(
                  child: Text(
                    b,
                    style: TextStyle(
                      fontSize: 10.5,
                      color: Colors.grey.shade900,
                      height: 1.35,
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

Widget _pitfall(String title, String body) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        left: BorderSide(color: Colors.red.shade400, width: 3.5),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.error_outline,
                color: Colors.red.shade700, size: 16.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade900,
                  fontSize: 13.0,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          body,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey.shade900,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}
