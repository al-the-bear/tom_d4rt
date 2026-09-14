// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, sort_child_properties_last
// Deep demo: DataTable, DataColumn, DataRow, DataCell from package:flutter/material.dart.
//
// Single hand-authored Flutter widget tree exposed through `dynamic build(BuildContext)`.
// No runApp, no main; the AST host calls build() directly.
//
// Sections:
//   1. Hero header.
//   2. Anatomy diagram.
//   3. Employees table.
//   4. Pricing-tier comparison.
//   5. Sortable financial summary.
//   6. Selectable students list.
//   7. Custom cell content gallery.
//   8. Theming via DataTableTheme.
//   9. Footer summary row.
//  10. Common pitfalls callouts.
//  11. Wide table inside horizontal SingleChildScrollView (recommended pattern).
//
// All callbacks are no-ops. Helper widgets are private. No withOpacity; uses withValues(alpha:).

import 'package:flutter/material.dart';

// =====================================================================
// Top-level build entry point.
// =====================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'DataTable Deep Demo',
    theme: ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF3D5AFE),
    ),
    home: const _DataTableDemoHome(),
  );
}

// =====================================================================
// Home scaffold.
// =====================================================================

class _DataTableDemoHome extends StatelessWidget {
  const _DataTableDemoHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F3FB),
      appBar: AppBar(
        title: const Text('DataTable Deep Demo'),
        backgroundColor: const Color(0xFF1A237E),
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _HeroHeader(),
              SizedBox(height: 24),
              _AnatomySection(),
              SizedBox(height: 24),
              _EmployeesSection(),
              SizedBox(height: 24),
              _PricingTierSection(),
              SizedBox(height: 24),
              _SortableFinancialSection(),
              SizedBox(height: 24),
              _SelectableStudentsSection(),
              SizedBox(height: 24),
              _CustomCellGallerySection(),
              SizedBox(height: 24),
              _ThemingSection(),
              SizedBox(height: 24),
              _FooterSummarySection(),
              SizedBox(height: 24),
              _PitfallsSection(),
              SizedBox(height: 24),
              _WideHorizontalScrollSection(),
              SizedBox(height: 32),
              _Credits(),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// 1. Hero header.
// =====================================================================

class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF1A237E), Color(0xFF3949AB), Color(0xFF7E57C2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF1A237E).withValues(alpha: 0.45),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(28),
      child: Row(
        children: <Widget>[
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              gradient: const RadialGradient(
                colors: <Color>[Color(0xFFFFD54F), Color(0xFFFB8C00)],
                radius: 0.85,
              ),
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: const Color(0xFFFB8C00).withValues(alpha: 0.5),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(Icons.table_chart, size: 56, color: Colors.white),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'DataTable',
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Anatomy, columns, rows, cells, sorting, selection & theming.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withValues(alpha: 0.92),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: const <Widget>[
                    _HeroChip(label: 'columns'),
                    SizedBox(width: 8),
                    _HeroChip(label: 'rows'),
                    SizedBox(width: 8),
                    _HeroChip(label: 'cells'),
                    SizedBox(width: 8),
                    _HeroChip(label: 'theming'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.4), width: 1),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// =====================================================================
// Section frame (shared chrome).
// =====================================================================

class _SectionFrame extends StatelessWidget {
  const _SectionFrame({
    required this.title,
    required this.subtitle,
    required this.child,
    required this.gradient,
    required this.shadowColor,
    this.icon = Icons.dashboard,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final Gradient gradient;
  final Color shadowColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: shadowColor.withValues(alpha: 0.35),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.92),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// 2. Anatomy diagram.
// =====================================================================

class _AnatomySection extends StatelessWidget {
  const _AnatomySection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      title: '2. Anatomy of a DataTable',
      subtitle: 'Columns, rows, cells, sizing, theming knobs.',
      icon: Icons.architecture,
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF0D47A1), Color(0xFF1976D2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      shadowColor: const Color(0xFF0D47A1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _AnatomyBlock(
            title: 'columns: List<DataColumn>',
            body: 'Each DataColumn declares: label (Widget), tooltip, '
                'numeric (right-aligns numeric data), onSort (sort callback).',
          ),
          SizedBox(height: 10),
          _AnatomyBlock(
            title: 'rows: List<DataRow>',
            body: 'Each DataRow holds: cells (List<DataCell>), selected (bool), '
                'onSelectChanged (selection toggle), color (WidgetStateProperty<Color?>), key.',
          ),
          SizedBox(height: 10),
          _AnatomyBlock(
            title: 'sizing knobs',
            body: 'dataRowMinHeight, dataRowMaxHeight, headingRowHeight, '
                'horizontalMargin, columnSpacing.',
          ),
          SizedBox(height: 10),
          _AnatomyBlock(
            title: 'visual knobs',
            body: 'dividerThickness (px), decoration (whole-table BoxDecoration), '
                'border (TableBorder), headingTextStyle, dataTextStyle.',
          ),
          SizedBox(height: 16),
          _MiniDataTablePreview(),
        ],
      ),
    );
  }
}

class _AnatomyBlock extends StatelessWidget {
  const _AnatomyBlock({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF1976D2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Color(0xFF0D47A1),
            ),
          ),
          const SizedBox(height: 4),
          Text(body, style: const TextStyle(fontSize: 13, color: Color(0xFF1A237E))),
        ],
      ),
    );
  }
}

class _MiniDataTablePreview extends StatelessWidget {
  const _MiniDataTablePreview();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowHeight: 40,
        dataRowMinHeight: 36,
        dataRowMaxHeight: 44,
        columnSpacing: 24,
        horizontalMargin: 12,
        dividerThickness: 1.0,
        decoration: const BoxDecoration(color: Color(0xFFFAFAFA)),
        columns: const <DataColumn>[
          DataColumn(label: Text('id'), tooltip: 'primary key'),
          DataColumn(label: Text('label')),
          DataColumn(label: Text('count'), numeric: true),
        ],
        rows: const <DataRow>[
          DataRow(cells: <DataCell>[
            DataCell(Text('A1')),
            DataCell(Text('alpha')),
            DataCell(Text('12')),
          ]),
          DataRow(cells: <DataCell>[
            DataCell(Text('A2')),
            DataCell(Text('beta')),
            DataCell(Text('48')),
          ]),
        ],
      ),
    );
  }
}

// =====================================================================
// 3. Employees table.
// =====================================================================

class _EmployeesSection extends StatelessWidget {
  const _EmployeesSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      title: '3. Employees',
      subtitle: 'Six columns, eight rows, mixed cell content (icons + text).',
      icon: Icons.people,
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF00695C), Color(0xFF26A69A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      shadowColor: const Color(0xFF00695C),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStatePropertyAll<Color>(Color(0xFFE0F2F1)),
          headingRowHeight: 48,
          dataRowMinHeight: 44,
          dataRowMaxHeight: 56,
          columnSpacing: 28,
          horizontalMargin: 16,
          columns: const <DataColumn>[
            DataColumn(label: Text('ID', style: TextStyle(fontWeight: FontWeight.w700))),
            DataColumn(label: Text('Name', style: TextStyle(fontWeight: FontWeight.w700))),
            DataColumn(label: Text('Role', style: TextStyle(fontWeight: FontWeight.w700))),
            DataColumn(label: Text('Department', style: TextStyle(fontWeight: FontWeight.w700))),
            DataColumn(label: Text('Joined', style: TextStyle(fontWeight: FontWeight.w700))),
            DataColumn(
              label: Text('Salary', style: TextStyle(fontWeight: FontWeight.w700)),
              numeric: true,
              tooltip: 'USD, gross',
            ),
          ],
          rows: const <DataRow>[
            DataRow(cells: <DataCell>[
              DataCell(Text('E-1001')),
              DataCell(_NameCell(icon: Icons.person, name: 'Ada Lovelace')),
              DataCell(Text('Principal Engineer')),
              DataCell(Text('Platform')),
              DataCell(Text('2018-03-12')),
              DataCell(Text(r'$182,400')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('E-1002')),
              DataCell(_NameCell(icon: Icons.person_outline, name: 'Grace Hopper')),
              DataCell(Text('Director')),
              DataCell(Text('Compilers')),
              DataCell(Text('2016-08-01')),
              DataCell(Text(r'$214,000')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('E-1003')),
              DataCell(_NameCell(icon: Icons.person, name: 'Alan Turing')),
              DataCell(Text('Senior Researcher')),
              DataCell(Text('Cryptography')),
              DataCell(Text('2019-11-23')),
              DataCell(Text(r'$176,800')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('E-1004')),
              DataCell(_NameCell(icon: Icons.person_outline, name: 'Linus Torvalds')),
              DataCell(Text('Kernel Lead')),
              DataCell(Text('Infrastructure')),
              DataCell(Text('2014-05-17')),
              DataCell(Text(r'$198,250')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('E-1005')),
              DataCell(_NameCell(icon: Icons.person, name: 'Margaret Hamilton')),
              DataCell(Text('Software Architect')),
              DataCell(Text('Avionics')),
              DataCell(Text('2017-02-09')),
              DataCell(Text(r'$192,600')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('E-1006')),
              DataCell(_NameCell(icon: Icons.person_outline, name: 'Donald Knuth')),
              DataCell(Text('Distinguished Engineer')),
              DataCell(Text('Algorithms')),
              DataCell(Text('2012-09-04')),
              DataCell(Text(r'$226,000')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('E-1007')),
              DataCell(_NameCell(icon: Icons.person, name: 'Edsger Dijkstra')),
              DataCell(Text('Staff Engineer')),
              DataCell(Text('Distributed Systems')),
              DataCell(Text('2020-06-14')),
              DataCell(Text(r'$165,300')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('E-1008')),
              DataCell(_NameCell(icon: Icons.person_outline, name: 'Barbara Liskov')),
              DataCell(Text('VP of Engineering')),
              DataCell(Text('Languages')),
              DataCell(Text('2013-12-01')),
              DataCell(Text(r'$248,900')),
            ]),
          ],
        ),
      ),
    );
  }
}

class _NameCell extends StatelessWidget {
  const _NameCell({required this.icon, required this.name});

  final IconData icon;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 18, color: const Color(0xFF00695C)),
        const SizedBox(width: 8),
        Text(name),
      ],
    );
  }
}

// =====================================================================
// 4. Pricing-tier comparison.
// =====================================================================

class _PricingTierSection extends StatelessWidget {
  const _PricingTierSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      title: '4. Pricing tier comparison',
      subtitle: 'Four plans x six features. Cells contain check / dash icons.',
      icon: Icons.price_check,
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFFAD1457), Color(0xFFEC407A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      shadowColor: const Color(0xFFAD1457),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStatePropertyAll<Color>(Color(0xFFFCE4EC)),
          dataRowMinHeight: 48,
          columnSpacing: 36,
          horizontalMargin: 16,
          columns: const <DataColumn>[
            DataColumn(label: Text('Feature', style: TextStyle(fontWeight: FontWeight.w700))),
            DataColumn(label: Text('Free', style: TextStyle(fontWeight: FontWeight.w700))),
            DataColumn(label: Text('Pro', style: TextStyle(fontWeight: FontWeight.w700))),
            DataColumn(label: Text('Team', style: TextStyle(fontWeight: FontWeight.w700))),
            DataColumn(label: Text('Enterprise', style: TextStyle(fontWeight: FontWeight.w700))),
          ],
          rows: const <DataRow>[
            DataRow(cells: <DataCell>[
              DataCell(Text('Unlimited projects')),
              DataCell(_TierMark(included: false)),
              DataCell(_TierMark(included: true)),
              DataCell(_TierMark(included: true)),
              DataCell(_TierMark(included: true)),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Custom domains')),
              DataCell(_TierMark(included: false)),
              DataCell(_TierMark(included: true)),
              DataCell(_TierMark(included: true)),
              DataCell(_TierMark(included: true)),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Team seats')),
              DataCell(Text('1')),
              DataCell(Text('3')),
              DataCell(Text('15')),
              DataCell(Text('Unlimited')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Audit log retention')),
              DataCell(Text('—')),
              DataCell(Text('30 days')),
              DataCell(Text('180 days')),
              DataCell(Text('7 years')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('SAML SSO')),
              DataCell(_TierMark(included: false)),
              DataCell(_TierMark(included: false)),
              DataCell(_TierMark(included: true)),
              DataCell(_TierMark(included: true)),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Dedicated support')),
              DataCell(_TierMark(included: false)),
              DataCell(_TierMark(included: false)),
              DataCell(_TierMark(included: false)),
              DataCell(_TierMark(included: true)),
            ]),
          ],
        ),
      ),
    );
  }
}

class _TierMark extends StatelessWidget {
  const _TierMark({required this.included});

  final bool included;

  @override
  Widget build(BuildContext context) {
    return Icon(
      included ? Icons.check_circle : Icons.remove_circle_outline,
      size: 20,
      color: included ? const Color(0xFF2E7D32) : const Color(0xFFB0BEC5),
    );
  }
}

// =====================================================================
// 5. Sortable financial summary.
// =====================================================================

class _SortableFinancialSection extends StatelessWidget {
  const _SortableFinancialSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      title: '5. Sortable financial summary',
      subtitle: 'sortColumnIndex, sortAscending, onSort no-op callbacks.',
      icon: Icons.trending_up,
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF263238), Color(0xFF455A64)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      shadowColor: const Color(0xFF263238),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          sortColumnIndex: 3,
          sortAscending: false,
          headingRowColor: WidgetStatePropertyAll<Color>(Color(0xFFECEFF1)),
          columnSpacing: 32,
          horizontalMargin: 16,
          dataRowMinHeight: 42,
          columns: <DataColumn>[
            DataColumn(
              label: const Text('Quarter', style: TextStyle(fontWeight: FontWeight.w700)),
              onSort: (int _, bool _) {},
            ),
            DataColumn(
              label: const Text('Region', style: TextStyle(fontWeight: FontWeight.w700)),
              onSort: (int _, bool _) {},
            ),
            DataColumn(
              label: const Text('Revenue', style: TextStyle(fontWeight: FontWeight.w700)),
              numeric: true,
              onSort: (int _, bool _) {},
            ),
            DataColumn(
              label: const Text('Growth %', style: TextStyle(fontWeight: FontWeight.w700)),
              numeric: true,
              tooltip: 'YoY growth, sorted descending',
              onSort: (int _, bool _) {},
            ),
            DataColumn(
              label: const Text('Margin %', style: TextStyle(fontWeight: FontWeight.w700)),
              numeric: true,
              onSort: (int _, bool _) {},
            ),
          ],
          rows: const <DataRow>[
            DataRow(cells: <DataCell>[
              DataCell(Text('Q1 2025')),
              DataCell(Text('EMEA')),
              DataCell(Text(r'$4,820,000')),
              DataCell(Text('+18.4')),
              DataCell(Text('22.1')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Q1 2025')),
              DataCell(Text('NA')),
              DataCell(Text(r'$7,310,000')),
              DataCell(Text('+12.7')),
              DataCell(Text('27.8')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Q1 2025')),
              DataCell(Text('APAC')),
              DataCell(Text(r'$3,140,000')),
              DataCell(Text('+24.6')),
              DataCell(Text('19.4')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Q4 2024')),
              DataCell(Text('EMEA')),
              DataCell(Text(r'$4,070,000')),
              DataCell(Text('+9.2')),
              DataCell(Text('21.3')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Q4 2024')),
              DataCell(Text('NA')),
              DataCell(Text(r'$6,480,000')),
              DataCell(Text('+7.8')),
              DataCell(Text('26.1')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Q4 2024')),
              DataCell(Text('APAC')),
              DataCell(Text(r'$2,520,000')),
              DataCell(Text('+15.3')),
              DataCell(Text('17.8')),
            ]),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// 6. Selectable students.
// =====================================================================

class _SelectableStudentsSection extends StatelessWidget {
  const _SelectableStudentsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      title: '6. Selectable students',
      subtitle: 'selected: true on some rows; alternating row colors via WidgetStateProperty.',
      icon: Icons.checklist,
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF4527A0), Color(0xFF7E57C2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      shadowColor: const Color(0xFF4527A0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          showCheckboxColumn: true,
          headingRowColor: WidgetStatePropertyAll<Color>(Color(0xFFEDE7F6)),
          columnSpacing: 28,
          horizontalMargin: 14,
          columns: const <DataColumn>[
            DataColumn(label: Text('Student', style: TextStyle(fontWeight: FontWeight.w700))),
            DataColumn(label: Text('Cohort', style: TextStyle(fontWeight: FontWeight.w700))),
            DataColumn(label: Text('GPA', style: TextStyle(fontWeight: FontWeight.w700)), numeric: true),
            DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.w700))),
          ],
          rows: <DataRow>[
            DataRow(
              key: const ValueKey<String>('student-1'),
              selected: true,
              color: WidgetStateProperty.resolveWith<Color?>(_zebraResolver(true)),
              onSelectChanged: (bool? _) {},
              cells: const <DataCell>[
                DataCell(Text('Alice Carter')),
                DataCell(Text('2025-A')),
                DataCell(Text('3.92')),
                DataCell(_StatusPill(label: 'Active', color: Color(0xFF2E7D32))),
              ],
            ),
            DataRow(
              key: const ValueKey<String>('student-2'),
              selected: false,
              color: WidgetStateProperty.resolveWith<Color?>(_zebraResolver(false)),
              onSelectChanged: (bool? _) {},
              cells: const <DataCell>[
                DataCell(Text('Bertrand Holm')),
                DataCell(Text('2025-A')),
                DataCell(Text('3.41')),
                DataCell(_StatusPill(label: 'Active', color: Color(0xFF2E7D32))),
              ],
            ),
            DataRow(
              key: const ValueKey<String>('student-3'),
              selected: true,
              color: WidgetStateProperty.resolveWith<Color?>(_zebraResolver(true)),
              onSelectChanged: (bool? _) {},
              cells: const <DataCell>[
                DataCell(Text('Cassidy Park')),
                DataCell(Text('2024-B')),
                DataCell(Text('3.78')),
                DataCell(_StatusPill(label: 'Honors', color: Color(0xFF6A1B9A))),
              ],
            ),
            DataRow(
              key: const ValueKey<String>('student-4'),
              selected: false,
              color: WidgetStateProperty.resolveWith<Color?>(_zebraResolver(false)),
              onSelectChanged: (bool? _) {},
              cells: const <DataCell>[
                DataCell(Text('Diego Marsh')),
                DataCell(Text('2024-B')),
                DataCell(Text('2.96')),
                DataCell(_StatusPill(label: 'On Leave', color: Color(0xFFEF6C00))),
              ],
            ),
            DataRow(
              key: const ValueKey<String>('student-5'),
              selected: true,
              color: WidgetStateProperty.resolveWith<Color?>(_zebraResolver(true)),
              onSelectChanged: (bool? _) {},
              cells: const <DataCell>[
                DataCell(Text('Elise Park')),
                DataCell(Text('2025-A')),
                DataCell(Text('3.65')),
                DataCell(_StatusPill(label: 'Active', color: Color(0xFF2E7D32))),
              ],
            ),
            DataRow(
              key: const ValueKey<String>('student-6'),
              selected: false,
              color: WidgetStateProperty.resolveWith<Color?>(_zebraResolver(false)),
              onSelectChanged: (bool? _) {},
              cells: const <DataCell>[
                DataCell(Text('Farouk Idris')),
                DataCell(Text('2023-C')),
                DataCell(Text('3.12')),
                DataCell(_StatusPill(label: 'Graduated', color: Color(0xFF1565C0))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Returns a resolver that gives a fixed color regardless of the
// row's interactive state — visible alternating rows.
Color? Function(Set<WidgetState>) _zebraResolver(bool isOdd) {
  return (Set<WidgetState> states) {
    if (states.contains(WidgetState.selected)) {
      return const Color(0xFFD1C4E9);
    }
    return isOdd ? const Color(0xFFF3E5F5) : const Color(0xFFFFFFFF);
  };
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.6), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w700),
      ),
    );
  }
}

// =====================================================================
// 7. Custom cell content gallery.
// =====================================================================

class _CustomCellGallerySection extends StatelessWidget {
  const _CustomCellGallerySection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      title: '7. Custom cell content',
      subtitle: 'Avatars, badges, progress bars — DataCell can wrap any widget.',
      icon: Icons.dashboard_customize,
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFFE65100), Color(0xFFFB8C00)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      shadowColor: const Color(0xFFE65100),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 32,
          horizontalMargin: 16,
          dataRowMinHeight: 56,
          dataRowMaxHeight: 64,
          columns: const <DataColumn>[
            DataColumn(label: Text('User', style: TextStyle(fontWeight: FontWeight.w700))),
            DataColumn(label: Text('Tags', style: TextStyle(fontWeight: FontWeight.w700))),
            DataColumn(label: Text('Storage used', style: TextStyle(fontWeight: FontWeight.w700))),
            DataColumn(label: Text('Last seen', style: TextStyle(fontWeight: FontWeight.w700))),
          ],
          rows: const <DataRow>[
            DataRow(cells: <DataCell>[
              DataCell(_AvatarCell(initials: 'AL', name: 'Ada Lovelace', color: Color(0xFF1565C0))),
              DataCell(_TagsCell(tags: <String>['admin', 'beta'])),
              DataCell(_StorageCell(value: 0.42, label: '4.2 GB / 10 GB')),
              DataCell(Text('2 minutes ago')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(_AvatarCell(initials: 'GH', name: 'Grace Hopper', color: Color(0xFF6A1B9A))),
              DataCell(_TagsCell(tags: <String>['owner'])),
              DataCell(_StorageCell(value: 0.78, label: '7.8 GB / 10 GB')),
              DataCell(Text('14 minutes ago')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(_AvatarCell(initials: 'AT', name: 'Alan Turing', color: Color(0xFFAD1457))),
              DataCell(_TagsCell(tags: <String>['guest', 'invited'])),
              DataCell(_StorageCell(value: 0.18, label: '1.8 GB / 10 GB')),
              DataCell(Text('yesterday')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(_AvatarCell(initials: 'MH', name: 'Margaret Hamilton', color: Color(0xFF2E7D32))),
              DataCell(_TagsCell(tags: <String>['admin', 'lead'])),
              DataCell(_StorageCell(value: 0.93, label: '9.3 GB / 10 GB')),
              DataCell(Text('5 minutes ago')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(_AvatarCell(initials: 'BL', name: 'Barbara Liskov', color: Color(0xFF0097A7))),
              DataCell(_TagsCell(tags: <String>['exec'])),
              DataCell(_StorageCell(value: 0.55, label: '5.5 GB / 10 GB')),
              DataCell(Text('3 hours ago')),
            ]),
          ],
        ),
      ),
    );
  }
}

class _AvatarCell extends StatelessWidget {
  const _AvatarCell({required this.initials, required this.name, required this.color});

  final String initials;
  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            initials,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(name),
      ],
    );
  }
}

class _TagsCell extends StatelessWidget {
  const _TagsCell({required this.tags});

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: <Widget>[
        for (final String t in tags)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFFB8C00), width: 1),
            ),
            child: Text(
              t,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFFE65100),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }
}

class _StorageCell extends StatelessWidget {
  const _StorageCell({required this.value, required this.label});

  final double value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label, style: const TextStyle(fontSize: 11)),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 6,
              backgroundColor: const Color(0xFFFFE0B2),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFE65100)),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// 8. Theming via DataTableTheme.
// =====================================================================

class _ThemingSection extends StatelessWidget {
  const _ThemingSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      title: '8. Theming',
      subtitle: 'DataTableTheme overrides text styles, dividers and decoration.',
      icon: Icons.palette,
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF006064), Color(0xFF00838F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      shadowColor: const Color(0xFF006064),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'Default styling:',
            style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF006064)),
          ),
          SizedBox(height: 6),
          _DefaultStyledTable(),
          SizedBox(height: 18),
          Text(
            'Themed via DataTableTheme:',
            style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF006064)),
          ),
          SizedBox(height: 6),
          _ThemedTable(),
        ],
      ),
    );
  }
}

class _DefaultStyledTable extends StatelessWidget {
  const _DefaultStyledTable();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(label: Text('Metric')),
          DataColumn(label: Text('Value'), numeric: true),
          DataColumn(label: Text('Change'), numeric: true),
        ],
        rows: const <DataRow>[
          DataRow(cells: <DataCell>[
            DataCell(Text('Latency p99')),
            DataCell(Text('142 ms')),
            DataCell(Text('-3.1%')),
          ]),
          DataRow(cells: <DataCell>[
            DataCell(Text('Error rate')),
            DataCell(Text('0.04%')),
            DataCell(Text('-12.7%')),
          ]),
          DataRow(cells: <DataCell>[
            DataCell(Text('Throughput')),
            DataCell(Text('48.2 k/s')),
            DataCell(Text('+8.4%')),
          ]),
        ],
      ),
    );
  }
}

class _ThemedTable extends StatelessWidget {
  const _ThemedTable();

  @override
  Widget build(BuildContext context) {
    return DataTableTheme(
      data: const DataTableThemeData(
        headingTextStyle: TextStyle(
          fontWeight: FontWeight.w800,
          color: Color(0xFF004D40),
          fontSize: 13,
          letterSpacing: 1.0,
        ),
        dataTextStyle: TextStyle(
          fontFamily: 'monospace',
          fontSize: 13,
          color: Color(0xFF263238),
        ),
        dividerThickness: 2.0,
        decoration: BoxDecoration(
          color: Color(0xFFE0F7FA),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        headingRowColor: WidgetStatePropertyAll<Color>(Color(0xFFB2EBF2)),
        columnSpacing: 30,
        horizontalMargin: 16,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(label: Text('Metric')),
            DataColumn(label: Text('Value'), numeric: true),
            DataColumn(label: Text('Change'), numeric: true),
          ],
          rows: const <DataRow>[
            DataRow(cells: <DataCell>[
              DataCell(Text('Latency p99')),
              DataCell(Text('142 ms')),
              DataCell(Text('-3.1%')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Error rate')),
              DataCell(Text('0.04%')),
              DataCell(Text('-12.7%')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('Throughput')),
              DataCell(Text('48.2 k/s')),
              DataCell(Text('+8.4%')),
            ]),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// 9. Footer summary row.
// =====================================================================

class _FooterSummarySection extends StatelessWidget {
  const _FooterSummarySection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      title: '9. Footer summary row',
      subtitle: 'Synthesised footer row uses WidgetStatePropertyAll for background.',
      icon: Icons.functions,
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF1B5E20), Color(0xFF388E3C)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      shadowColor: const Color(0xFF1B5E20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 28,
          horizontalMargin: 16,
          dividerThickness: 1.5,
          columns: const <DataColumn>[
            DataColumn(label: Text('Item', style: TextStyle(fontWeight: FontWeight.w700))),
            DataColumn(label: Text('Qty', style: TextStyle(fontWeight: FontWeight.w700)), numeric: true),
            DataColumn(label: Text('Unit', style: TextStyle(fontWeight: FontWeight.w700)), numeric: true),
            DataColumn(label: Text('Total', style: TextStyle(fontWeight: FontWeight.w700)), numeric: true),
          ],
          rows: <DataRow>[
            const DataRow(cells: <DataCell>[
              DataCell(Text('Hex bolt M8x40')),
              DataCell(Text('250')),
              DataCell(Text(r'$0.18')),
              DataCell(Text(r'$45.00')),
            ]),
            const DataRow(cells: <DataCell>[
              DataCell(Text('Lock washer M8')),
              DataCell(Text('500')),
              DataCell(Text(r'$0.06')),
              DataCell(Text(r'$30.00')),
            ]),
            const DataRow(cells: <DataCell>[
              DataCell(Text('Hex nut M8')),
              DataCell(Text('500')),
              DataCell(Text(r'$0.04')),
              DataCell(Text(r'$20.00')),
            ]),
            const DataRow(cells: <DataCell>[
              DataCell(Text('Loctite 243 (50 ml)')),
              DataCell(Text('4')),
              DataCell(Text(r'$8.50')),
              DataCell(Text(r'$34.00')),
            ]),
            DataRow(
              color: const WidgetStatePropertyAll<Color?>(Color(0xFFC8E6C9)),
              cells: const <DataCell>[
                DataCell(Text('TOTAL', style: TextStyle(fontWeight: FontWeight.w800))),
                DataCell(Text('1254', style: TextStyle(fontWeight: FontWeight.w800))),
                DataCell(Text('—', style: TextStyle(fontWeight: FontWeight.w800))),
                DataCell(Text(r'$129.00', style: TextStyle(fontWeight: FontWeight.w800))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// 10. Common pitfalls.
// =====================================================================

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      title: '10. Common pitfalls',
      subtitle: 'Things that bite people new to DataTable.',
      icon: Icons.warning_amber,
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFFBF360C), Color(0xFFE64A19)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      shadowColor: const Color(0xFFBF360C),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _PitfallCallout(
            symbol: '!',
            title: 'Forgetting numeric: true',
            body: 'Numeric columns must set numeric: true so values right-align '
                'and the heading is right-aligned. Without it, numbers look messy.',
          ),
          SizedBox(height: 10),
          _PitfallCallout(
            symbol: 'X',
            title: 'Mismatched cell count',
            body: 'Every DataRow must provide exactly one DataCell per DataColumn. '
                'A missing cell asserts at build time and crashes the frame.',
          ),
          SizedBox(height: 10),
          _PitfallCallout(
            symbol: '>',
            title: 'Wide tables overflow',
            body: 'DataTable does not scroll on its own. Always wrap wide tables '
                'in SingleChildScrollView(scrollDirection: Axis.horizontal, ...).',
          ),
          SizedBox(height: 10),
          _PitfallCallout(
            symbol: '?',
            title: 'No-op onSort still toggles arrow',
            body: 'Setting onSort enables the sort indicator. If your callback '
                'is a no-op, the arrow flips visually but data does not reorder.',
          ),
          SizedBox(height: 10),
          _PitfallCallout(
            symbol: '#',
            title: 'Selection without keys',
            body: 'When mutating a list of selected rows, give each DataRow a '
                'stable ValueKey so selection is preserved across rebuilds.',
          ),
        ],
      ),
    );
  }
}

class _PitfallCallout extends StatelessWidget {
  const _PitfallCallout({
    required this.symbol,
    required this.title,
    required this.body,
  });

  final String symbol;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE64A19), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xFFE64A19),
              shape: BoxShape.circle,
            ),
            child: Text(
              symbol,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFBF360C),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  body,
                  style: const TextStyle(fontSize: 13, color: Color(0xFF3E2723)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// 11. Wide table with horizontal SingleChildScrollView (recommended pattern).
// =====================================================================

class _WideHorizontalScrollSection extends StatelessWidget {
  const _WideHorizontalScrollSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      title: '11. Wide table inside horizontal scroll',
      subtitle: 'The recommended pattern for tables wider than the viewport.',
      icon: Icons.swap_horiz,
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF311B92), Color(0xFF512DA8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      shadowColor: const Color(0xFF311B92),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStatePropertyAll<Color>(Color(0xFFEDE7F6)),
          columnSpacing: 36,
          horizontalMargin: 16,
          columns: const <DataColumn>[
            DataColumn(label: Text('Order ID', style: TextStyle(fontWeight: FontWeight.w700))),
            DataColumn(label: Text('Customer', style: TextStyle(fontWeight: FontWeight.w700))),
            DataColumn(label: Text('SKU', style: TextStyle(fontWeight: FontWeight.w700))),
            DataColumn(label: Text('Description', style: TextStyle(fontWeight: FontWeight.w700))),
            DataColumn(label: Text('Qty', style: TextStyle(fontWeight: FontWeight.w700)), numeric: true),
            DataColumn(label: Text('Unit', style: TextStyle(fontWeight: FontWeight.w700)), numeric: true),
            DataColumn(label: Text('Subtotal', style: TextStyle(fontWeight: FontWeight.w700)), numeric: true),
            DataColumn(label: Text('Tax', style: TextStyle(fontWeight: FontWeight.w700)), numeric: true),
            DataColumn(label: Text('Shipped', style: TextStyle(fontWeight: FontWeight.w700))),
            DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.w700))),
          ],
          rows: const <DataRow>[
            DataRow(cells: <DataCell>[
              DataCell(Text('ORD-220394')),
              DataCell(Text('Helix Robotics')),
              DataCell(Text('SX-440-B')),
              DataCell(Text('Servo bracket, anodized')),
              DataCell(Text('24')),
              DataCell(Text(r'$12.40')),
              DataCell(Text(r'$297.60')),
              DataCell(Text(r'$23.81')),
              DataCell(Text('2025-04-22')),
              DataCell(_StatusPill(label: 'Shipped', color: Color(0xFF2E7D32))),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('ORD-220395')),
              DataCell(Text('Northwind Optics')),
              DataCell(Text('LP-7700')),
              DataCell(Text('Polarising lens, 60mm')),
              DataCell(Text('6')),
              DataCell(Text(r'$84.00')),
              DataCell(Text(r'$504.00')),
              DataCell(Text(r'$40.32')),
              DataCell(Text('2025-04-23')),
              DataCell(_StatusPill(label: 'Pending', color: Color(0xFFEF6C00))),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('ORD-220396')),
              DataCell(Text('Pelican Marine')),
              DataCell(Text('CB-12X')),
              DataCell(Text('Marine cable, 12 AWG, 50m')),
              DataCell(Text('3')),
              DataCell(Text(r'$162.00')),
              DataCell(Text(r'$486.00')),
              DataCell(Text(r'$38.88')),
              DataCell(Text('—')),
              DataCell(_StatusPill(label: 'Backorder', color: Color(0xFFAD1457))),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('ORD-220397')),
              DataCell(Text('Vector Aerospace')),
              DataCell(Text('TI-AL-225')),
              DataCell(Text('Titanium fastener kit')),
              DataCell(Text('1')),
              DataCell(Text(r'$1,180.00')),
              DataCell(Text(r'$1,180.00')),
              DataCell(Text(r'$94.40')),
              DataCell(Text('2025-04-21')),
              DataCell(_StatusPill(label: 'Shipped', color: Color(0xFF2E7D32))),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('ORD-220398')),
              DataCell(Text('Cypress Foods')),
              DataCell(Text('PK-300')),
              DataCell(Text('Vacuum pouch, 30x40, 1000ct')),
              DataCell(Text('12')),
              DataCell(Text(r'$58.00')),
              DataCell(Text(r'$696.00')),
              DataCell(Text(r'$55.68')),
              DataCell(Text('2025-04-22')),
              DataCell(_StatusPill(label: 'Shipped', color: Color(0xFF2E7D32))),
            ]),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// Credits.
// =====================================================================

class _Credits extends StatelessWidget {
  const _Credits();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF263238), Color(0xFF455A64)],
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.menu_book, color: Colors.white70, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'DataTable deep demo — covering anatomy, sorting, selection, theming and pitfalls.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.92),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
