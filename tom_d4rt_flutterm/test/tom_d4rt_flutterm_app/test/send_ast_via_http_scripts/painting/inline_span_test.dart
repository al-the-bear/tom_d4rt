// D4rt test script: Tests InlineSpan abstract via TextSpan from painting
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('InlineSpan test executing');
  final results = <String>[];

  // ========== InlineSpan Tests via TextSpan ==========
  // InlineSpan is abstract, TextSpan is the concrete implementation
  print('Testing InlineSpan via TextSpan...');

  // Test 1: Create basic TextSpan
  final span1 = TextSpan(text: 'Hello World');
  assert(span1.text == 'Hello World', 'Text should match');
  results.add('TextSpan text: ${span1.text}');
  print('TextSpan created: ${span1.text}');

  // Test 2: TextSpan with style
  final span2 = TextSpan(
    text: 'Styled Text',
    style: TextStyle(fontSize: 16.0, color: Color(0xFF000000)),
  );
  assert(span2.style != null, 'Style should not be null');
  assert(span2.style!.fontSize == 16.0, 'Font size should be 16.0');
  results.add('TextSpan style: fontSize=${span2.style!.fontSize}');
  print('TextSpan style verified');

  // Test 3: TextSpan with children
  final span3 = TextSpan(
    text: 'Parent ',
    children: [
      TextSpan(text: 'Child 1 '),
      TextSpan(text: 'Child 2'),
    ],
  );
  assert(span3.children != null, 'Children should not be null');
  assert(span3.children!.length == 2, 'Should have 2 children');
  results.add('TextSpan children: ${span3.children!.length}');
  print('TextSpan children: ${span3.children!.length}');

  // Test 4: Nested TextSpan styles
  final span4 = TextSpan(
    text: 'Normal ',
    style: TextStyle(fontSize: 14.0),
    children: [
      TextSpan(
        text: 'Bold',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ],
  );
  assert(span4.style!.fontSize == 14.0, 'Parent font size should be 14.0');
  results.add('Nested TextSpan: parent size=${span4.style!.fontSize}');
  print('Nested TextSpan styles verified');

  // Test 5: TextSpan toPlainText
  final span5 = TextSpan(
    text: 'Hello ',
    children: [TextSpan(text: 'World')],
  );
  final plainText = span5.toPlainText();
  assert(plainText == 'Hello World', 'Plain text should be "Hello World"');
  results.add('TextSpan toPlainText: $plainText');
  print('TextSpan toPlainText: $plainText');

  // Test 6: TextSpan with recognizer (conceptual)
  final span6 = TextSpan(
    text: 'Clickable',
    style: TextStyle(color: Color(0xFF0000FF)),
  );
  assert(span6.text == 'Clickable', 'Text should be Clickable');
  results.add('TextSpan clickable: ${span6.text}');
  print('TextSpan clickable text verified');

  // Test 7: TextSpan codeUnitAt
  final span7 = TextSpan(text: 'ABC');
  final codeUnit = span7.codeUnitAt(0);
  assert(codeUnit == 65, 'First code unit should be 65 (A)');
  results.add('TextSpan codeUnitAt(0): $codeUnit');
  print('TextSpan codeUnitAt: $codeUnit');

  // Test 8: TextSpan compareTo
  final spanA = TextSpan(text: 'A');
  final spanB = TextSpan(text: 'B');
  final comparison = spanA.compareTo(spanB);
  assert(comparison.isNegative, 'A should come before B');
  results.add('TextSpan compareTo: $comparison');
  print('TextSpan compareTo: $comparison');

  // Test 9: TextSpan with locale
  final span9 = TextSpan(text: 'Localized', locale: Locale('en', 'US'));
  assert(span9.locale == Locale('en', 'US'), 'Locale should match');
  results.add('TextSpan locale: ${span9.locale}');
  print('TextSpan locale: ${span9.locale}');

  // Test 10: TextSpan with spellOut
  final span10 = TextSpan(text: 'Spell check', spellOut: true);
  assert(span10.spellOut == true, 'SpellOut should be true');
  results.add('TextSpan spellOut: ${span10.spellOut}');
  print('TextSpan spellOut verified');

  // Test 11: TextSpan visitChildren
  final visitedTexts = <String>[];
  final rootSpan = TextSpan(
    text: 'Root',
    children: [
      TextSpan(text: ' Child1'),
      TextSpan(text: ' Child2'),
    ],
  );
  rootSpan.visitChildren((span) {
    if (span is TextSpan && span.text != null) {
      visitedTexts.add(span.text!);
    }
    return true;
  });
  assert(visitedTexts.length == 2, 'Should visit 2 children');
  results.add('TextSpan visitChildren: ${visitedTexts.length} visited');
  print('TextSpan visitChildren: ${visitedTexts.length}');

  // Test 12: TextSpan equality
  final eq1 = TextSpan(text: 'Same');
  final eq2 = TextSpan(text: 'Same');
  assert(eq1 == eq2, 'Same text spans should be equal');
  results.add('TextSpan equality: ${eq1 == eq2}');
  print('TextSpan equality verified');

  print('InlineSpan test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('InlineSpan Tests (via TextSpan)'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
