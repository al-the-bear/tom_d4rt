// D4rt test script: Tests MinColumnWidth from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MinColumnWidth test executing');

  // ========== Basic MinColumnWidth creation ==========
  print('--- Basic MinColumnWidth ---');
  final width1 = MinColumnWidth(
    FixedColumnWidth(100.0),
    FractionColumnWidth(0.5),
  );
  print('  created: ${width1.runtimeType}');
  print('  combines FixedColumnWidth(100) and FractionColumnWidth(0.5)');

  // ========== Different column width combinations ==========
  print('--- Different combinations ---');

  final width2 = MinColumnWidth(
    FixedColumnWidth(50.0),
    FixedColumnWidth(100.0),
  );
  print('  MinColumnWidth(Fixed(50), Fixed(100))');
  print('    type: ${width2.runtimeType}');

  final width3 = MinColumnWidth(
    FractionColumnWidth(0.3),
    FractionColumnWidth(0.5),
  );
  print('  MinColumnWidth(Fraction(0.3), Fraction(0.5))');
  print('    type: ${width3.runtimeType}');

  final width4 = MinColumnWidth(
    IntrinsicColumnWidth(),
    FixedColumnWidth(150.0),
  );
  print('  MinColumnWidth(Intrinsic, Fixed(150))');
  print('    type: ${width4.runtimeType}');

  // ========== Nested MinColumnWidth ==========
  print('--- Nested MinColumnWidth ---');
  final nested = MinColumnWidth(
    MinColumnWidth(FixedColumnWidth(50.0), FixedColumnWidth(100.0)),
    FractionColumnWidth(0.25),
  );
  print('  nested MinColumnWidth: ${nested.runtimeType}');

  // ========== With FlexColumnWidth ==========
  print('--- With FlexColumnWidth ---');
  final flex1 = MinColumnWidth(FlexColumnWidth(1.0), FixedColumnWidth(80.0));
  print('  MinColumnWidth(Flex(1.0), Fixed(80))');
  print('    type: ${flex1.runtimeType}');

  final flex2 = MinColumnWidth(FlexColumnWidth(2.0), FlexColumnWidth(1.0));
  print('  MinColumnWidth(Flex(2.0), Flex(1.0))');
  print('    type: ${flex2.runtimeType}');

  // ========== TableColumnWidth interface ==========
  print('--- TableColumnWidth interface ---');
  print('  is TableColumnWidth: ${width1 is TableColumnWidth}');
  print('  is TableColumnWidth: ${width2 is TableColumnWidth}');

  // ========== toString representation ==========
  print('--- toString ---');
  print('  width1.toString(): ${width1.toString()}');
  print('  width2.toString(): ${width2.toString()}');

  // ========== Compare with MaxColumnWidth ==========
  print('--- Compare with MaxColumnWidth ---');
  final minWidth = MinColumnWidth(
    FixedColumnWidth(100.0),
    FixedColumnWidth(200.0),
  );
  final maxWidth = MaxColumnWidth(
    FixedColumnWidth(100.0),
    FixedColumnWidth(200.0),
  );
  print('  MinColumnWidth: ${minWidth.runtimeType}');
  print('  MaxColumnWidth: ${maxWidth.runtimeType}');
  print('  Min picks smaller, Max picks larger');

  // ========== RuntimeType checks ==========
  print('--- RuntimeType checks ---');
  print('  width1.runtimeType: ${width1.runtimeType}');
  print('  width2.runtimeType: ${width2.runtimeType}');
  print('  nested.runtimeType: ${nested.runtimeType}');

  print('MinColumnWidth test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'MinColumnWidth Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Type: ${width1.runtimeType}'),
          Text('Purpose: Returns minimum of two column widths'),
          SizedBox(height: 8.0),
          Text('Combination examples:'),
          Table(
            columnWidths: {
              0: MinColumnWidth(
                FixedColumnWidth(80.0),
                FractionColumnWidth(0.4),
              ),
              1: MinColumnWidth(
                FixedColumnWidth(120.0),
                FractionColumnWidth(0.6),
              ),
            },
            border: TableBorder.all(color: Color(0xFF9E9E9E)),
            children: [
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Min(80, 40%)'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Min(120, 60%)'),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Column A'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Column B'),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text('Nested: ${nested.runtimeType}'),
          Text('Compare: MinColumnWidth vs MaxColumnWidth'),
        ],
      ),
    ),
  );
}
