// D4rt test script: Tests Tween and Animation classes from animation
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Animation tween test executing');

  // ========== TWEEN ==========
  print('--- Tween Tests ---');

  // Test Tween<double>
  final doubleTween = Tween<double>(begin: 0.0, end: 100.0);
  print('DoubleTween: begin=${doubleTween.begin}, end=${doubleTween.end}');
  print('DoubleTween.lerp(0.0): ${doubleTween.lerp(0.0)}');
  print('DoubleTween.lerp(0.25): ${doubleTween.lerp(0.25)}');
  print('DoubleTween.lerp(0.5): ${doubleTween.lerp(0.5)}');
  print('DoubleTween.lerp(0.75): ${doubleTween.lerp(0.75)}');
  print('DoubleTween.lerp(1.0): ${doubleTween.lerp(1.0)}');

  // Test Tween with negative values
  final negativeTween = Tween<double>(begin: -50.0, end: 50.0);
  print('NegativeTween.lerp(0.5): ${negativeTween.lerp(0.5)}');

  // Test transform method
  print('DoubleTween.transform(0.5): ${doubleTween.transform(0.5)}');

  // ========== INTTWEEN ==========
  print('--- IntTween Tests ---');

  final intTween = IntTween(begin: 0, end: 10);
  print('IntTween: begin=${intTween.begin}, end=${intTween.end}');
  print('IntTween.lerp(0.0): ${intTween.lerp(0.0)}');
  print('IntTween.lerp(0.5): ${intTween.lerp(0.5)}');
  print('IntTween.lerp(0.75): ${intTween.lerp(0.75)}');
  print('IntTween.lerp(1.0): ${intTween.lerp(1.0)}');

  // ========== STEPTWEEN ==========
  print('--- StepTween Tests ---');

  final stepTween = StepTween(begin: 0, end: 10);
  print('StepTween: begin=${stepTween.begin}, end=${stepTween.end}');
  print('StepTween.lerp(0.0): ${stepTween.lerp(0.0)}');
  print('StepTween.lerp(0.49): ${stepTween.lerp(0.49)}');
  print('StepTween.lerp(0.5): ${stepTween.lerp(0.5)}');
  print('StepTween.lerp(0.99): ${stepTween.lerp(0.99)}');
  print('StepTween.lerp(1.0): ${stepTween.lerp(1.0)}');

  // ========== COLORTWEEN ==========
  print('--- ColorTween Tests ---');

  final colorTween = ColorTween(
    begin: Color(0xFFFF0000), // Red
    end: Color(0xFF0000FF), // Blue
  );
  print('ColorTween: begin=${colorTween.begin}, end=${colorTween.end}');
  print('ColorTween.lerp(0.0): ${colorTween.lerp(0.0)}');
  print('ColorTween.lerp(0.5): ${colorTween.lerp(0.5)}');
  print('ColorTween.lerp(1.0): ${colorTween.lerp(1.0)}');

  // Color with alpha
  final alphaTween = ColorTween(
    begin: Color(0x00FFFFFF), // Transparent white
    end: Color(0xFFFFFFFF), // Opaque white
  );
  print('AlphaTween.lerp(0.5): ${alphaTween.lerp(0.5)}');

  // ========== SIZETWEEN ==========
  print('--- SizeTween Tests ---');

  final sizeTween = SizeTween(begin: Size(0.0, 0.0), end: Size(100.0, 80.0));
  print('SizeTween: begin=${sizeTween.begin}, end=${sizeTween.end}');
  print('SizeTween.lerp(0.0): ${sizeTween.lerp(0.0)}');
  print('SizeTween.lerp(0.5): ${sizeTween.lerp(0.5)}');
  print('SizeTween.lerp(1.0): ${sizeTween.lerp(1.0)}');

  // ========== RECTTWEEN ==========
  print('--- RectTween Tests ---');

  final rectTween = RectTween(
    begin: Rect.fromLTWH(0.0, 0.0, 50.0, 50.0),
    end: Rect.fromLTWH(100.0, 100.0, 150.0, 150.0),
  );
  print('RectTween: begin=${rectTween.begin}');
  print('RectTween.lerp(0.5): ${rectTween.lerp(0.5)}');
  print('RectTween.lerp(1.0): ${rectTween.lerp(1.0)}');

  // ========== ALIGNMENTTWEEN ==========
  print('--- AlignmentTween Tests ---');

  final alignmentTween = AlignmentTween(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  print('AlignmentTween: begin=${alignmentTween.begin}');
  print('AlignmentTween.lerp(0.0): ${alignmentTween.lerp(0.0)}');
  print('AlignmentTween.lerp(0.5): ${alignmentTween.lerp(0.5)}');
  print('AlignmentTween.lerp(1.0): ${alignmentTween.lerp(1.0)}');

  // ========== ALIGNMENTGEOMETRYTWEEN ==========
  print('--- AlignmentGeometryTween Tests ---');

  final alignGeomTween = AlignmentGeometryTween(
    begin: AlignmentDirectional.topStart,
    end: AlignmentDirectional.bottomEnd,
  );
  print('AlignmentGeometryTween: begin=${alignGeomTween.begin}');
  print('AlignmentGeometryTween.lerp(0.5): ${alignGeomTween.lerp(0.5)}');

  // ========== DECORATIONTWEEN ==========
  print('--- DecorationTween Tests ---');

  final decorationTween = DecorationTween(
    begin: BoxDecoration(
      color: Color(0xFFFF0000),
      borderRadius: BorderRadius.circular(0.0),
    ),
    end: BoxDecoration(
      color: Color(0xFF0000FF),
      borderRadius: BorderRadius.circular(20.0),
    ),
  );
  print('DecorationTween: begin=${decorationTween.begin}');
  print('DecorationTween.lerp(0.5): ${decorationTween.lerp(0.5)}');

  // ========== EDGEINSETSTWEEN ==========
  print('--- EdgeInsetsTween Tests ---');

  final edgeInsetsTween = EdgeInsetsTween(
    begin: EdgeInsets.zero,
    end: EdgeInsets.all(20.0),
  );
  print('EdgeInsetsTween: begin=${edgeInsetsTween.begin}');
  print('EdgeInsetsTween.lerp(0.5): ${edgeInsetsTween.lerp(0.5)}');
  print('EdgeInsetsTween.lerp(1.0): ${edgeInsetsTween.lerp(1.0)}');

  // ========== EDGEINSETSGEOMETRYTWEEN ==========
  print('--- EdgeInsetsGeometryTween Tests ---');

  final edgeGeomTween = EdgeInsetsGeometryTween(
    begin: EdgeInsetsDirectional.zero,
    end: EdgeInsetsDirectional.all(30.0),
  );
  print('EdgeInsetsGeometryTween: begin=${edgeGeomTween.begin}');
  print('EdgeInsetsGeometryTween.lerp(0.5): ${edgeGeomTween.lerp(0.5)}');

  // ========== BORDERRADIUSTWEEN ==========
  print('--- BorderRadiusTween Tests ---');

  final borderRadiusTween = BorderRadiusTween(
    begin: BorderRadius.zero,
    end: BorderRadius.circular(25.0),
  );
  print('BorderRadiusTween: begin=${borderRadiusTween.begin}');
  print('BorderRadiusTween.lerp(0.5): ${borderRadiusTween.lerp(0.5)}');
  print('BorderRadiusTween.lerp(1.0): ${borderRadiusTween.lerp(1.0)}');

  // ========== BORDERTWEEN ==========
  print('--- BorderTween Tests ---');

  final borderTween = BorderTween(
    begin: Border.all(color: Color(0xFFFF0000), width: 1.0),
    end: Border.all(color: Color(0xFF0000FF), width: 4.0),
  );
  print('BorderTween: begin=${borderTween.begin}');
  print('BorderTween.lerp(0.5): ${borderTween.lerp(0.5)}');

  // ========== MATRIX4TWEEN ==========
  print('--- Matrix4Tween Tests ---');

  final matrix4Tween = Matrix4Tween(
    begin: Matrix4.identity(),
    end: Matrix4.identity()..translate(100.0, 50.0, 0.0),
  );
  print('Matrix4Tween: begin identity');
  print('Matrix4Tween.lerp(0.5) translates to 50, 25');

  // ========== TEXTSTYLETWEEN ==========
  print('--- TextStyleTween Tests ---');

  final textStyleTween = TextStyleTween(
    begin: TextStyle(fontSize: 12.0, color: Color(0xFFFF0000)),
    end: TextStyle(fontSize: 24.0, color: Color(0xFF0000FF)),
  );
  print('TextStyleTween: begin=${textStyleTween.begin}');
  print('TextStyleTween.lerp(0.5): ${textStyleTween.lerp(0.5)}');

  // ========== CONSTANTTWEEN ==========
  print('--- ConstantTween Tests ---');

  final constantTween = ConstantTween<double>(42.0);
  print('ConstantTween(42): lerp(0.0)=${constantTween.lerp(0.0)}');
  print('ConstantTween(42): lerp(0.5)=${constantTween.lerp(0.5)}');
  print('ConstantTween(42): lerp(1.0)=${constantTween.lerp(1.0)}');

  // ========== REVERSIBLE TWEEN ==========
  print('--- ReverseTween Tests ---');

  final reverseTween = ReverseTween<double>(doubleTween);
  print('ReverseTween of 0-100: lerp(0.0)=${reverseTween.lerp(0.0)}');
  print('ReverseTween of 0-100: lerp(0.5)=${reverseTween.lerp(0.5)}');
  print('ReverseTween of 0-100: lerp(1.0)=${reverseTween.lerp(1.0)}');

  // ========== TWEEN CHAIN ==========
  print('--- TweenSequence Tests ---');

  final sequence = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween<double>(begin: 0.0, end: 100.0),
      weight: 1.0,
    ),
    TweenSequenceItem(
      tween: Tween<double>(begin: 100.0, end: 50.0),
      weight: 1.0,
    ),
    TweenSequenceItem(
      tween: Tween<double>(begin: 50.0, end: 200.0),
      weight: 2.0,
    ),
  ]);
  print('TweenSequence at 0.0: ${sequence.transform(0.0)}');
  print('TweenSequence at 0.25: ${sequence.transform(0.25)}');
  print('TweenSequence at 0.5: ${sequence.transform(0.5)}');
  print('TweenSequence at 0.75: ${sequence.transform(0.75)}');
  print('TweenSequence at 1.0: ${sequence.transform(1.0)}');

  // ========== CURVED TWEEN ==========
  print('--- CurveTween Tests ---');

  final curveTween = CurveTween(curve: Curves.easeInOut);
  print('CurveTween(easeInOut) at 0.0: ${curveTween.transform(0.0)}');
  print('CurveTween(easeInOut) at 0.5: ${curveTween.transform(0.5)}');
  print('CurveTween(easeInOut) at 1.0: ${curveTween.transform(1.0)}');

  // Chained with regular tween
  print('Tween chained with CurveTween:');
  final chainedValue = doubleTween.transform(curveTween.transform(0.5));
  print('  doubleTween.transform(curvedT(0.5)): $chainedValue');

  print('Animation tween test completed');

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
              'Animation Tween Tests',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            Text(
              'Tween<double>(0, 100):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                for (final t in [0.0, 0.25, 0.5, 0.75, 1.0])
                  Expanded(
                    child: Column(
                      children: [
                        Text('t=${t}', style: TextStyle(fontSize: 10.0)),
                        Container(
                          height: doubleTween.lerp(t) / 2,
                          width: 30.0,
                          color: Color(0xFF2196F3),
                        ),
                        Text(
                          '${doubleTween.lerp(t).toInt()}',
                          style: TextStyle(fontSize: 10.0),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'ColorTween (Red → Blue):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                for (final t in [0.0, 0.25, 0.5, 0.75, 1.0])
                  Expanded(
                    child: Container(
                      height: 40.0,
                      margin: EdgeInsets.symmetric(horizontal: 2.0),
                      color: colorTween.lerp(t),
                      child: Center(
                        child: Text(
                          '${(t * 100).toInt()}%',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'SizeTween (0x0 → 100x80):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final t in [0.0, 0.25, 0.5, 0.75, 1.0])
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: sizeTween.lerp(t)!.width / 2,
                          height: sizeTween.lerp(t)!.height / 2,
                          color: Color(0xFF4CAF50),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          '${(t * 100).toInt()}%',
                          style: TextStyle(fontSize: 10.0),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'BorderRadiusTween (0 → 25):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                for (final t in [0.0, 0.25, 0.5, 0.75, 1.0])
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: Column(
                      children: [
                        Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFFF9800),
                            borderRadius:
                                borderRadiusTween.lerp(t) ?? BorderRadius.zero,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          '${(t * 100).toInt()}%',
                          style: TextStyle(fontSize: 10.0),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'AlignmentTween (TL → BR):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Container(
              width: 200.0,
              height: 100.0,
              color: Color(0xFFE0E0E0),
              child: Stack(
                children: [
                  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0])
                    Positioned(
                      left: 90.0 * t,
                      top: 40.0 * t,
                      child: Container(
                        width: 20.0,
                        height: 20.0,
                        decoration: BoxDecoration(
                          color: Color.lerp(
                            Color(0xFFE53935),
                            Color(0xFF9C27B0),
                            t,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${(t * 100).toInt()}',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 8.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            Text(
              'TweenSequence (0→100→50→200):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final t in [
                  0.0,
                  0.125,
                  0.25,
                  0.375,
                  0.5,
                  0.625,
                  0.75,
                  0.875,
                  1.0,
                ])
                  Expanded(
                    child: Container(
                      height: sequence.transform(t) / 4 + 10,
                      margin: EdgeInsets.symmetric(horizontal: 1.0),
                      color: Color(0xFF9C27B0),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
