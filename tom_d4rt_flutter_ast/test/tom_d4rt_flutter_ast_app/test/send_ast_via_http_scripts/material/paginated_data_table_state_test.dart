// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo - PaginatedDataTableState (Material)
// Comprehensive demonstration of PaginatedDataTable with state-driven navigation,
// programmatic page control, sortable columns, row selection, and toolbar features.

import 'package:flutter/material.dart';

// =============================================================================
// SECTION 1 SOURCE: Employees - basic pagination demonstration
// =============================================================================
class _EmployeeDataSource extends DataTableSource {
  static const _names = <String>[
    'Alice Johnson', 'Bob Smith', 'Carol Davis', 'David Wilson',
    'Emma Brown', 'Frank Miller', 'Grace Lee', 'Henry Taylor',
    'Iris Chen', 'Jack Thompson', 'Kate Anderson', 'Liam Garcia',
    'Mia Rodriguez', 'Noah Martinez', 'Olivia Hernandez', 'Peter Lopez',
    'Quinn Walker', 'Rachel Hall', 'Samuel Allen', 'Tara Young',
    'Uma King', 'Victor Wright', 'Wendy Scott', 'Xavier Green',
    'Yara Adams',
  ];

  static const _departments = <String>[
    'Engineering', 'Marketing', 'Sales', 'Finance', 'HR',
  ];

  @override
  DataRow? getRow(int index) {
    if (index >= rowCount) return null;
    final name = _names[index];
    final dept = _departments[index % _departments.length];
    final salary = 55000 + (index * 1750);
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('${index + 1}')),
        DataCell(Text(name)),
        DataCell(Text(dept)),
        DataCell(Text('\$$salary')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _names.length;

  @override
  int get selectedRowCount => 0;
}

// =============================================================================
// SECTION 2 SOURCE: Transactions - programmatic pageTo navigation
// =============================================================================
class _TransactionDataSource extends DataTableSource {
  static const _categories = <String>[
    'Groceries', 'Utilities', 'Rent', 'Dining', 'Travel',
    'Entertainment', 'Health', 'Shopping',
  ];

  static const _statuses = <String>[
    'Cleared', 'Pending', 'Posted', 'Refunded',
  ];

  @override
  DataRow? getRow(int index) {
    if (index >= rowCount) return null;
    final category = _categories[index % _categories.length];
    final status = _statuses[index % _statuses.length];
    final amount = ((index * 17.31) + 12.45).toStringAsFixed(2);
    final day = ((index % 28) + 1).toString().padLeft(2, '0');
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('TX-${(2000 + index).toString()}')),
        DataCell(Text('2024-03-$day')),
        DataCell(Text(category)),
        DataCell(Text('\$$amount')),
        DataCell(Text(status)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 60;

  @override
  int get selectedRowCount => 0;
}

// =============================================================================
// SECTION 3 SOURCE: Products - custom indicator from firstRowIndex
// =============================================================================
class _ProductDataSource extends DataTableSource {
  static const _items = <String>[
    'Wireless Mouse', 'Mechanical Keyboard', 'USB-C Hub',
    'Laptop Stand', 'Desk Lamp', 'Monitor Arm', 'Webcam HD',
    'Headphones Pro', 'Microphone Studio', 'Cable Organizer',
    'Standing Desk', 'Office Chair', 'Notebook Set',
    'Pen Holder', 'Phone Mount', 'Tablet Stand',
    'External SSD', 'Power Bank', 'Wall Charger', 'Smart Plug',
  ];

  @override
  DataRow? getRow(int index) {
    if (index >= rowCount) return null;
    final price = 19.99 + (index * 4.50);
    final stock = (index * 7) % 50 + 5;
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('SKU-${1000 + index}')),
        DataCell(Text(_items[index])),
        DataCell(Text('\$${price.toStringAsFixed(2)}')),
        DataCell(Text('$stock')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _items.length;

  @override
  int get selectedRowCount => 0;
}

// =============================================================================
// SECTION 4 SOURCE: Sensor readings - rowsPerPage selector
// =============================================================================
class _SensorDataSource extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    if (index >= rowCount) return null;
    final temp = 18.0 + (index % 15) + (index % 7) * 0.3;
    final humidity = 35.0 + (index % 25);
    final pressure = 1010.0 + (index % 20) * 0.5;
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('S-${index.toString().padLeft(4, '0')}')),
        DataCell(Text('${temp.toStringAsFixed(1)}°C')),
        DataCell(Text('${humidity.toStringAsFixed(0)}%')),
        DataCell(Text('${pressure.toStringAsFixed(1)} hPa')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 80;

  @override
  int get selectedRowCount => 0;
}

// =============================================================================
// SECTION 5 SOURCE: Web requests - onPageChanged side log
// =============================================================================
class _RequestDataSource extends DataTableSource {
  static const _methods = <String>['GET', 'POST', 'PUT', 'DELETE', 'PATCH'];
  static const _paths = <String>[
    '/api/users', '/api/orders', '/api/products', '/api/auth',
    '/api/cart', '/api/checkout', '/api/inventory', '/api/reports',
  ];

  @override
  DataRow? getRow(int index) {
    if (index >= rowCount) return null;
    final method = _methods[index % _methods.length];
    final path = _paths[index % _paths.length];
    final code = (index % 5 == 0) ? 500 : (index % 3 == 0) ? 404 : 200;
    final ms = 12 + (index * 7) % 280;
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('R-${index + 1}')),
        DataCell(Text(method)),
        DataCell(Text(path)),
        DataCell(Text('$code')),
        DataCell(Text('$ms ms')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 45;

  @override
  int get selectedRowCount => 0;
}

// =============================================================================
// SECTION 6 SOURCE: Sortable scores
// =============================================================================
class _ScoreDataSource extends DataTableSource {
  final List<_ScoreRow> _rows;
  _ScoreDataSource(this._rows);

  @override
  DataRow? getRow(int index) {
    if (index >= rowCount) return null;
    final r = _rows[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('${index + 1}')),
        DataCell(Text(r.player)),
        DataCell(Text('${r.score}')),
        DataCell(Text(r.team)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _rows.length;

  @override
  int get selectedRowCount => 0;
}

class _ScoreRow {
  final String player;
  final int score;
  final String team;
  const _ScoreRow(this.player, this.score, this.team);
}

// =============================================================================
// SECTION 7 SOURCE: Selectable invoices with checkboxes
// =============================================================================
class _InvoiceDataSource extends DataTableSource {
  final Set<int> _selected;
  final void Function(int, bool) _onChanged;

  _InvoiceDataSource(this._selected, this._onChanged);

  static const _customers = <String>[
    'Acme Corp', 'Globex Inc', 'Initech LLC', 'Umbrella Co',
    'Stark Industries', 'Wayne Ent', 'Wonka Ltd', 'Soylent SA',
    'Tyrell Corp', 'Cyberdyne', 'Nakatomi', 'Oscorp',
  ];

  @override
  DataRow? getRow(int index) {
    if (index >= rowCount) return null;
    final customer = _customers[index % _customers.length];
    final amount = 250.00 + (index * 87.5);
    return DataRow.byIndex(
      index: index,
      selected: _selected.contains(index),
      onSelectChanged: (v) => _onChanged(index, v ?? false),
      cells: [
        DataCell(Text('INV-${10000 + index}')),
        DataCell(Text(customer)),
        DataCell(Text('\$${amount.toStringAsFixed(2)}')),
        DataCell(Text(index % 3 == 0 ? 'Paid' : 'Due')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _customers.length;

  @override
  int get selectedRowCount => _selected.length;
}

// =============================================================================
// SECTION 8 SOURCE: Toolbar demo (header + actions)
// =============================================================================
class _TaskDataSource extends DataTableSource {
  static const _titles = <String>[
    'Design landing page', 'Refactor auth flow', 'Write release notes',
    'Fix login bug', 'Update dependencies', 'Plan Q2 roadmap',
    'Review PR #482', 'Migrate database', 'Optimize images',
    'Deploy staging', 'Triage backlog', 'Pair on payment',
    'Document API', 'Onboard new hire', 'Investigate timeout',
  ];

  @override
  DataRow? getRow(int index) {
    if (index >= rowCount) return null;
    final t = _titles[index];
    final priority = (index % 4 == 0) ? 'High'
        : (index % 4 == 1) ? 'Medium'
            : (index % 4 == 2) ? 'Low' : 'Critical';
    final assignee = 'Dev ${(index % 6) + 1}';
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('T-${100 + index}')),
        DataCell(Text(t)),
        DataCell(Text(priority)),
        DataCell(Text(assignee)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _titles.length;

  @override
  int get selectedRowCount => 0;
}

// =============================================================================
// BUILD
// =============================================================================
dynamic build(BuildContext context) {
  print('=== PaginatedDataTableState Deep Demo ===');

  // Data sources for sections that don't need their own state holder.
  final employeeSource = _EmployeeDataSource();
  final transactionSource = _TransactionDataSource();
  final productSource = _ProductDataSource();
  final sensorSource = _SensorDataSource();
  final requestSource = _RequestDataSource();
  final taskSource = _TaskDataSource();

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'PaginatedDataTableState Deep Demo',
    theme: ThemeData(primarySwatch: Colors.indigo),
    home: Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ================================================================
              // HEADER
              // ================================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PaginatedDataTableState',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Deep Demo: Material PaginatedDataTable + State Control',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFFC5CAE9),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Pagination · State key access · Sort · Selection · Toolbar',
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Color(0xFFE8EAF6),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24.0),

              // ================================================================
              // INTRO CARD - When to use what
              // ================================================================
              _SectionCard(
                title: 'When to use PaginatedDataTable vs DataTable vs DataTable2',
                description:
                    'Pick the table widget that matches the dataset size and the '
                    'feature surface you actually need.',
                accent: const Color(0xFF455A64),
                background: const Color(0xFFECEFF1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ComparisonRow(
                      title: 'DataTable',
                      summary:
                          'Small static datasets that fit on screen. No pagination, '
                          'no built-in source abstraction. Best when row count is < 20.',
                      color: Color(0xFF26A69A),
                    ),
                    SizedBox(height: 12.0),
                    _ComparisonRow(
                      title: 'PaginatedDataTable',
                      summary:
                          'Built-in pager + DataTableSource. Good for medium-to-large '
                          'datasets where users navigate by pages. Exposes a State '
                          '(PaginatedDataTableState) so you can drive pageTo() externally.',
                      color: Color(0xFF5C6BC0),
                    ),
                    SizedBox(height: 12.0),
                    _ComparisonRow(
                      title: 'DataTable2 (third-party)',
                      summary:
                          'Same shape as DataTable / PaginatedDataTable but with '
                          'percentage-width columns, fixed scroll viewport, and '
                          'better fit-to-window behavior. Use when default sizing '
                          'is too rigid.',
                      color: Color(0xFFEF6C00),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ================================================================
              // SECTION 1: BASIC TABLE WITH BUILT-IN PAGER
              // ================================================================
              _SectionCard(
                title: '1. Basic Pagination',
                description:
                    'A vanilla PaginatedDataTable with the built-in pager controls. '
                    'Source: 25 employees, 5 rows per page. Use the arrow buttons in '
                    'the bottom-right of the table to navigate.',
                accent: const Color(0xFF2E7D32),
                background: const Color(0xFFE8F5E9),
                child: PaginatedDataTable(
                  header: const Text('Employee Directory'),
                  rowsPerPage: 5,
                  showCheckboxColumn: false,
                  columns: const [
                    DataColumn(label: Text('#'), numeric: true),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Department')),
                    DataColumn(label: Text('Salary'), numeric: true),
                  ],
                  source: employeeSource,
                ),
              ),

              const SizedBox(height: 16.0),

              // ================================================================
              // SECTION 2: PROGRAMMATIC pageTo() VIA GlobalKey
              // ================================================================
              _PageToSection(source: transactionSource),

              const SizedBox(height: 16.0),

              // ================================================================
              // SECTION 3: CUSTOM PAGE INDICATOR
              // ================================================================
              _CustomIndicatorSection(source: productSource),

              const SizedBox(height: 16.0),

              // ================================================================
              // SECTION 4: availableRowsPerPage SELECTOR
              // ================================================================
              _RowsPerPageSection(initial: 5, source: sensorSource),

              const SizedBox(height: 16.0),

              // ================================================================
              // SECTION 5: onPageChanged + LOG SIDE PANEL
              // ================================================================
              _PageLogSection(source: requestSource),

              const SizedBox(height: 16.0),

              // ================================================================
              // SECTION 6: SORTABLE COLUMNS
              // ================================================================
              _SortableSection(),

              const SizedBox(height: 16.0),

              // ================================================================
              // SECTION 7: ROW SELECTION WITH CHECKBOXES
              // ================================================================
              _SelectableSection(),

              const SizedBox(height: 16.0),

              // ================================================================
              // SECTION 8: HEADER + ACTIONS TOOLBAR
              // ================================================================
              _SectionCard(
                title: '8. header + actions Toolbar',
                description:
                    'PaginatedDataTable supports a header widget and a list of '
                    'action IconButtons. Both render above the table and are '
                    'great for filters, refresh, and bulk actions.',
                accent: const Color(0xFFEF6C00),
                background: const Color(0xFFFFF3E0),
                child: PaginatedDataTable(
                  header: const Text('Tasks'),
                  actions: [
                    IconButton(
                      tooltip: 'Refresh',
                      icon: const Icon(Icons.refresh),
                      onPressed: () => print('refresh tasks'),
                    ),
                    IconButton(
                      tooltip: 'Filter',
                      icon: const Icon(Icons.filter_list),
                      onPressed: () => print('filter tasks'),
                    ),
                    IconButton(
                      tooltip: 'Export',
                      icon: const Icon(Icons.download),
                      onPressed: () => print('export tasks'),
                    ),
                  ],
                  rowsPerPage: 5,
                  showCheckboxColumn: false,
                  columns: const [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Title')),
                    DataColumn(label: Text('Priority')),
                    DataColumn(label: Text('Assignee')),
                  ],
                  source: taskSource,
                ),
              ),

              const SizedBox(height: 24.0),

              // ================================================================
              // CAPTION FOOTER
              // ================================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cheat sheet',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      '• GlobalKey<PaginatedDataTableState> exposes pageTo() and firstRowIndex',
                      style: TextStyle(color: Color(0xFFE8EAF6), fontSize: 13.0),
                    ),
                    Text(
                      '• rowsPerPage + availableRowsPerPage + onRowsPerPageChanged drive page sizing',
                      style: TextStyle(color: Color(0xFFE8EAF6), fontSize: 13.0),
                    ),
                    Text(
                      '• onPageChanged fires every time the user navigates',
                      style: TextStyle(color: Color(0xFFE8EAF6), fontSize: 13.0),
                    ),
                    Text(
                      '• sortColumnIndex + sortAscending + DataColumn.onSort enable sortable columns',
                      style: TextStyle(color: Color(0xFFE8EAF6), fontSize: 13.0),
                    ),
                    Text(
                      '• DataRow.byIndex(selected: ..., onSelectChanged: ...) enables checkbox selection',
                      style: TextStyle(color: Color(0xFFE8EAF6), fontSize: 13.0),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      'Deep Demo · Material PaginatedDataTable',
                      style: TextStyle(
                        color: Color(0xFFC5CAE9),
                        fontSize: 11.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// SECTION 2: pageTo programmatic navigation
// =============================================================================
class _PageToSection extends StatefulWidget {
  final DataTableSource source;
  const _PageToSection({required this.source});
  @override
  State<_PageToSection> createState() => _PageToSectionState();
}

class _PageToSectionState extends State<_PageToSection> {
  final GlobalKey<PaginatedDataTableState> _tableKey =
      GlobalKey<PaginatedDataTableState>();
  int _firstRow = 0;
  static const int _perPage = 8;

  void _goto(int row) {
    _tableKey.currentState?.pageTo(row);
    // pageTo aligns to a multiple of rowsPerPage; mirror that here.
    final aligned = (row ~/ _perPage) * _perPage;
    setState(() => _firstRow = aligned);
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.source.rowCount;
    return _SectionCard(
      title: '2. Programmatic pageTo() via GlobalKey',
      description:
          'Buttons below dispatch through a GlobalKey<PaginatedDataTableState> '
          'and call state.pageTo(rowIndex) directly. The table jumps to '
          'the page that contains that row.',
      accent: const Color(0xFFC2185B),
      background: const Color(0xFFFCE4EC),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              _ActionButton(
                label: 'Go to row 0',
                color: const Color(0xFFE91E63),
                onPressed: () => _goto(0),
              ),
              _ActionButton(
                label: 'Go to row 20',
                color: const Color(0xFFE91E63),
                onPressed: () => _goto(20),
              ),
              _ActionButton(
                label: 'Go to row 40',
                color: const Color(0xFFE91E63),
                onPressed: () => _goto(40),
              ),
              _ActionButton(
                label: 'Go to last page',
                color: const Color(0xFFC2185B),
                onPressed: () => _goto(total - 1),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF8BBD9),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              'Tracked first row index: $_firstRow  ·  '
              'page ${(_firstRow ~/ _perPage) + 1} of '
              '${(total / _perPage).ceil()}',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          PaginatedDataTable(
            key: _tableKey,
            header: const Text('Transactions (60 rows)'),
            rowsPerPage: _perPage,
            showCheckboxColumn: false,
            onPageChanged: (firstRow) =>
                setState(() => _firstRow = firstRow),
            columns: const [
              DataColumn(label: Text('TX')),
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Category')),
              DataColumn(label: Text('Amount'), numeric: true),
              DataColumn(label: Text('Status')),
            ],
            source: widget.source,
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 3: Custom indicator from tracked first row index
// =============================================================================
class _CustomIndicatorSection extends StatefulWidget {
  final DataTableSource source;
  const _CustomIndicatorSection({required this.source});
  @override
  State<_CustomIndicatorSection> createState() =>
      _CustomIndicatorSectionState();
}

class _CustomIndicatorSectionState extends State<_CustomIndicatorSection> {
  final GlobalKey<PaginatedDataTableState> _tableKey =
      GlobalKey<PaginatedDataTableState>();
  int _firstRow = 0;
  static const int _perPage = 6;

  @override
  Widget build(BuildContext context) {
    final total = widget.source.rowCount;
    final pageNumber = (_firstRow ~/ _perPage) + 1;
    final pageCount = (total / _perPage).ceil();
    return _SectionCard(
      title: '3. Custom Indicator from tracked first row index',
      description:
          'A side panel renders the current page number, total pages, '
          'a progress bar, and clickable page dots. State is tracked via '
          'onPageChanged plus a GlobalKey<PaginatedDataTableState>.pageTo().',
      accent: const Color(0xFF6A1B9A),
      background: const Color(0xFFF3E5F5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: const Color(0xFFE1BEE7),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Page $pageNumber of $pageCount  ·  '
                  'firstRowIndex = $_firstRow',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: LinearProgressIndicator(
                    value: pageCount == 0 ? 0.0 : pageNumber / pageCount,
                    backgroundColor: const Color(0xFFFFFFFF),
                    valueColor: const AlwaysStoppedAnimation(
                      Color(0xFF8E24AA),
                    ),
                    minHeight: 8.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                Wrap(
                  spacing: 6.0,
                  children: [
                    for (var i = 0; i < pageCount; i++)
                      _PageDot(
                        number: i + 1,
                        active: i + 1 == pageNumber,
                        onTap: () {
                          _tableKey.currentState?.pageTo(i * _perPage);
                          setState(() => _firstRow = i * _perPage);
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          PaginatedDataTable(
            key: _tableKey,
            header: const Text('Products'),
            rowsPerPage: _perPage,
            showCheckboxColumn: false,
            onPageChanged: (firstRow) =>
                setState(() => _firstRow = firstRow),
            columns: const [
              DataColumn(label: Text('SKU')),
              DataColumn(label: Text('Item')),
              DataColumn(label: Text('Price'), numeric: true),
              DataColumn(label: Text('Stock'), numeric: true),
            ],
            source: widget.source,
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 4: rowsPerPage selector (extracted for state)
// =============================================================================
class _RowsPerPageSection extends StatefulWidget {
  final int initial;
  final DataTableSource source;
  const _RowsPerPageSection({required this.initial, required this.source});
  @override
  State<_RowsPerPageSection> createState() => _RowsPerPageSectionState();
}

class _RowsPerPageSectionState extends State<_RowsPerPageSection> {
  late int _rowsPerPage;

  @override
  void initState() {
    super.initState();
    _rowsPerPage = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: '4. availableRowsPerPage Selector',
      description:
          'PaginatedDataTable shows a "Rows per page" dropdown that lists the values '
          'you pass in availableRowsPerPage. onRowsPerPageChanged fires when the '
          'user picks a different value.',
      accent: const Color(0xFF00838F),
      background: const Color(0xFFE0F7FA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: const Color(0xFFB2EBF2),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              'Currently displaying $_rowsPerPage rows per page',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          PaginatedDataTable(
            header: const Text('Sensor Telemetry'),
            rowsPerPage: _rowsPerPage,
            availableRowsPerPage: const [5, 10, 15, 20],
            showCheckboxColumn: false,
            onRowsPerPageChanged: (value) {
              if (value != null) {
                setState(() => _rowsPerPage = value);
              }
            },
            columns: const [
              DataColumn(label: Text('Sensor')),
              DataColumn(label: Text('Temperature')),
              DataColumn(label: Text('Humidity')),
              DataColumn(label: Text('Pressure')),
            ],
            source: widget.source,
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 5: onPageChanged log
// =============================================================================
class _PageLogSection extends StatefulWidget {
  final DataTableSource source;
  const _PageLogSection({required this.source});
  @override
  State<_PageLogSection> createState() => _PageLogSectionState();
}

class _PageLogSectionState extends State<_PageLogSection> {
  final List<String> _log = <String>[];

  void _record(int firstRow) {
    setState(() {
      _log.insert(0, 'firstRowIndex -> $firstRow');
      if (_log.length > 8) _log.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: '5. onPageChanged Callback Log',
      description:
          'A side panel collects every onPageChanged event. Use the table pager '
          'to see entries appear in real time.',
      accent: const Color(0xFF1565C0),
      background: const Color(0xFFE3F2FD),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: const Color(0xFF263238),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Event log',
                  style: TextStyle(
                    color: Color(0xFF80DEEA),
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6.0),
                if (_log.isEmpty)
                  const Text(
                    '(no events yet — change pages on the table below)',
                    style: TextStyle(
                      color: Color(0xFFB0BEC5),
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                    ),
                  )
                else
                  for (final entry in _log)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: Text(
                        entry,
                        style: const TextStyle(
                          color: Color(0xFFB3E5FC),
                          fontFamily: 'monospace',
                          fontSize: 11.0,
                        ),
                      ),
                    ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          PaginatedDataTable(
            header: const Text('HTTP Request Log'),
            rowsPerPage: 5,
            showCheckboxColumn: false,
            onPageChanged: _record,
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Method')),
              DataColumn(label: Text('Path')),
              DataColumn(label: Text('Code'), numeric: true),
              DataColumn(label: Text('Latency'), numeric: true),
            ],
            source: widget.source,
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 6: Sortable columns
// =============================================================================
class _SortableSection extends StatefulWidget {
  @override
  State<_SortableSection> createState() => _SortableSectionState();
}

class _SortableSectionState extends State<_SortableSection> {
  int? _sortColumnIndex = 2;
  bool _sortAscending = false;

  late final List<_ScoreRow> _rows = <_ScoreRow>[
    const _ScoreRow('Aria', 1820, 'Phoenix'),
    const _ScoreRow('Bren', 940, 'Hydra'),
    const _ScoreRow('Caleb', 2410, 'Phoenix'),
    const _ScoreRow('Dora', 1175, 'Kraken'),
    const _ScoreRow('Eli', 1520, 'Hydra'),
    const _ScoreRow('Fiona', 2090, 'Kraken'),
    const _ScoreRow('Gabe', 800, 'Phoenix'),
    const _ScoreRow('Hana', 1380, 'Hydra'),
    const _ScoreRow('Ira', 2260, 'Kraken'),
    const _ScoreRow('Jules', 1100, 'Phoenix'),
    const _ScoreRow('Kira', 1645, 'Hydra'),
    const _ScoreRow('Lex', 2740, 'Kraken'),
  ];

  void _sortBy<T extends Comparable<T>>(T Function(_ScoreRow r) getter,
      int columnIndex, bool ascending) {
    _rows.sort((a, b) {
      final ax = getter(a);
      final bx = getter(b);
      return ascending ? ax.compareTo(bx) : bx.compareTo(ax);
    });
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    final source = _ScoreDataSource(_rows);
    return _SectionCard(
      title: '6. Sortable Columns',
      description:
          'Set sortColumnIndex and sortAscending on the PaginatedDataTable, and '
          'wire DataColumn.onSort to mutate the underlying list. The header '
          'arrows reflect the current sort.',
      accent: const Color(0xFFAD1457),
      background: const Color(0xFFFCE4EC),
      child: PaginatedDataTable(
        header: const Text('Leaderboard'),
        rowsPerPage: 6,
        showCheckboxColumn: false,
        sortColumnIndex: _sortColumnIndex,
        sortAscending: _sortAscending,
        columns: [
          const DataColumn(label: Text('Rank'), numeric: true),
          DataColumn(
            label: const Text('Player'),
            onSort: (i, asc) => _sortBy<String>((r) => r.player, i, asc),
          ),
          DataColumn(
            label: const Text('Score'),
            numeric: true,
            onSort: (i, asc) => _sortBy<num>((r) => r.score, i, asc),
          ),
          DataColumn(
            label: const Text('Team'),
            onSort: (i, asc) => _sortBy<String>((r) => r.team, i, asc),
          ),
        ],
        source: source,
      ),
    );
  }
}

// =============================================================================
// SECTION 7: Selectable rows
// =============================================================================
class _SelectableSection extends StatefulWidget {
  @override
  State<_SelectableSection> createState() => _SelectableSectionState();
}

class _SelectableSectionState extends State<_SelectableSection> {
  final Set<int> _selected = <int>{};

  void _toggle(int index, bool value) {
    setState(() {
      if (value) {
        _selected.add(index);
      } else {
        _selected.remove(index);
      }
    });
  }

  void _selectAll(bool? value, int total) {
    setState(() {
      _selected.clear();
      if (value ?? false) {
        for (var i = 0; i < total; i++) {
          _selected.add(i);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final source = _InvoiceDataSource(_selected, _toggle);
    final total = source.rowCount;
    return _SectionCard(
      title: '7. Row Selection with Checkboxes',
      description:
          'DataRow.byIndex with selected + onSelectChanged enables per-row '
          'checkboxes. PaginatedDataTable.onSelectAll handles the master '
          'checkbox. selectedRowCount drives the contextual header.',
      accent: const Color(0xFF6A1B9A),
      background: const Color(0xFFEDE7F6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: const Color(0xFFD1C4E9),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              '${_selected.length} of $total invoices selected',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          PaginatedDataTable(
            header: Text(_selected.isEmpty
                ? 'Invoices'
                : '${_selected.length} selected'),
            actions: _selected.isEmpty
                ? null
                : [
                    IconButton(
                      tooltip: 'Mark paid',
                      icon: const Icon(Icons.check_circle),
                      onPressed: () => print('mark paid: $_selected'),
                    ),
                    IconButton(
                      tooltip: 'Clear selection',
                      icon: const Icon(Icons.clear),
                      onPressed: () => setState(() => _selected.clear()),
                    ),
                  ],
            rowsPerPage: 6,
            onSelectAll: (v) => _selectAll(v, total),
            columns: const [
              DataColumn(label: Text('Invoice')),
              DataColumn(label: Text('Customer')),
              DataColumn(label: Text('Amount'), numeric: true),
              DataColumn(label: Text('Status')),
            ],
            source: source,
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// REUSABLE UI HELPERS
// =============================================================================
class _SectionCard extends StatelessWidget {
  final String title;
  final String description;
  final Color accent;
  final Color background;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.description,
    required this.accent,
    required this.background,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: accent.withOpacity(0.4), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: accent,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12.0,
              color: Color(0xFF424242),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14.0),
          child,
          const SizedBox(height: 8.0),
          Text(
            'Caption: live demo of "$title"',
            style: TextStyle(
              fontSize: 10.0,
              fontStyle: FontStyle.italic,
              color: accent.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}

class _ComparisonRow extends StatelessWidget {
  final String title;
  final String summary;
  final Color color;
  const _ComparisonRow({
    required this.title,
    required this.summary,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8.0,
            height: 56.0,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  summary,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFF424242),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;
  const _ActionButton({
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: const Color(0xFFFFFFFF),
        padding:
            const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

class _PageDot extends StatelessWidget {
  final int number;
  final bool active;
  final VoidCallback onTap;
  const _PageDot({
    required this.number,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        width: 28.0,
        height: 28.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? const Color(0xFF8E24AA) : const Color(0xFFFFFFFF),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF8E24AA), width: 1.0),
        ),
        child: Text(
          '$number',
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: active
                ? const Color(0xFFFFFFFF)
                : const Color(0xFF8E24AA),
          ),
        ),
      ),
    );
  }
}
