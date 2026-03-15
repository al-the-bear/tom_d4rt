// D4rt test script: Tests TextBox, TextDecoration, TextHeightBehavior, TextPosition, TextRange from dart:ui
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('dart:ui text data test executing');

  // ========== TEXTDECORATION ==========
  print('--- TextDecoration Tests ---');

  print('TextDecoration.none: ${TextDecoration.none}');
  print('TextDecoration.underline: ${TextDecoration.underline}');
  print('TextDecoration.overline: ${TextDecoration.overline}');
  print('TextDecoration.lineThrough: ${TextDecoration.lineThrough}');

  final combined = TextDecoration.combine([
    TextDecoration.underline,
    TextDecoration.lineThrough,
  ]);
  print('Combined underline+lineThrough: $combined');
  print('  runtimeType: ${combined.runtimeType}');

  final allThree = TextDecoration.combine([
    TextDecoration.underline,
    TextDecoration.overline,
    TextDecoration.lineThrough,
  ]);
  print('All three combined: $allThree');

  // Test contains
  print(
    'Combined contains underline: ${combined.contains(TextDecoration.underline)}',
  );
  print(
    'Combined contains overline: ${combined.contains(TextDecoration.overline)}',
  );
  print(
    'Combined contains lineThrough: ${combined.contains(TextDecoration.lineThrough)}',
  );

  // ========== TEXTPOSITION ==========
  print('--- TextPosition Tests ---');

  final pos1 = TextPosition(offset: 5);
  print('TextPosition(offset: 5): $pos1');
  print('  offset: ${pos1.offset}');
  print('  affinity: ${pos1.affinity}');
  print('  runtimeType: ${pos1.runtimeType}');

  final pos2 = TextPosition(offset: 10, affinity: TextAffinity.upstream);
  print('TextPosition(offset: 10, upstream): $pos2');
  print('  offset: ${pos2.offset}');
  print('  affinity: ${pos2.affinity}');

  final pos3 = TextPosition(offset: 0, affinity: TextAffinity.downstream);
  print('TextPosition(offset: 0, downstream): $pos3');

  // Test equality
  final posA = TextPosition(offset: 5);
  final posB = TextPosition(offset: 5);
  final posC = TextPosition(offset: 5, affinity: TextAffinity.upstream);
  print('Position equality: posA == posB: ${posA == posB}');
  print('Position equality: posA == posC: ${posA == posC}');

  // ========== TEXTRANGE ==========
  print('--- TextRange Tests ---');

  final range1 = TextRange(start: 0, end: 10);
  print('TextRange(0, 10): $range1');
  print('  start: ${range1.start}');
  print('  end: ${range1.end}');
  print('  isValid: ${range1.isValid}');
  print('  isNormalized: ${range1.isNormalized}');
  print('  isCollapsed: ${range1.isCollapsed}');
  print('  runtimeType: ${range1.runtimeType}');

  final range2 = TextRange(start: 5, end: 5);
  print('TextRange(5, 5) collapsed: $range2');
  print('  isCollapsed: ${range2.isCollapsed}');

  final range3 = TextRange(start: 10, end: 5);
  print('TextRange(10, 5) reversed: $range3');
  print('  isNormalized: ${range3.isNormalized}');

  // TextRange.empty
  print('TextRange.empty: ${TextRange.empty}');
  print('  isCollapsed: ${TextRange.empty.isCollapsed}');

  // Test textBefore, textAfter, textInside
  final testText = 'Hello, World!';
  final wordRange = TextRange(start: 7, end: 12);
  print('Text: "$testText"');
  print('Range(7, 12):');
  print('  textBefore: "${wordRange.textBefore(testText)}"');
  print('  textAfter: "${wordRange.textAfter(testText)}"');
  print('  textInside: "${wordRange.textInside(testText)}"');

  // ========== TEXTHEIGHTBEHAVIOR ==========
  print('--- TextHeightBehavior Tests ---');

  final behavior1 = TextHeightBehavior();
  print('Default TextHeightBehavior: $behavior1');
  print('  applyHeightToFirstAscent: ${behavior1.applyHeightToFirstAscent}');
  print('  applyHeightToLastDescent: ${behavior1.applyHeightToLastDescent}');
  print('  runtimeType: ${behavior1.runtimeType}');

  final behavior2 = TextHeightBehavior(
    applyHeightToFirstAscent: false,
    applyHeightToLastDescent: false,
  );
  print('Custom TextHeightBehavior: $behavior2');
  print('  applyHeightToFirstAscent: ${behavior2.applyHeightToFirstAscent}');
  print('  applyHeightToLastDescent: ${behavior2.applyHeightToLastDescent}');

  final behavior3 = TextHeightBehavior(
    applyHeightToFirstAscent: true,
    applyHeightToLastDescent: false,
  );
  print('Mixed TextHeightBehavior: $behavior3');

  // ========== TEXTBOX ==========
  print('--- TextBox Tests ---');

  final box1 = TextBox.fromLTRBD(10.0, 20.0, 100.0, 40.0, TextDirection.ltr);
  print('TextBox.fromLTRBD(10, 20, 100, 40, ltr): $box1');
  print('  left: ${box1.left}');
  print('  top: ${box1.top}');
  print('  right: ${box1.right}');
  print('  bottom: ${box1.bottom}');
  print('  direction: ${box1.direction}');
  print('  runtimeType: ${box1.runtimeType}');

  final box2 = TextBox.fromLTRBD(0.0, 0.0, 50.0, 20.0, TextDirection.rtl);
  print('TextBox RTL: $box2');
  print('  direction: ${box2.direction}');

  // toRect
  final rect = box1.toRect();
  print('TextBox.toRect(): $rect');

  // ========== RETURN WIDGET ==========
  print('dart:ui text data test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'dart:ui Text Data Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• TextDecoration - underline, overline, lineThrough'),
          Text('• TextPosition - cursor position with affinity'),
          Text('• TextRange - text selection range'),
          Text('• TextHeightBehavior - line height behavior'),
          Text('• TextBox - bounding box for text'),
          SizedBox(height: 16.0),

          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFFFF3E0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('TextRange(7,12) in "Hello, World!"'),
                Text('  inside: "${wordRange.textInside(testText)}"'),
                Text('  before: "${wordRange.textBefore(testText)}"'),
                Text('  after: "${wordRange.textAfter(testText)}"'),
                SizedBox(height: 8.0),
                Text('TextBox(10,20,100,40) rect: $rect'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
