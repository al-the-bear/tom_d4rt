// D4rt test script: Tests TextSelection, TextPosition, TextRange
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextSelectionTest test executing');

  // TextPosition
  final position1 = TextPosition(offset: 5);
  print('TextPosition offset: ${position1.offset}');
  print('TextPosition affinity: ${position1.affinity}');

  final position2 = TextPosition(offset: 10, affinity: TextAffinity.upstream);
  print('TextPosition(10, upstream) offset: ${position2.offset}');
  print('TextPosition(10, upstream) affinity: ${position2.affinity}');

  // TextRange
  final range1 = TextRange(start: 0, end: 5);
  print('TextRange start: ${range1.start}');
  print('TextRange end: ${range1.end}');
  print('TextRange isValid: ${range1.isValid}');
  print('TextRange isNormalized: ${range1.isNormalized}');
  print('TextRange isCollapsed: ${range1.isCollapsed}');

  // TextRange.empty
  final emptyRange = TextRange.empty;
  print('TextRange.empty start: ${emptyRange.start}');
  print('TextRange.empty end: ${emptyRange.end}');
  print('TextRange.empty isCollapsed: ${emptyRange.isCollapsed}');

  // TextRange.collapsed
  final collapsedRange = TextRange.collapsed(3);
  print('TextRange.collapsed(3) start: ${collapsedRange.start}');
  print('TextRange.collapsed(3) end: ${collapsedRange.end}');
  print('TextRange.collapsed(3) isCollapsed: ${collapsedRange.isCollapsed}');

  // TextRange textBefore/textAfter/textInside
  final sampleText = 'Hello, World!';
  print('textBefore: "${range1.textBefore(sampleText)}"');
  print('textAfter: "${range1.textAfter(sampleText)}"');
  print('textInside: "${range1.textInside(sampleText)}"');

  // TextSelection
  final selection1 = TextSelection(baseOffset: 0, extentOffset: 5);
  print('TextSelection baseOffset: ${selection1.baseOffset}');
  print('TextSelection extentOffset: ${selection1.extentOffset}');
  print('TextSelection isCollapsed: ${selection1.isCollapsed}');
  print('TextSelection isDirectional: ${selection1.isDirectional}');

  // TextSelection.collapsed
  final collapsedSel = TextSelection.collapsed(offset: 7);
  print('TextSelection.collapsed(7) baseOffset: ${collapsedSel.baseOffset}');
  print(
    'TextSelection.collapsed(7) extentOffset: ${collapsedSel.extentOffset}',
  );
  print('TextSelection.collapsed(7) isCollapsed: ${collapsedSel.isCollapsed}');

  // TextSelection with affinity
  final selWithAffinity = TextSelection(
    baseOffset: 3,
    extentOffset: 10,
    affinity: TextAffinity.upstream,
  );
  print('TextSelection(3,10) affinity: ${selWithAffinity.affinity}');
  print('TextSelection(3,10) start: ${selWithAffinity.start}');
  print('TextSelection(3,10) end: ${selWithAffinity.end}');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Sample: "$sampleText"',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
      ),
      SizedBox(height: 8.0),
      Text(
        'TextRange(0,5) inside: "${range1.textInside(sampleText)}"',
        style: TextStyle(fontSize: 13.0),
      ),
      Text(
        'TextRange(0,5) before: "${range1.textBefore(sampleText)}"',
        style: TextStyle(fontSize: 13.0),
      ),
      Text(
        'TextRange(0,5) after: "${range1.textAfter(sampleText)}"',
        style: TextStyle(fontSize: 13.0),
      ),
      SizedBox(height: 8.0),
      Text(
        'TextSelection(0,5) collapsed: ${selection1.isCollapsed}',
        style: TextStyle(fontSize: 13.0),
      ),
      Text(
        'TextSelection.collapsed(7) collapsed: ${collapsedSel.isCollapsed}',
        style: TextStyle(fontSize: 13.0),
      ),
      SizedBox(height: 8.0),
      Text(
        'TextPosition(5) affinity: ${position1.affinity}',
        style: TextStyle(fontSize: 13.0),
      ),
      Text(
        'TextPosition(10) affinity: ${position2.affinity}',
        style: TextStyle(fontSize: 13.0),
      ),
      SizedBox(height: 8.0),
      Text(
        'TextRange.empty collapsed: ${emptyRange.isCollapsed}',
        style: TextStyle(fontSize: 13.0, color: Colors.grey),
      ),
      Text(
        'TextRange.collapsed(3) collapsed: ${collapsedRange.isCollapsed}',
        style: TextStyle(fontSize: 13.0, color: Colors.grey),
      ),
    ],
  );
}
