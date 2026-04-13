// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const checkpoints = <Map<String, String>>[
    {
      'stage': 'attach',
      'detail': 'Position binds to one ScrollContext and physics chain.',
    },
    {
      'stage': 'applyViewportDimension',
      'detail': 'Viewport size updates before content constraints settle.',
    },
    {
      'stage': 'applyContentDimensions',
      'detail': 'Min and max extents become available for clamping.',
    },
    {
      'stage': 'setPixels',
      'detail': 'Offset changes are validated against boundaries.',
    },
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('ScrollPositionWithSingleContext')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: checkpoints
              .map(
                (entry) => Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    title: Text(entry['stage']!),
                    subtitle: Text(entry['detail']!),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    ),
  );
}
