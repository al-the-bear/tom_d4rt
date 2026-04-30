// ignore_for_file: avoid_print
// D4rt deep-demo script: ExtendSelectionToDocumentBoundaryIntent
// Visual demonstration of the intent that extends a text selection's
// extent offset all the way to the start or end of the document,
// while the base offset stays put.
//
// Key distinction from ExpandSelectionToDocumentBoundaryIntent:
// "Extend" moves only the extent.  "Expand" may normalise the
// selection so that both base and extent reach the boundary.
//
// Theme : Burnt Sienna (#8D3E2F) / Parchment (#FFF3E0)
// Prefix: db
import 'package:flutter/material.dart';

// ─────────────────────── palette ───────────────────────────────────
const Color _dbPrimary = Color(0xFF8D3E2F);
const Color _dbLight = Color(0xFFFFF3E0);
const Color _dbAccent = Color(0xFFBF5B3E);
const Color _dbMuted = Color(0xFFBCAAA4);
const Color _dbSurface = Color(0xFFD7CCC8);
const Color _dbDark = Color(0xFF3E2723);
const Color _dbHighlight = Color(0xFFFFAB91);

dynamic build(BuildContext context) {
  print('ExtendSelectionToDocumentBoundaryIntent  Deep Demo executing');

  // ================================================================
  // SECTION 1 — Banner
  // ================================================================
  print('=== Section 1: Banner ===');

  final banner = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [_dbPrimary, _dbAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: _dbPrimary.withValues(alpha: 0.45),
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
            Icon(Icons.select_all, color: Colors.white, size: 36.0),
            const SizedBox(width: 14.0),
            Expanded(
              child: Text(
                'ExtendSelectionTo\u200BDocumentBoundaryIntent',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Text(
          'Moves the selection extent to the very start or end of the '
          'document while keeping the base fixed.  Unlike '
          'ExpandSelectionToDocumentBoundaryIntent, the base never '
          'moves — only the extent travels to the boundary.',
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
    {'name': 'Intent', 'note': 'Base of the action-dispatch system'},
    {'name': 'DirectionalTextEditingIntent', 'note': 'Adds the forward boolean'},
    {
      'name': 'ExtendSelectionToDocumentBoundaryIntent',
      'note': 'Extends extent to doc start/end',
    },
  ];

  Widget dbChainTile(Map<String, String> c, int idx) {
    final isLast = idx == chain.length - 1;
    return Container(
      margin: EdgeInsets.only(left: idx * 22.0, top: 5.0, bottom: 5.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: isLast ? _dbLight : Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: isLast ? _dbAccent : _dbMuted.withValues(alpha: 0.3),
          width: isLast ? 2.0 : 1.0,
        ),
        boxShadow: isLast
            ? [BoxShadow(color: _dbPrimary.withValues(alpha: 0.15), blurRadius: 6.0, offset: const Offset(0.0, 3.0))]
            : [],
      ),
      child: Row(
        children: [
          Icon(isLast ? Icons.star : Icons.circle_outlined, color: isLast ? _dbAccent : _dbMuted, size: 18.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(c['name']!, style: TextStyle(fontSize: 14.0, fontWeight: isLast ? FontWeight.w700 : FontWeight.w500, color: isLast ? _dbPrimary : _dbDark)),
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
    children: [for (int i = 0; i < chain.length; i++) dbChainTile(chain[i], i)],
  );

  // ================================================================
  // SECTION 3 — Extend vs Expand
  // ================================================================
  print('=== Section 3: Extend vs Expand distinction ===');

  Widget dbKindCard(String title, String intent, String baseLabel, String extentLabel, Color accent) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12.0),
        border: Border(left: BorderSide(color: accent, width: 4.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: _dbDark)),
          const SizedBox(height: 4.0),
          Text(intent,
              style: TextStyle(fontSize: 12.0, fontFamily: 'monospace', color: accent)),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: accent.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    children: [
                      Text('Base', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _dbDark)),
                      const SizedBox(height: 2.0),
                      Text(baseLabel, style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: accent.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    children: [
                      Text('Extent', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _dbDark)),
                      const SizedBox(height: 2.0),
                      Text(extentLabel, style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  final extendVsExpand = Column(
    children: [
      dbKindCard(
        'Extend (this intent)',
        'ExtendSelectionToDocumentBoundaryIntent',
        'Stays at original position',
        'Moves to document boundary',
        _dbPrimary,
      ),
      const SizedBox(height: 10.0),
      dbKindCard(
        'Expand (sibling intent)',
        'ExpandSelectionToDocumentBoundaryIntent',
        'May move to ensure normalization',
        'Moves to document boundary',
        _dbMuted,
      ),
    ],
  );

  // ================================================================
  // SECTION 4 — Forward (to document end)
  // ================================================================
  print('=== Section 4: Forward — to document end ===');

  final docLines = <String>[
    '  1  Lorem ipsum dolor sit amet,',
    '  2  consectetur adipiscing elit.',
    '  3  Sed do eiusmod tempor incidi-',
    '  4  dunt ut labore et dolore',
    '  5  magna aliqua. Ut enim ad',
    '  6  minim veniam, quis nostrud',
    '  7  exercitation ullamco laboris.',
  ];

  Widget dbDocPreview({required String title, required int caretLine, required int selStartLine, required int selEndLine, required bool hasSelection}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _dbPrimary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700, color: _dbDark)),
          const SizedBox(height: 8.0),
          for (int li = 0; li < docLines.length; li++)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              margin: const EdgeInsets.only(bottom: 1.0),
              decoration: BoxDecoration(
                color: hasSelection && li >= selStartLine && li <= selEndLine
                    ? _dbHighlight.withValues(alpha: 0.25)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      docLines[li],
                      style: TextStyle(fontSize: 12.0, fontFamily: 'monospace', color: _dbDark),
                    ),
                  ),
                  if (!hasSelection && li == caretLine)
                    Container(width: 2.0, height: 16.0, color: _dbAccent),
                ],
              ),
            ),
          const SizedBox(height: 4.0),
          Text(
            hasSelection
                ? 'Selection: line ${selStartLine + 1} to line ${selEndLine + 1}'
                : 'Caret: line ${caretLine + 1}',
            style: TextStyle(fontSize: 11.0, color: _dbMuted, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  final forwardSection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _dbLight.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _dbPrimary.withValues(alpha: 0.12)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'forward: true — extend to document end',
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: _dbDark),
        ),
        const SizedBox(height: 4.0),
        Text(
          'The caret sits at line 3.  With forward=true the extent '
          'jumps to the very last offset of the document (end of '
          'line 7).  Base stays at line 3.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600, height: 1.4),
        ),
        const SizedBox(height: 8.0),
        dbDocPreview(title: 'BEFORE', caretLine: 2, selStartLine: 0, selEndLine: 0, hasSelection: false),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.vertical_align_bottom, color: _dbAccent, size: 22.0),
                const SizedBox(width: 6.0),
                Text('Ctrl+Shift+End', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: _dbAccent)),
              ],
            ),
          ),
        ),
        dbDocPreview(title: 'AFTER', caretLine: 2, selStartLine: 2, selEndLine: 6, hasSelection: true),
      ],
    ),
  );

  // ================================================================
  // SECTION 5 — Backward (to document start)
  // ================================================================
  print('=== Section 5: Backward — to document start ===');

  final backwardSection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _dbSurface.withValues(alpha: 0.25),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _dbMuted.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'forward: false — extend to document start',
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: _dbDark),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Caret at line 5.  With forward=false the extent jumps to '
          'offset 0 (start of line 1).  Base stays at line 5.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600, height: 1.4),
        ),
        const SizedBox(height: 8.0),
        dbDocPreview(title: 'BEFORE', caretLine: 4, selStartLine: 0, selEndLine: 0, hasSelection: false),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.vertical_align_top, color: _dbMuted, size: 22.0),
                const SizedBox(width: 6.0),
                Text('Ctrl+Shift+Home', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: _dbMuted)),
              ],
            ),
          ),
        ),
        dbDocPreview(title: 'AFTER', caretLine: 4, selStartLine: 0, selEndLine: 4, hasSelection: true),
      ],
    ),
  );

  // ================================================================
  // SECTION 6 — Pre-existing selection scenarios
  // ================================================================
  print('=== Section 6: Pre-existing selection ===');

  final existingSelScenarios = <Map<String, String>>[
    {
      'title': 'Extend existing forward selection to end',
      'before': 'base=20 extent=50 (forward selection, mid-doc)',
      'action': 'forward: true',
      'after': 'base=20 extent=<docLength>',
      'note': 'Existing forward selection grows to the end.',
    },
    {
      'title': 'Extend existing forward selection to start',
      'before': 'base=20 extent=50 (forward selection)',
      'action': 'forward: false',
      'after': 'base=20 extent=0',
      'note': 'Extent crosses back behind the base, resulting in a backward selection.',
    },
    {
      'title': 'Extend existing backward selection to start',
      'before': 'base=80 extent=30 (backward selection)',
      'action': 'forward: false',
      'after': 'base=80 extent=0',
      'note': 'Already backwards — extent just moves further left.',
    },
    {
      'title': 'Collapsed cursor to end',
      'before': 'base=40 extent=40 (collapsed)',
      'action': 'forward: true',
      'after': 'base=40 extent=<docLength>',
      'note': 'The simplest case — selects everything after the cursor.',
    },
  ];

  Widget dbScenarioCard(Map<String, String> s) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _dbPrimary.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(s['title']!, style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700, color: _dbDark)),
          const SizedBox(height: 6.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: _dbSurface.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Before', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, color: _dbMuted)),
                      Text(s['before']!, style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: _dbDark)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.arrow_forward, color: _dbAccent, size: 18.0),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: _dbHighlight.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('After', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, color: _dbAccent)),
                      Text(s['after']!, style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: _dbDark)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(color: _dbPrimary.withValues(alpha: 0.04), borderRadius: BorderRadius.circular(4.0)),
            child: Text('Action: ${s['action']!}', style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: _dbAccent)),
          ),
          const SizedBox(height: 4.0),
          Text(s['note']!, style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600, fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }

  final existingSelSection = Column(
    children: [for (final s in existingSelScenarios) dbScenarioCard(s)],
  );

  // ================================================================
  // SECTION 7 — Keyboard shortcuts
  // ================================================================
  print('=== Section 7: Keyboard shortcuts ===');

  final kbRows = <Map<String, String>>[
    {'platform': 'macOS', 'toEnd': '\u21E7+\u2318+\u2193', 'toStart': '\u21E7+\u2318+\u2191', 'note': 'Cmd+Shift+Down/Up'},
    {'platform': 'Windows', 'toEnd': 'Ctrl+Shift+End', 'toStart': 'Ctrl+Shift+Home', 'note': 'Standard'},
    {'platform': 'Linux', 'toEnd': 'Ctrl+Shift+End', 'toStart': 'Ctrl+Shift+Home', 'note': 'Same as Windows'},
    {'platform': 'Web', 'toEnd': 'Ctrl+Shift+End', 'toStart': 'Ctrl+Shift+Home', 'note': 'Follows host OS'},
  ];

  Widget dbKbRow(Map<String, String> r, int idx) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: idx.isEven ? _dbLight.withValues(alpha: 0.5) : Colors.white,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        children: [
          SizedBox(width: 70.0, child: Text(r['platform']!, style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: _dbDark))),
          Expanded(child: Text(r['toEnd']!, style: TextStyle(fontSize: 12.0, fontFamily: 'monospace', color: _dbAccent))),
          Expanded(child: Text(r['toStart']!, style: TextStyle(fontSize: 12.0, fontFamily: 'monospace', color: _dbMuted))),
          SizedBox(width: 80.0, child: Text(r['note']!, style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500))),
        ],
      ),
    );
  }

  final kbSection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.0), border: Border.all(color: _dbPrimary.withValues(alpha: 0.15))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Platform shortcuts', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: _dbDark)),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(color: _dbPrimary.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(6.0)),
          child: Row(
            children: [
              SizedBox(width: 70.0, child: Text('Platform', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _dbDark))),
              Expanded(child: Text('To End', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _dbDark))),
              Expanded(child: Text('To Start', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _dbDark))),
              SizedBox(width: 80.0, child: Text('Note', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _dbDark))),
            ],
          ),
        ),
        const SizedBox(height: 4.0),
        for (int i = 0; i < kbRows.length; i++) Padding(padding: const EdgeInsets.only(bottom: 2.0), child: dbKbRow(kbRows[i], i)),
      ],
    ),
  );

  // ================================================================
  // SECTION 8 — Dispatch flow
  // ================================================================
  print('=== Section 8: Dispatch flow ===');

  final flowSteps = <Map<String, String>>[
    {'step': '1', 'title': 'Shortcut fired', 'detail': 'Ctrl+Shift+End triggers the Shortcuts widget activator.'},
    {'step': '2', 'title': 'Intent created', 'detail': 'ExtendSelectionToDocumentBoundaryIntent(forward: true) is instantiated.'},
    {'step': '3', 'title': 'Action lookup', 'detail': 'Actions widget walks up the tree for a matching action.'},
    {'step': '4', 'title': 'Document length read', 'detail': 'The action reads controller.text.length (or 0) for the boundary offset.'},
    {'step': '5', 'title': 'Extent moved', 'detail': 'controller.selection.copyWith(extentOffset: boundary) applied.'},
    {'step': '6', 'title': 'Scroll + repaint', 'detail': 'RenderEditable repaints the highlight; scrollable makes extent visible.'},
  ];

  Widget dbFlowStep(Map<String, String> s, bool isLast) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 30.0, height: 30.0,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: _dbPrimary),
              child: Center(child: Text(s['step']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13.0))),
            ),
            if (!isLast) Container(width: 2.0, height: 30.0, color: _dbMuted.withValues(alpha: 0.3)),
          ],
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 4.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(color: _dbLight.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(8.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s['title']!, style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: _dbDark)),
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
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.0), border: Border.all(color: _dbPrimary.withValues(alpha: 0.15))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Dispatch flow', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: _dbDark)),
        const SizedBox(height: 10.0),
        for (int i = 0; i < flowSteps.length; i++) dbFlowStep(flowSteps[i], i == flowSteps.length - 1),
      ],
    ),
  );

  // ================================================================
  // SECTION 9 — Selection intent family
  // ================================================================
  print('=== Section 9: Intent family comparison ===');

  final family = <Map<String, String>>[
    {'name': 'ExtendSelectionByCharacterIntent', 'range': '1 grapheme', 'moves': 'Extent only'},
    {'name': 'ExtendSelectionToNextWordBoundaryIntent', 'range': '1 word', 'moves': 'Extent only'},
    {'name': 'ExtendSelectionToLineBreakIntent', 'range': 'To line end/start', 'moves': 'Extent only'},
    {'name': 'ExtendSelectionByPageIntent', 'range': '~1 viewport', 'moves': 'Extent only'},
    {'name': 'ExtendSelectionToDocumentBoundaryIntent', 'range': 'Entire document', 'moves': 'Extent only'},
    {'name': 'ExpandSelectionToDocumentBoundaryIntent', 'range': 'Entire document', 'moves': 'Both'},
  ];

  Widget dbFamilyRow(Map<String, String> f, int idx) {
    final isSelf = idx == 4;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: isSelf ? _dbHighlight.withValues(alpha: 0.15) : idx.isEven ? _dbLight.withValues(alpha: 0.4) : Colors.white,
        borderRadius: BorderRadius.circular(6.0),
        border: isSelf ? Border.all(color: _dbAccent.withValues(alpha: 0.4)) : null,
      ),
      child: Row(
        children: [
          Expanded(flex: 4, child: Text(f['name']!, style: TextStyle(fontSize: 11.0, fontWeight: isSelf ? FontWeight.w700 : FontWeight.w500, color: _dbDark))),
          Expanded(flex: 2, child: Text(f['range']!, style: TextStyle(fontSize: 11.0, color: _dbAccent))),
          Expanded(flex: 2, child: Text(f['moves']!, style: TextStyle(fontSize: 11.0, color: _dbMuted))),
        ],
      ),
    );
  }

  final familySection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.0), border: Border.all(color: _dbPrimary.withValues(alpha: 0.15))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Extend-family intents', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: _dbDark)),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(color: _dbPrimary.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(6.0)),
          child: Row(
            children: [
              Expanded(flex: 4, child: Text('Intent', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _dbDark))),
              Expanded(flex: 2, child: Text('Range', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _dbDark))),
              Expanded(flex: 2, child: Text('Moves', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _dbDark))),
            ],
          ),
        ),
        const SizedBox(height: 4.0),
        for (int i = 0; i < family.length; i++) Padding(padding: const EdgeInsets.only(bottom: 2.0), child: dbFamilyRow(family[i], i)),
      ],
    ),
  );

  // ================================================================
  // SECTION 10 — Custom action patterns
  // ================================================================
  print('=== Section 10: Custom action patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Select all below cursor',
      'icon': Icons.vertical_align_bottom,
      'desc': 'Common in code editors to select all text below the caret for deletion or copy.',
      'code': 'Actions.invoke<ExtendSelectionToDocumentBoundaryIntent>(\n'
          '  context,\n'
          '  const ExtendSelectionToDocumentBoundaryIntent(\n'
          '    forward: true,\n'
          '  ),\n'
          ');',
    },
    {
      'title': 'Restrict to section boundary',
      'icon': Icons.horizontal_rule,
      'desc': 'Override to stop at section markers (e.g. ---) instead of the true document boundary.',
      'code': 'CallbackAction<ExtendSelectionToDocumentBoundaryIntent>(\n'
          '  onInvoke: (intent) {\n'
          '    final text = controller.text;\n'
          '    final pos = controller.selection.extentOffset;\n'
          '    final boundary = intent.forward\n'
          '      ? text.indexOf(\'---\', pos)\n'
          '      : text.lastIndexOf(\'---\', pos);\n'
          '    final resolved = boundary == -1\n'
          '      ? (intent.forward ? text.length : 0)\n'
          '      : boundary;\n'
          '    controller.selection = controller.selection\n'
          '        .copyWith(extentOffset: resolved);\n'
          '    return null;\n'
          '  },\n'
          ')',
    },
    {
      'title': 'Logging wrapper',
      'icon': Icons.analytics,
      'desc': 'Wrap the default action to log how far the selection traveled.',
      'code': 'CallbackAction<ExtendSelectionToDocumentBoundaryIntent>(\n'
          '  onInvoke: (intent) {\n'
          '    final before = controller.selection.extentOffset;\n'
          '    final result = Actions.invoke(context, intent);\n'
          '    final after = controller.selection.extentOffset;\n'
          '    log(\'Moved \${(after - before).abs()} chars\');\n'
          '    return result;\n'
          '  },\n'
          ')',
    },
  ];

  Widget dbPatternCard(Map<String, dynamic> p) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: _dbLight.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.0),
        border: Border(left: BorderSide(color: _dbAccent, width: 4.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(p['icon'] as IconData, color: _dbPrimary, size: 22.0),
              const SizedBox(width: 10.0),
              Expanded(child: Text(p['title'] as String, style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: _dbDark))),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(p['desc'] as String, style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700, height: 1.4)),
          const SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(color: _dbDark.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(8.0)),
            child: Text(p['code'] as String, style: TextStyle(fontFamily: 'monospace', fontSize: 11.0, color: _dbDark, height: 1.4)),
          ),
        ],
      ),
    );
  }

  final patternSection = Column(
    children: [for (final p in patterns) dbPatternCard(p)],
  );

  // ================================================================
  // SECTION 11 — Edge cases
  // ================================================================
  print('=== Section 11: Edge cases ===');

  final edgeCases = <Map<String, String>>[
    {'case': 'Empty document, forward=true', 'result': 'No movement. offset stays 0.'},
    {'case': 'Extent already at doc end', 'result': 'No change — already at boundary.'},
    {'case': 'Single character document', 'result': 'Extent moves to 0 or 1 as expected.'},
    {'case': 'Very long document (100k chars)', 'result': 'Selection covers all text; scrollable adjusts in one step.'},
    {'case': 'RTL text', 'result': 'forward still means higher offset (logical end).'},
    {'case': 'Mixed LTR/RTL', 'result': 'Logical offsets are used; visual ordering does not affect boundary calc.'},
  ];

  Widget dbEdgeRow(Map<String, String> e) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: _dbSurface.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: _dbMuted.withValues(alpha: 0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: _dbMuted, size: 18.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(e['case']!, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: _dbDark)),
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
    children: [for (final e in edgeCases) dbEdgeRow(e)],
  );

  // ================================================================
  // SECTION 12 — Summary
  // ================================================================
  print('=== Section 12: Summary ===');

  final bullets = <String>[
    'ExtendSelectionToDocumentBoundaryIntent moves only the extent to offset 0 or text.length.',
    'The base never moves — this is the key difference from the Expand variant.',
    'forward: true goes to doc end; forward: false goes to doc start.',
    'Ctrl+Shift+End / Ctrl+Shift+Home on Windows/Linux; Cmd+Shift+Down/Up on macOS.',
    'If the extent crosses the base the selection becomes backwards — that is intentional.',
    'Works correctly with RTL, empty, and very long documents.',
    'Custom actions can intercept to limit the boundary to a section delimiter.',
    'The scroll position always adjusts to keep the new extent visible.',
  ];

  final summarySection = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_dbPrimary.withValues(alpha: 0.08), _dbLight.withValues(alpha: 0.5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _dbPrimary.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: _dbPrimary, size: 24.0),
            const SizedBox(width: 10.0),
            Text('Summary', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: _dbDark)),
          ],
        ),
        const SizedBox(height: 14.0),
        for (final b in bullets)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 6.0, height: 6.0, margin: const EdgeInsets.only(top: 6.0, right: 10.0), decoration: const BoxDecoration(shape: BoxShape.circle, color: _dbAccent)),
                Expanded(child: Text(b, style: TextStyle(fontSize: 13.0, color: _dbDark, height: 1.45))),
              ],
            ),
          ),
      ],
    ),
  );

  print('ExtendSelectionToDocumentBoundaryIntent deep demo complete');

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
        dbSectionHeader('Inheritance Chain'),
        chainSection,
        const SizedBox(height: 24.0),
        dbSectionHeader('Extend vs Expand'),
        extendVsExpand,
        const SizedBox(height: 24.0),
        dbSectionHeader('Forward: To Document End'),
        forwardSection,
        const SizedBox(height: 24.0),
        dbSectionHeader('Backward: To Document Start'),
        backwardSection,
        const SizedBox(height: 24.0),
        dbSectionHeader('Pre-Existing Selection'),
        existingSelSection,
        const SizedBox(height: 24.0),
        dbSectionHeader('Keyboard Shortcuts'),
        kbSection,
        const SizedBox(height: 24.0),
        dbSectionHeader('Dispatch Flow'),
        dispatchSection,
        const SizedBox(height: 24.0),
        dbSectionHeader('Selection Intent Family'),
        familySection,
        const SizedBox(height: 24.0),
        dbSectionHeader('Custom Action Patterns'),
        patternSection,
        const SizedBox(height: 24.0),
        dbSectionHeader('Edge Cases'),
        edgeCaseSection,
        const SizedBox(height: 24.0),
        summarySection,
        const SizedBox(height: 32.0),
      ],
    ),
  );
}

// ──────────────────── shared section header ───────────────────────
Widget dbSectionHeader(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Row(
      children: [
        Container(
          width: 4.0,
          height: 22.0,
          decoration: BoxDecoration(color: _dbAccent, borderRadius: BorderRadius.circular(2.0)),
        ),
        const SizedBox(width: 10.0),
        Text(title, style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: _dbDark)),
      ],
    ),
  );
}
