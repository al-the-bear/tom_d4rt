// D4rt test script: Tests Dismissible, DismissDirection, DismissUpdateDetails,
// LongPressGestureRecognizer, GestureRecognizerFactory, RawGestureDetector,
// PointerEvent
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

dynamic build(BuildContext context) {
  print('GestureDetector advanced test executing');

  // ========== DismissDirection ==========
  print('--- DismissDirection Tests ---');
  for (final dir in DismissDirection.values) {
    print('  DismissDirection: $dir');
  }

  // ========== Dismissible ==========
  print('--- Dismissible Tests ---');
  final dismissible = Dismissible(
    key: ValueKey('dismiss-1'),
    direction: DismissDirection.horizontal,
    background: Container(color: Colors.red),
    secondaryBackground: Container(color: Colors.green),
    confirmDismiss: (direction) async => true,
    onDismissed: (direction) => print('  Dismissed: $direction'),
    dismissThresholds: {
      DismissDirection.startToEnd: 0.4,
      DismissDirection.endToStart: 0.6,
    },
    movementDuration: Duration(milliseconds: 200),
    resizeDuration: Duration(milliseconds: 300),
    child: ListTile(title: Text('Swipe me')),
  );
  print('Dismissible created');

  // ========== LongPressGestureRecognizer ==========
  print('--- LongPressGestureRecognizer Tests ---');
  final longPress = LongPressGestureRecognizer(
    duration: Duration(milliseconds: 500),
    postAcceptSlopTolerance: 18.0,
  );
  print('LongPressGestureRecognizer created');
  longPress.onLongPress = () => print('  long press triggered');
  longPress.onLongPressStart = (details) =>
      print('  start: ${details.globalPosition}');
  longPress.onLongPressMoveUpdate = (details) =>
      print('  move: ${details.globalPosition}');
  longPress.onLongPressEnd = (details) =>
      print('  end: ${details.globalPosition}');
  longPress.onLongPressUp = () => print('  long press up');
  longPress.dispose();
  print('LongPressGestureRecognizer disposed');

  // ========== ForcePressGestureRecognizer ==========
  print('--- ForcePressGestureRecognizer Tests ---');
  final forcePress = ForcePressGestureRecognizer(
    startPressure: 0.4,
    peakPressure: 0.85,
  );
  print('ForcePressGestureRecognizer created');
  print('  startPressure: ${forcePress.startPressure}');
  print('  peakPressure: ${forcePress.peakPressure}');
  forcePress.onStart = (details) => print('  force start');
  forcePress.onPeak = (details) => print('  force peak');
  forcePress.onUpdate = (details) => print('  force update');
  forcePress.onEnd = (details) => print('  force end');
  forcePress.dispose();
  print('ForcePressGestureRecognizer disposed');

  // ========== RawGestureDetector ==========
  print('--- RawGestureDetector Tests ---');
  final rawGestureDetector = RawGestureDetector(
    gestures: <Type, GestureRecognizerFactory>{
      TapGestureRecognizer:
          GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
            () => TapGestureRecognizer(),
            (TapGestureRecognizer instance) {
              instance.onTap = () => print('  raw tap');
            },
          ),
    },
    behavior: HitTestBehavior.translucent,
    child: Container(
      width: 100,
      height: 100,
      color: Colors.purple,
      child: Text('Raw Gesture'),
    ),
  );
  print('RawGestureDetector created');

  // ========== GestureRecognizerFactoryWithHandlers ==========
  print('--- GestureRecognizerFactoryWithHandlers Tests ---');
  final factory = GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
    () => TapGestureRecognizer(),
    (instance) {
      instance.onTap = () {};
    },
  );
  print('GestureRecognizerFactoryWithHandlers created');

  // ========== HitTestBehavior ==========
  print('--- HitTestBehavior Tests ---');
  for (final behavior in HitTestBehavior.values) {
    print('  HitTestBehavior: $behavior');
  }

  print('All gesture detector advanced tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: ListView(
        children: [
          dismissible,
          Dismissible(
            key: ValueKey('dismiss-2'),
            direction: DismissDirection.endToStart,
            background: Container(color: Colors.orange),
            child: ListTile(title: Text('Swipe end to start')),
          ),
          rawGestureDetector,
        ],
      ),
    ),
  );
}
