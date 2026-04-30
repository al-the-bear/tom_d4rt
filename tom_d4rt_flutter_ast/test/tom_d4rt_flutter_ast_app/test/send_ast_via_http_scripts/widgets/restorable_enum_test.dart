// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────
//  RestorableEnum  –  Deep Visual Demo
//
//  Palette: Brown 700 / LightBlue 400
//  Tabs  : Theory · Playground · Restoration Lab
// ─────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  print('RestorableEnum demo building');
  return _RestorableEnumDemo();
}

// ── colour constants ────────────────────────────────────
const _kPrimary = Color(0xFF5D4037); // Brown 700
const _kAccent = Color(0xFF29B6F6); // LightBlue 400
const _kSurface = Color(0xFFEFEBE9); // Brown 50
const _kCardBg = Color(0xFFFFFFFF);
const _kDarkText = Color(0xFF3E2723); // Brown 900
const _kMuted = Color(0xFFBCAAA4); // Brown 200
const _kCodeBg = Color(0xFFE1F5FE); // LightBlue 50
const _kHighlight = Color(0xFFFFF3E0); // Orange 50
const _kGood = Color(0xFF2E7D32);
const _kBad = Color(0xFFC62828);

// ── Enums used for demonstration ────────────────────────
enum _Season { spring, summer, autumn, winter }

enum _Priority { low, medium, high, critical }

enum _ViewLayout { list, grid, compact, detailed }

class _RestorableEnumDemo extends StatefulWidget {
  @override
  State<_RestorableEnumDemo> createState() => _RestorableEnumDemoState();
}

class _RestorableEnumDemoState extends State<_RestorableEnumDemo>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kSurface,
      appBar: AppBar(
        title: Text('RestorableEnum',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        backgroundColor: _kPrimary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabCtrl,
          indicatorColor: _kAccent,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'Theory'),
            Tab(text: 'Playground'),
            Tab(text: 'Restoration Lab'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: [
          _TheoryTab(),
          _PlaygroundTab(),
          _RestorationLabTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  TAB 1  –  Theory
// ═══════════════════════════════════════════════════════════
class _TheoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // ── Overview ────────────────────────────────────
        _sectionCard(
          'What is RestorableEnum?',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RestorableEnum<T extends Enum> is a RestorableProperty that '
                'stores an enum value and survives state restoration — for '
                'example when Android kills a background activity. It '
                'serializes the enum by its index and deserializes it back '
                'when the framework restores the widget tree.',
                style: TextStyle(
                    color: _kDarkText, fontSize: 14, height: 1.5),
              ),
              SizedBox(height: 12),
              _codeBlock(
                'class RestorableEnum<T extends Enum>\n'
                '    extends RestorableValue<T> {\n'
                '  RestorableEnum(\n'
                '    T defaultValue, {\n'
                '    required List<T> values,\n'
                '  });\n'
                '\n'
                '  // Stored as int index.\n'
                '  // Restored via values[index].\n'
                '}',
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Constructor parameters ──────────────────────
        _sectionCard(
          'Constructor Parameters',
          Column(
            children: [
              _paramRow(
                'defaultValue',
                'T',
                'The enum value used when no restoration data exists. This is '
                'the initial value on first launch.',
                _kAccent,
              ),
              SizedBox(height: 8),
              _paramRow(
                'values',
                'List<T>',
                'The complete list of enum values (T.values). Used to map the '
                'stored index back to the correct enum member.',
                _kPrimary,
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Class hierarchy ─────────────────────────────
        _sectionCard(
          'Class Hierarchy',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _hierarchyRow(0, 'ChangeNotifier', Colors.grey),
              _hierarchyRow(1, 'RestorableProperty<T>', Colors.blueGrey),
              _hierarchyRow(2, 'RestorableValue<T>', Color(0xFF6D4C41)),
              _hierarchyRow(3, 'RestorableEnum<T extends Enum>', _kAccent),
              SizedBox(height: 12),
              Text(
                'RestorableEnum inherits from RestorableValue, which provides '
                'the value getter/setter. RestorableProperty provides the '
                'serialization protocol (toPrimitives/fromPrimitives) that the '
                'restoration framework uses.',
                style: TextStyle(
                    fontSize: 12, color: _kDarkText, height: 1.4),
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Registration workflow ───────────────────────
        _sectionCard(
          'Registration Workflow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _workflowStep(1, 'Declare',
                  'Create a RestorableEnum field in your State class.',
                  Icons.create, _kPrimary),
              SizedBox(height: 6),
              _workflowStep(2, 'Register',
                  'Call registerForRestoration() in restoreState().',
                  Icons.app_registration, _kAccent),
              SizedBox(height: 6),
              _workflowStep(3, 'Use',
                  'Read/write .value in build() and event handlers.',
                  Icons.play_arrow, Color(0xFF388E3C)),
              SizedBox(height: 6),
              _workflowStep(4, 'Serialize',
                  'Framework calls toPrimitives() → int index.',
                  Icons.save, Color(0xFFE65100)),
              SizedBox(height: 6),
              _workflowStep(5, 'Restore',
                  'Framework calls fromPrimitives() → enum from index.',
                  Icons.restore, Color(0xFF7B1FA2)),
              SizedBox(height: 12),
              _codeBlock(
                'class _MyState extends State<MyWidget>\n'
                '    with RestorationMixin {\n'
                '  final _season = RestorableEnum(\n'
                '    Season.spring,\n'
                '    values: Season.values,\n'
                '  );\n'
                '\n'
                '  @override\n'
                '  String get restorationId => \'my_widget\';\n'
                '\n'
                '  @override\n'
                '  void restoreState(\n'
                '    RestorationBucket? oldBucket,\n'
                '    bool initialRestore,\n'
                '  ) {\n'
                '    registerForRestoration(\n'
                '      _season, \'season\',\n'
                '    );\n'
                '  }\n'
                '}',
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── RestorableEnum vs RestorableEnumN ───────────
        _sectionCard(
          'RestorableEnum vs RestorableEnumN',
          Table(
            border: TableBorder.all(color: Colors.grey.shade300),
            columnWidths: {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
            },
            children: [
              _tableRow(
                  ['Aspect', 'RestorableEnum', 'RestorableEnumN'],
                  isHeader: true),
              _tableRow([
                'Nullability',
                'Non-null — always has a value',
                'Nullable — can be null',
              ]),
              _tableRow([
                'Default',
                'Required enum member',
                'Can default to null',
              ]),
              _tableRow([
                'Serialization',
                'int index',
                'int? index (null allowed)',
              ]),
              _tableRow([
                'Use case',
                'Setting that always has a value',
                'Optional / unset preference',
              ]),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Best practices ──────────────────────────────
        _sectionCard(
          'Best Practices',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _bp(true,
                  'Always pass T.values as the values parameter — it '
                  'guarantees correct deserialization.'),
              _bp(true,
                  'Dispose RestorableEnum in State.dispose() if you '
                  'add listeners to it.'),
              _bp(true,
                  'Choose a stable restorationId that does not change '
                  'between builds.'),
              _bp(false,
                  'Do NOT reorder enum members after data has been '
                  'persisted — the index will point to wrong values.'),
              _bp(false,
                  'Do NOT remove enum members from the middle — use '
                  'deprecation and keep the value for backward '
                  'compatibility.'),
            ],
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  TAB 2  –  Playground
// ═══════════════════════════════════════════════════════════
class _PlaygroundTab extends StatefulWidget {
  @override
  State<_PlaygroundTab> createState() => _PlaygroundTabState();
}

class _PlaygroundTabState extends State<_PlaygroundTab> {
  // Simulate RestorableEnum behavior with plain enum state + tracking
  _Season _season = _Season.spring;
  _Priority _priority = _Priority.medium;
  _ViewLayout _layout = _ViewLayout.list;

  int _changeCount = 0;
  final List<_ChangeRecord> _changes = [];

  void _onSeasonChanged(_Season s) {
    setState(() {
      _season = s;
      _recordChange('season', s.name, s.index);
    });
    print('Season changed → ${s.name} (index=${s.index})');
  }

  void _onPriorityChanged(_Priority p) {
    setState(() {
      _priority = p;
      _recordChange('priority', p.name, p.index);
    });
    print('Priority changed → ${p.name} (index=${p.index})');
  }

  void _onLayoutChanged(_ViewLayout l) {
    setState(() {
      _layout = l;
      _recordChange('layout', l.name, l.index);
    });
    print('Layout changed → ${l.name} (index=${l.index})');
  }

  void _recordChange(String prop, String value, int index) {
    _changeCount++;
    _changes.insert(
      0,
      _ChangeRecord(
        id: _changeCount,
        property: prop,
        value: value,
        index: index,
        time: DateTime.now(),
      ),
    );
    if (_changes.length > 30) _changes.removeLast();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left: enum controls
        Expanded(
          flex: 3,
          child: ListView(
            padding: EdgeInsets.all(14),
            children: [
              // ── Season control ────────────────────────
              _sectionCard(
                'Season (RestorableEnum<Season>)',
                Column(
                  children: [
                    // Visual preview
                    Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: _seasonColors(_season),
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(_seasonIcon(_season),
                              color: Colors.white, size: 32),
                          SizedBox(height: 4),
                          Text(_season.name.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                  letterSpacing: 2)),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    // Buttons
                    Row(
                      children: _Season.values.map((s) {
                        final sel = s == _season;
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2),
                            child: GestureDetector(
                              onTap: () => _onSeasonChanged(s),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: sel
                                      ? _seasonColors(s).first
                                      : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: sel
                                        ? _seasonColors(s).first
                                        : Colors.grey.shade300,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(s.name,
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: sel
                                            ? FontWeight.w700
                                            : FontWeight.w400,
                                        color: sel
                                            ? Colors.white
                                            : _kDarkText)),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 8),
                    _indexInfo('Season', _season.name, _season.index),
                  ],
                ),
              ),
              SizedBox(height: 12),

              // ── Priority control ──────────────────────
              _sectionCard(
                'Priority (RestorableEnum<Priority>)',
                Column(
                  children: [
                    // Visual priority bar
                    Row(
                      children: _Priority.values.map((p) {
                        final sel = p == _priority;
                        final color = _priorityColor(p);
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => _onPriorityChanged(p),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 250),
                              height: sel ? 64 : 40,
                              margin: EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: sel
                                    ? color
                                    : color.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: color,
                                  width: sel ? 2 : 1,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    _priorityIcon(p),
                                    color:
                                        sel ? Colors.white : color,
                                    size: sel ? 20 : 16,
                                  ),
                                  if (sel) ...[
                                    SizedBox(height: 2),
                                    Text(p.name,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700)),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 8),
                    _indexInfo('Priority', _priority.name, _priority.index),
                  ],
                ),
              ),
              SizedBox(height: 12),

              // ── Layout control ────────────────────────
              _sectionCard(
                'ViewLayout (RestorableEnum<ViewLayout>)',
                Column(
                  children: [
                    // Layout preview grid
                    Container(
                      height: 120,
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: _layoutPreview(_layout),
                    ),
                    SizedBox(height: 10),
                    // Selector
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: _ViewLayout.values.map((l) {
                        final sel = l == _layout;
                        return GestureDetector(
                          onTap: () => _onLayoutChanged(l),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: sel
                                  ? _kAccent
                                  : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: sel ? _kAccent : Colors.grey.shade300,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(_layoutIcon(l),
                                    size: 14,
                                    color:
                                        sel ? Colors.white : _kMuted),
                                SizedBox(width: 4),
                                Text(l.name,
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: sel
                                            ? FontWeight.w700
                                            : FontWeight.w400,
                                        color: sel
                                            ? Colors.white
                                            : _kDarkText)),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 8),
                    _indexInfo('ViewLayout', _layout.name, _layout.index),
                  ],
                ),
              ),
              SizedBox(height: 12),

              // ── Combined state inspector ──────────────
              _sectionCard(
                'Combined State Inspector',
                Column(
                  children: [
                    _inspRow('season.value', _season.name, _kPrimary),
                    _inspRow('season.toPrimitives()',
                        '${_season.index}', _kPrimary),
                    Divider(height: 10),
                    _inspRow('priority.value', _priority.name, _kAccent),
                    _inspRow('priority.toPrimitives()',
                        '${_priority.index}', _kAccent),
                    Divider(height: 10),
                    _inspRow(
                        'layout.value', _layout.name, Color(0xFF6D4C41)),
                    _inspRow('layout.toPrimitives()',
                        '${_layout.index}', Color(0xFF6D4C41)),
                  ],
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),

        // Right: change log
        Container(
          width: 220,
          decoration: BoxDecoration(
            color: _kCardBg,
            border: Border(left: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                color: _kPrimary.withOpacity(0.06),
                child: Row(
                  children: [
                    Icon(Icons.history, size: 16, color: _kPrimary),
                    SizedBox(width: 6),
                    Text('Change Log',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: _kDarkText)),
                    Spacer(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _kAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('$_changeCount',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _changes.isEmpty
                    ? Center(
                        child: Text('Change enum values\nto see log',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: _kMuted, fontSize: 12)),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(6),
                        itemCount: _changes.length,
                        itemBuilder: (_, i) {
                          final c = _changes[i];
                          final color =
                              c.property == 'season'
                                  ? _kPrimary
                                  : c.property == 'priority'
                                      ? _kAccent
                                      : Color(0xFF6D4C41);
                          return Padding(
                            padding: EdgeInsets.only(bottom: 4),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.04),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    color: color.withOpacity(0.15)),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 1),
                                        decoration: BoxDecoration(
                                          color: color.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        child: Text('#${c.id}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 9,
                                                color: color)),
                                      ),
                                      SizedBox(width: 4),
                                      Text(c.property,
                                          style: TextStyle(
                                              fontFamily: 'monospace',
                                              fontSize: 10,
                                              color: color,
                                              fontWeight:
                                                  FontWeight.w600)),
                                      Spacer(),
                                      Text(
                                        '${c.time.hour.toString().padLeft(2, '0')}:'
                                        '${c.time.minute.toString().padLeft(2, '0')}:'
                                        '${c.time.second.toString().padLeft(2, '0')}',
                                        style: TextStyle(
                                            fontSize: 8, color: _kMuted),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 3),
                                  Row(
                                    children: [
                                      Text('→ ${c.value}',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: _kDarkText,
                                              fontWeight:
                                                  FontWeight.w600)),
                                      SizedBox(width: 6),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 1),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        child: Text('idx:${c.index}',
                                            style: TextStyle(
                                                fontFamily: 'monospace',
                                                fontSize: 9,
                                                color: _kMuted)),
                                      ),
                                    ],
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
      ],
    );
  }

  Widget _indexInfo(String name, String value, int index) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _kHighlight,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.data_object, size: 14, color: _kPrimary),
          SizedBox(width: 6),
          Text('$name:',
              style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: _kMuted)),
          SizedBox(width: 4),
          Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                  color: _kDarkText)),
          Spacer(),
          Text('toPrimitives() → ',
              style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: _kMuted)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: _kAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text('$index',
                style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    color: _kAccent)),
          ),
        ],
      ),
    );
  }

  Widget _inspRow(String label, String value, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
                color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 6),
          Expanded(
            child: Text(label,
                style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: _kMuted)),
          ),
          Text(value,
              style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: _kDarkText)),
        ],
      ),
    );
  }

  // ── Season helpers ────────────────────────────────────
  List<Color> _seasonColors(_Season s) {
    switch (s) {
      case _Season.spring:
        return [Color(0xFF66BB6A), Color(0xFFA5D6A7)];
      case _Season.summer:
        return [Color(0xFFFFA726), Color(0xFFFFCC80)];
      case _Season.autumn:
        return [Color(0xFFEF6C00), Color(0xFFD84315)];
      case _Season.winter:
        return [Color(0xFF42A5F5), Color(0xFFBBDEFB)];
    }
  }

  IconData _seasonIcon(_Season s) {
    switch (s) {
      case _Season.spring:
        return Icons.local_florist;
      case _Season.summer:
        return Icons.wb_sunny;
      case _Season.autumn:
        return Icons.park;
      case _Season.winter:
        return Icons.ac_unit;
    }
  }

  // ── Priority helpers ──────────────────────────────────
  Color _priorityColor(_Priority p) {
    switch (p) {
      case _Priority.low:
        return Color(0xFF66BB6A);
      case _Priority.medium:
        return Color(0xFFFFA726);
      case _Priority.high:
        return Color(0xFFEF5350);
      case _Priority.critical:
        return Color(0xFFB71C1C);
    }
  }

  IconData _priorityIcon(_Priority p) {
    switch (p) {
      case _Priority.low:
        return Icons.arrow_downward;
      case _Priority.medium:
        return Icons.remove;
      case _Priority.high:
        return Icons.arrow_upward;
      case _Priority.critical:
        return Icons.priority_high;
    }
  }

  // ── Layout helpers ────────────────────────────────────
  IconData _layoutIcon(_ViewLayout l) {
    switch (l) {
      case _ViewLayout.list:
        return Icons.view_list;
      case _ViewLayout.grid:
        return Icons.grid_view;
      case _ViewLayout.compact:
        return Icons.view_comfy;
      case _ViewLayout.detailed:
        return Icons.view_agenda;
    }
  }

  Widget _layoutPreview(_ViewLayout l) {
    switch (l) {
      case _ViewLayout.list:
        return Column(
          children: List.generate(
            4,
            (i) => Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 3),
                decoration: BoxDecoration(
                  color: _kAccent.withOpacity(0.12 + i * 0.06),
                  borderRadius: BorderRadius.circular(4),
                ),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 8),
                child: Text('Row ${i + 1}',
                    style: TextStyle(
                        fontSize: 10, color: _kDarkText)),
              ),
            ),
          ),
        );
      case _ViewLayout.grid:
        return GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          physics: NeverScrollableScrollPhysics(),
          children: List.generate(
            6,
            (i) => Container(
              decoration: BoxDecoration(
                color: HSLColor.fromAHSL(
                        1, (i * 50).toDouble(), 0.4, 0.8)
                    .toColor(),
                borderRadius: BorderRadius.circular(6),
              ),
              alignment: Alignment.center,
              child: Text('${i + 1}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: _kDarkText)),
            ),
          ),
        );
      case _ViewLayout.compact:
        return Wrap(
          spacing: 4,
          runSpacing: 4,
          children: List.generate(
            8,
            (i) => Container(
              width: 40,
              height: 20,
              decoration: BoxDecoration(
                color: _kPrimary.withOpacity(0.1 + i * 0.05),
                borderRadius: BorderRadius.circular(3),
              ),
              alignment: Alignment.center,
              child: Text('${i + 1}',
                  style: TextStyle(fontSize: 9, color: _kDarkText)),
            ),
          ),
        );
      case _ViewLayout.detailed:
        return Column(
          children: List.generate(
            2,
            (i) => Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 4),
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: _kAccent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.image,
                          size: 18, color: _kAccent),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Item ${i + 1}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11,
                                  color: _kDarkText)),
                          Text('Detailed description',
                              style: TextStyle(
                                  fontSize: 9, color: _kMuted)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
    }
  }
}

class _ChangeRecord {
  final int id;
  final String property;
  final String value;
  final int index;
  final DateTime time;
  _ChangeRecord({
    required this.id,
    required this.property,
    required this.value,
    required this.index,
    required this.time,
  });
}

// ═══════════════════════════════════════════════════════════
//  TAB 3  –  Restoration Lab
// ═══════════════════════════════════════════════════════════
class _RestorationLabTab extends StatefulWidget {
  @override
  State<_RestorationLabTab> createState() => _RestorationLabTabState();
}

class _RestorationLabTabState extends State<_RestorationLabTab> {
  // Simulate restoration bucket
  _Season _season = _Season.spring;
  _Priority _priority = _Priority.medium;
  _ViewLayout _layout = _ViewLayout.list;

  // Saved state (bucket contents)
  Map<String, int> _bucket = {};
  bool _hasSavedState = false;
  final List<_RestoreEvent> _events = [];
  int _eventCount = 0;

  void _saveState() {
    setState(() {
      _bucket = {
        'season': _season.index,
        'priority': _priority.index,
        'layout': _layout.index,
      };
      _hasSavedState = true;
      _eventCount++;
      _events.insert(
        0,
        _RestoreEvent(
          _eventCount,
          'SAVE',
          'Saved 3 enums to bucket',
          Color(0xFF2E7D32),
          DateTime.now(),
        ),
      );
    });
    print('State saved: season=${_season.index}, '
        'priority=${_priority.index}, layout=${_layout.index}');
  }

  void _restoreState() {
    if (!_hasSavedState) return;
    setState(() {
      _season = _Season.values[_bucket['season']!];
      _priority = _Priority.values[_bucket['priority']!];
      _layout = _ViewLayout.values[_bucket['layout']!];
      _eventCount++;
      _events.insert(
        0,
        _RestoreEvent(
          _eventCount,
          'RESTORE',
          'Restored 3 enums from bucket',
          _kAccent,
          DateTime.now(),
        ),
      );
    });
    print('State restored: season=${_season.name}, '
        'priority=${_priority.name}, layout=${_layout.name}');
  }

  void _clearBucket() {
    setState(() {
      _bucket = {};
      _hasSavedState = false;
      _eventCount++;
      _events.insert(
        0,
        _RestoreEvent(
          _eventCount,
          'CLEAR',
          'Bucket cleared',
          _kBad,
          DateTime.now(),
        ),
      );
    });
    print('Bucket cleared');
  }

  void _randomize() {
    setState(() {
      _season = _Season
          .values[DateTime.now().microsecond % _Season.values.length];
      _priority = _Priority
          .values[DateTime.now().microsecond % _Priority.values.length];
      _layout = _ViewLayout
          .values[DateTime.now().microsecond % _ViewLayout.values.length];
      _eventCount++;
      _events.insert(
        0,
        _RestoreEvent(
          _eventCount,
          'RANDOM',
          'Randomized all enums',
          Color(0xFF7B1FA2),
          DateTime.now(),
        ),
      );
    });
    print('Randomized: ${_season.name}, ${_priority.name}, ${_layout.name}');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left: controls and visualization
        Expanded(
          flex: 3,
          child: ListView(
            padding: EdgeInsets.all(14),
            children: [
              // ── Current state ─────────────────────────
              _sectionCard(
                'Current Enum State',
                Column(
                  children: [
                    _enumStateRow(
                        'Season', _season.name, _season.index,
                        Icons.park, _kPrimary),
                    SizedBox(height: 6),
                    _enumStateRow(
                        'Priority', _priority.name, _priority.index,
                        Icons.flag, _kAccent),
                    SizedBox(height: 6),
                    _enumStateRow(
                        'Layout', _layout.name, _layout.index,
                        Icons.dashboard, Color(0xFF6D4C41)),
                  ],
                ),
              ),
              SizedBox(height: 12),

              // ── Quick change buttons ──────────────────
              _sectionCard(
                'Modify Current State',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Season:',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: _kDarkText)),
                    SizedBox(height: 4),
                    Wrap(
                      spacing: 4,
                      children: _Season.values
                          .map((s) => _enumChip(
                              s.name,
                              s == _season,
                              _kPrimary,
                              () => setState(() => _season = s)))
                          .toList(),
                    ),
                    SizedBox(height: 8),
                    Text('Priority:',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: _kDarkText)),
                    SizedBox(height: 4),
                    Wrap(
                      spacing: 4,
                      children: _Priority.values
                          .map((p) => _enumChip(
                              p.name,
                              p == _priority,
                              _kAccent,
                              () => setState(() => _priority = p)))
                          .toList(),
                    ),
                    SizedBox(height: 8),
                    Text('Layout:',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: _kDarkText)),
                    SizedBox(height: 4),
                    Wrap(
                      spacing: 4,
                      children: _ViewLayout.values
                          .map((l) => _enumChip(
                              l.name,
                              l == _layout,
                              Color(0xFF6D4C41),
                              () => setState(() => _layout = l)))
                          .toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),

              // ── Action buttons ────────────────────────
              _sectionCard(
                'Restoration Actions',
                Row(
                  children: [
                    _actionBtn('Save', Icons.save, Color(0xFF2E7D32),
                        _saveState),
                    SizedBox(width: 6),
                    _actionBtn('Restore', Icons.restore, _kAccent,
                        _hasSavedState ? _restoreState : null),
                    SizedBox(width: 6),
                    _actionBtn('Randomize', Icons.shuffle,
                        Color(0xFF7B1FA2), _randomize),
                    SizedBox(width: 6),
                    _actionBtn('Clear', Icons.delete_sweep, _kBad,
                        _hasSavedState ? _clearBucket : null),
                  ],
                ),
              ),
              SizedBox(height: 12),

              // ── Bucket visualization ──────────────────
              _sectionCard(
                'Restoration Bucket Contents',
                _hasSavedState
                    ? Column(
                        children: [
                          _bucketRow('season', _bucket['season'] ?? 0,
                              _Season.values[_bucket['season'] ?? 0].name),
                          SizedBox(height: 4),
                          _bucketRow(
                              'priority',
                              _bucket['priority'] ?? 0,
                              _Priority
                                  .values[_bucket['priority'] ?? 0].name),
                          SizedBox(height: 4),
                          _bucketRow(
                              'layout',
                              _bucket['layout'] ?? 0,
                              _ViewLayout
                                  .values[_bucket['layout'] ?? 0].name),
                          SizedBox(height: 10),
                          // JSON visualization
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: _kCodeBg,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: _kAccent.withOpacity(0.2)),
                            ),
                            child: Text(
                              '{\n'
                              '  "season": ${_bucket['season']},\n'
                              '  "priority": ${_bucket['priority']},\n'
                              '  "layout": ${_bucket['layout']}\n'
                              '}',
                              style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 12,
                                  color: _kDarkText,
                                  height: 1.5),
                            ),
                          ),
                        ],
                      )
                    : Container(
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Icon(Icons.inventory_2_outlined,
                                size: 32, color: _kMuted),
                            SizedBox(height: 6),
                            Text('Bucket is empty',
                                style: TextStyle(
                                    color: _kMuted, fontSize: 12)),
                            Text('Press Save to store current state',
                                style: TextStyle(
                                    color: _kMuted, fontSize: 10)),
                          ],
                        ),
                      ),
              ),
              SizedBox(height: 12),

              // ── Match indicator ───────────────────────
              if (_hasSavedState)
                _sectionCard(
                  'State Match',
                  Column(
                    children: [
                      _matchRow('Season',
                          _season.index == (_bucket['season'] ?? -1)),
                      _matchRow('Priority',
                          _priority.index == (_bucket['priority'] ?? -1)),
                      _matchRow('Layout',
                          _layout.index == (_bucket['layout'] ?? -1)),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: (_season.index ==
                                      (_bucket['season'] ?? -1) &&
                                  _priority.index ==
                                      (_bucket['priority'] ?? -1) &&
                                  _layout.index ==
                                      (_bucket['layout'] ?? -1))
                              ? _kGood.withOpacity(0.06)
                              : _kBad.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          (_season.index ==
                                      (_bucket['season'] ?? -1) &&
                                  _priority.index ==
                                      (_bucket['priority'] ?? -1) &&
                                  _layout.index ==
                                      (_bucket['layout'] ?? -1))
                              ? 'All values match saved state'
                              : 'Values differ from saved state — press Restore to sync',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: (_season.index ==
                                        (_bucket['season'] ?? -1) &&
                                    _priority.index ==
                                        (_bucket['priority'] ?? -1) &&
                                    _layout.index ==
                                        (_bucket['layout'] ?? -1))
                                ? _kGood
                                : _kBad,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 24),
            ],
          ),
        ),

        // Right: event log
        Container(
          width: 220,
          decoration: BoxDecoration(
            color: _kCardBg,
            border: Border(left: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                color: _kAccent.withOpacity(0.06),
                child: Row(
                  children: [
                    Icon(Icons.receipt_long, size: 16, color: _kAccent),
                    SizedBox(width: 6),
                    Text('Restore Events',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: _kDarkText)),
                  ],
                ),
              ),
              Expanded(
                child: _events.isEmpty
                    ? Center(
                        child: Text(
                          'Save/restore state\nto see events',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: _kMuted, fontSize: 12),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(6),
                        itemCount: _events.length,
                        itemBuilder: (_, i) {
                          final e = _events[i];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 4),
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: e.color.withOpacity(0.05),
                                borderRadius:
                                    BorderRadius.circular(6),
                                border: Border.all(
                                    color:
                                        e.color.withOpacity(0.15)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 1),
                                    decoration: BoxDecoration(
                                      color: e.color,
                                      borderRadius:
                                          BorderRadius.circular(4),
                                    ),
                                    child: Text(e.action,
                                        style: TextStyle(
                                            fontWeight:
                                                FontWeight.w700,
                                            fontSize: 8,
                                            color: Colors.white)),
                                  ),
                                  SizedBox(width: 6),
                                  Expanded(
                                    child: Text(e.detail,
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: _kDarkText)),
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
      ],
    );
  }

  Widget _enumStateRow(String name, String value, int index,
      IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.04),
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: color, width: 3)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          SizedBox(width: 8),
          Text(name,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: _kDarkText)),
          Spacer(),
          Text(value,
              style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: color)),
          SizedBox(width: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text('idx:$index',
                style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 9,
                    color: _kMuted)),
          ),
        ],
      ),
    );
  }

  Widget _enumChip(
      String label, bool selected, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: selected ? color : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? color : Colors.grey.shade300,
          ),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 10,
                fontWeight:
                    selected ? FontWeight.w700 : FontWeight.w400,
                color: selected ? Colors.white : _kDarkText)),
      ),
    );
  }

  Widget _actionBtn(
      String label, IconData icon, Color color, VoidCallback? onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: onTap != null
                ? color.withOpacity(0.08)
                : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: onTap != null ? color : Colors.grey.shade300,
            ),
          ),
          child: Column(
            children: [
              Icon(icon,
                  size: 18,
                  color: onTap != null ? color : Colors.grey.shade400),
              SizedBox(height: 2),
              Text(label,
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: onTap != null
                          ? color
                          : Colors.grey.shade400)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bucketRow(String key, int index, String resolvedName) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _kPrimary.withOpacity(0.03),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _kPrimary.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Text('"$key"',
              style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: _kAccent)),
          SizedBox(width: 6),
          Text(':',
              style: TextStyle(color: _kMuted, fontSize: 11)),
          SizedBox(width: 6),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            decoration: BoxDecoration(
              color: _kAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text('$index',
                style: TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    color: _kAccent)),
          ),
          Spacer(),
          Icon(Icons.arrow_forward, size: 12, color: _kMuted),
          SizedBox(width: 4),
          Text(resolvedName,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                  color: _kDarkText)),
        ],
      ),
    );
  }

  Widget _matchRow(String name, bool matches) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            matches ? Icons.check_circle : Icons.cancel,
            size: 16,
            color: matches ? _kGood : _kBad,
          ),
          SizedBox(width: 6),
          Text(name,
              style: TextStyle(fontSize: 12, color: _kDarkText)),
          Spacer(),
          Text(matches ? 'Matches' : 'Differs',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: matches ? _kGood : _kBad)),
        ],
      ),
    );
  }
}

class _RestoreEvent {
  final int id;
  final String action;
  final String detail;
  final Color color;
  final DateTime time;
  _RestoreEvent(this.id, this.action, this.detail, this.color, this.time);
}

// ═══════════════════════════════════════════════════════════
//  Shared helpers
// ═══════════════════════════════════════════════════════════

Widget _sectionCard(String title, Widget child) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: _kPrimary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: _kDarkText)),
            ),
          ],
        ),
        SizedBox(height: 12),
        child,
      ],
    ),
  );
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kAccent.withOpacity(0.2)),
    ),
    child: Text(code,
        style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: _kDarkText,
            height: 1.5)),
  );
}

Widget _paramRow(String name, String type, String desc, Color color) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withOpacity(0.04),
      borderRadius: BorderRadius.circular(8),
      border: Border(left: BorderSide(color: color, width: 3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(name,
                  style: TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: color)),
            ),
            SizedBox(width: 8),
            Text(type,
                style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: _kMuted)),
          ],
        ),
        SizedBox(height: 4),
        Text(desc,
            style: TextStyle(
                fontSize: 12, color: _kDarkText, height: 1.3)),
      ],
    ),
  );
}

Widget _hierarchyRow(int indent, String name, Color color) {
  return Padding(
    padding: EdgeInsets.only(left: indent * 20.0, bottom: 4),
    child: Row(
      children: [
        if (indent > 0) ...[
          Container(
            width: 12,
            height: 2,
            color: color.withOpacity(0.3),
          ),
          SizedBox(width: 4),
        ],
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Text(name,
              style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: color)),
        ),
      ],
    ),
  );
}

Widget _workflowStep(
    int step, String title, String desc, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withOpacity(0.04),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withOpacity(0.15)),
    ),
    child: Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text('$step',
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                  color: color)),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: _kDarkText)),
              Text(desc,
                  style: TextStyle(
                      fontSize: 11, color: _kMuted, height: 1.3)),
            ],
          ),
        ),
        Icon(icon, size: 20, color: color),
      ],
    ),
  );
}

TableRow _tableRow(List<String> cells, {bool isHeader = false}) {
  return TableRow(
    decoration: isHeader
        ? BoxDecoration(color: _kPrimary.withOpacity(0.08))
        : null,
    children: cells.map((c) {
      return Padding(
        padding: EdgeInsets.all(8),
        child: Text(c,
            style: TextStyle(
                fontSize: 11,
                fontWeight:
                    isHeader ? FontWeight.w700 : FontWeight.w400,
                color: isHeader ? _kPrimary : _kDarkText)),
      );
    }).toList(),
  );
}

Widget _bp(bool isGood, String text) {
  final color = isGood ? Color(0xFF2E7D32) : Color(0xFFC62828);
  final icon =
      isGood ? Icons.check_circle_outline : Icons.cancel_outlined;
  return Padding(
    padding: EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 18),
        SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  fontSize: 12, color: _kDarkText, height: 1.4)),
        ),
      ],
    ),
  );
}
