// D4rt test script: Tests AlwaysStoppedAnimation from animation
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AlwaysStoppedAnimation test executing');

  // ========== ALWAYSSTOPPEDANIMATION<double> ==========
  print('--- AlwaysStoppedAnimation<double> Tests ---');

  // Create with 0.5
  final anim1 = AlwaysStoppedAnimation<double>(0.5);
  print('AlwaysStoppedAnimation<double>(0.5):');
  print('  value: ${anim1.value}');
  print('  status: ${anim1.status}');

  // Create with 0.0
  final anim0 = AlwaysStoppedAnimation<double>(0.0);
  print('AlwaysStoppedAnimation<double>(0.0):');
  print('  value: ${anim0.value}');
  print('  status: ${anim0.status}');

  // Create with 1.0
  final anim1Full = AlwaysStoppedAnimation<double>(1.0);
  print('AlwaysStoppedAnimation<double>(1.0):');
  print('  value: ${anim1Full.value}');
  print('  status: ${anim1Full.status}');

  // Create with 0.75
  final anim75 = AlwaysStoppedAnimation<double>(0.75);
  print('AlwaysStoppedAnimation<double>(0.75):');
  print('  value: ${anim75.value}');
  print('  status: ${anim75.status}');

  // ========== ALWAYSSTOPPEDANIMATION<Color> ==========
  print('--- AlwaysStoppedAnimation<Color> Tests ---');

  final colorAnim = AlwaysStoppedAnimation<Color>(Color(0xFF2196F3));
  print('AlwaysStoppedAnimation<Color>(blue):');
  print('  value: ${colorAnim.value}');
  print('  status: ${colorAnim.status}');

  final redAnim = AlwaysStoppedAnimation<Color>(Color(0xFFFF0000));
  print('AlwaysStoppedAnimation<Color>(red):');
  print('  value: ${redAnim.value}');

  // ========== ALWAYSSTOPPEDANIMATION<int> ==========
  print('--- AlwaysStoppedAnimation<int> Tests ---');

  final intAnim = AlwaysStoppedAnimation<int>(42);
  print('AlwaysStoppedAnimation<int>(42):');
  print('  value: ${intAnim.value}');
  print('  status: ${intAnim.status}');

  // ========== ALWAYSSTOPPEDANIMATION<Offset> ==========
  print('--- AlwaysStoppedAnimation<Offset> Tests ---');

  final offsetAnim = AlwaysStoppedAnimation<Offset>(Offset(0.5, 0.3));
  print('AlwaysStoppedAnimation<Offset>(0.5, 0.3):');
  print('  value: ${offsetAnim.value}');
  print('  status: ${offsetAnim.status}');

  // ========== ALWAYSSTOPPEDANIMATION<Size> ==========
  print('--- AlwaysStoppedAnimation<Size> Tests ---');

  final sizeAnim = AlwaysStoppedAnimation<Size>(Size(100.0, 50.0));
  print('AlwaysStoppedAnimation<Size>(100, 50):');
  print('  value: ${sizeAnim.value}');

  // ========== USE IN TRANSITIONS ==========
  print('--- AlwaysStoppedAnimation in Transitions ---');

  // Use in FadeTransition
  print('Using in FadeTransition with opacity=0.5');
  print('Using in FadeTransition with opacity=1.0');

  // Use in SlideTransition
  print('Using in SlideTransition with offset=(0.0, 0.0)');

  // Use in RotationTransition
  print('Using in RotationTransition with turns=0.25');

  // Use in ScaleTransition
  print('Using in ScaleTransition with scale=0.8');

  // ========== STATUS CHECK ==========
  print('--- Status Consistency ---');
  final statuses = [anim0, anim1, anim1Full, anim75];
  for (final a in statuses) {
    print('  value=${a.value} -> status=${a.status}');
  }

  // ========== WIDGET TREE ==========
  return Container(
    padding: EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AlwaysStoppedAnimation Test Results',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1565C0),
            ),
          ),
          SizedBox(height: 16.0),

          // FadeTransition with AlwaysStoppedAnimation
          Text(
            'FadeTransition (opacity=0.5):',
            style: TextStyle(fontSize: 12.0),
          ),
          SizedBox(height: 4.0),
          FadeTransition(
            opacity: AlwaysStoppedAnimation<double>(0.5),
            child: Container(
              width: 200.0,
              height: 40.0,
              color: Color(0xFF2196F3),
              child: Center(
                child: Text(
                  '50% Opacity',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.0),

          // FadeTransition fully visible
          Text(
            'FadeTransition (opacity=1.0):',
            style: TextStyle(fontSize: 12.0),
          ),
          SizedBox(height: 4.0),
          FadeTransition(
            opacity: AlwaysStoppedAnimation<double>(1.0),
            child: Container(
              width: 200.0,
              height: 40.0,
              color: Color(0xFF4CAF50),
              child: Center(
                child: Text(
                  '100% Opacity',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.0),

          // FadeTransition low opacity
          Text(
            'FadeTransition (opacity=0.2):',
            style: TextStyle(fontSize: 12.0),
          ),
          SizedBox(height: 4.0),
          FadeTransition(
            opacity: AlwaysStoppedAnimation<double>(0.2),
            child: Container(
              width: 200.0,
              height: 40.0,
              color: Color(0xFFFF9800),
              child: Center(
                child: Text(
                  '20% Opacity',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.0),

          // SlideTransition
          Text(
            'SlideTransition (offset=0,0):',
            style: TextStyle(fontSize: 12.0),
          ),
          SizedBox(height: 4.0),
          SlideTransition(
            position: AlwaysStoppedAnimation<Offset>(Offset(0.0, 0.0)),
            child: Container(
              width: 200.0,
              height: 40.0,
              color: Color(0xFF9C27B0),
              child: Center(
                child: Text(
                  'No Slide',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.0),

          // RotationTransition
          Text(
            'RotationTransition (turns=0.25):',
            style: TextStyle(fontSize: 12.0),
          ),
          SizedBox(height: 4.0),
          SizedBox(
            width: 60.0,
            height: 60.0,
            child: RotationTransition(
              turns: AlwaysStoppedAnimation<double>(0.25),
              child: Container(
                color: Color(0xFFE91E63),
                child: Center(
                  child: Text(
                    'R',
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16.0),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.0),

          // ScaleTransition
          Text(
            'ScaleTransition (scale=0.8):',
            style: TextStyle(fontSize: 12.0),
          ),
          SizedBox(height: 4.0),
          ScaleTransition(
            scale: AlwaysStoppedAnimation<double>(0.8),
            child: Container(
              width: 200.0,
              height: 40.0,
              color: Color(0xFF009688),
              child: Center(
                child: Text(
                  '80% Scale',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),

          // Summary
          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFF5F5F5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AlwaysStoppedAnimation Summary:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
                ),
                SizedBox(height: 4.0),
                Text(
                  '• Provides a constant animation value',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '• Status is always AnimationStatus.forward',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '• Useful for static transition widgets',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '• Supports any type: double, Color, Offset, etc.',
                  style: TextStyle(fontSize: 11.0),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
