import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return _AnimatedFractionallySizedBoxDemo();
}

class _AnimatedFractionallySizedBoxDemo extends StatefulWidget {
  @override
  State<_AnimatedFractionallySizedBoxDemo> createState() => _AnimatedFractionallySizedBoxDemoState();
}

class _AnimatedFractionallySizedBoxDemoState extends State<_AnimatedFractionallySizedBoxDemo> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('AnimatedFractionallySizedBox demo', style: TextStyle(fontWeight: FontWeight.bold)),
        ElevatedButton(onPressed: () => setState(() => _expanded = !_expanded), child: const Text('Toggle factor')),
        Container(
          width: 280,
          height: 100,
          color: Colors.lime.shade100,
          child: AnimatedFractionallySizedBox(
            duration: const Duration(milliseconds: 300),
            widthFactor: _expanded ? 0.9 : 0.4,
            alignment: Alignment.centerLeft,
            child: Container(color: Colors.lime.shade700),
          ),
        ),
      ],
    );
  }
}
