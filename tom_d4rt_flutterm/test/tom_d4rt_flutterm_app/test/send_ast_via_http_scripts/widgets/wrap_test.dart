// D4rt test script: Tests Wrap widget from widgets
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Wrap test executing');

  // Test basic Wrap
  final basicWrap = Wrap(
    children: List.generate(10, (index) {
      return Container(
        margin: EdgeInsets.all(4.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        color: Colors.blue.shade100,
        child: Text('Item $index'),
      );
    }),
  );
  print('Basic Wrap with 10 items created');

  // Test Wrap with spacing
  final spacedWrap = Wrap(
    spacing: 8.0, // horizontal gap
    runSpacing: 12.0, // vertical gap
    children: List.generate(8, (index) {
      return Chip(label: Text('Chip $index'));
    }),
  );
  print('Wrap with spacing=8 and runSpacing=12 created');

  // Test Wrap with alignment
  final centerWrap = Wrap(
    alignment: WrapAlignment.center,
    spacing: 8.0,
    children: List.generate(5, (index) {
      return Container(
        padding: EdgeInsets.all(12.0),
        color: Colors.green.shade200,
        child: Text('Center $index'),
      );
    }),
  );
  print('Wrap with alignment=center created');

  final endWrap = Wrap(
    alignment: WrapAlignment.end,
    spacing: 8.0,
    children: List.generate(5, (index) {
      return Container(
        padding: EdgeInsets.all(12.0),
        color: Colors.orange.shade200,
        child: Text('End $index'),
      );
    }),
  );
  print('Wrap with alignment=end created');

  final spaceAroundWrap = Wrap(
    alignment: WrapAlignment.spaceAround,
    spacing: 8.0,
    children: List.generate(4, (index) {
      return Container(
        padding: EdgeInsets.all(12.0),
        color: Colors.purple.shade200,
        child: Text('Around $index'),
      );
    }),
  );
  print('Wrap with alignment=spaceAround created');

  final spaceBetween = Wrap(
    alignment: WrapAlignment.spaceBetween,
    children: List.generate(3, (index) {
      return Container(
        padding: EdgeInsets.all(12.0),
        color: Colors.red.shade200,
        child: Text('Between $index'),
      );
    }),
  );
  print('Wrap with alignment=spaceBetween created');

  final spaceEvenly = Wrap(
    alignment: WrapAlignment.spaceEvenly,
    children: List.generate(3, (index) {
      return Container(
        padding: EdgeInsets.all(12.0),
        color: Colors.teal.shade200,
        child: Text('Evenly $index'),
      );
    }),
  );
  print('Wrap with alignment=spaceEvenly created');

  // Test Wrap with direction
  final horizontalWrap = Wrap(
    direction: Axis.horizontal,
    spacing: 8.0,
    runSpacing: 8.0,
    children: List.generate(6, (index) {
      return Container(
        padding: EdgeInsets.all(12.0),
        color: Colors.cyan.shade200,
        child: Text('H$index'),
      );
    }),
  );
  print('Wrap with direction=horizontal created');

  final verticalWrap = Wrap(
    direction: Axis.vertical,
    spacing: 8.0,
    runSpacing: 8.0,
    children: List.generate(6, (index) {
      return Container(
        padding: EdgeInsets.all(12.0),
        color: Colors.pink.shade200,
        child: Text('V$index'),
      );
    }),
  );
  print('Wrap with direction=vertical created');

  // Test Wrap with runAlignment
  final runAlignedWrap = Wrap(
    runAlignment: WrapAlignment.center,
    spacing: 8.0,
    runSpacing: 8.0,
    children: [
      Container(width: 60, height: 30, color: Colors.red),
      Container(width: 80, height: 40, color: Colors.green),
      Container(width: 100, height: 50, color: Colors.blue),
      Container(width: 70, height: 35, color: Colors.orange),
      Container(width: 90, height: 45, color: Colors.purple),
    ],
  );
  print('Wrap with runAlignment=center created');

  // Test Wrap with crossAxisAlignment
  final crossAlignedWrap = Wrap(
    crossAxisAlignment: WrapCrossAlignment.center,
    spacing: 8.0,
    children: [
      Container(width: 40, height: 20, color: Colors.red.shade300),
      Container(width: 40, height: 40, color: Colors.green.shade300),
      Container(width: 40, height: 60, color: Colors.blue.shade300),
      Container(width: 40, height: 30, color: Colors.orange.shade300),
    ],
  );
  print('Wrap with crossAxisAlignment=center created');

  final crossStartWrap = Wrap(
    crossAxisAlignment: WrapCrossAlignment.start,
    spacing: 8.0,
    children: [
      Container(width: 40, height: 20, color: Colors.red.shade400),
      Container(width: 40, height: 40, color: Colors.green.shade400),
      Container(width: 40, height: 60, color: Colors.blue.shade400),
    ],
  );
  print('Wrap with crossAxisAlignment=start created');

  final crossEndWrap = Wrap(
    crossAxisAlignment: WrapCrossAlignment.end,
    spacing: 8.0,
    children: [
      Container(width: 40, height: 20, color: Colors.red.shade500),
      Container(width: 40, height: 40, color: Colors.green.shade500),
      Container(width: 40, height: 60, color: Colors.blue.shade500),
    ],
  );
  print('Wrap with crossAxisAlignment=end created');

  // Test Wrap with textDirection
  final rtlWrap = Wrap(
    textDirection: TextDirection.rtl,
    spacing: 8.0,
    children: List.generate(5, (index) {
      return Container(
        padding: EdgeInsets.all(8.0),
        color: Colors.amber.shade200,
        child: Text('RTL $index'),
      );
    }),
  );
  print('Wrap with textDirection=rtl created');

  // Test Wrap with verticalDirection
  final upWrap = Wrap(
    verticalDirection: VerticalDirection.up,
    direction: Axis.vertical,
    spacing: 8.0,
    children: List.generate(3, (index) {
      return Container(
        padding: EdgeInsets.all(8.0),
        color: Colors.indigo.shade200,
        child: Text('Up $index'),
      );
    }),
  );
  print('Wrap with verticalDirection=up created');

  // Test Wrap with Chips
  final chipWrap = Wrap(
    spacing: 8.0,
    runSpacing: 4.0,
    children: [
      Chip(label: Text('Flutter')),
      Chip(label: Text('Dart')),
      Chip(label: Text('Mobile')),
      Chip(label: Text('Web')),
      Chip(label: Text('Desktop')),
      Chip(label: Text('Embedded')),
      ActionChip(label: Text('Action'), onPressed: () {}),
      FilterChip(label: Text('Filter'), selected: true, onSelected: (_) {}),
    ],
  );
  print('Wrap with various Chip types created');

  print('Wrap test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Wrap Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text('Basic Wrap:', style: TextStyle(fontWeight: FontWeight.bold)),
        basicWrap,
        SizedBox(height: 16.0),

        Text(
          'Wrap with Spacing:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        spacedWrap,
        SizedBox(height: 16.0),

        Text(
          'WrapAlignment.center:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerWrap,
        SizedBox(height: 16.0),

        Text(
          'WrapAlignment.end:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        endWrap,
        SizedBox(height: 16.0),

        Text(
          'WrapAlignment.spaceAround:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        spaceAroundWrap,
        SizedBox(height: 16.0),

        Text(
          'CrossAxisAlignment:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text('start', style: TextStyle(fontSize: 10)),
                  crossStartWrap,
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text('center', style: TextStyle(fontSize: 10)),
                  crossAlignedWrap,
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text('end', style: TextStyle(fontSize: 10)),
                  crossEndWrap,
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),

        Text('Wrap with Chips:', style: TextStyle(fontWeight: FontWeight.bold)),
        chipWrap,
        SizedBox(height: 16.0),

        Text(
          'Vertical Direction:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(height: 120.0, child: verticalWrap),
      ],
    ),
  );
}
