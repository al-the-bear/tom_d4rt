// D4rt test script: Tests TreeSliverNodeParentData from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TreeSliverNodeParentData test executing');

  // ========== TreeSliverNodeParentData Basic Creation ==========
  print('--- TreeSliverNodeParentData Basic Creation ---');
  final parentData = TreeSliverNodeParentData();
  print('  created: ${parentData.runtimeType}');

  // ========== TreeSliverNodeParentData depth Property ==========
  print('--- TreeSliverNodeParentData depth Property ---');
  print('  initial depth: ${parentData.depth}');
  parentData.depth = 0;
  print('  depth = 0: ${parentData.depth}');
  parentData.depth = 1;
  print('  depth = 1: ${parentData.depth}');
  parentData.depth = 2;
  print('  depth = 2: ${parentData.depth}');
  parentData.depth = 5;
  print('  depth = 5: ${parentData.depth}');
  parentData.depth = 10;
  print('  depth = 10: ${parentData.depth}');

  // ========== TreeSliverNodeParentData layoutOffset Property ==========
  print('--- TreeSliverNodeParentData layoutOffset Property ---');
  print('  initial layoutOffset: ${parentData.layoutOffset}');
  parentData.layoutOffset = 0.0;
  print('  layoutOffset = 0.0: ${parentData.layoutOffset}');
  parentData.layoutOffset = 50.0;
  print('  layoutOffset = 50.0: ${parentData.layoutOffset}');
  parentData.layoutOffset = 100.5;
  print('  layoutOffset = 100.5: ${parentData.layoutOffset}');
  parentData.layoutOffset = 250.75;
  print('  layoutOffset = 250.75: ${parentData.layoutOffset}');

  // ========== TreeSliverNodeParentData Multiple Instances ==========
  print('--- TreeSliverNodeParentData Multiple Instances ---');
  final data1 = TreeSliverNodeParentData();
  final data2 = TreeSliverNodeParentData();
  final data3 = TreeSliverNodeParentData();

  data1.depth = 0;
  data1.layoutOffset = 0.0;
  print('  data1: depth=${data1.depth}, layoutOffset=${data1.layoutOffset}');

  data2.depth = 1;
  data2.layoutOffset = 48.0;
  print('  data2: depth=${data2.depth}, layoutOffset=${data2.layoutOffset}');

  data3.depth = 2;
  data3.layoutOffset = 96.0;
  print('  data3: depth=${data3.depth}, layoutOffset=${data3.layoutOffset}');

  // ========== TreeSliverNodeParentData Inheritance ==========
  print('--- TreeSliverNodeParentData Inheritance ---');
  // TreeSliverNodeParentData extends SliverMultiBoxAdaptorParentData
  print('  extends SliverMultiBoxAdaptorParentData: true');
  print(
    '  parentData is SliverMultiBoxAdaptorParentData: ${parentData is SliverMultiBoxAdaptorParentData}',
  );
  print('  parentData is ParentData: ${parentData is ParentData}');

  // ========== TreeSliverNodeParentData Index Property ==========
  print('--- TreeSliverNodeParentData Index Property (inherited) ---');
  print('  initial index: ${parentData.index}');
  parentData.index = 0;
  print('  index = 0: ${parentData.index}');
  parentData.index = 5;
  print('  index = 5: ${parentData.index}');
  parentData.index = 100;
  print('  index = 100: ${parentData.index}');

  // ========== TreeSliverNodeParentData keepAlive Property ==========
  print('--- TreeSliverNodeParentData keepAlive Property (inherited) ---');
  print('  initial keepAlive: ${parentData.keepAlive}');
  parentData.keepAlive = true;
  print('  keepAlive = true: ${parentData.keepAlive}');
  parentData.keepAlive = false;
  print('  keepAlive = false: ${parentData.keepAlive}');

  // ========== TreeSliverNodeParentData toString ==========
  print('--- TreeSliverNodeParentData toString ---');
  final toStringData = TreeSliverNodeParentData();
  toStringData.depth = 3;
  toStringData.layoutOffset = 150.0;
  toStringData.index = 7;
  print('  toString(): ${toStringData.toString()}');

  // ========== TreeSliverNodeParentData Tree Structure Simulation ==========
  print('--- TreeSliverNodeParentData Tree Structure Simulation ---');
  final nodes = <TreeSliverNodeParentData>[];
  for (int i = 0; i < 5; i++) {
    final node = TreeSliverNodeParentData();
    node.depth = i ~/ 2;
    node.layoutOffset = i * 40.0;
    node.index = i;
    nodes.add(node);
    print(
      '  node[$i]: depth=${node.depth}, offset=${node.layoutOffset}, index=${node.index}',
    );
  }

  print('TreeSliverNodeParentData test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'TreeSliverNodeParentData Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Type: ${parentData.runtimeType}'),
          Text('Properties: depth, layoutOffset'),
          Text('Inherited: index, keepAlive'),
          Text('Extends SliverMultiBoxAdaptorParentData'),
          Text('Multiple instances tested'),
          Text('Tree structure simulation completed'),
        ],
      ),
    ),
  );
}
