import 'package:flutter/material.dart';

/// Deep visual demo for ScaffoldPrelayoutGeometry.
/// Pre-layout constraints for floating action button.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('ScaffoldPrelayoutGeometry', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const Text('Available before layout', style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic)),
            const SizedBox(height: 12),
            _GeometryProp('contentBottom', 'double'),
            _GeometryProp('contentTop', 'double'),
            _GeometryProp('floatingActionButtonSize', 'Size'),
            _GeometryProp('minInsets', 'EdgeInsets'),
            _GeometryProp('scaffoldSize', 'Size'),
            _GeometryProp('snackBarSize', 'Size'),
            _GeometryProp('textDirection', 'TextDirection'),
          ],
        ),
      ),
      const SizedBox(height: 12),
      const Text('Used by FloatingActionButtonLocation', style: TextStyle(fontSize: 11, color: Colors.grey)),
    ],
  );
}

class _GeometryProp extends StatelessWidget {
  final String name;
  final String type;
  const _GeometryProp(this.name, this.type);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(name, style: const TextStyle(fontFamily: 'monospace', fontSize: 9)),
          const SizedBox(width: 8),
          Text(type, style: TextStyle(fontFamily: 'monospace', fontSize: 9, color: Colors.purple.shade700)),
        ],
      ),
    );
  }
}
