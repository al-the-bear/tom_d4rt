// D4rt test script: Tests SliverList, SliverGrid, SliverToBoxAdapter, SliverPadding from widgets
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverList test executing');

  // Test SliverList with SliverChildListDelegate
  final sliverListWidget = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverList(
        delegate: SliverChildListDelegate([
          Container(
            height: 50.0,
            color: Colors.blue,
            child: Center(
              child: Text(
                'SliverList item 1',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 50.0,
            color: Colors.lightBlue,
            child: Center(
              child: Text(
                'SliverList item 2',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 50.0,
            color: Colors.blue,
            child: Center(
              child: Text(
                'SliverList item 3',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            height: 50.0,
            color: Colors.lightBlue,
            child: Center(
              child: Text(
                'SliverList item 4',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ]),
      ),
    ],
  );
  print('SliverList with SliverChildListDelegate created');

  // Test SliverList with SliverChildBuilderDelegate
  final sliverListBuilder = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext ctx, int index) {
          print('SliverChildBuilderDelegate building index $index');
          return Container(
            height: 40.0,
            color: index % 2 == 0 ? Colors.green : Colors.lightGreen,
            child: Center(
              child: Text(
                'Builder item $index',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }, childCount: 5),
      ),
    ],
  );
  print('SliverList with SliverChildBuilderDelegate created');

  // Test SliverGrid with SliverGridDelegateWithFixedCrossAxisCount
  final sliverGridFixed = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          childAspectRatio: 1.0,
        ),
        delegate: SliverChildListDelegate([
          Container(
            color: Colors.red,
            child: Center(
              child: Text('1', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            color: Colors.orange,
            child: Center(
              child: Text('2', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            color: Colors.yellow,
            child: Center(
              child: Text('3', style: TextStyle(color: Colors.black)),
            ),
          ),
          Container(
            color: Colors.green,
            child: Center(
              child: Text('4', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            color: Colors.blue,
            child: Center(
              child: Text('5', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            color: Colors.purple,
            child: Center(
              child: Text('6', style: TextStyle(color: Colors.white)),
            ),
          ),
        ]),
      ),
    ],
  );
  print('SliverGrid with fixedCrossAxisCount=3 created');

  // Test SliverGrid with SliverGridDelegateWithMaxCrossAxisExtent
  final sliverGridExtent = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 100.0,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          childAspectRatio: 1.5,
        ),
        delegate: SliverChildBuilderDelegate((BuildContext ctx, int index) {
          return Container(
            color: Colors.primaries[index % Colors.primaries.length],
            child: Center(
              child: Text('$index', style: TextStyle(color: Colors.white)),
            ),
          );
        }, childCount: 8),
      ),
    ],
  );
  print('SliverGrid with maxCrossAxisExtent=100 created');

  // Test SliverToBoxAdapter
  final sliverToBoxWidget = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverToBoxAdapter(
        child: Container(
          height: 60.0,
          color: Colors.teal,
          child: Center(
            child: Text(
              'SliverToBoxAdapter',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Card in SliverToBoxAdapter'),
            ),
          ),
        ),
      ),
    ],
  );
  print('SliverToBoxAdapter widgets created');

  // Test SliverPadding
  final sliverPaddingWidget = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverPadding(
        padding: EdgeInsets.all(16.0),
        sliver: SliverList(
          delegate: SliverChildListDelegate([
            Container(
              height: 40.0,
              color: Colors.indigo,
              child: Center(
                child: Text(
                  'Padded item 1',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Container(
              height: 40.0,
              color: Colors.indigo,
              child: Center(
                child: Text(
                  'Padded item 2',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ]),
        ),
      ),
    ],
  );
  print('SliverPadding with SliverList created');

  // Test SliverPadding with symmetric padding
  final sliverPaddingSymmetric = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        sliver: SliverToBoxAdapter(
          child: Container(
            height: 50.0,
            color: Colors.brown,
            child: Center(
              child: Text(
                'Symmetric padding',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    ],
  );
  print('SliverPadding with symmetric padding created');

  // Test combined slivers
  final combinedSlivers = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverToBoxAdapter(
        child: Container(
          height: 40.0,
          color: Colors.grey,
          child: Center(
            child: Text(
              'Header',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      SliverPadding(
        padding: EdgeInsets.all(8.0),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            childAspectRatio: 2.0,
          ),
          delegate: SliverChildListDelegate([
            Container(
              color: Colors.cyan,
              child: Center(child: Text('A')),
            ),
            Container(
              color: Colors.amber,
              child: Center(child: Text('B')),
            ),
            Container(
              color: Colors.cyan,
              child: Center(child: Text('C')),
            ),
            Container(
              color: Colors.amber,
              child: Center(child: Text('D')),
            ),
          ]),
        ),
      ),
      SliverToBoxAdapter(
        child: Container(
          height: 40.0,
          color: Colors.grey,
          child: Center(
            child: Text(
              'Footer',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ],
  );
  print('Combined slivers created');

  print('SliverList test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'SliverList / SliverGrid Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text(
          'SliverList (ListDelegate):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 220.0, child: sliverListWidget),
        SizedBox(height: 16.0),
        Text(
          'SliverList (BuilderDelegate):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 220.0, child: sliverListBuilder),
        SizedBox(height: 16.0),
        Text(
          'SliverGrid (fixedCrossAxisCount):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 250.0, child: sliverGridFixed),
        SizedBox(height: 16.0),
        Text(
          'SliverGrid (maxCrossAxisExtent):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 200.0, child: sliverGridExtent),
        SizedBox(height: 16.0),
        Text(
          'SliverToBoxAdapter:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 150.0, child: sliverToBoxWidget),
        SizedBox(height: 16.0),
        Text('SliverPadding:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 130.0, child: sliverPaddingWidget),
        SizedBox(height: 16.0),
        Text(
          'SliverPadding symmetric:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 80.0, child: sliverPaddingSymmetric),
        SizedBox(height: 16.0),
        Text('Combined:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 200.0, child: combinedSlivers),
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• SliverList uses delegate for children'),
        Text('• SliverGrid uses gridDelegate + delegate'),
        Text('• SliverToBoxAdapter wraps regular widgets'),
        Text('• SliverPadding adds padding around slivers'),
        Text('• SliverChildBuilderDelegate for lazy building'),
      ],
    ),
  );
}
