// D4rt test script: Tests GestureRecognizerCallback, RecognizerCallback, GestureDragStartCallback, GestureDragUpdateCallback, GestureDragEndCallback, GestureDragCancelCallback, GestureDragDownCallback, GestureScaleStartCallback, GestureScaleUpdateCallback
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Gesture callback typedef tests executing');

  // ========== GestureDragStartCallback ==========
  print('--- GestureDragStartCallback Tests ---');
  // GestureDragStartCallback = void Function(DragStartDetails)
  final GestureDragStartCallback dragStartCallback =
      (DragStartDetails details) {
        print('Drag started at: ${details.globalPosition}');
      };
  print('GestureDragStartCallback type: ${dragStartCallback.runtimeType}');

  // ========== GestureDragUpdateCallback ==========
  print('--- GestureDragUpdateCallback Tests ---');
  // GestureDragUpdateCallback = void Function(DragUpdateDetails)
  final GestureDragUpdateCallback dragUpdateCallback =
      (DragUpdateDetails details) {
        print('Drag update delta: ${details.delta}');
      };
  print('GestureDragUpdateCallback type: ${dragUpdateCallback.runtimeType}');

  // ========== GestureDragEndCallback ==========
  print('--- GestureDragEndCallback Tests ---');
  // GestureDragEndCallback = void Function(DragEndDetails)
  final GestureDragEndCallback dragEndCallback = (DragEndDetails details) {
    print('Drag ended with velocity: ${details.velocity}');
  };
  print('GestureDragEndCallback type: ${dragEndCallback.runtimeType}');

  // ========== GestureDragCancelCallback ==========
  print('--- GestureDragCancelCallback Tests ---');
  // GestureDragCancelCallback = void Function()
  final GestureDragCancelCallback dragCancelCallback = () {
    print('Drag cancelled');
  };
  print('GestureDragCancelCallback type: ${dragCancelCallback.runtimeType}');

  // ========== GestureDragDownCallback ==========
  print('--- GestureDragDownCallback Tests ---');
  // GestureDragDownCallback = void Function(DragDownDetails)
  final GestureDragDownCallback dragDownCallback = (DragDownDetails details) {
    print('Drag down at: ${details.globalPosition}');
  };
  print('GestureDragDownCallback type: ${dragDownCallback.runtimeType}');

  // ========== GestureScaleStartCallback ==========
  print('--- GestureScaleStartCallback Tests ---');
  // GestureScaleStartCallback = void Function(ScaleStartDetails)
  final GestureScaleStartCallback scaleStartCallback =
      (ScaleStartDetails details) {
        print('Scale started, pointers: ${details.pointerCount}');
      };
  print('GestureScaleStartCallback type: ${scaleStartCallback.runtimeType}');

  // ========== GestureScaleUpdateCallback ==========
  print('--- GestureScaleUpdateCallback Tests ---');
  // GestureScaleUpdateCallback = void Function(ScaleUpdateDetails)
  final GestureScaleUpdateCallback scaleUpdateCallback =
      (ScaleUpdateDetails details) {
        print('Scale update, scale: ${details.scale}');
      };
  print('GestureScaleUpdateCallback type: ${scaleUpdateCallback.runtimeType}');

  // ========== GestureRecognizerCallback ==========
  print('--- GestureRecognizerCallback Tests ---');
  // GestureRecognizerCallback is a generic typedef used in gesture recognizer factories
  // GestureRecognizerFactoryWithHandlers uses callbacks to initialize recognizers
  final tapRecognizer = TapGestureRecognizer();
  print('TapGestureRecognizer type: ${tapRecognizer.runtimeType}');
  print('GestureRecognizer base type: ${GestureRecognizer}');
  // Reference the factory pattern that uses recognizer callbacks
  final factory = GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
    () => TapGestureRecognizer(),
    (TapGestureRecognizer instance) {
      instance.onTap = () {};
    },
  );
  print('GestureRecognizerFactoryWithHandlers type: ${factory.runtimeType}');

  // ========== RecognizerCallback ==========
  print('--- RecognizerCallback Tests ---');
  // RecognizerCallback is similar to GestureRecognizerCallback
  // Referenced through the gesture recognition system
  final panRecognizer = PanGestureRecognizer();
  panRecognizer.onStart = dragStartCallback;
  panRecognizer.onUpdate = dragUpdateCallback;
  panRecognizer.onEnd = dragEndCallback;
  panRecognizer.onCancel = dragCancelCallback;
  print('PanGestureRecognizer configured with all drag callbacks');
  print('PanGestureRecognizer type: ${panRecognizer.runtimeType}');

  // Verify pan callbacks with a GestureDetector
  // Note: Pan and Scale cannot be combined on the same GestureDetector
  // because scale is a superset of pan in Flutter.
  final gestureDetector = GestureDetector(
    onPanStart: dragStartCallback,
    onPanUpdate: dragUpdateCallback,
    onPanEnd: dragEndCallback,
    onPanCancel: dragCancelCallback,
    onPanDown: dragDownCallback,
    child: Container(),
  );
  print(
    'GestureDetector configured with pan callbacks: ${gestureDetector.runtimeType}',
  );

  // Verify scale callbacks with a separate GestureDetector
  final scaleDetector = GestureDetector(
    onScaleStart: scaleStartCallback,
    onScaleUpdate: scaleUpdateCallback,
    child: Container(),
  );

  print('All gesture callback tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gesture Callbacks Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('GestureDragStartCallback: defined'),
            Text('GestureDragUpdateCallback: defined'),
            Text('GestureDragEndCallback: defined'),
            Text('GestureDragCancelCallback: defined'),
            Text('GestureDragDownCallback: defined'),
            Text('GestureScaleStartCallback: defined'),
            Text('GestureScaleUpdateCallback: defined'),
            Text('GestureRecognizerCallback: via factory'),
            Text('RecognizerCallback: via PanGestureRecognizer'),
          ],
        ),
      ),
    ),
  );
}
