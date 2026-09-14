// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: hand-authored deep visual demo for DataTable,
// DataRow, DataColumn, DataCell and PaginatedDataTable
// An exhaustive guided tour of Material data-table widgets covering every
// constructor parameter, theme surface, sortable column wiring, selection
// state, divider thickness, column spacing, and the DataTableSource contract
// required by PaginatedDataTable. The demo is composed of seven distinct
// visual sections rendered into a single scrollable Scaffold.
import 'package:flutter/material.dart';

// ============================================================
// SHARED PALETTE
// ============================================================
// Slate gives a neutral page surface that does not compete with the
// table's own zebra striping. Indigo carries the "data" semantic — it
// is reserved for headings, sort chevrons, and selection accents.
// Amber/emerald/rose are used semantically for status pills inside
// table cells so the reader can tell at a glance which value column
// they belong to.
const Color kSlate50 = Color(0xFFF8FAFC);
const Color kSlate100 = Color(0xFFF1F5F9);
const Color kSlate200 = Color(0xFFE2E8F0);
const Color kSlate300 = Color(0xFFCBD5E1);
const Color kSlate400 = Color(0xFF94A3B8);
const Color kSlate500 = Color(0xFF64748B);
const Color kSlate600 = Color(0xFF475569);
const Color kSlate700 = Color(0xFF334155);
const Color kSlate800 = Color(0xFF1E293B);
const Color kSlate900 = Color(0xFF0F172A);
const Color kIndigo50 = Color(0xFFEEF2FF);
const Color kIndigo100 = Color(0xFFE0E7FF);
const Color kIndigo200 = Color(0xFFC7D2FE);
const Color kIndigo400 = Color(0xFF818CF8);
const Color kIndigo500 = Color(0xFF6366F1);
const Color kIndigo600 = Color(0xFF4F46E5);
const Color kIndigo700 = Color(0xFF4338CA);
const Color kIndigo800 = Color(0xFF3730A3);
const Color kIndigo900 = Color(0xFF312E81);
const Color kEmerald100 = Color(0xFFD1FAE5);
const Color kEmerald500 = Color(0xFF10B981);
const Color kEmerald700 = Color(0xFF047857);
const Color kAmber100 = Color(0xFFFEF3C7);
const Color kAmber500 = Color(0xFFF59E0B);
const Color kAmber700 = Color(0xFFB45309);
const Color kRose100 = Color(0xFFFFE4E6);
const Color kRose500 = Color(0xFFF43F5E);
const Color kRose700 = Color(0xFFBE123C);
const Color kCyan100 = Color(0xFFCFFAFE);
const Color kCyan500 = Color(0xFF06B6D4);
const Color kCyan700 = Color(0xFF0E7490);
const Color kViolet500 = Color(0xFF8B5CF6);

// ============================================================
// EMPLOYEE RECORDS — shared corpus
// ============================================================
// Every section reuses the same fictional roster so the reader can
// follow the same data through different presentation styles. We hold
// it in plain const-style lists; no mutation, no controllers.
class _Employee {
  const _Employee({
    required this.id,
    required this.name,
    required this.role,
    required this.department,
    required this.salary,
    required this.tenureYears,
    required this.status,
    required this.location,
  });

  final int id;
  final String name;
  final String role;
  final String department;
  final int salary;
  final double tenureYears;
  final String status;
  final String location;
}

const List<_Employee> _kEmployees = <_Employee>[
  _Employee(
    id: 1001,
    name: 'Ada Lovelace',
    role: 'Principal Engineer',
    department: 'Platform',
    salary: 215000,
    tenureYears: 8.5,
    status: 'Active',
    location: 'London',
  ),
  _Employee(
    id: 1002,
    name: 'Linus Torvalds',
    role: 'Kernel Architect',
    department: 'Core',
    salary: 198000,
    tenureYears: 11.0,
    status: 'Active',
    location: 'Portland',
  ),
  _Employee(
    id: 1003,
    name: 'Grace Hopper',
    role: 'Compiler Lead',
    department: 'Languages',
    salary: 188000,
    tenureYears: 6.25,
    status: 'On leave',
    location: 'Arlington',
  ),
  _Employee(
    id: 1004,
    name: 'Donald Knuth',
    role: 'Distinguished Researcher',
    department: 'Algorithms',
    salary: 225000,
    tenureYears: 14.75,
    status: 'Active',
    location: 'Palo Alto',
  ),
  _Employee(
    id: 1005,
    name: 'Margaret Hamilton',
    role: 'Software Director',
    department: 'Avionics',
    salary: 232000,
    tenureYears: 9.0,
    status: 'Active',
    location: 'Boston',
  ),
  _Employee(
    id: 1006,
    name: 'Edsger Dijkstra',
    role: 'Algorithms Engineer',
    department: 'Algorithms',
    salary: 175000,
    tenureYears: 4.5,
    status: 'Pending',
    location: 'Eindhoven',
  ),
  _Employee(
    id: 1007,
    name: 'Barbara Liskov',
    role: 'Type Systems Lead',
    department: 'Languages',
    salary: 205000,
    tenureYears: 12.0,
    status: 'Active',
    location: 'Cambridge',
  ),
  _Employee(
    id: 1008,
    name: 'Niklaus Wirth',
    role: 'Senior Engineer',
    department: 'Tooling',
    salary: 168000,
    tenureYears: 3.0,
    status: 'Active',
    location: 'Zurich',
  ),
  _Employee(
    id: 1009,
    name: 'Tony Hoare',
    role: 'Verification Lead',
    department: 'Core',
    salary: 199000,
    tenureYears: 7.75,
    status: 'On leave',
    location: 'Oxford',
  ),
  _Employee(
    id: 1010,
    name: 'Hedy Lamarr',
    role: 'Wireless Architect',
    department: 'Hardware',
    salary: 182000,
    tenureYears: 5.5,
    status: 'Active',
    location: 'Vienna',
  ),
];

// ============================================================
// SECTION BUILDER — entry point
// ============================================================
dynamic build(BuildContext context) {
  print('================================================================');
  print('DataTable deep visual demo — beginning render walkthrough');
  print('================================================================');
  print('Corpus contains ${_kEmployees.length} employee records');

  final Widget hero = _buildHeroSection();
  print('Section 1/7 :: hero header composed');

  final Widget anatomy = _buildAnatomyReference();
  print('Section 2/7 :: anatomy reference card composed');

  final Widget basicGallery = _buildBasicGallery();
  print('Section 3/7 :: basic table gallery composed');

  final Widget sortable = _buildSortableSection();
  print('Section 4/7 :: sortable table section composed');

  final Widget selectable = _buildSelectableSection();
  print('Section 5/7 :: selectable table with checkbox column composed');

  final Widget themeGrid = _buildThemeComparisonGrid();
  print('Section 6/7 :: theme comparison grid composed');

  final Widget headerStyling = _buildHeaderStylingShowcase();
  print('Section 7a/8 :: heading row styling showcase composed');

  final Widget paginated = _buildPaginatedSection();
  print('Section 7b/8 :: paginated table mockup composed');

  final Widget cheatSheet = _buildCheatSheet();
  print('Section 8/8 :: cheat sheet composed');

  print('All sections composed — handing off to Scaffold');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'DataTable Deep Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: kIndigo600),
      useMaterial3: true,
      scaffoldBackgroundColor: kSlate50,
      dataTableTheme: const DataTableThemeData(
        headingRowHeight: 56.0,
        dataRowMinHeight: 48.0,
        dataRowMaxHeight: 64.0,
        horizontalMargin: 20.0,
        columnSpacing: 32.0,
        dividerThickness: 1.0,
      ),
    ),
    home: Scaffold(
      backgroundColor: kSlate50,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              hero,
              const SizedBox(height: 28.0),
              anatomy,
              const SizedBox(height: 28.0),
              basicGallery,
              const SizedBox(height: 28.0),
              sortable,
              const SizedBox(height: 28.0),
              selectable,
              const SizedBox(height: 28.0),
              themeGrid,
              const SizedBox(height: 28.0),
              headerStyling,
              const SizedBox(height: 28.0),
              paginated,
              const SizedBox(height: 28.0),
              cheatSheet,
              const SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================
// SECTION 1 — HERO HEADER
// ============================================================
Widget _buildHeroSection() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(28.0, 32.0, 28.0, 32.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[kIndigo900, kIndigo700, kIndigo500],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kIndigo900.withValues(alpha: 0.35),
          blurRadius: 24.0,
          offset: const Offset(0.0, 12.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _miniTableGlyph(),
            const SizedBox(width: 18.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Material DataTable',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.6,
                      height: 1.05,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Deep tour: every parameter, every theme surface',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 22.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: <Widget>[
            _heroPill('DataTable'),
            _heroPill('DataColumn'),
            _heroPill('DataRow'),
            _heroPill('DataCell'),
            _heroPill('PaginatedDataTable'),
            _heroPill('DataTableSource'),
            _heroPill('DataTableThemeData'),
            _heroPill('WidgetStateProperty'),
          ],
        ),
        const SizedBox(height: 22.0),
        Text(
          'DataTable is a fully realised grid widget that adheres to the '
          'Material spec for sortable, selectable tabular data. It is laid '
          'out using a Flutter Table internally, which means it sizes each '
          'column to the widest cell in that column. Use it for small to '
          'medium datasets where every row fits in memory; reach for '
          'PaginatedDataTable when you need slicing, paging, and a '
          'DataTableSource.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.92),
            fontSize: 14.0,
            height: 1.55,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}

Widget _miniTableGlyph() {
  return Container(
    width: 76.0,
    height: 76.0,
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.35),
        width: 1.2,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _glyphRow(filled: true),
          const SizedBox(height: 3.0),
          _glyphRow(filled: false),
          const SizedBox(height: 3.0),
          _glyphRow(filled: false),
          const SizedBox(height: 3.0),
          _glyphRow(filled: false),
        ],
      ),
    ),
  );
}

Widget _glyphRow({required bool filled}) {
  return Row(
    children: <Widget>[
      Expanded(
        flex: 3,
        child: Container(
          height: 9.0,
          decoration: BoxDecoration(
            color: filled
                ? Colors.white.withValues(alpha: 0.95)
                : Colors.white.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
      ),
      const SizedBox(width: 4.0),
      Expanded(
        flex: 2,
        child: Container(
          height: 9.0,
          decoration: BoxDecoration(
            color: filled
                ? Colors.white.withValues(alpha: 0.85)
                : Colors.white.withValues(alpha: 0.40),
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
      ),
      const SizedBox(width: 4.0),
      Expanded(
        flex: 2,
        child: Container(
          height: 9.0,
          decoration: BoxDecoration(
            color: filled
                ? Colors.white.withValues(alpha: 0.70)
                : Colors.white.withValues(alpha: 0.30),
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
      ),
    ],
  );
}

Widget _heroPill(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.35),
        width: 1.0,
      ),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12.0,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.3,
      ),
    ),
  );
}

// ============================================================
// SECTION 2 — ANATOMY REFERENCE CARD
// ============================================================
// A static call-out card that labels every region of a DataTable.
// We render a real, tiny DataTable and surround it with text labels
// pointing to its anatomy — heading row, data rows, columns, cells,
// optional checkbox column, sort indicator, and bottom border.
Widget _buildAnatomyReference() {
  return _sectionCard(
    title: 'Anatomy of a DataTable',
    subtitle:
        'A DataTable is composed of a heading row, an optional checkbox '
        'column, one or more DataColumns, and a list of DataRows where '
        'each row contains the same number of DataCells as there are '
        'columns. The sort indicator lives in the heading cell whose '
        'index equals sortColumnIndex.',
    accent: kIndigo500,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'The annotated diagram below is a real, fully-functional '
          'DataTable rendered with showCheckboxColumn: true and a '
          'sortColumnIndex of 1 (the Salary column). Every label points '
          'to a region you can configure independently.',
          style: TextStyle(
            color: kSlate700,
            fontSize: 13.5,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: kSlate100,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: kSlate200, width: 1.0),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              showCheckboxColumn: true,
              showBottomBorder: true,
              sortColumnIndex: 1,
              sortAscending: false,
              headingRowHeight: 52.0,
              dataRowMinHeight: 44.0,
              dataRowMaxHeight: 52.0,
              horizontalMargin: 16.0,
              columnSpacing: 28.0,
              dividerThickness: 1.0,
              headingRowColor: WidgetStateProperty.all(kIndigo50),
              headingTextStyle: const TextStyle(
                color: kIndigo800,
                fontWeight: FontWeight.w800,
                fontSize: 13.0,
                letterSpacing: 0.3,
              ),
              dataTextStyle: const TextStyle(
                color: kSlate800,
                fontSize: 13.0,
              ),
              border: TableBorder.symmetric(
                inside: const BorderSide(color: kSlate300, width: 0.6),
              ),
              columns: <DataColumn>[
                const DataColumn(
                  label: Text('Engineer'),
                  tooltip: 'Full name of the engineer',
                ),
                DataColumn(
                  label: const Text('Salary (USD)'),
                  numeric: true,
                  tooltip: 'Annual base salary in US dollars',
                  onSort: (int _, bool _) {},
                ),
                const DataColumn(
                  label: Text('Status'),
                ),
              ],
              rows: <DataRow>[
                DataRow(
                  selected: true,
                  onSelectChanged: (bool? _) {},
                  cells: const <DataCell>[
                    DataCell(Text('Ada Lovelace')),
                    DataCell(Text(r'$215,000')),
                    DataCell(Text('Active')),
                  ],
                ),
                DataRow(
                  selected: false,
                  onSelectChanged: (bool? _) {},
                  cells: const <DataCell>[
                    DataCell(Text('Margaret Hamilton')),
                    DataCell(Text(r'$232,000')),
                    DataCell(Text('Active')),
                  ],
                ),
                DataRow(
                  selected: false,
                  onSelectChanged: (bool? _) {},
                  cells: const <DataCell>[
                    DataCell(Text('Grace Hopper')),
                    DataCell(Text(r'$188,000')),
                    DataCell(Text('On leave')),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18.0),
        _anatomyLegend(),
      ],
    ),
  );
}

Widget _anatomyLegend() {
  return Wrap(
    spacing: 12.0,
    runSpacing: 12.0,
    children: <Widget>[
      _legendChip(kIndigo50, kIndigo800, 'headingRowColor'),
      _legendChip(kSlate100, kSlate800, 'dataRowColor (default)'),
      _legendChip(kIndigo200, kIndigo900, 'selected row tint'),
      _legendChip(Colors.white, kSlate800, 'showCheckboxColumn'),
      _legendChip(kIndigo50, kIndigo700, 'sort indicator cell'),
      _legendChip(kSlate200, kSlate700, 'dividerThickness'),
    ],
  );
}

Widget _legendChip(Color swatch, Color textColor, String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: kSlate200, width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 14.0,
          height: 14.0,
          decoration: BoxDecoration(
            color: swatch,
            borderRadius: BorderRadius.circular(3.0),
            border: Border.all(color: kSlate300, width: 0.5),
          ),
        ),
        const SizedBox(width: 8.0),
        Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// SECTION 3 — BASIC GALLERY
// ============================================================
// Demonstrates three flavors of a plain DataTable: minimal, padded,
// and decorated. All three render the same first four employees so the
// only visible difference is configuration.
Widget _buildBasicGallery() {
  return _sectionCard(
    title: 'Basic gallery — minimal, padded, decorated',
    subtitle:
        'Three calibrations of the same data. Notice how horizontalMargin '
        'and columnSpacing alone can completely change the perceived '
        'density of a table.',
    accent: kCyan500,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _subHeading('1. Minimal — zero decoration, defaults only'),
        _explainer(
          'No border, no decoration, no row colors. The bare-bones '
          'DataTable still inherits dividerThickness from the active '
          'DataTableThemeData on the surrounding Theme.',
        ),
        const SizedBox(height: 10.0),
        _tableShell(
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Role')),
              DataColumn(label: Text('Dept.')),
              DataColumn(label: Text('Salary'), numeric: true),
            ],
            rows: _basicRows().take(4).toList(),
          ),
        ),
        const SizedBox(height: 24.0),
        _subHeading('2. Padded — generous horizontalMargin and columnSpacing'),
        _explainer(
          'horizontalMargin: 32 inserts whitespace on the leading and '
          'trailing edges of the table. columnSpacing: 56 increases the '
          'gap between each column boundary.',
        ),
        const SizedBox(height: 10.0),
        _tableShell(
          child: DataTable(
            horizontalMargin: 32.0,
            columnSpacing: 56.0,
            headingRowHeight: 60.0,
            dataRowMinHeight: 56.0,
            dataRowMaxHeight: 64.0,
            dividerThickness: 0.6,
            columns: const <DataColumn>[
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Role')),
              DataColumn(label: Text('Dept.')),
              DataColumn(label: Text('Salary'), numeric: true),
            ],
            rows: _basicRows().take(4).toList(),
          ),
        ),
        const SizedBox(height: 24.0),
        _subHeading('3. Decorated — full BoxDecoration + TableBorder'),
        _explainer(
          'A BoxDecoration wraps the entire DataTable, while TableBorder '
          'controls the internal grid. The two are independent — pick '
          'one or layer both as we do here.',
        ),
        const SizedBox(height: 10.0),
        DataTable(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: kIndigo200, width: 1.2),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: kIndigo900.withValues(alpha: 0.08),
                blurRadius: 16.0,
                offset: const Offset(0.0, 6.0),
              ),
            ],
          ),
          border: TableBorder(
            top: BorderSide.none,
            bottom: BorderSide.none,
            left: BorderSide.none,
            right: BorderSide.none,
            horizontalInside: const BorderSide(color: kIndigo100, width: 1.0),
            verticalInside: const BorderSide(color: kIndigo100, width: 1.0),
          ),
          headingRowColor: WidgetStateProperty.all(kIndigo50),
          headingTextStyle: const TextStyle(
            color: kIndigo800,
            fontWeight: FontWeight.w800,
            fontSize: 13.0,
          ),
          dataTextStyle: const TextStyle(
            color: kSlate800,
            fontSize: 13.0,
          ),
          horizontalMargin: 20.0,
          columnSpacing: 28.0,
          dividerThickness: 0.0,
          columns: const <DataColumn>[
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Role')),
            DataColumn(label: Text('Dept.')),
            DataColumn(label: Text('Salary'), numeric: true),
          ],
          rows: _basicRows().take(4).toList(),
        ),
      ],
    ),
  );
}

List<DataRow> _basicRows() {
  final List<DataRow> rows = <DataRow>[];
  for (int i = 0; i < _kEmployees.length; i++) {
    final _Employee e = _kEmployees[i];
    rows.add(
      DataRow(
        cells: <DataCell>[
          DataCell(Text(e.name)),
          DataCell(Text(e.role)),
          DataCell(Text(e.department)),
          DataCell(Text(_money(e.salary))),
        ],
      ),
    );
  }
  return rows;
}

// ============================================================
// SECTION 4 — SORTABLE TABLE
// ============================================================
// Demonstrates the sort wiring. We render the employees ordered by
// salary descending and surface the sortColumnIndex / sortAscending
// controls. The onSort callback is a no-op — the demo is visual only —
// but the chevron renders because we provide it.
Widget _buildSortableSection() {
  return _sectionCard(
    title: 'Sortable columns — sortColumnIndex & onSort',
    subtitle:
        'DataTable does not sort data for you. It renders the chevron in '
        'the heading cell at sortColumnIndex and calls the onSort '
        'callback of any column that supplies one. You sort the row list '
        'yourself before passing it in.',
    accent: kEmerald500,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _explainer(
          'In this example sortColumnIndex is 3 (Salary) and '
          'sortAscending is false — so the chevron points down on the '
          'Salary heading. We pre-sorted the rows by salary descending '
          'before passing them to DataTable. Tapping a different heading '
          'in a real app would trigger that column\'s onSort with the '
          'new column index and direction; you would then re-sort the '
          'list and rebuild.',
        ),
        const SizedBox(height: 14.0),
        _tableShell(
          child: DataTable(
            sortColumnIndex: 3,
            sortAscending: false,
            headingRowColor: WidgetStateProperty.all(kEmerald100),
            headingTextStyle: const TextStyle(
              color: kEmerald700,
              fontWeight: FontWeight.w800,
              fontSize: 13.0,
              letterSpacing: 0.4,
            ),
            dataTextStyle: const TextStyle(
              color: kSlate800,
              fontSize: 13.0,
            ),
            dividerThickness: 1.2,
            horizontalMargin: 18.0,
            columnSpacing: 28.0,
            columns: <DataColumn>[
              DataColumn(
                label: const Text('Name'),
                tooltip: 'Sort by employee name (alphabetical)',
                onSort: (int _, bool _) {},
              ),
              DataColumn(
                label: const Text('Role'),
                tooltip: 'Sort by primary job title',
                onSort: (int _, bool _) {},
              ),
              DataColumn(
                label: const Text('Tenure'),
                numeric: true,
                tooltip: 'Sort by tenure in years',
                onSort: (int _, bool _) {},
              ),
              DataColumn(
                label: const Text('Salary'),
                numeric: true,
                tooltip: 'Sort by annual salary (USD)',
                onSort: (int _, bool _) {},
              ),
            ],
            rows: _sortableRows(),
          ),
        ),
        const SizedBox(height: 18.0),
        _kvpRow('sortColumnIndex', '3 (Salary column)'),
        _kvpRow('sortAscending', 'false (descending)'),
        _kvpRow('onSort signature', '(int columnIndex, bool ascending)'),
        _kvpRow(
          'chevron rules',
          'Rendered automatically when onSort is non-null AND the '
              'column\'s index matches sortColumnIndex.',
        ),
        _kvpRow(
          'numeric: true',
          'Right-aligns cell content and label; convention for numbers.',
        ),
      ],
    ),
  );
}

List<DataRow> _sortableRows() {
  // Build a copy and sort by salary descending without mutating the
  // shared corpus.
  final List<_Employee> sorted = <_Employee>[];
  for (int i = 0; i < _kEmployees.length; i++) {
    sorted.add(_kEmployees[i]);
  }
  sorted.sort((_Employee a, _Employee b) => b.salary.compareTo(a.salary));

  final List<DataRow> rows = <DataRow>[];
  for (int i = 0; i < sorted.length; i++) {
    final _Employee e = sorted[i];
    rows.add(
      DataRow(
        cells: <DataCell>[
          DataCell(Text(e.name)),
          DataCell(Text(e.role)),
          DataCell(Text(_tenure(e.tenureYears))),
          DataCell(Text(_money(e.salary))),
        ],
      ),
    );
  }
  return rows;
}

// ============================================================
// SECTION 5 — SELECTABLE TABLE WITH CHECKBOXES
// ============================================================
// Demonstrates the selection surface: showCheckboxColumn, DataRow.
// selected, DataRow.color via WidgetStateProperty, and the
// onSelectChanged callback. Selection is visual only in this demo.
Widget _buildSelectableSection() {
  return _sectionCard(
    title: 'Selectable rows — checkbox column & WidgetStateProperty',
    subtitle:
        'DataTable adds a checkbox column on the leading edge when '
        'showCheckboxColumn is true AND at least one DataRow has a '
        'non-null onSelectChanged. The row\'s selected flag drives both '
        'the checkbox visual and any WidgetStateProperty<Color> bound '
        'to the row.color slot.',
    accent: kRose500,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _explainer(
          'We mark rows 1, 3 and 5 selected. A WidgetStateProperty '
          'resolves the row tint by inspecting WidgetState.selected. '
          'The checkbox row also responds to hover and pressed if you '
          'wire those states. checkboxHorizontalMargin controls how '
          'tightly the checkbox hugs the leading edge.',
        ),
        const SizedBox(height: 14.0),
        _tableShell(
          child: DataTable(
            showCheckboxColumn: true,
            checkboxHorizontalMargin: 14.0,
            horizontalMargin: 16.0,
            columnSpacing: 28.0,
            dividerThickness: 1.0,
            headingRowColor: WidgetStateProperty.all(kRose100),
            headingTextStyle: const TextStyle(
              color: kRose700,
              fontWeight: FontWeight.w800,
              fontSize: 13.0,
              letterSpacing: 0.3,
            ),
            dataRowColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return kRose100.withValues(alpha: 0.55);
                }
                return null;
              },
            ),
            columns: const <DataColumn>[
              DataColumn(label: Text('Engineer')),
              DataColumn(label: Text('Location')),
              DataColumn(label: Text('Department')),
              DataColumn(label: Text('Status')),
            ],
            rows: _selectableRows(),
          ),
        ),
        const SizedBox(height: 18.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: <Widget>[
            _badge(
              'showCheckboxColumn',
              'true',
              kRose500,
              kRose100,
            ),
            _badge(
              'checkboxHorizontalMargin',
              '14.0',
              kRose500,
              kRose100,
            ),
            _badge(
              'DataRow.selected',
              '3 rows = true',
              kRose500,
              kRose100,
            ),
            _badge(
              'dataRowColor',
              'WidgetStateProperty.resolveWith',
              kRose500,
              kRose100,
            ),
          ],
        ),
      ],
    ),
  );
}

List<DataRow> _selectableRows() {
  final List<DataRow> rows = <DataRow>[];
  for (int i = 0; i < _kEmployees.length; i++) {
    final _Employee e = _kEmployees[i];
    final bool isSelected = i == 1 || i == 3 || i == 5;
    rows.add(
      DataRow(
        selected: isSelected,
        onSelectChanged: (bool? _) {},
        cells: <DataCell>[
          DataCell(Text(e.name)),
          DataCell(Text(e.location)),
          DataCell(Text(e.department)),
          DataCell(_statusPill(e.status)),
        ],
      ),
    );
  }
  return rows;
}

Widget _statusPill(String status) {
  Color bg;
  Color fg;
  switch (status) {
    case 'Active':
      bg = kEmerald100;
      fg = kEmerald700;
      break;
    case 'On leave':
      bg = kAmber100;
      fg = kAmber700;
      break;
    case 'Pending':
      bg = kCyan100;
      fg = kCyan700;
      break;
    default:
      bg = kSlate200;
      fg = kSlate700;
  }
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(999.0),
    ),
    child: Text(
      status,
      style: TextStyle(
        color: fg,
        fontSize: 12.0,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      ),
    ),
  );
}

// ============================================================
// SECTION 6 — THEME COMPARISON GRID
// ============================================================
// Render the same DataTable four times under four different
// DataTableThemeData instances, so the reader can see exactly which
// parameter affects which surface.
Widget _buildThemeComparisonGrid() {
  return _sectionCard(
    title: 'DataTableThemeData — four calibrations',
    subtitle:
        'A DataTableThemeData lives on Theme.dataTableTheme and supplies '
        'defaults for every DataTable in the subtree. You can also wrap '
        'a single table in a Theme widget to override one instance. '
        'Below we render the same four-row table under four themes side '
        'by side.',
    accent: kIndigo600,
    child: Column(
      children: <Widget>[
        _themedTableTile(
          title: 'Compact dense',
          description:
              'headingRowHeight 40 + dataRowMinHeight 36 + columnSpacing '
              '18 — useful for admin dashboards.',
          theme: DataTableThemeData(
            headingRowHeight: 40.0,
            dataRowMinHeight: 36.0,
            dataRowMaxHeight: 40.0,
            horizontalMargin: 12.0,
            columnSpacing: 18.0,
            dividerThickness: 0.6,
            headingRowColor: WidgetStateProperty.all(kSlate200),
            headingTextStyle: const TextStyle(
              color: kSlate900,
              fontWeight: FontWeight.w800,
              fontSize: 11.5,
              letterSpacing: 0.6,
            ),
            dataTextStyle: const TextStyle(
              color: kSlate800,
              fontSize: 12.0,
            ),
          ),
        ),
        const SizedBox(height: 18.0),
        _themedTableTile(
          title: 'Generous reading',
          description:
              'headingRowHeight 64 + dataRowMaxHeight 72 + columnSpacing '
              '48 — comfortable for documents.',
          theme: DataTableThemeData(
            headingRowHeight: 64.0,
            dataRowMinHeight: 60.0,
            dataRowMaxHeight: 72.0,
            horizontalMargin: 28.0,
            columnSpacing: 48.0,
            dividerThickness: 1.4,
            headingRowColor: WidgetStateProperty.all(kIndigo50),
            headingTextStyle: const TextStyle(
              color: kIndigo700,
              fontWeight: FontWeight.w700,
              fontSize: 15.0,
            ),
            dataTextStyle: const TextStyle(
              color: kSlate800,
              fontSize: 14.5,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 18.0),
        _themedTableTile(
          title: 'Stripe-friendly',
          description:
              'No outer border, slim dividers, alternating row tint via '
              'dataRowColor.resolveWith with a fixed index-based check.',
          theme: DataTableThemeData(
            headingRowHeight: 48.0,
            dataRowMinHeight: 44.0,
            dataRowMaxHeight: 48.0,
            horizontalMargin: 16.0,
            columnSpacing: 24.0,
            dividerThickness: 0.0,
            headingRowColor: WidgetStateProperty.all(kCyan100),
            headingTextStyle: const TextStyle(
              color: kCyan700,
              fontWeight: FontWeight.w800,
              fontSize: 13.0,
            ),
            dataTextStyle: const TextStyle(
              color: kSlate800,
              fontSize: 13.0,
            ),
          ),
        ),
        const SizedBox(height: 18.0),
        _themedTableTile(
          title: 'Editorial outlined',
          description:
              'Heavy heading row, thicker dividerThickness: 2, and a '
              'dark indigo headingTextStyle.',
          theme: DataTableThemeData(
            headingRowHeight: 58.0,
            dataRowMinHeight: 50.0,
            dataRowMaxHeight: 56.0,
            horizontalMargin: 22.0,
            columnSpacing: 36.0,
            dividerThickness: 2.0,
            headingRowColor: WidgetStateProperty.all(kIndigo900),
            headingTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 13.0,
              letterSpacing: 1.0,
            ),
            dataTextStyle: const TextStyle(
              color: kSlate800,
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _themedTableTile({
  required String title,
  required String description,
  required DataTableThemeData theme,
}) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: kSlate200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 6.0,
              height: 20.0,
              decoration: BoxDecoration(
                color: kIndigo600,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            const SizedBox(width: 10.0),
            Text(
              title,
              style: const TextStyle(
                color: kSlate900,
                fontWeight: FontWeight.w800,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          description,
          style: const TextStyle(
            color: kSlate600,
            fontSize: 12.5,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 12.0),
        Theme(
          data: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: kIndigo600),
            dataTableTheme: theme,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const <DataColumn>[
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Role')),
                DataColumn(label: Text('Tenure'), numeric: true),
                DataColumn(label: Text('Salary'), numeric: true),
              ],
              rows: _themeRows(),
            ),
          ),
        ),
      ],
    ),
  );
}

List<DataRow> _themeRows() {
  final List<DataRow> rows = <DataRow>[];
  for (int i = 0; i < 4; i++) {
    final _Employee e = _kEmployees[i];
    rows.add(
      DataRow(
        cells: <DataCell>[
          DataCell(Text(e.name)),
          DataCell(Text(e.role)),
          DataCell(Text(_tenure(e.tenureYears))),
          DataCell(Text(_money(e.salary))),
        ],
      ),
    );
  }
  return rows;
}

// ============================================================
// SECTION 7a — HEADER STYLING SHOWCASE
// ============================================================
// Focused look at headingRowHeight, headingRowColor, headingTextStyle,
// dividerThickness, and how a custom widget (not just a Text) can be
// used as a column label.
Widget _buildHeaderStylingShowcase() {
  return _sectionCard(
    title: 'Header styling — labels are widgets, not strings',
    subtitle:
        'A DataColumn.label is an arbitrary Widget. That means you can '
        'embed icons, badges, tooltips, or Rich text directly in the '
        'heading row. Pair it with headingRowColor and headingTextStyle '
        'to make the heading row a first-class identity strip.',
    accent: kViolet500,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _explainer(
          'Each column label below is a Row containing an icon and a '
          'styled label. headingRowHeight is bumped to 64 to fit the '
          'taller content. The label widget participates in tooltip '
          'rendering when DataColumn.tooltip is provided.',
        ),
        const SizedBox(height: 14.0),
        _tableShell(
          child: DataTable(
            headingRowHeight: 64.0,
            dataRowMinHeight: 52.0,
            dataRowMaxHeight: 64.0,
            horizontalMargin: 20.0,
            columnSpacing: 30.0,
            dividerThickness: 1.0,
            headingRowColor: WidgetStateProperty.all(
              kIndigo900.withValues(alpha: 0.04),
            ),
            headingTextStyle: const TextStyle(
              color: kIndigo900,
              fontWeight: FontWeight.w800,
              fontSize: 13.0,
              letterSpacing: 0.4,
            ),
            dataTextStyle: const TextStyle(
              color: kSlate800,
              fontSize: 13.0,
            ),
            columns: <DataColumn>[
              DataColumn(
                tooltip: 'Engineer full name',
                label: _iconLabel(
                  Icons.person_outline,
                  'Engineer',
                  kIndigo600,
                ),
              ),
              DataColumn(
                tooltip: 'Department & cost-center identifier',
                label: _iconLabel(
                  Icons.account_tree_outlined,
                  'Department',
                  kCyan700,
                ),
              ),
              DataColumn(
                tooltip: 'Home office of record',
                label: _iconLabel(
                  Icons.location_on_outlined,
                  'Location',
                  kAmber700,
                ),
              ),
              DataColumn(
                tooltip: 'Annual salary in USD',
                numeric: true,
                label: _iconLabel(
                  Icons.attach_money_outlined,
                  'Salary',
                  kEmerald700,
                ),
              ),
            ],
            rows: _headerStylingRows(),
          ),
        ),
        const SizedBox(height: 18.0),
        _kvpRow(
          'DataColumn.label',
          'Any Widget — Row, Stack, Text.rich, badges are all valid.',
        ),
        _kvpRow(
          'DataColumn.tooltip',
          'Shows on long-press / hover over the label widget.',
        ),
        _kvpRow(
          'headingRowHeight',
          'Use this when the label widget is taller than ~32 dp.',
        ),
        _kvpRow(
          'headingRowColor',
          'WidgetStateProperty<Color?> — supports hover/pressed.',
        ),
      ],
    ),
  );
}

Widget _iconLabel(IconData icon, String label, Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Icon(icon, size: 14.0, color: color),
      ),
      const SizedBox(width: 8.0),
      Text(label),
    ],
  );
}

List<DataRow> _headerStylingRows() {
  final List<DataRow> rows = <DataRow>[];
  for (int i = 0; i < 6; i++) {
    final _Employee e = _kEmployees[i];
    rows.add(
      DataRow(
        cells: <DataCell>[
          DataCell(
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _avatar(e.name),
                const SizedBox(width: 10.0),
                Text(e.name),
              ],
            ),
          ),
          DataCell(Text(e.department)),
          DataCell(Text(e.location)),
          DataCell(Text(_money(e.salary))),
        ],
      ),
    );
  }
  return rows;
}

Widget _avatar(String name) {
  String initials;
  final List<String> parts = name.split(' ');
  if (parts.length >= 2) {
    initials = parts[0].substring(0, 1) + parts[1].substring(0, 1);
  } else if (parts.isNotEmpty && parts[0].isNotEmpty) {
    initials = parts[0].substring(0, 1);
  } else {
    initials = '?';
  }
  return Container(
    width: 28.0,
    height: 28.0,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: const LinearGradient(
        colors: <Color>[kIndigo500, kViolet500],
      ),
    ),
    child: Text(
      initials.toUpperCase(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 11.0,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.3,
      ),
    ),
  );
}

// ============================================================
// SECTION 7b — PAGINATED DATA TABLE
// ============================================================
// PaginatedDataTable consumes a DataTableSource and renders chrome
// for paging, header text, an actions toolbar, and a footer with
// row-count selector. We provide a const-sized inline DataTableSource
// implementation that returns DataRows from the shared corpus.
Widget _buildPaginatedSection() {
  return _sectionCard(
    title: 'PaginatedDataTable — header, source, footer',
    subtitle:
        'PaginatedDataTable wraps a DataTable in a paged surface. You '
        'supply a DataTableSource (a ChangeNotifier subclass that knows '
        'how to render the row at a given index) plus a list of column '
        'headers. The widget itself handles header, actions toolbar, '
        'and footer paging controls.',
    accent: kAmber500,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _explainer(
          'Parameters demonstrated: header (toolbar title), actions '
          '(trailing toolbar buttons), rowsPerPage, availableRowsPerPage, '
          'onRowsPerPageChanged, initialFirstRowIndex, sortColumnIndex, '
          'sortAscending, showCheckboxColumn, showFirstLastButtons, '
          'dataRowMinHeight, dataRowMaxHeight, headingRowHeight, '
          'horizontalMargin, columnSpacing, dividerThickness, and '
          'arrowHeadColor.',
        ),
        const SizedBox(height: 14.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: kSlate200, width: 1.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: kSlate900.withValues(alpha: 0.06),
                blurRadius: 14.0,
                offset: const Offset(0.0, 6.0),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: PaginatedDataTable(
            header: const Text(
              'Engineering roster — Q3 review',
              style: TextStyle(
                color: kSlate900,
                fontWeight: FontWeight.w800,
                fontSize: 16.0,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.filter_list, color: kSlate700),
                tooltip: 'Filter results',
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.file_download_outlined,
                    color: kSlate700),
                tooltip: 'Export CSV',
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, color: kSlate700),
                tooltip: 'More actions',
                onPressed: () {},
              ),
            ],
            rowsPerPage: 5,
            availableRowsPerPage: const <int>[5, 8, 10],
            onRowsPerPageChanged: (int? _) {},
            onPageChanged: (int _) {},
            initialFirstRowIndex: 0,
            sortColumnIndex: 3,
            sortAscending: false,
            showCheckboxColumn: true,
            showFirstLastButtons: true,
            dataRowMinHeight: 48.0,
            dataRowMaxHeight: 56.0,
            headingRowHeight: 56.0,
            horizontalMargin: 20.0,
            columnSpacing: 32.0,
            dividerThickness: 1.0,
            arrowHeadColor: kIndigo700,
            columns: <DataColumn>[
              const DataColumn(label: Text('Engineer')),
              const DataColumn(label: Text('Department')),
              const DataColumn(label: Text('Tenure'), numeric: true),
              DataColumn(
                label: const Text('Salary'),
                numeric: true,
                onSort: (int _, bool _) {},
              ),
            ],
            source: _RosterSource(),
          ),
        ),
        const SizedBox(height: 18.0),
        _explainer(
          'The DataTableSource subclass below is hand-authored. It '
          'returns DataRow instances from a const-sized backing list and '
          'never mutates state — the table is purely visual in this demo '
          'so the paging chrome renders without driving any controller.',
        ),
        const SizedBox(height: 12.0),
        _kvpRow('source', '_RosterSource (DataTableSource subclass)'),
        _kvpRow('rowCount', '${_kEmployees.length}'),
        _kvpRow('isRowCountApproximate', 'false (we know exact length)'),
        _kvpRow('selectedRowCount', '0 (selection not wired)'),
        _kvpRow(
          'arrowHeadColor',
          'kIndigo700 — paints the paging chevrons in the footer.',
        ),
      ],
    ),
  );
}

// ============================================================
// SECTION 8 — CHEAT SHEET
// ============================================================
// A static cheat-sheet listing every constructor parameter touched in
// this demo with a one-line description. This is the part the reader
// flips to when they forget what a flag does.
Widget _buildCheatSheet() {
  return _sectionCard(
    title: 'Cheat sheet — every parameter touched',
    subtitle:
        'A flat reference of the parameters demonstrated above. Use '
        'this as the index when you come back to this file looking for '
        '"the right knob".',
    accent: kSlate600,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cheatGroup('DataTable', <List<String>>[
          <String>['columns', 'List<DataColumn> — schema of the table.'],
          <String>['rows', 'List<DataRow> — every row must match column count.'],
          <String>['sortColumnIndex', 'Index of the column with the chevron.'],
          <String>['sortAscending', 'Chevron direction (true = up).'],
          <String>['showCheckboxColumn', 'Leading checkbox column toggle.'],
          <String>['showBottomBorder', 'Whether to paint the bottom edge.'],
          <String>['headingRowHeight', 'Height of the heading row.'],
          <String>['dataRowMinHeight', 'Floor for each data row.'],
          <String>['dataRowMaxHeight', 'Ceiling for each data row.'],
          <String>['horizontalMargin', 'Leading/trailing whitespace.'],
          <String>['columnSpacing', 'Gap between columns.'],
          <String>['dividerThickness', 'Width of horizontal row dividers.'],
          <String>['headingRowColor', 'WidgetStateProperty<Color?>.'],
          <String>['dataRowColor', 'WidgetStateProperty<Color?>.'],
          <String>['headingTextStyle', 'Default TextStyle for column labels.'],
          <String>['dataTextStyle', 'Default TextStyle for DataCells.'],
          <String>['decoration', 'BoxDecoration wrapping the whole table.'],
          <String>['border', 'TableBorder — internal grid lines.'],
          <String>['checkboxHorizontalMargin', 'Leading margin for checkboxes.'],
        ]),
        const SizedBox(height: 16.0),
        _cheatGroup('DataColumn', <List<String>>[
          <String>['label', 'Heading widget (any Widget, not just Text).'],
          <String>['tooltip', 'Long-press / hover tooltip text.'],
          <String>['numeric', 'Right-align cell content for numbers.'],
          <String>['onSort', 'Callback (int columnIndex, bool ascending).'],
        ]),
        const SizedBox(height: 16.0),
        _cheatGroup('DataRow', <List<String>>[
          <String>['cells', 'List<DataCell> — must match column count.'],
          <String>['selected', 'Visual selected state of the row.'],
          <String>['onSelectChanged', 'Callback (bool? selected).'],
          <String>['color', 'WidgetStateProperty<Color?> per-row.'],
          <String>['mouseCursor', 'Cursor when hovering this row.'],
        ]),
        const SizedBox(height: 16.0),
        _cheatGroup('DataCell', <List<String>>[
          <String>['child', 'Content widget for the cell.'],
          <String>['placeholder', 'Renders the child with placeholder style.'],
          <String>['showEditIcon', 'Tiny pencil icon to suggest editing.'],
          <String>['onTap', 'Tap handler — overrides row selection toggle.'],
          <String>['onDoubleTap', 'Double-tap handler.'],
          <String>['onLongPress', 'Long-press handler.'],
          <String>['onTapDown', 'Pressed-down notification (TapDownDetails).'],
          <String>['onTapCancel', 'Tap-cancelled notification.'],
        ]),
        const SizedBox(height: 16.0),
        _cheatGroup('PaginatedDataTable', <List<String>>[
          <String>['header', 'Toolbar title widget.'],
          <String>['actions', 'List<Widget> — toolbar trailing actions.'],
          <String>['source', 'DataTableSource — supplies DataRow on demand.'],
          <String>['rowsPerPage', 'Page size (default 10).'],
          <String>['availableRowsPerPage', 'Options in the footer dropdown.'],
          <String>['onRowsPerPageChanged', 'Footer dropdown callback.'],
          <String>['onPageChanged', 'Page-change callback.'],
          <String>['initialFirstRowIndex', 'Starting offset.'],
          <String>['showFirstLastButtons', 'Adds first/last paging buttons.'],
          <String>['arrowHeadColor', 'Color of paging chevrons.'],
        ]),
        const SizedBox(height: 16.0),
        _cheatGroup('DataTableThemeData', <List<String>>[
          <String>['headingRowHeight', 'Default heading height.'],
          <String>['dataRowMinHeight', 'Default min data row height.'],
          <String>['dataRowMaxHeight', 'Default max data row height.'],
          <String>['horizontalMargin', 'Default leading/trailing margin.'],
          <String>['columnSpacing', 'Default gap between columns.'],
          <String>['dividerThickness', 'Default divider thickness.'],
          <String>['headingRowColor', 'Default WidgetStateProperty<Color?>.'],
          <String>['dataRowColor', 'Default WidgetStateProperty<Color?>.'],
          <String>['headingTextStyle', 'Default heading TextStyle.'],
          <String>['dataTextStyle', 'Default data cell TextStyle.'],
          <String>['decoration', 'Default outer BoxDecoration.'],
        ]),
        const SizedBox(height: 20.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: kIndigo50,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: kIndigo200, width: 1.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(Icons.lightbulb_outline,
                  size: 18.0, color: kIndigo700),
              const SizedBox(width: 10.0),
              const Expanded(
                child: Text(
                  'Rule of thumb: pick DataTable when rows < 100 and they '
                  'all fit on screen. Pick PaginatedDataTable when you '
                  'have a source-of-truth that can yield arbitrary slices '
                  'on demand. Either way, set columnSpacing and '
                  'horizontalMargin explicitly — the defaults assume a '
                  'desktop monitor.',
                  style: TextStyle(
                    color: kIndigo900,
                    fontSize: 12.5,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _cheatGroup(String title, List<List<String>> rows) {
  final List<Widget> kvps = <Widget>[];
  for (int i = 0; i < rows.length; i++) {
    final List<String> kv = rows[i];
    kvps.add(_kvpRow(kv[0], kv[1]));
  }
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: kSlate200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 6.0,
              height: 18.0,
              decoration: BoxDecoration(
                color: kIndigo600,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              title,
              style: const TextStyle(
                color: kSlate900,
                fontWeight: FontWeight.w800,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: kvps,
        ),
      ],
    ),
  );
}

// ============================================================
// SHARED LAYOUT HELPERS
// ============================================================
Widget _sectionCard({
  required String title,
  required String subtitle,
  required Color accent,
  required Widget child,
}) {
  return Container(
    padding: const EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 22.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: kSlate200, width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kSlate900.withValues(alpha: 0.04),
          blurRadius: 18.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 10.0,
              height: 28.0,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: kSlate900,
                  fontWeight: FontWeight.w900,
                  fontSize: 18.0,
                  letterSpacing: -0.2,
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          subtitle,
          style: const TextStyle(
            color: kSlate600,
            fontSize: 13.0,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 18.0),
        child,
      ],
    ),
  );
}

Widget _subHeading(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 6.0, bottom: 4.0),
    child: Text(
      text,
      style: const TextStyle(
        color: kSlate900,
        fontWeight: FontWeight.w800,
        fontSize: 14.0,
        letterSpacing: -0.1,
      ),
    ),
  );
}

Widget _explainer(String text) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: kSlate100,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: kSlate200, width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Icon(
          Icons.info_outline,
          size: 16.0,
          color: kSlate500,
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: kSlate700,
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _tableShell({required Widget child}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: kSlate200, width: 1.0),
    ),
    clipBehavior: Clip.antiAlias,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: child,
    ),
  );
}

Widget _kvpRow(String key, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 180.0,
          child: Text(
            key,
            style: const TextStyle(
              color: kSlate900,
              fontWeight: FontWeight.w700,
              fontSize: 12.5,
              letterSpacing: 0.1,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: kSlate700,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _badge(String key, String value, Color fg, Color bg) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          key,
          style: TextStyle(
            color: fg,
            fontSize: 11.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(width: 6.0),
        Container(
          width: 1.0,
          height: 12.0,
          color: fg.withValues(alpha: 0.4),
        ),
        const SizedBox(width: 6.0),
        Text(
          value,
          style: TextStyle(
            color: fg,
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// FORMATTERS
// ============================================================
String _money(int amount) {
  // Hand-rolled thousands separator. Avoids NumberFormat / intl
  // because the interpreter prefers plain Dart.
  final String raw = amount.toString();
  final StringBuffer out = StringBuffer(r'$');
  final int len = raw.length;
  for (int i = 0; i < len; i++) {
    out.write(raw[i]);
    final int remaining = len - i - 1;
    if (remaining > 0 && remaining % 3 == 0) {
      out.write(',');
    }
  }
  return out.toString();
}

String _tenure(double years) {
  final int whole = years.floor();
  final int fraction = ((years - whole) * 4).round();
  if (fraction == 0) {
    return '$whole y';
  }
  return '$whole y ${fraction * 3} m';
}

// ============================================================
// DATA TABLE SOURCE — inline subclass for PaginatedDataTable
// ============================================================
class _RosterSource extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    if (index < 0 || index >= _kEmployees.length) {
      return null;
    }
    final _Employee e = _kEmployees[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.only(right: 8.0),
                decoration: BoxDecoration(
                  color: _statusDot(e.status),
                  shape: BoxShape.circle,
                ),
              ),
              Text(e.name),
            ],
          ),
        ),
        DataCell(Text(e.department)),
        DataCell(Text(_tenure(e.tenureYears))),
        DataCell(Text(_money(e.salary))),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _kEmployees.length;

  @override
  int get selectedRowCount => 0;

  Color _statusDot(String status) {
    if (status == 'Active') {
      return kEmerald500;
    } else if (status == 'On leave') {
      return kAmber500;
    } else if (status == 'Pending') {
      return kCyan500;
    }
    return kSlate400;
  }
}
