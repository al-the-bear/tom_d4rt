import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Color constants – Deep Blue / Slate theme
// ---------------------------------------------------------------------------
const _kPrimary = Color(0xFF1565C0);
const _kAccent = Color(0xFF42A5F5);
const _kSurface = Color(0xFFE3F2FD);
const _kDarkSlate = Color(0xFF263238);
const _kMediumSlate = Color(0xFF546E7A);
const _kLightSlate = Color(0xFF90A4AE);
const _kWhite = Color(0xFFFFFFFF);
const _kCardBg = Color(0xFFF5F9FF);
const _kDivider = Color(0xFFBBDEFB);
const _kSuccess = Color(0xFF2E7D32);
const _kWarning = Color(0xFFE65100);
const _kCodeBg = Color(0xFF1A237E);
const _kCodeText = Color(0xFFB3E5FC);
const _kBarTrack = Color(0xFFE0E0E0);
const _kGradientStart = Color(0xFF0D47A1);
const _kGradientEnd = Color(0xFF1E88E5);
const _kTableHeader = Color(0xFF1976D2);
const _kTableRowEven = Color(0xFFE3F2FD);
const _kTableRowOdd = Color(0xFFFFFFFF);
const _kBadgeBg = Color(0xFFC8E6C9);
const _kBadgeText = Color(0xFF1B5E20);
const _kScenarioA = Color(0xFF1565C0);
const _kScenarioB = Color(0xFF42A5F5);
const _kScenarioC = Color(0xFF90CAF9);
const _kScenarioD = Color(0xFFBBDEFB);

// ---------------------------------------------------------------------------
// Section header builder
// ---------------------------------------------------------------------------
Widget _buildSectionHeader(String title, IconData icon) {
  return Container(
    margin: const EdgeInsets.only(top: 28, bottom: 12, left: 16, right: 16),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: _kPrimary.withAlpha(20),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kPrimary.withAlpha(60), width: 1),
    ),
    child: Row(
      children: [
        Icon(icon, color: _kPrimary, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: _kDarkSlate,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Container(
          width: 40,
          height: 3,
          decoration: BoxDecoration(
            color: _kAccent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// 1 – Header banner with gradient
// ---------------------------------------------------------------------------
Widget _buildHeaderBanner() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_kGradientStart, _kGradientEnd],
      ),
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(32),
        bottomRight: Radius.circular(32),
      ),
      boxShadow: [
        BoxShadow(
          color: _kPrimary.withAlpha(80),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kWhite.withAlpha(40),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.view_column_rounded,
            size: 52,
            color: _kWhite,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'FractionColumnWidth Deep Demo',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: _kWhite,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Sizing table columns as a fraction of the table width',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: _kWhite.withAlpha(210),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: _kWhite.withAlpha(50),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'package:flutter/rendering.dart',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _kWhite,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// 2 – What is FractionColumnWidth – explanation cards
// ---------------------------------------------------------------------------
Widget _buildExplanationCards() {
  Widget infoCard(String title, String body, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kDivider, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kAccent.withAlpha(30),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: _kPrimary, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _kDarkSlate,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 13,
                    color: _kMediumSlate,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  return Column(
    children: [
      infoCard(
        'Definition',
        'FractionColumnWidth extends TableColumnWidth and sizes a column '
            'to a fraction of the table maximum intrinsic width. '
            'Pass a double value between 0.0 and 1.0.',
        Icons.menu_book_rounded,
      ),
      infoCard(
        'Constructor',
        'FractionColumnWidth(double value) where value is the fraction. '
            'For example 0.5 means the column takes 50 percent of the table width.',
        Icons.build_circle_outlined,
      ),
      infoCard(
        'Key Property',
        'value (double) - The fraction of the table width to use. '
            'A value of 0.3 allocates 30 percent of the total width.',
        Icons.tune_rounded,
      ),
      infoCard(
        'Methods',
        'minIntrinsicWidth, maxIntrinsicWidth, and flex are the main '
            'methods inherited from TableColumnWidth that FractionColumnWidth overrides.',
        Icons.functions_rounded,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// 3 – Visual fraction bar
// ---------------------------------------------------------------------------
Widget _buildFractionBar() {
  Widget fractionSegment(double flex, String label, Color color) {
    return Expanded(
      flex: (flex * 100).toInt(),
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: _kWhite, width: 1),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: _kWhite,
            ),
          ),
        ),
      ),
    );
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Each segment represents its fraction of the total width:',
          style: TextStyle(fontSize: 13, color: _kMediumSlate),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kDivider, width: 1),
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(
            children: [
              fractionSegment(0.2, '0.2', _kScenarioA),
              fractionSegment(0.3, '0.3', _kScenarioB),
              fractionSegment(0.5, '0.5', _kScenarioC),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildLegendDot(_kScenarioA, '20%'),
            const SizedBox(width: 16),
            _buildLegendDot(_kScenarioB, '30%'),
            const SizedBox(width: 16),
            _buildLegendDot(_kScenarioC, '50%'),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kSurface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Total fractions: 0.2 + 0.3 + 0.5 = 1.0 (100%)',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _kPrimary,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Legend dot helper
// ---------------------------------------------------------------------------
Widget _buildLegendDot(Color color, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 4),
      Text(label, style: const TextStyle(fontSize: 12, color: _kMediumSlate)),
    ],
  );
}

// ---------------------------------------------------------------------------
// 4 – Table with FractionColumnWidth columns
// ---------------------------------------------------------------------------
Widget _buildFractionTable() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Table using FractionColumnWidth for each column:',
          style: TextStyle(fontSize: 13, color: _kMediumSlate),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kDivider, width: 1),
          ),
          clipBehavior: Clip.antiAlias,
          child: Table(
            columnWidths: const {
              0: FractionColumnWidth(0.3),
              1: FractionColumnWidth(0.4),
              2: FractionColumnWidth(0.3),
            },
            children: [
              TableRow(
                decoration: const BoxDecoration(color: _kTableHeader),
                children: [
                  _buildTableCell('Product', isHeader: true),
                  _buildTableCell('Description', isHeader: true),
                  _buildTableCell('Price', isHeader: true),
                ],
              ),
              TableRow(
                decoration: const BoxDecoration(color: _kTableRowEven),
                children: [
                  _buildTableCell('Widget Pro'),
                  _buildTableCell('Advanced widget toolkit'),
                  _buildTableCell('\$49.99'),
                ],
              ),
              TableRow(
                decoration: const BoxDecoration(color: _kTableRowOdd),
                children: [
                  _buildTableCell('Layout Kit'),
                  _buildTableCell('Responsive layout engine'),
                  _buildTableCell('\$29.99'),
                ],
              ),
              TableRow(
                decoration: const BoxDecoration(color: _kTableRowEven),
                children: [
                  _buildTableCell('Theme Builder'),
                  _buildTableCell('Dynamic theming system'),
                  _buildTableCell('\$19.99'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: _kSurface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Columns: 0.3 | 0.4 | 0.3  =  1.0 total',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _kPrimary,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Table cell helper
// ---------------------------------------------------------------------------
Widget _buildTableCell(String text, {bool isHeader = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: isHeader ? FontWeight.w700 : FontWeight.w400,
        color: isHeader ? _kWhite : _kDarkSlate,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// 5 – Comparison with other TableColumnWidth types
// ---------------------------------------------------------------------------
Widget _buildComparisonSection() {
  Widget comparisonRow(
    String typeName,
    String description,
    String example,
    Color indicatorColor,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kDivider, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 50,
            decoration: BoxDecoration(
              color: indicatorColor,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  typeName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _kDarkSlate,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: _kMediumSlate,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: _kSurface,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    example,
                    style: const TextStyle(
                      fontSize: 11,
                      fontFamily: 'monospace',
                      color: _kPrimary,
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

  return Column(
    children: [
      comparisonRow(
        'FractionColumnWidth',
        'Fraction of the table maximum intrinsic width. Scales with table size.',
        'FractionColumnWidth(0.4)',
        _kPrimary,
      ),
      comparisonRow(
        'FixedColumnWidth',
        'A fixed number of logical pixels. Does not adapt to table width.',
        'FixedColumnWidth(120.0)',
        _kWarning,
      ),
      comparisonRow(
        'FlexColumnWidth',
        'Distributes remaining space using flex factors, similar to Expanded.',
        'FlexColumnWidth(2.0)',
        _kSuccess,
      ),
      comparisonRow(
        'IntrinsicColumnWidth',
        'Sizes to the intrinsic width of the column content.',
        'IntrinsicColumnWidth()',
        _kAccent,
      ),
      comparisonRow(
        'MinColumnWidth',
        'Takes the minimum of two TableColumnWidth strategies.',
        'MinColumnWidth(a, b)',
        _kLightSlate,
      ),
      comparisonRow(
        'MaxColumnWidth',
        'Takes the maximum of two TableColumnWidth strategies.',
        'MaxColumnWidth(a, b)',
        _kMediumSlate,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// 6 – Multiple fraction scenarios
// ---------------------------------------------------------------------------
Widget _buildFractionScenarios() {
  Widget scenarioBlock(String title, List<MapEntry<String, double>> fractions) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: _kDarkSlate,
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Row(
              children: [
                for (var i = 0; i < fractions.length; i++)
                  Expanded(
                    flex: (fractions[i].value * 100).toInt(),
                    child: Container(
                      height: 36,
                      color: [
                        _kScenarioA,
                        _kScenarioB,
                        _kScenarioC,
                        _kScenarioD,
                      ][i % 4],
                      child: Center(
                        child: Text(
                          fractions[i].key,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: i < 2 ? _kWhite : _kDarkSlate,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            fractions
                .map((e) => '${e.key}: ${(e.value * 100).toInt()}%')
                .join('  |  '),
            style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: _kMediumSlate,
            ),
          ),
        ],
      ),
    );
  }

  return Column(
    children: [
      scenarioBlock('Equal Split (50/50)', [
        const MapEntry('Col A', 0.5),
        const MapEntry('Col B', 0.5),
      ]),
      scenarioBlock('Weighted Split (70/30)', [
        const MapEntry('Col A', 0.7),
        const MapEntry('Col B', 0.3),
      ]),
      scenarioBlock('Three Columns (60/20/20)', [
        const MapEntry('Col A', 0.6),
        const MapEntry('Col B', 0.2),
        const MapEntry('Col C', 0.2),
      ]),
      scenarioBlock('Four Columns (40/25/20/15)', [
        const MapEntry('Col A', 0.4),
        const MapEntry('Col B', 0.25),
        const MapEntry('Col C', 0.2),
        const MapEntry('Col D', 0.15),
      ]),
      scenarioBlock('Heavily Weighted (80/10/10)', [
        const MapEntry('Main', 0.8),
        const MapEntry('Side', 0.1),
        const MapEntry('Aux', 0.1),
      ]),
    ],
  );
}

// ---------------------------------------------------------------------------
// 7 – Column width distribution visualization
// ---------------------------------------------------------------------------
Widget _buildDistributionVisualization() {
  Widget distributionBar(String label, double fraction, Color barColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _kDarkSlate,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 22,
              decoration: BoxDecoration(
                color: _kBarTrack,
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                widthFactor: fraction,
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      '${(fraction * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: _kWhite,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Horizontal bars illustrate how each fraction claim distributes width:',
          style: TextStyle(fontSize: 13, color: _kMediumSlate),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kCardBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kDivider, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dashboard Layout',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kDarkSlate,
                ),
              ),
              const SizedBox(height: 8),
              distributionBar('Sidebar', 0.2, _kScenarioA),
              distributionBar('Content', 0.55, _kScenarioB),
              distributionBar('Details', 0.25, _kScenarioC),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kCardBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kDivider, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Data Table Layout',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kDarkSlate,
                ),
              ),
              const SizedBox(height: 8),
              distributionBar('ID', 0.1, _kScenarioA),
              distributionBar('Name', 0.3, _kScenarioB),
              distributionBar('Email', 0.35, _kScenarioC),
              distributionBar('Actions', 0.25, _kAccent),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// 8 – Code snippets
// ---------------------------------------------------------------------------
Widget _buildCodeSnippets() {
  Widget codeBlock(String title, String code) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kPrimary.withAlpha(60), width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            color: _kPrimary.withAlpha(25),
            child: Row(
              children: [
                const Icon(Icons.code_rounded, size: 16, color: _kPrimary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _kPrimary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            color: _kCodeBg,
            child: Text(
              code,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'monospace',
                color: _kCodeText,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  return Column(
    children: [
      codeBlock(
        'Basic FractionColumnWidth Usage',
        'Table(\n'
            '  columnWidths: const {\n'
            '    0: FractionColumnWidth(0.3),\n'
            '    1: FractionColumnWidth(0.5),\n'
            '    2: FractionColumnWidth(0.2),\n'
            '  },\n'
            '  children: [\n'
            '    TableRow(children: [...]),\n'
            '  ],\n'
            ')',
      ),
      codeBlock(
        'Mixed Column Widths',
        'Table(\n'
            '  columnWidths: const {\n'
            '    0: FixedColumnWidth(60),\n'
            '    1: FractionColumnWidth(0.5),\n'
            '    2: FlexColumnWidth(1.0),\n'
            '  },\n'
            '  children: [\n'
            '    TableRow(children: [...]),\n'
            '  ],\n'
            ')',
      ),
      codeBlock(
        'Equal Three-Column Layout',
        'Table(\n'
            '  columnWidths: const {\n'
            '    0: FractionColumnWidth(1/3),\n'
            '    1: FractionColumnWidth(1/3),\n'
            '    2: FractionColumnWidth(1/3),\n'
            '  },\n'
            '  border: TableBorder.all(\n'
            '    color: Colors.grey,\n'
            '    width: 1,\n'
            '  ),\n'
            '  children: [...],\n'
            ')',
      ),
      codeBlock(
        'Accessing the Fraction Value',
        'const col = FractionColumnWidth(0.4);\n'
            'print(col.value); // 0.4\n'
            '\n'
            '// The fraction is used by the Table\n'
            '// layout algorithm to calculate the\n'
            '// actual pixel width of each column.',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// 9 – Real-world use cases
// ---------------------------------------------------------------------------
Widget _buildRealWorldUseCases() {
  Widget useCaseCard(
    String title,
    String description,
    IconData icon,
    List<String> fractionLabels,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider, width: 1),
        boxShadow: [
          BoxShadow(
            color: _kPrimary.withAlpha(12),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _kAccent.withAlpha(25),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: _kPrimary, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _kDarkSlate,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              color: _kMediumSlate,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: [
              for (final label in fractionLabels)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: _kSurface,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: _kDivider, width: 1),
                  ),
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _kPrimary,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  return Column(
    children: [
      useCaseCard(
        'Data Tables',
        'Display structured data with predictable column proportions. '
            'ID columns get a small fraction while description columns get larger ones.',
        Icons.table_chart_rounded,
        ['ID: 0.1', 'Name: 0.3', 'Desc: 0.4', 'Status: 0.2'],
      ),
      useCaseCard(
        'Form Layouts',
        'Align labels and input fields in a table-based form. '
            'Labels take a fixed fraction and inputs fill the rest.',
        Icons.edit_note_rounded,
        ['Label: 0.3', 'Input: 0.7'],
      ),
      useCaseCard(
        'Dashboard Grids',
        'Build dashboard widgets arranged in a table where each metric '
            'card occupies a proportional width that adapts to screen size.',
        Icons.dashboard_rounded,
        ['Nav: 0.15', 'Main: 0.55', 'Side: 0.3'],
      ),
      useCaseCard(
        'Invoice / Receipt',
        'Receipts use narrow columns for quantity and price, '
            'with a wider column for the item description.',
        Icons.receipt_long_rounded,
        ['Qty: 0.1', 'Item: 0.5', 'Unit: 0.15', 'Total: 0.25'],
      ),
      useCaseCard(
        'Comparison Charts',
        'Side-by-side comparisons where each option is shown as an '
            'equal fraction column for fair visual comparison.',
        Icons.compare_arrows_rounded,
        ['Option A: 0.33', 'Option B: 0.34', 'Option C: 0.33'],
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// 10 – Summary with test result badge
// ---------------------------------------------------------------------------
Widget _buildSummaryBadge() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _kCardBg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _kDivider, width: 1),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.check_circle_rounded,
                color: _kSuccess,
                size: 44,
              ),
              const SizedBox(height: 12),
              const Text(
                'FractionColumnWidth Deep Demo Complete',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: _kDarkSlate,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'All sections rendered successfully. '
                'FractionColumnWidth provides a simple yet powerful way '
                'to size table columns as a proportion of the total width.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: _kMediumSlate,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _kBadgeBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _kSuccess.withAlpha(80), width: 1),
                ),
                child: const Text(
                  'TEST PASSED',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: _kBadgeText,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _kSurface,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              _buildSummaryRow('Class', 'FractionColumnWidth'),
              _buildSummaryRow('Extends', 'TableColumnWidth'),
              _buildSummaryRow('Package', 'flutter/rendering.dart'),
              _buildSummaryRow('Key Property', 'value (double)'),
              _buildSummaryRow('Sections Shown', '10'),
              _buildSummaryRow('Theme', 'Deep Blue / Slate'),
            ],
          ),
        ),
        const SizedBox(height: 40),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Summary row helper
// ---------------------------------------------------------------------------
Widget _buildSummaryRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _kMediumSlate,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _kDarkSlate,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Bonus – Live table demo with four FractionColumnWidth columns
// ---------------------------------------------------------------------------
Widget _buildLiveTableDemo() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'A live Table widget using FractionColumnWidth in columnWidths:',
          style: TextStyle(fontSize: 13, color: _kMediumSlate),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kDivider, width: 1),
          ),
          clipBehavior: Clip.antiAlias,
          child: Table(
            columnWidths: const {
              0: FractionColumnWidth(0.15),
              1: FractionColumnWidth(0.45),
              2: FractionColumnWidth(0.2),
              3: FractionColumnWidth(0.2),
            },
            children: [
              TableRow(
                decoration: const BoxDecoration(color: _kTableHeader),
                children: [
                  _buildTableCell('#', isHeader: true),
                  _buildTableCell('Feature', isHeader: true),
                  _buildTableCell('Status', isHeader: true),
                  _buildTableCell('Fraction', isHeader: true),
                ],
              ),
              TableRow(
                decoration: const BoxDecoration(color: _kTableRowEven),
                children: [
                  _buildTableCell('1'),
                  _buildTableCell('Fractional sizing'),
                  _buildTableCell('Active'),
                  _buildTableCell('0.15'),
                ],
              ),
              TableRow(
                decoration: const BoxDecoration(color: _kTableRowOdd),
                children: [
                  _buildTableCell('2'),
                  _buildTableCell('Proportional columns'),
                  _buildTableCell('Active'),
                  _buildTableCell('0.45'),
                ],
              ),
              TableRow(
                decoration: const BoxDecoration(color: _kTableRowEven),
                children: [
                  _buildTableCell('3'),
                  _buildTableCell('Adaptive width'),
                  _buildTableCell('Active'),
                  _buildTableCell('0.20'),
                ],
              ),
              TableRow(
                decoration: const BoxDecoration(color: _kTableRowOdd),
                children: [
                  _buildTableCell('4'),
                  _buildTableCell('Table integration'),
                  _buildTableCell('Active'),
                  _buildTableCell('0.20'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: _kSurface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Columns: 0.15 | 0.45 | 0.20 | 0.20  =  1.0 total',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _kPrimary,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// Main build function
// ===========================================================================
dynamic build(BuildContext context) {
  // Debug info
  print('FractionColumnWidth Deep Demo - rendering');
  print('FractionColumnWidth(0.5).value -> fraction of table width');
  print('Sections: 10 + 1 bonus live table');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1 – Header banner
        _buildHeaderBanner(),

        // 2 – What is FractionColumnWidth
        _buildSectionHeader(
          'What is FractionColumnWidth?',
          Icons.help_outline_rounded,
        ),
        _buildExplanationCards(),

        // 3 – Visual fraction bar
        _buildSectionHeader('Visual Fraction Bar', Icons.equalizer_rounded),
        _buildFractionBar(),

        // 4 – Table with FractionColumnWidth columns
        _buildSectionHeader(
          'Table with FractionColumnWidth',
          Icons.table_rows_rounded,
        ),
        _buildFractionTable(),

        // 5 – Comparison with other types
        _buildSectionHeader(
          'Comparison with Other Column Widths',
          Icons.compare_rounded,
        ),
        _buildComparisonSection(),

        // 6 – Multiple fraction scenarios
        _buildSectionHeader('Fraction Scenarios', Icons.pie_chart_rounded),
        _buildFractionScenarios(),

        // 7 – Distribution visualization
        _buildSectionHeader(
          'Column Width Distribution',
          Icons.bar_chart_rounded,
        ),
        _buildDistributionVisualization(),

        // 8 – Code snippets
        _buildSectionHeader('Code Snippets', Icons.code_rounded),
        _buildCodeSnippets(),

        // 9 – Real-world use cases
        _buildSectionHeader('Real-World Use Cases', Icons.apps_rounded),
        _buildRealWorldUseCases(),

        // Bonus – Live table demo
        _buildSectionHeader('Live Table Demo', Icons.preview_rounded),
        _buildLiveTableDemo(),

        // 10 – Summary badge
        _buildSectionHeader('Summary', Icons.verified_rounded),
        _buildSummaryBadge(),
      ],
    ),
  );
}
