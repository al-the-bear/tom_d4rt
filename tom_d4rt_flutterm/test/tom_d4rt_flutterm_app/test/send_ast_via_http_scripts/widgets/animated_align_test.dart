import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return _AnimatedAlignDemo();
}

class _AnimatedAlignDemo extends StatefulWidget {
  @override
  State<_AnimatedAlignDemo> createState() => _AnimatedAlignDemoState();
}

class _AnimatedAlignDemoState extends State<_AnimatedAlignDemo> {
  var _end = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'AnimatedAlign demo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        FilledButton(
          onPressed: () => setState(() => _end = !_end),
          child: const Text('Toggle alignment'),
        ),
        Container(
          width: 280,
          height: 120,
          color: Colors.cyan.shade50,
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 350),
            alignment: _end ? Alignment.bottomRight : Alignment.topLeft,
            child: Container(
              width: 50,
              height: 50,
              color: Colors.cyan.shade700,
            ),
          ),
        ),
      ],
    );
  }
}
