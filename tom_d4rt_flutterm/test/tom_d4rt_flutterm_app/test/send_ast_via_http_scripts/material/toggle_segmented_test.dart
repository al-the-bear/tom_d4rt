// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ToggleButtons, SegmentedButton, ButtonSegment,
// ToggleButtonsThemeData, MaterialStateBorderSide, MaterialStateTextStyle, ButtonBar
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Toggle and Segmented button test executing');

  // ========== ToggleButtons ==========
  print('--- ToggleButtons Tests ---');
  final List<bool> isSelected = [true, false, false];

  final toggleButtons = ToggleButtons(
    isSelected: isSelected,
    onPressed: (index) => print('  Toggled index: $index'),
    children: [
      Icon(Icons.format_bold),
      Icon(Icons.format_italic),
      Icon(Icons.format_underline),
    ],
    color: Colors.grey,
    selectedColor: Colors.blue,
    fillColor: Colors.blue[100],
    focusColor: Colors.blue[200],
    hoverColor: Colors.blue[50],
    splashColor: Colors.blue[300],
    highlightColor: Colors.blue[400],
    disabledColor: Colors.grey[400],
    disabledBorderColor: Colors.grey[300],
    borderColor: Colors.grey,
    selectedBorderColor: Colors.blue,
    borderWidth: 2.0,
    borderRadius: BorderRadius.circular(8),
    constraints: BoxConstraints(minWidth: 48, minHeight: 48),
    renderBorder: true,
    direction: Axis.horizontal,
    verticalDirection: VerticalDirection.down,
  );
  print('ToggleButtons created');

  // ========== ToggleButtonsThemeData ==========
  print('--- ToggleButtonsThemeData Tests ---');
  final toggleTheme = ToggleButtonsThemeData(
    color: Colors.grey,
    selectedColor: Colors.green,
    fillColor: Colors.green[100],
    focusColor: Colors.green[200],
    hoverColor: Colors.green[50],
    splashColor: Colors.green[300],
    highlightColor: Colors.green[400],
    disabledColor: Colors.grey[400],
    disabledBorderColor: Colors.grey[300],
    borderColor: Colors.grey,
    selectedBorderColor: Colors.green,
    borderWidth: 1.5,
    borderRadius: BorderRadius.circular(4),
    constraints: BoxConstraints(minWidth: 56, minHeight: 36),
  );
  print('ToggleButtonsThemeData created');
  print('  borderWidth: ${toggleTheme.borderWidth}');
  print('  borderRadius: ${toggleTheme.borderRadius}');

  // ========== SegmentedButton ==========
  print('--- SegmentedButton Tests ---');
  final Set<String> selection = {'opt1'};

  final segmentedButton = SegmentedButton<String>(
    segments: [
      ButtonSegment<String>(
        value: 'opt1',
        label: Text('Option 1'),
        icon: Icon(Icons.looks_one),
        tooltip: 'First option',
        enabled: true,
      ),
      ButtonSegment<String>(
        value: 'opt2',
        label: Text('Option 2'),
        icon: Icon(Icons.looks_two),
      ),
      ButtonSegment<String>(
        value: 'opt3',
        label: Text('Option 3'),
        icon: Icon(Icons.looks_3),
        enabled: false,
      ),
    ],
    selected: selection,
    onSelectionChanged: (Set<String> newSelection) {
      print('  Selection changed: $newSelection');
    },
    multiSelectionEnabled: false,
    emptySelectionAllowed: false,
    showSelectedIcon: true,
    selectedIcon: Icon(Icons.check),
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color?>(
        (states) =>
            states.contains(WidgetState.selected) ? Colors.blue[100] : null,
      ),
    ),
  );
  print('SegmentedButton created');

  // ========== ButtonSegment ==========
  print('--- ButtonSegment Tests ---');
  final segment = ButtonSegment<int>(
    value: 42,
    label: Text('Segment'),
    icon: Icon(Icons.star),
    tooltip: 'Star segment',
    enabled: true,
  );
  print('ButtonSegment created: value=${segment.value}');
  print('  enabled: ${segment.enabled}');
  print('  tooltip: ${segment.tooltip}');

  // ========== MaterialStateBorderSide ==========
  print('--- MaterialStateBorderSide Tests ---');
  final stateBorderSide = MaterialStateBorderSide.resolveWith((states) {
    if (states.contains(WidgetState.focused)) {
      return BorderSide(color: Colors.blue, width: 2.0);
    }
    return BorderSide(color: Colors.grey, width: 1.0);
  });
  print('MaterialStateBorderSide created');

  // ========== MaterialStateTextStyle ==========
  print('--- MaterialStateTextStyle Tests ---');
  final stateTextStyle = MaterialStateTextStyle.resolveWith((states) {
    if (states.contains(WidgetState.disabled)) {
      return TextStyle(color: Colors.grey);
    }
    return TextStyle(color: Colors.black);
  });
  print('MaterialStateTextStyle created');

  // ========== ButtonBar ==========
  print('--- ButtonBar Tests ---');
  final buttonBar = ButtonBar(
    alignment: MainAxisAlignment.end,
    mainAxisSize: MainAxisSize.max,
    buttonPadding: EdgeInsets.symmetric(horizontal: 8),
    buttonMinWidth: 64.0,
    buttonHeight: 36.0,
    overflowDirection: VerticalDirection.down,
    overflowButtonSpacing: 12.0,
    children: [
      TextButton(onPressed: () {}, child: Text('Cancel')),
      ElevatedButton(onPressed: () {}, child: Text('OK')),
    ],
  );
  print('ButtonBar created');

  print('All toggle/segmented tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            toggleButtons,
            SizedBox(height: 16),
            segmentedButton,
            SizedBox(height: 16),
            buttonBar,
          ],
        ),
      ),
    ),
  );
}
