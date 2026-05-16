// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element
// D4rt test script: Advanced Gesture Atlas — Pointer Choreography Gallery
// Visual deep-demo for advanced GestureDetector callbacks: scale, long-press move,
// force press, hover, secondary tap, pan-zoom, hit-test behavior, supported devices,
// mouse cursors, trackpad scaling, RawGestureDetector, and multi-finger gestures.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// ============================================================================
// SMALL HELPERS
// ============================================================================

Widget _sectionBanner(int number, String title, String subtitle, Color base,
    Color accent, String emoji) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 24.0, bottom: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [base, accent],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Row(
      children: [
        Container(
          width: 42.0,
          height: 42.0,
          decoration: BoxDecoration(
            color: Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Text(
              '$number',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SECTION $number: $title',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                subtitle,
                style: TextStyle(
                    fontSize: 12.0, color: Color(0xCCFFFFFF), height: 1.3),
              ),
            ],
          ),
        ),
        Text(emoji, style: TextStyle(fontSize: 26.0)),
      ],
    ),
  );
}

Widget _recipeCard(String title, String body, Color bg, Color fg, Color border) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 10.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: border, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: fg,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          body,
          style: TextStyle(fontSize: 12.0, color: Color(0xFF424242), height: 1.4),
        ),
      ],
    ),
  );
}

Widget _chip(String label, Color color) {
  return Container(
    margin: EdgeInsets.only(right: 6.0, bottom: 6.0),
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Text(
      label,
      style: TextStyle(
          color: Color(0xFFFFFFFF), fontSize: 10.0, fontWeight: FontWeight.bold),
    ),
  );
}

Widget _tableHeader(List<String> labels, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      ),
    ),
    child: Row(
      children: [
        for (final l in labels)
          Expanded(
            child: Text(
              l,
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _tableRow(List<String> cells, Color bg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
    decoration: BoxDecoration(color: bg),
    child: Row(
      children: [
        for (final c in cells)
          Expanded(
            child: Text(
              c,
              style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: Color(0xFF263238)),
            ),
          ),
      ],
    ),
  );
}

Widget _radialOverlay(double t, Color core, Color halo) {
  return SizedBox(
    width: 120.0,
    height: 120.0,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: 0.25,
          child: Container(
            width: 110.0 * t,
            height: 110.0 * t,
            decoration: BoxDecoration(color: halo, shape: BoxShape.circle),
          ),
        ),
        Opacity(
          opacity: 0.55,
          child: Container(
            width: 70.0 * t,
            height: 70.0 * t,
            decoration: BoxDecoration(color: halo, shape: BoxShape.circle),
          ),
        ),
        Container(
          width: 28.0,
          height: 28.0,
          decoration: BoxDecoration(color: core, shape: BoxShape.circle),
          child: Center(
            child: Text('●',
                style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 14.0)),
          ),
        ),
      ],
    ),
  );
}

Widget _arrowPair(Color color) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('◀',
          style: TextStyle(
              color: color, fontSize: 22.0, fontWeight: FontWeight.bold)),
      SizedBox(width: 10.0),
      Container(width: 60.0, height: 4.0, color: color),
      SizedBox(width: 10.0),
      Text('▶',
          style: TextStyle(
              color: color, fontSize: 22.0, fontWeight: FontWeight.bold)),
    ],
  );
}

Widget _fingerDot(Color color, double size) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
      border: Border.all(color: Color(0xFFFFFFFF), width: 2.0),
    ),
  );
}

Widget _glossaryRow(String term, String defn, Color tag) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6.0,
          height: 30.0,
          decoration: BoxDecoration(
            color: tag,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        SizedBox(width: 10.0),
        SizedBox(
          width: 150.0,
          child: Text(
            term,
            style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF263238)),
          ),
        ),
        Expanded(
          child: Text(
            defn,
            style: TextStyle(
                fontSize: 12.0, color: Color(0xFF424242), height: 1.4),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION BUILDERS
// ============================================================================

Widget _heroHeader() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF311B92), Color(0xFF512DA8), Color(0xFF7E57C2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text('🖐',
                  style: TextStyle(fontSize: 28.0, color: Color(0xFFFFFFFF))),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Advanced Gesture Atlas',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFFFFF),
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Pointer Choreography Gallery',
                    style: TextStyle(
                        fontSize: 15.0, color: Color(0xFFD1C4E9)),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Wrap(
          children: [
            _chip('scale', Color(0xFF7C4DFF)),
            _chip('long-press-move', Color(0xFFAB47BC)),
            _chip('force-press', Color(0xFFE91E63)),
            _chip('hover', Color(0xFF26C6DA)),
            _chip('secondary-tap', Color(0xFFFF7043)),
            _chip('pan-zoom', Color(0xFF66BB6A)),
            _chip('hit-test', Color(0xFF42A5F5)),
            _chip('mouse-cursor', Color(0xFFFFA726)),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0x22FFFFFF),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'A static visual deep-demo of advanced GestureDetector wiring. '
            'All callbacks are inert no-ops; the gallery focuses on the '
            'shapes, types, and intent of each gesture surface.',
            style: TextStyle(
                fontSize: 13.0, color: Color(0xFFEDE7F6), height: 1.5),
          ),
        ),
      ],
    ),
  );
}

Widget _overviewPanel() {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 18.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFEDE7F6),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Color(0xFFB39DDB), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color(0xFF512DA8),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child:
                  Text('🗺', style: TextStyle(fontSize: 18.0)),
            ),
            SizedBox(width: 10.0),
            Text(
              'Concept Overview',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF311B92),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Advanced gestures extend the basic tap/drag vocabulary with '
          'continuous-magnitude reports (scale, force), pointer-specific '
          'event channels (mouse hover, secondary buttons, trackpad), and '
          'hit-test customization. Flutter exposes these through '
          'GestureDetector callbacks, RawGestureDetector recognizers, and '
          'MouseRegion-style cursor management.',
          style: TextStyle(fontSize: 13.0, height: 1.5),
        ),
        SizedBox(height: 10.0),
        Text(
          'Key surfaces covered in this gallery:',
          style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6.0),
        Text('• Scale lifecycle: onScaleStart / onScaleUpdate / onScaleEnd',
            style: TextStyle(fontSize: 12.0)),
        Text('• Long-press continuum: onLongPressStart / Move / End',
            style: TextStyle(fontSize: 12.0)),
        Text('• Force press (3D Touch): onForcePressStart / Peak / Update / End',
            style: TextStyle(fontSize: 12.0)),
        Text('• Pointer hover, secondary & tertiary taps',
            style: TextStyle(fontSize: 12.0)),
        Text('• Trackpad pan-zoom recognizers',
            style: TextStyle(fontSize: 12.0)),
        Text('• HitTestBehavior, supportedDevices, mouseCursor',
            style: TextStyle(fontSize: 12.0)),
        Text('• RawGestureDetector + GestureRecognizerFactory',
            style: TextStyle(fontSize: 12.0)),
      ],
    ),
  );
}

// SECTION 1: SCALE LIFECYCLE — onScaleStart / onScaleUpdate / onScaleEnd
Widget _section1Scale() {
  final scaleDetector = GestureDetector(
    onScaleStart: (ScaleStartDetails d) {},
    onScaleUpdate: (ScaleUpdateDetails d) {},
    onScaleEnd: (ScaleEndDetails d) {},
    child: SizedBox.shrink(),
  );
  final hasScaleStart = scaleDetector.onScaleStart != null;
  final hasScaleUpdate = scaleDetector.onScaleUpdate != null;
  final hasScaleEnd = scaleDetector.onScaleEnd != null;

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF64B5F6), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Scale Lifecycle (Pinch / Zoom / Rotate)',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D47A1),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Scale callbacks fire as a continuous magnitude evolves between '
          'two or more pointers. The Start details carry the focal point '
          'and pointer count; Update carries scale, horizontalScale, '
          'verticalScale, rotation, focalPoint, focalPointDelta, '
          'pointerCount; End carries velocity and pointerCount.',
          style: TextStyle(fontSize: 12.0, height: 1.5),
        ),
        SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                _radialOverlay(0.4, Color(0xFF1976D2), Color(0xFF42A5F5)),
                SizedBox(height: 6.0),
                Text('onScaleStart',
                    style: TextStyle(
                        fontSize: 11.0, fontWeight: FontWeight.bold)),
                Text('scale: 1.00',
                    style: TextStyle(
                        fontSize: 10.0, fontFamily: 'monospace')),
              ],
            ),
            Column(
              children: [
                _radialOverlay(0.75, Color(0xFF1976D2), Color(0xFF42A5F5)),
                SizedBox(height: 6.0),
                Text('onScaleUpdate',
                    style: TextStyle(
                        fontSize: 11.0, fontWeight: FontWeight.bold)),
                Text('scale: 1.85',
                    style: TextStyle(
                        fontSize: 10.0, fontFamily: 'monospace')),
              ],
            ),
            Column(
              children: [
                _radialOverlay(1.0, Color(0xFF1976D2), Color(0xFF42A5F5)),
                SizedBox(height: 6.0),
                Text('onScaleEnd',
                    style: TextStyle(
                        fontSize: 11.0, fontWeight: FontWeight.bold)),
                Text('velocity: 1.4',
                    style: TextStyle(
                        fontSize: 10.0, fontFamily: 'monospace')),
              ],
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _tableHeader(
            ['Callback', 'Details Type', 'Bound'], Color(0xFF1976D2)),
        _tableRow(
            ['onScaleStart', 'ScaleStartDetails', hasScaleStart ? '✓' : '✗'],
            Color(0xFFBBDEFB)),
        _tableRow(
            ['onScaleUpdate', 'ScaleUpdateDetails', hasScaleUpdate ? '✓' : '✗'],
            Color(0xFFD0E5FA)),
        _tableRow(
            ['onScaleEnd', 'ScaleEndDetails', hasScaleEnd ? '✓' : '✗'],
            Color(0xFFBBDEFB)),
        SizedBox(height: 12.0),
        _recipeCard(
          'Recipe: Pinch-to-Zoom',
          'Wire onScaleStart to snapshot the initial transform. In '
              'onScaleUpdate, multiply by details.scale and translate by '
              'details.focalPointDelta. In onScaleEnd, apply a fling using '
              'details.velocity.pixelsPerSecond.',
          Color(0xFFE1F5FE),
          Color(0xFF01579B),
          Color(0xFF81D4FA),
        ),
      ],
    ),
  );
}

// SECTION 2: LONG PRESS CONTINUUM
Widget _section2LongPressMove() {
  final det = GestureDetector(
    onLongPressStart: (LongPressStartDetails d) {},
    onLongPressMoveUpdate: (LongPressMoveUpdateDetails d) {},
    onLongPressEnd: (LongPressEndDetails d) {},
    onLongPressUp: () {},
    child: SizedBox.shrink(),
  );

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFCE93D8), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Long Press Continuum',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A148C),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Once a long-press is recognized, Flutter streams updates as the '
          'finger drags. Use onLongPressStart to anchor the origin, '
          'onLongPressMoveUpdate to follow drag offsets, and '
          'onLongPressEnd / onLongPressUp to finalize.',
          style: TextStyle(fontSize: 12.0, height: 1.5),
        ),
        SizedBox(height: 14.0),
        Container(
          height: 90.0,
          decoration: BoxDecoration(
            color: Color(0xFFE1BEE7),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 16.0,
                top: 30.0,
                child: _fingerDot(Color(0xFF6A1B9A), 28.0),
              ),
              Positioned(
                left: 80.0,
                top: 22.0,
                child: Container(
                    width: 6.0, height: 6.0, color: Color(0xFF7B1FA2)),
              ),
              Positioned(
                left: 130.0,
                top: 38.0,
                child: Container(
                    width: 6.0, height: 6.0, color: Color(0xFF7B1FA2)),
              ),
              Positioned(
                left: 180.0,
                top: 30.0,
                child: Container(
                    width: 6.0, height: 6.0, color: Color(0xFF7B1FA2)),
              ),
              Positioned(
                right: 16.0,
                top: 26.0,
                child: _fingerDot(Color(0xFF8E24AA), 32.0),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        _tableHeader(['Phase', 'Callback', 'Details'], Color(0xFF7B1FA2)),
        _tableRow([
          '1. press',
          'onLongPressStart',
          'LongPressStartDetails'
        ], Color(0xFFE1BEE7)),
        _tableRow([
          '2. drag',
          'onLongPressMoveUpdate',
          'LongPressMoveUpdateDetails'
        ], Color(0xFFEDD5F1)),
        _tableRow([
          '3. lift',
          'onLongPressEnd',
          'LongPressEndDetails'
        ], Color(0xFFE1BEE7)),
        _tableRow([
          '4. completed',
          'onLongPressUp',
          'void Function()'
        ], Color(0xFFEDD5F1)),
        SizedBox(height: 8.0),
        Text(
          det.onLongPressMoveUpdate != null
              ? 'onLongPressMoveUpdate is bound ✓'
              : 'onLongPressMoveUpdate is unbound ✗',
          style: TextStyle(
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
            color: Color(0xFF4A148C),
          ),
        ),
      ],
    ),
  );
}

// SECTION 3: FORCE PRESS (3D Touch)
Widget _section3ForcePress() {
  final det = GestureDetector(
    onForcePressStart: (ForcePressDetails d) {},
    onForcePressPeak: (ForcePressDetails d) {},
    onForcePressUpdate: (ForcePressDetails d) {},
    onForcePressEnd: (ForcePressDetails d) {},
    child: SizedBox.shrink(),
  );

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFEBEE),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFE57373), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Force Press (Pressure-Sensitive)',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFB71C1C),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'For devices that report pressure (iOS 3D Touch), Flutter emits a '
          'lifecycle of ForcePressDetails events. Each includes globalPosition, '
          'localPosition, and a normalized pressure 0..1.',
          style: TextStyle(fontSize: 12.0, height: 1.5),
        ),
        SizedBox(height: 14.0),
        Row(
          children: [
            for (final p in <double>[0.05, 0.35, 0.85, 1.0, 0.5])
              Expanded(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 3.0),
                      height: 60.0 * (p + 0.2),
                      decoration: BoxDecoration(
                        color: Color.lerp(Color(0xFFFFCDD2),
                            Color(0xFFB71C1C), p) ??
                            Color(0xFFE57373),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(p.toStringAsFixed(2),
                        style: TextStyle(
                            fontSize: 10.0, fontFamily: 'monospace')),
                  ],
                ),
              ),
          ],
        ),
        SizedBox(height: 12.0),
        _tableHeader(
            ['Phase', 'Callback', 'Pressure'], Color(0xFFC62828)),
        _tableRow(
            ['Engage', 'onForcePressStart', '~0.05'], Color(0xFFFFCDD2)),
        _tableRow(
            ['Peak', 'onForcePressPeak', '1.00'], Color(0xFFFFE0E2)),
        _tableRow(
            ['Stream', 'onForcePressUpdate', 'continuous'], Color(0xFFFFCDD2)),
        _tableRow(
            ['Release', 'onForcePressEnd', '→ 0'], Color(0xFFFFE0E2)),
        SizedBox(height: 10.0),
        _recipeCard(
          'Recipe: Pressure Preview',
          'Use onForcePressStart to fade in a preview overlay and '
              'onForcePressPeak to commit to a navigation push. '
              'onForcePressUpdate can drive a parallax effect as the user '
              'modulates pressure.',
          Color(0xFFFFF5F5),
          Color(0xFFB71C1C),
          Color(0xFFFFAB91),
        ),
        Text(
          det.onForcePressStart != null
              ? 'All four force-press hooks are bound ✓'
              : 'Force-press hooks are unbound ✗',
          style: TextStyle(
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
            color: Color(0xFFB71C1C),
          ),
        ),
      ],
    ),
  );
}

// SECTION 4: MOUSE HOVER & POINTER EVENTS
Widget _section4Hover() {
  final region = MouseRegion(
    onEnter: (PointerEnterEvent e) {},
    onExit: (PointerExitEvent e) {},
    onHover: (PointerHoverEvent e) {},
    cursor: SystemMouseCursors.click,
    child: SizedBox.shrink(),
  );

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFE0F7FA),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF4DD0E1), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pointer Hover (Mouse / Trackpad)',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF006064),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Hover events come from devices that can report a position without '
          'a button press: mice, trackpads, and styluses. MouseRegion exposes '
          'onEnter, onExit, and onHover with PointerHoverEvent details.',
          style: TextStyle(fontSize: 12.0, height: 1.5),
        ),
        SizedBox(height: 14.0),
        Container(
          height: 70.0,
          decoration: BoxDecoration(
            color: Color(0xFFB2EBF2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 30.0,
                top: 22.0,
                child: Text('↖',
                    style: TextStyle(
                        fontSize: 26.0, color: Color(0xFF006064))),
              ),
              Positioned(
                left: 80.0,
                top: 18.0,
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Color(0xFF00838F), width: 2.0),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              Positioned(
                left: 150.0,
                top: 26.0,
                child: Text('onEnter →',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF006064))),
              ),
              Positioned(
                left: 250.0,
                top: 22.0,
                child: Text('onHover ↻',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF006064))),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        _tableHeader(
            ['Event', 'Class', 'Use'], Color(0xFF00838F)),
        _tableRow([
          'onEnter',
          'PointerEnterEvent',
          'cursor enters region'
        ], Color(0xFFB2EBF2)),
        _tableRow([
          'onExit',
          'PointerExitEvent',
          'cursor leaves region'
        ], Color(0xFFC1ECF1)),
        _tableRow([
          'onHover',
          'PointerHoverEvent',
          'cursor moves inside'
        ], Color(0xFFB2EBF2)),
        SizedBox(height: 10.0),
        Text(
          region.cursor == SystemMouseCursors.click
              ? 'MouseRegion.cursor = SystemMouseCursors.click ✓'
              : 'MouseRegion.cursor differs ✗',
          style: TextStyle(
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
            color: Color(0xFF006064),
          ),
        ),
      ],
    ),
  );
}

// SECTION 5: SECONDARY & TERTIARY TAPS
Widget _section5SecondaryTaps() {
  final det = GestureDetector(
    onSecondaryTap: () {},
    onSecondaryTapDown: (TapDownDetails d) {},
    onSecondaryTapUp: (TapUpDetails d) {},
    onSecondaryTapCancel: () {},
    onTertiaryTapDown: (TapDownDetails d) {},
    onTertiaryTapUp: (TapUpDetails d) {},
    onTertiaryTapCancel: () {},
    child: SizedBox.shrink(),
  );

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFFFB74D), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Secondary & Tertiary Buttons',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE65100),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'GestureDetector distinguishes primary (left), secondary (right), '
          'and tertiary (middle / forward / back) buttons. Each has the '
          'full down / up / cancel lifecycle, plus a convenience "tap".',
          style: TextStyle(fontSize: 12.0, height: 1.5),
        ),
        SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Container(
                  width: 60.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFCC80),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Center(child: Text('1°', style: TextStyle(fontSize: 22.0))),
                ),
                SizedBox(height: 4.0),
                Text('primary',
                    style: TextStyle(fontSize: 10.0)),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 60.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFB74D),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Center(child: Text('2°', style: TextStyle(fontSize: 22.0))),
                ),
                SizedBox(height: 4.0),
                Text('secondary',
                    style: TextStyle(fontSize: 10.0)),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 60.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF9800),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Center(child: Text('3°', style: TextStyle(fontSize: 22.0))),
                ),
                SizedBox(height: 4.0),
                Text('tertiary',
                    style: TextStyle(fontSize: 10.0)),
              ],
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _tableHeader(
            ['Button', 'Callback Group', 'Bound?'], Color(0xFFEF6C00)),
        _tableRow([
          'secondary',
          'onSecondaryTap*',
          det.onSecondaryTap != null ? '✓' : '✗'
        ], Color(0xFFFFE0B2)),
        _tableRow([
          'tertiary',
          'onTertiaryTap*',
          det.onTertiaryTapDown != null ? '✓' : '✗'
        ], Color(0xFFFFECC5)),
        SizedBox(height: 8.0),
        _recipeCard(
          'Recipe: Context Menu on Right-Click',
          'Use onSecondaryTapUp to capture details.globalPosition and '
              'open a popup at that location. Bind onSecondaryTapCancel '
              'to dismiss any preview overlay.',
          Color(0xFFFFF8E1),
          Color(0xFFE65100),
          Color(0xFFFFB74D),
        ),
      ],
    ),
  );
}

// SECTION 6: PAN-ZOOM (Trackpad)
Widget _section6PanZoom() {
  final det = GestureDetector(
    onScaleStart: (ScaleStartDetails d) {},
    trackpadScrollCausesScale: true,
    supportedDevices: <PointerDeviceKind>{
      PointerDeviceKind.touch,
      PointerDeviceKind.trackpad,
      PointerDeviceKind.mouse,
    },
    child: SizedBox.shrink(),
  );

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF81C784), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trackpad Pan-Zoom & Supported Devices',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B5E20),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'GestureDetector accepts a supportedDevices set to restrict which '
          'PointerDeviceKind values produce events. The '
          'trackpadScrollCausesScale flag re-routes a two-finger trackpad '
          'scroll into the scale callback channel — handy for desktop zoom.',
          style: TextStyle(fontSize: 12.0, height: 1.5),
        ),
        SizedBox(height: 14.0),
        Wrap(
          children: [
            for (final kind in <PointerDeviceKind>{
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.stylus,
              PointerDeviceKind.invertedStylus,
              PointerDeviceKind.trackpad,
              PointerDeviceKind.unknown,
            })
              _chip(kind.name,
                  det.supportedDevices?.contains(kind) ?? false
                      ? Color(0xFF2E7D32)
                      : Color(0xFFBDBDBD)),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          height: 80.0,
          decoration: BoxDecoration(
            color: Color(0xFFC8E6C9),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('↕',
                  style: TextStyle(
                      fontSize: 40.0,
                      color: Color(0xFF1B5E20),
                      fontWeight: FontWeight.bold)),
              SizedBox(width: 14.0),
              Text('⇒',
                  style: TextStyle(
                      fontSize: 36.0, color: Color(0xFF2E7D32))),
              SizedBox(width: 14.0),
              Text('⤡',
                  style: TextStyle(
                      fontSize: 36.0, color: Color(0xFF388E3C))),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        _tableHeader(['Property', 'Value', 'Note'], Color(0xFF2E7D32)),
        _tableRow([
          'trackpadScrollCausesScale',
          det.trackpadScrollCausesScale ? 'true' : 'false',
          'pan→scale routing'
        ], Color(0xFFC8E6C9)),
        _tableRow([
          'supportedDevices.length',
          '${det.supportedDevices?.length ?? 0}',
          'whitelist size'
        ], Color(0xFFD4EDDA)),
      ],
    ),
  );
}

// SECTION 7: HIT-TEST BEHAVIOR
Widget _section7HitTest() {
  final detOpaque = GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {},
    child: SizedBox.shrink(),
  );
  final detTranslucent = GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () {},
    child: SizedBox.shrink(),
  );
  final detDeferToChild = GestureDetector(
    behavior: HitTestBehavior.deferToChild,
    onTap: () {},
    child: SizedBox.shrink(),
  );

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFDE7),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFFFD54F), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'HitTestBehavior',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFF57F17),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'HitTestBehavior determines how a widget participates in hit '
          'testing. opaque catches all pointer events over its bounds, '
          'translucent catches them but lets siblings underneath also '
          'receive, and deferToChild only catches if a child is hit.',
          style: TextStyle(fontSize: 12.0, height: 1.5),
        ),
        SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (final entry in <Map<String, dynamic>>[
              {
                'name': 'opaque',
                'color': Color(0xFFF9A825),
                'desc': 'absorbs',
                'value': detOpaque.behavior,
              },
              {
                'name': 'translucent',
                'color': Color(0xFFFFB300),
                'desc': 'passes through',
                'value': detTranslucent.behavior,
              },
              {
                'name': 'deferToChild',
                'color': Color(0xFFFFCA28),
                'desc': 'child decides',
                'value': detDeferToChild.behavior,
              },
            ])
              Column(
                children: [
                  Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      color: entry['color'] as Color,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        '⌘',
                        style: TextStyle(
                            fontSize: 28.0,
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(entry['name'] as String,
                      style: TextStyle(
                          fontSize: 11.0, fontWeight: FontWeight.bold)),
                  Text(entry['desc'] as String,
                      style: TextStyle(
                          fontSize: 10.0, color: Color(0xFF6D4C41))),
                ],
              ),
          ],
        ),
        SizedBox(height: 14.0),
        _tableHeader(['Behavior', 'Selected', 'Notes'], Color(0xFFF9A825)),
        _tableRow(
            ['opaque', detOpaque.behavior?.name ?? 'null', 'absorbs all events'],
            Color(0xFFFFF8E1)),
        _tableRow([
          'translucent',
          detTranslucent.behavior?.name ?? 'null',
          'co-exists with siblings'
        ], Color(0xFFFFF1C5)),
        _tableRow([
          'deferToChild',
          detDeferToChild.behavior?.name ?? 'null',
          'pass through unless child hits'
        ], Color(0xFFFFF8E1)),
      ],
    ),
  );
}

// SECTION 8: MOUSE CURSOR
Widget _section8MouseCursor() {
  final cursors = <MapEntry<String, MouseCursor>>[
    MapEntry('basic', SystemMouseCursors.basic),
    MapEntry('click', SystemMouseCursors.click),
    MapEntry('text', SystemMouseCursors.text),
    MapEntry('grab', SystemMouseCursors.grab),
    MapEntry('grabbing', SystemMouseCursors.grabbing),
    MapEntry('forbidden', SystemMouseCursors.forbidden),
    MapEntry('move', SystemMouseCursors.move),
    MapEntry('resizeUpDown', SystemMouseCursors.resizeUpDown),
    MapEntry('resizeLeftRight', SystemMouseCursors.resizeLeftRight),
    MapEntry('progress', SystemMouseCursors.progress),
    MapEntry('wait', SystemMouseCursors.wait),
    MapEntry('cell', SystemMouseCursors.cell),
    MapEntry('precise', SystemMouseCursors.precise),
    MapEntry('zoomIn', SystemMouseCursors.zoomIn),
    MapEntry('zoomOut', SystemMouseCursors.zoomOut),
    MapEntry('contextMenu', SystemMouseCursors.contextMenu),
    MapEntry('help', SystemMouseCursors.help),
    MapEntry('copy', SystemMouseCursors.copy),
    MapEntry('alias', SystemMouseCursors.alias),
    MapEntry('disappearing', SystemMouseCursors.disappearing),
  ];

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF7986CB), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SystemMouseCursors Gallery',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A237E),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Flutter ships a catalogue of platform-mapped cursors via '
          'SystemMouseCursors. Attach one through MouseRegion.cursor or '
          'GestureDetector-wrapped MouseRegion to express affordance.',
          style: TextStyle(fontSize: 12.0, height: 1.5),
        ),
        SizedBox(height: 14.0),
        Wrap(
          children: [
            for (final c in cursors)
              Container(
                margin: EdgeInsets.only(right: 8.0, bottom: 8.0),
                padding: EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: Color(0xFFC5CAE9),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                        color: Color(0xFF3949AB),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6.0),
                    Text(c.key,
                        style: TextStyle(
                            fontSize: 11.0,
                            color: Color(0xFF1A237E),
                            fontWeight: FontWeight.bold)),
                    SizedBox(width: 6.0),
                    Text(
                      c.value.runtimeType.toString(),
                      style: TextStyle(
                          fontSize: 10.0,
                          fontFamily: 'monospace',
                          color: Color(0xFF3F51B5)),
                    ),
                  ],
                ),
              ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          '${cursors.length} system cursors catalogued',
          style: TextStyle(
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
            color: Color(0xFF303F9F),
          ),
        ),
      ],
    ),
  );
}

// SECTION 9: POINTER DETAIL RECORDS
Widget _section9PointerDetails() {
  final records = <Map<String, String>>[
    {
      'type': 'ScaleStartDetails',
      'fields': 'focalPoint, localFocalPoint, pointerCount, sourceTimeStamp'
    },
    {
      'type': 'ScaleUpdateDetails',
      'fields':
          'focalPoint, focalPointDelta, scale, horizontalScale, verticalScale, rotation, pointerCount'
    },
    {
      'type': 'ScaleEndDetails',
      'fields': 'velocity, scaleVelocity, pointerCount'
    },
    {
      'type': 'ForcePressDetails',
      'fields': 'globalPosition, localPosition, pressure'
    },
    {
      'type': 'LongPressStartDetails',
      'fields': 'globalPosition, localPosition'
    },
    {
      'type': 'LongPressMoveUpdateDetails',
      'fields': 'globalPosition, localPosition, offsetFromOrigin, localOffsetFromOrigin'
    },
    {
      'type': 'LongPressEndDetails',
      'fields': 'globalPosition, localPosition, velocity'
    },
    {
      'type': 'TapDownDetails',
      'fields': 'globalPosition, localPosition, kind'
    },
    {
      'type': 'TapUpDetails',
      'fields': 'globalPosition, localPosition, kind'
    },
    {
      'type': 'DragDownDetails',
      'fields': 'globalPosition, localPosition'
    },
    {
      'type': 'DragStartDetails',
      'fields': 'globalPosition, localPosition, sourceTimeStamp, kind'
    },
    {
      'type': 'DragUpdateDetails',
      'fields': 'globalPosition, localPosition, delta, primaryDelta, sourceTimeStamp'
    },
    {
      'type': 'DragEndDetails',
      'fields': 'velocity, primaryVelocity'
    },
  ];

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFFCE4EC),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFF06292), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pointer Detail Records',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF880E4F),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Each callback receives an immutable details object describing '
          'the gesture state. The table below enumerates the canonical '
          'fields each record carries.',
          style: TextStyle(fontSize: 12.0, height: 1.5),
        ),
        SizedBox(height: 14.0),
        for (final r in records)
          Container(
            margin: EdgeInsets.only(bottom: 6.0),
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Color(0xFFF8BBD0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  r['type']!,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                      color: Color(0xFF880E4F)),
                ),
                SizedBox(height: 3.0),
                Text(
                  r['fields']!,
                  style: TextStyle(
                      fontSize: 11.0,
                      fontFamily: 'monospace',
                      color: Color(0xFF4E342E),
                      height: 1.4),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

// SECTION 10: MULTI-FINGER & POINTER COUNT
Widget _section10MultiFinger() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFEFEBE9),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFA1887F), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Multi-Finger Gestures',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3E2723),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'ScaleUpdateDetails.pointerCount lets you branch on finger count: '
          '1 finger → pan, 2 → pinch & rotate, 3+ → custom multi-touch.',
          style: TextStyle(fontSize: 12.0, height: 1.5),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFFD7CCC8),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (final entry in <Map<String, dynamic>>[
                {'n': 1, 'color': Color(0xFFBCAAA4), 'label': 'pan'},
                {'n': 2, 'color': Color(0xFFA1887F), 'label': 'pinch'},
                {'n': 3, 'color': Color(0xFF8D6E63), 'label': 'rotate-3'},
                {'n': 4, 'color': Color(0xFF6D4C41), 'label': 'system'},
                {'n': 5, 'color': Color(0xFF5D4037), 'label': 'global'},
              ])
                Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (var i = 0; i < (entry['n'] as int); i++)
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 1.0),
                            child: _fingerDot(entry['color'] as Color, 12.0),
                          ),
                      ],
                    ),
                    SizedBox(height: 6.0),
                    Text('${entry['n']}-finger',
                        style: TextStyle(
                            fontSize: 10.0, fontWeight: FontWeight.bold)),
                    Text(entry['label'] as String,
                        style: TextStyle(
                            fontSize: 10.0,
                            color: Color(0xFF5D4037))),
                  ],
                ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        _tableHeader(
            ['pointerCount', 'Convention', 'Example'], Color(0xFF6D4C41)),
        _tableRow(
            ['1', 'single drag', 'list scroll'], Color(0xFFD7CCC8)),
        _tableRow(
            ['2', 'pinch / rotate', 'photo zoom'], Color(0xFFE3DCD7)),
        _tableRow(
            ['3', 'three-finger', 'workspace switch'], Color(0xFFD7CCC8)),
        _tableRow(
            ['4+', 'system / global', 'app switch'], Color(0xFFE3DCD7)),
        SizedBox(height: 10.0),
        Row(
          children: [
            Text('MultitouchDragStrategy:',
                style: TextStyle(
                    fontSize: 11.0, fontWeight: FontWeight.bold)),
            SizedBox(width: 8.0),
            for (final s in MultitouchDragStrategy.values)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0),
                child: _chip(s.name, Color(0xFF6D4C41)),
              ),
          ],
        ),
      ],
    ),
  );
}

// SECTION 11: RAW GESTURE DETECTOR
Widget _section11RawDetector() {
  final factories = <Type, GestureRecognizerFactory>{
    TapGestureRecognizer:
        GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
      () => TapGestureRecognizer(),
      (TapGestureRecognizer r) {
        r.onTap = () {};
      },
    ),
    LongPressGestureRecognizer:
        GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
      () => LongPressGestureRecognizer(),
      (LongPressGestureRecognizer r) {
        r.onLongPress = () {};
      },
    ),
    ScaleGestureRecognizer:
        GestureRecognizerFactoryWithHandlers<ScaleGestureRecognizer>(
      () => ScaleGestureRecognizer(),
      (ScaleGestureRecognizer r) {
        r.onStart = (ScaleStartDetails d) {};
      },
    ),
  };
  final raw = RawGestureDetector(
    gestures: factories,
    behavior: HitTestBehavior.translucent,
    child: SizedBox.shrink(),
  );

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFE0F2F1),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF4DB6AC), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'RawGestureDetector & Recognizer Factories',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF004D40),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'When the GestureDetector callback surface is too rigid, drop down '
          'to RawGestureDetector. It accepts a map of recognizer factories, '
          'letting you mix-and-match TapGestureRecognizer, '
          'LongPressGestureRecognizer, ScaleGestureRecognizer, and friends — '
          'with full control over arena participation.',
          style: TextStyle(fontSize: 12.0, height: 1.5),
        ),
        SizedBox(height: 14.0),
        _tableHeader(['Recognizer', 'Bound Handler', 'Class'],
            Color(0xFF00796B)),
        for (final entry in raw.gestures.entries)
          _tableRow([
            entry.key.toString(),
            'onTap / onLongPress / onStart',
            entry.value.runtimeType.toString(),
          ], Color(0xFFB2DFDB)),
        SizedBox(height: 8.0),
        Text(
          'behavior: ${raw.behavior?.name ?? "default"}',
          style: TextStyle(
              fontSize: 11.0,
              fontStyle: FontStyle.italic,
              color: Color(0xFF00695C)),
        ),
        SizedBox(height: 8.0),
        _recipeCard(
          'Recipe: Multi-Recognizer Custom Widget',
          'Use RawGestureDetector when one widget must respond to several '
              'orthogonal gestures (tap, long-press, drag, scale) and you '
              'need to tune deadline, duration, or arena strategy on each '
              'recognizer.',
          Color(0xFFE0F7F4),
          Color(0xFF004D40),
          Color(0xFF80CBC4),
        ),
      ],
    ),
  );
}

// SECTION 12: GLOSSARY & EPILOGUE
Widget _section12Glossary() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFFFD54F), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Glossary',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFF57F17),
          ),
        ),
        SizedBox(height: 10.0),
        _glossaryRow('focalPoint',
            'Average of all active pointer positions during a scale gesture.',
            Color(0xFFFFA000)),
        _glossaryRow('focalPointDelta',
            'Per-frame translation of the focalPoint since last update.',
            Color(0xFFFFB300)),
        _glossaryRow('pointerCount',
            'Number of pointers currently engaged in the gesture.',
            Color(0xFFFFC107)),
        _glossaryRow('pressure',
            'Normalized pressure 0..1 reported by 3D-Touch hardware.',
            Color(0xFFFFD54F)),
        _glossaryRow('HitTestBehavior',
            'opaque / translucent / deferToChild — controls hit absorption.',
            Color(0xFFFFE082)),
        _glossaryRow('arena',
            'Gesture arbitration system that resolves competing recognizers.',
            Color(0xFFFFECB3)),
        _glossaryRow('MouseCursor',
            'Abstract cursor; SystemMouseCursors offers a stock catalogue.',
            Color(0xFFFFF59D)),
        _glossaryRow('trackpadScrollCausesScale',
            'Routes two-finger trackpad scroll into the scale callback channel.',
            Color(0xFFFFE082)),
        _glossaryRow('PointerDeviceKind',
            'touch / mouse / stylus / invertedStylus / trackpad / unknown.',
            Color(0xFFFFD54F)),
        _glossaryRow('MultitouchDragStrategy',
            'latestPointer / averageBoundaryPointers / sumAllPointers.',
            Color(0xFFFFC107)),
      ],
    ),
  );
}

Widget _epilogue() {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 18.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1A237E), Color(0xFF311B92), Color(0xFF4A148C)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Epilogue',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFFFFF),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'Advanced gesture wiring is mostly about three things: choosing '
          'the right callback granularity (one-shot vs. continuous), '
          'understanding the details records that ride along with each '
          'callback, and tuning hit-test/device behavior so the right '
          'pointers reach the right widgets.',
          style: TextStyle(
              fontSize: 13.0, color: Color(0xFFEDE7F6), height: 1.6),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0x22FFFFFF),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF4CAF50),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text('PASS',
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(width: 8.0),
                  Text('All 12 sections rendered',
                      style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 12.0)),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF2196F3),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text('INERT',
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(width: 8.0),
                  Text('All callbacks are no-ops',
                      style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 12.0)),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFFF9800),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text('STATIC',
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(width: 8.0),
                  Text('AlwaysStoppedAnimation / Duration.zero',
                      style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 12.0)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        Center(
          child: Text(
            'Advanced Gesture Atlas • Pointer Choreography Gallery',
            style: TextStyle(
              color: Color(0xFFB39DDB),
              fontSize: 11.0,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// ENTRY POINT
// ============================================================================

dynamic build(BuildContext context) {
  // Static snapshots — used in some sub-widgets for animation-like reasoning.
  final tEnter = AlwaysStoppedAnimation<double>(0.25);
  final tPeak = AlwaysStoppedAnimation<double>(1.0);
  final tFade = AlwaysStoppedAnimation<double>(0.5);
  final zeroDuration = Duration.zero;

  // ScaleUpdateDetails synthesized "snapshot" via details object inspection
  // is omitted (D4rt doesn't allow constructing these freely); instead we
  // rely on bound callbacks above to demonstrate API surface.

  return MaterialApp(
    title: 'Advanced Gesture Atlas',
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF5F0FF),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _heroHeader(),
            _overviewPanel(),
            _sectionBanner(1, 'SCALE LIFECYCLE',
                'onScaleStart / onScaleUpdate / onScaleEnd',
                Color(0xFF1565C0), Color(0xFF42A5F5), '🔍'),
            _section1Scale(),
            _sectionBanner(2, 'LONG PRESS CONTINUUM',
                'onLongPressStart → MoveUpdate → End → Up',
                Color(0xFF6A1B9A), Color(0xFFBA68C8), '⏳'),
            _section2LongPressMove(),
            _sectionBanner(3, 'FORCE PRESS',
                'onForcePressStart / Peak / Update / End',
                Color(0xFFB71C1C), Color(0xFFEF5350), '🔥'),
            _section3ForcePress(),
            _sectionBanner(4, 'POINTER HOVER',
                'MouseRegion onEnter / onExit / onHover',
                Color(0xFF006064), Color(0xFF26C6DA), '🖱'),
            _section4Hover(),
            _sectionBanner(5, 'SECONDARY & TERTIARY',
                'onSecondaryTap*, onTertiaryTap*',
                Color(0xFFEF6C00), Color(0xFFFFA726), '⊕'),
            _section5SecondaryTaps(),
            _sectionBanner(6, 'TRACKPAD PAN-ZOOM',
                'supportedDevices + trackpadScrollCausesScale',
                Color(0xFF2E7D32), Color(0xFF66BB6A), '↔'),
            _section6PanZoom(),
            _sectionBanner(7, 'HIT-TEST BEHAVIOR',
                'opaque / translucent / deferToChild',
                Color(0xFFF57F17), Color(0xFFFFCA28), '⌘'),
            _section7HitTest(),
            _sectionBanner(8, 'MOUSE CURSOR GALLERY',
                'SystemMouseCursors catalogue',
                Color(0xFF1A237E), Color(0xFF5C6BC0), '✥'),
            _section8MouseCursor(),
            _sectionBanner(9, 'POINTER DETAIL RECORDS',
                'ScaleStart/Update/End, ForcePress, LongPress*, Tap*, Drag*',
                Color(0xFF880E4F), Color(0xFFEC407A), '✎'),
            _section9PointerDetails(),
            _sectionBanner(10, 'MULTI-FINGER GESTURES',
                'pointerCount branching, MultitouchDragStrategy',
                Color(0xFF3E2723), Color(0xFF8D6E63), '✋'),
            _section10MultiFinger(),
            _sectionBanner(11, 'RAW GESTURE DETECTOR',
                'GestureRecognizerFactory map',
                Color(0xFF004D40), Color(0xFF26A69A), '⚙'),
            _section11RawDetector(),
            _sectionBanner(12, 'GLOSSARY',
                'Definitions for the advanced gesture vocabulary',
                Color(0xFFF9A825), Color(0xFFFFD54F), '📖'),
            _section12Glossary(),
            _epilogue(),
            SizedBox(height: 24.0),
            Center(
              child: Text(
                'animation snapshot: ${tEnter.value} → ${tFade.value} → ${tPeak.value}'
                    '   |   duration: ${zeroDuration.inMicroseconds}µs',
                style: TextStyle(
                    fontSize: 10.0,
                    color: Color(0xFF9E9E9E),
                    fontFamily: 'monospace'),
              ),
            ),
            SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}




