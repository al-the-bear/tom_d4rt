// D4rt test script: Tests TableCellParentData from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TableCellParentData test executing');
  final results = <String>[];

  // ========== Section 1: Basic Creation ==========
  print('--- Section 1: Basic TableCellParentData Creation ---');

  final parentData1 = TableCellParentData();
  print('Created TableCellParentData: ${parentData1.runtimeType}');
  print('Type check: ${parentData1 is TableCellParentData}');
  print('Is BoxParentData: ${parentData1 is BoxParentData}');
  results.add('Basic creation successful');

  // ========== Section 2: Vertical Alignment Property ==========
  print('--- Section 2: Vertical Alignment Property ---');

  final parentData2 = TableCellParentData();
  print('Initial verticalAlignment: ${parentData2.verticalAlignment}');

  parentData2.verticalAlignment = TableCellVerticalAlignment.top;
  print('After setting to top: ${parentData2.verticalAlignment}');

  parentData2.verticalAlignment = TableCellVerticalAlignment.middle;
  print('After setting to middle: ${parentData2.verticalAlignment}');

  parentData2.verticalAlignment = TableCellVerticalAlignment.bottom;
  print('After setting to bottom: ${parentData2.verticalAlignment}');

  parentData2.verticalAlignment = TableCellVerticalAlignment.baseline;
  print('After setting to baseline: ${parentData2.verticalAlignment}');

  parentData2.verticalAlignment = TableCellVerticalAlignment.fill;
  print('After setting to fill: ${parentData2.verticalAlignment}');
  results.add('Vertical alignment tested');

  // ========== Section 3: All TableCellVerticalAlignment Values ==========
  print('--- Section 3: All TableCellVerticalAlignment Values ---');

  for (final alignment in TableCellVerticalAlignment.values) {
    final pd = TableCellParentData();
    pd.verticalAlignment = alignment;
    print('Alignment ${alignment.name}: ${pd.verticalAlignment}');
  }
  print('Total alignments: ${TableCellVerticalAlignment.values.length}');
  results.add(
    'All ${TableCellVerticalAlignment.values.length} alignments tested',
  );

  // ========== Section 4: Offset Property (inherited from BoxParentData) ==========
  print('--- Section 4: Offset Property ---');

  final parentData3 = TableCellParentData();
  print('Initial offset: ${parentData3.offset}');

  parentData3.offset = Offset(100.0, 50.0);
  print('After setting to (100, 50): ${parentData3.offset}');

  parentData3.offset = Offset.zero;
  print('After setting to zero: ${parentData3.offset}');
  results.add('Offset property tested');

  // ========== Section 5: Combined Properties ==========
  print('--- Section 5: Combined Properties ---');

  final combined = TableCellParentData();
  combined.verticalAlignment = TableCellVerticalAlignment.middle;
  combined.offset = Offset(25.0, 50.0);
  print('Combined - verticalAlignment: ${combined.verticalAlignment}');
  print('Combined - offset: ${combined.offset}');
  results.add('Combined properties tested');

  // ========== Section 6: Multiple Instances ==========
  print('--- Section 6: Multiple Instances ---');

  final instances = <TableCellParentData>[];
  final alignments = TableCellVerticalAlignment.values;
  for (int i = 0; i < alignments.length; i++) {
    final pd = TableCellParentData();
    pd.verticalAlignment = alignments[i];
    pd.offset = Offset(i * 10.0, i * 20.0);
    instances.add(pd);
    print(
      'Instance $i - alignment: ${pd.verticalAlignment}, offset: ${pd.offset}',
    );
  }
  results.add('Created ${instances.length} instances');

  // ========== Section 7: Inheritance Chain ==========
  print('--- Section 7: Inheritance Chain ---');

  final parentData4 = TableCellParentData();
  print('Is ParentData: ${parentData4 is ParentData}');
  print('Is BoxParentData: ${parentData4 is BoxParentData}');
  print('Is TableCellParentData: ${parentData4 is TableCellParentData}');
  print('Runtime type: ${parentData4.runtimeType}');
  results.add('Inheritance chain verified');

  // ========== Section 8: Null Vertical Alignment ==========
  print('--- Section 8: Null Vertical Alignment ---');

  final parentData5 = TableCellParentData();
  print(
    'Default verticalAlignment is null: ${parentData5.verticalAlignment == null}',
  );

  parentData5.verticalAlignment = TableCellVerticalAlignment.top;
  print('After setting to top: ${parentData5.verticalAlignment}');

  parentData5.verticalAlignment = null;
  print('After setting to null: ${parentData5.verticalAlignment}');
  results.add('Null alignment tested');

  // ========== Section 9: Various Offsets ==========
  print('--- Section 9: Various Offsets ---');

  final offsets = [
    Offset(0, 0),
    Offset(10, 20),
    Offset(100, 200),
    Offset(-50, -100),
    Offset(1000, 500),
  ];
  for (final offset in offsets) {
    final pd = TableCellParentData();
    pd.offset = offset;
    print('Offset $offset: dx=${pd.offset.dx}, dy=${pd.offset.dy}');
  }
  results.add('Tested ${offsets.length} offsets');

  // ========== Section 10: toString Method ==========
  print('--- Section 10: toString Method ---');

  final parentData6 = TableCellParentData();
  parentData6.verticalAlignment = TableCellVerticalAlignment.middle;
  parentData6.offset = Offset(50.0, 100.0);
  print('toString: ${parentData6.toString()}');
  results.add('toString tested');

  print('TableCellParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TableCellParentData Tests'),
      Text('Results: ${results.length} sections'),
      ...results.map((r) => Text(r)),
    ],
  );
}
