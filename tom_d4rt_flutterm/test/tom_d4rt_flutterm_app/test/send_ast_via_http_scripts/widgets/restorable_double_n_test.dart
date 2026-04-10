// Deep visual test for RestorableDoubleN
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, sized_box_for_whitespace, unintended_html_in_doc_comment

import 'package:flutter/material.dart';

/// Deep visual exploration of RestorableDoubleN
/// A restorable property that holds a nullable double value.
///
/// RestorableDoubleN extends RestorableNumN<double?> and:
/// - Supports null (not set)
/// - Supports special values: infinity, -infinity, NaN
/// - Perfect for optional numeric inputs like volume sliders
///
/// Serializes directly as double? primitive.
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF1A1A2E),
    ),
    home: _RestorableDoubleNDemo(),
  );
}

// =============================================================================
// PALETTE: Pink 700 / Cyan A400
// =============================================================================
const Color _kPrimary = Color(0xFFC2185B); // Pink 700
const Color _kAccent = Color(0xFF00E5FF); // Cyan A400
const Color _kSurface = Color(0xFF252542);
const Color _kCardBg = Color(0xFF2D2D4A);
const Color _kTextPrimary = Color(0xFFE8E8F0);
const Color _kTextSecondary = Color(0xFFB0B0C8);
const Color _kDivider = Color(0xFF3A3A5C);
const Color _kSet = Color(0xFF66BB6A);
const Color _kNull = Color(0xFFFFCA28);
const Color _kInfinity = Color(0xFFE040FB);
const Color _kNaN = Color(0xFFFF5252);

// =============================================================================
// MAIN DEMO WIDGET
// =============================================================================
class _RestorableDoubleNDemo extends StatefulWidget {
  @override
  State<_RestorableDoubleNDemo> createState() => _RestorableDoubleNDemoState();
}

class _RestorableDoubleNDemoState extends State<_RestorableDoubleNDemo>
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
        title: Text('RestorableDoubleN Deep Dive'),
        backgroundColor: _kPrimary,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kTextSecondary,
          tabs: [
            Tab(icon: Icon(Icons.school), text: 'Theory'),
            Tab(icon: Icon(Icons.tune), text: 'Slider Lab'),
            Tab(icon: Icon(Icons.all_inclusive), text: 'Special Values'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TheoryTab(),
          _SliderLabTab(),
          _SpecialValuesTab(),
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
          _buildNullabilitySection(),
          SizedBox(height: 24),
          _buildSerializationSection(),
          SizedBox(height: 24),
          _buildClassHierarchySection(),
          SizedBox(height: 24),
          _buildSpecialValuesOverview(),
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
              Icon(Icons.blur_circular, color: _kAccent, size: 32),
              SizedBox(width: 12),
              Text(
                'RestorableDoubleN',
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
            'A restorable property for nullable double values. Supports null state '
            'and special IEEE 754 values: infinity, negative infinity, and NaN.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 15,
              height: 1.5,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _HeroBadge(icon: Icons.numbers, label: 'double?'),
              SizedBox(width: 12),
              _HeroBadge(icon: Icons.help_outline, label: 'Nullable'),
              SizedBox(width: 12),
              _HeroBadge(icon: Icons.all_inclusive, label: '∞ & NaN'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNullabilitySection() {
    return _TheoryCard(
      title: 'Nullable Double',
      icon: Icons.help_outline,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RestorableDoubleN can hold three categories of values:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _StateCard(
                  icon: Icons.pin,
                  color: _kSet,
                  title: 'Number',
                  subtitle: 'Any finite double',
                  example: '3.14159',
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _StateCard(
                  icon: Icons.remove_circle_outline,
                  color: _kNull,
                  title: 'null',
                  subtitle: 'Not set',
                  example: 'Optional',
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _StateCard(
                  icon: Icons.all_inclusive,
                  color: _kInfinity,
                  title: 'Special',
                  subtitle: '∞, -∞, NaN',
                  example: 'IEEE 754',
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
                    'Use null for "not configured" states—like volume sliders '
                    'that use system default when not explicitly set.',
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
      icon: Icons.transform,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Double values serialize directly—no conversion needed:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          _SerializationExample(
            input: '3.14159',
            output: '3.14159',
            desc: 'Finite numbers pass through',
          ),
          SizedBox(height: 8),
          _SerializationExample(
            input: 'null',
            output: 'null',
            desc: 'Null preserved',
          ),
          SizedBox(height: 8),
          _SerializationExample(
            input: 'double.infinity',
            output: 'Infinity',
            desc: 'Special value serialized',
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kNaN.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kNaN.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber, color: _kNaN, size: 18),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'NaN values may not serialize consistently across platforms. '
                    'Consider avoiding NaN in restorable state.',
                    style: TextStyle(color: _kNaN, fontSize: 11),
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
                _HierarchyItem(level: 0, name: 'RestorableProperty<double?>', desc: 'Base'),
                _HierarchyItem(level: 1, name: 'RestorableValue<double?>', desc: 'Value holder'),
                _HierarchyItem(level: 2, name: 'RestorableNumN<double?>', desc: 'Numeric base'),
                _HierarchyItem(level: 3, name: 'RestorableDoubleN', desc: 'Nullable double', isHighlighted: true),
              ],
            ),
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _RelatedChip('RestorableDouble', 'Non-null'),
              _RelatedChip('RestorableIntN', 'Nullable int'),
              _RelatedChip('RestorableNum', 'Non-null num'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialValuesOverview() {
    return _TheoryCard(
      title: 'IEEE 754 Special Values',
      icon: Icons.science,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SpecialValueRow(
            name: 'double.infinity',
            symbol: '∞',
            color: _kInfinity,
            desc: 'Positive infinity (division by zero)',
          ),
          _SpecialValueRow(
            name: 'double.negativeInfinity',
            symbol: '-∞',
            color: _kInfinity,
            desc: 'Negative infinity',
          ),
          _SpecialValueRow(
            name: 'double.nan',
            symbol: 'NaN',
            color: _kNaN,
            desc: 'Not a Number (0/0, sqrt(-1))',
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.code, color: _kAccent, size: 16),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Check with: value.isInfinite, value.isNaN, value.isNegative',
                    style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 10),
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
      title: 'Common Use Cases',
      icon: Icons.cases,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _UseCaseItem(
            icon: Icons.volume_up,
            title: 'Volume Slider',
            desc: 'null = use system default',
          ),
          _UseCaseItem(
            icon: Icons.opacity,
            title: 'Opacity Control',
            desc: 'null = fully transparent or default',
          ),
          _UseCaseItem(
            icon: Icons.thermostat,
            title: 'Temperature',
            desc: 'null = sensor not set',
          ),
          _UseCaseItem(
            icon: Icons.speed,
            title: 'Progress Value',
            desc: 'null = indeterminate progress',
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

class _StateCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final String example;

  const _StateCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.example,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
          ),
          SizedBox(height: 2),
          Text(subtitle, style: TextStyle(color: _kTextPrimary, fontSize: 9)),
          SizedBox(height: 6),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              example,
              style: TextStyle(color: color, fontSize: 8, fontFamily: 'monospace'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SerializationExample extends StatelessWidget {
  final String input;
  final String output;
  final String desc;

  const _SerializationExample({
    required this.input,
    required this.output,
    required this.desc,
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
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _kPrimary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                input,
                style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 11),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(width: 8),
          Icon(Icons.arrow_forward, color: _kAccent, size: 16),
          SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _kAccent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                output,
                style: TextStyle(color: _kAccent, fontFamily: 'monospace', fontSize: 11),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Text(
              desc,
              style: TextStyle(color: _kTextSecondary, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecialValueRow extends StatelessWidget {
  final String name;
  final String symbol;
  final Color color;
  final String desc;

  const _SpecialValueRow({
    required this.name,
    required this.symbol,
    required this.color,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                symbol,
                style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
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
// TAB 2: SLIDER LAB
// =============================================================================
class _SliderLabTab extends StatefulWidget {
  @override
  State<_SliderLabTab> createState() => _SliderLabTabState();
}

class _SliderLabTabState extends State<_SliderLabTab> {
  // Simulated RestorableDoubleN properties
  double? _volume;
  double? _brightness;
  double? _opacity;
  double? _temperature;

  final List<String> _eventLog = [];

  @override
  void initState() {
    super.initState();
    _volume = 0.75;
    _brightness = null;
    _opacity = 1.0;
    _temperature = null;
  }

  void _setValue(String name, double? value, void Function(double?) setter) {
    setState(() {
      setter(value);
      _logEvent('$name = ${value?.toStringAsFixed(2) ?? 'null'}');
    });
  }

  void _logEvent(String event) {
    _eventLog.insert(0, '${DateTime.now().toString().substring(11, 19)}: $event');
    if (_eventLog.length > 8) _eventLog.removeLast();
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
              Text(
                'Slider Lab',
                style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                'Each slider simulates a RestorableDoubleN. Toggle "Use Default" to set null.',
                style: TextStyle(color: _kTextSecondary, fontSize: 12),
              ),
            ],
          ),
        ),
        // Sliders
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              _SliderCard(
                name: 'volume',
                label: 'Volume',
                icon: Icons.volume_up,
                value: _volume,
                min: 0.0,
                max: 1.0,
                onChanged: (v) => _setValue('volume', v, (val) => _volume = val),
                onToggleNull: () => _setValue('volume', _volume == null ? 0.5 : null, (val) => _volume = val),
              ),
              SizedBox(height: 16),
              _SliderCard(
                name: 'brightness',
                label: 'Brightness',
                icon: Icons.brightness_6,
                value: _brightness,
                min: 0.0,
                max: 100.0,
                onChanged: (v) => _setValue('brightness', v, (val) => _brightness = val),
                onToggleNull: () => _setValue('brightness', _brightness == null ? 50.0 : null, (val) => _brightness = val),
              ),
              SizedBox(height: 16),
              _SliderCard(
                name: 'opacity',
                label: 'Opacity',
                icon: Icons.opacity,
                value: _opacity,
                min: 0.0,
                max: 1.0,
                onChanged: (v) => _setValue('opacity', v, (val) => _opacity = val),
                onToggleNull: () => _setValue('opacity', _opacity == null ? 1.0 : null, (val) => _opacity = val),
              ),
              SizedBox(height: 16),
              _SliderCard(
                name: 'temperature',
                label: 'Temperature',
                icon: Icons.thermostat,
                value: _temperature,
                min: -20.0,
                max: 50.0,
                onChanged: (v) => _setValue('temperature', v, (val) => _temperature = val),
                onToggleNull: () => _setValue('temperature', _temperature == null ? 20.0 : null, (val) => _temperature = val),
              ),
              SizedBox(height: 24),
              _buildStatePreview(),
            ],
          ),
        ),
        // Event log
        Container(
          height: 100,
          padding: EdgeInsets.all(16),
          color: _kCardBg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Event Log:', style: TextStyle(color: _kAccent, fontSize: 12)),
              SizedBox(height: 8),
              Expanded(
                child: ListView(
                  children: _eventLog.map((e) => Text(
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

  Widget _buildStatePreview() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kAccent.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.code, color: _kAccent, size: 16),
              SizedBox(width: 8),
              Text('Current State', style: TextStyle(color: _kAccent, fontSize: 11)),
            ],
          ),
          SizedBox(height: 12),
          Text(
            '''volume.value = ${_formatValue(_volume)};
brightness.value = ${_formatValue(_brightness)};
opacity.value = ${_formatValue(_opacity)};
temperature.value = ${_formatValue(_temperature)};''',
            style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 10, height: 1.5),
          ),
        ],
      ),
    );
  }

  String _formatValue(double? value) {
    if (value == null) return 'null';
    return value.toStringAsFixed(2);
  }
}

class _SliderCard extends StatelessWidget {
  final String name;
  final String label;
  final IconData icon;
  final double? value;
  final double min;
  final double max;
  final ValueChanged<double?> onChanged;
  final VoidCallback onToggleNull;

  const _SliderCard({
    required this.name,
    required this.label,
    required this.icon,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.onToggleNull,
  });

  bool get _isNull => value == null;
  Color get _stateColor => _isNull ? _kNull : _kSet;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _stateColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _stateColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: _stateColor, size: 22),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: TextStyle(color: _kTextPrimary, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(name, style: TextStyle(color: _kTextSecondary, fontFamily: 'monospace', fontSize: 11)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _stateColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  _isNull ? 'null' : value!.toStringAsFixed(2),
                  style: TextStyle(
                    color: _stateColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // Slider or null placeholder
          Container(
            height: 48,
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: _isNull
                ? Center(
                    child: Text(
                      'Using system default (null)',
                      style: TextStyle(color: _kNull, fontStyle: FontStyle.italic, fontSize: 12),
                    ),
                  )
                : Row(
                    children: [
                      Text(
                        min.toStringAsFixed(0),
                        style: TextStyle(color: _kTextSecondary, fontSize: 10),
                      ),
                      Expanded(
                        child: Slider(
                          value: value!,
                          min: min,
                          max: max,
                          activeColor: _kAccent,
                          inactiveColor: _kDivider,
                          onChanged: (v) => onChanged(v),
                        ),
                      ),
                      Text(
                        max.toStringAsFixed(0),
                        style: TextStyle(color: _kTextSecondary, fontSize: 10),
                      ),
                    ],
                  ),
          ),
          SizedBox(height: 12),
          // Toggle null button
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onToggleNull,
                  icon: Icon(_isNull ? Icons.edit : Icons.clear, size: 16),
                  label: Text(_isNull ? 'Set Value' : 'Use Default (null)'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _isNull ? _kAccent : _kNull,
                    side: BorderSide(color: _isNull ? _kAccent : _kNull),
                  ),
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
// TAB 3: SPECIAL VALUES
// =============================================================================
class _SpecialValuesTab extends StatefulWidget {
  @override
  State<_SpecialValuesTab> createState() => _SpecialValuesTabState();
}

class _SpecialValuesTabState extends State<_SpecialValuesTab> {
  double? _currentValue;
  final List<_ValueTransition> _history = [];

  @override
  void initState() {
    super.initState();
    _currentValue = 0.0;
    _addHistory('0.0');
  }

  void _setValue(double? value, String label) {
    setState(() {
      _currentValue = value;
      _addHistory(label);
    });
  }

  void _addHistory(String label) {
    _history.insert(0, _ValueTransition(label, DateTime.now()));
    if (_history.length > 8) _history.removeLast();
  }

  String _getValueCategory() {
    if (_currentValue == null) return 'NULL';
    if (_currentValue!.isNaN) return 'NaN';
    if (_currentValue == double.infinity) return 'INFINITY+';
    if (_currentValue == double.negativeInfinity) return 'INFINITY-';
    if (_currentValue!.isFinite) return 'FINITE';
    return 'UNKNOWN';
  }

  Color _getCategoryColor() {
    final cat = _getValueCategory();
    switch (cat) {
      case 'NULL':
        return _kNull;
      case 'NaN':
        return _kNaN;
      case 'INFINITY+':
      case 'INFINITY-':
        return _kInfinity;
      case 'FINITE':
        return _kSet;
      default:
        return _kTextSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Current value display
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _kSurface,
            border: Border(bottom: BorderSide(color: _kDivider)),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _getCategoryColor().withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _getCategoryColor()),
                ),
                child: Text(
                  _getValueCategory(),
                  style: TextStyle(
                    color: _getCategoryColor(),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                _formatDisplay(_currentValue),
                style: TextStyle(
                  color: _kTextPrimary,
                  fontFamily: 'monospace',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              _buildPropertiesRow(),
            ],
          ),
        ),
        // Value buttons
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Finite Values', style: TextStyle(color: _kTextSecondary, fontSize: 12)),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _ValueButton(label: '0.0', value: 0.0, color: _kSet, onTap: () => _setValue(0.0, '0.0')),
                    _ValueButton(label: '1.0', value: 1.0, color: _kSet, onTap: () => _setValue(1.0, '1.0')),
                    _ValueButton(label: 'π', value: 3.14159, color: _kSet, onTap: () => _setValue(3.14159, 'π')),
                    _ValueButton(label: '-273.15', value: -273.15, color: _kSet, onTap: () => _setValue(-273.15, '-273.15')),
                    _ValueButton(label: '1e10', value: 1e10, color: _kSet, onTap: () => _setValue(1e10, '1e10')),
                    _ValueButton(label: '1e-10', value: 1e-10, color: _kSet, onTap: () => _setValue(1e-10, '1e-10')),
                  ],
                ),
                SizedBox(height: 24),
                Text('Special Values', style: TextStyle(color: _kTextSecondary, fontSize: 12)),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _ValueButton(label: 'null', value: null, color: _kNull, onTap: () => _setValue(null, 'null')),
                    _ValueButton(label: '∞', value: double.infinity, color: _kInfinity, onTap: () => _setValue(double.infinity, '∞')),
                    _ValueButton(label: '-∞', value: double.negativeInfinity, color: _kInfinity, onTap: () => _setValue(double.negativeInfinity, '-∞')),
                    _ValueButton(label: 'NaN', value: double.nan, color: _kNaN, onTap: () => _setValue(double.nan, 'NaN')),
                  ],
                ),
                SizedBox(height: 24),
                Text('Arithmetic Tests', style: TextStyle(color: _kTextSecondary, fontSize: 12)),
                SizedBox(height: 8),
                _ArithmeticDemo(currentValue: _currentValue),
              ],
            ),
          ),
        ),
        // History log
        Container(
          height: 100,
          padding: EdgeInsets.all(16),
          color: _kCardBg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Value History:', style: TextStyle(color: _kAccent, fontSize: 12)),
              SizedBox(height: 8),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _history.map((h) => _HistoryChip(transition: h)).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPropertiesRow() {
    if (_currentValue == null) {
      return Text('value is null', style: TextStyle(color: _kNull, fontSize: 11));
    }
    return Wrap(
      spacing: 12,
      children: [
        _PropertyBadge(label: 'isFinite', value: _currentValue!.isFinite),
        _PropertyBadge(label: 'isInfinite', value: _currentValue!.isInfinite),
        _PropertyBadge(label: 'isNaN', value: _currentValue!.isNaN),
        _PropertyBadge(label: 'isNegative', value: _currentValue!.isNegative),
      ],
    );
  }

  String _formatDisplay(double? value) {
    if (value == null) return 'null';
    if (value.isNaN) return 'NaN';
    if (value == double.infinity) return '∞';
    if (value == double.negativeInfinity) return '-∞';
    if (value.abs() > 1e6 || (value != 0 && value.abs() < 1e-4)) {
      return value.toStringAsExponential(4);
    }
    return value.toStringAsFixed(6).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
  }
}

class _PropertyBadge extends StatelessWidget {
  final String label;
  final bool value;

  const _PropertyBadge({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final color = value ? _kAccent : _kTextSecondary;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        '$label: $value',
        style: TextStyle(color: color, fontSize: 9, fontFamily: 'monospace'),
      ),
    );
  }
}

class _ValueButton extends StatelessWidget {
  final String label;
  final double? value;
  final Color color;
  final VoidCallback onTap;

  const _ValueButton({
    required this.label,
    required this.value,
    required this.color,
    required this.onTap,
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
          border: Border.all(color: color),
        ),
        child: Text(
          label,
          style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ),
    );
  }
}

class _ArithmeticDemo extends StatelessWidget {
  final double? currentValue;

  const _ArithmeticDemo({required this.currentValue});

  @override
  Widget build(BuildContext context) {
    if (currentValue == null) {
      return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _kSurface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'Select a numeric value to see arithmetic behavior',
          style: TextStyle(color: _kTextSecondary, fontStyle: FontStyle.italic),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ArithmeticRow(op: '+ 1', result: currentValue! + 1),
          _ArithmeticRow(op: '* 2', result: currentValue! * 2),
          _ArithmeticRow(op: '/ 0', result: currentValue! / 0),
          _ArithmeticRow(op: '% 1', result: currentValue! % 1),
          _ArithmeticRow(op: '.abs()', result: currentValue!.abs()),
        ],
      ),
    );
  }
}

class _ArithmeticRow extends StatelessWidget {
  final String op;
  final double result;

  const _ArithmeticRow({required this.op, required this.result});

  String _formatResult() {
    if (result.isNaN) return 'NaN';
    if (result == double.infinity) return '∞';
    if (result == double.negativeInfinity) return '-∞';
    if (result.abs() > 1e9) return result.toStringAsExponential(2);
    return result.toStringAsFixed(4);
  }

  Color get _color {
    if (result.isNaN) return _kNaN;
    if (result.isInfinite) return _kInfinity;
    return _kAccent;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 60,
            child: Text(
              op,
              style: TextStyle(color: _kTextSecondary, fontFamily: 'monospace', fontSize: 11),
            ),
          ),
          Icon(Icons.arrow_forward, color: _kDivider, size: 14),
          SizedBox(width: 12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              _formatResult(),
              style: TextStyle(color: _color, fontFamily: 'monospace', fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}

class _ValueTransition {
  final String label;
  final DateTime time;
  _ValueTransition(this.label, this.time);
}

class _HistoryChip extends StatelessWidget {
  final _ValueTransition transition;

  const _HistoryChip({required this.transition});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kDivider),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            transition.label,
            style: TextStyle(color: _kAccent, fontWeight: FontWeight.bold, fontSize: 12),
          ),
          SizedBox(height: 2),
          Text(
            transition.time.toString().substring(11, 19),
            style: TextStyle(color: _kTextSecondary, fontSize: 8),
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
                overflow: TextOverflow.ellipsis,
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
