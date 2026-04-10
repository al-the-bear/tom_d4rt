// Deep visual test for RestorableValue
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, unintended_html_in_doc_comment

import 'package:flutter/material.dart';

/// Deep visual exploration of RestorableValue<T>
/// The abstract base class that bridges RestorableProperty with a typed
/// value getter/setter. All concrete restorable types extend this.
///
/// RestorableValue<T> provides:
/// - T get value / set value(T) for direct access
/// - didUpdateValue(T? oldValue) callback on changes
/// - Foundation for all 15+ concrete RestorableXxx classes
///
/// You never instantiate RestorableValue directly — you use its subclasses.
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF0F0A1A),
    ),
    home: _RestorableValueDemo(),
  );
}

// =============================================================================
// PALETTE: DeepPurple 500 / Lime A400
// =============================================================================
const Color _kPrimary = Color(0xFF673AB7); // DeepPurple 500
const Color _kAccent = Color(0xFFC6FF00); // Lime A400
const Color _kSurface = Color(0xFF1A1230);
const Color _kCardBg = Color(0xFF251A3A);
const Color _kTextPrimary = Color(0xFFEDE8F4);
const Color _kTextSecondary = Color(0xFFB8A8D0);
const Color _kDivider = Color(0xFF3D2E5A);
const Color _kAbstract = Color(0xFF7E57C2); // DeepPurple 400
const Color _kConcrete = Color(0xFF66BB6A); // Green 400
const Color _kMethod = Color(0xFF29B6F6); // LightBlue 400
const Color _kLifecycle = Color(0xFFFF7043); // DeepOrange 400
const Color _kCustom = Color(0xFFFFCA28); // Amber 400

// =============================================================================
// MAIN DEMO
// =============================================================================
class _RestorableValueDemo extends StatefulWidget {
  @override
  State<_RestorableValueDemo> createState() => _RestorableValueDemoState();
}

class _RestorableValueDemoState extends State<_RestorableValueDemo>
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
        title: Text('RestorableValue Deep Dive'),
        backgroundColor: _kPrimary,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kTextSecondary,
          tabs: [
            Tab(icon: Icon(Icons.description), text: 'Contract'),
            Tab(icon: Icon(Icons.grid_view), text: 'Catalog'),
            Tab(icon: Icon(Icons.build), text: 'Custom Builder'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _ContractTab(),
          _CatalogTab(),
          _CustomBuilderTab(),
        ],
      ),
    );
  }
}

// =============================================================================
// TAB 1: CONTRACT
// =============================================================================
class _ContractTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderCard(),
          SizedBox(height: 20),
          _buildWhatItAdds(),
          SizedBox(height: 20),
          _buildValueAccessorSection(),
          SizedBox(height: 20),
          _buildDidUpdateValueSection(),
          SizedBox(height: 20),
          _buildAbstractMethodsSection(),
          SizedBox(height: 20),
          _buildHierarchyPosition(),
          SizedBox(height: 20),
          _buildChangeNotifierSection(),
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
          colors: [_kPrimary.withOpacity(0.35), _kAccent.withOpacity(0.1)],
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
              Icon(Icons.architecture, color: _kAbstract, size: 32),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'RestorableValue<T>',
                      style: TextStyle(
                        color: _kTextPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: _kAbstract.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'ABSTRACT',
                        style: TextStyle(color: _kAbstract, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'The intermediate abstract class between RestorableProperty<T> '
            'and the concrete types. RestorableValue adds the critical '
            'value getter/setter pair, transforming an opaque restorable '
            'property into a typed, directly accessible value holder.',
            style: TextStyle(color: _kTextSecondary, fontSize: 14, height: 1.5),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _kAbstract.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'abstract class RestorableValue<T> extends RestorableProperty<T>',
              style: TextStyle(color: _kMethod, fontFamily: 'monospace', fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhatItAdds() {
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
          _sectionTitle('What RestorableValue Adds to RestorableProperty'),
          SizedBox(height: 12),
          Text(
            'RestorableProperty is pure plumbing — it handles serialization, '
            'bucket management, and listener wiring. But it cannot read or '
            'write the value directly. RestorableValue bridges that gap:',
            style: TextStyle(color: _kTextSecondary, fontSize: 13, height: 1.4),
          ),
          SizedBox(height: 16),
          // Side-by-side comparison
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _layerCard(
                  'RestorableProperty<T>',
                  _kTextSecondary,
                  [
                    'createDefaultValue()',
                    'fromPrimitives()',
                    'toPrimitives()',
                    'initWithValue()',
                    'enabled/enabled=',
                    'dispose()',
                  ],
                ),
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  SizedBox(height: 30),
                  Icon(Icons.add_circle, color: _kAccent, size: 20),
                ],
              ),
              SizedBox(width: 10),
              Expanded(
                child: _layerCard(
                  'RestorableValue<T>',
                  _kAbstract,
                  [
                    'T get value',
                    'set value(T)',
                    'didUpdateValue(T? old)',
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _layerCard(String title, Color color, List<String> items) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 10, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ...items.map((item) => Padding(
            padding: EdgeInsets.only(bottom: 3),
            child: Row(
              children: [
                Container(width: 4, height: 4, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                SizedBox(width: 6),
                Flexible(
                  child: Text(
                    item,
                    style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 10),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildValueAccessorSection() {
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
          _sectionTitle('The value Getter/Setter'),
          SizedBox(height: 16),
          // Getter
          _accessorCard(
            'T get value',
            _kConcrete,
            Icons.visibility,
            'Returns the current wrapped value. Can only be called after '
            'the property has been registered with a RestorationMixin. '
            'Calling before registration throws an assertion error.',
          ),
          SizedBox(height: 10),
          // Setter
          _accessorCard(
            'set value(T newValue)',
            _kLifecycle,
            Icons.edit,
            'Updates the wrapped value. If the new value differs from the '
            'old value (using != comparison), the framework calls '
            'didUpdateValue(oldValue) and marks the restoration bucket dirty.',
          ),
          SizedBox(height: 16),
          // Flow diagram
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
                  'Setter call flow:',
                  style: TextStyle(color: _kAccent, fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                _flowStep('1. prop.value = newVal', _kConcrete),
                _flowStep('2. if (newVal != oldVal)', _kMethod),
                _flowStep('3.   _value = newVal', _kConcrete),
                _flowStep('4.   didUpdateValue(oldVal)', _kLifecycle),
                _flowStep('5.   → notifyListeners()', _kCustom),
                _flowStep('6.   → bucket update dirty', _kAbstract),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _accessorCard(String signature, Color color, IconData icon, String desc) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  signature,
                  style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 12, height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _flowStep(String text, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2),
      child: Text(
        text,
        style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 10),
      ),
    );
  }

  Widget _buildDidUpdateValueSection() {
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
          _sectionTitle('didUpdateValue(T? oldValue)'),
          SizedBox(height: 12),
          Text(
            'This is the abstract callback that subclasses must implement. '
            'It fires whenever the value changes — either from a direct '
            'set or from restoration.',
            style: TextStyle(color: _kTextSecondary, fontSize: 13, height: 1.4),
          ),
          SizedBox(height: 16),
          // When it fires
          _triggerRow(
            'value = newVal',
            'Direct assignment by app code',
            _kConcrete,
          ),
          _triggerRow(
            'fromPrimitives(data)',
            'Restoration from bucket after app restart',
            _kLifecycle,
          ),
          _triggerRow(
            'initWithValue(val)',
            'First initialization during registration',
            _kMethod,
          ),
          SizedBox(height: 16),
          // What subclasses do
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kCustom.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What subclasses typically do in didUpdateValue:',
                  style: TextStyle(color: _kCustom, fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                _bulletRow('Call notifyListeners() so UI rebuilds'),
                _bulletRow('Log the change for debugging'),
                _bulletRow('Validate the new value'),
                _bulletRow('Update dependent computed values'),
              ],
            ),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kDivider),
            ),
            child: Text(
              '@override\n'
              'void didUpdateValue(T? oldValue) {\n'
              '  notifyListeners(); // Standard pattern\n'
              '}',
              style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 11, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _triggerRow(String trigger, String desc, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.bolt, color: color, size: 16),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(trigger, style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 11)),
                Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bulletRow(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Text('• ', style: TextStyle(color: _kCustom, fontSize: 12)),
          Expanded(
            child: Text(text, style: TextStyle(color: _kTextPrimary, fontSize: 11)),
          ),
        ],
      ),
    );
  }

  Widget _buildAbstractMethodsSection() {
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
          _sectionTitle('Full Abstract Method Contract'),
          SizedBox(height: 4),
          Text(
            'To implement a custom RestorableValue subclass, implement all of:',
            style: TextStyle(color: _kTextSecondary, fontSize: 12),
          ),
          SizedBox(height: 16),
          _methodCard(
            'T createDefaultValue()',
            'Creates the initial value before any restoration data is available.',
            'return 0; // for a RestorableInt',
            _kConcrete,
          ),
          SizedBox(height: 8),
          _methodCard(
            'T fromPrimitives(Object? data)',
            'Deserializes the value from the restoration bucket. '
            'The data is whatever toPrimitives() previously stored.',
            'return data as int; // cast back',
            _kMethod,
          ),
          SizedBox(height: 8),
          _methodCard(
            'Object? toPrimitives()',
            'Serializes the current value for bucket storage. '
            'Must return a primitive type (String, int, double, bool, null, List, Map).',
            'return value; // direct for primitives',
            _kLifecycle,
          ),
          SizedBox(height: 8),
          _methodCard(
            'void didUpdateValue(T? oldValue)',
            'Called after the value changes. oldValue is the previous value, '
            'or null if this is the initial value.',
            'notifyListeners();',
            _kCustom,
          ),
        ],
      ),
    );
  }

  Widget _methodCard(String signature, String desc, String example, Color color) {
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
            signature,
            style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 11, height: 1.3)),
          SizedBox(height: 4),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              example,
              style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHierarchyPosition() {
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
          _sectionTitle('Position in the Hierarchy'),
          SizedBox(height: 16),
          _hierarchyNode(0, 'ChangeNotifier', _kTextSecondary, 'Listener management'),
          _connector(),
          _hierarchyNode(1, 'RestorableProperty<T>', _kTextSecondary, 'Serialization + bucket'),
          _connector(),
          _hierarchyNode(2, 'RestorableValue<T>', _kAbstract, 'YOU ARE HERE — adds value accessors'),
          _connector(),
          // Branches
          Padding(
            padding: EdgeInsets.only(left: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _branchChip('_RestorablePrimitiveValueN<T>', _kMethod),
                    SizedBox(width: 6),
                    Text('→ nullable primitives', style: TextStyle(color: _kTextSecondary, fontSize: 9)),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    _branchChip('_RestorablePrimitiveValue<T>', _kConcrete),
                    SizedBox(width: 6),
                    Text('→ non-null primitives', style: TextStyle(color: _kTextSecondary, fontSize: 9)),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    _branchChip('RestorableTextEditingController', _kLifecycle),
                    SizedBox(width: 6),
                    Text('→ custom', style: TextStyle(color: _kTextSecondary, fontSize: 9)),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    _branchChip('RestorableDateTime / DateTimeN', _kCustom),
                    SizedBox(width: 6),
                    Text('→ date values', style: TextStyle(color: _kTextSecondary, fontSize: 9)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _hierarchyNode(int depth, String name, Color color, String desc) {
    return Padding(
      padding: EdgeInsets.only(left: depth * 20.0),
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

  Widget _branchChip(String name, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(name, style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 9)),
    );
  }

  Widget _buildChangeNotifierSection() {
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
          _sectionTitle('ChangeNotifier Heritage'),
          SizedBox(height: 12),
          Text(
            'Every RestorableValue is also a ChangeNotifier. This means:',
            style: TextStyle(color: _kTextSecondary, fontSize: 13, height: 1.4),
          ),
          SizedBox(height: 12),
          _notifierFact(Icons.add_alert, _kConcrete, 'addListener(VoidCallback) — get notified on every change'),
          _notifierFact(Icons.remove_circle_outline, _kLifecycle, 'removeListener(VoidCallback) — stop listening'),
          _notifierFact(Icons.campaign, _kCustom, 'notifyListeners() — called from didUpdateValue'),
          _notifierFact(Icons.delete_forever, _kMethod, 'dispose() — clears all listeners and resources'),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kAccent.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'This makes RestorableValue work seamlessly with '
              'AnimatedBuilder, ValueListenableBuilder (via adaptation), '
              'and any widget that reacts to ChangeNotifier updates.',
              style: TextStyle(color: _kAccent, fontSize: 11, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _notifierFact(IconData icon, Color color, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18),
          SizedBox(width: 8),
          Expanded(
            child: Text(text, style: TextStyle(color: _kTextPrimary, fontSize: 12, height: 1.3)),
          ),
        ],
      ),
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
// TAB 2: SUBCLASS CATALOG
// =============================================================================
class _CatalogTab extends StatefulWidget {
  @override
  State<_CatalogTab> createState() => _CatalogTabState();
}

class _CatalogTabState extends State<_CatalogTab> {
  String _filter = 'all';

  final List<_SubclassInfo> _subclasses = [
    _SubclassInfo('RestorableInt', 'int', false, 'Integer counter, page index', _kConcrete),
    _SubclassInfo('RestorableIntN', 'int?', true, 'Optional integer, nullable score', _kMethod),
    _SubclassInfo('RestorableDouble', 'double', false, 'Slider value, opacity', _kConcrete),
    _SubclassInfo('RestorableDoubleN', 'double?', true, 'Optional progress, nullable rating', _kMethod),
    _SubclassInfo('RestorableNum', 'num', false, 'Generic numeric value', _kConcrete),
    _SubclassInfo('RestorableNumN', 'num?', true, 'Optional generic number', _kMethod),
    _SubclassInfo('RestorableString', 'String', false, 'Username, query, label', _kConcrete),
    _SubclassInfo('RestorableStringN', 'String?', true, 'Optional search, cleared field', _kMethod),
    _SubclassInfo('RestorableBool', 'bool', false, 'Toggle, checkbox state', _kConcrete),
    _SubclassInfo('RestorableBoolN', 'bool?', true, 'Tri-state checkbox', _kMethod),
    _SubclassInfo('RestorableDateTime', 'DateTime', false, 'Selected date, timestamp', _kConcrete),
    _SubclassInfo('RestorableDateTimeN', 'DateTime?', true, 'Optional deadline, cleared date', _kMethod),
    _SubclassInfo('RestorableEnum', 'Enum', false, 'Tab selection, theme mode', _kConcrete),
    _SubclassInfo('RestorableEnumN', 'Enum?', true, 'Optional filter, cleared selection', _kMethod),
    _SubclassInfo('RestorableTextEditingController', 'TextEditingController', false, 'Text field with cursor/selection', _kLifecycle),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _filter == 'all'
        ? _subclasses
        : _filter == 'nullable'
            ? _subclasses.where((s) => s.nullable).toList()
            : _subclasses.where((s) => !s.nullable).toList();

    print('[Catalog] Showing ${filtered.length} subclasses (filter: $_filter)');

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOverviewCard(),
          SizedBox(height: 16),
          _buildFilterRow(),
          SizedBox(height: 16),
          ...filtered.map((s) => Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: _buildSubclassCard(s),
          )),
          SizedBox(height: 16),
          _buildStatisticsCard(filtered),
        ],
      ),
    );
  }

  Widget _buildOverviewCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kAbstract.withOpacity(0.15), _kAccent.withOpacity(0.06)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kAbstract.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Complete Subclass Catalog',
            style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Flutter provides ${_subclasses.length} concrete subclasses of '
            'RestorableValue, covering all common primitive types.',
            style: TextStyle(color: _kTextSecondary, fontSize: 13),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              _countChip('${_subclasses.where((s) => !s.nullable).length}', 'Non-null', _kConcrete),
              SizedBox(width: 8),
              _countChip('${_subclasses.where((s) => s.nullable).length}', 'Nullable', _kMethod),
              SizedBox(width: 8),
              _countChip('1', 'Special', _kLifecycle),
            ],
          ),
        ],
      ),
    );
  }

  Widget _countChip(String count, String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(count, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14)),
          SizedBox(width: 4),
          Text(label, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildFilterRow() {
    return Row(
      children: [
        Text('Filter: ', style: TextStyle(color: _kTextSecondary, fontSize: 12)),
        SizedBox(width: 8),
        _filterChip('all', 'All'),
        SizedBox(width: 6),
        _filterChip('nonnull', 'Non-null'),
        SizedBox(width: 6),
        _filterChip('nullable', 'Nullable'),
      ],
    );
  }

  Widget _filterChip(String key, String label) {
    final selected = _filter == key;
    return GestureDetector(
      onTap: () => setState(() => _filter = key),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? _kPrimary.withOpacity(0.25) : _kSurface,
          borderRadius: BorderRadius.circular(16),
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

  Widget _buildSubclassCard(_SubclassInfo info) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: info.color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: info.color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          // Type badge
          Container(
            width: 36, height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: info.color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              info.nullable ? 'N' : 'T',
              style: TextStyle(color: info.color, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  info.name,
                  style: TextStyle(color: info.color, fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: _kSurface,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        info.valueType,
                        style: TextStyle(color: _kTextSecondary, fontFamily: 'monospace', fontSize: 10),
                      ),
                    ),
                    SizedBox(width: 8),
                    if (info.nullable)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                        decoration: BoxDecoration(
                          color: _kCustom.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'nullable',
                          style: TextStyle(color: _kCustom, fontSize: 9),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 4),
                Text(info.useCases, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsCard(List<_SubclassInfo> filtered) {
    final nonNullCount = filtered.where((s) => !s.nullable).length;
    final nullableCount = filtered.where((s) => s.nullable).length;

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
            'Type Distribution',
            style: TextStyle(color: _kTextPrimary, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          // Visual bar
          Container(
            height: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Row(
                children: [
                  if (nonNullCount > 0)
                    Expanded(
                      flex: nonNullCount,
                      child: Container(color: _kConcrete.withOpacity(0.6)),
                    ),
                  if (nullableCount > 0)
                    Expanded(
                      flex: nullableCount,
                      child: Container(color: _kMethod.withOpacity(0.6)),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _legendItem(_kConcrete, 'Non-null ($nonNullCount)'),
              _legendItem(_kMethod, 'Nullable ($nullableCount)'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
        SizedBox(width: 4),
        Text(label, style: TextStyle(color: _kTextSecondary, fontSize: 11)),
      ],
    );
  }
}

// =============================================================================
// TAB 3: CUSTOM BUILDER
// =============================================================================
class _CustomBuilderTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIntroCard(),
          SizedBox(height: 20),
          _buildStep1(),
          SizedBox(height: 16),
          _buildStep2(),
          SizedBox(height: 16),
          _buildStep3(),
          SizedBox(height: 16),
          _buildStep4(),
          SizedBox(height: 16),
          _buildStep5(),
          SizedBox(height: 20),
          _buildFullExample(),
          SizedBox(height: 20),
          _buildChecklist(),
          SizedBox(height: 20),
          _buildTipsSection(),
        ],
      ),
    );
  }

  Widget _buildIntroCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_kCustom.withOpacity(0.15), _kPrimary.withOpacity(0.08)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kCustom.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.build, color: _kCustom, size: 24),
              SizedBox(width: 10),
              Text(
                'Building a Custom RestorableValue',
                style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'When the built-in types do not cover your needs, you can create '
            'your own RestorableValue subclass. This step-by-step guide shows '
            'how to build a RestorableColor for storing Color values.',
            style: TextStyle(color: _kTextSecondary, fontSize: 13, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildStep1() {
    return _stepCard(
      '1',
      'Extend RestorableValue<T>',
      _kConcrete,
      'Choose your value type T. For a custom Color restorable:',
      'class RestorableColor extends RestorableValue<Color> {\n'
      '  RestorableColor(Color defaultValue)\n'
      '      : _defaultValue = defaultValue;\n'
      '\n'
      '  final Color _defaultValue;\n'
      '}',
    );
  }

  Widget _buildStep2() {
    return _stepCard(
      '2',
      'Implement createDefaultValue()',
      _kMethod,
      'Return the value to use when no restoration data is available:',
      '@override\n'
      'Color createDefaultValue() => _defaultValue;',
    );
  }

  Widget _buildStep3() {
    return _stepCard(
      '3',
      'Implement toPrimitives()',
      _kLifecycle,
      'Serialize the Color to a bucket-compatible primitive. '
      'Only String, int, double, bool, null, List, and Map are allowed:',
      '@override\n'
      'Object toPrimitives() => value.value; // int',
    );
  }

  Widget _buildStep4() {
    return _stepCard(
      '4',
      'Implement fromPrimitives()',
      _kAbstract,
      'Deserialize the primitive back into a Color:',
      '@override\n'
      'Color fromPrimitives(Object? data) {\n'
      '  return Color(data! as int);\n'
      '}',
    );
  }

  Widget _buildStep5() {
    return _stepCard(
      '5',
      'Implement didUpdateValue()',
      _kCustom,
      'Notify listeners when the value changes — this drives UI rebuilds:',
      '@override\n'
      'void didUpdateValue(Color? oldValue) {\n'
      '  notifyListeners();\n'
      '}',
    );
  }

  Widget _stepCard(String num, String title, Color color, String desc, String code) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28, height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                child: Text(num, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(title, style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 12, height: 1.3)),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kDivider),
            ),
            child: Text(
              code,
              style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 11, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullExample() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kAccent.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.code, color: _kAccent, size: 20),
              SizedBox(width: 8),
              Text(
                'Complete RestorableColor Example',
                style: TextStyle(color: _kTextPrimary, fontSize: 14, fontWeight: FontWeight.bold),
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
              'class RestorableColor extends RestorableValue<Color> {\n'
              '  RestorableColor(Color defaultValue)\n'
              '      : _defaultValue = defaultValue;\n'
              '\n'
              '  final Color _defaultValue;\n'
              '\n'
              '  @override\n'
              '  Color createDefaultValue() => _defaultValue;\n'
              '\n'
              '  @override\n'
              '  Object toPrimitives() => value.value;\n'
              '\n'
              '  @override\n'
              '  Color fromPrimitives(Object? data) {\n'
              '    return Color(data! as int);\n'
              '  }\n'
              '\n'
              '  @override\n'
              '  void didUpdateValue(Color? oldValue) {\n'
              '    notifyListeners();\n'
              '  }\n'
              '}',
              style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 11, height: 1.5),
            ),
          ),
          SizedBox(height: 12),
          // Usage example
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
                  'Usage in a StatefulWidget:',
                  style: TextStyle(color: _kPrimary, fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                Text(
                  'final _bg = RestorableColor(Colors.blue);\n'
                  '\n'
                  'void restoreState(...) {\n'
                  '  registerForRestoration(_bg, "bgColor");\n'
                  '}\n'
                  '\n'
                  '// Change: _bg.value = Colors.red;\n'
                  '// Read:   Container(color: _bg.value)',
                  style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 10, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklist() {
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
              Icon(Icons.checklist, color: _kConcrete, size: 20),
              SizedBox(width: 8),
              Text(
                'Implementation Checklist',
                style: TextStyle(color: _kTextPrimary, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 12),
          _checkItem(true, 'Extend RestorableValue<YourType>'),
          _checkItem(true, 'Implement createDefaultValue()'),
          _checkItem(true, 'Implement toPrimitives() → primitive'),
          _checkItem(true, 'Implement fromPrimitives(Object?) → YourType'),
          _checkItem(true, 'Implement didUpdateValue() with notifyListeners()'),
          _checkItem(true, 'Store constructor default in a final field'),
          _checkItem(true, 'Only use bucket-compatible types in toPrimitives'),
          _checkItem(false, 'Do NOT store mutable objects directly'),
          _checkItem(false, 'Do NOT forget notifyListeners in didUpdateValue'),
          _checkItem(false, 'Do NOT return non-primitive types from toPrimitives'),
        ],
      ),
    );
  }

  Widget _checkItem(bool ok, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            ok ? Icons.check_box : Icons.dangerous,
            color: ok ? _kConcrete : _kLifecycle,
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

  Widget _buildTipsSection() {
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
              Icon(Icons.tips_and_updates, color: _kAccent, size: 20),
              SizedBox(width: 8),
              Text(
                'Tips for Custom RestorableValue',
                style: TextStyle(color: _kTextPrimary, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 12),
          _tipRow(
            'Immutable values',
            'Store immutable objects (like Color, DateTime, Offset). '
            'Mutable objects can change without triggering didUpdateValue.',
            _kConcrete,
          ),
          _tipRow(
            'Serialization size',
            'Keep toPrimitives output small. The restoration bucket has '
            'size limits on some platforms.',
            _kLifecycle,
          ),
          _tipRow(
            'Error handling',
            'fromPrimitives receives whatever was stored. Add null checks '
            'or fall back to createDefaultValue if data is corrupted.',
            _kCustom,
          ),
          _tipRow(
            'Equality',
            'The setter uses != to decide whether didUpdateValue fires. '
            'Ensure your type has correct == and hashCode.',
            _kMethod,
          ),
          _tipRow(
            'Testing',
            'Test the roundtrip: create → toPrimitives → fromPrimitives '
            '→ verify equality. This catches serialization bugs early.',
            _kAbstract,
          ),
        ],
      ),
    );
  }

  Widget _tipRow(String title, String desc, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
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
                Text(title, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
                Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 11, height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// HELPER CLASSES
// =============================================================================
class _SubclassInfo {
  final String name;
  final String valueType;
  final bool nullable;
  final String useCases;
  final Color color;
  _SubclassInfo(this.name, this.valueType, this.nullable, this.useCases, this.color);
}
