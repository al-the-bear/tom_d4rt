// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PointerData from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerData test executing');

  // Default
  final pd1 = ui.PointerData();
  print('Default: change=${pd1.change}, kind=${pd1.kind}');
  print('physicalX=${pd1.physicalX}, physicalY=${pd1.physicalY}');
  print('buttons=${pd1.buttons}, pressure=${pd1.pressure}');
  print('device=${pd1.device}, pointerIdentifier=${pd1.pointerIdentifier}');

  // Touch down
  final pd2 = ui.PointerData(
    change: ui.PointerChange.down,
    kind: ui.PointerDeviceKind.touch,
    physicalX: 150.0,
    physicalY: 300.0,
    buttons: 1,
    pressure: 0.5,
    pressureMin: 0.0,
    pressureMax: 1.0,
    device: 1,
  );
  print('Touch: change=${pd2.change}, kind=${pd2.kind}, x=${pd2.physicalX}, y=${pd2.physicalY}');
  print('pressure=${pd2.pressure}, pressureMin=${pd2.pressureMin}, pressureMax=${pd2.pressureMax}');

  // Mouse hover
  final pd3 = ui.PointerData(
    change: ui.PointerChange.hover,
    kind: ui.PointerDeviceKind.mouse,
    physicalX: 200.0,
    physicalY: 100.0,
    scrollDeltaX: 0.0,
    scrollDeltaY: -10.0,
  );
  print('Mouse: change=${pd3.change}, scrollDeltaY=${pd3.scrollDeltaY}');

  // Stylus
  final pd4 = ui.PointerData(
    change: ui.PointerChange.move,
    kind: ui.PointerDeviceKind.stylus,
    physicalX: 50.0,
    physicalY: 50.0,
    tilt: 0.3,
  );
  print('Stylus: kind=${pd4.kind}, tilt=${pd4.tilt}');
  print('toString: ${pd1.toString()}');

  print('PointerData test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('PointerData Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Default: ${pd1.change}'),
    Text('Touch: x=${pd2.physicalX}, y=${pd2.physicalY}'),
    Text('Mouse: scroll=${pd3.scrollDeltaY}'),
    Text('Stylus: tilt=${pd4.tilt}'),
  ]);
}
