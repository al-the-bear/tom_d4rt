// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const stages = <Map<String, String>>[
    {
      'stage': 'update',
      'description': 'Painter receives fresh metrics from the position.',
    },
    {
      'stage': 'fade-in',
      'description': 'Thumb opacity ramps up on interaction.',
    },
    {
      'stage': 'paint',
      'description': 'Track and thumb are rendered into canvas bounds.',
    },
    {
      'stage': 'fade-out',
      'description': 'Idle timeout starts and opacity decays.',
    },
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('ScrollbarPainter')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: stages
              .map(
                (entry) => Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: const Icon(Icons.brush_outlined),
                    title: Text(entry['stage']!),
                    subtitle: Text(entry['description']!),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    ),
  );
}
