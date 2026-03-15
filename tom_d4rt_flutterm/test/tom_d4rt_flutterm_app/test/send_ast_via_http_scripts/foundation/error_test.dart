// D4rt test script: Tests FlutterError, FlutterErrorDetails, ErrorDescription, ErrorHint, ErrorSummary from foundation
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Foundation error test executing');

  // ========== FLUTTERERROR ==========
  print('--- FlutterError Tests ---');

  final error = FlutterError('Test error message');
  print('FlutterError created: $error');
  print('FlutterError message: ${error.message}');
  print('FlutterError runtimeType: ${error.runtimeType}');
  print('FlutterError diagnostics count: ${error.diagnostics.length}');

  // FlutterError with multiple diagnostics
  final complexError = FlutterError.fromParts([
    ErrorSummary('A render error occurred'),
    ErrorDescription('The widget failed to render properly.'),
    ErrorHint('Try checking the widget constraints.'),
  ]);
  print('Complex FlutterError created');
  print('  diagnostics: ${complexError.diagnostics.length} parts');
  for (final diag in complexError.diagnostics) {
    print('  - ${diag.runtimeType}: ${diag.toStringDeep()}');
  }

  // ========== FLUTTERERRORDETAILS ==========
  print('--- FlutterErrorDetails Tests ---');

  final details = FlutterErrorDetails(
    exception: 'Test exception string',
    library: 'test library',
    context: ErrorDescription('during test execution'),
  );
  print('FlutterErrorDetails created');
  print('  exception: ${details.exception}');
  print('  library: ${details.library}');
  print('  context: ${details.context}');
  print('  runtimeType: ${details.runtimeType}');

  // FlutterErrorDetails with stack trace
  final detailsWithStack = FlutterErrorDetails(
    exception: Exception('something went wrong'),
    library: 'widgets library',
    context: ErrorDescription('while building MyWidget'),
    silent: false,
  );
  print('FlutterErrorDetails with exception:');
  print('  exception: ${detailsWithStack.exception}');
  print('  library: ${detailsWithStack.library}');
  print('  silent: ${detailsWithStack.silent}');

  // FlutterErrorDetails with informationCollector
  final detailsWithInfo = FlutterErrorDetails(
    exception: 'Detailed error',
    library: 'rendering library',
    context: ErrorDescription('during layout'),
    informationCollector: () => [
      ErrorDescription('Additional info line 1'),
      ErrorHint('Maybe try a different approach'),
    ],
  );
  print('FlutterErrorDetails with informationCollector:');
  print('  exception: ${detailsWithInfo.exception}');
  print('  context: ${detailsWithInfo.context}');

  // ========== ERRORDESCRIPTION ==========
  print('--- ErrorDescription Tests ---');

  final desc = ErrorDescription('This describes the error context');
  print('ErrorDescription: $desc');
  print('  runtimeType: ${desc.runtimeType}');
  print('  toString: ${desc.toString()}');
  print('  toStringDeep: ${desc.toStringDeep()}');

  // Multiple ErrorDescriptions
  final desc1 = ErrorDescription('First description line');
  final desc2 = ErrorDescription('Second description line');
  print('Multiple descriptions: $desc1, $desc2');

  // ========== ERRORHINT ==========
  print('--- ErrorHint Tests ---');

  final hint = ErrorHint('Try using a ConstrainedBox to limit size');
  print('ErrorHint: $hint');
  print('  runtimeType: ${hint.runtimeType}');
  print('  toString: ${hint.toString()}');

  final hint2 = ErrorHint(
    'Consider wrapping your widget in a SizedBox with specific dimensions.',
  );
  print('ErrorHint 2: $hint2');

  // ========== ERRORSUMMARY ==========
  print('--- ErrorSummary Tests ---');

  final summary = ErrorSummary('RenderBox was not laid out');
  print('ErrorSummary: $summary');
  print('  runtimeType: ${summary.runtimeType}');
  print('  toString: ${summary.toString()}');

  final summary2 = ErrorSummary('A RenderFlex overflowed by 42 pixels');
  print('ErrorSummary 2: $summary2');

  // ========== COMBINED ERROR CONSTRUCTION ==========
  print('--- Combined Error Tests ---');

  final fullError = FlutterError.fromParts([
    ErrorSummary('Widget rendering failed'),
    ErrorDescription('The Container widget could not be laid out.'),
    ErrorDescription('It was given infinite constraints.'),
    ErrorHint(
      'Consider using a SizedBox or ConstrainedBox to provide finite constraints.',
    ),
    ErrorHint(
      'See also: https://flutter.dev/docs/development/ui/layout/constraints',
    ),
  ]);
  print('Full combined error:');
  print('  message: ${fullError.message}');
  print('  diagnostics count: ${fullError.diagnostics.length}');
  for (int i = 0; i < fullError.diagnostics.length; i++) {
    print(
      '  [$i] ${fullError.diagnostics[i].runtimeType}: ${fullError.diagnostics[i]}',
    );
  }

  // Test FlutterError.defaultStackFilter behavior
  print('FlutterError.presentError is available');

  // ========== RETURN WIDGET ==========
  print('Foundation error test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Foundation Error Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• FlutterError - error with diagnostics'),
          Text('• FlutterErrorDetails - detailed error info'),
          Text('• ErrorDescription - describes error context'),
          Text('• ErrorHint - provides suggested fixes'),
          Text('• ErrorSummary - one-line error summary'),
          SizedBox(height: 16.0),

          Text(
            'Error Construction:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• FlutterError("message") - simple'),
          Text('• FlutterError.fromParts([...]) - complex'),
          Text('• FlutterErrorDetails(exception:...) - full details'),
          SizedBox(height: 16.0),

          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFFFEBEE),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sample Error:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD32F2F),
                  ),
                ),
                Text('Summary: ${summary.toString()}'),
                Text('Description: ${desc.toString()}'),
                Text('Hint: ${hint.toString()}'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
