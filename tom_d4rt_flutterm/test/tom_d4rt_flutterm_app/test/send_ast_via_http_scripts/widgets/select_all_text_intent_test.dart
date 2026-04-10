// ignore_for_file: always_declare_return_types
import 'package:flutter/material.dart';

/// Deep visual test for SelectAllTextIntent.
///
/// SelectAllTextIntent is an Intent to select all the text in a text field.
/// It carries a SelectionChangedCause indicating what triggered the selection.
///
/// Demonstrates:
/// - Tab 1 (Anatomy): Constructor with cause parameter,
///   SelectionChangedCause enum explorer, inheritance from Intent
/// - Tab 2 (Live Demo): Real TextField with selection state tracking,
///   programmatic select-all via Actions.invoke, selection range display
/// - Tab 3 (Integration): Shortcuts/Actions binding pattern, related
///   text editing intents comparison, custom action registration

// ── Palette ──────────────────────────────────────────────────────────────────
const Color _kPrimary = Color(0xFF4527A0); // DeepPurple 800
const Color _kAccent = Color(0xFFFFFF8D); // Yellow A100
const Color _kSurface = Color(0xFF1B1A1E);
const Color _kCard = Color(0xFF2B2A2E);
const Color _kDimText = Color(0xFFAAAAAA);
const Color _kSubtle = Color(0xFF3B3A3E);
const Color _kHighlight = Color(0xFF42A5F5);
const Color _kSelected = Color(0xFF66BB6A);
const Color _kWarning = Color(0xFFEF5350);

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: _kSurface,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: _kPrimary,
        secondary: _kAccent,
        surface: _kSurface,
      ),
    ),
    home: const _SelectAllDemo(),
  );
}

class _SelectAllDemo extends StatefulWidget {
  const _SelectAllDemo();
  @override
  State<_SelectAllDemo> createState() => _SelectAllDemoState();
}

class _SelectAllDemoState extends State<_SelectAllDemo>
    with TickerProviderStateMixin {
  late final TabController _tabCtrl;

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
      appBar: AppBar(
        title: const Text(
          'SelectAllTextIntent',
          style: TextStyle(
            color: _kAccent,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: _kCard,
        bottom: TabBar(
          controller: _tabCtrl,
          indicatorColor: _kPrimary,
          labelColor: _kAccent,
          unselectedLabelColor: _kDimText,
          tabs: const [
            Tab(text: 'Anatomy'),
            Tab(text: 'Live Demo'),
            Tab(text: 'Integration'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: const [
          _AnatomyTab(),
          _LiveDemoTab(),
          _IntegrationTab(),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 1 — Anatomy
// ═══════════════════════════════════════════════════════════════════════════════

class _AnatomyTab extends StatefulWidget {
  const _AnatomyTab();
  @override
  State<_AnatomyTab> createState() => _AnatomyTabState();
}

class _AnatomyTabState extends State<_AnatomyTab>
    with AutomaticKeepAliveClientMixin {
  SelectionChangedCause _selectedCause = SelectionChangedCause.keyboard;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Constructor ──
          _buildSectionTitle('Constructor'),
          const SizedBox(height: 8),
          _buildCodeBlock(
            'const SelectAllTextIntent(\n'
            '  SelectionChangedCause cause,\n'
            ')',
          ),
          const SizedBox(height: 16),

          // ── Inheritance ──
          _buildSectionTitle('Inheritance'),
          const SizedBox(height: 8),
          _buildInheritanceChain(),
          const SizedBox(height: 16),

          // ── SelectionChangedCause explorer ──
          _buildSectionTitle('SelectionChangedCause Values'),
          const SizedBox(height: 8),
          _buildCauseExplorer(),
          const SizedBox(height: 16),

          // ── Selected cause detail ──
          _buildSectionTitle('Selected Cause Detail'),
          const SizedBox(height: 8),
          _buildCauseDetail(_selectedCause),
          const SizedBox(height: 16),

          // ── How it works ──
          _buildSectionTitle('How SelectAllTextIntent Works'),
          const SizedBox(height: 8),
          _buildFlowDiagram(),
          const SizedBox(height: 16),

          // ── Properties ──
          _buildSectionTitle('Properties'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              children: [
                _propRow('cause', 'SelectionChangedCause',
                    'Why the selection changed'),
                _propRow('runtimeType', 'Type',
                    'SelectAllTextIntent'),
              ],
            ),
          ),
          const SizedBox(height: 12),

          _buildInfoBanner(
            'SelectAllTextIntent is a simple Intent carrying only the cause. '
            'The matching Action (inside EditableText) calls '
            'textEditingValue = value.copyWith(selection: TextSelection('
            'baseOffset: 0, extentOffset: text.length)).',
          ),
        ],
      ),
    );
  }

  Widget _buildInheritanceChain() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSubtle),
      ),
      child: Column(
        children: [
          _chainRow('Intent', 'Base class for all intents', _kDimText, false),
          _chainConnector(),
          _chainRow(
            'SelectAllTextIntent',
            'Select all text with a cause',
            _kAccent,
            true,
          ),
        ],
      ),
    );
  }

  Widget _chainRow(String name, String desc, Color color, bool current) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: current ? color : Colors.transparent,
            border: Border.all(color: color, width: 1.5),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: current ? FontWeight.w700 : FontWeight.w500,
                  fontFamily: 'monospace',
                ),
              ),
              Text(desc,
                  style: const TextStyle(color: _kDimText, fontSize: 10)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _chainConnector() {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 1,
          height: 14,
          color: _kDimText.withValues(alpha: 0.4),
        ),
      ),
    );
  }

  Widget _buildCauseExplorer() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSubtle),
      ),
      child: Column(
        children: SelectionChangedCause.values.map((cause) {
          final selected = _selectedCause == cause;
          return GestureDetector(
            onTap: () => setState(() => _selectedCause = cause),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              margin: const EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                color: selected
                    ? _kPrimary.withValues(alpha: 0.25)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: selected ? _kAccent : Colors.transparent,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: selected ? _kAccent : _kSubtle,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    cause.name,
                    style: TextStyle(
                      color: selected ? _kAccent : Colors.white70,
                      fontSize: 12,
                      fontFamily: 'monospace',
                      fontWeight:
                          selected ? FontWeight.w700 : FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    _causeIndexLabel(cause),
                    style: TextStyle(
                      color: _kDimText.withValues(alpha: 0.6),
                      fontSize: 10,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String _causeIndexLabel(SelectionChangedCause cause) {
    return 'index ${cause.index}';
  }

  Widget _buildCauseDetail(SelectionChangedCause cause) {
    final desc = _causeDescription(cause);
    final icon = _causeIcon(cause);
    final color = _causeColor(cause);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SelectionChangedCause.${cause.name}',
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: const TextStyle(color: _kDimText, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _causeDescription(SelectionChangedCause cause) {
    switch (cause) {
      case SelectionChangedCause.tap:
        return 'User tapped on text — usually places cursor at tap position.';
      case SelectionChangedCause.doubleTap:
        return 'User double-tapped — typically selects a word.';
      case SelectionChangedCause.longPress:
        return 'User long-pressed — triggers selection mode on mobile.';
      case SelectionChangedCause.forcePress:
        return 'Force press (3D Touch) — deeper press triggers selection.';
      case SelectionChangedCause.keyboard:
        return 'Keyboard shortcut (Ctrl/Cmd+A) — the most common cause for select-all.';
      case SelectionChangedCause.toolbar:
        return 'Context menu or toolbar "Select All" button pressed.';
      case SelectionChangedCause.drag:
        return 'User is dragging selection handles to extend/shrink selection.';
      case SelectionChangedCause.stylusHandwriting:
        return 'Stylus handwriting gesture (Apple Pencil / stylus input).';
    }
  }

  IconData _causeIcon(SelectionChangedCause cause) {
    switch (cause) {
      case SelectionChangedCause.tap:
        return Icons.touch_app;
      case SelectionChangedCause.doubleTap:
        return Icons.ads_click;
      case SelectionChangedCause.longPress:
        return Icons.back_hand;
      case SelectionChangedCause.forcePress:
        return Icons.compress;
      case SelectionChangedCause.keyboard:
        return Icons.keyboard;
      case SelectionChangedCause.toolbar:
        return Icons.content_cut;
      case SelectionChangedCause.drag:
        return Icons.open_with;
      case SelectionChangedCause.stylusHandwriting:
        return Icons.edit;
    }
  }

  Color _causeColor(SelectionChangedCause cause) {
    switch (cause) {
      case SelectionChangedCause.keyboard:
        return _kAccent;
      case SelectionChangedCause.toolbar:
        return _kHighlight;
      case SelectionChangedCause.tap:
      case SelectionChangedCause.doubleTap:
        return _kSelected;
      default:
        return _kDimText;
    }
  }

  Widget _buildFlowDiagram() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSubtle),
      ),
      child: Column(
        children: [
          _flowNode('User presses Ctrl/Cmd + A', _kDimText),
          _flowConnector(),
          _flowNode('Shortcuts widget matches SingleActivator', _kPrimary),
          _flowConnector(),
          _flowNode(
            'Creates SelectAllTextIntent(cause: keyboard)',
            _kAccent,
          ),
          _flowConnector(),
          _flowNode('Actions widget finds _SelectAllAction', _kHighlight),
          _flowConnector(),
          _flowNode('Action.invoke() selects all text', _kSelected),
          _flowConnector(),
          _flowNode('TextSelection(0, text.length)', _kSelected),
        ],
      ),
    );
  }

  Widget _flowNode(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _flowConnector() {
    return Padding(
      padding: const EdgeInsets.only(left: 3),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 1,
          height: 10,
          color: _kDimText.withValues(alpha: 0.3),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 2 — Live Demo
// ═══════════════════════════════════════════════════════════════════════════════

class _LiveDemoTab extends StatefulWidget {
  const _LiveDemoTab();
  @override
  State<_LiveDemoTab> createState() => _LiveDemoTabState();
}

class _LiveDemoTabState extends State<_LiveDemoTab>
    with AutomaticKeepAliveClientMixin {
  late final TextEditingController _textCtrl;
  int _baseOffset = 0;
  int _extentOffset = 0;
  int _textLength = 0;
  int _selectAllCount = 0;
  final List<String> _eventLog = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _textCtrl = TextEditingController(
      text: 'Hello, this is sample text for demonstrating '
          'SelectAllTextIntent. Try selecting all text!',
    );
    _textCtrl.addListener(_onTextChanged);
    _textLength = _textCtrl.text.length;
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _baseOffset = _textCtrl.selection.baseOffset;
      _extentOffset = _textCtrl.selection.extentOffset;
      _textLength = _textCtrl.text.length;
    });
  }

  void _doSelectAll() {
    _textCtrl.selection = TextSelection(
      baseOffset: 0,
      extentOffset: _textCtrl.text.length,
    );
    setState(() {
      _selectAllCount++;
      _eventLog.insert(
        0,
        '#$_selectAllCount SelectAll → 0..${_textCtrl.text.length}',
      );
    });
  }

  void _doClearSelection() {
    _textCtrl.selection = TextSelection.collapsed(
      offset: _textCtrl.text.length,
    );
    setState(() {
      _eventLog.insert(0, 'Cleared → cursor at ${_textCtrl.text.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isAllSelected =
        _baseOffset == 0 && _extentOffset == _textLength && _textLength > 0;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── TextField ──
          _buildSectionTitle('Text Field'),
          const SizedBox(height: 8),
          TextField(
            controller: _textCtrl,
            maxLines: 3,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
            decoration: InputDecoration(
              fillColor: _kCard,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: isAllSelected ? _kSelected : _kSubtle,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: isAllSelected ? _kSelected : _kSubtle,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: _kAccent, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ── Selection state ──
          _buildSectionTitle('Selection State'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isAllSelected
                    ? _kSelected.withValues(alpha: 0.4)
                    : _kSubtle,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    _selectionStat('base', '$_baseOffset', _kHighlight),
                    const SizedBox(width: 8),
                    _selectionStat('extent', '$_extentOffset', _kHighlight),
                    const SizedBox(width: 8),
                    _selectionStat('length', '$_textLength', _kDimText),
                  ],
                ),
                const SizedBox(height: 8),
                _buildSelectionBar(),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: isAllSelected
                      ? _kSelected.withValues(alpha: 0.1)
                      : Colors.transparent,
                  child: Row(
                    children: [
                      Icon(
                        isAllSelected
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        size: 14,
                        color: isAllSelected ? _kSelected : _kDimText,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isAllSelected
                            ? 'ALL TEXT SELECTED'
                            : 'Partial or no selection',
                        style: TextStyle(
                          color: isAllSelected ? _kSelected : _kDimText,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Action buttons ──
          _buildSectionTitle('Programmatic Actions'),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _doSelectAll,
                  icon: const Icon(Icons.select_all, size: 16),
                  label: const Text(
                    'Select All',
                    style: TextStyle(fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kPrimary.withValues(alpha: 0.3),
                    foregroundColor: _kAccent,
                    side: BorderSide(color: _kAccent.withValues(alpha: 0.4)),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _doClearSelection,
                  icon: const Icon(Icons.deselect, size: 16),
                  label: const Text(
                    'Clear',
                    style: TextStyle(fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kWarning.withValues(alpha: 0.15),
                    foregroundColor: _kWarning,
                    side: BorderSide(color: _kWarning.withValues(alpha: 0.3)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ── Multi-field demo ──
          _buildSectionTitle('Multiple Fields'),
          const SizedBox(height: 8),
          _buildMultiFieldDemo(),
          const SizedBox(height: 16),

          // ── Event log ──
          if (_eventLog.isNotEmpty) ...[
            _buildSectionTitle('Action Log'),
            const SizedBox(height: 8),
            Container(
              constraints: const BoxConstraints(maxHeight: 120),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _kCard,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _kSubtle),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _eventLog.length,
                itemBuilder: (_, i) {
                  final msg = _eventLog[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Text(
                      msg,
                      style: TextStyle(
                        color: msg.contains('SelectAll')
                            ? _kSelected
                            : _kDimText,
                        fontSize: 10,
                        fontFamily: 'monospace',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
          const SizedBox(height: 12),

          _buildInfoBanner(
            'SelectAllTextIntent only works within the focused text editing '
            'widget. Each TextField/EditableText has its own Actions scope '
            'that handles the intent independently.',
          ),
        ],
      ),
    );
  }

  Widget _selectionStat(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        decoration: BoxDecoration(
          color: _kSurface,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(color: _kDimText, fontSize: 8),
            ),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionBar() {
    final fraction = _textLength > 0
        ? ((_extentOffset - _baseOffset).abs() / _textLength).clamp(0.0, 1.0)
        : 0.0;
    return Column(
      children: [
        Row(
          children: [
            const Text(
              'Selection coverage',
              style: TextStyle(color: _kDimText, fontSize: 9),
            ),
            const Spacer(),
            Text(
              '${(fraction * 100).toStringAsFixed(0)}%',
              style: const TextStyle(
                color: _kAccent,
                fontSize: 9,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: fraction,
            backgroundColor: _kSubtle,
            valueColor: AlwaysStoppedAnimation<Color>(
              fraction >= 1.0 ? _kSelected : _kPrimary,
            ),
            minHeight: 6,
          ),
        ),
      ],
    );
  }

  Widget _buildMultiFieldDemo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Each field has its own select-all scope:',
            style: TextStyle(color: _kDimText, fontSize: 11),
          ),
          const SizedBox(height: 8),
          _miniField('Name', 'Jane Doe'),
          const SizedBox(height: 6),
          _miniField('Email', 'jane@example.com'),
          const SizedBox(height: 6),
          _miniField('Notes', 'Press Ctrl+A in any field'),
        ],
      ),
    );
  }

  Widget _miniField(String label, String initial) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: const TextStyle(
              color: _kAccent,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: TextField(
            controller: TextEditingController(text: initial),
            style: const TextStyle(color: Colors.white70, fontSize: 12),
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: _kSubtle),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: _kSubtle),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// TAB 3 — Integration
// ═══════════════════════════════════════════════════════════════════════════════

class _IntegrationTab extends StatefulWidget {
  const _IntegrationTab();
  @override
  State<_IntegrationTab> createState() => _IntegrationTabState();
}

class _IntegrationTabState extends State<_IntegrationTab>
    with AutomaticKeepAliveClientMixin {
  String _selectedView = 'shortcuts';
  int _customSelectCount = 0;
  String _customStatus = 'No custom select-all yet';

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Shortcuts/Actions pattern ──
          _buildSectionTitle('Shortcuts → Intent → Action'),
          const SizedBox(height: 8),
          Row(
            children: [
              _viewChip('Shortcuts', 'shortcuts'),
              const SizedBox(width: 8),
              _viewChip('Action', 'action'),
              const SizedBox(width: 8),
              _viewChip('Custom', 'custom'),
            ],
          ),
          const SizedBox(height: 12),
          _buildViewDetail(),
          const SizedBox(height: 16),

          // ── Default keyboard shortcuts ──
          _buildSectionTitle('Default Keyboard Shortcuts'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCard,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kSubtle),
            ),
            child: Column(
              children: [
                _shortcutRow('Windows/Linux', 'Ctrl + A',
                    'SelectionChangedCause.keyboard'),
                _shortcutRow(
                    'macOS', 'Cmd + A', 'SelectionChangedCause.keyboard'),
                _shortcutRow('Context Menu', '"Select All"',
                    'SelectionChangedCause.toolbar'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Custom action demo ──
          _buildSectionTitle('Custom Action Handler'),
          const SizedBox(height: 8),
          Actions(
            actions: <Type, Action<Intent>>{
              SelectAllTextIntent: CallbackAction<SelectAllTextIntent>(
                onInvoke: (intent) {
                  setState(() {
                    _customSelectCount++;
                    _customStatus =
                        'Custom handler #$_customSelectCount '
                        '(cause: ${intent.cause.name})';
                  });
                  return null;
                },
              ),
            },
            child: Builder(
              builder: (innerContext) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _kCard,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _kSubtle),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'This section has a custom Actions widget wrapping it:',
                        style: TextStyle(color: _kDimText, fontSize: 11),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Actions.invoke<SelectAllTextIntent>(
                                  innerContext,
                                  const SelectAllTextIntent(
                                    SelectionChangedCause.keyboard,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    _kPrimary.withValues(alpha: 0.3),
                                foregroundColor: _kAccent,
                              ),
                              child: const Text(
                                'Invoke (keyboard)',
                                style: TextStyle(fontSize: 11),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Actions.invoke<SelectAllTextIntent>(
                                  innerContext,
                                  const SelectAllTextIntent(
                                    SelectionChangedCause.toolbar,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    _kHighlight.withValues(alpha: 0.2),
                                foregroundColor: _kHighlight,
                              ),
                              child: const Text(
                                'Invoke (toolbar)',
                                style: TextStyle(fontSize: 11),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: _kSurface,
                        child: Text(
                          _customStatus,
                          style: TextStyle(
                            color: _customSelectCount > 0
                                ? _kSelected
                                : _kDimText,
                            fontSize: 11,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // ── Related intents ──
          _buildSectionTitle('Related Text Editing Intents'),
          const SizedBox(height: 8),
          _buildRelatedIntents(),
          const SizedBox(height: 12),

          _buildInfoBanner(
            'You can override the default select-all behavior by providing '
            'a custom Action<SelectAllTextIntent> in an Actions widget above '
            'the text field. This is useful for custom editors that need '
            'non-standard selection logic.',
          ),
        ],
      ),
    );
  }

  Widget _viewChip(String label, String value) {
    final selected = _selectedView == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedView = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected
              ? _kPrimary.withValues(alpha: 0.3)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? _kAccent : _kDimText.withValues(alpha: 0.4),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? _kAccent : _kDimText,
            fontSize: 12,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildViewDetail() {
    switch (_selectedView) {
      case 'shortcuts':
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kSubtle),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Shortcuts Widget',
                style: TextStyle(
                  color: _kAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              _buildCodeBlock(
                'Shortcuts(\n'
                '  shortcuts: {\n'
                '    SingleActivator(\n'
                '      LogicalKeyboardKey.keyA,\n'
                '      control: true,\n'
                '    ): const SelectAllTextIntent(\n'
                '      SelectionChangedCause.keyboard,\n'
                '    ),\n'
                '  },\n'
                '  child: myTextField,\n'
                ')',
              ),
              const SizedBox(height: 8),
              const Text(
                'Maps Ctrl+A ↔ SelectAllTextIntent with keyboard cause.',
                style: TextStyle(color: _kDimText, fontSize: 10),
              ),
            ],
          ),
        );
      case 'action':
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kSubtle),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '_SelectAllAction (internal)',
                style: TextStyle(
                  color: _kAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              _buildCodeBlock(
                '// Inside EditableText:\n'
                'Actions(\n'
                '  actions: {\n'
                '    SelectAllTextIntent:\n'
                '      _SelectAllAction(this),\n'
                '  },\n'
                '  child: ...\n'
                ')\n'
                '\n'
                '// _SelectAllAction.invoke:\n'
                'editableText.selectAll(\n'
                '  intent.cause,\n'
                ');',
              ),
              const SizedBox(height: 8),
              const Text(
                'EditableText registers the default action that calls '
                'selectAll() with the intent\'s cause.',
                style: TextStyle(color: _kDimText, fontSize: 10),
              ),
            ],
          ),
        );
      default:
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kCard,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kSubtle),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Custom Override',
                style: TextStyle(
                  color: _kAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              _buildCodeBlock(
                'Actions(\n'
                '  actions: {\n'
                '    SelectAllTextIntent:\n'
                '      CallbackAction<SelectAllTextIntent>(\n'
                '        onInvoke: (intent) {\n'
                '          // Custom logic here\n'
                '          myCustomSelectAll(\n'
                '            intent.cause,\n'
                '          );\n'
                '          return null;\n'
                '        },\n'
                '      ),\n'
                '  },\n'
                '  child: myEditor,\n'
                ')',
              ),
              const SizedBox(height: 8),
              const Text(
                'Wrap any subtree with Actions to override the default '
                'behavior. The nearest ancestor Action wins.',
                style: TextStyle(color: _kDimText, fontSize: 10),
              ),
            ],
          ),
        );
    }
  }

  Widget _shortcutRow(String platform, String keys, String cause) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              platform,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: _kSurface,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: _kDimText.withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              keys,
              style: const TextStyle(
                color: _kAccent,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              cause,
              style: const TextStyle(
                color: _kDimText,
                fontSize: 9,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedIntents() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kSubtle),
      ),
      child: Column(
        children: [
          _relatedRow(
            'SelectAllTextIntent',
            'Select all text (THIS)',
            true,
          ),
          _relatedRow(
            'CopySelectionTextIntent',
            'Copy selected text to clipboard',
            false,
          ),
          _relatedRow(
            'PasteTextIntent',
            'Paste from clipboard',
            false,
          ),
          _relatedRow(
            'CutSelectionTextIntent',
            'Cut selection to clipboard',
            false,
          ),
          _relatedRow(
            'DeleteCharacterIntent',
            'Delete character forward/backward',
            false,
          ),
          _relatedRow(
            'UndoTextIntent',
            'Undo last text change',
            false,
          ),
          _relatedRow(
            'RedoTextIntent',
            'Redo undone text change',
            false,
          ),
        ],
      ),
    );
  }

  Widget _relatedRow(String name, String desc, bool current) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            current ? Icons.arrow_right : Icons.remove,
            size: 14,
            color: current ? _kAccent : _kDimText.withValues(alpha: 0.4),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: current ? _kAccent : Colors.white70,
                    fontSize: 10,
                    fontFamily: 'monospace',
                    fontWeight:
                        current ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
                Text(
                  desc,
                  style: const TextStyle(color: _kDimText, fontSize: 9),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Shared helpers
// ═══════════════════════════════════════════════════════════════════════════════

Widget _propRow(String name, String type, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            name,
            style: const TextStyle(
              color: _kAccent,
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          width: 120,
          child: Text(
            type,
            style: const TextStyle(
              color: _kHighlight,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(color: _kDimText, fontSize: 10),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _kSurface,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 11,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _buildInfoBanner(String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    color: _kPrimary.withValues(alpha: 0.08),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.lightbulb_outline, size: 14, color: _kAccent),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: _kDimText, fontSize: 11),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title) {
  return Text(
    title,
    style: const TextStyle(
      color: _kAccent,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
  );
}
