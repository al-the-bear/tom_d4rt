// D4rt test script: Tests TextEditingValue, TextSelection, TextRange,
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// ClipboardData, FilteringTextInputFormatter, LengthLimitingTextInputFormatter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('Text editing value tests executing');

  // ========== TextEditingValue ==========
  print('--- TextEditingValue Tests ---');

  final tev1 = TextEditingValue(
    text: 'Hello World',
    selection: TextSelection.collapsed(offset: 5),
  );
  print('TextEditingValue text: ${tev1.text}');
  print('TextEditingValue selection: ${tev1.selection}');
  print('TextEditingValue composing: ${tev1.composing}');

  final tev2 = TextEditingValue.empty;
  print('TextEditingValue.empty text: "${tev2.text}"');
  print('TextEditingValue.empty selection: ${tev2.selection}');

  final tev3 = tev1.copyWith(text: 'Hello Dart');
  print('TextEditingValue copyWith text: ${tev3.text}');

  final replaced = tev1.replaced(TextRange(start: 6, end: 11), 'Flutter');
  print('TextEditingValue replaced: ${replaced.text}');

  // ========== TextSelection ==========
  print('--- TextSelection Tests ---');

  final sel1 = TextSelection(baseOffset: 2, extentOffset: 7);
  print('TextSelection base: ${sel1.baseOffset}, extent: ${sel1.extentOffset}');
  print('TextSelection isCollapsed: ${sel1.isCollapsed}');
  print('TextSelection isDirectional: ${sel1.isDirectional}');

  final sel2 = TextSelection.collapsed(offset: 3);
  print('TextSelection.collapsed offset: ${sel2.baseOffset}');
  print('TextSelection.collapsed isCollapsed: ${sel2.isCollapsed}');

  final sel3 = TextSelection.fromPosition(TextPosition(offset: 5));
  print('TextSelection.fromPosition: ${sel3.baseOffset}');

  // ========== TextRange ==========
  print('--- TextRange Tests ---');

  final range1 = TextRange(start: 2, end: 8);
  print('TextRange start: ${range1.start}, end: ${range1.end}');
  print('TextRange isValid: ${range1.isValid}');
  print('TextRange isCollapsed: ${range1.isCollapsed}');
  print('TextRange isNormalized: ${range1.isNormalized}');

  final rangeEmpty = TextRange.empty;
  print('TextRange.empty: start=${rangeEmpty.start}, end=${rangeEmpty.end}');

  final text = 'Hello World';
  print('TextRange textBefore: ${range1.textBefore(text)}');
  print('TextRange textInside: ${range1.textInside(text)}');
  print('TextRange textAfter: ${range1.textAfter(text)}');

  // ========== ClipboardData ==========
  print('--- ClipboardData Tests ---');

  final clipData = ClipboardData(text: 'copied text');
  print('ClipboardData text: ${clipData.text}');

  // ========== FilteringTextInputFormatter ==========
  print('--- FilteringTextInputFormatter Tests ---');

  final digitsOnly = FilteringTextInputFormatter.digitsOnly;
  print('digitsOnly: $digitsOnly');

  final allowFilter = FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'));
  print('allow letters filter: $allowFilter');

  final denyFilter = FilteringTextInputFormatter.deny(RegExp(r'[0-9]'));
  print('deny digits filter: $denyFilter');

  final singleLineFormatter = FilteringTextInputFormatter.singleLineFormatter;
  print('singleLineFormatter: $singleLineFormatter');

  // ========== LengthLimitingTextInputFormatter ==========
  print('--- LengthLimitingTextInputFormatter Tests ---');

  final lengthLimit = LengthLimitingTextInputFormatter(100);
  print('LengthLimitingTextInputFormatter maxLength: ${lengthLimit.maxLength}');

  final lengthLimitTruncate = LengthLimitingTextInputFormatter(
    50,
    maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
  );
  print(
    'LengthLimitingTextInputFormatter with enforcement: ${lengthLimitTruncate.maxLength}',
  );

  print('All text editing value tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Text Editing Value Tests',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text('TEV text: ${tev1.text}'),
            Text('Selection: ${sel1.baseOffset}-${sel1.extentOffset}'),
            Text('Range: ${range1.start}-${range1.end}'),
            Text('ClipboardData text: ${clipData.text}'),
            SizedBox(height: 12.0),
            TextField(
              controller: TextEditingController(text: 'Formatted'),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                LengthLimitingTextInputFormatter(20),
              ],
              decoration: InputDecoration(labelText: 'Letters only (max 20)'),
            ),
          ],
        ),
      ),
    ),
  );
}
