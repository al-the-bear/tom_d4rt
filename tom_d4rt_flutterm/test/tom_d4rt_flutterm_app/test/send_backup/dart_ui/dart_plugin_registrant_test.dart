import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for DartPluginRegistrant - plugin registration system.
/// Demonstrates how plugins register with the Dart runtime.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('DartPluginRegistrant Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Plugin Registration', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('System for registering native plugins', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          _buildFlowDiagram(),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('DartPluginRegistrant:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• Manages plugin initialization'),
                Text('• Called during app startup'),
                Text('• Registers platform channels'),
                Text('• Sets up native bindings'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildFlowDiagram() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        _buildStep(1, 'App Launch', Icons.launch, Colors.green),
        _buildArrow(),
        _buildStep(2, 'DartPluginRegistrant.ensureInitialized()', Icons.settings, Colors.blue),
        _buildArrow(),
        _buildStep(3, 'Register All Plugins', Icons.extension, Colors.purple),
        _buildArrow(),
        _buildStep(4, 'App Ready', Icons.check_circle, Colors.orange),
      ],
    ),
  );
}

Widget _buildStep(int num, String label, IconData icon, Color color) {
  return Row(
    children: [
      Container(
        width: 28, height: 28,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Center(child: Text('$num', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
      ),
      const SizedBox(width: 12),
      Icon(icon, color: color, size: 20),
      const SizedBox(width: 8),
      Expanded(child: Text(label, style: const TextStyle(fontSize: 12))),
    ],
  );
}

Widget _buildArrow() {
  return Container(margin: const EdgeInsets.only(left: 13), height: 16, width: 2, color: Colors.grey.shade400);
}
