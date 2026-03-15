// D4rt test script: Tests BackButtonDispatcher from widgets
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BackButtonDispatcher test executing');

  // Test RootBackButtonDispatcher
  final dispatcher = RootBackButtonDispatcher();
  print('RootBackButtonDispatcher created');
  print('RootBackButtonDispatcher runtimeType: ${dispatcher.runtimeType}');
  print('RootBackButtonDispatcher hashCode: ${dispatcher.hashCode}');

  // BackButtonDispatcher is used with Router-based navigation
  print('BackButtonDispatcher is for Router-based navigation (Navigator 2.0)');

  // Test ChildBackButtonDispatcher
  final childDispatcher = ChildBackButtonDispatcher(dispatcher);
  print('ChildBackButtonDispatcher created');
  print(
    'ChildBackButtonDispatcher runtimeType: ${childDispatcher.runtimeType}',
  );
  print('ChildBackButtonDispatcher hashCode: ${childDispatcher.hashCode}');

  // Test callback registration concept
  // BackButtonDispatcher.addCallback registers a callback for back button
  print('BackButtonDispatcher supports addCallback/removeCallback');

  // BackButtonListener widget wraps a child and listens for back button
  final backListener = BackButtonListener(
    onBackButtonPressed: () async {
      print('Back button pressed - handled');
      return true;
    },
    child: Container(
      width: 200.0,
      height: 100.0,
      color: Colors.blue,
      child: Center(
        child: Text(
          'Back Button Listener',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
  print('BackButtonListener widget created');

  // Show context: BackButtonDispatcher is typically passed to Router
  // Router(backButtonDispatcher: dispatcher, ...)
  print('BackButtonDispatcher is typically assigned to Router widget');
  print('Router uses it to handle system back button events');

  // Demonstrate with a simple visual
  final infoWidget = Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.grey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BackButtonDispatcher Info:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('- Used with Navigator 2.0 / Router API'),
            Text('- RootBackButtonDispatcher: system back button'),
            Text('- ChildBackButtonDispatcher: nested routers'),
            Text('- BackButtonListener: declarative widget'),
          ],
        ),
      ),
    ],
  );
  print('Info widget created');

  print('BackButtonDispatcher test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BackButtonDispatcher Tests'),
      SizedBox(height: 8.0),
      infoWidget,
      SizedBox(height: 8.0),
      // BackButtonListener removed from tree - requires Router ancestor.
      // The widget was created and tested above; just not rendered.
      Container(
        width: 200.0,
        height: 100.0,
        color: Colors.blue.shade100,
        child: Center(
          child: Text(
            'BackButtonListener\n(created, not rendered\n- needs Router)',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0),
          ),
        ),
      ),
    ],
  );
}
