// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ToggleButtonsTheme Deep Demo (Harness-Safe) ===');

  return MaterialApp(
    home: Scaffold(
      body: SafeArea(
        child: Center(
          child: ToggleButtonsTheme(
            data: const ToggleButtonsThemeData(),
            child: ToggleButtons(
              isSelected: const [false, true, false],
              onPressed: null,
              children: const [
                Padding(padding: EdgeInsets.all(8), child: Text('One')),
                Padding(padding: EdgeInsets.all(8), child: Text('Two')),
                Padding(padding: EdgeInsets.all(8), child: Text('Three')),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
