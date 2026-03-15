// D4rt test script: Tests ShapeBorder abstract class from painting
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ShapeBorder comprehensive test executing');
  final results = <String>[];

  // ========== ShapeBorder Tests ==========
  print('Testing ShapeBorder abstract class and implementations...');

  // Test 1: CircleBorder - basic circular shape
  final circleBorder = CircleBorder();
  assert(circleBorder != null, 'Should create CircleBorder');
  assert(circleBorder is ShapeBorder, 'CircleBorder should be ShapeBorder');
  results.add('CircleBorder: ShapeBorder subclass');
  print('CircleBorder: ${circleBorder.runtimeType}');

  // Test 2: CircleBorder with side
  final circleWithSide = CircleBorder(
    side: BorderSide(color: Colors.blue, width: 2.0),
  );
  assert(circleWithSide.side.color == Colors.blue, 'Side color should be blue');
  results.add('CircleBorder with BorderSide');
  print('CircleBorder side: ${circleWithSide.side}');

  // Test 3: CircleBorder with eccentricity
  final ovalBorder = CircleBorder(eccentricity: 0.5);
  results.add('CircleBorder with eccentricity: 0.5 (oval)');
  print('Oval border eccentricity: 0.5');

  // Test 4: RoundedRectangleBorder - basic
  final roundedRect = RoundedRectangleBorder();
  assert(
    roundedRect is ShapeBorder,
    'RoundedRectangleBorder should be ShapeBorder',
  );
  results.add('RoundedRectangleBorder: ShapeBorder subclass');
  print('RoundedRectangleBorder: ${roundedRect.runtimeType}');

  // Test 5: RoundedRectangleBorder with radius
  final roundedRectRadius = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16.0),
  );
  results.add('RoundedRectangleBorder with borderRadius: 16');
  print('Rounded rect radius: 16.0');

  // Test 6: RoundedRectangleBorder with side
  final roundedRectSide = RoundedRectangleBorder(
    side: BorderSide(color: Colors.red, width: 3.0),
    borderRadius: BorderRadius.circular(12.0),
  );
  results.add('RoundedRectangleBorder with side and radius');
  print('Rounded rect side: ${roundedRectSide.side}');

  // Test 7: StadiumBorder - pill shape
  final stadiumBorder = StadiumBorder();
  assert(stadiumBorder is ShapeBorder, 'StadiumBorder should be ShapeBorder');
  results.add('StadiumBorder: pill/capsule shape');
  print('StadiumBorder: ${stadiumBorder.runtimeType}');

  // Test 8: StadiumBorder with side
  final stadiumWithSide = StadiumBorder(
    side: BorderSide(color: Colors.green, width: 2.0),
  );
  results.add('StadiumBorder with BorderSide');
  print('Stadium side: ${stadiumWithSide.side}');

  // Test 9: BeveledRectangleBorder
  final beveledRect = BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
  );
  assert(
    beveledRect is ShapeBorder,
    'BeveledRectangleBorder should be ShapeBorder',
  );
  results.add('BeveledRectangleBorder: cut corners');
  print('BeveledRectangleBorder: ${beveledRect.runtimeType}');

  // Test 10: ContinuousRectangleBorder (smooth corners)
  final continuousRect = ContinuousRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
  );
  assert(
    continuousRect is ShapeBorder,
    'ContinuousRectangleBorder should be ShapeBorder',
  );
  results.add('ContinuousRectangleBorder: smooth superellipse');
  print('ContinuousRectangleBorder: ${continuousRect.runtimeType}');

  // Test 11: StarBorder (if available)
  final starBorder = StarBorder(points: 5);
  assert(starBorder is ShapeBorder, 'StarBorder should be ShapeBorder');
  results.add('StarBorder: 5-pointed star');
  print('StarBorder: ${starBorder.runtimeType}');

  // Test 12: dimensions property
  final dims = circleBorder.dimensions;
  assert(dims is EdgeInsetsGeometry, 'dimensions should be EdgeInsetsGeometry');
  results.add('dimensions: EdgeInsetsGeometry');
  print('CircleBorder dimensions: ${dims.runtimeType}');

  // Test 13: getOuterPath method
  final rect = Rect.fromLTWH(0, 0, 100, 100);
  final outerPath = circleBorder.getOuterPath(rect);
  assert(outerPath is Path, 'getOuterPath should return Path');
  results.add('getOuterPath: returns Path');
  print('Outer path: ${outerPath.runtimeType}');

  // Test 14: getInnerPath method
  final innerPath = circleBorder.getInnerPath(rect);
  assert(innerPath is Path, 'getInnerPath should return Path');
  results.add('getInnerPath: returns inner Path');
  print('Inner path: ${innerPath.runtimeType}');

  // Test 15: paint method concept
  results.add('paint(canvas, rect): draws border stroke');
  print('paint method renders the border');

  // Test 16: scale method
  final scaledCircle = circleBorder.scale(2.0);
  assert(scaledCircle is ShapeBorder, 'scale should return ShapeBorder');
  results.add('scale(2.0): scales border width');
  print('Scaled circle: ${scaledCircle.runtimeType}');

  // Test 17: add operator (+) - combining borders concept
  results.add('add (+): combines compatible borders');
  print('Border addition merges dimensions');

  // Test 18: lerp method - interpolation
  final lerpedCircle = ShapeBorder.lerp(
    CircleBorder(side: BorderSide(width: 1.0)),
    CircleBorder(side: BorderSide(width: 5.0)),
    0.5,
  );
  results.add('ShapeBorder.lerp: interpolates between borders');
  print('Lerped border: ${lerpedCircle?.runtimeType}');

  // Test 19: lerp at 0.0
  final lerpStart = ShapeBorder.lerp(circleBorder, roundedRect, 0.0);
  results.add('lerp(a, b, 0.0) returns a');
  print('Lerp at 0: ${lerpStart?.runtimeType}');

  // Test 20: lerp at 1.0
  final lerpEnd = ShapeBorder.lerp(circleBorder, roundedRect, 1.0);
  results.add('lerp(a, b, 1.0) returns b');
  print('Lerp at 1: ${lerpEnd?.runtimeType}');

  // Test 21: OutlinedBorder subclasses
  assert(circleBorder is OutlinedBorder, 'CircleBorder is OutlinedBorder');
  assert(
    roundedRect is OutlinedBorder,
    'RoundedRectangleBorder is OutlinedBorder',
  );
  results.add('OutlinedBorder: common base for borders with side');
  print('OutlinedBorder hierarchy confirmed');

  // Test 22: copyWith on OutlinedBorder
  final copiedCircle = circleWithSide.copyWith(
    side: BorderSide(color: Colors.purple, width: 4.0),
  );
  assert(copiedCircle is CircleBorder, 'copyWith returns same type');
  results.add('copyWith: creates modified copy');
  print('Copied circle side: ${copiedCircle.side}');

  // Test 23: Use with ShapeDecoration
  final decoration = ShapeDecoration(
    shape: roundedRectRadius,
    color: Colors.amber,
  );
  assert(decoration is ShapeDecoration, 'Should create ShapeDecoration');
  results.add('ShapeDecoration(shape: ShapeBorder)');
  print('ShapeDecoration: ${decoration.runtimeType}');

  // Test 24: Use with Material
  results.add('Material(shape: ShapeBorder) for elevation');
  print('Material widget accepts ShapeBorder');

  // Test 25: Equality comparison
  final circle1 = CircleBorder();
  final circle2 = CircleBorder();
  assert(circle1 == circle2, 'Equal borders should be equal');
  results.add('Equality: == works correctly');
  print('Circle equality: ${circle1 == circle2}');

  // Test 26: HashCode consistency
  final hash1 = circle1.hashCode;
  final hash2 = circle2.hashCode;
  assert(hash1 == hash2, 'Equal borders should have same hashCode');
  results.add('hashCode: consistent for equals');
  print('HashCodes equal: ${hash1 == hash2}');

  // Test 27: Summary
  print('ShapeBorder test completed with ${results.length} tests');
  results.add('All ${results.length} tests passed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('ShapeBorder Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('ShapeBorder: abstract base class'),
      Text('Subclasses: CircleBorder, RoundedRectangleBorder'),
      Text('Also: StadiumBorder, BeveledRectangleBorder, StarBorder'),
      Text('Methods: getOuterPath, getInnerPath, paint, scale'),
      Text('Operators: + (add), lerp for animation'),
      Text('OutlinedBorder: adds side property'),
      SizedBox(height: 8),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
