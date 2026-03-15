// D4rt test script: Tests ChangeNotifier and ValueNotifier from foundation
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ChangeNotifier test executing');

  // Test basic ChangeNotifier
  final changeNotifier = ChangeNotifier();
  print('Basic ChangeNotifier created');

  // Test adding listeners
  var listenerCallCount = 0;
  void listener() {
    listenerCallCount++;
    print('Listener called, count: $listenerCallCount');
  }

  changeNotifier.addListener(listener);
  print('Listener added to ChangeNotifier');

  // Note: notifyListeners is protected, so we can't call it directly on base class

  // Test ValueNotifier
  final intNotifier = ValueNotifier<int>(0);
  print('ValueNotifier<int> created with initial value: ${intNotifier.value}');

  // Test ValueNotifier value change
  intNotifier.value = 42;
  print('ValueNotifier value changed to: ${intNotifier.value}');

  // Test ValueNotifier listener
  var valueListenerCount = 0;
  intNotifier.addListener(() {
    valueListenerCount++;
    print(
      'ValueNotifier changed to ${intNotifier.value}, listener count: $valueListenerCount',
    );
  });
  print('Listener added to ValueNotifier');

  intNotifier.value = 100;
  print('ValueNotifier value changed again to: ${intNotifier.value}');

  // Test ValueNotifier with different types
  final stringNotifier = ValueNotifier<String>('Hello');
  print('ValueNotifier<String> created: ${stringNotifier.value}');
  stringNotifier.value = 'World';
  print('ValueNotifier<String> changed to: ${stringNotifier.value}');

  final boolNotifier = ValueNotifier<bool>(false);
  print('ValueNotifier<bool> created: ${boolNotifier.value}');
  boolNotifier.value = true;
  print('ValueNotifier<bool> changed to: ${boolNotifier.value}');

  final listNotifier = ValueNotifier<List<int>>([1, 2, 3]);
  print('ValueNotifier<List<int>> created: ${listNotifier.value}');
  listNotifier.value = [4, 5, 6];
  print('ValueNotifier<List<int>> changed to: ${listNotifier.value}');

  // Test ValueListenableBuilder
  final counter = ValueNotifier<int>(0);
  final valueListenableBuilder = ValueListenableBuilder<int>(
    valueListenable: counter,
    builder: (context, value, child) {
      print('ValueListenableBuilder rebuilding with value: $value');
      return Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.blue.shade100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Count: $value', style: TextStyle(fontSize: 20.0)),
            if (child != null) child,
          ],
        ),
      );
    },
    child: Icon(Icons.star), // child doesn't rebuild
  );
  print('ValueListenableBuilder created');

  // Test AnimatedBuilder (similar pattern)
  print('AnimatedBuilder uses similar Listenable pattern');

  // Test ListenableBuilder
  final listenableBuilder = ListenableBuilder(
    listenable: counter,
    builder: (context, child) {
      return Container(
        padding: EdgeInsets.all(12.0),
        color: Colors.green.shade100,
        child: Text('ListenableBuilder: ${counter.value}'),
      );
    },
  );
  print('ListenableBuilder created');

  // Test removing listeners
  void removableListener() {
    print('Removable listener called');
  }

  counter.addListener(removableListener);
  print('Removable listener added');
  counter.removeListener(removableListener);
  print('Removable listener removed');

  // Test hasListeners
  print('ValueNotifier hasListeners: ${counter.hasListeners}');

  // Test dispose
  final disposableNotifier = ValueNotifier<int>(0);
  disposableNotifier.addListener(() {});
  print('Disposable notifier created with listener');
  // disposableNotifier.dispose(); // Would remove all listeners
  print('dispose() removes all listeners and marks as disposed');

  // Test Listenable.merge
  final notifier1 = ValueNotifier<int>(1);
  final notifier2 = ValueNotifier<String>('a');
  final merged = Listenable.merge([notifier1, notifier2]);
  merged.addListener(() {
    print('Merged listenable notified');
  });
  print('Listenable.merge created from 2 notifiers');

  // Test custom ChangeNotifier (concept)
  print('Custom ChangeNotifier example:');
  print('class Counter extends ChangeNotifier {');
  print('  int _count = 0;');
  print('  int get count => _count;');
  print('  void increment() { _count++; notifyListeners(); }');
  print('}');

  // Test ChangeNotifier properties
  print('ChangeNotifier.hasListeners - checks if any listeners');
  print('ChangeNotifier.notifyListeners() - notifies all listeners');
  print('ChangeNotifier.addListener(callback) - adds listener');
  print('ChangeNotifier.removeListener(callback) - removes listener');
  print('ChangeNotifier.dispose() - cleans up');

  // Test ProxyAnimation concept
  print('ProxyAnimation extends Animation and uses Listenable');

  // Demonstrate counter increment
  counter.value = 1;
  counter.value = 2;
  counter.value = 3;
  print('Counter incremented 3 times');

  print('ChangeNotifier test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'ChangeNotifier Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text(
          'ValueListenableBuilder:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        valueListenableBuilder,
        SizedBox(height: 8.0),

        Text(
          'ListenableBuilder:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        listenableBuilder,
        SizedBox(height: 16.0),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Increment'),
              onPressed: () {
                counter.value++;
                print('Counter incremented to: ${counter.value}');
              },
            ),
            SizedBox(width: 8.0),
            ElevatedButton(
              child: Text('Reset'),
              onPressed: () {
                counter.value = 0;
                print('Counter reset to: ${counter.value}');
              },
            ),
          ],
        ),
        SizedBox(height: 24.0),

        Text('Key Concepts:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• ChangeNotifier - base class for observable objects'),
        Text('• ValueNotifier<T> - single value with notifications'),
        Text('• ValueListenableBuilder - rebuilds on value change'),
        Text('• ListenableBuilder - general listenable builder'),
        Text('• Listenable.merge - combine multiple listenables'),
        SizedBox(height: 16.0),

        Text('Current Values:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('int: ${intNotifier.value}'),
        Text('string: ${stringNotifier.value}'),
        Text('bool: ${boolNotifier.value}'),
        Text('list: ${listNotifier.value}'),
      ],
    ),
  );
}
