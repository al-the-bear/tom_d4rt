// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────
//  RestorableTextEditingController  –  Deep Visual Demo
//
//  Palette: DeepOrange 700 / Cyan 600
//  Tabs  : Theory · Interactive · Restoration
// ─────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  print('RestorableTextEditingController demo building');
  return _RestorableTextEditingControllerDemo();
}

// ── colour constants ────────────────────────────────────
const _kPrimary = Color(0xFFE64A19); // DeepOrange 700
const _kAccent = Color(0xFF00ACC1); // Cyan 600
const _kSurface = Color(0xFFFFF3E0); // Orange 50
const _kCardBg = Color(0xFFFFFFFF);
const _kDarkText = Color(0xFF3E2723); // Brown 900
const _kMuted = Color(0xFF795548); // Brown 500
const _kCodeBg = Color(0xFFFBE9E7); // DeepOrange 50
const _kHighlight = Color(0xFFB2EBF2); // Cyan 100
const _kSuccess = Color(0xFF2E7D32); // Green 800
const _kWarning = Color(0xFFEF6C00); // Orange 800

class _RestorableTextEditingControllerDemo extends StatefulWidget {
  @override
  State<_RestorableTextEditingControllerDemo> createState() =>
      _RestorableTextEditingControllerDemoState();
}

class _RestorableTextEditingControllerDemoState
    extends State<_RestorableTextEditingControllerDemo>
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
        title: Text('RestorableTextEditingController',
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
            Tab(text: 'Interactive'),
            Tab(text: 'Restoration'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: [
          _TheoryTab(),
          _InteractiveTab(),
          _RestorationTab(),
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
        // ── Overview card ───────────────────────────────
        _buildSectionCard(
          title: 'What is RestorableTextEditingController?',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RestorableTextEditingController wraps a TextEditingController '
                'so its text, selection, and composing region survive state '
                'restoration. It extends RestorableChangeNotifier<TextEditingController> '
                'and participates in the RestorationMixin lifecycle.',
                style: TextStyle(color: _kDarkText, fontSize: 14, height: 1.5),
              ),
              SizedBox(height: 12),
              _buildCodeBlock(
                'class RestorableTextEditingController\n'
                '    extends RestorableChangeNotifier<TextEditingController> {\n'
                '  RestorableTextEditingController({String? text});\n'
                '  RestorableTextEditingController.fromValue(\n'
                '      TextEditingValue value);\n'
                '}',
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Three constructors ──────────────────────────
        _buildSectionCard(
          title: 'Three Ways to Create',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildConstructorRow(
                name: 'Default (no args)',
                code: 'RestorableTextEditingController()',
                description:
                    'Creates a controller with an empty string. The text '
                    'field starts blank and any user input becomes the '
                    'restorable value.',
                color: _kPrimary,
              ),
              SizedBox(height: 12),
              _buildConstructorRow(
                name: 'With initial text',
                code:
                    "RestorableTextEditingController(text: 'Hello')",
                description:
                    'Pre-fills the text field. On restoration the framework '
                    'recreates the controller with the saved text, not the '
                    'initial text argument.',
                color: _kAccent,
              ),
              SizedBox(height: 12),
              _buildConstructorRow(
                name: 'fromValue',
                code:
                    'RestorableTextEditingController.fromValue(\n'
                    '  TextEditingValue(\n'
                    "    text: 'Custom',\n"
                    '    selection: TextSelection.collapsed(offset: 3),\n'
                    '  ),\n'
                    ')',
                description:
                    'Full control: specify text, selection, and composing '
                    'region at once. Useful when you need a precise cursor '
                    'position on first load.',
                color: _kSuccess,
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Restoration lifecycle ───────────────────────
        _buildSectionCard(
          title: 'Restoration Lifecycle',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLifecycleStep(
                step: '1',
                label: 'Declare property',
                detail:
                    'Declare a RestorableTextEditingController field in a State '
                    'that uses RestorationMixin.',
              ),
              _buildLifecycleStep(
                step: '2',
                label: 'Register for restoration',
                detail:
                    "Call registerForRestoration(controller, 'myId') inside "
                    'restoreState(). The framework calls createDefaultValue() '
                    'if no saved state exists, or fromPrimitives() if it does.',
              ),
              _buildLifecycleStep(
                step: '3',
                label: 'Use in TextField',
                detail:
                    'Pass controller.value to the TextField or TextFormField. '
                    'Edits are automatically tracked by the restoration '
                    'framework.',
              ),
              _buildLifecycleStep(
                step: '4',
                label: 'App backgrounded / restored',
                detail:
                    'toPrimitives() encodes the complete TextEditingValue '
                    '(text + selection + composing). On restore, '
                    'fromPrimitives() decodes it back.',
              ),
              _buildLifecycleStep(
                step: '5',
                label: 'Dispose',
                detail:
                    'The controller is disposed automatically when the '
                    'RestorableProperty is unregistered. You do NOT call '
                    'dispose() yourself.',
              ),
              SizedBox(height: 12),
              _buildCodeBlock(
                'class _MyState extends State<MyWidget>\n'
                '    with RestorationMixin {\n'
                '  final _controller =\n'
                "      RestorableTextEditingController(text: 'Hi');\n"
                '\n'
                '  @override\n'
                "  String get restorationId => 'my_widget';\n"
                '\n'
                '  @override\n'
                '  void restoreState(RestorationBucket? old, bool init) {\n'
                "    registerForRestoration(_controller, 'ctrl');\n"
                '  }\n'
                '\n'
                '  @override\n'
                '  Widget build(BuildContext context) =>\n'
                '      TextField(controller: _controller.value);\n'
                '}',
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Comparison table ────────────────────────────
        _buildSectionCard(
          title: 'TextEditingController vs Restorable',
          child: Table(
            border: TableBorder.all(color: Colors.grey.shade300),
            columnWidths: {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
            },
            children: [
              _buildTableRow(
                cells: ['Aspect', 'TextEditingController', 'Restorable'],
                isHeader: true,
              ),
              _buildTableRow(cells: [
                'State',
                'Lost on process kill',
                'Encoded & restored',
              ]),
              _buildTableRow(cells: [
                'Lifecycle',
                'Manual dispose()',
                'Auto-disposed',
              ]),
              _buildTableRow(cells: [
                'Selection',
                'Not persisted',
                'Persisted (offset/extent)',
              ]),
              _buildTableRow(cells: [
                'Composing',
                'Not persisted',
                'Persisted (IME region)',
              ]),
              _buildTableRow(cells: [
                'Typical use',
                'Ephemeral forms',
                'Forms that survive backgrounding',
              ]),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Best practices ──────────────────────────────
        _buildSectionCard(
          title: 'Best Practices',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBestPractice(
                icon: Icons.check_circle_outline,
                text:
                    'Always assign a unique restorationId to the widget and '
                    'a unique property ID when registering.',
                isGood: true,
              ),
              _buildBestPractice(
                icon: Icons.check_circle_outline,
                text:
                    'Prefer fromValue when you need specific cursor placement '
                    'on initial load (e.g., end-of-text).',
                isGood: true,
              ),
              _buildBestPractice(
                icon: Icons.cancel_outlined,
                text:
                    'Do NOT call controller.value.dispose() yourself — the '
                    'restoration framework manages disposal.',
                isGood: false,
              ),
              _buildBestPractice(
                icon: Icons.cancel_outlined,
                text:
                    'Do NOT create the controller inside build() — declare it '
                    'as a field and register once in restoreState().',
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
//  TAB 2  –  Interactive
// ═══════════════════════════════════════════════════════════
class _InteractiveTab extends StatefulWidget {
  @override
  State<_InteractiveTab> createState() => _InteractiveTabState();
}

class _InteractiveTabState extends State<_InteractiveTab> {
  // Three controllers showing the three constructors
  late TextEditingController _defaultCtrl;
  late TextEditingController _textCtrl;
  late TextEditingController _valueCtrl;

  int _editCount = 0;

  @override
  void initState() {
    super.initState();
    _defaultCtrl = TextEditingController();
    _textCtrl = TextEditingController(text: 'Hello, Flutter!');
    _valueCtrl = TextEditingController.fromValue(
      TextEditingValue(
        text: 'Cursor at 6',
        selection: TextSelection.collapsed(offset: 6),
      ),
    );
    _defaultCtrl.addListener(_onEdit);
    _textCtrl.addListener(_onEdit);
    _valueCtrl.addListener(_onEdit);
  }

  void _onEdit() {
    setState(() => _editCount++);
  }

  @override
  void dispose() {
    _defaultCtrl.dispose();
    _textCtrl.dispose();
    _valueCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // ── Edit counter banner ─────────────────────────
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_kPrimary, _kPrimary.withOpacity(0.8)],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(Icons.edit_note, color: Colors.white, size: 28),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total edits across all fields',
                      style: TextStyle(color: Colors.white70, fontSize: 12)),
                  Text('$_editCount listener callbacks',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // ── Default constructor field ───────────────────
        _buildFieldCard(
          title: 'Default Constructor',
          subtitle: 'RestorableTextEditingController()',
          controller: _defaultCtrl,
          accentColor: _kPrimary,
          icon: Icons.text_fields,
        ),
        SizedBox(height: 14),

        // ── Text constructor field ──────────────────────
        _buildFieldCard(
          title: 'With Initial Text',
          subtitle:
              "RestorableTextEditingController(text: 'Hello, Flutter!')",
          controller: _textCtrl,
          accentColor: _kAccent,
          icon: Icons.text_snippet,
        ),
        SizedBox(height: 14),

        // ── fromValue constructor field ─────────────────
        _buildFieldCard(
          title: 'From TextEditingValue',
          subtitle:
              'RestorableTextEditingController.fromValue(...)',
          controller: _valueCtrl,
          accentColor: _kSuccess,
          icon: Icons.code,
        ),
        SizedBox(height: 14),

        // ── Live property inspector ─────────────────────
        _buildSectionCard(
          title: 'Live Property Inspector',
          child: Column(
            children: [
              _buildPropertyGrid('Default', _defaultCtrl, _kPrimary),
              Divider(height: 20),
              _buildPropertyGrid('WithText', _textCtrl, _kAccent),
              Divider(height: 20),
              _buildPropertyGrid('FromValue', _valueCtrl, _kSuccess),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Action buttons ──────────────────────────────
        _buildSectionCard(
          title: 'Programmatic Operations',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildActionChip(
                label: 'Clear all',
                icon: Icons.clear_all,
                onTap: () {
                  setState(() {
                    _defaultCtrl.clear();
                    _textCtrl.clear();
                    _valueCtrl.clear();
                  });
                },
              ),
              _buildActionChip(
                label: 'Select all (default)',
                icon: Icons.select_all,
                onTap: () {
                  setState(() {
                    _defaultCtrl.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: _defaultCtrl.text.length,
                    );
                  });
                },
              ),
              _buildActionChip(
                label: 'Move cursor to end',
                icon: Icons.last_page,
                onTap: () {
                  setState(() {
                    for (final c in [_defaultCtrl, _textCtrl, _valueCtrl]) {
                      c.selection = TextSelection.collapsed(
                        offset: c.text.length,
                      );
                    }
                  });
                },
              ),
              _buildActionChip(
                label: 'Append " ✓"',
                icon: Icons.add,
                onTap: () {
                  setState(() {
                    for (final c in [_defaultCtrl, _textCtrl, _valueCtrl]) {
                      c.text = '${c.text} \u2713';
                    }
                  });
                },
              ),
              _buildActionChip(
                label: 'Set composing (withText)',
                icon: Icons.keyboard,
                onTap: () {
                  final text = _textCtrl.text;
                  if (text.length >= 5) {
                    setState(() {
                      _textCtrl.value = TextEditingValue(
                        text: text,
                        composing: TextRange(start: 0, end: 5),
                        selection: TextSelection.collapsed(offset: 5),
                      );
                    });
                  }
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _buildFieldCard({
    required String title,
    required String subtitle,
    required TextEditingController controller,
    required Color accentColor,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.08),
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
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: accentColor, size: 20),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: _kDarkText,
                            fontSize: 14)),
                    Text(subtitle,
                        style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11,
                            color: _kMuted)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: accentColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: accentColor, width: 2),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              hintText: 'Type here...',
              suffixIcon: Icon(Icons.edit, color: accentColor, size: 18),
            ),
            style: TextStyle(fontSize: 14, color: _kDarkText),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              _buildMiniStat(
                  'Length', '${controller.text.length}', accentColor),
              SizedBox(width: 8),
              _buildMiniStat(
                  'Cursor',
                  controller.selection.isValid
                      ? '${controller.selection.baseOffset}'
                      : '—',
                  accentColor),
              SizedBox(width: 8),
              _buildMiniStat(
                  'Selected',
                  controller.selection.isValid
                      ? '${controller.selection.end - controller.selection.start}'
                      : '0',
                  accentColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label,
              style: TextStyle(fontSize: 10, color: _kMuted)),
          SizedBox(width: 4),
          Text(value,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color)),
        ],
      ),
    );
  }

  Widget _buildPropertyGrid(
      String label, TextEditingController ctrl, Color color) {
    final sel = ctrl.selection;
    final comp = ctrl.value.composing;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(label,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: color)),
        ),
        SizedBox(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: [
            _buildPropChip('text', '"${_truncate(ctrl.text, 20)}"'),
            _buildPropChip('length', '${ctrl.text.length}'),
            _buildPropChip(
                'selection.base',
                sel.isValid ? '${sel.baseOffset}' : 'invalid'),
            _buildPropChip(
                'selection.extent',
                sel.isValid ? '${sel.extentOffset}' : 'invalid'),
            _buildPropChip('selection.isCollapsed',
                sel.isValid ? '${sel.isCollapsed}' : '—'),
            _buildPropChip(
                'composing',
                comp.isValid
                    ? '${comp.start}..${comp.end}'
                    : 'none'),
          ],
        ),
      ],
    );
  }

  Widget _buildPropChip(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: _kCodeBg,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: TextStyle(
                  fontSize: 10,
                  color: _kMuted,
                  fontFamily: 'monospace'),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: _kDarkText,
                  fontFamily: 'monospace'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionChip({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ActionChip(
      avatar: Icon(icon, size: 16, color: _kPrimary),
      label: Text(label, style: TextStyle(fontSize: 12)),
      onPressed: onTap,
      backgroundColor: _kHighlight,
      side: BorderSide(color: _kAccent.withOpacity(0.3)),
    );
  }

  String _truncate(String s, int max) =>
      s.length <= max ? s : '${s.substring(0, max)}...';
}

// ═══════════════════════════════════════════════════════════
//  TAB 3  –  Restoration
// ═══════════════════════════════════════════════════════════
class _RestorationTab extends StatefulWidget {
  @override
  State<_RestorationTab> createState() => _RestorationTabState();
}

class _RestorationTabState extends State<_RestorationTab> {
  int _rebuildCount = 0;
  bool _showChild = true;
  final List<_EventEntry> _events = [];

  // Simulated "bucket" to store text values across rebuild cycles
  final Map<String, String> _savedBucket = {};

  void _addEvent(String msg) {
    setState(() {
      _events.insert(0, _EventEntry(msg, DateTime.now()));
      if (_events.length > 30) _events.removeLast();
    });
  }

  void _simulateSave(String id, String text) {
    _savedBucket[id] = text;
    _addEvent('SAVE  "$id" → "${_truncate(text, 25)}"');
  }

  void _simulateRestore() {
    setState(() {
      _showChild = false;
    });
    Future.delayed(Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _showChild = true;
          _rebuildCount++;
        });
        _addEvent('RESTORE  rebuild #$_rebuildCount');
      }
    });
  }

  String _truncate(String s, int max) =>
      s.length <= max ? s : '${s.substring(0, max)}...';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Control bar ─────────────────────────────────
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: _kPrimary.withOpacity(0.06),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _kPrimary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text('Rebuilds: $_rebuildCount',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13)),
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _kAccent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text('Saved keys: ${_savedBucket.length}',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13)),
              ),
              Spacer(),
              ElevatedButton.icon(
                onPressed: _simulateRestore,
                icon: Icon(Icons.restore, size: 16),
                label: Text('Simulate Restore', style: TextStyle(fontSize: 12)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _kWarning,
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
              // Left side: restorable fields
              Expanded(
                flex: 3,
                child: _showChild
                    ? _RestorableFieldsPanel(
                        key: ValueKey('panel_$_rebuildCount'),
                        savedBucket: _savedBucket,
                        onSave: _simulateSave,
                        onEvent: _addEvent,
                      )
                    : Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.hourglass_top,
                                size: 48,
                                color: _kWarning.withOpacity(0.6)),
                            SizedBox(height: 8),
                            Text('Restoring...',
                                style: TextStyle(
                                    color: _kWarning,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
              ),

              // Right side: event log
              Container(
                width: 260,
                decoration: BoxDecoration(
                  color: _kCardBg,
                  border: Border(
                    left: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      color: _kPrimary.withOpacity(0.08),
                      child: Row(
                        children: [
                          Icon(Icons.list_alt,
                              size: 16, color: _kPrimary),
                          SizedBox(width: 6),
                          Text('Restoration Log',
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
                                'Edit fields then press\n"Simulate Restore"',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: _kMuted, fontSize: 12),
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.all(8),
                              itemCount: _events.length,
                              itemBuilder: (_, i) {
                                final e = _events[i];
                                final isSave =
                                    e.message.startsWith('SAVE');
                                final isRestore =
                                    e.message.startsWith('RESTORE');
                                final isInit =
                                    e.message.startsWith('INIT');
                                Color tagColor = _kMuted;
                                if (isSave) tagColor = _kAccent;
                                if (isRestore) tagColor = _kWarning;
                                if (isInit) tagColor = _kSuccess;
                                return Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 4),
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: tagColor
                                          .withOpacity(0.06),
                                      borderRadius:
                                          BorderRadius.circular(6),
                                      border: Border.all(
                                          color: tagColor
                                              .withOpacity(0.2)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          e.message,
                                          style: TextStyle(
                                            fontFamily: 'monospace',
                                            fontSize: 11,
                                            color: _kDarkText,
                                            fontWeight:
                                                FontWeight.w500,
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
  }
}

class _RestorableFieldsPanel extends StatefulWidget {
  final Map<String, String> savedBucket;
  final void Function(String id, String text) onSave;
  final void Function(String msg) onEvent;

  const _RestorableFieldsPanel({
    super.key,
    required this.savedBucket,
    required this.onSave,
    required this.onEvent,
  });

  @override
  State<_RestorableFieldsPanel> createState() =>
      _RestorableFieldsPanelState();
}

class _RestorableFieldsPanelState extends State<_RestorableFieldsPanel> {
  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _notesCtrl;

  @override
  void initState() {
    super.initState();
    // Simulate restoration: if bucket has values, use them
    final nameText = widget.savedBucket['name'] ?? '';
    final emailText = widget.savedBucket['email'] ?? '';
    final notesText = widget.savedBucket['notes'] ?? '';

    _nameCtrl = TextEditingController(text: nameText);
    _emailCtrl = TextEditingController(text: emailText);
    _notesCtrl = TextEditingController(text: notesText);

    if (nameText.isNotEmpty || emailText.isNotEmpty || notesText.isNotEmpty) {
      widget.onEvent(
          'INIT  Restored ${widget.savedBucket.length} field(s) from bucket');
    } else {
      widget.onEvent('INIT  Fresh start — bucket is empty');
    }

    // Auto-save on edits
    _nameCtrl.addListener(() => widget.onSave('name', _nameCtrl.text));
    _emailCtrl.addListener(() => widget.onSave('email', _emailCtrl.text));
    _notesCtrl.addListener(() => widget.onSave('notes', _notesCtrl.text));
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // Explanation
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kHighlight,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kAccent.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: _kAccent, size: 20),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Type into the fields below, then press "Simulate Restore". '
                  'The panel rebuilds from scratch, but text is recovered from '
                  'the saved bucket — just like RestorationMixin would do.',
                  style: TextStyle(fontSize: 12, color: _kDarkText, height: 1.4),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // Name field
        _buildRestorableField(
          label: 'Name',
          restorationId: 'name',
          controller: _nameCtrl,
          icon: Icons.person_outline,
          hint: 'Enter your name',
        ),
        SizedBox(height: 14),

        // Email field
        _buildRestorableField(
          label: 'Email',
          restorationId: 'email',
          controller: _emailCtrl,
          icon: Icons.email_outlined,
          hint: 'Enter your email',
        ),
        SizedBox(height: 14),

        // Notes field
        _buildRestorableField(
          label: 'Notes',
          restorationId: 'notes',
          controller: _notesCtrl,
          icon: Icons.sticky_note_2_outlined,
          hint: 'Write some notes here',
          maxLines: 3,
        ),
        SizedBox(height: 20),

        // Bucket visualization
        _buildSectionCard(
          title: 'Current Bucket Contents',
          child: widget.savedBucket.isEmpty
              ? Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('(empty — type into fields above)',
                      style: TextStyle(
                          color: _kMuted,
                          fontStyle: FontStyle.italic,
                          fontSize: 13)),
                )
              : Column(
                  children: widget.savedBucket.entries.map((e) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: [
                          Container(
                            width: 70,
                            padding: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: _kAccent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(e.key,
                                style: TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: _kAccent)),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward,
                              size: 12, color: _kMuted),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '"${e.value}"',
                              style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 11,
                                  color: _kDarkText),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
        ),
        SizedBox(height: 14),

        // Encoding visualization
        _buildSectionCard(
          title: 'Serialization Preview',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'In a real restoration, toPrimitives() encodes each '
                'TextEditingValue into the restoration bucket:',
                style: TextStyle(fontSize: 12, color: _kMuted, height: 1.4),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _kCodeBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '{\n'
                  '  "name": {\n'
                  '    "text": "${_nameCtrl.text}",\n'
                  '    "selectionBase": ${_nameCtrl.selection.isValid ? _nameCtrl.selection.baseOffset : -1},\n'
                  '    "selectionExtent": ${_nameCtrl.selection.isValid ? _nameCtrl.selection.extentOffset : -1}\n'
                  '  },\n'
                  '  "email": {\n'
                  '    "text": "${_emailCtrl.text}",\n'
                  '    "selectionBase": ${_emailCtrl.selection.isValid ? _emailCtrl.selection.baseOffset : -1},\n'
                  '    "selectionExtent": ${_emailCtrl.selection.isValid ? _emailCtrl.selection.extentOffset : -1}\n'
                  '  },\n'
                  '  "notes": {\n'
                  '    "text": "${_notesCtrl.text}",\n'
                  '    "selectionBase": ${_notesCtrl.selection.isValid ? _notesCtrl.selection.baseOffset : -1},\n'
                  '    "selectionExtent": ${_notesCtrl.selection.isValid ? _notesCtrl.selection.extentOffset : -1}\n'
                  '  }\n'
                  '}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: _kDarkText,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _buildRestorableField({
    required String label,
    required String restorationId,
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    int maxLines = 1,
  }) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kAccent.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: _kPrimary, size: 18),
              SizedBox(width: 6),
              Text(label,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: _kDarkText)),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _kCodeBg,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text('id: "$restorationId"',
                    style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10,
                        color: _kMuted)),
              ),
            ],
          ),
          SizedBox(height: 8),
          TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: _kPrimary, width: 2),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              hintText: hint,
              hintStyle: TextStyle(color: _kMuted.withOpacity(0.5)),
            ),
            style: TextStyle(fontSize: 13, color: _kDarkText),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  Shared helper widgets
// ═══════════════════════════════════════════════════════════

class _EventEntry {
  final String message;
  final DateTime time;
  _EventEntry(this.message, this.time);
}

Widget _buildSectionCard({required String title, required Widget child}) {
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

Widget _buildCodeBlock(String code) {
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

Widget _buildConstructorRow({
  required String name,
  required String code,
  required String description,
  required Color color,
}) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withOpacity(0.05),
      borderRadius: BorderRadius.circular(8),
      border: Border(left: BorderSide(color: color, width: 3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name,
            style: TextStyle(
                fontWeight: FontWeight.w700, color: color, fontSize: 13)),
        SizedBox(height: 4),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _kCodeBg,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(code,
              style: TextStyle(
                  fontFamily: 'monospace', fontSize: 11, color: _kDarkText)),
        ),
        SizedBox(height: 6),
        Text(description,
            style: TextStyle(
                fontSize: 12, color: _kMuted, height: 1.4)),
      ],
    ),
  );
}

Widget _buildLifecycleStep({
  required String step,
  required String label,
  required String detail,
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: _kPrimary,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(step,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13)),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: _kDarkText)),
              SizedBox(height: 2),
              Text(detail,
                  style: TextStyle(
                      fontSize: 12, color: _kMuted, height: 1.4)),
            ],
          ),
        ),
      ],
    ),
  );
}

TableRow _buildTableRow({
  required List<String> cells,
  bool isHeader = false,
}) {
  return TableRow(
    decoration: isHeader
        ? BoxDecoration(color: _kPrimary.withOpacity(0.08))
        : null,
    children: cells.map((c) {
      return Padding(
        padding: EdgeInsets.all(8),
        child: Text(c,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isHeader ? FontWeight.w700 : FontWeight.w400,
              color: isHeader ? _kPrimary : _kDarkText,
            )),
      );
    }).toList(),
  );
}

Widget _buildBestPractice({
  required IconData icon,
  required String text,
  required bool isGood,
}) {
  final color = isGood ? _kSuccess : Color(0xFFC62828);
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 18),
        SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style:
                  TextStyle(fontSize: 12, color: _kDarkText, height: 1.4)),
        ),
      ],
    ),
  );
}
