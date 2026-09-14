// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests AndroidMotionEvent from services
// Deep Demo: Visual demonstration of AndroidMotionEvent — the wrapper used by
// AndroidViewController to forward synthesized touch events to embedded
// Android views. Covers downTime/eventTime, action constants, pointer
// properties / coords, multi-touch flow and footguns.
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AndroidMotionEvent Deep Demo executing');

  // Android-themed palette
  final androidGreen = Color(0xFF3DDC84);
  final androidGreenDark = Color(0xFF2BB36A);
  final charcoal = Color(0xFF263238);
  final amber = Color(0xFFFFB300);

  // ============================================================
  // SECTION 1: Title Banner
  // ============================================================
  print('=== Section 1: Title Banner ===');

  final titleBanner = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [androidGreen, androidGreenDark, charcoal],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 0.55, 1.0],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: androidGreen.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 8.0),
        ),
        BoxShadow(
          color: charcoal.withValues(alpha: 0.35),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.android, size: 56.0, color: Colors.white),
            SizedBox(width: 12.0),
            Icon(Icons.touch_app, size: 56.0, color: amber),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'AndroidMotionEvent',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Wrapping Android MotionEvent for AndroidViewController',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white70,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: amber, width: 1.0),
          ),
          child: Text(
            'package:flutter/services.dart',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: amber,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created title banner');

  // ============================================================
  // SECTION 2: Anatomy Diagram
  // ============================================================
  print('=== Section 2: Anatomy Diagram ===');

  final anatomyFields = <Widget>[];
  final anatomyData = [
    {
      'name': 'downTime',
      'type': 'int',
      'desc': 'Time (ms) of initial ACTION_DOWN',
      'icon': Icons.timer_outlined,
    },
    {
      'name': 'eventTime',
      'type': 'int',
      'desc': 'Time (ms) of THIS event',
      'icon': Icons.access_time,
    },
    {
      'name': 'action',
      'type': 'int',
      'desc': 'Encoded ACTION_* constant (+ pointer index)',
      'icon': Icons.flash_on,
    },
    {
      'name': 'pointerCount',
      'type': 'int',
      'desc': 'Number of active pointers',
      'icon': Icons.fingerprint,
    },
    {
      'name': 'pointerProperties',
      'type': 'List<AndroidPointerProperties>',
      'desc': 'id + toolType per pointer',
      'icon': Icons.list_alt,
    },
    {
      'name': 'pointerCoords',
      'type': 'List<AndroidPointerCoords>',
      'desc': 'x/y, pressure, size, touchMajor...',
      'icon': Icons.scatter_plot,
    },
    {
      'name': 'metaState',
      'type': 'int',
      'desc': 'Modifier keys mask (SHIFT, ALT...)',
      'icon': Icons.keyboard,
    },
    {
      'name': 'buttonState',
      'type': 'int',
      'desc': 'Mouse / stylus button mask',
      'icon': Icons.mouse,
    },
    {
      'name': 'xPrecision / yPrecision',
      'type': 'double',
      'desc': 'Coordinate precision per axis',
      'icon': Icons.straighten,
    },
    {
      'name': 'deviceId',
      'type': 'int',
      'desc': 'Source input device id',
      'icon': Icons.devices,
    },
    {
      'name': 'edgeFlags',
      'type': 'int',
      'desc': 'Edge-touch flags (TOP, LEFT...)',
      'icon': Icons.border_outer,
    },
    {
      'name': 'source',
      'type': 'int',
      'desc': 'InputDevice source (TOUCHSCREEN=4098)',
      'icon': Icons.input,
    },
    {
      'name': 'flags',
      'type': 'int',
      'desc': 'Misc flags (WINDOW_IS_OBSCURED...)',
      'icon': Icons.flag,
    },
    {
      'name': 'motionEventId',
      'type': 'int',
      'desc': 'Flutter-side correlation id',
      'icon': Icons.tag,
    },
  ];

  for (final field in anatomyData) {
    anatomyFields.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              androidGreen.withValues(alpha: 0.08),
              charcoal.withValues(alpha: 0.04),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: androidGreen.withValues(alpha: 0.4),
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: androidGreen.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                field['icon'] as IconData,
                color: androidGreenDark,
                size: 22.0,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        field['name'] as String,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                          color: charcoal,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: amber.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          field['type'] as String,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 10.0,
                            color: charcoal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    field['desc'] as String,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey.shade700,
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
  print('Created ${anatomyFields.length} anatomy field rows');

  final anatomyDiagram = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: androidGreen.withValues(alpha: 0.5), width: 2.0),
      boxShadow: [
        BoxShadow(
          color: androidGreen.withValues(alpha: 0.15),
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
            Icon(Icons.architecture, color: androidGreenDark, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Constructor Anatomy',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: charcoal,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'All 15 named parameters are required.',
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.grey.shade600,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12.0),
        ...anatomyFields,
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Action Constants Gallery
  // ============================================================
  print('=== Section 3: Action Constants Gallery ===');

  final actionData = [
    {
      'name': 'ACTION_DOWN',
      'value': 0,
      'icon': Icons.south,
      'color': Colors.green,
      'desc': 'First pointer touches screen',
    },
    {
      'name': 'ACTION_UP',
      'value': 1,
      'icon': Icons.north,
      'color': Colors.blue,
      'desc': 'Last pointer leaves screen',
    },
    {
      'name': 'ACTION_MOVE',
      'value': 2,
      'icon': Icons.swap_horiz,
      'color': Colors.orange,
      'desc': 'Pointer position changed',
    },
    {
      'name': 'ACTION_CANCEL',
      'value': 3,
      'icon': Icons.cancel,
      'color': Colors.red,
      'desc': 'Gesture aborted by system',
    },
    {
      'name': 'ACTION_POINTER_DOWN',
      'value': 5,
      'icon': Icons.add_circle,
      'color': Colors.purple,
      'desc': 'Non-primary pointer down',
    },
    {
      'name': 'ACTION_POINTER_UP',
      'value': 6,
      'icon': Icons.remove_circle,
      'color': Colors.teal,
      'desc': 'Non-primary pointer up',
    },
  ];

  final actionCards = <Widget>[];
  for (final a in actionData) {
    final color = a['color'] as Color;
    final value = a['value'] as int;
    print('${a['name']} = $value');

    actionCards.add(
      Container(
        width: 170.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.12),
              color.withValues(alpha: 0.28),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.35),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(a['icon'] as IconData, color: color, size: 32.0),
            ),
            SizedBox(height: 10.0),
            Text(
              a['name'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 6.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                'int = $value',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              a['desc'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${actionCards.length} action constant cards');

  // ============================================================
  // SECTION 4: AndroidPointerProperties Showcase
  // ============================================================
  print('=== Section 4: AndroidPointerProperties Showcase ===');

  final toolTypeData = [
    {
      'name': 'TOOL_TYPE_FINGER',
      'value': 1,
      'icon': Icons.touch_app,
      'color': Colors.green,
      'desc': 'Default human finger',
    },
    {
      'name': 'TOOL_TYPE_STYLUS',
      'value': 2,
      'icon': Icons.edit,
      'color': Colors.indigo,
      'desc': 'Active stylus / pen',
    },
    {
      'name': 'TOOL_TYPE_MOUSE',
      'value': 3,
      'icon': Icons.mouse,
      'color': Colors.brown,
      'desc': 'Mouse pointer',
    },
    {
      'name': 'TOOL_TYPE_ERASER',
      'value': 4,
      'icon': Icons.cleaning_services,
      'color': Colors.pink,
      'desc': 'Stylus eraser tip',
    },
    {
      'name': 'TOOL_TYPE_UNKNOWN',
      'value': 0,
      'icon': Icons.help_outline,
      'color': Colors.grey,
      'desc': 'Unrecognized tool',
    },
  ];

  final toolTypeCards = <Widget>[];
  for (int i = 0; i < toolTypeData.length; i++) {
    final t = toolTypeData[i];
    final color = t['color'] as Color;
    final value = t['value'] as int;
    final props = AndroidPointerProperties(id: i, toolType: value);
    print('AndroidPointerProperties(id: $i, toolType: $value) ${t['name']}');

    toolTypeCards.add(
      Container(
        width: 160.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.25),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 56.0,
              height: 56.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withValues(alpha: 0.15),
                    color.withValues(alpha: 0.45),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(t['icon'] as IconData, color: color, size: 30.0),
            ),
            SizedBox(height: 8.0),
            Text(
              t['name'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 4.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'toolType = ${props.toolType}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 9.0,
                  color: color,
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'id = ${props.id}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 9.0,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              t['desc'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${toolTypeCards.length} pointer property cards');

  // ============================================================
  // SECTION 5: AndroidPointerCoords Detail
  // ============================================================
  print('=== Section 5: AndroidPointerCoords Detail ===');

  final coordsExamples = [
    {
      'label': 'Light tap',
      'pressure': 0.18,
      'size': 0.10,
      'touchMajor': 6.0,
      'touchMinor': 5.0,
      'orientation': 0.0,
      'color': Colors.lightBlue,
      'icon': Icons.bubble_chart,
    },
    {
      'label': 'Firm press',
      'pressure': 0.92,
      'size': 0.55,
      'touchMajor': 22.0,
      'touchMinor': 20.0,
      'orientation': 0.0,
      'color': Colors.deepOrange,
      'icon': Icons.fingerprint,
    },
    {
      'label': 'Stylus tilt',
      'pressure': 0.55,
      'size': 0.25,
      'touchMajor': 10.0,
      'touchMinor': 4.0,
      'orientation': 0.7853981633974483,
      'color': Colors.purple,
      'icon': Icons.edit_note,
    },
    {
      'label': 'Wide thumb',
      'pressure': 0.70,
      'size': 0.85,
      'touchMajor': 38.0,
      'touchMinor': 24.0,
      'orientation': 1.5707963267948966,
      'color': Colors.teal,
      'icon': Icons.pan_tool,
    },
  ];

  final coordsCards = <Widget>[];
  for (final ex in coordsExamples) {
    final color = ex['color'] as Color;
    final pressure = ex['pressure'] as double;
    final size = ex['size'] as double;
    final touchMajor = ex['touchMajor'] as double;
    final touchMinor = ex['touchMinor'] as double;
    final orientation = ex['orientation'] as double;

    final coords = AndroidPointerCoords(
      orientation: orientation,
      pressure: pressure,
      size: size,
      toolMajor: touchMajor + 2.0,
      toolMinor: touchMinor + 2.0,
      touchMajor: touchMajor,
      touchMinor: touchMinor,
      x: 100.0,
      y: 200.0,
    );
    print(
      'AndroidPointerCoords ${ex['label']}: '
      'pressure=${coords.pressure}, size=${coords.size}, '
      'touchMajor=${coords.touchMajor}, orientation=${coords.orientation}',
    );

    coordsCards.add(
      Container(
        width: 220.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.08),
              color.withValues(alpha: 0.22),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color, width: 1.5),
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
                Icon(ex['icon'] as IconData, color: color, size: 26.0),
                SizedBox(width: 8.0),
                Text(
                  ex['label'] as String,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            _buildMetricBar('pressure', pressure, 1.0, color),
            SizedBox(height: 6.0),
            _buildMetricBar('size', size, 1.0, color),
            SizedBox(height: 6.0),
            _buildMetricBar('touchMajor', touchMajor, 50.0, color),
            SizedBox(height: 6.0),
            _buildMetricBar('touchMinor', touchMinor, 50.0, color),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'orientation',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.0,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Text(
                    '${orientation.toStringAsFixed(3)} rad',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: color,
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
  print('Created ${coordsCards.length} coords detail cards');

  // ============================================================
  // SECTION 6: Real-world Mock — Android device with touch trail
  // ============================================================
  print('=== Section 6: Real-world Mock ===');

  // Simulate a finger drag across an embedded AndroidView. We craft a real
  // sequence of AndroidMotionEvent instances and then stamp their coords on
  // a Stack to visualize the trail.
  final trailEvents = <AndroidMotionEvent>[];
  for (int i = 0; i < 12; i++) {
    final t = i / 11.0; // 0..1
    final x = 30.0 + t * 200.0;
    final y = 60.0 + (t * t) * 230.0; // curved path
    final action = i == 0
        ? 0 // ACTION_DOWN
        : i == 11
            ? 1 // ACTION_UP
            : 2; // ACTION_MOVE
    trailEvents.add(
      AndroidMotionEvent(
        downTime: 1000,
        eventTime: 1000 + i * 16,
        action: action,
        pointerCount: 1,
        pointerProperties: [AndroidPointerProperties(id: 0, toolType: 1)],
        pointerCoords: [
          AndroidPointerCoords(
            orientation: 0.0,
            pressure: 0.6 + 0.3 * t,
            size: 0.4,
            toolMajor: 12.0,
            toolMinor: 12.0,
            touchMajor: 12.0,
            touchMinor: 12.0,
            x: x,
            y: y,
          ),
        ],
        metaState: 0,
        buttonState: 0,
        xPrecision: 1.0,
        yPrecision: 1.0,
        deviceId: 0,
        edgeFlags: 0,
        source: 4098, // SOURCE_TOUCHSCREEN
        flags: 0,
        motionEventId: i + 1,
      ),
    );
  }
  print('Synthesized ${trailEvents.length} AndroidMotionEvent samples');

  final trailDots = <Widget>[];
  for (int i = 0; i < trailEvents.length; i++) {
    final ev = trailEvents[i];
    final c = ev.pointerCoords[0];
    final pressure = c.pressure;
    final radius = 6.0 + pressure * 10.0;
    final isDown = ev.action == 0;
    final isUp = ev.action == 1;
    final dotColor = isDown
        ? Colors.green
        : isUp
            ? Colors.blue
            : amber;

    trailDots.add(
      Positioned(
        left: c.x - radius,
        top: c.y - radius,
        child: Container(
          width: radius * 2.0,
          height: radius * 2.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                dotColor.withValues(alpha: 0.85),
                dotColor.withValues(alpha: 0.0),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: dotColor.withValues(alpha: 0.6),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Center(
            child: Text(
              '${i + 1}',
              style: TextStyle(
                fontSize: 9.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  final deviceFrame = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [charcoal, Colors.black],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(28.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.5),
          blurRadius: 20.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: androidGreen.withValues(alpha: 0.3),
          blurRadius: 30.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40.0,
              height: 6.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
            Icon(Icons.android, color: androidGreen, size: 16.0),
            Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        // The "screen" — embedded AndroidView area
        Container(
          height: 320.0,
          width: 280.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                androidGreen.withValues(alpha: 0.18),
                Colors.white,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: androidGreenDark, width: 2.0),
          ),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Positioned(
                top: 6.0,
                left: 6.0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 2.0,
                  ),
                  decoration: BoxDecoration(
                    color: androidGreenDark,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    'AndroidView',
                    style: TextStyle(
                      fontSize: 9.0,
                      color: Colors.white,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ),
              ...trailDots,
              Positioned(
                bottom: 6.0,
                right: 8.0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 2.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    '${trailEvents.length} events',
                    style: TextStyle(
                      fontSize: 9.0,
                      color: amber,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          width: 60.0,
          height: 6.0,
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        SizedBox(height: 10.0),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 8.0,
          runSpacing: 4.0,
          children: [
            _buildLegendDot('DOWN', Colors.green),
            _buildLegendDot('MOVE', amber),
            _buildLegendDot('UP', Colors.blue),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Multi-touch Pinch Sequence
  // ============================================================
  print('=== Section 7: Multi-touch Pinch Sequence ===');

  final pinchStepData = [
    {
      'step': 1,
      'action': 'ACTION_DOWN',
      'actionValue': 0,
      'desc': 'First finger down — pointer 0',
      'pointers': 1,
      'color': Colors.green,
    },
    {
      'step': 2,
      'action': 'ACTION_POINTER_DOWN',
      'actionValue': (1 << 8) | 5, // pointer index 1 + ACTION_POINTER_DOWN
      'desc': 'Second finger down — pointer 1',
      'pointers': 2,
      'color': Colors.purple,
    },
    {
      'step': 3,
      'action': 'ACTION_MOVE',
      'actionValue': 2,
      'desc': 'Both fingers move — pinch gesture',
      'pointers': 2,
      'color': amber,
    },
    {
      'step': 4,
      'action': 'ACTION_POINTER_UP',
      'actionValue': (1 << 8) | 6,
      'desc': 'Second finger up — pointer 1 lifted',
      'pointers': 1,
      'color': Colors.teal,
    },
    {
      'step': 5,
      'action': 'ACTION_UP',
      'actionValue': 1,
      'desc': 'Last finger up — gesture ends',
      'pointers': 0,
      'color': Colors.blue,
    },
  ];

  final pinchSteps = <Widget>[];
  for (final s in pinchStepData) {
    final color = s['color'] as Color;
    final pointers = s['pointers'] as int;
    final actionValue = s['actionValue'] as int;
    final actionName = s['action'] as String;

    // Build pointer indicators
    final pointerDots = <Widget>[];
    for (int p = 0; p < pointers; p++) {
      pointerDots.add(
        Container(
          width: 18.0,
          height: 18.0,
          margin: EdgeInsets.symmetric(horizontal: 2.0),
          decoration: BoxDecoration(
            color: p == 0 ? Colors.green : Colors.purple,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: (p == 0 ? Colors.green : Colors.purple)
                    .withValues(alpha: 0.5),
                blurRadius: 4.0,
              ),
            ],
          ),
          child: Center(
            child: Text(
              '$p',
              style: TextStyle(
                fontSize: 9.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }
    if (pointerDots.isEmpty) {
      pointerDots.add(
        Icon(Icons.do_not_touch, color: Colors.grey, size: 16.0),
      );
    }

    pinchSteps.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.08),
              Colors.white,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.2),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.5),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '${s['step']}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          actionName,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ),
                      SizedBox(width: 6.0),
                      Text(
                        '0x${actionValue.toRadixString(16).padLeft(4, '0')}',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10.0,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    s['desc'] as String,
                    style: TextStyle(fontSize: 11.0, color: charcoal),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.0),
            Row(mainAxisSize: MainAxisSize.min, children: pointerDots),
          ],
        ),
      ),
    );
  }
  print('Created ${pinchSteps.length} pinch sequence steps');

  // ============================================================
  // SECTION 8: Code Block — dispatchPointerEvent
  // ============================================================
  print('=== Section 8: Code Block ===');

  final codeBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: androidGreen.withValues(alpha: 0.4), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
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
            Container(
              width: 12.0,
              height: 12.0,
              decoration: BoxDecoration(
                color: Colors.red.shade400,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 6.0),
            Container(
              width: 12.0,
              height: 12.0,
              decoration: BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 6.0),
            Container(
              width: 12.0,
              height: 12.0,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 16.0),
            Icon(Icons.terminal, color: androidGreen, size: 16.0),
            SizedBox(width: 6.0),
            Text(
              'dispatch_pointer.dart',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildCodeLine('// Forward a synthesized touch to AndroidView',
            Colors.grey.shade500),
        _buildCodeLine('controller.dispatchPointerEvent(',
            Colors.cyan.shade300),
        _buildCodeLine('  AndroidMotionEvent(', amber),
        _buildCodeLine('    downTime: 1000,', Colors.white),
        _buildCodeLine('    eventTime: 1016,', Colors.white),
        _buildCodeLine(
            '    action: AndroidMotionEvent.actionDown, // == 0',
            Colors.white),
        _buildCodeLine('    pointerCount: 1,', Colors.white),
        _buildCodeLine('    pointerProperties: [', Colors.white),
        _buildCodeLine(
            '      AndroidPointerProperties(id: 0, toolType: 1),',
            Colors.lightGreenAccent),
        _buildCodeLine('    ],', Colors.white),
        _buildCodeLine('    pointerCoords: [', Colors.white),
        _buildCodeLine('      AndroidPointerCoords(',
            Colors.lightGreenAccent),
        _buildCodeLine(
            '        orientation: 0.0, pressure: 1.0, size: 0.5,',
            Colors.lightGreenAccent),
        _buildCodeLine(
            '        toolMajor: 10, toolMinor: 10,',
            Colors.lightGreenAccent),
        _buildCodeLine(
            '        touchMajor: 10, touchMinor: 10,',
            Colors.lightGreenAccent),
        _buildCodeLine('        x: 120.0, y: 240.0,',
            Colors.lightGreenAccent),
        _buildCodeLine('      ),', Colors.lightGreenAccent),
        _buildCodeLine('    ],', Colors.white),
        _buildCodeLine('    metaState: 0, buttonState: 0,', Colors.white),
        _buildCodeLine(
            '    xPrecision: 1.0, yPrecision: 1.0,', Colors.white),
        _buildCodeLine('    deviceId: 0, edgeFlags: 0,', Colors.white),
        _buildCodeLine(
            '    source: 4098, // SOURCE_TOUCHSCREEN',
            Colors.cyan.shade200),
        _buildCodeLine('    flags: 0, motionEventId: 1,', Colors.white),
        _buildCodeLine('  ),', amber),
        _buildCodeLine(');', Colors.cyan.shade300),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Comparison Table
  // ============================================================
  print('=== Section 9: Comparison Table ===');

  final comparisonTable = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, Colors.grey.shade100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade400, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.3),
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
            Icon(Icons.compare, color: charcoal, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Three Pointer Models, Side-By-Side',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: charcoal,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        // Header row
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          decoration: BoxDecoration(
            color: charcoal,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            children: [
              _buildTableHeader('Aspect', 110.0),
              _buildTableHeader('AndroidMotionEvent', 130.0),
              _buildTableHeader('PointerEvent', 110.0),
              _buildTableHeader('Native MotionEvent', 130.0),
            ],
          ),
        ),
        SizedBox(height: 4.0),
        _buildTableRow(
          'Layer',
          'Flutter shim',
          'Flutter framework',
          'Android Java',
          androidGreen,
          Colors.blue,
          Colors.orange,
        ),
        _buildTableRow(
          'Direction',
          'Flutter -> native',
          'gesture in Flutter',
          'OS -> app',
          androidGreen,
          Colors.blue,
          Colors.orange,
        ),
        _buildTableRow(
          'Coords',
          'AndroidPointerCoords',
          'Offset / position',
          'PointerCoords',
          androidGreen,
          Colors.blue,
          Colors.orange,
        ),
        _buildTableRow(
          'Action',
          'int (encoded)',
          'PointerEvent subtype',
          'int (encoded)',
          androidGreen,
          Colors.blue,
          Colors.orange,
        ),
        _buildTableRow(
          'Multi-touch',
          'pointerCount + arrays',
          'one event / pointer',
          'pointerCount + arrays',
          androidGreen,
          Colors.blue,
          Colors.orange,
        ),
        _buildTableRow(
          'Used by',
          'AndroidViewController',
          'GestureDetector',
          'View.dispatchTouch',
          androidGreen,
          Colors.blue,
          Colors.orange,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Footgun Cards
  // ============================================================
  print('=== Section 10: Footgun Cards ===');

  final footgunData = [
    {
      'title': 'downTime != eventTime',
      'icon': Icons.timer,
      'desc':
          'downTime is set ONCE when ACTION_DOWN fires; eventTime updates per event. '
              'Reusing eventTime as downTime breaks gesture grouping on Android.',
    },
    {
      'title': 'action is encoded',
      'icon': Icons.flash_on,
      'desc':
          'For ACTION_POINTER_DOWN/UP, the high byte holds the pointer index: '
              '(pointerIndex << 8) | actionMasked. Just passing 5 always means index 0.',
    },
    {
      'title': 'array length must == pointerCount',
      'icon': Icons.format_list_numbered,
      'desc':
          'pointerProperties.length and pointerCoords.length MUST equal pointerCount, '
              'or AndroidView dispatch silently drops events / crashes the platform view.',
    },
    {
      'title': 'source matters',
      'icon': Icons.input,
      'desc':
          'source must be a valid InputDevice source (e.g. 0x1002 = SOURCE_TOUCHSCREEN). '
              'Using 0 makes Android treat the event as SOURCE_UNKNOWN and ignore it.',
    },
    {
      'title': 'precision is not noise',
      'icon': Icons.straighten,
      'desc':
          'xPrecision / yPrecision describe device coordinate precision, NOT a fudge factor. '
              'Setting them to 0 makes Android divide by zero in some gesture pipelines.',
    },
  ];

  final footgunCards = <Widget>[];
  for (final f in footgunData) {
    footgunCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red.shade50,
              Colors.orange.shade50,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.red.shade300, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withValues(alpha: 0.18),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red.shade300, Colors.orange.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withValues(alpha: 0.4),
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: Icon(
                f['icon'] as IconData,
                color: Colors.white,
                size: 22.0,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning_amber,
                          color: Colors.red.shade700, size: 16.0),
                      SizedBox(width: 4.0),
                      Expanded(
                        child: Text(
                          f['title'] as String,
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    f['desc'] as String,
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
      ),
    );
  }
  print('Created ${footgunCards.length} footgun cards');

  // ============================================================
  // SECTION 11: Recap Card
  // ============================================================
  print('=== Section 11: Recap Card ===');

  final recapCard = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [androidGreen, androidGreenDark, charcoal],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: androidGreen.withValues(alpha: 0.4),
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
            Icon(Icons.summarize, color: amber, size: 26.0),
            SizedBox(width: 8.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildRecapLine(
          Icons.android,
          'AndroidMotionEvent wraps Android MotionEvent for the Flutter -> '
              'AndroidView channel.',
        ),
        _buildRecapLine(
          Icons.timer_outlined,
          'downTime stays fixed for a gesture; eventTime advances per sample.',
        ),
        _buildRecapLine(
          Icons.flash_on,
          'action is an int with ACTION_* constants; pointer index is encoded '
              'in the high byte.',
        ),
        _buildRecapLine(
          Icons.list_alt,
          'pointerProperties + pointerCoords must each have length == pointerCount.',
        ),
        _buildRecapLine(
          Icons.input,
          'Always set source (e.g. 4098 SOURCE_TOUCHSCREEN) or the platform '
              'will drop the event.',
        ),
        _buildRecapLine(
          Icons.touch_app,
          'Dispatched via AndroidViewController.dispatchPointerEvent(...).',
        ),
      ],
    ),
  );

  // ============================================================
  // Crafted reference event for inline display
  // ============================================================
  print('=== Building reference event ===');

  final referenceEvent = AndroidMotionEvent(
    downTime: 100,
    eventTime: 150,
    action: 0,
    pointerCount: 1,
    pointerProperties: [AndroidPointerProperties(id: 0, toolType: 1)],
    pointerCoords: [
      AndroidPointerCoords(
        orientation: 0.0,
        pressure: 1.0,
        size: 0.5,
        toolMajor: 10.0,
        toolMinor: 10.0,
        touchMajor: 10.0,
        touchMinor: 10.0,
        x: 100.0,
        y: 200.0,
      ),
    ],
    metaState: 0,
    buttonState: 0,
    xPrecision: 1.0,
    yPrecision: 1.0,
    deviceId: 0,
    edgeFlags: 0,
    source: 4098,
    flags: 0,
    motionEventId: 1,
  );
  print('Reference event runtimeType: ${referenceEvent.runtimeType}');
  print('  downTime=${referenceEvent.downTime} '
      'eventTime=${referenceEvent.eventTime}');
  print('  action=${referenceEvent.action} '
      'pointerCount=${referenceEvent.pointerCount}');
  print('  source=${referenceEvent.source} '
      'motionEventId=${referenceEvent.motionEventId}');
  final refCoords = referenceEvent.pointerCoords[0];
  print('  coords: x=${refCoords.x} y=${refCoords.y} '
      'pressure=${refCoords.pressure}');

  print('AndroidMotionEvent Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return Scaffold(
    backgroundColor: Colors.grey.shade100,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Title banner
          titleBanner,
          SizedBox(height: 28.0),

          // 2. Anatomy
          _sectionHeader('1. Anatomy', Icons.architecture, charcoal),
          anatomyDiagram,
          SizedBox(height: 24.0),

          // 3. Action constants
          _sectionHeader('2. Action Constants', Icons.flash_on, charcoal),
          SizedBox(height: 8.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: actionCards,
          ),
          SizedBox(height: 24.0),

          // 4. Pointer properties
          _sectionHeader(
            '3. AndroidPointerProperties',
            Icons.fingerprint,
            charcoal,
          ),
          SizedBox(height: 8.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: toolTypeCards,
          ),
          SizedBox(height: 24.0),

          // 5. Pointer coords
          _sectionHeader(
            '4. AndroidPointerCoords',
            Icons.scatter_plot,
            charcoal,
          ),
          SizedBox(height: 8.0),
          Wrap(
            alignment: WrapAlignment.center,
            children: coordsCards,
          ),
          SizedBox(height: 24.0),

          // 6. Real-world device mock
          _sectionHeader(
            '5. AndroidView Touch Trail',
            Icons.android,
            charcoal,
          ),
          SizedBox(height: 8.0),
          Center(child: deviceFrame),
          SizedBox(height: 24.0),

          // 7. Multi-touch flow
          _sectionHeader(
            '6. Multi-touch Pinch Sequence',
            Icons.zoom_in,
            charcoal,
          ),
          ...pinchSteps,
          SizedBox(height: 24.0),

          // 8. Code block
          _sectionHeader(
            '7. dispatchPointerEvent Code',
            Icons.code,
            charcoal,
          ),
          codeBlock,
          SizedBox(height: 24.0),

          // 9. Comparison table
          _sectionHeader('8. Comparison', Icons.compare, charcoal),
          comparisonTable,
          SizedBox(height: 24.0),

          // 10. Footguns
          _sectionHeader(
            '9. Footguns',
            Icons.warning_amber,
            Colors.red.shade700,
          ),
          ...footgunCards,
          SizedBox(height: 24.0),

          // 11. Recap
          _sectionHeader('10. Recap', Icons.summarize, charcoal),
          recapCard,
          SizedBox(height: 16.0),

          // Footer
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: charcoal,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: androidGreen, size: 18.0),
                SizedBox(width: 8.0),
                Text(
                  'AndroidMotionEvent demo complete',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontFamily: 'monospace',
                  ),
                ),
                SizedBox(width: 8.0),
                Text(
                  '(${referenceEvent.runtimeType})',
                  style: TextStyle(
                    color: amber,
                    fontSize: 11.0,
                    fontFamily: 'monospace',
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

// ============================================================
// Top-level helper functions
// ============================================================

Widget _sectionHeader(String title, IconData icon, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Icon(icon, color: color, size: 22.0),
        ),
        SizedBox(width: 10.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _buildMetricBar(String label, double value, double max, Color color) {
  final fraction = (value / max).clamp(0.0, 1.0);
  return Row(
    children: [
      SizedBox(
        width: 76.0,
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            color: Colors.grey.shade700,
          ),
        ),
      ),
      Expanded(
        child: Container(
          height: 10.0,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: fraction,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withValues(alpha: 0.7),
                    color,
                  ],
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        ),
      ),
      SizedBox(width: 6.0),
      SizedBox(
        width: 44.0,
        child: Text(
          value.toStringAsFixed(2),
          textAlign: TextAlign.right,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    ],
  );
}

Widget _buildLegendDot(String label, Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.6),
              blurRadius: 4.0,
            ),
          ],
        ),
      ),
      SizedBox(width: 4.0),
      Text(
        label,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 10.0,
          color: Colors.white70,
        ),
      ),
    ],
  );
}

Widget _buildCodeLine(String line, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.0),
    child: Text(
      line,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: color,
        height: 1.4,
      ),
    ),
  );
}

Widget _buildTableHeader(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget _buildTableRow(
  String aspect,
  String android,
  String pointer,
  String native,
  Color cAndroid,
  Color cPointer,
  Color cNative,
) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
      ),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 110.0,
          child: Text(
            aspect,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        _buildTableCell(android, 130.0, cAndroid),
        _buildTableCell(pointer, 110.0, cPointer),
        _buildTableCell(native, 130.0, cNative),
      ],
    ),
  );
}

Widget _buildTableCell(String text, double width, Color color) {
  return SizedBox(
    width: width,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 10.0,
          color: color,
          fontFamily: 'monospace',
        ),
      ),
    ),
  );
}

Widget _buildRecapLine(IconData icon, String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Color(0xFFFFB300), size: 16.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}
