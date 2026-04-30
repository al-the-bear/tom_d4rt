// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== AutofillGroupState Deep Demo (Harness-Safe) ===');

  const fields = <String>['Name', 'Email', 'Phone'];

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'AutofillGroup State',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...fields.map((field) => TextFormField(decoration: InputDecoration(labelText: field))),
          ],
        ),
      ),
    ),
  );
}
