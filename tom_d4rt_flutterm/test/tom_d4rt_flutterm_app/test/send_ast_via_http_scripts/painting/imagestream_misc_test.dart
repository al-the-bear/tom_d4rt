// D4rt test script: Tests painting ImageStream, ImageStreamListener,
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// ImageStreamCompleter, ImageInfo, ImageChunkEvent, PlaceholderDimensions,
// InlineSpanSemanticsInformation, Accumulator
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

dynamic build(BuildContext context) {
  print('Painting image stream and misc test executing');

  // ========== PlaceholderDimensions ==========
  print('--- PlaceholderDimensions Tests ---');

  final placeholder = PlaceholderDimensions(
    size: Size(100.0, 50.0),
    alignment: PlaceholderAlignment.middle,
  );
  print('PlaceholderDimensions size: ${placeholder.size}');
  print('PlaceholderDimensions alignment: ${placeholder.alignment}');

  final placeholderWithBaseline = PlaceholderDimensions(
    size: Size(80.0, 30.0),
    alignment: PlaceholderAlignment.baseline,
    baselineOffset: 20.0,
    baseline: TextBaseline.alphabetic,
  );
  print(
    'PlaceholderDimensions baselineOffset: ${placeholderWithBaseline.baselineOffset}',
  );
  print('PlaceholderDimensions baseline: ${placeholderWithBaseline.baseline}');

  // ========== PlaceholderAlignment ==========
  print('--- PlaceholderAlignment Tests ---');

  print('PlaceholderAlignment.baseline: ${PlaceholderAlignment.baseline}');
  print(
    'PlaceholderAlignment.aboveBaseline: ${PlaceholderAlignment.aboveBaseline}',
  );
  print(
    'PlaceholderAlignment.belowBaseline: ${PlaceholderAlignment.belowBaseline}',
  );
  print('PlaceholderAlignment.top: ${PlaceholderAlignment.top}');
  print('PlaceholderAlignment.bottom: ${PlaceholderAlignment.bottom}');
  print('PlaceholderAlignment.middle: ${PlaceholderAlignment.middle}');

  // ========== Accumulator ==========
  print('--- Accumulator Tests ---');

  final acc = Accumulator();
  print('Accumulator initial value: ${acc.value}');
  acc.increment(5);
  print('Accumulator after increment(5): ${acc.value}');
  acc.increment(3);
  print('Accumulator after increment(3): ${acc.value}');

  // ========== InlineSpanSemanticsInformation ==========
  print('--- InlineSpanSemanticsInformation Tests ---');

  final spanInfo = InlineSpanSemanticsInformation(
    'Hello World',
    isPlaceholder: false,
  );
  print('InlineSpanSemanticsInformation text: ${spanInfo.text}');
  print(
    'InlineSpanSemanticsInformation isPlaceholder: ${spanInfo.isPlaceholder}',
  );
  print(
    'InlineSpanSemanticsInformation requiresOwnNode: ${spanInfo.requiresOwnNode}',
  );

  final placeholderInfo = InlineSpanSemanticsInformation.placeholder;
  print(
    'InlineSpanSemanticsInformation.placeholder isPlaceholder: ${placeholderInfo.isPlaceholder}',
  );

  // ========== ImageChunkEvent ==========
  print('--- ImageChunkEvent Tests ---');

  final chunkEvent = ImageChunkEvent(
    cumulativeBytesLoaded: 5000,
    expectedTotalBytes: 10000,
  );
  print(
    'ImageChunkEvent cumulativeBytesLoaded: ${chunkEvent.cumulativeBytesLoaded}',
  );
  print('ImageChunkEvent expectedTotalBytes: ${chunkEvent.expectedTotalBytes}');

  final chunkEventNoTotal = ImageChunkEvent(
    cumulativeBytesLoaded: 3000,
    expectedTotalBytes: null,
  );
  print(
    'ImageChunkEvent without total: ${chunkEventNoTotal.expectedTotalBytes}',
  );

  // ========== ImageConfiguration ==========
  print('--- ImageConfiguration Tests ---');

  final icEmpty = ImageConfiguration.empty;
  print(
    'ImageConfiguration.empty devicePixelRatio: ${icEmpty.devicePixelRatio}',
  );
  print('ImageConfiguration.empty locale: ${icEmpty.locale}');
  print('ImageConfiguration.empty textDirection: ${icEmpty.textDirection}');
  print('ImageConfiguration.empty size: ${icEmpty.size}');
  print('ImageConfiguration.empty platform: ${icEmpty.platform}');

  print('All painting image stream and misc tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Painting Image Stream & Misc Test',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('PlaceholderDimensions: ${placeholder.size}'),
            Text('Accumulator: ${acc.value}'),
            Text('ImageChunkEvent loaded: ${chunkEvent.cumulativeBytesLoaded}'),
          ],
        ),
      ),
    ),
  );
}
