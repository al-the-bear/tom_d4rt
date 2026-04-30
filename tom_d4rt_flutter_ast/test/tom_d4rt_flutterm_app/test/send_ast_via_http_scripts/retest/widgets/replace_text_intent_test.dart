// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────
//  ReplaceTextIntent  –  Deep Visual Demo
//
//  Palette: Red 700 / Teal 400
//  Tabs  : Theory · Workshop · Scenarios
// ─────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  print('ReplaceTextIntent demo building');
  return _ReplaceTextIntentDemo();
}

// ── colour constants ────────────────────────────────────
const _kPrimary = Color(0xFFD32F2F); // Red 700
const _kAccent = Color(0xFF26A69A); // Teal 400
const _kSurface = Color(0xFFFFEBEE); // Red 50
const _kCardBg = Color(0xFFFFFFFF);
const _kDarkText = Color(0xFFB71C1C); // Red 900
const _kMuted = Color(0xFFEF9A9A); // Red 200
const _kCodeBg = Color(0xFFFFF3E0); // Orange 50
const _kHighlight = Color(0xFFE0F2F1); // Teal 50
const _kReplaceBg = Color(0xFFE8F5E9); // Green 50
const _kDeleteBg = Color(0xFFFFCDD2); // Red 100

class _ReplaceTextIntentDemo extends StatefulWidget {
  @override
  State<_ReplaceTextIntentDemo> createState() =>
      _ReplaceTextIntentDemoState();
}

class _ReplaceTextIntentDemoState extends State<_ReplaceTextIntentDemo>
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
        title: Text('ReplaceTextIntent',
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
          _ScenariosTab(),
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
          'What is ReplaceTextIntent?',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ReplaceTextIntent is an Intent subclass used by Flutter\'s '
                'text editing framework to express the desire to replace a '
                'range of text within a TextEditingValue. It carries the '
                'current editing state, the replacement string, the target '
                'range, and the cause of the change. The corresponding '
                'Action processes this intent to produce the new '
                'TextEditingValue.',
                style: TextStyle(
                    color: _kDarkText, fontSize: 14, height: 1.5),
              ),
              SizedBox(height: 12),
              _codeBlock(
                'class ReplaceTextIntent extends Intent {\n'
                '  const ReplaceTextIntent(\n'
                '    this.currentTextEditingValue,\n'
                '    this.replacementText,\n'
                '    this.replacementRange,\n'
                '    this.cause,\n'
                '  );\n'
                '\n'
                '  final TextEditingValue currentTextEditingValue;\n'
                '  final String replacementText;\n'
                '  final TextRange replacementRange;\n'
                '  final SelectionChangedCause cause;\n'
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _paramCard(
                'currentTextEditingValue',
                'TextEditingValue',
                'The complete text editing state before the replacement. '
                'Includes text, selection, and composing range.',
                _kPrimary,
              ),
              SizedBox(height: 8),
              _paramCard(
                'replacementText',
                'String',
                'The new text to insert at the replacement range. Can be '
                'empty (deletion), shorter, or longer than the range.',
                _kAccent,
              ),
              SizedBox(height: 8),
              _paramCard(
                'replacementRange',
                'TextRange',
                'The range within the current text that will be replaced. '
                'Defined by start and end offsets (inclusive start, '
                'exclusive end).',
                Color(0xFFFF7043),
              ),
              SizedBox(height: 8),
              _paramCard(
                'cause',
                'SelectionChangedCause',
                'Why the replacement happened. Used by text field callbacks '
                'to distinguish user actions from programmatic changes.',
                Color(0xFF5C6BC0),
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── SelectionChangedCause overview ──────────────
        _sectionCard(
          'SelectionChangedCause Values',
          Column(
            children: [
              _causeRow('tap', 'User tapped the text field',
                  Icons.touch_app, Color(0xFF2E7D32)),
              _causeRow('doubleTap', 'Double-tap to select a word',
                  Icons.done_all, Color(0xFF1565C0)),
              _causeRow('longPress', 'Long press for selection handles',
                  Icons.pan_tool, Color(0xFF6A1B9A)),
              _causeRow('forcePress', 'Force touch (3D Touch)',
                  Icons.compress, Color(0xFFE65100)),
              _causeRow('keyboard', 'Keyboard shortcut (Shift+arrows)',
                  Icons.keyboard, _kPrimary),
              _causeRow('toolbar', 'Toolbar button (cut/copy/paste)',
                  Icons.content_paste, _kAccent),
              _causeRow('drag', 'Dragging selection handles',
                  Icons.drag_indicator, Color(0xFF795548)),
              _causeRow('scribble', 'Apple Pencil scribble input',
                  Icons.edit, Color(0xFFFF6F00)),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Comparison table ────────────────────────────
        _sectionCard(
          'Text Intent Comparison',
          Table(
            border: TableBorder.all(color: Colors.grey.shade300),
            columnWidths: {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(4),
            },
            children: [
              _tableRow(
                ['Intent', 'Operation', 'Parameters'],
                isHeader: true,
              ),
              _tableRow([
                'ReplaceTextIntent',
                'Replace range',
                'currentValue, text, range, cause',
              ]),
              _tableRow([
                'InsertTextIntent',
                'Insert at cursor',
                'text only (inserts at selection)',
              ]),
              _tableRow([
                'DeleteTextIntent',
                'Delete from cursor',
                'direction (forward/backward)',
              ]),
              _tableRow([
                'DeleteByWordIntent',
                'Delete word',
                'direction (forward/backward)',
              ]),
              _tableRow([
                'SelectAllTextIntent',
                'Select all',
                'cause only (no text params)',
              ]),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── How TextRange works ─────────────────────────
        _sectionCard(
          'How TextRange Works',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TextRange defines a half-open interval [start, end) in the '
                'text. Characters at indices start through end-1 are included.',
                style: TextStyle(
                    color: _kDarkText, fontSize: 12, height: 1.4),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _kHighlight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Example: "Hello World"',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            fontFamily: 'monospace',
                            color: _kDarkText)),
                    SizedBox(height: 8),
                    _rangeVisual(
                        'Hello World', 0, 5, 'TextRange(0, 5) = "Hello"'),
                    SizedBox(height: 6),
                    _rangeVisual(
                        'Hello World', 6, 11, 'TextRange(6, 11) = "World"'),
                    SizedBox(height: 6),
                    _rangeVisual(
                        'Hello World', 5, 6, 'TextRange(5, 6) = " "'),
                  ],
                ),
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
              _bp(true,
                  'Always validate that replacementRange is within bounds '
                  'of currentTextEditingValue.text.length.'),
              _bp(true,
                  'Update the selection after replacement to position the '
                  'cursor at the end of the inserted text.'),
              _bp(true,
                  'Use SelectionChangedCause.keyboard for programmatic '
                  'replacements triggered by key bindings.'),
              _bp(false,
                  'Do NOT modify the text directly — always go through '
                  'the Intent/Action system for undo/redo support.'),
              _bp(false,
                  'Do NOT assume the replacement range covers the entire '
                  'selection — it may be a sub-range.'),
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
  final TextEditingController _textCtrl =
      TextEditingController(text: 'The quick brown fox jumps over the lazy dog.');
  int _replaceCount = 0;
  final List<_ReplaceEvent> _history = [];

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
  }

  void _performReplace(String label, TextRange range, String replacement,
      SelectionChangedCause cause) {
    final oldValue = _textCtrl.value;
    final oldText = oldValue.text;

    // Validate range
    if (range.start < 0 || range.end > oldText.length || range.start > range.end) {
      print('Invalid range: $range for text of length ${oldText.length}');
      return;
    }

    // Build the intent (simulate what Flutter does internally)
    final intent = ReplaceTextIntent(
      oldValue,
      replacement,
      range,
      cause,
    );

    print('ReplaceTextIntent: replace "${range.textInside(oldText)}" '
        '(${range.start}..${range.end}) with "$replacement" cause=$cause');

    // Apply the replacement
    final before = oldText.substring(0, range.start);
    final after = oldText.substring(range.end);
    final newText = '$before$replacement$after';
    final cursorPos = range.start + replacement.length;

    setState(() {
      _replaceCount++;
      _textCtrl.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: cursorPos),
      );
      _history.insert(
        0,
        _ReplaceEvent(
          id: _replaceCount,
          label: label,
          oldFragment: intent.replacementRange.textInside(oldText),
          newFragment: intent.replacementText,
          range: range,
          cause: cause,
          resultText: newText,
        ),
      );
      if (_history.length > 20) _history.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    final text = _textCtrl.text;
    final sel = _textCtrl.selection;
    final hasSelection = sel.isValid && !sel.isCollapsed && sel.end <= text.length;

    return Row(
      children: [
        // Left: editor + actions
        Expanded(
          flex: 3,
          child: ListView(
            padding: EdgeInsets.all(14),
            children: [
              // ── Text editor ───────────────────────────
              _sectionCard(
                'Text Editor',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _textCtrl,
                      maxLines: 4,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        hintText: 'Type or edit text here...',
                        isDense: true,
                        contentPadding: EdgeInsets.all(12),
                      ),
                      style: TextStyle(
                          fontSize: 14, fontFamily: 'monospace', height: 1.5),
                      onChanged: (_) => setState(() {}),
                    ),
                    SizedBox(height: 8),
                    // Live info bar
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        _infoPill('Length', '${text.length}', _kPrimary),
                        _infoPill(
                          'Selection',
                          hasSelection
                              ? '${sel.start}..${sel.end}'
                              : sel.isValid
                                  ? 'cursor@${sel.baseOffset}'
                                  : 'none',
                          _kAccent,
                        ),
                        if (hasSelection)
                          _infoPill(
                              'Selected',
                              '"${sel.textInside(text)}"',
                              Color(0xFFFF7043)),
                        _infoPill('Replaces', '$_replaceCount',
                            Color(0xFF5C6BC0)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),

              // ── Quick replace actions ─────────────────
              _sectionCard(
                'Predefined Replace Operations',
                Column(
                  children: [
                    _actionButton(
                      'Replace first word',
                      'Replaces "The" with "A"',
                      Icons.find_replace,
                      _kPrimary,
                      () {
                        final idx = text.indexOf('The');
                        if (idx >= 0) {
                          _performReplace(
                            'Replace "The"→"A"',
                            TextRange(start: idx, end: idx + 3),
                            'A',
                            SelectionChangedCause.keyboard,
                          );
                        }
                      },
                    ),
                    SizedBox(height: 6),
                    _actionButton(
                      'Replace "fox" with "cat"',
                      'Finds and replaces the word fox',
                      Icons.pets,
                      _kAccent,
                      () {
                        final idx = text.indexOf('fox');
                        if (idx >= 0) {
                          _performReplace(
                            'Replace "fox"→"cat"',
                            TextRange(start: idx, end: idx + 3),
                            'cat',
                            SelectionChangedCause.keyboard,
                          );
                        }
                      },
                    ),
                    SizedBox(height: 6),
                    _actionButton(
                      'Uppercase selection',
                      'Replaces selected text with its uppercase form',
                      Icons.text_fields,
                      Color(0xFF6A1B9A),
                      hasSelection
                          ? () {
                              final fragment = sel.textInside(text);
                              _performReplace(
                                'Uppercase selection',
                                TextRange(start: sel.start, end: sel.end),
                                fragment.toUpperCase(),
                                SelectionChangedCause.toolbar,
                              );
                            }
                          : null,
                    ),
                    SizedBox(height: 6),
                    _actionButton(
                      'Wrap selection in brackets',
                      'Surrounds selected text with [...]',
                      Icons.code,
                      Color(0xFFE65100),
                      hasSelection
                          ? () {
                              final fragment = sel.textInside(text);
                              _performReplace(
                                'Wrap in [...]',
                                TextRange(start: sel.start, end: sel.end),
                                '[$fragment]',
                                SelectionChangedCause.toolbar,
                              );
                            }
                          : null,
                    ),
                    SizedBox(height: 6),
                    _actionButton(
                      'Delete selection',
                      'Replaces selected text with empty string',
                      Icons.delete_outline,
                      Color(0xFFC62828),
                      hasSelection
                          ? () {
                              _performReplace(
                                'Delete selection',
                                TextRange(start: sel.start, end: sel.end),
                                '',
                                SelectionChangedCause.toolbar,
                              );
                            }
                          : null,
                    ),
                    SizedBox(height: 6),
                    _actionButton(
                      'Append " — END"',
                      'Inserts text at the very end (range at end)',
                      Icons.add_circle_outline,
                      Color(0xFF2E7D32),
                      () {
                        _performReplace(
                          'Append " — END"',
                          TextRange(start: text.length, end: text.length),
                          ' — END',
                          SelectionChangedCause.keyboard,
                        );
                      },
                    ),
                    SizedBox(height: 6),
                    _actionButton(
                      'Reset text',
                      'Restore original sentence',
                      Icons.refresh,
                      Colors.grey,
                      () {
                        setState(() {
                          _textCtrl.text =
                              'The quick brown fox jumps over the lazy dog.';
                          _history.clear();
                          _replaceCount = 0;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),

              // ── Custom range replace ──────────────────
              _CustomRangeReplace(
                textLength: text.length,
                onReplace: (start, end, replacement) {
                  _performReplace(
                    'Custom range ($start..$end)',
                    TextRange(start: start, end: end),
                    replacement,
                    SelectionChangedCause.keyboard,
                  );
                },
              ),
              SizedBox(height: 24),
            ],
          ),
        ),

        // Right: history log
        Container(
          width: 280,
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
                    Text('Replace History',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: _kDarkText)),
                    Spacer(),
                    GestureDetector(
                      onTap: () => setState(() {
                        _history.clear();
                        _replaceCount = 0;
                      }),
                      child: Icon(Icons.delete_sweep,
                          size: 16, color: _kMuted),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _history.isEmpty
                    ? Center(
                        child: Text(
                          'Perform replace operations\nto see history here',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: _kMuted, fontSize: 12),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(6),
                        itemCount: _history.length,
                        itemBuilder: (_, i) {
                          final e = _history[i];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 4),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: _kPrimary.withOpacity(0.03),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    color: _kPrimary.withOpacity(0.12)),
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
                                          color: _kPrimary,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text('#${e.id}',
                                            style: TextStyle(
                                                fontSize: 9,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white)),
                                      ),
                                      SizedBox(width: 6),
                                      Expanded(
                                        child: Text(e.label,
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                                color: _kDarkText)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 1),
                                        decoration: BoxDecoration(
                                          color: _kDeleteBg,
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        child: Text(
                                          e.oldFragment.isEmpty
                                              ? '(empty)'
                                              : '"${_truncate(e.oldFragment, 12)}"',
                                          style: TextStyle(
                                              fontSize: 9,
                                              fontFamily: 'monospace',
                                              color: _kPrimary),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: Icon(Icons.arrow_forward,
                                            size: 10, color: _kMuted),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4, vertical: 1),
                                          decoration: BoxDecoration(
                                            color: _kReplaceBg,
                                            borderRadius:
                                                BorderRadius.circular(3),
                                          ),
                                          child: Text(
                                            e.newFragment.isEmpty
                                                ? '(deleted)'
                                                : '"${_truncate(e.newFragment, 12)}"',
                                            style: TextStyle(
                                                fontSize: 9,
                                                fontFamily: 'monospace',
                                                color: Color(0xFF2E7D32)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'range: ${e.range.start}..${e.range.end}  cause: ${e.cause.name}',
                                    style: TextStyle(
                                        fontFamily: 'monospace',
                                        fontSize: 8,
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
    );
  }

  Widget _actionButton(String title, String subtitle, IconData icon,
      Color color, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: onTap == null
              ? Colors.grey.shade100
              : color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: onTap == null
                ? Colors.grey.shade300
                : color.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Icon(icon,
                size: 18,
                color: onTap == null ? Colors.grey.shade400 : color),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: onTap == null
                              ? Colors.grey.shade500
                              : _kDarkText)),
                  Text(subtitle,
                      style: TextStyle(
                          fontSize: 10,
                          color: onTap == null
                              ? Colors.grey.shade400
                              : _kMuted)),
                ],
              ),
            ),
            Icon(Icons.play_arrow,
                size: 16,
                color: onTap == null ? Colors.grey.shade400 : color),
          ],
        ),
      ),
    );
  }

  Widget _infoPill(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: '$label: ',
            style: TextStyle(fontSize: 10, color: _kMuted),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: color),
          ),
        ]),
      ),
    );
  }
}

class _ReplaceEvent {
  final int id;
  final String label;
  final String oldFragment;
  final String newFragment;
  final TextRange range;
  final SelectionChangedCause cause;
  final String resultText;
  _ReplaceEvent({
    required this.id,
    required this.label,
    required this.oldFragment,
    required this.newFragment,
    required this.range,
    required this.cause,
    required this.resultText,
  });
}

// ── Custom Range Replace Widget ─────────────────────────
class _CustomRangeReplace extends StatefulWidget {
  final int textLength;
  final void Function(int start, int end, String replacement) onReplace;
  const _CustomRangeReplace({
    required this.textLength,
    required this.onReplace,
  });

  @override
  State<_CustomRangeReplace> createState() => _CustomRangeReplaceState();
}

class _CustomRangeReplaceState extends State<_CustomRangeReplace> {
  final _startCtrl = TextEditingController(text: '0');
  final _endCtrl = TextEditingController(text: '5');
  final _replCtrl = TextEditingController(text: 'REPLACED');

  @override
  void dispose() {
    _startCtrl.dispose();
    _endCtrl.dispose();
    _replCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _sectionCard(
      'Custom Range Replace',
      Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _startCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Start',
                    labelStyle: TextStyle(fontSize: 11),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6)),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  ),
                  style: TextStyle(
                      fontSize: 12, fontFamily: 'monospace'),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _endCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'End',
                    labelStyle: TextStyle(fontSize: 11),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6)),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  ),
                  style: TextStyle(
                      fontSize: 12, fontFamily: 'monospace'),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: TextField(
                  controller: _replCtrl,
                  decoration: InputDecoration(
                    labelText: 'Replacement',
                    labelStyle: TextStyle(fontSize: 11),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6)),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  ),
                  style: TextStyle(
                      fontSize: 12, fontFamily: 'monospace'),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Text length: ${widget.textLength}',
                style: TextStyle(
                    fontSize: 10, fontFamily: 'monospace', color: _kMuted),
              ),
              Spacer(),
              SizedBox(
                height: 32,
                child: ElevatedButton.icon(
                  onPressed: () {
                    final s = int.tryParse(_startCtrl.text) ?? 0;
                    final e = int.tryParse(_endCtrl.text) ?? 0;
                    if (s >= 0 && e <= widget.textLength && s <= e) {
                      widget.onReplace(s, e, _replCtrl.text);
                    }
                  },
                  icon: Icon(Icons.find_replace, size: 14),
                  label: Text('Apply', style: TextStyle(fontSize: 11)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kPrimary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 12),
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

// ═══════════════════════════════════════════════════════════
//  TAB 3  –  Scenarios
// ═══════════════════════════════════════════════════════════
class _ScenariosTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // ── Scenario 1: Autocomplete ────────────────────
        _sectionCard(
          'Scenario 1: Autocomplete Insertion',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'When a user selects an autocomplete suggestion, the partial '
                'text they typed is replaced with the full completion. The '
                'replacementRange covers the partial keyword.',
                style: TextStyle(
                    fontSize: 12, color: _kDarkText, height: 1.4),
              ),
              SizedBox(height: 10),
              _beforeAfterVisual(
                before: 'Send email to us',
                after: 'Send email to user@example.com',
                rangeStart: 14,
                rangeEnd: 16,
                replacement: 'user@example.com',
                cause: 'toolbar',
              ),
              SizedBox(height: 10),
              _codeBlock(
                'final intent = ReplaceTextIntent(\n'
                '  controller.value,           // current state\n'
                '  \'user@example.com\',         // completion\n'
                '  TextRange(start: 14, end: 16), // "us"\n'
                '  SelectionChangedCause.toolbar,\n'
                ');\n'
                'Actions.invoke(context, intent);',
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Scenario 2: Spell correction ────────────────
        _sectionCard(
          'Scenario 2: Spell Correction',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Spell-check finds a misspelled word and offers a correction. '
                'A ReplaceTextIntent targets just the misspelled range, '
                'preserving the rest of the sentence.',
                style: TextStyle(
                    fontSize: 12, color: _kDarkText, height: 1.4),
              ),
              SizedBox(height: 10),
              _beforeAfterVisual(
                before: 'The recieve date is tomorrow',
                after: 'The receive date is tomorrow',
                rangeStart: 4,
                rangeEnd: 11,
                replacement: 'receive',
                cause: 'keyboard',
              ),
              SizedBox(height: 10),
              _codeBlock(
                'final intent = ReplaceTextIntent(\n'
                '  controller.value,\n'
                '  \'receive\',                  // corrected\n'
                '  TextRange(start: 4, end: 11), // "recieve"\n'
                '  SelectionChangedCause.keyboard,\n'
                ');',
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Scenario 3: Template variable ───────────────
        _sectionCard(
          'Scenario 3: Template Variable Expansion',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'A template system finds placeholders like \${name} and '
                'replaces them with actual values. Each placeholder becomes '
                'a separate ReplaceTextIntent.',
                style: TextStyle(
                    fontSize: 12, color: _kDarkText, height: 1.4),
              ),
              SizedBox(height: 10),
              _beforeAfterVisual(
                before: 'Hello, \${name}! Welcome to \${app}.',
                after: 'Hello, Alice! Welcome to Flutter.',
                rangeStart: 7,
                rangeEnd: 14,
                replacement: 'Alice',
                cause: 'keyboard',
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _kHighlight,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _kAccent.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Multi-step replacement:',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                            color: _kAccent)),
                    SizedBox(height: 6),
                    _stepRow(1, 'Find \${name} at range (7, 14)'),
                    _stepRow(2, 'Replace with "Alice" → cursor at 12'),
                    _stepRow(3, 'Find \${app} at range (25, 31)'),
                    _stepRow(4, 'Replace with "Flutter" → cursor at 32'),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Scenario 4: Markdown formatting ─────────────
        _sectionCard(
          'Scenario 4: Markdown Bold Formatting',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'A rich text editor wraps selected text in markdown bold '
                'syntax (**...**). The replacement range covers the '
                'selection, and the replacement text includes the markers.',
                style: TextStyle(
                    fontSize: 12, color: _kDarkText, height: 1.4),
              ),
              SizedBox(height: 10),
              _beforeAfterVisual(
                before: 'This is important text here',
                after: 'This is **important** text here',
                rangeStart: 8,
                rangeEnd: 17,
                replacement: '**important**',
                cause: 'toolbar',
              ),
              SizedBox(height: 10),
              _codeBlock(
                '// Wrap selection in bold markers\n'
                'final selected = selection.textInside(text);\n'
                'final intent = ReplaceTextIntent(\n'
                '  controller.value,\n'
                '  \'**\$selected**\',\n'
                '  TextRange(start: sel.start, end: sel.end),\n'
                '  SelectionChangedCause.toolbar,\n'
                ');',
              ),
            ],
          ),
        ),
        SizedBox(height: 14),

        // ── Scenario 5: Multi-cursor / batch ────────────
        _sectionCard(
          'Scenario 5: Find and Replace All',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'A find-and-replace-all operation issues multiple '
                'ReplaceTextIntents in reverse order (from end to start) '
                'to avoid invalidating earlier ranges.',
                style: TextStyle(
                    fontSize: 12, color: _kDarkText, height: 1.4),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _kCodeBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _matchHighlight('The cat sat on the cat mat', 'cat',
                        [4, 20]),
                    SizedBox(height: 8),
                    Text('Matches found at indices: 4, 20',
                        style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 10,
                            color: _kMuted)),
                    SizedBox(height: 4),
                    Text('Process in REVERSE order to preserve indices:',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                            color: _kDarkText)),
                    SizedBox(height: 4),
                    _stepRow(1, 'Replace range (20, 23) → "dog"'),
                    _stepRow(2, 'Replace range (4, 7) → "dog"'),
                    SizedBox(height: 6),
                    Text('Result: "The dog sat on the dog mat"',
                        style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2E7D32))),
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
}

// ═══════════════════════════════════════════════════════════
//  Shared helpers
// ═══════════════════════════════════════════════════════════

String _truncate(String s, int max) {
  if (s.length <= max) return s;
  return '${s.substring(0, max)}...';
}

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
      border: Border.all(color: _kPrimary.withOpacity(0.1)),
    ),
    child: Text(code,
        style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: _kDarkText,
            height: 1.5)),
  );
}

Widget _paramCard(
    String name, String type, String desc, Color color) {
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
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
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
                      fontSize: 11, color: _kDarkText, height: 1.3)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _causeRow(
    String name, String desc, IconData icon, Color color) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        SizedBox(width: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(name,
              style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: color)),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(desc,
              style: TextStyle(fontSize: 11, color: _kMuted)),
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
              color: isHeader ? _kPrimary : _kDarkText,
            )),
      );
    }).toList(),
  );
}

Widget _rangeVisual(
    String text, int start, int end, String label) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          for (int i = 0; i < text.length; i++)
            Container(
              width: 18,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: (i >= start && i < end)
                    ? _kPrimary.withOpacity(0.15)
                    : Colors.transparent,
                border: Border.all(
                  color: (i >= start && i < end)
                      ? _kPrimary.withOpacity(0.4)
                      : Colors.grey.shade300,
                ),
              ),
              child: Text(text[i],
                  style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      fontWeight: (i >= start && i < end)
                          ? FontWeight.w700
                          : FontWeight.w400,
                      color: (i >= start && i < end)
                          ? _kPrimary
                          : _kDarkText)),
            ),
        ],
      ),
      SizedBox(height: 2),
      Text(label,
          style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 9,
              color: _kAccent)),
    ],
  );
}

Widget _beforeAfterVisual({
  required String before,
  required String after,
  required int rangeStart,
  required int rangeEnd,
  required String replacement,
  required String cause,
}) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Before
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text('Before:',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: _kPrimary)),
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: _kDarkText),
                  children: [
                    TextSpan(text: before.substring(0, rangeStart)),
                    TextSpan(
                      text: before.substring(rangeStart, rangeEnd),
                      style: TextStyle(
                        backgroundColor: _kDeleteBg,
                        fontWeight: FontWeight.w700,
                        color: _kPrimary,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    TextSpan(text: before.substring(rangeEnd)),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        // After
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text('After:',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2E7D32))),
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: _kDarkText),
                  children: [
                    TextSpan(text: after.substring(0, rangeStart)),
                    TextSpan(
                      text: replacement,
                      style: TextStyle(
                        backgroundColor: _kReplaceBg,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    TextSpan(
                        text: after.substring(rangeStart + replacement.length)),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        // Meta
        Row(
          children: [
            Text('range: ($rangeStart, $rangeEnd)',
                style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 9,
                    color: _kMuted)),
            SizedBox(width: 10),
            Text('cause: $cause',
                style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 9,
                    color: _kMuted)),
          ],
        ),
      ],
    ),
  );
}

Widget _matchHighlight(String text, String match, List<int> indices) {
  final spans = <TextSpan>[];
  int pos = 0;
  for (final idx in indices) {
    if (pos < idx) {
      spans.add(TextSpan(text: text.substring(pos, idx)));
    }
    spans.add(TextSpan(
      text: text.substring(idx, idx + match.length),
      style: TextStyle(
        backgroundColor: _kDeleteBg,
        fontWeight: FontWeight.w700,
        color: _kPrimary,
      ),
    ));
    pos = idx + match.length;
  }
  if (pos < text.length) {
    spans.add(TextSpan(text: text.substring(pos)));
  }
  return RichText(
    text: TextSpan(
      style: TextStyle(
          fontFamily: 'monospace', fontSize: 12, color: _kDarkText),
      children: spans,
    ),
  );
}

Widget _stepRow(int num, String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 3),
    child: Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: _kAccent.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text('$num',
              style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: _kAccent)),
        ),
        SizedBox(width: 6),
        Expanded(
          child: Text(text,
              style: TextStyle(fontSize: 11, color: _kDarkText)),
        ),
      ],
    ),
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
