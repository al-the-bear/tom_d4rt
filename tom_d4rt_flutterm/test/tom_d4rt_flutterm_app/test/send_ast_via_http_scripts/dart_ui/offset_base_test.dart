import 'dart:ui';
import 'package:flutter/material.dart';

/// Deep visual demo for OffsetBase - base class for Offset and Size.
/// Demonstrates shared properties between Offset and Size.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('OffsetBase Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('OffsetBase', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Base class for 2D values', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          _buildHierarchy(),
          const SizedBox(height: 24),
          _buildComparisonTable(),
        ],
      ),
    ),
  );
}

Widget _buildHierarchy() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.circular(8)),
          child: const Text('OffsetBase', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 2, height: 20, color: Colors.grey),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
              child: const Text('Offset', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(8)),
              child: const Text('Size', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildComparisonTable() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Properties:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        Row(children: [Text('• dx / width', style: TextStyle(fontFamily: 'monospace')), SizedBox(width: 16), Text('First component')]),
        Row(children: [Text('• dy / height', style: TextStyle(fontFamily: 'monospace')), SizedBox(width: 16), Text('Second component')]),
        SizedBox(height: 12),
        Text('Common to both Offset and Size', style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    ),
  );
}
