// D4rt test script: Tests ChangeNotifier, ValueNotifier, Listenable, ValueListenable from foundation
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Foundation notifier test executing');

  // ========== LISTENABLE ==========
  print('--- Listenable Tests ---');

  // Listenable is an abstract interface
  // Test via ChangeNotifier which implements it
  print('Listenable is an interface - tested via ChangeNotifier');

  // ========== VALUELISTENABLE ==========
  print('--- ValueListenable Tests ---');

  // ValueListenable is an abstract interface
  // Test via ValueNotifier which implements it
  print('ValueListenable is an interface - tested via ValueNotifier');

  // ========== CHANGENOTIFIER ==========
  print('--- ChangeNotifier Tests ---');

  // Create a custom ChangeNotifier
  final counter = CounterNotifier();
  print('CounterNotifier created with value: ${counter.value}');

  // Test addListener
  var listenerCallCount = 0;
  void listener() {
    listenerCallCount++;
    print('Listener called, count: $listenerCallCount');
  }

  counter.addListener(listener);
  print('Listener added');

  // Test notifyListeners via increment
  counter.increment();
  print(
    'After increment, value: ${counter.value}, listener called: $listenerCallCount times',
  );

  counter.increment();
  print(
    'After second increment, value: ${counter.value}, listener called: $listenerCallCount times',
  );

  // Test multiple listeners
  var secondListenerCalled = 0;
  void secondListener() {
    secondListenerCalled++;
    print('Second listener called');
  }

  counter.addListener(secondListener);
  print('Second listener added');

  counter.increment();
  print(
    'After increment with two listeners, listenerCalls: $listenerCallCount, secondListenerCalls: $secondListenerCalled',
  );

  // Test removeListener
  counter.removeListener(listener);
  print('First listener removed');

  counter.increment();
  print('After increment (first listener removed), value: ${counter.value}');
  print('First listener call count unchanged: $listenerCallCount');
  print('Second listener call count: $secondListenerCalled');

  // Test hasListeners
  print('Has listeners: ${counter.hasListeners}');

  // Remove second listener
  counter.removeListener(secondListener);
  print('Second listener removed');
  print('Has listeners after removal: ${counter.hasListeners}');

  // Test dispose
  final disposableCounter = CounterNotifier();
  disposableCounter.addListener(() {});
  print(
    'Counter before dispose hasListeners: ${disposableCounter.hasListeners}',
  );
  disposableCounter.dispose();
  print('Counter disposed');
  // Note: After dispose, hasListeners would throw if checked

  // ========== VALUENOTIFIER ==========
  print('--- ValueNotifier Tests ---');

  // Test basic ValueNotifier<int>
  final intNotifier = ValueNotifier<int>(0);
  print('ValueNotifier<int>(0) created, value: ${intNotifier.value}');

  // Test value setter
  intNotifier.value = 10;
  print('After setting value to 10, value: ${intNotifier.value}');

  // Test listener notification on value change
  var intNotifierListenerCalls = 0;
  intNotifier.addListener(() {
    intNotifierListenerCalls++;
    print('IntNotifier listener called, new value: ${intNotifier.value}');
  });

  intNotifier.value = 20;
  print('Listener calls after setting value: $intNotifierListenerCalls');

  // Test no notification when value unchanged
  intNotifier.value = 20; // Same value
  print(
    'Listener calls after setting same value: $intNotifierListenerCalls',
  ); // Should be same

  // Test ValueNotifier<String>
  final stringNotifier = ValueNotifier<String>('Hello');
  print(
    'ValueNotifier<String>("Hello") created, value: ${stringNotifier.value}',
  );

  stringNotifier.value = 'World';
  print('After update, value: ${stringNotifier.value}');

  // Test ValueNotifier<bool>
  final boolNotifier = ValueNotifier<bool>(false);
  print('ValueNotifier<bool>(false) created, value: ${boolNotifier.value}');

  boolNotifier.value = true;
  print('After toggle, value: ${boolNotifier.value}');

  // Test ValueNotifier<double>
  final doubleNotifier = ValueNotifier<double>(0.0);
  print('ValueNotifier<double>(0.0) created, value: ${doubleNotifier.value}');

  doubleNotifier.value = 3.14159;
  print('After update, value: ${doubleNotifier.value}');

  // Test ValueNotifier<List>
  final listNotifier = ValueNotifier<List<int>>([1, 2, 3]);
  print('ValueNotifier<List<int>> created, value: ${listNotifier.value}');

  // Note: Updating list contents won't trigger notification
  // Must assign new list
  listNotifier.value = [1, 2, 3, 4, 5];
  print('After assigning new list, value: ${listNotifier.value}');

  // Test ValueNotifier<Map>
  final mapNotifier = ValueNotifier<Map<String, int>>({'a': 1, 'b': 2});
  print('ValueNotifier<Map> created, value: ${mapNotifier.value}');

  mapNotifier.value = {'a': 1, 'b': 2, 'c': 3};
  print('After assigning new map, value: ${mapNotifier.value}');

  // Test ValueNotifier<dynamic>
  final dynamicNotifier = ValueNotifier<dynamic>('start');
  print('ValueNotifier<dynamic> created, value: ${dynamicNotifier.value}');

  dynamicNotifier.value = 42;
  print('After changing to int, value: ${dynamicNotifier.value}');

  dynamicNotifier.value = {'key': 'value'};
  print('After changing to map, value: ${dynamicNotifier.value}');

  // Test ValueNotifier toString
  print('ValueNotifier toString: ${intNotifier.toString()}');

  // Test ValueNotifier dispose
  final disposableNotifier = ValueNotifier<int>(100);
  disposableNotifier.addListener(() {});
  print(
    'Notifier before dispose hasListeners: ${disposableNotifier.hasListeners}',
  );
  disposableNotifier.dispose();
  print('Notifier disposed');

  // Test nullable ValueNotifier
  final nullableNotifier = ValueNotifier<String?>(null);
  print(
    'ValueNotifier<String?>(null) created, value: ${nullableNotifier.value}',
  );

  nullableNotifier.value = 'Not null';
  print('After setting value, value: ${nullableNotifier.value}');

  nullableNotifier.value = null;
  print('After setting back to null, value: ${nullableNotifier.value}');

  print('Foundation notifier test completed');

  // Return a visual representation using ValueListenableBuilder
  final demoCounter = ValueNotifier<int>(0);

  return Directionality(
    textDirection: TextDirection.ltr,
    child: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Foundation Notifiers',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            // ChangeNotifier info
            Text(
              'ChangeNotifier:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('• Abstract class for observable objects'),
            Text('• Call notifyListeners() to notify observers'),
            Text('• Use addListener/removeListener'),
            Text('• Call dispose() when done'),
            SizedBox(height: 16.0),

            // ValueNotifier info
            Text(
              'ValueNotifier<T>:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('• ChangeNotifier that holds a single value'),
            Text('• Notifies on value change'),
            Text('• Does not notify if same value assigned'),
            SizedBox(height: 16.0),

            // ValueListenableBuilder example
            Text(
              'ValueListenableBuilder Demo:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            ValueListenableBuilder<int>(
              valueListenable: demoCounter,
              builder: (context, value, child) {
                return Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => demoCounter.value--,
                        child: Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFE53935),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                            child: Text(
                              '-',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 24.0),
                      Text(
                        '$value',
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 24.0),
                      GestureDetector(
                        onTap: () => demoCounter.value++,
                        child: Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Color(0xFF43A047),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                            child: Text(
                              '+',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 16.0),

            // Listenable info
            Text(
              'Listenable Interface:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('• Base interface for observable objects'),
            Text('• Defines addListener/removeListener'),
            Text('• Implemented by ChangeNotifier, Animation'),
            SizedBox(height: 16.0),

            // ValueListenable info
            Text(
              'ValueListenable<T> Interface:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('• Listenable that exposes a value'),
            Text('• Defines value getter'),
            Text('• Implemented by ValueNotifier'),
          ],
        ),
      ),
    ),
  );
}

// Custom ChangeNotifier for testing
class CounterNotifier extends ChangeNotifier {
  int _value = 0;

  int get value => _value;

  void increment() {
    _value++;
    notifyListeners();
  }

  void decrement() {
    _value--;
    notifyListeners();
  }

  void reset() {
    _value = 0;
    notifyListeners();
  }
}
