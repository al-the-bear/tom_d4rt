// D4rt test script: Tests Gradient classes from painting
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Gradient test executing');
  final results = <String>[];

  // ========== LinearGradient Tests ==========
  print('Testing LinearGradient...');

  // Test 1: Basic LinearGradient with two colors
  final linearGradient1 = LinearGradient(
    colors: [Color(0xFFFF0000), Color(0xFF0000FF)],
  );
  assert(
    linearGradient1.colors.length == 2,
    'LinearGradient should have 2 colors',
  );
  results.add('LinearGradient basic: ${linearGradient1.colors.length} colors');
  print('LinearGradient basic: ${linearGradient1.colors.length} colors');

  // Test 2: LinearGradient with custom begin/end
  final linearGradient2 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF0000), Color(0xFF00FF00), Color(0xFF0000FF)],
  );
  assert(linearGradient2.begin == Alignment.topLeft, 'Begin should be topLeft');
  assert(
    linearGradient2.end == Alignment.bottomRight,
    'End should be bottomRight',
  );
  results.add(
    'LinearGradient begin/end: ${linearGradient2.begin} to ${linearGradient2.end}',
  );
  print('LinearGradient begin/end verified');

  // Test 3: LinearGradient with stops
  final linearGradient3 = LinearGradient(
    colors: [Color(0xFFFF0000), Color(0xFF00FF00), Color(0xFF0000FF)],
    stops: [0.0, 0.5, 1.0],
  );
  assert(linearGradient3.stops != null, 'Stops should not be null');
  assert(linearGradient3.stops!.length == 3, 'Should have 3 stops');
  results.add('LinearGradient stops: ${linearGradient3.stops}');
  print('LinearGradient stops: ${linearGradient3.stops}');

  // Test 4: LinearGradient with TileMode
  final linearGradient4 = LinearGradient(
    colors: [Color(0xFFFF0000), Color(0xFF0000FF)],
    tileMode: TileMode.mirror,
  );
  assert(
    linearGradient4.tileMode == TileMode.mirror,
    'TileMode should be mirror',
  );
  results.add('LinearGradient tileMode: ${linearGradient4.tileMode}');
  print('LinearGradient tileMode: ${linearGradient4.tileMode}');

  // Test 5: LinearGradient with transform
  final transform = GradientRotation(3.14159 / 4);
  final linearGradient5 = LinearGradient(
    colors: [Color(0xFFFF0000), Color(0xFF0000FF)],
    transform: transform,
  );
  assert(linearGradient5.transform != null, 'Transform should not be null');
  results.add('LinearGradient transform: applied');
  print('LinearGradient transform applied');

  // ========== RadialGradient Tests ==========
  print('Testing RadialGradient...');

  // Test 6: Basic RadialGradient
  final radialGradient1 = RadialGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFF000000)],
  );
  assert(
    radialGradient1.colors.length == 2,
    'RadialGradient should have 2 colors',
  );
  results.add('RadialGradient basic: ${radialGradient1.colors.length} colors');
  print('RadialGradient basic: ${radialGradient1.colors.length} colors');

  // Test 7: RadialGradient with center
  final radialGradient2 = RadialGradient(
    center: Alignment.topRight,
    colors: [Color(0xFFFF0000), Color(0xFF0000FF)],
  );
  assert(
    radialGradient2.center == Alignment.topRight,
    'Center should be topRight',
  );
  results.add('RadialGradient center: ${radialGradient2.center}');
  print('RadialGradient center: ${radialGradient2.center}');

  // Test 8: RadialGradient with radius
  final radialGradient3 = RadialGradient(
    radius: 0.75,
    colors: [Color(0xFFFF0000), Color(0xFF0000FF)],
  );
  assert(radialGradient3.radius == 0.75, 'Radius should be 0.75');
  results.add('RadialGradient radius: ${radialGradient3.radius}');
  print('RadialGradient radius: ${radialGradient3.radius}');

  // Test 9: RadialGradient with focal
  final radialGradient4 = RadialGradient(
    center: Alignment.center,
    focal: Alignment.topLeft,
    focalRadius: 0.1,
    colors: [Color(0xFFFF0000), Color(0xFF0000FF)],
  );
  assert(radialGradient4.focal == Alignment.topLeft, 'Focal should be topLeft');
  assert(radialGradient4.focalRadius == 0.1, 'FocalRadius should be 0.1');
  results.add(
    'RadialGradient focal: ${radialGradient4.focal}, focalRadius: ${radialGradient4.focalRadius}',
  );
  print('RadialGradient focal settings verified');

  // ========== SweepGradient Tests ==========
  print('Testing SweepGradient...');

  // Test 10: Basic SweepGradient
  final sweepGradient1 = SweepGradient(
    colors: [
      Color(0xFFFF0000),
      Color(0xFF00FF00),
      Color(0xFF0000FF),
      Color(0xFFFF0000),
    ],
  );
  assert(
    sweepGradient1.colors.length == 4,
    'SweepGradient should have 4 colors',
  );
  results.add('SweepGradient basic: ${sweepGradient1.colors.length} colors');
  print('SweepGradient basic: ${sweepGradient1.colors.length} colors');

  // Test 11: SweepGradient with angles
  final sweepGradient2 = SweepGradient(
    startAngle: 0.0,
    endAngle: 3.14159 * 2,
    colors: [Color(0xFFFF0000), Color(0xFF0000FF)],
  );
  assert(sweepGradient2.startAngle == 0.0, 'StartAngle should be 0.0');
  results.add(
    'SweepGradient angles: start=${sweepGradient2.startAngle}, end=${sweepGradient2.endAngle}',
  );
  print('SweepGradient angles verified');

  // ========== Gradient comparison tests ==========
  print('Testing gradient equality...');

  // Test 12: LinearGradient equality
  final lgA = LinearGradient(colors: [Color(0xFFFF0000), Color(0xFF0000FF)]);
  final lgB = LinearGradient(colors: [Color(0xFFFF0000), Color(0xFF0000FF)]);
  assert(lgA == lgB, 'Identical LinearGradients should be equal');
  results.add('LinearGradient equality: ${lgA == lgB}');
  print('LinearGradient equality: ${lgA == lgB}');

  // Test 13: Different gradients should not be equal
  final lgC = LinearGradient(colors: [Color(0xFFFF0000), Color(0xFF00FF00)]);
  assert(lgA != lgC, 'Different LinearGradients should not be equal');
  results.add('LinearGradient inequality: ${lgA != lgC}');
  print('LinearGradient inequality verified');

  // Test 14: Gradient hashCode
  final hashA = lgA.hashCode;
  final hashB = lgB.hashCode;
  assert(hashA == hashB, 'Equal gradients should have same hashCode');
  results.add('LinearGradient hashCode match: ${hashA == hashB}');
  print('LinearGradient hashCode: $hashA');

  // Test 15: All TileModes
  for (final mode in TileMode.values) {
    final lg = LinearGradient(
      colors: [Color(0xFFFF0000), Color(0xFF0000FF)],
      tileMode: mode,
    );
    assert(lg.tileMode == mode, 'TileMode should match');
    results.add('TileMode.$mode gradient created');
    print('TileMode.$mode verified');
  }

  print('Gradient test completed: ${results.length} tests passed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Gradient Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      Text('Total tests: ${results.length}', style: TextStyle(fontSize: 14)),
      Divider(),
      ...results.map(
        (r) => Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Text(r, style: TextStyle(fontSize: 11)),
        ),
      ),
    ],
  );
}
