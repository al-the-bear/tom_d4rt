// D4rt test script: Tests MouseCursor, SystemMouseCursors, SystemMouseCursor from services
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Services cursor test executing');

  // ========== SYSTEMMOUSECURSORS ==========
  print('--- SystemMouseCursors Tests ---');

  // Basic cursors
  final none = SystemMouseCursors.none;
  print('SystemMouseCursors.none: $none');
  print('  runtimeType: ${none.runtimeType}');

  final basic = SystemMouseCursors.basic;
  print('SystemMouseCursors.basic: $basic');

  final click = SystemMouseCursors.click;
  print('SystemMouseCursors.click: $click');

  final forbidden = SystemMouseCursors.forbidden;
  print('SystemMouseCursors.forbidden: $forbidden');

  final wait = SystemMouseCursors.wait;
  print('SystemMouseCursors.wait: $wait');

  final progress = SystemMouseCursors.progress;
  print('SystemMouseCursors.progress: $progress');

  // Text cursors
  final text = SystemMouseCursors.text;
  print('SystemMouseCursors.text: $text');

  final verticalText = SystemMouseCursors.verticalText;
  print('SystemMouseCursors.verticalText: $verticalText');

  // Selection cursors
  final cell = SystemMouseCursors.cell;
  print('SystemMouseCursors.cell: $cell');

  final precise = SystemMouseCursors.precise;
  print('SystemMouseCursors.precise: $precise');

  // Drag cursors
  final move = SystemMouseCursors.move;
  print('SystemMouseCursors.move: $move');

  final grab = SystemMouseCursors.grab;
  print('SystemMouseCursors.grab: $grab');

  final grabbing = SystemMouseCursors.grabbing;
  print('SystemMouseCursors.grabbing: $grabbing');

  final noDrop = SystemMouseCursors.noDrop;
  print('SystemMouseCursors.noDrop: $noDrop');

  final alias = SystemMouseCursors.alias;
  print('SystemMouseCursors.alias: $alias');

  final copy = SystemMouseCursors.copy;
  print('SystemMouseCursors.copy: $copy');

  final disappearing = SystemMouseCursors.disappearing;
  print('SystemMouseCursors.disappearing: $disappearing');

  final allScroll = SystemMouseCursors.allScroll;
  print('SystemMouseCursors.allScroll: $allScroll');

  // Resize cursors
  final resizeColumn = SystemMouseCursors.resizeColumn;
  print('SystemMouseCursors.resizeColumn: $resizeColumn');

  final resizeRow = SystemMouseCursors.resizeRow;
  print('SystemMouseCursors.resizeRow: $resizeRow');

  final resizeUp = SystemMouseCursors.resizeUp;
  print('SystemMouseCursors.resizeUp: $resizeUp');

  final resizeDown = SystemMouseCursors.resizeDown;
  print('SystemMouseCursors.resizeDown: $resizeDown');

  final resizeLeft = SystemMouseCursors.resizeLeft;
  print('SystemMouseCursors.resizeLeft: $resizeLeft');

  final resizeRight = SystemMouseCursors.resizeRight;
  print('SystemMouseCursors.resizeRight: $resizeRight');

  final resizeUpLeft = SystemMouseCursors.resizeUpLeft;
  print('SystemMouseCursors.resizeUpLeft: $resizeUpLeft');

  final resizeUpRight = SystemMouseCursors.resizeUpRight;
  print('SystemMouseCursors.resizeUpRight: $resizeUpRight');

  final resizeDownLeft = SystemMouseCursors.resizeDownLeft;
  print('SystemMouseCursors.resizeDownLeft: $resizeDownLeft');

  final resizeDownRight = SystemMouseCursors.resizeDownRight;
  print('SystemMouseCursors.resizeDownRight: $resizeDownRight');

  final resizeUpLeftDownRight = SystemMouseCursors.resizeUpLeftDownRight;
  print('SystemMouseCursors.resizeUpLeftDownRight: $resizeUpLeftDownRight');

  final resizeUpRightDownLeft = SystemMouseCursors.resizeUpRightDownLeft;
  print('SystemMouseCursors.resizeUpRightDownLeft: $resizeUpRightDownLeft');

  // Zoom cursors
  final zoomIn = SystemMouseCursors.zoomIn;
  print('SystemMouseCursors.zoomIn: $zoomIn');

  final zoomOut = SystemMouseCursors.zoomOut;
  print('SystemMouseCursors.zoomOut: $zoomOut');

  // ========== MOUSECURSOR ==========
  print('--- MouseCursor Tests ---');

  // MouseCursor.defer and MouseCursor.uncontrolled
  final deferred = MouseCursor.defer;
  print('MouseCursor.defer: $deferred');
  print('  runtimeType: ${deferred.runtimeType}');

  final uncontrolled = MouseCursor.uncontrolled;
  print('MouseCursor.uncontrolled: $uncontrolled');
  print('  runtimeType: ${uncontrolled.runtimeType}');

  // ========== SYSTEMMOUSECURSOR ==========
  print('--- SystemMouseCursor Type Check ---');

  print(
    'SystemMouseCursors.click is SystemMouseCursor: ${click is SystemMouseCursor}',
  );
  print(
    'SystemMouseCursors.text is SystemMouseCursor: ${text is SystemMouseCursor}',
  );
  print(
    'SystemMouseCursors.forbidden is MouseCursor: ${forbidden is MouseCursor}',
  );

  // ========== RETURN WIDGET ==========
  print('Services cursor test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Services Cursor Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• MouseCursor - abstract cursor base'),
          Text('• SystemMouseCursor - system cursor type'),
          Text('• SystemMouseCursors - predefined cursors'),
          SizedBox(height: 16.0),

          Text(
            'Cursor Categories:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFE1F5FE),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Basic: none, basic, click, forbidden, wait'),
                Text('Text: text, verticalText'),
                Text('Selection: cell, precise'),
                Text('Drag: move, grab, grabbing, noDrop, copy'),
                Text('Resize: column, row, up/down/left/right'),
                Text('  diagonal: upLeft, upRight, downLeft, downRight'),
                Text('Zoom: zoomIn, zoomOut'),
                Text('Special: defer, uncontrolled'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
