// ignore_for_file: avoid_print
// D4rt test script: Tests SegmentedButton from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SegmentedButton test executing');

  // Test basic SegmentedButton with single selection
  final segBasic = SegmentedButton<String>(
    segments: [
      ButtonSegment(value: 'day', label: Text('Day')),
      ButtonSegment(value: 'week', label: Text('Week')),
      ButtonSegment(value: 'month', label: Text('Month')),
    ],
    selected: {'day'},
    onSelectionChanged: (value) {
      print('Selected: $value');
    },
  );
  print('SegmentedButton basic single selection created');

  // Test SegmentedButton with icons
  final segIcons = SegmentedButton<String>(
    segments: [
      ButtonSegment(value: 'list', label: Text('List'), icon: Icon(Icons.list)),
      ButtonSegment(
        value: 'grid',
        label: Text('Grid'),
        icon: Icon(Icons.grid_view),
      ),
      ButtonSegment(
        value: 'table',
        label: Text('Table'),
        icon: Icon(Icons.table_chart),
      ),
    ],
    selected: {'grid'},
    onSelectionChanged: (value) {
      print('View: $value');
    },
  );
  print('SegmentedButton with icons created');

  // Test SegmentedButton with multiSelectionEnabled
  final segMulti = SegmentedButton<String>(
    segments: [
      ButtonSegment(value: 'bold', label: Text('B')),
      ButtonSegment(value: 'italic', label: Text('I')),
      ButtonSegment(value: 'underline', label: Text('U')),
      ButtonSegment(value: 'strike', label: Text('S')),
    ],
    selected: {'bold', 'italic'},
    multiSelectionEnabled: true,
    onSelectionChanged: (value) {
      print('Format: $value');
    },
  );
  print('SegmentedButton multiSelectionEnabled created');

  // Test SegmentedButton with showSelectedIcon=false
  final segNoIcon = SegmentedButton<String>(
    segments: [
      ButtonSegment(value: 'small', label: Text('S')),
      ButtonSegment(value: 'medium', label: Text('M')),
      ButtonSegment(value: 'large', label: Text('L')),
    ],
    selected: {'medium'},
    showSelectedIcon: false,
    onSelectionChanged: (value) {
      print('Size: $value');
    },
  );
  print('SegmentedButton showSelectedIcon=false created');

  // Test SegmentedButton with showSelectedIcon=true (default)
  final segShowIcon = SegmentedButton<String>(
    segments: [
      ButtonSegment(value: 'on', label: Text('On')),
      ButtonSegment(value: 'off', label: Text('Off')),
    ],
    selected: {'on'},
    showSelectedIcon: true,
    onSelectionChanged: (value) {
      print('Toggle: $value');
    },
  );
  print('SegmentedButton showSelectedIcon=true created');

  // Test SegmentedButton with two segments
  final segTwo = SegmentedButton<int>(
    segments: [
      ButtonSegment(value: 0, label: Text('Left')),
      ButtonSegment(value: 1, label: Text('Right')),
    ],
    selected: {0},
    onSelectionChanged: (value) {
      print('Side: $value');
    },
  );
  print('SegmentedButton with two segments created');

  // Test SegmentedButton with disabled segment
  final segDisabled = SegmentedButton<String>(
    segments: [
      ButtonSegment(value: 'a', label: Text('A')),
      ButtonSegment(value: 'b', label: Text('B'), enabled: false),
      ButtonSegment(value: 'c', label: Text('C')),
    ],
    selected: {'a'},
    onSelectionChanged: (value) {
      print('Selected: $value');
    },
  );
  print('SegmentedButton with disabled segment created');

  // Test SegmentedButton multi with empty selection
  final segMultiEmpty = SegmentedButton<String>(
    segments: [
      ButtonSegment(value: 'x', label: Text('X')),
      ButtonSegment(value: 'y', label: Text('Y')),
      ButtonSegment(value: 'z', label: Text('Z')),
    ],
    selected: {},
    multiSelectionEnabled: true,
    emptySelectionAllowed: true,
    onSelectionChanged: (value) {
      print('Empty selection: $value');
    },
  );
  print('SegmentedButton multi with empty selection created');

  // Test SegmentedButton with style
  final segStyled = SegmentedButton<String>(
    segments: [
      ButtonSegment(value: 'red', label: Text('Red')),
      ButtonSegment(value: 'green', label: Text('Green')),
      ButtonSegment(value: 'blue', label: Text('Blue')),
    ],
    selected: {'green'},
    onSelectionChanged: (value) {
      print('Color: $value');
    },
    style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.grey)),
  );
  print('SegmentedButton with style created');

  // Test SegmentedButton with icon-only segments
  final segIconOnly = SegmentedButton<String>(
    segments: [
      ButtonSegment(value: 'align_left', icon: Icon(Icons.format_align_left)),
      ButtonSegment(
        value: 'align_center',
        icon: Icon(Icons.format_align_center),
      ),
      ButtonSegment(value: 'align_right', icon: Icon(Icons.format_align_right)),
      ButtonSegment(
        value: 'align_justify',
        icon: Icon(Icons.format_align_justify),
      ),
    ],
    selected: {'align_left'},
    showSelectedIcon: false,
    onSelectionChanged: (value) {
      print('Alignment: $value');
    },
  );
  print('SegmentedButton icon-only created');

  print('All SegmentedButton tests completed');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '=== SegmentedButton Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text(
          'Basic single selection:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        segBasic,
        SizedBox(height: 12.0),
        Text('With icons:', style: TextStyle(fontWeight: FontWeight.bold)),
        segIcons,
        SizedBox(height: 12.0),
        Text('Multi selection:', style: TextStyle(fontWeight: FontWeight.bold)),
        segMulti,
        SizedBox(height: 12.0),
        Text(
          'No selected icon:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        segNoIcon,
        SizedBox(height: 12.0),
        Text(
          'Show selected icon:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        segShowIcon,
        SizedBox(height: 12.0),
        Text('Two segments:', style: TextStyle(fontWeight: FontWeight.bold)),
        segTwo,
        SizedBox(height: 12.0),
        Text(
          'Disabled segment:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        segDisabled,
        SizedBox(height: 12.0),
        Text(
          'Multi empty selection:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        segMultiEmpty,
        SizedBox(height: 12.0),
        Text('Styled:', style: TextStyle(fontWeight: FontWeight.bold)),
        segStyled,
        SizedBox(height: 12.0),
        Text(
          'Icon-only segments:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        segIconOnly,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• SegmentedButton provides segmented toggle control'),
        Text('• segments list defines ButtonSegment items'),
        Text('• selected is a Set for single or multi selection'),
        Text('• multiSelectionEnabled allows multiple selections'),
        Text('• showSelectedIcon toggles check icon on selected'),
        Text('• emptySelectionAllowed allows deselecting all'),
      ],
    ),
  );
}
