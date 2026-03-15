// D4rt test script: Tests DataTable, DataColumn, DataRow, DataCell from material
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DataTable widgets test executing');

  // ========== DATACELL ==========
  print('--- DataCell Tests ---');

  // Test basic DataCell
  final basicCell = DataCell(Text('Cell'));
  print('Basic DataCell created');

  // Test DataCell with placeholder
  final placeholderCell = DataCell.empty;
  print('DataCell.empty created');

  // Test DataCell with onTap
  final tapCell = DataCell(
    Text('Tappable'),
    onTap: () {
      print('Cell tapped');
    },
  );
  print('DataCell with onTap created');

  // Test DataCell with onLongPress
  final longPressCell = DataCell(
    Text('Long Press'),
    onLongPress: () {
      print('Cell long pressed');
    },
  );
  print('DataCell with onLongPress created');

  // Test DataCell with onDoubleTap
  final doubleTapCell = DataCell(
    Text('Double Tap'),
    onDoubleTap: () {
      print('Cell double tapped');
    },
  );
  print('DataCell with onDoubleTap created');

  // Test DataCell with onTapDown
  final tapDownCell = DataCell(
    Text('Tap Down'),
    onTapDown: (TapDownDetails details) {
      print('Cell tap down: ${details.globalPosition}');
    },
  );
  print('DataCell with onTapDown created');

  // Test DataCell with onTapCancel
  final tapCancelCell = DataCell(
    Text('Tap Cancel'),
    onTapCancel: () {
      print('Cell tap cancelled');
    },
  );
  print('DataCell with onTapCancel created');

  // Test DataCell with showEditIcon
  final editIconCell = DataCell(
    Text('Editable'),
    showEditIcon: true,
    onTap: () {
      print('Edit cell');
    },
  );
  print('DataCell with showEditIcon created');

  // Test DataCell with placeholder
  final placeholderTextCell = DataCell(
    Text('N/A', style: TextStyle(color: Colors.grey)),
    placeholder: true,
  );
  print('DataCell with placeholder=true created');

  // ========== DATACOLUMN ==========
  print('--- DataColumn Tests ---');

  // Test basic DataColumn
  final basicColumn = DataColumn(label: Text('Name'));
  print('Basic DataColumn created');

  // Test DataColumn with numeric
  final numericColumn = DataColumn(label: Text('Amount'), numeric: true);
  print('DataColumn with numeric=true created');

  // Test DataColumn with tooltip
  final tooltipColumn = DataColumn(
    label: Text('Info'),
    tooltip: 'Additional information',
  );
  print('DataColumn with tooltip created');

  // Test DataColumn with onSort
  final sortableColumn = DataColumn(
    label: Text('Date'),
    onSort: (int columnIndex, bool ascending) {
      print('Sort column $columnIndex, ascending: $ascending');
    },
  );
  print('DataColumn with onSort created');

  // Test DataColumn with mouseCursor
  final cursorColumn = DataColumn(
    label: Text('Clickable'),
    mouseCursor: MaterialStateProperty.all(SystemMouseCursors.click),
  );
  print('DataColumn with mouseCursor created');

  // ========== DATAROW ==========
  print('--- DataRow Tests ---');

  // Test basic DataRow
  final basicRow = DataRow(
    cells: [
      DataCell(Text('John')),
      DataCell(Text('Doe')),
      DataCell(Text('30')),
    ],
  );
  print('Basic DataRow created');

  // Test DataRow with selected
  final selectedRow = DataRow(
    selected: true,
    cells: [
      DataCell(Text('Selected')),
      DataCell(Text('Row')),
      DataCell(Text('Here')),
    ],
  );
  print('DataRow with selected=true created');

  // Test DataRow with onSelectChanged
  final selectableRow = DataRow(
    onSelectChanged: (bool? selected) {
      print('Row selection changed: $selected');
    },
    cells: [
      DataCell(Text('Selectable')),
      DataCell(Text('Row')),
      DataCell(Text('Data')),
    ],
  );
  print('DataRow with onSelectChanged created');

  // Test DataRow with onLongPress
  final longPressRow = DataRow(
    onLongPress: () {
      print('Row long pressed');
    },
    cells: [
      DataCell(Text('Long')),
      DataCell(Text('Press')),
      DataCell(Text('Me')),
    ],
  );
  print('DataRow with onLongPress created');

  // Test DataRow with color
  final coloredRow = DataRow(
    color: MaterialStateProperty.all(Colors.blue.shade50),
    cells: [
      DataCell(Text('Blue')),
      DataCell(Text('Background')),
      DataCell(Text('Row')),
    ],
  );
  print('DataRow with color created');

  // Test DataRow.byIndex
  // Note: byIndex is typically used in PaginatedDataTable
  print('DataRow.byIndex concept noted');

  // ========== DATATABLE ==========
  print('--- DataTable Tests ---');

  // Test basic DataTable
  final basicTable = DataTable(
    columns: [
      DataColumn(label: Text('Name')),
      DataColumn(label: Text('Age')),
      DataColumn(label: Text('City')),
    ],
    rows: [
      DataRow(
        cells: [
          DataCell(Text('Alice')),
          DataCell(Text('25')),
          DataCell(Text('New York')),
        ],
      ),
      DataRow(
        cells: [
          DataCell(Text('Bob')),
          DataCell(Text('30')),
          DataCell(Text('London')),
        ],
      ),
      DataRow(
        cells: [
          DataCell(Text('Charlie')),
          DataCell(Text('35')),
          DataCell(Text('Paris')),
        ],
      ),
    ],
  );
  print('Basic DataTable created');

  // Test DataTable with sortColumnIndex
  final sortedTable = DataTable(
    sortColumnIndex: 1,
    sortAscending: true,
    columns: [
      DataColumn(label: Text('Name'), onSort: (col, asc) {}),
      DataColumn(label: Text('Age'), numeric: true, onSort: (col, asc) {}),
    ],
    rows: [
      DataRow(cells: [DataCell(Text('Alice')), DataCell(Text('25'))]),
      DataRow(cells: [DataCell(Text('Bob')), DataCell(Text('30'))]),
    ],
  );
  print('DataTable with sortColumnIndex created');

  // Test DataTable with onSelectAll
  final selectAllTable = DataTable(
    onSelectAll: (bool? selected) {
      print('Select all: $selected');
    },
    columns: [
      DataColumn(label: Text('Item')),
      DataColumn(label: Text('Price')),
    ],
    rows: [
      DataRow(
        onSelectChanged: (selected) {},
        cells: [DataCell(Text('Item 1')), DataCell(Text('\$10'))],
      ),
      DataRow(
        onSelectChanged: (selected) {},
        cells: [DataCell(Text('Item 2')), DataCell(Text('\$20'))],
      ),
    ],
  );
  print('DataTable with onSelectAll created');

  // Test DataTable with decoration
  final decoratedTable = DataTable(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.blue),
      borderRadius: BorderRadius.circular(8.0),
    ),
    columns: [
      DataColumn(label: Text('A')),
      DataColumn(label: Text('B')),
    ],
    rows: [
      DataRow(cells: [DataCell(Text('1')), DataCell(Text('2'))]),
    ],
  );
  print('DataTable with decoration created');

  // Test DataTable with dataRowMinHeight and dataRowMaxHeight
  final rowHeightTable = DataTable(
    dataRowMinHeight: 60.0,
    dataRowMaxHeight: 80.0,
    columns: [
      DataColumn(label: Text('Product')),
      DataColumn(label: Text('Description')),
    ],
    rows: [
      DataRow(
        cells: [DataCell(Text('Widget A')), DataCell(Text('A helpful widget'))],
      ),
    ],
  );
  print('DataTable with dataRowHeight created');

  // Test DataTable with headingRowHeight
  final headingHeightTable = DataTable(
    headingRowHeight: 70.0,
    columns: [
      DataColumn(label: Text('Header 1')),
      DataColumn(label: Text('Header 2')),
    ],
    rows: [
      DataRow(cells: [DataCell(Text('Data 1')), DataCell(Text('Data 2'))]),
    ],
  );
  print('DataTable with headingRowHeight created');

  // Test DataTable with headingRowColor
  final headingColorTable = DataTable(
    headingRowColor: MaterialStateProperty.all(Colors.blue.shade100),
    columns: [
      DataColumn(label: Text('Col 1')),
      DataColumn(label: Text('Col 2')),
    ],
    rows: [
      DataRow(cells: [DataCell(Text('Data')), DataCell(Text('Data'))]),
    ],
  );
  print('DataTable with headingRowColor created');

  // Test DataTable with dataRowColor
  final dataColorTable = DataTable(
    dataRowColor: MaterialStateProperty.resolveWith<Color?>((
      Set<MaterialState> states,
    ) {
      if (states.contains(MaterialState.selected)) {
        return Colors.green.shade100;
      }
      return null;
    }),
    columns: [
      DataColumn(label: Text('Select')),
      DataColumn(label: Text('Data')),
    ],
    rows: [
      DataRow(
        selected: true,
        onSelectChanged: (selected) {},
        cells: [DataCell(Text('A')), DataCell(Text('Data A'))],
      ),
      DataRow(
        onSelectChanged: (selected) {},
        cells: [DataCell(Text('B')), DataCell(Text('Data B'))],
      ),
    ],
  );
  print('DataTable with dataRowColor created');

  // Test DataTable with border
  final borderTable = DataTable(
    border: TableBorder.all(color: Colors.grey),
    columns: [
      DataColumn(label: Text('X')),
      DataColumn(label: Text('Y')),
    ],
    rows: [
      DataRow(cells: [DataCell(Text('1')), DataCell(Text('2'))]),
      DataRow(cells: [DataCell(Text('3')), DataCell(Text('4'))]),
    ],
  );
  print('DataTable with border created');

  // Test DataTable with dividerThickness
  final dividerTable = DataTable(
    dividerThickness: 3.0,
    columns: [
      DataColumn(label: Text('Name')),
      DataColumn(label: Text('Value')),
    ],
    rows: [
      DataRow(cells: [DataCell(Text('A')), DataCell(Text('100'))]),
      DataRow(cells: [DataCell(Text('B')), DataCell(Text('200'))]),
    ],
  );
  print('DataTable with dividerThickness created');

  // Test DataTable with horizontalMargin
  final marginTable = DataTable(
    horizontalMargin: 32.0,
    columns: [
      DataColumn(label: Text('Label')),
      DataColumn(label: Text('Amount'), numeric: true),
    ],
    rows: [
      DataRow(cells: [DataCell(Text('Item')), DataCell(Text('\$50'))]),
    ],
  );
  print('DataTable with horizontalMargin created');

  // Test DataTable with columnSpacing
  final spacingTable = DataTable(
    columnSpacing: 80.0,
    columns: [
      DataColumn(label: Text('First')),
      DataColumn(label: Text('Second')),
      DataColumn(label: Text('Third')),
    ],
    rows: [
      DataRow(
        cells: [DataCell(Text('A')), DataCell(Text('B')), DataCell(Text('C'))],
      ),
    ],
  );
  print('DataTable with columnSpacing created');

  // Test DataTable with showCheckboxColumn
  final noCheckboxTable = DataTable(
    showCheckboxColumn: false,
    columns: [
      DataColumn(label: Text('Item')),
      DataColumn(label: Text('Active')),
    ],
    rows: [
      DataRow(
        onSelectChanged: (selected) {},
        cells: [DataCell(Text('Widget')), DataCell(Text('Yes'))],
      ),
    ],
  );
  print('DataTable with showCheckboxColumn=false created');

  // Test DataTable with showBottomBorder
  final bottomBorderTable = DataTable(
    showBottomBorder: true,
    columns: [
      DataColumn(label: Text('Bottom')),
      DataColumn(label: Text('Border')),
    ],
    rows: [
      DataRow(cells: [DataCell(Text('Has')), DataCell(Text('Border'))]),
    ],
  );
  print('DataTable with showBottomBorder created');

  // Test DataTable with checkboxHorizontalMargin
  final checkboxMarginTable = DataTable(
    checkboxHorizontalMargin: 24.0,
    columns: [DataColumn(label: Text('Data'))],
    rows: [
      DataRow(onSelectChanged: (selected) {}, cells: [DataCell(Text('Row 1'))]),
      DataRow(onSelectChanged: (selected) {}, cells: [DataCell(Text('Row 2'))]),
    ],
  );
  print('DataTable with checkboxHorizontalMargin created');

  // Test DataTable with headingTextStyle
  final styledHeadingTable = DataTable(
    headingTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.blue,
      fontSize: 16.0,
    ),
    columns: [
      DataColumn(label: Text('Name')),
      DataColumn(label: Text('Age')),
    ],
    rows: [
      DataRow(cells: [DataCell(Text('Test')), DataCell(Text('25'))]),
    ],
  );
  print('DataTable with headingTextStyle created');

  // Test DataTable with dataTextStyle
  final styledDataTable = DataTable(
    dataTextStyle: TextStyle(color: Colors.grey.shade700, fontSize: 14.0),
    columns: [
      DataColumn(label: Text('Product')),
      DataColumn(label: Text('Price')),
    ],
    rows: [
      DataRow(cells: [DataCell(Text('Widget')), DataCell(Text('\$99'))]),
    ],
  );
  print('DataTable with dataTextStyle created');

  print('DataTable widgets test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DataTable Widgets Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text('Basic DataTable:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: basicTable,
        ),

        SizedBox(height: 24.0),
        Text(
          'Sortable DataTable:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: sortedTable,
        ),

        SizedBox(height: 24.0),
        Text(
          'Selectable DataTable:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: selectAllTable,
        ),

        SizedBox(height: 24.0),
        Text(
          'Styled DataTable:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: decoratedTable,
        ),

        SizedBox(height: 24.0),
        Text(
          'DataTable with Border:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: borderTable,
        ),

        SizedBox(height: 24.0),
        Text(
          'DataTable with Colors:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: headingColorTable,
        ),

        SizedBox(height: 24.0),
        Text(
          'DataTable with Custom Styles:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: styledHeadingTable,
        ),
      ],
    ),
  );
}
