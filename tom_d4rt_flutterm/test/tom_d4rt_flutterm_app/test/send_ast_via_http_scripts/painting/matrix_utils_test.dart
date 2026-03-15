// D4rt test script: Tests MatrixUtils static methods from painting
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart';

dynamic build(BuildContext context) {
  print('MatrixUtils test executing');
  final results = <String>[];

  // ========== MatrixUtils Tests ==========
  print('Testing MatrixUtils static methods...');

  // Test 1: MatrixUtils.forceToPoint
  final matrix1 = Matrix4.identity();
  final point1 = MatrixUtils.transformPoint(matrix1, Offset(10.0, 20.0));
  assert(point1 == Offset(10.0, 20.0), 'Identity should not change point');
  results.add('MatrixUtils.transformPoint identity: $point1');
  print('MatrixUtils.transformPoint: $point1');

  // Test 2: MatrixUtils.transformPoint with translation
  final matrix2 = Matrix4.translationValues(100.0, 50.0, 0.0);
  final point2 = MatrixUtils.transformPoint(matrix2, Offset(10.0, 20.0));
  assert(point2.dx == 110.0, 'Translated X should be 110.0');
  assert(point2.dy == 70.0, 'Translated Y should be 70.0');
  results.add('MatrixUtils.transformPoint translated: $point2');
  print('MatrixUtils.transformPoint translated: $point2');

  // Test 3: MatrixUtils.transformPoint with scale
  final matrix3 = Matrix4.diagonal3Values(2.0, 2.0, 1.0);
  final point3 = MatrixUtils.transformPoint(matrix3, Offset(10.0, 20.0));
  assert(point3.dx == 20.0, 'Scaled X should be 20.0');
  assert(point3.dy == 40.0, 'Scaled Y should be 40.0');
  results.add('MatrixUtils.transformPoint scaled: $point3');
  print('MatrixUtils.transformPoint scaled: $point3');

  // Test 4: MatrixUtils.transformRect with identity
  final rect4 = Rect.fromLTWH(10, 20, 100, 50);
  final transformedRect = MatrixUtils.transformRect(Matrix4.identity(), rect4);
  assert(transformedRect == rect4, 'Identity should not change rect');
  results.add('MatrixUtils.transformRect identity: $transformedRect');
  print('MatrixUtils.transformRect: $transformedRect');

  // Test 5: MatrixUtils.transformRect with translation
  final matrix5 = Matrix4.translationValues(10.0, 10.0, 0.0);
  final rect5 = Rect.fromLTWH(0, 0, 50, 50);
  final transRect = MatrixUtils.transformRect(matrix5, rect5);
  assert(transRect.left == 10.0, 'Translated rect left should be 10.0');
  results.add('MatrixUtils.transformRect translated: left=${transRect.left}');
  print('MatrixUtils.transformRect translated: $transRect');

  // Test 6: MatrixUtils.inverseTransformRect
  final matrix6 = Matrix4.translationValues(20.0, 30.0, 0.0);
  final rect6 = Rect.fromLTWH(20, 30, 100, 100);
  final inverseRect = MatrixUtils.inverseTransformRect(matrix6, rect6);
  assert(inverseRect.left == 0.0, 'Inverse rect left should be 0.0');
  results.add('MatrixUtils.inverseTransformRect: left=${inverseRect.left}');
  print('MatrixUtils.inverseTransformRect: $inverseRect');

  // Test 7: MatrixUtils.getAsTranslation
  final translationMatrix = Matrix4.translationValues(50.0, 75.0, 0.0);
  final translation = MatrixUtils.getAsTranslation(translationMatrix);
  assert(translation != null, 'Should extract translation');
  assert(translation!.dx == 50.0, 'Translation dx should be 50.0');
  results.add('MatrixUtils.getAsTranslation: $translation');
  print('MatrixUtils.getAsTranslation: $translation');

  // Test 8: MatrixUtils.getAsTranslation returns null for non-translation
  final rotationMatrix = Matrix4.rotationZ(0.5);
  final notTranslation = MatrixUtils.getAsTranslation(rotationMatrix);
  assert(notTranslation == null, 'Non-translation should return null');
  results.add('MatrixUtils.getAsTranslation rotation: ${notTranslation}');
  print('MatrixUtils.getAsTranslation for rotation: null');

  // Test 9: MatrixUtils.getAsScale
  final scaleMatrix = Matrix4.diagonal3Values(2.5, 2.5, 1.0);
  final scale = MatrixUtils.getAsScale(scaleMatrix);
  assert(scale != null, 'Should extract scale');
  assert(scale == 2.5, 'Scale should be 2.5');
  results.add('MatrixUtils.getAsScale: $scale');
  print('MatrixUtils.getAsScale: $scale');

  // Test 10: MatrixUtils.matrixEquals
  final matrixA = Matrix4.identity();
  final matrixB = Matrix4.identity();
  final equals = MatrixUtils.matrixEquals(matrixA, matrixB);
  assert(equals == true, 'Identity matrices should be equal');
  results.add('MatrixUtils.matrixEquals: $equals');
  print('MatrixUtils.matrixEquals: $equals');

  // Test 11: MatrixUtils.isIdentity
  final identityCheck = MatrixUtils.isIdentity(Matrix4.identity());
  assert(identityCheck == true, 'Identity matrix should be identity');
  results.add('MatrixUtils.isIdentity: $identityCheck');
  print('MatrixUtils.isIdentity: $identityCheck');

  // Test 12: MatrixUtils.isIdentity false case
  final notIdentity = MatrixUtils.isIdentity(
    Matrix4.translationValues(1, 0, 0),
  );
  assert(notIdentity == false, 'Translated matrix should not be identity');
  results.add('MatrixUtils.isIdentity translated: $notIdentity');
  print('MatrixUtils.isIdentity for translated: $notIdentity');

  // Test 13: Matrix4 operations for utility context
  final combined = Matrix4.identity()
    ..translate(10.0, 20.0)
    ..scale(2.0);
  final combinedPoint = MatrixUtils.transformPoint(combined, Offset.zero);
  results.add('Combined transform: $combinedPoint');
  print('Combined matrix transform: $combinedPoint');

  print('MatrixUtils test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MatrixUtils Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
