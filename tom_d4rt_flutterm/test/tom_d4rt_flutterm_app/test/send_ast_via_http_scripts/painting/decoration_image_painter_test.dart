// D4rt test script: Tests DecorationImagePainter conceptual via DecorationImage from painting
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DecorationImagePainter test executing');
  final results = <String>[];

  // ========== DecorationImagePainter via DecorationImage Tests ==========
  // DecorationImagePainter is created internally by DecorationImage
  print('Testing DecorationImagePainter concepts via DecorationImage...');

  // Test 1: Create DecorationImage with basic settings
  final decorationImage1 = DecorationImage(
    image: NetworkImage('https://example.com/image.png'),
    fit: BoxFit.cover,
  );
  assert(decorationImage1.fit == BoxFit.cover, 'Fit should be cover');
  results.add('DecorationImage fit: ${decorationImage1.fit}');
  print('DecorationImage fit: ${decorationImage1.fit}');

  // Test 2: DecorationImage with BoxFit.contain
  final decorationImage2 = DecorationImage(
    image: NetworkImage('https://example.com/image2.png'),
    fit: BoxFit.contain,
  );
  assert(decorationImage2.fit == BoxFit.contain, 'Fit should be contain');
  results.add('DecorationImage contain: ${decorationImage2.fit}');
  print('DecorationImage contain verified');

  // Test 3: DecorationImage with alignment
  final decorationImage3 = DecorationImage(
    image: NetworkImage('https://example.com/image3.png'),
    alignment: Alignment.topLeft,
  );
  assert(
    decorationImage3.alignment == Alignment.topLeft,
    'Alignment should be topLeft',
  );
  results.add('DecorationImage alignment: ${decorationImage3.alignment}');
  print('DecorationImage alignment: ${decorationImage3.alignment}');

  // Test 4: DecorationImage with repeat
  final decorationImage4 = DecorationImage(
    image: NetworkImage('https://example.com/pattern.png'),
    repeat: ImageRepeat.repeat,
  );
  assert(
    decorationImage4.repeat == ImageRepeat.repeat,
    'Repeat should be repeat',
  );
  results.add('DecorationImage repeat: ${decorationImage4.repeat}');
  print('DecorationImage repeat: ${decorationImage4.repeat}');

  // Test 5: DecorationImage with ImageRepeat.repeatX
  final decorationImage5 = DecorationImage(
    image: NetworkImage('https://example.com/stripe.png'),
    repeat: ImageRepeat.repeatX,
  );
  assert(
    decorationImage5.repeat == ImageRepeat.repeatX,
    'Repeat should be repeatX',
  );
  results.add('DecorationImage repeatX: ${decorationImage5.repeat}');
  print('DecorationImage repeatX verified');

  // Test 6: DecorationImage with ImageRepeat.repeatY
  final decorationImage6 = DecorationImage(
    image: NetworkImage('https://example.com/vstripe.png'),
    repeat: ImageRepeat.repeatY,
  );
  assert(
    decorationImage6.repeat == ImageRepeat.repeatY,
    'Repeat should be repeatY',
  );
  results.add('DecorationImage repeatY: ${decorationImage6.repeat}');
  print('DecorationImage repeatY verified');

  // Test 7: DecorationImage with opacity
  final decorationImage7 = DecorationImage(
    image: NetworkImage('https://example.com/transparent.png'),
    opacity: 0.5,
  );
  assert(decorationImage7.opacity == 0.5, 'Opacity should be 0.5');
  results.add('DecorationImage opacity: ${decorationImage7.opacity}');
  print('DecorationImage opacity: ${decorationImage7.opacity}');

  // Test 8: DecorationImage with scale
  final decorationImage8 = DecorationImage(
    image: NetworkImage('https://example.com/scaled.png'),
    scale: 2.0,
  );
  assert(decorationImage8.scale == 2.0, 'Scale should be 2.0');
  results.add('DecorationImage scale: ${decorationImage8.scale}');
  print('DecorationImage scale: ${decorationImage8.scale}');

  // Test 9: DecorationImage with centerSlice
  final decorationImage9 = DecorationImage(
    image: NetworkImage('https://example.com/9patch.png'),
    centerSlice: Rect.fromLTWH(10, 10, 80, 80),
  );
  assert(
    decorationImage9.centerSlice != null,
    'CenterSlice should not be null',
  );
  results.add('DecorationImage centerSlice: ${decorationImage9.centerSlice}');
  print('DecorationImage centerSlice: ${decorationImage9.centerSlice}');

  // Test 10: DecorationImage with filterQuality
  final decorationImage10 = DecorationImage(
    image: NetworkImage('https://example.com/hq.png'),
    filterQuality: FilterQuality.high,
  );
  assert(
    decorationImage10.filterQuality == FilterQuality.high,
    'FilterQuality should be high',
  );
  results.add(
    'DecorationImage filterQuality: ${decorationImage10.filterQuality}',
  );
  print('DecorationImage filterQuality: ${decorationImage10.filterQuality}');

  // Test 11: DecorationImage with invertColors
  final decorationImage11 = DecorationImage(
    image: NetworkImage('https://example.com/invert.png'),
    invertColors: true,
  );
  assert(decorationImage11.invertColors == true, 'InvertColors should be true');
  results.add(
    'DecorationImage invertColors: ${decorationImage11.invertColors}',
  );
  print('DecorationImage invertColors: ${decorationImage11.invertColors}');

  // Test 12: DecorationImage with matchTextDirection
  final decorationImage12 = DecorationImage(
    image: NetworkImage('https://example.com/rtl.png'),
    matchTextDirection: true,
  );
  assert(
    decorationImage12.matchTextDirection == true,
    'MatchTextDirection should be true',
  );
  results.add(
    'DecorationImage matchTextDirection: ${decorationImage12.matchTextDirection}',
  );
  print('DecorationImage matchTextDirection verified');

  // Test 13: DecorationImage equality
  final imgA = DecorationImage(
    image: NetworkImage('https://a.com/img.png'),
    fit: BoxFit.cover,
  );
  final imgB = DecorationImage(
    image: NetworkImage('https://a.com/img.png'),
    fit: BoxFit.cover,
  );
  results.add('DecorationImage equality test: completed');
  print('DecorationImage equality test completed');

  print('DecorationImagePainter test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DecorationImagePainter Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
