// D4rt test script: Tests ListBodyParentData from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ListBodyParentData test executing');

  // ========== Basic ListBodyParentData creation ==========
  print('--- Basic ListBodyParentData ---');
  final parentData1 = ListBodyParentData();
  print('  created: ${parentData1.runtimeType}');
  print('  extent (initial): unset');

  // ========== ParentData inheritance ==========
  print('--- ParentData inheritance ---');
  print('  ListBodyParentData extends ContainerBoxParentData');
  print('  parentData1 is ParentData: ${parentData1 is ParentData}');
  print('  parentData1 is BoxParentData: ${parentData1 is BoxParentData}');
  print(
    '  parentData1 is ContainerBoxParentData: ${parentData1 is ContainerBoxParentData}',
  );

  // ========== BoxParentData properties ==========
  print('--- BoxParentData properties ---');
  final parentData2 = ListBodyParentData();
  parentData2.offset = Offset(10.0, 20.0);
  print('  offset set: ${parentData2.offset}');

  parentData2.offset = Offset(50.0, 100.0);
  print('  offset modified: ${parentData2.offset}');

  parentData2.offset = Offset.zero;
  print('  offset cleared: ${parentData2.offset}');

  // ========== ContainerBoxParentData properties ==========
  print('--- ContainerBoxParentData properties ---');
  final containerData = ListBodyParentData();
  print('  previousSibling: ${containerData.previousSibling}');
  print('  nextSibling: ${containerData.nextSibling}');

  // ========== Multiple instances ==========
  print('--- Multiple instances ---');
  final dataA = ListBodyParentData();
  final dataB = ListBodyParentData();
  final dataC = ListBodyParentData();
  dataA.offset = Offset(0.0, 0.0);
  dataB.offset = Offset(0.0, 50.0);
  dataC.offset = Offset(0.0, 100.0);
  print('  dataA offset: ${dataA.offset}');
  print('  dataB offset: ${dataB.offset}');
  print('  dataC offset: ${dataC.offset}');

  // ========== Typical list body layout pattern ==========
  print('--- Typical list layout pattern ---');
  final items = <ListBodyParentData>[];
  double currentY = 0.0;
  for (int i = 0; i < 5; i++) {
    final itemData = ListBodyParentData();
    itemData.offset = Offset(0.0, currentY);
    items.add(itemData);
    currentY += 48.0; // typical list item height
  }
  print('  created ${items.length} list items');
  for (int i = 0; i < items.length; i++) {
    print('  item $i offset: ${items[i].offset}');
  }

  // ========== toString representation ==========
  print('--- toString representation ---');
  final toStringData = ListBodyParentData();
  toStringData.offset = Offset(15.0, 25.0);
  print('  toString: ${toStringData.toString()}');

  // ========== RuntimeType checks ==========
  print('--- RuntimeType checks ---');
  print('  parentData1.runtimeType: ${parentData1.runtimeType}');
  print('  dataA.runtimeType: ${dataA.runtimeType}');

  // ========== Comparing instances ==========
  print('--- Comparing instances ---');
  final compareA = ListBodyParentData();
  final compareB = ListBodyParentData();
  compareA.offset = Offset(10.0, 10.0);
  compareB.offset = Offset(10.0, 10.0);
  print('  compareA == compareB: ${compareA == compareB}');
  print(
    '  compareA.offset == compareB.offset: ${compareA.offset == compareB.offset}',
  );

  print('ListBodyParentData test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'ListBodyParentData Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Basic data: ${parentData1.runtimeType}'),
          Text('Offset: ${parentData2.offset}'),
          SizedBox(height: 8.0),
          Text('Inheritance:'),
          Text('  - extends ContainerBoxParentData'),
          Text('  - includes offset property'),
          Text('  - includes sibling links'),
          SizedBox(height: 8.0),
          Text('List layout (${items.length} items):'),
          ...items.asMap().entries.map(
            (e) => Text('  Item ${e.key}: y=${e.value.offset.dy}'),
          ),
        ],
      ),
    ),
  );
}
