// D4rt test script: Tests SliverMultiBoxAdaptorParentData from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverMultiBoxAdaptorParentData test executing');
  final results = <String>[];

  // ========== Section 1: Basic Creation ==========
  print('--- Section 1: Basic SliverMultiBoxAdaptorParentData Creation ---');

  final parentData1 = SliverMultiBoxAdaptorParentData();
  print('Created SliverMultiBoxAdaptorParentData: ${parentData1.runtimeType}');
  print('Type check: ${parentData1 is SliverMultiBoxAdaptorParentData}');
  results.add('Basic creation successful');

  // ========== Section 2: Index Property ==========
  print('--- Section 2: Index Property ---');

  final parentData2 = SliverMultiBoxAdaptorParentData();
  print('Initial index: ${parentData2.index}');

  parentData2.index = 0;
  print('After setting to 0: ${parentData2.index}');

  parentData2.index = 5;
  print('After setting to 5: ${parentData2.index}');

  parentData2.index = 100;
  print('After setting to 100: ${parentData2.index}');
  results.add('Index property tested');

  // ========== Section 3: KeepAlive Property ==========
  print('--- Section 3: KeepAlive Property ---');

  final parentData3 = SliverMultiBoxAdaptorParentData();
  print('Initial keepAlive: ${parentData3.keepAlive}');

  parentData3.keepAlive = true;
  print('After setting to true: ${parentData3.keepAlive}');

  parentData3.keepAlive = false;
  print('After setting to false: ${parentData3.keepAlive}');
  results.add('KeepAlive property tested');

  // ========== Section 4: Layout Offset Property ==========
  print('--- Section 4: Layout Offset Property ---');

  final parentData4 = SliverMultiBoxAdaptorParentData();
  print('Initial layoutOffset: ${parentData4.layoutOffset}');

  parentData4.layoutOffset = 100.0;
  print('After setting to 100.0: ${parentData4.layoutOffset}');

  parentData4.layoutOffset = 0.0;
  print('After setting to 0.0: ${parentData4.layoutOffset}');

  parentData4.layoutOffset = 500.5;
  print('After setting to 500.5: ${parentData4.layoutOffset}');
  results.add('Layout offset tested');

  // ========== Section 5: Multiple Indices ==========
  print('--- Section 5: Multiple Indices ---');

  final indices = [0, 1, 5, 10, 50, 100, 500, 1000];
  for (final idx in indices) {
    final pd = SliverMultiBoxAdaptorParentData();
    pd.index = idx;
    print('Index $idx: ${pd.index}');
  }
  results.add('Tested ${indices.length} indices');

  // ========== Section 6: Combined Properties ==========
  print('--- Section 6: Combined Properties ---');

  final combined = SliverMultiBoxAdaptorParentData();
  combined.index = 42;
  combined.keepAlive = true;
  combined.layoutOffset = 250.0;
  print('Combined - index: ${combined.index}');
  print('Combined - keepAlive: ${combined.keepAlive}');
  print('Combined - layoutOffset: ${combined.layoutOffset}');
  results.add('Combined properties: index=42, keepAlive=true');

  // ========== Section 7: Inheritance Chain ==========
  print('--- Section 7: Inheritance Chain ---');

  final parentData5 = SliverMultiBoxAdaptorParentData();
  print('Is ParentData: ${parentData5 is ParentData}');
  print(
    'Is SliverLogicalParentData: ${parentData5 is SliverLogicalParentData}',
  );
  print(
    'Is SliverMultiBoxAdaptorParentData: ${parentData5 is SliverMultiBoxAdaptorParentData}',
  );
  print('Runtime type: ${parentData5.runtimeType}');
  results.add('Inheritance chain verified');

  // ========== Section 8: Multiple Instances with Different States ==========
  print('--- Section 8: Multiple Instances with Different States ---');

  final instances = <SliverMultiBoxAdaptorParentData>[];
  for (int i = 0; i < 5; i++) {
    final pd = SliverMultiBoxAdaptorParentData();
    pd.index = i;
    pd.keepAlive = i % 2 == 0;
    pd.layoutOffset = i * 50.0;
    instances.add(pd);
    print(
      'Instance $i - index: ${pd.index}, keepAlive: ${pd.keepAlive}, offset: ${pd.layoutOffset}',
    );
  }
  results.add('Created ${instances.length} instances');

  // ========== Section 9: Null Index ==========
  print('--- Section 9: Null Index ---');

  final parentData6 = SliverMultiBoxAdaptorParentData();
  print('Default index is null: ${parentData6.index == null}');
  parentData6.index = 10;
  print('After setting to 10: ${parentData6.index}');
  parentData6.index = null;
  print('After setting to null: ${parentData6.index}');
  results.add('Null index tested');

  // ========== Section 10: toString Method ==========
  print('--- Section 10: toString Method ---');

  final parentData7 = SliverMultiBoxAdaptorParentData();
  parentData7.index = 3;
  parentData7.keepAlive = true;
  parentData7.layoutOffset = 100.0;
  print('toString: ${parentData7.toString()}');
  results.add('toString tested');

  print('SliverMultiBoxAdaptorParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverMultiBoxAdaptorParentData Tests'),
      Text('Results: ${results.length} sections'),
      ...results.map((r) => Text(r)),
    ],
  );
}
