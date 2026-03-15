// D4rt test script: Tests Checkbox, Radio, Switch, Slider widgets from material
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
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
