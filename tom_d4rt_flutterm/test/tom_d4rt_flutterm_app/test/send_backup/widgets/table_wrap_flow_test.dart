// D4rt test script: Tests Table, TableRow, TableCell, TableBorder,
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// Wrap, Flow, FlowDelegate
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Table/Wrap/Flow test executing');

  // ========== TableBorder ==========
  print('--- TableBorder Tests ---');
  final tableBorder = TableBorder(
    top: BorderSide(color: Colors.black, width: 1.0),
    right: BorderSide(color: Colors.black, width: 1.0),
    bottom: BorderSide(color: Colors.black, width: 1.0),
    left: BorderSide(color: Colors.black, width: 1.0),
    horizontalInside: BorderSide(color: Colors.grey, width: 0.5),
    verticalInside: BorderSide(color: Colors.grey, width: 0.5),
  );
  print('TableBorder created');
  print('  isUniform: ${tableBorder.isUniform}');

  final tableBorderAll = TableBorder.all(color: Colors.red, width: 2.0);
  print('TableBorder.all created: isUniform=${tableBorderAll.isUniform}');

  final symmetricBorder = TableBorder.symmetric(
    inside: BorderSide(color: Colors.blue),
    outside: BorderSide(color: Colors.green, width: 2.0),
  );
  print('TableBorder.symmetric created');

  // ========== TableRow ==========
  print('--- TableRow Tests ---');
  final tableRow = TableRow(
    decoration: BoxDecoration(color: Colors.grey[200]),
    children: [Text('Cell 1'), Text('Cell 2'), Text('Cell 3')],
  );
  print('TableRow created with ${tableRow.children.length} cells');

  // ========== TableCell ==========
  print('--- TableCell Tests ---');
  final tableCell = TableCell(
    verticalAlignment: TableCellVerticalAlignment.middle,
    child: Text('Centered cell'),
  );
  print('TableCell created');
  print('  verticalAlignment: ${tableCell.verticalAlignment}');

  // TableCellVerticalAlignment values
  for (final align in TableCellVerticalAlignment.values) {
    print('  TableCellVerticalAlignment: $align');
  }

  // ========== Table ==========
  print('--- Table Tests ---');
  final table = Table(
    border: tableBorderAll,
    defaultColumnWidth: FlexColumnWidth(),
    columnWidths: {
      0: FixedColumnWidth(100),
      1: FlexColumnWidth(2),
      2: IntrinsicColumnWidth(),
    },
    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    children: [
      tableRow,
      TableRow(children: [Text('A'), Text('B'), Text('C')]),
    ],
  );
  print('Table created');

  // Column width types
  print('FixedColumnWidth: ${FixedColumnWidth(50)}');
  print('FlexColumnWidth: ${FlexColumnWidth(1.0)}');
  print('IntrinsicColumnWidth: ${IntrinsicColumnWidth()}');
  print('FractionColumnWidth: ${FractionColumnWidth(0.3)}');
  print(
    'MaxColumnWidth: ${MaxColumnWidth(FixedColumnWidth(50), FlexColumnWidth())}',
  );
  print(
    'MinColumnWidth: ${MinColumnWidth(FixedColumnWidth(50), FlexColumnWidth())}',
  );

  // ========== Wrap ==========
  print('--- Wrap Tests ---');
  final wrap = Wrap(
    spacing: 8.0,
    runSpacing: 4.0,
    alignment: WrapAlignment.start,
    runAlignment: WrapAlignment.center,
    crossAxisAlignment: WrapCrossAlignment.center,
    direction: Axis.horizontal,
    verticalDirection: VerticalDirection.down,
    children: [
      Chip(label: Text('A')),
      Chip(label: Text('B')),
      Chip(label: Text('C')),
    ],
  );
  print('Wrap created: spacing=${wrap.spacing}, runSpacing=${wrap.runSpacing}');

  for (final val in WrapAlignment.values) {
    print('  WrapAlignment: $val');
  }
  for (final val in WrapCrossAlignment.values) {
    print('  WrapCrossAlignment: $val');
  }

  // ========== Flow ==========
  print('--- Flow Tests ---');
  final flow = Flow(
    delegate: TestFlowDelegate(),
    children: [
      Container(width: 50, height: 50, color: Colors.red),
      Container(width: 50, height: 50, color: Colors.blue),
      Container(width: 50, height: 50, color: Colors.green),
    ],
  );
  print('Flow created with TestFlowDelegate');

  print('All table/wrap/flow tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            table,
            SizedBox(height: 16),
            wrap,
            SizedBox(height: 16),
            SizedBox(height: 100, child: flow),
          ],
        ),
      ),
    ),
  );
}

class TestFlowDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    double dx = 0;
    for (int i = 0; i < context.childCount; i++) {
      context.paintChild(i, transform: Matrix4.translationValues(dx, 0, 0));
      dx += 60;
    }
  }

  @override
  bool shouldRepaint(TestFlowDelegate oldDelegate) => false;

  @override
  Size getSize(BoxConstraints constraints) => Size(300, 50);
}
