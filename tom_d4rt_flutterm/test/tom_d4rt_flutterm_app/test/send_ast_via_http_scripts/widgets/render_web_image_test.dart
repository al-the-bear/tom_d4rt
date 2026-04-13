// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RenderWebImage Deep Demo (Harness-Safe) ===');

  const panels = <String>[
    'network source strategy',
    'placeholder policy',
    'decoding hints',
    'paint ordering',
    'practical checklist',
  ];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: panels.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Text('${index + 1}'),
                ),
                Expanded(
                  child: Text(
                    panels[index],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ),
  );
}
