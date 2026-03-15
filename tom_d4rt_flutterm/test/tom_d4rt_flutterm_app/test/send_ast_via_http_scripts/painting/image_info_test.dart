// D4rt test script: Tests ImageInfo conceptual from painting
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// ImageInfo requires dart:ui Image which cannot be directly instantiated in D4rt
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ImageInfo conceptual test executing');
  final results = <String>[];

  // ========== ImageInfo API Documentation ==========
  print('Documenting ImageInfo class...');

  // ImageInfo is an immutable class that holds an image along with its scale
  // Constructor: ImageInfo({required Image image, double scale = 1.0, String? debugLabel})
  results.add('ImageInfo: Holds Image with scale factor');
  print('ImageInfo purpose: Holds Image with scale');

  // Property: image - The raw dart:ui Image
  results.add('Property: image (dart:ui Image) - raw image data');
  print('Property: image - dart:ui Image');

  // Property: scale - Pixel density scale factor
  results.add('Property: scale (double) - pixel density scale');
  print('Property: scale - pixel density scaling');

  // Property: debugLabel - Optional debugging identifier
  results.add('Property: debugLabel (String?) - debug identifier');
  print('Property: debugLabel - debug info');

  // ========== Testing Related Size Calculations ==========
  print('Testing Size calculations used with ImageInfo...');

  // Test Size class which ImageInfo uses
  final size1 = Size(100.0, 200.0);
  assert(size1.width == 100.0, 'Width should be 100.0');
  assert(size1.height == 200.0, 'Height should be 200.0');
  results.add('Size(100, 200): width=${size1.width}, height=${size1.height}');
  print('Size created: ${size1.width}x${size1.height}');

  // Test scaled sizes
  final scale = 2.0;
  final scaledWidth = size1.width / scale;
  final scaledHeight = size1.height / scale;
  assert(scaledWidth == 50.0, 'Scaled width should be 50.0');
  assert(scaledHeight == 100.0, 'Scaled height should be 100.0');
  results.add('Scaled by $scale: ${scaledWidth}x$scaledHeight');
  print('Scaled size: ${scaledWidth}x$scaledHeight');

  // Test Size.square
  final square = Size.square(150.0);
  assert(square.width == square.height, 'Square should have equal dimensions');
  results.add('Size.square(150): ${square.width}x${square.height}');
  print('Square size: ${square.width}x${square.height}');

  // Test Size.fromRadius
  final fromRadius = Size.fromRadius(50.0);
  assert(fromRadius.width == 100.0, 'From radius width should be 100');
  results.add('Size.fromRadius(50): ${fromRadius.width}x${fromRadius.height}');
  print('From radius: ${fromRadius.width}x${fromRadius.height}');

  // Test Size operators
  final size2 = Size(50.0, 50.0);
  final aspectRatio = size1.aspectRatio;
  assert(aspectRatio == 0.5, 'Aspect ratio should be 0.5');
  results.add('Size aspectRatio: $aspectRatio');
  print('Aspect ratio: $aspectRatio');

  // ========== Image Scale Concepts ==========
  print('Testing image scale concepts...');

  // Common device pixel ratios
  final devicePixelRatios = [1.0, 1.5, 2.0, 3.0, 4.0];
  for (final dpr in devicePixelRatios) {
    final logicalSize = Size(100.0, 100.0);
    final physicalSize = Size(
      logicalSize.width * dpr,
      logicalSize.height * dpr,
    );
    results.add(
      'DPR $dpr: logical 100x100 -> physical ${physicalSize.width}x${physicalSize.height}',
    );
    print('DPR $dpr: ${physicalSize.width}x${physicalSize.height}');
  }

  // ========== ImageInfo Method Documentation ==========
  print('Documenting ImageInfo methods...');

  // Method: dispose() - Releases the image resource
  results.add('Method: dispose() - releases Image resource');
  print('Method: dispose() documented');

  // Method: clone() - Creates a copy with same Image reference
  results.add('Method: clone() - creates ImageInfo copy');
  print('Method: clone() documented');

  // Operator: == checks image identity and scale equality
  results.add('Operator: == checks image identity and scale');
  print('Equality operator documented');

  // Property: hashCode - based on image identity and scale
  results.add('Property: hashCode - based on image & scale');
  print('hashCode documented');

  // ========== ImageStream Context ==========
  print('Documenting ImageInfo in ImageStream context...');

  // ImageInfo is delivered through ImageStream callbacks
  results.add('ImageInfo delivered via ImageStream.addListener');
  print('ImageStream integration documented');

  // ImageStreamListener receives ImageInfo
  results.add('ImageStreamListener callback: (ImageInfo info, bool sync)');
  print('Callback signature documented');

  // ========== Size Comparison Tests ==========
  print('Testing Size comparisons for ImageInfo context...');

  final sizeA = Size(200.0, 300.0);
  final sizeB = Size(200.0, 300.0);
  final sizeC = Size(300.0, 200.0);

  assert(sizeA == sizeB, 'Equal sizes should be equal');
  results.add('Size equality: (200x300) == (200x300) is ${sizeA == sizeB}');
  print('Size equality verified');

  assert(sizeA != sizeC, 'Different sizes should not be equal');
  results.add('Size inequality: (200x300) != (300x200) is ${sizeA != sizeC}');
  print('Size inequality verified');

  // Test Size.isEmpty
  final emptySize = Size.zero;
  assert(emptySize.isEmpty, 'Zero size should be empty');
  results.add('Size.zero.isEmpty: ${emptySize.isEmpty}');
  print('Empty size: ${emptySize.isEmpty}');

  // Test Size.isFinite
  assert(sizeA.isFinite, 'Normal size should be finite');
  results.add('Size.isFinite: ${sizeA.isFinite}');
  print('Finite size: ${sizeA.isFinite}');

  // ========== Summary ==========
  print(
    'ImageInfo conceptual test completed: ${results.length} items documented',
  );
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'ImageInfo Tests (Conceptual)',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      Text(
        'Note: ImageInfo requires dart:ui Image - testing related APIs',
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
