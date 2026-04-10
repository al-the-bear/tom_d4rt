// Deep visual test for RestorableString
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, unintended_html_in_doc_comment

import 'package:flutter/material.dart';

/// Deep visual exploration of RestorableString
/// A restorable property for non-null String values.
///
/// RestorableString provides:
/// - Guaranteed non-null String storage
/// - Direct primitive serialization (no encoding overhead)
/// - ChangeNotifier integration for reactive UIs
///
/// The workhorse for any text field whose value must survive app restarts.
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF0D1B2A),
    ),
    home: _RestorableStringDemo(),
  );
}

// =============================================================================
// PALETTE: Blue 600 / Yellow A200
// =============================================================================
const Color _kPrimary = Color(0xFF1E88E5); // Blue 600
const Color _kAccent = Color(0xFFFFFF00); // Yellow A200
const Color _kSurface = Color(0xFF1B2838);
const Color _kCardBg = Color(0xFF243447);
const Color _kTextPrimary = Color(0xFFE8F0F8);
const Color _kTextSecondary = Color(0xFFB0C4D8);
const Color _kDivider = Color(0xFF3A5068);
const Color _kString = Color(0xFF66BB6A); // Green 400 for string values
const Color _kEmpty = Color(0xFFFF7043); // DeepOrange 400 for edge cases
const Color _kCode = Color(0xFF26C6DA); // Cyan 400 for code snippets
const Color _kWarm = Color(0xFFEC407A); // Pink 400 for warnings

// =============================================================================
// MAIN DEMO
// =============================================================================
class _RestorableStringDemo extends StatefulWidget {
  @override
  State<_RestorableStringDemo> createState() => _RestorableStringDemoState();
}

class _RestorableStringDemoState extends State<_RestorableStringDemo>
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
        title: Text('RestorableString Deep Dive'),
        backgroundColor: _kPrimary,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kTextSecondary,
          tabs: [
            Tab(icon: Icon(Icons.school), text: 'Theory'),
            Tab(icon: Icon(Icons.edit_note), text: 'Editor Lab'),
            Tab(icon: Icon(Icons.cases_outlined), text: 'Use Cases'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TheoryTab(),
          _EditorLabTab(),
          _UseCasesTab(),
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
          _buildHeaderCard(),
          SizedBox(height: 20),
          _buildOverviewSection(),
          SizedBox(height: 20),
          _buildHierarchySection(),
          SizedBox(height: 20),
          _buildAPISection(),
          SizedBox(height: 20),
          _buildSerializationSection(),
          SizedBox(height: 20),
          _buildComparisonTable(),
          SizedBox(height: 20),
          _buildWhenToUseSection(),
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
          colors: [_kPrimary.withOpacity(0.3), _kAccent.withOpacity(0.1)],
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
                  'RestorableString',
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
            'A restorable property that stores a non-null String value. '
            'The value is always guaranteed to be a valid String — never '
            'null. This is the go-to choice for required text fields, user '
            'names, form inputs, and any string state that must persist.',
            style: TextStyle(color: _kTextSecondary, fontSize: 14, height: 1.5),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _kPrimary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'class RestorableString extends _RestorablePrimitiveValue<String>',
              style: TextStyle(
                color: _kCode,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewSection() {
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
          _sectionTitle('What RestorableString Does'),
          SizedBox(height: 12),
          _featureTile(
            Icons.lock,
            _kString,
            'Guaranteed non-null value',
            'Unlike RestorableStringN, the value property always returns '
            'a String, never null. No null-checks needed.',
          ),
          SizedBox(height: 8),
          _featureTile(
            Icons.save,
            _kPrimary,
            'Survives process death',
            'When Android/iOS kills your app for memory, the String '
            'value reappears when the user returns.',
          ),
          SizedBox(height: 8),
          _featureTile(
            Icons.flash_on,
            _kAccent,
            'Zero-conversion serialization',
            'Strings are stored directly in the restoration bucket as '
            'primitive values — no JSON encoding step.',
          ),
          SizedBox(height: 8),
          _featureTile(
            Icons.notifications,
            _kWarm,
            'ChangeNotifier built-in',
            'Every value change fires listeners, so Widgets can rebuild '
            'reactively via addListener or AnimatedBuilder.',
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
          _sectionTitle('Class Hierarchy'),
          SizedBox(height: 16),
          _hierarchyNode(0, 'RestorableProperty<String>', _kTextSecondary, 'Abstract base'),
          _connector(),
          _hierarchyNode(1, 'RestorableValue<String>', _kCode, 'Adds value getter/setter'),
          _connector(),
          _hierarchyNode(2, '_RestorablePrimitiveValueN<String>', _kEmpty, 'Nullable primitive (private)'),
          _connector(),
          _hierarchyNode(3, '_RestorablePrimitiveValue<String>', _kPrimary, 'Non-null primitive (private)'),
          _connector(),
          _hierarchyNode(4, 'RestorableString', _kAccent, 'YOU ARE HERE'),
          SizedBox(height: 16),
          Text(
            'Non-null sibling classes:',
            style: TextStyle(color: _kTextSecondary, fontSize: 12),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              _siblingChip('RestorableInt'),
              _siblingChip('RestorableDouble'),
              _siblingChip('RestorableBool'),
              _siblingChip('RestorableNum'),
              _siblingChip('RestorableDateTime'),
              _siblingChip('RestorableEnum'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _hierarchyNode(int depth, String name, Color color, String desc) {
    return Padding(
      padding: EdgeInsets.only(left: depth * 18.0),
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
            Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
            SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 11)),
                  Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _connector() {
    return Padding(
      padding: EdgeInsets.only(left: 24),
      child: Container(width: 2, height: 14, color: _kDivider),
    );
  }

  Widget _siblingChip(String name) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _kPrimary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _kPrimary.withOpacity(0.3)),
      ),
      child: Text(name, style: TextStyle(color: _kPrimary, fontFamily: 'monospace', fontSize: 10)),
    );
  }

  Widget _buildAPISection() {
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
          _sectionTitle('API Surface'),
          SizedBox(height: 12),
          _apiRow('RestorableString(String default)', 'Constructor — provides the fallback value', _kString),
          _apiRow('String get value', 'Current value (always non-null)', _kPrimary),
          _apiRow('set value(String v)', 'Update value, notifies listeners', _kAccent),
          _apiRow('Object? toPrimitives()', 'Returns the String for bucket storage', _kCode),
          _apiRow('String fromPrimitives(Object?)', 'Casts stored Object? back to String', _kCode),
          _apiRow('String createDefaultValue()', 'Returns the constructor default', _kEmpty),
          _apiRow('void dispose()', 'Frees listeners (ChangeNotifier)', _kWarm),
          _apiRow('void addListener(VoidCallback)', 'Subscribe to value changes', _kString),
          _apiRow('void removeListener(VoidCallback)', 'Unsubscribe from changes', _kString),
        ],
      ),
    );
  }

  Widget _apiRow(String signature, String desc, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6, height: 6,
            margin: EdgeInsets.only(top: 6),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(signature, style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 11)),
                Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
              ],
            ),
          ),
        ],
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
          _sectionTitle('Serialization Flow'),
          SizedBox(height: 16),
          // Visual pipeline
          _pipelineStep('value = "Hello Flutter"', _kString),
          _pipelineArrow(),
          _pipelineStep('toPrimitives() → "Hello Flutter"', _kCode),
          _pipelineArrow(),
          _pipelineStep('Engine bucket stores raw String', _kPrimary),
          _pipelineArrow(),
          _pipelineStep('(app killed & relaunched)', _kWarm),
          _pipelineArrow(),
          _pipelineStep('fromPrimitives("Hello Flutter")', _kCode),
          _pipelineArrow(),
          _pipelineStep('value == "Hello Flutter" ✓', _kString),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kAccent.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'No JSON. No Base64. No conversion. The Dart String is stored '
              'as-is in the engine\'s native restoration map. This makes '
              'RestorableString one of the fastest restorable types.',
              style: TextStyle(color: _kAccent, fontSize: 11, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pipelineStep(String text, Color color) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 11),
      ),
    );
  }

  Widget _pipelineArrow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Icon(Icons.arrow_downward, color: _kDivider, size: 16),
    );
  }

  Widget _buildComparisonTable() {
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
          _sectionTitle('RestorableString vs Alternatives'),
          SizedBox(height: 12),
          // Header
          Row(
            children: [
              Expanded(flex: 3, child: Text('Feature', style: TextStyle(color: _kTextSecondary, fontSize: 11, fontWeight: FontWeight.bold))),
              Expanded(flex: 2, child: Text('String', style: TextStyle(color: _kPrimary, fontSize: 11, fontWeight: FontWeight.bold))),
              Expanded(flex: 2, child: Text('StringN', style: TextStyle(color: _kEmpty, fontSize: 11, fontWeight: FontWeight.bold))),
              Expanded(flex: 2, child: Text('TextEditing', style: TextStyle(color: _kCode, fontSize: 11, fontWeight: FontWeight.bold))),
            ],
          ),
          SizedBox(height: 6),
          Divider(color: _kDivider, height: 1),
          SizedBox(height: 6),
          _compRow('Null allowed', 'No', 'Yes', 'N/A'),
          _compRow('Default value', 'Required', 'Optional', 'Controller'),
          _compRow('Serialization', 'Direct', 'Direct', 'Custom'),
          _compRow('Listeners', 'Yes', 'Yes', 'Yes'),
          _compRow('Cursor/selection', 'No', 'No', 'Yes'),
          _compRow('Use case', 'Simple text', 'Optional text', 'Text field'),
        ],
      ),
    );
  }

  Widget _compRow(String feature, String str, String strN, String edit) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(feature, style: TextStyle(color: _kTextSecondary, fontSize: 10))),
          Expanded(flex: 2, child: Text(str, style: TextStyle(color: _kPrimary, fontFamily: 'monospace', fontSize: 10))),
          Expanded(flex: 2, child: Text(strN, style: TextStyle(color: _kEmpty, fontFamily: 'monospace', fontSize: 10))),
          Expanded(flex: 2, child: Text(edit, style: TextStyle(color: _kCode, fontFamily: 'monospace', fontSize: 10))),
        ],
      ),
    );
  }

  Widget _buildWhenToUseSection() {
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
          _sectionTitle('When to Choose RestorableString'),
          SizedBox(height: 12),
          _choiceRow(true, 'Required text that always has a value'),
          _choiceRow(true, 'Display labels, titles, user names'),
          _choiceRow(true, 'Simple string state without cursor tracking'),
          _choiceRow(true, 'App preferences stored as strings'),
          _choiceRow(false, 'Optional text that can be absent → use RestorableStringN'),
          _choiceRow(false, 'Rich text editing → use RestorableTextEditingController'),
          _choiceRow(false, 'Numeric text → use RestorableInt/RestorableDouble'),
        ],
      ),
    );
  }

  Widget _choiceRow(bool use, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            use ? Icons.check_circle : Icons.arrow_forward,
            color: use ? _kString : _kEmpty,
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

  // Shared helpers
  Widget _featureTile(IconData icon, Color color, String title, String desc) {
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
      style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}

// =============================================================================
// TAB 2: EDITOR LAB
// =============================================================================
class _EditorLabTab extends StatefulWidget {
  @override
  State<_EditorLabTab> createState() => _EditorLabTabState();
}

class _EditorLabTabState extends State<_EditorLabTab> {
  // Restorable instances
  final RestorableString _username = RestorableString('Guest');
  final RestorableString _greeting = RestorableString('Hello, World!');
  final RestorableString _note = RestorableString('');

  // Lab state
  int _selectedOpIndex = 0;

  final List<_StringOp> _operations = [
    _StringOp('toUpperCase()', (s) => s.toUpperCase(), Icons.arrow_upward),
    _StringOp('toLowerCase()', (s) => s.toLowerCase(), Icons.arrow_downward),
    _StringOp('trim()', (s) => s.trim(), Icons.content_cut),
    _StringOp('reversed', (s) => String.fromCharCodes(s.codeUnits.reversed), Icons.swap_horiz),
    _StringOp('length → String', (s) => '${s.length} chars', Icons.straighten),
    _StringOp('replaceAll vowels', (s) => s.replaceAll(RegExp('[aeiouAEIOU]'), '*'), Icons.find_replace),
  ];

  @override
  void dispose() {
    _username.dispose();
    _greeting.dispose();
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildValueInspector(),
          SizedBox(height: 20),
          _buildStringTransformLab(),
          SizedBox(height: 20),
          _buildCompositionBuilder(),
          SizedBox(height: 20),
          _buildCharacterAnalyzer(),
          SizedBox(height: 20),
          _buildSubstringExplorer(),
        ],
      ),
    );
  }

  Widget _buildValueInspector() {
    print('[EditorLab] Building value inspector');
    print('  _username: "${_username.value}"');
    print('  _greeting: "${_greeting.value}"');
    print('  _note: "${_note.value}"');

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
            'Value Inspector',
            style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'Three RestorableString instances with different defaults:',
            style: TextStyle(color: _kTextSecondary, fontSize: 12),
          ),
          SizedBox(height: 12),
          _inspectorCard(
            'RestorableString("Guest")',
            _username.value,
            _kPrimary,
            'A username — always has a value, even if just the default.',
          ),
          SizedBox(height: 8),
          _inspectorCard(
            'RestorableString("Hello, World!")',
            _greeting.value,
            _kString,
            'A greeting message — starts with a classic default.',
          ),
          SizedBox(height: 8),
          _inspectorCard(
            'RestorableString("")',
            _note.value,
            _kEmpty,
            'A note — starts empty but is never null. '
            'Empty string "" is a valid non-null value.',
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kPrimary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: _kPrimary, size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'All three are guaranteed non-null. Even the empty note '
                    'has .value == "" — it will never be null.',
                    style: TextStyle(color: _kTextPrimary, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _inspectorCard(String constructor, String value, Color color, String desc) {
    final display = value.isEmpty ? '<empty string "">' : '"$value"';
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
          Text(
            constructor,
            style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 11),
          ),
          SizedBox(height: 6),
          Row(
            children: [
              Text('.value → ', style: TextStyle(color: _kTextSecondary, fontSize: 12)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  display,
                  style: TextStyle(
                    color: color,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text(
                '(${value.length} chars)',
                style: TextStyle(color: _kTextSecondary, fontSize: 10),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildStringTransformLab() {
    final sourceValue = _greeting.value;
    final op = _operations[_selectedOpIndex];
    final result = op.transform(sourceValue);

    print('[EditorLab] Transform: ${op.label}("$sourceValue") → "$result"');

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
            'String Transform Lab',
            style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'Apply transforms to the greeting RestorableString:',
            style: TextStyle(color: _kTextSecondary, fontSize: 12),
          ),
          SizedBox(height: 12),
          // Operation selector
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: List.generate(_operations.length, (i) {
              final o = _operations[i];
              final selected = i == _selectedOpIndex;
              return GestureDetector(
                onTap: () => setState(() => _selectedOpIndex = i),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: selected ? _kAccent.withOpacity(0.2) : _kSurface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: selected ? _kAccent : _kDivider,
                      width: selected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(o.icon, size: 14, color: selected ? _kAccent : _kTextSecondary),
                      SizedBox(width: 4),
                      Text(
                        o.label,
                        style: TextStyle(
                          color: selected ? _kAccent : _kTextSecondary,
                          fontSize: 11,
                          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 16),
          // Input → Output visualization
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kDivider),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Input: ', style: TextStyle(color: _kTextSecondary, fontSize: 11)),
                    Expanded(
                      child: Text(
                        '"$sourceValue"',
                        style: TextStyle(color: _kString, fontFamily: 'monospace', fontSize: 12),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.arrow_downward, color: _kAccent, size: 14),
                    SizedBox(width: 4),
                    Text(
                      op.label,
                      style: TextStyle(color: _kAccent, fontFamily: 'monospace', fontSize: 11),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Text('Output: ', style: TextStyle(color: _kTextSecondary, fontSize: 11)),
                    Expanded(
                      child: Text(
                        '"$result"',
                        style: TextStyle(color: _kPrimary, fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.bold),
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

  Widget _buildCompositionBuilder() {
    final parts = <_CompPart>[
      _CompPart('Prefix', 'Dear ', _kPrimary),
      _CompPart('Username', _username.value, _kString),
      _CompPart('Separator', ', ', _kTextSecondary),
      _CompPart('Greeting', _greeting.value.toLowerCase(), _kAccent),
      _CompPart('Suffix', '!', _kWarm),
    ];
    final composed = parts.map((p) => p.value).join();

    print('[EditorLab] Composed message: "$composed"');

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
            'Composition Builder',
            style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'Combining multiple RestorableString values into one message:',
            style: TextStyle(color: _kTextSecondary, fontSize: 12),
          ),
          SizedBox(height: 12),
          // Parts breakdown
          ...parts.map((p) => Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                Container(
                  width: 80,
                  child: Text(p.label, style: TextStyle(color: _kTextSecondary, fontSize: 11)),
                ),
                Icon(Icons.arrow_forward, size: 12, color: _kDivider),
                SizedBox(width: 6),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: p.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '"${p.value}"',
                    style: TextStyle(color: p.color, fontFamily: 'monospace', fontSize: 11),
                  ),
                ),
              ],
            ),
          )),
          Divider(color: _kDivider, height: 20),
          // Composed result
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_kPrimary.withOpacity(0.08), _kAccent.withOpacity(0.06)],
              ),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kPrimary.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Composed result:', style: TextStyle(color: _kTextSecondary, fontSize: 11)),
                SizedBox(height: 4),
                // Colored segments
                Wrap(
                  children: parts.map((p) => Text(
                    p.value,
                    style: TextStyle(color: p.color, fontSize: 14, fontWeight: FontWeight.bold),
                  )).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharacterAnalyzer() {
    final value = _greeting.value;
    final letters = value.replaceAll(RegExp(r'[^a-zA-Z]'), '').length;
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '').length;
    final spaces = value.split(' ').length - 1;
    final punctuation = value.replaceAll(RegExp(r'[a-zA-Z0-9\s]'), '').length;

    print('[EditorLab] Character analysis of "${_greeting.value}":');
    print('  Total: ${value.length}, Letters: $letters, Digits: $digits, Spaces: $spaces');

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
            'Character Analyzer',
            style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'Breaking down the RestorableString value character by character:',
            style: TextStyle(color: _kTextSecondary, fontSize: 12),
          ),
          SizedBox(height: 12),
          // Source
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '"$value"',
              style: TextStyle(color: _kString, fontFamily: 'monospace', fontSize: 13),
            ),
          ),
          SizedBox(height: 12),
          // Stats bars
          _statBar('Total', value.length, value.length, _kTextPrimary),
          _statBar('Letters', letters, value.length, _kPrimary),
          _statBar('Digits', digits, value.length, _kAccent),
          _statBar('Spaces', spaces, value.length, _kCode),
          _statBar('Punctuation', punctuation, value.length, _kWarm),
          SizedBox(height: 12),
          // Character grid
          Wrap(
            spacing: 2,
            runSpacing: 2,
            children: value.codeUnits.map((unit) {
              final ch = String.fromCharCode(unit);
              Color bg;
              if (RegExp(r'[a-zA-Z]').hasMatch(ch)) {
                bg = _kPrimary;
              } else if (RegExp(r'[0-9]').hasMatch(ch)) {
                bg = _kAccent;
              } else if (ch == ' ') {
                bg = _kCode;
              } else {
                bg = _kWarm;
              }
              return Container(
                width: 22, height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: bg.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(color: bg.withOpacity(0.4)),
                ),
                child: Text(
                  ch == ' ' ? '·' : ch,
                  style: TextStyle(color: bg, fontSize: 11, fontFamily: 'monospace'),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _statBar(String label, int count, int total, Color color) {
    final fraction = total > 0 ? count / total : 0.0;
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(
            width: 80,
            child: Text(label, style: TextStyle(color: _kTextSecondary, fontSize: 11)),
          ),
          Expanded(
            child: Container(
              height: 14,
              decoration: BoxDecoration(
                color: _kSurface,
                borderRadius: BorderRadius.circular(7),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: fraction,
                child: Container(
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Container(
            width: 30,
            alignment: Alignment.centerRight,
            child: Text(
              '$count',
              style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubstringExplorer() {
    final value = _greeting.value;
    final hasSpace = value.contains(' ');
    final words = hasSpace ? value.split(' ') : [value];
    final firstThree = value.length >= 3 ? value.substring(0, 3) : value;
    final lastThree = value.length >= 3 ? value.substring(value.length - 3) : value;

    print('[EditorLab] Substring explorer:');
    print('  Words: $words, First 3: "$firstThree", Last 3: "$lastThree"');

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
            'Substring Explorer',
            style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          _substringRow('Full', '"$value"', _kString),
          _substringRow('First 3', '"$firstThree"', _kPrimary),
          _substringRow('Last 3', '"$lastThree"', _kAccent),
          _substringRow('Words', '${words.length} word${words.length == 1 ? "" : "s"}', _kCode),
          SizedBox(height: 12),
          // Word chips
          if (words.isNotEmpty) ...[
            Text('Word breakdown:', style: TextStyle(color: _kTextSecondary, fontSize: 11)),
            SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: List.generate(words.length, (i) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: _kPrimary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _kPrimary.withOpacity(0.3)),
                  ),
                  child: Text(
                    '#${i + 1}: "${words[i]}"',
                    style: TextStyle(color: _kPrimary, fontFamily: 'monospace', fontSize: 11),
                  ),
                );
              }),
            ),
          ],
        ],
      ),
    );
  }

  Widget _substringRow(String label, String value, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Container(
            width: 60,
            child: Text(label, style: TextStyle(color: _kTextSecondary, fontSize: 11)),
          ),
          Icon(Icons.arrow_forward, size: 12, color: _kDivider),
          SizedBox(width: 6),
          Text(
            value,
            style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 3: USE CASES
// =============================================================================
class _UseCasesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUsernameCase(),
          SizedBox(height: 20),
          _buildFormFieldCase(),
          SizedBox(height: 20),
          _buildSearchQueryCase(),
          SizedBox(height: 20),
          _buildPreferenceCase(),
          SizedBox(height: 20),
          _buildRegistrationPattern(),
          SizedBox(height: 20),
          _buildBestPractices(),
        ],
      ),
    );
  }

  Widget _buildUsernameCase() {
    return _useCaseCard(
      'User Profile Display',
      Icons.person,
      _kPrimary,
      'final _displayName = RestorableString("Anonymous");',
      'A chat app displays the user\'s chosen display name. The name '
      'defaults to "Anonymous" but can be changed. After an app restart '
      'caused by the OS, the name reappears without re-fetching from the server.',
      _buildProfileSimulation(),
    );
  }

  Widget _buildProfileSimulation() {
    final profiles = <_ProfileSim>[
      _ProfileSim('Initial', 'Anonymous', _kTextSecondary),
      _ProfileSim('User sets', 'Alexis', _kString),
      _ProfileSim('App restart', 'Alexis', _kString),
      _ProfileSim('User changes', 'Alex_Dev', _kPrimary),
      _ProfileSim('App restart', 'Alex_Dev', _kPrimary),
    ];
    return Column(
      children: profiles.map((p) {
        return Padding(
          padding: EdgeInsets.only(bottom: 4),
          child: Row(
            children: [
              Container(
                width: 8, height: 8,
                decoration: BoxDecoration(color: p.color, shape: BoxShape.circle),
              ),
              SizedBox(width: 6),
              Container(
                width: 90,
                child: Text(p.label, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
              ),
              Icon(Icons.arrow_forward, size: 10, color: _kDivider),
              SizedBox(width: 4),
              // Profile chip
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: p.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: p.color.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person, size: 12, color: p.color),
                    SizedBox(width: 4),
                    Text(p.value, style: TextStyle(color: p.color, fontSize: 11)),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFormFieldCase() {
    return _useCaseCard(
      'Form Field State',
      Icons.edit,
      _kString,
      'final _email = RestorableString("");',
      'A registration form with an email field. The field starts empty '
      '(not null — empty string is the initial state). As the user types, '
      'the RestorableString updates. If the OS kills the app mid-form, '
      'the partially typed email is restored.',
      _buildFormSimulation(),
    );
  }

  Widget _buildFormSimulation() {
    final steps = <_FormStep>[
      _FormStep('Start', '', 'Empty — typing not started', _kTextSecondary),
      _FormStep('Typing...', 'user@', 'Partial input', _kEmpty),
      _FormStep('More...', 'user@example', 'Still typing', _kAccent),
      _FormStep('Done', 'user@example.com', 'Complete email', _kString),
      _FormStep('Restored', 'user@example.com', 'After app restart', _kPrimary),
    ];
    return Column(
      children: steps.map((s) {
        return Padding(
          padding: EdgeInsets.only(bottom: 4),
          child: Row(
            children: [
              Container(
                width: 70,
                child: Text(s.label, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _kSurface,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: s.color.withOpacity(0.3)),
                  ),
                  child: Text(
                    s.value.isEmpty ? '|' : s.value,
                    style: TextStyle(
                      color: s.value.isEmpty ? _kTextSecondary.withOpacity(0.5) : s.color,
                      fontFamily: 'monospace',
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 6),
              Container(
                width: 100,
                child: Text(s.note, style: TextStyle(color: _kTextSecondary, fontSize: 9)),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSearchQueryCase() {
    return _useCaseCard(
      'Active Search Query',
      Icons.search,
      _kCode,
      'final _query = RestorableString("");',
      'A product catalog with a search bar. The query starts empty, '
      'representing "show all products." As the user types, results '
      'filter. On restoration, the search query and filter state reappear.',
      _buildSearchSimulation(),
    );
  }

  Widget _buildSearchSimulation() {
    final queries = <_SearchSim>[
      _SearchSim('', 'Show all (42 items)', Icons.grid_view, _kTextSecondary),
      _SearchSim('sh', 'Filtered (8 items)', Icons.filter_list, _kAccent),
      _SearchSim('shoe', 'Filtered (3 items)', Icons.filter_list, _kPrimary),
      _SearchSim('shoes red', 'Filtered (1 item)', Icons.filter_list, _kString),
    ];
    return Column(
      children: queries.map((q) {
        return Padding(
          padding: EdgeInsets.only(bottom: 6),
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: q.color.withOpacity(0.05),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: q.color.withOpacity(0.15)),
            ),
            child: Row(
              children: [
                Icon(Icons.search, size: 14, color: q.color),
                SizedBox(width: 6),
                Container(
                  width: 90,
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _kSurface,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    q.query.isEmpty ? '...' : q.query,
                    style: TextStyle(
                      color: q.query.isEmpty ? _kTextSecondary.withOpacity(0.4) : q.color,
                      fontFamily: 'monospace',
                      fontSize: 10,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Icon(q.icon, size: 14, color: q.color),
                SizedBox(width: 4),
                Expanded(
                  child: Text(q.result, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPreferenceCase() {
    return _useCaseCard(
      'App Preferences',
      Icons.settings,
      _kWarm,
      'final _theme = RestorableString("system");',
      'An app setting for theme mode stored as a string — "light", "dark", '
      'or "system". The RestorableString holds the current choice. On restart, '
      'the correct theme is applied immediately without reading SharedPreferences.',
      _buildPreferenceSimulation(),
    );
  }

  Widget _buildPreferenceSimulation() {
    final prefs = <_PrefSim>[
      _PrefSim('system', 'System Default', Icons.brightness_auto, _kTextSecondary),
      _PrefSim('light', 'Light Theme', Icons.brightness_high, _kAccent),
      _PrefSim('dark', 'Dark Theme', Icons.brightness_2, _kPrimary),
    ];
    return Row(
      children: prefs.map((p) {
        return Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 3),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: p.color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: p.color.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Icon(p.icon, color: p.color, size: 24),
                SizedBox(height: 4),
                Text(p.label, style: TextStyle(color: p.color, fontSize: 10), textAlign: TextAlign.center),
                SizedBox(height: 2),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _kSurface,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '"${p.value}"',
                    style: TextStyle(color: p.color, fontFamily: 'monospace', fontSize: 9),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRegistrationPattern() {
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
              Icon(Icons.code, color: _kAccent, size: 20),
              SizedBox(width: 8),
              Text(
                'Full Registration Pattern',
                style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kDivider),
            ),
            child: Text(
              'class _MyFormState extends State<MyForm>\n'
              '    with RestorationMixin {\n'
              '\n'
              '  final _name = RestorableString("Guest");\n'
              '  final _email = RestorableString("");\n'
              '  final _city = RestorableString("New York");\n'
              '\n'
              '  @override\n'
              '  String? get restorationId => "my_form";\n'
              '\n'
              '  @override\n'
              '  void restoreState(\n'
              '    RestorationBucket? oldBucket,\n'
              '    bool initialRestore,\n'
              '  ) {\n'
              '    registerForRestoration(_name, "nm");\n'
              '    registerForRestoration(_email, "em");\n'
              '    registerForRestoration(_city, "ct");\n'
              '  }\n'
              '\n'
              '  @override\n'
              '  void dispose() {\n'
              '    _name.dispose();\n'
              '    _email.dispose();\n'
              '    _city.dispose();\n'
              '    super.dispose();\n'
              '  }\n'
              '}',
              style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 11, height: 1.5),
            ),
          ),
          SizedBox(height: 12),
          _regStep('1', 'Declare fields with sensible defaults', _kPrimary),
          _regStep('2', 'Return a unique restorationId', _kString),
          _regStep('3', 'Register each property with a unique key', _kCode),
          _regStep('4', 'Dispose all properties in State.dispose()', _kWarm),
        ],
      ),
    );
  }

  Widget _regStep(String num, String text, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
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

  Widget _buildBestPractices() {
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
              Icon(Icons.star, color: _kAccent, size: 20),
              SizedBox(width: 8),
              Text(
                'Best Practices & Pitfalls',
                style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 12),
          _tipRow(true, 'Use meaningful defaults that make sense for your UI'),
          _tipRow(true, 'Keep restoration keys short but unique within the widget'),
          _tipRow(true, 'Always call dispose() to free ChangeNotifier resources'),
          _tipRow(true, 'Use RestorableString for required fields; StringN for optional'),
          _tipRow(true, 'Add listeners if sibling widgets react to value changes'),
          Divider(color: _kDivider, height: 20),
          _tipRow(false, 'Forgetting dispose() — listeners leak memory'),
          _tipRow(false, 'Using duplicate restoration keys — silent overwrites'),
          _tipRow(false, 'Setting value to a computed String every build — infinite loops'),
          _tipRow(false, 'Using RestorableString when null is a valid state'),
          _tipRow(false, 'Storing large text (megabytes) — bucket size limits apply'),
        ],
      ),
    );
  }

  Widget _tipRow(bool good, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            good ? Icons.check_circle : Icons.cancel,
            color: good ? _kString : _kWarm,
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

  Widget _useCaseCard(String title, IconData icon, Color color, String code,
      String explanation, Widget simulation) {
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
              Icon(icon, color: color, size: 22),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              code,
              style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 11),
            ),
          ),
          SizedBox(height: 8),
          Text(
            explanation,
            style: TextStyle(color: _kTextSecondary, fontSize: 12, height: 1.4),
          ),
          SizedBox(height: 12),
          simulation,
        ],
      ),
    );
  }
}

// =============================================================================
// HELPER CLASSES
// =============================================================================
class _StringOp {
  final String label;
  final String Function(String) transform;
  final IconData icon;
  _StringOp(this.label, this.transform, this.icon);
}

class _CompPart {
  final String label;
  final String value;
  final Color color;
  _CompPart(this.label, this.value, this.color);
}

class _ProfileSim {
  final String label;
  final String value;
  final Color color;
  _ProfileSim(this.label, this.value, this.color);
}

class _FormStep {
  final String label;
  final String value;
  final String note;
  final Color color;
  _FormStep(this.label, this.value, this.note, this.color);
}

class _SearchSim {
  final String query;
  final String result;
  final IconData icon;
  final Color color;
  _SearchSim(this.query, this.result, this.icon, this.color);
}

class _PrefSim {
  final String value;
  final String label;
  final IconData icon;
  final Color color;
  _PrefSim(this.value, this.label, this.icon, this.color);
}
