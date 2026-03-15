// D4rt test script: Tests AnimatedList from widgets
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimatedList test executing');

  // Test AnimatedList with initialItemCount
  final listBasic = AnimatedList(
    initialItemCount: 3,
    itemBuilder: (context, index, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: ListTile(title: Text('Item $index')),
      );
    },
  );
  print('AnimatedList with initialItemCount=3 created');

  // Test AnimatedList with initialItemCount=0
  final listEmpty = AnimatedList(
    initialItemCount: 0,
    itemBuilder: (context, index, animation) {
      return FadeTransition(
        opacity: animation,
        child: ListTile(title: Text('Item $index')),
      );
    },
  );
  print('AnimatedList with initialItemCount=0 created');

  // Test AnimatedList with initialItemCount=5
  final listFive = AnimatedList(
    initialItemCount: 5,
    itemBuilder: (context, index, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: Card(
          child: ListTile(
            leading: Icon(Icons.star),
            title: Text('Star item $index'),
          ),
        ),
      );
    },
  );
  print('AnimatedList with initialItemCount=5 created');

  // Test AnimatedList with horizontal scrollDirection
  final listHorizontal = SizedBox(
    height: 80.0,
    child: AnimatedList(
      scrollDirection: Axis.horizontal,
      initialItemCount: 4,
      itemBuilder: (context, index, animation) {
        return SizeTransition(
          sizeFactor: animation,
          axis: Axis.horizontal,
          child: Container(
            width: 80.0,
            margin: EdgeInsets.all(4.0),
            color: Colors.blue,
            child: Center(
              child: Text('H$index', style: TextStyle(color: Colors.white)),
            ),
          ),
        );
      },
    ),
  );
  print('AnimatedList with scrollDirection=horizontal created');

  // Test AnimatedList with physics NeverScrollableScrollPhysics
  final listNeverScroll = AnimatedList(
    initialItemCount: 3,
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (context, index, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: ListTile(
          title: Text('No-scroll item $index'),
          subtitle: Text('NeverScrollableScrollPhysics'),
        ),
      );
    },
  );
  print('AnimatedList with NeverScrollableScrollPhysics created');

  // Test AnimatedList with BouncingScrollPhysics
  final listBouncing = AnimatedList(
    initialItemCount: 4,
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: Container(
          height: 50.0,
          margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
          color: Colors.green,
          child: Center(
            child: Text('Bounce $index', style: TextStyle(color: Colors.white)),
          ),
        ),
      );
    },
  );
  print('AnimatedList with BouncingScrollPhysics created');

  // Test AnimatedList with reverse
  final listReverse = AnimatedList(
    initialItemCount: 3,
    reverse: true,
    itemBuilder: (context, index, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: ListTile(title: Text('Reverse item $index')),
      );
    },
  );
  print('AnimatedList with reverse=true created');

  // Test AnimatedList with padding
  final listPadded = AnimatedList(
    initialItemCount: 3,
    padding: EdgeInsets.all(16.0),
    itemBuilder: (context, index, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: Card(
          child: ListTile(
            leading: CircleAvatar(child: Text('$index')),
            title: Text('Padded item $index'),
          ),
        ),
      );
    },
  );
  print('AnimatedList with padding created');

  // Test AnimatedList with shrinkWrap
  final listShrinkWrap = AnimatedList(
    initialItemCount: 2,
    shrinkWrap: true,
    itemBuilder: (context, index, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: Container(
          height: 40.0,
          margin: EdgeInsets.all(2.0),
          color: Colors.orange,
          child: Center(
            child: Text('Shrink $index', style: TextStyle(color: Colors.white)),
          ),
        ),
      );
    },
  );
  print('AnimatedList with shrinkWrap=true created');

  print('All AnimatedList tests completed');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '=== AnimatedList Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Basic (3 items):', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 180.0, child: listBasic),
        SizedBox(height: 8.0),
        Text('Empty (0 items):', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 60.0, child: listEmpty),
        SizedBox(height: 8.0),
        Text(
          'Five items with cards:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 300.0, child: listFive),
        SizedBox(height: 8.0),
        Text('Horizontal:', style: TextStyle(fontWeight: FontWeight.bold)),
        listHorizontal,
        SizedBox(height: 8.0),
        Text('NeverScrollable:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 180.0, child: listNeverScroll),
        SizedBox(height: 8.0),
        Text(
          'Bouncing physics:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 220.0, child: listBouncing),
        SizedBox(height: 8.0),
        Text('Reverse:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 180.0, child: listReverse),
        SizedBox(height: 8.0),
        Text('Padded:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 220.0, child: listPadded),
        SizedBox(height: 8.0),
        Text('ShrinkWrap:', style: TextStyle(fontWeight: FontWeight.bold)),
        listShrinkWrap,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• AnimatedList animates item insertion/removal'),
        Text('• initialItemCount sets starting number of items'),
        Text('• itemBuilder receives animation for transitions'),
        Text('• scrollDirection supports horizontal lists'),
        Text('• physics controls scroll behavior'),
        Text('• Use SizeTransition/FadeTransition with the animation param'),
      ],
    ),
  );
}
