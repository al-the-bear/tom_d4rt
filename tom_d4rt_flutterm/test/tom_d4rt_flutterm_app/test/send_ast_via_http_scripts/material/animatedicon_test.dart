// D4rt test script: Tests AnimatedIcon from Flutter material
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimatedIcon test executing');

  // Variation 1: menu_arrow at progress 0.0
  final widget1 = AnimatedIcon(
    icon: AnimatedIcons.menu_arrow,
    progress: AlwaysStoppedAnimation(0.0),
  );
  print('AnimatedIcon(menu_arrow, progress: 0.0) created');

  // Variation 2: menu_arrow at progress 0.5
  final widget2 = AnimatedIcon(
    icon: AnimatedIcons.menu_arrow,
    progress: AlwaysStoppedAnimation(0.5),
  );
  print('AnimatedIcon(menu_arrow, progress: 0.5) created');

  // Variation 3: menu_arrow at progress 1.0
  final widget3 = AnimatedIcon(
    icon: AnimatedIcons.menu_arrow,
    progress: AlwaysStoppedAnimation(1.0),
  );
  print('AnimatedIcon(menu_arrow, progress: 1.0) created');

  // Variation 4: play_pause with size and color
  final widget4 = AnimatedIcon(
    icon: AnimatedIcons.play_pause,
    progress: AlwaysStoppedAnimation(0.5),
    size: 48.0,
    color: Colors.blue,
  );
  print(
    'AnimatedIcon(play_pause, progress: 0.5, size: 48, color: blue) created',
  );

  // Variation 5: menu_close at progress 0.0
  final widget5 = AnimatedIcon(
    icon: AnimatedIcons.menu_close,
    progress: AlwaysStoppedAnimation(0.0),
  );
  print('AnimatedIcon(menu_close, progress: 0.0) created');

  // Variation 6: home_menu at progress 1.0
  final widget6 = AnimatedIcon(
    icon: AnimatedIcons.home_menu,
    progress: AlwaysStoppedAnimation(1.0),
  );
  print('AnimatedIcon(home_menu, progress: 1.0) created');

  print('AnimatedIcon test completed');
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('menu_arrow 0.0: '), widget1],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('menu_arrow 0.5: '), widget2],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('menu_arrow 1.0: '), widget3],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('play_pause 0.5: '), widget4],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('menu_close 0.0: '), widget5],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('home_menu 1.0: '), widget6],
      ),
    ],
  );
}
