// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const stateRows = <Map<String, String>>[
    {
      'state': 'idle',
      'detail': 'No active selection or drag gesture in progress.',
    },
    {
      'state': 'selecting',
      'detail': 'Handles update while pointer drag changes range.',
    },
    {
      'state': 'toolbar-visible',
      'detail': 'Context actions displayed for selected content.',
    },
    {'state': 'cleared', 'detail': 'Selection collapsed and overlays removed.'},
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('SelectableRegionState')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: stateRows
              .map(
                (row) => Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: const Icon(Icons.select_all),
                    title: Text(row['state']!),
                    subtitle: Text(row['detail']!),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    ),
  );
}
