// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ToggleButtonsThemeData Deep Demo (Harness-Safe) ===');

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ToggleButtonsTheme(
            data: const ToggleButtonsThemeData(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ToggleButtonsThemeData',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                ToggleButtons(
                  isSelected: [true, false],
                  onPressed: null,
                  children: [
                    Padding(padding: EdgeInsets.all(8), child: Text('A')),
                    Padding(padding: EdgeInsets.all(8), child: Text('B')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
