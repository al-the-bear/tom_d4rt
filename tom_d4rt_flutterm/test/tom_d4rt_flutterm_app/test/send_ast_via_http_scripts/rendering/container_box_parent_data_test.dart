// D4rt test script: Tests ContainerBoxParentData from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ContainerBoxParentData test executing');
  final results = <String>[];

  // ========== Section 1: Basic Construction ==========
  print('--- Section 1: Basic Construction ---');

  // ContainerBoxParentData combines BoxParentData with ContainerParentDataMixin
  final parentData = ContainerBoxParentData<RenderBox>();
  print('Created ContainerBoxParentData');
  print('Initial offset: ${parentData.offset}');
  results.add('Initial offset: ${parentData.offset}');

  // ========== Section 2: Offset Property ==========
  print('--- Section 2: Offset Property ---');

  // Set offset
  parentData.offset = Offset(100, 50);
  print('Set offset to: ${parentData.offset}');
  results.add('Set offset: ${parentData.offset}');

  // Modify offset
  parentData.offset = Offset(200, 150);
  print('Modified offset: ${parentData.offset}');
  results.add('Modified offset: ${parentData.offset}');

  // ========== Section 3: Previous/Next Sibling ==========
  print('--- Section 3: Previous/Next Sibling ---');

  // These are from ContainerParentDataMixin
  // Note: previousSibling and nextSibling are set by the container
  print('previousSibling: ${parentData.previousSibling}');
  print('nextSibling: ${parentData.nextSibling}');
  results.add(
    'Siblings: prev=${parentData.previousSibling}, next=${parentData.nextSibling}',
  );

  // ========== Section 4: Multiple Parent Data Instances ==========
  print('--- Section 4: Multiple Parent Data Instances ---');

  final data1 = ContainerBoxParentData<RenderBox>();
  final data2 = ContainerBoxParentData<RenderBox>();
  final data3 = ContainerBoxParentData<RenderBox>();

  data1.offset = Offset(0, 0);
  data2.offset = Offset(100, 0);
  data3.offset = Offset(200, 0);

  print('Data 1 offset: ${data1.offset}');
  print('Data 2 offset: ${data2.offset}');
  print('Data 3 offset: ${data3.offset}');
  results.add(
    'Multiple: d1=${data1.offset}, d2=${data2.offset}, d3=${data3.offset}',
  );

  // ========== Section 5: Zero Offset ==========
  print('--- Section 5: Zero Offset ---');

  final zeroData = ContainerBoxParentData<RenderBox>();
  zeroData.offset = Offset.zero;
  print('Zero offset: ${zeroData.offset}');
  print('Is zero: ${zeroData.offset == Offset.zero}');
  results.add('Zero offset: ${zeroData.offset == Offset.zero}');

  // ========== Section 6: Negative Offset ==========
  print('--- Section 6: Negative Offset ---');

  final negData = ContainerBoxParentData<RenderBox>();
  negData.offset = Offset(-50, -30);
  print('Negative offset: ${negData.offset}');
  print('dx: ${negData.offset.dx}, dy: ${negData.offset.dy}');
  results.add('Negative: dx=${negData.offset.dx}, dy=${negData.offset.dy}');

  // ========== Section 7: Large Offset ==========
  print('--- Section 7: Large Offset ---');

  final largeData = ContainerBoxParentData<RenderBox>();
  largeData.offset = Offset(10000, 5000);
  print('Large offset: ${largeData.offset}');
  results.add('Large offset: ${largeData.offset}');

  // ========== Section 8: Fractional Offset ==========
  print('--- Section 8: Fractional Offset ---');

  final fracData = ContainerBoxParentData<RenderBox>();
  fracData.offset = Offset(10.5, 20.75);
  print('Fractional offset: ${fracData.offset}');
  results.add('Fractional: ${fracData.offset}');

  // ========== Section 9: ToString ==========
  print('--- Section 9: ToString ---');

  final strData = ContainerBoxParentData<RenderBox>();
  strData.offset = Offset(42, 24);
  final str = strData.toString();
  print('ToString: $str');
  results.add('HasToString: ${str.isNotEmpty}');

  // ========== Section 10: Type Parameters ==========
  print('--- Section 10: Type Parameters ---');

  // ContainerBoxParentData is generic over ChildType
  // This demonstrates type safety
  final typedData = ContainerBoxParentData<RenderBox>();
  print('Created typed ContainerBoxParentData<RenderBox>');

  // Runtime type check
  print('Type check: ${typedData is BoxParentData}');
  print('Is ContainerBoxParentData: ${typedData is ContainerBoxParentData}');
  results.add('Type check: isBoxParentData=${typedData is BoxParentData}');

  print('ContainerBoxParentData test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'ContainerBoxParentData Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ...results.map(
            (r) => Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text('✓ $r', style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
    ),
  );
}
