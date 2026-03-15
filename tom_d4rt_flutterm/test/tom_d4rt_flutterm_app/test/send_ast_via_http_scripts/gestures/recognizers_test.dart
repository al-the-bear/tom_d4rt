// D4rt test script: Tests gesture recognizer classes from package:flutter/gestures.dart
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Gestures recognizers test executing');

  // ========== HORIZONTALDRAGGESTURERECOGNIZER ==========
  print('--- HorizontalDragGestureRecognizer Tests ---');

  final hDrag = HorizontalDragGestureRecognizer();
  print('HorizontalDragGestureRecognizer created');
  print('  runtimeType: ${hDrag.runtimeType}');
  print('  debugDescription: ${hDrag.debugDescription}');

  hDrag.onStart = (DragStartDetails details) {
    print('  hDrag.onStart: ${details.globalPosition}');
  };
  hDrag.onUpdate = (DragUpdateDetails details) {
    print('  hDrag.onUpdate: ${details.delta}');
  };
  hDrag.onEnd = (DragEndDetails details) {
    print('  hDrag.onEnd: ${details.velocity}');
  };
  print('  Callbacks set: onStart, onUpdate, onEnd');
  hDrag.dispose();
  print('  Disposed');

  // ========== VERTICALDRAGGESTURERECOGNIZER ==========
  print('--- VerticalDragGestureRecognizer Tests ---');

  final vDrag = VerticalDragGestureRecognizer();
  print('VerticalDragGestureRecognizer created');
  print('  runtimeType: ${vDrag.runtimeType}');
  print('  debugDescription: ${vDrag.debugDescription}');

  vDrag.onStart = (DragStartDetails details) {
    print('  vDrag.onStart: ${details.globalPosition}');
  };
  vDrag.onUpdate = (DragUpdateDetails details) {
    print('  vDrag.onUpdate: ${details.delta}');
  };
  print('  Callbacks set: onStart, onUpdate');
  vDrag.dispose();
  print('  Disposed');

  // ========== PANGESTURERECOGNIZER ==========
  print('--- PanGestureRecognizer Tests ---');

  final pan = PanGestureRecognizer();
  print('PanGestureRecognizer created');
  print('  runtimeType: ${pan.runtimeType}');
  print('  debugDescription: ${pan.debugDescription}');

  pan.onStart = (DragStartDetails details) {
    print('  pan.onStart: ${details.globalPosition}');
  };
  pan.onUpdate = (DragUpdateDetails details) {
    print('  pan.onUpdate: delta=${details.delta}');
  };
  pan.onEnd = (DragEndDetails details) {
    print('  pan.onEnd: velocity=${details.velocity}');
  };
  print('  Callbacks set: onStart, onUpdate, onEnd');
  pan.dispose();
  print('  Disposed');

  // ========== SCALEGESTURERECOGNIZER ==========
  print('--- ScaleGestureRecognizer Tests ---');

  final scale = ScaleGestureRecognizer();
  print('ScaleGestureRecognizer created');
  print('  runtimeType: ${scale.runtimeType}');
  print('  debugDescription: ${scale.debugDescription}');

  scale.onStart = (ScaleStartDetails details) {
    print('  scale.onStart: focalPoint=${details.focalPoint}');
  };
  scale.onUpdate = (ScaleUpdateDetails details) {
    print(
      '  scale.onUpdate: scale=${details.scale}, rotation=${details.rotation}',
    );
  };
  scale.onEnd = (ScaleEndDetails details) {
    print('  scale.onEnd: velocity=${details.velocity}');
  };
  print('  Callbacks set: onStart, onUpdate, onEnd');
  scale.dispose();
  print('  Disposed');

  // ========== LONGPRESSGESTURERECOGNIZER ==========
  print('--- LongPressGestureRecognizer Tests ---');

  final longPress = LongPressGestureRecognizer();
  print('LongPressGestureRecognizer created');
  print('  runtimeType: ${longPress.runtimeType}');
  print('  debugDescription: ${longPress.debugDescription}');

  longPress.onLongPress = () {
    print('  longPress triggered');
  };
  longPress.onLongPressStart = (LongPressStartDetails details) {
    print('  longPress.onStart: ${details.globalPosition}');
  };
  longPress.onLongPressMoveUpdate = (LongPressMoveUpdateDetails details) {
    print('  longPress.onMoveUpdate: ${details.globalPosition}');
  };
  longPress.onLongPressEnd = (LongPressEndDetails details) {
    print('  longPress.onEnd: ${details.globalPosition}');
  };
  print('  Callbacks set: onLongPress, onStart, onMoveUpdate, onEnd');
  longPress.dispose();
  print('  Disposed');

  // ========== DOUBLETAPGESTURERECOGNIZER ==========
  print('--- DoubleTapGestureRecognizer Tests ---');

  final doubleTap = DoubleTapGestureRecognizer();
  print('DoubleTapGestureRecognizer created');
  print('  runtimeType: ${doubleTap.runtimeType}');
  print('  debugDescription: ${doubleTap.debugDescription}');

  doubleTap.onDoubleTap = () {
    print('  doubleTap triggered');
  };
  doubleTap.onDoubleTapDown = (TapDownDetails details) {
    print('  doubleTap.onDown: ${details.globalPosition}');
  };
  doubleTap.onDoubleTapCancel = () {
    print('  doubleTap cancelled');
  };
  print('  Callbacks set: onDoubleTap, onDoubleTapDown, onDoubleTapCancel');
  doubleTap.dispose();
  print('  Disposed');

  // ========== FORCEPRESSGESTURERECOGNIZER ==========
  print('--- ForcePressGestureRecognizer Tests ---');

  final forcePress = ForcePressGestureRecognizer();
  print('ForcePressGestureRecognizer created');
  print('  runtimeType: ${forcePress.runtimeType}');
  print('  debugDescription: ${forcePress.debugDescription}');

  forcePress.onStart = (ForcePressDetails details) {
    print(
      '  forcePress.onStart: ${details.globalPosition}, pressure=${details.pressure}',
    );
  };
  forcePress.onPeak = (ForcePressDetails details) {
    print('  forcePress.onPeak: pressure=${details.pressure}');
  };
  forcePress.onUpdate = (ForcePressDetails details) {
    print('  forcePress.onUpdate: pressure=${details.pressure}');
  };
  forcePress.onEnd = (ForcePressDetails details) {
    print('  forcePress.onEnd: pressure=${details.pressure}');
  };
  print('  Callbacks set: onStart, onPeak, onUpdate, onEnd');
  forcePress.dispose();
  print('  Disposed');

  // ========== TAPGESTURERECOGNIZER ==========
  print('--- TapGestureRecognizer Tests ---');

  final tap = TapGestureRecognizer();
  print('TapGestureRecognizer created');
  print('  runtimeType: ${tap.runtimeType}');
  print('  debugDescription: ${tap.debugDescription}');

  tap.onTap = () => print('  tapped');
  tap.onTapDown = (TapDownDetails d) => print('  tapDown: ${d.globalPosition}');
  tap.onTapUp = (TapUpDetails d) => print('  tapUp: ${d.globalPosition}');
  tap.onTapCancel = () => print('  tapCancel');
  print('  Callbacks set: onTap, onTapDown, onTapUp, onTapCancel');
  tap.dispose();
  print('  Disposed');

  // ========== RETURN WIDGET ==========
  print('Gestures recognizers test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gestures Recognizers Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• HorizontalDragGestureRecognizer'),
          Text('• VerticalDragGestureRecognizer'),
          Text('• PanGestureRecognizer'),
          Text('• ScaleGestureRecognizer'),
          Text('• LongPressGestureRecognizer'),
          Text('• DoubleTapGestureRecognizer'),
          Text('• ForcePressGestureRecognizer'),
          Text('• TapGestureRecognizer'),
          SizedBox(height: 16.0),

          Text('Notes:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFFFF9C4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• Recognizers are typically created by GestureDetector'),
                Text(
                  '• Each recognizer must be disposed when no longer needed',
                ),
                Text(
                  '• Callbacks receive detail objects with position/velocity',
                ),
                Text('• ForcePressGestureRecognizer requires 3D touch support'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
