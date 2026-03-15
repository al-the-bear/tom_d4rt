// D4rt test script: Tests ListWheelParentData from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ListWheelParentData test executing');

  // ========== Basic ListWheelParentData creation ==========
  print('--- Basic ListWheelParentData ---');
  final parentData1 = ListWheelParentData();
  print('  created: ${parentData1.runtimeType}');

  // ========== index property ==========
  print('--- index property ---');
  final pd1 = ListWheelParentData();
  pd1.index = 0;
  print('  index = 0: ${pd1.index}');

  final pd2 = ListWheelParentData();
  pd2.index = 5;
  print('  index = 5: ${pd2.index}');

  final pd3 = ListWheelParentData();
  pd3.index = 10;
  print('  index = 10: ${pd3.index}');

  final pd4 = ListWheelParentData();
  pd4.index = 100;
  print('  index = 100: ${pd4.index}');

  // ========== negative index ==========
  print('--- negative index ---');
  final pdNeg = ListWheelParentData();
  pdNeg.index = -1;
  print('  index = -1: ${pdNeg.index}');

  // ========== offset property (inherited from ContainerBoxParentData) ==========
  print('--- offset property ---');
  final pdOffset1 = ListWheelParentData();
  pdOffset1.offset = Offset(10.0, 20.0);
  print('  offset (10, 20): ${pdOffset1.offset}');

  final pdOffset2 = ListWheelParentData();
  pdOffset2.offset = Offset(0.0, 0.0);
  print('  offset (0, 0): ${pdOffset2.offset}');

  final pdOffset3 = ListWheelParentData();
  pdOffset3.offset = Offset(100.0, 200.0);
  print('  offset (100, 200): ${pdOffset3.offset}');

  final pdOffset4 = ListWheelParentData();
  pdOffset4.offset = Offset(-50.0, -100.0);
  print('  offset (-50, -100): ${pdOffset4.offset}');

  // ========== Combined index and offset ==========
  print('--- Combined index and offset ---');
  final pdCombined = ListWheelParentData();
  pdCombined.index = 3;
  pdCombined.offset = Offset(50.0, 150.0);
  print('  index: ${pdCombined.index}, offset: ${pdCombined.offset}');

  // ========== Multiple instances ==========
  print('--- Multiple instances ---');
  final dataList = List.generate(5, (i) {
    final pd = ListWheelParentData();
    pd.index = i;
    pd.offset = Offset(i * 10.0, i * 20.0);
    return pd;
  });
  for (int i = 0; i < dataList.length; i++) {
    print(
      '  child $i: index=${dataList[i].index}, offset=${dataList[i].offset}',
    );
  }

  // ========== Is ContainerBoxParentData ==========
  print('--- Inheritance check ---');
  print(
    '  is ContainerBoxParentData: ${parentData1 is ContainerBoxParentData}',
  );
  print('  is ParentData: ${parentData1 is ParentData}');

  // ========== RuntimeType ==========
  print('--- RuntimeType ---');
  print('  runtimeType: ${parentData1.runtimeType}');

  // ========== Default values ==========
  print('--- Default values ---');
  final pdDefault = ListWheelParentData();
  print('  default index: ${pdDefault.index}');
  print('  default offset: ${pdDefault.offset}');

  print('ListWheelParentData test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'ListWheelParentData Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Type: ${parentData1.runtimeType}'),
          Text('Properties: index, offset'),
          SizedBox(height: 8.0),
          Text('Sample values:'),
          Text('  index=0: ${pd1.index}'),
          Text('  index=5: ${pd2.index}'),
          Text('  index=10: ${pd3.index}'),
          SizedBox(height: 8.0),
          Text('Offset examples:'),
          Text('  offset: ${pdOffset1.offset}'),
          Text('  offset: ${pdOffset2.offset}'),
          Text('  offset: ${pdOffset3.offset}'),
          SizedBox(height: 8.0),
          Text('Combined: index=${pdCombined.index}, ${pdCombined.offset}'),
        ],
      ),
    ),
  );
}
