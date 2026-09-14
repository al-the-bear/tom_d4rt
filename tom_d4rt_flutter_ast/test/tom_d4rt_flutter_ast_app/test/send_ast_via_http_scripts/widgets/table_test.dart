// D4rt deep visual demo: Table, TableRow, TableCell, TableColumnWidth, TableBorder.
// This script renders an extensive visual reference of the Flutter Table widget
// family. It covers every column-width strategy, border variant, vertical
// alignment, and a series of real-world layouts (pricing matrix, comparison
// grid, schedule, financial summary, settings, cards, leading icons, actions).
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// PALETTE
// ---------------------------------------------------------------------------
const Color _kInk = Color(0xFF18223A);
const Color _kInkSoft = Color(0xFF4C5577);
const Color _kInkMuted = Color(0xFF7A819A);
const Color _kBg = Color(0xFFF4F1EC);
const Color _kSurface = Color(0xFFFFFFFF);
const Color _kSurfaceAlt = Color(0xFFF8F5EF);
const Color _kSurfaceDeep = Color(0xFFEDE7DC);
const Color _kBorder = Color(0xFFD8D2C4);
const Color _kBorderSoft = Color(0xFFE6E1D4);

const Color _kAccent = Color(0xFF2F6F5E);
const Color _kAccentSoft = Color(0xFFD9ECDF);
const Color _kAccentDeep = Color(0xFF1F4D40);

const Color _kPlum = Color(0xFF6B3F71);
const Color _kPlumSoft = Color(0xFFE9D8EC);

const Color _kAmber = Color(0xFFB36100);
const Color _kAmberSoft = Color(0xFFFCE7C2);

const Color _kRose = Color(0xFFB13A55);
const Color _kRoseSoft = Color(0xFFF6D9DF);

const Color _kIndigo = Color(0xFF334F8C);
const Color _kIndigoSoft = Color(0xFFD8E1F4);

const Color _kTeal = Color(0xFF1F7A8C);
const Color _kTealSoft = Color(0xFFD0E8EE);

const Color _kSlate = Color(0xFF445063);
const Color _kSlateSoft = Color(0xFFDDE2EA);

const Color _kSuccess = Color(0xFF1B7A3F);
const Color _kDanger = Color(0xFFB3261E);
const Color _kWarn = Color(0xFFB36100);

// ---------------------------------------------------------------------------
// ENTRY POINT
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return Scaffold(
    backgroundColor: _kBg,
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 28, 22, 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _heroHeader(),
            _gap(),
            _section01SimpleTable(),
            _gap(),
            _section02FixedColumnWidth(),
            _gap(),
            _section03FlexColumnWidth(),
            _gap(),
            _section04IntrinsicColumnWidth(),
            _gap(),
            _section05FractionColumnWidth(),
            _gap(),
            _section06MinMaxColumnWidth(),
            _gap(),
            _section07TableBorderVariants(),
            _gap(),
            _section08VerticalAlignments(),
            _gap(),
            _section09TextBaselineAndDefault(),
            _gap(),
            _section10HeaderAndStripedRows(),
            _gap(),
            _section11PricingMatrix(),
            _gap(),
            _section12FeatureComparison(),
            _gap(),
            _section13ScheduleGrid(),
            _gap(),
            _section14FinancialSummary(),
            _gap(),
            _section15SettingsKeyValue(),
            _gap(),
            _section16TableInCardWithIconsAndActions(),
            _gap(),
            _footer(),
          ],
        ),
      ),
    ),
  );
}

Widget _gap() => const SizedBox(height: 28);

// ---------------------------------------------------------------------------
// SECTION SHELL HELPER
// Required signature from the spec: title, subtitle, surface, border,
// titleColor, child.
// ---------------------------------------------------------------------------
Widget _sectionShell({
  required String title,
  required String subtitle,
  required Color surface,
  required Color border,
  required Color titleColor,
  required Widget child,
}) {
  return Container(
    padding: const EdgeInsets.fromLTRB(24, 22, 24, 26),
    decoration: BoxDecoration(
      color: surface,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: border, width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: titleColor.withValues(alpha: 0.06),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 6,
              height: 30,
              margin: const EdgeInsets.only(top: 6, right: 12),
              decoration: BoxDecoration(
                color: titleColor,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.1,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: _kInkSoft,
                      fontSize: 13.5,
                      height: 1.55,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        child,
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// HERO HEADER
// ---------------------------------------------------------------------------
Widget _heroHeader() {
  return Container(
    padding: const EdgeInsets.fromLTRB(28, 30, 28, 30),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF1F4D40),
          Color(0xFF2F6F5E),
          Color(0xFF6B3F71),
        ],
      ),
      borderRadius: BorderRadius.circular(24),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 22,
          offset: Offset(0, 12),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.35),
                  width: 1.2,
                ),
              ),
              child: const Icon(
                Icons.table_chart,
                color: Colors.white,
                size: 38,
              ),
            ),
            const SizedBox(width: 18),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Flutter Table — Deep Demo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.3,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'TableRow, TableCell, TableBorder and every '
                    'TableColumnWidth strategy — rendered through D4rt at '
                    'runtime.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            _heroBadge('Table'),
            _heroBadge('TableRow'),
            _heroBadge('TableCell'),
            _heroBadge('TableBorder'),
            _heroBadge('FixedColumnWidth'),
            _heroBadge('FlexColumnWidth'),
            _heroBadge('IntrinsicColumnWidth'),
            _heroBadge('FractionColumnWidth'),
            _heroBadge('MaxColumnWidth'),
            _heroBadge('MinColumnWidth'),
            _heroBadge('VerticalAlignment'),
            _heroBadge('columnWidths'),
          ],
        ),
      ],
    ),
  );
}

Widget _heroBadge(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Colors.white.withValues(alpha: 0.45),
        width: 1,
      ),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// FOOTER
// ---------------------------------------------------------------------------
Widget _footer() {
  return Container(
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      color: _kInk,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.check_circle_outline,
            color: Colors.white,
            size: 26,
          ),
        ),
        const SizedBox(width: 14),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'End of Table Reference',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Sixteen sections of Table widget behaviour rendered '
                'through D4rt interpretation.',
                style: TextStyle(
                  color: Color(0xFFCBCBD6),
                  fontSize: 12.5,
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

// ---------------------------------------------------------------------------
// SHARED UI BUILDERS
// ---------------------------------------------------------------------------
Widget _narrative(String text, Color accent) {
  return Container(
    margin: const EdgeInsets.only(bottom: 14),
    padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(12),
      border: Border(left: BorderSide(color: accent, width: 4)),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: _kInk,
        fontSize: 13,
        height: 1.55,
      ),
    ),
  );
}

Widget _miniLabel(String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.45), width: 1),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 10.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
      ),
    ),
  );
}

Widget _cellText(
  String text, {
  Color color = _kInk,
  double size = 13.5,
  FontWeight weight = FontWeight.w500,
  TextAlign align = TextAlign.left,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    child: Text(
      text,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight,
        height: 1.35,
      ),
    ),
  );
}

Widget _headerCell(
  String text, {
  Color background = _kAccent,
  Color color = Colors.white,
  TextAlign align = TextAlign.left,
}) {
  return Container(
    color: background,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    child: Text(
      text,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontSize: 12.5,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.5,
      ),
    ),
  );
}

Widget _stripedCell(
  String text, {
  required bool odd,
  Color color = _kInk,
  TextAlign align = TextAlign.left,
  FontWeight weight = FontWeight.w500,
}) {
  return Container(
    color: odd ? const Color(0xFFF6F2EA) : Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    child: Text(
      text,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontSize: 13.5,
        fontWeight: weight,
      ),
    ),
  );
}

Widget _calloutChip({
  required IconData icon,
  required String text,
  required Color color,
}) {
  return Container(
    margin: const EdgeInsets.only(right: 8, bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withValues(alpha: 0.45)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 01 — Simple Table layout
// ===========================================================================
Widget _section01SimpleTable() {
  return _sectionShell(
    title: '01 — Simple Table layout',
    subtitle:
        'The bare minimum: a Table whose children are TableRows of plain '
        'Text widgets. Without explicit column widths the table defaults to '
        'FlexColumnWidth(1.0) for every column, producing equal-width cells.',
    surface: _kSurface,
    border: _kBorder,
    titleColor: _kAccent,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _narrative(
          'Tables are unique in Flutter — they perform their own layout '
          'rather than delegating to Flex. Each TableRow must have the same '
          'number of children, and the table widget is greedy on the cross '
          'axis: it fills the available horizontal space.',
          _kAccent,
        ),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kSurfaceAlt,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kBorderSoft),
          ),
          child: Table(
            children: const <TableRow>[
              TableRow(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Cell A1',
                      style: TextStyle(
                        color: _kInk,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Cell B1',
                      style: TextStyle(
                        color: _kInk,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Cell C1',
                      style: TextStyle(
                        color: _kInk,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Cell A2',
                      style: TextStyle(color: _kInkSoft),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Cell B2',
                      style: TextStyle(color: _kInkSoft),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Cell C2',
                      style: TextStyle(color: _kInkSoft),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Cell A3',
                      style: TextStyle(color: _kInkSoft),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Cell B3',
                      style: TextStyle(color: _kInkSoft),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Cell C3',
                      style: TextStyle(color: _kInkSoft),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          children: <Widget>[
            _calloutChip(
              icon: Icons.grid_on,
              text: 'No border',
              color: _kAccent,
            ),
            _calloutChip(
              icon: Icons.straighten,
              text: 'Equal columns',
              color: _kIndigo,
            ),
            _calloutChip(
              icon: Icons.text_fields,
              text: 'Text cells',
              color: _kPlum,
            ),
          ],
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 02 — FixedColumnWidth
// ===========================================================================
Widget _section02FixedColumnWidth() {
  return _sectionShell(
    title: '02 — FixedColumnWidth',
    subtitle:
        'FixedColumnWidth pins a column to an exact logical pixel width. '
        'Useful for badges, icon columns or fixed-width identifiers where you '
        'do not want layout drift.',
    surface: _kSurface,
    border: _kBorder,
    titleColor: _kIndigo,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _narrative(
          'In this table column 0 is 60px, column 1 is 120px, column 2 takes '
          'the remaining flex. Mixing FixedColumnWidth with FlexColumnWidth '
          'lets you anchor certain columns while letting others breathe.',
          _kIndigo,
        ),
        Container(
          decoration: BoxDecoration(
            color: _kSurfaceAlt,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kBorderSoft),
          ),
          padding: const EdgeInsets.all(12),
          child: Table(
            border: TableBorder.all(color: _kBorderSoft, width: 1),
            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(60),
              1: FixedColumnWidth(120),
              2: FlexColumnWidth(),
            },
            children: <TableRow>[
              TableRow(
                decoration: const BoxDecoration(color: _kIndigoSoft),
                children: <Widget>[
                  _cellText('#',
                      align: TextAlign.center,
                      weight: FontWeight.w800,
                      color: _kIndigo),
                  _cellText('CODE',
                      weight: FontWeight.w800, color: _kIndigo),
                  _cellText('DESCRIPTION',
                      weight: FontWeight.w800, color: _kIndigo),
                ],
              ),
              TableRow(
                children: <Widget>[
                  _cellText('1', align: TextAlign.center),
                  _cellText('SKU-AC-001'),
                  _cellText('Stainless steel water bottle, 750ml, brushed'),
                ],
              ),
              TableRow(
                children: <Widget>[
                  _cellText('2', align: TextAlign.center),
                  _cellText('SKU-BK-042'),
                  _cellText('Hardcover notebook, A5, dotted, 240 pages'),
                ],
              ),
              TableRow(
                children: <Widget>[
                  _cellText('3', align: TextAlign.center),
                  _cellText('SKU-CN-117'),
                  _cellText('Ceramic mug, 350ml, matte glaze, dishwasher safe'),
                ],
              ),
              TableRow(
                children: <Widget>[
                  _cellText('4', align: TextAlign.center),
                  _cellText('SKU-DP-203'),
                  _cellText('Desk pad, leather grain, 80 x 40cm, dark navy'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: <Widget>[
            _miniLabel('FixedColumnWidth(60)', _kIndigo),
            const SizedBox(width: 8),
            _miniLabel('FixedColumnWidth(120)', _kIndigo),
            const SizedBox(width: 8),
            _miniLabel('FlexColumnWidth()', _kAccent),
          ],
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 03 — FlexColumnWidth
// ===========================================================================
Widget _section03FlexColumnWidth() {
  return _sectionShell(
    title: '03 — FlexColumnWidth',
    subtitle:
        'FlexColumnWidth distributes the remaining space proportionally to '
        'its flex factor — exactly like the flex parameter on Expanded.',
    surface: _kSurface,
    border: _kBorder,
    titleColor: _kPlum,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _narrative(
          'In the table below the three columns use flex 1, 2 and 3 — so '
          'they consume 1/6, 2/6 and 3/6 of the available width respectively. '
          'Useful for content that should scale with the viewport.',
          _kPlum,
        ),
        Container(
          decoration: BoxDecoration(
            color: _kSurfaceAlt,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kBorderSoft),
          ),
          padding: const EdgeInsets.all(12),
          child: Table(
            border: TableBorder.all(color: _kBorderSoft, width: 1),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(3),
            },
            children: <TableRow>[
              TableRow(
                decoration: const BoxDecoration(color: _kPlumSoft),
                children: <Widget>[
                  _cellText('FLEX 1',
                      weight: FontWeight.w800,
                      color: _kPlum,
                      align: TextAlign.center),
                  _cellText('FLEX 2',
                      weight: FontWeight.w800,
                      color: _kPlum,
                      align: TextAlign.center),
                  _cellText('FLEX 3',
                      weight: FontWeight.w800,
                      color: _kPlum,
                      align: TextAlign.center),
                ],
              ),
              TableRow(
                children: <Widget>[
                  _cellText('1/6', align: TextAlign.center),
                  _cellText('2/6', align: TextAlign.center),
                  _cellText('3/6', align: TextAlign.center),
                ],
              ),
              TableRow(
                children: <Widget>[
                  _cellText('Compact'),
                  _cellText('Medium width column'),
                  _cellText('The widest column — useful for descriptions'),
                ],
              ),
              TableRow(
                children: <Widget>[
                  _cellText('id'),
                  _cellText('label'),
                  _cellText('A longer body of text that needs more room'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          children: <Widget>[
            _calloutChip(
              icon: Icons.linear_scale,
              text: 'Proportional',
              color: _kPlum,
            ),
            _calloutChip(
              icon: Icons.swap_horiz,
              text: 'Responsive',
              color: _kIndigo,
            ),
          ],
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 04 — IntrinsicColumnWidth
// ===========================================================================
Widget _section04IntrinsicColumnWidth() {
  return _sectionShell(
    title: '04 — IntrinsicColumnWidth',
    subtitle:
        'IntrinsicColumnWidth sizes a column to the widest of its contents. '
        'It is the most expensive sizing because Flutter must measure every '
        'cell — use sparingly.',
    surface: _kSurface,
    border: _kBorder,
    titleColor: _kTeal,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _narrative(
          'Below: the first column shrinks to the widest label, the second '
          'is intrinsic too, and the third gets whatever is left. The '
          'IntrinsicColumnWidth has an optional flex parameter for ties.',
          _kTeal,
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kSurfaceAlt,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kBorderSoft),
          ),
          child: Table(
            border: TableBorder.all(color: _kBorderSoft, width: 1),
            columnWidths: const <int, TableColumnWidth>{
              0: IntrinsicColumnWidth(),
              1: IntrinsicColumnWidth(),
              2: FlexColumnWidth(),
            },
            children: <TableRow>[
              TableRow(
                decoration: const BoxDecoration(color: _kTealSoft),
                children: <Widget>[
                  _cellText('Key',
                      weight: FontWeight.w800, color: _kTeal),
                  _cellText('Type',
                      weight: FontWeight.w800, color: _kTeal),
                  _cellText('Description',
                      weight: FontWeight.w800, color: _kTeal),
                ],
              ),
              TableRow(
                children: <Widget>[
                  _cellText('id'),
                  _cellText('int'),
                  _cellText('Primary key'),
                ],
              ),
              TableRow(
                children: <Widget>[
                  _cellText('name'),
                  _cellText('String'),
                  _cellText('Display name'),
                ],
              ),
              TableRow(
                children: <Widget>[
                  _cellText('createdAt'),
                  _cellText('DateTime'),
                  _cellText('Creation timestamp, UTC'),
                ],
              ),
              TableRow(
                children: <Widget>[
                  _cellText('isPublished'),
                  _cellText('bool'),
                  _cellText('Visibility flag'),
                ],
              ),
              TableRow(
                children: <Widget>[
                  _cellText('tags'),
                  _cellText('List<String>'),
                  _cellText('Searchable category tags'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _miniLabel('IntrinsicColumnWidth — sized to widest content', _kTeal),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 05 — FractionColumnWidth
// ===========================================================================
Widget _section05FractionColumnWidth() {
  return _sectionShell(
    title: '05 — FractionColumnWidth',
    subtitle:
        'FractionColumnWidth assigns a fraction of the parent constraint. '
        'Mix three FractionColumnWidth(0.33) values, or build asymmetric '
        'layouts such as 0.25 / 0.5 / 0.25.',
    surface: _kSurface,
    border: _kBorder,
    titleColor: _kAmber,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _narrative(
          'The first table uses 0.25 / 0.5 / 0.25 — quarters and a half. '
          'The second uses three equal thirds (0.33 / 0.34 / 0.33).',
          _kAmber,
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kSurfaceAlt,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kBorderSoft),
          ),
          child: Table(
            border: TableBorder.all(color: _kBorderSoft, width: 1),
            columnWidths: const <int, TableColumnWidth>{
              0: FractionColumnWidth(0.25),
              1: FractionColumnWidth(0.5),
              2: FractionColumnWidth(0.25),
            },
            children: <TableRow>[
              TableRow(
                decoration: const BoxDecoration(color: _kAmberSoft),
                children: <Widget>[
                  _cellText('25%',
                      weight: FontWeight.w800,
                      color: _kAmber,
                      align: TextAlign.center),
                  _cellText('50%',
                      weight: FontWeight.w800,
                      color: _kAmber,
                      align: TextAlign.center),
                  _cellText('25%',
                      weight: FontWeight.w800,
                      color: _kAmber,
                      align: TextAlign.center),
                ],
              ),
              TableRow(
                children: <Widget>[
                  _cellText('Left',
                      align: TextAlign.center, color: _kInkSoft),
                  _cellText('Centre — twice as wide',
                      align: TextAlign.center, color: _kInkSoft),
                  _cellText('Right',
                      align: TextAlign.center, color: _kInkSoft),
                ],
              ),
              TableRow(
                children: <Widget>[
                  _cellText('SKU', align: TextAlign.center),
                  _cellText('Description', align: TextAlign.center),
                  _cellText('Price', align: TextAlign.center),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kSurfaceAlt,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kBorderSoft),
          ),
          child: Table(
            border: TableBorder.all(color: _kBorderSoft, width: 1),
            columnWidths: const <int, TableColumnWidth>{
              0: FractionColumnWidth(0.33),
              1: FractionColumnWidth(0.34),
              2: FractionColumnWidth(0.33),
            },
            children: <TableRow>[
              TableRow(
                decoration: const BoxDecoration(color: _kAmberSoft),
                children: <Widget>[
                  _cellText('33%',
                      weight: FontWeight.w800,
                      color: _kAmber,
                      align: TextAlign.center),
                  _cellText('34%',
                      weight: FontWeight.w800,
                      color: _kAmber,
                      align: TextAlign.center),
                  _cellText('33%',
                      weight: FontWeight.w800,
                      color: _kAmber,
                      align: TextAlign.center),
                ],
              ),
              TableRow(
                children: <Widget>[
                  _cellText('Alpha', align: TextAlign.center),
                  _cellText('Beta', align: TextAlign.center),
                  _cellText('Gamma', align: TextAlign.center),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 06 — MinColumnWidth and MaxColumnWidth
// ===========================================================================
Widget _section06MinMaxColumnWidth() {
  return _sectionShell(
    title: '06 — MinColumnWidth & MaxColumnWidth',
    subtitle:
        'These two combinators wrap another TableColumnWidth and clamp it. '
        'MinColumnWidth picks the larger of two widths, MaxColumnWidth picks '
        'the smaller — they are the floor and ceiling of column sizing.',
    surface: _kSurface,
    border: _kBorder,
    titleColor: _kRose,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _narrative(
          'Below: column 0 uses MinColumnWidth(IntrinsicColumnWidth(), '
          'FixedColumnWidth(120)) — i.e. at least 120px even if the content '
          'is shorter. Column 1 uses MaxColumnWidth(IntrinsicColumnWidth(), '
          'FixedColumnWidth(160)) — never more than 160px even with long '
          'content.',
          _kRose,
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kSurfaceAlt,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kBorderSoft),
          ),
          child: Table(
            border: TableBorder.all(color: _kBorderSoft, width: 1),
            columnWidths: const <int, TableColumnWidth>{
              0: MinColumnWidth(
                IntrinsicColumnWidth(),
                FixedColumnWidth(120),
              ),
              1: MaxColumnWidth(
                IntrinsicColumnWidth(),
                FixedColumnWidth(160),
              ),
              2: FlexColumnWidth(),
            },
            children: <TableRow>[
              TableRow(
                decoration: const BoxDecoration(color: _kRoseSoft),
                children: <Widget>[
                  _cellText('Min ≥ 120',
                      weight: FontWeight.w800, color: _kRose),
                  _cellText('Max ≤ 160',
                      weight: FontWeight.w800, color: _kRose),
                  _cellText('Flex',
                      weight: FontWeight.w800, color: _kRose),
                ],
              ),
              TableRow(
                children: <Widget>[
                  _cellText('id'),
                  _cellText('short'),
                  _cellText('Both columns hit their floors / ceilings'),
                ],
              ),
              TableRow(
                children: <Widget>[
                  _cellText('a-very-long-identifier-1234'),
                  _cellText(
                    'a really long label that wants to be wider than 160',
                  ),
                  _cellText('Content overflows are wrapped by Padding+Text'),
                ],
              ),
              TableRow(
                children: <Widget>[
                  _cellText('mid'),
                  _cellText('medium label'),
                  _cellText('Mid-sized values stay within bounds'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          children: <Widget>[
            _calloutChip(
              icon: Icons.vertical_align_bottom,
              text: 'MinColumnWidth = floor',
              color: _kRose,
            ),
            _calloutChip(
              icon: Icons.vertical_align_top,
              text: 'MaxColumnWidth = ceiling',
              color: _kIndigo,
            ),
          ],
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 07 — TableBorder variants
// ===========================================================================
Widget _section07TableBorderVariants() {
  return _sectionShell(
    title: '07 — TableBorder variants',
    subtitle:
        'TableBorder.all draws every line; TableBorder.symmetric splits '
        'inside/outside; the default constructor lets you target each side '
        'and the horizontal/vertical inner lines separately.',
    surface: _kSurface,
    border: _kBorder,
    titleColor: _kAccentDeep,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _narrative(
          'Three tables below, in order: TableBorder.all, '
          'TableBorder.symmetric(inside, outside), and the default '
          'constructor used to draw only the bottom edge and inner '
          'horizontal separators.',
          _kAccentDeep,
        ),
        _miniLabel('TableBorder.all', _kAccentDeep),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kSurfaceAlt,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kBorderSoft),
          ),
          child: Table(
            border: TableBorder.all(
              color: _kAccentDeep,
              width: 1.2,
              borderRadius: BorderRadius.circular(8),
            ),
            children: <TableRow>[
              TableRow(
                children: <Widget>[
                  _cellText('A',
                      align: TextAlign.center, weight: FontWeight.w700),
                  _cellText('B',
                      align: TextAlign.center, weight: FontWeight.w700),
                  _cellText('C',
                      align: TextAlign.center, weight: FontWeight.w700),
                ],
              ),
              TableRow(
                children: <Widget>[
                  _cellText('one', align: TextAlign.center),
                  _cellText('two', align: TextAlign.center),
                  _cellText('three', align: TextAlign.center),
                ],
              ),
              TableRow(
                children: <Widget>[
                  _cellText('four', align: TextAlign.center),
                  _cellText('five', align: TextAlign.center),
                  _cellText('six', align: TextAlign.center),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        _miniLabel('TableBorder.symmetric', _kAccentDeep),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kSurfaceAlt,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kBorderSoft),
          ),
          child: Table(
            border: TableBorder.symmetric(
              inside: const BorderSide(
                color: _kAccent,
                width: 0.8,
                style: BorderStyle.solid,
              ),
              outside: const BorderSide(
                color: _kAccentDeep,
                width: 2.0,
              ),
            ),
            children: <TableRow>[
              TableRow(
                children: <Widget>[
                  _cellText('North',
                      weight: FontWeight.w700, align: TextAlign.center),
                  _cellText('South',
                      weight: FontWeight.w700, align: TextAlign.center),
                  _cellText('East',
                      weight: FontWeight.w700, align: TextAlign.center),
                  _cellText('West',
                      weight: FontWeight.w700, align: TextAlign.center),
                ],
              ),
              TableRow(
                children: <Widget>[
                  _cellText('A1', align: TextAlign.center),
                  _cellText('A2', align: TextAlign.center),
                  _cellText('A3', align: TextAlign.center),
                  _cellText('A4', align: TextAlign.center),
                ],
              ),
              TableRow(
                children: <Widget>[
                  _cellText('B1', align: TextAlign.center),
                  _cellText('B2', align: TextAlign.center),
                  _cellText('B3', align: TextAlign.center),
                  _cellText('B4', align: TextAlign.center),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        _miniLabel(
          'TableBorder(bottom + horizontalInside) — invoice style',
          _kAccentDeep,
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kSurfaceAlt,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kBorderSoft),
          ),
          child: Table(
            border: const TableBorder(
              top: BorderSide.none,
              left: BorderSide.none,
              right: BorderSide.none,
              bottom: BorderSide(color: _kAccentDeep, width: 1.8),
              horizontalInside: BorderSide(color: _kBorder, width: 0.8),
              verticalInside: BorderSide.none,
            ),
            children: <TableRow>[
              TableRow(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8, vertical: 10),
                    child: Text(
                      'Item',
                      style: TextStyle(
                        color: _kAccentDeep,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8, vertical: 10),
                    child: Text(
                      'Qty',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: _kAccentDeep,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8, vertical: 10),
                    child: Text(
                      'Total',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: _kAccentDeep,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8, vertical: 10),
                    child: Text('Service fee', style: TextStyle(color: _kInk)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8, vertical: 10),
                    child: Text('1',
                        textAlign: TextAlign.right,
                        style: TextStyle(color: _kInk)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8, vertical: 10),
                    child: Text(r'$49.00',
                        textAlign: TextAlign.right,
                        style: TextStyle(color: _kInk)),
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8, vertical: 10),
                    child: Text('Setup', style: TextStyle(color: _kInk)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8, vertical: 10),
                    child: Text('2',
                        textAlign: TextAlign.right,
                        style: TextStyle(color: _kInk)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8, vertical: 10),
                    child: Text(r'$80.00',
                        textAlign: TextAlign.right,
                        style: TextStyle(color: _kInk)),
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8, vertical: 10),
                    child: Text('Monthly plan',
                        style: TextStyle(color: _kInk)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8, vertical: 10),
                    child: Text('3',
                        textAlign: TextAlign.right,
                        style: TextStyle(color: _kInk)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8, vertical: 10),
                    child: Text(r'$117.00',
                        textAlign: TextAlign.right,
                        style: TextStyle(color: _kInk)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 08 — Vertical alignments
// ===========================================================================
Widget _section08VerticalAlignments() {
  return _sectionShell(
    title: '08 — TableCellVerticalAlignment',
    subtitle:
        'Each TableCell can declare its vertical alignment. The cell is '
        'positioned relative to the tallest sibling in the row. Choose top, '
        'middle, bottom, baseline (text), intrinsicHeight or fill.',
    surface: _kSurface,
    border: _kBorder,
    titleColor: _kSlate,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _narrative(
          'Row 1 mixes top/middle/bottom — the tall cell on the right '
          'forces the others to anchor differently. Row 2 uses fill: each '
          'cell stretches to the row height. Row 3 demonstrates '
          'intrinsicHeight where the cell sizes itself.',
          _kSlate,
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kSurfaceAlt,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kBorderSoft),
          ),
          child: Table(
            border: TableBorder.all(color: _kBorderSoft, width: 1),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
              3: FlexColumnWidth(1.4),
            },
            children: <TableRow>[
              TableRow(
                decoration: const BoxDecoration(color: _kSlateSoft),
                children: <Widget>[
                  _cellText('top',
                      align: TextAlign.center,
                      weight: FontWeight.w800,
                      color: _kSlate),
                  _cellText('middle',
                      align: TextAlign.center,
                      weight: FontWeight.w800,
                      color: _kSlate),
                  _cellText('bottom',
                      align: TextAlign.center,
                      weight: FontWeight.w800,
                      color: _kSlate),
                  _cellText('Tall reference',
                      align: TextAlign.center,
                      weight: FontWeight.w800,
                      color: _kSlate),
                ],
              ),
              const TableRow(
                children: <Widget>[
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.top,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('TOP',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: _kSlate, fontWeight: FontWeight.w700)),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('MIDDLE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: _kSlate, fontWeight: FontWeight.w700)),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.bottom,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('BOTTOM',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: _kSlate, fontWeight: FontWeight.w700)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: SizedBox(
                      height: 100,
                      child: Center(
                        child: Text(
                          'Reference\n100px tall',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: _kInk, height: 1.4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.fill,
                    child: Container(
                      color: _kAccentSoft,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        'FILL',
                        style: TextStyle(
                          color: _kAccent,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.fill,
                    child: Container(
                      color: _kIndigoSoft,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        'FILL',
                        style: TextStyle(
                          color: _kIndigo,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.fill,
                    child: Container(
                      color: _kPlumSoft,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        'FILL',
                        style: TextStyle(
                          color: _kPlum,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: SizedBox(
                      height: 80,
                      child: Center(
                        child: Text(
                          'Reference\n80px tall',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: _kInk, height: 1.4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const TableRow(
                children: <Widget>[
                  TableCell(
                    verticalAlignment:
                        TableCellVerticalAlignment.intrinsicHeight,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'intrinsicHeight',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: _kSlate, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment:
                        TableCellVerticalAlignment.intrinsicHeight,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'sizes itself',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: _kInkSoft),
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment:
                        TableCellVerticalAlignment.intrinsicHeight,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'on its own',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: _kInkSoft),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Short row',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: _kInk),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 09 — textBaseline and defaultVerticalAlignment
// ===========================================================================
Widget _section09TextBaselineAndDefault() {
  return _sectionShell(
    title: '09 — textBaseline & defaultVerticalAlignment',
    subtitle:
        'When at least one TableCell uses baseline alignment the Table '
        'requires a textBaseline parameter (alphabetic or ideographic). The '
        'defaultVerticalAlignment is applied to every cell that does not set '
        'its own.',
    surface: _kSurface,
    border: _kBorder,
    titleColor: _kTeal,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _narrative(
          'Below the default is set to middle. The right-most column uses '
          'baseline alignment — note how the differently sized text glyphs '
          'sit on the same invisible baseline.',
          _kTeal,
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kSurfaceAlt,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kBorderSoft),
          ),
          child: Table(
            border: TableBorder.all(color: _kBorderSoft, width: 1),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            textBaseline: TextBaseline.alphabetic,
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(1.5),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
            },
            children: <TableRow>[
              TableRow(
                decoration: const BoxDecoration(color: _kTealSoft),
                children: <Widget>[
                  _cellText('Section',
                      weight: FontWeight.w800, color: _kTeal),
                  _cellText('Default (middle)',
                      weight: FontWeight.w800, color: _kTeal),
                  _cellText('Baseline aligned',
                      weight: FontWeight.w800, color: _kTeal),
                ],
              ),
              const TableRow(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('Headline',
                        style: TextStyle(
                          color: _kInk,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'middle-aligned body text',
                      style: TextStyle(color: _kInkSoft, fontSize: 13),
                    ),
                  ),
                  TableCell(
                    verticalAlignment:
                        TableCellVerticalAlignment.baseline,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        '14pt baseline',
                        style: TextStyle(color: _kInk, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
              const TableRow(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('Subhead',
                        style: TextStyle(
                          color: _kInk,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'middle-aligned again',
                      style: TextStyle(color: _kInkSoft, fontSize: 13),
                    ),
                  ),
                  TableCell(
                    verticalAlignment:
                        TableCellVerticalAlignment.baseline,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        '12pt baseline',
                        style: TextStyle(color: _kInk, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const TableRow(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('Body',
                        style: TextStyle(
                          color: _kInk,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'centered vertically',
                      style: TextStyle(color: _kInkSoft, fontSize: 13),
                    ),
                  ),
                  TableCell(
                    verticalAlignment:
                        TableCellVerticalAlignment.baseline,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        '18pt baseline',
                        style: TextStyle(color: _kInk, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: <Widget>[
            _miniLabel('defaultVerticalAlignment: middle', _kTeal),
            const SizedBox(width: 8),
            _miniLabel('textBaseline: alphabetic', _kPlum),
          ],
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 10 — Header & striped rows
// ===========================================================================
Widget _section10HeaderAndStripedRows() {
  return _sectionShell(
    title: '10 — Header row & zebra striping',
    subtitle:
        'A common Table pattern: a coloured header row plus alternating row '
        'backgrounds for readability. TableRow.decoration accepts a full '
        'BoxDecoration so you can tint, gradient, or border each row.',
    surface: _kSurface,
    border: _kBorder,
    titleColor: _kAccent,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _narrative(
          'The header row uses an accent BoxDecoration with white text. Data '
          'rows alternate between cream and white via _stripedCell.',
          _kAccent,
        ),
        Container(
          decoration: BoxDecoration(
            color: _kSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kBorderSoft),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Table(
              columnWidths: const <int, TableColumnWidth>{
                0: FixedColumnWidth(56),
                1: FlexColumnWidth(),
                2: FlexColumnWidth(),
                3: FixedColumnWidth(110),
              },
              children: <TableRow>[
                TableRow(
                  decoration: const BoxDecoration(color: _kAccent),
                  children: <Widget>[
                    _headerCell('#', align: TextAlign.center),
                    _headerCell('USER'),
                    _headerCell('EMAIL'),
                    _headerCell('ROLE', align: TextAlign.center),
                  ],
                ),
                ..._stripedDataRows(<List<String>>[
                  <String>['01', 'Ada Lovelace', 'ada@analyt.eng', 'Owner'],
                  <String>['02', 'Alan Turing', 'alan@bletch.mil', 'Admin'],
                  <String>['03', 'Grace Hopper', 'grace@unicode.io', 'Editor'],
                  <String>['04', 'Donald Knuth', 'don@art.cs', 'Editor'],
                  <String>['05', 'Edsger Dijkstra', 'edw@struct.nl', 'Viewer'],
                  <String>['06', 'Niklaus Wirth', 'nik@pascal.ch', 'Viewer'],
                  <String>['07', 'Linus Torvalds', 'linus@kernel.fi', 'Admin'],
                ]),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          children: <Widget>[
            _calloutChip(
              icon: Icons.view_headline,
              text: 'Styled header row',
              color: _kAccent,
            ),
            _calloutChip(
              icon: Icons.format_color_fill,
              text: 'Zebra striping',
              color: _kIndigo,
            ),
            _calloutChip(
              icon: Icons.layers,
              text: 'ClipRRect rounded',
              color: _kPlum,
            ),
          ],
        ),
      ],
    ),
  );
}

List<TableRow> _stripedDataRows(List<List<String>> rows) {
  return List<TableRow>.generate(rows.length, (int i) {
    final List<String> row = rows[i];
    final bool odd = (i % 2) == 1;
    return TableRow(
      children: <Widget>[
        _stripedCell(row[0],
            odd: odd, align: TextAlign.center, color: _kInkMuted),
        _stripedCell(row[1], odd: odd, weight: FontWeight.w700),
        _stripedCell(row[2], odd: odd, color: _kInkSoft),
        _stripedCell(row[3],
            odd: odd,
            align: TextAlign.center,
            weight: FontWeight.w700,
            color: _kAccent),
      ],
    );
  });
}

// ===========================================================================
// SECTION 11 — Pricing matrix
// ===========================================================================
Widget _section11PricingMatrix() {
  return _sectionShell(
    title: '11 — Pricing matrix',
    subtitle:
        'A three-tier pricing card built entirely with Table. The first row '
        'holds plan names, the second the prices, then a list of features '
        'with check / dash markers.',
    surface: _kSurface,
    border: _kBorder,
    titleColor: _kPlum,
    child: Container(
      decoration: BoxDecoration(
        color: _kSurfaceAlt,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kBorderSoft),
      ),
      padding: const EdgeInsets.all(14),
      child: Table(
        border: TableBorder(
          horizontalInside: BorderSide(
            color: _kBorder.withValues(alpha: 0.6),
            width: 0.8,
          ),
          verticalInside: BorderSide(
            color: _kBorder.withValues(alpha: 0.6),
            width: 0.8,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(1.4),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
          3: FlexColumnWidth(),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          TableRow(
            decoration: const BoxDecoration(color: _kPlumSoft),
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(14),
                child: Text(
                  'PLAN',
                  style: TextStyle(
                    color: _kPlum,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    fontSize: 11.5,
                  ),
                ),
              ),
              _planHeader('Starter', _kIndigo),
              _planHeader('Pro', _kAccent, recommended: true),
              _planHeader('Enterprise', _kPlum),
            ],
          ),
          TableRow(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(14),
                child: Text(
                  'Monthly price',
                  style: TextStyle(
                    color: _kInk,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              _planPrice(r'$9', _kIndigo),
              _planPrice(r'$29', _kAccent),
              _planPrice(r'$99', _kPlum),
            ],
          ),
          _pricingFeatureRow('Users included', '3', '25', 'Unlimited'),
          _pricingFeatureRow('Storage', '5 GB', '100 GB', '2 TB'),
          _pricingFeatureRow(
              'Custom domain', _featureNo, _featureYes, _featureYes),
          _pricingFeatureRow('Email support', _featureYes,
              _featureYesPlus('priority'), _featureYesPlus('24/7')),
          _pricingFeatureRow('SLA',
              _featureNo, _featureNo, _featureYesPlus('99.99%')),
          _pricingFeatureRow(
              'Audit log', _featureNo, _featureYes, _featureYes),
          _pricingFeatureRow('SAML SSO', _featureNo, _featureNo, _featureYes),
          _pricingFeatureRow(
              'API requests / day', '10k', '500k', '10M+'),
          TableRow(
            decoration: BoxDecoration(
              color: _kPlumSoft.withValues(alpha: 0.4),
            ),
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(14),
                child: Text(
                  '',
                  style: TextStyle(color: _kInk),
                ),
              ),
              _planCta('Try', _kIndigo),
              _planCta('Choose', _kAccent),
              _planCta('Contact', _kPlum),
            ],
          ),
        ],
      ),
    ),
  );
}

const String _featureYes = '__yes__';
const String _featureNo = '__no__';
String _featureYesPlus(String label) => '__yes__:$label';

Widget _planHeader(String name, Color color, {bool recommended = false}) {
  return Padding(
    padding: const EdgeInsets.all(14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: 0.5,
          ),
        ),
        if (recommended) ...<Widget>[
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'RECOMMENDED',
              style: TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ],
      ],
    ),
  );
}

Widget _planPrice(String value, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ),
        const Text(
          '/ month',
          style: TextStyle(
            color: _kInkMuted,
            fontSize: 11,
          ),
        ),
      ],
    ),
  );
}

Widget _planCta(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.all(12),
    child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.30),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.4,
        ),
      ),
    ),
  );
}

TableRow _pricingFeatureRow(
  String label,
  String starter,
  String pro,
  String enterprise,
) {
  return TableRow(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Text(
          label,
          style: const TextStyle(
            color: _kInk,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
      _featureCell(starter, _kIndigo),
      _featureCell(pro, _kAccent),
      _featureCell(enterprise, _kPlum),
    ],
  );
}

Widget _featureCell(String value, Color color) {
  if (value == _featureNo) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Icon(Icons.remove, color: _kInkMuted, size: 18),
    );
  }
  if (value == _featureYes) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Icon(Icons.check_circle, color: color, size: 20),
    );
  }
  if (value.startsWith('__yes__:')) {
    final String label = value.substring('__yes__:'.length);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.check_circle, color: color, size: 18),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    child: Text(
      value,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w700,
        fontSize: 13,
      ),
    ),
  );
}

// ===========================================================================
// SECTION 12 — Feature comparison
// ===========================================================================
Widget _section12FeatureComparison() {
  return _sectionShell(
    title: '12 — Feature comparison',
    subtitle:
        'A side-by-side comparison between two products. Demonstrates '
        'horizontal headers, leading icons inside cells and contextual color '
        'cues for "better" and "worse" cells.',
    surface: _kSurface,
    border: _kBorder,
    titleColor: _kIndigo,
    child: Container(
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBorderSoft),
      ),
      padding: const EdgeInsets.all(12),
      child: Table(
        border: TableBorder.all(color: _kBorderSoft, width: 0.8),
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(1.4),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          TableRow(
            decoration: const BoxDecoration(color: _kIndigoSoft),
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'CRITERION',
                  style: TextStyle(
                    color: _kIndigo,
                    fontWeight: FontWeight.w900,
                    fontSize: 11.5,
                    letterSpacing: 1,
                  ),
                ),
              ),
              _comparisonHeader('Aurora 9', Icons.rocket_launch, _kAccent),
              _comparisonHeader('Borealis 4', Icons.flight, _kPlum),
            ],
          ),
          _comparisonRow('Cold start',
              winner: 1, a: '420 ms', b: '180 ms'),
          _comparisonRow('Memory footprint',
              winner: 1, a: '88 MB', b: '54 MB'),
          _comparisonRow('Throughput (req/s)',
              winner: 1, a: '12 k', b: '18 k'),
          _comparisonRow('Build time',
              winner: 0, a: '24 s', b: '38 s'),
          _comparisonRow('Plugins available',
              winner: 0, a: '142', b: '67'),
          _comparisonRow('Hot reload',
              winner: 1, a: '0.8 s', b: '0.3 s'),
          _comparisonRow('Documentation pages',
              winner: 0, a: '912', b: '480'),
          _comparisonRow('Community size',
              winner: 0, a: '54 k devs', b: '12 k devs'),
          _comparisonRow('Monthly price',
              winner: 1, a: r'$29', b: r'$19'),
        ],
      ),
    ),
  );
}

Widget _comparisonHeader(String name, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.all(12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 8),
        Text(
          name,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w900,
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}

TableRow _comparisonRow(
  String criterion, {
  required int winner,
  required String a,
  required String b,
}) {
  return TableRow(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          criterion,
          style: const TextStyle(
            color: _kInk,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      _comparisonValue(a, isWinner: winner == 0, color: _kAccent),
      _comparisonValue(b, isWinner: winner == 1, color: _kPlum),
    ],
  );
}

Widget _comparisonValue(String value,
    {required bool isWinner, required Color color}) {
  return Padding(
    padding: const EdgeInsets.all(12),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isWinner ? color.withValues(alpha: 0.12) : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (isWinner) ...<Widget>[
            Icon(Icons.emoji_events, color: color, size: 15),
            const SizedBox(width: 6),
          ],
          Text(
            value,
            style: TextStyle(
              color: isWinner ? color : _kInkSoft,
              fontWeight: isWinner ? FontWeight.w800 : FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}

// ===========================================================================
// SECTION 13 — Schedule grid
// ===========================================================================
Widget _section13ScheduleGrid() {
  return _sectionShell(
    title: '13 — Schedule grid',
    subtitle:
        'A weekly schedule using Table — first column for time slots, then '
        'one column per day. Booked slots get a colored TableCell with the '
        'meeting title.',
    surface: _kSurface,
    border: _kBorder,
    titleColor: _kTeal,
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSurfaceAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBorderSoft),
      ),
      child: Table(
        border: TableBorder.all(
          color: _kBorder.withValues(alpha: 0.7),
          width: 0.8,
        ),
        columnWidths: const <int, TableColumnWidth>{
          0: FixedColumnWidth(60),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          TableRow(
            decoration: const BoxDecoration(color: _kTeal),
            children: <Widget>[
              _scheduleHeader(''),
              _scheduleHeader('MON'),
              _scheduleHeader('TUE'),
              _scheduleHeader('WED'),
              _scheduleHeader('THU'),
              _scheduleHeader('FRI'),
            ],
          ),
          _scheduleRow('08:00', <_Slot?>[
            _Slot('Standup', _kAccent),
            null,
            _Slot('Standup', _kAccent),
            null,
            _Slot('Standup', _kAccent),
          ]),
          _scheduleRow('09:00', <_Slot?>[
            _Slot('Deep work', _kIndigo),
            _Slot('Deep work', _kIndigo),
            _Slot('Deep work', _kIndigo),
            _Slot('Deep work', _kIndigo),
            _Slot('Deep work', _kIndigo),
          ]),
          _scheduleRow('10:00', <_Slot?>[
            null,
            _Slot('Design', _kPlum),
            null,
            _Slot('Design', _kPlum),
            null,
          ]),
          _scheduleRow('11:00', <_Slot?>[
            _Slot('Pair-prog', _kAmber),
            null,
            _Slot('Pair-prog', _kAmber),
            null,
            _Slot('Demo', _kRose),
          ]),
          _scheduleRow('12:00', <_Slot?>[
            null,
            null,
            null,
            null,
            null,
          ]),
          _scheduleRow('13:00', <_Slot?>[
            _Slot('1:1 Lead', _kSlate),
            _Slot('Workshop', _kTeal),
            null,
            _Slot('1:1 PM', _kSlate),
            null,
          ]),
          _scheduleRow('14:00', <_Slot?>[
            _Slot('Review', _kAccent),
            _Slot('Workshop', _kTeal),
            _Slot('Review', _kAccent),
            null,
            _Slot('Retro', _kRose),
          ]),
          _scheduleRow('15:00', <_Slot?>[
            null,
            null,
            _Slot('Architecture', _kIndigo),
            _Slot('Architecture', _kIndigo),
            null,
          ]),
          _scheduleRow('16:00', <_Slot?>[
            _Slot('Office hrs', _kPlum),
            null,
            _Slot('Office hrs', _kPlum),
            null,
            _Slot('Office hrs', _kPlum),
          ]),
        ],
      ),
    ),
  );
}

class _Slot {
  const _Slot(this.title, this.color);
  final String title;
  final Color color;
}

Widget _scheduleHeader(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 11.5,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.2,
      ),
    ),
  );
}

TableRow _scheduleRow(String time, List<_Slot?> slots) {
  return TableRow(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          time,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: _kInkSoft,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
      ),
      ...List<Widget>.generate(slots.length, (int i) {
        final _Slot? s = slots[i];
        if (s == null) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 4),
            child: SizedBox(height: 28),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(6),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            decoration: BoxDecoration(
              color: s.color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(6),
              border: Border(
                left: BorderSide(color: s.color, width: 3),
              ),
            ),
            child: Text(
              s.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: s.color,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      }),
    ],
  );
}

// ===========================================================================
// SECTION 14 — Financial summary
// ===========================================================================
Widget _section14FinancialSummary() {
  return _sectionShell(
    title: '14 — Financial summary',
    subtitle:
        'A quarterly financial summary built with Table — right-aligned '
        'numeric columns, accent colors for positive deltas and a heavy '
        'bottom row for totals.',
    surface: _kSurface,
    border: _kBorder,
    titleColor: _kAccentDeep,
    child: Container(
      decoration: BoxDecoration(
        color: _kSurfaceAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBorderSoft),
      ),
      padding: const EdgeInsets.all(12),
      child: Table(
        border: TableBorder.symmetric(
          inside: BorderSide(
            color: _kBorder.withValues(alpha: 0.6),
            width: 0.8,
          ),
          outside: const BorderSide(color: _kAccentDeep, width: 1.4),
        ),
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
          3: FlexColumnWidth(),
          4: FlexColumnWidth(),
          5: FlexColumnWidth(1.2),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          TableRow(
            decoration: const BoxDecoration(color: _kAccentDeep),
            children: <Widget>[
              _finHeader('Account'),
              _finHeader('Q1', align: TextAlign.right),
              _finHeader('Q2', align: TextAlign.right),
              _finHeader('Q3', align: TextAlign.right),
              _finHeader('Q4', align: TextAlign.right),
              _finHeader('YOY', align: TextAlign.right),
            ],
          ),
          _finRow('Revenue', <String>[
            r'$124,580',
            r'$140,205',
            r'$165,902',
            r'$192,318',
          ], '+34%', delta: 1),
          _finRow('Cost of services', <String>[
            r'$48,200',
            r'$55,640',
            r'$58,910',
            r'$66,402',
          ], '+27%', delta: -1),
          _finRow('Gross profit', <String>[
            r'$76,380',
            r'$84,565',
            r'$106,992',
            r'$125,916',
          ], '+39%', delta: 1, bold: true),
          _finRow('Marketing', <String>[
            r'$12,100',
            r'$15,820',
            r'$18,401',
            r'$22,330',
          ], '+45%', delta: -1),
          _finRow('R&D', <String>[
            r'$22,500',
            r'$23,800',
            r'$24,140',
            r'$25,005',
          ], '+10%', delta: -1),
          _finRow('Operating profit', <String>[
            r'$41,780',
            r'$44,945',
            r'$64,451',
            r'$78,581',
          ], '+58%', delta: 1, bold: true),
          _finRow('Taxes', <String>[
            r'$10,445',
            r'$11,236',
            r'$16,112',
            r'$19,645',
          ], '+58%', delta: -1),
          TableRow(
            decoration: BoxDecoration(
              color: _kAccentDeep.withValues(alpha: 0.10),
            ),
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(14),
                child: Text(
                  'Net profit',
                  style: TextStyle(
                    color: _kAccentDeep,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
              ),
              _finMoney(r'$31,335', strong: true),
              _finMoney(r'$33,709', strong: true),
              _finMoney(r'$48,339', strong: true),
              _finMoney(r'$58,936', strong: true),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  alignment: Alignment.centerRight,
                  child: const Text(
                    '+88%',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: _kSuccess,
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _finHeader(String text, {TextAlign align = TextAlign.left}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
    child: Text(
      text,
      textAlign: align,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 11.5,
        fontWeight: FontWeight.w900,
        letterSpacing: 1,
      ),
    ),
  );
}

TableRow _finRow(String label, List<String> values, String yoy,
    {required int delta, bool bold = false}) {
  return TableRow(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          label,
          style: TextStyle(
            color: _kInk,
            fontWeight: bold ? FontWeight.w900 : FontWeight.w600,
            fontSize: 13.5,
          ),
        ),
      ),
      ...List<Widget>.generate(values.length, (int i) {
        return _finMoney(values[i], strong: bold);
      }),
      Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          yoy,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: delta > 0 ? _kSuccess : _kDanger,
            fontWeight: FontWeight.w800,
            fontSize: 13,
          ),
        ),
      ),
    ],
  );
}

Widget _finMoney(String value, {bool strong = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
    child: Text(
      value,
      textAlign: TextAlign.right,
      style: TextStyle(
        color: _kInk,
        fontWeight: strong ? FontWeight.w900 : FontWeight.w500,
        fontFamily: 'monospace',
        fontSize: 13,
      ),
    ),
  );
}

// ===========================================================================
// SECTION 15 — Settings key/value
// ===========================================================================
Widget _section15SettingsKeyValue() {
  return _sectionShell(
    title: '15 — Settings key/value',
    subtitle:
        'Tables make an excellent layout for two-column settings panels — '
        'the IntrinsicColumnWidth strategy aligns labels neatly without '
        'manual sizing.',
    surface: _kSurface,
    border: _kBorder,
    titleColor: _kSlate,
    child: Container(
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorderSoft),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Table(
        columnWidths: const <int, TableColumnWidth>{
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          _settingsRow('Theme', 'Light · auto-switch at sundown', Icons.brightness_6, _kAccent),
          _settingsRow('Accent colour', 'Sage green', Icons.palette, _kPlum),
          _settingsRow('Font', 'System default', Icons.font_download, _kIndigo),
          _settingsRow('Time zone', 'Europe/Berlin (UTC+1)', Icons.public, _kTeal),
          _settingsRow('Language', 'English (United Kingdom)',
              Icons.translate, _kAmber),
          _settingsRow('Notifications', 'Email + push (work hours)',
              Icons.notifications_active, _kRose),
          _settingsRow('Two-factor auth', 'Enabled · TOTP',
              Icons.shield, _kSuccess),
          _settingsRow('Backup', 'Daily · last 02:14 today',
              Icons.cloud_done, _kAccent),
          _settingsRow('Storage', '14.6 GB of 100 GB used',
              Icons.sd_storage, _kIndigo),
          _settingsRow('Account tier', 'Pro · renews 31 March',
              Icons.workspace_premium, _kPlum),
          _settingsRow('Privacy', 'Strict · cross-site blocked',
              Icons.privacy_tip, _kAccentDeep),
          _settingsRow('Telemetry', 'Anonymous usage only',
              Icons.analytics, _kSlate),
        ],
      ),
    ),
  );
}

TableRow _settingsRow(
    String key, String value, IconData icon, Color color) {
  return TableRow(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                key,
                style: const TextStyle(
                  color: _kInk,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  color: _kInkSoft,
                  fontSize: 13,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: _kInkMuted,
              size: 18,
            ),
          ],
        ),
      ),
    ],
  );
}

// ===========================================================================
// SECTION 16 — Table in card with leading icons + inline actions
// ===========================================================================
Widget _section16TableInCardWithIconsAndActions() {
  return _sectionShell(
    title: '16 — Card · icons · inline actions',
    subtitle:
        'A polished, card-wrapped table: each row carries a leading icon, '
        'a descriptive value and an inline action cluster on the right. '
        'Combines several of the techniques shown above.',
    surface: _kSurface,
    border: _kBorder,
    titleColor: _kAccent,
    child: Container(
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kBorderSoft),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: _kAccentSoft,
                border: Border(
                  bottom: BorderSide(color: _kBorderSoft, width: 1),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _kAccent.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.workspaces,
                      color: _kAccentDeep,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Active integrations',
                          style: TextStyle(
                            color: _kAccentDeep,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Connections to external services',
                          style: TextStyle(
                            color: _kInkSoft,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: _kAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '8 ACTIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(54),
                  1: FlexColumnWidth(),
                  2: FixedColumnWidth(110),
                  3: FixedColumnWidth(140),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: <TableRow>[
                  _integrationRow(
                    icon: Icons.cloud,
                    color: _kAccent,
                    name: 'Cloud Storage',
                    detail: 's3.bucket / images',
                    status: 'Healthy',
                    statusColor: _kSuccess,
                  ),
                  _integrationRow(
                    icon: Icons.chat,
                    color: _kPlum,
                    name: 'Chat Bridge',
                    detail: 'webhook · 320 msg/h',
                    status: 'Healthy',
                    statusColor: _kSuccess,
                  ),
                  _integrationRow(
                    icon: Icons.email,
                    color: _kIndigo,
                    name: 'Mail Service',
                    detail: 'transactional · 4.1k/day',
                    status: 'Warning',
                    statusColor: _kWarn,
                  ),
                  _integrationRow(
                    icon: Icons.payment,
                    color: _kAccent,
                    name: 'Payment Provider',
                    detail: 'cards · sepa · 24 ccy',
                    status: 'Healthy',
                    statusColor: _kSuccess,
                  ),
                  _integrationRow(
                    icon: Icons.analytics,
                    color: _kTeal,
                    name: 'Analytics',
                    detail: 'events · funnels',
                    status: 'Healthy',
                    statusColor: _kSuccess,
                  ),
                  _integrationRow(
                    icon: Icons.bug_report,
                    color: _kRose,
                    name: 'Error Tracker',
                    detail: '12 unresolved issues',
                    status: 'Error',
                    statusColor: _kDanger,
                  ),
                  _integrationRow(
                    icon: Icons.calendar_month,
                    color: _kAmber,
                    name: 'Calendar Sync',
                    detail: 'two-way · 14 calendars',
                    status: 'Healthy',
                    statusColor: _kSuccess,
                  ),
                  _integrationRow(
                    icon: Icons.smart_toy,
                    color: _kSlate,
                    name: 'AI Assistant',
                    detail: 'on-device + cloud',
                    status: 'Healthy',
                    statusColor: _kSuccess,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: const BoxDecoration(
                color: _kSurfaceDeep,
                border: Border(
                  top: BorderSide(color: _kBorderSoft, width: 1),
                ),
              ),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.info_outline,
                    color: _kInkSoft,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Tip: Tables shine when you need column alignment '
                      'across rows — for purely linear lists prefer ListView.',
                      style: TextStyle(
                        color: _kInkSoft,
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _kAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'MANAGE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

TableRow _integrationRow({
  required IconData icon,
  required Color color,
  required String name,
  required String detail,
  required String status,
  required Color statusColor,
}) {
  return TableRow(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name,
              style: const TextStyle(
                color: _kInk,
                fontSize: 13.5,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              detail,
              style: const TextStyle(
                color: _kInkSoft,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: statusColor.withValues(alpha: 0.5)),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: statusColor,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _inlineAction(Icons.refresh, _kIndigo),
            _inlineAction(Icons.settings, _kSlate),
            _inlineAction(Icons.power_settings_new, _kDanger),
          ],
        ),
      ),
    ],
  );
}

Widget _inlineAction(IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 16),
    ),
  );
}

// ===========================================================================
// END OF FILE
// ===========================================================================
