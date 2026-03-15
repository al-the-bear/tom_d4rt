// D4rt test script: Tests DataTable, DataRow, DataCell, DataColumn,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// PaginatedDataTable, DataTableSource, DataTableThemeData, SortColumnOrder
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DataTable test executing');

  // ========== DataColumn ==========
  print('--- DataColumn Tests ---');
  final col1 = DataColumn(
    label: Text('Name'),
    numeric: false,
    tooltip: 'Full name',
  );
  print('DataColumn created: numeric=${col1.numeric}');

  final col2 = DataColumn(label: Text('Age'), numeric: true);
  print('DataColumn numeric created');

  final col3 = DataColumn(
    label: Text('Role'),
    onSort: (columnIndex, ascending) {
      print('  Sorting column $columnIndex ascending=$ascending');
    },
  );
  print('DataColumn with onSort created');

  // ========== DataRow ==========
  print('--- DataRow Tests ---');
  final row1 = DataRow(
    cells: [
      DataCell(Text('Alice')),
      DataCell(Text('30')),
      DataCell(Text('Engineer')),
    ],
    selected: false,
    onSelectChanged: (selected) => print('  Row selected: $selected'),
  );
  print('DataRow created: selected=${row1.selected}');

  final row2 = DataRow(
    cells: [
      DataCell(Text('Bob'), showEditIcon: true),
      DataCell(Text('25'), placeholder: true),
      DataCell(
        Text('Designer'),
        onTap: () => print('  Cell tapped'),
        onLongPress: () => print('  Cell long pressed'),
        onDoubleTap: () => print('  Cell double tapped'),
      ),
    ],
    color: WidgetStateProperty.resolveWith<Color?>(
      (states) =>
          states.contains(WidgetState.selected) ? Colors.blue[100] : null,
    ),
  );
  print('DataRow with DataCell options created');

  // ========== DataCell ==========
  print('--- DataCell Tests ---');
  final cell = DataCell(
    Text('Content'),
    showEditIcon: true,
    placeholder: false,
    onTap: () {},
  );
  print('DataCell created: showEditIcon=${cell.showEditIcon}');
  print('  DataCell.empty: ${DataCell.empty}');

  // ========== DataTable ==========
  print('--- DataTable Tests ---');
  final dataTable = DataTable(
    columns: [col1, col2, col3],
    rows: [row1, row2],
    sortColumnIndex: 0,
    sortAscending: true,
    showCheckboxColumn: true,
    showBottomBorder: true,
    headingRowHeight: 56.0,
    dataRowMinHeight: 48.0,
    dataRowMaxHeight: 56.0,
    horizontalMargin: 24.0,
    columnSpacing: 56.0,
    dividerThickness: 1.0,
    headingRowColor: WidgetStateProperty.all(Colors.grey[200]),
    headingTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    dataTextStyle: TextStyle(color: Colors.black87),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
    checkboxHorizontalMargin: 12.0,
    border: TableBorder.all(color: Colors.grey[300]!),
  );
  print('DataTable created');

  // ========== DataTableThemeData ==========
  print('--- DataTableThemeData Tests ---');
  final dtTheme = DataTableThemeData(
    headingRowHeight: 60.0,
    dataRowMinHeight: 50.0,
    dataRowMaxHeight: 60.0,
    horizontalMargin: 24.0,
    columnSpacing: 56.0,
    dividerThickness: 1.0,
    headingRowColor: WidgetStateProperty.all(Colors.blue[50]),
    headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
    dataTextStyle: TextStyle(fontSize: 14),
  );
  print('DataTableThemeData created');
  print('  headingRowHeight: ${dtTheme.headingRowHeight}');

  // ========== PaginatedDataTable concepts ==========
  print('--- PaginatedDataTable Tests ---');
  final paginatedTable = PaginatedDataTable(
    header: Text('Employees'),
    columns: [col1, col2, col3],
    source: TestDataSource(),
    rowsPerPage: 5,
    availableRowsPerPage: [5, 10, 20],
    onPageChanged: (page) => print('  Page: $page'),
    sortColumnIndex: 0,
    sortAscending: true,
    showCheckboxColumn: true,
    showFirstLastButtons: true,
    initialFirstRowIndex: 0,
  );
  print('PaginatedDataTable created');

  print('All data table tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [dataTable, SizedBox(height: 16), paginatedTable],
        ),
      ),
    ),
  );
}

class TestDataSource extends DataTableSource {
  final _data = List.generate(50, (i) => ['User $i', '${20 + i}', 'Role $i']);

  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) return null;
    final row = _data[index];
    return DataRow(
      cells: [
        DataCell(Text(row[0])),
        DataCell(Text(row[1])),
        DataCell(Text(row[2])),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
