// Deep visual test for RestorableIntN
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, sized_box_for_whitespace, unintended_html_in_doc_comment, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

/// Deep visual exploration of RestorableIntN
/// A restorable property that holds a nullable integer value.
///
/// RestorableIntN:
/// - Can be null or any valid int
/// - Extends RestorableNumN<int?>
/// - Full int64 range support
///
/// Perfect for optional counts, indices, or quantities.
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF1A1A2E),
    ),
    home: _RestorableIntNDemo(),
  );
}

// =============================================================================
// PALETTE: Brown 700 / LightGreen A400
// =============================================================================
const Color _kPrimary = Color(0xFF5D4037); // Brown 700
const Color _kAccent = Color(0xFF76FF03); // LightGreen A400
const Color _kSurface = Color(0xFF252542);
const Color _kCardBg = Color(0xFF2D2D4A);
const Color _kTextPrimary = Color(0xFFE8E8F0);
const Color _kTextSecondary = Color(0xFFB0B0C8);
const Color _kDivider = Color(0xFF3A3A5C);
const Color _kNull = Color(0xFF9E9E9E);
const Color _kPositive = Color(0xFF66BB6A);
const Color _kNegative = Color(0xFFEF5350);
const Color _kZero = Color(0xFF42A5F5);

// =============================================================================
// MAIN DEMO WIDGET
// =============================================================================
class _RestorableIntNDemo extends StatefulWidget {
  @override
  State<_RestorableIntNDemo> createState() => _RestorableIntNDemoState();
}

class _RestorableIntNDemoState extends State<_RestorableIntNDemo>
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
        title: Text('RestorableIntN Deep Dive'),
        backgroundColor: _kPrimary,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kTextSecondary,
          tabs: [
            Tab(icon: Icon(Icons.school), text: 'Theory'),
            Tab(icon: Icon(Icons.memory), text: 'Bit Explorer'),
            Tab(icon: Icon(Icons.add_circle_outline), text: 'Counter'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TheoryTab(),
          _BitExplorerTab(),
          _CounterTab(),
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
          _buildNullableSection(),
          SizedBox(height: 24),
          _buildRangeSection(),
          SizedBox(height: 24),
          _buildClassHierarchySection(),
          SizedBox(height: 24),
          _buildComparisonSection(),
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
              Icon(Icons.tag, color: _kAccent, size: 32),
              SizedBox(width: 12),
              Text(
                'RestorableIntN',
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
            'A restorable property for nullable integer values. Can be null or any '
            'valid int—perfect for optional counts, page indices, or quantities.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 15,
              height: 1.5,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _HeroBadge(icon: Icons.numbers, label: 'int?'),
              SizedBox(width: 12),
              _HeroBadge(icon: Icons.not_interested, label: 'Nullable'),
              SizedBox(width: 12),
              _HeroBadge(icon: Icons.all_inclusive, label: '64-bit'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNullableSection() {
    return _TheoryCard(
      title: 'Nullable Integer Values',
      icon: Icons.not_interested,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RestorableIntN can hold null or any integer:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _StateBox(label: 'null', color: _kNull, icon: Icons.remove_circle_outline)),
              SizedBox(width: 8),
              Expanded(child: _StateBox(label: '-N', color: _kNegative, icon: Icons.exposure_minus_1)),
              SizedBox(width: 8),
              Expanded(child: _StateBox(label: '0', color: _kZero, icon: Icons.exposure_zero)),
              SizedBox(width: 8),
              Expanded(child: _StateBox(label: '+N', color: _kPositive, icon: Icons.exposure_plus_1)),
            ],
          ),
          SizedBox(height: 16),
          _CodeExample(
            title: 'Usage patterns:',
            code: '''// Optional page index
final pageIndex = RestorableIntN(null);

// With default value
final count = RestorableIntN(0);

// Check nullability
if (pageIndex.value != null) {
  navigateTo(pageIndex.value!);
}''',
          ),
        ],
      ),
    );
  }

  Widget _buildRangeSection() {
    return _TheoryCard(
      title: 'Integer Range (64-bit)',
      icon: Icons.straighten,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dart int is 64-bit on native platforms:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          _RangeCard(
            label: 'Minimum',
            value: '-9,223,372,036,854,775,808',
            hex: '0x8000000000000000',
            color: _kNegative,
          ),
          SizedBox(height: 8),
          _RangeCard(
            label: 'Zero',
            value: '0',
            hex: '0x0000000000000000',
            color: _kZero,
          ),
          SizedBox(height: 8),
          _RangeCard(
            label: 'Maximum',
            value: '9,223,372,036,854,775,807',
            hex: '0x7FFFFFFFFFFFFFFF',
            color: _kPositive,
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: _kAccent, size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'On web, integers are limited to 53 bits (JavaScript number precision).',
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
                _HierarchyItem(level: 0, name: 'RestorableProperty<int?>', desc: 'Base'),
                _HierarchyItem(level: 1, name: 'RestorableValue<int?>', desc: 'Value holder'),
                _HierarchyItem(level: 2, name: 'RestorableNumN<int?>', desc: 'Nullable numeric'),
                _HierarchyItem(level: 3, name: 'RestorableIntN', desc: 'Nullable int', isHighlighted: true),
              ],
            ),
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _RelatedChip('RestorableInt', 'Non-null'),
              _RelatedChip('RestorableDoubleN', 'Nullable double'),
              _RelatedChip('RestorableNumN', 'Generic nullable num'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonSection() {
    return _TheoryCard(
      title: 'RestorableIntN vs RestorableInt',
      icon: Icons.compare_arrows,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _ComparisonCard(
                  title: 'RestorableIntN',
                  color: _kAccent,
                  items: [
                    'Type: int?',
                    'Can be null',
                    'Optional values',
                    'Needs null check',
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _ComparisonCard(
                  title: 'RestorableInt',
                  color: _kPrimary,
                  items: [
                    'Type: int',
                    'Never null',
                    'Required values',
                    'Direct access',
                  ],
                ),
              ),
            ],
          ),
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
            icon: Icons.bookmark,
            title: 'Optional Page Index',
            desc: 'null = start from beginning',
            color: _kNull,
          ),
          _UseCaseItem(
            icon: Icons.shopping_cart,
            title: 'Item Quantity',
            desc: 'null = not in cart',
            color: _kPositive,
          ),
          _UseCaseItem(
            icon: Icons.leaderboard,
            title: 'High Score',
            desc: 'null = no score yet',
            color: _kAccent,
          ),
          _UseCaseItem(
            icon: Icons.calendar_today,
            title: 'Selected Index',
            desc: 'null = no selection',
            color: _kZero,
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

class _StateBox extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;

  const _StateBox({required this.label, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: 4),
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }
}

class _RangeCard extends StatelessWidget {
  final String label;
  final String value;
  final String hex;
  final Color color;

  const _RangeCard({required this.label, required this.value, required this.hex, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(value, style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 11)),
                Text(hex, style: TextStyle(color: _kTextSecondary, fontFamily: 'monospace', fontSize: 9)),
              ],
            ),
          ),
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

class _UseCaseItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  final Color color;

  const _UseCaseItem({required this.icon, required this.title, required this.desc, required this.color});

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
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
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
// TAB 2: BIT EXPLORER
// =============================================================================
class _BitExplorerTab extends StatefulWidget {
  @override
  State<_BitExplorerTab> createState() => _BitExplorerTabState();
}

class _BitExplorerTabState extends State<_BitExplorerTab> {
  int? _value;
  final List<String> _log = [];

  void _setValue(int? v) {
    setState(() {
      _value = v;
      if (v == null) {
        _log.insert(0, '${_ts()}: Set to null');
      } else {
        _log.insert(0, '${_ts()}: Set to $v');
      }
      if (_log.length > 8) _log.removeLast();
    });
  }

  void _increment() {
    if (_value == null) {
      _setValue(0);
    } else if (_value! < 9223372036854775807) {
      _setValue(_value! + 1);
    }
  }

  void _decrement() {
    if (_value == null) {
      _setValue(0);
    } else if (_value! > -9223372036854775808) {
      _setValue(_value! - 1);
    }
  }

  void _double() {
    if (_value != null) {
      _setValue(_value! * 2);
    }
  }

  void _halve() {
    if (_value != null) {
      _setValue(_value! ~/ 2);
    }
  }

  void _negate() {
    if (_value != null) {
      _setValue(-_value!);
    }
  }

  String _ts() => DateTime.now().toString().substring(11, 19);

  String _toBinary(int? value) {
    if (value == null) return '(null)';
    if (value >= 0) {
      return value.toRadixString(2).padLeft(8, '0');
    }
    // Simplified representation for negative
    return '-' + (-value).toRadixString(2).padLeft(8, '0');
  }

  String _toHex(int? value) {
    if (value == null) return 'null';
    return '0x${value.toRadixString(16).toUpperCase()}';
  }

  @override
  Widget build(BuildContext context) {
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
              Row(
                children: [
                  Icon(Icons.memory, color: _kAccent, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Integer Bit Explorer',
                    style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                'Explore integer values and their binary/hex representations.',
                style: TextStyle(color: _kTextSecondary, fontSize: 12),
              ),
            ],
          ),
        ),
        // Value Display
        Container(
          padding: EdgeInsets.all(20),
          color: _kCardBg,
          child: Column(
            children: [
              // Current value
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'RestorableIntN: ',
                    style: TextStyle(color: _kTextSecondary, fontSize: 14),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: _getValueColor(_value).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: _getValueColor(_value)),
                    ),
                    child: Text(
                      _value?.toString() ?? 'null',
                      style: TextStyle(
                        color: _getValueColor(_value),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Representations
              Row(
                children: [
                  Expanded(
                    child: _RepCard(
                      label: 'Binary',
                      value: _toBinary(_value),
                      color: _kAccent,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _RepCard(
                      label: 'Hex',
                      value: _toHex(_value),
                      color: _kZero,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Controls
        Container(
          padding: EdgeInsets.all(16),
          color: _kSurface,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: _OpButton(label: '−1', icon: Icons.remove, onTap: _decrement)),
                  SizedBox(width: 8),
                  Expanded(child: _OpButton(label: '+1', icon: Icons.add, onTap: _increment)),
                  SizedBox(width: 8),
                  Expanded(child: _OpButton(label: '×2', icon: Icons.close, onTap: _double)),
                  SizedBox(width: 8),
                  Expanded(child: _OpButton(label: '÷2', icon: Icons.horizontal_rule, onTap: _halve)),
                  SizedBox(width: 8),
                  Expanded(child: _OpButton(label: '±', icon: Icons.swap_vert, onTap: _negate)),
                ],
              ),
              SizedBox(height: 12),
              Text('Quick values:', style: TextStyle(color: _kTextSecondary, fontSize: 11)),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _QuickButton(label: 'null', value: null, onTap: () => _setValue(null)),
                  _QuickButton(label: '0', value: 0, onTap: () => _setValue(0)),
                  _QuickButton(label: '1', value: 1, onTap: () => _setValue(1)),
                  _QuickButton(label: '42', value: 42, onTap: () => _setValue(42)),
                  _QuickButton(label: '100', value: 100, onTap: () => _setValue(100)),
                  _QuickButton(label: '255', value: 255, onTap: () => _setValue(255)),
                  _QuickButton(label: '1000', value: 1000, onTap: () => _setValue(1000)),
                  _QuickButton(label: '-1', value: -1, onTap: () => _setValue(-1)),
                  _QuickButton(label: '-100', value: -100, onTap: () => _setValue(-100)),
                ],
              ),
            ],
          ),
        ),
        // Bit visualization
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bit Pattern (low 16 bits):', style: TextStyle(color: _kTextPrimary, fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                _BitVisualization(value: _value),
              ],
            ),
          ),
        ),
        // Log
        Container(
          height: 70,
          padding: EdgeInsets.all(12),
          color: _kCardBg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Value Log:', style: TextStyle(color: _kAccent, fontSize: 10)),
              SizedBox(height: 4),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _log.map((l) => Container(
                    margin: EdgeInsets.only(right: 12),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _kSurface,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(l, style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 10)),
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

  Color _getValueColor(int? value) {
    if (value == null) return _kNull;
    if (value > 0) return _kPositive;
    if (value < 0) return _kNegative;
    return _kZero;
  }
}

class _RepCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _RepCard({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _OpButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _OpButton({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: _kCardBg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(label, style: TextStyle(color: _kAccent, fontWeight: FontWeight.bold, fontSize: 14)),
        ),
      ),
    );
  }
}

class _QuickButton extends StatelessWidget {
  final String label;
  final int? value;
  final VoidCallback onTap;

  const _QuickButton({required this.label, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: _kPrimary.withOpacity(0.3),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: _kPrimary),
        ),
        child: Text(label, style: TextStyle(color: _kTextPrimary, fontSize: 11)),
      ),
    );
  }
}

class _BitVisualization extends StatelessWidget {
  final int? value;

  const _BitVisualization({required this.value});

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _kNull.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _kNull.withOpacity(0.3)),
        ),
        child: Center(
          child: Text('null - no bits to display', style: TextStyle(color: _kNull, fontSize: 14)),
        ),
      );
    }

    final bits = <int>[];
    int v = value!.abs();
    for (int i = 0; i < 16; i++) {
      bits.add(v & 1);
      v >>= 1;
    }
    bits.setRange(0, 16, bits.reversed);

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: List.generate(16, (i) {
        final bit = bits[i];
        return Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: bit == 1 ? _kAccent.withOpacity(0.3) : _kSurface,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: bit == 1 ? _kAccent : _kDivider),
          ),
          child: Center(
            child: Text(
              '$bit',
              style: TextStyle(
                color: bit == 1 ? _kAccent : _kTextSecondary,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
          ),
        );
      }),
    );
  }
}

// =============================================================================
// TAB 3: COUNTER DEMO
// =============================================================================
class _CounterTab extends StatefulWidget {
  @override
  State<_CounterTab> createState() => _CounterTabState();
}

class _CounterTabState extends State<_CounterTab> {
  // Simulated RestorableIntN counters
  int? _counter1;
  int? _counter2;
  int? _counter3;
  final List<String> _history = [];

  void _updateCounter(int index, int? Function(int?) update) {
    setState(() {
      switch (index) {
        case 1:
          _counter1 = update(_counter1);
          _addHistory('Counter 1: ${_counter1 ?? 'null'}');
          break;
        case 2:
          _counter2 = update(_counter2);
          _addHistory('Counter 2: ${_counter2 ?? 'null'}');
          break;
        case 3:
          _counter3 = update(_counter3);
          _addHistory('Counter 3: ${_counter3 ?? 'null'}');
          break;
      }
    });
  }

  void _addHistory(String msg) {
    _history.insert(0, '${DateTime.now().toString().substring(11, 19)}: $msg');
    if (_history.length > 12) _history.removeLast();
  }

  void _initAll() {
    setState(() {
      _counter1 = 0;
      _counter2 = 0;
      _counter3 = 0;
      _addHistory('All initialized to 0');
    });
  }

  void _resetAll() {
    setState(() {
      _counter1 = null;
      _counter2 = null;
      _counter3 = null;
      _addHistory('All reset to null');
    });
  }

  int? _getTotal() {
    if (_counter1 == null && _counter2 == null && _counter3 == null) return null;
    return (_counter1 ?? 0) + (_counter2 ?? 0) + (_counter3 ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    final total = _getTotal();
    final nullCount = [_counter1, _counter2, _counter3].where((c) => c == null).length;

    return Column(
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kSurface,
            border: Border(bottom: BorderSide(color: _kDivider)),
          ),
          child: Row(
            children: [
              Icon(Icons.add_circle_outline, color: _kAccent, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Multi-Counter Demo', style: TextStyle(color: _kTextPrimary, fontWeight: FontWeight.bold)),
                    Text('Each counter simulates RestorableIntN', style: TextStyle(color: _kTextSecondary, fontSize: 11)),
                  ],
                ),
              ),
              Row(
                children: [
                  _ActionChip(label: 'Init All', color: _kPositive, onTap: _initAll),
                  SizedBox(width: 8),
                  _ActionChip(label: 'Reset', color: _kNegative, onTap: _resetAll),
                ],
              ),
            ],
          ),
        ),
        // Counters
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                _CounterCard(
                  index: 1,
                  label: 'Page Views',
                  icon: Icons.visibility,
                  value: _counter1,
                  onUpdate: (fn) => _updateCounter(1, fn),
                ),
                SizedBox(height: 16),
                _CounterCard(
                  index: 2,
                  label: 'Items Added',
                  icon: Icons.add_shopping_cart,
                  value: _counter2,
                  onUpdate: (fn) => _updateCounter(2, fn),
                ),
                SizedBox(height: 16),
                _CounterCard(
                  index: 3,
                  label: 'Actions Taken',
                  icon: Icons.touch_app,
                  value: _counter3,
                  onUpdate: (fn) => _updateCounter(3, fn),
                ),
              ],
            ),
          ),
        ),
        // Summary
        Container(
          padding: EdgeInsets.all(16),
          color: _kCardBg,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Summary', style: TextStyle(color: _kTextSecondary, fontSize: 11)),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text('Total: ', style: TextStyle(color: _kTextPrimary)),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: total == null ? _kNull.withOpacity(0.2) : _kAccent.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            total?.toString() ?? 'null',
                            style: TextStyle(
                              color: total == null ? _kNull : _kAccent,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('$nullCount null', style: TextStyle(color: _kNull, fontSize: 12)),
                  Text('${3 - nullCount} active', style: TextStyle(color: _kPositive, fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
        // History
        Container(
          height: 100,
          padding: EdgeInsets.all(12),
          color: _kSurface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Action History:', style: TextStyle(color: _kAccent, fontSize: 10)),
              SizedBox(height: 6),
              Expanded(
                child: ListView(
                  children: _history.map((h) => Text(
                    h,
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
}

class _ActionChip extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionChip({required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(label, style: TextStyle(color: color, fontSize: 11)),
      ),
    );
  }
}

class _CounterCard extends StatelessWidget {
  final int index;
  final String label;
  final IconData icon;
  final int? value;
  final void Function(int? Function(int?)) onUpdate;

  const _CounterCard({
    required this.index,
    required this.label,
    required this.icon,
    required this.value,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final isNull = value == null;
    final isPositive = value != null && value! > 0;
    final isNegative = value != null && value! < 0;

    final color = isNull ? _kNull : (isNegative ? _kNegative : (isPositive ? _kPositive : _kZero));

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _kPrimary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: _kAccent, size: 24),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Counter $index', style: TextStyle(color: _kTextSecondary, fontSize: 11)),
                    Text(label, style: TextStyle(color: _kTextPrimary, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color),
                ),
                child: Text(
                  value?.toString() ?? 'null',
                  style: TextStyle(
                    color: color,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _CounterButton(
                  label: 'Clear',
                  icon: Icons.clear,
                  color: _kNull,
                  onTap: () => onUpdate((v) => null),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _CounterButton(
                  label: '-10',
                  icon: Icons.remove,
                  color: _kNegative,
                  onTap: () => onUpdate((v) => (v ?? 0) - 10),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _CounterButton(
                  label: '-1',
                  icon: Icons.remove,
                  color: _kNegative,
                  onTap: () => onUpdate((v) => (v ?? 0) - 1),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _CounterButton(
                  label: '+1',
                  icon: Icons.add,
                  color: _kPositive,
                  onTap: () => onUpdate((v) => (v ?? 0) + 1),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _CounterButton(
                  label: '+10',
                  icon: Icons.add,
                  color: _kPositive,
                  onTap: () => onUpdate((v) => (v ?? 0) + 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CounterButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _CounterButton({required this.label, required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color.withOpacity(0.4)),
        ),
        child: Center(
          child: Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
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
