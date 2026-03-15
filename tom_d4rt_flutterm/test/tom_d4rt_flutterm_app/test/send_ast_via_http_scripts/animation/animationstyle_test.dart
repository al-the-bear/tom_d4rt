// D4rt test script: Tests AnimationStyle from animation
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimationStyle test executing');

  // ========== ANIMATIONSTYLE ==========
  print('--- AnimationStyle Tests ---');

  // Create AnimationStyle with duration and curve
  final style1 = AnimationStyle(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );
  print('AnimationStyle(duration=300ms, curve=easeInOut):');
  print('  duration: ${style1.duration}');
  print('  curve: ${style1.curve}');
  print('  reverseDuration: ${style1.reverseDuration}');
  print('  reverseCurve: ${style1.reverseCurve}');

  // Create AnimationStyle with all parameters
  final style2 = AnimationStyle(
    duration: Duration(milliseconds: 500),
    reverseDuration: Duration(milliseconds: 250),
    curve: Curves.easeIn,
    reverseCurve: Curves.easeOut,
  );
  print(
    'AnimationStyle(duration=500ms, reverseDuration=250ms, curve=easeIn, reverseCurve=easeOut):',
  );
  print('  duration: ${style2.duration}');
  print('  reverseDuration: ${style2.reverseDuration}');
  print('  curve: ${style2.curve}');
  print('  reverseCurve: ${style2.reverseCurve}');

  // Create AnimationStyle with only duration
  final style3 = AnimationStyle(duration: Duration(milliseconds: 200));
  print('AnimationStyle(duration=200ms):');
  print('  duration: ${style3.duration}');
  print('  curve: ${style3.curve}');

  // Create AnimationStyle with only curve
  final style4 = AnimationStyle(curve: Curves.bounceOut);
  print('AnimationStyle(curve=bounceOut):');
  print('  duration: ${style4.duration}');
  print('  curve: ${style4.curve}');

  // AnimationStyle.noAnimation
  final noAnim = AnimationStyle.noAnimation;
  print('AnimationStyle.noAnimation:');
  print('  duration: ${noAnim.duration}');
  print('  curve: ${noAnim.curve}');

  // Test different duration values
  final shortStyle = AnimationStyle(
    duration: Duration(milliseconds: 100),
    curve: Curves.linear,
  );
  print('Short style (100ms): duration=${shortStyle.duration}');

  final longStyle = AnimationStyle(
    duration: Duration(seconds: 2),
    curve: Curves.fastOutSlowIn,
  );
  print('Long style (2s): duration=${longStyle.duration}');

  // Test with various curves
  final curveStyles = [
    ('linear', Curves.linear),
    ('ease', Curves.ease),
    ('easeIn', Curves.easeIn),
    ('easeOut', Curves.easeOut),
    ('bounceIn', Curves.bounceIn),
    ('elasticOut', Curves.elasticOut),
  ];

  for (final entry in curveStyles) {
    final name = entry.$1;
    final curve = entry.$2;
    final s = AnimationStyle(
      duration: Duration(milliseconds: 300),
      curve: curve,
    );
    print('AnimationStyle with $name: curve=${s.curve}');
  }

  // ========== USE IN WIDGET ==========
  print('--- AnimationStyle in Widget ---');

  // AnimationStyle can be used with AnimatedContainer and similar widgets
  print('Building widget tree with AnimationStyle');

  return Container(
    padding: EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AnimationStyle Test Results',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1565C0),
            ),
          ),
          SizedBox(height: 16.0),
          // Show different animation styles visually
          Text(
            'Duration: 300ms, Curve: easeInOut',
            style: TextStyle(fontSize: 12.0),
          ),
          SizedBox(height: 8.0),
          AnimatedContainer(
            duration: style1.duration ?? Duration(milliseconds: 300),
            curve: style1.curve ?? Curves.linear,
            width: 200.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: Color(0xFF2196F3),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                'Style 1',
                style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12.0),
              ),
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            'Duration: 500ms, Curve: easeIn',
            style: TextStyle(fontSize: 12.0),
          ),
          SizedBox(height: 8.0),
          AnimatedContainer(
            duration: style2.duration ?? Duration(milliseconds: 500),
            curve: style2.curve ?? Curves.linear,
            width: 250.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: Color(0xFF4CAF50),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                'Style 2',
                style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12.0),
              ),
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            'Duration: 200ms (default curve)',
            style: TextStyle(fontSize: 12.0),
          ),
          SizedBox(height: 8.0),
          AnimatedContainer(
            duration: style3.duration ?? Duration(milliseconds: 200),
            curve: style3.curve ?? Curves.linear,
            width: 150.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: Color(0xFFFF9800),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                'Style 3',
                style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12.0),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFF5F5F5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AnimationStyle Summary:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
                ),
                SizedBox(height: 4.0),
                Text(
                  '• Controls duration and curve of animations',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '• Can specify reverse duration/curve separately',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '• AnimationStyle.noAnimation disables animation',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '• Used with AnimatedContainer, ExpansionTile, etc.',
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
