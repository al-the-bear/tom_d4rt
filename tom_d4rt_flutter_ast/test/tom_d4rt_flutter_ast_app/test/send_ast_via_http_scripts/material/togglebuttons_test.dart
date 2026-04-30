// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ToggleButtons from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ToggleButtons test executing');

  // Test basic ToggleButtons
  final toggleBasic = ToggleButtons(
    isSelected: [true, false, false],
    onPressed: (index) {
      print('Toggled index: $index');
    },
    children: [
      Icon(Icons.format_bold),
      Icon(Icons.format_italic),
      Icon(Icons.format_underline),
    ],
  );
  print('ToggleButtons basic created');

  // Test ToggleButtons with multiple selected
  final toggleMulti = ToggleButtons(
    isSelected: [true, true, false, false],
    onPressed: (index) {
      print('Multi toggled: $index');
    },
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Text('A'),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Text('B'),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Text('C'),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Text('D'),
      ),
    ],
  );
  print('ToggleButtons with multiple selected created');

  // Test ToggleButtons with color and selectedColor
  final toggleColored = ToggleButtons(
    isSelected: [false, true, false],
    color: Colors.grey,
    selectedColor: Colors.blue,
    onPressed: (index) {
      print('Colored toggle: $index');
    },
    children: [
      Icon(Icons.format_align_left),
      Icon(Icons.format_align_center),
      Icon(Icons.format_align_right),
    ],
  );
  print('ToggleButtons with color and selectedColor created');

  // Test ToggleButtons with fillColor
  final toggleFilled = ToggleButtons(
    isSelected: [true, false, false],
    fillColor: Colors.blue,
    selectedColor: Colors.white,
    color: Colors.blue,
    onPressed: (index) {
      print('Filled toggle: $index');
    },
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text('Option 1'),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text('Option 2'),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text('Option 3'),
      ),
    ],
  );
  print('ToggleButtons with fillColor created');

  // Test ToggleButtons with borderColor and selectedBorderColor
  final toggleBordered = ToggleButtons(
    isSelected: [false, true, false],
    borderColor: Colors.grey,
    selectedBorderColor: Colors.red,
    borderWidth: 2.0,
    onPressed: (index) {
      print('Bordered toggle: $index');
    },
    children: [
      Padding(padding: EdgeInsets.all(8.0), child: Icon(Icons.star_border)),
      Padding(padding: EdgeInsets.all(8.0), child: Icon(Icons.star_half)),
      Padding(padding: EdgeInsets.all(8.0), child: Icon(Icons.star)),
    ],
  );
  print('ToggleButtons with borderColor and borderWidth created');

  // Test ToggleButtons with borderRadius
  final toggleRounded = ToggleButtons(
    isSelected: [true, false, false],
    borderRadius: BorderRadius.circular(12.0),
    onPressed: (index) {
      print('Rounded toggle: $index');
    },
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text('Round 1'),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text('Round 2'),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text('Round 3'),
      ),
    ],
  );
  print('ToggleButtons with borderRadius=12 created');

  // Test ToggleButtons with splashColor and highlightColor
  final toggleSplash = ToggleButtons(
    isSelected: [false, false, true],
    splashColor: Colors.purple,
    highlightColor: Colors.purple,
    onPressed: (index) {
      print('Splash toggle: $index');
    },
    children: [
      Padding(padding: EdgeInsets.all(8.0), child: Icon(Icons.looks_one)),
      Padding(padding: EdgeInsets.all(8.0), child: Icon(Icons.looks_two)),
      Padding(padding: EdgeInsets.all(8.0), child: Icon(Icons.looks_3)),
    ],
  );
  print('ToggleButtons with splashColor created');

  // Test ToggleButtons disabled (no onPressed)
  final toggleDisabled = ToggleButtons(
    isSelected: [true, false, false],
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Text('Disabled 1'),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Text('Disabled 2'),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Text('Disabled 3'),
      ),
    ],
  );
  print('ToggleButtons disabled (no onPressed) created');

  // Test ToggleButtons with disabledColor and disabledBorderColor
  final toggleDisabledColors = ToggleButtons(
    isSelected: [false, true, false],
    disabledColor: Colors.grey,
    disabledBorderColor: Colors.grey,
    children: [
      Padding(padding: EdgeInsets.all(8.0), child: Text('Dis A')),
      Padding(padding: EdgeInsets.all(8.0), child: Text('Dis B')),
      Padding(padding: EdgeInsets.all(8.0), child: Text('Dis C')),
    ],
  );
  print('ToggleButtons with disabledColor created');

  // Test ToggleButtons with constraints
  final toggleConstrained = ToggleButtons(
    isSelected: [true, false],
    constraints: BoxConstraints(minWidth: 100.0, minHeight: 50.0),
    onPressed: (index) {
      print('Constrained toggle: $index');
    },
    children: [Text('Wide A'), Text('Wide B')],
  );
  print('ToggleButtons with constraints created');

  // Test ToggleButtons with all properties
  final toggleFull = ToggleButtons(
    isSelected: [false, true, false],
    color: Colors.teal,
    selectedColor: Colors.white,
    fillColor: Colors.teal,
    borderColor: Colors.teal,
    selectedBorderColor: Colors.teal,
    borderRadius: BorderRadius.circular(8.0),
    borderWidth: 2.0,
    onPressed: (index) {
      print('Full toggle: $index');
    },
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: [Icon(Icons.wb_sunny), SizedBox(width: 4.0), Text('Day')],
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: [
            Icon(Icons.nights_stay),
            SizedBox(width: 4.0),
            Text('Night'),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: [
            Icon(Icons.auto_awesome),
            SizedBox(width: 4.0),
            Text('Auto'),
          ],
        ),
      ),
    ],
  );
  print('ToggleButtons with all properties created');

  print('All ToggleButtons tests completed');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '=== ToggleButtons Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Basic:', style: TextStyle(fontWeight: FontWeight.bold)),
        toggleBasic,
        SizedBox(height: 12.0),
        Text(
          'Multiple selected:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        toggleMulti,
        SizedBox(height: 12.0),
        Text(
          'Color + selectedColor:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        toggleColored,
        SizedBox(height: 12.0),
        Text('Fill color:', style: TextStyle(fontWeight: FontWeight.bold)),
        toggleFilled,
        SizedBox(height: 12.0),
        Text(
          'Border color + width:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        toggleBordered,
        SizedBox(height: 12.0),
        Text('Border radius:', style: TextStyle(fontWeight: FontWeight.bold)),
        toggleRounded,
        SizedBox(height: 12.0),
        Text('Splash color:', style: TextStyle(fontWeight: FontWeight.bold)),
        toggleSplash,
        SizedBox(height: 12.0),
        Text('Disabled:', style: TextStyle(fontWeight: FontWeight.bold)),
        toggleDisabled,
        SizedBox(height: 12.0),
        Text('Disabled colors:', style: TextStyle(fontWeight: FontWeight.bold)),
        toggleDisabledColors,
        SizedBox(height: 12.0),
        Text('Constrained:', style: TextStyle(fontWeight: FontWeight.bold)),
        toggleConstrained,
        SizedBox(height: 12.0),
        Text('All properties:', style: TextStyle(fontWeight: FontWeight.bold)),
        toggleFull,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• ToggleButtons creates a row of toggleable buttons'),
        Text('• isSelected list tracks selected state per button'),
        Text('• onPressed receives the index of the pressed button'),
        Text('• color/selectedColor control icon and text color'),
        Text('• fillColor sets background of selected buttons'),
        Text('• borderColor, selectedBorderColor, borderWidth style borders'),
        Text('• borderRadius rounds button corners'),
      ],
    ),
  );
}
