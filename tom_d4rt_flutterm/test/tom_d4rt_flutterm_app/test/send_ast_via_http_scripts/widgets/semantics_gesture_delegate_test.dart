// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const delegates = <Map<String, String>>[
    {
      'gesture': 'tap',
      'semanticAction': 'activate',
      'result': 'Primary control action triggered.',
    },
    {
      'gesture': 'longPress',
      'semanticAction': 'showContextMenu',
      'result': 'Assistive action menu opened.',
    },
    {
      'gesture': 'scroll',
      'semanticAction': 'scrollUp/scrollDown',
      'result': 'Viewport moved with semantic feedback.',
    },
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('SemanticsGestureDelegate')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: delegates
              .map(
                (row) => Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: const Icon(Icons.accessibility_new_outlined),
                    title: Text(
                      '${row['gesture']} -> ${row['semanticAction']}',
                    ),
                    subtitle: Text(row['result']!),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    ),
  );
}
