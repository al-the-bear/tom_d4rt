import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for AccessibilityFeatures - accessibility settings from platform.
/// Demonstrates checking accessibility flags like boldText, reduceMotion, highContrast.
dynamic build(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
  
  return Scaffold(
    appBar: AppBar(title: const Text('AccessibilityFeatures Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Platform Accessibility Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildFeatureRow(Icons.format_bold, 'Bold Text', mediaQuery.boldText),
                const SizedBox(height: 12),
                _buildFeatureRow(Icons.motion_photos_pause, 'Reduce Motion', !mediaQuery.disableAnimations),
                const SizedBox(height: 12),
                _buildFeatureRow(Icons.contrast, 'High Contrast', mediaQuery.highContrast),
                const SizedBox(height: 12),
                _buildFeatureRow(Icons.invert_colors, 'Invert Colors', mediaQuery.invertColors),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('AccessibilityFeatures provides:', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          const Text('• accessibleNavigation - Screen reader active'),
          const Text('• boldText - Bold text preference'),
          const Text('• reduceMotion - Reduced animations'),
          const Text('• highContrast - Increased contrast'),
          const Text('• invertColors - Color inversion'),
        ],
      ),
    ),
  );
}

Widget _buildFeatureRow(IconData icon, String label, bool enabled) {
  return Row(
    children: [
      Icon(icon, color: enabled ? Colors.blue : Colors.grey),
      const SizedBox(width: 12),
      Text(label),
      const Spacer(),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: enabled ? Colors.green.shade100 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(enabled ? 'ON' : 'OFF', style: TextStyle(color: enabled ? Colors.green.shade800 : Colors.grey.shade600)),
      ),
    ],
  );
}
