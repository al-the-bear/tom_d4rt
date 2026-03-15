import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

dynamic build(BuildContext context) {
  const ltr = AnnounceSemanticsEvent('Hello world', TextDirection.ltr, 0);
  const rtl = AnnounceSemanticsEvent('مرحبا بالعالم', TextDirection.rtl, 0);

  Widget tile(String title, AnnounceSemanticsEvent event, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text('Message: ${event.message}'),
          Text('Direction: ${event.textDirection.name}'),
          Text('Type: ${event.type}'),
          Text('View: ${event.viewId}'),
        ],
      ),
    );
  }

  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'AnnounceSemanticsEvent Visual Test',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        tile('LTR Announcement', ltr, Colors.blue),
        tile('RTL Announcement', rtl, Colors.deepPurple),
      ],
    ),
  );
}
