// D4rt test script: Tests GestureDetector widget from widgets
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('GestureDetector test executing');

  // Test GestureDetector with onTap
  final tapDetector = GestureDetector(
    onTap: () {
      print('Tap detected!');
    },
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.blue,
      child: Center(
        child: Text('Tap Me', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('GestureDetector with onTap created');

  // Test GestureDetector with onDoubleTap
  final doubleTapDetector = GestureDetector(
    onDoubleTap: () {
      print('Double tap detected!');
    },
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.green,
      child: Center(
        child: Text('Double Tap', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('GestureDetector with onDoubleTap created');

  // Test GestureDetector with onLongPress
  final longPressDetector = GestureDetector(
    onLongPress: () {
      print('Long press detected!');
    },
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.orange,
      child: Center(
        child: Text('Long Press', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('GestureDetector with onLongPress created');

  // Test GestureDetector with onTapDown and onTapUp
  final tapUpDownDetector = GestureDetector(
    onTapDown: (details) {
      print('Tap down at: ${details.localPosition}');
    },
    onTapUp: (details) {
      print('Tap up at: ${details.localPosition}');
    },
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.purple,
      child: Center(
        child: Text(
          'Tap Up/Down',
          style: TextStyle(color: Colors.white, fontSize: 12.0),
        ),
      ),
    ),
  );
  print('GestureDetector with onTapDown and onTapUp created');

  // Test GestureDetector with drag callbacks
  final dragDetector = GestureDetector(
    onPanStart: (details) {
      print('Pan start at: ${details.localPosition}');
    },
    onPanUpdate: (details) {
      print('Pan update: ${details.delta}');
    },
    onPanEnd: (details) {
      print('Pan end with velocity: ${details.velocity}');
    },
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.teal,
      child: Center(
        child: Text('Drag Me', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('GestureDetector with pan/drag callbacks created');

  // Test GestureDetector with scale callbacks
  final scaleDetector = GestureDetector(
    onScaleStart: (details) {
      print('Scale start at: ${details.focalPoint}');
    },
    onScaleUpdate: (details) {
      print('Scale: ${details.scale}');
    },
    onScaleEnd: (details) {
      print('Scale end with velocity: ${details.velocity}');
    },
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.indigo,
      child: Center(
        child: Text('Scale', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('GestureDetector with scale callbacks created');

  // Test GestureDetector with behavior
  final behaviorDetector = GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      print('Opaque behavior tap!');
    },
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.pink,
      child: Center(
        child: Text('Opaque', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('GestureDetector with HitTestBehavior.opaque created');

  // Test GestureDetector with excludeFromSemantics
  final excludeSemanticsDetector = GestureDetector(
    excludeFromSemantics: true,
    onTap: () {
      print('Excluded from semantics tap!');
    },
    child: Container(
      width: 100.0,
      height: 50.0,
      color: Colors.amber,
      child: Center(
        child: Text('No A11y', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('GestureDetector with excludeFromSemantics=true created');

  print('GestureDetector test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [tapDetector, SizedBox(width: 8.0), doubleTapDetector],
      ),
      SizedBox(height: 8.0),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [longPressDetector, SizedBox(width: 8.0), tapUpDownDetector],
      ),
      SizedBox(height: 8.0),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [dragDetector, SizedBox(width: 8.0), scaleDetector],
      ),
      SizedBox(height: 8.0),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          behaviorDetector,
          SizedBox(width: 8.0),
          excludeSemanticsDetector,
        ],
      ),
    ],
  );
}
