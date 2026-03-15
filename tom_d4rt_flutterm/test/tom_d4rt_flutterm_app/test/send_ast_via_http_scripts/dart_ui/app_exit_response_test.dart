import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for AppExitResponse - response to app exit requests.
/// Demonstrates exit vs cancel responses when app tries to close.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('AppExitResponse Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('App Exit Response Values', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildResponseCard(
            'AppExitResponse.exit',
            'Allow the app to exit',
            Icons.exit_to_app,
            Colors.red,
          ),
          const SizedBox(height: 16),
          _buildResponseCard(
            'AppExitResponse.cancel',
            'Cancel the exit request',
            Icons.cancel,
            Colors.orange,
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Usage:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('AppExitResponse is returned from'),
                Text('AppLifecycleListener.onExitRequested'),
                Text('to control whether the app exits.'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildResponseCard(String title, String description, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: color.withValues(alpha: 0.5)),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 32),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontFamily: 'monospace')),
              const SizedBox(height: 4),
              Text(description, style: TextStyle(color: Colors.grey.shade600)),
            ],
          ),
        ),
      ],
    ),
  );
}
