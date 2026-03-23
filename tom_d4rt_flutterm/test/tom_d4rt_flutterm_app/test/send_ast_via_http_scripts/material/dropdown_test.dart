// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DropdownButton, DropdownMenu, PopupMenuButton from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Dropdown/Popup Menu test executing');

  // ========== DROPDOWNBUTTON ==========
  print('--- DropdownButton Tests ---');

  // Test basic DropdownButton
  final basicDropdown = DropdownButton<String>(
    value: 'One',
    items: [
      DropdownMenuItem(value: 'One', child: Text('One')),
      DropdownMenuItem(value: 'Two', child: Text('Two')),
      DropdownMenuItem(value: 'Three', child: Text('Three')),
    ],
    onChanged: (String? value) {
      print('Selected: $value');
    },
  );
  print('Basic DropdownButton created');

  // Test DropdownButton with hint
  final hintDropdown = DropdownButton<String>(
    hint: Text('Select an option'),
    items: [
      DropdownMenuItem(value: 'A', child: Text('Option A')),
      DropdownMenuItem(value: 'B', child: Text('Option B')),
    ],
    onChanged: (value) {},
  );
  print('DropdownButton with hint created');

  // Test DropdownButton with disabledHint
  final disabledHintDropdown = DropdownButton<String>(
    value: null,
    disabledHint: Text('Disabled'),
    items: [DropdownMenuItem(value: 'X', child: Text('X'))],
    onChanged: null,
  );
  print('DropdownButton with disabledHint created');

  // Test DropdownButton with icon
  final iconDropdown = DropdownButton<int>(
    value: 1,
    icon: Icon(Icons.arrow_drop_down_circle),
    iconSize: 30.0,
    iconEnabledColor: Colors.blue,
    iconDisabledColor: Colors.grey,
    items: [
      DropdownMenuItem(value: 1, child: Text('First')),
      DropdownMenuItem(value: 2, child: Text('Second')),
    ],
    onChanged: (value) {},
  );
  print('DropdownButton with custom icon created');

  // Test DropdownButton with style
  final styledDropdown = DropdownButton<String>(
    value: 'Styled',
    style: TextStyle(color: Colors.purple, fontSize: 16.0),
    items: [DropdownMenuItem(value: 'Styled', child: Text('Styled'))],
    onChanged: (value) {},
  );
  print('DropdownButton with style created');

  // Test DropdownButton isExpanded
  final expandedDropdown = DropdownButton<String>(
    value: 'Expanded',
    isExpanded: true,
    items: [
      DropdownMenuItem(value: 'Expanded', child: Text('Expanded dropdown')),
    ],
    onChanged: (value) {},
  );
  print('DropdownButton isExpanded created');

  // Test DropdownButton with underline
  final underlineDropdown = DropdownButton<String>(
    value: 'Custom',
    underline: Container(height: 2, color: Colors.deepPurpleAccent),
    items: [DropdownMenuItem(value: 'Custom', child: Text('Custom underline'))],
    onChanged: (value) {},
  );
  print('DropdownButton with underline created');

  // Test DropdownButton with elevation
  final elevatedDropdown = DropdownButton<String>(
    value: 'Elevated',
    elevation: 16,
    items: [DropdownMenuItem(value: 'Elevated', child: Text('Elevated menu'))],
    onChanged: (value) {},
  );
  print('DropdownButton with elevation created');

  // Test DropdownButton with dropdownColor
  final coloredDropdown = DropdownButton<String>(
    value: 'Colored',
    dropdownColor: Colors.lightBlue.shade100,
    items: [DropdownMenuItem(value: 'Colored', child: Text('Colored menu'))],
    onChanged: (value) {},
  );
  print('DropdownButton with dropdownColor created');

  // Test DropdownButton with focusColor
  final focusDropdown = DropdownButton<String>(
    value: 'Focus',
    focusColor: Colors.green.shade100,
    items: [DropdownMenuItem(value: 'Focus', child: Text('Focus color'))],
    onChanged: (value) {},
  );
  print('DropdownButton with focusColor created');

  // Test DropdownButtonFormField
  final formFieldDropdown = DropdownButtonFormField<String>(
    value: 'Form',
    decoration: InputDecoration(
      labelText: 'Select option',
      border: OutlineInputBorder(),
    ),
    items: [
      DropdownMenuItem(value: 'Form', child: Text('Form Field')),
      DropdownMenuItem(value: 'Option2', child: Text('Option 2')),
    ],
    onChanged: (value) {},
  );
  print('DropdownButtonFormField created');

  // ========== DROPDOWNMENU ==========
  print('--- DropdownMenu Tests ---');

  // Test basic DropdownMenu
  final basicDropdownMenu = DropdownMenu<String>(
    initialSelection: 'option1',
    dropdownMenuEntries: [
      DropdownMenuEntry(value: 'option1', label: 'Option 1'),
      DropdownMenuEntry(value: 'option2', label: 'Option 2'),
      DropdownMenuEntry(value: 'option3', label: 'Option 3'),
    ],
    onSelected: (String? value) {
      print('DropdownMenu selected: $value');
    },
  );
  print('Basic DropdownMenu created');

  // Test DropdownMenu with label
  final labeledMenu = DropdownMenu<String>(
    label: Text('Choose option'),
    initialSelection: 'a',
    dropdownMenuEntries: [
      DropdownMenuEntry(value: 'a', label: 'A'),
      DropdownMenuEntry(value: 'b', label: 'B'),
    ],
    onSelected: (value) {},
  );
  print('DropdownMenu with label created');

  // Test DropdownMenu with leadingIcon
  final iconMenu = DropdownMenu<String>(
    leadingIcon: Icon(Icons.search),
    initialSelection: 'search',
    dropdownMenuEntries: [DropdownMenuEntry(value: 'search', label: 'Search')],
    onSelected: (value) {},
  );
  print('DropdownMenu with leadingIcon created');

  // Test DropdownMenu enableFilter
  final filterMenu = DropdownMenu<String>(
    enableFilter: true,
    initialSelection: null,
    hintText: 'Type to search',
    dropdownMenuEntries: [
      DropdownMenuEntry(value: 'apple', label: 'Apple'),
      DropdownMenuEntry(value: 'banana', label: 'Banana'),
      DropdownMenuEntry(value: 'cherry', label: 'Cherry'),
    ],
    onSelected: (value) {},
  );
  print('DropdownMenu enableFilter created');

  // Test DropdownMenu with width
  final widthMenu = DropdownMenu<String>(
    width: 200.0,
    initialSelection: 'fixed',
    dropdownMenuEntries: [
      DropdownMenuEntry(value: 'fixed', label: 'Fixed Width'),
    ],
    onSelected: (value) {},
  );
  print('DropdownMenu with width created');

  // Test DropdownMenu with requestFocusOnTap
  final focusOnTapMenu = DropdownMenu<String>(
    requestFocusOnTap: true,
    initialSelection: 'focus',
    dropdownMenuEntries: [
      DropdownMenuEntry(value: 'focus', label: 'Focus on tap'),
    ],
    onSelected: (value) {},
  );
  print('DropdownMenu requestFocusOnTap created');

  // ========== POPUPMENUBUTTON ==========
  print('--- PopupMenuButton Tests ---');

  // Test basic PopupMenuButton
  final basicPopup = PopupMenuButton<String>(
    onSelected: (String value) {
      print('PopupMenu selected: $value');
    },
    itemBuilder: (BuildContext context) {
      return [
        PopupMenuItem(value: 'option1', child: Text('Option 1')),
        PopupMenuItem(value: 'option2', child: Text('Option 2')),
        PopupMenuItem(value: 'option3', child: Text('Option 3')),
      ];
    },
  );
  print('Basic PopupMenuButton created');

  // Test PopupMenuButton with icon
  final iconPopup = PopupMenuButton<int>(
    icon: Icon(Icons.more_vert),
    onSelected: (value) {},
    itemBuilder: (context) => [
      PopupMenuItem(value: 1, child: Text('Item 1')),
      PopupMenuItem(value: 2, child: Text('Item 2')),
    ],
  );
  print('PopupMenuButton with icon created');

  // Test PopupMenuButton with child
  final childPopup = PopupMenuButton<String>(
    child: Padding(padding: EdgeInsets.all(8.0), child: Text('Click Me')),
    onSelected: (value) {},
    itemBuilder: (context) => [
      PopupMenuItem(value: 'clicked', child: Text('Clicked!')),
    ],
  );
  print('PopupMenuButton with child created');

  // Test PopupMenuButton with enabled
  final disabledPopup = PopupMenuButton<String>(
    enabled: false,
    itemBuilder: (context) => [
      PopupMenuItem(value: 'none', child: Text('None')),
    ],
  );
  print('Disabled PopupMenuButton created');

  // Test PopupMenuButton with initialValue
  final initialValuePopup = PopupMenuButton<String>(
    initialValue: 'selected',
    onSelected: (value) {},
    itemBuilder: (context) => [
      PopupMenuItem(value: 'selected', child: Text('Selected')),
      PopupMenuItem(value: 'other', child: Text('Other')),
    ],
  );
  print('PopupMenuButton with initialValue created');

  // Test PopupMenuButton with offset
  final offsetPopup = PopupMenuButton<String>(
    offset: Offset(0, 50),
    onSelected: (value) {},
    itemBuilder: (context) => [
      PopupMenuItem(value: 'offset', child: Text('Offset menu')),
    ],
  );
  print('PopupMenuButton with offset created');

  // Test PopupMenuButton with color
  final coloredPopup = PopupMenuButton<String>(
    color: Colors.amber.shade100,
    onSelected: (value) {},
    itemBuilder: (context) => [
      PopupMenuItem(value: 'colored', child: Text('Colored menu')),
    ],
  );
  print('PopupMenuButton with color created');

  // Test PopupMenuButton with elevation
  final elevatedPopup = PopupMenuButton<String>(
    elevation: 8.0,
    onSelected: (value) {},
    itemBuilder: (context) => [
      PopupMenuItem(value: 'elevated', child: Text('Elevated')),
    ],
  );
  print('PopupMenuButton with elevation created');

  // Test PopupMenuButton with dividers
  final dividerPopup = PopupMenuButton<String>(
    onSelected: (value) {},
    itemBuilder: (context) => [
      PopupMenuItem(value: 'item1', child: Text('Item 1')),
      PopupMenuDivider(),
      PopupMenuItem(value: 'item2', child: Text('Item 2')),
    ],
  );
  print('PopupMenuButton with divider created');

  // Test CheckedPopupMenuItem
  final checkedPopup = PopupMenuButton<String>(
    onSelected: (value) {},
    itemBuilder: (context) => [
      CheckedPopupMenuItem(
        value: 'checked',
        checked: true,
        child: Text('Checked item'),
      ),
      CheckedPopupMenuItem(
        value: 'unchecked',
        checked: false,
        child: Text('Unchecked item'),
      ),
    ],
  );
  print('PopupMenuButton with CheckedPopupMenuItem created');

  // Test PopupMenuButton with shape
  final shapedPopup = PopupMenuButton<String>(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    onSelected: (value) {},
    itemBuilder: (context) => [
      PopupMenuItem(value: 'shaped', child: Text('Rounded menu')),
    ],
  );
  print('PopupMenuButton with shape created');

  print('Dropdown/Popup Menu test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dropdown & Popup Menu Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text('DropdownButton:', style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            basicDropdown,
            SizedBox(width: 8),
            hintDropdown,
            SizedBox(width: 8),
            iconDropdown,
          ],
        ),
        SizedBox(height: 8.0),
        SizedBox(width: double.infinity, child: expandedDropdown),
        SizedBox(height: 8.0),
        formFieldDropdown,

        SizedBox(height: 24.0),
        Text('DropdownMenu:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        basicDropdownMenu,
        SizedBox(height: 8.0),
        labeledMenu,
        SizedBox(height: 8.0),
        filterMenu,

        SizedBox(height: 24.0),
        Text('PopupMenuButton:', style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            basicPopup,
            iconPopup,
            childPopup,
            disabledPopup,
            checkedPopup,
          ],
        ),
      ],
    ),
  );
}
