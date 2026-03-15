// D4rt test script: Tests SliverPhysicalParentData from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverPhysicalParentData test executing');
  final results = <String>[];

  // ========== Section 1: Basic Creation ==========
  print('--- Section 1: Basic SliverPhysicalParentData Creation ---');

  final parentData1 = SliverPhysicalParentData();
  print('Created SliverPhysicalParentData: ${parentData1.runtimeType}');
  print('Type check: ${parentData1 is SliverPhysicalParentData}');
  print('Is ParentData: ${parentData1 is ParentData}');
  results.add('Basic creation successful');

  // ========== Section 2: Paint Offset Property ==========
  print('--- Section 2: Paint Offset Property ---');

  final parentData2 = SliverPhysicalParentData();
  print('Initial paintOffset: ${parentData2.paintOffset}');

  parentData2.paintOffset = Offset(100.0, 50.0);
  print('After setting to (100, 50): ${parentData2.paintOffset}');

  parentData2.paintOffset = Offset(0.0, 0.0);
  print('After setting to (0, 0): ${parentData2.paintOffset}');

  parentData2.paintOffset = Offset(200.5, 150.5);
  print('After setting to (200.5, 150.5): ${parentData2.paintOffset}');
  results.add('Paint offset tested');

  // ========== Section 3: Offset Zero ==========
  print('--- Section 3: Offset Zero ---');

  final parentData3 = SliverPhysicalParentData();
  parentData3.paintOffset = Offset.zero;
  print('Offset.zero: ${parentData3.paintOffset}');
  print('Is zero: ${parentData3.paintOffset == Offset.zero}');
  results.add('Offset.zero tested');

  // ========== Section 4: Various Paint Offsets ==========
  print('--- Section 4: Various Paint Offsets ---');

  final offsets = [
    Offset(0, 0),
    Offset(10, 20),
    Offset(50, 100),
    Offset(100, 200),
    Offset(250, 500),
    Offset(500, 1000),
  ];
  for (final offset in offsets) {
    final pd = SliverPhysicalParentData();
    pd.paintOffset = offset;
    print(
      'Paint offset $offset: dx=${pd.paintOffset.dx}, dy=${pd.paintOffset.dy}',
    );
  }
  results.add('Tested ${offsets.length} paint offsets');

  // ========== Section 5: Negative Offsets ==========
  print('--- Section 5: Negative Offsets ---');

  final negativeOffsets = [
    Offset(-10, -20),
    Offset(-50, 0),
    Offset(0, -100),
    Offset(-200, -150),
  ];
  for (final offset in negativeOffsets) {
    final pd = SliverPhysicalParentData();
    pd.paintOffset = offset;
    print('Negative offset $offset: ${pd.paintOffset}');
  }
  results.add('Tested ${negativeOffsets.length} negative offsets');

  // ========== Section 6: Multiple Instances ==========
  print('--- Section 6: Multiple Instances ---');

  final instances = <SliverPhysicalParentData>[];
  for (int i = 0; i < 5; i++) {
    final pd = SliverPhysicalParentData();
    pd.paintOffset = Offset(i * 50.0, i * 25.0);
    instances.add(pd);
    print('Instance $i paintOffset: ${pd.paintOffset}');
  }
  print('Created ${instances.length} instances');
  results.add('Created ${instances.length} instances');

  // ========== Section 7: Inheritance Chain ==========
  print('--- Section 7: Inheritance Chain ---');

  final parentData4 = SliverPhysicalParentData();
  print('Is ParentData: ${parentData4 is ParentData}');
  print(
    'Is SliverPhysicalParentData: ${parentData4 is SliverPhysicalParentData}',
  );
  print('Runtime type: ${parentData4.runtimeType}');
  results.add('Inheritance chain verified');

  // ========== Section 8: Large Paint Offsets ==========
  print('--- Section 8: Large Paint Offsets ---');

  final largeOffsets = [
    Offset(10000, 5000),
    Offset(50000, 25000),
    Offset(100000, 50000),
    Offset(1000000, 500000),
  ];
  for (final offset in largeOffsets) {
    final pd = SliverPhysicalParentData();
    pd.paintOffset = offset;
    print('Large offset dx: ${pd.paintOffset.dx}, dy: ${pd.paintOffset.dy}');
  }
  results.add('Tested ${largeOffsets.length} large offsets');

  // ========== Section 9: Fractional Offsets ==========
  print('--- Section 9: Fractional Offsets ---');

  final fractionalOffsets = [
    Offset(0.1, 0.2),
    Offset(1.5, 2.5),
    Offset(10.123, 20.456),
    Offset(100.999, 200.001),
  ];
  for (final offset in fractionalOffsets) {
    final pd = SliverPhysicalParentData();
    pd.paintOffset = offset;
    print('Fractional offset: ${pd.paintOffset}');
  }
  results.add('Tested ${fractionalOffsets.length} fractional offsets');

  // ========== Section 10: Offset Distance and Direction ==========
  print('--- Section 10: Offset Distance and Direction ---');

  final parentData5 = SliverPhysicalParentData();
  parentData5.paintOffset = Offset(100.0, 100.0);
  print('Offset (100, 100) distance: ${parentData5.paintOffset.distance}');
  print('Offset (100, 100) direction: ${parentData5.paintOffset.direction}');
  print(
    'Offset (100, 100) distanceSquared: ${parentData5.paintOffset.distanceSquared}',
  );
  results.add('Distance and direction tested');

  // ========== Section 11: toString Method ==========
  print('--- Section 11: toString Method ---');

  final parentData6 = SliverPhysicalParentData();
  parentData6.paintOffset = Offset(75.0, 125.0);
  print('toString: ${parentData6.toString()}');
  results.add('toString tested');

  print('SliverPhysicalParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverPhysicalParentData Tests'),
      Text('Results: ${results.length} sections'),
      ...results.map((r) => Text(r)),
    ],
  );
}
