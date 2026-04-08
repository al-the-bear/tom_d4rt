// ignore_for_file: avoid_print
// D4rt deep-demo script: ExtendSelectionByPageIntent
// Visual demonstration of the intent that extends the current text
// selection by one "page" — roughly one viewport height — in a
// scrollable text field.
//
// ExtendSelectionByPageIntent is a DirectionalTextEditingIntent.
// forward=true  → Shift+PageDown (extend selection one page forward)
// forward=false → Shift+PageUp   (extend selection one page backward)
//
// Theme : Royal Indigo (#1A237E) / Lavender Cloud (#E8EAF6)
// Prefix: pg
import 'package:flutter/material.dart';

// ─────────────────────── palette ───────────────────────────────────
const Color _pgPrimary = Color(0xFF1A237E);
const Color _pgLight = Color(0xFFE8EAF6);
const Color _pgAccent = Color(0xFF3949AB);
const Color _pgMuted = Color(0xFF9FA8DA);
const Color _pgSurface = Color(0xFFC5CAE9);
const Color _pgDark = Color(0xFF000051);
const Color _pgHighlight = Color(0xFF8C9EFF);

dynamic build(BuildContext context) {
  print('ExtendSelectionByPageIntent  Deep Demo executing');

  // ================================================================
  // SECTION 1 — Banner
  // ================================================================
  print('=== Section 1: Banner ===');

  final banner = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [_pgPrimary, _pgAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: _pgPrimary.withValues(alpha: 0.45),
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
            Icon(Icons.description, color: Colors.white, size: 36.0),
            const SizedBox(width: 14.0),
            Expanded(
              child: Text(
                'ExtendSelectionBy\u200BPageIntent',
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
          'A DirectionalTextEditingIntent that extends the current '
          'selection by approximately one viewport-height of text.  '
          'This is the Shift+PageDown / Shift+PageUp equivalent, '
          'allowing the user to select large blocks without reaching '
          'for the mouse.',
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
  // SECTION 2 — Inheritance chain & constructor
  // ================================================================
  print('=== Section 2: Inheritance chain ===');

  final chain = <Map<String, String>>[
    {'name': 'Intent', 'note': 'Abstract base for all action intents'},
    {'name': 'DirectionalTextEditingIntent', 'note': 'Adds forward boolean'},
    {
      'name': 'ExtendSelectionByPageIntent',
      'note': 'Extends selection ≈ one page',
    },
  ];

  Widget pgChainTile(Map<String, String> c, int idx) {
    final isTarget = idx == chain.length - 1;
    return Container(
      margin: EdgeInsets.only(left: idx * 20.0, top: 5.0, bottom: 5.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: isTarget ? _pgLight : Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: isTarget ? _pgAccent : _pgMuted.withValues(alpha: 0.3),
          width: isTarget ? 2.0 : 1.0,
        ),
        boxShadow: isTarget
            ? [BoxShadow(color: _pgPrimary.withValues(alpha: 0.15), blurRadius: 6.0, offset: const Offset(0.0, 3.0))]
            : [],
      ),
      child: Row(
        children: [
          Icon(isTarget ? Icons.star : Icons.circle_outlined, color: isTarget ? _pgAccent : _pgMuted, size: 18.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(c['name']!, style: TextStyle(fontSize: 14.0, fontWeight: isTarget ? FontWeight.w700 : FontWeight.w500, color: isTarget ? _pgPrimary : _pgDark)),
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
    children: [for (int i = 0; i < chain.length; i++) pgChainTile(chain[i], i)],
  );

  final ctorSection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _pgDark.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Constructor', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: _pgDark)),
        const SizedBox(height: 6.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(color: _pgDark.withValues(alpha: 0.04), borderRadius: BorderRadius.circular(8.0)),
          child: Text(
            'const ExtendSelectionByPageIntent({\n'
            '  required bool forward,\n'
            '}) : super(forward);',
            style: TextStyle(fontFamily: 'monospace', fontSize: 12.0, color: _pgDark, height: 1.5),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'forward: true  → page down (Shift+PageDown)\n'
          'forward: false → page up   (Shift+PageUp)',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.45),
        ),
      ],
    ),
  );

  // ================================================================
  // SECTION 3 — What is a "page"?
  // ================================================================
  print('=== Section 3: Page definition ===');

  final pageDefSection = Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _pgPrimary.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('What is a "page"?', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: _pgDark)),
        const SizedBox(height: 10.0),
        Text(
          'A "page" in Flutter\'s text editing is the visible viewport '
          'height of the scrollable text field.  Specifically:\n\n'
          '• The action queries the RenderEditable for the viewport '
          'height in pixels.\n'
          '• It multiplies that by the line height to estimate how '
          'many lines fit on screen.\n'
          '• The extent offset is moved forward or backward by that '
          'many lines.\n\n'
          'The exact number of lines varies with font size, line '
          'spacing, and the physical size of the widget.  For example, '
          'a 600 px tall field with 20 px line height ≈ 30 lines '
          'per page.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700, height: 1.55),
        ),
        const SizedBox(height: 14.0),
        // Visual diagram
        Row(
          children: [
            Expanded(
              child: Container(
                height: 160.0,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: _pgLight,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: _pgAccent.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Viewport', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: _pgPrimary)),
                    const SizedBox(height: 4.0),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: _pgHighlight.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(color: _pgAccent.withValues(alpha: 0.3), width: 2.0),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.visibility, color: _pgAccent, size: 28.0),
                              const SizedBox(height: 4.0),
                              Text('~30 lines visible', style: TextStyle(fontSize: 11.0, color: _pgAccent)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Container(
                height: 160.0,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: _pgSurface.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: _pgMuted.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Full document', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: _pgPrimary)),
                    const SizedBox(height: 4.0),
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: _pgMuted.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Center(child: Text('200 lines total', style: TextStyle(fontSize: 11.0, color: _pgMuted))),
                            ),
                          ),
                          Positioned(
                            top: 20.0, left: 0.0, right: 0.0, height: 40.0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: _pgHighlight.withValues(alpha: 0.25),
                                borderRadius: BorderRadius.circular(3.0),
                                border: Border.all(color: _pgAccent, width: 1.5),
                              ),
                              child: Center(child: Text('1 page', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, color: _pgAccent))),
                            ),
                          ),
                        ],
                      ),
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
  // SECTION 4 — Forward (page down) selection preview
  // ================================================================
  print('=== Section 4: Forward — page down ===');

  Widget pgSelectionPreview({
    required String title,
    required String description,
    required int startLine,
    required int endLine,
    required int totalLines,
    required int selStartLine,
    required int selEndLine,
  }) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _pgPrimary.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: _pgDark)),
          const SizedBox(height: 4.0),
          Text(description, style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600, height: 1.4)),
          const SizedBox(height: 10.0),
          for (int ln = startLine; ln <= endLine; ln++)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 1.0),
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: ln >= selStartLine && ln <= selEndLine
                    ? _pgHighlight.withValues(alpha: 0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 28.0,
                    child: Text('$ln', style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Colors.grey.shade400)),
                  ),
                  Expanded(
                    child: Container(
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: ln >= selStartLine && ln <= selEndLine
                            ? _pgAccent.withValues(alpha: 0.2)
                            : _pgMuted.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 6.0),
          Row(
            children: [
              Container(width: 12.0, height: 12.0, decoration: BoxDecoration(color: _pgHighlight.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(2.0))),
              const SizedBox(width: 6.0),
              Text('Selected', style: TextStyle(fontSize: 11.0, color: _pgMuted)),
              const SizedBox(width: 16.0),
              Container(width: 12.0, height: 12.0, decoration: BoxDecoration(color: _pgMuted.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(2.0))),
              const SizedBox(width: 6.0),
              Text('Unselected', style: TextStyle(fontSize: 11.0, color: _pgMuted)),
            ],
          ),
        ],
      ),
    );
  }

  final forwardSection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _pgLight.withValues(alpha: 0.4),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _pgPrimary.withValues(alpha: 0.12)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.keyboard_arrow_down, color: _pgAccent, size: 26.0),
            const SizedBox(width: 8.0),
            Text('forward: true — Shift+PageDown', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: _pgDark)),
          ],
        ),
        const SizedBox(height: 10.0),
        pgSelectionPreview(
          title: 'BEFORE: caret at line 25',
          description: 'The caret sits at line 25 in a 200-line document with ~30 lines per page.',
          startLine: 20, endLine: 35, totalLines: 200,
          selStartLine: -1, selEndLine: -1,
        ),
        const SizedBox(height: 8.0),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.arrow_downward, color: _pgAccent, size: 22.0),
              const SizedBox(width: 6.0),
              Text('Shift+PageDown', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: _pgAccent)),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        pgSelectionPreview(
          title: 'AFTER: selection from 25 to 55',
          description: 'Extent moved ~30 lines forward.  Base stays at line 25.',
          startLine: 20, endLine: 60, totalLines: 200,
          selStartLine: 25, selEndLine: 55,
        ),
      ],
    ),
  );

  // ================================================================
  // SECTION 5 — Backward (page up) selection preview
  // ================================================================
  print('=== Section 5: Backward — page up ===');

  final backwardSection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _pgSurface.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _pgMuted.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.keyboard_arrow_up, color: _pgMuted, size: 26.0),
            const SizedBox(width: 8.0),
            Text('forward: false — Shift+PageUp', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: _pgDark)),
          ],
        ),
        const SizedBox(height: 10.0),
        pgSelectionPreview(
          title: 'BEFORE: caret at line 80',
          description: 'The caret sits at line 80 in the same 200-line document.',
          startLine: 75, endLine: 90, totalLines: 200,
          selStartLine: -1, selEndLine: -1,
        ),
        const SizedBox(height: 8.0),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.arrow_upward, color: _pgMuted, size: 22.0),
              const SizedBox(width: 6.0),
              Text('Shift+PageUp', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: _pgMuted)),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        pgSelectionPreview(
          title: 'AFTER: selection from 50 to 80',
          description: 'Extent moved ~30 lines backward to line 50.  Base stays at 80.',
          startLine: 45, endLine: 85, totalLines: 200,
          selStartLine: 50, selEndLine: 80,
        ),
      ],
    ),
  );

  // ================================================================
  // SECTION 6 — Keyboard shortcuts
  // ================================================================
  print('=== Section 6: Keyboard shortcuts ===');

  final kbRows = <Map<String, String>>[
    {'platform': 'macOS', 'down': '\u21E7+Fn+\u2193', 'up': '\u21E7+Fn+\u2191', 'note': 'Fn remaps arrows to Page keys'},
    {'platform': 'Windows', 'down': 'Shift+PageDown', 'up': 'Shift+PageUp', 'note': 'Standard'},
    {'platform': 'Linux', 'down': 'Shift+PageDown', 'up': 'Shift+PageUp', 'note': 'Same'},
    {'platform': 'Web', 'down': 'Shift+PageDown', 'up': 'Shift+PageUp', 'note': 'Follows host OS'},
  ];

  Widget pgKbRow(Map<String, String> r, int idx) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: idx.isEven ? _pgLight.withValues(alpha: 0.5) : Colors.white,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        children: [
          SizedBox(width: 70.0, child: Text(r['platform']!, style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: _pgDark))),
          Expanded(child: Text(r['down']!, style: TextStyle(fontSize: 12.0, fontFamily: 'monospace', color: _pgAccent))),
          Expanded(child: Text(r['up']!, style: TextStyle(fontSize: 12.0, fontFamily: 'monospace', color: _pgMuted))),
          SizedBox(width: 80.0, child: Text(r['note']!, style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500))),
        ],
      ),
    );
  }

  final kbSection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _pgPrimary.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Platform shortcuts', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: _pgDark)),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(color: _pgPrimary.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(6.0)),
          child: Row(
            children: [
              SizedBox(width: 70.0, child: Text('Platform', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _pgDark))),
              Expanded(child: Text('Page Down', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _pgDark))),
              Expanded(child: Text('Page Up', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _pgDark))),
              SizedBox(width: 80.0, child: Text('Note', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _pgDark))),
            ],
          ),
        ),
        const SizedBox(height: 4.0),
        for (int i = 0; i < kbRows.length; i++) Padding(padding: const EdgeInsets.only(bottom: 2.0), child: pgKbRow(kbRows[i], i)),
      ],
    ),
  );

  // ================================================================
  // SECTION 7 — Dispatch flow
  // ================================================================
  print('=== Section 7: Dispatch flow ===');

  final steps = <Map<String, String>>[
    {'step': '1', 'title': 'Key event arrives', 'detail': 'Shift+PageDown maps to the intent via Shortcuts widget.'},
    {'step': '2', 'title': 'Viewport height measured', 'detail': 'The action reads RenderEditable.size.height for the page size.'},
    {'step': '3', 'title': 'Line count estimated', 'detail': 'Height divided by preferredLineHeight gives lines per page.'},
    {'step': '4', 'title': 'Target offset computed', 'detail': 'Current extent line ± lines-per-page determines the new line.'},
    {'step': '5', 'title': 'Selection updated', 'detail': 'controller.selection.copyWith(extentOffset: newOffset).'},
    {'step': '6', 'title': 'Scroll adjusted', 'detail': 'The scrollable ensures the new extent is visible.'},
  ];

  Widget pgStepRow(Map<String, String> s, bool isLast) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 30.0, height: 30.0,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: _pgPrimary),
              child: Center(child: Text(s['step']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13.0))),
            ),
            if (!isLast) Container(width: 2.0, height: 30.0, color: _pgMuted.withValues(alpha: 0.3)),
          ],
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 4.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(color: _pgLight.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(8.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s['title']!, style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: _pgDark)),
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
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.0), border: Border.all(color: _pgPrimary.withValues(alpha: 0.15))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Dispatch flow', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: _pgDark)),
        const SizedBox(height: 10.0),
        for (int i = 0; i < steps.length; i++) pgStepRow(steps[i], i == steps.length - 1),
      ],
    ),
  );

  // ================================================================
  // SECTION 8 — Comparison: page vs other granularities
  // ================================================================
  print('=== Section 8: Granularity comparison ===');

  final compRows = <Map<String, String>>[
    {'intent': 'ExtendSelectionByCharacterIntent', 'distance': '1 grapheme', 'speed': 'Slow (fine-grained)'},
    {'intent': 'ExtendSelectionToNextWordBoundaryIntent', 'distance': '1 word', 'speed': 'Medium'},
    {'intent': 'ExpandSelectionToLineBreakIntent', 'distance': 'To line end/start', 'speed': 'Medium-fast'},
    {'intent': 'ExtendSelectionByPageIntent', 'distance': '~1 viewport', 'speed': 'Fast'},
    {'intent': 'ExpandSelectionToDocumentBoundaryIntent', 'distance': 'To doc end/start', 'speed': 'Maximum'},
  ];

  Widget pgCompRow(Map<String, String> c, int idx) {
    final isSelf = idx == 3;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 9.0),
      decoration: BoxDecoration(
        color: isSelf
            ? _pgHighlight.withValues(alpha: 0.15)
            : idx.isEven ? _pgLight.withValues(alpha: 0.4) : Colors.white,
        borderRadius: BorderRadius.circular(6.0),
        border: isSelf ? Border.all(color: _pgAccent.withValues(alpha: 0.4)) : null,
      ),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(c['intent']!, style: TextStyle(fontSize: 11.0, fontWeight: isSelf ? FontWeight.w700 : FontWeight.w500, color: _pgDark))),
          Expanded(flex: 2, child: Text(c['distance']!, style: TextStyle(fontSize: 11.0, color: _pgAccent))),
          Expanded(flex: 2, child: Text(c['speed']!, style: TextStyle(fontSize: 11.0, color: _pgMuted))),
        ],
      ),
    );
  }

  final compSection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.0), border: Border.all(color: _pgPrimary.withValues(alpha: 0.15))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Selection granularity spectrum', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: _pgDark)),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(color: _pgPrimary.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(6.0)),
          child: Row(
            children: [
              Expanded(flex: 3, child: Text('Intent', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _pgDark))),
              Expanded(flex: 2, child: Text('Distance', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _pgDark))),
              Expanded(flex: 2, child: Text('Speed', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _pgDark))),
            ],
          ),
        ),
        const SizedBox(height: 4.0),
        for (int i = 0; i < compRows.length; i++) Padding(padding: const EdgeInsets.only(bottom: 2.0), child: pgCompRow(compRows[i], i)),
      ],
    ),
  );

  // ================================================================
  // SECTION 9 — Custom action patterns
  // ================================================================
  print('=== Section 9: Custom action patterns ===');

  final customPatterns = <Map<String, dynamic>>[
    {
      'title': 'Half-page selection',
      'icon': Icons.content_cut,
      'desc': 'Override to extend by half a viewport instead of a full page.',
      'code': 'CallbackAction<ExtendSelectionByPageIntent>(\n'
          '  onInvoke: (intent) {\n'
          '    final linesPerPage = viewportHeight ~/ lineHeight;\n'
          '    final half = linesPerPage ~/ 2;\n'
          '    final delta = intent.forward ? half : -half;\n'
          '    // move extent by half lines\n'
          '    controller.selection = controller.selection.copyWith(\n'
          '      extentOffset: computeOffset(delta),\n'
          '    );\n'
          '    return null;\n'
          '  },\n'
          ')',
    },
    {
      'title': 'Paragraph-aware page',
      'icon': Icons.format_indent_increase,
      'desc': 'Instead of an exact viewport page, snap to the nearest paragraph boundary.',
      'code': 'CallbackAction<ExtendSelectionByPageIntent>(\n'
          '  onInvoke: (intent) {\n'
          '    final boundary = findParagraphBoundary(\n'
          '      controller.text,\n'
          '      controller.selection.extentOffset,\n'
          '      intent.forward,\n'
          '      linesPerPage,\n'
          '    );\n'
          '    controller.selection = controller.selection\n'
          '        .copyWith(extentOffset: boundary);\n'
          '    return null;\n'
          '  },\n'
          ')',
    },
    {
      'title': 'Selection counter',
      'icon': Icons.analytics,
      'desc': 'Count how many page-selection events occur for analytics.',
      'code': 'CallbackAction<ExtendSelectionByPageIntent>(\n'
          '  onInvoke: (intent) {\n'
          '    analytics.track(\'page_select\',\n'
          '      direction: intent.forward ? \'down\' : \'up\');\n'
          '    return Actions.invoke(context, intent);\n'
          '  },\n'
          ')',
    },
  ];

  Widget pgPatternCard(Map<String, dynamic> p) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: _pgLight.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.0),
        border: Border(left: BorderSide(color: _pgAccent, width: 4.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(p['icon'] as IconData, color: _pgPrimary, size: 22.0),
              const SizedBox(width: 10.0),
              Expanded(child: Text(p['title'] as String, style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: _pgDark))),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(p['desc'] as String, style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700, height: 1.4)),
          const SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(color: _pgDark.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(8.0)),
            child: Text(p['code'] as String, style: TextStyle(fontFamily: 'monospace', fontSize: 11.0, color: _pgDark, height: 1.4)),
          ),
        ],
      ),
    );
  }

  final customSection = Column(
    children: [for (final p in customPatterns) pgPatternCard(p)],
  );

  // ================================================================
  // SECTION 10 — Edge cases
  // ================================================================
  print('=== Section 10: Edge cases ===');

  final edgeCases = <Map<String, String>>[
    {'case': 'Fewer than one page left', 'result': 'Extent moves to document end (or start) without overshooting.'},
    {'case': 'Single-line TextField', 'result': 'Page size ≈ 1 line; behaves like "to end" or "to start".'},
    {'case': 'Non-scrollable field', 'result': 'Viewport height equals content height; selects all remaining text.'},
    {'case': 'Very large font size', 'result': 'Page covers fewer lines; selection granularity feels coarser.'},
    {'case': 'Rapidly changing viewport', 'result': 'Each dispatch re-measures; page jumps track the latest size.'},
    {'case': 'Empty document', 'result': 'No movement.  Selection remains collapsed at offset 0.'},
  ];

  Widget pgEdgeRow(Map<String, String> e) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: _pgSurface.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: _pgMuted.withValues(alpha: 0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: _pgMuted, size: 18.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(e['case']!, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: _pgDark)),
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
    children: [for (final e in edgeCases) pgEdgeRow(e)],
  );

  // ================================================================
  // SECTION 11 — Scrolling behavior
  // ================================================================
  print('=== Section 11: Scrolling behavior ===');

  final scrollSection = Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_pgAccent.withValues(alpha: 0.07), _pgLight.withValues(alpha: 0.4)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _pgAccent.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.swap_vert, color: _pgPrimary, size: 22.0),
            const SizedBox(width: 10.0),
            Text('Scroll behavior', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: _pgDark)),
          ],
        ),
        const SizedBox(height: 10.0),
        for (final fact in <String>[
          'After updating the selection, the action calls showCaret() to ensure the new extent is visible.',
          'If the extent is already within the viewport, no scrolling occurs.',
          'If the extent moves below the viewport, it scrolls down by the overshoot amount.',
          'The scroll is animated (≈250 ms) for visual continuity.  Without it, the user loses context.',
          'In a non-scrollable field the call is a no-op since the entire content is always visible.',
        ])
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 6.0, height: 6.0, margin: const EdgeInsets.only(top: 6.0, right: 10.0), decoration: const BoxDecoration(shape: BoxShape.circle, color: _pgAccent)),
                Expanded(child: Text(fact, style: TextStyle(fontSize: 12.0, color: _pgDark, height: 1.45))),
              ],
            ),
          ),
      ],
    ),
  );

  // ================================================================
  // SECTION 12 — Summary
  // ================================================================
  print('=== Section 12: Summary ===');

  final summaryBullets = <String>[
    'ExtendSelectionByPageIntent extends the selection by roughly one viewport height of text.',
    'forward=true → Shift+PageDown; forward=false → Shift+PageUp.',
    'A "page" is dynamically measured: viewport height ÷ line height lines.',
    'The base stays fixed while the extent jumps by one page.',
    'If fewer than one page remains, the extent clamps to the document boundary.',
    'The scroll position auto-adjusts to keep the new extent visible.',
    'Custom actions can override for half-page, paragraph-snap, or analytics wrapping.',
    'On macOS, Fn key converts arrow keys to PageUp/PageDown.',
  ];

  final summarySection = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_pgPrimary.withValues(alpha: 0.08), _pgLight.withValues(alpha: 0.5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _pgPrimary.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: _pgPrimary, size: 24.0),
            const SizedBox(width: 10.0),
            Text('Summary', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: _pgDark)),
          ],
        ),
        const SizedBox(height: 14.0),
        for (final b in summaryBullets)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 6.0, height: 6.0, margin: const EdgeInsets.only(top: 6.0, right: 10.0), decoration: const BoxDecoration(shape: BoxShape.circle, color: _pgAccent)),
                Expanded(child: Text(b, style: TextStyle(fontSize: 13.0, color: _pgDark, height: 1.45))),
              ],
            ),
          ),
      ],
    ),
  );

  print('ExtendSelectionByPageIntent deep demo complete');

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
        pgSectionHeader('Inheritance Chain'),
        chainSection,
        const SizedBox(height: 12.0),
        ctorSection,
        const SizedBox(height: 24.0),
        pgSectionHeader('What is a "Page"?'),
        pageDefSection,
        const SizedBox(height: 24.0),
        pgSectionHeader('Forward: Page Down'),
        forwardSection,
        const SizedBox(height: 24.0),
        pgSectionHeader('Backward: Page Up'),
        backwardSection,
        const SizedBox(height: 24.0),
        pgSectionHeader('Keyboard Shortcuts'),
        kbSection,
        const SizedBox(height: 24.0),
        pgSectionHeader('Dispatch Flow'),
        dispatchSection,
        const SizedBox(height: 24.0),
        pgSectionHeader('Granularity Spectrum'),
        compSection,
        const SizedBox(height: 24.0),
        pgSectionHeader('Custom Action Patterns'),
        customSection,
        const SizedBox(height: 24.0),
        pgSectionHeader('Edge Cases'),
        edgeCaseSection,
        const SizedBox(height: 24.0),
        pgSectionHeader('Scrolling Behavior'),
        scrollSection,
        const SizedBox(height: 24.0),
        summarySection,
        const SizedBox(height: 32.0),
      ],
    ),
  );
}

// ──────────────────── shared section header ───────────────────────
Widget pgSectionHeader(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Row(
      children: [
        Container(
          width: 4.0,
          height: 22.0,
          decoration: BoxDecoration(color: _pgAccent, borderRadius: BorderRadius.circular(2.0)),
        ),
        const SizedBox(width: 10.0),
        Text(title, style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: _pgDark)),
      ],
    ),
  );
}
