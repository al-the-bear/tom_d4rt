// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Checkbox, Radio, Switch, Slider widgets from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Form Controls test executing');

  // ========== CHECKBOX ==========
  print('--- Checkbox Tests ---');

  // Test basic Checkbox
  final basicCheckbox = Checkbox(
    value: true,
    onChanged: (bool? value) {
      print('Checkbox changed to: $value');
    },
  );
  print('Basic Checkbox created');

  // Test Checkbox unchecked
  final uncheckedBox = Checkbox(value: false, onChanged: (value) {});
  print('Unchecked Checkbox created');

  // Test Checkbox tristate
  final tristateBox = Checkbox(
    value: null,
    tristate: true,
    onChanged: (value) {
      print('Tristate checkbox: $value');
    },
  );
  print('Tristate Checkbox created');

  // Test Checkbox with activeColor
  final coloredCheckbox = Checkbox(
    value: true,
    activeColor: Colors.purple,
    onChanged: (value) {},
  );
  print('Checkbox with activeColor created');

  // Test Checkbox with checkColor
  final checkColorBox = Checkbox(
    value: true,
    checkColor: Colors.yellow,
    activeColor: Colors.blue,
    onChanged: (value) {},
  );
  print('Checkbox with checkColor created');

  // Test Checkbox with shape
  final roundedCheckbox = Checkbox(
    value: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
    onChanged: (value) {},
  );
  print('Checkbox with rounded shape created');

  // Test CheckboxListTile
  final checkboxListTile = CheckboxListTile(
    title: Text('Checkbox List Tile'),
    subtitle: Text('With subtitle'),
    value: true,
    onChanged: (value) {},
  );
  print('CheckboxListTile created');

  // Test disabled Checkbox
  final disabledCheckbox = Checkbox(value: true, onChanged: null);
  print('Disabled Checkbox created');

  // ========== RADIO ==========
  print('--- Radio Tests ---');

  // Test basic Radio
  final radio1 = Radio<int>(
    value: 1,
    groupValue: 1,
    onChanged: (int? value) {
      print('Radio selected: $value');
    },
  );
  print('Basic Radio created');

  // Test Radio unselected
  final radio2 = Radio<int>(value: 2, groupValue: 1, onChanged: (value) {});
  print('Unselected Radio created');

  // Test Radio with activeColor
  final coloredRadio = Radio<int>(
    value: 1,
    groupValue: 1,
    activeColor: Colors.green,
    onChanged: (value) {},
  );
  print('Radio with activeColor created');

  // Test Radio with fillColor
  final fillColorRadio = Radio<int>(
    value: 1,
    groupValue: 1,
    fillColor: MaterialStateProperty.all(Colors.orange),
    onChanged: (value) {},
  );
  print('Radio with fillColor created');

  // Test RadioListTile
  final radioListTile = RadioListTile<int>(
    title: Text('Radio List Tile'),
    subtitle: Text('Option 1'),
    value: 1,
    groupValue: 1,
    onChanged: (value) {},
  );
  print('RadioListTile created');

  // Test disabled Radio
  final disabledRadio = Radio<int>(value: 1, groupValue: 1, onChanged: null);
  print('Disabled Radio created');

  // ========== SWITCH ==========
  print('--- Switch Tests ---');

  // Test basic Switch
  final basicSwitch = Switch(
    value: true,
    onChanged: (bool value) {
      print('Switch changed to: $value');
    },
  );
  print('Basic Switch created');

  // Test Switch off
  final offSwitch = Switch(value: false, onChanged: (value) {});
  print('Switch off created');

  // Test Switch with activeColor
  final coloredSwitch = Switch(
    value: true,
    activeColor: Colors.purple,
    onChanged: (value) {},
  );
  print('Switch with activeColor created');

  // Test Switch with activeTrackColor
  final trackColorSwitch = Switch(
    value: true,
    activeColor: Colors.green,
    activeTrackColor: Colors.green.shade200,
    inactiveThumbColor: Colors.grey,
    inactiveTrackColor: Colors.grey.shade300,
    onChanged: (value) {},
  );
  print('Switch with track colors created');

  // Test Switch with thumbColor
  final thumbColorSwitch = Switch(
    value: true,
    thumbColor: MaterialStateProperty.all(Colors.orange),
    onChanged: (value) {},
  );
  print('Switch with thumbColor created');

  // Test Switch.adaptive
  final adaptiveSwitch = Switch.adaptive(value: true, onChanged: (value) {});
  print('Switch.adaptive created');

  // Test SwitchListTile
  final switchListTile = SwitchListTile(
    title: Text('Switch List Tile'),
    subtitle: Text('Toggle this option'),
    value: true,
    onChanged: (value) {},
  );
  print('SwitchListTile created');

  // Test disabled Switch
  final disabledSwitch = Switch(value: true, onChanged: null);
  print('Disabled Switch created');

  // ========== SLIDER ==========
  print('--- Slider Tests ---');

  // Test basic Slider
  final basicSlider = Slider(
    value: 0.5,
    onChanged: (double value) {
      print('Slider changed to: $value');
    },
  );
  print('Basic Slider created');

  // Test Slider with min/max
  final rangeSlider = Slider(
    value: 50.0,
    min: 0.0,
    max: 100.0,
    onChanged: (value) {},
  );
  print('Slider with min=0, max=100 created');

  // Test Slider with divisions
  final discreteSlider = Slider(
    value: 20.0,
    min: 0.0,
    max: 100.0,
    divisions: 10,
    label: '20',
    onChanged: (value) {},
  );
  print('Slider with 10 divisions created');

  // Test Slider with label
  final labeledSlider = Slider(
    value: 30.0,
    min: 0.0,
    max: 100.0,
    divisions: 100,
    label: '30',
    onChanged: (value) {},
  );
  print('Slider with label created');

  // Test Slider with activeColor
  final coloredSlider = Slider(
    value: 0.7,
    activeColor: Colors.purple,
    inactiveColor: Colors.purple.shade100,
    onChanged: (value) {},
  );
  print('Slider with custom colors created');

  // Test Slider with thumbColor
  final thumbSlider = Slider(
    value: 0.5,
    thumbColor: Colors.orange,
    onChanged: (value) {},
  );
  print('Slider with thumbColor created');

  // Test Slider.adaptive
  final adaptiveSlider = Slider.adaptive(value: 0.5, onChanged: (value) {});
  print('Slider.adaptive created');

  // Test Slider with onChangeStart/onChangeEnd
  final callbackSlider = Slider(
    value: 0.5,
    onChanged: (value) {},
    onChangeStart: (value) {
      print('Slider drag started at: $value');
    },
    onChangeEnd: (value) {
      print('Slider drag ended at: $value');
    },
  );
  print('Slider with callbacks created');

  // Test RangeSlider
  final basicRangeSlider = RangeSlider(
    values: RangeValues(20, 80),
    min: 0,
    max: 100,
    onChanged: (RangeValues values) {
      print('Range: ${values.start} - ${values.end}');
    },
  );
  print('RangeSlider created');

  // Test disabled Slider
  final disabledSlider = Slider(value: 0.5, onChanged: null);
  print('Disabled Slider created');

  print('Form Controls test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Form Controls Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text('Checkbox:', style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            basicCheckbox,
            SizedBox(width: 8),
            uncheckedBox,
            SizedBox(width: 8),
            tristateBox,
            SizedBox(width: 8),
            coloredCheckbox,
            SizedBox(width: 8),
            roundedCheckbox,
            SizedBox(width: 8),
            disabledCheckbox,
          ],
        ),
        checkboxListTile,
        SizedBox(height: 16.0),

        Text('Radio:', style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            radio1,
            SizedBox(width: 8),
            radio2,
            SizedBox(width: 8),
            coloredRadio,
            SizedBox(width: 8),
            disabledRadio,
          ],
        ),
        radioListTile,
        SizedBox(height: 16.0),

        Text('Switch:', style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            basicSwitch,
            SizedBox(width: 8),
            offSwitch,
            SizedBox(width: 8),
            coloredSwitch,
            SizedBox(width: 8),
            adaptiveSwitch,
            SizedBox(width: 8),
            disabledSwitch,
          ],
        ),
        switchListTile,
        SizedBox(height: 16.0),

        Text('Slider:', style: TextStyle(fontWeight: FontWeight.bold)),
        basicSlider,
        rangeSlider,
        discreteSlider,
        coloredSlider,
        disabledSlider,
        SizedBox(height: 8.0),
        Text('RangeSlider:', style: TextStyle(fontWeight: FontWeight.bold)),
        basicRangeSlider,
      ],
    ),
  );
}
