// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== NavigationDestinationLabelBehavior Deep Demo (Harness-Safe) ===');

  final values = NavigationDestinationLabelBehavior.values;
  for (final v in values) {
    print('  ${v.index}: ${v.name}');
  }

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'NavigationDestinationLabelBehavior',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Available label behaviors in this runtime:'),
              const SizedBox(height: 12),
              ...values.map((v) => Text('${v.index}. ${v.name}')),
              const Spacer(),
              NavigationBar(
                selectedIndex: 0,
                destinations: [
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.settings_outlined),
                    selectedIcon: Icon(Icons.settings),
                    label: 'Settings',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
