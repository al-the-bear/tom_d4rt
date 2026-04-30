// ignore_for_file: avoid_print
// D4rt deep-demo script: ExtendSelectionByCharacterIntent
// Visual demonstration of the intent that grows or shrinks the
// current text selection by exactly one character in a given
// direction.  It is the Shift+Arrow key equivalent — one of the
// most frequently used selection intents in any text editor.
//
// ExtendSelectionByCharacterIntent extends DirectionalTextEditingIntent.
// forward=true  → Shift+Right (extend one char toward higher offsets)
// forward=false → Shift+Left  (extend one char toward lower offsets)
//
// Theme : Forest Teal (#004D40) / Mint Frost (#E0F2F1)
// Prefix: ec
import 'package:flutter/material.dart';

// ─────────────────────── palette ───────────────────────────────────
const Color _ecPrimary = Color(0xFF004D40);
const Color _ecLight = Color(0xFFE0F2F1);
const Color _ecAccent = Color(0xFF00796B);
const Color _ecMuted = Color(0xFF80CBC4);
const Color _ecSurface = Color(0xFFB2DFDB);
const Color _ecDark = Color(0xFF00251A);
const Color _ecHighlight = Color(0xFF64FFDA);

dynamic build(BuildContext context) {
  print('ExtendSelectionByCharacterIntent  Deep Demo executing');

  // ================================================================
  // SECTION 1 — Banner
  // ================================================================
  print('=== Section 1: Banner ===');

  final banner = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [_ecPrimary, _ecAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: _ecPrimary.withValues(alpha: 0.45),
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
            Icon(Icons.text_rotation_none, color: Colors.white, size: 36.0),
            const SizedBox(width: 14.0),
            Expanded(
              child: Text(
                'ExtendSelectionBy\u200BCharacterIntent',
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
          'A DirectionalTextEditingIntent that grows or shrinks the '
          'selection by exactly one character.  This is the '
          'Shift+Left / Shift+Right keyboard action — the most '
          'granular selection expansion available.',
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
    {'name': 'Intent', 'note': 'Base class for action dispatch'},
    {'name': 'DirectionalTextEditingIntent', 'note': 'Adds forward boolean'},
    {
      'name': 'ExtendSelectionByCharacterIntent',
      'note': 'Extends selection by one grapheme cluster',
    },
  ];

  Widget ecChainTile(Map<String, String> c, int idx) {
    final isTarget = idx == chain.length - 1;
    return Container(
      margin: EdgeInsets.only(left: idx * 20.0, top: 5.0, bottom: 5.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: isTarget ? _ecLight : Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: isTarget ? _ecAccent : _ecMuted.withValues(alpha: 0.3),
          width: isTarget ? 2.0 : 1.0,
        ),
        boxShadow: isTarget
            ? [BoxShadow(color: _ecPrimary.withValues(alpha: 0.15), blurRadius: 6.0, offset: const Offset(0.0, 3.0))]
            : [],
      ),
      child: Row(
        children: [
          Icon(isTarget ? Icons.star : Icons.circle_outlined, color: isTarget ? _ecAccent : _ecMuted, size: 18.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(c['name']!, style: TextStyle(fontSize: 14.0, fontWeight: isTarget ? FontWeight.w700 : FontWeight.w500, color: isTarget ? _ecPrimary : _ecDark)),
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
    children: [for (int i = 0; i < chain.length; i++) ecChainTile(chain[i], i)],
  );

  // Constructor detail
  final ctorSection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _ecDark.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Constructor', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: _ecDark)),
        const SizedBox(height: 6.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(color: _ecDark.withValues(alpha: 0.04), borderRadius: BorderRadius.circular(8.0)),
          child: Text(
            'const ExtendSelectionByCharacterIntent({\n'
            '  required bool forward,\n'
            '}) : super(forward);',
            style: TextStyle(fontFamily: 'monospace', fontSize: 12.0, color: _ecDark, height: 1.5),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'The single boolean forward determines the direction:\n'
          '• forward: true  → move extent one character to the right\n'
          '• forward: false → move extent one character to the left',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.45),
        ),
      ],
    ),
  );

  // ================================================================
  // SECTION 3 — Character-by-character animation concept
  // ================================================================
  print('=== Section 3: Character-by-character selection ===');

  // Show how the selection grows one char at a time
  final charLine = 'Hello, World!';
  final selectionFrames = <Map<String, dynamic>>[
    {'base': 5, 'extent': 5, 'label': 'Collapsed cursor at offset 5'},
    {'base': 5, 'extent': 6, 'label': 'After Shift+Right (1x)'},
    {'base': 5, 'extent': 7, 'label': 'After Shift+Right (2x)'},
    {'base': 5, 'extent': 8, 'label': 'After Shift+Right (3x)'},
    {'base': 5, 'extent': 9, 'label': 'After Shift+Right (4x)'},
  ];

  Widget ecFrameCard(Map<String, dynamic> f) {
    final base = f['base'] as int;
    final extent = f['extent'] as int;
    final isCollapsed = base == extent;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isCollapsed ? Colors.white : _ecLight,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: isCollapsed ? _ecMuted.withValues(alpha: 0.3) : _ecAccent.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(f['label'] as String, style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _ecDark)),
          const SizedBox(height: 6.0),
          Row(
            children: [
              for (int ci = 0; ci < charLine.length; ci++)
                Container(
                  width: 22.0, height: 28.0,
                  margin: const EdgeInsets.only(right: 1.0),
                  decoration: BoxDecoration(
                    color: ci >= base && ci < extent
                        ? _ecHighlight.withValues(alpha: 0.5)
                        : Colors.transparent,
                    border: ci == base && isCollapsed
                        ? Border(left: BorderSide(color: _ecAccent, width: 2.0))
                        : null,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  child: Center(
                    child: Text(
                      charLine[ci],
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13.0,
                        fontWeight: ci >= base && ci < extent ? FontWeight.bold : FontWeight.normal,
                        color: _ecDark,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4.0),
          Text(
            'base: $base  extent: $extent  selected: "${charLine.substring(base, extent)}"',
            style: TextStyle(fontFamily: 'monospace', fontSize: 10.0, color: _ecAccent),
          ),
        ],
      ),
    );
  }

  final framesSection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _ecPrimary.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Selection growth — forward', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: _ecDark)),
        const SizedBox(height: 4.0),
        Text(
          'Each press of Shift+Right dispatches ExtendSelectionByCharacterIntent(forward: true), '
          'moving the extent one grapheme cluster to the right.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600, height: 1.4),
        ),
        const SizedBox(height: 8.0),
        for (final f in selectionFrames) ecFrameCard(f),
      ],
    ),
  );

  // ================================================================
  // SECTION 4 — Backward contraction
  // ================================================================
  print('=== Section 4: Backward contraction ===');

  final backwardFrames = <Map<String, dynamic>>[
    {'base': 5, 'extent': 9, 'label': 'Starting selection: base=5 extent=9'},
    {'base': 5, 'extent': 8, 'label': 'After Shift+Left (1x) — selection shrinks'},
    {'base': 5, 'extent': 7, 'label': 'After Shift+Left (2x)'},
    {'base': 5, 'extent': 6, 'label': 'After Shift+Left (3x)'},
    {'base': 5, 'extent': 5, 'label': 'After Shift+Left (4x) — collapsed again'},
  ];

  final backwardSection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _ecSurface.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _ecMuted.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Selection shrink — backward', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: _ecDark)),
        const SizedBox(height: 4.0),
        Text(
          'When the extent is ahead of the base, pressing Shift+Left contracts the selection '
          'by one character until it collapses.  If you keep going, the extent crosses '
          'the base and selection grows in the opposite direction.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600, height: 1.4),
        ),
        const SizedBox(height: 8.0),
        for (final f in backwardFrames) ecFrameCard(f),
      ],
    ),
  );

  // ================================================================
  // SECTION 5 — Grapheme clusters
  // ================================================================
  print('=== Section 5: Grapheme clusters ===');

  final graphemes = <Map<String, String>>[
    {'text': 'a', 'clusters': '1 cluster → 1 code unit', 'note': 'ASCII — trivial case'},
    {'text': 'ñ', 'clusters': '1 cluster → 1 code unit (U+00F1)', 'note': 'Precomposed Unicode'},
    {'text': 'n\u0303', 'clusters': '1 cluster → 2 code units', 'note': 'Decomposed n + combining tilde'},
    {'text': '👨‍👩‍👧', 'clusters': '1 cluster → 8 code units', 'note': 'Emoji ZWJ family sequence'},
    {'text': '🇫🇷', 'clusters': '1 cluster → 4 code units', 'note': 'Regional indicator pair (flag)'},
    {'text': '🏳️‍🌈', 'clusters': '1 cluster → 6 code units', 'note': 'Flag + ZWJ + rainbow'},
  ];

  Widget ecGraphemeRow(Map<String, String> g, int idx) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: idx.isEven ? _ecLight.withValues(alpha: 0.5) : Colors.white,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        children: [
          Container(
            width: 40.0,
            alignment: Alignment.center,
            child: Text(g['text']!, style: const TextStyle(fontSize: 20.0)),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(g['clusters']!, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: _ecDark)),
                Text(g['note']!, style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final graphemeSection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _ecPrimary.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Grapheme clusters ≠ code units', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: _ecDark)),
        const SizedBox(height: 6.0),
        Text(
          'ExtendSelectionByCharacterIntent moves by one grapheme cluster, '
          'not by one UTF-16 code unit.  A single "character" like a '
          'family emoji can be 8 code units but is treated as one step.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600, height: 1.4),
        ),
        const SizedBox(height: 10.0),
        for (int i = 0; i < graphemes.length; i++) ecGraphemeRow(graphemes[i], i),
      ],
    ),
  );

  // ================================================================
  // SECTION 6 — Keyboard mapping table
  // ================================================================
  print('=== Section 6: Keyboard shortcuts ===');

  final kbRows = <Map<String, String>>[
    {'platform': 'macOS', 'forward': '\u21E7+\u2192', 'backward': '\u21E7+\u2190', 'note': 'Same across locales'},
    {'platform': 'Windows', 'forward': 'Shift+Right', 'backward': 'Shift+Left', 'note': ''},
    {'platform': 'Linux', 'forward': 'Shift+Right', 'backward': 'Shift+Left', 'note': ''},
    {'platform': 'Web', 'forward': 'Shift+Right', 'backward': 'Shift+Left', 'note': 'Follows host OS'},
  ];

  Widget ecKbRow(Map<String, String> r, int idx) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: idx.isEven ? _ecLight.withValues(alpha: 0.5) : Colors.white,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        children: [
          SizedBox(width: 70.0, child: Text(r['platform']!, style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: _ecDark))),
          Expanded(child: Text(r['forward']!, style: TextStyle(fontSize: 12.0, fontFamily: 'monospace', color: _ecAccent))),
          Expanded(child: Text(r['backward']!, style: TextStyle(fontSize: 12.0, fontFamily: 'monospace', color: _ecMuted))),
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
      border: Border.all(color: _ecPrimary.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Platform shortcuts', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: _ecDark)),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(color: _ecPrimary.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(6.0)),
          child: Row(
            children: [
              SizedBox(width: 70.0, child: Text('Platform', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _ecDark))),
              Expanded(child: Text('Forward', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _ecDark))),
              Expanded(child: Text('Backward', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _ecDark))),
              SizedBox(width: 80.0, child: Text('Note', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _ecDark))),
            ],
          ),
        ),
        const SizedBox(height: 4.0),
        for (int i = 0; i < kbRows.length; i++) Padding(padding: const EdgeInsets.only(bottom: 2.0), child: ecKbRow(kbRows[i], i)),
      ],
    ),
  );

  // ================================================================
  // SECTION 7 — Action dispatch pipeline
  // ================================================================
  print('=== Section 7: Dispatch pipeline ===');

  final pipeSteps = <Map<String, String>>[
    {'step': '1', 'title': 'KeyEvent received', 'detail': 'RawKeyboard or HardwareKeyboard sees Shift+Right arrow.'},
    {'step': '2', 'title': 'ShortcutActivator match', 'detail': 'LogicalKeySet(LogicalKeyboardKey.shift, LogicalKeyboardKey.arrowRight) fires.'},
    {'step': '3', 'title': 'Intent created', 'detail': 'Shortcuts widget creates ExtendSelectionByCharacterIntent(forward: true).'},
    {'step': '4', 'title': 'Action resolved', 'detail': 'Actions widget finds the CallbackAction registered in EditableTextState.'},
    {'step': '5', 'title': 'Grapheme boundary lookup', 'detail': 'TextEditingValue delegates to Characters to find the next cluster boundary.'},
    {'step': '6', 'title': 'Selection mutated', 'detail': 'TextEditingController.selection extent is incremented by one cluster.'},
    {'step': '7', 'title': 'Caret repaint', 'detail': 'RenderEditable repaints with the updated selection highlight.'},
  ];

  Widget ecPipeStep(Map<String, String> s, bool isLast) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 30.0, height: 30.0,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: _ecPrimary),
              child: Center(child: Text(s['step']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13.0))),
            ),
            if (!isLast) Container(width: 2.0, height: 30.0, color: _ecMuted.withValues(alpha: 0.3)),
          ],
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 4.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(color: _ecLight.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(8.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s['title']!, style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, color: _ecDark)),
                const SizedBox(height: 2.0),
                Text(s['detail']!, style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.4)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  final pipeSection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.0), border: Border.all(color: _ecPrimary.withValues(alpha: 0.15))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Dispatch pipeline', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: _ecDark)),
        const SizedBox(height: 10.0),
        for (int i = 0; i < pipeSteps.length; i++) ecPipeStep(pipeSteps[i], i == pipeSteps.length - 1),
      ],
    ),
  );

  // ================================================================
  // SECTION 8 — Related intents comparison
  // ================================================================
  print('=== Section 8: Related intents ===');

  final relatives = <Map<String, String>>[
    {'intent': 'ExtendSelectionByCharacterIntent', 'granularity': '1 character', 'typical': 'Shift+Arrow'},
    {'intent': 'ExtendSelectionToNextWordBoundaryIntent', 'granularity': '1 word', 'typical': 'Ctrl+Shift+Arrow'},
    {'intent': 'ExpandSelectionToLineBreakIntent', 'granularity': 'To line end/start', 'typical': 'Shift+Home/End'},
    {'intent': 'ExpandSelectionToDocumentBoundaryIntent', 'granularity': 'To document end/start', 'typical': 'Ctrl+Shift+Home/End'},
    {'intent': 'ExtendSelectionByPageIntent', 'granularity': '1 page', 'typical': 'Shift+PageUp/Down'},
  ];

  Widget ecRelRow(Map<String, String> r, int idx) {
    final isHighlighted = idx == 0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 9.0),
      decoration: BoxDecoration(
        color: isHighlighted
            ? _ecHighlight.withValues(alpha: 0.15)
            : idx.isEven ? _ecLight.withValues(alpha: 0.4) : Colors.white,
        borderRadius: BorderRadius.circular(6.0),
        border: isHighlighted ? Border.all(color: _ecAccent.withValues(alpha: 0.4)) : null,
      ),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(r['intent']!, style: TextStyle(fontSize: 11.0, fontWeight: isHighlighted ? FontWeight.w700 : FontWeight.w500, color: _ecDark))),
          Expanded(flex: 2, child: Text(r['granularity']!, style: TextStyle(fontSize: 11.0, color: _ecAccent))),
          Expanded(flex: 2, child: Text(r['typical']!, style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: _ecMuted))),
        ],
      ),
    );
  }

  final relSection = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.0), border: Border.all(color: _ecPrimary.withValues(alpha: 0.15))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Selection-extension intent family', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: _ecDark)),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(color: _ecPrimary.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(6.0)),
          child: Row(
            children: [
              Expanded(flex: 3, child: Text('Intent', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _ecDark))),
              Expanded(flex: 2, child: Text('Granularity', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _ecDark))),
              Expanded(flex: 2, child: Text('Shortcut', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: _ecDark))),
            ],
          ),
        ),
        const SizedBox(height: 4.0),
        for (int i = 0; i < relatives.length; i++) Padding(padding: const EdgeInsets.only(bottom: 2.0), child: ecRelRow(relatives[i], i)),
      ],
    ),
  );

  // ================================================================
  // SECTION 9 — Custom action patterns
  // ================================================================
  print('=== Section 9: Custom action patterns ===');

  final customPatterns = <Map<String, dynamic>>[
    {
      'title': 'Skip whitespace',
      'icon': Icons.space_bar,
      'desc': 'Override so that Shift+Arrow skips over whitespace characters automatically, selecting non-space content.',
      'code': 'CallbackAction<ExtendSelectionByCharacterIntent>(\n'
          '  onInvoke: (intent) {\n'
          '    var ext = controller.selection.extentOffset;\n'
          '    final delta = intent.forward ? 1 : -1;\n'
          '    while (ext >= 0 && ext < text.length &&\n'
          '           text[ext] == \' \') {\n'
          '      ext += delta;\n'
          '    }\n'
          '    ext += delta;\n'
          '    controller.selection = controller.selection\n'
          '        .copyWith(extentOffset: ext.clamp(0, text.length));\n'
          '    return null;\n'
          '  },\n'
          ')',
    },
    {
      'title': 'Snap to token boundary',
      'icon': Icons.code,
      'desc': 'In a code editor, extend to the nearest token boundary instead of one raw character.',
      'code': 'CallbackAction<ExtendSelectionByCharacterIntent>(\n'
          '  onInvoke: (intent) {\n'
          '    final boundary = findTokenBoundary(\n'
          '      controller.text,\n'
          '      controller.selection.extentOffset,\n'
          '      intent.forward,\n'
          '    );\n'
          '    controller.selection = controller.selection\n'
          '        .copyWith(extentOffset: boundary);\n'
          '    return null;\n'
          '  },\n'
          ')',
    },
    {
      'title': 'Audible feedback',
      'icon': Icons.volume_up,
      'desc': 'Play a click sound when moving by character — useful for accessibility.',
      'code': 'CallbackAction<ExtendSelectionByCharacterIntent>(\n'
          '  onInvoke: (intent) {\n'
          '    audioFeedback.playClick();\n'
          '    return Actions.invoke(context, intent);\n'
          '  },\n'
          ')',
    },
  ];

  Widget ecPatternCard(Map<String, dynamic> p) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: _ecLight.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.0),
        border: Border(left: BorderSide(color: _ecAccent, width: 4.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(p['icon'] as IconData, color: _ecPrimary, size: 22.0),
              const SizedBox(width: 10.0),
              Expanded(child: Text(p['title'] as String, style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: _ecDark))),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(p['desc'] as String, style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700, height: 1.4)),
          const SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(color: _ecDark.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(8.0)),
            child: Text(p['code'] as String, style: TextStyle(fontFamily: 'monospace', fontSize: 11.0, color: _ecDark, height: 1.4)),
          ),
        ],
      ),
    );
  }

  final customSection = Column(
    children: [for (final p in customPatterns) ecPatternCard(p)],
  );

  // ================================================================
  // SECTION 10 — Edge cases
  // ================================================================
  print('=== Section 10: Edge cases ===');

  final edgeCases = <Map<String, String>>[
    {'case': 'At document start, forward=false', 'result': 'No change — offset 0 cannot go lower.'},
    {'case': 'At document end, forward=true', 'result': 'No change — already at max offset.'},
    {'case': 'Emoji at caret', 'result': 'Skips all code units of the emoji in one step.'},
    {'case': 'Combining diacritical mark', 'result': 'Treated as single cluster with its base character.'},
    {'case': 'Surrogate pair (e.g. 𝑎)', 'result': 'Both code units consumed as one character.'},
    {'case': 'Empty text field', 'result': 'Intent dispatched but no movement — offset stays 0.'},
    {'case': 'RTL text', 'result': 'forward=true still means higher offset (logical right).'},
    {'case': 'Selection crosses line boundary', 'result': 'Extent wraps to the next visual line — no special handling needed.'},
  ];

  Widget ecEdgeRow(Map<String, String> e) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: _ecSurface.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: _ecMuted.withValues(alpha: 0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: _ecMuted, size: 18.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(e['case']!, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: _ecDark)),
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
    children: [for (final e in edgeCases) ecEdgeRow(e)],
  );

  // ================================================================
  // SECTION 11 — Performance & frequency notes
  // ================================================================
  print('=== Section 11: Performance ===');

  final perfSection = Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_ecAccent.withValues(alpha: 0.07), _ecLight.withValues(alpha: 0.4)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _ecAccent.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.speed, color: _ecPrimary, size: 22.0),
            const SizedBox(width: 10.0),
            Text('Performance considerations', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: _ecDark)),
          ],
        ),
        const SizedBox(height: 10.0),
        for (final fact in <String>[
          'ExtendSelectionByCharacterIntent is the MOST frequently fired selection intent — users hold Shift+Arrow for rapid selection.',
          'The action must complete in under 1 ms to keep up with key-repeat rate (~33 ms on most OSes).',
          'Grapheme cluster iteration is O(1) when using the Characters class, since each cluster boundary is computed from the current position only.',
          'If a custom action does additional work (e.g., syntax colouring lookup), ensure it is amortized or cached.',
          'setState within the action triggers a single-frame repaint; Flutter batches rapid-fire state updates efficiently.',
        ])
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 6.0, height: 6.0, margin: const EdgeInsets.only(top: 6.0, right: 10.0), decoration: const BoxDecoration(shape: BoxShape.circle, color: _ecAccent)),
                Expanded(child: Text(fact, style: TextStyle(fontSize: 12.0, color: _ecDark, height: 1.45))),
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
    'ExtendSelectionByCharacterIntent moves the selection extent by one grapheme cluster.',
    'forward=true → Shift+Right; forward=false → Shift+Left.',
    'A grapheme cluster can span multiple UTF-16 code units (emoji, combining marks).',
    'The base offset never moves — only the extent is adjusted.',
    'When extent passes the base, the selection direction flips.',
    'Custom actions can override granularity (word snapping, whitespace skipping).',
    'This is the highest-frequency selection intent — keep actions fast.',
    'Platform shortcuts are identical: Shift+Arrow, but macOS uses Shift+Option+Arrow for word-level.',
  ];

  final summarySection = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_ecPrimary.withValues(alpha: 0.08), _ecLight.withValues(alpha: 0.5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _ecPrimary.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: _ecPrimary, size: 24.0),
            const SizedBox(width: 10.0),
            Text('Summary', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: _ecDark)),
          ],
        ),
        const SizedBox(height: 14.0),
        for (final b in summaryBullets)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 6.0, height: 6.0, margin: const EdgeInsets.only(top: 6.0, right: 10.0), decoration: const BoxDecoration(shape: BoxShape.circle, color: _ecAccent)),
                Expanded(child: Text(b, style: TextStyle(fontSize: 13.0, color: _ecDark, height: 1.45))),
              ],
            ),
          ),
      ],
    ),
  );

  print('ExtendSelectionByCharacterIntent deep demo complete');

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
        ecSectionHeader('Inheritance Chain'),
        chainSection,
        const SizedBox(height: 12.0),
        ctorSection,
        const SizedBox(height: 24.0),
        ecSectionHeader('Character-by-Character Selection'),
        framesSection,
        const SizedBox(height: 24.0),
        ecSectionHeader('Backward Contraction'),
        backwardSection,
        const SizedBox(height: 24.0),
        ecSectionHeader('Grapheme Clusters'),
        graphemeSection,
        const SizedBox(height: 24.0),
        ecSectionHeader('Keyboard Shortcuts'),
        kbSection,
        const SizedBox(height: 24.0),
        ecSectionHeader('Dispatch Pipeline'),
        pipeSection,
        const SizedBox(height: 24.0),
        ecSectionHeader('Related Intents'),
        relSection,
        const SizedBox(height: 24.0),
        ecSectionHeader('Custom Action Patterns'),
        customSection,
        const SizedBox(height: 24.0),
        ecSectionHeader('Edge Cases'),
        edgeCaseSection,
        const SizedBox(height: 24.0),
        ecSectionHeader('Performance'),
        perfSection,
        const SizedBox(height: 24.0),
        summarySection,
        const SizedBox(height: 32.0),
      ],
    ),
  );
}

// ──────────────────── shared section header ───────────────────────
Widget ecSectionHeader(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Row(
      children: [
        Container(
          width: 4.0,
          height: 22.0,
          decoration: BoxDecoration(color: _ecAccent, borderRadius: BorderRadius.circular(2.0)),
        ),
        const SizedBox(width: 10.0),
        Text(title, style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: _ecDark)),
      ],
    ),
  );
}
