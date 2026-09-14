// Deep visual test for RestorableEnumN
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, sized_box_for_whitespace, unintended_html_in_doc_comment, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

/// Deep visual exploration of RestorableEnumN
/// A restorable property that holds a nullable enum value.
///
/// RestorableEnumN<T extends Enum>:
/// - Can be null or any value from the enum
/// - Requires `values` parameter for deserialization
/// - Serializes enum by name, not index
///
/// Perfect for optional settings where "not set" is meaningful.
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF1A1A2E),
    ),
    home: _RestorableEnumNDemo(),
  );
}

// =============================================================================
// PALETTE: DeepOrange 700 / LightBlue A400
// =============================================================================
const Color _kPrimary = Color(0xFFE64A19); // DeepOrange 700
const Color _kAccent = Color(0xFF00B0FF); // LightBlue A400
const Color _kSurface = Color(0xFF252542);
const Color _kCardBg = Color(0xFF2D2D4A);
const Color _kTextPrimary = Color(0xFFE8E8F0);
const Color _kTextSecondary = Color(0xFFB0B0C8);
const Color _kDivider = Color(0xFF3A3A5C);
const Color _kNull = Color(0xFF9E9E9E);
const Color _kSuccess = Color(0xFF66BB6A);
const Color _kWarning = Color(0xFFFF7043);

// =============================================================================
// DEMO ENUMS
// =============================================================================
enum ThemeMode { system, light, dark }
enum SortOrder { nameAsc, nameDesc, dateAsc, dateDesc }
enum Locale { en, es, fr, de, ja, zh }
enum Priority { low, medium, high, urgent }

// =============================================================================
// MAIN DEMO WIDGET
// =============================================================================
class _RestorableEnumNDemo extends StatefulWidget {
  @override
  State<_RestorableEnumNDemo> createState() => _RestorableEnumNDemoState();
}

class _RestorableEnumNDemoState extends State<_RestorableEnumNDemo>
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
        title: Text('RestorableEnumN Deep Dive'),
        backgroundColor: _kPrimary,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kTextSecondary,
          tabs: [
            Tab(icon: Icon(Icons.school), text: 'Theory'),
            Tab(icon: Icon(Icons.explore), text: 'Enum Explorer'),
            Tab(icon: Icon(Icons.settings), text: 'Settings'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TheoryTab(),
          _EnumExplorerTab(),
          _SettingsTab(),
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
          _buildValuesParamSection(),
          SizedBox(height: 24),
          _buildSerializationSection(),
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
              Icon(Icons.format_list_bulleted, color: _kAccent, size: 32),
              SizedBox(width: 12),
              Text(
                'RestorableEnumN<T>',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'A restorable property for nullable enum values. Can be null or any value '
            'from the enum type, perfect for optional settings or preferences.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 15,
              height: 1.5,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _HeroBadge(icon: Icons.code, label: 'T extends Enum'),
              SizedBox(width: 12),
              _HeroBadge(icon: Icons.not_interested, label: 'Nullable'),
              SizedBox(width: 12),
              _HeroBadge(icon: Icons.list, label: 'values required'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNullableSection() {
    return _TheoryCard(
      title: 'Nullable Enum Values',
      icon: Icons.not_interested,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RestorableEnumN can hold null or any enum value:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _StateBox(
                  label: 'null',
                  sublabel: '(not set)',
                  color: _kNull,
                  icon: Icons.radio_button_unchecked,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _StateBox(
                  label: 'EnumValue',
                  sublabel: '(selected)',
                  color: _kSuccess,
                  icon: Icons.radio_button_checked,
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
                Icon(Icons.tips_and_updates, color: _kAccent, size: 18),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Use null to mean "no preference" or "use default", while an explicit '
                    'value represents user choice.',
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

  Widget _buildValuesParamSection() {
    return _TheoryCard(
      title: 'Required: values Parameter',
      icon: Icons.list_alt,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kWarning.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kWarning.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber, color: _kWarning),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Constructor Requirement',
                        style: TextStyle(color: _kWarning, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Must provide Iterable<T> values for restoration lookup.',
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
            title: 'Constructor signature:',
            code: '''RestorableEnumN<T extends Enum>(
  T? defaultValue, {
  required Iterable<T> values,  // Always required!
})''',
          ),
          SizedBox(height: 12),
          _CodeExample(
            title: 'Usage example:',
            code: '''final theme = RestorableEnumN<ThemeMode>(
  null,  // Default to no preference
  values: ThemeMode.values,
);

// Or with a default
final sort = RestorableEnumN<SortOrder>(
  SortOrder.nameAsc,
  values: SortOrder.values,
);''',
          ),
        ],
      ),
    );
  }

  Widget _buildSerializationSection() {
    return _TheoryCard(
      title: 'Name-Based Serialization',
      icon: Icons.sync_alt,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enums are serialized by name, not index:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _SerializationCard(
                  title: 'toPrimitives()',
                  formula: 'value?.name',
                  example: '"ThemeMode.dark" → "dark"',
                  note: 'null → null',
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.compare_arrows, color: _kAccent),
              SizedBox(width: 8),
              Expanded(
                child: _SerializationCard(
                  title: 'fromPrimitives()',
                  formula: 'values.byName(data)',
                  example: '"dark" → ThemeMode.dark',
                  note: 'null → null',
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
              border: Border.all(color: _kSuccess.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: _kSuccess, size: 18),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Safe for enum reordering! Index-based would break on changes.',
                    style: TextStyle(color: _kSuccess, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonSection() {
    return _TheoryCard(
      title: 'RestorableEnumN vs RestorableEnum',
      icon: Icons.compare_arrows,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _ComparisonCard(
                  title: 'RestorableEnumN<T>',
                  color: _kAccent,
                  items: [
                    'Type: T?',
                    'Can be null',
                    'Optional setting',
                    'Needs ?. check',
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _ComparisonCard(
                  title: 'RestorableEnum<T>',
                  color: _kPrimary,
                  items: [
                    'Type: T',
                    'Never null',
                    'Required selection',
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
            icon: Icons.palette,
            title: 'Optional Theme Override',
            desc: 'null = follow system, value = user choice',
          ),
          _UseCaseItem(
            icon: Icons.language,
            title: 'Language Preference',
            desc: 'null = auto-detect, value = specific locale',
          ),
          _UseCaseItem(
            icon: Icons.filter_list,
            title: 'Filter Selection',
            desc: 'null = no filter, value = active filter',
          ),
          _UseCaseItem(
            icon: Icons.priority_high,
            title: 'Priority Assignment',
            desc: 'null = unset, value = assigned priority',
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
          Text(label, style: TextStyle(color: Colors.white, fontSize: 10)),
        ],
      ),
    );
  }
}

class _StateBox extends StatelessWidget {
  final String label;
  final String sublabel;
  final Color color;
  final IconData icon;

  const _StateBox({required this.label, required this.sublabel, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          SizedBox(height: 8),
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14)),
          Text(sublabel, style: TextStyle(color: _kTextSecondary, fontSize: 11)),
        ],
      ),
    );
  }
}

class _SerializationCard extends StatelessWidget {
  final String title;
  final String formula;
  final String example;
  final String note;

  const _SerializationCard({required this.title, required this.formula, required this.example, required this.note});

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
          Text(title, style: TextStyle(color: _kAccent, fontSize: 11, fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          Text(formula, style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 10)),
          SizedBox(height: 4),
          Text(example, style: TextStyle(color: _kTextSecondary, fontSize: 9)),
          Text(note, style: TextStyle(color: _kNull, fontSize: 9)),
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
            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 11, fontFamily: 'monospace'),
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
// TAB 2: ENUM EXPLORER
// =============================================================================
class _EnumExplorerTab extends StatefulWidget {
  @override
  State<_EnumExplorerTab> createState() => _EnumExplorerTabState();
}

class _EnumExplorerTabState extends State<_EnumExplorerTab> {
  String _selectedEnumType = 'Axis';
  dynamic _currentValue;
  final List<String> _log = [];

  final Map<String, List<dynamic>> _enumData = {
    'Axis': Axis.values,
    'AxisDirection': AxisDirection.values,
    'Clip': Clip.values,
    'CrossAxisAlignment': CrossAxisAlignment.values,
    'MainAxisAlignment': MainAxisAlignment.values,
    'FlexFit': FlexFit.values,
    'WrapAlignment': WrapAlignment.values,
    'TextOverflow': TextOverflow.values,
  };

  void _selectValue(dynamic value) {
    setState(() {
      _currentValue = value;
      if (value == null) {
        _log.insert(0, '${_timeStamp()}: Set to null (no preference)');
      } else {
        _log.insert(0, '${_timeStamp()}: Selected ${value.toString().split('.').last}');
      }
      if (_log.length > 8) _log.removeLast();
    });
  }

  void _changeEnumType(String type) {
    setState(() {
      _selectedEnumType = type;
      _currentValue = null;
      _log.insert(0, '${_timeStamp()}: Switched to $type enum');
      if (_log.length > 8) _log.removeLast();
    });
  }

  String _timeStamp() => DateTime.now().toString().substring(11, 19);

  @override
  Widget build(BuildContext context) {
    final values = _enumData[_selectedEnumType] ?? [];

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
                  Icon(Icons.explore, color: _kAccent, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Interactive Enum Explorer',
                    style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Select any enum value or leave null. See how RestorableEnumN handles different types.',
                style: TextStyle(color: _kTextSecondary, fontSize: 12),
              ),
            ],
          ),
        ),
        // Enum Type Selector
        Container(
          padding: EdgeInsets.all(12),
          color: _kCardBg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Enum Type:', style: TextStyle(color: _kTextSecondary, fontSize: 12)),
              SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _enumData.keys.map((type) => _EnumTypeChip(
                    label: type,
                    isSelected: type == _selectedEnumType,
                    onTap: () => _changeEnumType(type),
                  )).toList(),
                ),
              ),
            ],
          ),
        ),
        // Current State Display
        Container(
          padding: EdgeInsets.all(16),
          color: _kSurface,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('RestorableEnumN<$_selectedEnumType>', 
                      style: TextStyle(color: _kAccent, fontFamily: 'monospace', fontSize: 12)),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text('Current: ', style: TextStyle(color: _kTextSecondary, fontSize: 12)),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _currentValue == null ? _kNull.withOpacity(0.2) : _kSuccess.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            _currentValue == null ? 'null' : _currentValue.toString().split('.').last,
                            style: TextStyle(
                              color: _currentValue == null ? _kNull : _kSuccess,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => _selectValue(null),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _kNull.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _kNull.withOpacity(0.4)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.clear, color: _kNull, size: 20),
                      SizedBox(height: 4),
                      Text('Clear', style: TextStyle(color: _kNull, fontSize: 10)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // Values Grid
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Available Values (${values.length}):', 
                  style: TextStyle(color: _kTextPrimary, fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2.8,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: values.length,
                    itemBuilder: (context, index) {
                      final value = values[index];
                      final name = value.toString().split('.').last;
                      final isSelected = _currentValue == value;
                      
                      return GestureDetector(
                        onTap: () => _selectValue(value),
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isSelected ? _kAccent.withOpacity(0.2) : _kCardBg,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isSelected ? _kAccent : _kDivider,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: isSelected ? _kAccent : _kSurface,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: Text(
                                    '${index}',
                                    style: TextStyle(
                                      color: isSelected ? Colors.black87 : _kTextSecondary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  name,
                                  style: TextStyle(
                                    color: isSelected ? _kAccent : _kTextPrimary,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    fontSize: 11,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        // Serialization Preview
        Container(
          padding: EdgeInsets.all(12),
          color: _kCardBg,
          child: Row(
            children: [
              Icon(Icons.data_object, color: _kAccent, size: 18),
              SizedBox(width: 12),
              Text('Serialized: ', style: TextStyle(color: _kTextSecondary, fontSize: 12)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _kSurface,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _currentValue == null ? 'null' : '"${_currentValue.toString().split('.').last}"',
                  style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        // Activity Log
        Container(
          height: 80,
          padding: EdgeInsets.all(12),
          color: _kSurface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Activity Log:', style: TextStyle(color: _kAccent, fontSize: 10)),
              SizedBox(height: 6),
              Expanded(
                child: ListView(
                  children: _log.map((entry) => Text(
                    entry, 
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

class _EnumTypeChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _EnumTypeChip({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? _kPrimary : _kSurface,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: isSelected ? _kPrimary : _kDivider),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : _kTextPrimary,
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// TAB 3: SETTINGS DEMO
// =============================================================================
class _SettingsTab extends StatefulWidget {
  @override
  State<_SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<_SettingsTab> {
  // Simulated RestorableEnumN values
  ThemeMode? _themeMode;
  SortOrder? _sortOrder;
  Locale? _locale;
  Priority? _priority;
  final List<String> _log = [];

  void _setTheme(ThemeMode? value) {
    setState(() {
      _themeMode = value;
      _addLog('Theme: ${value?.name ?? 'system default'}');
    });
  }

  void _setSort(SortOrder? value) {
    setState(() {
      _sortOrder = value;
      _addLog('Sort: ${value?.name ?? 'default'}');
    });
  }

  void _setLocale(Locale? value) {
    setState(() {
      _locale = value;
      _addLog('Locale: ${value?.name ?? 'auto-detect'}');
    });
  }

  void _setPriority(Priority? value) {
    setState(() {
      _priority = value;
      _addLog('Priority: ${value?.name ?? 'none'}');
    });
  }

  void _addLog(String msg) {
    _log.insert(0, '${DateTime.now().toString().substring(11, 19)}: $msg');
    if (_log.length > 10) _log.removeLast();
  }

  void _resetAll() {
    setState(() {
      _themeMode = null;
      _sortOrder = null;
      _locale = null;
      _priority = null;
      _addLog('Reset all settings');
    });
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
          child: Row(
            children: [
              Icon(Icons.settings, color: _kAccent, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Settings Demo', style: TextStyle(color: _kTextPrimary, fontWeight: FontWeight.bold)),
                    Text('Real-world nullable enum preferences', style: TextStyle(color: _kTextSecondary, fontSize: 11)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: _resetAll,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _kWarning.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('Reset All', style: TextStyle(color: _kWarning, fontSize: 11)),
                ),
              ),
            ],
          ),
        ),
        // Settings List
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                _SettingCard(
                  icon: Icons.palette,
                  title: 'Theme Mode',
                  subtitle: _themeMode == null ? 'Following system default' : 'User selected',
                  current: _themeMode,
                  values: ThemeMode.values,
                  onChanged: _setTheme,
                  labels: {
                    ThemeMode.system: ('System', Icons.settings_suggest),
                    ThemeMode.light: ('Light', Icons.wb_sunny),
                    ThemeMode.dark: ('Dark', Icons.nightlight_round),
                  },
                ),
                SizedBox(height: 16),
                _SettingCard(
                  icon: Icons.sort,
                  title: 'Sort Order',
                  subtitle: _sortOrder == null ? 'Using default order' : 'Custom sort applied',
                  current: _sortOrder,
                  values: SortOrder.values,
                  onChanged: _setSort,
                  labels: {
                    SortOrder.nameAsc: ('Name ↑', Icons.sort_by_alpha),
                    SortOrder.nameDesc: ('Name ↓', Icons.sort_by_alpha),
                    SortOrder.dateAsc: ('Date ↑', Icons.calendar_today),
                    SortOrder.dateDesc: ('Date ↓', Icons.calendar_today),
                  },
                ),
                SizedBox(height: 16),
                _SettingCard(
                  icon: Icons.language,
                  title: 'Language',
                  subtitle: _locale == null ? 'Auto-detecting from device' : 'Manually selected',
                  current: _locale,
                  values: Locale.values,
                  onChanged: _setLocale,
                  labels: {
                    Locale.en: ('English', Icons.flag),
                    Locale.es: ('Español', Icons.flag),
                    Locale.fr: ('Français', Icons.flag),
                    Locale.de: ('Deutsch', Icons.flag),
                    Locale.ja: ('日本語', Icons.flag),
                    Locale.zh: ('中文', Icons.flag),
                  },
                ),
                SizedBox(height: 16),
                _SettingCard(
                  icon: Icons.flag,
                  title: 'Default Priority',
                  subtitle: _priority == null ? 'No default priority' : 'Priority assigned',
                  current: _priority,
                  values: Priority.values,
                  onChanged: _setPriority,
                  labels: {
                    Priority.low: ('Low', Icons.arrow_downward),
                    Priority.medium: ('Medium', Icons.remove),
                    Priority.high: ('High', Icons.arrow_upward),
                    Priority.urgent: ('Urgent', Icons.priority_high),
                  },
                ),
              ],
            ),
          ),
        ),
        // Status Bar
        Container(
          padding: EdgeInsets.all(12),
          color: _kCardBg,
          child: Row(
            children: [
              _StatusIndicator(label: 'Theme', hasValue: _themeMode != null),
              SizedBox(width: 16),
              _StatusIndicator(label: 'Sort', hasValue: _sortOrder != null),
              SizedBox(width: 16),
              _StatusIndicator(label: 'Locale', hasValue: _locale != null),
              SizedBox(width: 16),
              _StatusIndicator(label: 'Priority', hasValue: _priority != null),
            ],
          ),
        ),
        // Activity Log
        Container(
          height: 80,
          padding: EdgeInsets.all(12),
          color: _kSurface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Change Log:', style: TextStyle(color: _kAccent, fontSize: 10)),
              SizedBox(height: 6),
              Expanded(
                child: ListView(
                  children: _log.map((entry) => Text(
                    entry, 
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

class _SettingCard<T extends Enum> extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final T? current;
  final List<T> values;
  final ValueChanged<T?> onChanged;
  final Map<T, (String, IconData)> labels;

  const _SettingCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.current,
    required this.values,
    required this.onChanged,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _kPrimary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: _kAccent, size: 22),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(color: _kTextPrimary, fontWeight: FontWeight.bold)),
                    Text(subtitle, style: TextStyle(color: _kTextSecondary, fontSize: 11)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => onChanged(null),
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: current == null ? _kNull.withOpacity(0.3) : _kSurface,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: current == null ? _kNull : _kDivider),
                  ),
                  child: Icon(
                    Icons.clear,
                    color: current == null ? _kNull : _kTextSecondary,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: values.map((value) {
              final labelData = labels[value];
              final label = labelData?.$1 ?? value.name;
              final iconData = labelData?.$2 ?? Icons.circle;
              final isSelected = current == value;
              
              return GestureDetector(
                onTap: () => onChanged(value),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? _kAccent.withOpacity(0.2) : _kSurface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: isSelected ? _kAccent : _kDivider),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(iconData, color: isSelected ? _kAccent : _kTextSecondary, size: 14),
                      SizedBox(width: 6),
                      Text(
                        label,
                        style: TextStyle(
                          color: isSelected ? _kAccent : _kTextPrimary,
                          fontSize: 11,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _StatusIndicator extends StatelessWidget {
  final String label;
  final bool hasValue;

  const _StatusIndicator({required this.label, required this.hasValue});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: hasValue ? _kSuccess : _kNull,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 6),
        Text(label, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
      ],
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
