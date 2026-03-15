// D4rt test script: Tests AnimationStatus enum, AnimationMax, AnimationMin,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// AnimationMean from animation
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimationStatus test executing');

  // ========== ANIMATIONSTATUS ==========
  print('--- AnimationStatus Tests ---');

  print('AnimationStatus.dismissed: ${AnimationStatus.dismissed}');
  print('AnimationStatus.forward: ${AnimationStatus.forward}');
  print('AnimationStatus.reverse: ${AnimationStatus.reverse}');
  print('AnimationStatus.completed: ${AnimationStatus.completed}');
  print('AnimationStatus.values: ${AnimationStatus.values}');
  print('AnimationStatus.values count: ${AnimationStatus.values.length}');

  // Test enum properties
  final dismissed = AnimationStatus.dismissed;
  print('dismissed.name: ${dismissed.name}');
  print('dismissed.index: ${dismissed.index}');

  final completed = AnimationStatus.completed;
  print('completed.name: ${completed.name}');
  print('completed.index: ${completed.index}');

  // Test isDismissed / isCompleted
  print('dismissed.isDismissed: ${dismissed.isDismissed}');
  print('dismissed.isCompleted: ${dismissed.isCompleted}');
  print('completed.isDismissed: ${completed.isDismissed}');
  print('completed.isCompleted: ${completed.isCompleted}');

  // ========== ANIMATIONMAX ==========
  print('--- AnimationMax Tests ---');

  // AnimationMax returns the max of two animations
  final anim1 = AlwaysStoppedAnimation<double>(0.3);
  final anim2 = AlwaysStoppedAnimation<double>(0.7);

  final animMax = AnimationMax<double>(anim1, anim2);
  print('AnimationMax(0.3, 0.7) created');
  print('AnimationMax.value: ${animMax.value}');
  print('AnimationMax.first: ${animMax.first.value}');
  print('AnimationMax.next: ${animMax.next.value}');

  // Test with different values
  final animMax2 = AnimationMax<double>(
    AlwaysStoppedAnimation<double>(0.9),
    AlwaysStoppedAnimation<double>(0.1),
  );
  print('AnimationMax(0.9, 0.1).value: ${animMax2.value}');

  // Test with equal values
  final animMaxEqual = AnimationMax<double>(
    AlwaysStoppedAnimation<double>(0.5),
    AlwaysStoppedAnimation<double>(0.5),
  );
  print('AnimationMax(0.5, 0.5).value: ${animMaxEqual.value}');

  // ========== ANIMATIONMIN ==========
  print('--- AnimationMin Tests ---');

  final animMin = AnimationMin<double>(anim1, anim2);
  print('AnimationMin(0.3, 0.7) created');
  print('AnimationMin.value: ${animMin.value}');
  print('AnimationMin.first: ${animMin.first.value}');
  print('AnimationMin.next: ${animMin.next.value}');

  final animMin2 = AnimationMin<double>(
    AlwaysStoppedAnimation<double>(0.9),
    AlwaysStoppedAnimation<double>(0.1),
  );
  print('AnimationMin(0.9, 0.1).value: ${animMin2.value}');

  // ========== ANIMATIONMEAN ==========
  print('--- AnimationMean Tests ---');

  final animMean = AnimationMean(
    left: AlwaysStoppedAnimation<double>(0.2),
    right: AlwaysStoppedAnimation<double>(0.8),
  );
  print('AnimationMean(0.2, 0.8) created');
  print('AnimationMean.value: ${animMean.value}');

  final animMean2 = AnimationMean(
    left: AlwaysStoppedAnimation<double>(0.0),
    right: AlwaysStoppedAnimation<double>(1.0),
  );
  print('AnimationMean(0.0, 1.0).value: ${animMean2.value}');

  final animMean3 = AnimationMean(
    left: AlwaysStoppedAnimation<double>(0.4),
    right: AlwaysStoppedAnimation<double>(0.4),
  );
  print('AnimationMean(0.4, 0.4).value: ${animMean3.value}');

  print('All AnimationStatus tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Animation Status Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text('AnimationStatus values: ${AnimationStatus.values.length}'),
            SizedBox(height: 4.0),
            Text('AnimationMax(0.3, 0.7) = ${animMax.value}'),
            Text('AnimationMin(0.3, 0.7) = ${animMin.value}'),
            Text('AnimationMean(0.2, 0.8) = ${animMean.value}'),
          ],
        ),
      ),
    ),
  );
}
