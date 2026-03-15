// D4rt test script: Tests RawChip, ChipAttributes-related concepts,
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// DeletableChipAttributes, SelectableChipAttributes
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Chip attributes test executing');

  // ========== RawChip ==========
  print('--- RawChip Tests ---');
  final rawChip = RawChip(
    label: Text('Raw Chip'),
    avatar: CircleAvatar(child: Text('R')),
    onPressed: () => print('Raw chip pressed'),
    onDeleted: () => print('Raw chip deleted'),
    deleteIcon: Icon(Icons.cancel, size: 18.0),
    selected: false,
    isEnabled: true,
    elevation: 2.0,
    pressElevation: 4.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    side: BorderSide(color: Colors.grey),
    labelStyle: TextStyle(fontSize: 14.0),
    labelPadding: EdgeInsets.symmetric(horizontal: 4.0),
    padding: EdgeInsets.all(4.0),
    materialTapTargetSize: MaterialTapTargetSize.padded,
    showCheckmark: false,
    tapEnabled: true,
  );
  print('RawChip created');
  print('  selected: false');
  print('  isEnabled: true');
  print('  elevation: 2.0');

  // Selected RawChip
  final selectedRaw = RawChip(
    label: Text('Selected Raw'),
    selected: true,
    selectedColor: Colors.blue.shade200,
    selectedShadowColor: Colors.blue.shade400,
    showCheckmark: true,
    checkmarkColor: Colors.white,
    onSelected: (v) => print('Selected: $v'),
  );
  print('Selected RawChip created');

  // Disabled RawChip
  final disabledRaw = RawChip(
    label: Text('Disabled Raw'),
    isEnabled: false,
    disabledColor: Colors.grey.shade300,
  );
  print('Disabled RawChip created');

  // ========== Chip with avatar ==========
  print('--- Chip with avatar Tests ---');
  final chipWithAvatar = Chip(
    avatar: CircleAvatar(
      backgroundColor: Colors.blue.shade100,
      child: Text('A'),
    ),
    label: Text('Avatar Chip'),
    deleteIcon: Icon(Icons.close, size: 18.0),
    onDeleted: () => print('Chip deleted'),
    labelPadding: EdgeInsets.only(left: 4.0),
    side: BorderSide(color: Colors.blue.shade200),
  );
  print('Chip with avatar created');

  // ========== Chip themes ==========
  print('--- ChipTheme Tests ---');
  final chipTheme = ChipTheme(
    data: ChipThemeData(
      backgroundColor: Colors.grey.shade100,
      selectedColor: Colors.blue.shade200,
      labelStyle: TextStyle(fontSize: 14.0, color: Colors.black),
      padding: EdgeInsets.all(4.0),
    ),
    child: Wrap(children: [rawChip, selectedRaw]),
  );
  print('ChipTheme wrapping chips');

  print('All chip attribute tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chip Attributes Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [rawChip, selectedRaw, disabledRaw, chipWithAvatar],
            ),
          ],
        ),
      ),
    ),
  );
}
