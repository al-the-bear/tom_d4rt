// D4rt test script: Tests FractionColumnWidth from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FractionColumnWidth test executing');

  // ========== Basic FractionColumnWidth creation ==========
  print('--- Basic FractionColumnWidth ---');
  final width1 = FractionColumnWidth(0.5);
  print('  created: ${width1.runtimeType}');
  print('  value (fraction): 0.5');

  // ========== Different fraction values ==========
  print('--- Different fraction values ---');
  final width10 = FractionColumnWidth(0.1);
  print('  FractionColumnWidth(0.1): ${width10.runtimeType}');

  final width25 = FractionColumnWidth(0.25);
  print('  FractionColumnWidth(0.25): ${width25.runtimeType}');

  final width33 = FractionColumnWidth(0.333);
  print('  FractionColumnWidth(0.333): ${width33.runtimeType}');

  final width75 = FractionColumnWidth(0.75);
  print('  FractionColumnWidth(0.75): ${width75.runtimeType}');

  final width100 = FractionColumnWidth(1.0);
  print('  FractionColumnWidth(1.0): ${width100.runtimeType}');

  // ========== TableColumnWidth interface ==========
  print('--- TableColumnWidth interface ---');
  print('  width1 is TableColumnWidth: ${width1 is TableColumnWidth}');
  print('  minIntrinsicWidth: depends on table constraints');
  print('  maxIntrinsicWidth: depends on table constraints');

  // ========== Comparing FractionColumnWidth instances ==========
  print('--- Comparing instances ---');
  final widthA = FractionColumnWidth(0.5);
  final widthB = FractionColumnWidth(0.5);
  final widthC = FractionColumnWidth(0.3);
  print('  widthA == widthB (same fraction): ${widthA == widthB}');
  print('  widthA == widthC (different fraction): ${widthA == widthC}');

  // ========== toString representation ==========
  print('--- toString representation ---');
  print('  width1.toString(): ${width1.toString()}');
  print('  width10.toString(): ${width10.toString()}');
  print('  width100.toString(): ${width100.toString()}');

  // ========== Using in Table widget ==========
  print('--- Use in Table widget ---');
  final tableColumnWidths = {
    0: FractionColumnWidth(0.3),
    1: FractionColumnWidth(0.5),
    2: FractionColumnWidth(0.2),
  };
  print('  column 0: FractionColumnWidth(0.3)');
  print('  column 1: FractionColumnWidth(0.5)');
  print('  column 2: FractionColumnWidth(0.2)');
  print('  total fraction: 1.0 (30% + 50% + 20%)');

  // ========== Edge cases ==========
  print('--- Edge cases ---');
  final widthZero = FractionColumnWidth(0.0);
  print('  FractionColumnWidth(0.0): ${widthZero.runtimeType}');

  final widthSmall = FractionColumnWidth(0.01);
  print('  FractionColumnWidth(0.01): ${widthSmall.runtimeType}');

  print('FractionColumnWidth test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'FractionColumnWidth Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Basic FractionColumnWidth: ${width1.runtimeType}'),
          Text('Fraction 0.5 for 50% width'),
          SizedBox(height: 8.0),
          Table(
            columnWidths: {
              0: FractionColumnWidth(0.3),
              1: FractionColumnWidth(0.4),
              2: FractionColumnWidth(0.3),
            },
            border: TableBorder.all(color: Color(0xFF9E9E9E)),
            children: [
              TableRow(
                children: [
                  Padding(padding: EdgeInsets.all(8.0), child: Text('30%')),
                  Padding(padding: EdgeInsets.all(8.0), child: Text('40%')),
                  Padding(padding: EdgeInsets.all(8.0), child: Text('30%')),
                ],
              ),
              TableRow(
                children: [
                  Padding(padding: EdgeInsets.all(8.0), child: Text('Col A')),
                  Padding(padding: EdgeInsets.all(8.0), child: Text('Col B')),
                  Padding(padding: EdgeInsets.all(8.0), child: Text('Col C')),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
