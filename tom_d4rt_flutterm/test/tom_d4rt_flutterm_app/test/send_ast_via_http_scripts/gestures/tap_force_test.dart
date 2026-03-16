import 'package:flutter/material.dart';

/// Deep visual demo for TapDownDetails force pressure.
/// Shows pressure-sensitive tap info.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Tap Force')),
    body: Center(child: _ForceDemo()),
  );
}

class _ForceDemo extends StatefulWidget {
  @override
  State<_ForceDemo> createState() => _ForceDemoState();
}

class _ForceDemoState extends State<_ForceDemo> {
  double _force = 0;
  String _kind = 'N/A';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Press with varying force', style: TextStyle(fontSize: 16)),
        const Text('(Force Touch / 3D Touch devices)', style: TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 24),
        GestureDetector(
          onTapDown: (d) => setState(() {
            _kind = d.kind?.toString() ?? 'unknown';
          }),
          onForcePressStart: (d) => setState(() => _force = d.pressure),
          onForcePressUpdate: (d) => setState(() => _force = d.pressure),
          onForcePressEnd: (_) => setState(() => _force = 0),
          child: Container(
            width: 160, height: 160,
            decoration: BoxDecoration(
              color: Color.lerp(Colors.blue.shade100, Colors.blue.shade900, _force) ?? Colors.blue,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.blue.withAlpha((100 * _force).toInt()), blurRadius: 20 * _force, spreadRadius: 5 * _force)],
            ),
            alignment: Alignment.center,
            child: Text(
              '\${(_force * 100).toInt()}%',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: _force > 0.5 ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              Text('Pressure: \${_force.toStringAsFixed(2)}'),
              Text('Device kind: \$_kind'),
              const SizedBox(height: 8),
              const Text('Not all devices support force', style: TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }
}
