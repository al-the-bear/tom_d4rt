// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const metrics = <Map<String, String>>[
    {
      'metric': 'pixels',
      'value': '320.0',
      'note': 'Current offset in logical pixels.',
    },
    {
      'metric': 'minScrollExtent',
      'value': '0.0',
      'note': 'Lower boundary for the position.',
    },
    {
      'metric': 'maxScrollExtent',
      'value': '1260.0',
      'note': 'Upper boundary for the position.',
    },
    {
      'metric': 'viewportDimension',
      'value': '640.0',
      'note': 'Visible size used for page calculations.',
    },
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('ScrollMetricsNotification')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: metrics.length,
        itemBuilder: (context, index) {
          final row = metrics[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              title: Text('${row['metric']}: ${row['value']}'),
              subtitle: Text(row['note']!),
            ),
          );
        },
      ),
    ),
  );
}
