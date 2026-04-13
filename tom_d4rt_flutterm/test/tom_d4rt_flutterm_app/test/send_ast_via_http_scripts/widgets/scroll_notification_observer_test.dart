// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const observerPoints = <String>[
    'Observer listens for bubbling scroll notifications.',
    'Nested lists can be tracked from a common ancestor.',
    'Consumers can derive analytics or sticky-header triggers.',
    'Filtering by notification type avoids noisy handlers.',
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('ScrollNotificationObserver')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: observerPoints.length,
        separatorBuilder: (_, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) => ListTile(
          leading: const Icon(Icons.visibility_outlined),
          title: Text(observerPoints[index]),
        ),
      ),
    ),
  );
}
