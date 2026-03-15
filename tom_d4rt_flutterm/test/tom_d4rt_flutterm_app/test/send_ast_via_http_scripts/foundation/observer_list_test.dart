// D4rt test script: Tests ObserverList, HashedObserverList from foundation
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ObserverList test executing');

  // ========== OBSERVERLIST ==========
  print('--- ObserverList Tests ---');

  // ObserverList allows duplicates (unlike Set) but iterates safely
  final observers = ObserverList<VoidCallback>();
  print('ObserverList created, isEmpty: ${observers.isEmpty}');

  int callCount = 0;
  void callback1() {
    callCount += 1;
  }

  void callback2() {
    callCount += 10;
  }

  void callback3() {
    callCount += 100;
  }

  // Add observers
  observers.add(callback1);
  observers.add(callback2);
  observers.add(callback3);
  print('Added 3 observers');
  print('ObserverList isEmpty: ${observers.isEmpty}');

  // Iterate and call all observers
  for (final observer in observers) {
    observer();
  }
  print('After calling all observers, callCount: $callCount');

  // Add duplicate
  observers.add(callback1);
  print('Added duplicate callback1');

  // Remove one instance of callback1
  final removed = observers.remove(callback1);
  print('Remove callback1: $removed');

  // Contains check
  print('Contains callback1: ${observers.contains(callback1)}');
  print('Contains callback2: ${observers.contains(callback2)}');

  // ========== HASHEDOBSERVERLIST ==========
  print('--- HashedObserverList Tests ---');

  // HashedObserverList prevents duplicates (uses a Set internally)
  final hashedObservers = HashedObserverList<VoidCallback>();
  print('HashedObserverList created, isEmpty: ${hashedObservers.isEmpty}');

  int hashedCount = 0;
  void hCallback1() {
    hashedCount += 1;
  }

  void hCallback2() {
    hashedCount += 10;
  }

  hashedObservers.add(hCallback1);
  hashedObservers.add(hCallback2);
  print('Added 2 hashed observers');
  print('HashedObserverList isEmpty: ${hashedObservers.isEmpty}');

  // Try adding duplicate
  hashedObservers.add(hCallback1);
  print('Added duplicate hCallback1 (should be ignored)');

  // Iterate and call
  for (final observer in hashedObservers) {
    observer();
  }
  print('After calling hashed observers, hashedCount: $hashedCount');

  // Contains check
  print('Hashed contains hCallback1: ${hashedObservers.contains(hCallback1)}');

  // Remove
  final hashedRemoved = hashedObservers.remove(hCallback1);
  print('Hashed remove hCallback1: $hashedRemoved');
  print(
    'Hashed contains hCallback1 after remove: ${hashedObservers.contains(hCallback1)}',
  );

  print('All ObserverList tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ObserverList Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text('ObserverList callCount: $callCount'),
            SizedBox(height: 4.0),
            Text('HashedObserverList hashedCount: $hashedCount'),
          ],
        ),
      ),
    ),
  );
}
