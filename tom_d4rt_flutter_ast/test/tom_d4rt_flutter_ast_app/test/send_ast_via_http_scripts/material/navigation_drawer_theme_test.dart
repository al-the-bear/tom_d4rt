// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== NavigationDrawerTheme Deep Demo (Harness-Safe) ===');

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            SizedBox(
              width: 300,
              child: NavigationDrawerTheme(
                data: const NavigationDrawerThemeData(),
                child: NavigationDrawer(
                  selectedIndex: 0,
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text('Destinations'),
                    ),
                    NavigationDrawerDestination(
                      icon: Icon(Icons.inbox_outlined),
                      selectedIcon: Icon(Icons.inbox),
                      label: Text('Inbox'),
                    ),
                    NavigationDrawerDestination(
                      icon: Icon(Icons.send_outlined),
                      selectedIcon: Icon(Icons.send),
                      label: Text('Sent'),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(
              child: Center(child: Text('Content area')),
            ),
          ],
        ),
      ),
    ),
  );
}
