// D4rt test script: Tests Key, GlobalKey, ValueKey, UniqueKey, ObjectKey from widgets
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Key test executing');

  // Test ValueKey with different types
  final stringKey = ValueKey<String>('my-key');
  print('ValueKey<String> created: $stringKey');

  final intKey = ValueKey<int>(42);
  print('ValueKey<int> created: $intKey');

  final doubleKey = ValueKey<double>(3.14);
  print('ValueKey<double> created: $doubleKey');

  final boolKey = ValueKey<bool>(true);
  print('ValueKey<bool> created: $boolKey');

  // Test ValueKey equality
  final sameKey = ValueKey<String>('my-key');
  print('ValueKey equality: ${stringKey == sameKey}'); // true

  final differentKey = ValueKey<String>('other-key');
  print('Different ValueKey equality: ${stringKey == differentKey}'); // false

  // Test UniqueKey
  final unique1 = UniqueKey();
  final unique2 = UniqueKey();
  print('UniqueKey 1: $unique1');
  print('UniqueKey 2: $unique2');
  print('UniqueKey equality: ${unique1 == unique2}'); // false

  // Test ObjectKey
  final obj = {'id': 1, 'name': 'Test'};
  final objectKey = ObjectKey(obj);
  print('ObjectKey created: $objectKey');

  final sameObj = obj;
  final sameObjectKey = ObjectKey(sameObj);
  print(
    'Same object ObjectKey equality: ${objectKey == sameObjectKey}',
  ); // true

  final differentObj = {'id': 1, 'name': 'Test'}; // different instance
  final differentObjectKey = ObjectKey(differentObj);
  print(
    'Different object ObjectKey equality: ${objectKey == differentObjectKey}',
  ); // false

  // Test GlobalKey
  final globalKey = GlobalKey();
  print('Basic GlobalKey created: $globalKey');

  // Test GlobalKey<State>
  final stateKey = GlobalKey<State>();
  print('GlobalKey<State> created');

  // Test GlobalKey with debugLabel
  final labeledKey = GlobalKey(debugLabel: 'MyGlobalKey');
  print('GlobalKey with debugLabel created');

  // Test GlobalKey properties and methods
  print('GlobalKey.currentContext - gets BuildContext');
  print('GlobalKey.currentWidget - gets Widget');
  print('GlobalKey.currentState - gets State');

  // Test GlobalKey<FormState> for forms
  final formKey = GlobalKey<FormState>();
  print('GlobalKey<FormState> created for form validation');

  // Test GlobalKey<ScaffoldState> for scaffold
  final scaffoldKey = GlobalKey<ScaffoldState>();
  print('GlobalKey<ScaffoldState> created for scaffold access');

  // Test GlobalKey<NavigatorState> for navigation
  final navigatorKey = GlobalKey<NavigatorState>();
  print('GlobalKey<NavigatorState> created for navigation');

  // Test GlobalObjectKey
  final globalObjKey = GlobalObjectKey(obj);
  print('GlobalObjectKey created: $globalObjKey');

  // Test widgets with keys
  final keyedContainer = Container(
    key: ValueKey('container-key'),
    color: Colors.blue,
    height: 50.0,
    child: Center(child: Text('Keyed Container')),
  );
  print('Container with ValueKey created');

  final keyedText = Text('Keyed Text', key: ValueKey('text-key'));
  print('Text with ValueKey created');

  // Test key usage in lists
  final listItems = List.generate(5, (index) {
    return Container(
      key: ValueKey('item-$index'),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(vertical: 2.0),
      color: Colors.primaries[index % Colors.primaries.length].shade200,
      child: Text('Item $index with key'),
    );
  });
  print('List of 5 keyed items created');

  // Test GlobalKey for finding widget after build
  final findableKey = GlobalKey();
  final findableWidget = Container(
    key: findableKey,
    height: 60.0,
    color: Colors.orange.shade200,
    child: Center(child: Text('Findable Widget')),
  );
  print('Widget with GlobalKey created for finding');

  // Show accessing via GlobalKey
  // After build: findableKey.currentContext, findableKey.currentWidget

  // Test keys in ReorderableListView scenario
  print('Keys are essential for ReorderableListView items');

  // Test keys in AnimatedList scenario
  print('Keys help AnimatedList track items during animations');

  // Test Key base class
  print('Key is abstract base for all keys');

  // Test LocalKey subclasses
  print('LocalKey subclasses: ValueKey, ObjectKey, UniqueKey');

  // Test PageStorageKey for scroll position persistence
  final pageStorageKey = PageStorageKey<String>('scroll-position');
  print('PageStorageKey created: $pageStorageKey');

  // Test usage in ListView for scroll persistence
  final scrollPersistence = ListView(
    key: PageStorageKey('my-list'),
    children: [
      Container(height: 100, color: Colors.red.shade100),
      Container(height: 100, color: Colors.green.shade100),
      Container(height: 100, color: Colors.blue.shade100),
    ],
  );
  print('ListView with PageStorageKey for scroll persistence created');

  // Test form with GlobalKey
  final formWithKey = Form(
    key: formKey,
    child: Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Email'),
          validator: (value) => value!.isEmpty ? 'Required' : null,
        ),
        SizedBox(height: 8.0),
        ElevatedButton(
          child: Text('Validate'),
          onPressed: () {
            if (formKey.currentState?.validate() ?? false) {
              print('Form is valid');
            } else {
              print('Form is invalid');
            }
          },
        ),
      ],
    ),
  );
  print('Form with GlobalKey<FormState> created');

  print('Key test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Key Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text(
          'ValueKey Examples:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        keyedContainer,
        SizedBox(height: 8.0),

        Text(
          'GlobalKey Example:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        findableWidget,
        SizedBox(height: 16.0),

        Text(
          'Keyed List Items:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        ...listItems,
        SizedBox(height: 16.0),

        Text(
          'Form with GlobalKey:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        formWithKey,
        SizedBox(height: 16.0),

        Text('Key Types:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• ValueKey<T> - equality by value'),
        Text('• UniqueKey - always unique'),
        Text('• ObjectKey - equality by identity'),
        Text('• GlobalKey - access widget/state'),
        Text('• GlobalObjectKey - global + identity'),
        Text('• PageStorageKey - scroll persistence'),
      ],
    ),
  );
}
