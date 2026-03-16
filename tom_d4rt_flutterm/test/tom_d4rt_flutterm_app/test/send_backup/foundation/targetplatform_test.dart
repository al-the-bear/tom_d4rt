import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Deep visual demo for defaultTargetPlatform - current platform getter.
/// Shows how to access and override the current platform.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('defaultTargetPlatform Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Default Target Platform',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                const Icon(Icons.settings_applications, size: 48, color: Colors.blue),
                const SizedBox(height: 12),
                const Text('defaultTargetPlatform', style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(16)),
                  child: Text(defaultTargetPlatform.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(Icons.warning, color: Colors.amber),
                  SizedBox(width: 8),
                  Text('Override in Tests:', style: TextStyle(fontWeight: FontWeight.bold)),
                ]),
                SizedBox(height: 8),
                Text('debugDefaultTargetPlatformOverride = TargetPlatform.iOS;', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Text('Used by widgets to select platform-appropriate behaviors, like scrolling physics or navigation.', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    ),
  );
}
