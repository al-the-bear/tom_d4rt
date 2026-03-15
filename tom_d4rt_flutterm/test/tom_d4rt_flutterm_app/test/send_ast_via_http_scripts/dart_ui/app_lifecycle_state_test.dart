import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for AppLifecycleState - application lifecycle states.
/// Demonstrates all lifecycle states: detached, resumed, inactive, hidden, paused.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('AppLifecycleState Demo')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('App Lifecycle States', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('States your app transitions through', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          _buildStateCard('detached', 'App not attached to view', Icons.link_off, Colors.grey, 0),
          _buildConnector(),
          _buildStateCard('resumed', 'App visible & responding', Icons.play_circle, Colors.green, 1),
          _buildConnector(),
          _buildStateCard('inactive', 'App visible but not focused', Icons.pause_circle_outline, Colors.orange, 2),
          _buildConnector(),
          _buildStateCard('hidden', 'App hidden (desktop)', Icons.visibility_off, Colors.purple, 3),
          _buildConnector(),
          _buildStateCard('paused', 'App in background', Icons.stop_circle, Colors.red, 4),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.blue),
                const SizedBox(width: 12),
                const Expanded(child: Text('Use WidgetsBindingObserver to listen for state changes')),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildStateCard(String state, String description, IconData icon, Color color, int index) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: color.withValues(alpha: 0.5)),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: color.withValues(alpha: 0.1), blurRadius: 8, offset: const Offset(0, 2))],
    ),
    child: Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(24)),
          child: Icon(icon, color: color),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('AppLifecycleState.$state', style: const TextStyle(fontWeight: FontWeight.w600, fontFamily: 'monospace')),
              Text(description, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildConnector() {
  return Container(
    margin: const EdgeInsets.only(left: 40),
    height: 24,
    width: 2,
    color: Colors.grey.shade300,
  );
}
