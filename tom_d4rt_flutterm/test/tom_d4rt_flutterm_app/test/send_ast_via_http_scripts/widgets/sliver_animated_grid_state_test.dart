import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const apis = <Map<String, String>>[
    {
      'method': 'insertItem(index)',
      'detail': 'Adds an item and runs the entrance animation.',
    },
    {
      'method': 'removeItem(index, builder)',
      'detail': 'Removes an item and drives a reverse animation builder.',
    },
    {
      'method': 'removeAllItems(builder)',
      'detail': 'Animates all remaining items out of the grid.',
    },
    {
      'method': 'GlobalKey access',
      'detail': 'Control SliverAnimatedGridState through a GlobalKey.',
    },
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('SliverAnimatedGridState')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: apis.length,
        itemBuilder: (context, index) {
          final row = apis[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              title: Text(row['method']!),
              subtitle: Text(row['detail']!),
            ),
          );
        },
      ),
    ),
  );
}
