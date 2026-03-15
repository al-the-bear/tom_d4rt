// D4rt test script: Tests CustomScrollView from widgets
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('CustomScrollView test executing');

  // Test CustomScrollView with SliverToBoxAdapter children
  final basicScrollView = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverToBoxAdapter(
        child: Container(
          height: 80.0,
          color: Colors.blue,
          child: Center(
            child: Text('Sliver 1', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Container(
          height: 80.0,
          color: Colors.green,
          child: Center(
            child: Text('Sliver 2', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Container(
          height: 80.0,
          color: Colors.orange,
          child: Center(
            child: Text('Sliver 3', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    ],
  );
  print('CustomScrollView with SliverToBoxAdapter children created');

  // Test CustomScrollView with SliverAppBar
  final withAppBar = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverAppBar(
        title: Text('Sliver AppBar'),
        backgroundColor: Colors.purple,
        expandedHeight: 100.0,
        floating: true,
      ),
      SliverToBoxAdapter(
        child: Container(
          height: 60.0,
          color: Colors.purple,
          child: Center(
            child: Text(
              'Content below AppBar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    ],
  );
  print('CustomScrollView with SliverAppBar created');

  // Test CustomScrollView with SliverPadding
  final withPadding = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverPadding(
        padding: EdgeInsets.all(16.0),
        sliver: SliverToBoxAdapter(
          child: Container(
            height: 60.0,
            color: Colors.teal,
            child: Center(
              child: Text(
                'Padded sliver',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    ],
  );
  print('CustomScrollView with SliverPadding created');

  // Test CustomScrollView with SliverList
  final withSliverList = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverList(
        delegate: SliverChildListDelegate([
          Container(
            height: 50.0,
            color: Colors.red,
            child: Center(
              child: Text('List item 1', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 50.0,
            color: Colors.pink,
            child: Center(
              child: Text('List item 2', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            height: 50.0,
            color: Colors.red,
            child: Center(
              child: Text('List item 3', style: TextStyle(color: Colors.white)),
            ),
          ),
        ]),
      ),
    ],
  );
  print('CustomScrollView with SliverList created');

  // Test CustomScrollView with mixed slivers
  final mixedSlivers = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverToBoxAdapter(
        child: Container(
          height: 50.0,
          color: Colors.indigo,
          child: Center(
            child: Text('Header', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        sliver: SliverList(
          delegate: SliverChildListDelegate([
            Card(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('Card 1'),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('Card 2'),
              ),
            ),
          ]),
        ),
      ),
      SliverToBoxAdapter(
        child: Container(
          height: 50.0,
          color: Colors.indigo,
          child: Center(
            child: Text('Footer', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    ],
  );
  print('CustomScrollView with mixed slivers created');

  // Test CustomScrollView with scrollDirection horizontal
  final horizontalScroll = SizedBox(
    height: 80.0,
    child: CustomScrollView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            width: 100.0,
            color: Colors.cyan,
            child: Center(
              child: Text('H1', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            width: 100.0,
            color: Colors.amber,
            child: Center(
              child: Text('H2', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            width: 100.0,
            color: Colors.cyan,
            child: Center(
              child: Text('H3', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    ),
  );
  print('CustomScrollView with horizontal scrollDirection created');

  // Test CustomScrollView with reverse
  final reverseScroll = CustomScrollView(
    shrinkWrap: true,
    reverse: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverToBoxAdapter(
        child: Container(
          height: 50.0,
          color: Colors.brown,
          child: Center(
            child: Text(
              'First (at bottom)',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Container(
          height: 50.0,
          color: Colors.grey,
          child: Center(
            child: Text(
              'Second (above)',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    ],
  );
  print('CustomScrollView with reverse=true created');

  print('CustomScrollView test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'CustomScrollView Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text(
          'Basic with SliverToBoxAdapter:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 300.0, child: basicScrollView),
        SizedBox(height: 16.0),
        Text(
          'With SliverAppBar:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 200.0, child: withAppBar),
        SizedBox(height: 16.0),
        Text(
          'With SliverPadding:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 120.0, child: withPadding),
        SizedBox(height: 16.0),
        Text('With SliverList:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 200.0, child: withSliverList),
        SizedBox(height: 16.0),
        Text('Mixed slivers:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 250.0, child: mixedSlivers),
        SizedBox(height: 16.0),
        Text(
          'Horizontal scroll:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        horizontalScroll,
        SizedBox(height: 16.0),
        Text('Reverse:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 120.0, child: reverseScroll),
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• CustomScrollView combines multiple slivers'),
        Text('• SliverToBoxAdapter wraps regular widgets'),
        Text('• SliverPadding adds padding around slivers'),
        Text('• scrollDirection supports horizontal scrolling'),
        Text('• reverse flips the scroll direction'),
      ],
    ),
  );
}
