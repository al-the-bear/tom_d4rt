import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

Widget _eventCard(
  String title,
  GranularlyExtendSelectionEvent event,
  Color color,
) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text('Forward: ${event.forward}'),
          Text('isEnd: ${event.isEnd}'),
          Text('Granularity: ${event.granularity.name}'),
          Text('Type: ${event.type.name}'),
        ],
      ),
    ),
  );
}

dynamic build(BuildContext context) {
  const byCharacter = GranularlyExtendSelectionEvent(
    forward: true,
    isEnd: true,
    granularity: TextGranularity.character,
  );
  const byWordBackward = GranularlyExtendSelectionEvent(
    forward: false,
    isEnd: false,
    granularity: TextGranularity.word,
  );

  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'GranularlyExtendSelectionEvent Visual Test',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _eventCard('Character forward', byCharacter, Colors.blue),
            const SizedBox(width: 10),
            _eventCard('Word backward', byWordBackward, Colors.deepOrange),
          ],
        ),
      ],
    ),
  );
}
