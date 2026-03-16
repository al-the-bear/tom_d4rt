import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for FontFeature - OpenType font features.
/// Demonstrates ligatures, small caps, and stylistic features.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('FontFeature Demo')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('OpenType Font Features', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        _buildFeatureDemo('liga', 'Standard Ligatures', 'fi fl ff ffi', Colors.blue),
        _buildFeatureDemo('smcp', 'Small Capitals', 'SMALL CAPS TEXT', Colors.green),
        _buildFeatureDemo('onum', 'Old-style Numbers', '0123456789', Colors.orange),
        _buildFeatureDemo('tnum', 'Tabular Numbers', '0123456789', Colors.purple),
        _buildFeatureDemo('frac', 'Fractions', '1/2 3/4 5/6', Colors.red),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Creating Features:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text("FontFeature('smcp')", style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
              Text("FontFeature.enable('liga')", style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
              Text("FontFeature.tabularFigures()", style: TextStyle(fontFamily: 'monospace', fontSize: 12)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildFeatureDemo(String tag, String name, String sample, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(border: Border.all(color: color.withValues(alpha: 0.5)), borderRadius: BorderRadius.circular(12)),
    child: Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
          child: Center(child: Text(tag, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(sample, style: TextStyle(fontSize: 18, color: color)),
            ],
          ),
        ),
      ],
    ),
  );
}
