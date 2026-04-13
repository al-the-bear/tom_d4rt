// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const checkpoints = <String>[
    'User lifts pointer at the end of a drag.',
    'Scroll metrics are captured from the position.',
    'Notification bubbles through the widget tree.',
    'Observers can trigger snap or analytics actions.',
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('ScrollEndNotification')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Event flow',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: checkpoints.length,
                itemBuilder: (context, index) => ListTile(
                  leading: const Icon(Icons.notifications_active_outlined),
                  title: Text(checkpoints[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
