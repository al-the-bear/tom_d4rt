// D4rt test script: Tests scheduler package classes (Priority enum)
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Scheduler package class test executing');
  final results = <String>[];

  // Test 1: Priority enum exists
  results.add('Test 1: Priority enum exists in scheduler package');
  print('Priority enum available');

  // Test 2: Priority.idle value
  final idlePriority = Priority.idle;
  results.add('Priority.idle: $idlePriority');
  print('Priority.idle: $idlePriority');
  assert(idlePriority != null, 'Priority.idle should exist');

  // Test 3: Priority.animation value
  final animPriority = Priority.animation;
  results.add('Priority.animation: $animPriority');
  print('Priority.animation: $animPriority');
  assert(animPriority != null, 'Priority.animation should exist');

  // Test 4: Priority.touch value
  final touchPriority = Priority.touch;
  results.add('Priority.touch: $touchPriority');
  print('Priority.touch: $touchPriority');
  assert(touchPriority != null, 'Priority.touch should exist');

  // Test 5: Priority.kMaxOffset constant
  final maxOffset = Priority.kMaxOffset;
  results.add('Priority.kMaxOffset: $maxOffset');
  print('Priority.kMaxOffset: $maxOffset');
  assert(maxOffset != null, 'kMaxOffset should be defined');

  // Test 6: Priority index access (idle)
  final idleIndex = Priority.idle.index;
  results.add('Priority.idle.index: $idleIndex');
  print('Priority.idle index: $idleIndex');

  // Test 7: Priority index access (animation)
  final animIndex = Priority.animation.index;
  results.add('Priority.animation.index: $animIndex');
  print('Priority.animation index: $animIndex');

  // Test 8: Priority index access (touch)
  final touchIndex = Priority.touch.index;
  results.add('Priority.touch.index: $touchIndex');
  print('Priority.touch index: $touchIndex');

  // Test 9: Priority ordering (touch > animation > idle)
  results.add('Test 9: Priority ordering');
  print('Checking priority ordering');
  assert(
    touchIndex > animIndex,
    'touch should have higher index than animation',
  );
  assert(animIndex > idleIndex, 'animation should have higher index than idle');

  // Test 10: Priority values list
  final values = Priority.values;
  results.add('Priority.values count: ${values.length}');
  print('Priority values count: ${values.length}');
  assert(values.length >= 3, 'Should have at least 3 priority values');

  // Test 11: Priority values contains idle
  final containsIdle = values.contains(Priority.idle);
  results.add('values contains idle: $containsIdle');
  print('Priority.values contains idle: $containsIdle');
  assert(containsIdle, 'Values should contain idle');

  // Test 12: Priority values contains animation
  final containsAnim = values.contains(Priority.animation);
  results.add('values contains animation: $containsAnim');
  print('Priority.values contains animation: $containsAnim');
  assert(containsAnim, 'Values should contain animation');

  // Test 13: Priority values contains touch
  final containsTouch = values.contains(Priority.touch);
  results.add('values contains touch: $containsTouch');
  print('Priority.values contains touch: $containsTouch');
  assert(containsTouch, 'Values should contain touch');

  // Test 14: Priority name getter (idle)
  final idleName = Priority.idle.name;
  results.add('Priority.idle.name: $idleName');
  print('Priority.idle name: $idleName');
  assert(idleName == 'idle', 'Idle name should be "idle"');

  // Test 15: Priority name getter (animation)
  final animName = Priority.animation.name;
  results.add('Priority.animation.name: $animName');
  print('Priority.animation name: $animName');
  assert(animName == 'animation', 'Animation name should be "animation"');

  // Test 16: Priority name getter (touch)
  final touchName = Priority.touch.name;
  results.add('Priority.touch.name: $touchName');
  print('Priority.touch name: $touchName');
  assert(touchName == 'touch', 'Touch name should be "touch"');

  // Test 17: Priority toString
  final idleStr = Priority.idle.toString();
  results.add('Priority.idle.toString(): $idleStr');
  print('Priority.idle toString: $idleStr');
  assert(idleStr.contains('idle'), 'toString should contain "idle"');

  // Test 18: Priority comparison
  results.add('Test 18: Priority comparison via index');
  final isIdleLowerThanAnim = idleIndex < animIndex;
  results.add('idle < animation: $isIdleLowerThanAnim');
  print('Idle lower than animation: $isIdleLowerThanAnim');
  assert(isIdleLowerThanAnim, 'Idle should be lower priority than animation');

  // Test 19: Priority enum iteration
  var iterCount = 0;
  for (final p in Priority.values) {
    iterCount++;
    print('Iterating: $p');
  }
  results.add('Iteration count: $iterCount');
  assert(iterCount >= 3, 'Should iterate at least 3 values');

  // Test 20: Priority identity
  final idle1 = Priority.idle;
  final idle2 = Priority.idle;
  results.add('Priority.idle identity: ${identical(idle1, idle2)}');
  print('Priority identity check');
  assert(identical(idle1, idle2), 'Same priority should be identical');

  print('Scheduler package class test completed - ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Scheduler Package Class Tests (${results.length} tests)',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8),
      ...results.map(
        (r) => Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Text(r, style: TextStyle(fontSize: 12)),
        ),
      ),
    ],
  );
}
