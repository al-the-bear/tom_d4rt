// D4rt test script: Tests Visibility from widgets
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Visibility test executing');

  // Test Visibility visible
  final visibleWidget = Visibility(
    visible: true,
    child: Container(
      color: Colors.blue,
      height: 60.0,
      child: Center(
        child: Text('Visible', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Visibility(visible=true) created');

  // Test Visibility invisible (default behavior - collapses)
  final invisibleWidget = Visibility(
    visible: false,
    child: Container(
      color: Colors.red,
      height: 60.0,
      child: Center(
        child: Text('Invisible', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Visibility(visible=false) created - collapses space');

  // Test Visibility invisible with maintainSize
  final maintainSizeWidget = Visibility(
    visible: false,
    maintainSize: true,
    maintainAnimation: true,
    maintainState: true,
    child: Container(
      color: Colors.green,
      height: 60.0,
      child: Center(
        child: Text('Maintain size', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Visibility with maintainSize=true created - space preserved');

  // Test Visibility with replacement
  final replacementWidget = Visibility(
    visible: false,
    replacement: Container(
      color: Colors.grey,
      height: 60.0,
      child: Center(
        child: Text(
          'Replacement widget',
          style: TextStyle(color: Colors.black),
        ),
      ),
    ),
    child: Container(
      color: Colors.orange,
      height: 60.0,
      child: Center(
        child: Text('Original widget', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Visibility with replacement created');

  // Test Visibility with maintainAnimation only
  final maintainAnimWidget = Visibility(
    visible: false,
    maintainAnimation: true,
    maintainState: true,
    child: Container(
      color: Colors.purple,
      height: 60.0,
      child: Center(
        child: Text(
          'Maintain animation',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
  print('Visibility with maintainAnimation=true, maintainState=true created');

  // Test Visibility with maintainState only
  final maintainStateWidget = Visibility(
    visible: false,
    maintainState: true,
    child: Container(
      color: Colors.teal,
      height: 60.0,
      child: Center(
        child: Text('Maintain state', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Visibility with maintainState=true created');

  // Test Visibility with maintainInteractivity
  final maintainInteractWidget = Visibility(
    visible: false,
    maintainSize: true,
    maintainAnimation: true,
    maintainState: true,
    maintainInteractivity: true,
    child: Container(
      color: Colors.indigo,
      height: 60.0,
      child: Center(
        child: Text(
          'Maintain interactivity',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
  print('Visibility with maintainInteractivity=true created');

  // Test Visibility with maintainSemantics
  final maintainSemanticsWidget = Visibility(
    visible: false,
    maintainSize: true,
    maintainAnimation: true,
    maintainState: true,
    maintainSemantics: true,
    child: Container(
      color: Colors.brown,
      height: 60.0,
      child: Center(
        child: Text(
          'Maintain semantics',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
  print('Visibility with maintainSemantics=true created');

  print('Visibility test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Visibility Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text('Visible:', style: TextStyle(fontWeight: FontWeight.bold)),
        visibleWidget,
        SizedBox(height: 8.0),
        Text(
          'Invisible (collapses):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: invisibleWidget,
        ),
        SizedBox(height: 8.0),
        Text(
          'Invisible (maintainSize):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: maintainSizeWidget,
        ),
        SizedBox(height: 8.0),
        Text(
          'Invisible with replacement:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        replacementWidget,
        SizedBox(height: 8.0),
        Text(
          'MaintainAnimation:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: maintainAnimWidget,
        ),
        SizedBox(height: 8.0),
        Text('MaintainState:', style: TextStyle(fontWeight: FontWeight.bold)),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: maintainStateWidget,
        ),
        SizedBox(height: 8.0),
        Text(
          'MaintainInteractivity:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: maintainInteractWidget,
        ),
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• visible=false collapses by default'),
        Text('• maintainSize keeps space occupied'),
        Text('• maintainState preserves widget state'),
        Text('• maintainAnimation keeps animations running'),
        Text('• replacement shows alternative widget'),
      ],
    ),
  );
}
