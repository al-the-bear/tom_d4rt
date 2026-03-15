// D4rt test script: Tests TreeSliverIndentationType from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TreeSliverIndentationType test executing');

  // ========== TreeSliverIndentationType Static Values ==========
  print('--- TreeSliverIndentationType Static Values ---');
  final standard = TreeSliverIndentationType.standard;
  print('  standard: $standard');
  print('  standard type: ${standard.runtimeType}');

  final none = TreeSliverIndentationType.none;
  print('  none: $none');
  print('  none type: ${none.runtimeType}');

  // ========== TreeSliverIndentationType.custom ==========
  print('--- TreeSliverIndentationType.custom ---');
  final customSmall = TreeSliverIndentationType.custom(10.0);
  print('  custom(10.0): $customSmall');

  final customMedium = TreeSliverIndentationType.custom(20.0);
  print('  custom(20.0): $customMedium');

  final customLarge = TreeSliverIndentationType.custom(40.0);
  print('  custom(40.0): $customLarge');

  final customZero = TreeSliverIndentationType.custom(0.0);
  print('  custom(0.0): $customZero');

  final customNegative = TreeSliverIndentationType.custom(-5.0);
  print('  custom(-5.0): $customNegative');

  // ========== TreeSliverIndentationType Equality ==========
  print('--- TreeSliverIndentationType Equality ---');
  print(
    '  standard == standard: ${standard == TreeSliverIndentationType.standard}',
  );
  print('  none == none: ${none == TreeSliverIndentationType.none}');
  print('  standard == none: ${standard == none}');

  final custom1 = TreeSliverIndentationType.custom(15.0);
  final custom2 = TreeSliverIndentationType.custom(15.0);
  final custom3 = TreeSliverIndentationType.custom(25.0);
  print('  custom(15) == custom(15): ${custom1 == custom2}');
  print('  custom(15) == custom(25): ${custom1 == custom3}');

  // ========== TreeSliverIndentationType HashCode ==========
  print('--- TreeSliverIndentationType HashCode ---');
  print('  standard.hashCode: ${standard.hashCode}');
  print('  none.hashCode: ${none.hashCode}');
  print('  custom(10.0).hashCode: ${customSmall.hashCode}');
  print('  custom(20.0).hashCode: ${customMedium.hashCode}');

  // ========== TreeSliverIndentationType toString ==========
  print('--- TreeSliverIndentationType toString ---');
  print('  standard.toString(): ${standard.toString()}');
  print('  none.toString(): ${none.toString()}');
  print('  customSmall.toString(): ${customSmall.toString()}');

  // ========== TreeSliverIndentationType Usage Patterns ==========
  print('--- TreeSliverIndentationType Usage Patterns ---');
  final List<TreeSliverIndentationType> indentations = [
    TreeSliverIndentationType.standard,
    TreeSliverIndentationType.none,
    TreeSliverIndentationType.custom(8.0),
    TreeSliverIndentationType.custom(16.0),
    TreeSliverIndentationType.custom(24.0),
    TreeSliverIndentationType.custom(32.0),
  ];
  for (int i = 0; i < indentations.length; i++) {
    print('  indentations[$i]: ${indentations[i]}');
  }

  // ========== TreeSliverIndentationType Various Custom Values ==========
  print('--- TreeSliverIndentationType Various Custom Values ---');
  final customValues = [1.0, 5.0, 10.0, 15.0, 20.0, 50.0, 100.0];
  for (final value in customValues) {
    final custom = TreeSliverIndentationType.custom(value);
    print('  custom($value): $custom');
  }

  // ========== TreeSliverIndentationType Decimal Values ==========
  print('--- TreeSliverIndentationType Decimal Values ---');
  final customDecimal1 = TreeSliverIndentationType.custom(12.5);
  print('  custom(12.5): $customDecimal1');

  final customDecimal2 = TreeSliverIndentationType.custom(7.25);
  print('  custom(7.25): $customDecimal2');

  final customDecimal3 = TreeSliverIndentationType.custom(0.5);
  print('  custom(0.5): $customDecimal3');

  print('TreeSliverIndentationType test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'TreeSliverIndentationType Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Static values: standard, none'),
          Text('Custom values: custom(double)'),
          Text('Standard: $standard'),
          Text('None: $none'),
          Text('Custom(10.0): $customSmall'),
          Text('Custom(20.0): $customMedium'),
          Text('Equality tested for same/different values'),
          Text('HashCode tested for uniqueness'),
        ],
      ),
    ),
  );
}
