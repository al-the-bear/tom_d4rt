// Deep visual test for RestorableNum
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, unintended_html_in_doc_comment

import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Deep visual exploration of RestorableNum
/// A restorable property for non-nullable numeric values (int or double).
///
/// RestorableNum<T extends num> provides:
/// - Always-valid numeric storage (never null)
/// - Parent class for RestorableInt and RestorableDouble
/// - Restoration of numeric state across app restarts
///
/// Perfect when you need a required numeric field that persists.
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF1A1A2E),
    ),
    home: _RestorableNumDemo(),
  );
}

// =============================================================================
// PALETTE: Green 700 / Purple A200
// =============================================================================
const Color _kPrimary = Color(0xFF388E3C); // Green 700
const Color _kAccent = Color(0xFFE040FB); // Purple A200
const Color _kSurface = Color(0xFF252542);
const Color _kCardBg = Color(0xFF2D2D4A);
const Color _kTextPrimary = Color(0xFFE8E8F0);
const Color _kTextSecondary = Color(0xFFB0B0C8);
const Color _kDivider = Color(0xFF3A3A5C);
const Color _kSuccess = Color(0xFF66BB6A);
const Color _kWarning = Color(0xFFFF7043);
const Color _kInt = Color(0xFF42A5F5);
const Color _kDouble = Color(0xFFEC407A);
const Color _kMath = Color(0xFF26C6DA);

// =============================================================================
// MAIN DEMO WIDGET
// =============================================================================
class _RestorableNumDemo extends StatefulWidget {
  @override
  State<_RestorableNumDemo> createState() => _RestorableNumDemoState();
}

class _RestorableNumDemoState extends State<_RestorableNumDemo>
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
        title: Text('RestorableNum Deep Dive'),
        backgroundColor: _kPrimary,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kTextSecondary,
          tabs: [
            Tab(icon: Icon(Icons.school), text: 'Theory'),
            Tab(icon: Icon(Icons.functions), text: 'Math Lab'),
            Tab(icon: Icon(Icons.account_tree), text: 'Family Tree'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TheoryTab(),
          _MathLabTab(),
          _FamilyTreeTab(),
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
          _buildNonNullGuarantee(),
          SizedBox(height: 24),
          _buildNumTypeSection(),
          SizedBox(height: 24),
          _buildSubclassesSection(),
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
              Icon(Icons.numbers, color: _kAccent, size: 32),
              SizedBox(width: 12),
              Text(
                'RestorableNum<T>',
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
            'A restorable property for non-nullable numeric values. Always contains '
            'a valid number—either int or double. Parent class for RestorableInt '
            'and RestorableDouble.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 15,
              height: 1.5,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _HeroBadge(icon: Icons.check_circle, label: 'Non-null'),
              SizedBox(width: 12),
              _HeroBadge(icon: Icons.numbers, label: 'num'),
              SizedBox(width: 12),
              _HeroBadge(icon: Icons.account_tree, label: 'Parent'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNonNullGuarantee() {
    return _TheoryCard(
      title: 'Non-Null Guarantee',
      icon: Icons.check_circle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Unlike RestorableNumN, RestorableNum guarantees a value at all times:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          Row(
            children: [
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
                      Icon(Icons.check_circle, color: _kSuccess, size: 32),
                      SizedBox(height: 8),
                      Text(
                        'RestorableNum',
                        style: TextStyle(
                          color: _kSuccess,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'T extends num\n(always valid)',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: _kTextSecondary, fontSize: 10),
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
                    color: _kWarning.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _kWarning.withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.question_mark, color: _kWarning, size: 32),
                      SizedBox(height: 8),
                      Text(
                        'RestorableNumN',
                        style: TextStyle(
                          color: _kWarning,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'T extends num?\n(may be null)',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: _kTextSecondary, fontSize: 10),
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
              color: _kSuccess.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.verified, color: _kSuccess, size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'No null checks needed when accessing value!',
                    style: TextStyle(color: _kTextPrimary, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumTypeSection() {
    return _TheoryCard(
      title: 'Dart\'s num Type',
      icon: Icons.code,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The num type is the common supertype of int and double:',
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
                _TypeNode(name: 'num', color: _kPrimary, isHighlighted: true),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 1, height: 20, color: _kDivider),
                    SizedBox(width: 60),
                    Container(width: 1, height: 20, color: _kDivider),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _TypeNode(name: 'int', color: _kInt),
                    _TypeNode(name: 'double', color: _kDouble),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Key num operations:',
            style: TextStyle(color: _kTextSecondary, fontSize: 13),
          ),
          SizedBox(height: 12),
          _OperationRow(op: '+, -, *, /', desc: 'Arithmetic'),
          SizedBox(height: 6),
          _OperationRow(op: 'abs(), sign', desc: 'Magnitude'),
          SizedBox(height: 6),
          _OperationRow(op: 'toInt(), toDouble()', desc: 'Conversion'),
          SizedBox(height: 6),
          _OperationRow(op: 'compareTo()', desc: 'Comparison'),
        ],
      ),
    );
  }

  Widget _buildSubclassesSection() {
    return _TheoryCard(
      title: 'Concrete Subclasses',
      icon: Icons.account_tree,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RestorableNum has two specialized subclasses:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          _SubclassCard(
            name: 'RestorableInt',
            icon: Icons.pin,
            color: _kInt,
            desc: 'For integers only (counts, IDs, indices)',
            example: 'RestorableInt(0)',
          ),
          SizedBox(height: 12),
          _SubclassCard(
            name: 'RestorableDouble',
            icon: Icons.percent,
            color: _kDouble,
            desc: 'For decimals only (ratios, amounts, precision)',
            example: 'RestorableDouble(0.0)',
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kMath.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.recommend, color: _kMath, size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Prefer specialized subclasses when the type is known.',
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

  Widget _buildSerializationSection() {
    return _TheoryCard(
      title: 'Serialization',
      icon: Icons.save,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RestorableNum serializes directly to the primitive value:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          _SerializationRow(input: 'int value = 42', output: '42'),
          SizedBox(height: 8),
          _SerializationRow(input: 'double value = 3.14', output: '3.14'),
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
                  'Type Preservation:',
                  style: TextStyle(color: _kAccent, fontWeight: FontWeight.bold, fontSize: 12),
                ),
                SizedBox(height: 8),
                Text(
                  'int serializes as int, double as double. '
                  'Type is preserved through the restoration cycle.',
                  style: TextStyle(color: _kTextPrimary, fontSize: 12, height: 1.4),
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
            icon: Icons.score,
            title: 'Score/Points',
            desc: 'Game scores that must exist',
          ),
          SizedBox(height: 12),
          _UseCaseItem(
            icon: Icons.settings,
            title: 'Required Settings',
            desc: 'Volume, brightness, difficulty level',
          ),
          SizedBox(height: 12),
          _UseCaseItem(
            icon: Icons.timer,
            title: 'Progress/Position',
            desc: 'Seek position, scroll offset, progress bar',
          ),
          SizedBox(height: 12),
          _UseCaseItem(
            icon: Icons.calculate,
            title: 'Generic Math',
            desc: 'When type (int vs double) varies at runtime',
          ),
          SizedBox(height: 12),
          _UseCaseItem(
            icon: Icons.star,
            title: 'Ratings',
            desc: 'Star ratings, review scores',
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 2: MATH LAB
// =============================================================================
class _MathLabTab extends StatefulWidget {
  @override
  State<_MathLabTab> createState() => _MathLabTabState();
}

class _MathLabTabState extends State<_MathLabTab> {
  final RestorableNum<num> _numValue = RestorableNum<num>(0);
  String _lastOperation = 'Initialized with 0';

  @override
  void dispose() {
    _numValue.dispose();
    super.dispose();
  }

  void _setValue(num value, String operation) {
    setState(() {
      _numValue.value = value;
      _lastOperation = operation;
    });
  }

  void _applyOperation(String opName, num Function(num) op) {
    final oldValue = _numValue.value;
    final newValue = op(oldValue);
    _setValue(newValue, '$opName: $oldValue → $newValue');
  }

  String _getTypeString(num value) {
    if (value is int) return 'int';
    return 'double';
  }

  Color _getTypeColor(num value) {
    if (value is int) return _kInt;
    return _kDouble;
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
          _buildMathConstants(),
          SizedBox(height: 16),
          _buildBasicOperations(),
          SizedBox(height: 16),
          _buildAdvancedOperations(),
          SizedBox(height: 16),
          _buildTypeConversions(),
          SizedBox(height: 20),
          _buildLastOperation(),
          SizedBox(height: 20),
          _buildPropertyInfo(),
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
              Icon(Icons.functions, color: _kAccent, size: 28),
              SizedBox(width: 12),
              Text(
                'Math Lab',
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
            'Experiment with RestorableNum<num> using mathematical operations. '
            'Watch how the type changes between int and double based on operations.',
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
            value.toString(),
            style: TextStyle(
              color: typeColor,
              fontSize: 48,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: typeColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getTypeString(value),
                  style: TextStyle(color: typeColor, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: _kPrimary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'RestorableNum<num>',
                  style: TextStyle(color: _kPrimary, fontFamily: 'monospace', fontSize: 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMathConstants() {
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
              Icon(Icons.auto_awesome, color: _kMath, size: 20),
              SizedBox(width: 8),
              Text(
                'Math Constants',
                style: TextStyle(
                  color: _kMath,
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
              _MathButton(
                label: 'π',
                color: _kDouble,
                onTap: () => _setValue(math.pi, 'Set to π (3.14159...)'),
              ),
              _MathButton(
                label: 'e',
                color: _kDouble,
                onTap: () => _setValue(math.e, 'Set to e (2.71828...)'),
              ),
              _MathButton(
                label: '√2',
                color: _kDouble,
                onTap: () => _setValue(math.sqrt2, 'Set to √2 (1.41421...)'),
              ),
              _MathButton(
                label: 'ln2',
                color: _kDouble,
                onTap: () => _setValue(math.ln2, 'Set to ln(2) (0.69314...)'),
              ),
              _MathButton(
                label: '0',
                color: _kInt,
                onTap: () => _setValue(0, 'Set to 0 (int)'),
              ),
              _MathButton(
                label: '1',
                color: _kInt,
                onTap: () => _setValue(1, 'Set to 1 (int)'),
              ),
              _MathButton(
                label: '100',
                color: _kInt,
                onTap: () => _setValue(100, 'Set to 100 (int)'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBasicOperations() {
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
            'Basic Operations',
            style: TextStyle(
              color: _kTextPrimary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _OpButton(
                label: '+1',
                color: _kSuccess,
                onTap: () => _applyOperation('+1', (n) => n + 1),
              ),
              _OpButton(
                label: '-1',
                color: _kWarning,
                onTap: () => _applyOperation('-1', (n) => n - 1),
              ),
              _OpButton(
                label: '×2',
                color: _kInt,
                onTap: () => _applyOperation('×2', (n) => n * 2),
              ),
              _OpButton(
                label: '÷2',
                color: _kDouble,
                onTap: () => _applyOperation('÷2', (n) => n / 2),
              ),
              _OpButton(
                label: 'neg',
                color: _kAccent,
                onTap: () => _applyOperation('negate', (n) => -n),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedOperations() {
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
            'Advanced Operations',
            style: TextStyle(
              color: _kTextPrimary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _OpButton(
                label: 'abs',
                color: _kPrimary,
                onTap: () => _applyOperation('abs', (n) => n.abs()),
              ),
              _OpButton(
                label: 'sqrt',
                color: _kDouble,
                onTap: () => _applyOperation('sqrt', (n) => math.sqrt(n.abs())),
              ),
              _OpButton(
                label: 'x²',
                color: _kMath,
                onTap: () => _applyOperation('square', (n) => n * n),
              ),
              _OpButton(
                label: 'sin',
                color: _kDouble,
                onTap: () => _applyOperation('sin', (n) => math.sin(n)),
              ),
              _OpButton(
                label: 'cos',
                color: _kDouble,
                onTap: () => _applyOperation('cos', (n) => math.cos(n)),
              ),
              _OpButton(
                label: 'ln',
                color: _kDouble,
                onTap: () => _applyOperation('ln', (n) => math.log(n.abs() + 1)),
              ),
              _OpButton(
                label: 'exp',
                color: _kDouble,
                onTap: () => _applyOperation('exp', (n) => math.exp(n > 20 ? 20 : n)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypeConversions() {
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
            'Type Conversions',
            style: TextStyle(
              color: _kTextPrimary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    final oldVal = _numValue.value;
                    final newVal = oldVal.toInt();
                    _setValue(newVal, 'toInt(): $oldVal → $newVal');
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _kInt.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _kInt.withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.arrow_forward, color: _kInt),
                        SizedBox(height: 4),
                        Text(
                          'toInt()',
                          style: TextStyle(
                            color: _kInt,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          'Truncate to int',
                          style: TextStyle(color: _kTextSecondary, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    final oldVal = _numValue.value;
                    final newVal = oldVal.toDouble();
                    _setValue(newVal, 'toDouble(): $oldVal → $newVal');
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _kDouble.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _kDouble.withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.arrow_forward, color: _kDouble),
                        SizedBox(height: 4),
                        Text(
                          'toDouble()',
                          style: TextStyle(
                            color: _kDouble,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          'Convert to double',
                          style: TextStyle(color: _kTextSecondary, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    final oldVal = _numValue.value;
                    final newVal = oldVal.round();
                    _setValue(newVal, 'round(): $oldVal → $newVal');
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _kSuccess.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _kSuccess.withOpacity(0.3)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.arrow_forward, color: _kSuccess),
                        SizedBox(height: 4),
                        Text(
                          'round()',
                          style: TextStyle(
                            color: _kSuccess,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          'Round to int',
                          style: TextStyle(color: _kTextSecondary, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLastOperation() {
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
              _lastOperation,
              style: TextStyle(color: _kTextSecondary, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyInfo() {
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
            'Property Info',
            style: TextStyle(
              color: _kTextPrimary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          _InfoRow(label: 'value.runtimeType', value: '${value.runtimeType}'),
          _InfoRow(label: 'value.isFinite', value: '${value.isFinite}'),
          _InfoRow(label: 'value.isNaN', value: '${value.isNaN}'),
          _InfoRow(label: 'value.sign', value: '${value.sign}'),
          _InfoRow(label: 'value.isNegative', value: '${value.isNegative}'),
          _InfoRow(label: '_numValue is RestorableProperty', value: 'true'),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 3: FAMILY TREE
// =============================================================================
class _FamilyTreeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFamilyHero(),
          SizedBox(height: 24),
          _buildFullHierarchy(),
          SizedBox(height: 24),
          _buildNullableVsNonNull(),
          SizedBox(height: 24),
          _buildSubclassDetails(),
          SizedBox(height: 24),
          _buildDecisionTree(),
          SizedBox(height: 24),
          _buildRelatedClasses(),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildFamilyHero() {
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
              Icon(Icons.account_tree, color: _kPrimary, size: 28),
              SizedBox(width: 12),
              Text(
                'Family Tree',
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
            'Explore how RestorableNum fits into Flutter\'s restoration hierarchy '
            'and understand its relationship with specialized subclasses.',
            style: TextStyle(color: _kTextPrimary, fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildFullHierarchy() {
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
            'Inheritance Chain',
            style: TextStyle(
              color: _kTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          _HierarchyNode(name: 'RestorableProperty<T>', desc: 'Root', level: 0, isAbstract: true),
          _HierarchyNode(name: 'RestorableValue<T>', desc: 'Value management', level: 1, isAbstract: true),
          _HierarchyNode(name: '_RestorablePrimitiveValueN<T>', desc: 'Nullable', level: 2, isAbstract: true, isPrivate: true),
          _HierarchyNode(name: '_RestorablePrimitiveValue<T>', desc: 'Non-null', level: 3, isAbstract: true, isPrivate: true),
          _HierarchyNode(name: 'RestorableNum<T>', desc: 'Numeric', level: 4, isHighlighted: true),
          _HierarchyNode(name: 'RestorableInt', desc: 'int', level: 5, isAbstract: false),
          _HierarchyNode(name: 'RestorableDouble', desc: 'double', level: 5, isAbstract: false),
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
            'Nullable vs Non-Null Branches',
            style: TextStyle(
              color: _kTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Non-Null (N-less)',
                        style: TextStyle(color: _kSuccess, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      SizedBox(height: 8),
                      _BranchItem(name: 'RestorableNum', color: _kSuccess),
                      _BranchItem(name: 'RestorableInt', color: _kInt),
                      _BranchItem(name: 'RestorableDouble', color: _kDouble),
                    ],
                  ),
                ),
                Container(width: 1, height: 100, color: _kDivider),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Nullable (N-suffix)',
                        style: TextStyle(color: _kWarning, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      SizedBox(height: 8),
                      _BranchItem(name: 'RestorableNumN', color: _kWarning),
                      _BranchItem(name: 'RestorableIntN', color: _kWarning),
                      _BranchItem(name: 'RestorableDoubleN', color: _kWarning),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubclassDetails() {
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
            'Subclass Details',
            style: TextStyle(
              color: _kTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          _DetailedSubclass(
            name: 'RestorableInt',
            typeParam: 'int',
            constructor: 'RestorableInt(int defaultValue)',
            example: 'final _count = RestorableInt(0);',
            color: _kInt,
          ),
          SizedBox(height: 12),
          _DetailedSubclass(
            name: 'RestorableDouble',
            typeParam: 'double',
            constructor: 'RestorableDouble(double defaultValue)',
            example: 'final _rating = RestorableDouble(5.0);',
            color: _kDouble,
          ),
        ],
      ),
    );
  }

  Widget _buildDecisionTree() {
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
            'Which One to Use?',
            style: TextStyle(
              color: _kTextPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          _DecisionStep(
            question: 'Is type always int?',
            yesPath: 'RestorableInt',
            noPath: 'Continue',
            yesColor: _kInt,
          ),
          SizedBox(height: 8),
          _DecisionStep(
            question: 'Is type always double?',
            yesPath: 'RestorableDouble',
            noPath: 'Continue',
            yesColor: _kDouble,
          ),
          SizedBox(height: 8),
          _DecisionStep(
            question: 'Could be int or double?',
            yesPath: 'RestorableNum<num>',
            noPath: 'Check nullable',
            yesColor: _kPrimary,
          ),
          SizedBox(height: 8),
          _DecisionStep(
            question: 'Can be null?',
            yesPath: 'Use N-suffix variant',
            noPath: 'Use non-N variant',
            yesColor: _kWarning,
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
              _RelatedChip('RestorableNumN', 'Nullable version'),
              _RelatedChip('RestorableInt', 'Child: int'),
              _RelatedChip('RestorableDouble', 'Child: double'),
              _RelatedChip('RestorableIntN', 'Nullable int'),
              _RelatedChip('RestorableDoubleN', 'Nullable double'),
              _RelatedChip('RestorableValue', 'Parent class'),
              _RelatedChip('RestorableProperty', 'Root class'),
              _RelatedChip('RestorationMixin', 'Consumer'),
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
          Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
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
                style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
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

class _TypeNode extends StatelessWidget {
  final String name;
  final Color color;
  final bool isHighlighted;
  const _TypeNode({required this.name, required this.color, this.isHighlighted = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isHighlighted ? color.withOpacity(0.2) : _kCardBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: isHighlighted ? 2 : 1),
      ),
      child: Text(
        name,
        style: TextStyle(
          color: color,
          fontFamily: 'monospace',
          fontSize: 14,
          fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

class _OperationRow extends StatelessWidget {
  final String op;
  final String desc;
  const _OperationRow({required this.op, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _kSurface,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            op,
            style: TextStyle(color: _kAccent, fontFamily: 'monospace', fontSize: 11),
          ),
        ),
        SizedBox(width: 12),
        Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 12)),
      ],
    );
  }
}

class _SubclassCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;
  final String desc;
  final String example;
  const _SubclassCard({
    required this.name,
    required this.icon,
    required this.color,
    required this.desc,
    required this.example,
  });

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
          Icon(icon, color: color, size: 28),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13),
                ),
                SizedBox(height: 2),
                Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 11)),
                SizedBox(height: 4),
                Text(
                  example,
                  style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SerializationRow extends StatelessWidget {
  final String input;
  final String output;
  const _SerializationRow({required this.input, required this.output});

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
              input,
              style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 11),
            ),
          ),
          Icon(Icons.arrow_forward, color: _kDivider, size: 16),
          SizedBox(width: 8),
          Text(
            output,
            style: TextStyle(color: _kAccent, fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.bold),
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
              Text(title, style: TextStyle(color: _kTextPrimary, fontWeight: FontWeight.w600, fontSize: 14)),
              SizedBox(height: 2),
              Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}

class _MathButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _MathButton({required this.label, required this.color, required this.onTap});

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
          style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _OpButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _OpButton({required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.4)),
        ),
        child: Text(
          label,
          style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: _kTextSecondary, fontFamily: 'monospace', fontSize: 10),
            ),
          ),
          Text(
            value,
            style: TextStyle(color: _kAccent, fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.bold),
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
    this.isAbstract = false,
    this.isPrivate = false,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: level * 12.0, top: 5, bottom: 5),
      child: Row(
        children: [
          if (level > 0) Container(width: 10, height: 2, color: _kDivider),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isHighlighted ? _kPrimary.withOpacity(0.2) : _kSurface,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: isHighlighted ? _kPrimary : _kDivider,
                width: isHighlighted ? 2 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isAbstract)
                  Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: Text('abstract', style: TextStyle(color: _kWarning, fontSize: 7, fontStyle: FontStyle.italic)),
                  ),
                if (isPrivate)
                  Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: Text('private', style: TextStyle(color: _kTextSecondary, fontSize: 7, fontStyle: FontStyle.italic)),
                  ),
                Text(
                  name,
                  style: TextStyle(
                    color: isHighlighted ? _kPrimary : _kTextPrimary,
                    fontFamily: 'monospace',
                    fontSize: 9,
                    fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 6),
          Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 9)),
        ],
      ),
    );
  }
}

class _BranchItem extends StatelessWidget {
  final String name;
  final Color color;
  const _BranchItem({required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Text(
        name,
        style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 10),
      ),
    );
  }
}

class _DetailedSubclass extends StatelessWidget {
  final String name;
  final String typeParam;
  final String constructor;
  final String example;
  final Color color;
  const _DetailedSubclass({
    required this.name,
    required this.typeParam,
    required this.constructor,
    required this.example,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                name,
                style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13),
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _kSurface,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(typeParam, style: TextStyle(color: _kTextSecondary, fontSize: 9)),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(constructor, style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 10)),
          SizedBox(height: 4),
          Text(example, style: TextStyle(color: _kTextSecondary, fontFamily: 'monospace', fontSize: 9)),
        ],
      ),
    );
  }
}

class _DecisionStep extends StatelessWidget {
  final String question;
  final String yesPath;
  final String noPath;
  final Color yesColor;
  const _DecisionStep({
    required this.question,
    required this.yesPath,
    required this.noPath,
    required this.yesColor,
  });

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
            flex: 2,
            child: Text(question, style: TextStyle(color: _kTextPrimary, fontSize: 11)),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _kSuccess.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text('Y', style: TextStyle(color: _kSuccess, fontSize: 9, fontWeight: FontWeight.bold)),
              ),
              SizedBox(width: 4),
              Text(yesPath, style: TextStyle(color: yesColor, fontSize: 9, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(width: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _kWarning.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text('N', style: TextStyle(color: _kWarning, fontSize: 9, fontWeight: FontWeight.bold)),
              ),
              SizedBox(width: 4),
              Text(noPath, style: TextStyle(color: _kTextSecondary, fontSize: 9)),
            ],
          ),
        ],
      ),
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
          Text(name, style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 10)),
          SizedBox(width: 6),
          Text('($role)', style: TextStyle(color: _kTextSecondary, fontSize: 9)),
        ],
      ),
    );
  }
}
