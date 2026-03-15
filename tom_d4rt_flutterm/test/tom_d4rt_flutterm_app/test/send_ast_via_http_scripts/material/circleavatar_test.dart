// D4rt test script: Tests CircleAvatar from material
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('CircleAvatar test executing');

  // Test basic CircleAvatar with child text
  final avatarBasic = CircleAvatar(child: Text('AB'));
  print('CircleAvatar basic with child text created');

  // Test CircleAvatar with backgroundColor
  final avatarBgColor = CircleAvatar(
    backgroundColor: Colors.blue,
    child: Text('BG', style: TextStyle(color: Colors.white)),
  );
  print('CircleAvatar with backgroundColor=blue created');

  // Test CircleAvatar with foregroundColor
  final avatarFgColor = CircleAvatar(
    backgroundColor: Colors.white,
    foregroundColor: Colors.red,
    child: Text('FG'),
  );
  print('CircleAvatar with foregroundColor=red created');

  // Test CircleAvatar with radius
  final avatarRadius = CircleAvatar(
    radius: 40.0,
    backgroundColor: Colors.green,
    child: Text('40', style: TextStyle(color: Colors.white, fontSize: 20.0)),
  );
  print('CircleAvatar with radius=40 created');

  // Test CircleAvatar with small radius
  final avatarSmall = CircleAvatar(
    radius: 16.0,
    backgroundColor: Colors.orange,
    child: Text('S', style: TextStyle(color: Colors.white, fontSize: 10.0)),
  );
  print('CircleAvatar with radius=16 (small) created');

  // Test CircleAvatar with large radius
  final avatarLarge = CircleAvatar(
    radius: 60.0,
    backgroundColor: Colors.purple,
    child: Text('XL', style: TextStyle(color: Colors.white, fontSize: 28.0)),
  );
  print('CircleAvatar with radius=60 (large) created');

  // Test CircleAvatar with minRadius
  final avatarMinRadius = CircleAvatar(
    minRadius: 20.0,
    backgroundColor: Colors.teal,
    child: Text('Min', style: TextStyle(color: Colors.white, fontSize: 10.0)),
  );
  print('CircleAvatar with minRadius=20 created');

  // Test CircleAvatar with maxRadius
  final avatarMaxRadius = CircleAvatar(
    maxRadius: 50.0,
    backgroundColor: Colors.indigo,
    child: Text('Max', style: TextStyle(color: Colors.white, fontSize: 16.0)),
  );
  print('CircleAvatar with maxRadius=50 created');

  // Test CircleAvatar with minRadius and maxRadius
  final avatarMinMax = CircleAvatar(
    minRadius: 25.0,
    maxRadius: 45.0,
    backgroundColor: Colors.brown,
    child: Text('MM', style: TextStyle(color: Colors.white)),
  );
  print('CircleAvatar with minRadius=25, maxRadius=45 created');

  // Test CircleAvatar with Icon child
  final avatarIcon = CircleAvatar(
    backgroundColor: Colors.red,
    child: Icon(Icons.person, color: Colors.white),
  );
  print('CircleAvatar with Icon child created');

  // Test CircleAvatar with multiple icons
  final avatarIcons = CircleAvatar(
    radius: 30.0,
    backgroundColor: Colors.deepPurple,
    child: Icon(Icons.star, color: Colors.yellow, size: 30.0),
  );
  print('CircleAvatar with star icon created');

  // Test CircleAvatar with number
  final avatarNumber = CircleAvatar(
    radius: 20.0,
    backgroundColor: Colors.cyan,
    child: Text(
      '7',
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
  print('CircleAvatar with number child created');

  // Test CircleAvatar with foregroundColor and backgroundColor combined
  final avatarBothColors = CircleAvatar(
    backgroundColor: Colors.black,
    foregroundColor: Colors.amber,
    radius: 30.0,
    child: Text(
      'AB',
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    ),
  );
  print('CircleAvatar with both colors created');

  // Test CircleAvatar nested inside ListTile
  final avatarInTile = ListTile(
    leading: CircleAvatar(
      backgroundColor: Colors.blue,
      child: Text('JD', style: TextStyle(color: Colors.white)),
    ),
    title: Text('John Doe'),
    subtitle: Text('john@example.com'),
  );
  print('CircleAvatar in ListTile created');

  print('All CircleAvatar tests completed');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '=== CircleAvatar Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Basic:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: avatarBasic),
        SizedBox(height: 8.0),
        Text(
          'Background color:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: avatarBgColor),
        SizedBox(height: 8.0),
        Text(
          'Foreground color:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: avatarFgColor),
        SizedBox(height: 8.0),
        Text('Radius=40:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: avatarRadius),
        SizedBox(height: 8.0),
        Text(
          'Small (radius=16):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: avatarSmall),
        SizedBox(height: 8.0),
        Text(
          'Large (radius=60):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Center(child: avatarLarge),
        SizedBox(height: 8.0),
        Text('MinRadius=20:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: avatarMinRadius),
        SizedBox(height: 8.0),
        Text('MaxRadius=50:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: avatarMaxRadius),
        SizedBox(height: 8.0),
        Text('Min=25, Max=45:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: avatarMinMax),
        SizedBox(height: 8.0),
        Text('Icon child:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: avatarIcon),
        SizedBox(height: 8.0),
        Text('Star icon:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: avatarIcons),
        SizedBox(height: 8.0),
        Text('Number child:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: avatarNumber),
        SizedBox(height: 8.0),
        Text('Both colors:', style: TextStyle(fontWeight: FontWeight.bold)),
        Center(child: avatarBothColors),
        SizedBox(height: 8.0),
        Text('In ListTile:', style: TextStyle(fontWeight: FontWeight.bold)),
        avatarInTile,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• CircleAvatar displays a circular widget'),
        Text('• backgroundColor sets the circle background'),
        Text('• foregroundColor sets text/icon color'),
        Text('• radius sets exact size, minRadius/maxRadius set range'),
        Text('• child can be Text, Icon, or any widget'),
        Text('• Commonly used in ListTile leading'),
      ],
    ),
  );
}
