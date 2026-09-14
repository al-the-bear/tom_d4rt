// ignore_for_file: avoid_print
// D4rt deep-demo script: ExpandSelectionToLineBreakIntent
// Visual demonstration of the intent that expands the current text
// selection to the beginning or end of the current line.
//
// ExpandSelectionToLineBreakIntent is a DirectionalTextEditingIntent.
// When dispatched it grows the selection so that the extent reaches
// the line boundary (line start for forward=false, line end for
// forward=true) while the base stays fixed.  On all desktop
// platforms this is typically Shift+Home / Shift+End.
//
// Theme : Slate Blue (#37474F) / Ice Silver (#ECEFF1)
// Prefix: sl
import 'package:flutter/material.dart';

// ─────────────────────────── palette ───────────────────────────────
const Color _slPrimary = Color(0xFF37474F);
const Color _slLight = Color(0xFFECEFF1);
const Color _slAccent = Color(0xFF546E7A);
const Color _slMuted = Color(0xFF78909C);
const Color _slSurface = Color(0xFFCFD8DC);
const Color _slDark = Color(0xFF102027);
const Color _slHighlight = Color(0xFF80DEEA);

dynamic build(BuildContext context) {
  print('ExpandSelectionToLineBreakIntent  Deep Demo executing');

  // ================================================================
  // SECTION 1 — Banner
  // ================================================================
  print('=== Section 1: Banner ===');

  final banner = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [_slPrimary, _slAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: _slPrimary.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.format_align_left, color: Colors.white, size: 36.0),
            const SizedBox(width: 14.0),
            Expanded(
              child: Text(
                'ExpandSelectionTo\u200BLineBreakIntent',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Text(
          'A DirectionalTextEditingIntent that expands the current '
          'selection to the start or end of the current line.  The '
          'base stays fixed; only the extent moves to the nearest '
          'line boundary.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.92),
            fontSize: 15.0,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 7.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'package:flutter/widgets.dart  ·  DirectionalTextEditingIntent',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 13.0,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );

  // ================================================================
  // SECTION 2 — Inheritance chain
  // ================================================================
  print('=== Section 2: Inheritance chain ===');

  final chain = <Map<String, String>>[
    {'name': 'Intent', 'note': 'Base class for all intents'},
    {'name': 'DirectionalTextEditingIntent', 'note': 'Adds forward:bool'},
    {
      'name': 'ExpandSelectionToLineBreakIntent',
      'note': 'Selects to line start/end',
    },
  ];

  Widget slChainTile(Map<String, String> c, int idx) {
    final isTarget = idx == chain.length - 1;
    return Container(
      margin: EdgeInsets.only(left: idx * 20.0, top: 5.0, bottom: 5.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: isTarget ? _slLight : Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: isTarget ? _slAccent : _slMuted.withValues(alpha: 0.3),
          width: isTarget ? 2.0 : 1.0,
        ),
        boxShadow: isTarget
            ? [BoxShadow(color: _slPrimary.withValues(alpha: 0.15), blurRadius: 6.0, offset: const Offset(0.0, 3.0))]
            : [],
      ),
      child: Row(
        children: [
          Icon(
            isTarget ? Icons.star : Icons.circle_outlined,
            color: isTarget ? _slAccent : _slMuted,
            size: 18.0,
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(c['name']!, style: TextStyle(fontSize: 14.0, fontWeight: isTarget ? FontWeight.w700 : FontWeight.w500, color: isTarget ? _slPrimary : _slDark)),
                Text(c['note']!, style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final chainSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [for (int i = 0; i < chain.length; i++) slChainTile(chain[i], i)],
  );

  // ================================================================
  // SECTION 3 — Line boundary concept
  // ================================================================
  print('=== Section 3: Line boundary concept ===');

  final conceptSection = Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _slPrimary.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What is a "line break"?',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: _slDark),
        ),
        const SizedBox(height: 10.0),
        Text(
          'In Flutter text editing, a "line" can mean two things depending '
          'on context:\n\n'
          '1) A logical line — text between two newline characters (\\n).  '
          'If the text wraps visually, one logical line may span several '
          'visual lines.\n\n'
          '2) A visual (soft-wrapped) line — what the user sees as a '
          'single horizontal row of text.  The renderer breaks text at '
          'word boundaries when it reaches the edge of the container.\n\n'
          'ExpandSelectionToLineBreakIntent always targets the visual '
          'line boundary, not the logical one.  This means that if a '
          'long paragraph wraps across three visual lines, pressing '
          'Shift+End selects only to the end of the current visual line, '
          'not to the \\n at the end of the paragraph.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700, height: 1.55),
        ),
        const SizedBox(height: 14.0),
        // Visual diagram
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: _slLight,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: _slAccent.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Logical line', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: _slPrimary)),
                    const SizedBox(height: 4.0),
                    Container(
                      width: double.infinity,
                      height: 30.0,
                      decoration: BoxDecoration(
                        color: _slAccent.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Center(child: Text('One long paragraph \\n', style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: _slDark))),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: _slSurface.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: _slMuted.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Visual lines', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: _slPrimary)),
                    const SizedBox(height: 4.0),
                    for (final vl in ['One long para-', 'graph that wraps', 'across three rows'])
                      Container(
                        width: double.infinity,
                        height: 22.0,
                        margin: const EdgeInsets.only(bottom: 2.0),
                        decoration: BoxDecoration(
                          color: _slHighlight.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        child: Center(child: Text(vl, style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: _slDark))),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ================================================================
  // SECTION 4 — Forward expansion (to line end)
  // ================================================================
  print('=== Section 4: Forward expansion ===');

  final sampleText = <String>[
    'The quick brown fox jumps',
    'over the lazy dog today.',
    'Pack my box with five dozen',
    'liquor jugs and be happy.',
  ];

  Widget slLinePreview({
    required String title,
    required int caretLine,
    required int selLine,
    required int selStart,
    required int selEnd,
    required bool hasSelection,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _slPrimary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700, color: _slDark)),
          const SizedBox(height: 8.0),
          for (int li = 0; li < sampleText.length; li++)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              margin: const EdgeInsets.only(bottom: 1.0),
              decoration: BoxDecoration(
                color: hasSelection && li == selLine
                    ? _slHighlight.withValues(alpha: 0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 18.0,
                    child: Text('${li + 1}', style: TextStyle(fontSize: 10.0, color: Colors.grey.shade400, fontFamily: 'monospace')),
                  ),
                  const SizedBox(width: 4.0),
                  Expanded(
                    child: Text(sampleText[li], style: TextStyle(fontSize: 13.0, fontFamily: 'monospace', color: _slDark)),
                  ),
                  if (!hasSelection && li == caretLine)
                    Container(width: 2.0, height: 16.0, color: _slAccent),
                ],
              ),
            ),
          const SizedBox(height: 4.0),
          Text(
            hasSelection
                ? 'Selection: line ${selLine + 1} chars $selStart–$selEnd'
                : 'Caret at line ${caretLine + 1}',
            style: TextStyle(fontSize: 11.0, color: _slMuted, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  final forwardSection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _slLight.withValues(alpha: 0.4),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _slPrimary.withValues(alpha: 0.12)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'forward: true — select to line end',
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: _slDark),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Caret at line 2, character 10.  Dispatching with forward=true '
          'moves the extent to the end of line 2.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600, height: 1.4),
        ),
        const SizedBox(height: 8.0),
        slLinePreview(title: 'BEFORE', caretLine: 1, selLine: 0, selStart: 0, selEnd: 0, hasSelection: false),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_forward, color: _slAccent, size: 22.0),
                const SizedBox(width: 6.0),
                Text('Shift+End', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: _slAccent)),
              ],
            ),
          ),
        ),
        slLinePreview(title: 'AFTER', caretLine: 1, selLine: 1, selStart: 10, selEnd: 24, hasSelection: true),
      ],
    ),
  );

  // ================================================================
  // SECTION 5 — Backward expansion (to line start)
  // ================================================================
  print('=== Section 5: Backward expansion ===');

  final backwardSection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _slSurface.withValues(alpha: 0.25),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _slMuted.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'forward: false — select to line start',
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: _slDark),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Same caret at line 2, character 10.  Dispatching with '
          'forward=false moves the extent to character 0 of line 2.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600, height: 1.4),
        ),
        const SizedBox(height: 8.0),
        slLinePreview(title: 'BEFORE', caretLine: 1, selLine: 0, selStart: 0, selEnd: 0, hasSelection: false),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_back, color: _slMuted, size: 22.0),
                const SizedBox(width: 6.0),
                Text('Shift+Home', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: _slMuted)),
              ],
            ),
          ),
        ),
        slLinePreview(title: 'AFTER', caretLine: 1, selLine: 1, selStart: 0, selEnd: 10, hasSelection: true),
      ],
    ),
  );

  // ================================================================
  // SECTION 6 — Soft wrap vs hard break
  // ================================================================
  print('=== Section 6: Soft wrap vs hard break ===');

  final wrapData = <Map<String, dynamic>>[
    {
      'type': 'Hard line break (\\n)',
      'icon': Icons.keyboard_return,
      'visual': 'Line ends where the user typed Enter.',
      'behavior': 'ExpandSelectionToLineBreakIntent stops at the \\n.',
      'color': _slAccent,
    },
    {
      'type': 'Soft wrap (word boundary)',
      'icon': Icons.wrap_text,
      'visual': 'Renderer wraps text at container edge.',
      'behavior': 'Intent stops at the visual wrap point, not the \\n.',
      'color': _slMuted,
    },
    {
      'type': 'Forced wrap (overflow)',
      'icon': Icons.text_rotate_up,
      'visual': 'Renderer splits mid-word at max width.',
      'behavior':
          'Intent stops at the forced break.  The "line" boundary '
          'is wherever the text metric says the current line ends.',
      'color': _slPrimary,
    },
  ];

  Widget slWrapCard(Map<String, dynamic> w) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: (w['color'] as Color).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12.0),
        border: Border(left: BorderSide(color: w['color'] as Color, width: 4.0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(w['icon'] as IconData, color: w['color'] as Color, size: 24.0),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(w['type'] as String, style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: _slDark)),
                const SizedBox(height: 3.0),
                Text(w['visual'] as String, style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600)),
                const SizedBox(height: 3.0),
                Text(w['behavior'] as String, style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final wrapSection = Column(
    children: [for (final w in wrapData) slWrapCard(w)],
  );

  // ================================================================
  // SECTION 7 — Keyboard shortcuts table
  // ================================================================
  print('=== Section 7: Keyboard shortcuts ===');

  final shortcutRows = <Map<String, String>>[
    {'platform': 'macOS', 'toStart': '\u21E7+\u2318+\u2190', 'toEnd': '\u21E7+\u2318+\u2192', 'note': 'Cmd+Shift+Arrow'},
    {'platform': 'Windows', 'toStart': 'Shift+Home', 'toEnd': 'Shift+End', 'note': 'Standard'},
    {'platform': 'Linux', 'toStart': 'Shift+Home', 'toEnd': 'Shift+End', 'note': 'Same as Windows'},
    {'platform': 'Web', 'toStart': 'Shift+Home', 'toEnd': 'Shift+End', 'note': 'Follows host OS'},
  ];

  Widget slShortcutRow(Map<String, String> s, int idx) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: idx.isEven ? _slLight.withValues(alpha: 0.5) : Colors.white,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        children: [
          SizedBox(width: 70.0, child: Text(s['platform']!, style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: _slDark))),
          Expanded(child: Text(s['toStart']!, style: TextStyle(fontSize: 12.0, fontFamily: 'monospace', color: _slAccent))),
          Expanded(child: Text(s['toEnd']!, style: TextStyle(fontSize: 12.0, fontFamily: 'monospace', color: _slMuted))),
          SizedBox(width: 80.0, child: Text(s['note']!, style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500))),
        ],
      ),
    );
  }

  final shortcutSection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _slPrimary.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Platform keyboard shortcuts', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: _slDark)),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: _slPrimary.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            children: [
              SizedBox(width: 70.0, child: Text('Platform', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _slDark))),
              Expanded(child: Text('To Start', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _slDark))),
              Expanded(child: Text('To End', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _slDark))),
              SizedBox(width: 80.0, child: Text('Note', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _slDark))),
            ],
          ),
        ),
        const SizedBox(height: 4.0),
        for (int i = 0; i < shortcutRows.length; i++)
          Padding(padding: const EdgeInsets.only(bottom: 2.0), child: slShortcutRow(shortcutRows[i], i)),
      ],
    ),
  );

  // ================================================================
  // SECTION 8 — Dispatch flow
  // ================================================================
  print('=== Section 8: Dispatch flow ===');

  final steps = <Map<String, String>>[
    {'step': '1', 'title': 'Key combo matched', 'detail': 'Shift+End is received and mapped to ExpandSelectionToLineBreakIntent(forward: true).'},
    {'step': '2', 'title': 'Intent dispatched', 'detail': 'The Shortcuts widget calls Actions.invoke with the intent.'},
    {'step': '3', 'title': 'Line metrics queried', 'detail': 'The action asks the RenderEditable for the current line\'s start and end offsets.'},
    {'step': '4', 'title': 'Selection updated', 'detail': 'TextEditingController.selection is set with the base preserved and extent moved to the line boundary.'},
    {'step': '5', 'title': 'Repaint triggered', 'detail': 'RenderEditable repaints the selection highlight to cover the newly selected range.'},
  ];

  Widget slStepRow(Map<String, String> s, bool isLast) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 30.0, height: 30.0,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: _slPrimary),
              child: Center(child: Text(s['step']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13.0))),
            ),
            if (!isLast) Container(width: 2.0, height: 34.0, color: _slMuted.withValues(alpha: 0.3)),
          ],
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 4.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(color: _slLight.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(8.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s['title']!, style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: _slDark)),
                const SizedBox(height: 2.0),
                Text(s['detail']!, style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.4)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  final dispatchSection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.0), border: Border.all(color: _slPrimary.withValues(alpha: 0.15))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Dispatch flow', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: _slDark)),
        const SizedBox(height: 10.0),
        for (int i = 0; i < steps.length; i++) slStepRow(steps[i], i == steps.length - 1),
      ],
    ),
  );

  // ================================================================
  // SECTION 9 — Comparison: Line vs Document boundary
  // ================================================================
  print('=== Section 9: Line vs document boundary ===');

  final compRows = <Map<String, String>>[
    {
      'aspect': 'Granularity',
      'line': 'Current visual line',
      'document': 'Entire document',
    },
    {
      'aspect': 'Typical shortcut',
      'line': 'Shift+Home / Shift+End',
      'document': 'Ctrl+Shift+Home / End',
    },
    {
      'aspect': 'Selection range',
      'line': 'Tens of characters',
      'document': 'Potentially thousands',
    },
    {
      'aspect': 'Single-line field',
      'line': 'Identical behavior',
      'document': 'Identical behavior',
    },
    {
      'aspect': 'Multi-line field',
      'line': 'Stays on current line',
      'document': 'Crosses all lines',
    },
    {
      'aspect': 'Use case',
      'line': 'Select rest of line',
      'document': 'Select all below/above',
    },
  ];

  Widget slCompRow(Map<String, String> c, int idx) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: idx.isEven ? _slLight.withValues(alpha: 0.4) : Colors.white,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        children: [
          SizedBox(width: 80.0, child: Text(c['aspect']!, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: _slDark))),
          Expanded(child: Text(c['line']!, style: TextStyle(fontSize: 12.0, color: _slAccent))),
          Expanded(child: Text(c['document']!, style: TextStyle(fontSize: 12.0, color: _slMuted))),
        ],
      ),
    );
  }

  final compSection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.0), border: Border.all(color: _slPrimary.withValues(alpha: 0.15))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Line boundary vs document boundary', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: _slDark)),
        const SizedBox(height: 6.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(color: _slPrimary.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(6.0)),
          child: Row(
            children: [
              SizedBox(width: 80.0, child: Text('Aspect', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _slDark))),
              Expanded(child: Text('Line Break', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _slDark))),
              Expanded(child: Text('Document Boundary', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _slDark))),
            ],
          ),
        ),
        const SizedBox(height: 4.0),
        for (int i = 0; i < compRows.length; i++) Padding(padding: const EdgeInsets.only(bottom: 2.0), child: slCompRow(compRows[i], i)),
      ],
    ),
  );

  // ================================================================
  // SECTION 10 — Custom action patterns
  // ================================================================
  print('=== Section 10: Custom action patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Select entire logical line',
      'icon': Icons.text_snippet,
      'description': 'Override the default to select to the hard line break instead of the visual wrap point.',
      'code': 'CallbackAction<ExpandSelectionToLineBreakIntent>(\n'
          '  onInvoke: (intent) {\n'
          '    final text = controller.text;\n'
          '    final pos = controller.selection.baseOffset;\n'
          '    final end = intent.forward\n'
          '      ? text.indexOf(\'\\n\', pos).clamp(0, text.length)\n'
          '      : text.lastIndexOf(\'\\n\', pos - 1) + 1;\n'
          '    controller.selection = TextSelection(\n'
          '      baseOffset: pos,\n'
          '      extentOffset: end,\n'
          '    );\n'
          '    return null;\n'
          '  },\n'
          ')',
    },
    {
      'title': 'Toolbar "Select to End" button',
      'icon': Icons.touch_app,
      'description': 'Fire the intent programmatically when the user taps a toolbar icon.',
      'code': 'Actions.invoke<ExpandSelectionToLineBreakIntent>(\n'
          '  context,\n'
          '  const ExpandSelectionToLineBreakIntent(\n'
          '    forward: true,\n'
          '  ),\n'
          ');',
    },
    {
      'title': 'Block in read-only mode',
      'icon': Icons.lock,
      'description': 'Prevent line selection expansion when the field is in read-only viewing mode.',
      'code': 'CallbackAction<ExpandSelectionToLineBreakIntent>(\n'
          '  onInvoke: (intent) {\n'
          '    if (readOnly) return null;\n'
          '    return Actions.invoke(context, intent);\n'
          '  },\n'
          ')',
    },
  ];

  Widget slPatternCard(Map<String, dynamic> p) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: _slLight.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.0),
        border: Border(left: BorderSide(color: _slAccent, width: 4.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(p['icon'] as IconData, color: _slPrimary, size: 22.0),
              const SizedBox(width: 10.0),
              Expanded(child: Text(p['title'] as String, style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: _slDark))),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(p['description'] as String, style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700, height: 1.4)),
          const SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(color: _slDark.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(8.0)),
            child: Text(p['code'] as String, style: TextStyle(fontFamily: 'monospace', fontSize: 11.0, color: _slDark, height: 1.4)),
          ),
        ],
      ),
    );
  }

  final patternSection = Column(
    children: [for (final p in patterns) slPatternCard(p)],
  );

  // ================================================================
  // SECTION 11 — Edge cases
  // ================================================================
  print('=== Section 11: Edge cases ===');

  final edgeCases = <Map<String, String>>[
    {'case': 'Caret at line start, forward=false', 'result': 'No change — extent is already at the boundary.'},
    {'case': 'Caret at line end, forward=true', 'result': 'No change — extent is already at the line end.'},
    {'case': 'Empty line', 'result': 'Both directions produce a collapsed selection at offset 0 of that line.'},
    {'case': 'Single character line', 'result': 'Selects the one character in the appropriate direction.'},
    {'case': 'RTL text', 'result': 'forward still means toward higher offsets (logical end of line).'},
    {'case': 'Bidirectional text', 'result': 'Visual ordering may differ from logical; selection follows logical offsets.'},
  ];

  Widget slEdgeRow(Map<String, String> e) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: _slSurface.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: _slMuted.withValues(alpha: 0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: _slMuted, size: 18.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(e['case']!, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: _slDark)),
                const SizedBox(height: 2.0),
                Text(e['result']!, style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600, height: 1.35)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final edgeCaseSection = Column(
    children: [for (final e in edgeCases) slEdgeRow(e)],
  );

  // ================================================================
  // SECTION 12 — EditableText integration points
  // ================================================================
  print('=== Section 12: Integration with EditableText ===');

  final integrationParts = <Map<String, dynamic>>[
    {'component': 'Shortcuts', 'role': 'Maps Shift+Home/End to the intent', 'icon': Icons.keyboard},
    {'component': 'Actions', 'role': 'Resolves the intent to an action', 'icon': Icons.play_circle_outline},
    {'component': 'EditableTextState', 'role': 'Default action implementation', 'icon': Icons.text_fields},
    {'component': 'RenderEditable', 'role': 'Provides line metrics via getLineAtOffset()', 'icon': Icons.straighten},
    {'component': 'TextPainter', 'role': 'Computes visual line boundaries', 'icon': Icons.format_paint},
  ];

  Widget slIntRow(Map<String, dynamic> ip, int idx) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: idx.isEven ? _slLight.withValues(alpha: 0.5) : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: _slPrimary.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 36.0, height: 36.0,
            decoration: BoxDecoration(shape: BoxShape.circle, color: _slPrimary.withValues(alpha: 0.08)),
            child: Icon(ip['icon'] as IconData, color: _slAccent, size: 20.0),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ip['component'] as String, style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: _slDark)),
                Text(ip['role'] as String, style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600)),
              ],
            ),
          ),
          if (idx < integrationParts.length - 1)
            Icon(Icons.arrow_forward_ios, size: 12.0, color: _slMuted.withValues(alpha: 0.5)),
        ],
      ),
    );
  }

  final integrationSection = Column(
    children: [for (int i = 0; i < integrationParts.length; i++) slIntRow(integrationParts[i], i)],
  );

  // ================================================================
  // SECTION 13 — Summary
  // ================================================================
  print('=== Section 13: Summary ===');

  final bullets = <String>[
    'ExpandSelectionToLineBreakIntent selects from the caret to the visual line start or end.',
    'It extends DirectionalTextEditingIntent with a single "forward" boolean.',
    'On macOS: Cmd+Shift+Left/Right; on Win/Linux: Shift+Home/End.',
    'The "line" is the visual line, not the logical paragraph.',
    'Soft wraps, hard breaks, and forced breaks all define line boundaries.',
    'In a single-line field, line boundary equals document boundary.',
    'Custom actions can override to select to logical line breaks instead.',
    'RTL text uses logical offsets — forward always means a higher offset.',
  ];

  final summarySection = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_slPrimary.withValues(alpha: 0.08), _slLight.withValues(alpha: 0.5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _slPrimary.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: _slPrimary, size: 24.0),
            const SizedBox(width: 10.0),
            Text('Summary', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: _slDark)),
          ],
        ),
        const SizedBox(height: 14.0),
        for (final b in bullets)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 6.0, height: 6.0, margin: const EdgeInsets.only(top: 6.0, right: 10.0), decoration: const BoxDecoration(shape: BoxShape.circle, color: _slAccent)),
                Expanded(child: Text(b, style: TextStyle(fontSize: 13.0, color: _slDark, height: 1.45))),
              ],
            ),
          ),
      ],
    ),
  );

  print('ExpandSelectionToLineBreakIntent deep demo complete');

  // ================================================================
  // FINAL ASSEMBLY
  // ================================================================
  return SingleChildScrollView(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        banner,
        const SizedBox(height: 24.0),
        slSectionHeader('Inheritance Chain'),
        chainSection,
        const SizedBox(height: 24.0),
        slSectionHeader('Line Boundary Concept'),
        conceptSection,
        const SizedBox(height: 24.0),
        slSectionHeader('Forward: Select to Line End'),
        forwardSection,
        const SizedBox(height: 24.0),
        slSectionHeader('Backward: Select to Line Start'),
        backwardSection,
        const SizedBox(height: 24.0),
        slSectionHeader('Soft Wrap vs Hard Break'),
        wrapSection,
        const SizedBox(height: 24.0),
        slSectionHeader('Keyboard Shortcuts'),
        shortcutSection,
        const SizedBox(height: 24.0),
        slSectionHeader('Dispatch Flow'),
        dispatchSection,
        const SizedBox(height: 24.0),
        slSectionHeader('Line vs Document Boundary'),
        compSection,
        const SizedBox(height: 24.0),
        slSectionHeader('Custom Action Patterns'),
        patternSection,
        const SizedBox(height: 24.0),
        slSectionHeader('Edge Cases'),
        edgeCaseSection,
        const SizedBox(height: 24.0),
        slSectionHeader('EditableText Integration'),
        integrationSection,
        const SizedBox(height: 24.0),
        summarySection,
        const SizedBox(height: 32.0),
      ],
    ),
  );
}

// ───────────────────── shared section header ──────────────────────
Widget slSectionHeader(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Row(
      children: [
        Container(
          width: 4.0,
          height: 22.0,
          decoration: BoxDecoration(color: _slAccent, borderRadius: BorderRadius.circular(2.0)),
        ),
        const SizedBox(width: 10.0),
        Text(title, style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: _slDark)),
      ],
    ),
  );
}
