import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for RootIsolateToken - background isolate registration.
/// Demonstrates token used for background processing setup.
dynamic build(BuildContext context) {
  final tokenExists = RootIsolateToken.instance != null;
  
  return Scaffold(
    appBar: AppBar(title: const Text('RootIsolateToken Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Root Isolate Token', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Setup token for background isolates', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: tokenExists ? Colors.green.shade50 : Colors.red.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(tokenExists ? Icons.check_circle : Icons.error, color: tokenExists ? Colors.green : Colors.red, size: 48),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Token Status', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(tokenExists ? 'Available in root isolate' : 'Not available'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Usage:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1. Get token in root isolate:', style: TextStyle(fontSize: 12)),
                Text('   final token = RootIsolateToken.instance;', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
                SizedBox(height: 8),
                Text('2. Pass to background isolate', style: TextStyle(fontSize: 12)),
                SizedBox(height: 8),
                Text('3. Register in background:', style: TextStyle(fontSize: 12)),
                Text('   BackgroundIsolateBinaryMessenger.ensureInitialized(token);', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
