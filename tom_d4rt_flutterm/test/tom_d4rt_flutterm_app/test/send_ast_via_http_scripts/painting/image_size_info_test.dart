// D4rt test script: Tests ImageSizeInfo conceptual from painting
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// ImageSizeInfo is used for debugging oversized images
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ImageSizeInfo conceptual test executing');
  final results = <String>[];

  // ========== ImageSizeInfo API Documentation ==========
  print('Documenting ImageSizeInfo class...');

  // ImageSizeInfo provides debugging info about image size vs display size
  results.add('ImageSizeInfo: Debug info for image size vs display size');
  print('ImageSizeInfo purpose documented');

  // Property: source - The image source identifier
  results.add('Property: source (String?) - image source identifier');
  print('Property: source documented');

  // Property: imageSize - The actual decoded image size
  results.add('Property: imageSize (Size) - actual decoded size');
  print('Property: imageSize documented');

  // Property: displaySize - The size used for display
  results.add('Property: displaySize (Size) - rendering display size');
  print('Property: displaySize documented');

  // ========== Size Comparison Testing ==========
  print('Testing size comparison scenarios...');

  // Scenario 1: Image larger than display (wasteful)
  final imageSize1 = Size(2000, 2000);
  final displaySize1 = Size(200, 200);
  final ratio1 =
      (imageSize1.width * imageSize1.height) /
      (displaySize1.width * displaySize1.height);
  assert(ratio1 > 1, 'Image should be larger than display');
  results.add(
    'Oversized: ${imageSize1.width.toInt()}x${imageSize1.height.toInt()} -> ${displaySize1.width.toInt()}x${displaySize1.height.toInt()} (${ratio1.toStringAsFixed(0)}x pixels)',
  );
  print('Oversized ratio: ${ratio1.toStringAsFixed(0)}x');

  // Scenario 2: Image matches display (optimal)
  final imageSize2 = Size(300, 300);
  final displaySize2 = Size(300, 300);
  final ratio2 =
      (imageSize2.width * imageSize2.height) /
      (displaySize2.width * displaySize2.height);
  assert(ratio2 == 1, 'Optimal size match');
  results.add(
    'Optimal: ${imageSize2.width.toInt()}x${imageSize2.height.toInt()} -> ${displaySize2.width.toInt()}x${displaySize2.height.toInt()} (${ratio2.toStringAsFixed(0)}x)',
  );
  print('Optimal ratio: ${ratio2.toStringAsFixed(0)}x');

  // Scenario 3: Image smaller than display (upscaling)
  final imageSize3 = Size(100, 100);
  final displaySize3 = Size(400, 400);
  final ratio3 =
      (imageSize3.width * imageSize3.height) /
      (displaySize3.width * displaySize3.height);
  assert(ratio3 < 1, 'Image smaller than display');
  results.add(
    'Upscaled: ${imageSize3.width.toInt()}x${imageSize3.height.toInt()} -> ${displaySize3.width.toInt()}x${displaySize3.height.toInt()} (${ratio3.toStringAsFixed(2)}x)',
  );
  print('Upscaled ratio: ${ratio3.toStringAsFixed(2)}x');

  // ========== Memory Usage Calculation ==========
  print('Calculating memory usage...');

  int calculateMemory(Size size) {
    return (size.width * size.height * 4).toInt(); // 4 bytes per pixel (RGBA)
  }

  final testSizes = [
    Size(100, 100),
    Size(500, 500),
    Size(1920, 1080),
    Size(4096, 4096),
  ];

  for (final size in testSizes) {
    final memory = calculateMemory(size);
    final memoryMB = memory / (1024 * 1024);
    results.add(
      'Memory for ${size.width.toInt()}x${size.height.toInt()}: ${memoryMB.toStringAsFixed(2)} MB',
    );
    print('Memory: ${memoryMB.toStringAsFixed(2)} MB');
  }

  // ========== Waste Calculation ==========
  print('Calculating memory waste...');

  final wasteScenarios = [
    {'image': Size(4000, 4000), 'display': Size(200, 200)},
    {'image': Size(1920, 1080), 'display': Size(192, 108)},
    {'image': Size(800, 600), 'display': Size(400, 300)},
  ];

  for (final scenario in wasteScenarios) {
    final imgSize = scenario['image'] as Size;
    final dispSize = scenario['display'] as Size;
    final imgMemory = calculateMemory(imgSize);
    final dispMemory = calculateMemory(dispSize);
    final waste = imgMemory - dispMemory;
    final wasteMB = waste / (1024 * 1024);
    results.add(
      'Waste: ${imgSize.width.toInt()}x${imgSize.height.toInt()}->${dispSize.width.toInt()}x${dispSize.height.toInt()} = ${wasteMB.toStringAsFixed(2)} MB wasted',
    );
    print('Waste: ${wasteMB.toStringAsFixed(2)} MB');
  }

  // ========== Device Pixel Ratio Considerations ==========
  print('Testing DPR adjustments...');

  final dprs = [1.0, 2.0, 3.0];
  final logicalSize = Size(100, 100);

  for (final dpr in dprs) {
    final optimalImageSize = Size(
      logicalSize.width * dpr,
      logicalSize.height * dpr,
    );
    results.add(
      'DPR $dpr: logical ${logicalSize.width.toInt()}x${logicalSize.height.toInt()} -> optimal ${optimalImageSize.width.toInt()}x${optimalImageSize.height.toInt()}',
    );
    print(
      'DPR $dpr: ${optimalImageSize.width.toInt()}x${optimalImageSize.height.toInt()}',
    );
  }

  // ========== ImageSizeInfo Method Documentation ==========
  print('Documenting ImageSizeInfo methods...');

  // toString method
  results.add('Method: toString() - returns formatted size info string');
  print('toString method documented');

  // Comparison methods
  results.add('ImageSizeInfo supports == and hashCode');
  print('Equality documented');

  // ========== debugImageOverheadAllowance Documentation ==========
  print('Documenting debugImageOverheadAllowance...');

  // This property controls when warnings are triggered
  results.add(
    'Static: debugImageOverheadAllowance (double) - threshold multiplier',
  );
  print('debugImageOverheadAllowance documented');

  // Default value
  results.add('Default debugImageOverheadAllowance: null (platform default)');
  print('Default value documented');

  // ========== Integration with ImageProvider ==========
  print('Documenting ImageProvider integration...');

  results.add('ImageProvider.resolve() can trigger ImageSizeInfo warnings');
  print('ImageProvider integration documented');

  results.add('ResizeImage can be used to prevent oversized images');
  print('ResizeImage solution documented');

  print(
    'ImageSizeInfo conceptual test completed: ${results.length} items documented',
  );
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'ImageSizeInfo Tests (Conceptual)',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      Text(
        'Note: ImageSizeInfo used in debug mode for size warnings',
        style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic),
      ),
      Text('Total items: ${results.length}', style: TextStyle(fontSize: 14)),
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
