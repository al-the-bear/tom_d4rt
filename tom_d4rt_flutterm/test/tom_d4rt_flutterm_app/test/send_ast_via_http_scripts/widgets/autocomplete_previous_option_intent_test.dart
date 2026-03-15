import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('AutocompletePreviousOptionIntent demo', style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: const [
          Chip(label: Text('Intent mapping')),
          Chip(label: Text('Action handling')),
          Chip(label: Text('Focusable target')),
        ],
      ),
    ],
  );
}
