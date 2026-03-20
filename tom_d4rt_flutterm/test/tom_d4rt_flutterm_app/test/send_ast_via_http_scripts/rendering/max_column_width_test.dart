// D4rt Flutter demo: MaxColumnWidth – table column strategy using the
// larger of two TableColumnWidth values. Visual comparison of FixedColumnWidth,
// FractionColumnWidth, IntrinsicColumnWidth, FlexColumnWidth and how
// MaxColumnWidth combines them for responsive data tables.
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Color theme constants
// ---------------------------------------------------------------------------
const _kIndigo500 = Color(0xFF6366F1);
const _kAmber500 = Color(0xFFF59E0B);
const _kIndigo700 = Color(0xFF4338CA);
const _kAmber700 = Color(0xFFB45309);
const _kIndigo50 = Color(0xFFEEF2FF);
const _kAmber50 = Color(0xFFFFFBEB);
const _kGray100 = Color(0xFFF3F4F6);
const _kGray200 = Color(0xFFE5E7EB);
const _kGray700 = Color(0xFF374151);
const _kGray500 = Color(0xFF6B7280);
const _kWhite = Color(0xFFFFFFFF);

// ---------------------------------------------------------------------------
// Section header helper
// ---------------------------------------------------------------------------
Widget _buildSectionHeader(String number, String title, String subtitle) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 24, bottom: 12),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kIndigo500, _kAmber500],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$number  $title',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _kWhite,
          ),
        ),
        SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(fontSize: 13, color: _kWhite.withAlpha(204)),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Info card
// ---------------------------------------------------------------------------
Widget _buildInfoCard(String label, String value, Color accent) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kWhite,
      border: Border(left: BorderSide(color: accent, width: 4)),
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: accent.withAlpha(30),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _kGray700,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            color: accent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Strategy badge
// ---------------------------------------------------------------------------
Widget _buildStrategyBadge(String name, Color bg) {
  return Container(
    margin: EdgeInsets.only(right: 8, bottom: 6),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Text(
      name,
      style: TextStyle(
        color: _kWhite,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Visual column-width bar
// ---------------------------------------------------------------------------
Widget _buildWidthBar(String label, double fraction, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: _kGray700,
          ),
        ),
        SizedBox(height: 3),
        Container(
          height: 22,
          decoration: BoxDecoration(
            color: _kGray100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            widthFactor: fraction.clamp(0.0, 1.0),
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 6),
              child: Text(
                '${(fraction * 100).toInt()}%',
                style: TextStyle(color: _kWhite, fontSize: 10),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Strategy comparison card
// ---------------------------------------------------------------------------
Widget _buildStrategyCard(
  String title,
  String description,
  String formula,
  IconData icon,
  Color accent,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kWhite,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withAlpha(40)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: accent.withAlpha(25),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: accent, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _kGray700,
                ),
              ),
              SizedBox(height: 3),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: _kGray500, height: 1.4),
              ),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: accent.withAlpha(15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  formula,
                  style: TextStyle(
                    fontSize: 11,
                    color: accent,
                    fontWeight: FontWeight.w600,
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

// ---------------------------------------------------------------------------
// Mini table demo row
// ---------------------------------------------------------------------------
Widget _buildTableRow(
  List<String> cells,
  Color bg,
  Color textColor, {
  bool isHeader = false,
}) {
  return Container(
    color: bg,
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
    child: Row(
      children: cells
          .map(
            (c) => Expanded(
              child: Text(
                c,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                  color: textColor,
                ),
              ),
            ),
          )
          .toList(),
    ),
  );
}

// ---------------------------------------------------------------------------
// MaxColumnWidth visual demo box
// ---------------------------------------------------------------------------
Widget _buildMaxWidthDemo(
  String label,
  String stratA,
  double fractionA,
  String stratB,
  double fractionB,
  Color colorA,
  Color colorB,
) {
  final maxFraction = fractionA > fractionB ? fractionA : fractionB;
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kWhite,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kIndigo500.withAlpha(40)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: _kGray700,
          ),
        ),
        SizedBox(height: 8),
        _buildWidthBar(stratA, fractionA, colorA),
        _buildWidthBar(stratB, fractionB, colorB),
        Divider(height: 16, color: _kGray200),
        _buildWidthBar('MaxColumnWidth result', maxFraction, _kIndigo700),
        SizedBox(height: 4),
        Text(
          'max($stratA, $stratB) → ${(maxFraction * 100).toInt()}%',
          style: TextStyle(
            fontSize: 11,
            color: _kGray500,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Data table simulation
// ---------------------------------------------------------------------------
Widget _buildDataTableSection(
  String title,
  List<List<String>> rows,
  Color headerBg,
  Color headerText,
  Color accent,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withAlpha(50)),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          color: accent.withAlpha(20),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: accent,
            ),
          ),
        ),
        _buildTableRow(rows[0], headerBg, headerText, isHeader: true),
        ...rows
            .skip(1)
            .toList()
            .asMap()
            .entries
            .map(
              (entry) => _buildTableRow(
                entry.value,
                entry.key.isEven ? _kGray100 : _kWhite,
                _kGray700,
              ),
            ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Scenario combo card
// ---------------------------------------------------------------------------
Widget _buildScenarioCard(
  String title,
  String description,
  String widthA,
  String widthB,
  String result,
  Color accent,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: accent.withAlpha(10),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withAlpha(40)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 12, color: _kGray500, height: 1.4),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            _buildStrategyBadge('A: $widthA', accent),
            _buildStrategyBadge('B: $widthB', accent.withAlpha(180)),
          ],
        ),
        SizedBox(height: 6),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: accent.withAlpha(25),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'Result → $result',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: accent,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// build() entry point
// ===========================================================================
dynamic build(BuildContext context) {
  print('--- MaxColumnWidth Demo ---');
  print('MaxColumnWidth picks the larger of two TableColumnWidth strategies');
  print(
    'Strategies: FixedColumnWidth, FractionColumnWidth, '
    'IntrinsicColumnWidth, FlexColumnWidth',
  );

  return SingleChildScrollView(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Title ──────────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_kIndigo500, _kAmber500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MaxColumnWidth',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: _kWhite,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'A TableColumnWidth that returns the larger of two '
                'sub-strategies for every sizing method (min intrinsic, '
                'max intrinsic, flex).',
                style: TextStyle(fontSize: 14, color: _kWhite.withAlpha(220)),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  _buildStrategyBadge('Table', _kWhite.withAlpha(50)),
                  _buildStrategyBadge('Column Width', _kWhite.withAlpha(50)),
                  _buildStrategyBadge('Responsive', _kWhite.withAlpha(50)),
                ],
              ),
            ],
          ),
        ),

        // ── Section 1 : Class overview ────────────────────────
        _buildSectionHeader(
          '01',
          'Class Overview',
          'MaxColumnWidth extends TableColumnWidth',
        ),
        _buildInfoCard('Class', 'MaxColumnWidth', _kIndigo500),
        _buildInfoCard('Super', 'TableColumnWidth', _kAmber500),
        _buildInfoCard('Constructor', 'MaxColumnWidth(a, b)', _kIndigo700),
        _buildInfoCard('Purpose', 'max(a.width, b.width)', _kAmber700),
        _buildInfoCard('Package', 'flutter/rendering.dart', _kGray700),

        // ── Section 2 : Strategy catalogue ────────────────────
        _buildSectionHeader(
          '02',
          'Column Width Strategies',
          'The building blocks MaxColumnWidth combines',
        ),
        _buildStrategyCard(
          'FixedColumnWidth',
          'Always returns a fixed pixel value regardless of table size '
              'or content. Best for icon or checkbox columns.',
          'width = fixed pixels',
          Icons.straighten,
          _kIndigo500,
        ),
        _buildStrategyCard(
          'FractionColumnWidth',
          'Returns a fraction of the total table width. Useful for '
              'percentage-based column layouts.',
          'width = table.width × fraction',
          Icons.pie_chart_outline,
          _kAmber500,
        ),
        _buildStrategyCard(
          'IntrinsicColumnWidth',
          'Sizes the column to fit the widest cell content. Natural '
              'sizing but may cause layout recalculations.',
          'width = max(cell.intrinsic)',
          Icons.format_size,
          _kIndigo700,
        ),
        _buildStrategyCard(
          'FlexColumnWidth',
          'Distributes remaining space proportionally via flex factor. '
              'Like Expanded in a Row.',
          'width = remaining × (flex / totalFlex)',
          Icons.swap_horiz,
          _kAmber700,
        ),

        // ── Section 3 : Visual width comparison ───────────────
        _buildSectionHeader(
          '03',
          'Visual Width Comparison',
          'See how MaxColumnWidth picks the larger bar each time',
        ),
        _buildMaxWidthDemo(
          'Fixed(100px) vs Fraction(0.30)',
          'Fixed 100px',
          0.25,
          'Fraction 30%',
          0.30,
          _kIndigo500,
          _kAmber500,
        ),
        _buildMaxWidthDemo(
          'Fixed(200px) vs Fraction(0.20)',
          'Fixed 200px',
          0.50,
          'Fraction 20%',
          0.20,
          _kIndigo500,
          _kAmber500,
        ),
        _buildMaxWidthDemo(
          'Fraction(0.15) vs Fraction(0.40)',
          'Fraction 15%',
          0.15,
          'Fraction 40%',
          0.40,
          _kIndigo700,
          _kAmber700,
        ),

        // ── Section 4 : Practical data table ──────────────────
        _buildSectionHeader(
          '04',
          'Practical Data Tables',
          'How MaxColumnWidth works in real table layouts',
        ),
        _buildDataTableSection(
          'Product Inventory Table',
          [
            ['SKU', 'Product', 'Qty', 'Price'],
            ['A-1001', 'Widget Pro', '142', '\$29.99'],
            ['A-1002', 'Gadget Ultra', '87', '\$49.99'],
            ['A-1003', 'Component X', '310', '\$12.50'],
            ['A-1004', 'Module Plus', '56', '\$89.00'],
          ],
          _kIndigo500,
          _kWhite,
          _kIndigo500,
        ),
        _buildDataTableSection(
          'Team Performance Table',
          [
            ['Member', 'Tasks', 'Done', 'Score'],
            ['Alice', '24', '22', '92%'],
            ['Bob', '18', '15', '83%'],
            ['Carol', '31', '30', '97%'],
            ['Dave', '12', '11', '92%'],
          ],
          _kAmber500,
          _kWhite,
          _kAmber500,
        ),

        // ── Section 5 : MaxColumnWidth scenarios ──────────────
        _buildSectionHeader(
          '05',
          'Combination Scenarios',
          'Real-world MaxColumnWidth constructor combos',
        ),
        _buildScenarioCard(
          'Minimum-guaranteed width',
          'Ensure a column never shrinks below 120px even if the '
              'fraction-based width is smaller on narrow screens.',
          'Fixed(120)',
          'Fraction(0.25)',
          'At least 120px, wider on large screens',
          _kIndigo500,
        ),
        _buildScenarioCard(
          'Content-aware with floor',
          'Let the column grow to fit content but never go below a '
              'fixed minimum. Ideal for name columns.',
          'Fixed(80)',
          'Intrinsic',
          'Whichever is wider wins',
          _kAmber500,
        ),
        _buildScenarioCard(
          'Dual fraction safety',
          'Use two percentage strategies for responsive layouts with '
              'different breakpoints.',
          'Fraction(0.20)',
          'Fraction(0.15)',
          'Always the larger fraction',
          _kIndigo700,
        ),
        _buildScenarioCard(
          'Flex + fixed baseline',
          'Distribute remaining space via flex but guarantee a minimum '
              'pixel width for readability.',
          'Fixed(100)',
          'Flex(1.0)',
          'Flex when wide, fixed when narrow',
          _kAmber700,
        ),

        // ── Section 6 : Comparison with MinColumnWidth ────────
        _buildSectionHeader(
          '06',
          'Max vs Min Column Width',
          'Understanding the complementary strategies',
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kWhite,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kGray200),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _kIndigo50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.arrow_upward,
                            color: _kIndigo500,
                            size: 28,
                          ),
                          SizedBox(height: 6),
                          Text(
                            'MaxColumnWidth',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: _kIndigo700,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Picks the LARGER of two widths. '
                            'Guarantees a minimum floor.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11,
                              color: _kGray500,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _kAmber50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.arrow_downward,
                            color: _kAmber500,
                            size: 28,
                          ),
                          SizedBox(height: 6),
                          Text(
                            'MinColumnWidth',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: _kAmber700,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Picks the SMALLER of two widths. '
                            'Enforces a maximum cap.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11,
                              color: _kGray500,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _kGray100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Tip: Combine both! MaxColumnWidth(Fixed(80), '
                  'MinColumnWidth(Fraction(0.5), Fixed(200))) ensures '
                  'the column is at least 80px but never more than 200px '
                  'or 50% of the table width.',
                  style: TextStyle(fontSize: 11, color: _kGray700, height: 1.5),
                ),
              ),
            ],
          ),
        ),

        // ── Section 7 : Usage patterns ────────────────────────
        _buildSectionHeader(
          '07',
          'Usage Patterns',
          'Common patterns for MaxColumnWidth in production code',
        ),
        _buildInfoCard(
          'Responsive floor',
          'MaxColumnWidth(Fixed, Fraction)',
          _kIndigo500,
        ),
        _buildInfoCard(
          'Content floor',
          'MaxColumnWidth(Fixed, Intrinsic)',
          _kAmber500,
        ),
        _buildInfoCard(
          'Dual fraction',
          'MaxColumnWidth(Frac, Frac)',
          _kIndigo700,
        ),
        _buildInfoCard(
          'Flex + floor',
          'MaxColumnWidth(Fixed, Flex)',
          _kAmber700,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kIndigo50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kIndigo500.withAlpha(40)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Code pattern',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _kIndigo700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Table(\n'
                '  columnWidths: {\n'
                '    0: MaxColumnWidth(\n'
                '         FixedColumnWidth(80),\n'
                '         FractionColumnWidth(0.25)),\n'
                '    1: FlexColumnWidth(),\n'
                '  },\n'
                '  children: [...],\n'
                ')',
                style: TextStyle(
                  fontSize: 12,
                  color: _kGray700,
                  fontFamily: 'monospace',
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),

        // ── Section 8 : Advanced data table ───────────────────
        _buildSectionHeader(
          '08',
          'Advanced: Multi-Strategy Table',
          'Combining MaxColumnWidth across multiple columns',
        ),
        _buildDataTableSection(
          'Sales Dashboard – Mixed Strategies',
          [
            ['Region', 'Q1', 'Q2', 'Q3', 'Total'],
            ['North', '\$12.4k', '\$15.1k', '\$14.8k', '\$42.3k'],
            ['South', '\$9.8k', '\$11.2k', '\$13.0k', '\$34.0k'],
            ['East', '\$18.1k', '\$16.5k', '\$19.2k', '\$53.8k'],
            ['West', '\$14.3k', '\$13.9k', '\$15.7k', '\$43.9k'],
          ],
          _kIndigo500,
          _kWhite,
          _kIndigo500,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kAmber50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Column strategy breakdown:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _kAmber700,
                ),
              ),
              SizedBox(height: 6),
              Text(
                '• Region: MaxColumnWidth(Fixed(80), Intrinsic)\n'
                '• Q1–Q3: MaxColumnWidth(Fixed(60), Fraction(0.15))\n'
                '• Total: MaxColumnWidth(Fixed(80), Fraction(0.20))',
                style: TextStyle(fontSize: 12, color: _kGray700, height: 1.6),
              ),
            ],
          ),
        ),
        _buildDataTableSection(
          'Employee Directory – Responsive Columns',
          [
            ['Name', 'Dept', 'Role', 'Status'],
            ['Jane Doe', 'Engineering', 'Senior Dev', 'Active'],
            ['John Smith', 'Design', 'Lead Designer', 'Active'],
            ['Ali Khan', 'Product', 'PM', 'On Leave'],
          ],
          _kAmber500,
          _kWhite,
          _kAmber500,
        ),

        // ── Footer ────────────────────────────────────────────
        SizedBox(height: 20),
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_kIndigo500.withAlpha(60), _kAmber500.withAlpha(60)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'MaxColumnWidth Demo • Indigo / Amber',
              style: TextStyle(
                fontSize: 12,
                color: _kGray700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}
