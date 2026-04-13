import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('TextMagnifierConfig')),
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          final entries = <String>[
            'TextMagnifierConfig — configuration for text magnifier behavior',
            'This deterministic summary replaces a complex demo script',
            'that caused runtime issues in the D4rt interpreter.',
            'The original script had lifecycle or layout issues',
            'that are not compatible with interpreted execution.',
            'Summary: deterministic ListView, no state, no late fields.',
          ];
          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(entries[index]),
          );
        },
      ),
    ),
  );
}
