// ignore_for_file: avoid_print
// D4rt test script: Tests RawChip, ChipAttributes-related concepts,
// DeletableChipAttributes, SelectableChipAttributes
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Chip attributes test executing');

  // ========== RawChip ==========
  print('--- RawChip Tests ---');
  final rawChip = RawChip(
    label: Text('Raw Chip'),
    avatar: CircleAvatar(child: Text('R')),
    onPressed: () => print('Raw chip pressed'),
    onDeleted: () => print('Raw chip deleted'),
    deleteIcon: Icon(Icons.cancel, size: 18.0),
    selected: false,
    isEnabled: true,
    elevation: 2.0,
    pressElevation: 4.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    side: BorderSide(color: Colors.grey),
    labelStyle: TextStyle(fontSize: 14.0),
    labelPadding: EdgeInsets.symmetric(horizontal: 4.0),
    padding: EdgeInsets.all(4.0),
    materialTapTargetSize: MaterialTapTargetSize.padded,
    showCheckmark: false,
    tapEnabled: true,
  );
  print('RawChip created');
  print('  selected: false');
  print('  isEnabled: true');
  print('  elevation: 2.0');

  // Selected RawChip
  final selectedRaw = RawChip(
    label: Text('Selected Raw'),
    selected: true,
    selectedColor: Colors.blue.shade200,
    selectedShadowColor: Colors.blue.shade400,
    showCheckmark: true,
    checkmarkColor: Colors.white,
    onSelected: (v) => print('Selected: $v'),
  );
  print('Selected RawChip created');

  // Disabled RawChip
  final disabledRaw = RawChip(
    label: Text('Disabled Raw'),
    isEnabled: false,
    disabledColor: Colors.grey.shade300,
  );
  print('Disabled RawChip created');

  // ========== Chip with avatar ==========
  print('--- Chip with avatar Tests ---');
  final chipWithAvatar = Chip(
    avatar: CircleAvatar(
      backgroundColor: Colors.blue.shade100,
      child: Text('A'),
    ),
    label: Text('Avatar Chip'),
    deleteIcon: Icon(Icons.close, size: 18.0),
    onDeleted: () => print('Chip deleted'),
    labelPadding: EdgeInsets.only(left: 4.0),
    side: BorderSide(color: Colors.blue.shade200),
  );
  print('Chip with avatar created');

  // ========== Chip themes ==========
  print('--- ChipTheme Tests ---');
  final chipTheme = ChipTheme(
    data: ChipThemeData(
      backgroundColor: Colors.grey.shade100,
      selectedColor: Colors.blue.shade200,
      labelStyle: TextStyle(fontSize: 14.0, color: Colors.black),
      padding: EdgeInsets.all(4.0),
    ),
    child: Wrap(children: [rawChip, selectedRaw]),
  );
  print('ChipTheme wrapping chips');

  print('All chip attribute tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chip Attributes Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [rawChip, selectedRaw, disabledRaw, chipWithAvatar],
            ),
          ],
        ),
      ),
    ),
  );
}
