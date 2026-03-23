// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Chip variants - ActionChip, FilterChip, ChoiceChip,
// InputChip, RawChip, ChipThemeData
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Chip variants test executing');

  // ========== ActionChip ==========
  print('--- ActionChip Tests ---');

  final actionChip = ActionChip(
    label: Text('Action'),
    avatar: Icon(Icons.flash_on, size: 18.0),
    onPressed: () => print('Action chip pressed'),
    elevation: 2.0,
    pressElevation: 4.0,
    tooltip: 'Action chip tooltip',
  );
  print('ActionChip created');

  // ========== FilterChip ==========
  print('--- FilterChip Tests ---');

  final filterChip = FilterChip(
    label: Text('Filter'),
    selected: true,
    onSelected: (bool value) => print('Filter selected: $value'),
    avatar: Icon(Icons.filter_alt, size: 18.0),
    showCheckmark: true,
    checkmarkColor: Colors.white,
    selectedColor: Colors.blue.shade100,
  );
  print('FilterChip selected: ${filterChip.selected}');

  // ========== ChoiceChip ==========
  print('--- ChoiceChip Tests ---');

  final choiceChip = ChoiceChip(
    label: Text('Choice'),
    selected: false,
    onSelected: (bool value) => print('Choice selected: $value'),
    selectedColor: Colors.green.shade200,
    disabledColor: Colors.grey.shade300,
    labelStyle: TextStyle(color: Colors.black),
  );
  print('ChoiceChip selected: ${choiceChip.selected}');

  // ========== InputChip ==========
  print('--- InputChip Tests ---');

  final inputChip = InputChip(
    label: Text('Input'),
    avatar: CircleAvatar(child: Text('I')),
    onDeleted: () => print('Input chip deleted'),
    deleteIcon: Icon(Icons.cancel, size: 18.0),
    onPressed: () => print('Input chip pressed'),
    selected: false,
    isEnabled: true,
  );
  print('InputChip created');

  // ========== ChipThemeData ==========
  print('--- ChipThemeData Tests ---');

  final chipTheme = ChipThemeData(
    backgroundColor: Colors.grey.shade200,
    selectedColor: Colors.blue.shade200,
    disabledColor: Colors.grey.shade400,
    labelStyle: TextStyle(fontSize: 14.0),
    secondaryLabelStyle: TextStyle(fontSize: 12.0),
    padding: EdgeInsets.all(4.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    side: BorderSide(color: Colors.grey),
    brightness: Brightness.light,
    elevation: 2.0,
    pressElevation: 4.0,
    checkmarkColor: Colors.white,
    showCheckmark: true,
  );
  print('ChipThemeData backgroundColor: ${chipTheme.backgroundColor}');
  print('ChipThemeData elevation: ${chipTheme.elevation}');
  print('ChipThemeData showCheckmark: ${chipTheme.showCheckmark}');

  print('All chip variant tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chip Variants Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                actionChip,
                filterChip,
                choiceChip,
                inputChip,
                FilterChip(
                  label: Text('Unselected'),
                  selected: false,
                  onSelected: (v) {},
                ),
                ChoiceChip(
                  label: Text('Selected'),
                  selected: true,
                  onSelected: (v) {},
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
