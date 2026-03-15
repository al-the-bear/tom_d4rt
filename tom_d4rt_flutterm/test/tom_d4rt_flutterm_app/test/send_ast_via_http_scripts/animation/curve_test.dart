// D4rt test script: Tests Curve and CurvedAnimation from animation
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Animation curve test executing');

  // ========== CURVES ==========
  print('--- Curve Tests ---');

  // Test built-in curves
  final curves = [
    ('linear', Curves.linear),
    ('decelerate', Curves.decelerate),
    ('ease', Curves.ease),
    ('easeIn', Curves.easeIn),
    ('easeOut', Curves.easeOut),
    ('easeInOut', Curves.easeInOut),
    ('easeInSine', Curves.easeInSine),
    ('easeOutSine', Curves.easeOutSine),
    ('easeInOutSine', Curves.easeInOutSine),
    ('easeInQuad', Curves.easeInQuad),
    ('easeOutQuad', Curves.easeOutQuad),
    ('easeInOutQuad', Curves.easeInOutQuad),
    ('easeInCubic', Curves.easeInCubic),
    ('easeOutCubic', Curves.easeOutCubic),
    ('easeInOutCubic', Curves.easeInOutCubic),
    ('easeInQuart', Curves.easeInQuart),
    ('easeOutQuart', Curves.easeOutQuart),
    ('easeInOutQuart', Curves.easeInOutQuart),
    ('easeInQuint', Curves.easeInQuint),
    ('easeOutQuint', Curves.easeOutQuint),
    ('easeInOutQuint', Curves.easeInOutQuint),
    ('easeInExpo', Curves.easeInExpo),
    ('easeOutExpo', Curves.easeOutExpo),
    ('easeInOutExpo', Curves.easeInOutExpo),
    ('easeInCirc', Curves.easeInCirc),
    ('easeOutCirc', Curves.easeOutCirc),
    ('easeInOutCirc', Curves.easeInOutCirc),
    ('easeInBack', Curves.easeInBack),
    ('easeOutBack', Curves.easeOutBack),
    ('easeInOutBack', Curves.easeInOutBack),
    ('bounceIn', Curves.bounceIn),
    ('bounceOut', Curves.bounceOut),
    ('bounceInOut', Curves.bounceInOut),
    ('elasticIn', Curves.elasticIn),
    ('elasticOut', Curves.elasticOut),
    ('elasticInOut', Curves.elasticInOut),
    ('fastOutSlowIn', Curves.fastOutSlowIn),
    ('slowMiddle', Curves.slowMiddle),
    ('fastLinearToSlowEaseIn', Curves.fastLinearToSlowEaseIn),
    ('fastEaseInToSlowEaseOut', Curves.fastEaseInToSlowEaseOut),
  ];

  // Test curve transformations at different points
  print('Testing curves at t=0, 0.25, 0.5, 0.75, 1.0:');
  for (final curveData in curves.take(10)) {
    final name = curveData.$1;
    final curve = curveData.$2;
    final values = [
      0.0,
      0.25,
      0.5,
      0.75,
      1.0,
    ].map((t) => curve.transform(t).toStringAsFixed(3)).join(', ');
    print('$name: [$values]');
  }

  // Test linear curve (identity)
  print('--- Linear Curve ---');
  final linear = Curves.linear;
  print('Linear at 0.0: ${linear.transform(0.0)}');
  print('Linear at 0.5: ${linear.transform(0.5)}');
  print('Linear at 1.0: ${linear.transform(1.0)}');

  // Test ease curve
  print('--- Ease Curve ---');
  final ease = Curves.ease;
  print('Ease at 0.0: ${ease.transform(0.0)}');
  print('Ease at 0.25: ${ease.transform(0.25)}');
  print('Ease at 0.5: ${ease.transform(0.5)}');
  print('Ease at 0.75: ${ease.transform(0.75)}');
  print('Ease at 1.0: ${ease.transform(1.0)}');

  // Test bounce curve
  print('--- Bounce Curves ---');
  final bounceOut = Curves.bounceOut;
  print('BounceOut at 0.0: ${bounceOut.transform(0.0)}');
  print('BounceOut at 0.5: ${bounceOut.transform(0.5)}');
  print('BounceOut at 0.8: ${bounceOut.transform(0.8)}');
  print('BounceOut at 0.95: ${bounceOut.transform(0.95)}');
  print('BounceOut at 1.0: ${bounceOut.transform(1.0)}');

  // Test elastic curve (can exceed 0-1 range)
  print('--- Elastic Curves ---');
  final elasticOut = Curves.elasticOut;
  print('ElasticOut at 0.0: ${elasticOut.transform(0.0)}');
  print('ElasticOut at 0.25: ${elasticOut.transform(0.25)}');
  print('ElasticOut at 0.5: ${elasticOut.transform(0.5)}');
  print('ElasticOut at 0.75: ${elasticOut.transform(0.75)}');
  print('ElasticOut at 1.0: ${elasticOut.transform(1.0)}');

  // Test easeInBack curve (can go negative)
  print('--- EaseInBack Curve ---');
  final easeInBack = Curves.easeInBack;
  print('EaseInBack at 0.0: ${easeInBack.transform(0.0)}');
  print('EaseInBack at 0.25: ${easeInBack.transform(0.25)}'); // Goes negative
  print('EaseInBack at 0.5: ${easeInBack.transform(0.5)}');
  print('EaseInBack at 1.0: ${easeInBack.transform(1.0)}');

  // ========== CUBIC CURVE ==========
  print('--- Cubic Curve ---');

  // Standard cubic bezier (like CSS ease)
  final customCubic = Cubic(0.25, 0.1, 0.25, 1.0);
  print('Custom Cubic at 0.0: ${customCubic.transform(0.0)}');
  print('Custom Cubic at 0.5: ${customCubic.transform(0.5)}');
  print('Custom Cubic at 1.0: ${customCubic.transform(1.0)}');

  // Material design standard easing
  final materialStandard = Cubic(0.4, 0.0, 0.2, 1.0);
  print('Material Standard at 0.5: ${materialStandard.transform(0.5)}');

  // Material design decelerate
  final materialDecel = Cubic(0.0, 0.0, 0.2, 1.0);
  print('Material Decelerate at 0.5: ${materialDecel.transform(0.5)}');

  // Material design accelerate
  final materialAccel = Cubic(0.4, 0.0, 1.0, 1.0);
  print('Material Accelerate at 0.5: ${materialAccel.transform(0.5)}');

  // ========== INTERVAL ==========
  print('--- Interval Curve ---');

  final interval = Interval(0.25, 0.75);
  print('Interval(0.25, 0.75) at 0.0: ${interval.transform(0.0)}');
  print('Interval(0.25, 0.75) at 0.25: ${interval.transform(0.25)}');
  print('Interval(0.25, 0.75) at 0.5: ${interval.transform(0.5)}');
  print('Interval(0.25, 0.75) at 0.75: ${interval.transform(0.75)}');
  print('Interval(0.25, 0.75) at 1.0: ${interval.transform(1.0)}');

  // Interval with curve
  final intervalEased = Interval(0.0, 0.5, curve: Curves.easeOut);
  print('Interval with easeOut at 0.25: ${intervalEased.transform(0.25)}');
  print('Interval with easeOut at 0.5: ${intervalEased.transform(0.5)}');

  // ========== THRESHOLD ==========
  print('--- Threshold Curve ---');

  final threshold = Threshold(0.5);
  print('Threshold(0.5) at 0.0: ${threshold.transform(0.0)}');
  print('Threshold(0.5) at 0.49: ${threshold.transform(0.49)}');
  print('Threshold(0.5) at 0.5: ${threshold.transform(0.5)}');
  print('Threshold(0.5) at 0.51: ${threshold.transform(0.51)}');
  print('Threshold(0.5) at 1.0: ${threshold.transform(1.0)}');

  // ========== SAWTOOTH ==========
  print('--- SawTooth Curve ---');

  final sawTooth = SawTooth(3);
  print('SawTooth(3) at 0.0: ${sawTooth.transform(0.0)}');
  print('SawTooth(3) at 0.167: ${sawTooth.transform(0.167)}');
  print('SawTooth(3) at 0.333: ${sawTooth.transform(0.333)}');
  print('SawTooth(3) at 0.5: ${sawTooth.transform(0.5)}');
  print('SawTooth(3) at 0.667: ${sawTooth.transform(0.667)}');
  print('SawTooth(3) at 1.0: ${sawTooth.transform(1.0)}');

  // ========== FLIPPED CURVE ==========
  print('--- FlippedCurve ---');

  final flipped = FlippedCurve(Curves.easeIn);
  print('FlippedCurve(easeIn) at 0.0: ${flipped.transform(0.0)}');
  print('FlippedCurve(easeIn) at 0.5: ${flipped.transform(0.5)}');
  print('FlippedCurve(easeIn) at 1.0: ${flipped.transform(1.0)}');

  // Compare with original
  print('Original easeIn at 0.25: ${Curves.easeIn.transform(0.25)}');
  print('Flipped easeIn at 0.25: ${flipped.transform(0.25)}');

  // ========== ELASTIC IN/OUT CURVES ==========
  print('--- ElasticInOutCurve ---');

  final elasticInOut = ElasticInOutCurve();
  print('ElasticInOutCurve at 0.0: ${elasticInOut.transform(0.0)}');
  print('ElasticInOutCurve at 0.25: ${elasticInOut.transform(0.25)}');
  print('ElasticInOutCurve at 0.5: ${elasticInOut.transform(0.5)}');
  print('ElasticInOutCurve at 0.75: ${elasticInOut.transform(0.75)}');
  print('ElasticInOutCurve at 1.0: ${elasticInOut.transform(1.0)}');

  // Custom period
  final elasticCustom = ElasticInOutCurve(0.6);
  print('ElasticInOutCurve(0.6) at 0.5: ${elasticCustom.transform(0.5)}');

  print('Animation curve test completed');

  // Return a visual representation
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Animation Curve Tests',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            Text(
              'Curve Comparison (t=0.5):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),

            // Visual bars showing curve values at t=0.5
            ...[
              'linear',
              'ease',
              'easeIn',
              'easeOut',
              'easeInOut',
              'bounceOut',
              'elasticOut',
            ].map((name) {
              final curve = {
                'linear': Curves.linear,
                'ease': Curves.ease,
                'easeIn': Curves.easeIn,
                'easeOut': Curves.easeOut,
                'easeInOut': Curves.easeInOut,
                'bounceOut': Curves.bounceOut,
                'elasticOut': Curves.elasticOut,
              }[name]!;
              final value = curve.transform(0.5);
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  children: [
                    Container(
                      width: 80.0,
                      child: Text(name, style: TextStyle(fontSize: 12.0)),
                    ),
                    Expanded(
                      child: Container(
                        height: 20.0,
                        child: Stack(
                          children: [
                            Container(color: Color(0xFFE0E0E0)),
                            Positioned(
                              left: 0.0,
                              top: 0.0,
                              bottom: 0.0,
                              width: (value.clamp(0.0, 1.5) * 150.0).abs(),
                              child: Container(
                                color: value < 0.0
                                    ? Color(0xFFE53935)
                                    : Color(0xFF2196F3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 50.0,
                      child: Text(
                        value.toStringAsFixed(2),
                        style: TextStyle(fontSize: 10.0),
                      ),
                    ),
                  ],
                ),
              );
            }),
            SizedBox(height: 16.0),

            Text(
              'Interval Examples:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),

            Row(
              children: [
                Container(
                  width: 200.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFE0E0E0),
                        Color(0xFF2196F3),
                        Color(0xFFE0E0E0),
                      ],
                      stops: [0.25, 0.5, 0.75],
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Text('Interval(0.25, 0.75)', style: TextStyle(fontSize: 10.0)),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Container(
                  width: 200.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF2196F3), Color(0xFFE0E0E0)],
                      stops: [0.5, 0.5],
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Text('Interval(0.0, 0.5)', style: TextStyle(fontSize: 10.0)),
              ],
            ),
            SizedBox(height: 16.0),

            Text('Threshold:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Row(
              children: [
                Container(
                  width: 100.0,
                  height: 30.0,
                  color: Color(0xFFE0E0E0),
                  child: Center(
                    child: Text('Before', style: TextStyle(fontSize: 10.0)),
                  ),
                ),
                Container(
                  width: 100.0,
                  height: 30.0,
                  color: Color(0xFF2196F3),
                  child: Center(
                    child: Text(
                      'After',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Text('Threshold(0.5)', style: TextStyle(fontSize: 10.0)),
              ],
            ),
            SizedBox(height: 16.0),

            Text('SawTooth(3):', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Container(
              width: 210.0,
              height: 40.0,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFE0E0E0), Color(0xFF2196F3)],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFE0E0E0), Color(0xFF2196F3)],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFE0E0E0), Color(0xFF2196F3)],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
