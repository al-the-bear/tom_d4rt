// D4rt test script: Tests WrapParentData from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WrapParentData test executing');

  // ========== WrapParentData Basic Creation ==========
  print('--- WrapParentData Basic Creation ---');
  final parentData = WrapParentData();
  print('  created: ${parentData.runtimeType}');
  print('  type: WrapParentData');

  // ========== WrapParentData runIndex Property ==========
  print('--- WrapParentData runIndex Property ---');
  print('  initial runIndex: ${parentData.runIndex}');
  parentData.runIndex = 0;
  print('  runIndex = 0: ${parentData.runIndex}');
  parentData.runIndex = 1;
  print('  runIndex = 1: ${parentData.runIndex}');
  parentData.runIndex = 2;
  print('  runIndex = 2: ${parentData.runIndex}');
  parentData.runIndex = 5;
  print('  runIndex = 5: ${parentData.runIndex}');
  parentData.runIndex = 10;
  print('  runIndex = 10: ${parentData.runIndex}');

  // ========== WrapParentData Multiple Instances ==========
  print('--- WrapParentData Multiple Instances ---');
  final data1 = WrapParentData();
  final data2 = WrapParentData();
  final data3 = WrapParentData();
  final data4 = WrapParentData();

  data1.runIndex = 0;
  data2.runIndex = 0;
  data3.runIndex = 1;
  data4.runIndex = 1;

  print('  data1.runIndex: ${data1.runIndex}');
  print('  data2.runIndex: ${data2.runIndex}');
  print('  data3.runIndex: ${data3.runIndex}');
  print('  data4.runIndex: ${data4.runIndex}');

  // ========== WrapParentData Inheritance ==========
  print('--- WrapParentData Inheritance ---');
  // WrapParentData extends ContainerBoxParentData<RenderBox>
  print('  extends ContainerBoxParentData<RenderBox>: true');
  print(
    '  parentData is ContainerBoxParentData: ${parentData is ContainerBoxParentData}',
  );
  print('  parentData is BoxParentData: ${parentData is BoxParentData}');
  print('  parentData is ParentData: ${parentData is ParentData}');

  // ========== WrapParentData offset Property (inherited) ==========
  print('--- WrapParentData offset Property (inherited) ---');
  print('  initial offset: ${parentData.offset}');
  parentData.offset = Offset.zero;
  print('  offset = Offset.zero: ${parentData.offset}');
  parentData.offset = Offset(10.0, 20.0);
  print('  offset = Offset(10, 20): ${parentData.offset}');
  parentData.offset = Offset(50.5, 100.25);
  print('  offset = Offset(50.5, 100.25): ${parentData.offset}');
  parentData.offset = Offset(-10.0, -5.0);
  print('  offset = Offset(-10, -5): ${parentData.offset}');

  // ========== WrapParentData Simulated Row Layout ==========
  print('--- WrapParentData Simulated Row Layout ---');
  // Simulate items in a wrap layout with multiple rows
  final items = <WrapParentData>[];
  for (int i = 0; i < 6; i++) {
    final item = WrapParentData();
    item.runIndex = i ~/ 3; // 2 items per row
    item.offset = Offset((i % 3) * 100.0, (i ~/ 3) * 50.0);
    items.add(item);
    print('  item[$i]: runIndex=${item.runIndex}, offset=${item.offset}');
  }

  // ========== WrapParentData toString ==========
  print('--- WrapParentData toString ---');
  final toStringData = WrapParentData();
  toStringData.runIndex = 2;
  toStringData.offset = Offset(150.0, 100.0);
  print('  toString(): ${toStringData.toString()}');

  // ========== WrapParentData with Wrap Widget Context ==========
  print('--- WrapParentData with Wrap Widget Context ---');
  print('  WrapParentData is used with RenderWrap');
  print('  runIndex indicates which row/column the child is in');
  print('  offset is set by RenderWrap during layout');

  // ========== WrapParentData Edge Cases ==========
  print('--- WrapParentData Edge Cases ---');
  final edgeCase = WrapParentData();
  edgeCase.runIndex = 0;
  edgeCase.offset = Offset.zero;
  print(
    '  empty wrap (first item): runIndex=${edgeCase.runIndex}, offset=${edgeCase.offset}',
  );

  final largeRunIndex = WrapParentData();
  largeRunIndex.runIndex = 100;
  print('  large runIndex: ${largeRunIndex.runIndex}');

  final largeOffset = WrapParentData();
  largeOffset.offset = Offset(10000.0, 5000.0);
  print('  large offset: ${largeOffset.offset}');

  // ========== WrapParentData Container Properties ==========
  print('--- WrapParentData Container Properties ---');
  final containerData = WrapParentData();
  print('  nextSibling: ${containerData.nextSibling}');
  print('  previousSibling: ${containerData.previousSibling}');

  print('WrapParentData test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'WrapParentData Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Type: ${parentData.runtimeType}'),
          Text('Properties: runIndex, offset (inherited)'),
          Text('Extends ContainerBoxParentData<RenderBox>'),
          Text('Used with RenderWrap for layout'),
          Text('Multiple instances tested'),
          Text('Row layout simulation completed'),
        ],
      ),
    ),
  );
}
