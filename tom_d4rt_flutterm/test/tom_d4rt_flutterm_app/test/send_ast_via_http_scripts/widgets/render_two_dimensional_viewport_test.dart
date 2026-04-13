// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RenderTwoDimensionalViewport Deep Demo (Harness-Safe) ===');

  const rows = <String>[
    'grid abstraction',
    'viewport offsets',
    'cross-axis culling',
    'cache extent',
    'practical summary',
  ];

  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Two Dimensional Viewport')),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth.isFinite
                ? constraints.maxWidth
                : 400.0;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: rows.length,
              itemBuilder: (context, index) {
                return Container(
                  width: width,
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.teal.shade200),
                  ),
                  child: Text('${index + 1}. ${rows[index]}'),
                );
              },
            );
          },
        ),
      ),
    ),
  );
}
