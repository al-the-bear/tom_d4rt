// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== DrawerControllerState Deep Demo (Harness-Safe) ===');

  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('DrawerControllerState')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: const [
              Text(
                'DrawerControllerState',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Harness-safe list layout avoids horizontal overflow.'),
              SizedBox(height: 8),
              Text('Drawer open/close state should be tracked by controller lifecycle.'),
              SizedBox(height: 8),
              Text('This summary script intentionally uses wrapped/scrollable layout only.'),
            ],
          ),
        ),
      ),
      drawer: const Drawer(
        child: Center(child: Text('Drawer content')),
      ),
    ),
  );
}
