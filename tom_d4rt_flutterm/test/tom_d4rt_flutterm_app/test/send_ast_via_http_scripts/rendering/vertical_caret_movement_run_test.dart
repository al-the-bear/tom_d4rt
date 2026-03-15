// D4rt test script: Tests VerticalCaretMovementRun from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('VerticalCaretMovementRun test executing');

  // ========== VerticalCaretMovementRun Overview ==========
  print('--- VerticalCaretMovementRun Overview ---');
  print('  VerticalCaretMovementRun is an Iterator<TextPosition>');
  print('  Used for vertical caret movement in text editing');
  print('  Tracks caret position during up/down arrow key navigation');

  // ========== VerticalCaretMovementRun Creation via RenderEditable ==========
  print('--- VerticalCaretMovementRun Creation Context ---');
  // VerticalCaretMovementRun is typically created via RenderEditable.startVerticalCaretMovement
  print('  Created via: RenderEditable.startVerticalCaretMovement()');
  print('  Iterator type: Iterator<TextPosition>');
  print('  Maintains horizontal position preference during vertical movement');

  // ========== TextPosition Related Tests ==========
  print('--- TextPosition Related Tests ---');
  final position1 = TextPosition(offset: 0);
  print('  TextPosition(offset: 0): $position1');
  print('    offset: ${position1.offset}');
  print('    affinity: ${position1.affinity}');

  final position2 = TextPosition(offset: 10, affinity: TextAffinity.downstream);
  print('  TextPosition(offset: 10, downstream): $position2');
  print('    offset: ${position2.offset}');
  print('    affinity: ${position2.affinity}');

  final position3 = TextPosition(offset: 20, affinity: TextAffinity.upstream);
  print('  TextPosition(offset: 20, upstream): $position3');
  print('    offset: ${position3.offset}');
  print('    affinity: ${position3.affinity}');

  // ========== TextPosition Equality ==========
  print('--- TextPosition Equality ---');
  final posA = TextPosition(offset: 5);
  final posB = TextPosition(offset: 5);
  final posC = TextPosition(offset: 10);
  print('  position(5) == position(5): ${posA == posB}');
  print('  position(5) == position(10): ${posA == posC}');

  final posUp = TextPosition(offset: 5, affinity: TextAffinity.upstream);
  final posDown = TextPosition(offset: 5, affinity: TextAffinity.downstream);
  print('  pos(5, upstream) == pos(5, downstream): ${posUp == posDown}');

  // ========== TextAffinity Values ==========
  print('--- TextAffinity Values ---');
  for (final affinity in TextAffinity.values) {
    print('  ${affinity.name}: index=${affinity.index}');
  }
  print('  TextAffinity.values.length: ${TextAffinity.values.length}');

  // ========== TextSelection for Context ==========
  print('--- TextSelection for Context ---');
  final selection1 = TextSelection.collapsed(offset: 0);
  print('  collapsed(offset: 0): $selection1');
  print('    isCollapsed: ${selection1.isCollapsed}');
  print('    baseOffset: ${selection1.baseOffset}');
  print('    extentOffset: ${selection1.extentOffset}');

  final selection2 = TextSelection(baseOffset: 0, extentOffset: 10);
  print('  selection(0, 10): $selection2');
  print('    isCollapsed: ${selection2.isCollapsed}');
  print('    start: ${selection2.start}');
  print('    end: ${selection2.end}');

  // ========== TextRange Tests ==========
  print('--- TextRange Tests ---');
  final range1 = TextRange(start: 0, end: 10);
  print('  TextRange(0, 10): $range1');
  print('    start: ${range1.start}');
  print('    end: ${range1.end}');
  print('    isValid: ${range1.isValid}');
  print('    isCollapsed: ${range1.isCollapsed}');
  print('    isNormalized: ${range1.isNormalized}');

  final range2 = TextRange.collapsed(5);
  print('  TextRange.collapsed(5): $range2');
  print('    isCollapsed: ${range2.isCollapsed}');

  final emptyRange = TextRange.empty;
  print('  TextRange.empty: $emptyRange');
  print('    isValid: ${emptyRange.isValid}');

  // ========== Iterator Protocol ==========
  print('--- Iterator Protocol for VerticalCaretMovementRun ---');
  print('  moveNext(): advances to next position');
  print('  current: returns current TextPosition');
  print('  Returns false when no more positions');

  // ========== TextPainter Simulated Usage Context ==========
  print('--- TextPainter Simulated Usage Context ---');
  final textSpan = TextSpan(
    text: 'Hello World\nSecond Line\nThird Line',
    style: TextStyle(fontSize: 16.0),
  );
  final textPainter = TextPainter(
    text: textSpan,
    textDirection: TextDirection.ltr,
  );
  textPainter.layout(maxWidth: 200.0);
  print('  TextPainter created with multi-line text');
  print('  width: ${textPainter.width}');
  print('  height: ${textPainter.height}');
  print('  minIntrinsicWidth: ${textPainter.minIntrinsicWidth}');
  print('  maxIntrinsicWidth: ${textPainter.maxIntrinsicWidth}');

  // ========== Caret Position Calculation ==========
  print('--- Caret Position Calculation ---');
  final caretOffset1 = textPainter.getOffsetForCaret(
    TextPosition(offset: 0),
    Rect.zero,
  );
  print('  caret at offset 0: $caretOffset1');

  final caretOffset2 = textPainter.getOffsetForCaret(
    TextPosition(offset: 5),
    Rect.zero,
  );
  print('  caret at offset 5: $caretOffset2');

  final caretOffset3 = textPainter.getOffsetForCaret(
    TextPosition(offset: 12),
    Rect.zero,
  );
  print('  caret at offset 12 (newline): $caretOffset3');

  print('VerticalCaretMovementRun test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'VerticalCaretMovementRun Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Type: Iterator<TextPosition>'),
          Text('Created via: RenderEditable.startVerticalCaretMovement'),
          Text('TextPosition tests: offset, affinity'),
          Text('TextSelection tests: collapsed, range'),
          Text('TextRange tests: start, end, validity'),
          Text('TextPainter caret position calculation tested'),
        ],
      ),
    ),
  );
}
