import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('AbstractLayoutBuilder concept', style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      Container(
        width: 320,
        height: 140,
        color: Colors.indigo.shade50,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 240;
            return Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: compact ? 120 : 220,
                height: 80,
                color: compact ? Colors.orange : Colors.teal,
                alignment: Alignment.center,
                child: Text('maxWidth ${constraints.maxWidth.toStringAsFixed(0)}'),
              ),
            );
          },
        ),
      ),
    ],
  );
}
