// D4rt test script: Tests FadeTransition from widgets
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FadeTransition test executing');

  // Test FadeTransition with AlwaysStoppedAnimation at 0.5
  final fadeHalf = FadeTransition(
    opacity: AlwaysStoppedAnimation(0.5),
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.blue,
      child: Center(
        child: Text('Fade 0.5', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('FadeTransition with opacity=0.5 created');

  // Test FadeTransition with opacity 0.0 (transparent)
  final fadeZero = FadeTransition(
    opacity: AlwaysStoppedAnimation(0.0),
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.red,
      child: Center(
        child: Text('Fade 0.0', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('FadeTransition with opacity=0.0 created');

  // Test FadeTransition with opacity 1.0 (fully visible)
  final fadeFull = FadeTransition(
    opacity: AlwaysStoppedAnimation(1.0),
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.green,
      child: Center(
        child: Text('Fade 1.0', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('FadeTransition with opacity=1.0 created');

  // Test FadeTransition with opacity 0.25
  final fadeQuarter = FadeTransition(
    opacity: AlwaysStoppedAnimation(0.25),
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.orange,
      child: Center(
        child: Text('Fade 0.25', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('FadeTransition with opacity=0.25 created');

  // Test FadeTransition with opacity 0.75
  final fadeThreeQuarter = FadeTransition(
    opacity: AlwaysStoppedAnimation(0.75),
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.purple,
      child: Center(
        child: Text('Fade 0.75', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('FadeTransition with opacity=0.75 created');

  // Test FadeTransition with alwaysIncludeSemantics
  final fadeSemantics = FadeTransition(
    opacity: AlwaysStoppedAnimation(0.0),
    alwaysIncludeSemantics: true,
    child: Container(
      width: 200.0,
      height: 60.0,
      color: Colors.teal,
      child: Center(
        child: Text('With semantics', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('FadeTransition with alwaysIncludeSemantics=true created');

  // Test FadeTransition with Text child
  final fadeText = FadeTransition(
    opacity: AlwaysStoppedAnimation(0.6),
    child: Text(
      'Faded text at 0.6',
      style: TextStyle(fontSize: 18.0, color: Colors.indigo),
    ),
  );
  print('FadeTransition with Text child created');

  // Test FadeTransition with Icon child
  final fadeIcon = FadeTransition(
    opacity: AlwaysStoppedAnimation(0.4),
    child: Icon(Icons.favorite, size: 48.0, color: Colors.red),
  );
  print('FadeTransition with Icon child created');

  // Test FadeTransition with Card child
  final fadeCard = FadeTransition(
    opacity: AlwaysStoppedAnimation(0.8),
    child: Card(
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Faded Card at 0.8'),
      ),
    ),
  );
  print('FadeTransition with Card child created');

  // Test nested FadeTransition
  final nestedFade = FadeTransition(
    opacity: AlwaysStoppedAnimation(0.7),
    child: FadeTransition(
      opacity: AlwaysStoppedAnimation(0.7),
      child: Container(
        width: 200.0,
        height: 60.0,
        color: Colors.brown,
        child: Center(
          child: Text('Nested fade', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
  );
  print('Nested FadeTransition created (0.7 * 0.7 = ~0.49)');

  print('FadeTransition test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'FadeTransition Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text('Opacity 0.0:', style: TextStyle(fontWeight: FontWeight.bold)),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: fadeZero,
        ),
        SizedBox(height: 8.0),
        Text('Opacity 0.25:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: fadeQuarter),
        SizedBox(height: 8.0),
        Text('Opacity 0.5:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: fadeHalf),
        SizedBox(height: 8.0),
        Text('Opacity 0.75:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: fadeThreeQuarter),
        SizedBox(height: 8.0),
        Text('Opacity 1.0:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: fadeFull),
        SizedBox(height: 8.0),
        Text('Faded Text:', style: TextStyle(fontWeight: FontWeight.bold)),
        fadeText,
        SizedBox(height: 8.0),
        Text('Faded Icon:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: fadeIcon),
        SizedBox(height: 8.0),
        Text('Faded Card:', style: TextStyle(fontWeight: FontWeight.bold)),
        fadeCard,
        SizedBox(height: 8.0),
        Text('Nested Fade:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: nestedFade),
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• FadeTransition uses Animation<double> for opacity'),
        Text('• AlwaysStoppedAnimation for static values'),
        Text('• opacity range: 0.0 (hidden) to 1.0 (visible)'),
        Text('• alwaysIncludeSemantics for accessibility'),
        Text('• Nested fades multiply opacity values'),
      ],
    ),
  );
}
