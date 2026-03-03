// D4rt test script: Tests MenuBar, CheckboxMenuButton, RadioMenuButton from Flutter material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MenuBar/CheckboxMenuButton/RadioMenuButton test executing');

  // ========== MENUBAR ==========
  print('--- MenuBar Tests ---');

  // Variation 1: Basic MenuBar with SubmenuButton children
  final widget1 = MenuBar(
    children: [
      SubmenuButton(
        menuChildren: [
          MenuItemButton(
            onPressed: () {
              print('New pressed');
            },
            child: Text('New'),
          ),
          MenuItemButton(
            onPressed: () {
              print('Open pressed');
            },
            child: Text('Open'),
          ),
          MenuItemButton(
            onPressed: () {
              print('Save pressed');
            },
            child: Text('Save'),
          ),
        ],
        child: Text('File'),
      ),
      SubmenuButton(
        menuChildren: [
          MenuItemButton(onPressed: () {}, child: Text('Undo')),
          MenuItemButton(onPressed: () {}, child: Text('Redo')),
        ],
        child: Text('Edit'),
      ),
    ],
  );
  print('MenuBar(basic with File and Edit menus) created');

  // Variation 2: MenuBar with style
  final widget2 = MenuBar(
    style: MenuStyle(
      backgroundColor: WidgetStatePropertyAll(Colors.blue.shade50),
      elevation: WidgetStatePropertyAll(4.0),
    ),
    children: [
      SubmenuButton(
        menuChildren: [
          MenuItemButton(onPressed: () {}, child: Text('Option 1')),
        ],
        child: Text('Styled Menu'),
      ),
    ],
  );
  print('MenuBar(with MenuStyle) created');

  // ========== CHECKBOXMENUBUTTON ==========
  print('--- CheckboxMenuButton Tests ---');

  // Variation 3: CheckboxMenuButton checked
  final widget3 = CheckboxMenuButton(
    value: true,
    onChanged: (bool? value) {
      print('Checkbox changed: $value');
    },
    child: Text('Show Toolbar'),
  );
  print('CheckboxMenuButton(value: true) created');

  // Variation 4: CheckboxMenuButton unchecked
  final widget4 = CheckboxMenuButton(
    value: false,
    onChanged: (bool? value) {
      print('Checkbox changed: $value');
    },
    child: Text('Show Status Bar'),
  );
  print('CheckboxMenuButton(value: false) created');

  // Variation 5: CheckboxMenuButton tristate
  final widget5 = CheckboxMenuButton(
    value: null,
    tristate: true,
    onChanged: (bool? value) {
      print('Tristate changed: $value');
    },
    child: Text('Select All'),
  );
  print('CheckboxMenuButton(tristate, value: null) created');

  // Variation 6: CheckboxMenuButton disabled
  final widget6 = CheckboxMenuButton(
    value: true,
    onChanged: null,
    child: Text('Disabled Check'),
  );
  print('CheckboxMenuButton(disabled, onChanged: null) created');

  // ========== RADIOMENUBUTTON ==========
  print('--- RadioMenuButton Tests ---');

  // Variation 7: RadioMenuButton selected
  final widget7 = RadioMenuButton<String>(
    value: 'small',
    groupValue: 'small',
    onChanged: (String? value) {
      print('Radio changed: $value');
    },
    child: Text('Small'),
  );
  print('RadioMenuButton(selected, value matches groupValue) created');

  // Variation 8: RadioMenuButton unselected
  final widget8 = RadioMenuButton<String>(
    value: 'medium',
    groupValue: 'small',
    onChanged: (String? value) {
      print('Radio changed: $value');
    },
    child: Text('Medium'),
  );
  print('RadioMenuButton(unselected) created');

  // Variation 9: RadioMenuButton disabled
  final widget9 = RadioMenuButton<String>(
    value: 'large',
    groupValue: 'small',
    onChanged: null,
    child: Text('Large (disabled)'),
  );
  print('RadioMenuButton(disabled) created');

  // Variation 10: MenuBar with CheckboxMenuButton and RadioMenuButton
  final widget10 = MenuBar(
    children: [
      SubmenuButton(
        menuChildren: [
          CheckboxMenuButton(
            value: true,
            onChanged: (bool? v) {},
            child: Text('Word Wrap'),
          ),
          CheckboxMenuButton(
            value: false,
            onChanged: (bool? v) {},
            child: Text('Line Numbers'),
          ),
        ],
        child: Text('View'),
      ),
      SubmenuButton(
        menuChildren: [
          RadioMenuButton<int>(
            value: 12,
            groupValue: 14,
            onChanged: (int? v) {},
            child: Text('12pt'),
          ),
          RadioMenuButton<int>(
            value: 14,
            groupValue: 14,
            onChanged: (int? v) {},
            child: Text('14pt'),
          ),
          RadioMenuButton<int>(
            value: 16,
            groupValue: 14,
            onChanged: (int? v) {},
            child: Text('16pt'),
          ),
        ],
        child: Text('Font Size'),
      ),
    ],
  );
  print('MenuBar(with CheckboxMenuButton and RadioMenuButton) created');

  print('MenuBar/CheckboxMenuButton/RadioMenuButton test completed');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      widget1,
      SizedBox(height: 8),
      widget2,
      SizedBox(height: 8),
      widget3,
      widget4,
      widget5,
      widget6,
      SizedBox(height: 8),
      widget7,
      widget8,
      widget9,
      SizedBox(height: 8),
      widget10,
    ],
  );
}
