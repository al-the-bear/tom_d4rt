// Deep visual test for RestorableDouble
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, sized_box_for_whitespace

import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Deep visual exploration of RestorableDouble
/// A restorable property that holds a non-null double value.
///
/// RestorableDouble extends RestorableNum and:
/// - Always contains a valid double (never null)
/// - Requires a default value at construction
/// - Handles IEEE 754 floating-point precision
///
/// Perfect for required numeric values like settings, measurements, or scores.
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF1A1A2E),
    ),
    home: _RestorableDoubleDemo(),
  );
}

// =============================================================================
// PALETTE: Indigo 700 / Amber A400
// =============================================================================
const Color _kPrimary = Color(0xFF303F9F); // Indigo 700
const Color _kAccent = Color(0xFFFFAB00); // Amber A400
const Color _kSurface = Color(0xFF252542);
const Color _kCardBg = Color(0xFF2D2D4A);
const Color _kTextPrimary = Color(0xFFE8E8F0);
const Color _kTextSecondary = Color(0xFFB0B0C8);
const Color _kDivider = Color(0xFF3A3A5C);
const Color _kSuccess = Color(0xFF66BB6A);
const Color _kWarning = Color(0xFFFF7043);
const Color _kMath = Color(0xFF26C6DA);

// =============================================================================
// MAIN DEMO WIDGET
// =============================================================================
class _RestorableDoubleDemo extends StatefulWidget {
  @override
  State<_RestorableDoubleDemo> createState() => _RestorableDoubleDemoState();
}

class _RestorableDoubleDemoState extends State<_RestorableDoubleDemo>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RestorableDouble Deep Dive'),
        backgroundColor: _kPrimary,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kTextSecondary,
          tabs: [
            Tab(icon: Icon(Icons.school), text: 'Theory'),
            Tab(icon: Icon(Icons.precision_manufacturing), text: 'Precision'),
            Tab(icon: Icon(Icons.calculate), text: 'Calculator'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TheoryTab(),
          _PrecisionTab(),
          _CalculatorTab(),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 1: THEORY
// =============================================================================
class _TheoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeroSection(),
          SizedBox(height: 24),
          _buildNonNullSection(),
          SizedBox(height: 24),
          _buildComparisonSection(),
          SizedBox(height: 24),
          _buildClassHierarchySection(),
          SizedBox(height: 24),
          _buildMathConstantsSection(),
          SizedBox(height: 24),
          _buildUseCasesSection(),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kPrimary, _kPrimary.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.pin, color: _kAccent, size: 32),
              SizedBox(width: 12),
              Text(
                'RestorableDouble',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'A restorable property for non-nullable double values. Always contains '
            'a valid number—perfect for required settings like volume, brightness, or scores.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 15,
              height: 1.5,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _HeroBadge(icon: Icons.numbers, label: 'double'),
              SizedBox(width: 12),
              _HeroBadge(icon: Icons.check_circle, label: 'Non-null'),
              SizedBox(width: 12),
              _HeroBadge(icon: Icons.functions, label: 'IEEE 754'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNonNullSection() {
    return _TheoryCard(
      title: 'Always Has Value',
      icon: Icons.shield,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RestorableDouble guarantees a valid double at all times:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kSuccess.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kSuccess.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: _kSuccess, size: 32),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Non-null Guarantee',
                        style: TextStyle(
                          color: _kSuccess,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'No null checks needed. Value always accessible via .value property.',
                        style: TextStyle(color: _kTextPrimary, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          _CodeExample(
            title: 'Direct access without null checks:',
            code: '''final volume = RestorableDouble(0.75);

// No null check needed!
double current = volume.value;
volume.value = 0.5;  // Always valid''',
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonSection() {
    return _TheoryCard(
      title: 'RestorableDouble vs RestorableDoubleN',
      icon: Icons.compare_arrows,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _ComparisonCard(
                  title: 'RestorableDouble',
                  color: _kAccent,
                  items: [
                    'Type: double',
                    'Never null',
                    'Default required',
                    'Direct .value',
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _ComparisonCard(
                  title: 'RestorableDoubleN',
                  color: _kWarning,
                  items: [
                    'Type: double?',
                    'Can be null',
                    'null default OK',
                    'Needs ?. check',
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.lightbulb_outline, color: _kAccent, size: 18),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Use RestorableDouble for required values (volume, brightness). '
                    'Use RestorableDoubleN when "not set" is meaningful.',
                    style: TextStyle(color: _kTextPrimary, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassHierarchySection() {
    return _TheoryCard(
      title: 'Class Hierarchy',
      icon: Icons.account_tree,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HierarchyItem(level: 0, name: 'RestorableProperty<double>', desc: 'Base'),
                _HierarchyItem(level: 1, name: 'RestorableValue<double>', desc: 'Value holder'),
                _HierarchyItem(level: 2, name: 'RestorableNum<double>', desc: 'Numeric'),
                _HierarchyItem(level: 3, name: 'RestorableDouble', desc: 'Non-null double', isHighlighted: true),
              ],
            ),
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _RelatedChip('RestorableDoubleN', 'Nullable'),
              _RelatedChip('RestorableInt', 'Integer'),
              _RelatedChip('RestorableNum', 'Generic num'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMathConstantsSection() {
    return _TheoryCard(
      title: 'Mathematical Constants',
      icon: Icons.functions,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RestorableDouble can store high-precision mathematical values:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          _MathConstantRow(symbol: 'π', name: 'Pi', value: math.pi),
          _MathConstantRow(symbol: 'e', name: 'Euler', value: math.e),
          _MathConstantRow(symbol: 'φ', name: 'Golden Ratio', value: 1.618033988749895),
          _MathConstantRow(symbol: '√2', name: 'Square Root 2', value: math.sqrt2),
          _MathConstantRow(symbol: 'ln2', name: 'Natural Log 2', value: math.ln2),
        ],
      ),
    );
  }

  Widget _buildUseCasesSection() {
    return _TheoryCard(
      title: 'Common Use Cases',
      icon: Icons.cases,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _UseCaseItem(
            icon: Icons.volume_up,
            title: 'Audio Volume',
            desc: '0.0 to 1.0 range slider',
          ),
          _UseCaseItem(
            icon: Icons.brightness_6,
            title: 'Screen Brightness',
            desc: 'Display adjustment setting',
          ),
          _UseCaseItem(
            icon: Icons.speed,
            title: 'Animation Speed',
            desc: 'Playback rate multiplier',
          ),
          _UseCaseItem(
            icon: Icons.zoom_in,
            title: 'Zoom Level',
            desc: 'Map or image scale factor',
          ),
        ],
      ),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  final IconData icon;
  final String label;

  const _HeroBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: _kAccent, size: 14),
          SizedBox(width: 6),
          Text(label, style: TextStyle(color: Colors.white, fontSize: 11)),
        ],
      ),
    );
  }
}

class _ComparisonCard extends StatelessWidget {
  final String title;
  final Color color;
  final List<String> items;

  const _ComparisonCard({required this.title, required this.color, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 11),
          ),
          SizedBox(height: 8),
          ...items.map((item) => Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                Icon(Icons.check, color: color, size: 12),
                SizedBox(width: 6),
                Flexible(
                  child: Text(item, style: TextStyle(color: _kTextPrimary, fontSize: 10)),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _MathConstantRow extends StatelessWidget {
  final String symbol;
  final String name;
  final double value;

  const _MathConstantRow({required this.symbol, required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kMath.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kMath.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _kMath.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                symbol,
                style: TextStyle(color: _kMath, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(color: _kTextPrimary, fontWeight: FontWeight.w500, fontSize: 12)),
                Text(
                  value.toStringAsFixed(15),
                  style: TextStyle(color: _kMath, fontFamily: 'monospace', fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UseCaseItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;

  const _UseCaseItem({required this.icon, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _kPrimary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: _kAccent, size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: _kTextPrimary, fontWeight: FontWeight.w500, fontSize: 13)),
                Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 2: PRECISION LAB
// =============================================================================
class _PrecisionTab extends StatefulWidget {
  @override
  State<_PrecisionTab> createState() => _PrecisionTabState();
}

class _PrecisionTabState extends State<_PrecisionTab> {
  double _value1 = 0.1;
  double _value2 = 0.2;
  final List<String> _log = [];

  @override
  void initState() {
    super.initState();
    _computeResult();
  }

  void _computeResult() {
    final sum = _value1 + _value2;
    final expected = 0.3;
    final diff = (sum - expected).abs();
    _addLog('$_value1 + $_value2 = $sum');
    _addLog('Expected: $expected, Diff: $diff');
  }

  void _addLog(String msg) {
    _log.insert(0, '${DateTime.now().toString().substring(11, 19)}: $msg');
    if (_log.length > 10) _log.removeLast();
  }

  void _setValues(double v1, double v2) {
    setState(() {
      _value1 = v1;
      _value2 = v2;
      _computeResult();
    });
  }

  @override
  Widget build(BuildContext context) {
    final sum = _value1 + _value2;

    return Column(
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kSurface,
            border: Border(bottom: BorderSide(color: _kDivider)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Floating-Point Precision Lab',
                style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                'Explore IEEE 754 double precision behavior. RestorableDouble stores these values as-is.',
                style: TextStyle(color: _kTextSecondary, fontSize: 12),
              ),
            ],
          ),
        ),
        // Visualization
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // Addition visualization
                _buildAdditionCard(sum),
                SizedBox(height: 24),
                // Precision examples
                _buildPrecisionExamplesCard(),
                SizedBox(height: 24),
                // Preset buttons
                _buildPresetButtons(),
                SizedBox(height: 24),
                // Representation details
                _buildRepresentationCard(sum),
              ],
            ),
          ),
        ),
        // Log
        Container(
          height: 100,
          padding: EdgeInsets.all(16),
          color: _kCardBg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Computation Log:', style: TextStyle(color: _kAccent, fontSize: 12)),
              SizedBox(height: 8),
              Expanded(
                child: ListView(
                  children: _log.map((e) => Text(
                    e,
                    style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 10),
                  )).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAdditionCard(double sum) {
    final expected = _value1 == 0.1 && _value2 == 0.2 ? 0.3 : _value1 + _value2;
    final isExact = sum == expected;

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isExact ? _kSuccess : _kWarning.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ValueBox(value: _value1, label: 'Value 1'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('+', style: TextStyle(color: _kAccent, fontSize: 28, fontWeight: FontWeight.bold)),
              ),
              _ValueBox(value: _value2, label: 'Value 2'),
            ],
          ),
          SizedBox(height: 16),
          Icon(Icons.arrow_downward, color: _kAccent, size: 28),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: _kAccent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _kAccent),
            ),
            child: Column(
              children: [
                Text('Result', style: TextStyle(color: _kTextSecondary, fontSize: 11)),
                SizedBox(height: 4),
                Text(
                  sum.toStringAsFixed(17),
                  style: TextStyle(
                    color: _kAccent,
                    fontFamily: 'monospace',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          if (_value1 == 0.1 && _value2 == 0.2) ...[
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kWarning.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: _kWarning, size: 18),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '0.1 + 0.2 ≠ 0.3 in floating-point! This is a classic IEEE 754 limitation.',
                      style: TextStyle(color: _kWarning, fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPrecisionExamplesCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Precision Examples', style: TextStyle(color: _kTextPrimary, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          _PrecisionRow(expr: '0.1', actual: 0.1),
          _PrecisionRow(expr: '0.2', actual: 0.2),
          _PrecisionRow(expr: '0.3', actual: 0.3),
          _PrecisionRow(expr: '1/3', actual: 1.0 / 3.0),
          _PrecisionRow(expr: '1/7', actual: 1.0 / 7.0),
        ],
      ),
    );
  }

  Widget _buildPresetButtons() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Test Presets:', style: TextStyle(color: _kTextSecondary, fontSize: 12)),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _PresetButton(label: '0.1 + 0.2', onTap: () => _setValues(0.1, 0.2)),
              _PresetButton(label: '0.5 + 0.5', onTap: () => _setValues(0.5, 0.5)),
              _PresetButton(label: '1/3 + 1/3', onTap: () => _setValues(1/3, 1/3)),
              _PresetButton(label: 'π/2 + π/2', onTap: () => _setValues(math.pi/2, math.pi/2)),
              _PresetButton(label: '0.7 + 0.3', onTap: () => _setValues(0.7, 0.3)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRepresentationCard(double sum) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.memory, color: _kMath, size: 20),
              SizedBox(width: 8),
              Text('IEEE 754 Representation', style: TextStyle(color: _kTextPrimary, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 16),
          _RepresentationRow(label: 'Sign bit', value: sum.isNegative ? '1 (negative)' : '0 (positive)'),
          _RepresentationRow(label: 'Exponent', value: '11 bits (biased)'),
          _RepresentationRow(label: 'Mantissa', value: '52 bits (fraction)'),
          _RepresentationRow(label: 'Total', value: '64 bits = 8 bytes'),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: _kTextSecondary, size: 14),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '~15-17 significant decimal digits precision',
                    style: TextStyle(color: _kTextSecondary, fontSize: 10),
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

class _ValueBox extends StatelessWidget {
  final double value;
  final String label;

  const _ValueBox({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
          SizedBox(height: 4),
          Text(
            value.toString(),
            style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _PrecisionRow extends StatelessWidget {
  final String expr;
  final double actual;

  const _PrecisionRow({required this.expr, required this.actual});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 6),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            child: Text(expr, style: TextStyle(color: _kAccent, fontSize: 11, fontFamily: 'monospace')),
          ),
          Text(' = ', style: TextStyle(color: _kTextSecondary, fontSize: 11)),
          Expanded(
            child: Text(
              actual.toStringAsFixed(17),
              style: TextStyle(color: _kTextPrimary, fontSize: 10, fontFamily: 'monospace'),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _PresetButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _PresetButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: _kPrimary.withOpacity(0.3),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: _kPrimary),
        ),
        child: Text(label, style: TextStyle(color: _kAccent, fontSize: 11)),
      ),
    );
  }
}

class _RepresentationRow extends StatelessWidget {
  final String label;
  final String value;

  const _RepresentationRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 80,
            child: Text(label, style: TextStyle(color: _kTextSecondary, fontSize: 11)),
          ),
          Expanded(
            child: Text(value, style: TextStyle(color: _kTextPrimary, fontSize: 11)),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 3: CALCULATOR
// =============================================================================
class _CalculatorTab extends StatefulWidget {
  @override
  State<_CalculatorTab> createState() => _CalculatorTabState();
}

class _CalculatorTabState extends State<_CalculatorTab> {
  // Simulated RestorableDouble values
  double _memory = 0.0;
  double _display = 0.0;
  String _operation = '';
  double _operand = 0.0;
  bool _newNumber = true;
  final List<String> _history = [];

  void _digit(int d) {
    setState(() {
      if (_newNumber) {
        _display = d.toDouble();
        _newNumber = false;
      } else {
        _display = _display * 10 + d;
      }
    });
  }

  void _decimal() {
    setState(() {
      if (_newNumber) {
        _display = 0.0;
        _newNumber = false;
      }
    });
  }

  void _op(String op) {
    setState(() {
      _operand = _display;
      _operation = op;
      _newNumber = true;
    });
  }

  void _equals() {
    setState(() {
      double result = _display;
      switch (_operation) {
        case '+':
          result = _operand + _display;
          break;
        case '-':
          result = _operand - _display;
          break;
        case '×':
          result = _operand * _display;
          break;
        case '÷':
          result = _display != 0 ? _operand / _display : double.infinity;
          break;
      }
      _history.insert(0, '$_operand $_operation $_display = $result');
      if (_history.length > 8) _history.removeLast();
      _display = result;
      _operation = '';
      _newNumber = true;
    });
  }

  void _clear() {
    setState(() {
      _display = 0.0;
      _operation = '';
      _operand = 0.0;
      _newNumber = true;
    });
  }

  void _memoryStore() {
    setState(() {
      _memory = _display;
      _history.insert(0, 'M← $_display');
      if (_history.length > 8) _history.removeLast();
    });
  }

  void _memoryRecall() {
    setState(() {
      _display = _memory;
      _newNumber = true;
    });
  }

  void _memoryAdd() {
    setState(() {
      _memory += _display;
      _history.insert(0, 'M+ $_display (M=$_memory)');
      if (_history.length > 8) _history.removeLast();
    });
  }

  void _sqrt() {
    setState(() {
      final result = math.sqrt(_display);
      _history.insert(0, '√$_display = $result');
      if (_history.length > 8) _history.removeLast();
      _display = result;
      _newNumber = true;
    });
  }

  void _percent() {
    setState(() {
      final result = _display / 100;
      _history.insert(0, '$_display% = $result');
      if (_history.length > 8) _history.removeLast();
      _display = result;
      _newNumber = true;
    });
  }

  void _negate() {
    setState(() {
      _display = -_display;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(16),
          color: _kSurface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.calculate, color: _kAccent, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'RestorableDouble Calculator',
                    style: TextStyle(color: _kTextPrimary, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                'All values would persist via RestorableDouble in a real app.',
                style: TextStyle(color: _kTextSecondary, fontSize: 11),
              ),
            ],
          ),
        ),
        // Display
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          color: _kCardBg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (_operation.isNotEmpty)
                Text(
                  '$_operand $_operation',
                  style: TextStyle(color: _kTextSecondary, fontSize: 14),
                ),
              SizedBox(height: 4),
              Text(
                _formatDisplay(_display),
                style: TextStyle(
                  color: _kTextPrimary,
                  fontSize: 36,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _memory != 0 ? _kAccent.withOpacity(0.2) : _kSurface,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'M: ${_memory.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: _memory != 0 ? _kAccent : _kTextSecondary,
                        fontSize: 10,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Keypad
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8),
            color: _kSurface,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      _CalcButton(label: 'MC', onTap: () => setState(() => _memory = 0), color: _kTextSecondary),
                      _CalcButton(label: 'MR', onTap: _memoryRecall, color: _kTextSecondary),
                      _CalcButton(label: 'M+', onTap: _memoryAdd, color: _kTextSecondary),
                      _CalcButton(label: 'MS', onTap: _memoryStore, color: _kTextSecondary),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      _CalcButton(label: 'C', onTap: _clear, color: _kWarning),
                      _CalcButton(label: '±', onTap: _negate, color: _kTextSecondary),
                      _CalcButton(label: '%', onTap: _percent, color: _kTextSecondary),
                      _CalcButton(label: '÷', onTap: () => _op('÷'), color: _kAccent),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      _CalcButton(label: '7', onTap: () => _digit(7)),
                      _CalcButton(label: '8', onTap: () => _digit(8)),
                      _CalcButton(label: '9', onTap: () => _digit(9)),
                      _CalcButton(label: '×', onTap: () => _op('×'), color: _kAccent),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      _CalcButton(label: '4', onTap: () => _digit(4)),
                      _CalcButton(label: '5', onTap: () => _digit(5)),
                      _CalcButton(label: '6', onTap: () => _digit(6)),
                      _CalcButton(label: '-', onTap: () => _op('-'), color: _kAccent),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      _CalcButton(label: '1', onTap: () => _digit(1)),
                      _CalcButton(label: '2', onTap: () => _digit(2)),
                      _CalcButton(label: '3', onTap: () => _digit(3)),
                      _CalcButton(label: '+', onTap: () => _op('+'), color: _kAccent),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      _CalcButton(label: '√', onTap: _sqrt, color: _kMath),
                      _CalcButton(label: '0', onTap: () => _digit(0)),
                      _CalcButton(label: '.', onTap: _decimal),
                      _CalcButton(label: '=', onTap: _equals, color: _kSuccess, isAccent: true),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // History
        Container(
          height: 80,
          padding: EdgeInsets.all(12),
          color: _kCardBg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('History:', style: TextStyle(color: _kAccent, fontSize: 10)),
              SizedBox(height: 4),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _history.map((h) => Container(
                    margin: EdgeInsets.only(right: 8),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: _kSurface,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(h, style: TextStyle(color: _kTextPrimary, fontSize: 10, fontFamily: 'monospace')),
                    ),
                  )).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDisplay(double value) {
    if (value == value.truncateToDouble()) {
      return value.truncate().toString();
    }
    return value.toStringAsFixed(8).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
  }
}

class _CalcButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color? color;
  final bool isAccent;

  const _CalcButton({
    required this.label,
    required this.onTap,
    this.color,
    this.isAccent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(4),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: isAccent ? _kSuccess : _kCardBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: isAccent ? Colors.black87 : (color ?? _kTextPrimary),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// HELPER WIDGETS
// =============================================================================
class _TheoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _TheoryCard({required this.title, required this.icon, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: _kDivider)),
            ),
            child: Row(
              children: [
                Icon(icon, color: _kAccent, size: 22),
                SizedBox(width: 12),
                Text(title, style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _HierarchyItem extends StatelessWidget {
  final int level;
  final String name;
  final String desc;
  final bool isHighlighted;

  const _HierarchyItem({required this.level, required this.name, required this.desc, this.isHighlighted = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: level * 14.0, top: level > 0 ? 6 : 0),
      child: Row(
        children: [
          if (level > 0) ...[
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                border: Border(left: BorderSide(color: _kDivider), bottom: BorderSide(color: _kDivider)),
              ),
            ),
            SizedBox(width: 6),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: isHighlighted ? _kAccent.withOpacity(0.2) : _kCardBg,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: isHighlighted ? _kAccent : _kDivider),
              ),
              child: Text(
                name,
                style: TextStyle(
                  color: isHighlighted ? _kAccent : _kTextPrimary,
                  fontFamily: 'monospace',
                  fontSize: 9,
                  fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
          SizedBox(width: 6),
          Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 9)),
        ],
      ),
    );
  }
}

class _RelatedChip extends StatelessWidget {
  final String name;
  final String desc;
  const _RelatedChip(this.name, this.desc);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: _kDivider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(name, style: TextStyle(color: _kTextPrimary, fontSize: 10, fontFamily: 'monospace')),
          SizedBox(width: 4),
          Text('($desc)', style: TextStyle(color: _kTextSecondary, fontSize: 9)),
        ],
      ),
    );
  }
}

class _CodeExample extends StatelessWidget {
  final String title;
  final String code;

  const _CodeExample({required this.title, required this.code});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: _kTextSecondary, fontSize: 12)),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kSurface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kAccent.withOpacity(0.2)),
          ),
          child: Text(
            code,
            style: TextStyle(
              color: _kTextPrimary,
              fontFamily: 'monospace',
              fontSize: 10,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
