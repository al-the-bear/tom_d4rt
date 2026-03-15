// D4rt test script: Tests MultiChildLayoutParentData from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

enum LayoutId { header, content, footer }

dynamic build(BuildContext context) {
  print('MultiChildLayoutParentData test executing');

  // ========== Basic MultiChildLayoutParentData creation ==========
  print('--- Basic MultiChildLayoutParentData ---');
  final pd1 = MultiChildLayoutParentData();
  print('  created: ${pd1.runtimeType}');

  // ========== id property ==========
  print('--- id property ---');
  final pdId1 = MultiChildLayoutParentData();
  pdId1.id = 'header';
  print('  id = "header": ${pdId1.id}');
  
  final pdId2 = MultiChildLayoutParentData();
  pdId2.id = 'body';
  print('  id = "body": ${pdId2.id}');
  
  final pdId3 = MultiChildLayoutParentData();
  pdId3.id = 'footer';
  print('  id = "footer": ${pdId3.id}');
  
  final pdId4 = MultiChildLayoutParentData();
  pdId4.id = 1;
  print('  id = 1 (int): ${pdId4.id}');
  
  final pdId5 = MultiChildLayoutParentData();
  pdId5.id = 'sidebar';
  print('  id = "sidebar": ${pdId5.id}');

  // ========== Different id types ==========
  print('--- Different id types ---');
  final pdString = MultiChildLayoutParentData()..id = 'stringId';
  print('  String id: ${pdString.id}');
  
  final pdInt = MultiChildLayoutParentData()..id = 42;
  print('  int id: ${pdInt.id}');
  final pdEnum = MultiChildLayoutParentData()..id = LayoutId.header;
  print('  enum id: ${pdEnum.id}');

  // ========== offset property (inherited) ==========
  print('--- offset property ---');
  final pdOffset1 = MultiChildLayoutParentData();
  pdOffset1.id = 'offsetTest1';
  pdOffset1.offset = Offset(10.0, 20.0);
  print('  offset (10, 20): ${pdOffset1.offset}');
  
  final pdOffset2 = MultiChildLayoutParentData();
  pdOffset2.id = 'offsetTest2';
  pdOffset2.offset = Offset(100.0, 200.0);
  print('  offset (100, 200): ${pdOffset2.offset}');
  
  final pdOffset3 = MultiChildLayoutParentData();
  pdOffset3.id = 'offsetTest3';
  pdOffset3.offset = Offset.zero;
  print('  offset (0, 0): ${pdOffset3.offset}');

  // ========== Combined id and offset ==========
  print('--- Combined id and offset ---');
  final combined1 = MultiChildLayoutParentData();
  combined1.id = 'topLeft';
  combined1.offset = Offset(0.0, 0.0);
  print('  topLeft at ${combined1.offset}');
  
  final combined2 = MultiChildLayoutParentData();
  combined2.id = 'center';
  combined2.offset = Offset(100.0, 100.0);
  print('  center at ${combined2.offset}');
  
  final combined3 = MultiChildLayoutParentData();
  combined3.id = 'bottomRight';
  combined3.offset = Offset(200.0, 200.0);
  print('  bottomRight at ${combined3.offset}');

  // ========== Multiple parent data instances ==========
  print('--- Multiple instances ---');
  final ids = ['top', 'middle', 'bottom', 'left', 'right'];
  final dataList = ids.map((id) {
    final pd = MultiChildLayoutParentData();
    pd.id = id;
    pd.offset = Offset(ids.indexOf(id) * 50.0, ids.indexOf(id) * 30.0);
    return pd;
  }).toList();
  for (final pd in dataList) {
    print('  id: ${pd.id}, offset: ${pd.offset}');
  }

  // ========== Inheritance check ==========
  print('--- Inheritance check ---');
  print('  is ContainerBoxParentData: ${pd1 is ContainerBoxParentData}');
  print('  is BoxParentData: ${pd1 is BoxParentData}');
  print('  is ParentData: ${pd1 is ParentData}');

  // ========== RuntimeType checks ==========
  print('--- RuntimeType checks ---');
  print('  pd1.runtimeType: ${pd1.runtimeType}');
  print('  pdId1.runtimeType: ${pdId1.runtimeType}');

  // ========== toString ==========
  print('--- toString ---');
  print('  pdId1.toString(): ${pdId1.toString()}');
  print('  combined1.toString(): ${combined1.toString()}');

  print('MultiChildLayoutParentData test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('MultiChildLayoutParentData Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('Type: ${pd1.runtimeType}'),
          Text('Properties: id, offset'),
          SizedBox(height: 8.0),
          Text('Sample IDs:'),
          Text('  header: ${pdId1.id}'),
          Text('  body: ${pdId2.id}'),
          Text('  footer: ${pdId3.id}'),
          Text('  int id: ${pdId4.id}'),
          SizedBox(height: 8.0),
          Text('Combined examples:'),
          Text('  ${combined1.id} at ${combined1.offset}'),
          Text('  ${combined2.id} at ${combined2.offset}'),
          Text('  ${combined3.id} at ${combined3.offset}'),
          SizedBox(height: 8.0),
          Text('Inheritance: ContainerBoxParentData > BoxParentData'),
        ],
      ),
    ),
  );
}
