import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for CallbackHandle - handle to top-level function for background isolate.
/// Demonstrates concept of callback handles for isolate communication.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('CallbackHandle Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('CallbackHandle', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Handle to a top-level function for isolate communication', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.purple.shade100, Colors.blue.shade100]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildIsolateBox('Main Isolate', Colors.purple),
                    const Icon(Icons.arrow_forward, size: 32),
                    _buildIsolateBox('Background Isolate', Colors.blue),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'CallbackHandle allows passing function references '
                    'between isolates via PluginUtilities',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('API:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildCodeBlock('PluginUtilities.getCallbackHandle(myFunction)'),
          const SizedBox(height: 8),
          _buildCodeBlock('PluginUtilities.getCallbackFromHandle(handle)'),
        ],
      ),
    ),
  );
}

Widget _buildIsolateBox(String label, Color color) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        const Icon(Icons.memory, color: Colors.white),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    ),
  );
}

Widget _buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(code, style: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
  );
}
