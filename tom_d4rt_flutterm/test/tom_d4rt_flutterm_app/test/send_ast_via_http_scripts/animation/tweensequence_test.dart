// D4rt test script: Tests TweenSequence and TweenSequenceItem from animation
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TweenSequence test executing');

  // ========== TWEENSEQUENCE<double> ==========
  print('--- TweenSequence<double> Tests ---');

  // Simple two-item sequence: 0 -> 100, then 100 -> 50
  final sequence1 = TweenSequence<double>([
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 0.0, end: 100.0),
      weight: 50,
    ),
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 100.0, end: 50.0),
      weight: 50,
    ),
  ]);
  print('TweenSequence [0->100 (w:50), 100->50 (w:50)]:');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    print('  transform($t): ${sequence1.transform(t).toStringAsFixed(2)}');
  }

  // Three-item sequence: 0 -> 100 -> 50 -> 200
  final sequence2 = TweenSequence<double>([
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 0.0, end: 100.0),
      weight: 33,
    ),
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 100.0, end: 50.0),
      weight: 33,
    ),
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 50.0, end: 200.0),
      weight: 34,
    ),
  ]);
  print('TweenSequence [0->100 (w:33), 100->50 (w:33), 50->200 (w:34)]:');
  for (final t in [0.0, 0.1, 0.2, 0.33, 0.5, 0.66, 0.8, 0.9, 1.0]) {
    print('  transform($t): ${sequence2.transform(t).toStringAsFixed(2)}');
  }

  // Unequal weights
  final unequalSeq = TweenSequence<double>([
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 0.0, end: 100.0),
      weight: 80,
    ),
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 100.0, end: 0.0),
      weight: 20,
    ),
  ]);
  print('TweenSequence unequal weights [0->100 (w:80), 100->0 (w:20)]:');
  for (final t in [0.0, 0.4, 0.8, 0.9, 1.0]) {
    print('  transform($t): ${unequalSeq.transform(t).toStringAsFixed(2)}');
  }

  // ========== TWEENSEQUENCE WITH CURVES ==========
  print('--- TweenSequence with Curves ---');

  final curvedSequence = TweenSequence<double>([
    TweenSequenceItem<double>(
      tween: Tween<double>(
        begin: 0.0,
        end: 100.0,
      ).chain(CurveTween(curve: Curves.easeIn)),
      weight: 50,
    ),
    TweenSequenceItem<double>(
      tween: Tween<double>(
        begin: 100.0,
        end: 0.0,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 50,
    ),
  ]);
  print('Curved: [0->100 easeIn (w:50), 100->0 easeOut (w:50)]:');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    print('  transform($t): ${curvedSequence.transform(t).toStringAsFixed(2)}');
  }

  // ========== TWEENSEQUENCE<Color> ==========
  print('--- TweenSequence<Color> Tests ---');

  final colorSequence = TweenSequence<Color?>([
    TweenSequenceItem<Color?>(
      tween: ColorTween(begin: Color(0xFFFF0000), end: Color(0xFF00FF00)),
      weight: 50,
    ),
    TweenSequenceItem<Color?>(
      tween: ColorTween(begin: Color(0xFF00FF00), end: Color(0xFF0000FF)),
      weight: 50,
    ),
  ]);
  print('Color sequence [red->green, green->blue]:');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    print('  transform($t): ${colorSequence.transform(t)}');
  }

  // ========== TWEENSEQUENCE EVALUATE ==========
  print('--- TweenSequence evaluate ---');

  // Evaluate using an AlwaysStoppedAnimation
  final evalAnim = AlwaysStoppedAnimation<double>(0.5);
  final evalResult = sequence1.evaluate(evalAnim);
  print(
    'sequence1.evaluate(AlwaysStoppedAnimation(0.5)): ${evalResult.toStringAsFixed(2)}',
  );

  final evalAnim25 = AlwaysStoppedAnimation<double>(0.25);
  final evalResult25 = sequence1.evaluate(evalAnim25);
  print(
    'sequence1.evaluate(AlwaysStoppedAnimation(0.25)): ${evalResult25.toStringAsFixed(2)}',
  );

  final evalAnim75 = AlwaysStoppedAnimation<double>(0.75);
  final evalResult75 = sequence1.evaluate(evalAnim75);
  print(
    'sequence1.evaluate(AlwaysStoppedAnimation(0.75)): ${evalResult75.toStringAsFixed(2)}',
  );

  // ========== SINGLE ITEM SEQUENCE ==========
  print('--- Single Item TweenSequence ---');

  final singleSequence = TweenSequence<double>([
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 10.0, end: 90.0),
      weight: 1,
    ),
  ]);
  print('Single item [10->90]:');
  for (final t in [0.0, 0.5, 1.0]) {
    print('  transform($t): ${singleSequence.transform(t).toStringAsFixed(2)}');
  }

  // ========== FOUR ITEM SEQUENCE ==========
  print('--- Four Item TweenSequence ---');

  final fourSequence = TweenSequence<double>([
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 0.0, end: 50.0),
      weight: 25,
    ),
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 50.0, end: 100.0),
      weight: 25,
    ),
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 100.0, end: 25.0),
      weight: 25,
    ),
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 25.0, end: 75.0),
      weight: 25,
    ),
  ]);
  print('Four items [0->50, 50->100, 100->25, 25->75]:');
  for (final t in [0.0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1.0]) {
    print('  transform($t): ${fourSequence.transform(t).toStringAsFixed(2)}');
  }

  // ========== WIDGET TREE ==========
  return Container(
    padding: EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TweenSequence Test Results',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1565C0),
            ),
          ),
          SizedBox(height: 16.0),

          // Visualize sequence1 as bar chart
          Text(
            'Sequence: 0→100→50',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
          ),
          SizedBox(height: 8.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (final t in [
                0.0,
                0.05,
                0.1,
                0.15,
                0.2,
                0.25,
                0.3,
                0.35,
                0.4,
                0.45,
                0.5,
                0.55,
                0.6,
                0.65,
                0.7,
                0.75,
                0.8,
                0.85,
                0.9,
                0.95,
                1.0,
              ])
                Expanded(
                  child: Container(
                    height: sequence1.transform(t) / 2 + 5,
                    margin: EdgeInsets.symmetric(horizontal: 0.5),
                    color: Color(0xFF2196F3),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.0),

          // Visualize sequence2 as bar chart
          Text(
            'Sequence: 0→100→50→200',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
          ),
          SizedBox(height: 8.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (final t in [
                0.0,
                0.05,
                0.1,
                0.15,
                0.2,
                0.25,
                0.3,
                0.35,
                0.4,
                0.45,
                0.5,
                0.55,
                0.6,
                0.65,
                0.7,
                0.75,
                0.8,
                0.85,
                0.9,
                0.95,
                1.0,
              ])
                Expanded(
                  child: Container(
                    height: sequence2.transform(t) / 4 + 5,
                    margin: EdgeInsets.symmetric(horizontal: 0.5),
                    color: Color(0xFF4CAF50),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.0),

          // Visualize four-item sequence
          Text(
            'Sequence: 0→50→100→25→75',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
          ),
          SizedBox(height: 8.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (final t in [
                0.0,
                0.05,
                0.1,
                0.15,
                0.2,
                0.25,
                0.3,
                0.35,
                0.4,
                0.45,
                0.5,
                0.55,
                0.6,
                0.65,
                0.7,
                0.75,
                0.8,
                0.85,
                0.9,
                0.95,
                1.0,
              ])
                Expanded(
                  child: Container(
                    height: fourSequence.transform(t) / 2 + 5,
                    margin: EdgeInsets.symmetric(horizontal: 0.5),
                    color: Color(0xFFFF9800),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.0),

          // Color sequence visualization
          Text(
            'Color Sequence: Red→Green→Blue',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              for (final t in [
                0.0,
                0.1,
                0.2,
                0.3,
                0.4,
                0.5,
                0.6,
                0.7,
                0.8,
                0.9,
                1.0,
              ])
                Expanded(
                  child: Container(
                    height: 30.0,
                    color: colorSequence.transform(t) ?? Color(0xFF000000),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.0),

          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFF5F5F5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TweenSequence Summary:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
                ),
                SizedBox(height: 4.0),
                Text(
                  '• Composes multiple Tweens into one animation',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '• Each item has a weight controlling its time share',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '• Can chain with CurveTween for per-segment curves',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '• Works with any type: double, Color, etc.',
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
