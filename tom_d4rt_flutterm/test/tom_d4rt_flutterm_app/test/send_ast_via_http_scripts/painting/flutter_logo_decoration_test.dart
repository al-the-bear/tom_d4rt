// D4rt test script: Tests FlutterLogoDecoration from painting
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FlutterLogoDecoration test executing');
  final results = <String>[];

  // ========== FlutterLogoDecoration Tests ==========
  print('Testing FlutterLogoDecoration...');

  // Test 1: Default FlutterLogoDecoration
  final logoDeco1 = FlutterLogoDecoration();
  assert(
    logoDeco1.style == FlutterLogoStyle.markOnly,
    'Default style should be markOnly',
  );
  results.add('FlutterLogoDecoration default style: ${logoDeco1.style}');
  print('FlutterLogoDecoration default: ${logoDeco1.style}');

  // Test 2: FlutterLogoDecoration with markOnly style
  final logoDeco2 = FlutterLogoDecoration(style: FlutterLogoStyle.markOnly);
  assert(
    logoDeco2.style == FlutterLogoStyle.markOnly,
    'Style should be markOnly',
  );
  results.add('FlutterLogoDecoration markOnly: ${logoDeco2.style}');
  print('FlutterLogoDecoration markOnly verified');

  // Test 3: FlutterLogoDecoration with horizontal style
  final logoDeco3 = FlutterLogoDecoration(style: FlutterLogoStyle.horizontal);
  assert(
    logoDeco3.style == FlutterLogoStyle.horizontal,
    'Style should be horizontal',
  );
  results.add('FlutterLogoDecoration horizontal: ${logoDeco3.style}');
  print('FlutterLogoDecoration horizontal: ${logoDeco3.style}');

  // Test 4: FlutterLogoDecoration with stacked style
  final logoDeco4 = FlutterLogoDecoration(style: FlutterLogoStyle.stacked);
  assert(
    logoDeco4.style == FlutterLogoStyle.stacked,
    'Style should be stacked',
  );
  results.add('FlutterLogoDecoration stacked: ${logoDeco4.style}');
  print('FlutterLogoDecoration stacked: ${logoDeco4.style}');

  // Test 5: FlutterLogoDecoration with textColor
  final logoDeco5 = FlutterLogoDecoration(textColor: Color(0xFF000000));
  assert(logoDeco5.textColor == Color(0xFF000000), 'TextColor should be black');
  results.add('FlutterLogoDecoration textColor: ${logoDeco5.textColor}');
  print('FlutterLogoDecoration textColor: ${logoDeco5.textColor}');

  // Test 6: FlutterLogoDecoration with custom textColor
  final logoDeco6 = FlutterLogoDecoration(textColor: Color(0xFFFF0000));
  assert(logoDeco6.textColor == Color(0xFFFF0000), 'TextColor should be red');
  results.add('FlutterLogoDecoration red textColor: ${logoDeco6.textColor}');
  print('FlutterLogoDecoration custom textColor verified');

  // Test 7: FlutterLogoDecoration with margin
  final logoDeco7 = FlutterLogoDecoration(margin: EdgeInsets.all(10.0));
  assert(logoDeco7.margin == EdgeInsets.all(10.0), 'Margin should be 10.0 all');
  results.add('FlutterLogoDecoration margin: ${logoDeco7.margin}');
  print('FlutterLogoDecoration margin: ${logoDeco7.margin}');

  // Test 8: FlutterLogoDecoration with zero margin
  final logoDeco8 = FlutterLogoDecoration(margin: EdgeInsets.zero);
  assert(logoDeco8.margin == EdgeInsets.zero, 'Margin should be zero');
  results.add('FlutterLogoDecoration zero margin: ${logoDeco8.margin}');
  print('FlutterLogoDecoration zero margin verified');

  // Test 9: FlutterLogoDecoration lerp
  final logoDecoA = FlutterLogoDecoration(style: FlutterLogoStyle.markOnly);
  final logoDecoB = FlutterLogoDecoration(style: FlutterLogoStyle.horizontal);
  final lerped = FlutterLogoDecoration.lerp(logoDecoA, logoDecoB, 0.5);
  assert(lerped != null, 'Lerped decoration should not be null');
  results.add('FlutterLogoDecoration lerp: computed');
  print('FlutterLogoDecoration lerp: $lerped');

  // Test 10: FlutterLogoDecoration lerp with matching styles
  final logoDecoC = FlutterLogoDecoration(style: FlutterLogoStyle.markOnly);
  final logoDecoD = FlutterLogoDecoration(style: FlutterLogoStyle.markOnly);
  final lerped2 = FlutterLogoDecoration.lerp(logoDecoC, logoDecoD, 0.5);
  assert(lerped2 != null, 'Same style lerp should not be null');
  results.add('FlutterLogoDecoration same style lerp: computed');
  print('FlutterLogoDecoration same style lerp verified');

  // Test 11: FlutterLogoDecoration with horizontal and text color
  final logoDeco11 = FlutterLogoDecoration(
    style: FlutterLogoStyle.horizontal,
    textColor: Color(0xFF0000FF),
  );
  assert(
    logoDeco11.style == FlutterLogoStyle.horizontal,
    'Style should be horizontal',
  );
  assert(logoDeco11.textColor == Color(0xFF0000FF), 'TextColor should be blue');
  results.add('FlutterLogoDecoration horizontal+blue: verified');
  print('FlutterLogoDecoration horizontal with blue text verified');

  // Test 12: FlutterLogoDecoration equality
  final logoA = FlutterLogoDecoration(style: FlutterLogoStyle.markOnly);
  final logoB = FlutterLogoDecoration(style: FlutterLogoStyle.markOnly);
  assert(logoA == logoB, 'Equal decorations should be equal');
  results.add('FlutterLogoDecoration equality: ${logoA == logoB}');
  print('FlutterLogoDecoration equality verified');

  // Test 13: FlutterLogoDecoration hashCode
  final hashA = logoA.hashCode;
  final hashB = logoB.hashCode;
  assert(hashA == hashB, 'Equal decorations should have same hash');
  results.add('FlutterLogoDecoration hashCode: $hashA');
  print('FlutterLogoDecoration hashCode verified');

  print('FlutterLogoDecoration test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FlutterLogoDecoration Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
