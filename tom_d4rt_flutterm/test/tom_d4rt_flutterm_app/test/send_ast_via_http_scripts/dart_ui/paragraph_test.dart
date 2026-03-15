// D4rt test script: Tests Paragraph, ParagraphBuilder, ParagraphStyle, StrutStyle, LineMetrics
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('dart:ui paragraph tests executing');

  // ========== ParagraphStyle ==========
  print('--- ParagraphStyle Tests ---');
  final ps1 = ui.ParagraphStyle(
    textAlign: TextAlign.left,
    textDirection: TextDirection.ltr,
    maxLines: 3,
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
  );
  print('ParagraphStyle created: $ps1');

  final ps2 = ui.ParagraphStyle(
    textAlign: TextAlign.center,
    textDirection: TextDirection.rtl,
    maxLines: 1,
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    ellipsis: '...',
  );
  print('ParagraphStyle with ellipsis: $ps2');

  // ========== TextStyle (ui) ==========
  print('--- ui.TextStyle Tests ---');
  final ts1 = ui.TextStyle(
    color: Color.fromARGB(255, 0, 0, 0),
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  );
  print('ui.TextStyle created: $ts1');

  final ts2 = ui.TextStyle(
    color: Color.fromARGB(255, 255, 0, 0),
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    letterSpacing: 1.5,
    wordSpacing: 2.0,
  );
  print('ui.TextStyle bold+italic: $ts2');

  // ========== StrutStyle ==========
  print('--- StrutStyle Tests ---');
  final strut1 = ui.StrutStyle(fontSize: 16.0, forceStrutHeight: true);
  print('StrutStyle created: $strut1');

  // ========== ParagraphBuilder + Paragraph ==========
  print('--- ParagraphBuilder Tests ---');
  final builder1 = ui.ParagraphBuilder(ps1);
  print('ParagraphBuilder created');

  builder1.pushStyle(ts1);
  builder1.addText('Hello, world! This is a test paragraph with multiple words.');
  builder1.pop();
  print('pushStyle + addText + pop done');

  final paragraph1 = builder1.build();
  print('Paragraph built: ${paragraph1.runtimeType}');

  // ========== ParagraphConstraints ==========
  print('--- ParagraphConstraints Tests ---');
  final constraints1 = ui.ParagraphConstraints(width: 200.0);
  print('ParagraphConstraints: width=${constraints1.width}');
  final constraints2 = ui.ParagraphConstraints(width: 500.0);
  print('ParagraphConstraints: width=${constraints2.width}');

  // ========== Layout ==========
  print('--- Paragraph Layout Tests ---');
  paragraph1.layout(constraints1);
  print('Paragraph laid out at width 200');
  print('width: ${paragraph1.width}');
  print('height: ${paragraph1.height}');
  print('minIntrinsicWidth: ${paragraph1.minIntrinsicWidth}');
  print('maxIntrinsicWidth: ${paragraph1.maxIntrinsicWidth}');
  print('alphabeticBaseline: ${paragraph1.alphabeticBaseline}');
  print('ideographicBaseline: ${paragraph1.ideographicBaseline}');
  print('longestLine: ${paragraph1.longestLine}');
  print('didExceedMaxLines: ${paragraph1.didExceedMaxLines}');

  // ========== Multi-style paragraph ==========
  print('--- Multi-style Paragraph ---');
  final builder2 = ui.ParagraphBuilder(ps2);
  builder2.pushStyle(ts1);
  builder2.addText('Normal text ');
  builder2.pop();
  builder2.pushStyle(ts2);
  builder2.addText('Bold red text');
  builder2.pop();
  final paragraph2 = builder2.build();
  paragraph2.layout(constraints2);
  print('Multi-style paragraph: w=${paragraph2.width}, h=${paragraph2.height}');
  print('didExceedMaxLines: ${paragraph2.didExceedMaxLines}');

  // ========== LineMetrics ==========
  print('--- LineMetrics Tests ---');
  final metrics = paragraph1.computeLineMetrics();
  print('Line count: ${metrics.length}');
  if (metrics.isNotEmpty) {
    final line = metrics.first;
    print('Line 0: ascent=${line.ascent}, descent=${line.descent}');
    print('  width=${line.width}, height=${line.height}');
    print('  baseline=${line.baseline}, lineNumber=${line.lineNumber}');
    print('  hardBreak=${line.hardBreak}, left=${line.left}');
  }

  print('All paragraph tests passed');

  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('dart:ui Paragraph Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            SizedBox(height: 16.0),
            Text('ParagraphStyle: 2 configurations'),
            Text('TextStyle: normal + bold+italic'),
            Text('ParagraphBuilder: single + multi-style'),
            Text('Layout: w=${paragraph1.width.toInt()}, h=${paragraph1.height.toInt()}'),
            Text('LineMetrics: ${metrics.length} lines'),
          ],
        ),
      ),
    ),
  );
}
