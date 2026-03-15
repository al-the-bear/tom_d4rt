import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for IsolateNameServer - isolate lookup by name.
/// Demonstrates registering and finding isolates by name.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('IsolateNameServer Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Isolate Name Server', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Find isolates by registered name', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          _buildIsolateRegistry(),
          const SizedBox(height: 24),
          const Text('Methods:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildMethod('registerPortWithName', 'Register a SendPort', Colors.blue),
          _buildMethod('lookupPortByName', 'Find a registered port', Colors.green),
          _buildMethod('removePortNameMapping', 'Unregister a port', Colors.red),
        ],
      ),
    ),
  );
}

Widget _buildIsolateRegistry() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [Colors.indigo.shade100, Colors.purple.shade100]),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      children: [
        const Text('Name Registry', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildRegistryRow('background_task', true),
        _buildRegistryRow('audio_player', true),
        _buildRegistryRow('file_watcher', false),
      ],
    ),
  );
}

Widget _buildRegistryRow(String name, bool registered) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
    child: Row(
      children: [
        Icon(registered ? Icons.check_circle : Icons.cancel, color: registered ? Colors.green : Colors.grey, size: 20),
        const SizedBox(width: 8),
        Text(name, style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
        const Spacer(),
        Text(registered ? 'Registered' : 'Available', style: TextStyle(fontSize: 11, color: registered ? Colors.green : Colors.grey)),
      ],
    ),
  );
}

Widget _buildMethod(String name, String desc, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(border: Border(left: BorderSide(color: color, width: 4)), color: color.withValues(alpha: 0.1)),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold)),
              Text(desc, style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
            ],
          ),
        ),
      ],
    ),
  );
}
