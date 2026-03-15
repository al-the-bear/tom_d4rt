// D4rt test script: Tests AnimationMax from animation
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AnimationMax test executing');

  // ========== Basic AnimationMax ==========
  print('--- Basic AnimationMax ---');
  final first = AlwaysStoppedAnimation<double>(0.3);
  final next = AlwaysStoppedAnimation<double>(0.7);
  final animMax = AnimationMax<double>(first, next);
  print('  first.value: ${first.value}');
  print('  next.value: ${next.value}');
  print('  max.value: ${animMax.value}');

  // ========== Max when first > next ==========
  print('--- Max when first > next ---');
  final high = AlwaysStoppedAnimation<double>(0.9);
  final low = AlwaysStoppedAnimation<double>(0.1);
  final maxHL = AnimationMax<double>(high, low);
  print('  high=0.9, low=0.1, max: ${maxHL.value}');

  // ========== Max with equal values ==========
  print('--- Max with equal values ---');
  final eq1 = AlwaysStoppedAnimation<double>(0.5);
  final eq2 = AlwaysStoppedAnimation<double>(0.5);
  final maxEq = AnimationMax<double>(eq1, eq2);
  print('  equal(0.5, 0.5), max: ${maxEq.value}');

  // ========== Max with zero and one ==========
  print('--- Max boundary values ---');
  final zero = AlwaysStoppedAnimation<double>(0.0);
  final one = AlwaysStoppedAnimation<double>(1.0);
  final maxBound = AnimationMax<double>(zero, one);
  print('  max(0.0, 1.0): ${maxBound.value}');

  // ========== Max with negative values ==========
  print('--- Max with negative values ---');
  final neg = AlwaysStoppedAnimation<double>(-0.5);
  final pos = AlwaysStoppedAnimation<double>(0.5);
  final maxNeg = AnimationMax<double>(neg, pos);
  print('  max(-0.5, 0.5): ${maxNeg.value}');

  // ========== Status ==========
  print('--- Status ---');
  print('  status: ${animMax.status}');

  print('AnimationMax test completed');

  final results = [
    ('max(0.3, 0.7)', animMax.value),
    ('max(0.9, 0.1)', maxHL.value),
    ('max(0.5, 0.5)', maxEq.value),
    ('max(0.0, 1.0)', maxBound.value),
    ('max(-0.5, 0.5)', maxNeg.value),
  ];

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'AnimationMax Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          for (final r in results)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                children: [
                  SizedBox(width: 150.0, child: Text('${r.$1}:')),
                  Expanded(
                    child: Container(
                      height: 20.0,
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: r.$2.clamp(0.0, 1.0),
                        child: Container(color: Color(0xFF4CAF50)),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text('${r.$2.toStringAsFixed(2)}'),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}
