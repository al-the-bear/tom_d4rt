// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== EndDrawerButton Deep Demo (Harness-Safe) ===');

  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('EndDrawerButton'),
        actions: const [
          EndDrawerButton(),
        ],
      ),
      endDrawer: SizedBox(
        width: 280,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const [
              DrawerHeader(child: Text('Drawer Header')),
              ListTile(title: Text('Item 1')),
              ListTile(title: Text('Item 2')),
            ],
          ),
        ),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Bounded end-drawer layout to avoid infinite-size render constraints.',
          ),
        ),
      ),
    ),
  );
}
