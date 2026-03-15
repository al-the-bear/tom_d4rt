import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for Brightness - light vs dark theme modes.
/// Demonstrates visual difference between light and dark brightness.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Brightness Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: _buildBrightnessCard(
              Brightness.light,
              'Brightness.light',
              Colors.white,
              Colors.black,
              Icons.light_mode,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _buildBrightnessCard(
              Brightness.dark,
              'Brightness.dark',
              Colors.grey.shade900,
              Colors.white,
              Icons.dark_mode,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildBrightnessCard(Brightness brightness, String label, Color bg, Color fg, IconData icon) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8, offset: const Offset(0, 4))],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 64, color: fg),
        const SizedBox(height: 16),
        Text(label, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: fg, fontFamily: 'monospace')),
        const SizedBox(height: 8),
        Text(
          brightness == Brightness.light ? 'Light backgrounds, dark text' : 'Dark backgrounds, light text',
          style: TextStyle(color: fg.withValues(alpha: 0.7)),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: fg.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text('Theme mode: ${brightness.name}', style: TextStyle(color: fg)),
        ),
      ],
    ),
  );
}
