// Deep visual test for RestorableNumN
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, unintended_html_in_doc_comment

import 'package:flutter/material.dart';

/// Deep visual exploration of RestorableNumN
/// A restorable property for nullable numeric values (int or double).
///
/// RestorableNumN<T extends num?> enables:
/// - Storage of nullable num values (int? or double?)
/// - Restoration of numeric state across app restarts
/// - Parent class for RestorableIntN and RestorableDoubleN
///
/// Perfect when you need a nullable numeric field that persists.
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF1A1A2E),
    ),
    home: _RestorableNumNDemo(),
  );
}

// =============================================================================
// PALETTE: Teal 600 / Yellow A700
// =============================================================================
const Color _kPrimary = Color(0xFF00897B); // Teal 600
const Color _kAccent = Color(0xFFFFD600); // Yellow A700
const Color _kSurface = Color(0xFF252542);
const Color _kCardBg = Color(0xFF2D2D4A);
const Color _kTextPrimary = Color(0xFFE8E8F0);
const Color _kTextSecondary = Color(0xFFB0B0C8);
const Color _kDivider = Color(0xFF3A3A5C);
const Color _kSuccess = Color(0xFF66BB6A);
const Color _kWarning = Color(0xFFFF7043);
const Color _kNull = Color(0xFF7E57C2);
const Color _kInt = Color(0xFF42A5F5);
const Color _kDouble = Color(0xFFEC407A);

// =============================================================================
// MAIN DEMO WIDGET
// =============================================================================
class _RestorableNumNDemo extends StatefulWidget {
  @override
  State<_RestorableNumNDemo> createState() => _RestorableNumNDemoState();
}

class _RestorableNumNDemoState extends State<_RestorableNumNDemo>
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
        title: Text('RestorableNumN Deep Dive'),
        backgroundColor: _kPrimary,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kTextSecondary,
          tabs: [
            Tab(icon: Icon(Icons.school), text: 'Theory'),
            Tab(icon: Icon(Icons.numbers), text: 'Type Lab'),
            Tab(icon: Icon(Icons.compare), text: 'Comparison'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TheoryTab(),
          _TypeLabTab(),
          _ComparisonTab(),
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
          _buildNullableNatureSection(),
          SizedBox(height: 24),
          _buildTypeSystemSection(),
          SizedBox(height: 24),
          _buildInheritanceSection(),
          SizedBox(height: 24),
          _buildSerializationSection(),
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
              Icon(Icons.question_mark, color: _kAccent, size: 32),
              SizedBox(width: 12),
              Text(
                'RestorableNumN<T>',
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
            'A restorable property for nullable numeric values. Stores int?, double?, '
            'or num? with full restoration support. The "N" suffix indicates nullability, '
            'matching Flutter\'s naming convention.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 15,
              height: 1.5,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _HeroBadge(icon: Icons.question_mark, label: 'Nullable'),
              SizedBox(width: 12),
              _HeroBadge(icon: Icons.numbers, label: 'num?'),
              SizedBox(width: 12),
              _HeroBadge(icon: Icons.account_tree, label: 'Parent'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNullableNatureSection() {
    return _TheoryCard(
      title: 'Nullable by Design',
      icon: Icons.question_mark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The "N" suffix in RestorableNumN indicates nullable type parameter:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _kNull.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _kNull.withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.check_box_outline_blank, color: _kNull, size: 32),
                      SizedBox(height: 8),
                      Text(
                        'null',
                        style: TextStyle(
                          color: _kNull,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Valid value',
                        style: TextStyle(color: _kTextSecondary, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _kInt.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _kInt.withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.pin, color: _kInt, size: 32),
                      SizedBox(height: 8),
                      Text(
                        '42',
                        style: TextStyle(
                          color: _kInt,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'int value',
                        style: TextStyle(color: _kTextSecondary, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _kDouble.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _kDouble.withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.more_horiz, color: _kDouble, size: 32),
                      SizedBox(height: 8),
                      Text(
                        '3.14',
                        style: TextStyle(
                          color: _kDouble,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'double value',
                        style: TextStyle(color: _kTextSecondary, fontSize: 11),
                      ),
                    ],
                  ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Naming Convention:',
                  style: TextStyle(color: _kAccent, fontWeight: FontWeight.bold, fontSize: 12),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'RestorableNumN',
                      style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 12),
                    ),
                    SizedBox(width: 8),
                    Text('→', style: TextStyle(color: _kDivider)),
                    SizedBox(width: 8),
                    Text(
                      'T extends num? (nullable)',
                      style: TextStyle(color: _kNull, fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      'RestorableNum',
                      style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 12),
                    ),
                    SizedBox(width: 8),
                    Text('→', style: TextStyle(color: _kDivider)),
                    SizedBox(width: 8),
                    Text(
                      'T extends num (non-null)',
                      style: TextStyle(color: _kSuccess, fontSize: 12),
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

  Widget _buildTypeSystemSection() {
    return _TheoryCard(
      title: 'Dart\'s num Type System',
      icon: Icons.category,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'In Dart, num is the supertype of both int and double:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _TypeHierarchyNode(
                  name: 'Object',
                  color: _kTextSecondary,
                  indent: 0,
                ),
                _TypeHierarchyNode(
                  name: 'num',
                  color: _kPrimary,
                  indent: 1,
                  isHighlighted: true,
                ),
                _TypeHierarchyNode(
                  name: 'int',
                  color: _kInt,
                  indent: 2,
                ),
                _TypeHierarchyNode(
                  name: 'double',
                  color: _kDouble,
                  indent: 2,
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text(
            'RestorableNumN<T extends num?> unifies both:',
            style: TextStyle(color: _kTextSecondary, fontSize: 13),
          ),
          SizedBox(height: 12),
          _TypeUsageRow(
            code: 'RestorableNumN<int?>(null)',
            desc: 'Nullable integer',
            color: _kInt,
          ),
          SizedBox(height: 8),
          _TypeUsageRow(
            code: 'RestorableNumN<double?>(3.14)',
            desc: 'Nullable double',
            color: _kDouble,
          ),
          SizedBox(height: 8),
          _TypeUsageRow(
            code: 'RestorableNumN<num?>(42)',
            desc: 'Any nullable numeric',
            color: _kPrimary,
          ),
        ],
      ),
    );
  }

  Widget _buildInheritanceSection() {
    return _TheoryCard(
      title: 'Class Hierarchy',
      icon: Icons.account_tree,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RestorableNumN is a parent class for specialized nullable types:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          _HierarchyNode(
            name: 'RestorableProperty<T>',
            desc: 'Root restoration',
            level: 0,
            isAbstract: true,
          ),
          _HierarchyNode(
            name: 'RestorableValue<T>',
            desc: 'Value management',
            level: 1,
            isAbstract: true,
          ),
          _HierarchyNode(
            name: '_RestorablePrimitiveValueN<T>',
            desc: 'Nullable primitives',
            level: 2,
            isAbstract: true,
            isPrivate: true,
          ),
          _HierarchyNode(
            name: 'RestorableNumN<T>',
            desc: 'Nullable numerics',
            level: 3,
            isAbstract: false,
            isHighlighted: true,
          ),
          _HierarchyNode(
            name: 'RestorableIntN',
            desc: 'int?',
            level: 4,
            isAbstract: false,
          ),
          _HierarchyNode(
            name: 'RestorableDoubleN',
            desc: 'double?',
            level: 4,
            isAbstract: false,
          ),
        ],
      ),
    );
  }

  Widget _buildSerializationSection() {
    return _TheoryCard(
      title: 'Serialization',
      icon: Icons.save,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RestorableNumN serializes directly as a primitive num or null:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          _SerializationExample(
            input: 'value = 42',
            output: '42',
            inputType: 'int',
            outputType: 'num',
          ),
          SizedBox(height: 12),
          _SerializationExample(
            input: 'value = 3.14159',
            output: '3.14159',
            inputType: 'double',
            outputType: 'num',
          ),
          SizedBox(height: 12),
          _SerializationExample(
            input: 'value = null',
            output: 'null',
            inputType: 'null',
            outputType: 'null',
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kWarning.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kWarning.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.warning, color: _kWarning, size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Type preservation: int remains int, double remains double. '
                    'No precision is lost during serialization.',
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

  Widget _buildUseCasesSection() {
    return _TheoryCard(
      title: 'Use Cases',
      icon: Icons.lightbulb,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _UseCaseItem(
            icon: Icons.input,
            title: 'Optional Form Fields',
            desc: 'Age, quantity, or rating that user may not fill',
          ),
          SizedBox(height: 12),
          _UseCaseItem(
            icon: Icons.api,
            title: 'API Response Data',
            desc: 'Numeric fields that may be absent in JSON',
          ),
          SizedBox(height: 12),
          _UseCaseItem(
            icon: Icons.calculate,
            title: 'Computed Results',
            desc: 'Calculation result that may not be computed yet',
          ),
          SizedBox(height: 12),
          _UseCaseItem(
            icon: Icons.settings,
            title: 'Optional Settings',
            desc: 'User preferences with a "not set" state',
          ),
          SizedBox(height: 12),
          _UseCaseItem(
            icon: Icons.psychology,
            title: 'Generic Algorithms',
            desc: 'When the exact numeric type varies dynamically',
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 2: TYPE LAB
// =============================================================================
class _TypeLabTab extends StatefulWidget {
  @override
  State<_TypeLabTab> createState() => _TypeLabTabState();
}

class _TypeLabTabState extends State<_TypeLabTab> {
  final RestorableNumN<num?> _numValue = RestorableNumN<num?>(null);
  String _lastAction = 'Property initialized with null';

  @override
  void dispose() {
    _numValue.dispose();
    super.dispose();
  }

  void _setValue(num? value, String action) {
    setState(() {
      _numValue.value = value;
      _lastAction = action;
    });
  }

  String _getTypeString(num? value) {
    if (value == null) return 'null';
    if (value is int) return 'int';
    if (value is double) return 'double';
    return 'num';
  }

  Color _getTypeColor(num? value) {
    if (value == null) return _kNull;
    if (value is int) return _kInt;
    if (value is double) return _kDouble;
    return _kPrimary;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabHero(),
          SizedBox(height: 20),
          _buildValueDisplay(),
          SizedBox(height: 20),
          _buildTypeIndicator(),
          SizedBox(height: 20),
          _buildIntControls(),
          SizedBox(height: 16),
          _buildDoubleControls(),
          SizedBox(height: 16),
          _buildNullControl(),
          SizedBox(height: 20),
          _buildLastAction(),
          SizedBox(height: 20),
          _buildSerializationPreview(),
          SizedBox(height: 20),
          _buildTypeChecks(),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildLabHero() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kAccent.withOpacity(0.2), _kAccent.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kAccent.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.science, color: _kAccent, size: 28),
              SizedBox(width: 12),
              Text(
                'Type Lab',
                style: TextStyle(
                  color: _kAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Experiment with RestorableNumN<num?> to see how it handles different '
            'numeric types and null. Watch how the type changes dynamically while '
            'the property maintains restoration capability.',
            style: TextStyle(color: _kTextPrimary, fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildValueDisplay() {
    final value = _numValue.value;
    final typeColor = _getTypeColor(value);

    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: typeColor.withOpacity(0.4), width: 2),
      ),
      child: Column(
        children: [
          Text(
            'Current Value',
            style: TextStyle(color: _kTextSecondary, fontSize: 14),
          ),
          SizedBox(height: 12),
          Text(
            value?.toString() ?? 'null',
            style: TextStyle(
              color: typeColor,
              fontSize: 48,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: typeColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _getTypeString(value),
              style: TextStyle(
                color: typeColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeIndicator() {
    final value = _numValue.value;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _TypeBadge(
          label: 'null',
          isActive: value == null,
          color: _kNull,
        ),
        _TypeBadge(
          label: 'int',
          isActive: value is int,
          color: _kInt,
        ),
        _TypeBadge(
          label: 'double',
          isActive: value is double,
          color: _kDouble,
        ),
      ],
    );
  }

  Widget _buildIntControls() {
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
              Icon(Icons.pin, color: _kInt, size: 20),
              SizedBox(width: 8),
              Text(
                'Integer Values',
                style: TextStyle(
                  color: _kInt,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _ValueButton(
                label: '0',
                color: _kInt,
                onTap: () => _setValue(0, 'Set to int: 0'),
              ),
              _ValueButton(
                label: '1',
                color: _kInt,
                onTap: () => _setValue(1, 'Set to int: 1'),
              ),
              _ValueButton(
                label: '42',
                color: _kInt,
                onTap: () => _setValue(42, 'Set to int: 42'),
              ),
              _ValueButton(
                label: '-1',
                color: _kInt,
                onTap: () => _setValue(-1, 'Set to int: -1'),
              ),
              _ValueButton(
                label: '9007199254740991',
                color: _kInt,
                fontSize: 8,
                onTap: () => _setValue(9007199254740991, 'Set to max safe int'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDoubleControls() {
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
              Icon(Icons.more_horiz, color: _kDouble, size: 20),
              SizedBox(width: 8),
              Text(
                'Double Values',
                style: TextStyle(
                  color: _kDouble,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _ValueButton(
                label: '0.0',
                color: _kDouble,
                onTap: () => _setValue(0.0, 'Set to double: 0.0'),
              ),
              _ValueButton(
                label: '3.14',
                color: _kDouble,
                onTap: () => _setValue(3.14159265, 'Set to double: 3.14159265 (pi)'),
              ),
              _ValueButton(
                label: '2.718',
                color: _kDouble,
                onTap: () => _setValue(2.71828, 'Set to double: 2.71828 (e)'),
              ),
              _ValueButton(
                label: '-0.5',
                color: _kDouble,
                onTap: () => _setValue(-0.5, 'Set to double: -0.5'),
              ),
              _ValueButton(
                label: 'infinity',
                color: _kDouble,
                onTap: () => _setValue(double.infinity, 'Set to double.infinity'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNullControl() {
    return GestureDetector(
      onTap: () => _setValue(null, 'Set to null'),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _kNull.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _kNull.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.do_not_disturb, color: _kNull, size: 24),
            SizedBox(width: 12),
            Text(
              'Set to null',
              style: TextStyle(
                color: _kNull,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLastAction() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.history, color: _kTextSecondary, size: 18),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              _lastAction,
              style: TextStyle(color: _kTextSecondary, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSerializationPreview() {
    final value = _numValue.value;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Serialization',
            style: TextStyle(
              color: _kTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _kSurface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'toPrimitives()',
                        style: TextStyle(color: _kTextSecondary, fontSize: 11),
                      ),
                      SizedBox(height: 4),
                      Text(
                        value?.toString() ?? 'null',
                        style: TextStyle(
                          color: _kAccent,
                          fontFamily: 'monospace',
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _kSurface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'fromPrimitives()',
                        style: TextStyle(color: _kTextSecondary, fontSize: 11),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${value?.toString() ?? "null"} as ${_getTypeString(value)}',
                        style: TextStyle(
                          color: _getTypeColor(value),
                          fontFamily: 'monospace',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypeChecks() {
    final value = _numValue.value;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Type Checks',
            style: TextStyle(
              color: _kTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          _TypeCheckRow(expression: 'value == null', result: value == null),
          _TypeCheckRow(expression: 'value is int', result: value is int),
          _TypeCheckRow(expression: 'value is double', result: value is double),
          _TypeCheckRow(expression: 'value is num', result: value is num),
          _TypeCheckRow(expression: '_numValue is RestorableProperty', result: true),
          _TypeCheckRow(expression: '_numValue is RestorableValue', result: true),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 3: COMPARISON
// =============================================================================
class _ComparisonTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildComparisonHero(),
          SizedBox(height: 24),
          _buildNullableVsNonNull(),
          SizedBox(height: 24),
          _buildSubclassComparison(),
          SizedBox(height: 24),
          _buildDecisionGuide(),
          SizedBox(height: 24),
          _buildCodeExamples(),
          SizedBox(height: 24),
          _buildRelatedClasses(),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildComparisonHero() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kPrimary.withOpacity(0.3), _kPrimary.withOpacity(0.1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kPrimary.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.compare, color: _kPrimary, size: 28),
              SizedBox(width: 12),
              Text(
                'Comparison',
                style: TextStyle(
                  color: _kPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Understand how RestorableNumN relates to other restorable numeric types '
            'and when to use each variant.',
            style: TextStyle(color: _kTextPrimary, fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildNullableVsNonNull() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nullable vs Non-Null',
            style: TextStyle(
              color: _kTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _kNull.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _kNull.withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'RestorableNumN',
                        style: TextStyle(
                          color: _kNull,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                        ),
                      ),
                      SizedBox(height: 12),
                      Icon(Icons.question_mark, color: _kNull, size: 32),
                      SizedBox(height: 8),
                      Text(
                        'T extends num?',
                        style: TextStyle(color: _kTextSecondary, fontSize: 11),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'null allowed',
                        style: TextStyle(color: _kNull, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _kSuccess.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _kSuccess.withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'RestorableNum',
                        style: TextStyle(
                          color: _kSuccess,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                        ),
                      ),
                      SizedBox(height: 12),
                      Icon(Icons.check_circle, color: _kSuccess, size: 32),
                      SizedBox(height: 8),
                      Text(
                        'T extends num',
                        style: TextStyle(color: _kTextSecondary, fontSize: 11),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'always has value',
                        style: TextStyle(color: _kSuccess, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubclassComparison() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Subclass Comparison',
            style: TextStyle(
              color: _kTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          _ComparisonRow(
            left: 'RestorableIntN',
            right: 'RestorableInt',
            leftDesc: 'int? (nullable)',
            rightDesc: 'int (required)',
            leftColor: _kNull,
            rightColor: _kInt,
          ),
          SizedBox(height: 12),
          _ComparisonRow(
            left: 'RestorableDoubleN',
            right: 'RestorableDouble',
            leftDesc: 'double? (nullable)',
            rightDesc: 'double (required)',
            leftColor: _kNull,
            rightColor: _kDouble,
          ),
          SizedBox(height: 12),
          _ComparisonRow(
            left: 'RestorableNumN',
            right: 'RestorableNum',
            leftDesc: 'num? (any, nullable)',
            rightDesc: 'num (any, required)',
            leftColor: _kNull,
            rightColor: _kPrimary,
          ),
        ],
      ),
    );
  }

  Widget _buildDecisionGuide() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Decision Guide',
            style: TextStyle(
              color: _kTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          _DecisionItem(
            question: 'Need exact int?',
            yesAnswer: 'RestorableIntN or RestorableInt',
            noAnswer: 'Continue to next question',
            color: _kInt,
          ),
          SizedBox(height: 12),
          _DecisionItem(
            question: 'Need exact double?',
            yesAnswer: 'RestorableDoubleN or RestorableDouble',
            noAnswer: 'Continue to next question',
            color: _kDouble,
          ),
          SizedBox(height: 12),
          _DecisionItem(
            question: 'Type can be int or double?',
            yesAnswer: 'RestorableNumN or RestorableNum',
            noAnswer: 'Consider other Restorable types',
            color: _kPrimary,
          ),
          SizedBox(height: 12),
          _DecisionItem(
            question: 'Value can be absent/null?',
            yesAnswer: 'Use the N-suffix variant',
            noAnswer: 'Use the non-N variant',
            color: _kNull,
          ),
        ],
      ),
    );
  }

  Widget _buildCodeExamples() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Code Examples',
            style: TextStyle(
              color: _kTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          _CodeExample(
            title: 'Optional Score',
            code: 'final RestorableNumN<int?> _score =\n    RestorableNumN<int?>(null);\n\n// Later:\n_score.value = 95;  // int\n_score.value = null; // cleared',
          ),
          SizedBox(height: 12),
          _CodeExample(
            title: 'Generic Number',
            code: 'final RestorableNumN<num?> _amount =\n    RestorableNumN<num?>(0);\n\n// Accepts any numeric:\n_amount.value = 42;     // int\n_amount.value = 3.14;   // double\n_amount.value = null;   // absent',
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedClasses() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Related Classes',
            style: TextStyle(
              color: _kTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _RelatedChip('RestorableNum', 'Non-null parent'),
              _RelatedChip('RestorableIntN', 'int? child'),
              _RelatedChip('RestorableDoubleN', 'double? child'),
              _RelatedChip('RestorableInt', 'int non-null'),
              _RelatedChip('RestorableDouble', 'double non-null'),
              _RelatedChip('RestorableValue', 'Base class'),
              _RelatedChip('RestorableBoolN', 'Nullable bool'),
              _RelatedChip('RestorableStringN', 'Nullable string'),
            ],
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// HELPER WIDGETS
// =============================================================================

class _HeroBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  const _HeroBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 14),
          SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _TheoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  const _TheoryCard({required this.title, required this.icon, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
              Icon(icon, color: _kAccent, size: 20),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  color: _kTextPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _TypeHierarchyNode extends StatelessWidget {
  final String name;
  final Color color;
  final int indent;
  final bool isHighlighted;
  const _TypeHierarchyNode({
    required this.name,
    required this.color,
    required this.indent,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: indent * 20.0, top: 4, bottom: 4),
      child: Row(
        children: [
          if (indent > 0) ...[
            Container(
              width: 12,
              height: 2,
              color: _kDivider,
            ),
            SizedBox(width: 4),
          ],
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: isHighlighted ? color.withOpacity(0.2) : _kCardBg,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: isHighlighted ? color : _kDivider,
              ),
            ),
            child: Text(
              name,
              style: TextStyle(
                color: color,
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TypeUsageRow extends StatelessWidget {
  final String code;
  final String desc;
  final Color color;
  const _TypeUsageRow({required this.code, required this.desc, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              code,
              style: TextStyle(
                color: color,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
          SizedBox(width: 8),
          Text(
            desc,
            style: TextStyle(color: _kTextSecondary, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _HierarchyNode extends StatelessWidget {
  final String name;
  final String desc;
  final int level;
  final bool isAbstract;
  final bool isPrivate;
  final bool isHighlighted;
  const _HierarchyNode({
    required this.name,
    required this.desc,
    required this.level,
    required this.isAbstract,
    this.isPrivate = false,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: level * 12.0, top: 6, bottom: 6),
      child: Row(
        children: [
          if (level > 0) ...[
            Container(width: 12, height: 2, color: _kDivider),
          ],
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: isHighlighted ? _kAccent.withOpacity(0.2) : _kSurface,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: isHighlighted ? _kAccent : _kDivider,
                width: isHighlighted ? 2 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isAbstract)
                  Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: Text(
                      'abstract',
                      style: TextStyle(
                        color: _kWarning,
                        fontSize: 8,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                if (isPrivate)
                  Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: Text(
                      'private',
                      style: TextStyle(
                        color: _kTextSecondary,
                        fontSize: 8,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                Text(
                  name,
                  style: TextStyle(
                    color: isHighlighted ? _kAccent : _kTextPrimary,
                    fontFamily: 'monospace',
                    fontSize: 10,
                    fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          Text(
            desc,
            style: TextStyle(color: _kTextSecondary, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class _SerializationExample extends StatelessWidget {
  final String input;
  final String output;
  final String inputType;
  final String outputType;
  const _SerializationExample({
    required this.input,
    required this.output,
    required this.inputType,
    required this.outputType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  input,
                  style: TextStyle(
                    color: _kTextPrimary,
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
                Text(
                  inputType,
                  style: TextStyle(color: _kTextSecondary, fontSize: 9),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward, color: _kDivider, size: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  output,
                  style: TextStyle(
                    color: _kAccent,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  outputType,
                  style: TextStyle(color: _kTextSecondary, fontSize: 9),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kPrimary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _kPrimary, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: _kTextPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 2),
              Text(
                desc,
                style: TextStyle(color: _kTextSecondary, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TypeBadge extends StatelessWidget {
  final String label;
  final bool isActive;
  final Color color;
  const _TypeBadge({required this.label, required this.isActive, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isActive ? color.withOpacity(0.2) : _kSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive ? color : _kDivider,
          width: isActive ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            isActive ? Icons.check_circle : Icons.circle_outlined,
            color: isActive ? color : _kTextSecondary,
            size: 20,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? color : _kTextSecondary,
              fontSize: 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class _ValueButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;
  final double fontSize;
  const _ValueButton({
    required this.label,
    required this.color,
    required this.onTap,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: fontSize,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _TypeCheckRow extends StatelessWidget {
  final String expression;
  final bool result;
  const _TypeCheckRow({required this.expression, required this.result});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              expression,
              style: TextStyle(
                color: _kTextPrimary,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: result ? _kSuccess.withOpacity(0.2) : _kWarning.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              result ? 'true' : 'false',
              style: TextStyle(
                color: result ? _kSuccess : _kWarning,
                fontSize: 10,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ComparisonRow extends StatelessWidget {
  final String left;
  final String right;
  final String leftDesc;
  final String rightDesc;
  final Color leftColor;
  final Color rightColor;
  const _ComparisonRow({
    required this.left,
    required this.right,
    required this.leftDesc,
    required this.rightDesc,
    required this.leftColor,
    required this.rightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  left,
                  style: TextStyle(
                    color: leftColor,
                    fontFamily: 'monospace',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(leftDesc, style: TextStyle(color: _kTextSecondary, fontSize: 9)),
              ],
            ),
          ),
          Text('vs', style: TextStyle(color: _kDivider, fontSize: 11)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  right,
                  style: TextStyle(
                    color: rightColor,
                    fontFamily: 'monospace',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(rightDesc, style: TextStyle(color: _kTextSecondary, fontSize: 9)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DecisionItem extends StatelessWidget {
  final String question;
  final String yesAnswer;
  final String noAnswer;
  final Color color;
  const _DecisionItem({
    required this.question,
    required this.yesAnswer,
    required this.noAnswer,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _kSuccess.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Yes',
                  style: TextStyle(color: _kSuccess, fontSize: 9),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  yesAnswer,
                  style: TextStyle(color: _kTextPrimary, fontSize: 10),
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _kWarning.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'No',
                  style: TextStyle(color: _kWarning, fontSize: 9),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  noAnswer,
                  style: TextStyle(color: _kTextSecondary, fontSize: 10),
                ),
              ),
            ],
          ),
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
        Text(
          title,
          style: TextStyle(color: _kTextSecondary, fontSize: 12),
        ),
        SizedBox(height: 6),
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

class _RelatedChip extends StatelessWidget {
  final String name;
  final String role;
  const _RelatedChip(this.name, this.role);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kDivider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: TextStyle(
              color: _kTextPrimary,
              fontFamily: 'monospace',
              fontSize: 10,
            ),
          ),
          SizedBox(width: 6),
          Text(
            '($role)',
            style: TextStyle(color: _kTextSecondary, fontSize: 9),
          ),
        ],
      ),
    );
  }
}
