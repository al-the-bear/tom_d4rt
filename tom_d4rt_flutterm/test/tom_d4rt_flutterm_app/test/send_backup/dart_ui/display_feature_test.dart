import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for DisplayFeature - physical screen features.
/// Demonstrates hinges, folds, and cutouts on foldable devices.
dynamic build(BuildContext context) {
  final displayFeatures = MediaQuery.of(context).displayFeatures;
  
  return Scaffold(
    appBar: AppBar(title: const Text('DisplayFeature Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Display Features', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Found: ${displayFeatures.length} features', style: TextStyle(color: Colors.grey.shade600)),
          const SizedBox(height: 24),
          _buildFeatureTypeCard('Hinge', 'Physical hinge on foldable', Icons.phonelink, Colors.blue),
          const SizedBox(height: 12),
          _buildFeatureTypeCard('Fold', 'Flexible fold area', Icons.layers, Colors.green),
          const SizedBox(height: 12),
          _buildFeatureTypeCard('Cutout', 'Camera or sensor cutout', Icons.crop, Colors.orange),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('DisplayFeature Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('• bounds - Rect of the feature'),
                Text('• type - DisplayFeatureType'),
                Text('• state - DisplayFeatureState'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildFeatureTypeCard(String name, String desc, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(border: Border.all(color: color.withValues(alpha: 0.5)), borderRadius: BorderRadius.circular(12)),
    child: Row(
      children: [
        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: color)),
        const SizedBox(width: 16),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(desc, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
        ]),
      ],
    ),
  );
}
