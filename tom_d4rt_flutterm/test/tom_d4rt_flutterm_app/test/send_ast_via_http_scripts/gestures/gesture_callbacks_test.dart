// D4rt test script: Tests GestureRecognizerCallback, RecognizerCallback, GestureDragStartCallback, GestureDragUpdateCallback, GestureDragEndCallback, GestureDragCancelCallback, GestureDragDownCallback, GestureScaleStartCallback, GestureScaleUpdateCallback
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Gesture callback typedef tests executing');

  // ========== GestureDragStartCallback ==========
  print('--- GestureDragStartCallback Tests ---');
  // GestureDragStartCallback = void Function(DragStartDetails)
  final GestureDragStartCallback dragStartCallback = (DragStartDetails details) {
    print('Drag started at: ${details.globalPosition}');
  };
  print('GestureDragStartCallback type: ${dragStartCallback.runtimeType}');

  // ========== GestureDragUpdateCallback ==========
  print('--- GestureDragUpdateCallback Tests ---');
  // GestureDragUpdateCallback = void Function(DragUpdateDetails)
  final GestureDragUpdateCallback dragUpdateCallback = (DragUpdateDetails details) {
    print('Drag update delta: ${details.delta}');
  };
  print('GestureDragUpdateCallback type: ${dragUpdateCallback.runtimeType}');

  // ========== GestureDragEndCallback ==========
  print('--- GestureDragEndCallback Tests ---');
  // GestureDragEndCallback = void Function(DragEndDetails)
  final GestureDragEndCallback dragEndCallback = (DragEndDetails details) {
    print('Drag ended with velocity: ${details.velocity}');
  };
  print('GestureDragEndCallback type: ${dragEndCallback.runtimeType}');

  // ========== GestureDragCancelCallback ==========
  print('--- GestureDragCancelCallback Tests ---');
  // GestureDragCancelCallback = void Function()
  final GestureDragCancelCallback dragCancelCallback = () {
    print('Drag cancelled');
  };
  print('GestureDragCancelCallback type: ${dragCancelCallback.runtimeType}');

  // ========== GestureDragDownCallback ==========
  print('--- GestureDragDownCallback Tests ---');
  // GestureDragDownCallback = void Function(DragDownDetails)
  final GestureDragDownCallback dragDownCallback = (DragDownDetails details) {
    print('Drag down at: ${details.globalPosition}');
  };
  print('GestureDragDownCallback type: ${dragDownCallback.runtimeType}');

  // ========== GestureScaleStartCallback ==========
  print('--- GestureScaleStartCallback Tests ---');
  // GestureScaleStartCallback = void Function(ScaleStartDetails)
  final GestureScaleStartCallback scaleStartCallback = (ScaleStartDetails details) {
    print('Scale started, pointers: ${details.pointerCount}');
  };
  print('GestureScaleStartCallback type: ${scaleStartCallback.runtimeType}');

  // ========== GestureScaleUpdateCallback ==========
  print('--- GestureScaleUpdateCallback Tests ---');
  // GestureScaleUpdateCallback = void Function(ScaleUpdateDetails)
  final GestureScaleUpdateCallback scaleUpdateCallback = (ScaleUpdateDetails details) {
    print('Scale update, scale: ${details.scale}');
  };
  print('GestureScaleUpdateCallback type: ${scaleUpdateCallback.runtimeType}');

  // ========== GestureRecognizerCallback ==========
  print('--- GestureRecognizerCallback Tests ---');
  // GestureRecognizerCallback is a generic typedef used in gesture recognizer factories
  // GestureRecognizerFactoryWithHandlers uses callbacks to initialize recognizers
  final tapRecognizer = TapGestureRecognizer();
  print('TapGestureRecognizer type: ${tapRecognizer.runtimeType}');
  print('GestureRecognizer base type: ${GestureRecognizer}');
  // Reference the factory pattern that uses recognizer callbacks
  final factory = GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
    () => TapGestureRecognizer(),
    (TapGestureRecognizer instance) {
      instance.onTap = () {};
    },
  );
  print('GestureRecognizerFactoryWithHandlers type: ${factory.runtimeType}');

  // ========== RecognizerCallback ==========
  print('--- RecognizerCallback Tests ---');
  // RecognizerCallback is similar to GestureRecognizerCallback
  // Referenced through the gesture recognition system
  final panRecognizer = PanGestureRecognizer();
  panRecognizer.onStart = dragStartCallback;
  panRecognizer.onUpdate = dragUpdateCallback;
  panRecognizer.onEnd = dragEndCallback;
  panRecognizer.onCancel = dragCancelCallback;
  print('PanGestureRecognizer configured with all drag callbacks');
  print('PanGestureRecognizer type: ${panRecognizer.runtimeType}');

  // Verify all callbacks with a GestureDetector
  final gestureDetector = GestureDetector(
    onPanStart: dragStartCallback,
    onPanUpdate: dragUpdateCallback,
    onPanEnd: dragEndCallback,
    onPanCancel: dragCancelCallback,
    onPanDown: dragDownCallback,
    onScaleStart: scaleStartCallback,
    onScaleUpdate: scaleUpdateCallback,
    child: Container(),
  );
  print('GestureDetector configured with all callbacks: ${gestureDetector.runtimeType}');

  print('All gesture callback tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Gesture Callbacks Test', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            SizedBox(height: 16.0),
            Text('GestureDragStartCallback: defined'),
            Text('GestureDragUpdateCallback: defined'),
            Text('GestureDragEndCallback: defined'),
            Text('GestureDragCancelCallback: defined'),
            Text('GestureDragDownCallback: defined'),
            Text('GestureScaleStartCallback: defined'),
            Text('GestureScaleUpdateCallback: defined'),
            Text('GestureRecognizerCallback: via factory'),
            Text('RecognizerCallback: via PanGestureRecognizer'),
          ],
        ),
      ),
    ),
  );
}
