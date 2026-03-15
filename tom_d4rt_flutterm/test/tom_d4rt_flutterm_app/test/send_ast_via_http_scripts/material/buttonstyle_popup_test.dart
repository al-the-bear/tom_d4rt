// D4rt test script: Tests ButtonStyle, ButtonBar, PopupMenuButton,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// PopupMenuItem, PopupMenuDivider
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Button style and popup menu test executing');

  // ========== ButtonStyle ==========
  print('--- ButtonStyle Tests ---');

  final style1 = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.blue),
    foregroundColor: WidgetStateProperty.all(Colors.white),
    padding: WidgetStateProperty.all(
      EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    ),
    elevation: WidgetStateProperty.all(4.0),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),
    minimumSize: WidgetStateProperty.all(Size(120.0, 48.0)),
    tapTargetSize: MaterialTapTargetSize.padded,
    visualDensity: VisualDensity.standard,
  );
  print('ButtonStyle created');

  // ButtonStyle.copyWith
  final style2 = style1.copyWith(
    backgroundColor: WidgetStateProperty.all(Colors.red),
  );
  print('ButtonStyle copyWith created');

  // ButtonStyle.merge
  final style3 = style1.merge(
    ButtonStyle(elevation: WidgetStateProperty.all(8.0)),
  );
  print('ButtonStyle merge created');

  // ========== WidgetStateProperty ==========
  print('--- WidgetStateProperty Tests ---');

  final bgProp = WidgetStateProperty.resolveWith<Color>((states) {
    if (states.contains(WidgetState.pressed)) return Colors.blue.shade700;
    if (states.contains(WidgetState.hovered)) return Colors.blue.shade300;
    if (states.contains(WidgetState.disabled)) return Colors.grey;
    return Colors.blue;
  });
  final resolvedNormal = bgProp.resolve({});
  print('WidgetStateProperty resolved normal: $resolvedNormal');

  final resolvedPressed = bgProp.resolve({WidgetState.pressed});
  print('WidgetStateProperty resolved pressed: $resolvedPressed');

  final resolvedDisabled = bgProp.resolve({WidgetState.disabled});
  print('WidgetStateProperty resolved disabled: $resolvedDisabled');

  // ========== WidgetState ==========
  print('--- WidgetState Tests ---');

  print('WidgetState.hovered: ${WidgetState.hovered}');
  print('WidgetState.focused: ${WidgetState.focused}');
  print('WidgetState.pressed: ${WidgetState.pressed}');
  print('WidgetState.dragged: ${WidgetState.dragged}');
  print('WidgetState.selected: ${WidgetState.selected}');
  print('WidgetState.scrolledUnder: ${WidgetState.scrolledUnder}');
  print('WidgetState.disabled: ${WidgetState.disabled}');
  print('WidgetState.error: ${WidgetState.error}');
  print('WidgetState.values: ${WidgetState.values}');

  print('All button style and popup menu tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Button Style Test')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Button Style & Popup Menu Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: style1,
              onPressed: () => print('Pressed 1'),
              child: Text('Style 1'),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              style: style2,
              onPressed: () => print('Pressed 2'),
              child: Text('Style 2 (red)'),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              style: style3,
              onPressed: () => print('Pressed 3'),
              child: Text('Style 3 (merged)'),
            ),
            SizedBox(height: 16.0),
            PopupMenuButton<String>(
              onSelected: (String value) {
                print('Selected: $value');
              },
              itemBuilder: (BuildContext ctx) => [
                PopupMenuItem<String>(value: 'edit', child: Text('Edit')),
                PopupMenuItem<String>(value: 'delete', child: Text('Delete')),
                PopupMenuDivider(),
                PopupMenuItem<String>(
                  value: 'share',
                  child: ListTile(
                    leading: Icon(Icons.share),
                    title: Text('Share'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
              child: Text('Show Menu'),
            ),
          ],
        ),
      ),
    ),
  );
}
