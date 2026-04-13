import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {'label': 'Class', 'value': 'UserScrollNotification'},
    {'label': 'Kind', 'value': 'ScrollNotification subclass'},
    {'label': 'Purpose', 'value': 'Notifies listeners about user-initiated scroll direction changes'},
    {'label': 'Key property', 'value': 'direction — ScrollDirection indicating user drag direction'},
    {'label': 'Related', 'value': 'ScrollNotification, NotificationListener'},
    {'label': 'Use-case', 'value': 'Hiding/showing UI elements based on scroll direction'},
    {'label': 'Flutter layer', 'value': 'widgets (scrolling)'},
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF0F172A),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('UserScrollNotification Summary'),
      ),
      body: ListView.builder(
        itemCount: rows.length,
        itemBuilder: (context, index) {
          final row = rows[index];
          return ListTile(
            leading: Text(
              '${index + 1}',
              style: const TextStyle(color: Color(0xFF99F6E4), fontSize: 16),
            ),
            title: Text(row['label']!,
                style: const TextStyle(
                    color: Color(0xFFFFD27A), fontWeight: FontWeight.w700)),
            subtitle: Text(row['value']!,
                style: const TextStyle(color: Color(0xFFF8FAFC))),
          );
        },
      ),
    ),
  );
}
