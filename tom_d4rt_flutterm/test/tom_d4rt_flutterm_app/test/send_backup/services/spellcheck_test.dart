// D4rt test script: Tests SpellCheckResults, SuggestionSpan concepts from services
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Services spellcheck test executing');

  // ========== SUGGESTIONSPAN ==========
  print('--- SuggestionSpan Tests ---');

  final span1 = SuggestionSpan(TextRange(start: 0, end: 5), [
    'hello',
    'hallo',
    'hullo',
  ]);
  print('SuggestionSpan created');
  print('  range: ${span1.range}');
  print('  suggestions: ${span1.suggestions}');
  print('  runtimeType: ${span1.runtimeType}');

  final span2 = SuggestionSpan(TextRange(start: 10, end: 15), [
    'world',
    'would',
  ]);
  print('SuggestionSpan 2:');
  print('  range: ${span2.range}');
  print('  suggestions: ${span2.suggestions}');

  // Empty suggestions
  final emptySpan = SuggestionSpan(TextRange(start: 0, end: 3), []);
  print('Empty SuggestionSpan: suggestions=${emptySpan.suggestions}');

  // Single suggestion
  final singleSpan = SuggestionSpan(TextRange(start: 5, end: 10), ['correct']);
  print('Single SuggestionSpan: suggestions=${singleSpan.suggestions}');

  // ========== SPELLCHECKRESULTS ==========
  print('--- SpellCheckResults Tests ---');

  final results = SpellCheckResults('helo wrold', [span1, span2]);
  print('SpellCheckResults created');
  print('  spellCheckedText: "${results.spellCheckedText}"');
  print('  suggestionSpans count: ${results.suggestionSpans.length}');
  print('  runtimeType: ${results.runtimeType}');

  for (int i = 0; i < results.suggestionSpans.length; i++) {
    final s = results.suggestionSpans[i];
    print('  span[$i]: range=${s.range}, suggestions=${s.suggestions}');
  }

  // Empty results
  final emptyResults = SpellCheckResults('correct text', []);
  print('Empty SpellCheckResults:');
  print('  spellCheckedText: "${emptyResults.spellCheckedText}"');
  print('  suggestionSpans count: ${emptyResults.suggestionSpans.length}');

  // ========== SPELLCHECKSERVICE ==========
  print('--- SpellCheckService Notes ---');

  print('SpellCheckService is abstract');
  print('DefaultSpellCheckService is the platform implementation');
  print('  Available via SpellCheckConfiguration');
  print('  Used by EditableText/TextField widgets');

  // ========== SPELLCHECKCONFIGURATION ==========
  print('--- SpellCheckConfiguration Notes ---');

  print('SpellCheckConfiguration properties:');
  print('  spellCheckService - the service implementation');
  print('  misspelledTextStyle - TextStyle for misspelled words');
  print('  spellCheckSuggestionsToolbarBuilder - toolbar builder');
  print('SpellCheckConfiguration.disabled() - disables spell check');

  // ========== RETURN WIDGET ==========
  print('Services spellcheck test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Services Spellcheck Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• SuggestionSpan - spell check suggestion'),
          Text('• SpellCheckResults - spell check result set'),
          SizedBox(height: 16.0),

          Text(
            'Bridge Availability:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFFCE4EC),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SuggestionSpan: available'),
                Text('SpellCheckResults: available'),
                Text('SpellCheckService: abstract (not constructable)'),
                Text('SpellCheckConfiguration: framework-provided'),
                SizedBox(height: 8.0),
                Text('Sample: "${results.spellCheckedText}"'),
                Text('  ${results.suggestionSpans.length} suggestion spans'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
