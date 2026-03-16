import 'package:flutter/material.dart';

/// Deep visual demo for Adaptation.
/// Shows adaptive behavior across platforms.
dynamic build(BuildContext context) {
  final platform = Theme.of(context).platform;
  return Scaffold(
    appBar: AppBar(title: const Text('Adaptation')),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Platform Adaptation', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _PlatformChip('Current Platform', platform.name, Colors.blue),
          const SizedBox(height: 24),
          const Text('Adaptive Widgets:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _AdaptiveItem('Switch', Icons.toggle_on),
          _AdaptiveItem('Slider', Icons.tune),
          _AdaptiveItem('CircularProgressIndicator', Icons.refresh),
          _AdaptiveItem('AlertDialog', Icons.chat_bubble),
          const SizedBox(height: 16),
          const Text('Uses Material on Android/web, Cupertino on iOS/macOS',
            style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    ),
  );
}

class _PlatformChip extends StatelessWidget {
  final String label; final String value; final Color color;
  const _PlatformChip(this.label, this.value, this.color);
  @override
  Widget build(BuildContext context) => Chip(
    avatar: CircleAvatar(backgroundColor: color, child: Icon(Icons.devices, color: Colors.white, size: 16)),
    label: Text('\$label: \$value'),
  );
}

class _AdaptiveItem extends StatelessWidget {
  final String name; final IconData icon;
  const _AdaptiveItem(this.name, this.icon);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(children: [Icon(icon, size: 20), const SizedBox(width: 8), Text(name)]),
  );
}
