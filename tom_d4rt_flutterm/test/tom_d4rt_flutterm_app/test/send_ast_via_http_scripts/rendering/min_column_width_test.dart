// ignore_for_file: avoid_print
// D4rt Flutter demo: MinColumnWidth – table column strategy using the
// smaller of two TableColumnWidth values. Visual comparison with
// MaxColumnWidth, constraint clamping, responsive table columns,
// and practical data table patterns.
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Color theme constants
// ---------------------------------------------------------------------------
const _kLime500 = Color(0xFF84CC16);
const _kSlate500 = Color(0xFF64748B);
const _kLime700 = Color(0xFF4D7C0F);
const _kSlate700 = Color(0xFF334155);
const _kLime50 = Color(0xFFF7FEE7);
const _kSlate50 = Color(0xFFF8FAFC);
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
        colors: [_kLime500, _kSlate500],
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
// Width bar – visualises a fraction as a coloured bar
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
// MinColumnWidth visual demo
// ---------------------------------------------------------------------------
Widget _buildMinWidthDemo(
  String label,
  String stratA,
  double fractionA,
  String stratB,
  double fractionB,
  Color colorA,
  Color colorB,
) {
  final minFraction = fractionA < fractionB ? fractionA : fractionB;
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kWhite,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kLime500.withAlpha(40)),
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
        _buildWidthBar('MinColumnWidth result', minFraction, _kLime700),
        SizedBox(height: 4),
        Text(
          'min($stratA, $stratB) → ${(minFraction * 100).toInt()}%',
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
// Strategy card with icon
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
// Table row helper
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
// Data table section
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
// Scenario card
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

// ---------------------------------------------------------------------------
// Clamp demo card
// ---------------------------------------------------------------------------
Widget _buildClampDemo(
  String title,
  double rawFraction,
  double clampedFraction,
  Color accent,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kWhite,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withAlpha(40)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: accent,
          ),
        ),
        SizedBox(height: 8),
        _buildWidthBar('Unclamped width', rawFraction, _kGray500),
        _buildWidthBar('MinColumnWidth cap', clampedFraction, accent),
        SizedBox(height: 6),
        Row(
          children: [
            Icon(
              rawFraction > clampedFraction
                  ? Icons.content_cut
                  : Icons.check_circle_outline,
              color: accent,
              size: 16,
            ),
            SizedBox(width: 6),
            Text(
              rawFraction > clampedFraction
                  ? 'Width clamped down by MinColumnWidth'
                  : 'Width unchanged – already smaller',
              style: TextStyle(fontSize: 11, color: _kGray500),
            ),
          ],
        ),
      ],
    ),
  );
}

// ===========================================================================
// build() entry point
// ===========================================================================
dynamic build(BuildContext context) {
  print('--- MinColumnWidth Demo ---');
  print('MinColumnWidth picks the smaller of two TableColumnWidth strategies');
  print('Companion to MaxColumnWidth – enforces a maximum cap on width');
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
              colors: [_kLime500, _kSlate500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MinColumnWidth',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: _kWhite,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'A TableColumnWidth that returns the smaller of two '
                'sub-strategies for every sizing method. Use it to '
                'cap column widths at a maximum.',
                style: TextStyle(fontSize: 14, color: _kWhite.withAlpha(220)),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  _buildStrategyBadge('Table', _kWhite.withAlpha(50)),
                  _buildStrategyBadge('Cap Width', _kWhite.withAlpha(50)),
                  _buildStrategyBadge('Responsive', _kWhite.withAlpha(50)),
                ],
              ),
            ],
          ),
        ),

        // ── Section 1: Class overview ─────────────────────────
        _buildSectionHeader(
          '01',
          'Class Overview',
          'MinColumnWidth extends TableColumnWidth',
        ),
        _buildInfoCard('Class', 'MinColumnWidth', _kLime500),
        _buildInfoCard('Super', 'TableColumnWidth', _kSlate500),
        _buildInfoCard('Constructor', 'MinColumnWidth(a, b)', _kLime700),
        _buildInfoCard('Purpose', 'min(a.width, b.width)', _kSlate700),
        _buildInfoCard('Package', 'flutter/rendering.dart', _kGray700),

        // ── Section 2: How Min differs from Max ───────────────
        _buildSectionHeader(
          '02',
          'Min vs Max Column Width',
          'Understanding the complementary strategies side by side',
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
                        color: _kLime50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.arrow_downward,
                            color: _kLime500,
                            size: 28,
                          ),
                          SizedBox(height: 6),
                          Text(
                            'MinColumnWidth',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: _kLime700,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Picks the SMALLER of two widths. '
                            'Enforces a maximum cap on column size.',
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
                        color: _kSlate50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.arrow_upward, color: _kSlate500, size: 28),
                          SizedBox(height: 6),
                          Text(
                            'MaxColumnWidth',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: _kSlate700,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Picks the LARGER of two widths. '
                            'Guarantees a minimum floor on column size.',
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
                  'MinColumnWidth caps growth → prevents columns from '
                  'becoming too wide on large screens.\n'
                  'MaxColumnWidth guarantees floor → prevents columns from '
                  'shrinking too much on small screens.',
                  style: TextStyle(fontSize: 11, color: _kGray700, height: 1.5),
                ),
              ),
            ],
          ),
        ),

        // ── Section 3: Visual width comparison ────────────────
        _buildSectionHeader(
          '03',
          'Visual Width Comparison',
          'See how MinColumnWidth picks the smaller bar each time',
        ),
        _buildMinWidthDemo(
          'Fixed(200px) vs Fraction(0.30)',
          'Fixed 200px',
          0.50,
          'Fraction 30%',
          0.30,
          _kSlate500,
          _kLime500,
        ),
        _buildMinWidthDemo(
          'Fixed(80px) vs Fraction(0.50)',
          'Fixed 80px',
          0.20,
          'Fraction 50%',
          0.50,
          _kSlate500,
          _kLime500,
        ),
        _buildMinWidthDemo(
          'Fraction(0.60) vs Fraction(0.35)',
          'Fraction 60%',
          0.60,
          'Fraction 35%',
          0.35,
          _kSlate700,
          _kLime700,
        ),

        // ── Section 4: Constraint clamping ────────────────────
        _buildSectionHeader(
          '04',
          'Constraint Clamping',
          'MinColumnWidth caps column growth at specified limits',
        ),
        _buildClampDemo(
          'Intrinsic content wider than fixed cap',
          0.70,
          0.35,
          _kLime500,
        ),
        _buildClampDemo(
          'Fraction cap on a wide flex column',
          0.85,
          0.50,
          _kSlate500,
        ),
        _buildClampDemo(
          'Already within limits – no clamping',
          0.25,
          0.25,
          _kLime700,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kLime50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'MinColumnWidth acts like a clamp: it lets the column use '
            'its natural width up to a ceiling defined by the second '
            'strategy. Beyond that, the width is capped.',
            style: TextStyle(fontSize: 12, color: _kGray700, height: 1.5),
          ),
        ),

        // ── Section 5: Practical data tables ──────────────────
        _buildSectionHeader(
          '05',
          'Practical Data Tables',
          'MinColumnWidth in real table layouts',
        ),
        _buildDataTableSection(
          'Capped Product Table',
          [
            ['ID', 'Product', 'Category', 'Price'],
            ['001', 'Widget Pro', 'Tools', '\$29.99'],
            ['002', 'Super Gadget', 'Electronics', '\$149.00'],
            ['003', 'Nano Component', 'Parts', '\$8.50'],
            ['004', 'Mega Module', 'Hardware', '\$245.00'],
          ],
          _kLime500,
          _kWhite,
          _kLime500,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kSlate50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Column strategy:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _kSlate700,
                ),
              ),
              SizedBox(height: 6),
              Text(
                '• ID: MinColumnWidth(Intrinsic, Fixed(60))  → capped at 60px\n'
                '• Product: MinColumnWidth(Flex(2), Fraction(0.4))  → max 40%\n'
                '• Category: MinColumnWidth(Intrinsic, Fixed(120))  → max 120px\n'
                '• Price: FixedColumnWidth(80)',
                style: TextStyle(fontSize: 12, color: _kGray700, height: 1.6),
              ),
            ],
          ),
        ),
        _buildDataTableSection(
          'Responsive Schedule Table',
          [
            ['Time', 'Event', 'Room', 'Speaker'],
            ['09:00', 'Keynote', 'Main Hall', 'Dr. Smith'],
            ['10:30', 'Workshop A', 'Room 201', 'J. Doe'],
            ['12:00', 'Lunch', 'Cafeteria', '—'],
            ['14:00', 'Panel', 'Room 101', 'Team'],
          ],
          _kSlate500,
          _kWhite,
          _kSlate500,
        ),

        // ── Section 6: Combination scenarios ──────────────────
        _buildSectionHeader(
          '06',
          'Combination Scenarios',
          'Real-world MinColumnWidth constructor combos',
        ),
        _buildScenarioCard(
          'Maximum-capped column',
          'Prevent a content-sized column from exceeding 200px '
              'even with very long text.',
          'Intrinsic',
          'Fixed(200)',
          'Content width, capped at 200px',
          _kLime500,
        ),
        _buildScenarioCard(
          'Fraction ceiling on flex',
          'Allow flex distribution but never exceed 40% of the '
              'table width for this column.',
          'Flex(1.0)',
          'Fraction(0.40)',
          'Flex when narrow, capped at 40%',
          _kSlate500,
        ),
        _buildScenarioCard(
          'Dual fraction – pick tighter',
          'Use two percentage strategies and always pick the '
              'narrower one for compact layouts.',
          'Fraction(0.30)',
          'Fraction(0.20)',
          'Always the smaller percentage',
          _kLime700,
        ),
        _buildScenarioCard(
          'Fixed + fixed ceiling',
          'Ensure column never goes over 150px even if another '
              'fixed strategy says 200px.',
          'Fixed(200)',
          'Fixed(150)',
          'Hard cap at 150px',
          _kSlate700,
        ),

        // ── Section 7: Code patterns ──────────────────────────
        _buildSectionHeader(
          '07',
          'Code Patterns',
          'Common patterns for MinColumnWidth in production',
        ),
        _buildInfoCard(
          'Cap pattern',
          'MinColumnWidth(Intrinsic, Fixed)',
          _kLime500,
        ),
        _buildInfoCard(
          'Fraction cap',
          'MinColumnWidth(Flex, Fraction)',
          _kSlate500,
        ),
        _buildInfoCard(
          'Dual fraction',
          'MinColumnWidth(Frac, Frac)',
          _kLime700,
        ),
        _buildInfoCard(
          'Nested combo',
          'Max(Fixed, Min(Frac, Fixed))',
          _kSlate700,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kLime50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kLime500.withAlpha(40)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Code pattern',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _kLime700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Table(\n'
                '  columnWidths: {\n'
                '    0: MinColumnWidth(\n'
                '         IntrinsicColumnWidth(),\n'
                '         FixedColumnWidth(200)),\n'
                '    1: MinColumnWidth(\n'
                '         FlexColumnWidth(),\n'
                '         FractionColumnWidth(0.4)),\n'
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

        // ── Section 8: Responsive table best practices ────────
        _buildSectionHeader(
          '08',
          'Best Practices',
          'Tips for using MinColumnWidth in responsive tables',
        ),
        _buildStrategyCard(
          'Use Min for Maximum Caps',
          'MinColumnWidth picks the smaller width – use it to prevent '
              'columns from growing too wide on large screens.',
          'Cap = min(actual, ceiling)',
          Icons.vertical_align_top,
          _kLime500,
        ),
        _buildStrategyCard(
          'Combine with MaxColumnWidth',
          'Nest MinColumnWidth inside MaxColumnWidth (or vice versa) '
              'to create a width range: guaranteed floor AND ceiling.',
          'range = max(floor, min(x, ceiling))',
          Icons.unfold_more,
          _kSlate500,
        ),
        _buildStrategyCard(
          'Test on Multiple Widths',
          'Column strategies resolve differently at different table '
              'widths. Test on narrow (320px), medium (768px), and wide '
              '(1200px) layouts.',
          'Responsive testing',
          Icons.devices,
          _kLime700,
        ),
        _buildStrategyCard(
          'Prefer Fraction for Responsive Caps',
          'Using Fraction as the cap strategy scales with screen size. '
              'Fixed caps may truncate on very small screens.',
          'MinColumnWidth(Intrinsic, Fraction(0.5))',
          Icons.aspect_ratio,
          _kSlate700,
        ),
        Container(
          margin: EdgeInsets.only(top: 8, bottom: 4),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kSlate50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kSlate500.withAlpha(40)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Summary',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _kSlate700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '• MinColumnWidth is the inverse of MaxColumnWidth.\n'
                '• Use it to cap, not to guarantee minimums.\n'
                '• Nesting Max(floor, Min(x, ceiling)) gives a range.\n'
                '• Always test with real data to see actual sizing.\n'
                '• Prefer fraction-based caps for responsive layouts.',
                style: TextStyle(fontSize: 12, color: _kGray700, height: 1.6),
              ),
            ],
          ),
        ),

        // ── Footer ────────────────────────────────────────────
        SizedBox(height: 20),
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_kLime500.withAlpha(60), _kSlate500.withAlpha(60)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'MinColumnWidth Demo • Lime / Slate',
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
