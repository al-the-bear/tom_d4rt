// D4rt test script: Tests SliverLogicalContainerParentData from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverLogicalContainerParentData test executing');
  final results = <String>[];

  // ========== Section 1: Basic Creation ==========
  print('--- Section 1: Basic SliverLogicalContainerParentData Creation ---');

  final parentData1 = SliverLogicalContainerParentData();
  print('Created SliverLogicalContainerParentData: ${parentData1.runtimeType}');
  print('Type check: ${parentData1 is SliverLogicalContainerParentData}');
  print(
    'Is SliverLogicalParentData: ${parentData1 is SliverLogicalParentData}',
  );
  results.add('Basic creation successful');

  // ========== Section 2: Layout Offset Property ==========
  print('--- Section 2: Layout Offset Property ---');

  final parentData2 = SliverLogicalContainerParentData();
  print('Initial layoutOffset: ${parentData2.layoutOffset}');

  parentData2.layoutOffset = 100.0;
  print('After setting to 100.0: ${parentData2.layoutOffset}');

  parentData2.layoutOffset = 250.5;
  print('After setting to 250.5: ${parentData2.layoutOffset}');

  parentData2.layoutOffset = 0.0;
  print('After setting to 0.0: ${parentData2.layoutOffset}');
  results.add('Layout offset tested');

  // ========== Section 3: Various Layout Offsets ==========
  print('--- Section 3: Various Layout Offsets ---');

  final offsets = [0.0, 50.0, 100.0, 200.0, 500.0, 1000.0, 5000.0];
  for (final offset in offsets) {
    final pd = SliverLogicalContainerParentData();
    pd.layoutOffset = offset;
    print('Layout offset $offset: ${pd.layoutOffset}');
  }
  results.add('Tested ${offsets.length} layout offsets');

  // ========== Section 4: Null Layout Offset ==========
  print('--- Section 4: Null Layout Offset ---');

  final parentData3 = SliverLogicalContainerParentData();
  print('Default layoutOffset is null: ${parentData3.layoutOffset == null}');

  parentData3.layoutOffset = 100.0;
  print('After setting: ${parentData3.layoutOffset}');

  parentData3.layoutOffset = null;
  print('After setting to null: ${parentData3.layoutOffset}');
  results.add('Null layout offset tested');

  // ========== Section 5: Multiple Instances ==========
  print('--- Section 5: Multiple Instances ---');

  final instances = <SliverLogicalContainerParentData>[];
  for (int i = 0; i < 5; i++) {
    final pd = SliverLogicalContainerParentData();
    pd.layoutOffset = i * 100.0;
    instances.add(pd);
    print('Instance $i layoutOffset: ${pd.layoutOffset}');
  }
  print('Created ${instances.length} instances');
  results.add('Created ${instances.length} instances');

  // ========== Section 6: Inheritance Chain ==========
  print('--- Section 6: Inheritance Chain ---');

  final parentData4 = SliverLogicalContainerParentData();
  print('Is ParentData: ${parentData4 is ParentData}');
  print(
    'Is SliverLogicalParentData: ${parentData4 is SliverLogicalParentData}',
  );
  print(
    'Is SliverLogicalContainerParentData: ${parentData4 is SliverLogicalContainerParentData}',
  );
  print('Runtime type: ${parentData4.runtimeType}');
  results.add('Inheritance chain verified');

  // ========== Section 7: Large Layout Offsets ==========
  print('--- Section 7: Large Layout Offsets ---');

  final largeOffsets = [10000.0, 50000.0, 100000.0, 1000000.0];
  for (final offset in largeOffsets) {
    final pd = SliverLogicalContainerParentData();
    pd.layoutOffset = offset;
    print('Large offset $offset: ${pd.layoutOffset}');
  }
  results.add('Tested ${largeOffsets.length} large offsets');

  // ========== Section 8: Fractional Layout Offsets ==========
  print('--- Section 8: Fractional Layout Offsets ---');

  final fractionalOffsets = [0.1, 0.5, 1.5, 10.25, 100.333, 500.666];
  for (final offset in fractionalOffsets) {
    final pd = SliverLogicalContainerParentData();
    pd.layoutOffset = offset;
    print('Fractional offset $offset: ${pd.layoutOffset}');
  }
  results.add('Tested ${fractionalOffsets.length} fractional offsets');

  // ========== Section 9: toString Method ==========
  print('--- Section 9: toString Method ---');

  final parentData5 = SliverLogicalContainerParentData();
  parentData5.layoutOffset = 150.0;
  print('toString: ${parentData5.toString()}');
  results.add('toString tested');

  print('SliverLogicalContainerParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverLogicalContainerParentData Tests'),
      Text('Results: ${results.length} sections'),
      ...results.map((r) => Text(r)),
    ],
  );
}
