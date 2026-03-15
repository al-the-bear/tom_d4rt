// D4rt test script: Tests MenuBar, CheckboxMenuButton, RadioMenuButton from Flutter material
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
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
