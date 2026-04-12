// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== AutomaticKeepAliveClientMixin Deep Demo (Harness-Safe) ===');

  final rows = List<String>.generate(8, (index) => 'Item ${index + 1} (keepAlive summary)');

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: rows.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text(
                    'AutomaticKeepAliveClientMixin',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                );
              }
              return Card(child: ListTile(title: Text(rows[index - 1])));
            },
          ),
        ),
      ),
    ),
  );
}
