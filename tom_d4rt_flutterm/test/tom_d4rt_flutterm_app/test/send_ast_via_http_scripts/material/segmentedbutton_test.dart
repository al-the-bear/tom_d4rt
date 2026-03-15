// D4rt test script: Tests SegmentedButton from material
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
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
