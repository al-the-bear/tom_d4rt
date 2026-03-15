// D4rt test script: Tests Scrollbar, RefreshIndicator from material
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Scrollbar/RefreshIndicator test executing');

  // ========== SCROLLBAR ==========
  print('--- Scrollbar Tests ---');

  // Test basic Scrollbar
  final scrollBasic = Scrollbar(
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 60.0,
            color: Colors.red,
            child: Center(
              child: Text('Item 1', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.blue,
            child: Center(
              child: Text('Item 2', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.green,
            child: Center(
              child: Text('Item 3', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.orange,
            child: Center(
              child: Text('Item 4', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.purple,
            child: Center(
              child: Text('Item 5', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    ),
  );
  print('Scrollbar basic created');

  // Test Scrollbar with thumbVisibility=true
  final scrollThumbVisible = Scrollbar(
    thumbVisibility: true,
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 50.0,
            color: Colors.blue,
            child: Center(
              child: Text(
                'Always visible 1',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 50.0,
            color: Colors.green,
            child: Center(
              child: Text(
                'Always visible 2',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 50.0,
            color: Colors.red,
            child: Center(
              child: Text(
                'Always visible 3',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 50.0,
            color: Colors.teal,
            child: Center(
              child: Text(
                'Always visible 4',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 50.0,
            color: Colors.orange,
            child: Center(
              child: Text(
                'Always visible 5',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 50.0,
            color: Colors.purple,
            child: Center(
              child: Text(
                'Always visible 6',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ),
  );
  print('Scrollbar with thumbVisibility=true created');

  // Test Scrollbar with thickness
  final scrollThick = Scrollbar(
    thickness: 12.0,
    thumbVisibility: true,
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 60.0,
            color: Colors.indigo,
            child: Center(
              child: Text('Thick 1', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.amber,
            child: Center(
              child: Text('Thick 2', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.cyan,
            child: Center(
              child: Text('Thick 3', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.brown,
            child: Center(
              child: Text('Thick 4', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.pink,
            child: Center(
              child: Text('Thick 5', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    ),
  );
  print('Scrollbar with thickness=12 created');

  // Test Scrollbar with radius
  final scrollRadius = Scrollbar(
    radius: Radius.circular(10.0),
    thumbVisibility: true,
    thickness: 8.0,
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 60.0,
            color: Colors.deepOrange,
            child: Center(
              child: Text('Radius 1', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.deepPurple,
            child: Center(
              child: Text('Radius 2', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.lightBlue,
            child: Center(
              child: Text('Radius 3', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.lightGreen,
            child: Center(
              child: Text('Radius 4', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.lime,
            child: Center(
              child: Text('Radius 5', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    ),
  );
  print('Scrollbar with radius=10 created');

  // Test Scrollbar with interactive=true
  final scrollInteractive = Scrollbar(
    interactive: true,
    thumbVisibility: true,
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 60.0,
            color: Colors.red,
            child: Center(
              child: Text(
                'Interactive 1',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.blue,
            child: Center(
              child: Text(
                'Interactive 2',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.green,
            child: Center(
              child: Text(
                'Interactive 3',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.orange,
            child: Center(
              child: Text(
                'Interactive 4',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.purple,
            child: Center(
              child: Text(
                'Interactive 5',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ),
  );
  print('Scrollbar with interactive=true created');

  // ========== REFRESHINDICATOR ==========
  print('--- RefreshIndicator Tests ---');

  // Test basic RefreshIndicator
  final refreshBasic = RefreshIndicator(
    onRefresh: () {
      print('Refreshing...');
      return Future.value();
    },
    child: ListView(
      children: [
        ListTile(title: Text('Pull to refresh 1')),
        ListTile(title: Text('Pull to refresh 2')),
        ListTile(title: Text('Pull to refresh 3')),
        ListTile(title: Text('Pull to refresh 4')),
      ],
    ),
  );
  print('RefreshIndicator basic created');

  // Test RefreshIndicator with color
  final refreshColored = RefreshIndicator(
    color: Colors.red,
    onRefresh: () {
      print('Red refresh');
      return Future.value();
    },
    child: ListView(
      children: [
        ListTile(
          leading: Icon(Icons.circle, color: Colors.red),
          title: Text('Red indicator 1'),
        ),
        ListTile(
          leading: Icon(Icons.circle, color: Colors.red),
          title: Text('Red indicator 2'),
        ),
        ListTile(
          leading: Icon(Icons.circle, color: Colors.red),
          title: Text('Red indicator 3'),
        ),
      ],
    ),
  );
  print('RefreshIndicator with color=red created');

  // Test RefreshIndicator with backgroundColor
  final refreshBg = RefreshIndicator(
    backgroundColor: Colors.black,
    color: Colors.white,
    onRefresh: () {
      print('Dark refresh');
      return Future.value();
    },
    child: ListView(
      children: [
        ListTile(title: Text('Dark bg 1')),
        ListTile(title: Text('Dark bg 2')),
        ListTile(title: Text('Dark bg 3')),
      ],
    ),
  );
  print('RefreshIndicator with backgroundColor=black created');

  // Test RefreshIndicator with displacement
  final refreshDisplaced = RefreshIndicator(
    displacement: 60.0,
    onRefresh: () {
      print('Displaced refresh');
      return Future.value();
    },
    child: ListView(
      children: [
        ListTile(title: Text('Displacement 60 - item 1')),
        ListTile(title: Text('Displacement 60 - item 2')),
        ListTile(title: Text('Displacement 60 - item 3')),
      ],
    ),
  );
  print('RefreshIndicator with displacement=60 created');

  // Test RefreshIndicator with strokeWidth
  final refreshStroke = RefreshIndicator(
    strokeWidth: 4.0,
    color: Colors.green,
    onRefresh: () {
      print('Thick stroke refresh');
      return Future.value();
    },
    child: ListView(
      children: [
        ListTile(title: Text('Stroke width 4 - item 1')),
        ListTile(title: Text('Stroke width 4 - item 2')),
        ListTile(title: Text('Stroke width 4 - item 3')),
      ],
    ),
  );
  print('RefreshIndicator with strokeWidth=4 created');

  // Test RefreshIndicator with edgeOffset
  final refreshEdge = RefreshIndicator(
    edgeOffset: 50.0,
    onRefresh: () {
      print('Edge offset refresh');
      return Future.value();
    },
    child: ListView(
      children: [
        ListTile(title: Text('Edge offset 50 - item 1')),
        ListTile(title: Text('Edge offset 50 - item 2')),
        ListTile(title: Text('Edge offset 50 - item 3')),
      ],
    ),
  );
  print('RefreshIndicator with edgeOffset=50 created');

  print('All Scrollbar/RefreshIndicator tests completed');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '=== Scrollbar Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Basic:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 180.0, child: scrollBasic),
        SizedBox(height: 8.0),
        Text(
          'Thumb always visible:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 180.0, child: scrollThumbVisible),
        SizedBox(height: 8.0),
        Text('Thickness=12:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 180.0, child: scrollThick),
        SizedBox(height: 8.0),
        Text('Radius=10:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 180.0, child: scrollRadius),
        SizedBox(height: 8.0),
        Text('Interactive:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 180.0, child: scrollInteractive),
        SizedBox(height: 16.0),
        Text(
          '=== RefreshIndicator Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Basic:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 180.0, child: refreshBasic),
        SizedBox(height: 8.0),
        Text('Color=red:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 140.0, child: refreshColored),
        SizedBox(height: 8.0),
        Text('Dark background:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 140.0, child: refreshBg),
        SizedBox(height: 8.0),
        Text('Displacement=60:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 140.0, child: refreshDisplaced),
        SizedBox(height: 8.0),
        Text('Stroke width=4:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 140.0, child: refreshStroke),
        SizedBox(height: 8.0),
        Text('Edge offset=50:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 140.0, child: refreshEdge),
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• Scrollbar adds scrollbar indicator to scrollable widgets'),
        Text('• thumbVisibility=true keeps scrollbar always visible'),
        Text('• thickness controls scrollbar width'),
        Text('• radius rounds scrollbar thumb corners'),
        Text('• RefreshIndicator adds pull-to-refresh to scrollable lists'),
        Text('• displacement controls how far indicator drops'),
      ],
    ),
  );
}
