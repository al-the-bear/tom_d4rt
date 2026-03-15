import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget _kv(String label, Object? value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(width: 130, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600))),
        Expanded(child: Text('$value')),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  final down = KeyDownEvent(
    physicalKey: PhysicalKeyboardKey.keyA,
    logicalKey: LogicalKeyboardKey.keyA,
    timeStamp: Duration.zero,
    character: 'a',
  );
  final up = const KeyUpEvent(
    physicalKey: PhysicalKeyboardKey.keyA,
    logicalKey: LogicalKeyboardKey.keyA,
    timeStamp: Duration(milliseconds: 8),
  );

  return Card(
    margin: const EdgeInsets.all(16),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('KeyEvent Visual Test (modern replacement)', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _kv('Down type', down.runtimeType),
          _kv('Down logical', down.logicalKey.debugName),
          _kv('Down physical', down.physicalKey.debugName),
          _kv('Down char', down.character),
          const Divider(),
          _kv('Up type', up.runtimeType),
          _kv('Up logical', up.logicalKey.debugName),
          _kv('Up physical', up.physicalKey.debugName),
          _kv('Up char', up.character),
        ],
      ),
    ),
  );
}