// D4rt test script: Tests PaginatedDataTableState from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.indigo.shade700,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget buildInfoCard(String label, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildPropertyRow(String name, String type, String description) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.indigo.shade100),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120,
          child: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.indigo.shade700,
            ),
          ),
        ),
        Container(
          width: 80,
          child: Text(
            type,
            style: TextStyle(
              fontSize: 12,
              color: Colors.purple.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

class DemoDataSource extends DataTableSource {
  List<Map<String, dynamic>> data;
  Set<int> selectedRows;
  Function(int, bool) onSelectRow;

  DemoDataSource(this.data, this.selectedRows, this.onSelectRow);

  int get rowCount {
    return data.length;
  }

  bool get isRowCountApproximate {
    return false;
  }

  int get selectedRowCount {
    return selectedRows.length;
  }

  DataRow getRow(int index) {
    if (index >= data.length) {
      return DataRow(cells: []);
    }
    Map<String, dynamic> row = data[index];
    bool isSelected = selectedRows.contains(index);

    return DataRow(
      selected: isSelected,
      onSelectChanged: (bool? selected) {
        onSelectRow(index, selected ?? false);
      },
      cells: [
        DataCell(Text('${row['id']}')),
        DataCell(Text('${row['name']}')),
        DataCell(Text('${row['category']}')),
        DataCell(Text('\$${row['price']}')),
        DataCell(Text('${row['quantity']}')),
      ],
    );
  }
}

class SimpleDataSource extends DataTableSource {
  List<List<String>> rows;

  SimpleDataSource(this.rows);

  int get rowCount {
    return rows.length;
  }

  bool get isRowCountApproximate {
    return false;
  }

  int get selectedRowCount {
    return 0;
  }

  DataRow getRow(int index) {
    if (index >= rows.length) {
      return DataRow(cells: []);
    }
    List<String> row = rows[index];
    List<DataCell> cells = [];
    int i = 0;
    for (i = 0; i < row.length; i = i + 1) {
      cells.add(DataCell(Text(row[i])));
    }
    return DataRow(cells: cells);
  }
}

Widget buildBasicPaginatedTable() {
  print('Building basic paginated data table');
  List<List<String>> sampleData = [
    ['1', 'Apple', 'Fruit'],
    ['2', 'Carrot', 'Vegetable'],
    ['3', 'Banana', 'Fruit'],
    ['4', 'Broccoli', 'Vegetable'],
    ['5', 'Orange', 'Fruit'],
    ['6', 'Spinach', 'Vegetable'],
    ['7', 'Grape', 'Fruit'],
    ['8', 'Tomato', 'Vegetable'],
    ['9', 'Mango', 'Fruit'],
    ['10', 'Lettuce', 'Vegetable'],
    ['11', 'Cherry', 'Fruit'],
    ['12', 'Cucumber', 'Vegetable'],
  ];

  SimpleDataSource source = SimpleDataSource(sampleData);

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Basic PaginatedDataTable',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: PaginatedDataTable(
            header: Text('Food Items'),
            columns: [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Category')),
            ],
            source: source,
            rowsPerPage: 5,
          ),
        ),
      ],
    ),
  );
}

Widget buildMultiColumnTable() {
  print('Building multi-column data table');
  List<List<String>> productData = [
    ['P001', 'Laptop Pro', 'Electronics', '\$1299', '45', 'Active'],
    ['P002', 'Wireless Mouse', 'Accessories', '\$29', '230', 'Active'],
    ['P003', 'USB-C Hub', 'Accessories', '\$49', '120', 'Active'],
    ['P004', 'Monitor 27"', 'Electronics', '\$399', '67', 'Active'],
    ['P005', 'Keyboard', 'Accessories', '\$89', '180', 'Active'],
    ['P006', 'Webcam HD', 'Electronics', '\$79', '95', 'Active'],
    ['P007', 'Headphones', 'Audio', '\$199', '140', 'Active'],
    ['P008', 'Speakers', 'Audio', '\$149', '85', 'Active'],
    ['P009', 'Mouse Pad XL', 'Accessories', '\$19', '350', 'Active'],
    ['P010', 'Cable Kit', 'Accessories', '\$35', '420', 'Active'],
    ['P011', 'Tablet Stand', 'Accessories', '\$25', '190', 'Active'],
    ['P012', 'Desk Lamp', 'Office', '\$45', '88', 'Active'],
    ['P013', 'Chair Mat', 'Office', '\$55', '72', 'Active'],
    ['P014', 'Notebook', 'Supplies', '\$8', '510', 'Active'],
    ['P015', 'Pen Set', 'Supplies', '\$12', '680', 'Active'],
  ];

  SimpleDataSource source = SimpleDataSource(productData);

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'Product Inventory Table',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: PaginatedDataTable(
            header: Text('Product List'),
            columns: [
              DataColumn(label: Text('SKU')),
              DataColumn(label: Text('Product Name')),
              DataColumn(label: Text('Category')),
              DataColumn(label: Text('Price'), numeric: true),
              DataColumn(label: Text('Stock'), numeric: true),
              DataColumn(label: Text('Status')),
            ],
            source: source,
            rowsPerPage: 5,
            showCheckboxColumn: false,
          ),
        ),
      ],
    ),
  );
}

Widget buildPaginationControlsDemo() {
  print('Building pagination controls demo');
  List<List<String>> data = [];
  int i = 0;
  for (i = 1; i <= 50; i = i + 1) {
    data.add(['$i', 'Item ${i}', 'Description for item ${i}']);
  }

  SimpleDataSource source = SimpleDataSource(data);

  List<int> rowOptions = [5, 10, 20, 50];

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.view_list, color: Colors.indigo),
              SizedBox(width: 8),
              Text(
                'Pagination Controls Demo',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade700,
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: PaginatedDataTable(
            header: Text('50 Items Dataset'),
            columns: [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Description')),
            ],
            source: source,
            rowsPerPage: 10,
            availableRowsPerPage: rowOptions,
            onRowsPerPageChanged: (int? value) {
              print('Rows per page changed to: $value');
            },
            onPageChanged: (int page) {
              print('Page changed to: $page');
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'Use controls at bottom to navigate pages and change rows per page',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ),
      ],
    ),
  );
}

Widget buildSortableColumnsDemo() {
  print('Building sortable columns demo');

  List<List<String>> employeeData = [
    ['E001', 'Alice Johnson', 'Engineering', '85000', '2019'],
    ['E002', 'Bob Smith', 'Marketing', '72000', '2020'],
    ['E003', 'Carol White', 'Engineering', '92000', '2018'],
    ['E004', 'David Brown', 'Sales', '68000', '2021'],
    ['E005', 'Eve Davis', 'HR', '65000', '2020'],
    ['E006', 'Frank Miller', 'Engineering', '88000', '2019'],
    ['E007', 'Grace Lee', 'Marketing', '75000', '2019'],
    ['E008', 'Henry Wilson', 'Sales', '71000', '2020'],
    ['E009', 'Ivy Chen', 'Engineering', '95000', '2017'],
    ['E010', 'Jack Taylor', 'HR', '62000', '2021'],
    ['E011', 'Kate Moore', 'Sales', '78000', '2018'],
    ['E012', 'Leo Garcia', 'Marketing', '69000', '2021'],
  ];

  SimpleDataSource source = SimpleDataSource(employeeData);

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.green.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.sort, color: Colors.green.shade700),
              SizedBox(width: 8),
              Text(
                'Sortable Columns Demo',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: PaginatedDataTable(
            header: Text('Employee Directory'),
            sortColumnIndex: 1,
            sortAscending: true,
            columns: [
              DataColumn(
                label: Text('ID'),
                onSort: (int colIdx, bool asc) {
                  print('Sorting ID column, ascending: $asc');
                },
              ),
              DataColumn(
                label: Text('Name'),
                onSort: (int colIdx, bool asc) {
                  print('Sorting Name column, ascending: $asc');
                },
              ),
              DataColumn(
                label: Text('Department'),
                onSort: (int colIdx, bool asc) {
                  print('Sorting Department column, ascending: $asc');
                },
              ),
              DataColumn(
                label: Text('Salary'),
                numeric: true,
                onSort: (int colIdx, bool asc) {
                  print('Sorting Salary column, ascending: $asc');
                },
              ),
              DataColumn(
                label: Text('Year'),
                numeric: true,
                onSort: (int colIdx, bool asc) {
                  print('Sorting Year column, ascending: $asc');
                },
              ),
            ],
            source: source,
            rowsPerPage: 5,
            showCheckboxColumn: false,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'Click column headers to sort data',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ),
      ],
    ),
  );
}

Widget buildRowSelectionDemo() {
  print('Building row selection demo');

  List<List<String>> taskData = [
    ['1', 'Design mockups', 'High', 'In Progress'],
    ['2', 'API integration', 'High', 'Pending'],
    ['3', 'Unit tests', 'Medium', 'In Progress'],
    ['4', 'Documentation', 'Low', 'Pending'],
    ['5', 'Code review', 'Medium', 'Completed'],
    ['6', 'Bug fixes', 'High', 'In Progress'],
    ['7', 'Performance optimization', 'Medium', 'Pending'],
    ['8', 'Security audit', 'High', 'Pending'],
    ['9', 'UI polish', 'Low', 'In Progress'],
    ['10', 'Deployment', 'High', 'Pending'],
  ];

  SimpleDataSource source = SimpleDataSource(taskData);

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.orange.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.check_box, color: Colors.orange.shade700),
              SizedBox(width: 8),
              Text(
                'Row Selection Demo',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade700,
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: PaginatedDataTable(
            header: Text('Task List'),
            columns: [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Task')),
              DataColumn(label: Text('Priority')),
              DataColumn(label: Text('Status')),
            ],
            source: source,
            rowsPerPage: 5,
            showCheckboxColumn: true,
            onSelectAll: (bool? selected) {
              print('Select all: $selected');
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select rows using checkboxes',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              SizedBox(height: 4),
              Text(
                'Use header checkbox to select/deselect all',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildMultiplePageSizesDemo() {
  print('Building multiple page sizes demo');

  List<List<String>> logData = [];
  int i = 0;
  for (i = 1; i <= 100; i = i + 1) {
    String level = (i % 3 == 0) ? 'ERROR' : ((i % 2 == 0) ? 'WARN' : 'INFO');
    logData.add(['$i', '2024-03-${(i % 28) + 1}', level, 'Log message #$i']);
  }

  List<int> pageSizes = [5, 10, 25, 50, 100];
  SimpleDataSource source = SimpleDataSource(logData);

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.purple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.pages, color: Colors.purple.shade700),
              SizedBox(width: 8),
              Text(
                'Multiple Page Sizes',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade700,
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: PaginatedDataTable(
            header: Text('System Logs (100 entries)'),
            columns: [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Level')),
              DataColumn(label: Text('Message')),
            ],
            source: source,
            rowsPerPage: 10,
            availableRowsPerPage: pageSizes,
            onRowsPerPageChanged: (int? value) {
              print('Page size changed to: $value');
            },
            showCheckboxColumn: false,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Wrap(
            spacing: 8,
            children: _buildPageSizeChips(pageSizes),
          ),
        ),
      ],
    ),
  );
}

List<Widget> _buildPageSizeChips(List<int> sizes) {
  List<Widget> chips = [];
  int i = 0;
  for (i = 0; i < sizes.length; i = i + 1) {
    chips.add(
      Chip(
        label: Text('${sizes[i]} rows'),
        backgroundColor: Colors.purple.shade100,
        labelStyle: TextStyle(fontSize: 11, color: Colors.purple.shade700),
      ),
    );
  }
  return chips;
}

Widget buildStyledDataTable() {
  print('Building styled data table');

  List<List<String>> orderData = [
    ['ORD-001', 'John Doe', '\$245.00', 'Shipped', '2024-03-15'],
    ['ORD-002', 'Jane Smith', '\$189.50', 'Processing', '2024-03-16'],
    ['ORD-003', 'Bob Wilson', '\$420.00', 'Delivered', '2024-03-14'],
    ['ORD-004', 'Alice Brown', '\$75.25', 'Shipped', '2024-03-17'],
    ['ORD-005', 'Charlie Lee', '\$312.80', 'Processing', '2024-03-18'],
    ['ORD-006', 'Diana Ross', '\$156.00', 'Pending', '2024-03-18'],
    ['ORD-007', 'Edward Kim', '\$89.99', 'Delivered', '2024-03-13'],
    ['ORD-008', 'Fiona Chen', '\$567.00', 'Shipped', '2024-03-16'],
  ];

  SimpleDataSource source = SimpleDataSource(orderData);

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade300,
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade400, Colors.teal.shade600],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.shopping_cart, color: Colors.white),
              SizedBox(width: 12),
              Text(
                'Order Management',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Theme(
            data: ThemeData(
              dataTableTheme: DataTableThemeData(
                headingRowColor: WidgetStateProperty.all(Colors.teal.shade50),
                dataRowColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.teal.shade100;
                  }
                  return Colors.white;
                }),
                headingTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade800,
                ),
              ),
            ),
            child: PaginatedDataTable(
              header: Text(
                'Recent Orders',
                style: TextStyle(color: Colors.teal.shade700),
              ),
              columns: [
                DataColumn(label: Text('Order ID')),
                DataColumn(label: Text('Customer')),
                DataColumn(label: Text('Amount'), numeric: true),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Date')),
              ],
              source: source,
              rowsPerPage: 5,
              showCheckboxColumn: false,
              arrowHeadColor: Colors.teal,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildDataSourceIntegration() {
  print('Building data source integration demo');

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.blue.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.integration_instructions, color: Colors.blue.shade700),
            SizedBox(width: 8),
            Text(
              'DataTableSource Integration',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        _buildSourceProperty('rowCount', 'int', 'Total number of rows in data source'),
        _buildSourceProperty('isRowCountApproximate', 'bool', 'Whether row count is exact or estimated'),
        _buildSourceProperty('selectedRowCount', 'int', 'Number of currently selected rows'),
        _buildSourceProperty('getRow(int index)', 'DataRow', 'Returns DataRow for given index'),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Key Methods:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('notifyListeners() - Refresh table when data changes'),
              Text('dispose() - Clean up resources'),
              Text('setRowSelection() - Programmatic row selection'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSourceProperty(String name, String returnType, String desc) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 200,
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Colors.blue.shade800,
            ),
          ),
        ),
        Container(
          width: 60,
          child: Text(
            returnType,
            style: TextStyle(
              fontSize: 11,
              color: Colors.purple,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildStateAccessPatterns() {
  print('Building state access patterns demo');

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.amber.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.amber.shade800),
            SizedBox(width: 8),
            Text(
              'State Access Patterns',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        _buildPatternCard(
          'GlobalKey Access',
          'Use GlobalKey<PaginatedDataTableState> to access state',
          Icons.key,
          Colors.amber,
        ),
        _buildPatternCard(
          'Callback Handlers',
          'onPageChanged, onRowsPerPageChanged for state updates',
          Icons.touch_app,
          Colors.orange,
        ),
        _buildPatternCard(
          'DataSource Notifications',
          'Call notifyListeners() to trigger rebuild',
          Icons.notifications_active,
          Colors.deepOrange,
        ),
        _buildPatternCard(
          'Controller Pattern',
          'Wrap in custom controller for advanced state management',
          Icons.control_camera,
          Colors.red,
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'State Properties:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Current page index'),
              Text('Rows per page setting'),
              Text('Sort column and direction'),
              Text('Selected row indices'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildPatternCard(
    String title, String description, IconData icon, MaterialColor color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.shade200),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.shade100,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: color.shade700, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: color.shade800,
                ),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildPaginatedStateOverview() {
  print('Building PaginatedDataTableState overview');

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.indigo.shade100, Colors.indigo.shade50],
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.table_chart, color: Colors.white, size: 24),
            ),
            SizedBox(width: 12),
            Text(
              'PaginatedDataTableState',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'The State object for PaginatedDataTable widget. Manages pagination, sorting, and row selection state for data tables with large datasets.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.indigo.shade700,
            height: 1.5,
          ),
        ),
        SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildFeatureChip('Pagination', Icons.auto_stories, Colors.blue),
            _buildFeatureChip('Sorting', Icons.sort, Colors.green),
            _buildFeatureChip('Selection', Icons.check_circle, Colors.orange),
            _buildFeatureChip('Page Size', Icons.view_module, Colors.purple),
          ],
        ),
        SizedBox(height: 16),
        buildPropertyRow('source', 'DataTableSource', 'Data provider for table rows'),
        buildPropertyRow('rowsPerPage', 'int', 'Number of rows displayed per page'),
        buildPropertyRow('sortColumnIndex', 'int?', 'Index of sorted column'),
        buildPropertyRow('sortAscending', 'bool', 'Sort direction flag'),
        buildPropertyRow('onPageChanged', 'Function', 'Callback when page changes'),
      ],
    ),
  );
}

Widget _buildFeatureChip(String label, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget buildActionsDemo() {
  print('Building actions demo');

  List<List<String>> userData = [
    ['U001', 'admin@example.com', 'Admin', 'Active'],
    ['U002', 'user1@example.com', 'User', 'Active'],
    ['U003', 'user2@example.com', 'User', 'Inactive'],
    ['U004', 'manager@example.com', 'Manager', 'Active'],
    ['U005', 'guest@example.com', 'Guest', 'Active'],
  ];

  SimpleDataSource source = SimpleDataSource(userData);

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: PaginatedDataTable(
            header: Text('User Management'),
            actions: [
              IconButton(
                icon: Icon(Icons.add_circle, color: Colors.green),
                onPressed: () {
                  print('Add user pressed');
                },
              ),
              IconButton(
                icon: Icon(Icons.refresh, color: Colors.blue),
                onPressed: () {
                  print('Refresh pressed');
                },
              ),
              IconButton(
                icon: Icon(Icons.filter_list, color: Colors.orange),
                onPressed: () {
                  print('Filter pressed');
                },
              ),
              IconButton(
                icon: Icon(Icons.download, color: Colors.purple),
                onPressed: () {
                  print('Export pressed');
                },
              ),
            ],
            columns: [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Role')),
              DataColumn(label: Text('Status')),
            ],
            source: source,
            rowsPerPage: 5,
            showCheckboxColumn: false,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'Custom actions appear next to the header',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('Building PaginatedDataTableState deep demo');

  Widget result = Scaffold(
    appBar: AppBar(
      title: Text('PaginatedDataTableState Demo'),
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () {
            print('Info button pressed');
          },
        ),
      ],
    ),
    body: Container(
      color: Colors.grey.shade100,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildSectionHeader('1. Overview of PaginatedDataTableState'),
            buildPaginatedStateOverview(),
            buildInfoCard(
              'Widget Type',
              'StatefulWidget with PaginatedDataTableState',
            ),
            buildInfoCard(
              'Primary Use',
              'Display large datasets with pagination controls',
            ),
            buildInfoCard(
              'Data Source',
              'Requires DataTableSource implementation',
            ),

            buildSectionHeader('2. PaginatedDataTable Basic Setup'),
            buildBasicPaginatedTable(),
            buildInfoCard('Required', 'columns, source, rowsPerPage'),
            buildInfoCard('Optional', 'header, showCheckboxColumn, actions'),

            buildSectionHeader('3. Data Rows with Multiple Columns'),
            buildMultiColumnTable(),
            buildInfoCard(
              'Column Features',
              'Label, numeric alignment, tooltips, sorting',
            ),

            buildSectionHeader('4. Pagination Controls'),
            buildPaginationControlsDemo(),
            buildInfoCard(
              'Controls',
              'Previous/Next buttons, rows per page dropdown',
            ),

            buildSectionHeader('5. Column Sorting'),
            buildSortableColumnsDemo(),
            buildInfoCard(
              'Sorting State',
              'sortColumnIndex and sortAscending properties',
            ),

            buildSectionHeader('6. Row Selection'),
            buildRowSelectionDemo(),
            buildInfoCard(
              'Selection',
              'showCheckboxColumn enables row selection',
            ),

            buildSectionHeader('7. Multiple Page Sizes'),
            buildMultiplePageSizesDemo(),
            buildInfoCard(
              'Configuration',
              'availableRowsPerPage defines dropdown options',
            ),

            buildSectionHeader('8. Styled Data Table'),
            buildStyledDataTable(),
            buildInfoCard(
              'Theming',
              'Use DataTableTheme for consistent styling',
            ),

            buildSectionHeader('9. Data Source Integration'),
            buildDataSourceIntegration(),
            buildInfoCard(
              'Implementation',
              'Extend DataTableSource for custom data',
            ),

            buildSectionHeader('10. State Access Patterns'),
            buildStateAccessPatterns(),
            buildInfoCard(
              'Access',
              'GlobalKey or controller pattern for state access',
            ),

            buildSectionHeader('11. Header Actions'),
            buildActionsDemo(),
            buildInfoCard('Actions', 'Add action widgets to table header'),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('PaginatedDataTableState deep demo completed');
  return result;
}
