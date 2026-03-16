import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for PointerEvent base class.
/// Shows common properties of all pointer events.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PointerEvent')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('PointerEvent Base Properties', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _PropertyCard('position', 'Offset', 'Location in global coordinates'),
        _PropertyCard('localPosition', 'Offset', 'Location in local widget coordinates'),
        _PropertyCard('delta', 'Offset', 'Distance moved since last event'),
        _PropertyCard('pressure', 'double', 'Pressure applied (0.0 to 1.0)'),
        _PropertyCard('device', 'int', 'Unique device identifier'),
        _PropertyCard('kind', 'PointerDeviceKind', 'touch, mouse, stylus, etc.'),
        _PropertyCard('timeStamp', 'Duration', 'Time since frame began'),
        const SizedBox(height: 16),
        GestureDetector(
          onTapDown: (d) => print('Position: \${d.globalPosition}'),
          child: Container(
            height: 100,
            color: Colors.blue.shade100,
            alignment: Alignment.center,
            child: const Text('Tap to see position in console'),
          ),
        ),
      ],
    ),
  );
}

class _PropertyCard extends StatelessWidget {
  final String name;
  final String type;
  final String desc;
  const _PropertyCard(this.name, this.type, this.desc);
  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(desc),
      trailing: Chip(label: Text(type, style: const TextStyle(fontSize: 11))),
    ),
  );
}
