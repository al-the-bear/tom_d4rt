// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────
//  SelectAction  –  Deep Visual Demo
//
//  Palette : Teal 700 / DeepOrange 300
//  Tabs    : Theory · Workshop · Scenarios
// ─────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  print('SelectAction demo building');
  return _SelectActionDemo();
}

// ── colour constants ────────────────────────────────────
const _kPrimary = Color(0xFF00796B); // Teal 700
const _kAccent = Color(0xFFFF8A65); // DeepOrange 300
const _kSurface = Color(0xFFE0F2F1); // Teal 50
const _kCardBg = Color(0xFFFFFFFF);
const _kDarkText = Color(0xFF004D40); // Teal 900
const _kMuted = Color(0xFF80CBC4); // Teal 200
const _kCodeBg = Color(0xFFFBE9E7); // DeepOrange 50
const _kHighlight = Color(0xFFFFF8E1); // Amber 50
const _kSelectColor = Color(0xFF1565C0);
const _kIntentColor = Color(0xFF6A1B9A);
const _kActionColor = Color(0xFF2E7D32);
const _kCallbackColor = Color(0xFFC62828);

class _SelectActionDemo extends StatefulWidget {
  @override
  State<_SelectActionDemo> createState() =>
      _SelectActionDemoState();
}

class _SelectActionDemoState extends State<_SelectActionDemo>
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
        title: Text('SelectAction',
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
            Tab(text: 'Workshop'),
            Tab(text: 'Scenarios'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: [
          _TheoryTab(),
          _WorkshopTab(),
          _ScenarioTab(),
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
          'What is SelectAction?',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SelectAction is a concrete Action<SelectIntent> that '
                'triggers selection behaviour in response to a SelectIntent. '
                'It is part of Flutter\'s Intent/Action shortcut system, '
                'which decouples keyboard shortcuts and UI triggers from '
                'the actual behaviour they invoke.',
                style: TextStyle(
                    color: _kDarkText, fontSize: 14, height: 1.5),
              ),
              SizedBox(height: 12),
              _codeBlock(
                '// SelectAction wraps a VoidCallback\n'
                'class SelectAction extends Action<SelectIntent> {\n'
                '  SelectAction({required VoidCallback onSelect});\n'
                '\n'
                '  @override\n'
                '  void invoke(SelectIntent intent) {\n'
                '    // Calls the onSelect callback\n'
                '  }\n'
                '}',
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Intent/Action system overview ───────────────
        _sectionCard(
          'The Intent / Action System',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Flutter uses Intents and Actions to separate "what should '
                'happen" from "how it happens". Shortcuts map key combos '
                'to Intents; the Actions widget maps Intents to Actions.',
                style: TextStyle(
                    color: _kDarkText, fontSize: 12, height: 1.4),
              ),
              SizedBox(height: 10),
              _flowRow(1, 'Shortcut triggers', 'Shortcuts widget maps '
                  'a key combination to a SelectIntent.',
                  _kIntentColor, Icons.keyboard),
              SizedBox(height: 6),
              _flowRow(2, 'Intent dispatched', 'The SelectIntent is '
                  'dispatched to the nearest Actions widget.',
                  _kSelectColor, Icons.send),
              SizedBox(height: 6),
              _flowRow(3, 'Action invoked', 'Actions widget finds the '
                  'SelectAction mapped to SelectIntent and calls invoke().',
                  _kActionColor, Icons.play_arrow),
              SizedBox(height: 6),
              _flowRow(4, 'Callback runs', 'The onSelect callback '
                  'executes the desired behaviour.',
                  _kCallbackColor, Icons.check_circle),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Key classes ─────────────────────────────────
        _sectionCard(
          'Key Classes',
          Column(
            children: [
              _classRow('SelectIntent', 'Intent',
                  'A semantic intent that represents a "select" action. '
                  'Contains no data — it is a marker intent.',
                  _kIntentColor, Icons.lightbulb_outline),
              SizedBox(height: 8),
              _classRow('SelectAction', 'Action<SelectIntent>',
                  'Handles SelectIntent by invoking a VoidCallback. '
                  'Register it with the Actions widget.',
                  _kActionColor, Icons.play_arrow),
              SizedBox(height: 8),
              _classRow('Actions', 'Widget',
                  'Maps Intent types to Action instances. Searches up '
                  'the widget tree for handlers.',
                  _kSelectColor, Icons.account_tree),
              SizedBox(height: 8),
              _classRow('Shortcuts', 'Widget',
                  'Maps key combinations to Intent instances. Works '
                  'together with Actions.',
                  _kCallbackColor, Icons.keyboard),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Registration code ───────────────────────────
        _sectionCard(
          'How To Register',
          _codeBlock(
            'Actions(\n'
            '  actions: {\n'
            '    SelectIntent: SelectAction(\n'
            '      onSelect: () {\n'
            '        // Handle select\n'
            '        setState(() => _selected = true);\n'
            '      },\n'
            '    ),\n'
            '  },\n'
            '  child: Shortcuts(\n'
            '    shortcuts: {\n'
            '      SingleActivator(LogicalKeyboardKey.enter):\n'
            '          SelectIntent(),\n'
            '    },\n'
            '    child: Focus(\n'
            '      autofocus: true,\n'
            '      child: MyWidget(),\n'
            '    ),\n'
            '  ),\n'
            ')',
          ),
        ),
        SizedBox(height: 14),

        // ── Comparison with other actions ───────────────
        _sectionCard(
          'SelectAction vs. Other Built-in Actions',
          Table(
            border: TableBorder.all(color: Colors.grey.shade300),
            columnWidths: {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(3),
            },
            children: [
              _tableRow(['Action', 'Intent', 'Purpose'],
                  isHeader: true),
              _tableRow(
                  ['SelectAction', 'SelectIntent', 'Generic "select" from keyboard']),
              _tableRow(
                  ['ActivateAction', 'ActivateIntent', 'Activate focused widget']),
              _tableRow(
                  ['DismissAction', 'DismissIntent', 'Dismiss focused overlay']),
              _tableRow(
                  ['ScrollAction', 'ScrollIntent', 'Scroll in a direction']),
              _tableRow(
                  ['DirectionalFocusAction', 'DirectionalFocusIntent', 'Move focus directionally']),
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
                  'Use SelectAction for keyboard-driven selection in '
                  'custom list/grid widgets that are not based on standard '
                  'Material components.'),
              _bp(true,
                  'Pair SelectAction with Focus widgets to ensure the '
                  'correct scope receives the intent.'),
              _bp(true,
                  'Use Actions.invoke(context, SelectIntent()) '
                  'to programmatically trigger select from code.'),
              _bp(false,
                  'Do NOT use SelectAction when a standard widget '
                  '(ListTile, DropdownButton) already handles selection '
                  'internally.'),
              _bp(false,
                  'Do NOT register Actions at the app root if only a '
                  'subtree needs them — scope them to the relevant widget.'),
            ],
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  TAB 2  –  Workshop
// ═══════════════════════════════════════════════════════════
class _WorkshopTab extends StatefulWidget {
  @override
  State<_WorkshopTab> createState() => _WorkshopTabState();
}

class _WorkshopTabState extends State<_WorkshopTab> {
  // Item grid
  static const int _gridSize = 12;
  final Set<int> _selected = {};
  int _focusedIndex = 0;
  int _selectCount = 0;
  int _deselectCount = 0;
  final List<_ActionEvent> _events = [];
  int _eventId = 0;

  // Palette for items
  static const List<Color> _itemColors = [
    Color(0xFF1565C0), Color(0xFF2E7D32), Color(0xFFC62828),
    Color(0xFF6A1B9A), Color(0xFFEF6C00), Color(0xFF00838F),
    Color(0xFF4E342E), Color(0xFF37474F), Color(0xFFAD1457),
    Color(0xFF558B2F), Color(0xFF283593), Color(0xFFBF360C),
  ];

  static const List<IconData> _itemIcons = [
    Icons.star, Icons.favorite, Icons.bookmark,
    Icons.flag, Icons.circle, Icons.diamond,
    Icons.hexagon, Icons.square, Icons.bolt,
    Icons.brightness_7, Icons.spa, Icons.auto_awesome,
  ];

  void _toggleSelect(int index) {
    _eventId++;
    final wasSelected = _selected.contains(index);
    setState(() {
      if (wasSelected) {
        _selected.remove(index);
        _deselectCount++;
      } else {
        _selected.add(index);
        _selectCount++;
      }
      _events.insert(
          0,
          _ActionEvent(
            id: _eventId,
            action: wasSelected ? 'Deselected' : 'Selected',
            target: 'Item ${index + 1}',
            method: 'SelectAction.invoke()',
            time: DateTime.now(),
          ));
      if (_events.length > 30) _events.removeLast();
    });
    print('SelectAction: ${wasSelected ? "Deselected" : "Selected"} '
        'item ${index + 1}');
  }

  void _selectAll() {
    _eventId++;
    setState(() {
      for (int i = 0; i < _gridSize; i++) {
        if (!_selected.contains(i)) {
          _selected.add(i);
          _selectCount++;
        }
      }
      _events.insert(
          0,
          _ActionEvent(
            id: _eventId,
            action: 'Select All',
            target: 'All items',
            method: 'Batch invoke()',
            time: DateTime.now(),
          ));
      if (_events.length > 30) _events.removeLast();
    });
  }

  void _deselectAll() {
    _eventId++;
    final count = _selected.length;
    setState(() {
      _selected.clear();
      _deselectCount += count;
      _events.insert(
          0,
          _ActionEvent(
            id: _eventId,
            action: 'Deselect All',
            target: '$count items',
            method: 'Clear selection',
            time: DateTime.now(),
          ));
      if (_events.length > 30) _events.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left: grid and controls
        Expanded(
          flex: 3,
          child: Column(
            children: [
              // ── Toolbar ──────────────────────────────
              Container(
                color: _kCardBg,
                padding:
                    EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: Row(
                  children: [
                    Text('Selection Grid',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: _kDarkText)),
                    Spacer(),
                    _toolBtn('Select All', Icons.select_all,
                        _kActionColor, _selectAll),
                    SizedBox(width: 6),
                    _toolBtn('Clear', Icons.deselect,
                        _kCallbackColor, _deselectAll),
                  ],
                ),
              ),
              Divider(height: 1),

              // ── Selection counter ────────────────────
              Container(
                color: _kPrimary.withOpacity(0.04),
                padding:
                    EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                child: Row(
                  children: [
                    Icon(Icons.check_box, size: 14, color: _kPrimary),
                    SizedBox(width: 6),
                    Text(
                      '${_selected.length} of $_gridSize selected',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _kDarkText),
                    ),
                    Spacer(),
                    // Selection bar
                    Container(
                      width: 100,
                      height: 6,
                      decoration: BoxDecoration(
                        color: _kMuted.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: FractionallySizedBox(
                        widthFactor: _selected.length / _gridSize,
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: _kPrimary,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1),

              // ── Item grid ────────────────────────────
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(14),
                  child: GridView.builder(
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: _gridSize,
                    itemBuilder: (_, i) {
                      final selected = _selected.contains(i);
                      final focused = _focusedIndex == i;
                      final color = _itemColors[i % _itemColors.length];
                      return GestureDetector(
                        onTap: () {
                          setState(() => _focusedIndex = i);
                          _toggleSelect(i);
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: selected
                                ? color.withOpacity(0.12)
                                : _kCardBg,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: focused
                                  ? _kAccent
                                  : selected
                                      ? color
                                      : Colors.grey.shade300,
                              width: focused ? 2.5 : selected ? 2 : 1,
                            ),
                            boxShadow: selected
                                ? [
                                    BoxShadow(
                                      color: color.withOpacity(0.15),
                                      blurRadius: 8,
                                      offset: Offset(0, 2),
                                    ),
                                  ]
                                : [],
                          ),
                          child: Column(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color:
                                          color.withOpacity(0.12),
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      _itemIcons[
                                          i % _itemIcons.length],
                                      color: color,
                                      size: 22,
                                    ),
                                  ),
                                  if (selected)
                                    Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        color: color,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(Icons.check,
                                          size: 10,
                                          color: Colors.white),
                                    ),
                                ],
                              ),
                              SizedBox(height: 6),
                              Text('Item ${i + 1}',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: selected
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      color: selected
                                          ? color
                                          : _kDarkText)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // ── Intent builder section ───────────────
              Container(
                padding: EdgeInsets.all(12),
                margin:
                    EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: _kCodeBg,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: _kAccent.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Generated Code',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                            color: _kPrimary)),
                    SizedBox(height: 6),
                    Text(
                      'Actions(\n'
                      '  actions: {\n'
                      '    SelectIntent: SelectAction(\n'
                      '      onSelect: () => toggle(focusedItem),\n'
                      '    ),\n'
                      '  },\n'
                      '  child: /* ${_selected.length} items selected */\n'
                      ')',
                      style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11,
                          color: _kDarkText,
                          height: 1.5),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),

        // Right: event log sidebar
        Container(
          width: 250,
          decoration: BoxDecoration(
            color: _kCardBg,
            border:
                Border(left: BorderSide(color: Colors.grey.shade300)),
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
                    Text('Action Log',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: _kDarkText)),
                    Spacer(),
                    _miniTag('$_selectCount sel', _kActionColor),
                    SizedBox(width: 4),
                    _miniTag('$_deselectCount des', _kCallbackColor),
                  ],
                ),
              ),
              Expanded(
                child: _events.isEmpty
                    ? Center(
                        child: Text(
                          'Tap items to fire\nSelectAction events',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: _kMuted, fontSize: 11),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(6),
                        itemCount: _events.length,
                        itemBuilder: (_, i) {
                          final e = _events[i];
                          final isSelect =
                              e.action.startsWith('Select');
                          return Padding(
                            padding: EdgeInsets.only(bottom: 3),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isSelect
                                    ? _kActionColor
                                        .withOpacity(0.04)
                                    : _kCallbackColor
                                        .withOpacity(0.04),
                                borderRadius:
                                    BorderRadius.circular(6),
                                border: Border.all(
                                    color: isSelect
                                        ? _kActionColor
                                            .withOpacity(0.12)
                                        : _kCallbackColor
                                            .withOpacity(0.12)),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        isSelect
                                            ? Icons.check_circle
                                            : Icons.cancel,
                                        size: 12,
                                        color: isSelect
                                            ? _kActionColor
                                            : _kCallbackColor,
                                      ),
                                      SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          '${e.action}: ${e.target}',
                                          style: TextStyle(
                                              fontWeight:
                                                  FontWeight.w600,
                                              fontSize: 10,
                                              color: _kDarkText),
                                        ),
                                      ),
                                      Text(
                                        '${e.time.hour.toString().padLeft(2, '0')}:'
                                        '${e.time.minute.toString().padLeft(2, '0')}:'
                                        '${e.time.second.toString().padLeft(2, '0')}',
                                        style: TextStyle(
                                            fontSize: 8,
                                            color: _kMuted),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2),
                                  Text(e.method,
                                      style: TextStyle(
                                          fontFamily: 'monospace',
                                          fontSize: 9,
                                          color: _kMuted)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),

              // Stats
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _kPrimary.withOpacity(0.04),
                  border: Border(
                      top: BorderSide(color: Colors.grey.shade200)),
                ),
                child: Column(
                  children: [
                    _statRow('Total selects', '$_selectCount'),
                    SizedBox(height: 2),
                    _statRow('Total deselects', '$_deselectCount'),
                    SizedBox(height: 2),
                    _statRow('Currently selected',
                        '${_selected.length}/$_gridSize'),
                    SizedBox(height: 2),
                    _statRow('Focused', 'Item ${_focusedIndex + 1}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _toolBtn(
      String label, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            SizedBox(width: 4),
            Text(label,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: color)),
          ],
        ),
      ),
    );
  }

  Widget _miniTag(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label,
          style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: color)),
    );
  }

  Widget _statRow(String label, String value) {
    return Row(
      children: [
        Text(label,
            style: TextStyle(fontSize: 10, color: _kMuted)),
        Spacer(),
        Text(value,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: _kDarkText)),
      ],
    );
  }
}

class _ActionEvent {
  final int id;
  final String action;
  final String target;
  final String method;
  final DateTime time;
  _ActionEvent({
    required this.id,
    required this.action,
    required this.target,
    required this.method,
    required this.time,
  });
}

// ═══════════════════════════════════════════════════════════
//  TAB 3  –  Scenarios
// ═══════════════════════════════════════════════════════════
class _ScenarioTab extends StatefulWidget {
  @override
  State<_ScenarioTab> createState() => _ScenarioTabState();
}

class _ScenarioTabState extends State<_ScenarioTab> {
  int _activeScenario = -1;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // ── Scenario 1: Custom list ─────────────────────
        _scenarioCard(
          0,
          'Custom Keyboard-Driven List',
          Icons.list,
          _kSelectColor,
          'A custom list widget where users navigate with arrow keys '
          'and select with Enter via SelectAction.',
          _ScenarioCustomList(),
        ),
        SizedBox(height: 14),

        // ── Scenario 2: Action chain ────────────────────
        _scenarioCard(
          1,
          'Action Chain with Feedback',
          Icons.link,
          _kActionColor,
          'SelectAction triggers a chain: select → validate → animate '
          '→ confirm. Each step provides visual feedback.',
          _ScenarioActionChain(),
        ),
        SizedBox(height: 14),

        // ── Scenario 3: Multi-scope selection ───────────
        _scenarioCard(
          2,
          'Multi-Scope Actions',
          Icons.layers,
          _kIntentColor,
          'Different parts of the widget tree register different '
          'SelectAction handlers, demonstrating scope resolution.',
          _ScenarioMultiScope(),
        ),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _scenarioCard(int index, String title, IconData icon,
      Color color, String desc, Widget child) {
    final active = _activeScenario == index;
    return Container(
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
          // Header
          GestureDetector(
            onTap: () => setState(
                () => _activeScenario = active ? -1 : index),
            child: Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: active
                    ? color.withOpacity(0.06)
                    : _kCardBg,
                borderRadius: active
                    ? BorderRadius.vertical(top: Radius.circular(12))
                    : BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Icon(icon, size: 20, color: color),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: _kDarkText)),
                        Text(desc,
                            style: TextStyle(
                                fontSize: 11,
                                color: _kMuted,
                                height: 1.3)),
                      ],
                    ),
                  ),
                  Icon(
                    active
                        ? Icons.expand_less
                        : Icons.expand_more,
                    color: _kMuted,
                  ),
                ],
              ),
            ),
          ),
          // Content
          if (active)
            Padding(
              padding:
                  EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: child,
            ),
        ],
      ),
    );
  }
}

// ── Scenario 1: Custom keyboard list ────────────────────
class _ScenarioCustomList extends StatefulWidget {
  @override
  State<_ScenarioCustomList> createState() =>
      _ScenarioCustomListState();
}

class _ScenarioCustomListState extends State<_ScenarioCustomList> {
  int _focusedIdx = 0;
  final Set<int> _selectedItems = {};
  final List<String> _items = [
    'Documents', 'Photos', 'Music', 'Videos',
    'Downloads', 'Desktop',
  ];

  void _selectCurrent() {
    setState(() {
      if (_selectedItems.contains(_focusedIdx)) {
        _selectedItems.remove(_focusedIdx);
      } else {
        _selectedItems.add(_focusedIdx);
      }
    });
    print('Scenario: SelectAction invoked for '
        '"${_items[_focusedIdx]}"');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kHighlight,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline,
                  size: 14, color: Color(0xFFF57F17)),
              SizedBox(width: 6),
              Text('Tap items to simulate Enter key → SelectAction',
                  style: TextStyle(
                      fontSize: 11,
                      color: _kDarkText,
                      fontStyle: FontStyle.italic)),
            ],
          ),
        ),
        SizedBox(height: 8),
        ...List.generate(_items.length, (i) {
          final isFocused = _focusedIdx == i;
          final isSelected = _selectedItems.contains(i);
          return GestureDetector(
            onTap: () {
              setState(() => _focusedIdx = i);
              _selectCurrent();
            },
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              margin: EdgeInsets.only(bottom: 3),
              decoration: BoxDecoration(
                color: isSelected
                    ? _kSelectColor.withOpacity(0.08)
                    : _kCardBg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isFocused
                      ? _kAccent
                      : isSelected
                          ? _kSelectColor.withOpacity(0.3)
                          : Colors.grey.shade200,
                  width: isFocused ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isSelected
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    size: 18,
                    color: isSelected
                        ? _kSelectColor
                        : _kMuted,
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.folder,
                      size: 18,
                      color: isSelected
                          ? _kSelectColor
                          : Colors.amber.shade700),
                  SizedBox(width: 8),
                  Text(_items[i],
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w400,
                          color: _kDarkText)),
                  Spacer(),
                  if (isFocused)
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: _kAccent.withOpacity(0.15),
                        borderRadius:
                            BorderRadius.circular(3),
                      ),
                      child: Text('focused',
                          style: TextStyle(
                              fontSize: 8, color: _kAccent)),
                    ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

// ── Scenario 2: Action chain with feedback ──────────────
class _ScenarioActionChain extends StatefulWidget {
  @override
  State<_ScenarioActionChain> createState() =>
      _ScenarioActionChainState();
}

class _ScenarioActionChainState
    extends State<_ScenarioActionChain> {
  int _chainStep = -1;
  bool _completed = false;

  static const List<_ChainItem> _steps = [
    _ChainItem('SelectAction invoked', Icons.play_arrow,
        Color(0xFF1565C0)),
    _ChainItem('Validation passed', Icons.verified,
        Color(0xFF2E7D32)),
    _ChainItem('Animation triggered', Icons.animation,
        Color(0xFF6A1B9A)),
    _ChainItem('Confirmed', Icons.check_circle,
        Color(0xFFEF6C00)),
  ];

  void _runChain() async {
    setState(() {
      _chainStep = -1;
      _completed = false;
    });
    for (int i = 0; i < _steps.length; i++) {
      await Future.delayed(Duration(milliseconds: 500));
      if (!mounted) return;
      setState(() => _chainStep = i);
      print('Chain step ${i + 1}: ${_steps[i].label}');
    }
    await Future.delayed(Duration(milliseconds: 300));
    if (!mounted) return;
    setState(() => _completed = true);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _chainStep >= 0 && !_completed
                ? null
                : _runChain,
            icon: Icon(Icons.play_arrow, size: 16),
            label: Text(
                _completed ? 'Run Again' : 'Trigger SelectAction'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _kPrimary,
              foregroundColor: Colors.white,
              disabledBackgroundColor: _kMuted.withOpacity(0.3),
            ),
          ),
        ),
        SizedBox(height: 10),
        ...List.generate(_steps.length, (i) {
          final s = _steps[i];
          final reached = _chainStep >= i;
          final current = _chainStep == i && !_completed;
          return Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: reached
                    ? s.color.withOpacity(0.08)
                    : _kSurface.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: current
                      ? s.color
                      : reached
                          ? s.color.withOpacity(0.3)
                          : Colors.grey.shade300,
                  width: current ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: reached
                          ? s.color.withOpacity(0.12)
                          : Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: reached
                        ? Icon(s.icon, size: 16, color: s.color)
                        : Text('${i + 1}',
                            style: TextStyle(
                                fontSize: 11,
                                color: _kMuted)),
                  ),
                  SizedBox(width: 10),
                  Text(s.label,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: reached
                              ? FontWeight.w700
                              : FontWeight.w400,
                          color: reached
                              ? _kDarkText
                              : _kMuted)),
                  Spacer(),
                  if (reached && !current)
                    Icon(Icons.check, size: 16, color: s.color),
                  if (current)
                    SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation(s.color),
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
        if (_completed)
          Padding(
            padding: EdgeInsets.only(top: 6),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _kActionColor.withOpacity(0.06),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: _kActionColor.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.celebration,
                      size: 16, color: _kActionColor),
                  SizedBox(width: 6),
                  Text('Action chain completed successfully!',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: _kActionColor)),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _ChainItem {
  final String label;
  final IconData icon;
  final Color color;
  const _ChainItem(this.label, this.icon, this.color);
}

// ── Scenario 3: Multi-scope actions ─────────────────────
class _ScenarioMultiScope extends StatefulWidget {
  @override
  State<_ScenarioMultiScope> createState() =>
      _ScenarioMultiScopeState();
}

class _ScenarioMultiScopeState extends State<_ScenarioMultiScope> {
  String _scopeAMessage = '';
  String _scopeBMessage = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kHighlight,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline,
                  size: 14, color: Color(0xFFF57F17)),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Two scopes register different SelectAction handlers. '
                  'Tapping "Select" in each scope invokes its own handler.',
                  style: TextStyle(
                      fontSize: 11,
                      color: _kDarkText,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _scopePanel(
                'Scope A — Files',
                _kSelectColor,
                Icons.folder,
                _scopeAMessage,
                () => setState(() =>
                    _scopeAMessage = 'File selected at '
                        '${TimeOfDay.now().format(context)}'),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _scopePanel(
                'Scope B — Contacts',
                _kIntentColor,
                Icons.person,
                _scopeBMessage,
                () => setState(() =>
                    _scopeBMessage = 'Contact selected at '
                        '${TimeOfDay.now().format(context)}'),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kCodeBg,
            borderRadius: BorderRadius.circular(8),
            border:
                Border.all(color: _kAccent.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Scope Resolution',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                      color: _kPrimary)),
              SizedBox(height: 6),
              Text(
                'When Actions.invoke() is called, Flutter walks up the\n'
                'widget tree from the calling context until it finds an\n'
                'Actions widget that handles SelectIntent. Each subtree\n'
                'can have its own SelectAction with different behavior.',
                style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: _kDarkText,
                    height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _scopePanel(String title, Color color, IconData icon,
      String message, VoidCallback onSelect) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.04),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              SizedBox(width: 6),
              Expanded(
                child: Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: _kDarkText)),
              ),
            ],
          ),
          SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onSelect,
              child: Text('Select'),
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 8),
                textStyle: TextStyle(fontSize: 12),
              ),
            ),
          ),
          SizedBox(height: 6),
          Container(
            width: double.infinity,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withOpacity(0.06),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              message.isEmpty ? 'No selection yet' : message,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: message.isEmpty
                      ? FontWeight.w400
                      : FontWeight.w600,
                  color: message.isEmpty ? _kMuted : color),
            ),
          ),
        ],
      ),
    );
  }
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
      border: Border.all(color: _kAccent.withOpacity(0.3)),
    ),
    child: Text(code,
        style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: _kDarkText,
            height: 1.5)),
  );
}

Widget _flowRow(int step, String title, String desc, Color color,
    IconData icon) {
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
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text('$step',
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
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
                      fontSize: 12,
                      color: _kDarkText)),
              Text(desc,
                  style: TextStyle(
                      fontSize: 11, color: _kMuted, height: 1.3)),
            ],
          ),
        ),
        Icon(icon, size: 18, color: color),
      ],
    ),
  );
}

Widget _classRow(String name, String parent, String desc, Color color,
    IconData icon) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withOpacity(0.04),
      borderRadius: BorderRadius.circular(8),
      border: Border(left: BorderSide(color: color, width: 3)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(name,
                      style: TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: color)),
                  SizedBox(width: 6),
                  Text('extends $parent',
                      style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 9,
                          color: _kMuted)),
                ],
              ),
              SizedBox(height: 3),
              Text(desc,
                  style: TextStyle(
                      fontSize: 11,
                      color: _kDarkText,
                      height: 1.3)),
            ],
          ),
        ),
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
