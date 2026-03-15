// D4rt test script: Tests SafeArea from widgets
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SafeArea test executing');

  // Test SafeArea with all edges (default)
  final safeAreaAll = SafeArea(
    child: Container(
      color: Colors.blue,
      height: 100.0,
      child: Center(
        child: Text(
          'SafeArea all edges',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
  print('SafeArea with all edges created');

  // Test SafeArea with top disabled
  final safeAreaNoTop = SafeArea(
    top: false,
    child: Container(
      color: Colors.green,
      height: 100.0,
      child: Center(
        child: Text('SafeArea no top', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('SafeArea with top=false created');

  // Test SafeArea with bottom disabled
  final safeAreaNoBottom = SafeArea(
    bottom: false,
    child: Container(
      color: Colors.orange,
      height: 100.0,
      child: Center(
        child: Text(
          'SafeArea no bottom',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
  print('SafeArea with bottom=false created');

  // Test SafeArea with left and right disabled
  final safeAreaNoSides = SafeArea(
    left: false,
    right: false,
    child: Container(
      color: Colors.purple,
      height: 100.0,
      child: Center(
        child: Text('SafeArea no sides', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('SafeArea with left=false, right=false created');

  // Test SafeArea with all edges disabled
  final safeAreaNone = SafeArea(
    top: false,
    bottom: false,
    left: false,
    right: false,
    child: Container(
      color: Colors.red,
      height: 100.0,
      child: Center(
        child: Text('SafeArea no edges', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('SafeArea with all edges disabled created');

  // Test SafeArea with minimum padding
  final safeAreaMinPadding = SafeArea(
    minimum: EdgeInsets.all(16.0),
    child: Container(
      color: Colors.teal,
      height: 100.0,
      child: Center(
        child: Text(
          'SafeArea min padding 16',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
  print('SafeArea with minimum padding=16 created');

  // Test SafeArea with asymmetric minimum padding
  final safeAreaAsymmetric = SafeArea(
    minimum: EdgeInsets.only(left: 20.0, right: 20.0, top: 8.0, bottom: 8.0),
    child: Container(
      color: Colors.indigo,
      height: 100.0,
      child: Center(
        child: Text(
          'SafeArea asymmetric min',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
  print('SafeArea with asymmetric minimum padding created');

  // Test SafeArea with maintainBottomViewPadding
  final safeAreaMaintainBottom = SafeArea(
    maintainBottomViewPadding: true,
    child: Container(
      color: Colors.brown,
      height: 100.0,
      child: Center(
        child: Text(
          'SafeArea maintainBottom',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
  print('SafeArea with maintainBottomViewPadding=true created');

  print('SafeArea test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'SafeArea Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text(
          'All edges (default):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        safeAreaAll,
        SizedBox(height: 8.0),
        Text('No top:', style: TextStyle(fontWeight: FontWeight.bold)),
        safeAreaNoTop,
        SizedBox(height: 8.0),
        Text('No bottom:', style: TextStyle(fontWeight: FontWeight.bold)),
        safeAreaNoBottom,
        SizedBox(height: 8.0),
        Text('No sides:', style: TextStyle(fontWeight: FontWeight.bold)),
        safeAreaNoSides,
        SizedBox(height: 8.0),
        Text(
          'All edges disabled:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        safeAreaNone,
        SizedBox(height: 8.0),
        Text(
          'Minimum padding 16:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        safeAreaMinPadding,
        SizedBox(height: 8.0),
        Text(
          'Asymmetric min padding:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        safeAreaAsymmetric,
        SizedBox(height: 8.0),
        Text(
          'Maintain bottom view padding:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        safeAreaMaintainBottom,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• SafeArea respects system UI intrusions'),
        Text('• top/bottom/left/right control which edges'),
        Text('• minimum sets a floor for padding'),
        Text('• maintainBottomViewPadding for keyboard'),
      ],
    ),
  );
}
