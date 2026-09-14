// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unnecessary_import

// =====================================================================
// PointerExitEvent — Deep Demo Script
// ---------------------------------------------------------------------
// PointerExitEvent is the gesture-system signal that fires when a
// hovering pointer leaves a tracked region. It is the "departure half"
// of the enter/exit pair and is most often consumed through MouseRegion
// or Listener. This script paints a full visual encyclopedia of the
// event: construction, getters, device-kind variations, comparison
// against PointerEnterEvent and PointerHoverEvent, lifecycle diagrams,
// synthesized vs real exit semantics, and a usage cheat-sheet.
//
// Theme: "departure / exit-sign" — runway-amber, exit-green, departure
//        black, signal red. The visuals evoke airport gate boards,
//        emergency exit placards, and runway taxi lights.
//
// This file is intentionally a static, single-build snapshot. There is
// no live mouse interaction, no animation controller, no Future or
// Timer. Every interactive moment is rendered as a still illustration.
// =====================================================================

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------
// Color palette — runway / exit-sign theme
// ---------------------------------------------------------------------
const Color kRunwayAmber = Color(0xFFFFB300);
const Color kExitGreen = Color(0xFF1B5E20);
const Color kExitGreenLight = Color(0xFF66BB6A);
const Color kDepartureBlack = Color(0xFF0D0D0D);
const Color kSignalRed = Color(0xFFD50000);
const Color kBoardYellow = Color(0xFFFFEE58);
const Color kTaxiBlue = Color(0xFF0277BD);
const Color kConcreteGray = Color(0xFF424242);
const Color kPlacardWhite = Color(0xFFFAFAFA);
const Color kBeaconOrange = Color(0xFFFF6F00);
const Color kNightSky = Color(0xFF1A237E);
const Color kSignalCyan = Color(0xFF00B8D4);
const Color kHighlightCream = Color(0xFFFFF8E1);
const Color kRunwayShadow = Color(0xFF3E2723);

// ---------------------------------------------------------------------
// Section 0 — Construct anchor PointerExitEvent and probe every getter
// ---------------------------------------------------------------------
Widget buildSection0Anchor() {
  print('--- Section 0: PointerExitEvent anchor instance ---');

  final PointerExitEvent anchor = PointerExitEvent(
    timeStamp: Duration(milliseconds: 4242),
    pointer: 7,
    kind: PointerDeviceKind.mouse,
    device: 1,
    position: Offset(120, 80),
    delta: Offset(-3, 2),
    buttons: 0,
    obscured: false,
    pressureMin: 1.0,
    pressureMax: 1.0,
    distance: 0,
    distanceMax: 0,
    size: 0,
    radiusMajor: 0,
    radiusMinor: 0,
    radiusMin: 0,
    radiusMax: 0,
    orientation: 0.0,
    tilt: 0.0,
    synthesized: false,
    embedderId: 0,
  );

  print('runtimeType .................. ${anchor.runtimeType}');
  print('timeStamp .................... ${anchor.timeStamp}');
  print('pointer ...................... ${anchor.pointer}');
  print('kind ......................... ${anchor.kind}');
  print('device ....................... ${anchor.device}');
  print('position ..................... ${anchor.position}');
  print('localPosition ................ ${anchor.localPosition}');
  print('delta ........................ ${anchor.delta}');
  print('localDelta ................... ${anchor.localDelta}');
  print('buttons ...................... ${anchor.buttons}');
  print('down ......................... ${anchor.down}');
  print('obscured ..................... ${anchor.obscured}');
  print('pressure ..................... ${anchor.pressure}');
  print('pressureMin .................. ${anchor.pressureMin}');
  print('pressureMax .................. ${anchor.pressureMax}');
  print('distance ..................... ${anchor.distance}');
  print('distanceMax .................. ${anchor.distanceMax}');
  print('size ......................... ${anchor.size}');
  print('radiusMajor .................. ${anchor.radiusMajor}');
  print('radiusMinor .................. ${anchor.radiusMinor}');
  print('radiusMin .................... ${anchor.radiusMin}');
  print('radiusMax .................... ${anchor.radiusMax}');
  print('orientation .................. ${anchor.orientation}');
  print('tilt ......................... ${anchor.tilt}');
  print('synthesized .................. ${anchor.synthesized}');
  print('embedderId ................... ${anchor.embedderId}');
  print('transform .................... ${anchor.transform}');

  final List<List<String>> rows = <List<String>>[
    <String>['runtimeType', '${anchor.runtimeType}'],
    <String>['timeStamp', '${anchor.timeStamp}'],
    <String>['pointer', '${anchor.pointer}'],
    <String>['kind', '${anchor.kind}'],
    <String>['device', '${anchor.device}'],
    <String>['position', '${anchor.position}'],
    <String>['localPosition', '${anchor.localPosition}'],
    <String>['delta', '${anchor.delta}'],
    <String>['localDelta', '${anchor.localDelta}'],
    <String>['buttons', '${anchor.buttons}'],
    <String>['down', '${anchor.down}'],
    <String>['obscured', '${anchor.obscured}'],
    <String>['pressure', '${anchor.pressure}'],
    <String>['pressureMin', '${anchor.pressureMin}'],
    <String>['pressureMax', '${anchor.pressureMax}'],
    <String>['distance', '${anchor.distance}'],
    <String>['distanceMax', '${anchor.distanceMax}'],
    <String>['size', '${anchor.size}'],
    <String>['radiusMajor', '${anchor.radiusMajor}'],
    <String>['radiusMinor', '${anchor.radiusMinor}'],
    <String>['radiusMin', '${anchor.radiusMin}'],
    <String>['radiusMax', '${anchor.radiusMax}'],
    <String>['orientation', '${anchor.orientation}'],
    <String>['tilt', '${anchor.tilt}'],
    <String>['synthesized', '${anchor.synthesized}'],
    <String>['embedderId', '${anchor.embedderId}'],
    <String>['transform', '${anchor.transform}'],
  ];

  final List<Widget> rowWidgets = <Widget>[];
  for (int i = 0; i < rows.length; i = i + 1) {
    final List<String> r = rows[i];
    final bool stripe = (i % 2) == 0;
    rowWidgets.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: stripe ? kHighlightCream : kPlacardWhite,
          border: Border(
            bottom: BorderSide(color: kConcreteGray.withOpacity(0.18)),
          ),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 160,
              child: Text(
                r[0],
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: kExitGreen,
                ),
              ),
            ),
            Expanded(
              child: Text(
                r[1],
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: kDepartureBlack,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.only(bottom: 24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[kPlacardWhite, kHighlightCream, kBoardYellow],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: kRunwayAmber, width: 2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kRunwayAmber.withOpacity(0.30),
          blurRadius: 18,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[kExitGreen, kExitGreenLight],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.exit_to_app, color: kPlacardWhite, size: 22),
              SizedBox(width: 8),
              Text(
                'Section 0  ::  PointerExitEvent — anchor instance',
                style: TextStyle(
                  color: kPlacardWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Column(children: rowWidgets),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Section 1 — Title banner (departure-board style)
// ---------------------------------------------------------------------
Widget buildSection1Title() {
  print('--- Section 1: Title banner ---');
  print('Painting departure-board-style title');
  print('Theme: runway amber + exit green');
  print('Subject: PointerExitEvent');

  return Container(
    margin: EdgeInsets.only(bottom: 24),
    padding: EdgeInsets.all(28),
    decoration: BoxDecoration(
      gradient: RadialGradient(
        center: Alignment.topLeft,
        radius: 1.4,
        colors: <Color>[kDepartureBlack, kRunwayShadow, kNightSky],
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kDepartureBlack.withOpacity(0.45),
          blurRadius: 22,
          offset: Offset(0, 10),
        ),
        BoxShadow(
          color: kBeaconOrange.withOpacity(0.20),
          blurRadius: 32,
          spreadRadius: 2,
          offset: Offset(0, 0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: kSignalRed,
                borderRadius: BorderRadius.circular(4),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: kSignalRed.withOpacity(0.6),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Text(
                'DEPARTING',
                style: TextStyle(
                  color: kPlacardWhite,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                  letterSpacing: 2,
                ),
              ),
            ),
            SizedBox(width: 12),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: kRunwayAmber,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'GATE B-7',
                style: TextStyle(
                  color: kDepartureBlack,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                  letterSpacing: 2,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 18),
        Text(
          'PointerExitEvent',
          style: TextStyle(
            color: kBoardYellow,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w900,
            fontSize: 36,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'the hover-departure signal',
          style: TextStyle(
            color: kRunwayAmber,
            fontStyle: FontStyle.italic,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 16),
        Container(height: 2, color: kRunwayAmber.withOpacity(0.6)),
        SizedBox(height: 12),
        Text(
          'Fired when a hovering pointer leaves the bounds of a region.\n'
          'Most often consumed through MouseRegion.onExit, but available\n'
          'through Listener and the lower gesture-arena APIs as well.\n'
          'Carries no button information beyond the moment of exit.',
          style: TextStyle(
            color: kPlacardWhite,
            fontSize: 13,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Section 2 — Anatomy diagram of a PointerExitEvent
// ---------------------------------------------------------------------
Widget _anatomyRow(String label, String description, Color accent) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: kPlacardWhite,
      borderRadius: BorderRadius.circular(6),
      border: Border(left: BorderSide(color: accent, width: 5)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withOpacity(0.18),
          blurRadius: 6,
          offset: Offset(2, 2),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 130,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
              color: accent,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 12, color: kDepartureBlack),
          ),
        ),
      ],
    ),
  );
}

Widget buildSection2Anatomy() {
  print('--- Section 2: Anatomy diagram ---');
  print('Mapping each PointerExitEvent field to its meaning');
  print('Highlighting position, delta, synthesized, transform');
  print('Static diagram — no animation');

  return Container(
    margin: EdgeInsets.only(bottom: 24),
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[kHighlightCream, kPlacardWhite],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kExitGreen, width: 2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kExitGreen.withOpacity(0.18),
          blurRadius: 14,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Section 2 :: Anatomy of a PointerExitEvent',
          style: TextStyle(
            color: kExitGreen,
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 10),
        _anatomyRow(
          'timeStamp',
          'Engine-monotonic clock at the moment the exit was reported. '
              'Used for ordering against enter/hover events.',
          kRunwayAmber,
        ),
        _anatomyRow(
          'pointer',
          'Stable identifier for the logical pointer stream. Same as the '
              'matching enter/hover events for this hover session.',
          kTaxiBlue,
        ),
        _anatomyRow(
          'kind',
          'PointerDeviceKind enum — mouse, stylus, invertedStylus, '
              'touch, trackpad, or unknown.',
          kSignalCyan,
        ),
        _anatomyRow(
          'position',
          'Global position (logical pixels) where the pointer was when it '
              'crossed the region boundary.',
          kBeaconOrange,
        ),
        _anatomyRow(
          'localPosition',
          'Position transformed into the receiver widget\'s coordinate '
              'space; falls back to position when no transform is set.',
          kExitGreenLight,
        ),
        _anatomyRow(
          'delta',
          'Movement vector from the previous hover event. May be zero on '
              'synthesized exits.',
          kSignalRed,
        ),
        _anatomyRow(
          'synthesized',
          'true if the engine generated this event to balance state '
              '(e.g. layout change moved a region away from the pointer).',
          kNightSky,
        ),
        _anatomyRow(
          'transform',
          'Optional Matrix4 mapping global -> local coordinates. Set by '
              'the framework when dispatching through transformed widgets.',
          kConcreteGray,
        ),
        _anatomyRow(
          'down / buttons',
          'Always false / 0 on a hover-style exit. The pointer is not '
              'pressed during enter/exit by definition.',
          kExitGreen,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Section 3 — Gallery of six PointerExitEvent variants by device kind
// ---------------------------------------------------------------------
Widget _kindCard({
  required PointerExitEvent event,
  required String label,
  required IconData icon,
  required Color accent,
  required Color shadowAccent,
  required String narrative,
}) {
  return Container(
    margin: EdgeInsets.all(6),
    padding: EdgeInsets.all(14),
    width: 280,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[kPlacardWhite, accent.withOpacity(0.18)],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accent, width: 2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: shadowAccent.withOpacity(0.30),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: kPlacardWhite, size: 20),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          'kind:    ${event.kind}',
          style: TextStyle(fontFamily: 'monospace', fontSize: 11),
        ),
        Text(
          'pointer: ${event.pointer}',
          style: TextStyle(fontFamily: 'monospace', fontSize: 11),
        ),
        Text(
          'device:  ${event.device}',
          style: TextStyle(fontFamily: 'monospace', fontSize: 11),
        ),
        Text(
          'pos:     ${event.position}',
          style: TextStyle(fontFamily: 'monospace', fontSize: 11),
        ),
        Text(
          'delta:   ${event.delta}',
          style: TextStyle(fontFamily: 'monospace', fontSize: 11),
        ),
        Text(
          'time:    ${event.timeStamp}',
          style: TextStyle(fontFamily: 'monospace', fontSize: 11),
        ),
        SizedBox(height: 8),
        Container(height: 1, color: accent.withOpacity(0.4)),
        SizedBox(height: 8),
        Text(
          narrative,
          style: TextStyle(
            fontSize: 11,
            color: kDepartureBlack,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

Widget buildSection3Gallery() {
  print('--- Section 3: Gallery of device kinds ---');
  print('Building 6 PointerExitEvent instances');
  print('Kinds: mouse, touch, stylus, invertedStylus, trackpad, unknown');
  print('Each card shows construction details and narrative');

  final PointerExitEvent eMouse = PointerExitEvent(
    timeStamp: Duration(milliseconds: 1000),
    pointer: 11,
    kind: PointerDeviceKind.mouse,
    device: 1,
    position: Offset(40, 40),
    delta: Offset(-1, 0),
  );
  final PointerExitEvent eTouch = PointerExitEvent(
    timeStamp: Duration(milliseconds: 2000),
    pointer: 12,
    kind: PointerDeviceKind.touch,
    device: 2,
    position: Offset(80, 90),
    delta: Offset(0, -2),
  );
  final PointerExitEvent eStylus = PointerExitEvent(
    timeStamp: Duration(milliseconds: 3000),
    pointer: 13,
    kind: PointerDeviceKind.stylus,
    device: 3,
    position: Offset(120, 60),
    delta: Offset(2, 1),
  );
  final PointerExitEvent eInverted = PointerExitEvent(
    timeStamp: Duration(milliseconds: 4000),
    pointer: 14,
    kind: PointerDeviceKind.invertedStylus,
    device: 4,
    position: Offset(160, 30),
    delta: Offset(-2, 2),
  );
  // Framework constraint: `PointerExitEvent` asserts
  // `!identical(kind, PointerDeviceKind.trackpad)` at
  // events.dart:1387 — trackpad-pan gestures route through the
  // `PointerPanZoom*` event family instead. Single-finger trackpad
  // *hover* exits do reach `MouseRegion.onExit`, but they arrive
  // as `kind: PointerDeviceKind.mouse` (the trackpad emulates a
  // mouse for hover purposes). The card label is kept as
  // "trackpad" so the gallery still illustrates the six device
  // categories Flutter cares about, but the constructed event
  // honours the framework assert by using `kind: mouse`.
  final PointerExitEvent eTrackpad = PointerExitEvent(
    timeStamp: Duration(milliseconds: 5000),
    pointer: 15,
    kind: PointerDeviceKind.mouse,
    device: 5,
    position: Offset(200, 110),
    delta: Offset(1, -1),
  );
  final PointerExitEvent eUnknown = PointerExitEvent(
    timeStamp: Duration(milliseconds: 6000),
    pointer: 16,
    kind: PointerDeviceKind.unknown,
    device: 6,
    position: Offset(240, 70),
    delta: Offset(0, 0),
  );

  print('Mouse exit at ${eMouse.position}');
  print('Touch exit at ${eTouch.position}');
  print('Stylus exit at ${eStylus.position}');
  print('Inverted stylus exit at ${eInverted.position}');
  print('Trackpad exit at ${eTrackpad.position}');
  print('Unknown device exit at ${eUnknown.position}');

  return Container(
    margin: EdgeInsets.only(bottom: 24),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: <Color>[kHighlightCream, kPlacardWhite, kBoardYellow],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kRunwayAmber, width: 2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kRunwayAmber.withOpacity(0.22),
          blurRadius: 14,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Section 3 :: Gallery — six device kinds',
          style: TextStyle(
            color: kRunwayShadow,
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Note: hover-style exits are realistic for mouse / stylus / '
          'trackpad. Touch exits also occur but always come paired with '
          'a pointer-up event.',
          style: TextStyle(
            color: kConcreteGray,
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12),
        Wrap(
          children: <Widget>[
            _kindCard(
              event: eMouse,
              label: 'mouse',
              icon: Icons.mouse,
              accent: kTaxiBlue,
              shadowAccent: kTaxiBlue,
              narrative:
                  'Cursor leaves the tracked rect on a desktop session. '
                  'Most common kind for MouseRegion.onExit.',
            ),
            _kindCard(
              event: eTouch,
              label: 'touch',
              icon: Icons.touch_app,
              accent: kBeaconOrange,
              shadowAccent: kBeaconOrange,
              narrative:
                  'A finger lifts and the engine sends a paired exit. '
                  'Less common, since touch rarely "hovers".',
            ),
            _kindCard(
              event: eStylus,
              label: 'stylus',
              icon: Icons.edit,
              accent: kExitGreen,
              shadowAccent: kExitGreen,
              narrative:
                  'A pen tip leaves the active region while still hovering. '
                  'Useful for inking palettes.',
            ),
            _kindCard(
              event: eInverted,
              label: 'invertedStylus',
              icon: Icons.south,
              accent: kSignalRed,
              shadowAccent: kSignalRed,
              narrative:
                  'Stylus eraser end exits a tracked region. Same hover '
                  'mechanics, different ink behaviour.',
            ),
            _kindCard(
              event: eTrackpad,
              label: 'trackpad (mouse-routed)',
              icon: Icons.swipe,
              accent: kSignalCyan,
              shadowAccent: kSignalCyan,
              narrative:
                  'A trackpad hover-exit routes through the mouse '
                  'pathway and arrives with kind=mouse — Flutter '
                  'asserts !identical(kind, trackpad) on '
                  'PointerExitEvent (events.dart:1387). Trackpad '
                  'pan/zoom gestures use PointerPanZoom* events '
                  'instead, not the exit family.',
            ),
            _kindCard(
              event: eUnknown,
              label: 'unknown',
              icon: Icons.help_outline,
              accent: kConcreteGray,
              shadowAccent: kConcreteGray,
              narrative:
                  'Engine could not classify the device. Treat conservatively '
                  'and fall back to position-only logic.',
            ),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Section 4 — MouseRegion integration (static visual representation)
// ---------------------------------------------------------------------
Widget _mouseRegionVisualPanel() {
  return Container(
    width: 280,
    height: 180,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[kExitGreenLight, kExitGreen],
      ),
      borderRadius: BorderRadius.circular(10),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kExitGreen.withOpacity(0.4),
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Stack(
      children: <Widget>[
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.exit_to_app, size: 48, color: kPlacardWhite),
              SizedBox(height: 8),
              Text(
                'MouseRegion target',
                style: TextStyle(
                  color: kPlacardWhite,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'onExit fires here',
                style: TextStyle(
                  color: kPlacardWhite.withOpacity(0.85),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        // Pointer trail leaving region
        Positioned(
          right: 4,
          top: 4,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: kSignalRed,
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: kSignalRed.withOpacity(0.6),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: -12,
          top: -12,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              border: Border.all(color: kSignalRed, width: 2),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: kDepartureBlack,
      borderRadius: BorderRadius.circular(8),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kDepartureBlack.withOpacity(0.5),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        color: kBoardYellow,
        fontSize: 11,
        height: 1.5,
      ),
    ),
  );
}

Widget buildSection4MouseRegion() {
  print('--- Section 4: MouseRegion integration ---');
  print('Static panel: pointer trail leaving a target region');
  print('Code sample: how MouseRegion.onExit consumes the event');
  print('No live mouse interaction — snapshot only');

  const String sample =
      'MouseRegion(\n'
      '  onEnter: (PointerEnterEvent e) {\n'
      '    setHover(true);\n'
      '  },\n'
      '  onExit:  (PointerExitEvent e) {\n'
      '    // e.position    -> global coords at exit\n'
      '    // e.kind        -> device classification\n'
      '    // e.synthesized -> true if engine-balanced\n'
      '    setHover(false);\n'
      '  },\n'
      '  child: SomeWidget(),\n'
      ')';

  return Container(
    margin: EdgeInsets.only(bottom: 24),
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[kPlacardWhite, kHighlightCream],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kExitGreen, width: 2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kExitGreen.withOpacity(0.16),
          blurRadius: 14,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Section 4 :: MouseRegion integration',
          style: TextStyle(
            color: kExitGreen,
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'A pointer trail leaves the green panel; MouseRegion.onExit '
          'receives the PointerExitEvent. The diagram is static — see the '
          'code block for the consumer signature.',
          style: TextStyle(fontSize: 12, color: kConcreteGray),
        ),
        SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _mouseRegionVisualPanel(),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Consumer pattern',
                    style: TextStyle(
                      color: kRunwayShadow,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 6),
                  _codeBlock(sample),
                  SizedBox(height: 10),
                  Text(
                    'Listener.onPointerSignal does NOT receive enter/exit '
                    'events. They flow only through MouseTracker via '
                    'MouseRegion. Deeper hooks live in RendererBinding.',
                    style: TextStyle(
                      fontSize: 11,
                      color: kSignalRed,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Section 5 — Lifecycle diagram: enter → hover → exit, with timestamps
// ---------------------------------------------------------------------
Widget _lifecycleStep({
  required String stepLabel,
  required String eventType,
  required String timeStamp,
  required String position,
  required Color accent,
  required IconData icon,
  required bool isLast,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Column(
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: <Color>[accent, accent.withOpacity(0.5)],
              ),
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: accent.withOpacity(0.5),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Icon(icon, color: kPlacardWhite, size: 22),
          ),
          if (!isLast)
            Container(
              width: 3,
              height: 50,
              color: accent.withOpacity(0.5),
            ),
        ],
      ),
      SizedBox(width: 12),
      Expanded(
        child: Container(
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: kPlacardWhite,
            border: Border.all(color: accent, width: 1.5),
            borderRadius: BorderRadius.circular(8),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: accent.withOpacity(0.18),
                blurRadius: 6,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      stepLabel,
                      style: TextStyle(
                        color: kPlacardWhite,
                        fontFamily: 'monospace',
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    eventType,
                    style: TextStyle(
                      color: accent,
                      fontFamily: 'monospace',
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                'time:     $timeStamp',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: kDepartureBlack,
                ),
              ),
              Text(
                'position: $position',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: kDepartureBlack,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget buildSection5Lifecycle() {
  print('--- Section 5: Lifecycle diagram ---');
  print('Phases: enter -> hover -> hover -> exit');
  print('Each phase carries a distinct timestamp');
  print('PointerExitEvent always closes the hover session');

  return Container(
    margin: EdgeInsets.only(bottom: 24),
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[kNightSky, kDepartureBlack],
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kNightSky.withOpacity(0.45),
          blurRadius: 16,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Section 5 :: Lifecycle — enter, hover, exit',
          style: TextStyle(
            color: kBoardYellow,
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'A typical hover session starts with PointerEnterEvent, runs '
          'through zero or more PointerHoverEvent updates, and finishes '
          'with exactly one PointerExitEvent.',
          style: TextStyle(color: kPlacardWhite, fontSize: 12),
        ),
        SizedBox(height: 18),
        _lifecycleStep(
          stepLabel: 'STEP 1',
          eventType: 'PointerEnterEvent',
          timeStamp: '0 ms',
          position: 'Offset(50, 50)',
          accent: kExitGreen,
          icon: Icons.login,
          isLast: false,
        ),
        _lifecycleStep(
          stepLabel: 'STEP 2',
          eventType: 'PointerHoverEvent',
          timeStamp: '120 ms',
          position: 'Offset(80, 70)',
          accent: kRunwayAmber,
          icon: Icons.swap_horiz,
          isLast: false,
        ),
        _lifecycleStep(
          stepLabel: 'STEP 3',
          eventType: 'PointerHoverEvent',
          timeStamp: '240 ms',
          position: 'Offset(110, 95)',
          accent: kBeaconOrange,
          icon: Icons.swap_horiz,
          isLast: false,
        ),
        _lifecycleStep(
          stepLabel: 'STEP 4',
          eventType: 'PointerExitEvent',
          timeStamp: '360 ms',
          position: 'Offset(140, 120)',
          accent: kSignalRed,
          icon: Icons.logout,
          isLast: true,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Section 6 — Comparison table: Enter / Hover / Exit
// ---------------------------------------------------------------------
Widget _compareHeaderCell(String text, Color accent) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: accent,
        border: Border(right: BorderSide(color: kPlacardWhite, width: 1)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: kPlacardWhite,
          fontFamily: 'monospace',
          fontSize: 12,
          fontWeight: FontWeight.w900,
        ),
      ),
    ),
  );
}

Widget _compareDataCell(String text, {bool stripe = false}) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: stripe ? kHighlightCream : kPlacardWhite,
        border: Border(
          right: BorderSide(color: kConcreteGray.withOpacity(0.2)),
          bottom: BorderSide(color: kConcreteGray.withOpacity(0.2)),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11,
          color: kDepartureBlack,
        ),
      ),
    ),
  );
}

Widget buildSection6Comparison() {
  print('--- Section 6: Comparison table ---');
  print('Comparing PointerEnterEvent / PointerHoverEvent / PointerExitEvent');
  print('Axes: trigger, frequency, callback, position semantics');
  print('Highlights what makes Exit distinct');

  final List<List<String>> rows = <List<String>>[
    <String>[
      'trigger',
      'pointer crosses INTO region',
      'pointer moves WITHIN region',
      'pointer crosses OUT of region',
    ],
    <String>[
      'frequency',
      'exactly once per hover session',
      'zero or more per session',
      'exactly once per hover session',
    ],
    <String>[
      'MouseRegion',
      'onEnter',
      'onHover',
      'onExit',
    ],
    <String>[
      'down',
      'false',
      'false',
      'false',
    ],
    <String>[
      'buttons',
      '0',
      '0',
      '0',
    ],
    <String>[
      'delta',
      'usually zero',
      'movement vector',
      'last movement vector',
    ],
    <String>[
      'synthesized',
      'true on layout-induced enter',
      'rarely synthesized',
      'true on layout-induced exit',
    ],
    <String>[
      'common use',
      'start hover state',
      'tooltip / cursor visuals',
      'end hover state',
    ],
  ];

  final List<Widget> dataRows = <Widget>[];
  for (int i = 0; i < rows.length; i = i + 1) {
    final List<String> r = rows[i];
    final bool stripe = (i % 2) == 0;
    dataRows.add(
      Row(
        children: <Widget>[
          _compareDataCell(r[0], stripe: stripe),
          _compareDataCell(r[1], stripe: stripe),
          _compareDataCell(r[2], stripe: stripe),
          _compareDataCell(r[3], stripe: stripe),
        ],
      ),
    );
  }

  return Container(
    margin: EdgeInsets.only(bottom: 24),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kPlacardWhite,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kRunwayAmber, width: 2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kRunwayAmber.withOpacity(0.22),
          blurRadius: 14,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Section 6 :: Comparison — Enter / Hover / Exit',
          style: TextStyle(
            color: kRunwayShadow,
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _compareHeaderCell('aspect', kDepartureBlack),
                  _compareHeaderCell('PointerEnterEvent', kExitGreen),
                  _compareHeaderCell('PointerHoverEvent', kRunwayAmber),
                  _compareHeaderCell('PointerExitEvent', kSignalRed),
                ],
              ),
              Column(children: dataRows),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Section 7 — Synthesized vs real exit events
// ---------------------------------------------------------------------
Widget _scenarioCard({
  required String title,
  required String narrative,
  required bool synthesized,
  required Color accent,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[kPlacardWhite, accent.withOpacity(0.10)],
      ),
      border: Border(left: BorderSide(color: accent, width: 6)),
      borderRadius: BorderRadius.circular(8),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withOpacity(0.18),
          blurRadius: 8,
          offset: Offset(2, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                synthesized ? 'synthesized: true' : 'synthesized: false',
                style: TextStyle(
                  color: kPlacardWhite,
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          narrative,
          style: TextStyle(
            fontSize: 12,
            color: kDepartureBlack,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget buildSection7Synthesized() {
  print('--- Section 7: Synthesized vs real exits ---');
  print('Real: physical pointer leaves the rect');
  print('Synthesized: layout/route change moves the rect from under it');
  print('Both are valid exits — handlers must accept either');
  print('Engine guarantees pairing: every enter has a matching exit');

  return Container(
    margin: EdgeInsets.only(bottom: 24),
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: <Color>[kHighlightCream, kBoardYellow],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kBeaconOrange, width: 2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kBeaconOrange.withOpacity(0.25),
          blurRadius: 14,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Section 7 :: Synthesized vs real exits',
          style: TextStyle(
            color: kRunwayShadow,
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'The engine guarantees that every PointerEnterEvent is balanced '
          'by a PointerExitEvent. When layout, scrolling, navigation, or '
          'a render-tree edit moves the region out from under the cursor, '
          'a synthesized exit is dispatched even though the physical '
          'pointer never moved. Handlers should not distinguish the two '
          'unless they need diagnostics.',
          style: TextStyle(fontSize: 12, color: kConcreteGray),
        ),
        SizedBox(height: 12),
        _scenarioCard(
          title: 'Cursor moves off the widget',
          narrative:
              'Classic case. The user nudges the mouse. The engine reports '
              'a PointerExitEvent with realistic delta and synthesized=false.',
          synthesized: false,
          accent: kExitGreen,
        ),
        _scenarioCard(
          title: 'Pointer-up after a touch hover',
          narrative:
              'Touch input does not really hover, so a press-up generates '
              'an exit alongside the up event. Still synthesized=false in '
              'most embedders.',
          synthesized: false,
          accent: kTaxiBlue,
        ),
        _scenarioCard(
          title: 'Layout collapse moves the region',
          narrative:
              'A panel animation completes and the tracked widget no longer '
              'covers the cursor. The engine generates a synthesized exit '
              'so onExit can run cleanup logic.',
          synthesized: true,
          accent: kSignalRed,
        ),
        _scenarioCard(
          title: 'Route push/pop',
          narrative:
              'A modal route covers the page; widgets underneath receive '
              'synthesized exits because they are no longer reachable from '
              'the cursor.',
          synthesized: true,
          accent: kBeaconOrange,
        ),
        _scenarioCard(
          title: 'Widget removal from tree',
          narrative:
              'If the MouseRegion itself is unmounted while hovered, '
              'the framework dispatches a synthesized exit before disposal.',
          synthesized: true,
          accent: kNightSky,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Section 8 — Cheat-sheet of common usage patterns
// ---------------------------------------------------------------------
Widget _cheatRow(String title, String snippet, Color accent) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      color: kPlacardWhite,
      border: Border.all(color: accent.withOpacity(0.4)),
      borderRadius: BorderRadius.circular(8),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withOpacity(0.15),
          blurRadius: 6,
          offset: Offset(2, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7),
              topRight: Radius.circular(7),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: kPlacardWhite,
              fontWeight: FontWeight.w900,
              fontSize: 12,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            snippet,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: kDepartureBlack,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildSection8CheatSheet() {
  print('--- Section 8: Cheat-sheet ---');
  print('Common patterns: hover state, tooltip, button highlight');
  print('Always reset state in onExit, including synthesized cases');
  print('Pair onExit with onEnter; never assume one without the other');
  print('Avoid heavy work in the handler — schedule it');

  return Container(
    margin: EdgeInsets.only(bottom: 24),
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[kPlacardWhite, kHighlightCream, kBoardYellow],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: kRunwayAmber, width: 2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kRunwayAmber.withOpacity(0.22),
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Section 8 :: Cheat-sheet',
          style: TextStyle(
            color: kRunwayShadow,
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 10),
        _cheatRow(
          'Hover toggle',
          'MouseRegion(\n'
              '  onEnter: (_) => hover.value = true,\n'
              '  onExit:  (_) => hover.value = false,\n'
              '  child: ...,\n'
              ')',
          kExitGreen,
        ),
        _cheatRow(
          'Tooltip dismissal',
          'onExit: (PointerExitEvent e) {\n'
              '  tooltipController.dismiss();\n'
              '}',
          kTaxiBlue,
        ),
        _cheatRow(
          'Cursor restoration',
          'MouseRegion(\n'
              '  cursor: SystemMouseCursors.click,\n'
              '  onExit: (_) {\n'
              '    // framework auto-resets; nothing to do.\n'
              '  },\n'
              '  child: ...,\n'
              ')',
          kBeaconOrange,
        ),
        _cheatRow(
          'Button highlight reset',
          'onExit: (PointerExitEvent e) {\n'
              '  highlight.value = HighlightState.idle;\n'
              '}',
          kSignalRed,
        ),
        _cheatRow(
          'Diagnostic logging',
          'onExit: (PointerExitEvent e) {\n'
              '  log("exit pos=\${e.position} '
              'kind=\${e.kind} synth=\${e.synthesized}");\n'
              '}',
          kSignalCyan,
        ),
        _cheatRow(
          'Synthesized-aware cleanup',
          'onExit: (PointerExitEvent e) {\n'
              '  if (e.synthesized) {\n'
              '    // skip animations, run instant cleanup\n'
              '  } else {\n'
              '    fadeOut.start();\n'
              '  }\n'
              '}',
          kNightSky,
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: kDepartureBlack,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Rule of thumb: treat onExit as the deterministic teardown of '
            'whatever onEnter set up. The engine guarantees pairing — '
            'use that guarantee.',
            style: TextStyle(
              color: kBoardYellow,
              fontStyle: FontStyle.italic,
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Footer summary
// ---------------------------------------------------------------------
Widget buildFooter() {
  print('--- Footer summary ---');
  print('All sections rendered');
  print('PointerExitEvent demo complete');
  print('Returning composed root widget');

  return Container(
    margin: EdgeInsets.only(top: 12),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[kDepartureBlack, kRunwayShadow],
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kDepartureBlack.withOpacity(0.4),
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.flight_takeoff, color: kRunwayAmber, size: 22),
            SizedBox(width: 8),
            Text(
              'PointerExitEvent — departure complete',
              style: TextStyle(
                color: kBoardYellow,
                fontWeight: FontWeight.w900,
                fontSize: 14,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Eight sections covered: anchor instance, title banner, anatomy, '
          'device-kind gallery, MouseRegion integration, lifecycle diagram, '
          'comparison vs Enter/Hover, synthesized cases, and a usage '
          'cheat-sheet.',
          style: TextStyle(
            color: kPlacardWhite,
            fontSize: 12,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------
// Single build entry — composes all sections
// ---------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('=====================================================');
  print('PointerExitEvent deep-demo build() executing');
  print('Theme: departure / exit-sign');
  print('Sections: 0..8 + footer');
  print('=====================================================');

  final List<Widget> sections = <Widget>[
    buildSection0Anchor(),
    buildSection1Title(),
    buildSection2Anatomy(),
    buildSection3Gallery(),
    buildSection4MouseRegion(),
    buildSection5Lifecycle(),
    buildSection6Comparison(),
    buildSection7Synthesized(),
    buildSection8CheatSheet(),
    buildFooter(),
  ];

  print('Composed ${sections.length} section widgets');
  print('Returning Container root with exit-theme background');

  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #24, P1+P2):
  // Root was a bare Container > Column with 10 sections — vertical
  // overflow by 4707 px on the bottom. Wrap in Scaffold + SafeArea +
  // SingleChildScrollView so the column scrolls in an unbounded
  // viewport.
  return Scaffold(
    body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                kHighlightCream,
                kPlacardWhite,
                kBoardYellow,
                kHighlightCream,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: sections,
          ),
        ),
      ),
    ),
  );
}
