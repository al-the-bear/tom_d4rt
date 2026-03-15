// D4rt test script: Tests AppBar widget from widgets
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AppBar test executing');

  // Test basic AppBar with title
  final basicAppBar = AppBar(title: Text('Basic AppBar'));
  print('Basic AppBar with title created');

  // Test AppBar with leading widget
  final withLeading = AppBar(
    leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
    title: Text('With Leading'),
  );
  print('AppBar with leading IconButton created');

  // Test AppBar with actions
  final withActions = AppBar(
    title: Text('With Actions'),
    actions: [
      IconButton(icon: Icon(Icons.search), onPressed: () {}),
      IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
    ],
  );
  print('AppBar with actions created');

  // Test AppBar with custom colors
  final customColors = AppBar(
    title: Text('Custom Colors'),
    backgroundColor: Colors.purple,
    foregroundColor: Colors.white,
  );
  print('AppBar with custom colors created');

  // Test AppBar with elevation
  final withElevation = AppBar(
    title: Text('Elevated'),
    elevation: 8.0,
    shadowColor: Colors.black,
  );
  print('AppBar with elevation=8.0 created');

  // Test AppBar with centerTitle
  final centerTitle = AppBar(title: Text('Centered'), centerTitle: true);
  print('AppBar with centerTitle=true created');

  // Test AppBar with automaticallyImplyLeading
  final noImply = AppBar(
    title: Text('No Implied Leading'),
    automaticallyImplyLeading: false,
  );
  print('AppBar with automaticallyImplyLeading=false created');

  // Test AppBar with bottom
  final withBottom = AppBar(
    title: Text('With Bottom'),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(48.0),
      child: Container(
        height: 48.0,
        color: Colors.blue.shade700,
        child: Center(
          child: Text('Bottom Widget', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
  );
  print('AppBar with bottom widget created');

  // Test AppBar with flexibleSpace
  final withFlexibleSpace = AppBar(
    title: Text('Flexible Space'),
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    ),
  );
  print('AppBar with flexibleSpace gradient created');

  // Test AppBar with toolbarHeight
  final customHeight = AppBar(title: Text('Tall AppBar'), toolbarHeight: 80.0);
  print('AppBar with toolbarHeight=80.0 created');

  // Test AppBar with shape
  final withShape = AppBar(
    title: Text('Shaped'),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
    ),
  );
  print('AppBar with rounded bottom shape created');

  print('AppBar test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(height: 56.0, child: basicAppBar),
      SizedBox(height: 4.0),
      Container(height: 56.0, child: withLeading),
      SizedBox(height: 4.0),
      Container(height: 56.0, child: withActions),
      SizedBox(height: 4.0),
      Container(height: 56.0, child: customColors),
      SizedBox(height: 4.0),
      Container(height: 56.0, child: centerTitle),
      SizedBox(height: 4.0),
      Container(height: 104.0, child: withBottom),
      SizedBox(height: 4.0),
      Container(height: 56.0, child: withFlexibleSpace),
      SizedBox(height: 4.0),
      Container(height: 80.0, child: customHeight),
    ],
  );
}
