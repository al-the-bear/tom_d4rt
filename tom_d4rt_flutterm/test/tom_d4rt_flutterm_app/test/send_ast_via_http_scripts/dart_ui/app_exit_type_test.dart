import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for AppExitType - types of app exit scenarios.
/// Demonstrates cancelable vs required exit types.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('AppExitType Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('App Exit Types', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildTypeCard(
            'AppExitType.cancelable',
            'Exit can be cancelled by the app',
            Icons.cancel_outlined,
            Colors.green,
            ['User clicks close button', 'Cmd+Q on macOS', 'Can prompt "Save changes?"'],
          ),
          const SizedBox(height: 16),
          _buildTypeCard(
            'AppExitType.required',
            'Exit cannot be cancelled',
            Icons.power_settings_new,
            Colors.red,
            ['System shutdown', 'Force quit', 'App must exit immediately'],
          ),
        ],
      ),
    ),
  );
}

Widget _buildTypeCard(String title, String description, IconData icon, Color color, List<String> examples) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.withValues(alpha: 0.1), color.withValues(alpha: 0.05)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(color: color.withValues(alpha: 0.3)),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontFamily: 'monospace')),
                  Text(description, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...examples.map((e) => Padding(
          padding: const EdgeInsets.only(left: 40, bottom: 4),
          child: Row(
            children: [
              Icon(Icons.arrow_right, size: 16, color: color),
              const SizedBox(width: 4),
              Text(e, style: const TextStyle(fontSize: 13)),
            ],
          ),
        )),
      ],
    ),
  );
}
