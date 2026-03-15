// D4rt test script: Tests DropdownButtonFormField and ButtonSegment from Flutter material
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
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
