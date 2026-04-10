// Deep visual test for RestorableBoolN
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';

/// Deep visual exploration of RestorableBoolN
/// A restorable property that holds a nullable boolean value.
///
/// RestorableBoolN is used for state restoration with three possible states:
/// - null: Unknown, unset, or indeterminate
/// - true: Explicitly true
/// - false: Explicitly false
///
/// Common use case: Tristate checkboxes in partial selection scenarios.
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF1A1A2E),
    ),
    home: _RestorableBoolNDemo(),
  );
}

// =============================================================================
// PALETTE: Teal 700 / Pink 400
// =============================================================================
const Color _kPrimary = Color(0xFF00796B); // Teal 700
const Color _kAccent = Color(0xFFEC407A); // Pink 400
const Color _kSurface = Color(0xFF252542);
const Color _kCardBg = Color(0xFF2D2D4A);
const Color _kTextPrimary = Color(0xFFE8E8F0);
const Color _kTextSecondary = Color(0xFFB0B0C8);
const Color _kDivider = Color(0xFF3A3A5C);
const Color _kTrue = Color(0xFF66BB6A);
const Color _kFalse = Color(0xFFEF5350);
const Color _kNull = Color(0xFFFFCA28);

// =============================================================================
// MAIN DEMO WIDGET
// =============================================================================
class _RestorableBoolNDemo extends StatefulWidget {
  @override
  State<_RestorableBoolNDemo> createState() => _RestorableBoolNDemoState();
}

class _RestorableBoolNDemoState extends State<_RestorableBoolNDemo>
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
        title: Text('RestorableBoolN Deep Dive'),
        backgroundColor: _kPrimary,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kTextSecondary,
          tabs: [
            Tab(icon: Icon(Icons.school), text: 'Theory'),
            Tab(icon: Icon(Icons.check_box), text: 'Tristate Lab'),
            Tab(icon: Icon(Icons.restore), text: 'Persistence'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TheoryTab(),
          _TristateLabTab(),
          _PersistenceTab(),
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
          _buildThreeStatesSection(),
          SizedBox(height: 24),
          _buildClassHierarchySection(),
          SizedBox(height: 24),
          _buildConstructorSection(),
          SizedBox(height: 24),
          _buildUsageSection(),
          SizedBox(height: 24),
          _buildComparisonSection(),
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
              Icon(Icons.help_outline, color: _kAccent, size: 32),
              SizedBox(width: 12),
              Text(
                'RestorableBoolN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'A restorable property for nullable boolean values. Unlike RestorableBool '
            'which only supports true/false, RestorableBoolN adds a third state: null.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 15,
              height: 1.5,
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _kNull,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'TRISTATE',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Perfect for indeterminate checkboxes and optional selections',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThreeStatesSection() {
    return _TheoryCard(
      title: 'The Three States',
      icon: Icons.view_in_ar,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RestorableBoolN can hold three distinct states, each with semantic meaning:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _StateCard(
                  value: 'null',
                  color: _kNull,
                  icon: Icons.help_outline,
                  meaning: 'Unknown',
                  description: 'Value not set, indeterminate, or partially selected',
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _StateCard(
                  value: 'true',
                  color: _kTrue,
                  icon: Icons.check_circle,
                  meaning: 'True',
                  description: 'Explicitly set to true, selected, enabled',
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _StateCard(
                  value: 'false',
                  color: _kFalse,
                  icon: Icons.cancel,
                  meaning: 'False',
                  description: 'Explicitly set to false, deselected, disabled',
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
                Icon(Icons.info_outline, color: _kAccent, size: 18),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Key insight: null !== false. When null represents "not yet decided", '
                    'false explicitly means "decided to be false".',
                    style: TextStyle(color: _kTextSecondary, fontSize: 12),
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
                _HierarchyItem(level: 0, name: 'RestorableProperty<T>', desc: 'Base restoration'),
                _HierarchyItem(level: 1, name: 'RestorableValue<T>', desc: 'Value holder'),
                _HierarchyItem(level: 2, name: '_RestorablePrimitiveValueN<T?>', desc: 'Nullable primitive'),
                _HierarchyItem(level: 3, name: 'RestorableBoolN', desc: 'Nullable bool', isHighlighted: true),
              ],
            ),
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _RelatedChip('RestorableBool', 'Non-null'),
              _RelatedChip('RestorableIntN', 'Nullable int'),
              _RelatedChip('RestorableDoubleN', 'Nullable double'),
              _RelatedChip('RestorableStringN', 'Nullable string'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConstructorSection() {
    return _TheoryCard(
      title: 'Constructor',
      icon: Icons.build,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kAccent.withOpacity(0.3)),
            ),
            child: Text(
              'RestorableBoolN(bool? defaultValue)',
              style: TextStyle(
                color: _kAccent,
                fontFamily: 'monospace',
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'The defaultValue can be null, true, or false. This becomes the initial '
            'value before any restoration occurs.',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 12),
          _CodeExample(
            title: 'Examples:',
            code: '''// Start with unknown state
final tristate = RestorableBoolN(null);

// Start with known value
final accepted = RestorableBoolN(true);
final declined = RestorableBoolN(false);''',
          ),
        ],
      ),
    );
  }

  Widget _buildUsageSection() {
    return _TheoryCard(
      title: 'Usage with RestorationMixin',
      icon: Icons.code,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Register the property in your StatefulWidget for automatic state persistence:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 12),
          _CodeExample(
            title: 'Complete pattern:',
            code: '''class _MyState extends State<MyWidget>
    with RestorationMixin {
  
  final _agreedToTerms = RestorableBoolN(null);
  
  @override
  String? get restorationId => 'my_widget';
  
  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_agreedToTerms, 'agreed_to_terms');
  }
  
  @override
  void dispose() {
    _agreedToTerms.dispose();
    super.dispose();
  }
}''',
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonSection() {
    return _TheoryCard(
      title: 'RestorableBoolN vs RestorableBool',
      icon: Icons.compare_arrows,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ComparisonRow(feature: 'Type', boolN: 'bool?', boolReg: 'bool'),
          _ComparisonRow(feature: 'States', boolN: 'null, true, false', boolReg: 'true, false'),
          _ComparisonRow(feature: 'Default', boolN: 'Can be null', boolReg: 'Must be non-null'),
          _ComparisonRow(feature: 'Use case', boolN: 'Tristate checkbox', boolReg: 'Binary toggle'),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kPrimary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kPrimary.withOpacity(0.3)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lightbulb_outline, color: _kAccent, size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Use RestorableBoolN when "no selection" is semantically different '
                    'from "false". Common scenarios: survey responses, partial selection, '
                    'user consent forms with "not yet answered" state.',
                    style: TextStyle(color: _kTextPrimary, fontSize: 13, height: 1.5),
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

class _StateCard extends StatelessWidget {
  final String value;
  final Color color;
  final IconData icon;
  final String meaning;
  final String description;

  const _StateCard({
    required this.value,
    required this.color,
    required this.icon,
    required this.meaning,
    required this.description,
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
        children: [
          Icon(icon, color: color, size: 28),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            meaning,
            style: TextStyle(color: _kTextPrimary, fontWeight: FontWeight.w500, fontSize: 12),
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(color: _kTextSecondary, fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ComparisonRow extends StatelessWidget {
  final String feature;
  final String boolN;
  final String boolReg;

  const _ComparisonRow({
    required this.feature,
    required this.boolN,
    required this.boolReg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: _kDivider.withOpacity(0.5))),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              feature,
              style: TextStyle(color: _kTextSecondary, fontSize: 12),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _kAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                boolN,
                style: TextStyle(color: _kAccent, fontSize: 11),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _kPrimary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                boolReg,
                style: TextStyle(color: _kPrimary, fontSize: 11),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 2: TRISTATE LAB
// =============================================================================
class _TristateLabTab extends StatefulWidget {
  @override
  State<_TristateLabTab> createState() => _TristateLabTabState();
}

class _TristateLabTabState extends State<_TristateLabTab> {
  // Simulate RestorableBoolN values
  bool? _mainSelection;
  final List<bool> _items = [false, false, false, false, false];
  final List<String> _eventLog = [];

  void _onMainChanged(bool? value) {
    setState(() {
      _mainSelection = value;
      // When main is changed directly, set all items
      if (value != null) {
        for (var i = 0; i < _items.length; i++) {
          _items[i] = value;
        }
      }
      _logEvent('Main changed to: ${_valueString(value)}');
    });
  }

  void _onItemChanged(int index, bool value) {
    setState(() {
      _items[index] = value;
      _updateMainSelection();
      _logEvent('Item $index changed to: $value');
    });
  }

  void _updateMainSelection() {
    final allTrue = _items.every((v) => v);
    final allFalse = _items.every((v) => !v);
    
    if (allTrue) {
      _mainSelection = true;
    } else if (allFalse) {
      _mainSelection = false;
    } else {
      _mainSelection = null; // Indeterminate
    }
  }

  void _logEvent(String event) {
    _eventLog.insert(0, '${DateTime.now().toString().substring(11, 19)}: $event');
    if (_eventLog.length > 8) _eventLog.removeLast();
  }

  String _valueString(bool? value) {
    if (value == null) return 'null (indeterminate)';
    return value ? 'true' : 'false';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header with main checkbox
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
                'Tristate Checkbox Demo',
                style: TextStyle(
                  color: _kTextPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'The parent checkbox shows an indeterminate state when some but not all children are selected.',
                style: TextStyle(color: _kTextSecondary, fontSize: 12),
              ),
              SizedBox(height: 16),
              _MainCheckboxRow(
                value: _mainSelection,
                onChanged: _onMainChanged,
                selectedCount: _items.where((v) => v).length,
                totalCount: _items.length,
              ),
            ],
          ),
        ),
        // Item list
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return _ItemCheckboxRow(
                index: index,
                value: _items[index],
                onChanged: (v) => _onItemChanged(index, v),
              );
            },
          ),
        ),
        // State visualization
        Container(
          padding: EdgeInsets.all(16),
          color: _kCardBg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RestorableBoolN Equivalent:',
                style: TextStyle(color: _kAccent, fontSize: 12),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  _StateIndicator(
                    label: 'Value',
                    value: _mainSelection,
                  ),
                  SizedBox(width: 16),
                  _StateIndicator(
                    label: 'Selected',
                    value: null,
                    count: '${_items.where((v) => v).length}/${_items.length}',
                  ),
                ],
              ),
            ],
          ),
        ),
        // Event log
        Container(
          height: 100,
          padding: EdgeInsets.all(16),
          color: _kSurface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Event Log:', style: TextStyle(color: _kTextSecondary, fontSize: 12)),
              SizedBox(height: 8),
              Expanded(
                child: ListView(
                  children: _eventLog
                      .map((e) => Text(
                            e,
                            style: TextStyle(
                              color: _kTextPrimary,
                              fontFamily: 'monospace',
                              fontSize: 10,
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MainCheckboxRow extends StatelessWidget {
  final bool? value;
  final ValueChanged<bool?> onChanged;
  final int selectedCount;
  final int totalCount;

  const _MainCheckboxRow({
    required this.value,
    required this.onChanged,
    required this.selectedCount,
    required this.totalCount,
  });

  Color get _stateColor {
    if (value == null) return _kNull;
    return value! ? _kTrue : _kFalse;
  }

  String get _stateText {
    if (value == null) return 'Indeterminate';
    return value! ? 'All Selected' : 'None Selected';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _stateColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _stateColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.3,
            child: Checkbox(
              value: value,
              tristate: true,
              onChanged: onChanged,
              activeColor: _kPrimary,
              checkColor: Colors.white,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select All Items',
                  style: TextStyle(
                    color: _kTextPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: _stateColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _stateText,
                        style: TextStyle(
                          color: value == null ? Colors.black87 : Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '$selectedCount of $totalCount selected',
                      style: TextStyle(color: _kTextSecondary, fontSize: 12),
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
}

class _ItemCheckboxRow extends StatelessWidget {
  final int index;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ItemCheckboxRow({
    required this.index,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: value ? _kTrue.withOpacity(0.1) : _kCardBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: value ? _kTrue.withOpacity(0.3) : _kDivider),
      ),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: (v) => onChanged(v ?? false),
            activeColor: _kTrue,
          ),
          SizedBox(width: 12),
          Icon(
            Icons.folder,
            color: value ? _kTrue : _kTextSecondary,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Item ${index + 1}',
              style: TextStyle(
                color: value ? _kTrue : _kTextPrimary,
                fontWeight: value ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ),
          Text(
            value ? 'Selected' : 'Not selected',
            style: TextStyle(
              color: value ? _kTrue : _kTextSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _StateIndicator extends StatelessWidget {
  final String label;
  final bool? value;
  final String? count;

  const _StateIndicator({
    required this.label,
    required this.value,
    this.count,
  });

  Color get _color {
    if (count != null) return _kAccent;
    if (value == null) return _kNull;
    return value! ? _kTrue : _kFalse;
  }

  String get _valueText {
    if (count != null) return count!;
    if (value == null) return 'null';
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
          SizedBox(height: 4),
          Text(
            _valueText,
            style: TextStyle(
              color: _color,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 3: PERSISTENCE DEMO
// =============================================================================
class _PersistenceTab extends StatefulWidget {
  @override
  State<_PersistenceTab> createState() => _PersistenceTabState();
}

class _PersistenceTabState extends State<_PersistenceTab> {
  // Simulate multiple RestorableBoolN properties
  final Map<String, bool?> _values = {
    'notifications': null,
    'darkMode': true,
    'analytics': false,
    'newsletter': null,
  };
  
  int _buildCount = 0;
  bool _isRestored = false;
  Map<String, bool?>? _savedState;
  final List<String> _eventLog = [];

  void _setValue(String key, bool? value) {
    setState(() {
      _values[key] = value;
      _logEvent('$key = ${_valueString(value)}');
    });
  }

  void _simulatePersist() {
    _savedState = Map.from(_values);
    _logEvent('State persisted');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('State saved!'),
        backgroundColor: _kPrimary,
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _simulateRestore() {
    if (_savedState != null) {
      setState(() {
        _values.clear();
        _values.addAll(_savedState!);
        _buildCount++;
        _isRestored = true;
      });
      _logEvent('State restored (build #$_buildCount)');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('State restored!'),
          backgroundColor: _kAccent,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  void _simulateReset() {
    setState(() {
      _values['notifications'] = null;
      _values['darkMode'] = true;
      _values['analytics'] = false;
      _values['newsletter'] = null;
      _buildCount++;
    });
    _logEvent('Values reset (build #$_buildCount)');
  }

  void _logEvent(String event) {
    _eventLog.insert(0, '${DateTime.now().toString().substring(11, 19)}: $event');
    if (_eventLog.length > 10) _eventLog.removeLast();
  }

  String _valueString(bool? value) {
    if (value == null) return 'null';
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Status bar
        Container(
          padding: EdgeInsets.all(16),
          color: _kSurface,
          child: Row(
            children: [
              Icon(
                _isRestored ? Icons.restore : Icons.fiber_new,
                color: _isRestored ? _kAccent : _kPrimary,
              ),
              SizedBox(width: 12),
              Text(
                _isRestored ? 'Restored state (build #$_buildCount)' : 'Fresh state',
                style: TextStyle(color: _kTextPrimary, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _savedState != null ? _kTrue.withOpacity(0.2) : _kSurface,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: _savedState != null ? _kTrue : _kDivider,
                  ),
                ),
                child: Text(
                  _savedState != null ? 'Saved' : 'Not saved',
                  style: TextStyle(
                    color: _savedState != null ? _kTrue : _kTextSecondary,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Settings list
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              _SettingRow(
                title: 'Push Notifications',
                subtitle: 'Receive notifications about updates',
                icon: Icons.notifications,
                value: _values['notifications'],
                onChanged: (v) => _setValue('notifications', v),
              ),
              SizedBox(height: 12),
              _SettingRow(
                title: 'Dark Mode',
                subtitle: 'Use dark theme throughout the app',
                icon: Icons.dark_mode,
                value: _values['darkMode'],
                onChanged: (v) => _setValue('darkMode', v),
              ),
              SizedBox(height: 12),
              _SettingRow(
                title: 'Analytics',
                subtitle: 'Help improve the app by sharing usage data',
                icon: Icons.analytics,
                value: _values['analytics'],
                onChanged: (v) => _setValue('analytics', v),
              ),
              SizedBox(height: 12),
              _SettingRow(
                title: 'Newsletter',
                subtitle: 'Subscribe to our weekly newsletter',
                icon: Icons.email,
                value: _values['newsletter'],
                onChanged: (v) => _setValue('newsletter', v),
              ),
              SizedBox(height: 24),
              _buildCodePreview(),
            ],
          ),
        ),
        // Controls
        Container(
          padding: EdgeInsets.all(16),
          color: _kCardBg,
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _simulatePersist,
                  icon: Icon(Icons.save),
                  label: Text('Save State'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kPrimary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _savedState != null ? _simulateRestore : null,
                  icon: Icon(Icons.restore),
                  label: Text('Restore'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kAccent,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: _simulateReset,
                icon: Icon(Icons.refresh),
                label: Text('Reset'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: _kTextSecondary,
                  side: BorderSide(color: _kDivider),
                ),
              ),
            ],
          ),
        ),
        // Event log
        Container(
          height: 100,
          padding: EdgeInsets.all(16),
          color: _kSurface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Event Log:', style: TextStyle(color: _kAccent, fontSize: 12)),
              SizedBox(height: 8),
              Expanded(
                child: ListView(
                  children: _eventLog
                      .map((e) => Text(
                            e,
                            style: TextStyle(
                              color: _kTextPrimary,
                              fontFamily: 'monospace',
                              fontSize: 10,
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCodePreview() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.code, color: _kAccent, size: 18),
              SizedBox(width: 8),
              Text(
                'Current State (RestorableBoolN equivalent)',
                style: TextStyle(color: _kAccent, fontSize: 12),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            '''final notifications = RestorableBoolN(${_values['notifications']});
final darkMode = RestorableBoolN(${_values['darkMode']});
final analytics = RestorableBoolN(${_values['analytics']});
final newsletter = RestorableBoolN(${_values['newsletter']});''',
            style: TextStyle(
              color: _kTextPrimary,
              fontFamily: 'monospace',
              fontSize: 11,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool? value;
  final ValueChanged<bool?> onChanged;

  const _SettingRow({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  Color get _stateColor {
    if (value == null) return _kNull;
    return value! ? _kTrue : _kFalse;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _stateColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: _stateColor, size: 22),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: _kTextPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: _kTextSecondary, fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Checkbox(
                value: value,
                tristate: true,
                onChanged: onChanged,
                activeColor: _kPrimary,
              ),
              Text(
                value == null ? 'null' : value.toString(),
                style: TextStyle(
                  color: _stateColor,
                  fontSize: 10,
                  fontFamily: 'monospace',
                ),
              ),
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
class _TheoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _TheoryCard({
    required this.title,
    required this.icon,
    required this.child,
  });

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

  const _HierarchyItem({
    required this.level,
    required this.name,
    required this.desc,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: level * 16.0, top: level > 0 ? 8 : 0),
      child: Row(
        children: [
          if (level > 0) ...[
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: _kDivider),
                  bottom: BorderSide(color: _kDivider),
                ),
              ),
            ),
            SizedBox(width: 8),
          ],
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isHighlighted ? _kAccent.withOpacity(0.2) : _kCardBg,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: isHighlighted ? _kAccent : _kDivider,
              ),
            ),
            child: Text(
              name,
              style: TextStyle(
                color: isHighlighted ? _kAccent : _kTextPrimary,
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
              ),
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
          Text(
            name,
            style: TextStyle(color: _kTextPrimary, fontSize: 10, fontFamily: 'monospace'),
          ),
          SizedBox(width: 4),
          Text(
            '($desc)',
            style: TextStyle(color: _kTextSecondary, fontSize: 9),
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
              fontSize: 11,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
