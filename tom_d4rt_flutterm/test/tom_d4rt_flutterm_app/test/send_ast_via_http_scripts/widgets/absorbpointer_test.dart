import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return _AbsorbPointerDemo();
}

class _AbsorbPointerDemo extends StatefulWidget {
  @override
  State<_AbsorbPointerDemo> createState() => _AbsorbPointerDemoState();
}

class _AbsorbPointerDemoState extends State<_AbsorbPointerDemo> {
  var _absorbing = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'AbsorbPointer demo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SwitchListTile(
          title: const Text('Absorbing enabled'),
          value: _absorbing,
          onChanged: (value) => setState(() => _absorbing = value),
        ),
        Container(
          width: 260,
          height: 120,
          color: Colors.blueGrey.shade50,
          alignment: Alignment.center,
          child: AbsorbPointer(
            absorbing: _absorbing,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Tap target'),
            ),
          ),
        ),
      ],
    );
  }
}
