import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for DartPerformanceMode - performance optimization modes.
/// Demonstrates balanced vs latency optimization modes.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('DartPerformanceMode Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Performance Modes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _buildModeCard(
            'DartPerformanceMode.balanced',
            'Balanced Performance',
            'Default mode balancing throughput and latency',
            Icons.balance,
            Colors.blue,
          ),
          const SizedBox(height: 16),
          _buildModeCard(
            'DartPerformanceMode.latency',
            'Low Latency',
            'Optimized for minimal response time',
            Icons.speed,
            Colors.green,
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Usage:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('PlatformDispatcher.instance.requestDartPerformanceMode(mode)', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildModeCard(String code, String name, String desc, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [color.withValues(alpha: 0.1), color.withValues(alpha: 0.05)], begin: Alignment.topLeft, end: Alignment.bottomRight),
      border: Border.all(color: color.withValues(alpha: 0.3)),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: color, size: 32),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
              Text(code, style: const TextStyle(fontFamily: 'monospace', fontSize: 10, color: Colors.grey)),
              const SizedBox(height: 4),
              Text(desc, style: TextStyle(color: Colors.grey.shade600)),
            ],
          ),
        ),
      ],
    ),
  );
}
