// D4rt test script: Tests Animatable concepts using Tween, chain(), evaluate() from animation
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Animatable test executing');

  // ========== TWEEN AS ANIMATABLE ==========
  print('--- Tween as Animatable ---');

  // Tween extends Animatable, so we can use Animatable methods
  final tween = Tween<double>(begin: 0.0, end: 100.0);
  print('Tween<double>(0 -> 100):');

  // evaluate() takes an Animation<double> and returns the interpolated value
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final anim = AlwaysStoppedAnimation<double>(t);
    final result = tween.evaluate(anim);
    print('  evaluate($t): ${result.toStringAsFixed(2)}');
  }

  // transform() takes a double directly
  print('Using transform():');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    print('  transform($t): ${tween.transform(t).toStringAsFixed(2)}');
  }

  // ========== CHAIN WITH CURVETWEEN ==========
  print('--- chain() with CurveTween ---');

  // CurveTween applies a curve transformation
  final curveTween = CurveTween(curve: Curves.easeInOut);
  print('CurveTween(easeInOut):');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    print('  transform($t): ${curveTween.transform(t).toStringAsFixed(4)}');
  }

  // Chain Tween with CurveTween: first applies curve, then tween
  final chained = tween.chain(CurveTween(curve: Curves.easeInOut));
  print('Tween(0->100).chain(CurveTween(easeInOut)):');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    print('  transform($t): ${chained.transform(t).toStringAsFixed(2)}');
  }

  // Chain with easeIn
  final chainedEaseIn = tween.chain(CurveTween(curve: Curves.easeIn));
  print('Tween(0->100).chain(CurveTween(easeIn)):');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    print('  transform($t): ${chainedEaseIn.transform(t).toStringAsFixed(2)}');
  }

  // Chain with easeOut
  final chainedEaseOut = tween.chain(CurveTween(curve: Curves.easeOut));
  print('Tween(0->100).chain(CurveTween(easeOut)):');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    print('  transform($t): ${chainedEaseOut.transform(t).toStringAsFixed(2)}');
  }

  // Chain with bounceOut
  final chainedBounce = tween.chain(CurveTween(curve: Curves.bounceOut));
  print('Tween(0->100).chain(CurveTween(bounceOut)):');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    print('  transform($t): ${chainedBounce.transform(t).toStringAsFixed(2)}');
  }

  // ========== MULTIPLE CHAINS ==========
  print('--- Multiple chain() calls ---');

  // chain() can be called multiple times
  final doubleChained = Tween<double>(begin: 0.0, end: 200.0)
      .chain(CurveTween(curve: Curves.easeIn))
      .chain(CurveTween(curve: Curves.easeOut));
  print('Tween(0->200).chain(easeIn).chain(easeOut):');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    print('  transform($t): ${doubleChained.transform(t).toStringAsFixed(2)}');
  }

  // ========== CURVETWEEN STANDALONE ==========
  print('--- CurveTween standalone ---');

  final curves = [
    ('linear', Curves.linear),
    ('easeIn', Curves.easeIn),
    ('easeOut', Curves.easeOut),
    ('easeInOut', Curves.easeInOut),
    ('decelerate', Curves.decelerate),
    ('fastOutSlowIn', Curves.fastOutSlowIn),
  ];

  for (final entry in curves) {
    final name = entry.$1;
    final curve = entry.$2;
    final ct = CurveTween(curve: curve);
    final values = [
      0.0,
      0.25,
      0.5,
      0.75,
      1.0,
    ].map((t) => ct.transform(t).toStringAsFixed(3)).join(', ');
    print('CurveTween($name): [$values]');
  }

  // ========== EVALUATE WITH ANIMATION ==========
  print('--- evaluate() with Animation ---');

  // evaluate uses an Animation<double> as input
  final evalTween = Tween<double>(begin: -50.0, end: 50.0);
  final chainedEval = evalTween.chain(CurveTween(curve: Curves.easeInOut));

  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final anim = AlwaysStoppedAnimation<double>(t);
    final result = chainedEval.evaluate(anim);
    print('  chained.evaluate($t): ${result.toStringAsFixed(2)}');
  }

  // ========== COLORTWEEN CHAIN ==========
  print('--- ColorTween chain() ---');

  final colorTween = ColorTween(
    begin: Color(0xFFFF0000),
    end: Color(0xFF0000FF),
  );
  final colorChained = colorTween.chain(CurveTween(curve: Curves.easeInOut));
  print('ColorTween(red->blue).chain(easeInOut):');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final anim = AlwaysStoppedAnimation<double>(t);
    print('  evaluate($t): ${colorChained.evaluate(anim)}');
  }

  // ========== INTTWEEN CHAIN ==========
  print('--- IntTween chain() ---');

  final intTween = IntTween(begin: 0, end: 255);
  final intChained = intTween.chain(CurveTween(curve: Curves.easeIn));
  print('IntTween(0->255).chain(easeIn):');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final anim = AlwaysStoppedAnimation<double>(t);
    print('  evaluate($t): ${intChained.evaluate(anim)}');
  }

  // ========== WIDGET TREE ==========
  return Container(
    padding: EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Animatable Test Results',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1565C0),
            ),
          ),
          SizedBox(height: 16.0),

          // Visualize linear vs curved tween
          Text(
            'Linear Tween (0 → 100):',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
          ),
          SizedBox(height: 4.0),
          _tweenBarChart(tween, Color(0xFF2196F3)),
          SizedBox(height: 12.0),

          Text(
            'Chained with easeInOut:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
          ),
          SizedBox(height: 4.0),
          _tweenBarChart(chained, Color(0xFF4CAF50)),
          SizedBox(height: 12.0),

          Text(
            'Chained with easeIn:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
          ),
          SizedBox(height: 4.0),
          _tweenBarChart(chainedEaseIn, Color(0xFFFF9800)),
          SizedBox(height: 12.0),

          Text(
            'Chained with easeOut:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
          ),
          SizedBox(height: 4.0),
          _tweenBarChart(chainedEaseOut, Color(0xFF9C27B0)),
          SizedBox(height: 12.0),

          Text(
            'Chained with bounceOut:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
          ),
          SizedBox(height: 4.0),
          _tweenBarChart(chainedBounce, Color(0xFFE91E63)),
          SizedBox(height: 16.0),

          // Color gradient visualization
          Text(
            'ColorTween chained with easeInOut:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
          ),
          SizedBox(height: 4.0),
          Row(
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
                    height: 24.0,
                    color:
                        colorChained.evaluate(
                          AlwaysStoppedAnimation<double>(t),
                        ) ??
                        Color(0xFF000000),
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
                  'Animatable Summary:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
                ),
                SizedBox(height: 4.0),
                Text(
                  '• Animatable is the base class for Tween',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '• evaluate() maps Animation<double> to a value',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '• transform() maps a raw double (0..1) to a value',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '• chain() composes Animatables (e.g., CurveTween)',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '• CurveTween wraps a Curve as an Animatable',
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

Widget _tweenBarChart(Animatable<double> animatable, Color color) {
  return Row(
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
            height: animatable.transform(t) / 2 + 5,
            margin: EdgeInsets.symmetric(horizontal: 0.5),
            color: color,
          ),
        ),
    ],
  );
}
