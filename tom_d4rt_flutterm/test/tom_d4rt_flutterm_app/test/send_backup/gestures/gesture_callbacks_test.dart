import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for GestureRecognizerCallback.
/// Shows common gesture callback type definitions.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Gesture Callbacks')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Gesture Callback Types',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _CallbackType(name: 'GestureTapCallback', signature: 'void Function()'),
          _CallbackType(name: 'GestureTapDownCallback', signature: 'void Function(TapDownDetails)'),
          _CallbackType(name: 'GestureTapUpCallback', signature: 'void Function(TapUpDetails)'),
          _CallbackType(name: 'GestureTapCancelCallback', signature: 'void Function()'),
          _CallbackType(name: 'GestureLongPressCallback', signature: 'void Function()'),
          _CallbackType(name: 'GestureDragDownCallback', signature: 'void Function(DragDownDetails)'),
          _CallbackType(name: 'GestureDragStartCallback', signature: 'void Function(DragStartDetails)'),
          _CallbackType(name: 'GestureDragUpdateCallback', signature: 'void Function(DragUpdateDetails)'),
          _CallbackType(name: 'GestureDragEndCallback', signature: 'void Function(DragEndDetails)'),
        ],
      ),
    ),
  );
}

class _CallbackType extends StatelessWidget {
  final String name;
  final String signature;
  const _CallbackType({required this.name, required this.signature});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        Expanded(child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
        Text(signature, style: const TextStyle(fontFamily: 'monospace', fontSize: 10, color: Colors.blue)),
      ]),
    );
  }
}
