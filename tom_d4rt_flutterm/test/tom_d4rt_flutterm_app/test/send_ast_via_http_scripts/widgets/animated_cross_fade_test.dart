import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return _AnimatedCrossFadeDemo();
}

class _AnimatedCrossFadeDemo extends StatefulWidget {
  @override
  State<_AnimatedCrossFadeDemo> createState() => _AnimatedCrossFadeDemoState();
}

class _AnimatedCrossFadeDemoState extends State<_AnimatedCrossFadeDemo> {
  var _showFirst = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'AnimatedCrossFade demo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        OutlinedButton(
          onPressed: () => setState(() => _showFirst = !_showFirst),
          child: const Text('Cross-fade'),
        ),
        AnimatedCrossFade(
          firstChild: Container(
            width: 260,
            height: 90,
            color: Colors.pink.shade100,
            alignment: Alignment.center,
            child: const Text('First child'),
          ),
          secondChild: Container(
            width: 260,
            height: 90,
            color: Colors.purple.shade100,
            alignment: Alignment.center,
            child: const Text('Second child'),
          ),
          crossFadeState: _showFirst
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }
}
