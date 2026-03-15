// D4rt test script: Tests Priority enum from scheduler in detail
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Priority enum detailed test executing');
  final results = <String>[];

  // Test 1: Priority.idle exists and is valid
  final idle = Priority.idle;
  results.add('Test 1: Priority.idle = $idle');
  print('Priority.idle: $idle');
  assert(idle == Priority.idle, 'idle should equal itself');

  // Test 2: Priority.animation exists and is valid
  final animation = Priority.animation;
  results.add('Test 2: Priority.animation = $animation');
  print('Priority.animation: $animation');
  assert(animation == Priority.animation, 'animation should equal itself');

  // Test 3: Priority.touch exists and is valid
  final touch = Priority.touch;
  results.add('Test 3: Priority.touch = $touch');
  print('Priority.touch: $touch');
  assert(touch == Priority.touch, 'touch should equal itself');

  // Test 4: Index of idle
  results.add('Test 4: Priority.idle.index = ${idle.index}');
  print('idle index: ${idle.index}');

  // Test 5: Index of animation
  results.add('Test 5: Priority.animation.index = ${animation.index}');
  print('animation index: ${animation.index}');

  // Test 6: Index of touch
  results.add('Test 6: Priority.touch.index = ${touch.index}');
  print('touch index: ${touch.index}');

  // Test 7: Index ordering (idle < animation)
  final idleLessAnim = idle.index < animation.index;
  results.add('Test 7: idle.index < animation.index = $idleLessAnim');
  print('idle < animation: $idleLessAnim');
  assert(idleLessAnim, 'idle should have lower index than animation');

  // Test 8: Index ordering (animation < touch)
  final animLessTouch = animation.index < touch.index;
  results.add('Test 8: animation.index < touch.index = $animLessTouch');
  print('animation < touch: $animLessTouch');
  assert(animLessTouch, 'animation should have lower index than touch');

  // Test 9: Name of idle
  results.add('Test 9: Priority.idle.name = "${idle.name}"');
  print('idle.name: ${idle.name}');
  assert(idle.name == 'idle', 'idle.name should be "idle"');

  // Test 10: Name of animation
  results.add('Test 10: Priority.animation.name = "${animation.name}"');
  print('animation.name: ${animation.name}');
  assert(animation.name == 'animation', 'animation.name should be "animation"');

  // Test 11: Name of touch
  results.add('Test 11: Priority.touch.name = "${touch.name}"');
  print('touch.name: ${touch.name}');
  assert(touch.name == 'touch', 'touch.name should be "touch"');

  // Test 12: Priority.values list
  final values = Priority.values;
  results.add('Test 12: Priority.values.length = ${values.length}');
  print('Priority.values.length: ${values.length}');
  assert(values.length >= 3, 'Should have at least 3 values');

  // Test 13: Values contains all three main priorities
  final hasAll = values.contains(idle) && values.contains(animation) && values.contains(touch);
  results.add('Test 13: values contains all three = $hasAll');
  print('Contains all three: $hasAll');
  assert(hasAll, 'Values should contain all three priorities');

  // Test 14: kMaxOffset constant
  final maxOffset = Priority.kMaxOffset;
  results.add('Test 14: Priority.kMaxOffset = $maxOffset');
  print('kMaxOffset: $maxOffset');
  assert(maxOffset >= 0, 'kMaxOffset should be non-negative');

  // Test 15: Priority toString contains name
  final idleStr = idle.toString();
  results.add('Test 15: idle.toString() = "$idleStr"');
  print('idle.toString: $idleStr');
  assert(idleStr.contains('idle'), 'toString should contain "idle"');

  // Test 16: Animation toString
  final animStr = animation.toString();
  results.add('Test 16: animation.toString() = "$animStr"');
  print('animation.toString: $animStr');
  assert(animStr.contains('animation'), 'toString should contain "animation"');

  // Test 17: Touch toString
  final touchStr = touch.toString();
  results.add('Test 17: touch.toString() = "$touchStr"');
  print('touch.toString: $touchStr');
  assert(touchStr.contains('touch'), 'toString should contain "touch"');

  // Test 18: Equality tests (same enum values)
  results.add('Test 18: Priority.idle == Priority.idle = ${Priority.idle == Priority.idle}');
  print('idle == idle: ${Priority.idle == Priority.idle}');
  assert(Priority.idle == Priority.idle, 'Same enum value should be equal');

  // Test 19: Inequality tests (different enum values)
  final idleNotAnim = Priority.idle != Priority.animation;
  results.add('Test 19: idle != animation = $idleNotAnim');
  print('idle != animation: $idleNotAnim');
  assert(idleNotAnim, 'Different enum values should not be equal');

  // Test 20: Inequality tests (animation != touch)
  final animNotTouch = Priority.animation != Priority.touch;
  results.add('Test 20: animation != touch = $animNotTouch');
  print('animation != touch: $animNotTouch');
  assert(animNotTouch, 'Different enum values should not be equal');

  // Test 21: Values are ordered
  var orderedProperly = true;
  for (var i = 0; i < values.length - 1; i++) {
    if (values[i].index >= values[i + 1].index) {
      orderedProperly = false;
      break;
    }
  }
  results.add('Test 21: values ordered by index = $orderedProperly');
  print('Values ordered: $orderedProperly');

  // Test 22: First value is idle
  results.add('Test 22: values[0] = ${values[0]}');
  print('First value: ${values[0]}');

  // Test 23: Last value has highest index
  final lastVal = values.last;
  results.add('Test 23: values.last.index = ${lastVal.index}');
  print('Last value index: ${lastVal.index}');

  // Test 24: Hash code consistency
  final hash1 = idle.hashCode;
  final hash2 = idle.hashCode;
  results.add('Test 24: hashCode consistent = ${hash1 == hash2}');
  print('Hash code consistent: ${hash1 == hash2}');

  print('Priority enum detailed test completed - ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Priority Enum Detailed Tests (${results.length} tests)',
           style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      ...results.map((r) => Padding(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Text(r, style: TextStyle(fontSize: 12)),
      )),
    ],
  );
}
