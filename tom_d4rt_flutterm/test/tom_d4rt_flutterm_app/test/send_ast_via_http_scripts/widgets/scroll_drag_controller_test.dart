// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const events = <String>[
    'Pointer down starts a drag sequence.',
    'Controller tracks delta updates from gestures.',
    'Overscroll is clamped by active scroll physics.',
    'Pointer up ends drag and transitions activity.',
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('ScrollDragController')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: events.length,
        separatorBuilder: (_, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) => Card(
          child: ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(events[index]),
          ),
        ),
      ),
    ),
  );
}
