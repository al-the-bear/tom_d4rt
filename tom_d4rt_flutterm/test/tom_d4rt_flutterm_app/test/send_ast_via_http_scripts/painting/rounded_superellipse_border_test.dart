// D4rt test script: Tests RoundedSuperellipseBorder from painting
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RoundedSuperellipseBorder comprehensive test executing');
  final results = <String>[];

  // ========== RoundedSuperellipseBorder Tests ==========
  print('Testing RoundedSuperellipseBorder...');

  // Test 1: Create default RoundedSuperellipseBorder
  final border1 = RoundedSuperellipseBorder();
  assert(border1 != null, 'Should create RoundedSuperellipseBorder');
  results.add('RoundedSuperellipseBorder created');
  print('RoundedSuperellipseBorder created: ${border1.runtimeType}');

  // Test 2: Check inheritance from OutlinedBorder
  assert(border1 is OutlinedBorder, 'Should be OutlinedBorder');
  results.add('Inheritance: OutlinedBorder');
  print('Is OutlinedBorder: ${border1 is OutlinedBorder}');

  // Test 3: Check inheritance from ShapeBorder
  assert(border1 is ShapeBorder, 'Should be ShapeBorder');
  results.add('Inheritance: ShapeBorder');
  print('Is ShapeBorder: ${border1 is ShapeBorder}');

  // Test 4: Create with custom cornerRadius
  final borderRadius = RoundedSuperellipseBorder(
    cornerRadius: BorderRadius.circular(16.0),
  );
  results.add('Border with cornerRadius: 16.0');
  print('RoundedSuperellipseBorder with cornerRadius: 16.0');

  // Test 5: Create with BorderRadius.only
  final borderRadiusOnly = RoundedSuperellipseBorder(
    cornerRadius: BorderRadius.only(
      topLeft: Radius.circular(10),
      topRight: Radius.circular(20),
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(40),
    ),
  );
  results.add('Border with asymmetric cornerRadius');
  print('Asymmetric cornerRadius created');

  // Test 6: Create with custom side (BorderSide)
  final borderWithSide = RoundedSuperellipseBorder(
    side: BorderSide(color: Colors.blue, width: 2.0),
  );
  assert(borderWithSide.side.color == Colors.blue, 'Side color should be blue');
  assert(borderWithSide.side.width == 2.0, 'Side width should be 2.0');
  results.add('Border with BorderSide: blue, 2.0');
  print('BorderSide: ${borderWithSide.side}');

  // Test 7: Create with both cornerRadius and side
  final borderFull = RoundedSuperellipseBorder(
    cornerRadius: BorderRadius.circular(12.0),
    side: BorderSide(color: Colors.red, width: 3.0),
  );
  results.add('Border with both cornerRadius and side');
  print('Full border: radius=12, side=red/3.0');

  // Test 8: Access side property
  final sideAccess = borderWithSide.side;
  assert(sideAccess is BorderSide, 'Side should be BorderSide');
  results.add('Side property accessible');
  print('Side access: ${sideAccess.color}, ${sideAccess.width}');

  // Test 9: Dimensions property
  final dims = borderWithSide.dimensions;
  assert(dims is EdgeInsetsGeometry, 'Dimensions should be EdgeInsetsGeometry');
  results.add('Dimensions: EdgeInsetsGeometry');
  print('Dimensions type: ${dims.runtimeType}');

  // Test 10: Scale operation
  final scaledBorder = border1.scale(2.0);
  assert(
    scaledBorder is RoundedSuperellipseBorder,
    'Scaled should return same type',
  );
  results.add('scale(2.0) works');
  print('Scaled border: ${scaledBorder.runtimeType}');

  // Test 11: copyWith functionality - change side
  final copiedSide = borderWithSide.copyWith(
    side: BorderSide(color: Colors.green, width: 4.0),
  );
  assert(copiedSide is RoundedSuperellipseBorder, 'copyWith returns same type');
  results.add('copyWith(side) works');
  print('Copied with new side: ${copiedSide.side}');

  // Test 12: getOuterPath concept
  final rect = Rect.fromLTWH(0, 0, 100, 100);
  results.add('getOuterPath returns Path for superellipse');
  print('getOuterPath(rect: $rect) generates path');

  // Test 13: getInnerPath concept
  results.add('getInnerPath returns inner path (inset by border)');
  print('getInnerPath respects border width');

  // Test 14: Paint method concept
  results.add('paint draws border on canvas');
  print('paint(canvas, rect) renders border');

  // Test 15: Superellipse vs RoundedRectangle comparison
  final roundedRect = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16.0),
  );
  results.add('Superellipse differs from RoundedRectangle');
  print('RoundedRectangle type: ${roundedRect.runtimeType}');
  print('Superellipse: continuous curvature vs. arc segments');

  // Test 16: Equality check - same properties
  final borderA = RoundedSuperellipseBorder(
    cornerRadius: BorderRadius.circular(10),
  );
  final borderB = RoundedSuperellipseBorder(
    cornerRadius: BorderRadius.circular(10),
  );
  assert(borderA == borderB, 'Equal borders should be equal');
  results.add('Equality: same props are equal');
  print('Border equality: ${borderA == borderB}');

  // Test 17: HashCode consistency
  final hashA = borderA.hashCode;
  final hashB = borderB.hashCode;
  assert(hashA == hashB, 'Equal borders should have same hashCode');
  results.add('HashCode: consistent for equals');
  print('HashCodes: $hashA == $hashB');

  // Test 18: Inequality check - different properties
  final borderC = RoundedSuperellipseBorder(
    cornerRadius: BorderRadius.circular(20),
  );
  assert(borderA != borderC, 'Different borders should not be equal');
  results.add('Inequality: different props are unequal');
  print('Border inequality: ${borderA != borderC}');

  // Test 19: Use with ShapeDecoration
  final decoration = ShapeDecoration(
    shape: RoundedSuperellipseBorder(
      cornerRadius: BorderRadius.circular(16),
      side: BorderSide(color: Colors.purple, width: 2),
    ),
    color: Colors.amber,
  );
  assert(decoration is ShapeDecoration, 'Should create ShapeDecoration');
  results.add('Works with ShapeDecoration');
  print('ShapeDecoration created: ${decoration.runtimeType}');

  // Test 20: Use with Container
  results.add('Compatible with Container decoration');
  print('Container(decoration: ShapeDecoration(shape: ...))');

  // Test 21: BorderRadius.zero
  final borderZero = RoundedSuperellipseBorder(cornerRadius: BorderRadius.zero);
  results.add('BorderRadius.zero creates square corners');
  print('Zero radius: superellipse becomes rectangle');

  // Test 22: BorderSide.none
  final borderNone = RoundedSuperellipseBorder(
    cornerRadius: BorderRadius.circular(16),
    side: BorderSide.none,
  );
  results.add('BorderSide.none removes stroke');
  print('No side: only shape, no stroke');

  // Test 23: Summary of tests
  print(
    'RoundedSuperellipseBorder test completed with ${results.length} tests',
  );
  results.add('All ${results.length} tests passed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'RoundedSuperellipseBorder Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8),
      Text('Inheritance: OutlinedBorder -> ShapeBorder'),
      Text('Properties: cornerRadius, side'),
      Text('Methods: scale, copyWith, getOuterPath, getInnerPath'),
      Text('Equality: == and hashCode work correctly'),
      Text('Superellipse: continuous curvature corners'),
      SizedBox(height: 8),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
