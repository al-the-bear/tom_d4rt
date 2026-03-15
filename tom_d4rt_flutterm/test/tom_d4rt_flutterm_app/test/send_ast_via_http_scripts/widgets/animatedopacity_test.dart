// D4rt test script: Tests AnimatedOpacity from widgets
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimatedOpacity test executing');

  // Test AnimatedOpacity with opacity 0.0 (fully transparent)
  final opacity0 = AnimatedOpacity(
    opacity: 0.0,
    duration: Duration(milliseconds: 300),
    child: Container(
      color: Colors.blue,
      height: 60.0,
      child: Center(
        child: Text('Opacity 0.0', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('AnimatedOpacity(opacity=0.0) created - fully transparent');

  // Test AnimatedOpacity with opacity 0.5 (half transparent)
  final opacity50 = AnimatedOpacity(
    opacity: 0.5,
    duration: Duration(milliseconds: 300),
    child: Container(
      color: Colors.blue,
      height: 60.0,
      child: Center(
        child: Text('Opacity 0.5', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('AnimatedOpacity(opacity=0.5) created - half transparent');

  // Test AnimatedOpacity with opacity 1.0 (fully visible)
  final opacity100 = AnimatedOpacity(
    opacity: 1.0,
    duration: Duration(milliseconds: 300),
    child: Container(
      color: Colors.blue,
      height: 60.0,
      child: Center(
        child: Text('Opacity 1.0', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('AnimatedOpacity(opacity=1.0) created - fully visible');

  // Test AnimatedOpacity with longer duration
  final longDuration = AnimatedOpacity(
    opacity: 0.7,
    duration: Duration(milliseconds: 1000),
    child: Container(
      color: Colors.green,
      height: 60.0,
      child: Center(
        child: Text('1000ms duration', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('AnimatedOpacity with duration=1000ms created');

  // Test AnimatedOpacity with curve
  final withCurve = AnimatedOpacity(
    opacity: 0.8,
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOut,
    child: Container(
      color: Colors.orange,
      height: 60.0,
      child: Center(
        child: Text('easeInOut curve', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('AnimatedOpacity with curve=easeInOut created');

  // Test AnimatedOpacity with bounceIn curve
  final withBounceCurve = AnimatedOpacity(
    opacity: 0.6,
    duration: Duration(milliseconds: 600),
    curve: Curves.bounceIn,
    child: Container(
      color: Colors.purple,
      height: 60.0,
      child: Center(
        child: Text('bounceIn curve', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('AnimatedOpacity with curve=bounceIn created');

  // Test AnimatedOpacity with onEnd callback
  final withOnEnd = AnimatedOpacity(
    opacity: 0.9,
    duration: Duration(milliseconds: 400),
    onEnd: () {
      print('AnimatedOpacity animation ended');
    },
    child: Container(
      color: Colors.red,
      height: 60.0,
      child: Center(
        child: Text('With onEnd', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('AnimatedOpacity with onEnd callback created');

  // Test AnimatedOpacity with alwaysIncludeSemantics
  final withSemantics = AnimatedOpacity(
    opacity: 0.0,
    duration: Duration(milliseconds: 300),
    alwaysIncludeSemantics: true,
    child: Text('Semantics included'),
  );
  print('AnimatedOpacity with alwaysIncludeSemantics=true created');

  // Test AnimatedOpacity with decelerate curve
  final withDecelerate = AnimatedOpacity(
    opacity: 0.4,
    duration: Duration(milliseconds: 450),
    curve: Curves.decelerate,
    child: Container(
      color: Colors.teal,
      height: 60.0,
      child: Center(
        child: Text('decelerate', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('AnimatedOpacity with curve=decelerate created');

  print('AnimatedOpacity test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'AnimatedOpacity Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text(
          'Opacity 0.0 (transparent):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: opacity0,
        ),
        SizedBox(height: 8.0),
        Text('Opacity 0.5:', style: TextStyle(fontWeight: FontWeight.bold)),
        opacity50,
        SizedBox(height: 8.0),
        Text(
          'Opacity 1.0 (visible):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        opacity100,
        SizedBox(height: 8.0),
        Text(
          'Long duration (1000ms):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        longDuration,
        SizedBox(height: 8.0),
        Text(
          'With easeInOut curve:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        withCurve,
        SizedBox(height: 8.0),
        Text(
          'With bounceIn curve:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        withBounceCurve,
        SizedBox(height: 8.0),
        Text(
          'With onEnd callback:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        withOnEnd,
        SizedBox(height: 8.0),
        Text(
          'With decelerate curve:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        withDecelerate,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• AnimatedOpacity is an implicit animation'),
        Text('• opacity: 0.0 (transparent) to 1.0 (visible)'),
        Text('• duration controls animation length'),
        Text('• curve controls animation easing'),
        Text('• onEnd fires when animation completes'),
        Text('• No AnimationController needed'),
      ],
    ),
  );
}
