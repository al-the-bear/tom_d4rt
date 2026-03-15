// D4rt test script: Tests MenuAnchor, MenuItemButton, SubmenuButton from Flutter material
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MenuAnchor/MenuItemButton/SubmenuButton test executing');

  // Variation 1: Basic MenuAnchor with MenuItemButtons
  final widget1 = MenuAnchor(
    menuChildren: [
      MenuItemButton(
        onPressed: () {
          print('item1');
        },
        child: Text('Item 1'),
      ),
      MenuItemButton(
        onPressed: () {
          print('item2');
        },
        child: Text('Item 2'),
      ),
    ],
    child: TextButton(onPressed: () {}, child: Text('Open Menu')),
  );
  print('MenuAnchor(basic with 2 MenuItemButtons) created');

  // Variation 2: MenuItemButton with leading icon
  final widget2 = MenuItemButton(
    onPressed: () {},
    leadingIcon: Icon(Icons.edit),
    child: Text('Edit'),
  );
  print('MenuItemButton(leadingIcon: edit) created');

  // Variation 3: MenuItemButton disabled
  final widget3 = MenuItemButton(onPressed: null, child: Text('Disabled'));
  print('MenuItemButton(onPressed: null, disabled) created');

  // Variation 4: SubmenuButton with children
  final widget4 = SubmenuButton(
    menuChildren: [
      MenuItemButton(onPressed: () {}, child: Text('Sub1')),
      MenuItemButton(onPressed: () {}, child: Text('Sub2')),
    ],
    child: Text('Submenu'),
  );
  print('SubmenuButton(2 children) created');

  // Variation 5: MenuAnchor with SubmenuButton and MenuItemButtons
  final widget5 = MenuAnchor(
    menuChildren: [
      MenuItemButton(
        onPressed: () {
          print('new');
        },
        leadingIcon: Icon(Icons.add),
        child: Text('New'),
      ),
      SubmenuButton(
        menuChildren: [
          MenuItemButton(onPressed: () {}, child: Text('Copy')),
          MenuItemButton(onPressed: () {}, child: Text('Paste')),
        ],
        child: Text('Edit'),
      ),
      MenuItemButton(
        onPressed: () {
          print('delete');
        },
        leadingIcon: Icon(Icons.delete),
        child: Text('Delete'),
      ),
    ],
    child: TextButton(onPressed: () {}, child: Text('Actions')),
  );
  print('MenuAnchor(with SubmenuButton nested) created');

  // Variation 6: MenuItemButton with trailing icon
  final widget6 = MenuItemButton(
    onPressed: () {
      print('settings');
    },
    leadingIcon: Icon(Icons.settings),
    trailingIcon: Icon(Icons.arrow_forward),
    child: Text('Settings'),
  );
  print('MenuItemButton(leadingIcon + trailingIcon) created');

  print('MenuAnchor/MenuItemButton/SubmenuButton test completed');
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [widget1, widget2, widget3, widget4, widget5, widget6],
  );
}
