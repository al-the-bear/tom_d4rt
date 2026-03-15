// D4rt test script: Tests ResizeImage from painting
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ResizeImage test executing');
  final results = <String>[];

  // ========== ResizeImage Tests ==========
  print('Testing ResizeImage...');

  // Test 1: ResizeImage with width
  final originalImage1 = NetworkImage('https://example.com/large.png');
  final resized1 = ResizeImage(originalImage1, width: 100);
  assert(resized1.width == 100, 'Width should be 100');
  assert(resized1.height == null, 'Height should be null');
  results.add('ResizeImage width: ${resized1.width}');
  print('ResizeImage width: ${resized1.width}');

  // Test 2: ResizeImage with height
  final resized2 = ResizeImage(originalImage1, height: 200);
  assert(resized2.height == 200, 'Height should be 200');
  assert(resized2.width == null, 'Width should be null');
  results.add('ResizeImage height: ${resized2.height}');
  print('ResizeImage height: ${resized2.height}');

  // Test 3: ResizeImage with both dimensions
  final resized3 = ResizeImage(originalImage1, width: 150, height: 150);
  assert(resized3.width == 150, 'Width should be 150');
  assert(resized3.height == 150, 'Height should be 150');
  results.add('ResizeImage both: ${resized3.width}x${resized3.height}');
  print('ResizeImage both: ${resized3.width}x${resized3.height}');

  // Test 4: ResizeImage.resizeIfNeeded static method (width only)
  final provider4 = ResizeImage.resizeIfNeeded(100, null, originalImage1);
  results.add('ResizeImage.resizeIfNeeded width: created');
  print('ResizeImage.resizeIfNeeded with width');

  // Test 5: ResizeImage.resizeIfNeeded (height only)
  final provider5 = ResizeImage.resizeIfNeeded(null, 100, originalImage1);
  results.add('ResizeImage.resizeIfNeeded height: created');
  print('ResizeImage.resizeIfNeeded with height');

  // Test 6: ResizeImage.resizeIfNeeded (both null - returns original)
  final provider6 = ResizeImage.resizeIfNeeded(null, null, originalImage1);
  assert(
    provider6 == originalImage1,
    'Should return original when no resize needed',
  );
  results.add('ResizeImage.resizeIfNeeded null: returns original');
  print('ResizeImage.resizeIfNeeded with null returns original');

  // Test 7: ResizeImage with allowUpscaling false (default)
  final resized7 = ResizeImage(
    originalImage1,
    width: 50,
    allowUpscaling: false,
  );
  assert(resized7.allowUpscaling == false, 'allowUpscaling should be false');
  results.add('ResizeImage allowUpscaling: ${resized7.allowUpscaling}');
  print('ResizeImage allowUpscaling: ${resized7.allowUpscaling}');

  // Test 8: ResizeImage with allowUpscaling true
  final resized8 = ResizeImage(
    originalImage1,
    width: 500,
    allowUpscaling: true,
  );
  assert(resized8.allowUpscaling == true, 'allowUpscaling should be true');
  results.add('ResizeImage allowUpscaling true: ${resized8.allowUpscaling}');
  print('ResizeImage allowUpscaling true verified');

  // Test 9: ResizeImage with AssetImage
  final assetImage = AssetImage('assets/photo.png');
  final resizedAsset = ResizeImage(assetImage, width: 200, height: 200);
  assert(
    resizedAsset.imageProvider == assetImage,
    'Image provider should match',
  );
  results.add(
    'ResizeImage AssetImage: ${resizedAsset.width}x${resizedAsset.height}',
  );
  print('ResizeImage with AssetImage');

  // Test 10: ResizeImage imageProvider getter
  final innerProvider = resized1.imageProvider;
  assert(innerProvider == originalImage1, 'Inner provider should match');
  results.add('ResizeImage.imageProvider: verified');
  print('ResizeImage.imageProvider getter verified');

  // Test 11: ResizeImage policy (default)
  final resized11 = ResizeImage(originalImage1, width: 100);
  results.add('ResizeImage policy: default');
  print('ResizeImage default policy');

  // Test 12: ResizeImage equality
  final resizeA = ResizeImage(originalImage1, width: 100, height: 100);
  final resizeB = ResizeImage(originalImage1, width: 100, height: 100);
  assert(resizeA == resizeB, 'Same resize params should be equal');
  results.add('ResizeImage equality: ${resizeA == resizeB}');
  print('ResizeImage equality verified');

  // Test 13: ResizeImage hashCode
  final hash1 = resizeA.hashCode;
  final hash2 = resizeB.hashCode;
  assert(hash1 == hash2, 'Equal providers should have same hash');
  results.add('ResizeImage hashCode: $hash1');
  print('ResizeImage hashCode: $hash1');

  // Test 14: ResizeImage inequality
  final resizeC = ResizeImage(originalImage1, width: 100);
  final resizeD = ResizeImage(originalImage1, width: 200);
  assert(resizeC != resizeD, 'Different sizes should not be equal');
  results.add('ResizeImage inequality: ${resizeC != resizeD}');
  print('ResizeImage inequality verified');

  print('ResizeImage test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ResizeImage Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
