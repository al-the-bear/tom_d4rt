// D4rt test script: Tests Curves from animation
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Curves test executing');

  // ========== All named curves ==========
  final curves = <(String, Curve)>[
    ('linear', Curves.linear),
    ('decelerate', Curves.decelerate),
    ('fastLinearToSlowEaseIn', Curves.fastLinearToSlowEaseIn),
    ('ease', Curves.ease),
    ('easeIn', Curves.easeIn),
    ('easeInToLinear', Curves.easeInToLinear),
    ('easeInSine', Curves.easeInSine),
    ('easeInQuad', Curves.easeInQuad),
    ('easeInCubic', Curves.easeInCubic),
    ('easeInQuart', Curves.easeInQuart),
    ('easeInQuint', Curves.easeInQuint),
    ('easeInExpo', Curves.easeInExpo),
    ('easeInCirc', Curves.easeInCirc),
    ('easeInBack', Curves.easeInBack),
    ('easeOut', Curves.easeOut),
    ('linearToEaseOut', Curves.linearToEaseOut),
    ('easeOutSine', Curves.easeOutSine),
    ('easeOutQuad', Curves.easeOutQuad),
    ('easeOutCubic', Curves.easeOutCubic),
    ('easeOutQuart', Curves.easeOutQuart),
    ('easeOutQuint', Curves.easeOutQuint),
    ('easeOutExpo', Curves.easeOutExpo),
    ('easeOutCirc', Curves.easeOutCirc),
    ('easeOutBack', Curves.easeOutBack),
    ('easeInOut', Curves.easeInOut),
    ('easeInOutSine', Curves.easeInOutSine),
    ('easeInOutCubic', Curves.easeInOutCubic),
    ('bounceIn', Curves.bounceIn),
    ('bounceOut', Curves.bounceOut),
    ('bounceInOut', Curves.bounceInOut),
    ('elasticIn', Curves.elasticIn),
    ('elasticOut', Curves.elasticOut),
    ('elasticInOut', Curves.elasticInOut),
  ];

  print('--- All Curves at t=0.5 ---');
  for (final entry in curves) {
    final val = entry.$2.transform(0.5);
    print('  ${entry.$1}: ${val.toStringAsFixed(4)}');
  }

  // ========== Boundary conditions ==========
  print('--- Boundary conditions (all should be 0 at t=0, ~1 at t=1) ---');
  for (final entry in curves) {
    final v0 = entry.$2.transform(0.0);
    final v1 = entry.$2.transform(1.0);
    print(
      '  ${entry.$1}: t=0 -> ${v0.toStringAsFixed(4)}, t=1 -> ${v1.toStringAsFixed(4)}',
    );
  }

  print('Curves test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Curves Tests (${curves.length} curves)',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          for (final entry in curves)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 160.0,
                    child: Text(entry.$1, style: TextStyle(fontSize: 11.0)),
                  ),
                  Expanded(
                    child: Container(
                      height: 12.0,
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: entry.$2.transform(0.5).clamp(0.0, 1.0),
                        child: Container(color: Color(0xFF3F51B5)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}
