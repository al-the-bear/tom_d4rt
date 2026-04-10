// Deep visual test for RestorableDateTimeN
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

/// Deep visual exploration of RestorableDateTimeN
/// A restorable property that holds a nullable DateTime value.
///
/// RestorableDateTimeN serializes DateTime using millisecondsSinceEpoch:
/// - Compact integer storage
/// - Cross-platform compatible
/// - Handles null gracefully
///
/// Perfect for optional date selections like birthdays or expiration dates.
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF1A1A2E),
    ),
    home: _RestorableDateTimeNDemo(),
  );
}

// =============================================================================
// PALETTE: BlueGrey 700 / Yellow A400
// =============================================================================
const Color _kPrimary = Color(0xFF455A64); // BlueGrey 700
const Color _kAccent = Color(0xFFFFEA00); // Yellow A400
const Color _kSurface = Color(0xFF252542);
const Color _kCardBg = Color(0xFF2D2D4A);
const Color _kTextPrimary = Color(0xFFE8E8F0);
const Color _kTextSecondary = Color(0xFFB0B0C8);
const Color _kDivider = Color(0xFF3A3A5C);
const Color _kSet = Color(0xFF66BB6A);
const Color _kNull = Color(0xFFFFCA28);
const Color _kWarning = Color(0xFFFF7043);

// =============================================================================
// MAIN DEMO WIDGET
// =============================================================================
class _RestorableDateTimeNDemo extends StatefulWidget {
  @override
  State<_RestorableDateTimeNDemo> createState() => _RestorableDateTimeNDemoState();
}

class _RestorableDateTimeNDemoState extends State<_RestorableDateTimeNDemo>
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
        title: Text('RestorableDateTimeN Deep Dive'),
        backgroundColor: _kPrimary,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kTextSecondary,
          tabs: [
            Tab(icon: Icon(Icons.school), text: 'Theory'),
            Tab(icon: Icon(Icons.calendar_today), text: 'Date Lab'),
            Tab(icon: Icon(Icons.data_object), text: 'Serialization'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TheoryTab(),
          _DateLabTab(),
          _SerializationTab(),
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
          _buildConstructorSection(),
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
              Icon(Icons.event, color: _kAccent, size: 32),
              SizedBox(width: 12),
              Text(
                'RestorableDateTimeN',
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
            'A restorable property for nullable DateTime values. Persists dates '
            'across app lifecycle using millisecondsSinceEpoch serialization.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 15,
              height: 1.5,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _HeroBadge(icon: Icons.calendar_month, label: 'DateTime?'),
              SizedBox(width: 12),
              _HeroBadge(icon: Icons.numbers, label: 'millisSinceEpoch'),
              SizedBox(width: 12),
              _HeroBadge(icon: Icons.help_outline, label: 'Nullable'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNullabilitySection() {
    return _TheoryCard(
      title: 'Nullable DateTime',
      icon: Icons.help_outline,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RestorableDateTimeN can hold null OR a DateTime value:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _StateCard(
                  icon: Icons.event_available,
                  color: _kSet,
                  title: 'DateTime',
                  subtitle: 'A specific date/time',
                  example: '2024-03-15 14:30:00',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _StateCard(
                  icon: Icons.event_busy,
                  color: _kNull,
                  title: 'null',
                  subtitle: 'No date selected',
                  example: 'Not set / Optional',
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
                    'Use null to represent "not yet selected" - common for optional '
                    'birthdays, expiration dates, or deadline fields.',
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
      title: 'Serialization Strategy',
      icon: Icons.transform,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DateTime is serialized as millisecondsSinceEpoch (integer):',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          _SerializationStep(
            step: 1,
            label: 'Save (toPrimitives)',
            code: 'value?.millisecondsSinceEpoch',
            result: '1710517800000',
          ),
          SizedBox(height: 12),
          _SerializationStep(
            step: 2,
            label: 'Restore (fromPrimitives)',
            code: 'DateTime.fromMillisecondsSinceEpoch(data)',
            result: '2024-03-15 14:30:00',
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _AdvantageChip('Compact storage')),
              SizedBox(width: 8),
              Expanded(child: _AdvantageChip('Cross-platform')),
              SizedBox(width: 8),
              Expanded(child: _AdvantageChip('Microsecond precision')),
            ],
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
                _HierarchyItem(level: 0, name: 'RestorableProperty<DateTime?>', desc: 'Base'),
                _HierarchyItem(level: 1, name: 'RestorableValue<DateTime?>', desc: 'Value holder'),
                _HierarchyItem(level: 2, name: 'RestorableDateTimeN', desc: 'Nullable DateTime', isHighlighted: true),
              ],
            ),
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _RelatedChip('RestorableDateTime', 'Non-null'),
              _RelatedChip('RestorableBoolN', 'Nullable bool'),
              _RelatedChip('RestorableIntN', 'Nullable int'),
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
              'RestorableDateTimeN(DateTime? defaultValue)',
              style: TextStyle(
                color: _kAccent,
                fontFamily: 'monospace',
                fontSize: 13,
              ),
            ),
          ),
          SizedBox(height: 16),
          _CodeExample(
            title: 'Usage examples:',
            code: '''// Optional date - not yet selected
final birthdate = RestorableDateTimeN(null);

// Default to today
final selectedDate = RestorableDateTimeN(DateTime.now());

// Specific default
final deadline = RestorableDateTimeN(
  DateTime(2024, 12, 31, 23, 59),
);''',
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
            icon: Icons.cake,
            title: 'Optional Birthday',
            desc: 'User profiles where birthday is not required',
          ),
          _UseCaseItem(
            icon: Icons.timer_off,
            title: 'Expiration Date',
            desc: 'Items that may or may not expire',
          ),
          _UseCaseItem(
            icon: Icons.event_note,
            title: 'Appointment Scheduling',
            desc: 'Dates that can be cleared/reset',
          ),
          _UseCaseItem(
            icon: Icons.history,
            title: 'Last Accessed',
            desc: 'Track when something was last used (null = never)',
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
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(color: _kTextPrimary, fontSize: 11),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              example,
              style: TextStyle(
                color: color,
                fontSize: 9,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SerializationStep extends StatelessWidget {
  final int step;
  final String label;
  final String code;
  final String result;

  const _SerializationStep({
    required this.step,
    required this.label,
    required this.code,
    required this.result,
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
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: _kAccent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$step',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(color: _kTextSecondary, fontSize: 11),
                ),
                SizedBox(height: 4),
                Text(
                  code,
                  style: TextStyle(
                    color: _kAccent,
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _kPrimary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              result,
              style: TextStyle(
                color: _kTextPrimary,
                fontFamily: 'monospace',
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdvantageChip extends StatelessWidget {
  final String text;
  const _AdvantageChip(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: _kSet.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _kSet.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check, color: _kSet, size: 12),
          SizedBox(width: 4),
          Flexible(
            child: Text(
              text,
              style: TextStyle(color: _kSet, fontSize: 10),
              overflow: TextOverflow.ellipsis,
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

  const _UseCaseItem({
    required this.icon,
    required this.title,
    required this.desc,
  });

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
                Text(
                  title,
                  style: TextStyle(
                    color: _kTextPrimary,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 2),
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
// TAB 2: DATE LAB
// =============================================================================
class _DateLabTab extends StatefulWidget {
  @override
  State<_DateLabTab> createState() => _DateLabTabState();
}

class _DateLabTabState extends State<_DateLabTab> {
  // Simulated RestorableDateTimeN properties
  DateTime? _birthdate;
  DateTime? _appointmentDate;
  DateTime? _deadlineDate;
  DateTime? _lastAccessDate;

  final List<String> _eventLog = [];

  void _setDate(String name, void Function(DateTime?) setter, DateTime? date) {
    setState(() {
      setter(date);
      final display = date != null 
          ? '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}'
          : 'null';
      _logEvent('$name = $display');
    });
  }

  void _clearDate(String name, void Function(DateTime?) setter) {
    _setDate(name, setter, null);
  }

  Future<void> _pickDate(String name, DateTime? current, void Function(DateTime?) setter) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: current ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: _kAccent,
              surface: _kCardBg,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      _setDate(name, setter, picked);
    }
  }

  void _logEvent(String event) {
    _eventLog.insert(0, '${DateTime.now().toString().substring(11, 19)}: $event');
    if (_eventLog.length > 10) _eventLog.removeLast();
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
                'Date Picker Lab',
                style: TextStyle(
                  color: _kTextPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Each field simulates a RestorableDateTimeN. Tap to pick, clear to set null.',
                style: TextStyle(color: _kTextSecondary, fontSize: 12),
              ),
            ],
          ),
        ),
        // Date fields
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              _DateFieldCard(
                name: 'birthdate',
                label: 'Birthday',
                icon: Icons.cake,
                value: _birthdate,
                onPick: () => _pickDate('birthdate', _birthdate, (d) => _birthdate = d),
                onClear: () => _clearDate('birthdate', (d) => _birthdate = d),
              ),
              SizedBox(height: 12),
              _DateFieldCard(
                name: 'appointmentDate',
                label: 'Appointment',
                icon: Icons.event,
                value: _appointmentDate,
                onPick: () => _pickDate('appointmentDate', _appointmentDate, (d) => _appointmentDate = d),
                onClear: () => _clearDate('appointmentDate', (d) => _appointmentDate = d),
              ),
              SizedBox(height: 12),
              _DateFieldCard(
                name: 'deadlineDate',
                label: 'Deadline',
                icon: Icons.timer,
                value: _deadlineDate,
                onPick: () => _pickDate('deadlineDate', _deadlineDate, (d) => _deadlineDate = d),
                onClear: () => _clearDate('deadlineDate', (d) => _deadlineDate = d),
              ),
              SizedBox(height: 12),
              _DateFieldCard(
                name: 'lastAccessDate',
                label: 'Last Access',
                icon: Icons.history,
                value: _lastAccessDate,
                onPick: () => _pickDate('lastAccessDate', _lastAccessDate, (d) => _lastAccessDate = d),
                onClear: () => _clearDate('lastAccessDate', (d) => _lastAccessDate = d),
              ),
              SizedBox(height: 24),
              _buildStatePreview(),
            ],
          ),
        ),
        // Event log
        Container(
          height: 120,
          padding: EdgeInsets.all(16),
          color: _kCardBg,
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
              Text(
                'Current State (RestorableDateTimeN equivalent)',
                style: TextStyle(color: _kAccent, fontSize: 11),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            '''birthdate.value = ${_formatForCode(_birthdate)};
appointmentDate.value = ${_formatForCode(_appointmentDate)};
deadlineDate.value = ${_formatForCode(_deadlineDate)};
lastAccessDate.value = ${_formatForCode(_lastAccessDate)};''',
            style: TextStyle(
              color: _kTextPrimary,
              fontFamily: 'monospace',
              fontSize: 10,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  String _formatForCode(DateTime? dt) {
    if (dt == null) return 'null';
    return 'DateTime(${dt.year}, ${dt.month}, ${dt.day})';
  }
}

class _DateFieldCard extends StatelessWidget {
  final String name;
  final String label;
  final IconData icon;
  final DateTime? value;
  final VoidCallback onPick;
  final VoidCallback onClear;

  const _DateFieldCard({
    required this.name,
    required this.label,
    required this.icon,
    required this.value,
    required this.onPick,
    required this.onClear,
  });

  bool get _hasValue => value != null;

  Color get _stateColor => _hasValue ? _kSet : _kNull;

  String get _displayValue {
    if (value == null) return 'Not set (null)';
    return '${value!.year}-${value!.month.toString().padLeft(2, '0')}-${value!.day.toString().padLeft(2, '0')}';
  }

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
                    Text(
                      label,
                      style: TextStyle(
                        color: _kTextPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      name,
                      style: TextStyle(
                        color: _kTextSecondary,
                        fontFamily: 'monospace',
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _stateColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _hasValue ? 'Set' : 'null',
                  style: TextStyle(
                    color: _stateColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  _hasValue ? Icons.calendar_today : Icons.help_outline,
                  color: _stateColor,
                  size: 18,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _displayValue,
                    style: TextStyle(
                      color: _hasValue ? _kTextPrimary : _kTextSecondary,
                      fontFamily: 'monospace',
                      fontSize: 13,
                    ),
                  ),
                ),
                if (_hasValue)
                  Text(
                    'ms: ${value!.millisecondsSinceEpoch}',
                    style: TextStyle(
                      color: _kTextSecondary,
                      fontFamily: 'monospace',
                      fontSize: 9,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onPick,
                  icon: Icon(Icons.calendar_month, size: 16),
                  label: Text('Pick Date'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kPrimary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: onClear,
                icon: Icon(Icons.clear, size: 16),
                label: Text('Clear'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: _hasValue ? _kWarning : _kTextSecondary,
                  side: BorderSide(color: _hasValue ? _kWarning : _kDivider),
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
// TAB 3: SERIALIZATION
// =============================================================================
class _SerializationTab extends StatefulWidget {
  @override
  State<_SerializationTab> createState() => _SerializationTabState();
}

class _SerializationTabState extends State<_SerializationTab> {
  DateTime? _currentValue;
  int? _serializedValue;
  bool _hasRestored = false;
  int _buildCount = 0;
  final List<_SerEvent> _events = [];

  @override
  void initState() {
    super.initState();
    _currentValue = DateTime.now();
    _updateSerialized();
    _addEvent(_SerEventType.create, 'Created with current date');
  }

  void _updateSerialized() {
    _serializedValue = _currentValue?.millisecondsSinceEpoch;
  }

  void _setToNow() {
    setState(() {
      _currentValue = DateTime.now();
      _updateSerialized();
      _addEvent(_SerEventType.update, 'Set to DateTime.now()');
    });
  }

  void _setToNull() {
    setState(() {
      _currentValue = null;
      _updateSerialized();
      _addEvent(_SerEventType.update, 'Set to null');
    });
  }

  void _setToEpoch() {
    setState(() {
      _currentValue = DateTime.fromMillisecondsSinceEpoch(0);
      _updateSerialized();
      _addEvent(_SerEventType.update, 'Set to epoch (1970-01-01)');
    });
  }

  void _simulateSave() {
    _addEvent(_SerEventType.save, 'Saved: $_serializedValue');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Saved to bucket: $_serializedValue'),
        backgroundColor: _kPrimary,
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _simulateRestore() {
    if (_serializedValue == null) {
      setState(() {
        _currentValue = null;
        _hasRestored = true;
        _buildCount++;
      });
      _addEvent(_SerEventType.restore, 'Restored null from bucket');
    } else {
      setState(() {
        _currentValue = DateTime.fromMillisecondsSinceEpoch(_serializedValue!);
        _hasRestored = true;
        _buildCount++;
      });
      _addEvent(_SerEventType.restore, 'Restored from bucket (build #$_buildCount)');
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Restored! Build #$_buildCount'),
        backgroundColor: _kAccent,
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _addEvent(_SerEventType type, String message) {
    _events.insert(0, _SerEvent(type: type, message: message, time: DateTime.now()));
    if (_events.length > 8) _events.removeLast();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Current state
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kSurface,
            border: Border(bottom: BorderSide(color: _kDivider)),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _hasRestored ? _kAccent.withOpacity(0.2) : _kPrimary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  _hasRestored ? Icons.restore : Icons.fiber_new,
                  color: _hasRestored ? _kAccent : _kPrimary,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _hasRestored ? 'Restored State' : 'Fresh Instance',
                      style: TextStyle(
                        color: _kTextPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Build count: $_buildCount',
                      style: TextStyle(color: _kTextSecondary, fontSize: 12),
                    ),
                  ],
                ),
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
                // Value display
                _ValueDisplayCard(
                  label: 'DateTime? value',
                  value: _currentValue,
                ),
                SizedBox(height: 16),
                // Arrow
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_downward, color: _kAccent),
                    SizedBox(width: 8),
                    Text(
                      'toPrimitives()',
                      style: TextStyle(color: _kAccent, fontFamily: 'monospace', fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // Serialized display
                _SerializedDisplayCard(
                  label: 'int? (millisecondsSinceEpoch)',
                  value: _serializedValue,
                ),
                SizedBox(height: 16),
                // Arrow
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_downward, color: _kAccent),
                    SizedBox(width: 8),
                    Text(
                      'fromPrimitives()',
                      style: TextStyle(color: _kAccent, fontFamily: 'monospace', fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // Restored display
                _RestoredDisplayCard(
                  value: _serializedValue,
                ),
                SizedBox(height: 24),
                // Value presets
                _buildPresetButtons(),
              ],
            ),
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
                  onPressed: _simulateSave,
                  icon: Icon(Icons.save),
                  label: Text('Save'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kPrimary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _simulateRestore,
                  icon: Icon(Icons.restore),
                  label: Text('Restore'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kAccent,
                    foregroundColor: Colors.black87,
                  ),
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
              Text('Serialization Events:', style: TextStyle(color: _kTextSecondary, fontSize: 12)),
              SizedBox(height: 8),
              Expanded(
                child: ListView(
                  children: _events
                      .map((e) => _SerEventRow(event: e))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
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
          Text(
            'Set Value:',
            style: TextStyle(color: _kTextSecondary, fontSize: 12),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _PresetButton(
                  label: 'Now',
                  icon: Icons.today,
                  onTap: _setToNow,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _PresetButton(
                  label: 'Epoch',
                  icon: Icons.history,
                  onTap: _setToEpoch,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _PresetButton(
                  label: 'null',
                  icon: Icons.remove_circle_outline,
                  onTap: _setToNull,
                  isNull: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ValueDisplayCard extends StatelessWidget {
  final String label;
  final DateTime? value;

  const _ValueDisplayCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null;
    final color = hasValue ? _kSet : _kNull;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(color: _kTextSecondary, fontSize: 11),
          ),
          SizedBox(height: 8),
          Icon(
            hasValue ? Icons.calendar_today : Icons.help_outline,
            color: color,
            size: 32,
          ),
          SizedBox(height: 8),
          Text(
            hasValue ? value.toString() : 'null',
            style: TextStyle(
              color: color,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: hasValue ? 11 : 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _SerializedDisplayCard extends StatelessWidget {
  final String label;
  final int? value;

  const _SerializedDisplayCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kAccent.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(color: _kTextSecondary, fontSize: 11),
          ),
          SizedBox(height: 8),
          Icon(Icons.numbers, color: _kAccent, size: 32),
          SizedBox(height: 8),
          Text(
            hasValue ? value.toString() : 'null',
            style: TextStyle(
              color: _kAccent,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: hasValue ? 14 : 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _RestoredDisplayCard extends StatelessWidget {
  final int? value;

  const _RestoredDisplayCard({required this.value});

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null;
    final restored = hasValue
        ? DateTime.fromMillisecondsSinceEpoch(value!)
        : null;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kPrimary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kPrimary.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Text(
            'Restored DateTime?',
            style: TextStyle(color: _kTextSecondary, fontSize: 11),
          ),
          SizedBox(height: 8),
          Icon(
            hasValue ? Icons.check_circle : Icons.help_outline,
            color: _kPrimary,
            size: 32,
          ),
          SizedBox(height: 8),
          Text(
            hasValue ? restored.toString() : 'null',
            style: TextStyle(
              color: _kTextPrimary,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: hasValue ? 11 : 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _PresetButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isNull;

  const _PresetButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.isNull = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isNull ? _kNull : _kPrimary;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

enum _SerEventType { create, update, save, restore }

class _SerEvent {
  final _SerEventType type;
  final String message;
  final DateTime time;

  _SerEvent({required this.type, required this.message, required this.time});
}

class _SerEventRow extends StatelessWidget {
  final _SerEvent event;

  const _SerEventRow({required this.event});

  Color get _color {
    switch (event.type) {
      case _SerEventType.create:
        return _kTextSecondary;
      case _SerEventType.update:
        return _kSet;
      case _SerEventType.save:
        return _kPrimary;
      case _SerEventType.restore:
        return _kAccent;
    }
  }

  IconData get _icon {
    switch (event.type) {
      case _SerEventType.create:
        return Icons.fiber_new;
      case _SerEventType.update:
        return Icons.edit;
      case _SerEventType.save:
        return Icons.save;
      case _SerEventType.restore:
        return Icons.restore;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            event.time.toString().substring(11, 19),
            style: TextStyle(color: _kTextSecondary, fontFamily: 'monospace', fontSize: 9),
          ),
          SizedBox(width: 8),
          Icon(_icon, color: _color, size: 12),
          SizedBox(width: 6),
          Expanded(
            child: Text(
              event.message,
              style: TextStyle(color: _color, fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
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
              border: Border.all(color: isHighlighted ? _kAccent : _kDivider),
            ),
            child: Text(
              name,
              style: TextStyle(
                color: isHighlighted ? _kAccent : _kTextPrimary,
                fontFamily: 'monospace',
                fontSize: 10,
                fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          SizedBox(width: 8),
          Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
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
