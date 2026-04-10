// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────
//  RedoTextIntent  –  Deep Visual Demo
//
//  Palette : Crimson 800 / Amber 400
//  Tabs    : Theory · Workshop · Undo/Redo Lab
// ─────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  print('RedoTextIntent demo building');
  return _RedoTextIntentDemo();
}

// ── colour constants ────────────────────────────────────
const _kPrimary = Color(0xFFC62828); // Red 800 (Crimson)
const _kAccent = Color(0xFFFFCA28); // Amber 400
const _kSurface = Color(0xFFFFF8E1); // Amber 50
const _kCardBg = Color(0xFFFFFFFF);
const _kDarkText = Color(0xFF4E342E); // Brown 800
const _kMuted = Color(0xFFEF9A9A); // Red 200
const _kCodeBg = Color(0xFFFCE4EC); // Pink 50
const _kHighlight = Color(0xFFFFF9C4); // Yellow 100
const _kIntentColor = Color(0xFF6A1B9A); // Purple 800
const _kActionColor = Color(0xFF2E7D32); // Green 800
const _kUndoColor = Color(0xFF1565C0); // Blue 800
const _kRedoColor = Color(0xFFE65100); // Orange 900

class _RedoTextIntentDemo extends StatefulWidget {
  @override
  State<_RedoTextIntentDemo> createState() => _RedoTextIntentDemoState();
}

class _RedoTextIntentDemoState extends State<_RedoTextIntentDemo>
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
        title: Text('RedoTextIntent',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        backgroundColor: _kPrimary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabCtrl,
          indicatorColor: _kAccent,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: [
            Tab(text: 'Theory'),
            Tab(text: 'Workshop'),
            Tab(text: 'Undo/Redo Lab'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: [
          _TheoryTab(),
          _WorkshopTab(),
          _UndoRedoLabTab(),
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
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOverviewCard(),
          SizedBox(height: 14),
          _buildIntentHierarchyCard(),
          SizedBox(height: 14),
          _buildSelectionCauseCard(),
          SizedBox(height: 14),
          _buildKeyboardShortcutsCard(),
          SizedBox(height: 14),
          _buildRelatedIntentsCard(),
          SizedBox(height: 14),
          _buildIntentActionFlowCard(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildOverviewCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kPrimary.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _kPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.redo, color: _kPrimary, size: 28),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('RedoTextIntent',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: _kDarkText)),
                    SizedBox(height: 3),
                    Text('Restores previously undone text edits',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 14),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kHighlight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'RedoTextIntent is a Flutter Intent that triggers the "redo" '
              'action in text editing fields. It reverses the most recent '
              'undo operation, restoring text to its state before the undo. '
              'The intent carries a SelectionChangedCause that describes '
              'what triggered the redo (keyboard shortcut, toolbar, etc.).',
              style: TextStyle(fontSize: 12.5, color: _kDarkText, height: 1.5),
            ),
          ),
          SizedBox(height: 12),
          _labelBadge('Part of Flutter\'s Intent / Action system', _kIntentColor),
          SizedBox(height: 6),
          _labelBadge('Works with UndoHistoryController', _kActionColor),
          SizedBox(height: 6),
          _labelBadge('Platform-aware keyboard shortcuts', _kUndoColor),
        ],
      ),
    );
  }

  Widget _buildIntentHierarchyCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kMuted),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Class Hierarchy',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kPrimary)),
          SizedBox(height: 12),
          _hierarchyRow('Intent', 0, _kIntentColor, 'Base class for all intents'),
          _hierarchyRow(
              'RedoTextIntent', 1, _kRedoColor, 'Redo text edit intent'),
          SizedBox(height: 14),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kCodeBg,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Constructor:',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _kDarkText)),
                SizedBox(height: 4),
                Text(
                  'const RedoTextIntent(\n'
                  '  SelectionChangedCause cause\n'
                  ')',
                  style: TextStyle(
                      fontSize: 11.5,
                      fontFamily: 'monospace',
                      color: _kDarkText),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            'The intent is immutable (const) and carries a single property: '
            'the SelectionChangedCause that describes what triggered the redo.',
            style: TextStyle(fontSize: 11.5, color: Colors.grey[700], height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionCauseCard() {
    final causes = <String, String>{
      'tap': 'User tapped to change selection',
      'doubleTap': 'User double-tapped a word',
      'longPress': 'User long-pressed the text',
      'forcePress': 'User force-pressed (3D Touch)',
      'keyboard': 'Keyboard shortcut triggered',
      'toolbar': 'Toolbar button activated',
      'drag': 'User dragged across text',
      'scribble': 'Apple Pencil scribble input',
    };
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kMuted),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('SelectionChangedCause Values',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kPrimary)),
          SizedBox(height: 4),
          Text('Describes what triggered the redo action',
              style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          SizedBox(height: 12),
          ...causes.entries.map((e) => Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 90,
                      padding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: _kAccent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(e.key,
                          style: TextStyle(
                              fontSize: 10.5,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w600,
                              color: _kDarkText)),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(e.value,
                          style: TextStyle(
                              fontSize: 11.5, color: Colors.grey[700])),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildKeyboardShortcutsCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kMuted),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.keyboard, color: _kPrimary, size: 20),
              SizedBox(width: 8),
              Text('Platform Keyboard Shortcuts',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _kPrimary)),
            ],
          ),
          SizedBox(height: 12),
          _shortcutRow('Windows / Linux', 'Ctrl + Y', Icons.desktop_windows),
          SizedBox(height: 8),
          _shortcutRow(
              'macOS (primary)', 'Cmd + Shift + Z', Icons.laptop_mac),
          SizedBox(height: 8),
          _shortcutRow('macOS (alt)', 'Cmd + Y', Icons.laptop_mac),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: _kPrimary),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'The intent itself is platform-agnostic. The Shortcuts '
                    'widget maps platform-specific key combinations to the '
                    'RedoTextIntent.',
                    style: TextStyle(fontSize: 11, color: _kDarkText, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _shortcutRow(String platform, String keys, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        SizedBox(width: 8),
        SizedBox(
          width: 110,
          child: Text(platform,
              style: TextStyle(fontSize: 11.5, color: Colors.grey[700])),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: _kRedoColor.withOpacity(0.1),
            border: Border.all(color: _kRedoColor.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(keys,
              style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                  color: _kRedoColor)),
        ),
      ],
    );
  }

  Widget _buildRelatedIntentsCard() {
    final intents = <Map<String, dynamic>>[
      {
        'name': 'UndoTextIntent',
        'desc': 'Undo the last text edit',
        'icon': Icons.undo,
        'color': _kUndoColor,
      },
      {
        'name': 'RedoTextIntent',
        'desc': 'Redo the last undone edit',
        'icon': Icons.redo,
        'color': _kRedoColor,
      },
      {
        'name': 'CopySelectionTextIntent',
        'desc': 'Copy selected text to clipboard',
        'icon': Icons.copy,
        'color': _kActionColor,
      },
      {
        'name': 'PasteTextIntent',
        'desc': 'Paste from clipboard',
        'icon': Icons.paste,
        'color': _kIntentColor,
      },
      {
        'name': 'CutSelectionTextIntent',
        'desc': 'Cut selected text',
        'icon': Icons.content_cut,
        'color': Color(0xFF00838F),
      },
      {
        'name': 'SelectAllTextIntent',
        'desc': 'Select all text in field',
        'icon': Icons.select_all,
        'color': Color(0xFF558B2F),
      },
    ];
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kMuted),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Related Text Intents Family',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kPrimary)),
          SizedBox(height: 4),
          Text('All intents that modify or act on text',
              style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          SizedBox(height: 12),
          ...intents.map((i) => Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: (i['color'] as Color).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(i['icon'] as IconData,
                          size: 16, color: i['color'] as Color),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(i['name'] as String,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: i['color'] as Color)),
                          Text(i['desc'] as String,
                              style: TextStyle(
                                  fontSize: 11, color: Colors.grey[600])),
                        ],
                      ),
                    ),
                    if (i['name'] == 'RedoTextIntent')
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: _kAccent.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text('THIS',
                            style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: _kRedoColor)),
                      ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildIntentActionFlowCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kPrimary.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Intent ➜ Action Flow',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kPrimary)),
          SizedBox(height: 12),
          _flowStep(1, 'User presses Ctrl+Y / Cmd+Shift+Z',
              Icons.keyboard, Colors.grey[700]!),
          _flowArrow(),
          _flowStep(2, 'Shortcuts widget matches key binding',
              Icons.route, _kUndoColor),
          _flowArrow(),
          _flowStep(3, 'Creates RedoTextIntent(cause: keyboard)',
              Icons.flash_on, _kRedoColor),
          _flowArrow(),
          _flowStep(4, 'Actions widget finds matching Action',
              Icons.search, _kActionColor),
          _flowArrow(),
          _flowStep(5, 'Action invokes redo on UndoHistoryController',
              Icons.history, _kIntentColor),
          _flowArrow(),
          _flowStep(6, 'TextField state updates with restored text',
              Icons.check_circle_outline, _kPrimary),
        ],
      ),
    );
  }

  Widget _flowStep(int num, String label, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text('$num',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: color)),
          ),
        ),
        SizedBox(width: 10),
        Icon(icon, size: 18, color: color),
        SizedBox(width: 8),
        Expanded(
          child: Text(label,
              style: TextStyle(fontSize: 12, color: _kDarkText)),
        ),
      ],
    );
  }

  Widget _flowArrow() {
    return Padding(
      padding: EdgeInsets.only(left: 12, top: 2, bottom: 2),
      child: Icon(Icons.arrow_downward, size: 14, color: Colors.grey[400]),
    );
  }

  Widget _hierarchyRow(
      String name, int depth, Color color, String desc) {
    return Padding(
      padding: EdgeInsets.only(left: depth * 24.0, bottom: 6),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: 8),
          Text(name,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                  color: color)),
          SizedBox(width: 8),
          Text(desc,
              style: TextStyle(fontSize: 11, color: Colors.grey[500])),
        ],
      ),
    );
  }
}

Widget _labelBadge(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: color.withOpacity(0.25)),
    ),
    child: Text(text,
        style: TextStyle(
            fontSize: 11, fontWeight: FontWeight.w500, color: color)),
  );
}

// ═══════════════════════════════════════════════════════════
//  TAB 2  –  Workshop
// ═══════════════════════════════════════════════════════════

class _WorkshopTab extends StatefulWidget {
  @override
  State<_WorkshopTab> createState() => _WorkshopTabState();
}

class _WorkshopTabState extends State<_WorkshopTab> {
  final _controller1 = TextEditingController(text: 'Hello World');
  final _undoCtrl1 = UndoHistoryController();
  final _controller2 = TextEditingController();
  final _undoCtrl2 = UndoHistoryController();
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();

  final List<String> _editLog = [];
  bool _canUndo1 = false;
  bool _canRedo1 = false;
  bool _canUndo2 = false;
  bool _canRedo2 = false;

  @override
  void initState() {
    super.initState();
    _undoCtrl1.onUndo.addListener(_updateUndoState1);
    _undoCtrl1.onRedo.addListener(_updateUndoState1);
    _undoCtrl2.onUndo.addListener(_updateUndoState2);
    _undoCtrl2.onRedo.addListener(_updateUndoState2);
    _controller1.addListener(() {
      _addLog('Field 1 text: "${_controller1.text}"');
    });
    _controller2.addListener(() {
      _addLog('Field 2 text: "${_controller2.text}"');
    });
  }

  void _updateUndoState1() {
    setState(() {
      _canUndo1 = _undoCtrl1.value.canUndo;
      _canRedo1 = _undoCtrl1.value.canRedo;
    });
  }

  void _updateUndoState2() {
    setState(() {
      _canUndo2 = _undoCtrl2.value.canUndo;
      _canRedo2 = _undoCtrl2.value.canRedo;
    });
  }

  void _addLog(String entry) {
    setState(() {
      _editLog.insert(0, entry);
      if (_editLog.length > 30) _editLog.removeLast();
    });
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _undoCtrl1.dispose();
    _undoCtrl2.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEditField1(),
          SizedBox(height: 16),
          _buildEditField2(),
          SizedBox(height: 16),
          _buildUndoRedoStatePanel(),
          SizedBox(height: 16),
          _buildEditLogPanel(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildEditField1() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kPrimary.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: _kPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(Icons.edit, size: 16, color: _kPrimary),
              ),
              SizedBox(width: 8),
              Text('Text Field with Undo History',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: _kDarkText)),
            ],
          ),
          SizedBox(height: 4),
          Text(
            'Type, then use the undo/redo buttons or Ctrl+Z / Ctrl+Y',
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
          ),
          SizedBox(height: 12),
          TextField(
            controller: _controller1,
            focusNode: _focusNode1,
            undoController: _undoCtrl1,
            decoration: InputDecoration(
              labelText: 'Editable text',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: _kPrimary, width: 2),
              ),
              filled: true,
              fillColor: _kSurface,
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              _undoRedoButton(
                icon: Icons.undo,
                label: 'Undo',
                enabled: _canUndo1,
                color: _kUndoColor,
                onPressed: () {
                  _undoCtrl1.undo();
                  _addLog('→ UNDO on Field 1');
                  print('Undo triggered on field 1');
                },
              ),
              SizedBox(width: 8),
              _undoRedoButton(
                icon: Icons.redo,
                label: 'Redo',
                enabled: _canRedo1,
                color: _kRedoColor,
                onPressed: () {
                  _undoCtrl1.redo();
                  _addLog('→ REDO on Field 1');
                  print('Redo triggered on field 1');
                },
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _kHighlight,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'undoController param',
                  style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'monospace',
                      color: _kDarkText),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEditField2() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kAccent.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: _kAccent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(Icons.text_fields, size: 16, color: _kRedoColor),
              ),
              SizedBox(width: 8),
              Text('Multi-line with Undo Tracking',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: _kDarkText)),
            ],
          ),
          SizedBox(height: 4),
          Text(
            'A multiline TextField that also tracks undo/redo state',
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
          ),
          SizedBox(height: 12),
          TextField(
            controller: _controller2,
            focusNode: _focusNode2,
            undoController: _undoCtrl2,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Type multiple lines here...',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: _kRedoColor, width: 2),
              ),
              filled: true,
              fillColor: Color(0xFFFFF3E0),
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              _undoRedoButton(
                icon: Icons.undo,
                label: 'Undo',
                enabled: _canUndo2,
                color: _kUndoColor,
                onPressed: () {
                  _undoCtrl2.undo();
                  _addLog('→ UNDO on Field 2');
                  print('Undo triggered on field 2');
                },
              ),
              SizedBox(width: 8),
              _undoRedoButton(
                icon: Icons.redo,
                label: 'Redo',
                enabled: _canRedo2,
                color: _kRedoColor,
                onPressed: () {
                  _undoCtrl2.redo();
                  _addLog('→ REDO on Field 2');
                  print('Redo triggered on field 2');
                },
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'maxLines: 4',
                  style: TextStyle(
                      fontSize: 10,
                      fontFamily: 'monospace',
                      color: _kDarkText),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _undoRedoButton({
    required IconData icon,
    required String label,
    required bool enabled,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: enabled ? color.withOpacity(0.12) : Colors.grey[200],
          border: Border.all(
            color: enabled ? color.withOpacity(0.4) : Colors.grey[300]!,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Icon(icon,
                size: 16,
                color: enabled ? color : Colors.grey[400]),
            SizedBox(width: 4),
            Text(label,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: enabled ? color : Colors.grey[400])),
          ],
        ),
      ),
    );
  }

  Widget _buildUndoRedoStatePanel() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Undo/Redo State Monitor',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _kDarkText)),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _stateIndicator('Field 1', _canUndo1, _canRedo1)),
              SizedBox(width: 12),
              Expanded(child: _stateIndicator('Field 2', _canUndo2, _canRedo2)),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('UndoHistoryValue properties:',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: _kDarkText)),
                SizedBox(height: 4),
                Text(
                  '• canUndo → whether undo stack has entries\n'
                  '• canRedo → whether redo stack has entries\n'
                  '• The UndoHistoryController exposes these\n'
                  '  as onUndo and onRedo listeners',
                  style: TextStyle(
                      fontSize: 11, color: Colors.grey[700], height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stateIndicator(String label, bool canUndo, bool canRedo) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kHighlight,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: _kDarkText)),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _stateDot('Undo', canUndo, _kUndoColor),
              SizedBox(width: 12),
              _stateDot('Redo', canRedo, _kRedoColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stateDot(String label, bool active, Color color) {
    return Column(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: active ? color : Colors.grey[300],
            shape: BoxShape.circle,
            border: Border.all(
              color: active ? color.withOpacity(0.5) : Colors.grey[400]!,
              width: 2,
            ),
          ),
          child: active
              ? Icon(Icons.check, size: 12, color: Colors.white)
              : null,
        ),
        SizedBox(height: 3),
        Text(label,
            style: TextStyle(
                fontSize: 9,
                color: active ? color : Colors.grey[500])),
      ],
    );
  }

  Widget _buildEditLogPanel() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.list_alt, size: 18, color: _kPrimary),
              SizedBox(width: 8),
              Text('Edit Activity Log',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: _kDarkText)),
              Spacer(),
              GestureDetector(
                onTap: () => setState(() => _editLog.clear()),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('Clear',
                      style:
                          TextStyle(fontSize: 10, color: Colors.grey[600])),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          if (_editLog.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text('Type in the fields above to see activity',
                    style: TextStyle(
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[500])),
              ),
            )
          else
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(6),
              ),
              child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: _editLog.length,
                itemBuilder: (_, i) {
                  final isAction = _editLog[i].startsWith('→');
                  return Padding(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          margin: EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                            color: isAction ? _kRedoColor : Colors.grey[400],
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            _editLog[i],
                            style: TextStyle(
                              fontSize: 10.5,
                              fontFamily: isAction ? null : 'monospace',
                              color: isAction ? _kRedoColor : Colors.grey[700],
                              fontWeight: isAction
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
//  TAB 3  –  Undo / Redo Lab
// ═══════════════════════════════════════════════════════════

class _UndoRedoLabTab extends StatefulWidget {
  @override
  State<_UndoRedoLabTab> createState() => _UndoRedoLabTabState();
}

class _UndoRedoLabTabState extends State<_UndoRedoLabTab> {
  final _labController = TextEditingController(text: 'Flutter');
  final _labUndoCtrl = UndoHistoryController();
  final _labFocus = FocusNode();

  final List<_EditSnapshot> _timeline = [];
  int _snapshotCounter = 0;

  @override
  void initState() {
    super.initState();
    _timeline.add(_EditSnapshot(
      id: _snapshotCounter++,
      text: _labController.text,
      kind: _EditKind.initial,
    ));
    _labController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    // Debounce-like: only add snapshot on distinct values
    final current = _labController.text;
    if (_timeline.isEmpty || _timeline.last.text != current) {
      setState(() {
        _timeline.add(_EditSnapshot(
          id: _snapshotCounter++,
          text: current,
          kind: _EditKind.edit,
        ));
        if (_timeline.length > 25) _timeline.removeAt(0);
      });
    }
  }

  void _performUndo() {
    _labUndoCtrl.undo();
    setState(() {
      _timeline.add(_EditSnapshot(
        id: _snapshotCounter++,
        text: _labController.text,
        kind: _EditKind.undo,
      ));
    });
    print('Lab: undo performed → "${_labController.text}"');
  }

  void _performRedo() {
    _labUndoCtrl.redo();
    setState(() {
      _timeline.add(_EditSnapshot(
        id: _snapshotCounter++,
        text: _labController.text,
        kind: _EditKind.redo,
      ));
    });
    print('Lab: redo performed → "${_labController.text}"');
  }

  @override
  void dispose() {
    _labController.dispose();
    _labUndoCtrl.dispose();
    _labFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabEditorCard(),
          SizedBox(height: 14),
          _buildTimelineCard(),
          SizedBox(height: 14),
          _buildActionsShortcutsCard(),
          SizedBox(height: 14),
          _buildCustomOverrideCard(),
          SizedBox(height: 14),
          _buildBestPracticesCard(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildLabEditorCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kPrimary.withOpacity(0.35)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.science, size: 20, color: _kPrimary),
              SizedBox(width: 8),
              Text('Undo / Redo Lab',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _kDarkText)),
            ],
          ),
          SizedBox(height: 4),
          Text(
            'Edit text and observe the undo/redo timeline below',
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
          ),
          SizedBox(height: 12),
          TextField(
            controller: _labController,
            focusNode: _labFocus,
            undoController: _labUndoCtrl,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: _kPrimary, width: 2),
              ),
              filled: true,
              fillColor: _kSurface,
              prefixIcon: Icon(Icons.text_format, color: _kPrimary),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _labButton(Icons.undo, 'Undo', _kUndoColor, _performUndo),
              SizedBox(width: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '"${_labController.text}"',
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'monospace',
                      color: _kDarkText),
                ),
              ),
              SizedBox(width: 16),
              _labButton(Icons.redo, 'Redo', _kRedoColor, _performRedo),
            ],
          ),
        ],
      ),
    );
  }

  Widget _labButton(
      IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          border: Border.all(color: color.withOpacity(0.35)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color),
            SizedBox(width: 6),
            Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.timeline, size: 18, color: _kPrimary),
              SizedBox(width: 8),
              Text('Edit Timeline',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: _kDarkText)),
              Spacer(),
              Text('${_timeline.length} entries',
                  style: TextStyle(fontSize: 10, color: Colors.grey[500])),
            ],
          ),
          SizedBox(height: 12),
          ..._timeline.reversed.take(12).map((snap) {
            Color dotColor;
            IconData dotIcon;
            switch (snap.kind) {
              case _EditKind.initial:
                dotColor = Colors.grey[500]!;
                dotIcon = Icons.flag;
                break;
              case _EditKind.edit:
                dotColor = _kActionColor;
                dotIcon = Icons.edit;
                break;
              case _EditKind.undo:
                dotColor = _kUndoColor;
                dotIcon = Icons.undo;
                break;
              case _EditKind.redo:
                dotColor = _kRedoColor;
                dotIcon = Icons.redo;
                break;
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: dotColor.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(dotIcon, size: 12, color: dotColor),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      color: dotColor.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      snap.kind.name.toUpperCase(),
                      style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: dotColor),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '"${snap.text}"',
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: 'monospace',
                          color: _kDarkText),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text('#${snap.id}',
                      style:
                          TextStyle(fontSize: 9, color: Colors.grey[400])),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildActionsShortcutsCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kMuted),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Actions & Shortcuts Integration',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _kPrimary)),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kCodeBg,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '// Custom Shortcuts widget can override redo binding:\n'
              'Shortcuts(\n'
              '  shortcuts: {\n'
              '    SingleActivator(\n'
              '      LogicalKeyboardKey.keyY,\n'
              '      control: true,\n'
              '    ): RedoTextIntent(\n'
              '      SelectionChangedCause.keyboard,\n'
              '    ),\n'
              '  },\n'
              '  child: TextField(...),\n'
              ')',
              style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: _kDarkText,
                  height: 1.5),
            ),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kCodeBg,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '// Custom Action handler for redo:\n'
              'Actions(\n'
              '  actions: {\n'
              '    RedoTextIntent: CallbackAction<RedoTextIntent>(\n'
              '      onInvoke: (intent) {\n'
              '        print("Redo cause: \${intent.cause}");\n'
              '        return null;\n'
              '      },\n'
              '    ),\n'
              '  },\n'
              '  child: Focus(\n'
              '    child: Builder(...),\n'
              '  ),\n'
              ')',
              style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: _kDarkText,
                  height: 1.5),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'The Shortcuts widget maps key combinations to intents. '
            'The Actions widget maps intents to callbacks. '
            'RedoTextIntent fits naturally into this system.',
            style: TextStyle(fontSize: 11.5, color: Colors.grey[700], height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomOverrideCard() {
    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kAccent.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.tune, size: 18, color: _kRedoColor),
              SizedBox(width: 8),
              Text('Custom Redo Behaviors',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: _kDarkText)),
            ],
          ),
          SizedBox(height: 12),
          _customBehaviorItem(
            title: 'Confirmation before redo',
            desc: 'Show a dialog before applying redo to prevent accidental restores',
            icon: Icons.warning_amber,
            color: _kRedoColor,
          ),
          SizedBox(height: 8),
          _customBehaviorItem(
            title: 'Redo with analytics',
            desc: 'Track how often users use redo to improve UX',
            icon: Icons.analytics,
            color: _kUndoColor,
          ),
          SizedBox(height: 8),
          _customBehaviorItem(
            title: 'Grouped redo',
            desc: 'Redo multiple sequential edits as one atomic step',
            icon: Icons.layers,
            color: _kActionColor,
          ),
          SizedBox(height: 8),
          _customBehaviorItem(
            title: 'Redo with visual feedback',
            desc: 'Highlight restored text with a brief color flash',
            icon: Icons.highlight,
            color: _kIntentColor,
          ),
        ],
      ),
    );
  }

  Widget _customBehaviorItem({
    required String title,
    required String desc,
    required IconData icon,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 15, color: color),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _kDarkText)),
              SizedBox(height: 2),
              Text(desc,
                  style: TextStyle(
                      fontSize: 11, color: Colors.grey[600], height: 1.3)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBestPracticesCard() {
    final practices = <Map<String, String>>[
      {
        'title': 'Always pair UndoTextIntent and RedoTextIntent',
        'detail': 'Users expect both undo and redo to be available. '
            'If you customize one, customize the other.',
      },
      {
        'title': 'Use UndoHistoryController for state tracking',
        'detail': 'The controller provides canUndo and canRedo properties '
            'to enable/disable UI buttons appropriately.',
      },
      {
        'title': 'Preserve SelectionChangedCause fidelity',
        'detail': 'When creating RedoTextIntent manually, use the correct '
            'cause (keyboard vs toolbar) for analytics and accessibility.',
      },
      {
        'title': 'Test on all platforms',
        'detail': 'Redo shortcuts differ across platforms. Ensure your '
            'custom bindings do not conflict with system shortcuts.',
      },
      {
        'title': 'Consider undo grouping',
        'detail': 'Rapid edits may create many small undo entries. '
            'Group related edits for a better user experience.',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        border: Border.all(color: _kPrimary.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.school, size: 18, color: _kPrimary),
              SizedBox(width: 8),
              Text('Best Practices',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: _kPrimary)),
            ],
          ),
          SizedBox(height: 12),
          ...practices.asMap().entries.map((e) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: _kAccent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text('${e.key + 1}',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: _kDarkText)),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.value['title']!,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _kDarkText)),
                          SizedBox(height: 2),
                          Text(e.value['detail']!,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[600],
                                  height: 1.4)),
                        ],
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

// ── data models ─────────────────────────────────────────

enum _EditKind { initial, edit, undo, redo }

class _EditSnapshot {
  final int id;
  final String text;
  final _EditKind kind;
  const _EditSnapshot({
    required this.id,
    required this.text,
    required this.kind,
  });
}
