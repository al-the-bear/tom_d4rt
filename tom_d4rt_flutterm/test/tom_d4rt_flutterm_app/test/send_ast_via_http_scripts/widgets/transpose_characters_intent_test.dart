// D4rt test script: Deep Demo — TransposeCharactersIntent
// ----------------------------------------------------------------------------
// TransposeCharactersIntent is a zero-field [Intent] subclass that represents
// the semantic command "swap the two characters immediately around the caret".
// It lives in package:flutter/src/widgets/text_editing_intents.dart and, by
// default, is wired by [DefaultTextEditingShortcuts] to Ctrl+T (or its Apple
// equivalent) on every focused [EditableText]. The action the framework binds
// to it lives inside EditableText's state and uses the private
// `_transposeCharacters` helper — but because the intent is a public contract
// any subtree can install its own [Action] via [Actions] and intercept or
// augment the default behaviour.
//
// This deep-demo visualises that story as a typewriter lab: amber paper
// panels, ink-black monospace copy, and interactive experiments showing the
// intent firing in real time, rewired to custom actions, and manually invoked
// from a button. Nothing here relies on `flutter_test` — this is a d4rt
// harness script that returns a MaterialApp from `build(BuildContext)`.
// ----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// D4RT-SCRIPT-LIMITATION: layout cascade (Fa1 EditableText pocket)
//
// Emits 2 FE: BoxConstraints negative-minimum-height on
// `_RenderEditableCustomPaint`, followed by the
// `!childSemantics.renderObject._needsLayout` semantics-layout race
// (object.dart:5737). Same shape as
// `widgets/select_all_text_intent_test.dart` — Tier-A TextField in
// a stretched Column whose grandparent computes a vertical extent
// that shrinks to negative minimum height while semantics tries to
// dirty-walk the editable's render object.
//
// Closing route documented in interpreter_unfixable.md §Fa1-N1
// (EditableText sub-pocket): pin the TextField parent height with
// `SizedBox(height: <fixed>)` or replace the live TextField with a
// SelectableText + static caret glyph. Deferred — the live
// TextField is the demo's primary surface for showing
// transpose-characters dispatch.
//
// Sentinel: test/fa1_bisect_test.dart [fa1-2250-sentinel].

// ============================================================================
// Palette & typography — one place, one truth.
// ============================================================================

const Color _tciLabPaper = Color(0xFFF6ECD4);
const Color _tciLabPaperDark = Color(0xFFE8D9B0);
const Color _tciLabInk = Color(0xFF1F1A12);
const Color _tciLabInkSoft = Color(0xFF3B3326);
const Color _tciLabAmber = Color(0xFFB8860B);
const Color _tciLabAmberDeep = Color(0xFF8B6508);
const Color _tciLabRibbon = Color(0xFFC23B22);
const Color _tciLabStamp = Color(0xFF2E4A3A);
const Color _tciLabShadow = Color(0xFF2A2216);

const String _tciLabFontMono = 'monospace';

TextStyle _tciLabMono({
  double size = 13,
  FontWeight weight = FontWeight.w500,
  Color color = _tciLabInk,
  double height = 1.4,
  FontStyle style = FontStyle.normal,
  double letters = 0,
}) {
  return TextStyle(
    fontFamily: _tciLabFontMono,
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: height,
    fontStyle: style,
    letterSpacing: letters,
  );
}

// ============================================================================
// Paper panel — a reusable card chrome used by every scenario.
// ============================================================================

class _TciLabPaperPanel extends StatelessWidget {
  const _TciLabPaperPanel({
    required this.title,
    required this.subtitle,
    required this.stampLabel,
    required this.stampColor,
    required this.body,
    this.footnote,
  });

  final String title;
  final String subtitle;
  final String stampLabel;
  final Color stampColor;
  final Widget body;
  final String? footnote;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: _tciLabPaper,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: _tciLabShadow.withValues(alpha: 0.35),
            blurRadius: 14,
            offset: const Offset(4, 6),
          ),
          BoxShadow(
            color: _tciLabShadow.withValues(alpha: 0.12),
            blurRadius: 2,
            offset: const Offset(1, 1),
          ),
        ],
        border: Border.all(color: _tciLabPaperDark, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 18, 22, 22),
            child: body,
          ),
          if (footnote != null) _buildFootnote(footnote!),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 16, 18, 14),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: _tciLabPaperDark.withValues(alpha: 0.8),
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: _tciLabMono(
                    size: 18,
                    weight: FontWeight.w800,
                    color: _tciLabInk,
                    letters: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: _tciLabMono(
                    size: 12,
                    weight: FontWeight.w500,
                    color: _tciLabInkSoft,
                    style: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          _TciLabStampBadge(label: stampLabel, color: stampColor),
        ],
      ),
    );
  }

  Widget _buildFootnote(String text) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 10, 22, 14),
      decoration: BoxDecoration(
        color: _tciLabAmber.withValues(alpha: 0.12),
        border: Border(
          top: BorderSide(
            color: _tciLabPaperDark.withValues(alpha: 0.6),
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.push_pin_outlined,
              size: 16, color: _tciLabAmberDeep),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: _tciLabMono(
                size: 12,
                color: _tciLabInkSoft,
                style: FontStyle.italic,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TciLabStampBadge extends StatelessWidget {
  const _TciLabStampBadge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.06,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(4),
          color: color.withValues(alpha: 0.08),
        ),
        child: Text(
          label.toUpperCase(),
          style: _tciLabMono(
            size: 10,
            color: color,
            weight: FontWeight.w900,
            letters: 1.2,
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// Pill badge used for rendering logical keys and other short labels.
// ============================================================================

class _TciLabKeyPill extends StatelessWidget {
  const _TciLabKeyPill({
    required this.label,
    this.dim = false,
  });

  final String label;
  final bool dim;

  @override
  Widget build(BuildContext context) {
    final Color bg = dim
        ? _tciLabPaperDark.withValues(alpha: 0.5)
        : _tciLabInk.withValues(alpha: 0.92);
    final Color fg = dim ? _tciLabInkSoft : _tciLabPaper;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        boxShadow: dim
            ? null
            : [
                BoxShadow(
                  color: _tciLabShadow.withValues(alpha: 0.35),
                  blurRadius: 2,
                  offset: const Offset(1, 2),
                ),
              ],
        border: Border.all(
          color: dim ? _tciLabPaperDark : _tciLabInk,
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: _tciLabMono(
          size: 11,
          color: fg,
          weight: FontWeight.w800,
          letters: 0.6,
        ),
      ),
    );
  }
}

// ============================================================================
// Section header divider between scenarios.
// ============================================================================

class _TciLabDivider extends StatelessWidget {
  const _TciLabDivider({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 24, 28, 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _tciLabAmber.withValues(alpha: 0.0),
                    _tciLabAmber.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              label.toUpperCase(),
              style: _tciLabMono(
                size: 11,
                color: _tciLabAmberDeep,
                weight: FontWeight.w900,
                letters: 2.2,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _tciLabAmber.withValues(alpha: 0.7),
                    _tciLabAmber.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Scenario 1 — Preamble: what the intent means.
// ============================================================================

class _TciLabPreambleCard extends StatelessWidget {
  const _TciLabPreambleCard();

  @override
  Widget build(BuildContext context) {
    final List<_TciLabPreambleFact> facts = <_TciLabPreambleFact>[
      const _TciLabPreambleFact(
        emoji: '\u{270D}',
        caption: 'Intent vs Action',
        body: 'TransposeCharactersIntent is a zero-field marker. It declares '
            '"swap characters around the caret" without specifying how. The '
            'matching Action — resolved by Actions.maybeFind — does the work.',
      ),
      const _TciLabPreambleFact(
        emoji: '\u{2328}',
        caption: 'Default binding',
        body: 'DefaultTextEditingShortcuts binds SingleActivator(keyT, '
            'control: true) to const TransposeCharactersIntent(). Every '
            'EditableText therefore gets Ctrl+T for free.',
      ),
      const _TciLabPreambleFact(
        emoji: '\u{1F4DC}',
        caption: 'Semantic, not literal',
        body: 'The intent names the user goal. Screen readers, tests, and '
            'platform integrations can dispatch the same intent without '
            'caring that Ctrl+T happens to be the desktop shortcut.',
      ),
      const _TciLabPreambleFact(
        emoji: '\u{1F39E}',
        caption: 'Live editability',
        body: 'When invoked, the built-in Action rewrites the selection range '
            'so the two characters flanking the caret trade places. Undo is '
            'tracked by the underlying text input history.',
      ),
    ];

    return _TciLabPaperPanel(
      title: 'Preamble — what TransposeCharactersIntent means',
      subtitle: 'const Intent marker bound to Ctrl+T by DefaultTextEditingShortcuts',
      stampLabel: 'concept',
      stampColor: _tciLabStamp,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _tciLabInk,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'class TransposeCharactersIntent extends Intent {\n'
              '  const TransposeCharactersIntent();\n'
              '}',
              style: _tciLabMono(
                size: 13,
                color: _tciLabPaper,
                height: 1.55,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ...facts.map<Widget>(
            (_TciLabPreambleFact fact) => _TciLabPreambleRow(fact: fact),
          ),
        ],
      ),
      footnote: 'Source: package:flutter/src/widgets/text_editing_intents.dart, '
          'line 383. Wired at package:flutter/src/widgets/default_text_editing_shortcuts.dart line 681.',
    );
  }
}

class _TciLabPreambleFact {
  const _TciLabPreambleFact({
    required this.emoji,
    required this.caption,
    required this.body,
  });

  final String emoji;
  final String caption;
  final String body;
}

class _TciLabPreambleRow extends StatelessWidget {
  const _TciLabPreambleRow({required this.fact});

  final _TciLabPreambleFact fact;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _tciLabAmber.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _tciLabAmberDeep, width: 1.4),
            ),
            child: Text(fact.emoji, style: const TextStyle(fontSize: 18)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  fact.caption,
                  style: _tciLabMono(
                    size: 13,
                    weight: FontWeight.w800,
                    color: _tciLabAmberDeep,
                    letters: 0.4,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  fact.body,
                  style: _tciLabMono(
                    size: 12,
                    color: _tciLabInkSoft,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Scenario 2 — Live typewriter with a real TextField and a snapshot strip.
// ============================================================================

class _TciLabTypewriterCard extends StatefulWidget {
  const _TciLabTypewriterCard();

  @override
  State<_TciLabTypewriterCard> createState() => _TciLabTypewriterCardState();
}

class _TciLabTypewriterCardState extends State<_TciLabTypewriterCard> {
  final TextEditingController _controller =
      TextEditingController(text: 'type hear and press Ctrl+T');
  final FocusNode _focusNode = FocusNode(debugLabel: 'TciLabLiveField');
  final List<_TciLabSnapshot> _snapshots = <_TciLabSnapshot>[];

  String _lastText = '';
  int _fireCount = 0;

  @override
  void initState() {
    super.initState();
    _lastText = _controller.text;
    _controller.addListener(_maybeRecordTranspose);
  }

  @override
  void dispose() {
    _controller.removeListener(_maybeRecordTranspose);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _maybeRecordTranspose() {
    final String now = _controller.text;
    if (now == _lastText) {
      return;
    }
    // Detect a "swap" mutation: same length, exactly two characters changed
    // at adjacent indices — the signature of a transpose.
    if (now.length == _lastText.length) {
      int firstDiff = -1;
      int lastDiff = -1;
      for (int i = 0; i < now.length; i++) {
        if (now[i] != _lastText[i]) {
          if (firstDiff == -1) {
            firstDiff = i;
          }
          lastDiff = i;
        }
      }
      if (firstDiff != -1 &&
          lastDiff - firstDiff == 1 &&
          now[firstDiff] == _lastText[lastDiff] &&
          now[lastDiff] == _lastText[firstDiff]) {
        setState(() {
          _fireCount++;
          _snapshots.insert(
            0,
            _TciLabSnapshot(
              before: _lastText,
              after: now,
              swapAt: firstDiff,
              when: DateTime.now(),
            ),
          );
          if (_snapshots.length > 6) {
            _snapshots.removeLast();
          }
        });
      }
    }
    _lastText = now;
  }

  @override
  Widget build(BuildContext context) {
    return _TciLabPaperPanel(
      title: 'Live typewriter — watch the intent fire',
      subtitle:
          'Click into the field, position the caret, hit Ctrl+T (\u2303T on macOS).',
      stampLabel: 'interactive',
      stampColor: _tciLabRibbon,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildFocusBar(),
          const SizedBox(height: 14),
          _buildField(),
          const SizedBox(height: 16),
          _buildCounter(),
          const SizedBox(height: 14),
          _buildHistory(),
        ],
      ),
      footnote:
          'Transposes are detected heuristically: same length, adjacent swap. '
          'The intent itself is fired inside EditableText by the default '
          'Action bound in DefaultTextEditingShortcuts.',
    );
  }

  Widget _buildFocusBar() {
    return AnimatedBuilder(
      animation: _focusNode,
      builder: (BuildContext context, Widget? child) {
        final bool has = _focusNode.hasFocus;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: has
                ? _tciLabStamp.withValues(alpha: 0.12)
                : _tciLabPaperDark.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: has ? _tciLabStamp : _tciLabPaperDark,
              width: 1,
            ),
          ),
          child: Row(
            children: <Widget>[
              Icon(
                has ? Icons.radio_button_checked : Icons.radio_button_off,
                size: 14,
                color: has ? _tciLabStamp : _tciLabInkSoft,
              ),
              const SizedBox(width: 8),
              Text(
                has ? 'focus: acquired — intent is listening' : 'focus: idle',
                style: _tciLabMono(
                  size: 12,
                  color: has ? _tciLabStamp : _tciLabInkSoft,
                  weight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              _TciLabKeyPill(label: 'Ctrl', dim: !has),
              const Text(' + ', style: TextStyle(fontFamily: _tciLabFontMono)),
              _TciLabKeyPill(label: 'T', dim: !has),
            ],
          ),
        );
      },
    );
  }

  Widget _buildField() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: _tciLabPaperDark.withValues(alpha: 0.3),
        border: Border.all(color: _tciLabAmberDeep, width: 1.5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        autofocus: false,
        style: _tciLabMono(size: 16, color: _tciLabInk, weight: FontWeight.w600),
        decoration: InputDecoration(
          filled: true,
          fillColor: _tciLabPaper,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          hintText: 'transpose me',
          hintStyle: _tciLabMono(
            color: _tciLabInkSoft.withValues(alpha: 0.6),
            style: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  Widget _buildCounter() {
    return Row(
      children: <Widget>[
        Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _tciLabAmberDeep,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: _tciLabShadow.withValues(alpha: 0.3),
                blurRadius: 3,
                offset: const Offset(1, 2),
              ),
            ],
          ),
          child: Text(
            '$_fireCount',
            style: _tciLabMono(
              size: 18,
              color: _tciLabPaper,
              weight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            _fireCount == 0
                ? 'No transposes yet. Place your caret between two letters and press Ctrl+T.'
                : 'Intent fired $_fireCount time${_fireCount == 1 ? '' : 's'}. '
                    'Each hit reordered exactly two adjacent code units.',
            style: _tciLabMono(size: 12, color: _tciLabInkSoft, height: 1.5),
          ),
        ),
      ],
    );
  }

  Widget _buildHistory() {
    if (_snapshots.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _tciLabPaperDark.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: _tciLabPaperDark,
            width: 1,
          ),
        ),
        child: Text(
          '(history is empty — snapshots appear here once the intent fires)',
          style: _tciLabMono(
            size: 12,
            color: _tciLabInkSoft,
            style: FontStyle.italic,
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text('recent transposes', style: _tciLabMono(
          size: 11,
          color: _tciLabAmberDeep,
          weight: FontWeight.w900,
          letters: 1.6,
        )),
        const SizedBox(height: 6),
        ..._snapshots.map<Widget>((_TciLabSnapshot s) => _buildSnapshotRow(s)),
      ],
    );
  }

  Widget _buildSnapshotRow(_TciLabSnapshot s) {
    final String time = '${s.when.hour.toString().padLeft(2, '0')}:'
        '${s.when.minute.toString().padLeft(2, '0')}:'
        '${s.when.second.toString().padLeft(2, '0')}';
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _tciLabPaper,
        border: Border.all(color: _tciLabPaperDark),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            color: _tciLabInk,
            child: Text(time,
                style: _tciLabMono(
                    size: 10, color: _tciLabPaper, weight: FontWeight.w700)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: _tciLabMono(size: 12, color: _tciLabInk),
                children: <InlineSpan>[
                  const TextSpan(text: 'before: '),
                  TextSpan(
                    text: '"${s.before}"',
                    style: _tciLabMono(
                        size: 12,
                        color: _tciLabRibbon,
                        weight: FontWeight.w700),
                  ),
                  const TextSpan(text: '  \u2192  after: '),
                  TextSpan(
                    text: '"${s.after}"',
                    style: _tciLabMono(
                        size: 12,
                        color: _tciLabStamp,
                        weight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: _tciLabAmber.withValues(alpha: 0.2),
              border: Border.all(color: _tciLabAmberDeep),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text('@${s.swapAt}',
                style: _tciLabMono(
                    size: 10,
                    color: _tciLabAmberDeep,
                    weight: FontWeight.w900)),
          ),
        ],
      ),
    );
  }
}

class _TciLabSnapshot {
  const _TciLabSnapshot({
    required this.before,
    required this.after,
    required this.swapAt,
    required this.when,
  });

  final String before;
  final String after;
  final int swapAt;
  final DateTime when;
}

// ============================================================================
// Scenario 3 — Custom Actions scope that intercepts the intent.
// ============================================================================

class _TciLabCustomActionCard extends StatefulWidget {
  const _TciLabCustomActionCard();

  @override
  State<_TciLabCustomActionCard> createState() =>
      _TciLabCustomActionCardState();
}

class _TciLabCustomActionCardState extends State<_TciLabCustomActionCard> {
  final TextEditingController _controller =
      TextEditingController(text: 'custom transpose listens here');
  final FocusNode _focusNode = FocusNode(debugLabel: 'TciLabCustomField');
  final ValueNotifier<List<String>> _log = ValueNotifier<List<String>>(<String>[]);

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _log.dispose();
    super.dispose();
  }

  void _record(String line) {
    final List<String> next = <String>[line, ..._log.value];
    if (next.length > 5) {
      next.removeLast();
    }
    _log.value = next;
  }

  @override
  Widget build(BuildContext context) {
    return _TciLabPaperPanel(
      title: 'Custom Actions scope — intercept + delegate',
      subtitle:
          'Wrap a subtree in Actions and register a CallbackAction<TransposeCharactersIntent>',
      stampLabel: 'override',
      stampColor: _tciLabAmberDeep,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _tciLabInk,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'Actions(\n'
              '  actions: <Type, Action<Intent>>{\n'
              '    TransposeCharactersIntent: CallbackAction<TransposeCharactersIntent>(\n'
              '      onInvoke: (TransposeCharactersIntent intent) {\n'
              '        // log, then null means "did not consume".\n'
              '        return null;\n'
              '      },\n'
              '    ),\n'
              '  },\n'
              '  child: TextField(...),\n'
              ')',
              style: _tciLabMono(size: 12, color: _tciLabPaper, height: 1.55),
            ),
          ),
          const SizedBox(height: 14),
          Actions(
            actions: <Type, Action<Intent>>{
              TransposeCharactersIntent:
                  CallbackAction<TransposeCharactersIntent>(
                onInvoke: (TransposeCharactersIntent intent) {
                  final String snapshot = _controller.text;
                  _record('intercepted: "$snapshot"');
                  // Returning null falls back to framework default so the user
                  // still sees the visible transpose happen.
                  return null;
                },
              ),
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: _tciLabPaperDark.withValues(alpha: 0.3),
                border: Border.all(color: _tciLabStamp, width: 1.5),
                borderRadius: BorderRadius.circular(4),
              ),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                style: _tciLabMono(size: 15, color: _tciLabInk),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: _tciLabPaper,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  hintText: 'type & Ctrl+T to log',
                  hintStyle: _tciLabMono(
                    color: _tciLabInkSoft.withValues(alpha: 0.6),
                    style: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          ValueListenableBuilder<List<String>>(
            valueListenable: _log,
            builder: (BuildContext ctx, List<String> entries, Widget? _) {
              if (entries.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _tciLabPaperDark.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    '// log is empty — no intent captured yet',
                    style: _tciLabMono(
                      size: 12,
                      color: _tciLabInkSoft,
                      style: FontStyle.italic,
                    ),
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('callback log',
                      style: _tciLabMono(
                        size: 11,
                        color: _tciLabAmberDeep,
                        weight: FontWeight.w900,
                        letters: 1.6,
                      )),
                  const SizedBox(height: 6),
                  ...entries.map<Widget>((String line) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: _tciLabAmber.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(
                          color: _tciLabAmberDeep.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Text(line,
                          style: _tciLabMono(size: 12, color: _tciLabInkSoft)),
                    );
                  }),
                ],
              );
            },
          ),
        ],
      ),
      footnote: 'Returning null from a CallbackAction tells the dispatcher '
          'the action did not consume the intent — so the built-in Action '
          'below still runs and you see the visible transpose.',
    );
  }
}

// ============================================================================
// Scenario 4 — Shortcut gallery with per-platform binding pills.
// ============================================================================

class _TciLabShortcutGalleryCard extends StatelessWidget {
  const _TciLabShortcutGalleryCard();

  @override
  Widget build(BuildContext context) {
    final List<_TciLabBinding> bindings = <_TciLabBinding>[
      const _TciLabBinding(
        platform: 'Windows / Linux',
        keys: <String>['Ctrl', 'T'],
        rationale:
            'SingleActivator(LogicalKeyboardKey.keyT, control: true) '
            'fires TransposeCharactersIntent for every focused EditableText.',
      ),
      const _TciLabBinding(
        platform: 'macOS',
        keys: <String>['\u2303 Control', 'T'],
        rationale:
            'Apple keeps Ctrl+T because it is historical readline behaviour — '
            'Cmd+T is reserved by the OS / browser for new tab.',
      ),
      const _TciLabBinding(
        platform: 'Web (desktop)',
        keys: <String>['Ctrl', 'T'],
        rationale:
            'On the web, DefaultTextEditingShortcuts is still the source of '
            'truth — but your browser may swallow Ctrl+T for New Tab. A '
            'Shortcuts override can remap if needed.',
      ),
      const _TciLabBinding(
        platform: 'Mobile (iOS / Android)',
        keys: <String>['(no default)'],
        rationale:
            'Mobile text fields do not expose a Ctrl+T by default. You can '
            'still dispatch TransposeCharactersIntent programmatically via '
            'Actions.invoke with a FocusNode in scope.',
      ),
    ];

    return _TciLabPaperPanel(
      title: 'Shortcut gallery — bindings by platform',
      subtitle:
          'LogicalKeyboardKey.keyT is the input, TransposeCharactersIntent is the output',
      stampLabel: 'gallery',
      stampColor: _tciLabStamp,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildKeyCapRow(),
          const SizedBox(height: 16),
          ...bindings.map<Widget>((_TciLabBinding b) => _buildBindingRow(b)),
        ],
      ),
      footnote:
          'LogicalKeyboardKey.keyT resolves identically on all platforms; it '
          'is the modifier resolution (control / meta) that differs.',
    );
  }

  Widget _buildKeyCapRow() {
    // Touch LogicalKeyboardKey so the services import is used meaningfully.
    final LogicalKeyboardKey keyT = LogicalKeyboardKey.keyT;
    final LogicalKeyboardKey control = LogicalKeyboardKey.controlLeft;
    final String debugName = '${control.debugName} + ${keyT.debugName}';
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _tciLabPaperDark.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              _TciLabKeyCap(label: 'Ctrl', wide: true),
              SizedBox(width: 8),
              Text('+',
                  style: TextStyle(
                      fontFamily: _tciLabFontMono,
                      fontSize: 22,
                      color: _tciLabInkSoft,
                      fontWeight: FontWeight.w900)),
              SizedBox(width: 8),
              _TciLabKeyCap(label: 'T'),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'resolves to: $debugName',
            textAlign: TextAlign.center,
            style: _tciLabMono(
              size: 11,
              color: _tciLabInkSoft,
              style: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBindingRow(_TciLabBinding b) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 150,
            child: Text(
              b.platform,
              style: _tciLabMono(
                size: 12,
                weight: FontWeight.w900,
                color: _tciLabAmberDeep,
                letters: 0.6,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: b.keys
                      .map<Widget>((String k) => _TciLabKeyPill(label: k))
                      .toList(),
                ),
                const SizedBox(height: 6),
                Text(b.rationale,
                    style: _tciLabMono(
                      size: 11,
                      color: _tciLabInkSoft,
                      height: 1.5,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TciLabBinding {
  const _TciLabBinding({
    required this.platform,
    required this.keys,
    required this.rationale,
  });

  final String platform;
  final List<String> keys;
  final String rationale;
}

class _TciLabKeyCap extends StatelessWidget {
  const _TciLabKeyCap({required this.label, this.wide = false});

  final String label;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: wide ? 70 : 52,
      height: 52,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _tciLabPaper,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _tciLabInk, width: 2),
        boxShadow: [
          BoxShadow(
            color: _tciLabShadow.withValues(alpha: 0.4),
            blurRadius: 0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        label,
        style: _tciLabMono(
          size: 16,
          color: _tciLabInk,
          weight: FontWeight.w900,
        ),
      ),
    );
  }
}

// ============================================================================
// Scenario 5 — Manual invocation via Actions.maybeInvoke.
// ============================================================================

class _TciLabManualInvokeCard extends StatefulWidget {
  const _TciLabManualInvokeCard();

  @override
  State<_TciLabManualInvokeCard> createState() =>
      _TciLabManualInvokeCardState();
}

class _TciLabManualInvokeCardState extends State<_TciLabManualInvokeCard> {
  final TextEditingController _controller =
      TextEditingController(text: 'tap the amber button to the right');
  final FocusNode _focusNode = FocusNode(debugLabel: 'TciLabManualField');

  String _lastStatus = 'idle';
  int _manualFires = 0;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _invoke() {
    // Always target the field's own focus node so the framework uses the
    // right EditableText context regardless of where the tap came from.
    _focusNode.requestFocus();
    final BuildContext? ctx = _focusNode.context;
    if (ctx == null) {
      setState(() {
        _lastStatus = 'no context on focus node yet';
      });
      return;
    }
    final Object? result = Actions.maybeInvoke<TransposeCharactersIntent>(
      ctx,
      const TransposeCharactersIntent(),
    );
    setState(() {
      _manualFires++;
      _lastStatus = result == null
          ? 'dispatched, no action returned a value'
          : 'dispatched, action returned $result';
    });
  }

  @override
  Widget build(BuildContext context) {
    return _TciLabPaperPanel(
      title: 'Manual invocation — dispatch without a keystroke',
      subtitle:
          'Actions.maybeInvoke<TransposeCharactersIntent>(ctx, const TransposeCharactersIntent())',
      stampLabel: 'dispatch',
      stampColor: _tciLabRibbon,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildFocusIndicator(),
                const SizedBox(height: 10),
                _buildField(),
                const SizedBox(height: 12),
                _buildStatusBar(),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Expanded(flex: 2, child: _buildButtonColumn()),
        ],
      ),
      footnote:
          'maybeInvoke returns null both when no action is found and when a '
          'found action returns null. Check focus first — the default action '
          'lives in the EditableText that owns the focus.',
    );
  }

  Widget _buildFocusIndicator() {
    return AnimatedBuilder(
      animation: _focusNode,
      builder: (BuildContext ctx, Widget? _) {
        final bool focused = _focusNode.hasFocus;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: focused
                ? _tciLabStamp.withValues(alpha: 0.18)
                : _tciLabPaperDark.withValues(alpha: 0.4),
            border: Border.all(
                color: focused ? _tciLabStamp : _tciLabPaperDark, width: 1),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Row(
            children: <Widget>[
              Icon(
                focused ? Icons.center_focus_strong : Icons.center_focus_weak,
                size: 14,
                color: focused ? _tciLabStamp : _tciLabInkSoft,
              ),
              const SizedBox(width: 6),
              Text(
                focused ? 'field is focused' : 'field is not focused',
                style: _tciLabMono(
                  size: 11,
                  color: focused ? _tciLabStamp : _tciLabInkSoft,
                  weight: FontWeight.w700,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildField() {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: _tciLabPaperDark.withValues(alpha: 0.3),
        border: Border.all(color: _tciLabAmberDeep, width: 1.3),
        borderRadius: BorderRadius.circular(3),
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        style: _tciLabMono(size: 14, color: _tciLabInk),
        decoration: InputDecoration(
          filled: true,
          fillColor: _tciLabPaper,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 10, vertical: 10),
        ),
      ),
    );
  }

  Widget _buildStatusBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      color: _tciLabInk,
      child: Row(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            color: _tciLabAmberDeep,
            child: Text('$_manualFires',
                style: _tciLabMono(
                    size: 11,
                    color: _tciLabPaper,
                    weight: FontWeight.w900)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _lastStatus,
              overflow: TextOverflow.ellipsis,
              style: _tciLabMono(size: 11, color: _tciLabPaper),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildBigButton(),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _tciLabPaperDark.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            'The button focuses the field then calls Actions.maybeInvoke. '
            'Because the default Action lives inside EditableText, focusing '
            'the field first is required — without focus, maybeInvoke has '
            'no meaningful subtree to dispatch into.',
            style: _tciLabMono(
                size: 11, color: _tciLabInkSoft, height: 1.5),
          ),
        ),
      ],
    );
  }

  Widget _buildBigButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _invoke,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            color: _tciLabRibbon,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: _tciLabShadow.withValues(alpha: 0.45),
                blurRadius: 4,
                offset: const Offset(2, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.swap_horiz, color: _tciLabPaper, size: 22),
              const SizedBox(width: 8),
              Text(
                'TRANSPOSE NOW',
                style: _tciLabMono(
                  size: 14,
                  color: _tciLabPaper,
                  weight: FontWeight.w900,
                  letters: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// Scenario 6 — Edge-cases readout.
// ============================================================================

class _TciLabEdgeCasesCard extends StatelessWidget {
  const _TciLabEdgeCasesCard();

  @override
  Widget build(BuildContext context) {
    final List<_TciLabEdge> edges = <_TciLabEdge>[
      const _TciLabEdge(
        label: 'Caret at position 0',
        before: '|type',
        after: '|type',
        note: 'No characters to the left of the caret — the framework does '
            'nothing. The intent fires, the action exits early.',
        outcome: 'noop',
      ),
      const _TciLabEdge(
        label: 'Caret at end of text',
        before: 'type|',
        after: 'tyep|',
        note:
            'End-of-text is the classic emacs behaviour: swap the two '
            'characters immediately to the left of the caret.',
        outcome: 'swap left-of-caret pair',
      ),
      const _TciLabEdge(
        label: 'Caret strictly inside',
        before: 'ty|pe',
        after: 'yt|pe',
        note:
            'The standard case: swap the character immediately before the '
            'caret with the character immediately after.',
        outcome: 'swap flanking pair',
      ),
      const _TciLabEdge(
        label: 'Empty string',
        before: '|',
        after: '|',
        note:
            'Nothing to transpose, nothing happens. Safe to bind the intent '
            'unconditionally — the action is defensive.',
        outcome: 'noop',
      ),
      const _TciLabEdge(
        label: 'Single character',
        before: 'x|',
        after: 'x|',
        note:
            'Only one character exists, no adjacent pair is available. The '
            'action silently skips.',
        outcome: 'noop',
      ),
      const _TciLabEdge(
        label: 'Surrogate pair / emoji',
        before: 'a|\u{1F600}b',
        after: '\u{1F600}|ab',
        note:
            'Flutter operates on code units, not graphemes. Emoji with '
            'surrogate pairs can produce surprising results — consider '
            'overriding this action for CJK or emoji-heavy inputs.',
        outcome: 'platform-dependent',
      ),
    ];

    return _TciLabPaperPanel(
      title: 'Edge cases — what the default Action actually does',
      subtitle:
          'Caret position is the only parameter; the intent carries nothing',
      stampLabel: 'edges',
      stampColor: _tciLabAmberDeep,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: edges.map<Widget>(_buildEdge).toList(),
      ),
      footnote:
          'The built-in action reads the current TextEditingValue, figures '
          'out which two characters to swap, and replaces them via '
          'TextEditingValue.copyWith. It never inserts or deletes net text.',
    );
  }

  Widget _buildEdge(_TciLabEdge e) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _tciLabPaper,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: _tciLabPaperDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(e.label,
                    style: _tciLabMono(
                      size: 13,
                      weight: FontWeight.w900,
                      color: _tciLabInk,
                    )),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _tciLabStamp.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(color: _tciLabStamp),
                ),
                child: Text(e.outcome,
                    style: _tciLabMono(
                      size: 10,
                      color: _tciLabStamp,
                      weight: FontWeight.w900,
                      letters: 1.1,
                    )),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: _buildEdgeSample(
                  label: 'before',
                  text: e.before,
                  color: _tciLabRibbon,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward, color: _tciLabAmberDeep, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: _buildEdgeSample(
                  label: 'after',
                  text: e.after,
                  color: _tciLabStamp,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(e.note,
              style: _tciLabMono(
                size: 11,
                color: _tciLabInkSoft,
                height: 1.5,
                style: FontStyle.italic,
              )),
        ],
      ),
    );
  }

  Widget _buildEdgeSample({
    required String label,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label,
              style: _tciLabMono(
                size: 9,
                color: color,
                weight: FontWeight.w900,
                letters: 1.2,
              )),
          const SizedBox(height: 2),
          Text(text,
              style: _tciLabMono(
                size: 14,
                color: _tciLabInk,
                weight: FontWeight.w700,
              )),
        ],
      ),
    );
  }
}

class _TciLabEdge {
  const _TciLabEdge({
    required this.label,
    required this.before,
    required this.after,
    required this.note,
    required this.outcome,
  });

  final String label;
  final String before;
  final String after;
  final String note;
  final String outcome;
}

// ============================================================================
// Scenario 7 — Epilogue with override / disable recipes.
// ============================================================================

class _TciLabEpilogueCard extends StatelessWidget {
  const _TciLabEpilogueCard();

  @override
  Widget build(BuildContext context) {
    final List<_TciLabRecipe> recipes = <_TciLabRecipe>[
      const _TciLabRecipe(
        title: 'Override the action in a subtree',
        snippet:
            'Actions(\n'
            '  actions: <Type, Action<Intent>>{\n'
            '    TransposeCharactersIntent: _MyTransposeAction(),\n'
            '  },\n'
            '  child: child,\n'
            ')',
        explanation:
            'Pass a custom Action<TransposeCharactersIntent> to completely '
            'replace the default behaviour, for example to integrate with a '
            'spellcheck engine or to substitute grapheme-aware logic.',
      ),
      const _TciLabRecipe(
        title: 'Disable the intent in a FocusScope',
        snippet:
            'Shortcuts(\n'
            '  shortcuts: <ShortcutActivator, Intent>{\n'
            '    SingleActivator(LogicalKeyboardKey.keyT, control: true):\n'
            '        DoNothingIntent(),\n'
            '  },\n'
            '  child: child,\n'
            ')',
        explanation:
            'Shadow the default binding so Ctrl+T produces DoNothingIntent. '
            'Useful in command palettes and code editors where Ctrl+T has '
            'app-level meaning.',
      ),
      const _TciLabRecipe(
        title: 'Dispatch from anywhere',
        snippet:
            'Actions.maybeInvoke<TransposeCharactersIntent>(\n'
            '  primaryFocus!.context!,\n'
            '  const TransposeCharactersIntent(),\n'
            ');',
        explanation:
            'Fire the intent without a keystroke — useful for test hooks, '
            'accessibility shortcuts, or screen-reader-driven editing '
            'commands.',
      ),
      const _TciLabRecipe(
        title: 'Opt into overridable Action',
        snippet:
            'class MyField extends StatelessWidget {\n'
            '  @override\n'
            '  Widget build(BuildContext context) {\n'
            '    return Actions(\n'
            '      actions: <Type, Action<Intent>>{\n'
            '        TransposeCharactersIntent: Action.overridable(\n'
            '          defaultAction: _fallback,\n'
            '          context: context,\n'
            '        ),\n'
            '      },\n'
            '      child: child,\n'
            '    );\n'
            '  }\n'
            '}',
        explanation:
            'Action.overridable allows descendants to augment behaviour '
            'while preserving a sensible default; see the EditableTextTap '
            'family for canonical usage.',
      ),
    ];

    return _TciLabPaperPanel(
      title: 'Epilogue — when and how to override',
      subtitle:
          'Recipes for making Ctrl+T do the right thing for your application',
      stampLabel: 'field manual',
      stampColor: _tciLabAmberDeep,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: recipes.map<Widget>(_buildRecipe).toList(),
      ),
      footnote:
          'Three rules of thumb: (1) never override globally unless you own '
          'the app, (2) always preserve undo/redo, (3) remember that tests '
          'can dispatch the intent directly — so your override must also '
          'be reachable programmatically.',
    );
  }

  Widget _buildRecipe(_TciLabRecipe r) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: _tciLabPaper,
        border: Border.all(color: _tciLabPaperDark),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            decoration: BoxDecoration(
              color: _tciLabAmber.withValues(alpha: 0.18),
              border: Border(
                bottom: BorderSide(color: _tciLabPaperDark),
              ),
            ),
            child: Text(r.title,
                style: _tciLabMono(
                  size: 13,
                  weight: FontWeight.w900,
                  color: _tciLabAmberDeep,
                )),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            color: _tciLabInk,
            child: Text(r.snippet,
                style: _tciLabMono(
                    size: 11.5, color: _tciLabPaper, height: 1.55)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(r.explanation,
                style: _tciLabMono(
                    size: 12, color: _tciLabInkSoft, height: 1.5)),
          ),
        ],
      ),
    );
  }
}

class _TciLabRecipe {
  const _TciLabRecipe({
    required this.title,
    required this.snippet,
    required this.explanation,
  });

  final String title;
  final String snippet;
  final String explanation;
}

// ============================================================================
// Lab title banner.
// ============================================================================

class _TciLabBanner extends StatelessWidget {
  const _TciLabBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
      decoration: BoxDecoration(
        color: _tciLabInk,
        border: Border(
          bottom: BorderSide(color: _tciLabAmberDeep, width: 3),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: _tciLabAmber,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: _tciLabShadow.withValues(alpha: 0.5),
                  blurRadius: 4,
                  offset: const Offset(2, 3),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              'T',
              style: _tciLabMono(
                size: 28,
                color: _tciLabInk,
                weight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'TRANSPOSECHARACTERS LAB',
                  style: _tciLabMono(
                    size: 20,
                    color: _tciLabPaper,
                    weight: FontWeight.w900,
                    letters: 2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'a typewriter tour of Flutter\u2019s text-editing intents',
                  style: _tciLabMono(
                    size: 12,
                    color: _tciLabAmber,
                    style: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: _tciLabAmber, width: 1.5),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(
              'vol. 1',
              style: _tciLabMono(
                size: 11,
                color: _tciLabAmber,
                weight: FontWeight.w900,
                letters: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Closing note — footer with build info.
// ============================================================================

class _TciLabFooter extends StatelessWidget {
  const _TciLabFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 28),
      decoration: BoxDecoration(
        color: _tciLabInk,
        border: Border(top: BorderSide(color: _tciLabAmberDeep, width: 2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            '/* END OF LAB NOTES */',
            textAlign: TextAlign.center,
            style: _tciLabMono(
              size: 12,
              color: _tciLabAmber,
              weight: FontWeight.w900,
              letters: 2.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'TransposeCharactersIntent — a tiny class with a big architectural '
            'lesson: keep intents semantic, let actions be replaceable, and let '
            'shortcuts stay pluggable.',
            textAlign: TextAlign.center,
            style: _tciLabMono(
              size: 12,
              color: _tciLabPaper.withValues(alpha: 0.78),
              style: FontStyle.italic,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const _TciLabKeyPill(label: 'Intent'),
              const SizedBox(width: 6),
              Text('\u2192',
                  style: _tciLabMono(
                      size: 12,
                      color: _tciLabAmber,
                      weight: FontWeight.w900)),
              const SizedBox(width: 6),
              const _TciLabKeyPill(label: 'Action'),
              const SizedBox(width: 6),
              Text('\u2192',
                  style: _tciLabMono(
                      size: 12,
                      color: _tciLabAmber,
                      weight: FontWeight.w900)),
              const SizedBox(width: 6),
              const _TciLabKeyPill(label: 'EditableText'),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Entry point — the d4rt harness expects `dynamic build(BuildContext)`.
// ============================================================================

dynamic build(BuildContext context) {
  debugPrint('TransposeCharactersIntent deep demo executing');
  debugPrint('  palette: amber/paper/ink-black typewriter');
  debugPrint('  scenarios: preamble, live typewriter, custom actions,');
  debugPrint('             shortcut gallery, manual invocation, edges, epilogue');

  // Seven scenarios, ordered narratively: concept, practice, override,
  // gallery, manual dispatch, edges, and epilogue.
  final List<Widget> scaffoldChildren = <Widget>[
    const _TciLabBanner(),
    const _TciLabDivider(label: 'scenario 1 — preamble'),
    const _TciLabPreambleCard(),
    const _TciLabDivider(label: 'scenario 2 — live typewriter'),
    const _TciLabTypewriterCard(),
    const _TciLabDivider(label: 'scenario 3 — custom actions scope'),
    const _TciLabCustomActionCard(),
    const _TciLabDivider(label: 'scenario 4 — shortcut gallery'),
    const _TciLabShortcutGalleryCard(),
    const _TciLabDivider(label: 'scenario 5 — manual invocation'),
    const _TciLabManualInvokeCard(),
    const _TciLabDivider(label: 'scenario 6 — edge cases'),
    const _TciLabEdgeCasesCard(),
    const _TciLabDivider(label: 'scenario 7 — epilogue'),
    const _TciLabEpilogueCard(),
    const _TciLabFooter(),
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TransposeCharactersIntent Lab',
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFECE1C4),
      textTheme: const TextTheme(),
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFECE1C4),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: scaffoldChildren,
        ),
      ),
    ),
  );
}
