// D4rt test script: Tests Draggable, DragTarget, LongPressDraggable from widgets
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Draggable/DragTarget/LongPressDraggable test executing');

  // ========== DRAGGABLE ==========
  print('--- Draggable Tests ---');

  // Test basic Draggable with String data
  final draggableBasic = Draggable<String>(
    data: 'Hello',
    feedback: Material(
      elevation: 4.0,
      child: Container(
        width: 100.0,
        height: 50.0,
        color: Colors.blue,
        child: Center(
          child: Text('Dragging', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.blue,
      child: Center(
        child: Text('Drag me', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Draggable basic with String data created');

  // Test Draggable with childWhenDragging
  final draggableWithPlaceholder = Draggable<String>(
    data: 'Item1',
    feedback: Material(
      elevation: 6.0,
      child: Container(
        width: 120.0,
        height: 50.0,
        color: Colors.green,
        child: Center(
          child: Text('Moving...', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
    childWhenDragging: Container(
      width: 120.0,
      height: 50.0,
      color: Colors.grey,
      child: Center(
        child: Text('Gone', style: TextStyle(color: Colors.white)),
      ),
    ),
    child: Container(
      width: 120.0,
      height: 50.0,
      color: Colors.green,
      child: Center(
        child: Text('With placeholder', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Draggable with childWhenDragging created');

  // Test Draggable with onDragStarted/onDragEnd
  final draggableCallbacks = Draggable<int>(
    data: 42,
    onDragStarted: () {
      print('Drag started');
    },
    onDragEnd: (details) {
      print('Drag ended');
    },
    onDraggableCanceled: (velocity, offset) {
      print('Drag canceled');
    },
    feedback: Material(
      child: Container(
        width: 100.0,
        height: 50.0,
        color: Colors.orange,
        child: Center(
          child: Text('42', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.orange,
      child: Center(
        child: Text('Callbacks', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Draggable with callbacks created');

  // Test Draggable with axis constraint
  final draggableHorizontal = Draggable<String>(
    data: 'horizontal',
    axis: Axis.horizontal,
    feedback: Material(
      child: Container(
        width: 100.0,
        height: 50.0,
        color: Colors.purple,
        child: Center(
          child: Text('H-only', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.purple,
      child: Center(
        child: Text('Horizontal', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Draggable with axis=horizontal created');

  // Test Draggable with vertical axis
  final draggableVertical = Draggable<String>(
    data: 'vertical',
    axis: Axis.vertical,
    feedback: Material(
      child: Container(
        width: 100.0,
        height: 50.0,
        color: Colors.teal,
        child: Center(
          child: Text('V-only', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.teal,
      child: Center(
        child: Text('Vertical', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Draggable with axis=vertical created');

  // Test Draggable with maxSimultaneousDrags
  final draggableMaxDrags = Draggable<String>(
    data: 'limited',
    maxSimultaneousDrags: 1,
    feedback: Material(
      child: Container(
        width: 100.0,
        height: 50.0,
        color: Colors.indigo,
        child: Center(
          child: Text('Max 1', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.indigo,
      child: Center(
        child: Text('Max drags=1', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Draggable with maxSimultaneousDrags=1 created');

  // ========== DRAGTARGET ==========
  print('--- DragTarget Tests ---');

  // Test DragTarget basic
  final dragTargetBasic = DragTarget<String>(
    builder: (context, candidateData, rejectedData) {
      return Container(
        width: 200.0,
        height: 80.0,
        color: Colors.grey,
        child: Center(
          child: Text('Drop here', style: TextStyle(color: Colors.white)),
        ),
      );
    },
    onAcceptWithDetails: (details) {
      print('Accepted: ${details.data}');
    },
  );
  print('DragTarget basic created');

  // Test DragTarget with onWillAcceptWithDetails
  final dragTargetFiltered = DragTarget<String>(
    builder: (context, candidateData, rejectedData) {
      return Container(
        width: 200.0,
        height: 80.0,
        color: Colors.blueGrey,
        child: Center(
          child: Text('Filtered target', style: TextStyle(color: Colors.white)),
        ),
      );
    },
    onWillAcceptWithDetails: (details) {
      print('Will accept? ${details.data}');
      return true;
    },
    onAcceptWithDetails: (details) {
      print('Filtered accepted: ${details.data}');
    },
    onLeave: (data) {
      print('Left target');
    },
  );
  print('DragTarget with filtering created');

  // ========== LONGPRESSDRAGGABLE ==========
  print('--- LongPressDraggable Tests ---');

  // Test LongPressDraggable basic
  final longPressBasic = LongPressDraggable<String>(
    data: 'LongPress',
    feedback: Material(
      elevation: 4.0,
      child: Container(
        width: 120.0,
        height: 50.0,
        color: Colors.red,
        child: Center(
          child: Text('Long drag', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
    child: Container(
      width: 120.0,
      height: 50.0,
      color: Colors.red,
      child: Center(
        child: Text('Long press me', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('LongPressDraggable basic created');

  // Test LongPressDraggable with hapticFeedbackOnStart
  final longPressHaptic = LongPressDraggable<String>(
    data: 'Haptic',
    hapticFeedbackOnStart: true,
    feedback: Material(
      elevation: 6.0,
      child: Container(
        width: 120.0,
        height: 50.0,
        color: Colors.deepOrange,
        child: Center(
          child: Text('Haptic', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
    childWhenDragging: Container(
      width: 120.0,
      height: 50.0,
      color: Colors.grey,
      child: Center(
        child: Text('Dragging...', style: TextStyle(color: Colors.white)),
      ),
    ),
    child: Container(
      width: 120.0,
      height: 50.0,
      color: Colors.deepOrange,
      child: Center(
        child: Text('Haptic drag', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('LongPressDraggable with hapticFeedbackOnStart created');

  // Test LongPressDraggable with callbacks
  final longPressCallbacks = LongPressDraggable<int>(
    data: 99,
    onDragStarted: () {
      print('Long press drag started');
    },
    onDragEnd: (details) {
      print('Long press drag ended');
    },
    onDragCompleted: () {
      print('Long press drag completed');
    },
    feedback: Material(
      child: Container(
        width: 120.0,
        height: 50.0,
        color: Colors.brown,
        child: Center(
          child: Text(
            '99',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
    ),
    child: Container(
      width: 120.0,
      height: 50.0,
      color: Colors.brown,
      child: Center(
        child: Text('Callbacks LP', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('LongPressDraggable with callbacks created');

  print('All Draggable/DragTarget/LongPressDraggable tests completed');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '=== Draggable Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Basic:', style: TextStyle(fontWeight: FontWeight.bold)),
        draggableBasic,
        SizedBox(height: 8.0),
        Text(
          'With placeholder:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        draggableWithPlaceholder,
        SizedBox(height: 8.0),
        Text('With callbacks:', style: TextStyle(fontWeight: FontWeight.bold)),
        draggableCallbacks,
        SizedBox(height: 8.0),
        Text('Horizontal only:', style: TextStyle(fontWeight: FontWeight.bold)),
        draggableHorizontal,
        SizedBox(height: 8.0),
        Text('Vertical only:', style: TextStyle(fontWeight: FontWeight.bold)),
        draggableVertical,
        SizedBox(height: 8.0),
        Text('Max drags=1:', style: TextStyle(fontWeight: FontWeight.bold)),
        draggableMaxDrags,
        SizedBox(height: 16.0),
        Text(
          '=== DragTarget Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Basic target:', style: TextStyle(fontWeight: FontWeight.bold)),
        dragTargetBasic,
        SizedBox(height: 8.0),
        Text('Filtered target:', style: TextStyle(fontWeight: FontWeight.bold)),
        dragTargetFiltered,
        SizedBox(height: 16.0),
        Text(
          '=== LongPressDraggable Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Basic:', style: TextStyle(fontWeight: FontWeight.bold)),
        longPressBasic,
        SizedBox(height: 8.0),
        Text('Haptic feedback:', style: TextStyle(fontWeight: FontWeight.bold)),
        longPressHaptic,
        SizedBox(height: 8.0),
        Text('With callbacks:', style: TextStyle(fontWeight: FontWeight.bold)),
        longPressCallbacks,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Draggable creates drag-and-drop items with feedback widgets'),
        Text('• DragTarget receives dropped items via onAcceptWithDetails'),
        Text('• LongPressDraggable requires long press to start dragging'),
        Text('• axis constrains drag to horizontal or vertical'),
        Text('• childWhenDragging shows placeholder during drag'),
      ],
    ),
  );
}
