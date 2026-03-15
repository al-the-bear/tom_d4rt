// D4rt test script: Tests SliverFixedExtentList, SliverFillViewport, SliverPersistentHeader from widgets
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverWidgets test executing');

  // Test SliverFixedExtentList
  final fixedExtentSliver = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverFixedExtentList(
        itemExtent: 50.0,
        delegate: SliverChildBuilderDelegate((context, index) {
          return Container(
            color: Colors.primaries[index % Colors.primaries.length],
            child: Center(
              child: Text(
                'Fixed extent item $index',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }, childCount: 5),
      ),
    ],
  );
  print('SliverFixedExtentList(itemExtent: 50.0, childCount: 5) created');

  // Test SliverFixedExtentList with different extent
  final fixedExtent2 = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverFixedExtentList(
        itemExtent: 80.0,
        delegate: SliverChildListDelegate([
          Container(
            color: Colors.blue,
            child: Center(
              child: Text('A', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            color: Colors.green,
            child: Center(
              child: Text('B', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            color: Colors.orange,
            child: Center(
              child: Text('C', style: TextStyle(color: Colors.white)),
            ),
          ),
        ]),
      ),
    ],
  );
  print('SliverFixedExtentList(itemExtent: 80.0) with ListDelegate created');

  // Test SliverFillViewport
  final fillViewport = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverFillViewport(
        viewportFraction: 1.0,
        delegate: SliverChildListDelegate([
          Container(
            color: Colors.red,
            child: Center(
              child: Text(
                'Fill Viewport 1',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ),
          Container(
            color: Colors.purple,
            child: Center(
              child: Text(
                'Fill Viewport 2',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          ),
        ]),
      ),
    ],
  );
  print('SliverFillViewport(viewportFraction: 1.0) with 2 children created');

  // Test SliverFillViewport with partial fraction
  final fillViewportPartial = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverFillViewport(
        viewportFraction: 0.5,
        delegate: SliverChildBuilderDelegate((context, index) {
          return Container(
            margin: EdgeInsets.all(4.0),
            color: Colors.teal,
            child: Center(child: Text('Half $index')),
          );
        }, childCount: 4),
      ),
    ],
  );
  print('SliverFillViewport(viewportFraction: 0.5) created');

  // SliverPersistentHeader requires a SliverPersistentHeaderDelegate
  // which is abstract and cannot be subclassed in D4rt
  print(
    'SliverPersistentHeader requires SliverPersistentHeaderDelegate (abstract)',
  );
  print(
    'Cannot subclass delegate in D4rt - showing SliverAppBar as alternative',
  );

  // SliverAppBar internally uses SliverPersistentHeader
  final persistentConcept = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverAppBar(
        title: Text('Persistent Header Concept'),
        backgroundColor: Colors.indigo,
        expandedHeight: 80.0,
        floating: true,
        pinned: true,
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return ListTile(
            leading: Icon(Icons.label),
            title: Text('Item below header $index'),
          );
        }, childCount: 5),
      ),
    ],
  );
  print('SliverAppBar (uses SliverPersistentHeader internally) created');

  // Test SliverFillRemaining in combination
  final fillRemaining = CustomScrollView(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    slivers: [
      SliverToBoxAdapter(
        child: Container(
          height: 50.0,
          color: Colors.amber,
          child: Center(child: Text('Header content')),
        ),
      ),
      SliverFillRemaining(
        child: Container(
          color: Colors.grey,
          child: Center(child: Text('Fill remaining space')),
        ),
      ),
    ],
  );
  print('CustomScrollView with SliverFillRemaining created');

  print('SliverWidgets test completed');
  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Sliver Widgets Tests'),
        SizedBox(height: 4.0),
        SizedBox(height: 260.0, child: fixedExtentSliver),
        SizedBox(height: 4.0),
        SizedBox(height: 250.0, child: fixedExtent2),
        SizedBox(height: 4.0),
        SizedBox(height: 200.0, child: fillViewport),
        SizedBox(height: 4.0),
        SizedBox(height: 200.0, child: fillViewportPartial),
        SizedBox(height: 4.0),
        SizedBox(height: 200.0, child: persistentConcept),
        SizedBox(height: 4.0),
        SizedBox(height: 150.0, child: fillRemaining),
      ],
    ),
  );
}
