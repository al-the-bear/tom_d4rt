import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for PluginUtilities - plugin message registration.
/// Demonstrates platform channel registration for plugins.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('PluginUtilities Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Plugin Utilities', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Low-level plugin registration', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.indigo.shade50, borderRadius: BorderRadius.circular(12)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [Icon(Icons.extension, color: Colors.indigo), SizedBox(width: 8), Text('Purpose', style: TextStyle(fontWeight: FontWeight.bold))]),
                SizedBox(height: 8),
                Text('Register Dart callbacks that can be invoked from platform-specific plugin code.'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Key Methods:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildMethod('getCallbackHandle', 'Get handle for callback function'),
          _buildMethod('getCallbackFromHandle', 'Get callback from handle'),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(8)),
            child: const Row(
              children: [
                Icon(Icons.info, color: Colors.orange),
                SizedBox(width: 12),
                Expanded(child: Text('Typically used for background execution and platform plugin communication.')),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildMethod(String name, String desc) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(border: Border.all(color: Colors.indigo.shade200), borderRadius: BorderRadius.circular(8)),
    child: Row(children: [
      const Icon(Icons.functions, color: Colors.indigo, size: 20),
      const SizedBox(width: 12),
      Text(name, style: const TextStyle(fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.w500)),
      const Spacer(),
      Text(desc, style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
    ]),
  );
}
