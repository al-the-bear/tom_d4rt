// D4rt test script: Tests Icon widget from widgets
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Icon test executing');

  // Test basic Icon with Material icon
  final basicIcon = Icon(Icons.home);
  print('Basic Icon with Icons.home created');

  // Test Icon with custom size
  final sizedIcon = Icon(Icons.star, size: 48.0);
  print('Icon with size=48.0 created');

  // Test Icon with custom color
  final coloredIcon = Icon(Icons.favorite, color: Colors.red);
  print('Icon with color=red created');

  // Test Icon with size and color
  final styledIcon = Icon(Icons.settings, size: 36.0, color: Colors.blue);
  print('Icon with size=36.0 and color=blue created');

  // Test Icon with semanticLabel
  final labeledIcon = Icon(
    Icons.accessibility,
    semanticLabel: 'Accessibility icon',
    size: 32.0,
  );
  print('Icon with semanticLabel created');

  // Test various Material icons
  final iconsRow = Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.add, size: 24.0),
      SizedBox(width: 8.0),
      Icon(Icons.remove, size: 24.0),
      SizedBox(width: 8.0),
      Icon(Icons.close, size: 24.0),
      SizedBox(width: 8.0),
      Icon(Icons.check, size: 24.0),
      SizedBox(width: 8.0),
      Icon(Icons.menu, size: 24.0),
    ],
  );
  print('Row of various Material icons created');

  // Test Icon with different icon categories
  final categoryIcons = Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.folder, color: Colors.amber),
          SizedBox(width: 4.0),
          Icon(Icons.file_copy, color: Colors.grey),
          SizedBox(width: 4.0),
          Icon(Icons.delete, color: Colors.red),
        ],
      ),
      SizedBox(height: 8.0),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.play_arrow, color: Colors.green),
          SizedBox(width: 4.0),
          Icon(Icons.pause, color: Colors.orange),
          SizedBox(width: 4.0),
          Icon(Icons.stop, color: Colors.red),
        ],
      ),
    ],
  );
  print('Category icons created');

  // Test Icon with gradient using ShaderMask (if supported)
  final iconWithTextDirection = Directionality(
    textDirection: TextDirection.ltr,
    child: Icon(Icons.arrow_forward, size: 32.0),
  );
  print('Icon with text direction created');

  print('Icon test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      basicIcon,
      SizedBox(height: 8.0),
      sizedIcon,
      SizedBox(height: 8.0),
      coloredIcon,
      SizedBox(height: 8.0),
      styledIcon,
      SizedBox(height: 8.0),
      labeledIcon,
      SizedBox(height: 16.0),
      iconsRow,
      SizedBox(height: 16.0),
      categoryIcons,
    ],
  );
}
