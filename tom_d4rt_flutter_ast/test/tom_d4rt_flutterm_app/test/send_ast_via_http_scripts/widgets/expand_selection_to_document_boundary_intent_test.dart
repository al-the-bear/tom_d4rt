// ignore_for_file: avoid_print
// D4rt deep-demo script: ExpandSelectionToDocumentBoundaryIntent
// Visual demonstration of the intent that expands the current text
// selection all the way to the beginning or end of the entire document.
//
// ExpandSelectionToDocumentBoundaryIntent is a DirectionalTextEditingIntent.
// When dispatched, it grows the selection (keeping the base fixed) so that
// the extent reaches the very first character (forward=false) or the very
// last character (forward=true) of the document.  On macOS this is
// typically Cmd+Shift+Up / Cmd+Shift+Down; on Windows/Linux it is
// Ctrl+Shift+Home / Ctrl+Shift+End.
//
// Theme : Deep Amber (#FF6F00) / Warm Cream (#FFF8E1)
// Prefix: sd
import 'package:flutter/material.dart';

// ─────────────────────────── palette ───────────────────────────────
const Color _sdPrimary = Color(0xFFFF6F00);
const Color _sdLight = Color(0xFFFFF8E1);
const Color _sdAccent = Color(0xFFE65100);
const Color _sdMuted = Color(0xFFF57C00);
const Color _sdSurface = Color(0xFFFFE0B2);
const Color _sdDark = Color(0xFF4E2600);
const Color _sdHighlight = Color(0xFFFFAB40);

dynamic build(BuildContext context) {
  print('ExpandSelectionToDocumentBoundaryIntent  Deep Demo executing');

  // ================================================================
  // SECTION 1 — Banner
  // ================================================================
  print('=== Section 1: Banner ===');

  final banner = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [_sdPrimary, _sdAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: _sdPrimary.withValues(alpha: 0.45),
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
                'ExpandSelectionTo\u200BDocumentBoundaryIntent',
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
          'A DirectionalTextEditingIntent that expands the current '
          'selection to the very beginning or end of the document.  '
          'The base of the selection stays fixed while the extent '
          'moves to a document boundary.',
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
  // SECTION 2 — Inheritance chain & API surface
  // ================================================================
  print('=== Section 2: Inheritance chain & API ===');

  final chain = <Map<String, String>>[
    {'name': 'Intent', 'note': 'Root of the intent hierarchy'},
    {'name': 'DirectionalTextEditingIntent', 'note': 'Adds forward:bool property'},
    {
      'name': 'ExpandSelectionToDocumentBoundaryIntent',
      'note': 'Concrete — selects to document start/end',
    },
  ];

  Widget sdChainCard(Map<String, String> c, int idx) {
    final isTarget = idx == chain.length - 1;
    return Container(
      margin: EdgeInsets.only(left: idx * 22.0, top: 6.0, bottom: 6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: isTarget ? _sdLight : Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: isTarget ? _sdAccent : _sdMuted.withValues(alpha: 0.3),
          width: isTarget ? 2.0 : 1.0,
        ),
        boxShadow: isTarget
            ? [
                BoxShadow(
                  color: _sdPrimary.withValues(alpha: 0.2),
                  blurRadius: 8.0,
                  offset: const Offset(0.0, 3.0),
                ),
              ]
            : [],
      ),
      child: Row(
        children: [
          Icon(
            isTarget ? Icons.star : Icons.circle_outlined,
            color: isTarget ? _sdAccent : _sdMuted,
            size: 20.0,
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c['name']!,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: isTarget ? FontWeight.w700 : FontWeight.w500,
                    color: isTarget ? _sdAccent : _sdDark,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  c['note']!,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final chainSection = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [for (int i = 0; i < chain.length; i++) sdChainCard(chain[i], i)],
  );

  // ================================================================
  // SECTION 3 — Direction visualization
  // ================================================================
  print('=== Section 3: Direction visualization ===');

  Widget sdShortcutChip(String platform, String keys) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: _sdDark.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$platform: ',
            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
          ),
          Text(
            keys,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              fontFamily: 'monospace',
              color: _sdDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget sdDirectionPanel({
    required bool forward,
    required String label,
    required String shortcutMac,
    required String shortcutWin,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.0),
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: forward
            ? _sdLight.withValues(alpha: 0.7)
            : _sdSurface.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: forward ? _sdAccent : _sdMuted,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                forward ? Icons.vertical_align_bottom : Icons.vertical_align_top,
                color: forward ? _sdAccent : _sdMuted,
                size: 28.0,
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                    color: _sdDark,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: (forward ? _sdAccent : _sdMuted).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'forward: $forward',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: forward ? _sdAccent : _sdMuted,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            description,
            style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700, height: 1.45),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              sdShortcutChip('macOS', shortcutMac),
              const SizedBox(width: 8.0),
              sdShortcutChip('Win/Linux', shortcutWin),
            ],
          ),
        ],
      ),
    );
  }

  final directionSection = Column(
    children: [
      sdDirectionPanel(
        forward: false,
        label: 'Expand to Document Start',
        shortcutMac: '\u2318+\u21E7+\u2191',
        shortcutWin: 'Ctrl+Shift+Home',
        description:
            'Selection extends from the current base upward / backward '
            'to the very first character of the document.  Everything '
            'before the original caret becomes selected.',
      ),
      sdDirectionPanel(
        forward: true,
        label: 'Expand to Document End',
        shortcutMac: '\u2318+\u21E7+\u2193',
        shortcutWin: 'Ctrl+Shift+End',
        description:
            'Selection extends from the current base downward / forward '
            'to the very last character.  Everything after the original '
            'caret becomes selected.',
      ),
    ],
  );

  // ================================================================
  // SECTION 4 — Before / after selection visualization
  // ================================================================
  print('=== Section 4: Before / after selection state ===');

  final sampleLines = <String>[
    'Lorem ipsum dolor sit amet,',
    'consectetur adipiscing elit.',
    'Sed do eiusmod tempor incid-',
    'idunt ut labore et dolore',
    'magna aliqua. Ut enim ad',
    'minim veniam, quis nostrud.',
  ];

  Widget sdDocumentPreview({
    required String title,
    required int caretLine,
    required int caretChar,
    required int selStartLine,
    required int selStartChar,
    required int selEndLine,
    required int selEndChar,
    required bool hasSelection,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _sdPrimary.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
              color: _sdDark,
            ),
          ),
          const SizedBox(height: 8.0),
          for (int lineIdx = 0; lineIdx < sampleLines.length; lineIdx++)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              margin: const EdgeInsets.only(bottom: 1.0),
              decoration: BoxDecoration(
                color: hasSelection &&
                        lineIdx >= selStartLine &&
                        lineIdx <= selEndLine
                    ? _sdHighlight.withValues(alpha: 0.25)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 20.0,
                    child: Text(
                      '${lineIdx + 1}',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.grey.shade400,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  const SizedBox(width: 6.0),
                  Expanded(
                    child: Text(
                      sampleLines[lineIdx],
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'monospace',
                        color: _sdDark,
                      ),
                    ),
                  ),
                  if (!hasSelection && lineIdx == caretLine)
                    Container(
                      width: 2.0,
                      height: 16.0,
                      color: _sdAccent,
                    ),
                ],
              ),
            ),
          const SizedBox(height: 6.0),
          if (hasSelection)
            Text(
              'Selection: line ${selStartLine + 1}:$selStartChar → '
              'line ${selEndLine + 1}:$selEndChar',
              style: TextStyle(
                fontSize: 11.0,
                color: _sdMuted,
                fontStyle: FontStyle.italic,
              ),
            )
          else
            Text(
              'Caret: line ${caretLine + 1}:$caretChar  (no selection)',
              style: TextStyle(
                fontSize: 11.0,
                color: _sdMuted,
                fontStyle: FontStyle.italic,
              ),
            ),
        ],
      ),
    );
  }

  final beforeAfterSection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _sdLight.withValues(alpha: 0.4),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _sdPrimary.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selection state: before → after  (forward: true)',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            color: _sdDark,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'The caret sits at line 3, character 14.  Dispatching the '
          'intent with forward=true expands the selection to the end '
          'of line 6.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600, height: 1.4),
        ),
        const SizedBox(height: 8.0),
        sdDocumentPreview(
          title: 'BEFORE — caret only',
          caretLine: 2,
          caretChar: 14,
          selStartLine: 0,
          selStartChar: 0,
          selEndLine: 0,
          selEndChar: 0,
          hasSelection: false,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_downward, color: _sdAccent, size: 28.0),
            const SizedBox(width: 6.0),
            Text(
              'forward: true',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                color: _sdAccent,
              ),
            ),
          ],
        ),
        sdDocumentPreview(
          title: 'AFTER — selection expanded to document end',
          caretLine: 2,
          caretChar: 14,
          selStartLine: 2,
          selStartChar: 14,
          selEndLine: 5,
          selEndChar: 28,
          hasSelection: true,
        ),
      ],
    ),
  );

  // ================================================================
  // SECTION 5 — Backward expansion preview
  // ================================================================
  print('=== Section 5: Backward expansion preview ===');

  final backwardSection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _sdSurface.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _sdMuted.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selection state: before → after  (forward: false)',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            color: _sdDark,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Same caret at line 3:14.  Dispatching with forward=false '
          'selects everything from the document start to the caret.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600, height: 1.4),
        ),
        const SizedBox(height: 8.0),
        sdDocumentPreview(
          title: 'BEFORE — caret only',
          caretLine: 2,
          caretChar: 14,
          selStartLine: 0,
          selStartChar: 0,
          selEndLine: 0,
          selEndChar: 0,
          hasSelection: false,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_upward, color: _sdMuted, size: 28.0),
            const SizedBox(width: 6.0),
            Text(
              'forward: false',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                color: _sdMuted,
              ),
            ),
          ],
        ),
        sdDocumentPreview(
          title: 'AFTER — selection expanded to document start',
          caretLine: 2,
          caretChar: 14,
          selStartLine: 0,
          selStartChar: 0,
          selEndLine: 2,
          selEndChar: 14,
          hasSelection: true,
        ),
      ],
    ),
  );

  // ================================================================
  // SECTION 6 — Keyboard shortcut table
  // ================================================================
  print('=== Section 6: Keyboard shortcut table ===');

  final shortcuts = <Map<String, String>>[
    {
      'platform': 'macOS',
      'toStart': '\u2318 + \u21E7 + \u2191',
      'toEnd': '\u2318 + \u21E7 + \u2193',
      'note': 'Cmd+Shift+Up/Down',
    },
    {
      'platform': 'Windows',
      'toStart': 'Ctrl + Shift + Home',
      'toEnd': 'Ctrl + Shift + End',
      'note': 'Standard Windows binding',
    },
    {
      'platform': 'Linux',
      'toStart': 'Ctrl + Shift + Home',
      'toEnd': 'Ctrl + Shift + End',
      'note': 'Same as Windows',
    },
    {
      'platform': 'Web',
      'toStart': 'Ctrl/\u2318 + Shift + Home',
      'toEnd': 'Ctrl/\u2318 + Shift + End',
      'note': 'Follows host OS convention',
    },
  ];

  Widget sdShortcutRow(Map<String, String> s, int idx) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: idx.isEven ? _sdLight.withValues(alpha: 0.5) : Colors.white,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 70.0,
            child: Text(
              s['platform']!,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                color: _sdDark,
              ),
            ),
          ),
          Expanded(
            child: Text(
              s['toStart']!,
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'monospace',
                color: _sdAccent,
              ),
            ),
          ),
          Expanded(
            child: Text(
              s['toEnd']!,
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'monospace',
                color: _sdMuted,
              ),
            ),
          ),
          SizedBox(
            width: 90.0,
            child: Text(
              s['note']!,
              style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
            ),
          ),
        ],
      ),
    );
  }

  final shortcutSection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _sdPrimary.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Platform keyboard shortcuts',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            color: _sdDark,
          ),
        ),
        const SizedBox(height: 6.0),
        // Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: _sdPrimary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 70.0,
                child: Text('Platform',
                    style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _sdDark)),
              ),
              Expanded(
                child: Text('To Start',
                    style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _sdDark)),
              ),
              Expanded(
                child: Text('To End',
                    style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _sdDark)),
              ),
              SizedBox(
                width: 90.0,
                child: Text('Note',
                    style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _sdDark)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4.0),
        for (int i = 0; i < shortcuts.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
            child: sdShortcutRow(shortcuts[i], i),
          ),
      ],
    ),
  );

  // ================================================================
  // SECTION 7 — Action binding & dispatch flow
  // ================================================================
  print('=== Section 7: Action binding & dispatch flow ===');

  final dispatchSteps = <Map<String, String>>[
    {
      'step': '1',
      'title': 'Key event triggers shortcut',
      'detail':
          'The user presses Cmd+Shift+Down.  The Shortcuts widget '
          'matches this against its shortcut map and finds the binding.',
    },
    {
      'step': '2',
      'title': 'Intent created',
      'detail':
          'A new ExpandSelectionToDocumentBoundaryIntent(forward: true) '
          'is instantiated from the mapping.',
    },
    {
      'step': '3',
      'title': 'Actions widget resolves action',
      'detail':
          'The framework walks up the tree looking for an Action<Expand'
          'SelectionToDocumentBoundaryIntent>.  EditableText provides one.',
    },
    {
      'step': '4',
      'title': 'Action invoked',
      'detail':
          'The action reads the current TextEditingValue, keeps the base '
          'where it is, and moves the extent to offset 0 or text.length '
          'depending on forward.',
    },
    {
      'step': '5',
      'title': 'Selection updated',
      'detail':
          'EditableText calls updateEditingValue with the new selection.  '
          'The text field re-renders with the expanded highlight.',
    },
  ];

  Widget sdDispatchStep(Map<String, String> s, bool isLast) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 32.0,
              height: 32.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: _sdPrimary,
              ),
              child: Center(
                child: Text(
                  s['step']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
            if (!isLast)
              Container(width: 2.0, height: 36.0, color: _sdMuted.withValues(alpha: 0.3)),
          ],
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 6.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: _sdLight.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s['title']!,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: _sdDark),
                ),
                const SizedBox(height: 3.0),
                Text(
                  s['detail']!,
                  style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700, height: 1.4),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  final dispatchSection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _sdPrimary.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dispatch flow: key press → selection update',
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: _sdDark),
        ),
        const SizedBox(height: 12.0),
        for (int i = 0; i < dispatchSteps.length; i++)
          sdDispatchStep(dispatchSteps[i], i == dispatchSteps.length - 1),
      ],
    ),
  );

  // ================================================================
  // SECTION 8 — Related intent family comparison
  // ================================================================
  print('=== Section 8: Related intent family comparison ===');

  final relatedIntents = <Map<String, String>>[
    {
      'intent': 'ExpandSelectionToDocumentBoundaryIntent',
      'granularity': 'Document',
      'action': 'Expand selection (keep base)',
      'target': 'Start or end of entire text',
    },
    {
      'intent': 'ExpandSelectionToLineBreakIntent',
      'granularity': 'Line',
      'action': 'Expand selection (keep base)',
      'target': 'Start or end of current line',
    },
    {
      'intent': 'ExtendSelectionToDocumentBoundaryIntent',
      'granularity': 'Document',
      'action': 'Extend selection (move extent)',
      'target': 'Start or end of entire text',
    },
    {
      'intent': 'ExtendSelectionToLineBreakIntent',
      'granularity': 'Line',
      'action': 'Extend selection (move extent)',
      'target': 'Start or end of current line',
    },
    {
      'intent': 'ExtendSelectionByCharacterIntent',
      'granularity': 'Character',
      'action': 'Extend by one character',
      'target': 'Next or previous character',
    },
  ];

  Widget sdRelatedRow(Map<String, String> r, int idx) {
    final isThis = idx == 0;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isThis ? _sdLight : (idx.isEven ? Colors.grey.shade50 : Colors.white),
        borderRadius: BorderRadius.circular(8.0),
        border: isThis ? Border.all(color: _sdAccent, width: 1.5) : null,
      ),
      child: Row(
        children: [
          if (isThis)
            Icon(Icons.arrow_right, color: _sdAccent, size: 18.0)
          else
            const SizedBox(width: 18.0),
          const SizedBox(width: 4.0),
          Expanded(
            flex: 3,
            child: Text(
              r['intent']!,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: isThis ? FontWeight.w700 : FontWeight.w500,
                color: isThis ? _sdAccent : _sdDark,
              ),
            ),
          ),
          Expanded(
            child: Text(
              r['granularity']!,
              style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              r['target']!,
              style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
            ),
          ),
        ],
      ),
    );
  }

  final relatedSection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _sdPrimary.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Related selection intents',
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: _sdDark),
        ),
        const SizedBox(height: 4.0),
        Text(
          '"Expand" keeps the anchor and moves the extent.  '
          '"Extend" is similar but may collapse first.  Compare '
          'granularity levels: character, word, line, document.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600, height: 1.4),
        ),
        const SizedBox(height: 8.0),
        for (int i = 0; i < relatedIntents.length; i++)
          sdRelatedRow(relatedIntents[i], i),
      ],
    ),
  );

  // ================================================================
  // SECTION 9 — Custom action implementation
  // ================================================================
  print('=== Section 9: Custom action implementation ===');

  final customPatterns = <Map<String, dynamic>>[
    {
      'title': 'Override default action',
      'icon': Icons.edit,
      'code':
          'Actions(\n'
          '  actions: {\n'
          '    ExpandSelectionToDocumentBoundaryIntent:\n'
          '      CallbackAction<...>(onInvoke: (intent) {\n'
          '        // Custom: select entire visible text only\n'
          '        final visible = getVisibleRange();\n'
          '        controller.selection = TextSelection(\n'
          '          baseOffset: intent.forward\n'
          '            ? controller.selection.baseOffset\n'
          '            : visible.start,\n'
          '          extentOffset: intent.forward\n'
          '            ? visible.end\n'
          '            : controller.selection.baseOffset,\n'
          '        );\n'
          '        return null;\n'
          '      }),\n'
          '  },\n'
          '  child: TextField(...),\n'
          ')',
      'description':
          'Instead of selecting to the absolute document boundary, '
          'this custom action selects only to the edges of the '
          'currently visible viewport — useful in very long documents.',
    },
    {
      'title': 'Programmatic dispatch',
      'icon': Icons.send,
      'code':
          'Actions.invoke<ExpandSelectionToDocumentBoundaryIntent>(\n'
          '  context,\n'
          '  ExpandSelectionToDocumentBoundaryIntent(\n'
          '    forward: true,\n'
          '  ),\n'
          ');',
      'description':
          'Fire the intent without a key press — for example from a '
          'toolbar "Select to end" button or an accessibility action.',
    },
    {
      'title': 'Conditional interception',
      'icon': Icons.security,
      'code':
          'Actions(\n'
          '  actions: {\n'
          '    ExpandSelectionToDocumentBoundaryIntent:\n'
          '      CallbackAction<...>(onInvoke: (intent) {\n'
          '        if (isReadOnly) return null; // block\n'
          '        return Actions.invoke(context, intent);\n'
          '      }),\n'
          '  },\n'
          '  child: ...,\n'
          ')',
      'description':
          'In read-only mode you may want to block selection expansion '
          'to keep users focused on visible content.',
    },
  ];

  Widget sdCustomCard(Map<String, dynamic> p) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: _sdLight.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.0),
        border: Border(left: BorderSide(color: _sdAccent, width: 4.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(p['icon'] as IconData, color: _sdPrimary, size: 22.0),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  p['title'] as String,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: _sdDark),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            p['description'] as String,
            style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700, height: 1.45),
          ),
          const SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: _sdDark.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              p['code'] as String,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: _sdDark,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final customSection = Column(
    children: [for (final p in customPatterns) sdCustomCard(p)],
  );

  // ================================================================
  // SECTION 10 — Edge cases & caveats
  // ================================================================
  print('=== Section 10: Edge cases & caveats ===');

  final edgeCases = <Map<String, String>>[
    {
      'case': 'Empty document',
      'behavior':
          'Both forward=true and forward=false produce a collapsed '
          'selection at offset 0.  No visible change.',
    },
    {
      'case': 'Caret already at boundary',
      'behavior':
          'If the caret is already at offset 0 and forward=false, the '
          'selection remains collapsed — no expansion occurs.',
    },
    {
      'case': 'Existing selection',
      'behavior':
          'The existing base is preserved.  Only the extent moves to '
          'the document boundary, potentially flipping the selection '
          'direction.',
    },
    {
      'case': 'Multi-line vs single-line',
      'behavior':
          'In a single-line TextField, "document boundary" is the start '
          'or end of that single line.  Functionally identical to '
          'ExpandSelectionToLineBreakIntent.',
    },
    {
      'case': 'RTL text',
      'behavior':
          'forward refers to logical direction, not visual.  In RTL '
          'text, forward=true still goes to the end offset.',
    },
  ];

  Widget sdEdgeCard(Map<String, String> e) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: _sdSurface.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _sdMuted.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, color: _sdMuted, size: 20.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e['case']!,
                  style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: _sdDark),
                ),
                const SizedBox(height: 3.0),
                Text(
                  e['behavior']!,
                  style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final edgeCaseSection = Column(
    children: [for (final e in edgeCases) sdEdgeCard(e)],
  );

  // ================================================================
  // SECTION 11 — Integration with EditableText
  // ================================================================
  print('=== Section 11: Integration with EditableText ===');

  final integrationPoints = <Map<String, dynamic>>[
    {
      'component': 'Shortcuts widget',
      'role': 'Maps key combinations to this intent',
      'icon': Icons.keyboard,
    },
    {
      'component': 'Actions widget',
      'role': 'Resolves the intent to a concrete Action',
      'icon': Icons.play_circle_outline,
    },
    {
      'component': 'EditableTextState',
      'role': 'Provides the default Action implementation',
      'icon': Icons.text_fields,
    },
    {
      'component': 'TextEditingController',
      'role': 'Holds the TextEditingValue that receives the new selection',
      'icon': Icons.storage,
    },
    {
      'component': 'RenderEditable',
      'role': 'Paints the selection highlight on screen',
      'icon': Icons.brush,
    },
  ];

  Widget sdIntegrationCard(Map<String, dynamic> ip, int idx) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: idx.isEven ? _sdLight.withValues(alpha: 0.5) : Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _sdPrimary.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _sdPrimary.withValues(alpha: 0.1),
            ),
            child: Icon(ip['icon'] as IconData, color: _sdAccent, size: 22.0),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ip['component'] as String,
                  style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: _sdDark),
                ),
                const SizedBox(height: 2.0),
                Text(
                  ip['role'] as String,
                  style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          if (idx < integrationPoints.length - 1)
            Icon(Icons.arrow_forward_ios, size: 14.0, color: _sdMuted.withValues(alpha: 0.5)),
        ],
      ),
    );
  }

  final integrationSection = Column(
    children: [
      for (int i = 0; i < integrationPoints.length; i++)
        sdIntegrationCard(integrationPoints[i], i),
    ],
  );

  // ================================================================
  // SECTION 12 — Summary
  // ================================================================
  print('=== Section 12: Summary ===');

  final summaryBullets = <String>[
    'ExpandSelectionToDocumentBoundaryIntent selects from the current base to offset 0 or text.length.',
    'It extends DirectionalTextEditingIntent with a single "forward" boolean.',
    'The default action is provided by EditableTextState within EditableText.',
    'Platform shortcuts: Cmd+Shift+Up/Down (macOS), Ctrl+Shift+Home/End (Win/Linux).',
    'The base of the selection stays fixed; only the extent moves.',
    'In a single-line field, document boundary equals line boundary.',
    'Custom actions can restrict expansion to the visible viewport or block it entirely.',
    'RTL text uses logical direction: forward=true always means toward the end offset.',
  ];

  final summarySection = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _sdPrimary.withValues(alpha: 0.08),
          _sdLight.withValues(alpha: 0.5),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _sdPrimary.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: _sdPrimary, size: 24.0),
            const SizedBox(width: 10.0),
            Text(
              'Summary',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: _sdDark),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        for (final b in summaryBullets)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6.0,
                  height: 6.0,
                  margin: const EdgeInsets.only(top: 6.0, right: 10.0),
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: _sdAccent),
                ),
                Expanded(
                  child: Text(
                    b,
                    style: TextStyle(fontSize: 13.0, color: _sdDark, height: 1.45),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );

  print('ExpandSelectionToDocumentBoundaryIntent deep demo complete');

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

        sdSectionHeader('Inheritance Chain & API'),
        chainSection,
        const SizedBox(height: 24.0),

        sdSectionHeader('Direction: Forward vs Backward'),
        directionSection,
        const SizedBox(height: 24.0),

        sdSectionHeader('Forward Expansion Preview'),
        beforeAfterSection,
        const SizedBox(height: 24.0),

        sdSectionHeader('Backward Expansion Preview'),
        backwardSection,
        const SizedBox(height: 24.0),

        sdSectionHeader('Keyboard Shortcuts by Platform'),
        shortcutSection,
        const SizedBox(height: 24.0),

        sdSectionHeader('Dispatch Flow'),
        dispatchSection,
        const SizedBox(height: 24.0),

        sdSectionHeader('Related Selection Intents'),
        relatedSection,
        const SizedBox(height: 24.0),

        sdSectionHeader('Custom Action Patterns'),
        customSection,
        const SizedBox(height: 24.0),

        sdSectionHeader('Edge Cases & Caveats'),
        edgeCaseSection,
        const SizedBox(height: 24.0),

        sdSectionHeader('EditableText Integration Stack'),
        integrationSection,
        const SizedBox(height: 24.0),

        summarySection,
        const SizedBox(height: 32.0),
      ],
    ),
  );
}

// ───────────────────── shared section header ──────────────────────
Widget sdSectionHeader(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Row(
      children: [
        Container(
          width: 4.0,
          height: 22.0,
          decoration: BoxDecoration(
            color: _sdAccent,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        const SizedBox(width: 10.0),
        Text(
          title,
          style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: _sdDark),
        ),
      ],
    ),
  );
}
