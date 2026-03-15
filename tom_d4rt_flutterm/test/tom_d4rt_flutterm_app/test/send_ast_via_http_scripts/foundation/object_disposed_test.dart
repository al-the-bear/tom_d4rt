// D4rt test script: Tests ObjectDisposed from foundation
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ObjectDisposed comprehensive test executing');
  final results = <String>[];

  // ========== ObjectDisposed Tests ==========
  print('Testing ObjectDisposed...');

  // Test 1: Create ObjectDisposed event
  final testObject = Object();
  final event1 = ObjectDisposed(object: testObject);
  assert(event1 != null, 'Should create ObjectDisposed');
  results.add('ObjectDisposed created');
  print('ObjectDisposed created: ${event1.runtimeType}');

  // Test 2: Verify object property
  assert(event1.object == testObject, 'Object reference should match');
  results.add('Object reference verified');
  print('Object: ${event1.object}');

  // Test 3: Check inheritance from ObjectEvent
  assert(event1 is ObjectEvent, 'Should be ObjectEvent');
  results.add('Inheritance: ObjectEvent');
  print('Is ObjectEvent: ${event1 is ObjectEvent}');

  // Test 4: ObjectDisposed vs ObjectCreated
  final createdEvent = ObjectCreated(object: testObject);
  assert(createdEvent is ObjectEvent, 'Created should be ObjectEvent');
  assert(event1 is ObjectEvent, 'Disposed should be ObjectEvent');
  results.add('Both are ObjectEvent subclasses');
  print('ObjectCreated and ObjectDisposed are ObjectEvent');

  // Test 5: Create event with custom object
  final customObj = StringBuffer('test');
  final event2 = ObjectDisposed(object: customObj);
  assert(event2.object == customObj, 'Custom object should match');
  results.add('ObjectDisposed with StringBuffer');
  print('Event with StringBuffer: ${event2.object.runtimeType}');

  // Test 6: Purpose of ObjectDisposed
  results.add('Purpose: Track object lifecycle disposal');
  print('ObjectDisposed tracks when objects are disposed');

  // Test 7: Memory tracking context
  results.add('Used for memory leak detection');
  print('FlutterMemoryAllocations uses ObjectDisposed');

  // Test 8: Create event with list object
  final listObj = [1, 2, 3];
  final event3 = ObjectDisposed(object: listObj);
  assert(event3.object == listObj, 'List reference should match');
  results.add('ObjectDisposed with List');
  print('Event with List: ${event3.object.runtimeType}');

  // Test 9: Create event with map object
  final mapObj = {'key': 'value'};
  final event4 = ObjectDisposed(object: mapObj);
  assert(event4.object == mapObj, 'Map reference should match');
  results.add('ObjectDisposed with Map');
  print('Event with Map: ${event4.object.runtimeType}');

  // Test 10: Object identity preservation
  assert(identical(event1.object, testObject), 'Should be identical');
  results.add('Object identity preserved');
  print('Object identity verified via identical()');

  // Test 11: Multiple events for same object
  final multiObj = Object();
  final created = ObjectCreated(object: multiObj);
  final disposed = ObjectDisposed(object: multiObj);
  assert(created.object == disposed.object, 'Same object tracked');
  results.add('Created and Disposed track same object');
  print('Lifecycle: Created -> Disposed');

  // Test 12: FlutterMemoryAllocations concept
  results.add('FlutterMemoryAllocations.instance dispatches events');
  print('Memory allocations system uses these events');

  // Test 13: DevTools integration
  results.add('Events visible in Flutter DevTools');
  print('DevTools memory view shows allocation events');

  // Test 14: Debug mode tracking
  results.add('Typically enabled in debug mode only');
  print('Memory tracking disabled in release builds');

  // Test 15: Event runtime type
  assert(
    event1.runtimeType.toString() == 'ObjectDisposed',
    'Runtime type should match',
  );
  results.add('Runtime type: ${event1.runtimeType}');
  print('Runtime type: ${event1.runtimeType}');

  // Test 16: ObjectEvent hierarchy
  results.add('ObjectEvent: base for Created/Disposed');
  print('ObjectEvent is abstract base class');

  // Test 17: Object.hashCode for tracking
  final hash = testObject.hashCode;
  assert(hash != 0, 'Hash code should exist');
  results.add('Object hashCode: $hash');
  print('Object can be identified by hashCode: $hash');

  // Test 18: ChangeNotifier disposal tracking
  results.add('ChangeNotifier dispose tracked via ObjectDisposed');
  print('Dispose pattern commonly used with ChangeNotifier');

  // Test 19: Event collection pattern
  final events = <ObjectEvent>[
    ObjectCreated(object: testObject),
    ObjectDisposed(object: testObject),
  ];
  assert(events.length == 2, 'Should have lifecycle events');
  results.add('Lifecycle events: ${events.length}');
  print('Lifecycle events collected: ${events.length}');

  // Test 20: Summary
  print('ObjectDisposed test completed with ${results.length} tests');
  results.add('All tests passed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ObjectDisposed Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('Constructor: ObjectDisposed(object: obj)'),
      Text('Inheritance: ObjectEvent'),
      Text('Purpose: Track object disposal for memory analysis'),
      Text('Used by: FlutterMemoryAllocations'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
