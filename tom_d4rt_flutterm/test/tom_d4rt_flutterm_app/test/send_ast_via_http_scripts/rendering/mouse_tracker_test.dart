// D4rt test script: Tests MouseTracker from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MouseTracker test executing');

  // ========== MouseTracker basics ==========
  print('--- MouseTracker basics ---');
  // MouseTracker is typically created and managed by the rendering binding
  // We can test the interface and concepts
  print('  MouseTracker manages mouse pointer state');
  print('  Tracks which render objects the mouse is over');
  print('  Handles mouse enter/exit events');

  // ========== MouseTrackerAnnotation ==========
  print('--- MouseTrackerAnnotation ---');
  int enterCount = 0;
  int exitCount = 0;
  int hoverCount = 0;

  final annotation1 = MouseTrackerAnnotation(
    onEnter: (event) {
      enterCount++;
      print('  onEnter called: pointer ${event.pointer}');
    },
    onExit: (event) {
      exitCount++;
      print('  onExit called: pointer ${event.pointer}');
    },
    onHover: (event) {
      hoverCount++;
      print('  onHover called');
    },
  );
  print('  annotation1 created: ${annotation1.runtimeType}');

  // ========== MouseTrackerAnnotation with cursor ==========
  print('--- MouseTrackerAnnotation with cursor ---');
  final annotationWithCursor = MouseTrackerAnnotation(
    cursor: SystemMouseCursors.click,
    onEnter: (event) => print('  entered clickable region'),
    onExit: (event) => print('  exited clickable region'),
  );
  print('  cursor: ${annotationWithCursor.cursor}');

  // ========== Different cursor types ==========
  print('--- Different cursor types ---');
  final cursors = [
    ('basic', SystemMouseCursors.basic),
    ('click', SystemMouseCursors.click),
    ('text', SystemMouseCursors.text),
    ('grab', SystemMouseCursors.grab),
    ('grabbing', SystemMouseCursors.grabbing),
    ('resizeColumn', SystemMouseCursors.resizeColumn),
    ('resizeRow', SystemMouseCursors.resizeRow),
    ('move', SystemMouseCursors.move),
    ('noDrop', SystemMouseCursors.noDrop),
    ('forbidden', SystemMouseCursors.forbidden),
  ];
  for (final (name, cursor) in cursors) {
    final ann = MouseTrackerAnnotation(cursor: cursor);
    print('  $name cursor: ${ann.cursor}');
  }

  // ========== validForMouseTracker property ==========
  print('--- validForMouseTracker property ---');
  final validAnnotation = MouseTrackerAnnotation(
    onEnter: (_) {},
    validForMouseTracker: true,
  );
  print('  validForMouseTracker: true - ${validAnnotation.runtimeType}');

  // ========== PointerEnterEvent ==========
  print('--- PointerEnterEvent ---');
  final enterEvent = PointerEnterEvent(
    position: Offset(100.0, 100.0),
    localPosition: Offset(50.0, 50.0),
  );
  print('  PointerEnterEvent position: ${enterEvent.position}');
  print('  PointerEnterEvent localPosition: ${enterEvent.localPosition}');

  // ========== PointerExitEvent ==========
  print('--- PointerExitEvent ---');
  final exitEvent = PointerExitEvent(
    position: Offset(200.0, 200.0),
    localPosition: Offset(100.0, 100.0),
  );
  print('  PointerExitEvent position: ${exitEvent.position}');
  print('  PointerExitEvent localPosition: ${exitEvent.localPosition}');

  // ========== PointerHoverEvent ==========
  print('--- PointerHoverEvent ---');
  final hoverEvent = PointerHoverEvent(
    position: Offset(150.0, 150.0),
    delta: Offset(5.0, 5.0),
  );
  print('  PointerHoverEvent position: ${hoverEvent.position}');
  print('  PointerHoverEvent delta: ${hoverEvent.delta}');

  // ========== Multiple annotations ==========
  print('--- Multiple annotations ---');
  final annotations = List.generate(5, (i) {
    return MouseTrackerAnnotation(
      cursor: i.isEven ? SystemMouseCursors.click : SystemMouseCursors.text,
      onEnter: (e) => print('  annotation $i entered'),
      onExit: (e) => print('  annotation $i exited'),
    );
  });
  print('  created ${annotations.length} annotations');
  for (int i = 0; i < annotations.length; i++) {
    print('  annotation $i cursor: ${annotations[i].cursor}');
  }

  // ========== RuntimeType checks ==========
  print('--- RuntimeType checks ---');
  print('  annotation1.runtimeType: ${annotation1.runtimeType}');
  print('  enterEvent.runtimeType: ${enterEvent.runtimeType}');
  print('  exitEvent.runtimeType: ${exitEvent.runtimeType}');
  print('  hoverEvent.runtimeType: ${hoverEvent.runtimeType}');

  print('MouseTracker test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'MouseTracker Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('MouseTracker: Manages mouse pointer state'),
          Text('MouseTrackerAnnotation: ${annotation1.runtimeType}'),
          SizedBox(height: 8.0),
          Text('Cursor types tested:'),
          ...cursors.take(5).map((c) => Text('  - ${c.$1}')),
          SizedBox(height: 8.0),
          Text('Events:'),
          Text('  PointerEnterEvent: ${enterEvent.position}'),
          Text('  PointerExitEvent: ${exitEvent.position}'),
          Text('  PointerHoverEvent: ${hoverEvent.position}'),
          SizedBox(height: 8.0),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              color: Color(0xFF2196F3),
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Hover me!',
                style: TextStyle(color: Color(0xFFFFFFFF)),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
