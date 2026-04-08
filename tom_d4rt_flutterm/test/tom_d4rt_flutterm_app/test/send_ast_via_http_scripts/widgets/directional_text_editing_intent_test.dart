// ignore_for_file: avoid_print
// Deep demo: DirectionalTextEditingIntent — abstract base intent for text
// editing operations that have a direction (forward or backward), used by
// Flutter's text editing action system for delete, backspace, and similar ops.
import 'package:flutter/material.dart';

// ────────────────────────────────────────────────────────────
// Theme: Warm Amber (#E65100) on Pale Gold (#FFF3E0)
// Prefix: _te (text editing)
// ────────────────────────────────────────────────────────────

const Color _teAmber = Color(0xFFE65100);
const Color _teGold = Color(0xFFFFF3E0);
const Color _teDarkAmber = Color(0xFFBF360C);
const Color _teLightAmber = Color(0xFFF57C00);
const Color _teMuted = Color(0xFF8D6E63);
const Color _teAccent = Color(0xFFFF8F00);
const Color _teSurface = Color(0xFFFBE9E7);
const Color _teDivider = Color(0xFFFFCCBC);
const Color _teWhite = Color(0xFFFFFFFF);
const Color _teBlack = Color(0xFF212121);
const Color _teError = Color(0xFFC62828);
const Color _teSuccess = Color(0xFF2E7D32);
const Color _teInfo = Color(0xFF0277BD);
const Color _teHighlight = Color(0xFFFFE0B2);

dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Banner ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_teAmber, _teDarkAmber],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _teAmber.withValues(alpha: 0.35),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.edit_note, color: _teGold, size: 36),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'DirectionalTextEditingIntent',
                      style: TextStyle(
                        color: _teGold,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'An abstract base class for intents that represent text '
                'editing operations with a direction — forward (towards end) '
                'or backward (towards start). Concrete subclasses handle '
                'deleting characters, words, and lines.',
                style: TextStyle(
                  color: _teGold.withValues(alpha: 0.9),
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),

        // ── 1. What Is It ──
        _teSection('1. What Is DirectionalTextEditingIntent?'),
        _teBody(
          'DirectionalTextEditingIntent is an abstract Intent subclass '
          'that adds a single property — forward — to indicate the '
          'direction of a text editing operation. When forward is true, '
          'the operation affects text after the cursor (e.g., Delete key). '
          'When false, it affects text before the cursor (e.g., Backspace). '
          'This base class is never instantiated directly; instead, '
          'concrete subclasses like DeleteCharacterIntent, '
          'DeleteToLineBreakIntent, and DeleteToNextWordBoundaryIntent '
          'inherit from it.',
        ),
        const SizedBox(height: 12),
        _teInfoBox(
          'Why a base class?',
          'Having a common ancestor lets the Actions framework handle '
          'all directional text operations uniformly. A single action '
          'can check intent.forward to decide whether to delete '
          'forward or backward, reducing code duplication.',
        ),
        const SizedBox(height: 24),

        // ── 2. The forward Property ──
        _teSection('2. The Forward Property'),
        _teBody(
          'The core of DirectionalTextEditingIntent is the boolean '
          'forward property. It distinguishes between two operation '
          'directions:',
        ),
        const SizedBox(height: 12),
        _buildForwardPropertyComparison(),
        const SizedBox(height: 12),
        _teCodeBlock(
          '// Abstract class definition\n'
          'abstract class DirectionalTextEditingIntent\n'
          '    extends Intent {\n'
          '  const DirectionalTextEditingIntent(this.forward);\n'
          '\n'
          '  /// True = towards end of text (Delete)\n'
          '  /// False = towards start of text (Backspace)\n'
          '  final bool forward;\n'
          '}',
        ),
        const SizedBox(height: 24),

        // ── 3. Concrete Subclasses ──
        _teSection('3. Concrete Subclasses'),
        _teBody(
          'Several concrete intent classes extend '
          'DirectionalTextEditingIntent, each targeting a different '
          'granularity of text deletion:',
        ),
        const SizedBox(height: 12),
        _buildSubclassShowcase(),
        const SizedBox(height: 24),

        // ── 4. Keyboard Mapping ──
        _teSection('4. Keyboard Shortcut Mapping'),
        _teBody(
          'Flutter maps platform keyboard shortcuts to the appropriate '
          'directional text editing intents:',
        ),
        const SizedBox(height: 12),
        _buildKeyboardMappingTable(),
        const SizedBox(height: 24),

        // ── 5. Action Chain ──
        _teSection('5. Intent → Action → Edit Chain'),
        _teBody(
          'When a keyboard shortcut fires, the system creates an intent, '
          'finds the matching action, and applies the text edit. The '
          'direction property guides the operation:',
        ),
        const SizedBox(height: 12),
        _buildActionChain(),
        const SizedBox(height: 24),

        // ── 6. Character Deletion ──
        _teSection('6. Character Deletion Visualization'),
        _teBody(
          'DeleteCharacterIntent is the most common subclass. It deletes '
          'a single character forward or backward from the cursor:',
        ),
        const SizedBox(height: 12),
        _buildCharacterDeletionDemo(),
        const SizedBox(height: 24),

        // ── 7. Word Deletion ──
        _teSection('7. Word Boundary Deletion'),
        _teBody(
          'DeleteToNextWordBoundaryIntent extends the concept to word '
          'boundaries — deleting from cursor to the start or end of '
          'the nearest word:',
        ),
        const SizedBox(height: 12),
        _buildWordDeletionDemo(),
        const SizedBox(height: 24),

        // ── 8. Line Deletion ──
        _teSection('8. Line Break Deletion'),
        _teBody(
          'DeleteToLineBreakIntent deletes everything from cursor to '
          'the start or end of the current line:',
        ),
        const SizedBox(height: 12),
        _buildLineDeletionDemo(),
        const SizedBox(height: 24),

        // ── 9. Selection Awareness ──
        _teSection('9. Selection-Aware Behavior'),
        _teBody(
          'When text is selected, all directional delete intents '
          'behave the same: they delete the selection regardless of '
          'the forward property:',
        ),
        const SizedBox(height: 12),
        _buildSelectionAwareness(),
        const SizedBox(height: 24),

        // ── 10. Platform Differences ──
        _teSection('10. Platform-Specific Behaviors'),
        _teBody(
          'Different platforms have distinct key bindings and behaviors '
          'for directional text editing:',
        ),
        const SizedBox(height: 12),
        _buildPlatformBehaviors(),
        const SizedBox(height: 24),

        // ── 11. Undo Integration ──
        _teSection('11. Undo/Redo Integration'),
        _teBody(
          'All directional text edits are recorded in the undo history. '
          'The direction affects how edits are grouped for undo:',
        ),
        const SizedBox(height: 12),
        _buildUndoIntegration(),
        const SizedBox(height: 24),

        // ── 12. Custom Editor Scenario ──
        _teSection('12. Custom Text Editor Scenario'),
        _teBody(
          'Building a code editor that handles directional delete with '
          'language-aware word boundaries:',
        ),
        const SizedBox(height: 12),
        _buildCustomEditorScenario(),
        const SizedBox(height: 24),

        // ── Summary ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _teAmber.withValues(alpha: 0.08),
                _teGold,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _teAmber.withValues(alpha: 0.25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.summarize, color: _teAmber, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    'Summary',
                    style: TextStyle(
                      color: _teAmber,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _teSummaryRow('Type', 'Abstract Intent base class'),
              _teSummaryRow('Key Property', 'forward (bool)'),
              _teSummaryRow('Subclasses', 'DeleteCharacter, DeleteToWord, DeleteToLine'),
              _teSummaryRow('Forward', 'Delete key — removes after cursor'),
              _teSummaryRow('Backward', 'Backspace — removes before cursor'),
              _teSummaryRow('Selection', 'Deletes selection regardless of direction'),
              _teSummaryRow('Undo', 'All edits recorded in undo history'),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}

// ─── Helper Widgets ──────────────────────────────────────────

Widget _teSection(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      title,
      style: TextStyle(
        color: _teAmber,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.3,
      ),
    ),
  );
}

Widget _teBody(String text) {
  return Text(
    text,
    style: TextStyle(
      color: _teBlack,
      fontSize: 15,
      height: 1.6,
    ),
  );
}

Widget _teCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF3E2723),
      borderRadius: BorderRadius.circular(10),
    ),
    child: SelectableText(
      code,
      style: const TextStyle(
        color: Color(0xFFFFCC80),
        fontSize: 13,
        fontFamily: 'monospace',
        height: 1.5,
      ),
    ),
  );
}

Widget _teInfoBox(String title, String content) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _teInfo.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _teInfo.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.lightbulb_outline, color: _teInfo, size: 18),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: _teInfo,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            color: _teBlack,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _teSummaryRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TextStyle(
              color: _teMuted,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: _teBlack,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _teChip(String text, {Color? color}) {
  final c = color ?? _teAmber;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: c.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: c.withValues(alpha: 0.25)),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: c,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// ─── Builder Functions ───────────────────────────────────────

Widget _buildForwardPropertyComparison() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _teAmber.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _teAmber.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.arrow_forward, color: _teAmber, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'forward: true',
                    style: TextStyle(
                      color: _teAmber,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _teBody('Operates towards the END of text'),
              const SizedBox(height: 6),
              Text(
                'Examples:',
                style: TextStyle(color: _teMuted, fontSize: 12, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text('\u2022 Delete key', style: TextStyle(color: _teBlack, fontSize: 13)),
              Text('\u2022 Fn+Backspace (macOS)', style: TextStyle(color: _teBlack, fontSize: 13)),
              Text('\u2022 Ctrl+Delete (word)', style: TextStyle(color: _teBlack, fontSize: 13)),
              const SizedBox(height: 10),
              // Visual: cursor with text after highlighted
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _teWhite,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _teDivider),
                ),
                child: Row(
                  children: [
                    Text('Hello', style: TextStyle(color: _teBlack, fontSize: 14)),
                    Container(width: 2, height: 18, color: _teAmber),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      color: _teError.withValues(alpha: 0.2),
                      child: Text(' World', style: TextStyle(color: _teError, fontSize: 14)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Red = text affected by forward delete',
                style: TextStyle(color: _teMuted, fontSize: 11),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _teDarkAmber.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _teDarkAmber.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.arrow_back, color: _teDarkAmber, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'forward: false',
                    style: TextStyle(
                      color: _teDarkAmber,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _teBody('Operates towards the START of text'),
              const SizedBox(height: 6),
              Text(
                'Examples:',
                style: TextStyle(color: _teMuted, fontSize: 12, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text('\u2022 Backspace key', style: TextStyle(color: _teBlack, fontSize: 13)),
              Text('\u2022 Ctrl+Backspace (word)', style: TextStyle(color: _teBlack, fontSize: 13)),
              Text('\u2022 Cmd+Backspace (line)', style: TextStyle(color: _teBlack, fontSize: 13)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _teWhite,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _teDivider),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      color: _teError.withValues(alpha: 0.2),
                      child: Text('Hello', style: TextStyle(color: _teError, fontSize: 14)),
                    ),
                    Container(width: 2, height: 18, color: _teDarkAmber),
                    Text(' World', style: TextStyle(color: _teBlack, fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Red = text affected by backward delete',
                style: TextStyle(color: _teMuted, fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildSubclassShowcase() {
  final subclasses = <Map<String, dynamic>>[
    {
      'name': 'DeleteCharacterIntent',
      'granularity': 'Single character',
      'forward': 'Delete key',
      'backward': 'Backspace key',
      'icon': Icons.text_fields,
      'color': _teAmber,
    },
    {
      'name': 'DeleteToNextWordBoundaryIntent',
      'granularity': 'Word boundary',
      'forward': 'Ctrl+Delete',
      'backward': 'Ctrl+Backspace',
      'icon': Icons.text_rotation_none,
      'color': _teLightAmber,
    },
    {
      'name': 'DeleteToLineBreakIntent',
      'granularity': 'Line boundary',
      'forward': 'Ctrl+K (Cmd+Delete)',
      'backward': 'Cmd+Backspace',
      'icon': Icons.wrap_text,
      'color': _teDarkAmber,
    },
  ];

  return Column(
    children: [
      for (var i = 0; i < subclasses.length; i++) ...[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: (subclasses[i]['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: (subclasses[i]['color'] as Color).withValues(alpha: 0.25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(subclasses[i]['icon'] as IconData,
                      color: subclasses[i]['color'] as Color, size: 22),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      subclasses[i]['name'] as String,
                      style: TextStyle(
                        color: subclasses[i]['color'] as Color,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(
                    width: 90,
                    child: Text('Granularity:', style: TextStyle(
                      color: _teMuted, fontSize: 12, fontWeight: FontWeight.w600)),
                  ),
                  Text(subclasses[i]['granularity'] as String,
                      style: TextStyle(color: _teBlack, fontSize: 12)),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  SizedBox(
                    width: 90,
                    child: Text('Forward:', style: TextStyle(
                      color: _teMuted, fontSize: 12, fontWeight: FontWeight.w600)),
                  ),
                  _teChip(subclasses[i]['forward'] as String,
                      color: _teSuccess),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  SizedBox(
                    width: 90,
                    child: Text('Backward:', style: TextStyle(
                      color: _teMuted, fontSize: 12, fontWeight: FontWeight.w600)),
                  ),
                  _teChip(subclasses[i]['backward'] as String,
                      color: _teError),
                ],
              ),
            ],
          ),
        ),
        if (i < subclasses.length - 1) const SizedBox(height: 8),
      ],
    ],
  );
}

Widget _buildKeyboardMappingTable() {
  final mappings = <List<String>>[
    ['Backspace', 'DeleteCharacterIntent(false)', 'All'],
    ['Delete', 'DeleteCharacterIntent(true)', 'All'],
    ['Ctrl+Backspace', 'DeleteToNextWordBoundaryIntent(false)', 'Windows/Linux'],
    ['Ctrl+Delete', 'DeleteToNextWordBoundaryIntent(true)', 'Windows/Linux'],
    ['Option+Backspace', 'DeleteToNextWordBoundaryIntent(false)', 'macOS'],
    ['Option+Delete', 'DeleteToNextWordBoundaryIntent(true)', 'macOS'],
    ['Cmd+Backspace', 'DeleteToLineBreakIntent(false)', 'macOS'],
    ['Ctrl+K', 'DeleteToLineBreakIntent(true)', 'Linux/macOS'],
  ];

  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _teDivider),
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: _teAmber.withValues(alpha: 0.08),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(9),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text('Shortcut', style: TextStyle(
                  color: _teAmber, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 5,
                child: Text('Intent Created', style: TextStyle(
                  color: _teAmber, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 2,
                child: Text('Platform', style: TextStyle(
                  color: _teAmber, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        for (var row in mappings)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: _teDivider)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(row[0], style: TextStyle(
                    color: _teDarkAmber, fontSize: 12,
                    fontWeight: FontWeight.w600)),
                ),
                Expanded(
                  flex: 5,
                  child: Text(row[1], style: TextStyle(
                    color: _teBlack, fontSize: 11,
                    fontFamily: 'monospace')),
                ),
                Expanded(
                  flex: 2,
                  child: Text(row[2], style: TextStyle(
                    color: _teMuted, fontSize: 11)),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _buildActionChain() {
  final steps = <Map<String, dynamic>>[
    {
      'label': 'Key Press',
      'desc': 'User presses Backspace or Delete',
      'icon': Icons.keyboard,
      'color': _teMuted,
    },
    {
      'label': 'Shortcut Match',
      'desc': 'Shortcuts widget maps key to Intent',
      'icon': Icons.route,
      'color': _teInfo,
    },
    {
      'label': 'Intent Created',
      'desc': 'DirectionalTextEditingIntent with forward property',
      'icon': Icons.create,
      'color': _teAmber,
    },
    {
      'label': 'Action Lookup',
      'desc': 'Actions widget finds registered handler',
      'icon': Icons.search,
      'color': _teLightAmber,
    },
    {
      'label': 'Check Direction',
      'desc': 'Action reads intent.forward to decide direction',
      'icon': Icons.compare_arrows,
      'color': _teAccent,
    },
    {
      'label': 'Apply Edit',
      'desc': 'TextEditingController applies the deletion',
      'icon': Icons.delete_outline,
      'color': _teError,
    },
    {
      'label': 'Record Undo',
      'desc': 'Edit pushed to UndoHistory stack',
      'icon': Icons.undo,
      'color': _teSuccess,
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _teSurface,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _teDivider),
    ),
    child: Column(
      children: [
        for (var i = 0; i < steps.length; i++) ...[
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: steps[i]['color'] as Color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(steps[i]['icon'] as IconData,
                    color: _teWhite, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      steps[i]['label'] as String,
                      style: TextStyle(
                        color: (steps[i]['color'] as Color),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      steps[i]['desc'] as String,
                      style: TextStyle(color: _teBlack, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (i < steps.length - 1)
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 3, bottom: 3),
              child: Container(width: 2, height: 12, color: _teDivider),
            ),
        ],
      ],
    ),
  );
}

Widget _buildCharacterDeletionDemo() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _teSurface,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _teDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DeleteCharacterIntent — Step by Step',
          style: TextStyle(
            color: _teAmber, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        // Before state
        _buildTextStateRow('Before:', 'Flut', 't', 'er', isActive: true),
        const SizedBox(height: 6),
        Row(
          children: [
            const SizedBox(width: 60),
            Icon(Icons.arrow_downward, color: _teAmber, size: 16),
            const SizedBox(width: 6),
            Text('DeleteCharacterIntent(forward: true)',
                style: TextStyle(
                  color: _teAmber, fontSize: 11,
                  fontFamily: 'monospace', fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 6),
        _buildTextStateRow('After:', 'Flut', '', 'er', isActive: false),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          height: 1,
          color: _teDivider,
        ),
        const SizedBox(height: 16),
        _buildTextStateRow('Before:', 'Flut', 't', 'er', isActive: true),
        const SizedBox(height: 6),
        Row(
          children: [
            const SizedBox(width: 60),
            Icon(Icons.arrow_downward, color: _teDarkAmber, size: 16),
            const SizedBox(width: 6),
            Text('DeleteCharacterIntent(forward: false)',
                style: TextStyle(
                  color: _teDarkAmber, fontSize: 11,
                  fontFamily: 'monospace', fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 6),
        _buildTextStateRow('After:', 'Flu', '', 'ter', isActive: false),
      ],
    ),
  );
}

Widget _buildTextStateRow(String label, String before, String cursor,
    String after, {required bool isActive}) {
  return Row(
    children: [
      SizedBox(
        width: 56,
        child: Text(label, style: TextStyle(
          color: _teMuted, fontSize: 12, fontWeight: FontWeight.w600)),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: _teWhite,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isActive ? _teAmber : _teDivider,
            width: isActive ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(before, style: TextStyle(color: _teBlack, fontSize: 15,
                fontFamily: 'monospace')),
            if (cursor.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                color: _teError.withValues(alpha: 0.25),
                child: Text(cursor, style: TextStyle(color: _teError,
                    fontSize: 15, fontFamily: 'monospace',
                    fontWeight: FontWeight.bold)),
              )
            else
              Container(width: 2, height: 18, color: _teAmber),
            Text(after, style: TextStyle(color: _teBlack, fontSize: 15,
                fontFamily: 'monospace')),
          ],
        ),
      ),
    ],
  );
}

Widget _buildWordDeletionDemo() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _teSurface,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _teDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Word Boundary Delete — Visual',
          style: TextStyle(
            color: _teLightAmber, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        // Forward word delete
        Row(
          children: [
            SizedBox(
              width: 80,
              child: Text('Original:', style: TextStyle(
                color: _teMuted, fontSize: 12, fontWeight: FontWeight.w600)),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _teWhite,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _teDivider),
                ),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 14, fontFamily: 'monospace'),
                    children: [
                      TextSpan(text: 'Hello ', style: TextStyle(color: _teBlack)),
                      WidgetSpan(child: Container(width: 2, height: 16, color: _teAmber)),
                      TextSpan(
                        text: 'beautiful',
                        style: TextStyle(
                          color: _teError,
                          backgroundColor: _teError.withValues(alpha: 0.12),
                        ),
                      ),
                      TextSpan(text: ' world', style: TextStyle(color: _teBlack)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 80),
          child: Text(
            '\u2192 Ctrl+Delete: deletes "beautiful" (forward to word boundary)',
            style: TextStyle(color: _teMuted, fontSize: 11),
          ),
        ),
        const SizedBox(height: 12),
        // Backward word delete
        Row(
          children: [
            SizedBox(
              width: 80,
              child: Text('Original:', style: TextStyle(
                color: _teMuted, fontSize: 12, fontWeight: FontWeight.w600)),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _teWhite,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _teDivider),
                ),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 14, fontFamily: 'monospace'),
                    children: [
                      TextSpan(text: 'Hello ', style: TextStyle(color: _teBlack)),
                      TextSpan(
                        text: 'beautiful',
                        style: TextStyle(
                          color: _teError,
                          backgroundColor: _teError.withValues(alpha: 0.12),
                        ),
                      ),
                      WidgetSpan(child: Container(width: 2, height: 16, color: _teDarkAmber)),
                      TextSpan(text: ' world', style: TextStyle(color: _teBlack)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 80),
          child: Text(
            '\u2190 Ctrl+Backspace: deletes "beautiful" (backward to word boundary)',
            style: TextStyle(color: _teMuted, fontSize: 11),
          ),
        ),
        const SizedBox(height: 14),
        _teCodeBlock(
          '// Word boundary deletion\n'
          'const forwardWordDelete =\n'
          '    DeleteToNextWordBoundaryIntent(\n'
          '  forward: true,\n'
          ');\n'
          '\n'
          'const backwardWordDelete =\n'
          '    DeleteToNextWordBoundaryIntent(\n'
          '  forward: false,\n'
          ');',
        ),
      ],
    ),
  );
}

Widget _buildLineDeletionDemo() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _teSurface,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _teDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Line Break Delete — Before & After',
          style: TextStyle(
            color: _teDarkAmber, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 14),
        Text(
          'Forward (Ctrl+K / Cmd+Delete):',
          style: TextStyle(color: _teAmber, fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _teWhite,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: _teDivider),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 13, fontFamily: 'monospace'),
                  children: [
                    TextSpan(text: 'The quick ', style: TextStyle(color: _teBlack)),
                    WidgetSpan(child: Container(width: 2, height: 15, color: _teAmber)),
                    TextSpan(
                      text: 'brown fox jumps',
                      style: TextStyle(
                        color: _teError,
                        backgroundColor: _teError.withValues(alpha: 0.12),
                      ),
                    ),
                  ],
                ),
              ),
              Text('over the lazy dog',
                  style: TextStyle(color: _teBlack, fontSize: 13,
                      fontFamily: 'monospace')),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text('Deletes "brown fox jumps" (cursor to end of line)',
            style: TextStyle(color: _teMuted, fontSize: 11)),
        const SizedBox(height: 14),
        Text(
          'Backward (Cmd+Backspace):',
          style: TextStyle(color: _teDarkAmber, fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _teWhite,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: _teDivider),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 13, fontFamily: 'monospace'),
                  children: [
                    TextSpan(
                      text: 'The quick brown',
                      style: TextStyle(
                        color: _teError,
                        backgroundColor: _teError.withValues(alpha: 0.12),
                      ),
                    ),
                    WidgetSpan(child: Container(width: 2, height: 15, color: _teDarkAmber)),
                    TextSpan(text: ' fox jumps', style: TextStyle(color: _teBlack)),
                  ],
                ),
              ),
              Text('over the lazy dog',
                  style: TextStyle(color: _teBlack, fontSize: 13,
                      fontFamily: 'monospace')),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text('Deletes "The quick brown" (start of line to cursor)',
            style: TextStyle(color: _teMuted, fontSize: 11)),
      ],
    ),
  );
}

Widget _buildSelectionAwareness() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _teHighlight.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _teAccent.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.select_all, color: _teAccent, size: 20),
            const SizedBox(width: 8),
            Text('Selection Override',
                style: TextStyle(color: _teAccent, fontSize: 14,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 12),
        // With selection
        Row(
          children: [
            SizedBox(width: 60, child: Text('Text:', style: TextStyle(
              color: _teMuted, fontSize: 12, fontWeight: FontWeight.w600))),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: _teWhite,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _teDivider),
              ),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 14, fontFamily: 'monospace'),
                  children: [
                    TextSpan(text: 'Hello ', style: TextStyle(color: _teBlack)),
                    TextSpan(
                      text: 'beautiful',
                      style: TextStyle(
                        color: _teWhite,
                        backgroundColor: _teAccent,
                      ),
                    ),
                    TextSpan(text: ' world', style: TextStyle(color: _teBlack)),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Any directional delete intent \u2192 deletes "beautiful"',
                style: TextStyle(color: _teBlack, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                'forward: true AND forward: false both produce the same '
                'result when text is selected',
                style: TextStyle(color: _teMuted, fontSize: 11,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            SizedBox(width: 60, child: Text('Result:', style: TextStyle(
              color: _teMuted, fontSize: 12, fontWeight: FontWeight.w600))),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: _teWhite,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _teSuccess.withValues(alpha: 0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Hello ', style: TextStyle(color: _teBlack, fontSize: 14,
                      fontFamily: 'monospace')),
                  Container(width: 2, height: 16, color: _teAccent),
                  Text(' world', style: TextStyle(color: _teBlack, fontSize: 14,
                      fontFamily: 'monospace')),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildPlatformBehaviors() {
  final platforms = <Map<String, dynamic>>[
    {
      'platform': 'macOS',
      'bindings': [
        'Option+Delete: word forward',
        'Option+Backspace: word backward',
        'Cmd+Delete: line forward',
        'Cmd+Backspace: line backward',
      ],
      'icon': Icons.desktop_mac,
      'color': _teAmber,
    },
    {
      'platform': 'Windows / Linux',
      'bindings': [
        'Ctrl+Delete: word forward',
        'Ctrl+Backspace: word backward',
        'No native line-delete shortcut',
        'Some editors add Ctrl+K',
      ],
      'icon': Icons.desktop_windows,
      'color': _teLightAmber,
    },
    {
      'platform': 'iOS / Android',
      'bindings': [
        'Backspace: character backward',
        'Software keyboard only',
        'Long-press for selection delete',
        'No word/line shortcuts',
      ],
      'icon': Icons.phone_android,
      'color': _teMuted,
    },
    {
      'platform': 'Web',
      'bindings': [
        'Inherits host platform shortcuts',
        'Ctrl/Cmd modifiers work as expected',
        'Browser may intercept some combos',
        'Backspace can trigger browser back',
      ],
      'icon': Icons.public,
      'color': _teInfo,
    },
  ];

  return Wrap(
    spacing: 10,
    runSpacing: 10,
    children: [
      for (var p in platforms)
        Container(
          width: 180,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: (p['color'] as Color).withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: (p['color'] as Color).withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(p['icon'] as IconData,
                      color: p['color'] as Color, size: 20),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      p['platform'] as String,
                      style: TextStyle(
                        color: p['color'] as Color,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              for (var binding in (p['bindings'] as List<String>))
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(
                    '\u2022 $binding',
                    style: TextStyle(color: _teBlack, fontSize: 11, height: 1.3),
                  ),
                ),
            ],
          ),
        ),
    ],
  );
}

Widget _buildUndoIntegration() {
  final entries = <Map<String, String>>[
    {
      'action': 'Type "Hello"',
      'undo': 'Grouped as single typing run',
    },
    {
      'action': 'Backspace (delete "o")',
      'undo': 'New undo entry for backward delete',
    },
    {
      'action': 'Ctrl+Backspace (delete "Hell")',
      'undo': 'New undo entry for word delete',
    },
    {
      'action': 'Undo (Ctrl+Z)',
      'undo': 'Restores "Hell" — word delete reversed',
    },
    {
      'action': 'Undo again',
      'undo': 'Restores "Hello" — character delete reversed',
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _teSurface,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _teDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.history, color: _teAmber, size: 20),
            const SizedBox(width: 8),
            Text('Undo Stack Visualization',
                style: TextStyle(color: _teAmber, fontSize: 14,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 12),
        for (var i = 0; i < entries.length; i++) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: i < 3
                      ? _teAmber.withValues(alpha: 0.12)
                      : _teSuccess.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      color: i < 3 ? _teAmber : _teSuccess,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entries[i]['action']!,
                      style: TextStyle(
                        color: _teBlack,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      entries[i]['undo']!,
                      style: TextStyle(color: _teMuted, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (i < entries.length - 1) const SizedBox(height: 8),
        ],
      ],
    ),
  );
}

Widget _buildCustomEditorScenario() {
  final steps = <Map<String, String>>[
    {
      'step': 'Define custom word boundaries',
      'detail': 'CamelCase-aware: "handleClick" becomes "handle" + "Click"',
    },
    {
      'step': 'Create custom action',
      'detail': 'Override DeleteToNextWordBoundaryAction to use custom boundaries',
    },
    {
      'step': 'Register in Actions widget',
      'detail': 'Map DeleteToNextWordBoundaryIntent to custom action',
    },
    {
      'step': 'Check intent.forward',
      'detail': 'Forward: delete from cursor to next camelCase boundary right. '
          'Backward: delete from cursor to previous boundary left.',
    },
    {
      'step': 'Apply text edit',
      'detail': 'Update TextEditingController with new value and cursor position',
    },
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _teSurface,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _teDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: _teAmber, size: 20),
            const SizedBox(width: 8),
            Text(
              'Custom Code Editor with CamelCase Delete',
              style: TextStyle(
                color: _teAmber,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        for (var i = 0; i < steps.length; i++) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: _teAmber.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: Text(
                    '${i + 1}',
                    style: TextStyle(
                      color: _teAmber,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      steps[i]['step']!,
                      style: TextStyle(
                        color: _teDarkAmber,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      steps[i]['detail']!,
                      style: TextStyle(
                        color: _teBlack,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (i < steps.length - 1) const SizedBox(height: 10),
        ],
        const SizedBox(height: 14),
        _teCodeBlock(
          '// Custom CamelCase word delete action\n'
          'class CamelCaseDeleteAction\n'
          '    extends Action<DeleteToNextWordBoundaryIntent> {\n'
          '  CamelCaseDeleteAction(this.controller);\n'
          '  final TextEditingController controller;\n'
          '\n'
          '  @override\n'
          '  void invoke(\n'
          '    DeleteToNextWordBoundaryIntent intent,\n'
          '  ) {\n'
          '    final text = controller.text;\n'
          '    final offset = controller.selection\n'
          '        .baseOffset;\n'
          '    final boundary = intent.forward\n'
          '        ? _nextCamelBoundary(text, offset)\n'
          '        : _prevCamelBoundary(text, offset);\n'
          '    final start = intent.forward\n'
          '        ? offset : boundary;\n'
          '    final end = intent.forward\n'
          '        ? boundary : offset;\n'
          '    controller.value = TextEditingValue(\n'
          '      text: text.replaceRange(start, end, ""),\n'
          '      selection: TextSelection.collapsed(\n'
          '        offset: start,\n'
          '      ),\n'
          '    );\n'
          '  }\n'
          '}',
        ),
      ],
    ),
  );
}
