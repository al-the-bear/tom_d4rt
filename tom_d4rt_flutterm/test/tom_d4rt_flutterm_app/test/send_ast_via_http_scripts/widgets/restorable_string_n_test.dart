// Deep visual test for RestorableStringN
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, unintended_html_in_doc_comment

import 'package:flutter/material.dart';

/// Deep visual exploration of RestorableStringN
/// A restorable property for nullable String values.
///
/// RestorableStringN provides:
/// - Nullable string storage with direct primitive serialization
/// - null represents "no value" vs empty string ("")
/// - Full Unicode preservation through restoration
///
/// Essential when an optional text field must survive app restarts.
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF1B1020),
    ),
    home: _RestorableStringNDemo(),
  );
}

// =============================================================================
// PALETTE: Red 400 / LightGreen A200
// =============================================================================
const Color _kPrimary = Color(0xFFEF5350); // Red 400
const Color _kAccent = Color(0xFFB2FF59); // LightGreen A200
const Color _kSurface = Color(0xFF281830);
const Color _kCardBg = Color(0xFF322040);
const Color _kTextPrimary = Color(0xFFF0E8F4);
const Color _kTextSecondary = Color(0xFFC0B0D0);
const Color _kDivider = Color(0xFF4A3560);
const Color _kNull = Color(0xFF90A4AE); // BlueGrey 300 for null
const Color _kPresent = Color(0xFF66BB6A); // Green 400 for present
const Color _kEmpty = Color(0xFFFFCA28); // Amber 400 for empty
const Color _kUnicode = Color(0xFF29B6F6); // LightBlue 400
const Color _kPurple = Color(0xFFAB47BC); // Purple 400

// =============================================================================
// MAIN DEMO
// =============================================================================
class _RestorableStringNDemo extends StatefulWidget {
  @override
  State<_RestorableStringNDemo> createState() => _RestorableStringNDemoState();
}

class _RestorableStringNDemoState extends State<_RestorableStringNDemo>
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
        title: Text('RestorableStringN Deep Dive'),
        backgroundColor: _kPrimary,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kTextSecondary,
          tabs: [
            Tab(icon: Icon(Icons.school), text: 'Theory'),
            Tab(icon: Icon(Icons.text_fields), text: 'String Lab'),
            Tab(icon: Icon(Icons.pattern), text: 'Patterns'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TheoryTab(),
          _StringLabTab(),
          _PatternsTab(),
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
          // Header card
          _buildHeaderCard(),
          SizedBox(height: 20),
          // What is it?
          _buildWhatIsItSection(),
          SizedBox(height: 20),
          // Null vs Empty vs Present
          _buildTriStateSection(),
          SizedBox(height: 20),
          // Inheritance hierarchy
          _buildHierarchySection(),
          SizedBox(height: 20),
          // Serialization
          _buildSerializationSection(),
          SizedBox(height: 20),
          // Comparison with RestorableString
          _buildComparisonSection(),
          SizedBox(height: 20),
          // Key facts
          _buildKeyFactsSection(),
        ],
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kPrimary.withOpacity(0.3), _kAccent.withOpacity(0.15)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kPrimary.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.text_snippet, color: _kPrimary, size: 32),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'RestorableStringN',
                  style: TextStyle(
                    color: _kTextPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'A restorable property that stores a nullable String value. '
            'The "N" suffix indicates nullability — the value can be null, '
            'representing an absent or cleared state that persists across '
            'application restarts.',
            style: TextStyle(color: _kTextSecondary, fontSize: 14, height: 1.5),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _kNull.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'class RestorableStringN extends _RestorablePrimitiveValueN<String?>',
              style: TextStyle(
                color: _kNull,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhatIsItSection() {
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
          _sectionTitle('What Does RestorableStringN Do?'),
          SizedBox(height: 12),
          _explanationTile(
            Icons.save_alt,
            _kPresent,
            'Stores & restores a String? value',
            'If the user typed optional text before the OS kills your app, '
            'RestorableStringN brings it back when the app relaunches.',
          ),
          SizedBox(height: 8),
          _explanationTile(
            Icons.block,
            _kNull,
            'null means "no value entered"',
            'Unlike RestorableString whose value is always non-null, '
            'this variant lets null express a meaningful absence.',
          ),
          SizedBox(height: 8),
          _explanationTile(
            Icons.speed,
            _kAccent,
            'Direct primitive serialization',
            'The String? is stored as-is in the restoration bucket — '
            'no JSON encoding, no conversion overhead.',
          ),
          SizedBox(height: 8),
          _explanationTile(
            Icons.cached,
            _kUnicode,
            'Full Unicode fidelity',
            'Emoji, CJK, RTL, combining characters — all survive '
            'the restoration roundtrip without loss.',
          ),
        ],
      ),
    );
  }

  Widget _buildTriStateSection() {
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
          _sectionTitle('The Three States of String?'),
          SizedBox(height: 16),
          // Visual comparison row
          Row(
            children: [
              Expanded(child: _triStateCard('null', _kNull, Icons.block, 'No value\n(never set / cleared)')),
              SizedBox(width: 8),
              Expanded(child: _triStateCard('""', _kEmpty, Icons.text_fields, 'Empty\n(set, but blank)')),
              SizedBox(width: 8),
              Expanded(child: _triStateCard('"Hello"', _kPresent, Icons.check_circle, 'Present\n(has content)')),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kPrimary.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.lightbulb, color: _kPrimary, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'RestorableStringN preserves the distinction between null and "". '
                    'RestorableString cannot represent null at all.',
                    style: TextStyle(color: _kTextPrimary, fontSize: 12, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _triStateCard(String value, Color color, IconData icon, String label) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.4)),
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
              fontSize: 14,
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(color: _kTextSecondary, fontSize: 10, height: 1.3),
          ),
        ],
      ),
    );
  }

  Widget _buildHierarchySection() {
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
          _sectionTitle('Inheritance Hierarchy'),
          SizedBox(height: 16),
          _hierarchyLevel(0, 'RestorableProperty<String?>', _kTextSecondary, 'Abstract base'),
          _hierarchyConnector(),
          _hierarchyLevel(1, 'RestorableValue<String?>', _kPurple, 'Adds value getter/setter'),
          _hierarchyConnector(),
          _hierarchyLevel(2, '_RestorablePrimitiveValueN<String?>', _kUnicode, 'Direct primitive storage'),
          _hierarchyConnector(),
          _hierarchyLevel(3, 'RestorableStringN', _kPrimary, 'Nullable String (YOU ARE HERE)'),
          SizedBox(height: 16),
          // Sibling classes
          Text(
            'Sibling nullable primitive classes:',
            style: TextStyle(color: _kTextSecondary, fontSize: 12),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              _siblingChip('RestorableIntN'),
              _siblingChip('RestorableDoubleN'),
              _siblingChip('RestorableBoolN'),
              _siblingChip('RestorableNumN'),
              _siblingChip('RestorableDateTimeN'),
              _siblingChip('RestorableEnumN'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _hierarchyLevel(int indent, String name, Color color, String desc) {
    return Padding(
      padding: EdgeInsets.only(left: indent * 20.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 12),
                  ),
                  Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _hierarchyConnector() {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Container(
        width: 2,
        height: 16,
        color: _kDivider,
      ),
    );
  }

  Widget _siblingChip(String name) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _kPurple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _kPurple.withOpacity(0.3)),
      ),
      child: Text(
        name,
        style: TextStyle(color: _kPurple, fontFamily: 'monospace', fontSize: 10),
      ),
    );
  }

  Widget _buildSerializationSection() {
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
          _sectionTitle('Serialization: Direct Primitive'),
          SizedBox(height: 12),
          Text(
            'RestorableStringN stores the String? directly in the restoration '
            'bucket. No encoding or wrapping is needed.',
            style: TextStyle(color: _kTextSecondary, fontSize: 13, height: 1.4),
          ),
          SizedBox(height: 16),
          _serializationRow('toPrimitives()', '"Flutter"', 'Stored as String'),
          SizedBox(height: 6),
          _serializationRow('toPrimitives()', 'null', 'Stored as null'),
          SizedBox(height: 6),
          _serializationRow('fromPrimitives()', '"Flutter"', 'Cast to String?'),
          SizedBox(height: 6),
          _serializationRow('fromPrimitives()', 'null', 'Returns null'),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kAccent.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Because the engine restoration bucket natively stores '
              'String and null, no conversion code runs at all — '
              'making this one of the most efficient restorable types.',
              style: TextStyle(color: _kAccent, fontSize: 11, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _serializationRow(String method, String value, String note) {
    return Row(
      children: [
        Container(
          width: 120,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _kUnicode.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            method,
            style: TextStyle(color: _kUnicode, fontFamily: 'monospace', fontSize: 10),
          ),
        ),
        SizedBox(width: 8),
        Icon(Icons.arrow_forward, color: _kDivider, size: 14),
        SizedBox(width: 8),
        Text(
          value,
          style: TextStyle(
            color: value == 'null' ? _kNull : _kPresent,
            fontFamily: 'monospace',
            fontSize: 12,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(note, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
        ),
      ],
    );
  }

  Widget _buildComparisonSection() {
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
          _sectionTitle('RestorableStringN vs RestorableString'),
          SizedBox(height: 12),
          _comparisonHeader(),
          SizedBox(height: 4),
          _comparisonRow('Value type', 'String?', 'String', true),
          _comparisonRow('Default null?', 'Yes', 'No', true),
          _comparisonRow('Clears to null?', 'Yes', 'No (to "")', true),
          _comparisonRow('Serialization', 'Direct', 'Direct', false),
          _comparisonRow('ChangeNotifier', 'Yes', 'Yes', false),
          _comparisonRow('Use case', 'Optional field', 'Required field', true),
        ],
      ),
    );
  }

  Widget _comparisonHeader() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text('Feature', style: TextStyle(color: _kTextSecondary, fontSize: 11, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          flex: 2,
          child: Text('StringN', style: TextStyle(color: _kPrimary, fontSize: 11, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          flex: 2,
          child: Text('String', style: TextStyle(color: _kAccent, fontSize: 11, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _comparisonRow(String feature, String nullable, String nonNull, bool differs) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(feature, style: TextStyle(color: _kTextSecondary, fontSize: 11)),
          ),
          Expanded(
            flex: 2,
            child: Text(
              nullable,
              style: TextStyle(
                color: differs ? _kPrimary : _kTextSecondary,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              nonNull,
              style: TextStyle(
                color: differs ? _kAccent : _kTextSecondary,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyFactsSection() {
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
          _sectionTitle('Key Facts'),
          SizedBox(height: 12),
          _factRow(Icons.api, 'Constructor: RestorableStringN(String? defaultValue)'),
          _factRow(Icons.check, 'Accepts null as defaultValue'),
          _factRow(Icons.cached, 'Serializes as-is (direct primitive)'),
          _factRow(Icons.notifications_active, 'Extends ChangeNotifier — listeners get updates'),
          _factRow(Icons.memory, 'Must dispose() when no longer needed'),
          _factRow(Icons.warning_amber, 'value throws if accessed before registration'),
        ],
      ),
    );
  }

  Widget _factRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: _kAccent, size: 16),
          SizedBox(width: 8),
          Expanded(
            child: Text(text, style: TextStyle(color: _kTextPrimary, fontSize: 12, height: 1.3)),
          ),
        ],
      ),
    );
  }

  Widget _explanationTile(IconData icon, Color color, String title, String desc) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: _kTextPrimary, fontSize: 13, fontWeight: FontWeight.w600)),
              SizedBox(height: 2),
              Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 12, height: 1.3)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        color: _kTextPrimary,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// =============================================================================
// TAB 2: STRING LAB
// =============================================================================
class _StringLabTab extends StatefulWidget {
  @override
  State<_StringLabTab> createState() => _StringLabTabState();
}

class _StringLabTabState extends State<_StringLabTab> {
  // Diverse RestorableStringN instances
  final RestorableStringN _nullDefault = RestorableStringN(null);
  final RestorableStringN _emptyDefault = RestorableStringN('');
  final RestorableStringN _helloDefault = RestorableStringN('Hello');
  final RestorableStringN _unicodeDefault = RestorableStringN('🌍 World 世界');
  final RestorableStringN _multilineDefault = RestorableStringN('Line 1\nLine 2\nLine 3');

  // Lab state
  String _selectedDemo = 'nullability';

  @override
  void dispose() {
    _nullDefault.dispose();
    _emptyDefault.dispose();
    _helloDefault.dispose();
    _unicodeDefault.dispose();
    _multilineDefault.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Demo selector
          _buildDemoSelector(),
          SizedBox(height: 16),
          // Active demo
          if (_selectedDemo == 'nullability') _buildNullabilityDemo(),
          if (_selectedDemo == 'encoding') _buildEncodingDemo(),
          if (_selectedDemo == 'lifecycle') _buildLifecycleDemo(),
          if (_selectedDemo == 'scenarios') _buildScenariosDemo(),
        ],
      ),
    );
  }

  Widget _buildDemoSelector() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select a Lab Experiment',
            style: TextStyle(color: _kTextPrimary, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              _selectorChip('nullability', 'Null vs Empty'),
              _selectorChip('encoding', 'Unicode & Encoding'),
              _selectorChip('lifecycle', 'Value Lifecycle'),
              _selectorChip('scenarios', 'Real Scenarios'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _selectorChip(String key, String label) {
    final selected = _selectedDemo == key;
    return GestureDetector(
      onTap: () => setState(() => _selectedDemo = key),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? _kPrimary.withOpacity(0.25) : _kSurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? _kPrimary : _kDivider,
            width: selected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? _kPrimary : _kTextSecondary,
            fontSize: 12,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Nullability demo
  // ---------------------------------------------------------------------------
  Widget _buildNullabilityDemo() {
    print('[StringLab] Building nullability demo');
    print('  _nullDefault value: ${_nullDefault.value}');
    print('  _emptyDefault value: "${_emptyDefault.value}"');
    print('  _helloDefault value: "${_helloDefault.value}"');

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
          Text(
            'Null vs Empty vs Present',
            style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'Each RestorableStringN carries a distinct semantic state:',
            style: TextStyle(color: _kTextSecondary, fontSize: 12),
          ),
          SizedBox(height: 16),
          // Value display cards
          _valueCard(
            'RestorableStringN(null)',
            _nullDefault.value,
            _kNull,
            Icons.block,
            'Value is null — represents absence. '
            'A search bar with no query, an optional nickname the user never set.',
          ),
          SizedBox(height: 10),
          _valueCard(
            'RestorableStringN("")',
            _emptyDefault.value,
            _kEmpty,
            Icons.text_fields,
            'Value is an empty string — explicitly blank. '
            'The user opened the text field, typed nothing, and saved.',
          ),
          SizedBox(height: 10),
          _valueCard(
            'RestorableStringN("Hello")',
            _helloDefault.value,
            _kPresent,
            Icons.check_circle,
            'Value is a real string — the user typed something meaningful. '
            'This is the normal filled-in state.',
          ),
          SizedBox(height: 16),
          // Boolean checks
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kPrimary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Common null-check patterns:',
                  style: TextStyle(color: _kTextPrimary, fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                _codeBlock('value == null     // never set'),
                _codeBlock('value?.isEmpty    // set but blank'),
                _codeBlock('value?.isNotEmpty  // has content'),
                _codeBlock('value ?? "default" // fallback'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _valueCard(String constructor, String? value, Color color, IconData icon, String explanation) {
    final displayValue = value == null ? 'null' : (value.isEmpty ? '""  (empty)' : '"$value"');
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  constructor,
                  style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 11),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text('value → ', style: TextStyle(color: _kTextSecondary, fontSize: 12)),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        displayValue,
                        style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  explanation,
                  style: TextStyle(color: _kTextSecondary, fontSize: 11, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Encoding demo
  // ---------------------------------------------------------------------------
  Widget _buildEncodingDemo() {
    final samples = <_EncodingSample>[
      _EncodingSample('ASCII', 'Hello World', Icons.abc, _kPresent),
      _EncodingSample('Emoji', '🎨🚀💡🌈🎯', Icons.emoji_emotions, _kEmpty),
      _EncodingSample('CJK', '你好世界 こんにちは 안녕', Icons.translate, _kUnicode),
      _EncodingSample('RTL Arabic', 'مرحبا بالعالم', Icons.format_textdirection_r_to_l, _kPurple),
      _EncodingSample('Diacritics', 'Ñoño café ü résumé', Icons.spellcheck, _kPrimary),
      _EncodingSample('Symbols', '∑ ∫ ∞ √ π ≈ ≠', Icons.functions, _kAccent),
      _EncodingSample('Mixed', 'Hello 🌍 世界!', Icons.merge_type, _kNull),
    ];

    print('[StringLab] Building encoding demo');
    for (final s in samples) {
      final prop = RestorableStringN(s.value);
      print('  ${s.label}: "${prop.value}" (${prop.value?.length} chars)');
      prop.dispose();
    }

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
          Text(
            'Unicode & Character Encoding',
            style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'RestorableStringN preserves every character through restoration:',
            style: TextStyle(color: _kTextSecondary, fontSize: 12),
          ),
          SizedBox(height: 16),
          ...samples.map((s) => Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: _encodingCard(s),
          )),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kAccent.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Dart strings are UTF-16. All characters — including those '
              'in the Supplementary Multilingual Plane (emoji, rare CJK) — '
              'serialize and restore correctly because the engine bucket '
              'stores raw Dart String objects.',
              style: TextStyle(color: _kAccent, fontSize: 11, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _encodingCard(_EncodingSample sample) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: sample.color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: sample.color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(sample.icon, color: sample.color, size: 20),
          SizedBox(width: 10),
          Container(
            width: 70,
            child: Text(
              sample.label,
              style: TextStyle(color: sample.color, fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _kSurface,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                sample.value,
                style: TextStyle(color: _kTextPrimary, fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          SizedBox(width: 8),
          Text(
            '${sample.value.length}c',
            style: TextStyle(color: _kTextSecondary, fontSize: 10, fontFamily: 'monospace'),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Lifecycle demo
  // ---------------------------------------------------------------------------
  Widget _buildLifecycleDemo() {
    print('[StringLab] Building lifecycle demo');

    final steps = <_LifecycleStep>[
      _LifecycleStep('1. Construct', 'RestorableStringN(null)', 'Property created, default set', _kNull),
      _LifecycleStep('2. Register', 'registerForRestoration(prop, "id")', 'Hooked into RestorationMixin', _kUnicode),
      _LifecycleStep('3. Read value', 'prop.value  // → null', 'Returns current value (String?)', _kPresent),
      _LifecycleStep('4. Set value', 'prop.value = "Typed"', 'Notifies listeners, marks bucket dirty', _kPrimary),
      _LifecycleStep('5. Serialize', 'toPrimitives() → "Typed"', 'Engine saves String? into bucket', _kAccent),
      _LifecycleStep('6. App killed', '(OS reclaims process)', 'Bucket persisted by engine', _kNull),
      _LifecycleStep('7. App relaunched', 'Framework restores bucket', 'RestorationMixin rebuilds', _kUnicode),
      _LifecycleStep('8. Deserialize', 'fromPrimitives("Typed")', 'Value restored from bucket', _kPresent),
      _LifecycleStep('9. Dispose', 'prop.dispose()', 'Listeners cleared, resources freed', _kPrimary),
    ];

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
          Text(
            'Value Lifecycle',
            style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'From construction through restoration to disposal:',
            style: TextStyle(color: _kTextSecondary, fontSize: 12),
          ),
          SizedBox(height: 16),
          ...steps.map((step) => _lifecycleStepCard(step)),
        ],
      ),
    );
  }

  Widget _lifecycleStepCard(_LifecycleStep step) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Vertical rail
          Column(
            children: [
              Container(
                width: 12, height: 12,
                decoration: BoxDecoration(
                  color: step.color,
                  shape: BoxShape.circle,
                ),
              ),
              Container(width: 2, height: 40, color: _kDivider),
            ],
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: step.color.withOpacity(0.06),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: step.color.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: TextStyle(color: step.color, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 2),
                  Text(
                    step.code,
                    style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 10),
                  ),
                  SizedBox(height: 2),
                  Text(step.note, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Scenarios demo
  // ---------------------------------------------------------------------------
  Widget _buildScenariosDemo() {
    print('[StringLab] Building scenarios demo');

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
          Text(
            'Real-World Scenarios',
            style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          _scenarioCard(
            'Optional Search Query',
            Icons.search,
            _kUnicode,
            'final _query = RestorableStringN(null);',
            'When the user opens the search bar, query starts as null (no search active). '
            'As they type, it becomes non-null. Clearing the search can set it to null '
            'rather than "" to distinguish "search bar closed" from "search bar open but empty".',
            _buildSearchSimulation(),
          ),
          SizedBox(height: 12),
          _scenarioCard(
            'Clearable Nickname',
            Icons.person_outline,
            _kPresent,
            'final _nickname = RestorableStringN(null);',
            'A user profile with an optional nickname. null means they never set one. '
            'Setting it to "" might mean they want it blank. null triggers a "Set nickname" prompt.',
            _buildNicknameSimulation(),
          ),
          SizedBox(height: 12),
          _scenarioCard(
            'Draft Note Auto-Save',
            Icons.note_alt,
            _kPrimary,
            'final _draft = RestorableStringN(null);',
            'If the user starts writing a note, the draft survives app restart. '
            'null means no draft exists. Even an empty draft ("") is preserved.',
            _buildDraftSimulation(),
          ),
          SizedBox(height: 12),
          _scenarioCard(
            'Last Error Message',
            Icons.error_outline,
            _kEmpty,
            'final _lastError = RestorableStringN(null);',
            'Store the last validation error so the UI can re-display it '
            'after restoration. null = no error. Cleared when input is valid.',
            _buildErrorSimulation(),
          ),
        ],
      ),
    );
  }

  Widget _scenarioCard(String title, IconData icon, Color color, String code,
      String explanation, Widget simulation) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              code,
              style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 10),
            ),
          ),
          SizedBox(height: 8),
          Text(
            explanation,
            style: TextStyle(color: _kTextSecondary, fontSize: 11, height: 1.4),
          ),
          SizedBox(height: 8),
          simulation,
        ],
      ),
    );
  }

  Widget _buildSearchSimulation() {
    final states = <_SimState>[
      _SimState('Search bar closed', null, _kNull),
      _SimState('Bar opened, empty', '', _kEmpty),
      _SimState('User types "flut"', 'flut', _kPresent),
      _SimState('User types "flutter"', 'flutter', _kPresent),
      _SimState('User clears', null, _kNull),
    ];
    return _stateTimeline(states);
  }

  Widget _buildNicknameSimulation() {
    final states = <_SimState>[
      _SimState('Never set', null, _kNull),
      _SimState('Set "Ace"', 'Ace', _kPresent),
      _SimState('Changed "Rocket"', 'Rocket', _kPresent),
      _SimState('Cleared', null, _kNull),
    ];
    return _stateTimeline(states);
  }

  Widget _buildDraftSimulation() {
    final states = <_SimState>[
      _SimState('No draft', null, _kNull),
      _SimState('Started typing', 'Dear ', _kPresent),
      _SimState('More text', 'Dear team, I wanted...', _kPresent),
      _SimState('App killed → restored', 'Dear team, I wanted...', _kPresent),
      _SimState('Sent & cleared', null, _kNull),
    ];
    return _stateTimeline(states);
  }

  Widget _buildErrorSimulation() {
    final states = <_SimState>[
      _SimState('No error', null, _kNull),
      _SimState('Invalid email', 'Not a valid email', _kPrimary),
      _SimState('Fixed → valid', null, _kNull),
      _SimState('Too short', 'Min 8 characters', _kPrimary),
    ];
    return _stateTimeline(states);
  }

  Widget _stateTimeline(List<_SimState> states) {
    return Column(
      children: states.map((s) {
        final display = s.value == null ? 'null' : (s.value!.isEmpty ? '""' : '"${s.value}"');
        return Padding(
          padding: EdgeInsets.only(bottom: 4),
          child: Row(
            children: [
              Container(
                width: 8, height: 8,
                decoration: BoxDecoration(color: s.color, shape: BoxShape.circle),
              ),
              SizedBox(width: 6),
              Container(
                width: 130,
                child: Text(s.label, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
              ),
              Icon(Icons.arrow_forward, size: 10, color: _kDivider),
              SizedBox(width: 4),
              Text(
                display,
                style: TextStyle(color: s.color, fontFamily: 'monospace', fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _codeBlock(String code) {
    return Padding(
      padding: EdgeInsets.only(bottom: 3),
      child: Text(
        code,
        style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 11),
      ),
    );
  }
}

// =============================================================================
// TAB 3: PATTERNS
// =============================================================================
class _PatternsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRestorationMixinPattern(),
          SizedBox(height: 20),
          _buildNullCoalescingPattern(),
          SizedBox(height: 20),
          _buildConditionalUIPattern(),
          SizedBox(height: 20),
          _buildFormResetPattern(),
          SizedBox(height: 20),
          _buildBestPracticesSection(),
          SizedBox(height: 20),
          _buildPitfallsSection(),
        ],
      ),
    );
  }

  Widget _buildRestorationMixinPattern() {
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
          _patternTitle(Icons.extension, 'RestorationMixin Integration'),
          SizedBox(height: 12),
          Text(
            'The standard way to use RestorableStringN in a StatefulWidget:',
            style: TextStyle(color: _kTextSecondary, fontSize: 12),
          ),
          SizedBox(height: 12),
          _codeSnippet(
            'class _MyState extends State<MyWidget>\n'
            '    with RestorationMixin {\n'
            '\n'
            '  final _search = RestorableStringN(null);\n'
            '\n'
            '  @override\n'
            '  String? get restorationId => "my_widget";\n'
            '\n'
            '  @override\n'
            '  void restoreState(RestorationBucket? old, bool init) {\n'
            '    registerForRestoration(_search, "search");\n'
            '  }\n'
            '\n'
            '  @override\n'
            '  void dispose() {\n'
            '    _search.dispose();\n'
            '    super.dispose();\n'
            '  }\n'
            '}',
          ),
          SizedBox(height: 12),
          _stepRow('1', 'Declare the property with a nullable default', _kNull),
          _stepRow('2', 'Provide a unique restorationId for the widget', _kUnicode),
          _stepRow('3', 'Register in restoreState with a unique string key', _kPresent),
          _stepRow('4', 'Always dispose to free ChangeNotifier resources', _kPrimary),
        ],
      ),
    );
  }

  Widget _buildNullCoalescingPattern() {
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
          _patternTitle(Icons.merge_type, 'Null Coalescing Pattern'),
          SizedBox(height: 12),
          Text(
            'Common patterns for working with the nullable value:',
            style: TextStyle(color: _kTextSecondary, fontSize: 12),
          ),
          SizedBox(height: 12),
          _patternRow(
            '_search.value ?? "No query"',
            'Fallback when null',
            _kNull,
          ),
          _patternRow(
            '_search.value?.toUpperCase()',
            'Transform only if present',
            _kPresent,
          ),
          _patternRow(
            'if (_search.value != null) ...',
            'Guard clause',
            _kUnicode,
          ),
          _patternRow(
            '_search.value = null;  // clear',
            'Reset to absent',
            _kPrimary,
          ),
          _patternRow(
            '_search.value?.isEmpty == true',
            'Check for blank string',
            _kEmpty,
          ),
          SizedBox(height: 12),
          // Visual flow
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kPrimary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Decision Flow:',
                  style: TextStyle(color: _kPrimary, fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                _flowArrow('value', '→  null?  →  show "Set a value" prompt', _kNull),
                _flowArrow('value', '→  ""?    →  show "Enter text" hint', _kEmpty),
                _flowArrow('value', '→  text?  →  display the text', _kPresent),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConditionalUIPattern() {
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
          _patternTitle(Icons.visibility, 'Conditional UI Display'),
          SizedBox(height: 12),
          Text(
            'Use the three-state nature to drive different UI modes:',
            style: TextStyle(color: _kTextSecondary, fontSize: 12),
          ),
          SizedBox(height: 16),
          // Simulated UI states
          _uiStateCard(
            'null → Hidden State',
            _kNull,
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kNull.withOpacity(0.06),
                borderRadius: BorderRadius.circular(8),
                border: Border(left: BorderSide(color: _kNull, width: 3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.search_off, color: _kNull, size: 18),
                  SizedBox(width: 8),
                  Text('Tap to search...', style: TextStyle(color: _kNull.withOpacity(0.7), fontSize: 13)),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          _uiStateCard(
            '"" → Active but Empty',
            _kEmpty,
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kEmpty.withOpacity(0.06),
                borderRadius: BorderRadius.circular(8),
                border: Border(left: BorderSide(color: _kEmpty, width: 3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: _kEmpty, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                        color: _kSurface,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: _kEmpty.withOpacity(0.3)),
                      ),
                      child: Text(
                        'Type to search...',
                        style: TextStyle(color: _kTextSecondary, fontSize: 12, fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.close, color: _kEmpty, size: 16),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          _uiStateCard(
            '"flutter" → Active with Content',
            _kPresent,
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kPresent.withOpacity(0.06),
                borderRadius: BorderRadius.circular(8),
                border: Border(left: BorderSide(color: _kPresent, width: 3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: _kPresent, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                        color: _kSurface,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: _kPresent.withOpacity(0.4)),
                      ),
                      child: Text(
                        'flutter',
                        style: TextStyle(color: _kTextPrimary, fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: _kPresent.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text('23 results', style: TextStyle(color: _kPresent, fontSize: 10)),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.close, color: _kPresent, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _uiStateCard(String label, Color color, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        child,
      ],
    );
  }

  Widget _buildFormResetPattern() {
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
          _patternTitle(Icons.restart_alt, 'Form Reset Pattern'),
          SizedBox(height: 12),
          Text(
            'How to handle form fields that start empty and can be cleared:',
            style: TextStyle(color: _kTextSecondary, fontSize: 12),
          ),
          SizedBox(height: 12),
          _codeSnippet(
            '// Option A: null = untouched, "" = cleared\n'
            'void onClear() {\n'
            '  _field.value = null; // back to pristine\n'
            '}\n'
            '\n'
            '// Option B: null = invalid, "" = valid-empty\n'
            'void onReset() {\n'
            '  _field.value = ""; // keep form active\n'
            '}\n'
            '\n'
            '// Checking form state\n'
            'bool get isDirty => _field.value != null;\n'
            'bool get hasContent => _field.value?.isNotEmpty == true;',
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kAccent.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Tip: Choose a clear semantic meaning for null vs empty '
              'early in development and document it. Mixing meanings '
              'leads to bugs.',
              style: TextStyle(color: _kAccent, fontSize: 11, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBestPracticesSection() {
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
          _patternTitle(Icons.thumb_up, 'Best Practices'),
          SizedBox(height: 12),
          _practiceRow(
            true,
            'Use null for "no value" and "" for "explicitly empty"',
          ),
          _practiceRow(
            true,
            'Dispose in State.dispose() to prevent memory leaks',
          ),
          _practiceRow(
            true,
            'Use unique restoration keys across the widget tree',
          ),
          _practiceRow(
            true,
            'Check .value != null before using .value!',
          ),
          _practiceRow(
            true,
            'Prefer RestorableString if null is never a valid state',
          ),
          _practiceRow(
            true,
            'Add a listener if the UI must react to external value changes',
          ),
        ],
      ),
    );
  }

  Widget _buildPitfallsSection() {
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
          _patternTitle(Icons.warning_amber, 'Pitfalls to Avoid'),
          SizedBox(height: 12),
          _practiceRow(
            false,
            'Using .value! without a null check — will throw if null',
          ),
          _practiceRow(
            false,
            'Accessing .value before registration — assertion failure',
          ),
          _practiceRow(
            false,
            'Forgetting to dispose — listeners leak memory',
          ),
          _practiceRow(
            false,
            'Treating null and "" the same — they have different UI meanings',
          ),
          _practiceRow(
            false,
            'Using mutable objects instead of immutable strings',
          ),
          _practiceRow(
            false,
            'Registering the same property under two different keys',
          ),
        ],
      ),
    );
  }

  // Helpers
  Widget _patternTitle(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: _kAccent, size: 20),
        SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _stepRow(String num, String text, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20, height: 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Text(num, style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(text, style: TextStyle(color: _kTextSecondary, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _patternRow(String code, String desc, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6, height: 6,
            margin: EdgeInsets.only(top: 5),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  code,
                  style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 11),
                ),
                Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _flowArrow(String prefix, String text, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 3),
      child: Text(
        '$prefix  $text',
        style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 10),
      ),
    );
  }

  Widget _practiceRow(bool good, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            good ? Icons.check_circle : Icons.cancel,
            color: good ? _kPresent : _kPrimary,
            size: 16,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(text, style: TextStyle(color: _kTextPrimary, fontSize: 12, height: 1.3)),
          ),
        ],
      ),
    );
  }

  Widget _codeSnippet(String code) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kDivider),
      ),
      child: Text(
        code,
        style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 11, height: 1.5),
      ),
    );
  }
}

// =============================================================================
// HELPER CLASSES
// =============================================================================
class _EncodingSample {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  _EncodingSample(this.label, this.value, this.icon, this.color);
}

class _LifecycleStep {
  final String title;
  final String code;
  final String note;
  final Color color;
  _LifecycleStep(this.title, this.code, this.note, this.color);
}

class _SimState {
  final String label;
  final String? value;
  final Color color;
  _SimState(this.label, this.value, this.color);
}
