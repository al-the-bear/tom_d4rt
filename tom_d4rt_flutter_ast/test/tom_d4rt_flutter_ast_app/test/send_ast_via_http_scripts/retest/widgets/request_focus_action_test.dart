// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────
//  RequestFocusAction  –  Deep Visual Demo
//
//  Palette: BlueGrey 700 / Lime 600
//  Tabs  : Theory · Focus Ring · Multi-Node
// ─────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  print('RequestFocusAction demo building');
  return _RequestFocusActionDemo();
}

// ── colour constants ────────────────────────────────────
const _kPrimary = Color(0xFF455A64); // BlueGrey 700
const _kAccent = Color(0xFF7CB342); // Lime 600
const _kSurface = Color(0xFFF5F5F5); // Grey 100
const _kCardBg = Color(0xFFFFFFFF);
const _kDarkText = Color(0xFF263238); // BlueGrey 900
const _kMuted = Color(0xFF78909C); // BlueGrey 300
const _kCodeBg = Color(0xFFECEFF1); // BlueGrey 50
const _kHighlight = Color(0xFFF0F4C3); // Lime 100
const _kFocused = Color(0xFFCDDC39); // Lime 500
const _kError = Color(0xFFC62828); // Red 800

class _RequestFocusActionDemo extends StatefulWidget {
  @override
  State<_RequestFocusActionDemo> createState() =>
      _RequestFocusActionDemoState();
}

class _RequestFocusActionDemoState extends State<_RequestFocusActionDemo>
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
        title: Text('RequestFocusAction',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
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
            Tab(text: 'Focus Ring'),
            Tab(text: 'Multi-Node'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: [
          _TheoryTab(),
          _FocusRingTab(),
          _MultiNodeTab(),
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
          'What is RequestFocusAction?',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RequestFocusAction is an Action<RequestFocusIntent> that '
                'moves keyboard focus to a specific FocusNode. It is '
                'registered by default in every WidgetsApp (and therefore '
                'MaterialApp), so you can invoke it from anywhere in the '
                'widget tree without additional setup.',
                style: TextStyle(
                    color: _kDarkText, fontSize: 14, height: 1.5),
              ),
              SizedBox(height: 12),
              _codeBlock(
                'class RequestFocusAction\n'
                '    extends Action<RequestFocusIntent> {\n'
                '  @override\n'
                '  void invoke(RequestFocusIntent intent) {\n'
                '    intent.requestFocusCallback(intent.focusNode);\n'
                '  }\n'
                '}',
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── RequestFocusIntent ──────────────────────────
        _sectionCard(
          'RequestFocusIntent',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The intent that carries the target FocusNode. By default '
                'it calls focusNode.requestFocus(), but you can provide '
                'a custom requestFocusCallback to change that behavior '
                '(e.g., to request only the primary focus tree).',
                style: TextStyle(
                    color: _kDarkText, fontSize: 14, height: 1.5),
              ),
              SizedBox(height: 12),
              _codeBlock(
                'class RequestFocusIntent extends Intent {\n'
                '  const RequestFocusIntent(\n'
                '    this.focusNode, {\n'
                '    this.requestFocusCallback\n'
                '        = _defaultCallback,\n'
                '  });\n'
                '\n'
                '  final FocusNode focusNode;\n'
                '  final ValueChanged<FocusNode>\n'
                '      requestFocusCallback;\n'
                '}',
              ),
              SizedBox(height: 12),
              _paramRow('focusNode', 'FocusNode',
                  'The node that should receive focus', _kPrimary),
              SizedBox(height: 6),
              _paramRow(
                  'requestFocusCallback',
                  'ValueChanged<FocusNode>?',
                  'Custom callback, defaults to node.requestFocus()',
                  _kAccent),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── How to dispatch ─────────────────────────────
        _sectionCard(
          'Dispatching Focus Requests',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _dispatchMethod(
                title: 'Method 1: Actions.invoke()',
                code: 'Actions.invoke(\n'
                    '  context,\n'
                    '  RequestFocusIntent(myNode),\n'
                    ');',
                description:
                    'Walks up the tree and finds the nearest registered '
                    'RequestFocusAction. Works from any context.',
              ),
              SizedBox(height: 12),
              _dispatchMethod(
                title: 'Method 2: Actions.maybeInvoke()',
                code: 'Actions.maybeInvoke<RequestFocusIntent>(\n'
                    '  context,\n'
                    '  RequestFocusIntent(myNode),\n'
                    ');',
                description:
                    'Same as invoke() but returns null instead of throwing '
                    'if no action is registered. Safer for optional focus.',
              ),
              SizedBox(height: 12),
              _dispatchMethod(
                title: 'Method 3: Direct node.requestFocus()',
                code: 'myFocusNode.requestFocus();',
                description:
                    'Bypasses the Actions system entirely. Simpler but '
                    'cannot be intercepted by an overriding Action widget.',
              ),
              SizedBox(height: 12),
              _dispatchMethod(
                title: 'Method 4: Keyboard shortcut binding',
                code: 'Shortcuts(\n'
                    '  shortcuts: {\n'
                    '    LogicalKeySet(LogicalKeyboardKey.f2):\n'
                    '        RequestFocusIntent(searchNode),\n'
                    '  },\n'
                    '  child: ...,\n'
                    ')',
                description:
                    'Bind a keyboard shortcut directly to RequestFocusIntent. '
                    'The framework automatically dispatches RequestFocusAction.',
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Action override mechanism ───────────────────
        _sectionCard(
          'Overriding the Default Action',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'You can wrap a subtree in an Actions widget that maps '
                'RequestFocusIntent to a custom Action. This lets you '
                'intercept or modify focus requests — for example, to add '
                'logging, animate focus transitions, or conditionally deny '
                'focus.',
                style: TextStyle(
                    color: _kDarkText, fontSize: 14, height: 1.5),
              ),
              SizedBox(height: 12),
              _codeBlock(
                'Actions(\n'
                '  actions: {\n'
                '    RequestFocusIntent:\n'
                '        CallbackAction<RequestFocusIntent>(\n'
                '      onInvoke: (intent) {\n'
                '        print("Focus → \${intent.focusNode}");\n'
                '        intent.focusNode.requestFocus();\n'
                '        return null;\n'
                '      },\n'
                '    ),\n'
                '  },\n'
                '  child: MyForm(),\n'
                ')',
              ),
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
              _bestPractice(
                icon: Icons.check_circle_outline,
                text:
                    'Prefer Actions.invoke() over direct requestFocus() when '
                    'you want parent widgets to be able to intercept focus.',
                isGood: true,
              ),
              _bestPractice(
                icon: Icons.check_circle_outline,
                text:
                    'Dispose FocusNode objects when the widget is disposed to '
                    'avoid memory leaks and stale focus references.',
                isGood: true,
              ),
              _bestPractice(
                icon: Icons.check_circle_outline,
                text:
                    'Use debugLabel on FocusNode to make focus tree debugging '
                    'easier in the DevTools inspector.',
                isGood: true,
              ),
              _bestPractice(
                icon: Icons.cancel_outlined,
                text:
                    'Do NOT request focus inside build() — it causes rebuild '
                    'loops. Use initState(), callbacks, or post-frame callbacks.',
                isGood: false,
              ),
              _bestPractice(
                icon: Icons.cancel_outlined,
                text:
                    'Do NOT hold references to FocusNodes from other widget '
                    'States — pass them through constructors or callbacks.',
                isGood: false,
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  TAB 2  –  Focus Ring
// ═══════════════════════════════════════════════════════════
class _FocusRingTab extends StatefulWidget {
  @override
  State<_FocusRingTab> createState() => _FocusRingTabState();
}

class _FocusRingTabState extends State<_FocusRingTab> {
  static const _tileCount = 12;
  final List<FocusNode> _nodes = [];
  int _focusedIndex = -1;
  int _totalFocusRequests = 0;
  final List<String> _focusLog = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _tileCount; i++) {
      final node = FocusNode(debugLabel: 'tile_$i');
      node.addListener(() {
        if (node.hasFocus) {
          setState(() {
            _focusedIndex = i;
            _totalFocusRequests++;
            _focusLog.insert(0, 'Focus → Tile $i');
            if (_focusLog.length > 20) _focusLog.removeLast();
          });
        }
      });
      _nodes.add(node);
    }
  }

  @override
  void dispose() {
    for (final n in _nodes) {
      n.dispose();
    }
    super.dispose();
  }

  void _requestFocusViaAction(int index) {
    if (index >= 0 && index < _nodes.length) {
      Actions.invoke(
        context,
        RequestFocusIntent(_nodes[index]),
      );
      print('RequestFocusAction invoked for tile $index');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Stats bar ───────────────────────────────────
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: _kPrimary.withOpacity(0.06),
          child: Row(
            children: [
              _statBadge('Focused', _focusedIndex >= 0
                  ? 'Tile $_focusedIndex'
                  : 'None', _kAccent),
              SizedBox(width: 10),
              _statBadge('Requests', '$_totalFocusRequests', _kPrimary),
              Spacer(),
              ElevatedButton.icon(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  setState(() {
                    _focusedIndex = -1;
                    _focusLog.insert(0, 'Unfocused all');
                    if (_focusLog.length > 20) _focusLog.removeLast();
                  });
                },
                icon: Icon(Icons.blur_off, size: 16),
                label: Text('Unfocus', style: TextStyle(fontSize: 12)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _kError,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                ),
              ),
            ],
          ),
        ),

        // ── Main content ────────────────────────────────
        Expanded(
          child: Row(
            children: [
              // Left: tile grid
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Click a tile to focus it via RequestFocusAction, '
                        'or use the buttons below to focus programmatically.',
                        style: TextStyle(
                            fontSize: 12, color: _kMuted, height: 1.4),
                      ),
                      SizedBox(height: 12),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1.2,
                          ),
                          itemCount: _tileCount,
                          itemBuilder: (_, i) =>
                              _buildFocusableTile(i),
                        ),
                      ),
                      SizedBox(height: 12),

                      // Quick-focus buttons
                      Text('Quick Focus:',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              color: _kDarkText)),
                      SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          _quickFocusButton('First', 0),
                          _quickFocusButton('Middle', _tileCount ~/ 2),
                          _quickFocusButton('Last', _tileCount - 1),
                          _quickFocusButton('#3', 3),
                          _quickFocusButton('#7', 7),
                          _quickFocusButton('#10', 10),
                        ],
                      ),

                      SizedBox(height: 12),
                      // Sequential focus demo
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              final next = (_focusedIndex + 1) % _tileCount;
                              _requestFocusViaAction(next);
                            },
                            icon: Icon(Icons.arrow_forward, size: 16),
                            label: Text('Next',
                                style: TextStyle(fontSize: 12)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _kAccent,
                              foregroundColor: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: () {
                              final prev =
                                  (_focusedIndex - 1 + _tileCount) % _tileCount;
                              _requestFocusViaAction(prev);
                            },
                            icon: Icon(Icons.arrow_back, size: 16),
                            label: Text('Prev',
                                style: TextStyle(fontSize: 12)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _kPrimary,
                              foregroundColor: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: () {
                              final random =
                                  DateTime.now().millisecondsSinceEpoch %
                                      _tileCount;
                              _requestFocusViaAction(random);
                            },
                            icon: Icon(Icons.shuffle, size: 16),
                            label: Text('Random',
                                style: TextStyle(fontSize: 12)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF6D4C41),
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Right: focus log
              Container(
                width: 220,
                decoration: BoxDecoration(
                  color: _kCardBg,
                  border: Border(
                      left: BorderSide(color: Colors.grey.shade300)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      color: _kPrimary.withOpacity(0.08),
                      child: Row(
                        children: [
                          Icon(Icons.history,
                              size: 16, color: _kPrimary),
                          SizedBox(width: 6),
                          Text('Focus Log',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: _kDarkText)),
                          Spacer(),
                          GestureDetector(
                            onTap: () => setState(() {
                              _focusLog.clear();
                              _totalFocusRequests = 0;
                            }),
                            child: Icon(Icons.delete_sweep,
                                size: 16, color: _kMuted),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: _focusLog.isEmpty
                          ? Center(
                              child: Text('Click tiles to start',
                                  style: TextStyle(
                                      color: _kMuted, fontSize: 12)),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.all(6),
                              itemCount: _focusLog.length,
                              itemBuilder: (_, i) {
                                final entry = _focusLog[i];
                                final isUnfocus =
                                    entry.startsWith('Unfocus');
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 3),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: isUnfocus
                                          ? _kError.withOpacity(0.06)
                                          : _kAccent.withOpacity(0.06),
                                      borderRadius:
                                          BorderRadius.circular(4),
                                    ),
                                    child: Text(entry,
                                        style: TextStyle(
                                            fontFamily: 'monospace',
                                            fontSize: 11,
                                            color: isUnfocus
                                                ? _kError
                                                : _kDarkText)),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFocusableTile(int index) {
    final isFocused = _focusedIndex == index;
    final colors = [
      Color(0xFF1E88E5), Color(0xFF43A047), Color(0xFFFB8C00),
      Color(0xFF8E24AA), Color(0xFFE53935), Color(0xFF00ACC1),
      Color(0xFF3949AB), Color(0xFF7CB342), Color(0xFFD81B60),
      Color(0xFF546E7A), Color(0xFFF4511E), Color(0xFF00897B),
    ];
    final tileColor = colors[index % colors.length];

    return GestureDetector(
      onTap: () => _requestFocusViaAction(index),
      child: Focus(
        focusNode: _nodes[index],
        child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          decoration: BoxDecoration(
            color: isFocused
                ? _kFocused.withOpacity(0.2)
                : _kCardBg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isFocused ? _kFocused : tileColor.withOpacity(0.3),
              width: isFocused ? 3 : 1,
            ),
            boxShadow: isFocused
                ? [
                    BoxShadow(
                      color: _kFocused.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 4,
                    ),
                  ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isFocused
                      ? tileColor
                      : tileColor.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '$index',
                  style: TextStyle(
                    color:
                        isFocused ? Colors.white : tileColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: 4),
              Text(
                isFocused ? 'FOCUSED' : 'Tile $index',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isFocused
                      ? FontWeight.w800
                      : FontWeight.w400,
                  color: isFocused ? _kPrimary : _kMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _quickFocusButton(String label, int index) {
    return SizedBox(
      height: 30,
      child: OutlinedButton(
        onPressed: () => _requestFocusViaAction(index),
        style: OutlinedButton.styleFrom(
          foregroundColor: _kPrimary,
          side: BorderSide(color: _kPrimary.withOpacity(0.3)),
          padding: EdgeInsets.symmetric(horizontal: 10),
        ),
        child: Text(label, style: TextStyle(fontSize: 11)),
      ),
    );
  }

  Widget _statBadge(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$label: ',
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w500)),
          Text(value,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  TAB 3  –  Multi-Node
// ═══════════════════════════════════════════════════════════
class _MultiNodeTab extends StatefulWidget {
  @override
  State<_MultiNodeTab> createState() => _MultiNodeTabState();
}

class _MultiNodeTabState extends State<_MultiNodeTab> {
  late FocusNode _nameNode;
  late FocusNode _emailNode;
  late FocusNode _phoneNode;
  late FocusNode _addressNode;
  late FocusNode _notesNode;
  late FocusNode _submitNode;

  String _lastAction = 'None';
  int _interceptCount = 0;
  bool _interceptEnabled = false;

  final List<_FocusEvent> _events = [];

  @override
  void initState() {
    super.initState();
    _nameNode = FocusNode(debugLabel: 'name');
    _emailNode = FocusNode(debugLabel: 'email');
    _phoneNode = FocusNode(debugLabel: 'phone');
    _addressNode = FocusNode(debugLabel: 'address');
    _notesNode = FocusNode(debugLabel: 'notes');
    _submitNode = FocusNode(debugLabel: 'submit');

    for (final entry in _allFields) {
      entry.node.addListener(() {
        if (entry.node.hasFocus) {
          setState(() {
            _lastAction = 'Focused: ${entry.label}';
            _events.insert(0, _FocusEvent(entry.label, DateTime.now()));
            if (_events.length > 25) _events.removeLast();
          });
        }
      });
    }
  }

  List<_FieldEntry> get _allFields => [
        _FieldEntry('Name', _nameNode, Icons.person),
        _FieldEntry('Email', _emailNode, Icons.email),
        _FieldEntry('Phone', _phoneNode, Icons.phone),
        _FieldEntry('Address', _addressNode, Icons.location_on),
        _FieldEntry('Notes', _notesNode, Icons.note),
        _FieldEntry('Submit', _submitNode, Icons.send),
      ];

  @override
  void dispose() {
    _nameNode.dispose();
    _emailNode.dispose();
    _phoneNode.dispose();
    _addressNode.dispose();
    _notesNode.dispose();
    _submitNode.dispose();
    super.dispose();
  }

  void _focusField(FocusNode node) {
    Actions.invoke(context, RequestFocusIntent(node));
  }

  @override
  Widget build(BuildContext context) {
    final fields = _allFields;

    // Wrap in Actions to optionally intercept
    Widget content = Column(
      children: [
        // ── Control bar ─────────────────────────────────
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: _kPrimary.withOpacity(0.06),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _kAccent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(_lastAction,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
              ),
              Spacer(),
              Text('Intercept:',
                  style: TextStyle(fontSize: 12, color: _kMuted)),
              SizedBox(width: 6),
              Switch(
                value: _interceptEnabled,
                onChanged: (v) => setState(() => _interceptEnabled = v),
                activeColor: _kAccent,
              ),
              if (_interceptEnabled)
                Container(
                  margin: EdgeInsets.only(left: 4),
                  padding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _kError.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('$_interceptCount blocked',
                      style: TextStyle(
                          fontSize: 11,
                          color: _kError,
                          fontWeight: FontWeight.w600)),
                ),
            ],
          ),
        ),

        // ── Main area ───────────────────────────────────
        Expanded(
          child: Row(
            children: [
              // Left: form fields
              Expanded(
                flex: 3,
                child: ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    // Info card
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _kHighlight,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: _kAccent.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline,
                              color: _kAccent, size: 20),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Each field has its own FocusNode. Use the '
                              'buttons to dispatch RequestFocusIntent. '
                              'Toggle "Intercept" to see a custom Action '
                              'override that blocks focus changes.',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: _kDarkText,
                                  height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14),

                    // Form fields
                    ...fields.map((f) => _buildFormField(f)),

                    SizedBox(height: 16),

                    // Quick navigation row
                    _sectionCard(
                      'Programmatic Navigation',
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'These buttons dispatch RequestFocusIntent '
                            'via Actions.invoke(). When "Intercept" is on, '
                            'a custom CallbackAction blocks the request.',
                            style: TextStyle(
                                fontSize: 12, color: _kMuted, height: 1.4),
                          ),
                          SizedBox(height: 10),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: fields.map((f) {
                              final isFocused = f.node.hasFocus;
                              return SizedBox(
                                height: 34,
                                child: ElevatedButton.icon(
                                  onPressed: () => _focusField(f.node),
                                  icon: Icon(f.icon, size: 14),
                                  label: Text(f.label,
                                      style: TextStyle(fontSize: 11)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isFocused
                                        ? _kAccent
                                        : _kPrimary,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  // Sequential focus: name → email → phone → ...
                                  final current = fields.indexWhere(
                                      (f) => f.node.hasFocus);
                                  final next =
                                      (current + 1) % fields.length;
                                  _focusField(fields[next].node);
                                },
                                child: Text('Tab Forward →',
                                    style: TextStyle(fontSize: 11)),
                              ),
                              SizedBox(width: 8),
                              OutlinedButton(
                                onPressed: () {
                                  final current = fields.indexWhere(
                                      (f) => f.node.hasFocus);
                                  final prev = (current - 1 +
                                          fields.length) %
                                      fields.length;
                                  _focusField(fields[prev].node);
                                },
                                child: Text('← Tab Back',
                                    style: TextStyle(fontSize: 11)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),

              // Right: event timeline
              Container(
                width: 210,
                decoration: BoxDecoration(
                  color: _kCardBg,
                  border: Border(
                      left: BorderSide(color: Colors.grey.shade300)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      color: _kAccent.withOpacity(0.08),
                      child: Row(
                        children: [
                          Icon(Icons.timeline,
                              size: 16, color: _kAccent),
                          SizedBox(width: 6),
                          Text('Focus Timeline',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: _kDarkText)),
                          Spacer(),
                          GestureDetector(
                            onTap: () =>
                                setState(() => _events.clear()),
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
                                'Focus a field\nto see events',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: _kMuted, fontSize: 12),
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.all(6),
                              itemCount: _events.length,
                              itemBuilder: (_, i) {
                                final e = _events[i];
                                return Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 3),
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: _kAccent
                                          .withOpacity(0.06),
                                      borderRadius:
                                          BorderRadius.circular(4),
                                      border: Border.all(
                                          color: _kAccent
                                              .withOpacity(0.15)),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.adjust,
                                            size: 12,
                                            color: _kAccent),
                                        SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                            e.field,
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight:
                                                    FontWeight
                                                        .w600,
                                                color:
                                                    _kDarkText),
                                          ),
                                        ),
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
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );

    // Conditionally wrap in an intercepting Action
    if (_interceptEnabled) {
      content = Actions(
        actions: {
          RequestFocusIntent:
              CallbackAction<RequestFocusIntent>(
            onInvoke: (intent) {
              setState(() {
                _interceptCount++;
                _lastAction =
                    'BLOCKED focus on ${intent.focusNode.debugLabel}';
              });
              print(
                  'Intercepted: focus request to ${intent.focusNode.debugLabel}');
              return null; // do NOT forward
            },
          ),
        },
        child: content,
      );
    }

    return content;
  }

  Widget _buildFormField(_FieldEntry entry) {
    final hasFocus = entry.node.hasFocus;
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: hasFocus
              ? _kFocused.withOpacity(0.08)
              : _kCardBg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: hasFocus ? _kFocused : Colors.grey.shade300,
            width: hasFocus ? 2 : 1,
          ),
          boxShadow: hasFocus
              ? [
                  BoxShadow(
                    color: _kFocused.withOpacity(0.15),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: hasFocus
                    ? _kAccent
                    : _kPrimary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Icon(entry.icon,
                  size: 18,
                  color: hasFocus ? Colors.white : _kPrimary),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(entry.label,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: _kDarkText)),
                  SizedBox(height: 4),
                  SizedBox(
                    height: 36,
                    child: TextField(
                      focusNode: entry.node,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                              color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              BorderSide(color: _kAccent, width: 2),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 8, vertical: 6),
                        hintText: 'Enter ${entry.label.toLowerCase()}',
                        hintStyle: TextStyle(
                            fontSize: 12,
                            color: _kMuted.withOpacity(0.5)),
                        isDense: true,
                      ),
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: hasFocus
                    ? _kAccent.withOpacity(0.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                hasFocus ? 'FOCUSED' : 'idle',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight:
                      hasFocus ? FontWeight.w800 : FontWeight.w400,
                  color: hasFocus ? _kAccent : _kMuted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FieldEntry {
  final String label;
  final FocusNode node;
  final IconData icon;
  _FieldEntry(this.label, this.node, this.icon);
}

class _FocusEvent {
  final String field;
  final DateTime time;
  _FocusEvent(this.field, this.time);
}

// ═══════════════════════════════════════════════════════════
//  Shared helper widgets
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
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: _kDarkText)),
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

Widget _paramRow(
    String name, String type, String desc, Color color) {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withOpacity(0.05),
      borderRadius: BorderRadius.circular(6),
      border: Border(left: BorderSide(color: color, width: 3)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: _kCodeBg,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(name,
              style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: color)),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(type,
                  style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: _kMuted)),
              Text(desc,
                  style: TextStyle(
                      fontSize: 11, color: _kDarkText)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _dispatchMethod({
  required String title,
  required String code,
  required String description,
}) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _kPrimary.withOpacity(0.03),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kPrimary.withOpacity(0.1)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: _kPrimary)),
        SizedBox(height: 6),
        _codeBlock(code),
        SizedBox(height: 6),
        Text(description,
            style: TextStyle(
                fontSize: 12, color: _kMuted, height: 1.4)),
      ],
    ),
  );
}

Widget _bestPractice({
  required IconData icon,
  required String text,
  required bool isGood,
}) {
  final color = isGood ? Color(0xFF2E7D32) : _kError;
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
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
