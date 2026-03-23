// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt Flutter demo: MainAxisSize – min vs max sizing along main axis
// Visual comparison of MainAxisSize.min (shrink-wrap) vs MainAxisSize.max
// (expand to parent) in Row and Column, practical button bars, centering
// tricks, and constraint-aware layout patterns.
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Color theme constants
// ---------------------------------------------------------------------------
const _kRose500 = Color(0xFFF43F5E);
const _kCyan500 = Color(0xFF06B6D4);
const _kRose700 = Color(0xFFBE123C);
const _kCyan700 = Color(0xFF0E7490);
const _kRose50 = Color(0xFFFFF1F2);
const _kCyan50 = Color(0xFFECFEFF);
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
        colors: [_kRose500, _kCyan500],
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
// Colored sample box
// ---------------------------------------------------------------------------
Widget _buildSampleBox(String label, Color bg, {double width = 80}) {
  return Container(
    width: width,
    height: 40,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11,
        color: _kWhite,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Size comparison row – shows min vs max side by side
// ---------------------------------------------------------------------------
Widget _buildSizeComparisonRow(String title, MainAxisSize size, Color accent) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kWhite,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withAlpha(60)),
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
        SizedBox(height: 8),
        // The Row itself uses the given MainAxisSize
        Container(
          color: _kGray100,
          padding: EdgeInsets.all(4),
          child: Row(
            mainAxisSize: size,
            children: [
              _buildSampleBox('A', accent),
              SizedBox(width: 8),
              _buildSampleBox('B', accent.withAlpha(180)),
              SizedBox(width: 8),
              _buildSampleBox('C', accent.withAlpha(120)),
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(
          size == MainAxisSize.min
              ? 'Row shrinks to fit children (min)'
              : 'Row expands to fill parent (max)',
          style: TextStyle(fontSize: 11, color: _kGray500),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Column size demo – vertical layout
// ---------------------------------------------------------------------------
Widget _buildColumnSizeDemo(String title, MainAxisSize size, Color accent) {
  return Container(
    width: 140,
    margin: EdgeInsets.only(right: 12),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _kWhite,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withAlpha(60)),
    ),
    child: Column(
      mainAxisSize: size,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        SizedBox(height: 6),
        Container(height: 24, width: 80, color: accent),
        SizedBox(height: 4),
        Container(height: 24, width: 80, color: accent.withAlpha(180)),
        SizedBox(height: 4),
        Container(height: 24, width: 80, color: accent.withAlpha(120)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Button bar demo – practical use of MainAxisSize in button groups
// ---------------------------------------------------------------------------
Widget _buildButtonBar(
  String title,
  MainAxisSize size,
  List<String> labels,
  Color accent,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: accent.withAlpha(15),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withAlpha(50)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: _kGray700,
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisSize: size,
          mainAxisAlignment: MainAxisAlignment.center,
          children: labels
              .map(
                (l) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    l,
                    style: TextStyle(
                      color: _kWhite,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        SizedBox(height: 6),
        Text(
          'MainAxisSize.${size.name}',
          style: TextStyle(fontSize: 11, color: _kGray500),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Constraint card – explains constraints
// ---------------------------------------------------------------------------
Widget _buildConstraintCard(
  String title,
  String description,
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
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: _kGray500, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Centering demo – shows centering trick with min
// ---------------------------------------------------------------------------
Widget _buildCenteringDemo(String title, MainAxisSize size, Color accent) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kGray100,
      borderRadius: BorderRadius.circular(10),
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
        Center(
          child: Column(
            mainAxisSize: size,
            children: [
              Container(
                width: 200,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Centered content',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: _kWhite, fontSize: 13),
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: 160,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accent.withAlpha(150),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Secondary',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: _kWhite, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Column uses MainAxisSize.${size.name}',
          style: TextStyle(fontSize: 11, color: _kGray500),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Card layout demo – practical card with MainAxisSize
// ---------------------------------------------------------------------------
Widget _buildCardLayoutDemo(
  String title,
  String subtitle,
  MainAxisSize rowSize,
  Color accent,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kWhite,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: accent.withAlpha(20),
          blurRadius: 8,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: rowSize,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: accent.withAlpha(30),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.widgets_outlined, color: accent, size: 24),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: _kGray700,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: _kGray500),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisSize: rowSize,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: accent),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'Details',
                style: TextStyle(color: accent, fontSize: 12),
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'Action',
                style: TextStyle(color: _kWhite, fontSize: 12),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Nested size demo – shows nesting behaviour
// ---------------------------------------------------------------------------
Widget _buildNestedSizeDemo(Color accent) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: accent.withAlpha(10),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withAlpha(40)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Outer Column (min)',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: accent,
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kWhite,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kGray200),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Inner Row (max)',
                style: TextStyle(fontSize: 12, color: _kGray700),
              ),
              Icon(Icons.arrow_forward, color: accent, size: 16),
            ],
          ),
        ),
        SizedBox(height: 6),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kWhite,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kGray200),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.compress, color: accent, size: 16),
              SizedBox(width: 6),
              Text(
                'Inner Row (min)',
                style: TextStyle(fontSize: 12, color: _kGray700),
              ),
            ],
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Nested min/max interact with parent constraints',
          style: TextStyle(fontSize: 11, color: _kGray500),
        ),
      ],
    ),
  );
}

// ===========================================================================
// build() entry point
// ===========================================================================
dynamic build(BuildContext context) {
  print('--- MainAxisSize Demo ---');
  print('MainAxisSize.min: shrink-wraps children');
  print('MainAxisSize.max: expands to fill parent');
  print('Values: ${MainAxisSize.values.map((v) => v.name).join(", ")}');

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
              colors: [_kRose500, _kCyan500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MainAxisSize',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: _kWhite,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Controls whether a Flex widget (Row / Column) takes '
                'the minimum or maximum space along its main axis.',
                style: TextStyle(fontSize: 14, color: _kWhite.withAlpha(220)),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _kWhite.withAlpha(40),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'min',
                      style: TextStyle(
                        color: _kWhite,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _kWhite.withAlpha(40),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'max',
                      style: TextStyle(
                        color: _kWhite,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // ── Section 1 : Enum overview ─────────────────────────
        _buildSectionHeader(
          '01',
          'Enum Values',
          'MainAxisSize has exactly two values: min and max',
        ),
        _buildInfoCard('MainAxisSize.min', 'Shrink-wrap children', _kRose500),
        _buildInfoCard('MainAxisSize.max', 'Expand to fill parent', _kCyan500),
        _buildInfoCard(
          'Default value',
          'MainAxisSize.max (in Row & Column)',
          _kGray700,
        ),
        _buildInfoCard('Affected widgets', 'Row, Column, Flex', _kRose700),
        _buildInfoCard(
          'Constraint impact',
          'Changes tight vs loose sizing',
          _kCyan700,
        ),

        // ── Section 2 : Row comparison ────────────────────────
        _buildSectionHeader(
          '02',
          'Row – Min vs Max',
          'Horizontal sizing behaviour side by side',
        ),
        _buildSizeComparisonRow(
          'MainAxisSize.min',
          MainAxisSize.min,
          _kRose500,
        ),
        _buildSizeComparisonRow(
          'MainAxisSize.max',
          MainAxisSize.max,
          _kCyan500,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kRose50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'With min, the Row width equals the sum of its children. '
            'With max, it stretches to the parent full width.',
            style: TextStyle(fontSize: 12, color: _kGray700, height: 1.5),
          ),
        ),

        // ── Section 3 : Column comparison ─────────────────────
        _buildSectionHeader(
          '03',
          'Column – Min vs Max',
          'Vertical sizing behaviour comparison',
        ),
        Container(
          height: 200,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kGray100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildColumnSizeDemo('min', MainAxisSize.min, _kRose500),
              _buildColumnSizeDemo('max', MainAxisSize.max, _kCyan500),
            ],
          ),
        ),
        SizedBox(height: 6),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kCyan50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'A Column with MainAxisSize.min uses only enough height for '
            'its children, while .max fills the remaining vertical space.',
            style: TextStyle(fontSize: 12, color: _kGray700, height: 1.5),
          ),
        ),

        // ── Section 4 : Practical button bars ─────────────────
        _buildSectionHeader(
          '04',
          'Practical: Button Bars',
          'How MainAxisSize affects button groups in real UIs',
        ),
        _buildButtonBar('Compact button group (min)', MainAxisSize.min, [
          'Save',
          'Cancel',
        ], _kRose500),
        _buildButtonBar('Full-width button group (max)', MainAxisSize.max, [
          'Save',
          'Cancel',
        ], _kCyan500),
        _buildButtonBar('Three actions – min', MainAxisSize.min, [
          'Edit',
          'Share',
          'Delete',
        ], _kRose700),
        _buildButtonBar('Three actions – max', MainAxisSize.max, [
          'Edit',
          'Share',
          'Delete',
        ], _kCyan700),

        // ── Section 5 : Layout constraints ────────────────────
        _buildSectionHeader(
          '05',
          'How Constraints Work',
          'MainAxisSize changes tight vs loose constraint resolution',
        ),
        _buildConstraintCard(
          'Tight constraint (max)',
          'When MainAxisSize.max, the flex widget tells its parent it '
              'wants to be as wide/tall as possible, resulting in a tight '
              'constraint along the main axis.',
          Icons.open_in_full,
          _kCyan500,
        ),
        _buildConstraintCard(
          'Loose constraint (min)',
          'With MainAxisSize.min, the widget tells its parent it only '
              'needs enough space for its children, producing a loose '
              'constraint that shrink-wraps.',
          Icons.close_fullscreen,
          _kRose500,
        ),
        _buildConstraintCard(
          'Unconstrained parents',
          'Inside a ListView or another scrollable, the main axis is '
              'unconstrained. In that case min avoids infinite-size errors '
              'while max may cause layout issues.',
          Icons.warning_amber_rounded,
          _kRose700,
        ),
        _buildConstraintCard(
          'CrossAxisAlignment interaction',
          'MainAxisSize only affects the main axis – the cross axis is '
              'controlled independently by crossAxisAlignment and the '
              'parent cross-axis constraints.',
          Icons.swap_horiz,
          _kCyan700,
        ),

        // ── Section 6 : Centering patterns ────────────────────
        _buildSectionHeader(
          '06',
          'Centering Patterns',
          'Using MainAxisSize.min with Center for compact layouts',
        ),
        _buildCenteringDemo(
          'Center + Column(min) – compact',
          MainAxisSize.min,
          _kRose500,
        ),
        _buildCenteringDemo(
          'Center + Column(max) – fills height',
          MainAxisSize.max,
          _kCyan500,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 6),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kRose50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Tip: Wrap a Column(mainAxisSize: MainAxisSize.min) inside '
            'Center to get a compact vertically-centered group. This is '
            'common in dialogs and empty-state screens.',
            style: TextStyle(
              fontSize: 12,
              color: _kGray700,
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),

        // ── Section 7 : Card layouts ──────────────────────────
        _buildSectionHeader(
          '07',
          'Card Layouts',
          'MainAxisSize in real-world card UI patterns',
        ),
        _buildCardLayoutDemo(
          'Compact card row',
          'MainAxisSize.min – buttons hug content',
          MainAxisSize.min,
          _kRose500,
        ),
        _buildCardLayoutDemo(
          'Full-width card row',
          'MainAxisSize.max – buttons span card',
          MainAxisSize.max,
          _kCyan500,
        ),
        _buildCardLayoutDemo(
          'Settings card',
          'Toggle row with min sizing',
          MainAxisSize.min,
          _kRose700,
        ),

        // ── Section 8 : Nesting & best practices ──────────────
        _buildSectionHeader(
          '08',
          'Nesting & Best Practices',
          'How nested min/max interact and when to use each',
        ),
        _buildNestedSizeDemo(_kRose500),
        _buildNestedSizeDemo(_kCyan500),
        Container(
          margin: EdgeInsets.only(top: 8, bottom: 4),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kCyan50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kCyan500.withAlpha(40)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Best practices',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _kCyan700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '• Use MainAxisSize.min inside scrollables to avoid '
                'unbounded-height errors.\n'
                '• Pair with MainAxisAlignment to control spacing.\n'
                '• In dialogs, Column(min) + Center prevents overflow.\n'
                '• Prefer max for top-level page layouts so content '
                'fills the screen.\n'
                '• Test both values to visualise constraint behaviour.',
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
                colors: [_kRose500.withAlpha(60), _kCyan500.withAlpha(60)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'MainAxisSize Demo • Rose / Cyan',
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
