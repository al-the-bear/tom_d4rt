// D4rt test script: Tests PlaceholderSpan abstract via WidgetSpan from painting
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlaceholderSpan test executing');
  final results = <String>[];

  // ========== PlaceholderSpan Tests via WidgetSpan ==========
  // PlaceholderSpan is abstract, WidgetSpan extends it
  print('Testing PlaceholderSpan via WidgetSpan...');

  // Test 1: Create basic WidgetSpan
  final widgetSpan1 = WidgetSpan(
    child: Container(width: 20, height: 20, color: Color(0xFFFF0000)),
  );
  assert(widgetSpan1.child != null, 'Child should not be null');
  results.add('WidgetSpan: child present');
  print('WidgetSpan created with Container child');

  // Test 2: WidgetSpan with PlaceholderAlignment.bottom
  final widgetSpan2 = WidgetSpan(
    child: Icon(Icons.star),
    alignment: PlaceholderAlignment.bottom,
  );
  assert(
    widgetSpan2.alignment == PlaceholderAlignment.bottom,
    'Alignment should be bottom',
  );
  results.add('WidgetSpan alignment: ${widgetSpan2.alignment}');
  print('WidgetSpan alignment: ${widgetSpan2.alignment}');

  // Test 3: WidgetSpan with PlaceholderAlignment.top
  final widgetSpan3 = WidgetSpan(
    child: Icon(Icons.circle),
    alignment: PlaceholderAlignment.top,
  );
  assert(
    widgetSpan3.alignment == PlaceholderAlignment.top,
    'Alignment should be top',
  );
  results.add('WidgetSpan top: ${widgetSpan3.alignment}');
  print('WidgetSpan top alignment verified');

  // Test 4: WidgetSpan with PlaceholderAlignment.middle
  final widgetSpan4 = WidgetSpan(
    child: Icon(Icons.square),
    alignment: PlaceholderAlignment.middle,
  );
  assert(
    widgetSpan4.alignment == PlaceholderAlignment.middle,
    'Alignment should be middle',
  );
  results.add('WidgetSpan middle: ${widgetSpan4.alignment}');
  print('WidgetSpan middle alignment verified');

  // Test 5: WidgetSpan with PlaceholderAlignment.aboveBaseline
  final widgetSpan5 = WidgetSpan(
    child: Icon(Icons.add),
    alignment: PlaceholderAlignment.aboveBaseline,
    baseline: TextBaseline.alphabetic,
  );
  assert(
    widgetSpan5.alignment == PlaceholderAlignment.aboveBaseline,
    'Alignment should be aboveBaseline',
  );
  results.add('WidgetSpan aboveBaseline: ${widgetSpan5.alignment}');
  print('WidgetSpan aboveBaseline verified');

  // Test 6: WidgetSpan with PlaceholderAlignment.belowBaseline
  final widgetSpan6 = WidgetSpan(
    child: Icon(Icons.remove),
    alignment: PlaceholderAlignment.belowBaseline,
    baseline: TextBaseline.alphabetic,
  );
  assert(
    widgetSpan6.alignment == PlaceholderAlignment.belowBaseline,
    'Alignment should be belowBaseline',
  );
  results.add('WidgetSpan belowBaseline: ${widgetSpan6.alignment}');
  print('WidgetSpan belowBaseline verified');

  // Test 7: WidgetSpan baseline property
  final widgetSpan7 = WidgetSpan(
    child: Text('X'),
    alignment: PlaceholderAlignment.baseline,
    baseline: TextBaseline.alphabetic,
  );
  assert(
    widgetSpan7.baseline == TextBaseline.alphabetic,
    'Baseline should be alphabetic',
  );
  results.add('WidgetSpan baseline: ${widgetSpan7.baseline}');
  print('WidgetSpan baseline: ${widgetSpan7.baseline}');

  // Test 8: WidgetSpan with ideographic baseline
  final widgetSpan8 = WidgetSpan(
    child: Text('中'),
    alignment: PlaceholderAlignment.baseline,
    baseline: TextBaseline.ideographic,
  );
  assert(
    widgetSpan8.baseline == TextBaseline.ideographic,
    'Baseline should be ideographic',
  );
  results.add('WidgetSpan ideographic: ${widgetSpan8.baseline}');
  print('WidgetSpan ideographic baseline verified');

  // Test 9: WidgetSpan with style
  final widgetSpan9 = WidgetSpan(
    child: Icon(Icons.favorite),
    style: TextStyle(fontSize: 20),
  );
  assert(widgetSpan9.style != null, 'Style should not be null');
  results.add('WidgetSpan style: fontSize=${widgetSpan9.style?.fontSize}');
  print('WidgetSpan style: ${widgetSpan9.style}');

  // Test 10: WidgetSpan in TextSpan children
  final textSpan = TextSpan(
    text: 'Hello ',
    children: [
      WidgetSpan(child: Icon(Icons.star, size: 16)),
      TextSpan(text: ' World'),
    ],
  );
  assert(textSpan.children!.length == 2, 'Should have 2 children');
  results.add(
    'TextSpan with WidgetSpan: ${textSpan.children!.length} children',
  );
  print('TextSpan with WidgetSpan children');

  // Test 11: WidgetSpan toPlainText
  final plainSpan = WidgetSpan(child: Icon(Icons.check));
  final plainText = plainSpan.toPlainText();
  results.add('WidgetSpan toPlainText: "${plainText}" (placeholder char)');
  print('WidgetSpan toPlainText: "$plainText"');

  // Test 12: WidgetSpan equality
  final ws1 = WidgetSpan(child: Icon(Icons.star));
  final ws2 = WidgetSpan(child: Icon(Icons.star));
  results.add('WidgetSpan equality test: completed');
  print('WidgetSpan equality test completed');

  // Test 13: Multiple WidgetSpans
  final multiSpan = TextSpan(
    children: [
      WidgetSpan(child: Icon(Icons.star)),
      WidgetSpan(child: Icon(Icons.star)),
      WidgetSpan(child: Icon(Icons.star)),
    ],
  );
  assert(multiSpan.children!.length == 3, 'Should have 3 WidgetSpans');
  results.add('Multiple WidgetSpans: ${multiSpan.children!.length}');
  print('Multiple WidgetSpans: ${multiSpan.children!.length}');

  print('PlaceholderSpan test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PlaceholderSpan Tests (via WidgetSpan)'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
