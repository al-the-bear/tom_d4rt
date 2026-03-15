// D4rt test script: Tests LayoutBuilder from widgets
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('LayoutBuilder test executing');

  // Test LayoutBuilder checking constraints
  final constraintCheck = LayoutBuilder(
    builder: (BuildContext ctx, BoxConstraints constraints) {
      print('LayoutBuilder constraints: $constraints');
      print('maxWidth: ${constraints.maxWidth}');
      print('maxHeight: ${constraints.maxHeight}');
      print('minWidth: ${constraints.minWidth}');
      print('minHeight: ${constraints.minHeight}');
      return Container(
        color: Colors.blue,
        height: 60.0,
        child: Center(
          child: Text(
            'Max: ${constraints.maxWidth.toInt()}x${constraints.maxHeight.toInt()}',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    },
  );
  print('LayoutBuilder with constraint check created');

  // Test LayoutBuilder using maxWidth for responsive layout
  final responsiveLayout = LayoutBuilder(
    builder: (BuildContext ctx, BoxConstraints constraints) {
      final maxWidth = constraints.maxWidth;
      print('LayoutBuilder maxWidth: $maxWidth');
      if (maxWidth > 600.0) {
        return Row(
          children: [
            Expanded(
              child: Container(
                color: Colors.green,
                height: 80.0,
                child: Center(
                  child: Text(
                    'Left Panel',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Container(
                color: Colors.teal,
                height: 80.0,
                child: Center(
                  child: Text(
                    'Right Panel',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        );
      } else {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.green,
              height: 60.0,
              child: Center(
                child: Text('Top Panel', style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              color: Colors.teal,
              height: 60.0,
              child: Center(
                child: Text(
                  'Bottom Panel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      }
    },
  );
  print('LayoutBuilder responsive layout created');

  // Test LayoutBuilder with percentage-based sizing
  final percentSizing = LayoutBuilder(
    builder: (BuildContext ctx, BoxConstraints constraints) {
      final halfWidth = constraints.maxWidth * 0.5;
      print('LayoutBuilder half width: $halfWidth');
      return Container(
        width: halfWidth,
        height: 60.0,
        color: Colors.orange,
        child: Center(
          child: Text('50% width', style: TextStyle(color: Colors.white)),
        ),
      );
    },
  );
  print('LayoutBuilder with percentage sizing created');

  // Test LayoutBuilder inside constrained parent
  final constrainedParent = SizedBox(
    width: 200.0,
    height: 100.0,
    child: LayoutBuilder(
      builder: (BuildContext ctx, BoxConstraints constraints) {
        print('Constrained LayoutBuilder: $constraints');
        return Container(
          color: Colors.purple,
          child: Center(
            child: Text(
              '${constraints.maxWidth.toInt()}x${constraints.maxHeight.toInt()}',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    ),
  );
  print('LayoutBuilder inside constrained SizedBox created');

  // Test LayoutBuilder with hasInfiniteWidth check
  final infiniteCheck = LayoutBuilder(
    builder: (BuildContext ctx, BoxConstraints constraints) {
      final isUnbounded = constraints.maxWidth == double.infinity;
      print('LayoutBuilder hasBoundedWidth: ${constraints.hasBoundedWidth}');
      return Container(
        width: isUnbounded ? 200.0 : constraints.maxWidth,
        height: 60.0,
        color: Colors.red,
        child: Center(
          child: Text(
            'Bounded: ${constraints.hasBoundedWidth}',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    },
  );
  print('LayoutBuilder with infinity check created');

  // Test LayoutBuilder returning different child counts
  final dynamicChildren = LayoutBuilder(
    builder: (BuildContext ctx, BoxConstraints constraints) {
      final itemWidth = 80.0;
      final count = (constraints.maxWidth / itemWidth).floor();
      print('LayoutBuilder can fit $count items');
      final items = <Widget>[];
      for (int i = 0; i < count; i = i + 1) {
        items.add(
          Container(
            width: itemWidth - 4.0,
            height: 40.0,
            margin: EdgeInsets.all(2.0),
            color: Colors.primaries[i % Colors.primaries.length],
            child: Center(
              child: Text('${i + 1}', style: TextStyle(color: Colors.white)),
            ),
          ),
        );
      }
      return Row(children: items);
    },
  );
  print('LayoutBuilder with dynamic children created');

  print('LayoutBuilder test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'LayoutBuilder Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Text(
          'Constraint Check:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        constraintCheck,
        SizedBox(height: 8.0),
        Text(
          'Responsive Layout:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        responsiveLayout,
        SizedBox(height: 8.0),
        Text(
          'Percentage Sizing:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        percentSizing,
        SizedBox(height: 8.0),
        Text(
          'Constrained Parent (200x100):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        constrainedParent,
        SizedBox(height: 8.0),
        Text('Bounded Check:', style: TextStyle(fontWeight: FontWeight.bold)),
        infiniteCheck,
        SizedBox(height: 8.0),
        Text(
          'Dynamic Children:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        dynamicChildren,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• LayoutBuilder provides parent constraints'),
        Text('• Use maxWidth/maxHeight for responsive UIs'),
        Text('• hasBoundedWidth checks for infinite constraints'),
        Text('• Great for percentage-based layouts'),
        Text('• Rebuilds when constraints change'),
      ],
    ),
  );
}
