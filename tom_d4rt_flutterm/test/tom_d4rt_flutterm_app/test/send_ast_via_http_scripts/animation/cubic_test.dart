// D4rt test script: Tests Cubic from animation
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Cubic test executing');

  // ========== Standard Cubic ==========
  print('--- Standard Cubic (ease) ---');
  final ease = Cubic(0.25, 0.1, 0.25, 1.0);
  final tValues = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
  final results = <double>[];
  for (final t in tValues) {
    final v = ease.transform(t);
    results.add(v);
    print('  t=$t: ${v.toStringAsFixed(4)}');
  }

  // ========== Cubic ease-in ==========
  print('--- Cubic ease-in ---');
  final easeIn = Cubic(0.42, 0.0, 1.0, 1.0);
  print('  easeIn(0.25): ${easeIn.transform(0.25).toStringAsFixed(4)}');
  print('  easeIn(0.50): ${easeIn.transform(0.50).toStringAsFixed(4)}');
  print('  easeIn(0.75): ${easeIn.transform(0.75).toStringAsFixed(4)}');

  // ========== Cubic ease-out ==========
  print('--- Cubic ease-out ---');
  final easeOut = Cubic(0.0, 0.0, 0.58, 1.0);
  print('  easeOut(0.25): ${easeOut.transform(0.25).toStringAsFixed(4)}');
  print('  easeOut(0.50): ${easeOut.transform(0.50).toStringAsFixed(4)}');
  print('  easeOut(0.75): ${easeOut.transform(0.75).toStringAsFixed(4)}');

  // ========== Linear Cubic ==========
  print('--- Linear Cubic ---');
  final linear = Cubic(0.0, 0.0, 1.0, 1.0);
  print('  linear(0.25): ${linear.transform(0.25).toStringAsFixed(4)}');
  print('  linear(0.50): ${linear.transform(0.50).toStringAsFixed(4)}');
  print('  linear(0.75): ${linear.transform(0.75).toStringAsFixed(4)}');

  // ========== Boundary conditions ==========
  print('--- Boundary conditions ---');
  print('  transform(0.0): ${ease.transform(0.0).toStringAsFixed(4)}');
  print('  transform(1.0): ${ease.transform(1.0).toStringAsFixed(4)}');

  // ========== Flipped ==========
  print('--- Flipped ---');
  final flipped = ease.flipped;
  print('  flipped(0.5): ${flipped.transform(0.5).toStringAsFixed(4)}');

  print('Cubic test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Cubic Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('Ease curve visualization:'),
          for (var i = 0; i < tValues.length; i++)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.0),
              child: Row(children: [
                SizedBox(width: 50.0, child: Text('t=${tValues[i]}')),
                Expanded(
                  child: Container(
                    height: 14.0,
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: results[i].clamp(0.0, 1.0),
                      child: Container(color: Color(0xFF9C27B0)),
                    ),
                  ),
                ),
                SizedBox(width: 6.0),
                Text(results[i].toStringAsFixed(3)),
              ]),
            ),
        ],
      ),
    ),
  );
}
