// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const phases = <String>[
    'Hold begins after gesture arena resolution.',
    'Position pauses while waiting for drag intent.',
    'Transition to drag or ballistic activity follows.',
    'Controller reports hold cancellation when released.',
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('ScrollHoldController')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.25,
        ),
        itemCount: phases.length,
        itemBuilder: (context, index) => DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blueGrey.shade200),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(phases[index]),
          ),
        ),
      ),
    ),
  );
}
