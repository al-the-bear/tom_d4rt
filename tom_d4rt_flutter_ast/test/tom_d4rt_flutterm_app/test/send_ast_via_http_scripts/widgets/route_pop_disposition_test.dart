// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────
//  RoutePopDisposition  –  Deep Visual Demo
//
//  Palette: Indigo 700 / Amber 500
//  Tabs  : Theory · Interactive · Flow
// ─────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  print('RoutePopDisposition demo building');
  return _RoutePopDispositionDemo();
}

// ── colour constants ────────────────────────────────────
const _kPrimary = Color(0xFF303F9F); // Indigo 700
const _kAccent = Color(0xFFFFC107); // Amber 500
const _kSurface = Color(0xFFE8EAF6); // Indigo 50
const _kCardBg = Color(0xFFFFFFFF);
const _kDarkText = Color(0xFF1A237E); // Indigo 900
const _kMuted = Color(0xFF9FA8DA); // Indigo 200
const _kCodeBg = Color(0xFFFFF8E1); // Amber 50
const _kPopColor = Color(0xFF2E7D32); // Green 800
const _kDoNotPopColor = Color(0xFFC62828); // Red 800
const _kBubbleColor = Color(0xFFE65100); // Orange 900

class _RoutePopDispositionDemo extends StatefulWidget {
  @override
  State<_RoutePopDispositionDemo> createState() =>
      _RoutePopDispositionDemoState();
}

class _RoutePopDispositionDemoState extends State<_RoutePopDispositionDemo>
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
        title: Text('RoutePopDisposition',
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
            Tab(text: 'Interactive'),
            Tab(text: 'Flow'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: [
          _TheoryTab(),
          _InteractiveTab(),
          _FlowTab(),
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
          'What is RoutePopDisposition?',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RoutePopDisposition is an enum returned by Route.willPop() '
                'that tells the Navigator how to handle a pop request. When '
                'the user presses the back button (or maybePop() is called), '
                'the topmost route\'s willPop() method is invoked. The '
                'returned disposition determines whether the route pops, '
                'blocks the pop, or lets it bubble up to the next route.',
                style: TextStyle(
                    color: _kDarkText, fontSize: 14, height: 1.5),
              ),
              SizedBox(height: 12),
              _codeBlock(
                'enum RoutePopDisposition {\n'
                '  pop,        // Route will be popped\n'
                '  doNotPop,   // Route blocks the pop\n'
                '  bubble,     // Let ancestor route decide\n'
                '}',
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Three values ────────────────────────────────
        _sectionCard(
          'The Three Dispositions',
          Column(
            children: [
              _dispositionCard(
                icon: Icons.exit_to_app,
                name: 'pop',
                color: _kPopColor,
                description: 'The route agrees to be popped. The Navigator '
                    'removes it from the stack and navigates back to the '
                    'previous route.',
                useCases: [
                  'Standard navigation (no unsaved data)',
                  'User confirmed form submission',
                  'Read-only detail views',
                ],
              ),
              SizedBox(height: 10),
              _dispositionCard(
                icon: Icons.block,
                name: 'doNotPop',
                color: _kDoNotPopColor,
                description: 'The route refuses to be popped. The Navigator '
                    'aborts the pop entirely. The route typically shows a '
                    'dialog warning the user about unsaved changes.',
                useCases: [
                  'Unsaved form data',
                  'Active file upload in progress',
                  'Long-running operation that cannot be interrupted',
                ],
              ),
              SizedBox(height: 10),
              _dispositionCard(
                icon: Icons.bubble_chart,
                name: 'bubble',
                color: _kBubbleColor,
                description: 'The route passes the decision up to its '
                    'parent route or the root Navigator. Useful for nested '
                    'navigators where an inner route delegates pop handling '
                    'to the outer navigator.',
                useCases: [
                  'Nested Navigator (tab navigation)',
                  'Route wrappers / intermediaries',
                  'Conditional delegation based on state',
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── WillPopScope / PopScope ─────────────────────
        _sectionCard(
          'Using with PopScope (Modern) & WillPopScope (Legacy)',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _kPopColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _kPopColor.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('PopScope (Flutter 3.16+)',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: _kPopColor,
                            fontSize: 13)),
                    SizedBox(height: 6),
                    _codeBlock(
                      'PopScope(\n'
                      '  canPop: false,\n'
                      '  onPopInvokedWithResult: (didPop, _) {\n'
                      '    if (!didPop) {\n'
                      '      showExitDialog(context);\n'
                      '    }\n'
                      '  },\n'
                      '  child: Scaffold(...),\n'
                      ')',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _kDoNotPopColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: _kDoNotPopColor.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('WillPopScope (Deprecated)',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: _kDoNotPopColor,
                                fontSize: 13)),
                        SizedBox(width: 6),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                          decoration: BoxDecoration(
                            color: _kDoNotPopColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text('LEGACY',
                              style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: _kDoNotPopColor)),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    _codeBlock(
                      'WillPopScope(\n'
                      '  onWillPop: () async {\n'
                      '    // Return false → doNotPop\n'
                      '    // Return true  → pop\n'
                      '    return showConfirmDialog(context);\n'
                      '  },\n'
                      '  child: Scaffold(...),\n'
                      ')',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Comparison table ────────────────────────────
        _sectionCard(
          'Disposition Decision Matrix',
          Table(
            border: TableBorder.all(color: Colors.grey.shade300),
            columnWidths: {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(3),
            },
            children: [
              _tableRow([
                'Scenario',
                'Disposition',
                'Route Removed?',
                'User Experience',
              ], isHeader: true),
              _tableRow([
                'No unsaved data',
                'pop',
                'Yes',
                'Navigates back immediately',
              ]),
              _tableRow([
                'Unsaved form',
                'doNotPop',
                'No',
                'Shows "Unsaved changes" dialog',
              ]),
              _tableRow([
                'Nested nav inner',
                'bubble',
                'Depends',
                'Outer navigator decides',
              ]),
              _tableRow([
                'After save',
                'pop',
                'Yes',
                'Data saved, safe to leave',
              ]),
              _tableRow([
                'Active upload',
                'doNotPop',
                'No',
                'Shows "Upload in progress" warning',
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
                  'Prefer PopScope over WillPopScope in Flutter 3.16+ '
                  'for predictive back gesture support on Android.'),
              _bp(true,
                  'Always show clear feedback when blocking a pop — '
                  'users need to understand why back does not work.'),
              _bp(true,
                  'Use "bubble" for nested navigators to delegate pop '
                  'decisions to the parent when the inner stack is empty.'),
              _bp(false,
                  'Do NOT silently block pops without user feedback — '
                  'this creates a frustrating "stuck screen" experience.'),
              _bp(false,
                  'Do NOT use doNotPop as a permanent state — always '
                  'provide an alternative exit path.'),
            ],
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  TAB 2  –  Interactive
// ═══════════════════════════════════════════════════════════
class _InteractiveTab extends StatefulWidget {
  @override
  State<_InteractiveTab> createState() => _InteractiveTabState();
}

class _InteractiveTabState extends State<_InteractiveTab> {
  RoutePopDisposition _selectedDisposition = RoutePopDisposition.pop;
  final List<_PopEvent> _events = [];
  int _popAttempts = 0;
  int _popsAllowed = 0;
  int _popsBlocked = 0;
  int _popsBubbled = 0;
  bool _hasUnsavedData = false;
  final TextEditingController _formCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _formCtrl.addListener(() {
      setState(() {
        _hasUnsavedData = _formCtrl.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _formCtrl.dispose();
    super.dispose();
  }

  void _simulatePop() {
    _popAttempts++;
    final disposition = _selectedDisposition;
    String result;
    Color resultColor;

    switch (disposition) {
      case RoutePopDisposition.pop:
        _popsAllowed++;
        result = 'POPPED';
        resultColor = _kPopColor;
        break;
      case RoutePopDisposition.doNotPop:
        _popsBlocked++;
        result = 'BLOCKED';
        resultColor = _kDoNotPopColor;
        break;
      case RoutePopDisposition.bubble:
        _popsBubbled++;
        result = 'BUBBLED';
        resultColor = _kBubbleColor;
        break;
    }

    setState(() {
      _events.insert(
        0,
        _PopEvent(
          attempt: _popAttempts,
          disposition: disposition.name,
          result: result,
          color: resultColor,
          time: DateTime.now(),
          hadUnsavedData: _hasUnsavedData,
        ),
      );
      if (_events.length > 40) _events.removeLast();
    });

    print('Pop attempt #$_popAttempts: $result (disposition=$disposition, '
        'unsavedData=$_hasUnsavedData)');
  }

  void _simulateAutoDecision() {
    // Auto-decide based on form state
    setState(() {
      if (_hasUnsavedData) {
        _selectedDisposition = RoutePopDisposition.doNotPop;
      } else {
        _selectedDisposition = RoutePopDisposition.pop;
      }
    });
    _simulatePop();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left: controls and simulation
        Expanded(
          flex: 3,
          child: ListView(
            padding: EdgeInsets.all(14),
            children: [
              // ── Disposition selector ──────────────────
              _sectionCard(
                'Select Disposition',
                Column(
                  children: [
                    _dispositionButton(
                      RoutePopDisposition.pop,
                      'pop',
                      Icons.exit_to_app,
                      _kPopColor,
                      'Route will be popped from the stack',
                    ),
                    SizedBox(height: 6),
                    _dispositionButton(
                      RoutePopDisposition.doNotPop,
                      'doNotPop',
                      Icons.block,
                      _kDoNotPopColor,
                      'Route blocks the pop request',
                    ),
                    SizedBox(height: 6),
                    _dispositionButton(
                      RoutePopDisposition.bubble,
                      'bubble',
                      Icons.bubble_chart,
                      _kBubbleColor,
                      'Delegate to parent / ancestor route',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),

              // ── Simulated form ────────────────────────
              _sectionCard(
                'Simulated Form',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _hasUnsavedData
                            ? _kDoNotPopColor.withOpacity(0.06)
                            : _kPopColor.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _hasUnsavedData
                              ? _kDoNotPopColor.withOpacity(0.3)
                              : _kPopColor.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _hasUnsavedData
                                ? Icons.edit_note
                                : Icons.check_circle,
                            color: _hasUnsavedData
                                ? _kDoNotPopColor
                                : _kPopColor,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            _hasUnsavedData
                                ? 'Unsaved changes detected'
                                : 'No unsaved changes',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: _hasUnsavedData
                                  ? _kDoNotPopColor
                                  : _kPopColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _formCtrl,
                      decoration: InputDecoration(
                        labelText: 'Type something to create "unsaved data"',
                        labelStyle: TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        suffixIcon: _hasUnsavedData
                            ? IconButton(
                                icon: Icon(Icons.clear, size: 18),
                                onPressed: () => _formCtrl.clear(),
                              )
                            : null,
                      ),
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),

              // ── Action buttons ────────────────────────
              _sectionCard(
                'Trigger Pop',
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: ElevatedButton.icon(
                              onPressed: _simulatePop,
                              icon: Icon(Icons.arrow_back, size: 16),
                              label: Text(
                                  'Pop with: ${_selectedDisposition.name}',
                                  style: TextStyle(fontSize: 12)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _colorForDisposition(
                                    _selectedDisposition),
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: OutlinedButton.icon(
                              onPressed: _simulateAutoDecision,
                              icon: Icon(Icons.smart_toy, size: 16),
                              label: Text('Auto-decide from form state',
                                  style: TextStyle(fontSize: 12)),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: _kPrimary,
                                side: BorderSide(color: _kPrimary),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),

              // ── Statistics ────────────────────────────
              _sectionCard(
                'Statistics',
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _statChip('Total Attempts', '$_popAttempts', _kPrimary),
                    _statChip('Popped', '$_popsAllowed', _kPopColor),
                    _statChip('Blocked', '$_popsBlocked', _kDoNotPopColor),
                    _statChip('Bubbled', '$_popsBubbled', _kBubbleColor),
                  ],
                ),
              ),
              SizedBox(height: 12),

              // ── Visual route stack ────────────────────
              _sectionCard(
                'Simulated Route Stack',
                Column(
                  children: [
                    _routeBox('/ (Root)', _kPrimary, 0.3, true),
                    Container(
                      width: 2,
                      height: 12,
                      color: _kMuted,
                    ),
                    _routeBox('/settings', _kPrimary, 0.5, true),
                    Container(
                      width: 2,
                      height: 12,
                      color: _kMuted,
                    ),
                    _routeBox(
                      '/settings/profile (Current)',
                      _colorForDisposition(_selectedDisposition),
                      1.0,
                      false,
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _kAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline,
                              size: 14, color: _kPrimary),
                          SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              _selectedDisposition ==
                                      RoutePopDisposition.pop
                                  ? 'The current route will be removed from the stack.'
                                  : _selectedDisposition ==
                                          RoutePopDisposition.doNotPop
                                      ? 'The current route blocks the pop. Stack unchanged.'
                                      : 'The current route delegates — /settings decides.',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: _kDarkText,
                                  height: 1.3),
                            ),
                          ),
                        ],
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
          width: 240,
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
                    Text('Pop Event Log',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: _kDarkText)),
                    Spacer(),
                    GestureDetector(
                      onTap: () => setState(() {
                        _events.clear();
                        _popAttempts = 0;
                        _popsAllowed = 0;
                        _popsBlocked = 0;
                        _popsBubbled = 0;
                      }),
                      child: Icon(Icons.delete_sweep,
                          size: 16, color: _kMuted),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _events.isEmpty
                    ? Center(
                        child: Text(
                          'Trigger pop attempts\nto see events here',
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
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: e.color.withOpacity(0.05),
                                borderRadius:
                                    BorderRadius.circular(6),
                                border: Border.all(
                                    color: e.color.withOpacity(0.2)),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 1),
                                        decoration: BoxDecoration(
                                          color:
                                              e.color.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text('#${e.attempt}',
                                            style: TextStyle(
                                                fontWeight:
                                                    FontWeight.w700,
                                                fontSize: 10,
                                                color: e.color)),
                                      ),
                                      SizedBox(width: 6),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 1),
                                        decoration: BoxDecoration(
                                          color: e.color,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(e.result,
                                            style: TextStyle(
                                                fontWeight:
                                                    FontWeight.w700,
                                                fontSize: 9,
                                                color: Colors.white)),
                                      ),
                                      Spacer(),
                                      Text(
                                        '${e.time.hour.toString().padLeft(2, '0')}:'
                                        '${e.time.minute.toString().padLeft(2, '0')}:'
                                        '${e.time.second.toString().padLeft(2, '0')}',
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: _kMuted),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 3),
                                  Row(
                                    children: [
                                      Text(
                                        e.disposition,
                                        style: TextStyle(
                                            fontFamily: 'monospace',
                                            fontSize: 10,
                                            color: _kDarkText),
                                      ),
                                      SizedBox(width: 6),
                                      if (e.hadUnsavedData)
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4,
                                              vertical: 1),
                                          decoration: BoxDecoration(
                                            color: _kDoNotPopColor
                                                .withOpacity(0.08),
                                            borderRadius:
                                                BorderRadius.circular(3),
                                          ),
                                          child: Text('unsaved',
                                              style: TextStyle(
                                                  fontSize: 8,
                                                  color:
                                                      _kDoNotPopColor)),
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

  Widget _dispositionButton(RoutePopDisposition disp, String name,
      IconData icon, Color color, String desc) {
    final selected = _selectedDisposition == disp;
    return GestureDetector(
      onTap: () => setState(() => _selectedDisposition = disp),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? color.withOpacity(0.08) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? color : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(selected ? 0.15 : 0.06),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: color,
                          fontFamily: 'monospace')),
                  Text(desc,
                      style: TextStyle(
                          fontSize: 11, color: _kMuted, height: 1.3)),
                ],
              ),
            ),
            if (selected)
              Icon(Icons.radio_button_checked, color: color, size: 22)
            else
              Icon(Icons.radio_button_off,
                  color: Colors.grey.shade400, size: 22),
          ],
        ),
      ),
    );
  }

  Widget _routeBox(String name, Color color, double opacity, bool dim) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(dim ? 0.06 : 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(dim ? 0.2 : 0.5),
          width: dim ? 1 : 2,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.layers,
              size: 16,
              color: color.withOpacity(dim ? 0.4 : 1.0)),
          SizedBox(width: 8),
          Text(name,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: dim ? FontWeight.w400 : FontWeight.w700,
                color: dim ? _kMuted : color,
              )),
        ],
      ),
    );
  }

  Color _colorForDisposition(RoutePopDisposition d) {
    switch (d) {
      case RoutePopDisposition.pop:
        return _kPopColor;
      case RoutePopDisposition.doNotPop:
        return _kDoNotPopColor;
      case RoutePopDisposition.bubble:
        return _kBubbleColor;
    }
  }

  Widget _statChip(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: color)),
          Text(label,
              style: TextStyle(fontSize: 10, color: _kMuted)),
        ],
      ),
    );
  }
}

class _PopEvent {
  final int attempt;
  final String disposition;
  final String result;
  final Color color;
  final DateTime time;
  final bool hadUnsavedData;
  _PopEvent({
    required this.attempt,
    required this.disposition,
    required this.result,
    required this.color,
    required this.time,
    required this.hadUnsavedData,
  });
}

// ═══════════════════════════════════════════════════════════
//  TAB 3  –  Flow
// ═══════════════════════════════════════════════════════════
class _FlowTab extends StatefulWidget {
  @override
  State<_FlowTab> createState() => _FlowTabState();
}

class _FlowTabState extends State<_FlowTab> {
  int _highlightedStep = -1;
  RoutePopDisposition _flowDisposition = RoutePopDisposition.pop;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // ── Flow selector ───────────────────────────────
        _sectionCard(
          'Choose Disposition for Flow',
          Row(
            children: [
              _flowOption(RoutePopDisposition.pop, 'pop',
                  _kPopColor, Icons.exit_to_app),
              SizedBox(width: 8),
              _flowOption(RoutePopDisposition.doNotPop, 'doNotPop',
                  _kDoNotPopColor, Icons.block),
              SizedBox(width: 8),
              _flowOption(RoutePopDisposition.bubble, 'bubble',
                  _kBubbleColor, Icons.bubble_chart),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Decision flow ───────────────────────────────
        _sectionCard(
          'Pop Decision Flow',
          Column(
            children: [
              _flowStep(
                0,
                'User Presses Back',
                'The system back button, gesture, or Navigator.maybePop() '
                'initiates a pop request.',
                Icons.arrow_back,
                _kPrimary,
              ),
              _flowArrow(),
              _flowStep(
                1,
                'Route.willPop() Called',
                'The Navigator asks the topmost route whether it consents '
                'to being popped. The route returns a RoutePopDisposition.',
                Icons.help_outline,
                _kAccent,
              ),
              _flowArrow(),
              _flowStep(
                2,
                'Disposition: ${_flowDisposition.name}',
                _flowDisposition == RoutePopDisposition.pop
                    ? 'The route returns pop. Navigator proceeds to remove '
                        'the route from the stack.'
                    : _flowDisposition == RoutePopDisposition.doNotPop
                        ? 'The route returns doNotPop. Navigator aborts — '
                            'the route stays on the stack.'
                        : 'The route returns bubble. The pop request is '
                            'forwarded to the parent route or navigator.',
                _flowDisposition == RoutePopDisposition.pop
                    ? Icons.exit_to_app
                    : _flowDisposition == RoutePopDisposition.doNotPop
                        ? Icons.block
                        : Icons.bubble_chart,
                _colorForDisposition(_flowDisposition),
              ),
              _flowArrow(),
              // Final outcome
              _flowStep(
                3,
                _flowDisposition == RoutePopDisposition.pop
                    ? 'Route Removed'
                    : _flowDisposition == RoutePopDisposition.doNotPop
                        ? 'Pop Cancelled'
                        : 'Parent Decides',
                _flowDisposition == RoutePopDisposition.pop
                    ? 'The route\'s dispose() is called. The previous route '
                        'becomes visible. Transition animation plays.'
                    : _flowDisposition == RoutePopDisposition.doNotPop
                        ? 'Nothing changes. The route should show user '
                            'feedback explaining why the pop was blocked.'
                        : 'The parent route\'s willPop() is now invoked. '
                            'This allows nested navigators to delegate pops.',
                _flowDisposition == RoutePopDisposition.pop
                    ? Icons.check_circle
                    : _flowDisposition == RoutePopDisposition.doNotPop
                        ? Icons.cancel
                        : Icons.swap_vert,
                _colorForDisposition(_flowDisposition),
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Navigator stack visual ──────────────────────
        _sectionCard(
          'Stack Visualization After Pop',
          Column(
            children: [
              Text('Navigator Stack',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: _kDarkText)),
              SizedBox(height: 10),
              // Stack frames
              _stackFrame('PageA (Home)', _kPrimary, true),
              SizedBox(height: 2),
              _stackFrame('PageB (List)', _kPrimary, true),
              SizedBox(height: 2),
              if (_flowDisposition != RoutePopDisposition.pop) ...[
                _stackFrame(
                  'PageC (Detail)',
                  _colorForDisposition(_flowDisposition),
                  true,
                ),
              ] else ...[
                _stackFrame(
                  'PageC (Detail)',
                  Colors.grey.shade400,
                  false,
                ),
              ],
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: _colorForDisposition(_flowDisposition)
                      .withOpacity(0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _colorForDisposition(_flowDisposition)
                        .withOpacity(0.2),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _flowDisposition == RoutePopDisposition.pop
                              ? Icons.check_circle
                              : _flowDisposition ==
                                      RoutePopDisposition.doNotPop
                                  ? Icons.cancel
                                  : Icons.swap_vert,
                          color:
                              _colorForDisposition(_flowDisposition),
                          size: 20,
                        ),
                        SizedBox(width: 6),
                        Text(
                          _flowDisposition == RoutePopDisposition.pop
                              ? 'PageC removed — showing PageB'
                              : _flowDisposition ==
                                      RoutePopDisposition.doNotPop
                                  ? 'Stack unchanged — PageC stays'
                                  : 'Bubbling to parent navigator...',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: _colorForDisposition(
                                _flowDisposition),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      _flowDisposition == RoutePopDisposition.pop
                          ? 'Stack depth: 2'
                          : _flowDisposition ==
                                  RoutePopDisposition.doNotPop
                              ? 'Stack depth: 3 (unchanged)'
                              : 'Stack depth: depends on parent',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10,
                        color: _kMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Nested navigator scenario ───────────────────
        _sectionCard(
          'Nested Navigator Scenario',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'In apps with tabs or split views, a nested Navigator '
                'manages its own route stack. When the inner stack has '
                'only one route left, the inner route returns "bubble" '
                'so the outer Navigator handles the pop.',
                style: TextStyle(
                    fontSize: 12, color: _kDarkText, height: 1.4),
              ),
              SizedBox(height: 10),
              _codeBlock(
                '// Inside nested navigator\'s route:\n'
                '@override\n'
                'Future<RoutePopDisposition> willPop() async {\n'
                '  if (innerNavigator.canPop()) {\n'
                '    innerNavigator.pop();\n'
                '    return RoutePopDisposition.doNotPop;\n'
                '  }\n'
                '  return RoutePopDisposition.bubble;\n'
                '}',
              ),
              SizedBox(height: 10),
              // Visual nested nav
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _kPrimary.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _kPrimary.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Outer Navigator',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                            color: _kPrimary)),
                    SizedBox(height: 4),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _kBubbleColor.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: _kBubbleColor.withOpacity(0.2)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Inner Navigator (Tab)',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
                                  color: _kBubbleColor)),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              _miniRoute('TabA', true),
                              SizedBox(width: 4),
                              Icon(Icons.arrow_forward,
                                  size: 10, color: _kMuted),
                              SizedBox(width: 4),
                              _miniRoute('TabB', true),
                              SizedBox(width: 4),
                              Icon(Icons.arrow_forward,
                                  size: 10, color: _kMuted),
                              SizedBox(width: 4),
                              _miniRoute('TabC (top)', false),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Back → pop TabC. If only TabA left → bubble to outer.',
                            style: TextStyle(
                                fontSize: 10,
                                color: _kBubbleColor,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _flowOption(RoutePopDisposition disp, String label,
      Color color, IconData icon) {
    final selected = _flowDisposition == disp;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _flowDisposition = disp),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? color.withOpacity(0.12) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected ? color : Colors.grey.shade300,
              width: selected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 22),
              SizedBox(height: 4),
              Text(label,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    fontWeight:
                        selected ? FontWeight.w700 : FontWeight.w400,
                    color: selected ? color : _kMuted,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _flowStep(int step, String title, String desc,
      IconData icon, Color color) {
    final highlighted = _highlightedStep == step;
    return GestureDetector(
      onTap: () => setState(() =>
          _highlightedStep = _highlightedStep == step ? -1 : step),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: highlighted ? color.withOpacity(0.08) : _kCardBg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: highlighted ? color : Colors.grey.shade300,
            width: highlighted ? 2 : 1,
          ),
          boxShadow: highlighted
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.15),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  )
                ]
              : [],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(icon, color: color, size: 20),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text('Step ${step + 1}',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 9,
                                color: color)),
                      ),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text(title,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: _kDarkText)),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(desc,
                      style: TextStyle(
                          fontSize: 11,
                          color: _kMuted,
                          height: 1.3)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _flowArrow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Center(
        child: Icon(Icons.arrow_downward,
            size: 18, color: _kMuted),
      ),
    );
  }

  Widget _stackFrame(String name, Color color, bool active) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: active ? color.withOpacity(0.08) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: active ? color.withOpacity(0.3) : Colors.grey.shade300,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.layers,
              size: 14,
              color: active ? color : Colors.grey.shade400),
          SizedBox(width: 8),
          Text(name,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                color: active ? color : Colors.grey.shade400,
                decoration:
                    active ? null : TextDecoration.lineThrough,
              )),
          Spacer(),
          if (!active)
            Text('removed',
                style: TextStyle(
                    fontSize: 9,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade400)),
        ],
      ),
    );
  }

  Widget _miniRoute(String name, bool stacked) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: stacked ? _kPrimary.withOpacity(0.08) : _kBubbleColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: stacked ? _kPrimary.withOpacity(0.2) : _kBubbleColor.withOpacity(0.3),
        ),
      ),
      child: Text(name,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 9,
            fontWeight: stacked ? FontWeight.w400 : FontWeight.w700,
            color: stacked ? _kPrimary : _kBubbleColor,
          )),
    );
  }

  Color _colorForDisposition(RoutePopDisposition d) {
    switch (d) {
      case RoutePopDisposition.pop:
        return _kPopColor;
      case RoutePopDisposition.doNotPop:
        return _kDoNotPopColor;
      case RoutePopDisposition.bubble:
        return _kBubbleColor;
    }
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
      border: Border.all(color: _kPrimary.withOpacity(0.15)),
    ),
    child: Text(code,
        style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: _kDarkText,
            height: 1.5)),
  );
}

Widget _dispositionCard({
  required IconData icon,
  required String name,
  required Color color,
  required String description,
  required List<String> useCases,
}) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withOpacity(0.04),
      borderRadius: BorderRadius.circular(10),
      border: Border(left: BorderSide(color: color, width: 4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            SizedBox(width: 10),
            Text(name,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    color: color,
                    fontFamily: 'monospace')),
          ],
        ),
        SizedBox(height: 8),
        Text(description,
            style: TextStyle(
                fontSize: 12, color: _kDarkText, height: 1.4)),
        SizedBox(height: 8),
        Text('Use cases:',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 11,
                color: color)),
        SizedBox(height: 4),
        ...useCases.map((u) => Padding(
              padding: EdgeInsets.only(bottom: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('  \u2022 ',
                      style: TextStyle(color: color, fontSize: 11)),
                  Expanded(
                    child: Text(u,
                        style: TextStyle(
                            fontSize: 11, color: _kMuted, height: 1.3)),
                  ),
                ],
              ),
            )),
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
              color: isHeader ? _kPrimary : _kDarkText,
            )),
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
