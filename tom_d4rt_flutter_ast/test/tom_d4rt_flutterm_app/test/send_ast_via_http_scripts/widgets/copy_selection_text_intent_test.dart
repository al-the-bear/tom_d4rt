// ignore_for_file: avoid_print
// Deep demo: CopySelectionTextIntent — copying selected text to clipboard
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// Color palette: Deep Cobalt / Pale Lavender
// ─────────────────────────────────────────────────────────────
const Color _csCobalt = Color(0xFF1A237E);
const Color _csLavender = Color(0xFFEDE7F6);
const Color _csDarkCobalt = Color(0xFF0D1542);
const Color _csMedCobalt = Color(0xFF3949AB);
const Color _csLightCobalt = Color(0xFF9FA8DA);
const Color _csWhite = Color(0xFFFFFFFF);
const Color _csDarkText = Color(0xFF1A1A2E);
const Color _csAccentGreen = Color(0xFF2E7D32);
const Color _csAccentOrange = Color(0xFFE65100);
const Color _csAccentPurple = Color(0xFF6A1B9A);
const Color _csAccentTeal = Color(0xFF00796B);
const Color _csAccentRed = Color(0xFFC62828);

// ─────────────────────────────────────────────────────────────
// Helper builders
// ─────────────────────────────────────────────────────────────
Widget _csSection(String title, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _csWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _csLightCobalt, width: 1.5),
      boxShadow: const [
        BoxShadow(
            color: Color(0x151A237E), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _csCobalt,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(title,
              style: const TextStyle(
                  color: _csWhite,
                  fontSize: 15,
                  fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _csLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            color: _csDarkCobalt,
            fontSize: 13,
            fontWeight: FontWeight.w600)),
  );
}

Widget _csBody(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(
            color: _csDarkText, fontSize: 12.5, height: 1.5)),
  );
}

Widget _csCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _csLightCobalt.withValues(alpha: 0.6)),
    ),
    child: Text(code,
        style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            color: _csDarkCobalt,
            height: 1.45)),
  );
}

Widget _csChip(String text, Color bg, Color fg) {
  return Container(
    margin: const EdgeInsets.only(right: 6, bottom: 4),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(text,
        style:
            TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.w600)),
  );
}

Widget _csDivider() {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 8),
    color: _csLightCobalt.withValues(alpha: 0.4),
  );
}

// ─────────────────────────────────────────────────────────────
// Main build
// ─────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════');
  print('  DEEP DEMO: CopySelectionTextIntent');
  print('  Copying selected text to the system clipboard');
  print('═══════════════════════════════════════════════════');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _csLavender,
      appBarTheme: const AppBarTheme(
        backgroundColor: _csCobalt,
        foregroundColor: _csWhite,
        elevation: 0,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('CopySelectionTextIntent',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          children: [
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Banner
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [_csDarkCobalt, _csCobalt, _csMedCobalt],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: _csWhite.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.content_copy,
                        color: _csWhite, size: 32),
                  ),
                  const SizedBox(height: 14),
                  const Text('CopySelectionTextIntent',
                      style: TextStyle(
                          color: _csWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Text('Copy selected text to the system clipboard',
                      style: TextStyle(
                          color: _csWhite.withValues(alpha: 0.85),
                          fontSize: 13)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _csChip('Ctrl+C', _csWhite.withValues(alpha: 0.25), _csWhite),
                      _csChip('Clipboard', _csWhite.withValues(alpha: 0.25), _csWhite),
                      _csChip('Selection', _csWhite.withValues(alpha: 0.25), _csWhite),
                    ],
                  ),
                ],
              ),
            ),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 1: What is it?
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _csSection('1 · What Is CopySelectionTextIntent?', [
              _csBody(
                'CopySelectionTextIntent is the semantic intent dispatched '
                'when the user requests to copy the currently selected text '
                'to the system clipboard. It is triggered by Ctrl+C (or '
                'Cmd+C on macOS) within text editing contexts.',
              ),
              _csLabel('Intent positioning'),
              _csCodeBlock(
                'Intent (abstract)\n'
                '  └─ CopySelectionTextIntent\n'
                '       • Carries: cause (SelectionChangedCause)\n'
                '       • Dispatched by: Ctrl+C / Cmd+C shortcuts\n'
                '       • Handled by: text editing Actions\n'
                '       • Effect: selection → system clipboard',
              ),
              _csDivider(),
              _csBody(
                'This intent bridges keyboard shortcuts and the clipboard '
                'system. The selection is read, serialized to text, and '
                'placed on the platform clipboard.',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 2: Shortcut → Intent → Action chain
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _csSection('2 · Shortcut → Intent → Action Chain', [
              _csBody(
                'The copy operation follows Flutter\'s standard three-layer '
                'architecture.',
              ),
              ..._buildCopyChain(),
              _csDivider(),
              _csLabel('Wiring'),
              _csCodeBlock(
                'Shortcuts(\n'
                '  shortcuts: {\n'
                '    SingleActivator(LogicalKeyboardKey.keyC,\n'
                '        control: true):\n'
                '        CopySelectionTextIntent(\n'
                '            SelectionChangedCause.keyboard),\n'
                '  },\n'
                '  child: Actions(\n'
                '    actions: {\n'
                '      CopySelectionTextIntent:\n'
                '        _CopySelectionAction(editableText),\n'
                '    },\n'
                '    child: editableTextField,\n'
                '  ),\n'
                ')',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 3: Selection prerequisites
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _csSection('3 · Text Selection Prerequisites', [
              _csBody(
                'The intent only produces a clipboard result when there is '
                'an active text selection (base != extent).',
              ),
              _buildSelectionPrereqs(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 4: Platform shortcuts
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _csSection('4 · Platform Copy Shortcuts', [
              _csBody(
                'Each platform maps different key combinations to the '
                'same CopySelectionTextIntent.',
              ),
              _buildPlatformShortcutsTable(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 5: Clipboard interaction
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _csSection('5 · Clipboard Interaction', [
              _csBody(
                'When the action handles CopySelectionTextIntent, it '
                'interacts with the platform clipboard service.',
              ),
              _buildClipboardFlow(),
              _csDivider(),
              _csCodeBlock(
                '// Simplified copy action implementation:\n'
                'void handleCopy(CopySelectionTextIntent intent) {\n'
                '  final selection = controller.selection;\n'
                '  if (selection.isCollapsed) return;\n'
                '  final text = controller.text.substring(\n'
                '    selection.start, selection.end,\n'
                '  );\n'
                '  Clipboard.setData(ClipboardData(text: text));\n'
                '}',
              ),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 6: Collapse after copy
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _csSection('6 · Selection Behavior After Copy', [
              _csBody(
                'Unlike Cut, Copy preserves the selection. The user can '
                'continue to see what was copied.',
              ),
              _buildCopyVsCutBehavior(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 7: Copy in different widgets
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _csSection('7 · Copy in Different Text Widgets', [
              _csBody(
                'Multiple text widgets respond to CopySelectionTextIntent, '
                'each with slightly different behavior.',
              ),
              ..._buildTextWidgetCards(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 8: Custom copy behavior
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _csSection('8 · Custom Copy Behavior', [
              _csBody(
                'You can override the copy action to modify what gets '
                'copied — redacting sensitive data, adding formatting, '
                'or copying to multiple targets.',
              ),
              ..._buildCustomCopyScenarios(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 9: Rich text vs plain text
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _csSection('9 · Rich Text vs Plain Text Copy', [
              _csBody(
                'The clipboard can hold different MIME types. '
                'CopySelectionTextIntent typically copies plain text.',
              ),
              _buildRichVsPlainComparison(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 10: Accessibility
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _csSection('10 · Accessibility Considerations', [
              _buildAccessibilityItems(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 11: Code editor scenario
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _csSection('11 · Real-World: Code Editor Copy', [
              _csBody(
                'In a code editor, the copy intent is the most frequently '
                'used text intent. Multiple lines, indentation, and syntax '
                'context all affect what gets copied.',
              ),
              _buildCodeEditorDemo(),
            ]),

            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            // Section 12: Summary
            // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            _csSection('12 · Summary', [
              _csBody(
                'CopySelectionTextIntent is the standard way to copy '
                'selected text to the clipboard in Flutter.',
              ),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_csCobalt, _csMedCobalt],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _csSummaryRow(Icons.content_copy, 'Copies selected text to system clipboard'),
                    _csSummaryRow(Icons.keyboard, 'Triggered by Ctrl+C / Cmd+C'),
                    _csSummaryRow(Icons.text_fields, 'Works in TextField, SelectableText, EditableText'),
                    _csSummaryRow(Icons.select_all, 'Requires active selection (non-collapsed)'),
                    _csSummaryRow(Icons.tune, 'Can be overridden for custom copy logic'),
                    _csSummaryRow(Icons.accessible, 'Announced by screen readers'),
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 2: Copy chain
// ─────────────────────────────────────────────────────────────
List<Widget> _buildCopyChain() {
  final layers = <Map<String, dynamic>>[
    {
      'icon': Icons.keyboard,
      'title': 'Shortcut Layer',
      'detail': 'Ctrl+C → CopySelectionTextIntent(cause)',
      'color': _csMedCobalt,
    },
    {
      'icon': Icons.content_copy,
      'title': 'Intent Layer',
      'detail': 'Carries "copy this selection" semantics',
      'color': _csCobalt,
    },
    {
      'icon': Icons.content_paste,
      'title': 'Action Layer',
      'detail': 'Reads selection → writes to Clipboard',
      'color': _csAccentGreen,
    },
  ];
  return layers.map((l) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (l['color'] as Color).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: (l['color'] as Color).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: l['color'] as Color,
              borderRadius: BorderRadius.circular(8),
            ),
            child:
                Icon(l['icon'] as IconData, color: _csWhite, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l['title'] as String,
                    style: TextStyle(
                        color: l['color'] as Color,
                        fontWeight: FontWeight.w700,
                        fontSize: 12)),
                Text(l['detail'] as String,
                    style: const TextStyle(
                        color: _csDarkText, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();
}

// ─────────────────────────────────────────────────────────────
// Section 3: Selection prerequisites
// ─────────────────────────────────────────────────────────────
Widget _buildSelectionPrereqs() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _csLavender,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _csLightCobalt),
    ),
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _csAccentGreen.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: _csAccentGreen.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                const Icon(Icons.check_circle,
                    color: _csAccentGreen, size: 22),
                const SizedBox(height: 4),
                const Text('Has Selection',
                    style: TextStyle(
                        color: _csAccentGreen,
                        fontSize: 11,
                        fontWeight: FontWeight.w700)),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _csWhite,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                        color: _csAccentGreen.withValues(alpha: 0.3)),
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          color: _csDarkText),
                      children: [
                        const TextSpan(text: 'Hello '),
                        TextSpan(
                            text: 'World',
                            style: TextStyle(
                                backgroundColor:
                                    _csMedCobalt.withValues(alpha: 0.3),
                                fontWeight: FontWeight.w700)),
                        const TextSpan(text: '!'),
                      ],
                    ),
                  ),
                ),
                const Text('Ctrl+C → "World" copied',
                    style: TextStyle(
                        color: _csAccentGreen, fontSize: 9)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _csAccentRed.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: _csAccentRed.withValues(alpha: 0.2)),
            ),
            child: Column(
              children: [
                Icon(Icons.cancel,
                    color: _csAccentRed.withValues(alpha: 0.6), size: 22),
                const SizedBox(height: 4),
                Text('No Selection',
                    style: TextStyle(
                        color: _csAccentRed.withValues(alpha: 0.6),
                        fontSize: 11,
                        fontWeight: FontWeight.w700)),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _csWhite,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                        color: _csAccentRed.withValues(alpha: 0.2)),
                  ),
                  child: const Text('Hello World|',
                      style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10,
                          color: _csDarkText)),
                ),
                Text('Ctrl+C → no-op',
                    style: TextStyle(
                        color: _csAccentRed.withValues(alpha: 0.6),
                        fontSize: 9)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 4: Platform shortcuts table
// ─────────────────────────────────────────────────────────────
Widget _buildPlatformShortcutsTable() {
  final rows = <List<String>>[
    ['Platform', 'Primary', 'Secondary', 'Notes'],
    ['macOS', 'Cmd+C', '—', 'Standard macOS convention'],
    ['Windows', 'Ctrl+C', 'Ctrl+Insert', 'Legacy Insert combo'],
    ['Linux', 'Ctrl+C', 'Ctrl+Insert', 'Same as Windows'],
    ['Web', 'Ctrl/Cmd+C', '—', 'Browser delegates to Flutter'],
    ['iOS', 'Long press menu', '—', 'Touch-based selection'],
    ['Android', 'Long press menu', 'Ctrl+C (keyboard)', 'Physical keyboard'],
  ];

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _csLightCobalt),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: rows.asMap().entries.map((entry) {
        final isHeader = entry.key == 0;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
          color: isHeader
              ? _csCobalt
              : entry.key.isEven
                  ? _csLavender
                  : _csWhite,
          child: Row(
            children: entry.value.asMap().entries.map((col) {
              return Expanded(
                flex: col.key == 3 ? 3 : 2,
                child: Text(col.value,
                    style: TextStyle(
                        color: isHeader ? _csWhite : _csDarkText,
                        fontSize: 10,
                        fontWeight:
                            isHeader ? FontWeight.w700 : FontWeight.w400)),
              );
            }).toList(),
          ),
        );
      }).toList(),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 5: Clipboard flow
// ─────────────────────────────────────────────────────────────
Widget _buildClipboardFlow() {
  final steps = <Map<String, dynamic>>[
    {'label': 'Intent dispatched', 'icon': Icons.send, 'color': _csMedCobalt},
    {'label': 'Read TextSelection', 'icon': Icons.select_all, 'color': _csAccentPurple},
    {'label': 'Extract substring', 'icon': Icons.content_cut, 'color': _csAccentOrange},
    {'label': 'Clipboard.setData()', 'icon': Icons.content_paste, 'color': _csAccentGreen},
    {'label': 'Platform clipboard updated', 'icon': Icons.check, 'color': _csAccentTeal},
  ];

  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _csLavender,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _csLightCobalt),
    ),
    child: Column(
      children: steps.asMap().entries.map((entry) {
        final s = entry.value;
        return Container(
          margin: const EdgeInsets.only(bottom: 4),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (s['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
                color: (s['color'] as Color).withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: s['color'] as Color,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text('${entry.key + 1}',
                      style: const TextStyle(
                          color: _csWhite,
                          fontSize: 10,
                          fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(width: 8),
              Icon(s['icon'] as IconData,
                  size: 16, color: s['color'] as Color),
              const SizedBox(width: 6),
              Text(s['label'] as String,
                  style: TextStyle(
                      color: s['color'] as Color,
                      fontSize: 11,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        );
      }).toList(),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 6: Copy vs Cut behavior
// ─────────────────────────────────────────────────────────────
Widget _buildCopyVsCutBehavior() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _csLavender,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _csLightCobalt),
    ),
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _csAccentGreen.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: _csAccentGreen.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                const Icon(Icons.content_copy,
                    color: _csAccentGreen, size: 22),
                const SizedBox(height: 4),
                const Text('Copy (Ctrl+C)',
                    style: TextStyle(
                        color: _csAccentGreen,
                        fontSize: 11,
                        fontWeight: FontWeight.w700)),
                _csDivider(),
                const Text('Selection preserved',
                    style: TextStyle(
                        color: _csAccentGreen, fontSize: 10)),
                const Text('Text remains in field',
                    style: TextStyle(
                        color: _csAccentGreen, fontSize: 10)),
                const Text('Clipboard updated',
                    style: TextStyle(
                        color: _csAccentGreen, fontSize: 10)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _csAccentOrange.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: _csAccentOrange.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                const Icon(Icons.content_cut,
                    color: _csAccentOrange, size: 22),
                const SizedBox(height: 4),
                const Text('Cut (Ctrl+X)',
                    style: TextStyle(
                        color: _csAccentOrange,
                        fontSize: 11,
                        fontWeight: FontWeight.w700)),
                _csDivider(),
                const Text('Selection removed',
                    style: TextStyle(
                        color: _csAccentOrange, fontSize: 10)),
                const Text('Text deleted from field',
                    style: TextStyle(
                        color: _csAccentOrange, fontSize: 10)),
                const Text('Clipboard updated',
                    style: TextStyle(
                        color: _csAccentOrange, fontSize: 10)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 7: Text widget cards
// ─────────────────────────────────────────────────────────────
List<Widget> _buildTextWidgetCards() {
  final widgets = <Map<String, dynamic>>[
    {'name': 'TextField', 'behavior': 'Full copy support, selection handles', 'detail': 'Primary editable text. Copies between base and extent of current selection.', 'icon': Icons.text_fields, 'color': _csMedCobalt},
    {'name': 'SelectableText', 'behavior': 'Read-only copy support', 'detail': 'Non-editable but selectable. User can select and copy but not modify.', 'icon': Icons.text_snippet, 'color': _csAccentPurple},
    {'name': 'EditableText', 'behavior': 'Low-level copy action', 'detail': 'Foundation widget. TextField wraps this. Direct clipboard access.', 'icon': Icons.edit, 'color': _csAccentTeal},
    {'name': 'TextFormField', 'behavior': 'Same as TextField + form', 'detail': 'Form integration. Copy behavior inherited from TextField delegate.', 'icon': Icons.description, 'color': _csAccentGreen},
  ];

  return widgets.map((w) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (w['color'] as Color).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border:
            Border.all(color: (w['color'] as Color).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: w['color'] as Color,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(w['icon'] as IconData,
                    color: _csWhite, size: 15),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(w['name'] as String,
                        style: TextStyle(
                            color: w['color'] as Color,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'monospace')),
                    Text(w['behavior'] as String,
                        style: const TextStyle(
                            color: _csDarkText, fontSize: 10)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(w['detail'] as String,
              style: const TextStyle(
                  color: _csDarkText, fontSize: 10.5, height: 1.3)),
        ],
      ),
    );
  }).toList();
}

// ─────────────────────────────────────────────────────────────
// Section 8: Custom copy scenarios
// ─────────────────────────────────────────────────────────────
List<Widget> _buildCustomCopyScenarios() {
  final scenarios = <Map<String, dynamic>>[
    {
      'name': 'Redact Sensitive Data',
      'desc': 'Replace credit card digits with **** before copying',
      'icon': Icons.security,
      'color': _csAccentRed,
    },
    {
      'name': 'Add Formatting',
      'desc': 'Prepend source URL when copying from an article',
      'icon': Icons.format_quote,
      'color': _csMedCobalt,
    },
    {
      'name': 'Analytics Tracking',
      'desc': 'Log what content users copy most frequently',
      'icon': Icons.analytics,
      'color': _csAccentPurple,
    },
    {
      'name': 'Multi-target Copy',
      'desc': 'Copy to both system clipboard and internal buffer',
      'icon': Icons.copy_all,
      'color': _csAccentTeal,
    },
  ];

  return scenarios.map((s) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: (s['color'] as Color).withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border:
            Border.all(color: (s['color'] as Color).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: s['color'] as Color,
              borderRadius: BorderRadius.circular(6),
            ),
            child:
                Icon(s['icon'] as IconData, color: _csWhite, size: 15),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s['name'] as String,
                    style: TextStyle(
                        color: s['color'] as Color,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700)),
                Text(s['desc'] as String,
                    style: const TextStyle(
                        color: _csDarkText, fontSize: 10, height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();
}

// ─────────────────────────────────────────────────────────────
// Section 9: Rich vs plain comparison
// ─────────────────────────────────────────────────────────────
Widget _buildRichVsPlainComparison() {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _csLavender,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _csLightCobalt),
    ),
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _csMedCobalt.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: _csMedCobalt.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                const Text('Plain Text',
                    style: TextStyle(
                        color: _csMedCobalt,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                const Text('text/plain',
                    style: TextStyle(
                        color: _csMedCobalt,
                        fontSize: 10,
                        fontFamily: 'monospace')),
                _csDivider(),
                const Text('Default for\nCopySelectionTextIntent',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: _csDarkText, fontSize: 10)),
                const SizedBox(height: 4),
                const Text('No formatting\nNo colors\nJust characters',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: _csDarkText, fontSize: 9.5)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _csAccentPurple.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: _csAccentPurple.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                const Text('Rich Text',
                    style: TextStyle(
                        color: _csAccentPurple,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                const Text('text/html',
                    style: TextStyle(
                        color: _csAccentPurple,
                        fontSize: 10,
                        fontFamily: 'monospace')),
                _csDivider(),
                const Text('Custom action\nneeded for HTML copy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: _csDarkText, fontSize: 10)),
                const SizedBox(height: 4),
                const Text('Bold, italic\nColors, links\nStructured content',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: _csDarkText, fontSize: 9.5)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 10: Accessibility items
// ─────────────────────────────────────────────────────────────
Widget _buildAccessibilityItems() {
  final items = <Map<String, dynamic>>[
    {'req': 'Screen reader announces "copied to clipboard"', 'icon': Icons.record_voice_over},
    {'req': 'Keyboard shortcut must work without mouse', 'icon': Icons.keyboard},
    {'req': 'Selection visible before and after copy', 'icon': Icons.visibility},
    {'req': 'Context menu provides Copy option', 'icon': Icons.menu},
    {'req': 'Works with assistive technology selection', 'icon': Icons.accessible},
  ];

  return Column(
    children: items.map((item) {
      return Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _csAccentGreen.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(6),
          border:
              Border.all(color: _csAccentGreen.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Icon(item['icon'] as IconData,
                size: 16, color: _csAccentGreen),
            const SizedBox(width: 8),
            Expanded(
              child: Text(item['req'] as String,
                  style: const TextStyle(
                      color: _csDarkText, fontSize: 11)),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

// ─────────────────────────────────────────────────────────────
// Section 11: Code editor demo
// ─────────────────────────────────────────────────────────────
Widget _buildCodeEditorDemo() {
  final lines = <Map<String, dynamic>>[
    {'num': '1', 'code': 'void main() {', 'selected': false},
    {'num': '2', 'code': '  final greeting = "Hello";', 'selected': true},
    {'num': '3', 'code': '  final name = "Flutter";', 'selected': true},
    {'num': '4', 'code': '  print("\$greeting, \$name!");', 'selected': true},
    {'num': '5', 'code': '}', 'selected': false},
  ];

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _csLightCobalt),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          color: _csCobalt,
          child: Row(
            children: [
              const Icon(Icons.code, color: _csWhite, size: 14),
              const SizedBox(width: 8),
              const Text('main.dart',
                  style: TextStyle(
                      color: _csWhite,
                      fontSize: 11,
                      fontWeight: FontWeight.w600)),
              const Spacer(),
              _csChip('Lines 2-4 selected',
                  _csWhite.withValues(alpha: 0.2), _csWhite),
            ],
          ),
        ),
        Container(
          color: const Color(0xFF1E1E2E),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: lines.map((l) {
              final selected = l['selected'] as bool;
              return Container(
                color: selected
                    ? _csMedCobalt.withValues(alpha: 0.3)
                    : null,
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 2),
                child: Row(
                  children: [
                    SizedBox(
                      width: 24,
                      child: Text(l['num'] as String,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: selected
                                  ? _csLightCobalt
                                  : const Color(0xFF6C6C8A),
                              fontSize: 10,
                              fontFamily: 'monospace')),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(l['code'] as String,
                          style: TextStyle(
                              color: selected
                                  ? _csWhite
                                  : const Color(0xFFA0A0C0),
                              fontSize: 11,
                              fontFamily: 'monospace')),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          color: _csLavender,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _csWhite,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: _csLightCobalt),
                ),
                child: const Text('Ctrl+C',
                    style: TextStyle(
                        color: _csCobalt,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'monospace')),
              ),
              const SizedBox(width: 8),
              const Text('→ 3 lines copied to clipboard',
                  style: TextStyle(
                      color: _csCobalt,
                      fontSize: 11,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// Summary row helper
// ─────────────────────────────────────────────────────────────
Widget _csSummaryRow(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _csWhite.withValues(alpha: 0.9)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: TextStyle(
                  color: _csWhite.withValues(alpha: 0.95),
                  fontSize: 12.5)),
        ),
      ],
    ),
  );
}
