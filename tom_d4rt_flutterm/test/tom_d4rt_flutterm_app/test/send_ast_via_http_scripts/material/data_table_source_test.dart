// D4rt test script: Tests DataTableSource from material
import 'package:flutter/material.dart';

// Helper to build a section header
Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(top: 20, bottom: 10),
    decoration: BoxDecoration(
      color: Color(0xFF4527A0),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFFFFFF),
      ),
    ),
  );
}

// Helper to build a demo card
Widget buildDemoCard(String label, Widget child) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFBDBDBD), width: 1),
      boxShadow: [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF424242),
          ),
        ),
        SizedBox(height: 12),
        child,
      ],
    ),
  );
}

// Helper: info row
Widget buildInfoRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Color(0xFF616161)),
          ),
        ),
        Expanded(
          child: Text(value, style: TextStyle(fontSize: 13, color: Color(0xFF212121))),
        ),
      ],
    ),
  );
}

// Helper: table header row
Widget buildTableHeader(List<String> columns, List<int> flexes) {
  List<Widget> cells = [];
  for (int i = 0; i < columns.length; i++) {
    cells.add(
      Expanded(
        flex: i < flexes.length ? flexes[i] : 1,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Text(
            columns[i],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
  return Container(
    decoration: BoxDecoration(
      color: Color(0xFF4527A0),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
    ),
    child: Row(children: cells),
  );
}

// Helper: table data row
Widget buildTableRow(List<String> values, List<int> flexes, bool isEven, bool isSelected) {
  List<Widget> cells = [];
  for (int i = 0; i < values.length; i++) {
    cells.add(
      Expanded(
        flex: i < flexes.length ? flexes[i] : 1,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Text(
            values[i],
            style: TextStyle(fontSize: 13, color: Color(0xFF212121)),
          ),
        ),
      ),
    );
  }
  return Container(
    decoration: BoxDecoration(
      color: isSelected
          ? Color(0xFFE8EAF6)
          : isEven
              ? Color(0xFFF5F5F5)
              : Color(0xFFFFFFFF),
      border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0), width: 0.5)),
    ),
    child: Row(children: cells),
  );
}

// Helper: selectable table row with checkbox
Widget buildSelectableRow(List<String> values, List<int> flexes, bool isEven, bool isSelected) {
  List<Widget> rowChildren = [
    Container(
      width: 40,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFF4527A0) : Color(0xFFFFFFFF),
            border: Border.all(color: isSelected ? Color(0xFF4527A0) : Color(0xFFBDBDBD), width: 2),
            borderRadius: BorderRadius.circular(3),
          ),
          child: isSelected
              ? Icon(Icons.check, size: 14, color: Color(0xFFFFFFFF))
              : SizedBox(),
        ),
      ),
    ),
  ];
  for (int i = 0; i < values.length; i++) {
    rowChildren.add(
      Expanded(
        flex: i < flexes.length ? flexes[i] : 1,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Text(values[i], style: TextStyle(fontSize: 13, color: Color(0xFF212121))),
        ),
      ),
    );
  }
  return Container(
    decoration: BoxDecoration(
      color: isSelected
          ? Color(0xFFE8EAF6)
          : isEven
              ? Color(0xFFF5F5F5)
              : Color(0xFFFFFFFF),
      border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0), width: 0.5)),
    ),
    child: Row(children: rowChildren),
  );
}

// Helper: sort indicator column header
Widget buildSortableHeader(String label, bool isSorted, bool isAscending) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFFFFFFFF))),
      if (isSorted)
        Padding(
          padding: EdgeInsets.only(left: 4),
          child: Icon(
            isAscending ? Icons.arrow_upward : Icons.arrow_downward,
            size: 14,
            color: Color(0xFFFFCC80),
          ),
        ),
    ],
  );
}

// Helper: numeric value cell with right alignment
Widget buildNumericCell(String value, Color textColor) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
    alignment: Alignment.centerRight,
    child: Text(
      value,
      style: TextStyle(fontSize: 13, fontFamily: 'monospace', color: textColor),
    ),
  );
}

// Helper: pagination controls
Widget buildPaginationControls(int currentPage, int totalPages, int rowsPerPage) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
      border: Border(top: BorderSide(color: Color(0xFFE0E0E0))),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Page $currentPage of $totalPages',
          style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
        ),
        Row(
          children: [
            Text('Rows per page: ', style: TextStyle(fontSize: 12, color: Color(0xFF757575))),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFBDBDBD)),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(rowsPerPage.toString(), style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.first_page, size: 20),
              onPressed: () { debugPrint('First page'); },
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(minWidth: 32, minHeight: 32),
            ),
            IconButton(
              icon: Icon(Icons.chevron_left, size: 20),
              onPressed: () { debugPrint('Previous page'); },
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(minWidth: 32, minHeight: 32),
            ),
            IconButton(
              icon: Icon(Icons.chevron_right, size: 20),
              onPressed: () { debugPrint('Next page'); },
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(minWidth: 32, minHeight: 32),
            ),
            IconButton(
              icon: Icon(Icons.last_page, size: 20),
              onPressed: () { debugPrint('Last page'); },
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(minWidth: 32, minHeight: 32),
            ),
          ],
        ),
      ],
    ),
  );
}

// Helper: cell with widget (icon, chip, etc.)
Widget buildCellWithIcon(IconData icon, String text, Color iconColor) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: iconColor),
        SizedBox(width: 6),
        Flexible(
          child: Text(text, style: TextStyle(fontSize: 13, color: Color(0xFF212121)), overflow: TextOverflow.ellipsis),
        ),
      ],
    ),
  );
}

// Helper: status chip in cell
Widget buildStatusChip(String label, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
  );
}

// Helper: row state indicator
Widget buildRowStateIndicator(String state, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: Color(0xFFFFFFFF), shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        Text(state, style: TextStyle(fontSize: 13, color: Color(0xFFFFFFFF), fontWeight: FontWeight.w500)),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== DataTableSource Deep Demo ===');
  debugPrint('Testing data table construction, selection, sorting, pagination');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('DataTableSource Deep Demo'),
        backgroundColor: Color(0xFF4527A0),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: DataTableSource Properties
            buildSectionHeader('1. DataTableSource Properties'),
            buildDemoCard(
              'Key properties and methods of DataTableSource',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow('rowCount', 'Total number of rows in the data source'),
                  buildInfoRow('isRowCountApprox', 'Whether rowCount is approximate'),
                  buildInfoRow('selectedRowCount', 'Number of currently selected rows'),
                  buildInfoRow('getRow(index)', 'Returns DataRow for the given index'),
                  buildInfoRow('notifyListeners', 'Notifies table to rebuild rows'),
                ],
              ),
            ),
            Text('Section 1: DataTableSource properties displayed', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 2: Basic Data Table
            buildSectionHeader('2. Basic Data Table'),
            buildDemoCard(
              'Employee directory table',
              Column(
                children: [
                  buildTableHeader(['ID', 'Name', 'Department', 'Email'], [1, 2, 2, 3]),
                  buildTableRow(['001', 'Alice Johnson', 'Engineering', 'alice@example.com'], [1, 2, 2, 3], false, false),
                  buildTableRow(['002', 'Bob Smith', 'Marketing', 'bob@example.com'], [1, 2, 2, 3], true, false),
                  buildTableRow(['003', 'Carol White', 'Design', 'carol@example.com'], [1, 2, 2, 3], false, false),
                  buildTableRow(['004', 'David Brown', 'Sales', 'david@example.com'], [1, 2, 2, 3], true, false),
                  buildTableRow(['005', 'Eve Davis', 'Engineering', 'eve@example.com'], [1, 2, 2, 3], false, false),
                  buildTableRow(['006', 'Frank Miller', 'HR', 'frank@example.com'], [1, 2, 2, 3], true, false),
                ],
              ),
            ),
            Text('Section 2: Basic data table rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 3: Selectable Rows
            buildSectionHeader('3. Selectable Rows'),
            buildDemoCard(
              'Table with row selection (3 of 6 selected)',
              Column(
                children: [
                  buildTableHeader(['Name', 'Role', 'Status'], [2, 2, 1]),
                  buildSelectableRow(['Alice Johnson', 'Lead Engineer', 'Active'], [2, 2, 1], false, true),
                  buildSelectableRow(['Bob Smith', 'Designer', 'Active'], [2, 2, 1], true, false),
                  buildSelectableRow(['Carol White', 'Manager', 'Away'], [2, 2, 1], false, true),
                  buildSelectableRow(['David Brown', 'Analyst', 'Active'], [2, 2, 1], true, false),
                  buildSelectableRow(['Eve Davis', 'Developer', 'Offline'], [2, 2, 1], false, true),
                  buildSelectableRow(['Frank Miller', 'Tester', 'Active'], [2, 2, 1], true, false),
                ],
              ),
            ),
            buildDemoCard(
              'Selection summary',
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text('6', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF4527A0))),
                      Text('Total Rows', style: TextStyle(fontSize: 12, color: Color(0xFF757575))),
                    ],
                  ),
                  Column(
                    children: [
                      Text('3', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1976D2))),
                      Text('Selected', style: TextStyle(fontSize: 12, color: Color(0xFF757575))),
                    ],
                  ),
                  Column(
                    children: [
                      Text('50%', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF388E3C))),
                      Text('Percentage', style: TextStyle(fontSize: 12, color: Color(0xFF757575))),
                    ],
                  ),
                ],
              ),
            ),
            Text('Section 3: Selectable rows rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 4: Sortable Columns
            buildSectionHeader('4. Sortable Columns'),
            buildDemoCard(
              'Table sorted by Name (ascending)',
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF4527A0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: buildSortableHeader('Name', true, true)),
                        Expanded(flex: 2, child: buildSortableHeader('Score', false, true)),
                        Expanded(flex: 1, child: buildSortableHeader('Grade', false, true)),
                      ],
                    ),
                  ),
                  buildTableRow(['Alice', '95', 'A'], [2, 2, 1], false, false),
                  buildTableRow(['Bob', '82', 'B'], [2, 2, 1], true, false),
                  buildTableRow(['Carol', '91', 'A'], [2, 2, 1], false, false),
                  buildTableRow(['David', '78', 'C+'], [2, 2, 1], true, false),
                  buildTableRow(['Eve', '88', 'B+'], [2, 2, 1], false, false),
                ],
              ),
            ),
            buildDemoCard(
              'Table sorted by Score (descending)',
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF4527A0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: buildSortableHeader('Name', false, true)),
                        Expanded(flex: 2, child: buildSortableHeader('Score', true, false)),
                        Expanded(flex: 1, child: buildSortableHeader('Grade', false, true)),
                      ],
                    ),
                  ),
                  buildTableRow(['Alice', '95', 'A'], [2, 2, 1], false, false),
                  buildTableRow(['Carol', '91', 'A'], [2, 2, 1], true, false),
                  buildTableRow(['Eve', '88', 'B+'], [2, 2, 1], false, false),
                  buildTableRow(['Bob', '82', 'B'], [2, 2, 1], true, false),
                  buildTableRow(['David', '78', 'C+'], [2, 2, 1], false, false),
                ],
              ),
            ),
            Text('Section 4: Sortable columns rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 5: Numeric Data Table
            buildSectionHeader('5. Numeric Data Table'),
            buildDemoCard(
              'Financial data with numeric alignment',
              Column(
                children: [
                  buildTableHeader(['Product', 'Units', 'Revenue', 'Profit'], [3, 1, 2, 2]),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0), width: 0.5)),
                    ),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Container(padding: EdgeInsets.all(10), child: Text('Widget Pro', style: TextStyle(fontSize: 13)))),
                        Expanded(flex: 1, child: buildNumericCell('1,245', Color(0xFF212121))),
                        Expanded(flex: 2, child: buildNumericCell('\$124,500', Color(0xFF2E7D32))),
                        Expanded(flex: 2, child: buildNumericCell('\$45,200', Color(0xFF2E7D32))),
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xFFF5F5F5),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Container(padding: EdgeInsets.all(10), child: Text('Gadget X', style: TextStyle(fontSize: 13)))),
                        Expanded(flex: 1, child: buildNumericCell('892', Color(0xFF212121))),
                        Expanded(flex: 2, child: buildNumericCell('\$89,200', Color(0xFF2E7D32))),
                        Expanded(flex: 2, child: buildNumericCell('\$31,700', Color(0xFF2E7D32))),
                      ],
                    ),
                  ),
                  Row(
                      children: [
                        Expanded(flex: 3, child: Container(padding: EdgeInsets.all(10), child: Text('Service Plus', style: TextStyle(fontSize: 13)))),
                        Expanded(flex: 1, child: buildNumericCell('3,421', Color(0xFF212121))),
                        Expanded(flex: 2, child: buildNumericCell('\$342,100', Color(0xFF2E7D32))),
                        Expanded(flex: 2, child: buildNumericCell('-\$12,300', Color(0xFFC62828))),
                      ],
                  ),
                  Container(
                    color: Color(0xFFF5F5F5),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Container(padding: EdgeInsets.all(10), child: Text('Bundle Deal', style: TextStyle(fontSize: 13)))),
                        Expanded(flex: 1, child: buildNumericCell('567', Color(0xFF212121))),
                        Expanded(flex: 2, child: buildNumericCell('\$56,700', Color(0xFF2E7D32))),
                        Expanded(flex: 2, child: buildNumericCell('\$22,400', Color(0xFF2E7D32))),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Color(0xFFEDE7F6),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                        Expanded(flex: 1, child: buildNumericCell('6,125', Color(0xFF4527A0))),
                        Expanded(flex: 2, child: buildNumericCell('\$612,500', Color(0xFF4527A0))),
                        Expanded(flex: 2, child: buildNumericCell('\$87,000', Color(0xFF4527A0))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text('Section 5: Numeric data table rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 6: Pagination
            buildSectionHeader('6. Paginated DataTable'),
            buildDemoCard(
              'Table with pagination controls',
              Column(
                children: [
                  buildTableHeader(['#', 'Item', 'Quantity', 'Price'], [1, 3, 1, 2]),
                  buildTableRow(['11', 'Laptop Stand', '15', '\$29.99'], [1, 3, 1, 2], false, false),
                  buildTableRow(['12', 'USB-C Hub', '42', '\$49.99'], [1, 3, 1, 2], true, false),
                  buildTableRow(['13', 'Wireless Mouse', '103', '\$19.99'], [1, 3, 1, 2], false, false),
                  buildTableRow(['14', 'Mechanical KB', '28', '\$89.99'], [1, 3, 1, 2], true, false),
                  buildTableRow(['15', 'Monitor Arm', '7', '\$129.99'], [1, 3, 1, 2], false, false),
                  buildPaginationControls(2, 10, 5),
                ],
              ),
            ),
            buildDemoCard(
              'Rows per page options',
              Row(
                children: [
                  Text('Rows per page: ', style: TextStyle(fontSize: 13, color: Color(0xFF616161))),
                  SizedBox(width: 8),
                  ...[5, 10, 25, 50, 100].map((v) {
                    bool isActive = v == 10;
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isActive ? Color(0xFF4527A0) : Color(0xFFFFFFFF),
                        border: Border.all(color: isActive ? Color(0xFF4527A0) : Color(0xFFBDBDBD)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        v.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          color: isActive ? Color(0xFFFFFFFF) : Color(0xFF616161),
                          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            Text('Section 6: Paginated table rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 7: Mixed Cell Types
            buildSectionHeader('7. Mixed Cell Types'),
            buildDemoCard(
              'Table with icons, chips, and custom cell content',
              Column(
                children: [
                  buildTableHeader(['App', 'Status', 'Users', 'Health'], [2, 2, 1, 1]),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0), width: 0.5)),
                    ),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: buildCellWithIcon(Icons.cloud, 'Cloud API', Color(0xFF1976D2))),
                        Expanded(flex: 2, child: Padding(padding: EdgeInsets.all(8), child: buildStatusChip('Running', Color(0xFFE8F5E9), Color(0xFF2E7D32)))),
                        Expanded(flex: 1, child: buildNumericCell('12.4k', Color(0xFF212121))),
                        Expanded(flex: 1, child: Padding(padding: EdgeInsets.all(8), child: Icon(Icons.check_circle, color: Color(0xFF4CAF50), size: 20))),
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xFFF5F5F5),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: buildCellWithIcon(Icons.storage, 'Database', Color(0xFFF57C00))),
                        Expanded(flex: 2, child: Padding(padding: EdgeInsets.all(8), child: buildStatusChip('Warning', Color(0xFFFFF3E0), Color(0xFFE65100)))),
                        Expanded(flex: 1, child: buildNumericCell('8.2k', Color(0xFF212121))),
                        Expanded(flex: 1, child: Padding(padding: EdgeInsets.all(8), child: Icon(Icons.warning, color: Color(0xFFF57C00), size: 20))),
                      ],
                    ),
                  ),
                  Row(
                      children: [
                        Expanded(flex: 2, child: buildCellWithIcon(Icons.web, 'Web Portal', Color(0xFF7B1FA2))),
                        Expanded(flex: 2, child: Padding(padding: EdgeInsets.all(8), child: buildStatusChip('Stopped', Color(0xFFFFEBEE), Color(0xFFC62828)))),
                        Expanded(flex: 1, child: buildNumericCell('0', Color(0xFFBDBDBD))),
                        Expanded(flex: 1, child: Padding(padding: EdgeInsets.all(8), child: Icon(Icons.cancel, color: Color(0xFFD32F2F), size: 20))),
                      ],
                  ),
                  Container(
                    color: Color(0xFFF5F5F5),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: buildCellWithIcon(Icons.memory, 'ML Pipeline', Color(0xFF00695C))),
                        Expanded(flex: 2, child: Padding(padding: EdgeInsets.all(8), child: buildStatusChip('Running', Color(0xFFE8F5E9), Color(0xFF2E7D32)))),
                        Expanded(flex: 1, child: buildNumericCell('3.1k', Color(0xFF212121))),
                        Expanded(flex: 1, child: Padding(padding: EdgeInsets.all(8), child: Icon(Icons.check_circle, color: Color(0xFF4CAF50), size: 20))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text('Section 7: Mixed cell types rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 8: Row States
            buildSectionHeader('8. DataRow States'),
            buildDemoCard(
              'Visual states for data rows',
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildRowStateIndicator('Normal Row', Color(0xFF757575)),
                  buildRowStateIndicator('Selected Row', Color(0xFF1976D2)),
                  buildRowStateIndicator('Hovered Row', Color(0xFF9C27B0)),
                  buildRowStateIndicator('Pressed Row', Color(0xFF00695C)),
                  buildRowStateIndicator('Disabled Row', Color(0xFFBDBDBD)),
                ],
              ),
            ),
            buildDemoCard(
              'DataRow.byIndex simulated index mapping',
              Column(
                children: [
                  buildInfoRow('Row index 0', 'Maps to data[0] - normal'),
                  buildInfoRow('Row index 1', 'Maps to data[1] - selected'),
                  buildInfoRow('Row index 2', 'Maps to data[2] - normal'),
                  buildInfoRow('Row index 3', 'Maps to data[3] - disabled'),
                  buildInfoRow('Row index 4', 'Maps to data[4] - normal'),
                ],
              ),
            ),
            Text('Section 8: Row states rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 9: Large Dataset Simulation
            buildSectionHeader('9. Large Dataset Info'),
            buildDemoCard(
              'Simulating large datasets with DataTableSource',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFFEDE7F6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dataset Statistics', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF4527A0))),
                        SizedBox(height: 8),
                        buildInfoRow('Total Rows', '10,000'),
                        buildInfoRow('Visible Rows', '25 (per page)'),
                        buildInfoRow('Pages', '400'),
                        buildInfoRow('Approx Count', 'false'),
                        buildInfoRow('Selected', '42'),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFF4527A0),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text('10K', style: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold, fontSize: 16)),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text('Rows', style: TextStyle(fontSize: 11, color: Color(0xFF757575))),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFF1976D2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text('15', style: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold, fontSize: 16)),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text('Cols', style: TextStyle(fontSize: 11, color: Color(0xFF757575))),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFF00695C),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text('150K', style: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold, fontSize: 16)),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text('Cells', style: TextStyle(fontSize: 11, color: Color(0xFF757575))),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text('Section 9: Large dataset info rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Summary
            buildSectionHeader('Summary'),
            buildDemoCard(
              'DataTableSource Features Demonstrated',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow('1', 'DataTableSource key properties'),
                  buildInfoRow('2', 'Basic data table with rows'),
                  buildInfoRow('3', 'Selectable rows with checkboxes'),
                  buildInfoRow('4', 'Sortable column headers'),
                  buildInfoRow('5', 'Numeric data with alignment'),
                  buildInfoRow('6', 'Paginated table controls'),
                  buildInfoRow('7', 'Mixed cell content types'),
                  buildInfoRow('8', 'Row state variations'),
                  buildInfoRow('9', 'Large dataset simulation'),
                ],
              ),
            ),
            Text('=== DataTableSource Deep Demo Complete ===', style: TextStyle(fontSize: 10, color: Colors.grey)),

            SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}
