// Deep visual test for RestorableDateTime
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, sized_box_for_whitespace, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

/// Deep visual exploration of RestorableDateTime
/// A restorable property that holds a non-null DateTime value.
///
/// Unlike RestorableDateTimeN, this class always has a valid DateTime:
/// - Cannot be null - always set
/// - Requires a default value at construction
/// - Perfect for mandatory date fields
///
/// Serializes via millisecondsSinceEpoch for compact cross-platform storage.
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF1A1A2E),
    ),
    home: _RestorableDateTimeDemo(),
  );
}

// =============================================================================
// PALETTE: Purple 700 / Teal A400
// =============================================================================
const Color _kPrimary = Color(0xFF7B1FA2); // Purple 700
const Color _kAccent = Color(0xFF1DE9B6); // Teal A400
const Color _kSurface = Color(0xFF252542);
const Color _kCardBg = Color(0xFF2D2D4A);
const Color _kTextPrimary = Color(0xFFE8E8F0);
const Color _kTextSecondary = Color(0xFFB0B0C8);
const Color _kDivider = Color(0xFF3A3A5C);
const Color _kUtc = Color(0xFF42A5F5);
const Color _kLocal = Color(0xFFFFCA28);
const Color _kHighlight = Color(0xFFFF7043);

// =============================================================================
// MAIN DEMO WIDGET
// =============================================================================
class _RestorableDateTimeDemo extends StatefulWidget {
  @override
  State<_RestorableDateTimeDemo> createState() => _RestorableDateTimeDemoState();
}

class _RestorableDateTimeDemoState extends State<_RestorableDateTimeDemo>
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
        title: Text('RestorableDateTime Deep Dive'),
        backgroundColor: _kPrimary,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: _kAccent,
          labelColor: _kAccent,
          unselectedLabelColor: _kTextSecondary,
          tabs: [
            Tab(icon: Icon(Icons.school), text: 'Theory'),
            Tab(icon: Icon(Icons.edit_calendar), text: 'DateTime Lab'),
            Tab(icon: Icon(Icons.public), text: 'UTC vs Local'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TheoryTab(),
          _DateTimeLabTab(),
          _UtcLocalTab(),
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
          _buildNonNullSection(),
          SizedBox(height: 24),
          _buildComparisonSection(),
          SizedBox(height: 24),
          _buildClassHierarchySection(),
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
              Icon(Icons.event_available, color: _kAccent, size: 32),
              SizedBox(width: 12),
              Text(
                'RestorableDateTime',
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
            'A restorable property for non-nullable DateTime values. Always holds a '
            'valid date—perfect for mandatory fields like event dates or timestamps.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 15,
              height: 1.5,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _HeroBadge(icon: Icons.calendar_month, label: 'DateTime'),
              SizedBox(width: 12),
              _HeroBadge(icon: Icons.check_circle, label: 'Non-nullable'),
              SizedBox(width: 12),
              _HeroBadge(icon: Icons.restore, label: 'Restorable'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNonNullSection() {
    return _TheoryCard(
      title: 'Never Null Guarantee',
      icon: Icons.shield,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RestorableDateTime always contains a valid DateTime value:',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kAccent.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.event_available, color: _kAccent, size: 32),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Always Contains DateTime',
                        style: TextStyle(
                          color: _kAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Default value required at construction. No null checks needed!',
                        style: TextStyle(color: _kTextPrimary, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          _AdvantageRow(
            icon: Icons.speed,
            title: 'No null checks',
            desc: 'Directly access .value without ?. operator',
          ),
          _AdvantageRow(
            icon: Icons.verified,
            title: 'Type safety',
            desc: 'Compiler guarantees DateTime availability',
          ),
          _AdvantageRow(
            icon: Icons.data_object,
            title: 'Clean API',
            desc: 'Value always exists for serialization',
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonSection() {
    return _TheoryCard(
      title: 'RestorableDateTime vs RestorableDateTimeN',
      icon: Icons.compare_arrows,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _ComparisonCard(
                  title: 'RestorableDateTime',
                  color: _kAccent,
                  items: [
                    'Always has value',
                    'Type: DateTime',
                    'Default required',
                    'Direct access',
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _ComparisonCard(
                  title: 'RestorableDateTimeN',
                  color: _kLocal,
                  items: [
                    'Can be null',
                    'Type: DateTime?',
                    'Null default OK',
                    'Needs null check',
                  ],
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
                    'Use RestorableDateTime for mandatory dates. Use RestorableDateTimeN '
                    'when "not set" is a valid state (optional fields).',
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
                _HierarchyItem(level: 0, name: 'RestorableProperty<DateTime>', desc: 'Base'),
                _HierarchyItem(level: 1, name: 'RestorableValue<DateTime>', desc: 'Value holder'),
                _HierarchyItem(level: 2, name: 'RestorableDateTime', desc: 'Non-null DateTime', isHighlighted: true),
              ],
            ),
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _RelatedChip('RestorableDateTimeN', 'Nullable'),
              _RelatedChip('RestorableBool', 'Non-null bool'),
              _RelatedChip('RestorableInt', 'Non-null int'),
            ],
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
            'DateTime serializes as a single integer (milliseconds since epoch):',
            style: TextStyle(color: _kTextPrimary, height: 1.5),
          ),
          SizedBox(height: 16),
          _SerializationStep(
            step: 1,
            label: 'toPrimitives()',
            code: 'value.millisecondsSinceEpoch',
            example: '1710517800000',
          ),
          SizedBox(height: 8),
          _SerializationStep(
            step: 2,
            label: 'fromPrimitives()',
            code: 'DateTime.fromMillisecondsSinceEpoch(data)',
            example: '2024-03-15 14:30:00.000',
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kHighlight.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _kHighlight.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber, color: _kHighlight, size: 18),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Note: millisecondsSinceEpoch loses timezone info. '
                    'Restored DateTime is always local time.',
                    style: TextStyle(color: _kHighlight, fontSize: 11),
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
            icon: Icons.event,
            title: 'Event Date',
            desc: 'Appointments, meetings (always set)',
          ),
          _UseCaseItem(
            icon: Icons.schedule,
            title: 'Selected Time',
            desc: 'From time picker dialog',
          ),
          _UseCaseItem(
            icon: Icons.assignment_turned_in,
            title: 'Task Due Date',
            desc: 'Deadline (mandatory)',
          ),
          _UseCaseItem(
            icon: Icons.flight_takeoff,
            title: 'Trip Date',
            desc: 'Departure/arrival dates',
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

class _AdvantageRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;

  const _AdvantageRow({required this.icon, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: _kAccent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, color: _kAccent, size: 16),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: _kTextPrimary, fontSize: 12, fontWeight: FontWeight.w500)),
                Text(desc, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
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
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
          SizedBox(height: 8),
          ...items.map((item) => Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                Icon(Icons.check, color: color, size: 12),
                SizedBox(width: 6),
                Flexible(
                  child: Text(
                    item,
                    style: TextStyle(color: _kTextPrimary, fontSize: 10),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _SerializationStep extends StatelessWidget {
  final int step;
  final String label;
  final String code;
  final String example;

  const _SerializationStep({
    required this.step,
    required this.label,
    required this.code,
    required this.example,
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
            width: 26,
            height: 26,
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
                Text(label, style: TextStyle(color: _kAccent, fontSize: 11)),
                SizedBox(height: 2),
                Text(code, style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 10)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: _kPrimary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(example, style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 9)),
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
// TAB 2: DATETIME LAB
// =============================================================================
class _DateTimeLabTab extends StatefulWidget {
  @override
  State<_DateTimeLabTab> createState() => _DateTimeLabTabState();
}

class _DateTimeLabTabState extends State<_DateTimeLabTab> {
  // Simulated RestorableDateTime properties
  late DateTime _eventDate;
  late DateTime _dueDate;
  late DateTime _reminderDate;
  late DateTime _createdDate;

  final List<String> _eventLog = [];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _eventDate = now;
    _dueDate = now.add(Duration(days: 7));
    _reminderDate = now.add(Duration(hours: 2));
    _createdDate = now;
    _logEvent('Initialized with DateTime.now()');
  }

  void _updateDate(String name, DateTime newValue, void Function(DateTime) setter) {
    setState(() {
      setter(newValue);
      _logEvent('$name = ${_formatShort(newValue)}');
    });
  }

  Future<void> _pickDate(String name, DateTime current, void Function(DateTime) setter) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: current,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(primary: _kAccent, surface: _kCardBg),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      _updateDate(name, picked, setter);
    }
  }

  void _setToNow(String name, void Function(DateTime) setter) {
    _updateDate(name, DateTime.now(), setter);
  }

  void _addDays(String name, DateTime current, int days, void Function(DateTime) setter) {
    _updateDate(name, current.add(Duration(days: days)), setter);
  }

  void _logEvent(String event) {
    _eventLog.insert(0, '${DateTime.now().toString().substring(11, 19)}: $event');
    if (_eventLog.length > 8) _eventLog.removeLast();
  }

  String _formatShort(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
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
                'DateTime Lab',
                style: TextStyle(color: _kTextPrimary, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                'Each field simulates a RestorableDateTime. Always has a value—never null.',
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
                name: 'eventDate',
                label: 'Event Date',
                icon: Icons.event,
                value: _eventDate,
                onPick: () => _pickDate('eventDate', _eventDate, (d) => _eventDate = d),
                onNow: () => _setToNow('eventDate', (d) => _eventDate = d),
                onAddDays: (days) => _addDays('eventDate', _eventDate, days, (d) => _eventDate = d),
              ),
              SizedBox(height: 12),
              _DateFieldCard(
                name: 'dueDate',
                label: 'Due Date',
                icon: Icons.assignment_late,
                value: _dueDate,
                onPick: () => _pickDate('dueDate', _dueDate, (d) => _dueDate = d),
                onNow: () => _setToNow('dueDate', (d) => _dueDate = d),
                onAddDays: (days) => _addDays('dueDate', _dueDate, days, (d) => _dueDate = d),
              ),
              SizedBox(height: 12),
              _DateFieldCard(
                name: 'reminderDate',
                label: 'Reminder',
                icon: Icons.alarm,
                value: _reminderDate,
                onPick: () => _pickDate('reminderDate', _reminderDate, (d) => _reminderDate = d),
                onNow: () => _setToNow('reminderDate', (d) => _reminderDate = d),
                onAddDays: (days) => _addDays('reminderDate', _reminderDate, days, (d) => _reminderDate = d),
              ),
              SizedBox(height: 12),
              _DateFieldCard(
                name: 'createdDate',
                label: 'Created At',
                icon: Icons.fiber_new,
                value: _createdDate,
                onPick: () => _pickDate('createdDate', _createdDate, (d) => _createdDate = d),
                onNow: () => _setToNow('createdDate', (d) => _createdDate = d),
                onAddDays: (days) => _addDays('createdDate', _createdDate, days, (d) => _createdDate = d),
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
            '''eventDate.value = DateTime(${_eventDate.year}, ${_eventDate.month}, ${_eventDate.day});
dueDate.value = DateTime(${_dueDate.year}, ${_dueDate.month}, ${_dueDate.day});
reminderDate.value = DateTime(${_reminderDate.year}, ${_reminderDate.month}, ${_reminderDate.day});
createdDate.value = DateTime(${_createdDate.year}, ${_createdDate.month}, ${_createdDate.day});''',
            style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 10, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _DateFieldCard extends StatelessWidget {
  final String name;
  final String label;
  final IconData icon;
  final DateTime value;
  final VoidCallback onPick;
  final VoidCallback onNow;
  final void Function(int) onAddDays;

  const _DateFieldCard({
    required this.name,
    required this.label,
    required this.icon,
    required this.value,
    required this.onPick,
    required this.onNow,
    required this.onAddDays,
  });

  String get _displayDate {
    return '${value.year}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';
  }

  String get _displayTime {
    return '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}:${value.second.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
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
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _kAccent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: _kAccent, size: 22),
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
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _kAccent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text('Always Set', style: TextStyle(color: _kAccent, fontSize: 10, fontWeight: FontWeight.bold)),
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
                Icon(Icons.calendar_today, color: _kAccent, size: 18),
                SizedBox(width: 12),
                Text(_displayDate, style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 14)),
                SizedBox(width: 16),
                Icon(Icons.access_time, color: _kPrimary, size: 16),
                SizedBox(width: 8),
                Text(_displayTime, style: TextStyle(color: _kTextSecondary, fontFamily: 'monospace', fontSize: 12)),
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
                  label: Text('Pick'),
                  style: ElevatedButton.styleFrom(backgroundColor: _kPrimary, foregroundColor: Colors.white),
                ),
              ),
              SizedBox(width: 8),
              OutlinedButton(
                onPressed: onNow,
                child: Text('Now'),
                style: OutlinedButton.styleFrom(foregroundColor: _kAccent, side: BorderSide(color: _kAccent)),
              ),
              SizedBox(width: 8),
              _DaysButton(label: '+1d', onTap: () => onAddDays(1)),
              SizedBox(width: 6),
              _DaysButton(label: '+7d', onTap: () => onAddDays(7)),
            ],
          ),
        ],
      ),
    );
  }
}

class _DaysButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _DaysButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: _kSurface,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: _kDivider),
        ),
        child: Text(label, style: TextStyle(color: _kTextPrimary, fontSize: 11)),
      ),
    );
  }
}

// =============================================================================
// TAB 3: UTC VS LOCAL
// =============================================================================
class _UtcLocalTab extends StatefulWidget {
  @override
  State<_UtcLocalTab> createState() => _UtcLocalTabState();
}

class _UtcLocalTabState extends State<_UtcLocalTab> {
  late DateTime _localTime;
  late DateTime _utcTime;
  late int _serialized;

  @override
  void initState() {
    super.initState();
    _refreshTimes();
  }

  void _refreshTimes() {
    setState(() {
      _localTime = DateTime.now();
      _utcTime = _localTime.toUtc();
      _serialized = _localTime.millisecondsSinceEpoch;
    });
  }

  void _simulateRestore() {
    setState(() {
      // Restoration always creates local time
      final restored = DateTime.fromMillisecondsSinceEpoch(_serialized);
      _localTime = restored;
      _utcTime = restored.toUtc();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Restored! isUtc: ${_localTime.isUtc}'),
        backgroundColor: _kAccent,
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info banner
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_kPrimary, _kPrimary.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.public, color: _kAccent, size: 24),
                    SizedBox(width: 12),
                    Text(
                      'UTC vs Local Time',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'RestorableDateTime serializes using millisecondsSinceEpoch, which is '
                  'timezone-independent. However, restored DateTime is always local.',
                  style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          // Current times display
          Row(
            children: [
              Expanded(
                child: _TimeCard(
                  title: 'Local Time',
                  icon: Icons.location_on,
                  color: _kLocal,
                  time: _localTime,
                  isUtc: false,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _TimeCard(
                  title: 'UTC Time',
                  icon: Icons.public,
                  color: _kUtc,
                  time: _utcTime,
                  isUtc: true,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          // Serialization visualization
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kCardBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Serialization', style: TextStyle(color: _kTextPrimary, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                // Arrow down
                Center(
                  child: Column(
                    children: [
                      Text('DateTime.now()', style: TextStyle(color: _kLocal, fontSize: 12, fontFamily: 'monospace')),
                      SizedBox(height: 8),
                      Icon(Icons.arrow_downward, color: _kAccent),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: _kAccent.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: _kAccent),
                        ),
                        child: Text(
                          '.millisecondsSinceEpoch\n$_serialized',
                          style: TextStyle(color: _kAccent, fontFamily: 'monospace', fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 8),
                      Icon(Icons.arrow_downward, color: _kAccent),
                      SizedBox(height: 8),
                      Text(
                        'fromMillisecondsSinceEpoch($_serialized)',
                        style: TextStyle(color: _kLocal, fontSize: 10, fontFamily: 'monospace'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          // Key points
          _buildKeyPointsCard(),
          SizedBox(height: 24),
          // Actions
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _refreshTimes,
                  icon: Icon(Icons.refresh),
                  label: Text('Refresh Now'),
                  style: ElevatedButton.styleFrom(backgroundColor: _kPrimary, foregroundColor: Colors.white),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _simulateRestore,
                  icon: Icon(Icons.restore),
                  label: Text('Simulate Restore'),
                  style: ElevatedButton.styleFrom(backgroundColor: _kAccent, foregroundColor: Colors.black87),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          // Restore demonstration
          _buildRestoreDemoCard(),
        ],
      ),
    );
  }

  Widget _buildKeyPointsCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kHighlight.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: _kHighlight, size: 18),
              SizedBox(width: 8),
              Text('Key Points', style: TextStyle(color: _kHighlight, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 12),
          _KeyPoint(text: 'millisecondsSinceEpoch is timezone-independent'),
          _KeyPoint(text: 'Same epoch value = same instant worldwide'),
          _KeyPoint(text: 'fromMillisecondsSinceEpoch returns local DateTime'),
          _KeyPoint(text: 'isUtc property is NOT preserved after restoration'),
        ],
      ),
    );
  }

  Widget _buildRestoreDemoCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Restoration Demo', style: TextStyle(color: _kTextPrimary, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _DemoStep(
                  label: 'Original',
                  value: _utcTime.isUtc ? 'UTC' : 'Local',
                  color: _kUtc,
                ),
              ),
              Icon(Icons.arrow_forward, color: _kDivider),
              Expanded(
                child: _DemoStep(
                  label: 'Serialized',
                  value: _serialized.toString().substring(0, 7) + '...',
                  color: _kAccent,
                ),
              ),
              Icon(Icons.arrow_forward, color: _kDivider),
              Expanded(
                child: _DemoStep(
                  label: 'Restored',
                  value: 'Local',
                  color: _kLocal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final DateTime time;
  final bool isUtc;

  const _TimeCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.time,
    required this.isUtc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          SizedBox(height: 8),
          Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
          SizedBox(height: 8),
          Text(
            '${time.year}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')}',
            style: TextStyle(color: _kTextPrimary, fontFamily: 'monospace', fontSize: 12),
          ),
          Text(
            '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}',
            style: TextStyle(color: _kTextSecondary, fontFamily: 'monospace', fontSize: 11),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'isUtc: $isUtc',
              style: TextStyle(color: color, fontSize: 10, fontFamily: 'monospace'),
            ),
          ),
        ],
      ),
    );
  }
}

class _KeyPoint extends StatelessWidget {
  final String text;
  const _KeyPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.circle, color: _kHighlight, size: 8),
          SizedBox(width: 8),
          Expanded(
            child: Text(text, style: TextStyle(color: _kTextPrimary, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

class _DemoStep extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _DemoStep({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(color: _kTextSecondary, fontSize: 10)),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 11),
            overflow: TextOverflow.ellipsis,
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
      padding: EdgeInsets.only(left: level * 16.0, top: level > 0 ? 8 : 0),
      child: Row(
        children: [
          if (level > 0) ...[
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                border: Border(left: BorderSide(color: _kDivider), bottom: BorderSide(color: _kDivider)),
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
          Text(name, style: TextStyle(color: _kTextPrimary, fontSize: 10, fontFamily: 'monospace')),
          SizedBox(width: 4),
          Text('($desc)', style: TextStyle(color: _kTextSecondary, fontSize: 9)),
        ],
      ),
    );
  }
}
