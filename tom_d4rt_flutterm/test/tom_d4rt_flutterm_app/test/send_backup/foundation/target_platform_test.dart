import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for TargetPlatform - platform detection enum.
/// Shows detecting and handling different platforms.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('TargetPlatform Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Target Platform Detection',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _PlatformChip(platform: 'android', icon: Icons.android, color: Colors.green),
              _PlatformChip(platform: 'iOS', icon: Icons.phone_iphone, color: Colors.grey),
              _PlatformChip(platform: 'fuchsia', icon: Icons.memory, color: Colors.pink),
              _PlatformChip(platform: 'linux', icon: Icons.desktop_windows, color: Colors.orange),
              _PlatformChip(platform: 'macOS', icon: Icons.laptop_mac, color: Colors.blue),
              _PlatformChip(platform: 'windows', icon: Icons.window, color: Colors.cyan),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
            child: Row(children: [
              const Icon(Icons.devices, color: Colors.blue),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Current Platform:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(Theme.of(context).platform.name, style: const TextStyle(fontFamily: 'monospace')),
                  ],
                ),
              ),
            ]),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('Access via defaultTargetPlatform or Theme.of(context).platform', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}

class _PlatformChip extends StatelessWidget {
  final String platform;
  final IconData icon;
  final Color color;
  const _PlatformChip({required this.platform, required this.icon, required this.color});
  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, color: color, size: 18),
      label: Text(platform),
      backgroundColor: color.withValues(alpha: 0.1),
    );
  }
}
