// D4rt test script: Tests BottomAppBar from material
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BottomAppBar test executing');

  // Test basic BottomAppBar
  final barBasic = BottomAppBar(
    child: Row(
      children: [
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            print('Menu pressed');
          },
        ),
        Spacer(),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            print('Search pressed');
          },
        ),
      ],
    ),
  );
  print('Basic BottomAppBar created');

  // Test BottomAppBar with color
  final barColored = BottomAppBar(
    color: Colors.blue,
    child: Row(
      children: [
        IconButton(
          icon: Icon(Icons.home, color: Colors.white),
          onPressed: () {
            print('Home pressed');
          },
        ),
        IconButton(
          icon: Icon(Icons.favorite, color: Colors.white),
          onPressed: () {
            print('Favorite pressed');
          },
        ),
      ],
    ),
  );
  print('BottomAppBar with color=blue created');

  // Test BottomAppBar with elevation
  final barElevated = BottomAppBar(
    elevation: 12.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            print('Person pressed');
          },
        ),
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            print('Settings pressed');
          },
        ),
      ],
    ),
  );
  print('BottomAppBar with elevation=12 created');

  // Test BottomAppBar with shape (CircularNotchedRectangle)
  final barNotched = BottomAppBar(
    shape: CircularNotchedRectangle(),
    notchMargin: 8.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            print('Menu pressed');
          },
        ),
        SizedBox(width: 48.0),
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {
            print('More pressed');
          },
        ),
      ],
    ),
  );
  print('BottomAppBar with CircularNotchedRectangle and notchMargin=8 created');

  // Test BottomAppBar with clipBehavior
  final barClipped = BottomAppBar(
    clipBehavior: Clip.antiAlias,
    color: Colors.green,
    child: Row(
      children: [
        IconButton(
          icon: Icon(Icons.star, color: Colors.white),
          onPressed: () {
            print('Star pressed');
          },
        ),
        Text('Clipped', style: TextStyle(color: Colors.white)),
      ],
    ),
  );
  print('BottomAppBar with clipBehavior=antiAlias created');

  // Test BottomAppBar with surfaceTintColor
  final barSurfaceTint = BottomAppBar(
    surfaceTintColor: Colors.purple,
    elevation: 4.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.palette, color: Colors.purple),
        SizedBox(width: 8.0),
        Text('Surface tint'),
      ],
    ),
  );
  print('BottomAppBar with surfaceTintColor=purple created');

  // Test BottomAppBar with notchMargin variations
  final barWideNotch = BottomAppBar(
    shape: CircularNotchedRectangle(),
    notchMargin: 16.0,
    color: Colors.orange,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            print('Back pressed');
          },
        ),
        SizedBox(width: 56.0),
        IconButton(
          icon: Icon(Icons.arrow_forward, color: Colors.white),
          onPressed: () {
            print('Forward pressed');
          },
        ),
      ],
    ),
  );
  print('BottomAppBar with wide notchMargin=16 created');

  // Test BottomAppBar with padding
  final barPadded = BottomAppBar(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    height: 70.0,
    color: Colors.teal,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.home, color: Colors.white),
            Text('Home', style: TextStyle(color: Colors.white, fontSize: 10.0)),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search, color: Colors.white),
            Text(
              'Search',
              style: TextStyle(color: Colors.white, fontSize: 10.0),
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person, color: Colors.white),
            Text(
              'Profile',
              style: TextStyle(color: Colors.white, fontSize: 10.0),
            ),
          ],
        ),
      ],
    ),
  );
  print('BottomAppBar with padding and height created');

  // Test BottomAppBar with all properties combined
  final barFull = BottomAppBar(
    color: Colors.indigo,
    elevation: 8.0,
    shape: CircularNotchedRectangle(),
    notchMargin: 6.0,
    clipBehavior: Clip.antiAlias,
    surfaceTintColor: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: Icon(Icons.dashboard, color: Colors.white),
          onPressed: () {
            print('Dashboard pressed');
          },
        ),
        SizedBox(width: 40.0),
        IconButton(
          icon: Icon(Icons.notifications, color: Colors.white),
          onPressed: () {
            print('Notifications pressed');
          },
        ),
      ],
    ),
  );
  print('BottomAppBar with all properties created');

  print('All BottomAppBar tests completed');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '=== BottomAppBar Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Basic:', style: TextStyle(fontWeight: FontWeight.bold)),
        barBasic,
        SizedBox(height: 8.0),
        Text('Colored (blue):', style: TextStyle(fontWeight: FontWeight.bold)),
        barColored,
        SizedBox(height: 8.0),
        Text('Elevated:', style: TextStyle(fontWeight: FontWeight.bold)),
        barElevated,
        SizedBox(height: 8.0),
        Text('Notched shape:', style: TextStyle(fontWeight: FontWeight.bold)),
        barNotched,
        SizedBox(height: 8.0),
        Text('Clipped:', style: TextStyle(fontWeight: FontWeight.bold)),
        barClipped,
        SizedBox(height: 8.0),
        Text('Surface tint:', style: TextStyle(fontWeight: FontWeight.bold)),
        barSurfaceTint,
        SizedBox(height: 8.0),
        Text('Wide notch:', style: TextStyle(fontWeight: FontWeight.bold)),
        barWideNotch,
        SizedBox(height: 8.0),
        Text(
          'Padded with height:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        barPadded,
        SizedBox(height: 8.0),
        Text('Full properties:', style: TextStyle(fontWeight: FontWeight.bold)),
        barFull,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• BottomAppBar sits at bottom of Scaffold'),
        Text('• shape with CircularNotchedRectangle creates FAB notch'),
        Text('• notchMargin controls gap around the notch'),
        Text('• elevation controls shadow depth'),
        Text('• clipBehavior controls clipping of the shape'),
        Text('• surfaceTintColor tints the surface for Material 3'),
      ],
    ),
  );
}
