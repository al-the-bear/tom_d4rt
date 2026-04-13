// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const checkpoints = <String>[
    'Pointer drag starts and creates a new scroll activity.',
    'ScrollStartNotification captures initial metrics.',
    'Notification bubbles to observers in parent widgets.',
    'Observers can trigger UI updates or analytics hooks.',
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('ScrollStartNotification')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: checkpoints.length,
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(checkpoints[index]),
          ),
        ),
      ),
    ),
  );
}
