// D4rt test script: Tests Offstage from widgets
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Offstage test executing');

  // Test Offstage with offstage=true (hidden, no space)
  final offstageTrue = Offstage(
    offstage: true,
    child: Container(
      color: Colors.blue,
      height: 80.0,
      width: 200.0,
      child: Center(
        child: Text('Offstage true', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Offstage(offstage=true) created - widget hidden');

  // Test Offstage with offstage=false (visible)
  final offstageFalse = Offstage(
    offstage: false,
    child: Container(
      color: Colors.green,
      height: 80.0,
      width: 200.0,
      child: Center(
        child: Text('Offstage false', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Offstage(offstage=false) created - widget visible');

  // Test Offstage default (offstage defaults to true)
  final offstageDefault = Offstage(
    child: Container(
      color: Colors.red,
      height: 80.0,
      width: 200.0,
      child: Center(
        child: Text('Offstage default', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Offstage(default) created - defaults to offstage=true');

  // Test Offstage with SizedBox child
  final offstageSizedBox = Offstage(
    offstage: true,
    child: SizedBox(
      width: 150.0,
      height: 150.0,
      child: Container(
        color: Colors.orange,
        child: Center(
          child: Text('SizedBox child', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
  );
  print('Offstage with SizedBox child created');

  // Test Offstage with visible SizedBox child
  final visibleSizedBox = Offstage(
    offstage: false,
    child: SizedBox(
      width: 150.0,
      height: 80.0,
      child: Container(
        color: Colors.purple,
        child: Center(
          child: Text(
            'Visible SizedBox',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );
  print('Offstage(false) with SizedBox child - visible');

  // Test Offstage with Text child
  final offstageText = Offstage(
    offstage: true,
    child: Text('This text is offstage', style: TextStyle(fontSize: 18.0)),
  );
  print('Offstage with Text child created');

  // Test Offstage toggling concept
  final showWidget = false;
  final toggledOffstage = Offstage(
    offstage: showWidget == false,
    child: Container(
      color: Colors.teal,
      height: 80.0,
      child: Center(
        child: Text('Toggled offstage', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print(
    'Offstage toggle concept: showWidget=$showWidget, offstage=${showWidget == false}',
  );

  print('Offstage test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Offstage Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text(
          'Offstage=true (hidden):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          height: 30.0,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Stack(children: [Text('(widget is offstage)'), offstageTrue]),
        ),
        SizedBox(height: 8.0),
        Text(
          'Offstage=false (visible):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        offstageFalse,
        SizedBox(height: 8.0),
        Text(
          'Default offstage:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          height: 30.0,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Stack(
            children: [Text('(default is offstage)'), offstageDefault],
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Visible SizedBox child:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        visibleSizedBox,
        SizedBox(height: 8.0),
        Text(
          'Hidden SizedBox child:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          height: 30.0,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Stack(
            children: [Text('(SizedBox is offstage)'), offstageSizedBox],
          ),
        ),
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• offstage=true hides widget and removes from layout'),
        Text('• offstage=false renders widget normally'),
        Text('• Unlike Visibility, Offstage always removes space'),
        Text('• Widget state is maintained when offstage'),
        Text('• Default value of offstage is true'),
      ],
    ),
  );
}
