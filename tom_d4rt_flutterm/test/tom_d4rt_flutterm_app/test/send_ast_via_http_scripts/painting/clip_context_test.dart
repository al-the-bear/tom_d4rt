// D4rt test script: Tests ClipContext conceptual from painting
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ClipContext test executing');
  final results = <String>[];

  // ========== ClipContext Conceptual Tests ==========
  // ClipContext is a mixin that provides clipping methods to Canvas
  // We test clipping concepts through related classes
  print('Testing ClipContext concepts...');

  // Test 1: Create Rect for clipping
  final clipRect = Rect.fromLTWH(10.0, 10.0, 100.0, 100.0);
  assert(clipRect.left == 10.0, 'Clip rect left should be 10.0');
  assert(clipRect.top == 10.0, 'Clip rect top should be 10.0');
  assert(clipRect.width == 100.0, 'Clip rect width should be 100.0');
  assert(clipRect.height == 100.0, 'Clip rect height should be 100.0');
  results.add('ClipRect: ${clipRect.width}x${clipRect.height}');
  print('ClipRect created: $clipRect');

  // Test 2: RRect for rounded clipping
  final clipRRect = RRect.fromRectAndRadius(
    Rect.fromLTWH(0, 0, 200, 200),
    Radius.circular(20.0),
  );
  assert(clipRRect.tlRadiusX == 20.0, 'Top-left radius should be 20.0');
  results.add('ClipRRect radius: ${clipRRect.tlRadiusX}');
  print('ClipRRect created with radius: ${clipRRect.tlRadiusX}');

  // Test 3: Path for custom clipping
  final clipPath = Path();
  clipPath.moveTo(50, 0);
  clipPath.lineTo(100, 50);
  clipPath.lineTo(50, 100);
  clipPath.lineTo(0, 50);
  clipPath.close();
  final pathBounds = clipPath.getBounds();
  assert(pathBounds.width == 100.0, 'Path width should be 100.0');
  results.add('ClipPath bounds: ${pathBounds.width}x${pathBounds.height}');
  print('ClipPath created with bounds: $pathBounds');

  // Test 4: BorderRadius for clip regions
  final borderRadius = BorderRadius.circular(15.0);
  assert(borderRadius.topLeft.x == 15.0, 'TopLeft radius should be 15.0');
  results.add('BorderRadius for clip: ${borderRadius.topLeft.x}');
  print('BorderRadius for clipping: $borderRadius');

  // Test 5: BorderRadius.only for asymmetric clipping
  final asymmetricRadius = BorderRadius.only(
    topLeft: Radius.circular(10.0),
    topRight: Radius.circular(20.0),
    bottomLeft: Radius.circular(5.0),
    bottomRight: Radius.circular(15.0),
  );
  assert(asymmetricRadius.topLeft.x == 10.0, 'TopLeft should be 10.0');
  assert(asymmetricRadius.topRight.x == 20.0, 'TopRight should be 20.0');
  results.add(
    'Asymmetric clip radius: TL=${asymmetricRadius.topLeft.x}, TR=${asymmetricRadius.topRight.x}',
  );
  print('Asymmetric BorderRadius verified');

  // Test 6: Clip behavior concepts
  final clipBehavior = Clip.antiAlias;
  assert(clipBehavior == Clip.antiAlias, 'Clip behavior should be antiAlias');
  results.add('Clip.antiAlias: verified');
  print('Clip.antiAlias behavior verified');

  // Test 7: Clip.hardEdge
  const hardEdge = Clip.hardEdge;
  assert(hardEdge == Clip.hardEdge, 'Clip hardEdge verified');
  results.add('Clip.hardEdge: verified');
  print('Clip.hardEdge verified');

  // Test 8: Clip.antiAliasWithSaveLayer
  const saveLayer = Clip.antiAliasWithSaveLayer;
  assert(saveLayer == Clip.antiAliasWithSaveLayer, 'Clip saveLayer verified');
  results.add('Clip.antiAliasWithSaveLayer: verified');
  print('Clip.antiAliasWithSaveLayer verified');

  // Test 9: Clip.none
  const noClip = Clip.none;
  assert(noClip == Clip.none, 'Clip none verified');
  results.add('Clip.none: verified');
  print('Clip.none verified');

  // Test 10: Create complex clipping path
  final complexPath = Path();
  complexPath.addOval(Rect.fromLTWH(0, 0, 100, 80));
  final ovalBounds = complexPath.getBounds();
  assert(ovalBounds.width == 100.0, 'Oval width should be 100.0');
  results.add(
    'Complex clip path (oval): ${ovalBounds.width}x${ovalBounds.height}',
  );
  print('Complex oval clip path created');

  // Test 11: RRect with different corner radii
  final customRRect = RRect.fromRectAndCorners(
    Rect.fromLTWH(0, 0, 150, 100),
    topLeft: Radius.circular(10),
    topRight: Radius.circular(20),
    bottomLeft: Radius.circular(5),
    bottomRight: Radius.circular(15),
  );
  assert(customRRect.tlRadiusX == 10.0, 'TL radius should be 10.0');
  assert(customRRect.trRadiusX == 20.0, 'TR radius should be 20.0');
  results.add(
    'Custom RRect: TL=${customRRect.tlRadiusX}, TR=${customRRect.trRadiusX}',
  );
  print('Custom corner RRect verified');

  // Test 12: Path operations for clip
  final path1 = Path()..addRect(Rect.fromLTWH(0, 0, 100, 100));
  final path2 = Path()..addRect(Rect.fromLTWH(50, 50, 100, 100));
  final combinedPath = Path.combine(PathOperation.intersect, path1, path2);
  final combinedBounds = combinedPath.getBounds();
  results.add(
    'Path combine intersect: ${combinedBounds.width}x${combinedBounds.height}',
  );
  print('Combined path intersection: $combinedBounds');

  print('ClipContext test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ClipContext Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
