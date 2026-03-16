import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for TargetPlatformVariant - testing across platforms.
/// Shows how tests can run variants for different target platforms.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('TargetPlatformVariant Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Platform Test Variants',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _PlatformCard(platform: 'Android', icon: Icons.android, color: Colors.green),
          _PlatformCard(platform: 'iOS', icon: Icons.phone_iphone, color: Colors.grey),
          _PlatformCard(platform: 'macOS', icon: Icons.laptop_mac, color: Colors.blue),
          _PlatformCard(platform: 'Windows', icon: Icons.window, color: Colors.cyan),
          _PlatformCard(platform: 'Linux', icon: Icons.computer, color: Colors.orange),
          _PlatformCard(platform: 'Fuchsia', icon: Icons.devices_other, color: Colors.pink),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('TargetPlatformVariant.all() runs tests on all platforms automatically', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}

class _PlatformCard extends StatelessWidget {
  final String platform;
  final IconData icon;
  final Color color;
  const _PlatformCard({required this.platform, required this.icon, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Text(platform, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(4)),
            child: const Text('PASS', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
