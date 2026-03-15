// D4rt test script: Tests MatrixUtils from painting
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:math' as math;
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MatrixUtils test executing');

  // ========== MATRIXUTILS ==========
  print('--- MatrixUtils Tests ---');

  // Test MatrixUtils.transformPoint
  final identity = Matrix4.identity();
  final point = Offset(10.0, 20.0);
  final transformedPoint = MatrixUtils.transformPoint(identity, point);
  print('transformPoint with identity: $transformedPoint');

  // Test with translation
  final translated = Matrix4.translationValues(100.0, 200.0, 0.0);
  final translatedPoint = MatrixUtils.transformPoint(translated, point);
  print('transformPoint with translate(100,200): $translatedPoint');

  // Test with scaling
  final scaled = Matrix4.diagonal3Values(2.0, 3.0, 1.0);
  final scaledPoint = MatrixUtils.transformPoint(scaled, point);
  print('transformPoint with scale(2,3): $scaledPoint');

  // Test MatrixUtils.transformRect
  final rect = Rect.fromLTWH(10.0, 20.0, 100.0, 50.0);
  final identityRect = MatrixUtils.transformRect(identity, rect);
  print('transformRect with identity: $identityRect');

  final translatedRect = MatrixUtils.transformRect(translated, rect);
  print('transformRect with translate(100,200): $translatedRect');

  final scaledRect = MatrixUtils.transformRect(scaled, rect);
  print('transformRect with scale(2,3): $scaledRect');

  // Test MatrixUtils.getAsTranslation
  final translationOnly = Matrix4.translationValues(50.0, 75.0, 0.0);
  final asTranslation = MatrixUtils.getAsTranslation(translationOnly);
  print('getAsTranslation (translation): $asTranslation');

  final notTranslation = Matrix4.rotationZ(math.pi / 4);
  final asTranslation2 = MatrixUtils.getAsTranslation(notTranslation);
  print('getAsTranslation (rotation): $asTranslation2');

  // Test MatrixUtils.getAsScale
  final scaleOnly = Matrix4.diagonal3Values(2.0, 3.0, 1.0);
  final asScale = MatrixUtils.getAsScale(scaleOnly);
  print('getAsScale (scale): $asScale');

  final notScale = Matrix4.rotationZ(math.pi / 4);
  final asScale2 = MatrixUtils.getAsScale(notScale);
  print('getAsScale (rotation): $asScale2');

  // Test MatrixUtils.isIdentity
  print('isIdentity (identity): ${MatrixUtils.isIdentity(identity)}');
  print('isIdentity (translated): ${MatrixUtils.isIdentity(translated)}');

  // Test MatrixUtils.forceToPoint
  final forceMatrix = MatrixUtils.forceToPoint(Offset(100.0, 200.0));
  print('forceToPoint(100,200) type: ${forceMatrix.runtimeType}');
  final forcedPoint = MatrixUtils.transformPoint(forceMatrix, Offset(0.0, 0.0));
  print('forceToPoint applied to origin: $forcedPoint');

  // Test combining transforms
  final combined = Matrix4.identity()
    ..translate(50.0, 50.0)
    ..scale(2.0, 2.0);
  final combinedPoint = MatrixUtils.transformPoint(
    combined,
    Offset(10.0, 10.0),
  );
  print('Combined translate+scale on (10,10): $combinedPoint');

  print('All MatrixUtils tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'MatrixUtils Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text('Identity point: $transformedPoint'),
            Text('Translated point: $translatedPoint'),
            Text('Scaled point: $scaledPoint'),
            SizedBox(height: 8.0),
            Transform(
              transform: Matrix4.rotationZ(0.1),
              child: Container(
                color: Colors.blue,
                width: 100.0,
                height: 50.0,
                child: Center(
                  child: Text('Rotated', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
