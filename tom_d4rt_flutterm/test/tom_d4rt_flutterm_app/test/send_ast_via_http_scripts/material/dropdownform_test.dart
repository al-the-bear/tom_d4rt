// ignore_for_file: avoid_print
// D4rt test script: Tests DropdownButtonFormField and ButtonSegment from Flutter material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DropdownButtonFormField/ButtonSegment test executing');

  // ========== DROPDOWNBUTTONFORMFIELD ==========
  print('--- DropdownButtonFormField Tests ---');

  // Variation 1: Basic DropdownButtonFormField
  final widget1 = Material(
    child: Form(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: DropdownButtonFormField<String>(
          value: 'One',
          items: [
            DropdownMenuItem(value: 'One', child: Text('One')),
            DropdownMenuItem(value: 'Two', child: Text('Two')),
            DropdownMenuItem(value: 'Three', child: Text('Three')),
          ],
          onChanged: (String? value) {
            print('Selected: $value');
          },
        ),
      ),
    ),
  );
  print('DropdownButtonFormField(basic) created');

  // Variation 2: DropdownButtonFormField with decoration
  final widget2 = Material(
    child: Form(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: DropdownButtonFormField<String>(
          value: 'A',
          decoration: InputDecoration(
            labelText: 'Select Option',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.category),
          ),
          items: [
            DropdownMenuItem(value: 'A', child: Text('Option A')),
            DropdownMenuItem(value: 'B', child: Text('Option B')),
            DropdownMenuItem(value: 'C', child: Text('Option C')),
          ],
          onChanged: (value) {},
        ),
      ),
    ),
  );
  print('DropdownButtonFormField(decoration: InputDecoration) created');

  // Variation 3: DropdownButtonFormField with hint
  final widget3 = Material(
    child: Form(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: DropdownButtonFormField<int>(
          hint: Text('Choose a number'),
          decoration: InputDecoration(
            labelText: 'Number',
            helperText: 'Pick your favorite',
          ),
          items: [
            DropdownMenuItem(value: 1, child: Text('1')),
            DropdownMenuItem(value: 2, child: Text('2')),
            DropdownMenuItem(value: 3, child: Text('3')),
          ],
          onChanged: (value) {},
        ),
      ),
    ),
  );
  print('DropdownButtonFormField(hint, helperText) created');

  // Variation 4: DropdownButtonFormField with validator
  final widget4 = Material(
    child: Form(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: DropdownButtonFormField<String>(
          value: null,
          decoration: InputDecoration(
            labelText: 'Required Field',
            border: OutlineInputBorder(),
          ),
          items: [
            DropdownMenuItem(value: 'x', child: Text('X')),
            DropdownMenuItem(value: 'y', child: Text('Y')),
          ],
          validator: (String? value) {
            if (value == null) return 'Please select a value';
            return null;
          },
          onChanged: (value) {},
        ),
      ),
    ),
  );
  print('DropdownButtonFormField(validator) created');

  // Variation 5: DropdownButtonFormField with onSaved
  final widget5 = Material(
    child: Form(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: DropdownButtonFormField<String>(
          value: 'saved',
          decoration: InputDecoration(labelText: 'Save on Submit'),
          items: [
            DropdownMenuItem(value: 'saved', child: Text('Saved')),
            DropdownMenuItem(value: 'draft', child: Text('Draft')),
          ],
          onSaved: (String? value) {
            print('Saved: $value');
          },
          onChanged: (value) {},
        ),
      ),
    ),
  );
  print('DropdownButtonFormField(onSaved) created');

  // Variation 6: DropdownButtonFormField with isExpanded and icon
  final widget6 = Material(
    child: Form(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: DropdownButtonFormField<String>(
          value: 'wide',
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down_circle),
          iconSize: 28.0,
          iconEnabledColor: Colors.blue,
          decoration: InputDecoration(
            labelText: 'Expanded',
            border: OutlineInputBorder(),
          ),
          items: [
            DropdownMenuItem(value: 'wide', child: Text('Wide option')),
            DropdownMenuItem(value: 'narrow', child: Text('Narrow option')),
          ],
          onChanged: (value) {},
        ),
      ),
    ),
  );
  print('DropdownButtonFormField(isExpanded, icon, iconSize) created');

  // Variation 7: DropdownButtonFormField with style and alignment
  final widget7 = Material(
    child: Form(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: DropdownButtonFormField<String>(
          value: 'styled',
          style: TextStyle(color: Colors.purple, fontSize: 16),
          alignment: AlignmentDirectional.center,
          decoration: InputDecoration(
            labelText: 'Styled Dropdown',
            filled: true,
            fillColor: Colors.purple.shade50,
          ),
          items: [
            DropdownMenuItem(value: 'styled', child: Text('Styled')),
            DropdownMenuItem(value: 'plain', child: Text('Plain')),
          ],
          onChanged: (value) {},
        ),
      ),
    ),
  );
  print('DropdownButtonFormField(style, alignment, filled) created');

  // Variation 8: DropdownButtonFormField disabled
  final widget8 = Material(
    child: Form(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: DropdownButtonFormField<String>(
          value: 'locked',
          decoration: InputDecoration(
            labelText: 'Disabled Dropdown',
            enabled: false,
          ),
          items: [DropdownMenuItem(value: 'locked', child: Text('Locked'))],
          onChanged: null,
        ),
      ),
    ),
  );
  print('DropdownButtonFormField(disabled) created');

  // ========== BUTTONSEGMENT ==========
  print('--- ButtonSegment Tests ---');

  // Variation 9: SegmentedButton with ButtonSegment entries
  final widget9 = SegmentedButton<String>(
    segments: [
      ButtonSegment<String>(
        value: 'day',
        label: Text('Day'),
        icon: Icon(Icons.calendar_today),
      ),
      ButtonSegment<String>(
        value: 'week',
        label: Text('Week'),
        icon: Icon(Icons.calendar_view_week),
      ),
      ButtonSegment<String>(
        value: 'month',
        label: Text('Month'),
        icon: Icon(Icons.calendar_month),
      ),
    ],
    selected: {'day'},
    onSelectionChanged: (Set<String> selected) {
      print('ButtonSegment selected: $selected');
    },
  );
  print('ButtonSegment(3 entries with icon and label) created');

  // Variation 10: ButtonSegment with tooltip
  final widget10 = SegmentedButton<int>(
    segments: [
      ButtonSegment<int>(value: 1, label: Text('S'), tooltip: 'Small'),
      ButtonSegment<int>(value: 2, label: Text('M'), tooltip: 'Medium'),
      ButtonSegment<int>(value: 3, label: Text('L'), tooltip: 'Large'),
    ],
    selected: {2},
    onSelectionChanged: (selected) {},
  );
  print('ButtonSegment(with tooltip) created');

  // Variation 11: ButtonSegment with enabled false
  final widget11 = SegmentedButton<String>(
    segments: [
      ButtonSegment<String>(value: 'on', label: Text('On')),
      ButtonSegment<String>(value: 'off', label: Text('Off'), enabled: false),
    ],
    selected: {'on'},
    onSelectionChanged: (selected) {},
  );
  print('ButtonSegment(enabled: false) created');

  // Variation 12: ButtonSegment icon-only
  final widget12 = SegmentedButton<String>(
    segments: [
      ButtonSegment<String>(value: 'list', icon: Icon(Icons.list)),
      ButtonSegment<String>(value: 'grid', icon: Icon(Icons.grid_view)),
      ButtonSegment<String>(value: 'table', icon: Icon(Icons.table_chart)),
    ],
    selected: {'grid'},
    onSelectionChanged: (selected) {},
  );
  print('ButtonSegment(icon-only, no label) created');

  print('DropdownButtonFormField/ButtonSegment test completed');
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        widget1,
        widget2,
        widget3,
        widget4,
        widget5,
        widget6,
        widget7,
        widget8,
        SizedBox(height: 16),
        Padding(padding: EdgeInsets.all(16.0), child: widget9),
        Padding(padding: EdgeInsets.all(16.0), child: widget10),
        Padding(padding: EdgeInsets.all(16.0), child: widget11),
        Padding(padding: EdgeInsets.all(16.0), child: widget12),
      ],
    ),
  );
}
