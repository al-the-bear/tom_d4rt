// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, unused_element_parameter, unused_field, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// =============================================================================
// PALETTE
// =============================================================================

class _Palette {
  final Color background;
  final Color surface;
  final Color surfaceAlt;
  final Color ink;
  final Color inkSoft;
  final Color muted;
  final Color outline;
  final Color outlineSoft;
  final Color primary;
  final Color primaryInk;
  final Color secondary;
  final Color secondaryInk;
  final Color accent;
  final Color accentInk;
  final Color danger;
  final Color dangerInk;
  final Color success;
  final Color successInk;
  final Color warning;
  final Color warningInk;
  final Color info;
  final Color infoInk;

  const _Palette({
    required this.background,
    required this.surface,
    required this.surfaceAlt,
    required this.ink,
    required this.inkSoft,
    required this.muted,
    required this.outline,
    required this.outlineSoft,
    required this.primary,
    required this.primaryInk,
    required this.secondary,
    required this.secondaryInk,
    required this.accent,
    required this.accentInk,
    required this.danger,
    required this.dangerInk,
    required this.success,
    required this.successInk,
    required this.warning,
    required this.warningInk,
    required this.info,
    required this.infoInk,
  });
}

const _Palette _kPalette = _Palette(
  background: Color(0xFFF4F6FB),
  surface: Color(0xFFFFFFFF),
  surfaceAlt: Color(0xFFEEF2F9),
  ink: Color(0xFF0F172A),
  inkSoft: Color(0xFF1E293B),
  muted: Color(0xFF64748B),
  outline: Color(0xFFD0D7E2),
  outlineSoft: Color(0xFFE5EAF1),
  primary: Color(0xFF1D4ED8),
  primaryInk: Color(0xFFFFFFFF),
  secondary: Color(0xFFEA580C),
  secondaryInk: Color(0xFFFFFFFF),
  accent: Color(0xFF0D9488),
  accentInk: Color(0xFFFFFFFF),
  danger: Color(0xFFB91C1C),
  dangerInk: Color(0xFFFFFFFF),
  success: Color(0xFF15803D),
  successInk: Color(0xFFFFFFFF),
  warning: Color(0xFFB45309),
  warningInk: Color(0xFFFFFFFF),
  info: Color(0xFF1E40AF),
  infoInk: Color(0xFFFFFFFF),
);

// =============================================================================
// INTENT TYPES (domain-style)
// =============================================================================

class _SaveDocumentIntent extends Intent {
  final String document;
  const _SaveDocumentIntent(this.document);
}

class _CopyIntent extends Intent {
  final String selection;
  const _CopyIntent(this.selection);
}

class _PasteIntent extends Intent {
  const _PasteIntent();
}

class _CutIntent extends Intent {
  final String selection;
  const _CutIntent(this.selection);
}

class _UndoIntent extends Intent {
  const _UndoIntent();
}

class _RedoIntent extends Intent {
  const _RedoIntent();
}

class _NavigateNextIntent extends Intent {
  const _NavigateNextIntent();
}

class _NavigatePreviousIntent extends Intent {
  const _NavigatePreviousIntent();
}

class _OpenPaletteIntent extends Intent {
  const _OpenPaletteIntent();
}

class _CommitIntent extends Intent {
  final String message;
  const _CommitIntent(this.message);
}

class _BoldIntent extends Intent {
  const _BoldIntent();
}

class _ItalicIntent extends Intent {
  const _ItalicIntent();
}

class _ZoomInIntent extends Intent {
  const _ZoomInIntent();
}

class _ZoomOutIntent extends Intent {
  const _ZoomOutIntent();
}

// =============================================================================
// ACTION CLASSES — bound to Intent types
// =============================================================================

class _SaveDocumentAction extends Action<_SaveDocumentIntent> {
  final void Function(String) onSave;
  _SaveDocumentAction(this.onSave);

  @override
  Object? invoke(_SaveDocumentIntent intent) {
    onSave(intent.document);
    return 'saved:${intent.document}';
  }
}

class _CopyAction extends Action<_CopyIntent> {
  final void Function(String) onCopy;
  _CopyAction(this.onCopy);

  @override
  Object? invoke(_CopyIntent intent) {
    onCopy(intent.selection);
    return 'copied';
  }
}

class _PasteAction extends Action<_PasteIntent> {
  final VoidCallback onPaste;
  _PasteAction(this.onPaste);

  @override
  Object? invoke(_PasteIntent intent) {
    onPaste();
    return 'pasted';
  }
}

class _UndoAction extends Action<_UndoIntent> {
  final VoidCallback onUndo;
  _UndoAction(this.onUndo);

  @override
  Object? invoke(_UndoIntent intent) {
    onUndo();
    return null;
  }
}

class _RedoAction extends Action<_RedoIntent> {
  final VoidCallback onRedo;
  _RedoAction(this.onRedo);

  @override
  Object? invoke(_RedoIntent intent) {
    onRedo();
    return null;
  }
}

class _DisabledSaveAction extends Action<_SaveDocumentIntent> {
  @override
  bool isEnabled(_SaveDocumentIntent intent) => false;

  @override
  Object? invoke(_SaveDocumentIntent intent) {
    return null;
  }
}

class _LoggingDispatcher extends ActionDispatcher {
  final List<String> log;
  _LoggingDispatcher(this.log);

  @override
  Object? invokeAction(
    covariant Action<Intent> action,
    covariant Intent intent, [
    BuildContext? context,
  ]) {
    log.add('dispatch:${intent.runtimeType}');
    return super.invokeAction(action, intent, context);
  }
}

// =============================================================================
// SHORTCUT RECORDS — visual model
// =============================================================================

class _ShortcutRecord {
  final String label;
  final List<String> keyTokens;
  final String intentName;
  final String actionName;
  final String purpose;
  final Color tint;
  final Color tintInk;
  final bool usesSingleActivator;

  const _ShortcutRecord({
    required this.label,
    required this.keyTokens,
    required this.intentName,
    required this.actionName,
    required this.purpose,
    required this.tint,
    required this.tintInk,
    required this.usesSingleActivator,
  });
}

const List<_ShortcutRecord> _kShortcutRecords = <_ShortcutRecord>[
  _ShortcutRecord(
    label: 'Save document',
    keyTokens: <String>['Ctrl', 'S'],
    intentName: '_SaveDocumentIntent',
    actionName: '_SaveDocumentAction',
    purpose: 'Persist the current draft to disk.',
    tint: Color(0xFFDBEAFE),
    tintInk: Color(0xFF1E3A8A),
    usesSingleActivator: true,
  ),
  _ShortcutRecord(
    label: 'Copy selection',
    keyTokens: <String>['Ctrl', 'C'],
    intentName: '_CopyIntent',
    actionName: '_CopyAction',
    purpose: 'Copy the currently selected range to clipboard.',
    tint: Color(0xFFCCFBF1),
    tintInk: Color(0xFF134E4A),
    usesSingleActivator: true,
  ),
  _ShortcutRecord(
    label: 'Paste',
    keyTokens: <String>['Ctrl', 'V'],
    intentName: '_PasteIntent',
    actionName: '_PasteAction',
    purpose: 'Insert clipboard contents at the caret.',
    tint: Color(0xFFE9D5FF),
    tintInk: Color(0xFF581C87),
    usesSingleActivator: true,
  ),
  _ShortcutRecord(
    label: 'Cut',
    keyTokens: <String>['Ctrl', 'X'],
    intentName: '_CutIntent',
    actionName: '(via Actions)',
    purpose: 'Delete selection and place it on the clipboard.',
    tint: Color(0xFFFDE68A),
    tintInk: Color(0xFF78350F),
    usesSingleActivator: true,
  ),
  _ShortcutRecord(
    label: 'Undo',
    keyTokens: <String>['Ctrl', 'Z'],
    intentName: '_UndoIntent',
    actionName: '_UndoAction',
    purpose: 'Roll back the last document mutation.',
    tint: Color(0xFFFECACA),
    tintInk: Color(0xFF7F1D1D),
    usesSingleActivator: true,
  ),
  _ShortcutRecord(
    label: 'Redo',
    keyTokens: <String>['Ctrl', 'Shift', 'Z'],
    intentName: '_RedoIntent',
    actionName: '_RedoAction',
    purpose: 'Replay a previously undone mutation.',
    tint: Color(0xFFFBCFE8),
    tintInk: Color(0xFF831843),
    usesSingleActivator: true,
  ),
  _ShortcutRecord(
    label: 'Open command palette',
    keyTokens: <String>['Ctrl', 'Shift', 'P'],
    intentName: '_OpenPaletteIntent',
    actionName: 'CallbackAction',
    purpose: 'Show the floating command palette overlay.',
    tint: Color(0xFFD1FAE5),
    tintInk: Color(0xFF064E3B),
    usesSingleActivator: true,
  ),
  _ShortcutRecord(
    label: 'Next pane',
    keyTokens: <String>['Ctrl', 'Tab'],
    intentName: '_NavigateNextIntent',
    actionName: 'CallbackAction',
    purpose: 'Switch focus to the next editor pane.',
    tint: Color(0xFFC7D2FE),
    tintInk: Color(0xFF312E81),
    usesSingleActivator: true,
  ),
  _ShortcutRecord(
    label: 'Previous pane',
    keyTokens: <String>['Ctrl', 'Shift', 'Tab'],
    intentName: '_NavigatePreviousIntent',
    actionName: 'CallbackAction',
    purpose: 'Switch focus to the previous editor pane.',
    tint: Color(0xFFBAE6FD),
    tintInk: Color(0xFF0C4A6E),
    usesSingleActivator: true,
  ),
  _ShortcutRecord(
    label: 'Bold',
    keyTokens: <String>['Ctrl', 'B'],
    intentName: '_BoldIntent',
    actionName: 'CallbackAction',
    purpose: 'Toggle bold formatting on the selection.',
    tint: Color(0xFFFEF3C7),
    tintInk: Color(0xFF713F12),
    usesSingleActivator: true,
  ),
  _ShortcutRecord(
    label: 'Italic',
    keyTokens: <String>['Ctrl', 'I'],
    intentName: '_ItalicIntent',
    actionName: 'CallbackAction',
    purpose: 'Toggle italic formatting on the selection.',
    tint: Color(0xFFE0E7FF),
    tintInk: Color(0xFF3730A3),
    usesSingleActivator: true,
  ),
  _ShortcutRecord(
    label: 'Zoom in',
    keyTokens: <String>['Ctrl', '='],
    intentName: '_ZoomInIntent',
    actionName: 'CallbackAction',
    purpose: 'Increase editor magnification by one step.',
    tint: Color(0xFFFFE4E6),
    tintInk: Color(0xFF881337),
    usesSingleActivator: true,
  ),
  _ShortcutRecord(
    label: 'Zoom out',
    keyTokens: <String>['Ctrl', '-'],
    intentName: '_ZoomOutIntent',
    actionName: 'CallbackAction',
    purpose: 'Decrease editor magnification by one step.',
    tint: Color(0xFFFEE2E2),
    tintInk: Color(0xFF7F1D1D),
    usesSingleActivator: true,
  ),
  _ShortcutRecord(
    label: 'Legacy escape (Set)',
    keyTokens: <String>['Esc'],
    intentName: 'DismissIntent',
    actionName: 'DismissAction',
    purpose: 'LogicalKeySet style activator — order-insensitive.',
    tint: Color(0xFFE2E8F0),
    tintInk: Color(0xFF1E293B),
    usesSingleActivator: false,
  ),
];

// =============================================================================
// GLOSSARY / DOSSIER DATA
// =============================================================================

class _DossierEntry {
  final String title;
  final String body;
  final IconData icon;
  final Color tint;
  final Color tintInk;
  const _DossierEntry({
    required this.title,
    required this.body,
    required this.icon,
    required this.tint,
    required this.tintInk,
  });
}

const List<_DossierEntry> _kDossier = <_DossierEntry>[
  _DossierEntry(
    title: 'Why Intents and Actions exist',
    body:
        'Flutter\'s Actions/Intents framework decouples user input from the '
        'behavior that responds to it. A keystroke, a button, or a menu can '
        'each emit the same Intent — and a single Action somewhere up the '
        'widget tree decides what to do.',
    icon: Icons.bolt_outlined,
    tint: Color(0xFFEFF6FF),
    tintInk: Color(0xFF1E3A8A),
  ),
  _DossierEntry(
    title: 'Layered routing',
    body:
        'Shortcuts translate raw key events into Intents. Actions widgets '
        'host a map from Intent.runtimeType to Action. Dispatcher walks up '
        'the focus chain and invokes the most specific enabled action found.',
    icon: Icons.account_tree_outlined,
    tint: Color(0xFFF0FDFA),
    tintInk: Color(0xFF115E59),
  ),
  _DossierEntry(
    title: 'Why not RawKeyboardListener',
    body:
        'Raw listeners only see key events for the focused widget. They '
        'have no notion of an enabled/disabled command, no override path, '
        'no context lookups, and no built-in lifecycle. Actions/Intents '
        'solves all four.',
    icon: Icons.electrical_services_outlined,
    tint: Color(0xFFFEF3C7),
    tintInk: Color(0xFF713F12),
  ),
  _DossierEntry(
    title: 'Context-driven dispatch',
    body:
        'Actions.invoke(context, intent) looks up the nearest Actions '
        'widget along the focus path that has a handler for the intent\'s '
        'runtime type. This means the same intent can resolve differently '
        'depending on where focus is.',
    icon: Icons.location_searching,
    tint: Color(0xFFEDE9FE),
    tintInk: Color(0xFF5B21B6),
  ),
];

class _GlossaryTerm {
  final String name;
  final String definition;
  const _GlossaryTerm({required this.name, required this.definition});
}

const List<_GlossaryTerm> _kGlossary = <_GlossaryTerm>[
  _GlossaryTerm(
    name: 'Intent',
    definition:
        'An immutable, declarative description of "what the user wants to '
        'happen" — never the implementation. Lives in widget trees as a '
        'lightweight data object. May carry parameters such as a target '
        'document name or a focus direction.',
  ),
  _GlossaryTerm(
    name: 'Action<T extends Intent>',
    definition:
        'The procedural counterpart to an Intent type. Knows how to handle '
        'one runtime type of Intent through its invoke() method. Can be '
        'enabled/disabled at runtime via isEnabled(). May be re-bound '
        'live in the Actions map.',
  ),
  _GlossaryTerm(
    name: 'Actions widget',
    definition:
        'Provides a Map<Type, Action<Intent>> for the subtree. Multiple '
        'Actions widgets can nest — the innermost match wins, unless an '
        'outer one overrides via ActionDispatcher.',
  ),
  _GlossaryTerm(
    name: 'Shortcuts widget',
    definition:
        'Maps ShortcutActivator → Intent. Listens to key events bubbling '
        'up the focus chain and dispatches the matching Intent via the '
        'enclosing Actions tree.',
  ),
  _GlossaryTerm(
    name: 'ShortcutActivator',
    definition:
        'Abstract gatekeeper — checks if a given key event should fire. '
        'Concrete subclasses: SingleActivator (modern, ordered modifiers, '
        'pressed-key match) and LogicalKeySet (legacy, set-based).',
  ),
  _GlossaryTerm(
    name: 'SingleActivator',
    definition:
        'The modern, preferred activator. Encodes exactly one trigger key '
        'plus required modifiers. Order-insensitive for modifiers, but '
        'strict about which key is the trigger. Supports control, shift, '
        'alt, meta, includeRepeats and numLock flags.',
  ),
  _GlossaryTerm(
    name: 'LogicalKeySet',
    definition:
        'Older activator that matches a set of currently pressed logical '
        'keys, regardless of which was pressed last. Less precise than '
        'SingleActivator; kept for backward compatibility.',
  ),
  _GlossaryTerm(
    name: 'ActionDispatcher',
    definition:
        'Final stop in the dispatch pipeline. Calls Action.invoke() on the '
        'resolved action. Subclass it to add logging, analytics, '
        'transactionality, or to short-circuit certain intents.',
  ),
  _GlossaryTerm(
    name: 'CallbackAction',
    definition:
        'A drop-in Action<T> whose invoke() is supplied as a closure. The '
        'simplest way to express "run this code when this intent fires" '
        'without subclassing Action.',
  ),
  _GlossaryTerm(
    name: 'ActionListener',
    definition:
        'Widget that subscribes to an Action and rebuilds when the action '
        'notifies its listeners (e.g. when isEnabled changes). Lets the UI '
        'reflect command availability.',
  ),
  _GlossaryTerm(
    name: 'FocusableActionDetector',
    definition:
        'High-level combination of Focus + Shortcuts + Actions + '
        'MouseRegion. Designed for custom widgets that need to be '
        'keyboard-focusable, react to shortcuts, and report hover/focus '
        'state simultaneously.',
  ),
  _GlossaryTerm(
    name: 'Actions.invoke / maybeInvoke',
    definition:
        'Static helpers. invoke() looks up an action for the given intent '
        'and asserts that one exists. maybeInvoke() returns null instead '
        'of asserting — useful when an action may legitimately be absent.',
  ),
];

class _PitfallEntry {
  final String name;
  final String body;
  const _PitfallEntry({required this.name, required this.body});
}

const List<_PitfallEntry> _kPitfalls = <_PitfallEntry>[
  _PitfallEntry(
    name: 'No focus = no shortcut',
    body:
        'Shortcuts only fire if some focusable descendant currently owns '
        'focus. Wrap Shortcuts in a Focus widget (autofocus: true) when '
        'the area should respond before the user clicks anything.',
  ),
  _PitfallEntry(
    name: 'Type vs subtype',
    body:
        'Actions are looked up by the exact runtime type of the intent. A '
        'subclass intent will NOT match a parent type binding; register '
        'both if you need polymorphic handling.',
  ),
  _PitfallEntry(
    name: 'Overlapping shortcuts',
    body:
        'The innermost matching Shortcuts widget wins. If a nested area '
        'rebinds Ctrl+S, the outer "save document" handler will never see '
        'the event while focus is inside that area.',
  ),
  _PitfallEntry(
    name: 'Disabled actions still consume',
    body:
        'An action whose isEnabled returns false is not invoked, but the '
        'lookup still succeeds and the key event is considered handled. '
        'Use this deliberately — or return null/skip the binding.',
  ),
  _PitfallEntry(
    name: 'LogicalKeySet vs SingleActivator drift',
    body:
        'LogicalKeySet({Ctrl, S}) and SingleActivator(KeyS, control: true) '
        'look identical but behave differently for "Ctrl pressed AFTER S". '
        'Prefer SingleActivator in new code.',
  ),
  _PitfallEntry(
    name: 'Forgetting to register the intent type',
    body:
        'Shortcuts only emits the intent; if no Actions widget on the '
        'path handles it, the event is dropped silently. Use '
        'Actions.maybeInvoke when this is intentional.',
  ),
];

// =============================================================================
// SHARED CONSTANTS / STYLE HELPERS
// =============================================================================

const double _kPanelPad = 18.0;
const double _kCardRadius = 14.0;
const double _kHeaderGap = 10.0;
const double _kRowGap = 8.0;
const double _kBetweenSections = 26.0;

TextStyle _displayStyle() => const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w800,
      color: _kInk,
      height: 1.1,
      letterSpacing: -0.5,
    );

TextStyle _subtitleStyle() => const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: _kMuted,
      height: 1.35,
    );

TextStyle _sectionTitleStyle() => const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: _kInk,
      letterSpacing: -0.2,
      height: 1.2,
    );

TextStyle _sectionLeadStyle() => const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: _kMuted,
      height: 1.4,
    );

TextStyle _cardTitleStyle() => const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: _kInk,
      height: 1.25,
    );

TextStyle _bodyStyle() => const TextStyle(
      fontSize: 13.5,
      fontWeight: FontWeight.w400,
      color: _kInkSoft,
      height: 1.45,
    );

TextStyle _smallStyle() => const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: _kMuted,
      height: 1.4,
    );

TextStyle _monoStyle({Color color = _kInk}) => TextStyle(
      fontSize: 12.5,
      fontFamily: 'monospace',
      fontFamilyFallback: const <String>['Courier', 'Menlo', 'monospace'],
      color: color,
      height: 1.4,
    );

const Color _kInk = Color(0xFF0F172A);
const Color _kInkSoft = Color(0xFF1E293B);
const Color _kMuted = Color(0xFF64748B);
const Color _kOutline = Color(0xFFD0D7E2);
const Color _kOutlineSoft = Color(0xFFE5EAF1);

// =============================================================================
// BUILD HELPER FUNCTIONS — small visual atoms
// =============================================================================

Widget _buildBadge({
  required String text,
  required Color tint,
  required Color tintInk,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: tint,
      borderRadius: BorderRadius.circular(999),
      border: Border.all(color: tintInk.withOpacity(0.15)),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
        color: tintInk,
        letterSpacing: 0.4,
      ),
    ),
  );
}

Widget _buildKeyCap(String token) {
  final bool isLetter = token.length == 1;
  return Container(
    constraints: BoxConstraints(minWidth: isLetter ? 28 : 36, minHeight: 28),
    padding: EdgeInsets.symmetric(horizontal: isLetter ? 8 : 10, vertical: 4),
    decoration: BoxDecoration(
      color: const Color(0xFFFAFBFD),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _kOutline),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x12000000),
          offset: Offset(0, 1),
          blurRadius: 0,
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Text(
      token,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: _kInk,
        height: 1.0,
        fontFamily: 'monospace',
        fontFamilyFallback: <String>['Courier', 'Menlo', 'monospace'],
      ),
    ),
  );
}

Widget _buildKeyCombo(List<String> tokens) {
  final List<Widget> parts = <Widget>[];
  for (int i = 0; i < tokens.length; i++) {
    parts.add(_buildKeyCap(tokens[i]));
    if (i < tokens.length - 1) {
      parts.add(
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            '+',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _kMuted,
            ),
          ),
        ),
      );
    }
  }
  return Row(mainAxisSize: MainAxisSize.min, children: parts);
}

Widget _buildArrow({Color color = _kMuted}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6),
    child: Icon(Icons.east, size: 16, color: color),
  );
}

Widget _buildPanelHeader({
  required String eyebrow,
  required String title,
  required String lead,
  required Color tint,
  required Color tintInk,
  IconData icon = Icons.bolt_outlined,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: tint,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: tintInk.withOpacity(0.18)),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: tintInk, size: 22),
      ),
      const SizedBox(width: 14),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              eyebrow,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
                color: tintInk,
                letterSpacing: 1.4,
              ),
            ),
            const SizedBox(height: 4),
            Text(title, style: _sectionTitleStyle()),
            const SizedBox(height: 6),
            Text(lead, style: _sectionLeadStyle()),
          ],
        ),
      ),
    ],
  );
}

Widget _buildCard({required Widget child, EdgeInsets? padding, Color? color}) {
  return Container(
    padding: padding ?? const EdgeInsets.all(_kPanelPad),
    decoration: BoxDecoration(
      color: color ?? _kPalette.surface,
      borderRadius: BorderRadius.circular(_kCardRadius),
      border: Border.all(color: _kOutline),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x0A0F172A),
          offset: Offset(0, 6),
          blurRadius: 16,
        ),
      ],
    ),
    child: child,
  );
}

Widget _buildPill({required String text, required Color color}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color.withOpacity(0.14),
      borderRadius: BorderRadius.circular(999),
      border: Border.all(color: color.withOpacity(0.35)),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: 0.6,
      ),
    ),
  );
}

Widget _buildDivider() {
  return Container(height: 1, color: _kOutlineSoft);
}

Widget _buildLabeledValue(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: _kMuted,
          letterSpacing: 0.8,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        value,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: _kInk,
        ),
      ),
    ],
  );
}

// =============================================================================
// SECTION BUILDERS — DOSSIER
// =============================================================================

Widget _buildDossierEntry(_DossierEntry entry) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: entry.tint,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: entry.tintInk.withOpacity(0.15)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: entry.tintInk.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Icon(entry.icon, color: entry.tintInk, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                entry.title,
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w800,
                  color: entry.tintInk,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                entry.body,
                style: TextStyle(
                  fontSize: 13,
                  color: entry.tintInk.withOpacity(0.86),
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildDossierSection() {
  final List<Widget> entries = <Widget>[];
  for (final _DossierEntry e in _kDossier) {
    entries.add(_buildDossierEntry(e));
    entries.add(const SizedBox(height: 10));
  }
  if (entries.isNotEmpty) entries.removeLast();

  return _buildCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildPanelHeader(
          eyebrow: 'DOSSIER',
          title: 'Decouple input from behavior',
          lead:
              'Actions and Intents form a tiny command bus for the UI: many '
              'inputs, one declarative shape, many possible handlers — chosen '
              'by context, not by the input device.',
          tint: const Color(0xFFEFF6FF),
          tintInk: const Color(0xFF1D4ED8),
          icon: Icons.bolt_outlined,
        ),
        const SizedBox(height: 16),
        ...entries,
      ],
    ),
  );
}

// =============================================================================
// SECTION BUILDERS — ANATOMY (pipeline diagram)
// =============================================================================

class _AnatomyStage {
  final String name;
  final String role;
  final IconData icon;
  final Color tint;
  final Color tintInk;
  const _AnatomyStage({
    required this.name,
    required this.role,
    required this.icon,
    required this.tint,
    required this.tintInk,
  });
}

const List<_AnatomyStage> _kAnatomyStages = <_AnatomyStage>[
  _AnatomyStage(
    name: 'Key event',
    role: 'HardwareKeyboard feeds the focus tree.',
    icon: Icons.keyboard_alt_outlined,
    tint: Color(0xFFE0F2FE),
    tintInk: Color(0xFF075985),
  ),
  _AnatomyStage(
    name: 'Shortcuts',
    role: 'Activator matches → Intent created.',
    icon: Icons.shortcut_outlined,
    tint: Color(0xFFEDE9FE),
    tintInk: Color(0xFF5B21B6),
  ),
  _AnatomyStage(
    name: 'Actions lookup',
    role: 'Walks ancestors for Intent type.',
    icon: Icons.search,
    tint: Color(0xFFFEF3C7),
    tintInk: Color(0xFF713F12),
  ),
  _AnatomyStage(
    name: 'Dispatcher',
    role: 'Calls Action.invoke() with intent.',
    icon: Icons.swap_horiz,
    tint: Color(0xFFCCFBF1),
    tintInk: Color(0xFF134E4A),
  ),
  _AnatomyStage(
    name: 'Side effect',
    role: 'Document mutated, focus moved, etc.',
    icon: Icons.check_circle_outline,
    tint: Color(0xFFD1FAE5),
    tintInk: Color(0xFF065F46),
  ),
];

Widget _buildAnatomyStageCard(_AnatomyStage stage, int index) {
  return Container(
    width: 152,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: stage.tint,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: stage.tintInk.withOpacity(0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: stage.tintInk,
                borderRadius: BorderRadius.circular(7),
              ),
              alignment: Alignment.center,
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Icon(stage.icon, size: 18, color: stage.tintInk),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          stage.name,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: stage.tintInk,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          stage.role,
          style: TextStyle(
            fontSize: 11.5,
            color: stage.tintInk.withOpacity(0.85),
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

Widget _buildAnatomySection() {
  final List<Widget> rowChildren = <Widget>[];
  for (int i = 0; i < _kAnatomyStages.length; i++) {
    rowChildren.add(_buildAnatomyStageCard(_kAnatomyStages[i], i));
    if (i < _kAnatomyStages.length - 1) {
      rowChildren.add(_buildArrow(color: _kInk.withOpacity(0.4)));
    }
  }

  return _buildCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildPanelHeader(
          eyebrow: 'ANATOMY',
          title: 'From key event to side effect',
          lead:
              'Five hops. Each one is a separable widget or class, which is '
              'why you can swap activators, intents, actions, and dispatchers '
              'independently.',
          tint: const Color(0xFFFEF3C7),
          tintInk: const Color(0xFF713F12),
          icon: Icons.account_tree_outlined,
        ),
        const SizedBox(height: 18),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rowChildren,
          ),
        ),
        const SizedBox(height: 18),
        _buildDivider(),
        const SizedBox(height: 14),
        Text(
          'Pipeline notes',
          style: _cardTitleStyle(),
        ),
        const SizedBox(height: 8),
        _buildBulletLine(
          'The dispatcher boundary is where most subclassing happens — log, '
          'wrap with telemetry, or short-circuit forbidden intents there.',
        ),
        _buildBulletLine(
          'Actions are resolved by walking up from the focused widget, not '
          'from the root. Two areas can resolve the same Intent differently.',
        ),
        _buildBulletLine(
          'Shortcuts is just one source of intents — you can also call '
          'Actions.invoke from a button onPressed, gesture, or controller.',
        ),
      ],
    ),
  );
}

Widget _buildBulletLine(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(top: 7, right: 10),
          decoration: const BoxDecoration(
            color: _kInk,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(child: Text(text, style: _bodyStyle())),
      ],
    ),
  );
}

// =============================================================================
// SECTION BUILDERS — KEY MAP TABLE
// =============================================================================

Widget _buildKeyMapHeaderRow() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: const Color(0xFFF8FAFC),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kOutlineSoft),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Text(
            'Shortcut',
            style: _smallStyle().copyWith(
              fontWeight: FontWeight.w800,
              color: _kInk,
              letterSpacing: 0.8,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'Intent type',
            style: _smallStyle().copyWith(
              fontWeight: FontWeight.w800,
              color: _kInk,
              letterSpacing: 0.8,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'Action binding',
            style: _smallStyle().copyWith(
              fontWeight: FontWeight.w800,
              color: _kInk,
              letterSpacing: 0.8,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            'Purpose',
            style: _smallStyle().copyWith(
              fontWeight: FontWeight.w800,
              color: _kInk,
              letterSpacing: 0.8,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildKeyMapRow(_ShortcutRecord r, int index) {
  final Color stripe = index.isEven ? Colors.white : const Color(0xFFFBFCFE);
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: stripe,
      border: Border(
        bottom: BorderSide(color: _kOutlineSoft),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildKeyCombo(r.keyTokens),
              const SizedBox(height: 4),
              Text(
                r.usesSingleActivator ? 'SingleActivator' : 'LogicalKeySet',
                style: _smallStyle().copyWith(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: r.usesSingleActivator
                      ? const Color(0xFF0D9488)
                      : const Color(0xFFB45309),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: r.tint,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: r.tintInk.withOpacity(0.18)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.flag_outlined, size: 14, color: r.tintInk),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    r.intentName,
                    style: _monoStyle(color: r.tintInk).copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: <Widget>[
              _buildArrow(color: r.tintInk),
              Flexible(
                child: Text(
                  r.actionName,
                  style: _monoStyle(color: r.tintInk).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            r.purpose,
            style: _bodyStyle(),
          ),
        ),
      ],
    ),
  );
}

Widget _buildKeyMapSection() {
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < _kShortcutRecords.length; i++) {
    rows.add(_buildKeyMapRow(_kShortcutRecords[i], i));
  }

  return _buildCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildPanelHeader(
          eyebrow: 'KEY MAP',
          title: 'Shortcut → Intent → Action',
          lead:
              'A living lookup table for the demo. Each row is a real entry '
              'in the demo\'s Shortcuts and Actions widgets below.',
          tint: const Color(0xFFF0FDFA),
          tintInk: const Color(0xFF0D9488),
          icon: Icons.keyboard_command_key,
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kOutlineSoft),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              _buildKeyMapHeaderRow(),
              ...rows,
            ],
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION BUILDERS — RECIPES
// =============================================================================

class _Recipe {
  final String title;
  final String story;
  final List<String> steps;
  final String snippet;
  final Color tint;
  final Color tintInk;
  final IconData icon;
  const _Recipe({
    required this.title,
    required this.story,
    required this.steps,
    required this.snippet,
    required this.tint,
    required this.tintInk,
    required this.icon,
  });
}

const List<_Recipe> _kRecipes = <_Recipe>[
  _Recipe(
    title: 'Save with Ctrl+S',
    story:
        'The save shortcut is the textbook Actions/Intents example. It '
        'declares a parameterized SaveIntent carrying the document id and '
        'registers a SaveAction that knows where to flush.',
    steps: <String>[
      'Define _SaveDocumentIntent extends Intent with a document field.',
      'Define _SaveDocumentAction extends Action<_SaveDocumentIntent>.',
      'Wrap UI with Shortcuts: SingleActivator(KeyS, control: true) → '
          'SaveIntent(documentId).',
      'Wrap that with Actions: {SaveIntent: SaveAction(onSave: ...)}.',
      'Focus must live inside this subtree for the shortcut to fire.',
    ],
    snippet:
        'Shortcuts(\n'
        '  shortcuts: <ShortcutActivator, Intent>{\n'
        '    SingleActivator(LogicalKeyboardKey.keyS, control: true):\n'
        '        _SaveDocumentIntent(currentDocId),\n'
        '  },\n'
        '  child: Actions(\n'
        '    actions: <Type, Action<Intent>>{\n'
        '      _SaveDocumentIntent: _SaveDocumentAction(persist),\n'
        '    },\n'
        '    child: Focus(autofocus: true, child: editor),\n'
        '  ),\n'
        ')',
    tint: Color(0xFFDBEAFE),
    tintInk: Color(0xFF1E3A8A),
    icon: Icons.save_outlined,
  ),
  _Recipe(
    title: 'Copy / Paste / Cut',
    story:
        'Each clipboard verb is a distinct Intent. CopyIntent and CutIntent '
        'carry the current selection so the Action does not need access to '
        'the editor controller directly.',
    steps: <String>[
      'Three Intents: _CopyIntent(selection), _CutIntent(selection), '
          '_PasteIntent.',
      'Three Actions; each calls into the document model.',
      'Bind: Ctrl+C → CopyIntent, Ctrl+X → CutIntent, Ctrl+V → PasteIntent.',
      'Disable Cut when selection is empty by overriding isEnabled.',
    ],
    snippet:
        'class _CutAction extends Action<_CutIntent> {\n'
        '  bool isEnabled(_CutIntent i) => i.selection.isNotEmpty;\n'
        '  Object? invoke(_CutIntent i) { clipboard = i.selection; '
        'delete(); return null; }\n'
        '}',
    tint: Color(0xFFCCFBF1),
    tintInk: Color(0xFF134E4A),
    icon: Icons.content_copy_outlined,
  ),
  _Recipe(
    title: 'Undo / Redo',
    story:
        'Undo and Redo are pure semantic verbs — the document history stack '
        'lives elsewhere. The Action is a thin shim that pops or pushes that '
        'stack, freeing the keystroke binding from caring about scope.',
    steps: <String>[
      'One UndoIntent, one RedoIntent — both empty.',
      'Bind Ctrl+Z → UndoIntent, Ctrl+Shift+Z → RedoIntent.',
      'Action.isEnabled returns whether the stack has anything to pop.',
      'When the stack changes, call action.notifyActionListeners() to '
          'refresh ActionListener consumers.',
    ],
    snippet:
        'class _UndoAction extends Action<_UndoIntent> {\n'
        '  bool isEnabled(_UndoIntent _) => history.canUndo;\n'
        '  Object? invoke(_UndoIntent _) { history.undo(); '
        'notifyActionListeners(); return null; }\n'
        '}',
    tint: Color(0xFFFECACA),
    tintInk: Color(0xFF7F1D1D),
    icon: Icons.undo,
  ),
  _Recipe(
    title: 'Custom navigation',
    story:
        'Pane navigation has the same problem as save: many ways to trigger '
        '(menu, gesture, keystroke), one canonical handler. Use Intents '
        'with a target argument or use sibling intents for direction.',
    steps: <String>[
      'Define NavigateNextIntent and NavigatePreviousIntent.',
      'CallbackAction can wrap the existing TabController.animateTo logic.',
      'Bind Ctrl+Tab and Ctrl+Shift+Tab via SingleActivator.',
      'Allow the same intents to be triggered from a bottom button bar '
          'via Actions.invoke(context, ...).',
    ],
    snippet:
        'CallbackAction<_NavigateNextIntent>(\n'
        '  onInvoke: (intent) { tabs.animateTo(tabs.index + 1); return null; },\n'
        ')',
    tint: Color(0xFFC7D2FE),
    tintInk: Color(0xFF312E81),
    icon: Icons.swap_horiz,
  ),
  _Recipe(
    title: 'Focus traversal intents',
    story:
        'Flutter ships first-class intents for moving focus: '
        'NextFocusIntent, PreviousFocusIntent, DirectionalFocusIntent. The '
        'WidgetsApp installs default Actions for these — usually you only '
        'add the Shortcuts side.',
    steps: <String>[
      'Tab and Shift+Tab default to NextFocusIntent / PreviousFocusIntent.',
      'Use DirectionalFocusIntent for arrow keys in form-style layouts.',
      'Override the corresponding Action when a custom traversal order is '
          'required.',
    ],
    snippet:
        'Shortcuts(\n'
        '  shortcuts: <ShortcutActivator, Intent>{\n'
        '    SingleActivator(LogicalKeyboardKey.arrowRight):\n'
        '        DirectionalFocusIntent(TraversalDirection.right),\n'
        '  },\n'
        '  child: ...,\n'
        ')',
    tint: Color(0xFFE9D5FF),
    tintInk: Color(0xFF581C87),
    icon: Icons.center_focus_strong_outlined,
  ),
  _Recipe(
    title: 'Multi-modifier shortcuts',
    story:
        'SingleActivator scales gracefully to any combo of '
        'control/shift/alt/meta. Combine flags rather than chaining keys — '
        'the trigger is always one logical key.',
    steps: <String>[
      'Use named flags: control: true, shift: true, alt: true, meta: true.',
      'On macOS the convention is meta (Cmd); on others, control.',
      'Optionally branch by defaultTargetPlatform when building the map.',
    ],
    snippet:
        'final ShortcutActivator commitShortcut = SingleActivator(\n'
        '  LogicalKeyboardKey.enter,\n'
        '  control: defaultTargetPlatform != TargetPlatform.macOS,\n'
        '  meta: defaultTargetPlatform == TargetPlatform.macOS,\n'
        ');',
    tint: Color(0xFFFEF3C7),
    tintInk: Color(0xFF713F12),
    icon: Icons.layers_outlined,
  ),
];

Widget _buildRecipeCard(_Recipe r) {
  final List<Widget> steps = <Widget>[];
  for (int i = 0; i < r.steps.length; i++) {
    steps.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 18,
              height: 18,
              margin: const EdgeInsets.only(right: 8, top: 1),
              decoration: BoxDecoration(
                color: r.tintInk.withOpacity(0.12),
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              child: Text(
                '${i + 1}',
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  color: r.tintInk,
                ),
              ),
            ),
            Expanded(child: Text(r.steps[i], style: _bodyStyle())),
          ],
        ),
      ),
    );
  }

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kPalette.surface,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kOutline),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: r.tint,
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: r.tintInk.withOpacity(0.2)),
              ),
              alignment: Alignment.center,
              child: Icon(r.icon, color: r.tintInk, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(r.title, style: _cardTitleStyle()),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(r.story, style: _bodyStyle()),
        const SizedBox(height: 12),
        ...steps,
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            r.snippet,
            style: _monoStyle(color: const Color(0xFFE2E8F0)).copyWith(
              fontSize: 11.5,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildRecipesSection() {
  final List<Widget> cards = <Widget>[];
  for (final _Recipe r in _kRecipes) {
    cards.add(_buildRecipeCard(r));
    cards.add(const SizedBox(height: 12));
  }
  if (cards.isNotEmpty) cards.removeLast();

  return _buildCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildPanelHeader(
          eyebrow: 'RECIPES',
          title: 'Common bindings, common shapes',
          lead:
              'Each recipe is a tiny end-to-end example: the Intent type, '
              'the Action class, the Shortcuts binding, and the moment of '
              'truth inside invoke().',
          tint: const Color(0xFFEDE9FE),
          tintInk: const Color(0xFF5B21B6),
          icon: Icons.menu_book_outlined,
        ),
        const SizedBox(height: 16),
        ...cards,
      ],
    ),
  );
}

// =============================================================================
// SECTION BUILDERS — SingleActivator vs LogicalKeySet
// =============================================================================

Widget _buildComparisonRow(String label, String singleA, String logicalK) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 150,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
              color: _kInk,
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDFA),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF99F6E4)),
            ),
            child: Text(singleA, style: _bodyStyle()),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFFDE68A)),
            ),
            child: Text(logicalK, style: _bodyStyle()),
          ),
        ),
      ],
    ),
  );
}

Widget _buildActivatorComparisonSection() {
  return _buildCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildPanelHeader(
          eyebrow: 'ACTIVATOR',
          title: 'SingleActivator vs LogicalKeySet',
          lead:
              'They look interchangeable on a slide but behave subtly '
              'differently. Use SingleActivator in new code; reach for '
              'LogicalKeySet only when matching legacy behavior.',
          tint: const Color(0xFFFEF3C7),
          tintInk: const Color(0xFF92400E),
          icon: Icons.compare_arrows,
        ),
        const SizedBox(height: 16),
        Row(
          children: <Widget>[
            const SizedBox(width: 150),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D9488),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'SingleActivator',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 12.5,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFB45309),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'LogicalKeySet',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 12.5,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        _buildDivider(),
        _buildComparisonRow(
          'Trigger key',
          'Exactly one key is the trigger; modifiers are flags.',
          'Any set of keys held simultaneously triggers the match.',
        ),
        _buildComparisonRow(
          'Modifier flags',
          'control / shift / alt / meta as boolean params.',
          'Modifier keys are members of the set, indistinguishable.',
        ),
        _buildComparisonRow(
          'Repeats',
          'includeRepeats flag controls whether held keys re-fire.',
          'Always fires once when the set is fully pressed.',
        ),
        _buildComparisonRow(
          'NumLock',
          'numLock parameter — explicit (.ignored, .on, .off).',
          'No equivalent; matches regardless of NumLock state.',
        ),
        _buildComparisonRow(
          'macOS Cmd',
          'meta: true on macOS, control: true elsewhere.',
          'Add LogicalKeyboardKey.metaLeft to the set.',
        ),
        _buildComparisonRow(
          'Order',
          'Order of modifiers irrelevant; trigger comes last.',
          'No notion of order — any sequence that ends with the set works.',
        ),
        _buildComparisonRow(
          'Recommended use',
          'All new shortcuts; clearer intent, fewer ambiguities.',
          'Compatibility with older code; matching unusual hold-style combos.',
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION BUILDERS — DISPATCHER, LISTENER, INVOKE, FACD
// =============================================================================

class _ConceptCard {
  final String title;
  final String tagline;
  final String body;
  final List<String> bullets;
  final IconData icon;
  final Color tint;
  final Color tintInk;
  const _ConceptCard({
    required this.title,
    required this.tagline,
    required this.body,
    required this.bullets,
    required this.icon,
    required this.tint,
    required this.tintInk,
  });
}

const List<_ConceptCard> _kConcepts = <_ConceptCard>[
  _ConceptCard(
    title: 'ActionDispatcher customization',
    tagline: 'Wrap the dispatch boundary.',
    body:
        'Subclass ActionDispatcher and override invokeAction to interpose '
        'logging, analytics, or guards. Provide your subclass to the '
        'Actions widget via its dispatcher parameter.',
    bullets: <String>[
      'A logging dispatcher writes the intent runtime type to a debug log.',
      'A guard dispatcher can short-circuit forbidden intents at the bus.',
      'A retry dispatcher can re-invoke after async failures.',
      'Make sure to call super.invokeAction to preserve default semantics.',
    ],
    icon: Icons.alt_route,
    tint: Color(0xFFFFE4E6),
    tintInk: Color(0xFF881337),
  ),
  _ConceptCard(
    title: 'ActionListener',
    tagline: 'Rebuild when isEnabled changes.',
    body:
        'Actions extend ChangeNotifier. ActionListener subscribes — its '
        'builder runs whenever the action calls notifyActionListeners(), '
        'typically because its isEnabled changed.',
    bullets: <String>[
      'Useful for menus and toolbars that need to grey out commands.',
      'Pair with an Action that watches model state to decide isEnabled.',
      'Avoid building the entire screen — wrap only the affordance.',
    ],
    icon: Icons.hearing,
    tint: Color(0xFFE0E7FF),
    tintInk: Color(0xFF3730A3),
  ),
  _ConceptCard(
    title: 'Actions.invoke vs maybeInvoke',
    tagline: 'Imperative trigger from any context.',
    body:
        'Both walk the focus tree from context upward and look for an '
        'Action matching the intent\'s runtime type. invoke asserts that '
        'a handler exists; maybeInvoke returns null silently.',
    bullets: <String>[
      'Use invoke when the binding is part of your component\'s contract.',
      'Use maybeInvoke for optional commands (e.g. plug-in style features).',
      'Both return the value produced by Action.invoke.',
    ],
    icon: Icons.touch_app_outlined,
    tint: Color(0xFFCCFBF1),
    tintInk: Color(0xFF134E4A),
  ),
  _ConceptCard(
    title: 'FocusableActionDetector',
    tagline: 'Focus + Shortcuts + Actions + hover.',
    body:
        'A high-level wrapper for building custom controls — checkboxes, '
        'cards, menu items — that should respond to keyboard and pointer '
        'consistently with Material expectations.',
    bullets: <String>[
      'Reports focus state and hover state via callbacks.',
      'Manages its own internal FocusNode unless one is supplied.',
      'Plays nicely with WidgetsApp\'s default focus shortcuts.',
      'Designed to be the building block for custom Material-like controls.',
    ],
    icon: Icons.center_focus_weak_outlined,
    tint: Color(0xFFD1FAE5),
    tintInk: Color(0xFF065F46),
  ),
];

Widget _buildConceptCard(_ConceptCard c) {
  final List<Widget> bulletWidgets = <Widget>[];
  for (final String b in c.bullets) {
    bulletWidgets.add(
      Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 5,
              height: 5,
              margin: const EdgeInsets.only(top: 7, right: 8),
              decoration: BoxDecoration(
                color: c.tintInk,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(child: Text(b, style: _bodyStyle())),
          ],
        ),
      ),
    );
  }
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kPalette.surface,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kOutline),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: c.tint,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: c.tintInk.withOpacity(0.2)),
              ),
              alignment: Alignment.center,
              child: Icon(c.icon, color: c.tintInk, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(c.title, style: _cardTitleStyle()),
                  const SizedBox(height: 2),
                  Text(
                    c.tagline,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: c.tintInk,
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(c.body, style: _bodyStyle()),
        ...bulletWidgets,
      ],
    ),
  );
}

Widget _buildConceptsSection() {
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < _kConcepts.length; i += 2) {
    final _ConceptCard a = _kConcepts[i];
    final _ConceptCard? b = i + 1 < _kConcepts.length ? _kConcepts[i + 1] : null;
    rows.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _buildConceptCard(a)),
            const SizedBox(width: 12),
            if (b != null)
              Expanded(child: _buildConceptCard(b))
            else
              const Expanded(child: SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
  return _buildCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildPanelHeader(
          eyebrow: 'INTERNALS',
          title: 'Dispatcher, Listener, Invoke, FocusableActionDetector',
          lead:
              'Four orthogonal pieces of the framework. Each one lets a '
              'specific kind of code stay outside the Actions widget tree.',
          tint: const Color(0xFFE0F2FE),
          tintInk: const Color(0xFF075985),
          icon: Icons.settings_input_component_outlined,
        ),
        const SizedBox(height: 14),
        ...rows,
      ],
    ),
  );
}

// =============================================================================
// SECTION BUILDERS — VS RAW KEYBOARD (comparison)
// =============================================================================

class _ComparisonRow {
  final String concern;
  final String raw;
  final String actionsIntents;
  final IconData icon;
  const _ComparisonRow({
    required this.concern,
    required this.raw,
    required this.actionsIntents,
    required this.icon,
  });
}

const List<_ComparisonRow> _kRawCompare = <_ComparisonRow>[
  _ComparisonRow(
    concern: 'Granularity',
    raw: 'Key down/up events; you parse modifiers yourself.',
    actionsIntents:
        'High-level activators describe combos symbolically and match cleanly.',
    icon: Icons.tune,
  ),
  _ComparisonRow(
    concern: 'Scope',
    raw: 'Listener only sees events for its own focused subtree.',
    actionsIntents:
        'Shortcuts/Actions follow the focus chain across the entire app.',
    icon: Icons.account_tree_outlined,
  ),
  _ComparisonRow(
    concern: 'Override',
    raw: 'Need to manually skip processing based on state.',
    actionsIntents:
        'Inner Actions widget naturally shadows the outer mapping.',
    icon: Icons.layers_outlined,
  ),
  _ComparisonRow(
    concern: 'Disabled state',
    raw: 'Conditionally early-return inside the handler.',
    actionsIntents:
        'Action.isEnabled returns false; framework treats it as missing.',
    icon: Icons.block_outlined,
  ),
  _ComparisonRow(
    concern: 'Triggering from menu/button',
    raw: 'Duplicate the handler or extract into a function.',
    actionsIntents:
        'Same Intent can be invoked via Actions.invoke(context, intent).',
    icon: Icons.menu_open,
  ),
  _ComparisonRow(
    concern: 'Telemetry',
    raw: 'Sprinkle logs in every handler.',
    actionsIntents:
        'Subclass ActionDispatcher once; all intents flow through it.',
    icon: Icons.analytics_outlined,
  ),
  _ComparisonRow(
    concern: 'Platform handling',
    raw: 'Branch on platform inside the listener.',
    actionsIntents:
        'Build a different Shortcuts map per platform; rest of code unchanged.',
    icon: Icons.devices_other,
  ),
  _ComparisonRow(
    concern: 'Testability',
    raw: 'Synthesize key events; brittle.',
    actionsIntents:
        'Test Actions by invoking their Intents directly — no key sim needed.',
    icon: Icons.science_outlined,
  ),
];

Widget _buildRawCompareRow(_ComparisonRow r) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 170,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(r.icon, size: 16, color: _kInk),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  r.concern,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: _kInk,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF2F2),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFFECACA)),
            ),
            child: Text(r.raw, style: _bodyStyle()),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDFA),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF99F6E4)),
            ),
            child: Text(r.actionsIntents, style: _bodyStyle()),
          ),
        ),
      ],
    ),
  );
}

Widget _buildRawCompareSection() {
  final List<Widget> rows = <Widget>[];
  for (final _ComparisonRow r in _kRawCompare) {
    rows.add(_buildRawCompareRow(r));
  }
  return _buildCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildPanelHeader(
          eyebrow: 'COMPARE',
          title: 'Actions/Intents vs RawKeyboardListener',
          lead:
              'Raw key listeners and HardwareKeyboard are still useful for '
              'specialized cases (games, custom keymaps), but they re-implement '
              'a lot of what Actions/Intents already does.',
          tint: const Color(0xFFFEE2E2),
          tintInk: const Color(0xFF991B1B),
          icon: Icons.compare_outlined,
        ),
        const SizedBox(height: 14),
        Row(
          children: <Widget>[
            const SizedBox(width: 170),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFB91C1C),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'RawKeyboardListener / HardwareKeyboard',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F766E),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Actions / Intents / Shortcuts',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 12.5,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        _buildDivider(),
        ...rows,
      ],
    ),
  );
}

// =============================================================================
// SECTION BUILDERS — PITFALLS
// =============================================================================

Widget _buildPitfallCard(_PitfallEntry p, int idx) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFBEB),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFFFDE68A)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: const Color(0xFFB45309),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            '${idx + 1}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                p.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF78350F),
                ),
              ),
              const SizedBox(height: 4),
              Text(p.body, style: _bodyStyle()),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildPitfallsSection() {
  final List<Widget> cards = <Widget>[];
  for (int i = 0; i < _kPitfalls.length; i++) {
    cards.add(_buildPitfallCard(_kPitfalls[i], i));
    if (i < _kPitfalls.length - 1) cards.add(const SizedBox(height: 10));
  }
  return _buildCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildPanelHeader(
          eyebrow: 'PITFALLS',
          title: 'Common traps & how to avoid them',
          lead:
              'These bite first-time users of Actions/Intents — almost all '
              'related to focus path lookups and to subclass-vs-runtime-type '
              'expectations.',
          tint: const Color(0xFFFEF3C7),
          tintInk: const Color(0xFF92400E),
          icon: Icons.warning_amber_outlined,
        ),
        const SizedBox(height: 14),
        ...cards,
      ],
    ),
  );
}

// =============================================================================
// SECTION BUILDERS — GLOSSARY
// =============================================================================

Widget _buildGlossaryRow(_GlossaryTerm term, int idx) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    decoration: BoxDecoration(
      color: idx.isEven ? const Color(0xFFFBFCFE) : Colors.white,
      border: Border(bottom: BorderSide(color: _kOutlineSoft)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 220,
          child: Text(
            term.name,
            style: _monoStyle(color: _kInk).copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 12.5,
            ),
          ),
        ),
        Expanded(child: Text(term.definition, style: _bodyStyle())),
      ],
    ),
  );
}

Widget _buildGlossarySection() {
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < _kGlossary.length; i++) {
    rows.add(_buildGlossaryRow(_kGlossary[i], i));
  }
  return _buildCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildPanelHeader(
          eyebrow: 'GLOSSARY',
          title: 'The vocabulary',
          lead:
              'A concise lexicon for the Actions/Intents framework — useful '
              'when reading the SDK source or talking with reviewers.',
          tint: const Color(0xFFF1F5F9),
          tintInk: const Color(0xFF334155),
          icon: Icons.menu_book_outlined,
        ),
        const SizedBox(height: 14),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kOutlineSoft),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(children: rows),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION BUILDERS — LIVE DEMO TREE (actual Actions/Shortcuts widget tree)
// =============================================================================

Widget _buildLiveDemoTree() {
  final List<String> savedDocs = <String>[];
  final List<String> copiedSelections = <String>[];
  final List<String> dispatchLog = <String>[];
  int pasteCount = 0;
  int undoCount = 0;
  int redoCount = 0;

  void onSave(String doc) {
    savedDocs.add(doc);
  }

  void onCopy(String s) {
    copiedSelections.add(s);
  }

  void onPaste() {
    pasteCount++;
  }

  void onUndo() {
    undoCount++;
  }

  void onRedo() {
    redoCount++;
  }

  final FocusNode demoNode = FocusNode(debugLabel: 'actions_demo_root');

  // Build an actual Actions/Shortcuts widget tree — the demo doesn't need
  // user interaction, but the structure is real and analyzer-checked.
  final Map<ShortcutActivator, Intent> shortcuts =
      <ShortcutActivator, Intent>{
    const SingleActivator(LogicalKeyboardKey.keyS, control: true):
        const _SaveDocumentIntent('untitled-1.md'),
    const SingleActivator(LogicalKeyboardKey.keyC, control: true):
        const _CopyIntent('hello world'),
    const SingleActivator(LogicalKeyboardKey.keyV, control: true):
        const _PasteIntent(),
    const SingleActivator(LogicalKeyboardKey.keyX, control: true):
        const _CutIntent('hello'),
    const SingleActivator(LogicalKeyboardKey.keyZ, control: true):
        const _UndoIntent(),
    const SingleActivator(LogicalKeyboardKey.keyZ, control: true, shift: true):
        const _RedoIntent(),
    const SingleActivator(LogicalKeyboardKey.keyP, control: true, shift: true):
        const _OpenPaletteIntent(),
    const SingleActivator(LogicalKeyboardKey.tab, control: true):
        const _NavigateNextIntent(),
    const SingleActivator(LogicalKeyboardKey.tab, control: true, shift: true):
        const _NavigatePreviousIntent(),
    const SingleActivator(LogicalKeyboardKey.keyB, control: true):
        const _BoldIntent(),
    const SingleActivator(LogicalKeyboardKey.keyI, control: true):
        const _ItalicIntent(),
    const SingleActivator(LogicalKeyboardKey.equal, control: true):
        const _ZoomInIntent(),
    const SingleActivator(LogicalKeyboardKey.minus, control: true):
        const _ZoomOutIntent(),
    LogicalKeySet(LogicalKeyboardKey.escape): const DismissIntent(),
  };

  final Map<Type, Action<Intent>> actions = <Type, Action<Intent>>{
    _SaveDocumentIntent: _SaveDocumentAction(onSave),
    _CopyIntent: _CopyAction(onCopy),
    _PasteIntent: _PasteAction(onPaste),
    _UndoIntent: _UndoAction(onUndo),
    _RedoIntent: _RedoAction(onRedo),
    _OpenPaletteIntent: CallbackAction<_OpenPaletteIntent>(
      onInvoke: (_OpenPaletteIntent _) => null,
    ),
    _NavigateNextIntent: CallbackAction<_NavigateNextIntent>(
      onInvoke: (_NavigateNextIntent _) => null,
    ),
    _NavigatePreviousIntent: CallbackAction<_NavigatePreviousIntent>(
      onInvoke: (_NavigatePreviousIntent _) => null,
    ),
    _BoldIntent: CallbackAction<_BoldIntent>(
      onInvoke: (_BoldIntent _) => null,
    ),
    _ItalicIntent: CallbackAction<_ItalicIntent>(
      onInvoke: (_ItalicIntent _) => null,
    ),
    _ZoomInIntent: CallbackAction<_ZoomInIntent>(
      onInvoke: (_ZoomInIntent _) => null,
    ),
    _ZoomOutIntent: CallbackAction<_ZoomOutIntent>(
      onInvoke: (_ZoomOutIntent _) => null,
    ),
  };

  final ActionDispatcher dispatcher = _LoggingDispatcher(dispatchLog);

  return _buildCard(
    color: const Color(0xFFFAFBFD),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildPanelHeader(
          eyebrow: 'LIVE DEMO',
          title: 'Real Actions / Shortcuts tree',
          lead:
              'The widgets below are wired into a real Shortcuts → Actions → '
              'Focus subtree using a custom logging dispatcher. The visual '
              'tree label mirrors the runtime structure.',
          tint: const Color(0xFFE0F2FE),
          tintInk: const Color(0xFF075985),
          icon: Icons.bolt,
        ),
        const SizedBox(height: 16),
        Shortcuts(
          shortcuts: shortcuts,
          child: Actions(
            dispatcher: dispatcher,
            actions: actions,
            child: Focus(
              focusNode: demoNode,
              autofocus: false,
              child: _buildLiveDemoBody(),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildLiveDemoBody() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _buildTreeStratum(
        depth: 0,
        widgetName: 'Shortcuts',
        note: 'Map<ShortcutActivator, Intent> — translates key events.',
        tint: const Color(0xFFEDE9FE),
        tintInk: const Color(0xFF5B21B6),
        icon: Icons.shortcut_outlined,
      ),
      _buildTreeStratum(
        depth: 1,
        widgetName: 'Actions',
        note: 'Map<Type, Action<Intent>> — resolves intents to handlers.',
        tint: const Color(0xFFFEF3C7),
        tintInk: const Color(0xFF92400E),
        icon: Icons.layers,
      ),
      _buildTreeStratum(
        depth: 2,
        widgetName: '+ _LoggingDispatcher',
        note: 'Subclass ActionDispatcher — logs every invocation.',
        tint: const Color(0xFFFFE4E6),
        tintInk: const Color(0xFF9F1239),
        icon: Icons.alt_route,
      ),
      _buildTreeStratum(
        depth: 3,
        widgetName: 'Focus(focusNode: demoNode)',
        note: 'Provides the focus owner for the shortcut chain.',
        tint: const Color(0xFFCCFBF1),
        tintInk: const Color(0xFF115E59),
        icon: Icons.center_focus_strong_outlined,
      ),
      _buildTreeStratum(
        depth: 4,
        widgetName: 'Editor surface (placeholder)',
        note: 'Where the actual content lives — text fields, canvas, etc.',
        tint: const Color(0xFFE0E7FF),
        tintInk: const Color(0xFF3730A3),
        icon: Icons.edit_note_outlined,
      ),
      const SizedBox(height: 14),
      _buildDivider(),
      const SizedBox(height: 14),
      _buildInvocationFlow(),
      const SizedBox(height: 14),
      _buildActionsMapInspector(),
    ],
  );
}

Widget _buildTreeStratum({
  required int depth,
  required String widgetName,
  required String note,
  required Color tint,
  required Color tintInk,
  required IconData icon,
}) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 18.0, bottom: 6),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: tint,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tintInk.withOpacity(0.2)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: tintInk,
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: Colors.white, size: 13),
          ),
          const SizedBox(width: 10),
          Text(
            widgetName,
            style: _monoStyle(color: tintInk).copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              note,
              style: TextStyle(
                fontSize: 12,
                color: tintInk.withOpacity(0.86),
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// =============================================================================
// SECTION BUILDERS — INVOCATION FLOW (visual arrows)
// =============================================================================

Widget _buildInvocationFlow() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text('Invocation flow visualization', style: _cardTitleStyle()),
      const SizedBox(height: 4),
      Text(
        'Walks the path of a single Ctrl+S keystroke through the demo tree.',
        style: _smallStyle(),
      ),
      const SizedBox(height: 12),
      _buildFlowStep(
        index: 1,
        title: 'KeyDownEvent',
        detail: 'physicalKey=KeyS, logicalKey=KeyS, control held',
        tint: const Color(0xFFEFF6FF),
        tintInk: const Color(0xFF1E3A8A),
      ),
      _buildFlowConnector(),
      _buildFlowStep(
        index: 2,
        title: 'Shortcuts.matches',
        detail:
            'SingleActivator(LogicalKeyboardKey.keyS, control: true) matches.',
        tint: const Color(0xFFEDE9FE),
        tintInk: const Color(0xFF5B21B6),
      ),
      _buildFlowConnector(),
      _buildFlowStep(
        index: 3,
        title: 'Intent created',
        detail: '_SaveDocumentIntent(\'untitled-1.md\')',
        tint: const Color(0xFFCCFBF1),
        tintInk: const Color(0xFF134E4A),
      ),
      _buildFlowConnector(),
      _buildFlowStep(
        index: 4,
        title: 'Actions.lookup',
        detail: 'Walk focus path; resolve _SaveDocumentIntent.',
        tint: const Color(0xFFFEF3C7),
        tintInk: const Color(0xFF92400E),
      ),
      _buildFlowConnector(),
      _buildFlowStep(
        index: 5,
        title: 'Dispatcher.invokeAction',
        detail:
            '_LoggingDispatcher writes "dispatch:_SaveDocumentIntent", then '
            'forwards to super.invokeAction.',
        tint: const Color(0xFFFFE4E6),
        tintInk: const Color(0xFF9F1239),
      ),
      _buildFlowConnector(),
      _buildFlowStep(
        index: 6,
        title: 'Action.invoke',
        detail: '_SaveDocumentAction.invoke calls onSave(\'untitled-1.md\').',
        tint: const Color(0xFFD1FAE5),
        tintInk: const Color(0xFF065F46),
      ),
      _buildFlowConnector(),
      _buildFlowStep(
        index: 7,
        title: 'Return value',
        detail:
            'invoke returns "saved:untitled-1.md"; framework reports the '
            'event as handled.',
        tint: const Color(0xFFE0E7FF),
        tintInk: const Color(0xFF3730A3),
      ),
    ],
  );
}

Widget _buildFlowStep({
  required int index,
  required String title,
  required String detail,
  required Color tint,
  required Color tintInk,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: tint,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: tintInk.withOpacity(0.2)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: tintInk,
            borderRadius: BorderRadius.circular(7),
          ),
          alignment: Alignment.center,
          child: Text(
            '$index',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 12.5,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                  color: tintInk,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                detail,
                style: TextStyle(
                  fontSize: 12,
                  color: tintInk.withOpacity(0.86),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildFlowConnector() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
    child: Row(
      children: <Widget>[
        Container(width: 2, height: 14, color: _kOutline),
      ],
    ),
  );
}

// =============================================================================
// SECTION BUILDERS — Actions map inspector
// =============================================================================

class _InspectorRow {
  final String intentType;
  final String actionType;
  final String enabledHint;
  const _InspectorRow({
    required this.intentType,
    required this.actionType,
    required this.enabledHint,
  });
}

const List<_InspectorRow> _kInspector = <_InspectorRow>[
  _InspectorRow(
    intentType: '_SaveDocumentIntent',
    actionType: '_SaveDocumentAction',
    enabledHint: 'enabled when document is dirty',
  ),
  _InspectorRow(
    intentType: '_CopyIntent',
    actionType: '_CopyAction',
    enabledHint: 'enabled when selection is non-empty',
  ),
  _InspectorRow(
    intentType: '_PasteIntent',
    actionType: '_PasteAction',
    enabledHint: 'enabled when clipboard has content',
  ),
  _InspectorRow(
    intentType: '_UndoIntent',
    actionType: '_UndoAction',
    enabledHint: 'enabled when history.canUndo',
  ),
  _InspectorRow(
    intentType: '_RedoIntent',
    actionType: '_RedoAction',
    enabledHint: 'enabled when history.canRedo',
  ),
  _InspectorRow(
    intentType: '_OpenPaletteIntent',
    actionType: 'CallbackAction',
    enabledHint: 'always enabled',
  ),
  _InspectorRow(
    intentType: '_NavigateNextIntent',
    actionType: 'CallbackAction',
    enabledHint: 'enabled when there is a next pane',
  ),
  _InspectorRow(
    intentType: '_NavigatePreviousIntent',
    actionType: 'CallbackAction',
    enabledHint: 'enabled when there is a previous pane',
  ),
  _InspectorRow(
    intentType: '_BoldIntent',
    actionType: 'CallbackAction',
    enabledHint: 'enabled while editing rich text',
  ),
  _InspectorRow(
    intentType: '_ItalicIntent',
    actionType: 'CallbackAction',
    enabledHint: 'enabled while editing rich text',
  ),
  _InspectorRow(
    intentType: '_ZoomInIntent',
    actionType: 'CallbackAction',
    enabledHint: 'enabled below max zoom',
  ),
  _InspectorRow(
    intentType: '_ZoomOutIntent',
    actionType: 'CallbackAction',
    enabledHint: 'enabled above min zoom',
  ),
];

Widget _buildInspectorRow(_InspectorRow r, int idx) {
  final Color stripe = idx.isEven ? Colors.white : const Color(0xFFFBFCFE);
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
    decoration: BoxDecoration(
      color: stripe,
      border: Border(bottom: BorderSide(color: _kOutlineSoft)),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Text(
            r.intentType,
            style: _monoStyle(color: const Color(0xFF1E40AF)).copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Row(
            children: <Widget>[
              _buildArrow(color: _kMuted),
              Flexible(
                child: Text(
                  r.actionType,
                  style: _monoStyle(color: const Color(0xFF0F766E)).copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(r.enabledHint, style: _smallStyle()),
        ),
      ],
    ),
  );
}

Widget _buildActionsMapInspector() {
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < _kInspector.length; i++) {
    rows.add(_buildInspectorRow(_kInspector[i], i));
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        children: <Widget>[
          Text('Actions map inspector', style: _cardTitleStyle()),
          const SizedBox(width: 10),
          _buildPill(text: 'RUNTIME', color: const Color(0xFF0D9488)),
        ],
      ),
      const SizedBox(height: 4),
      Text(
        'A snapshot of what the demo\'s Actions widget exposes to its '
        'subtree. Each row is a real entry in the actions map above.',
        style: _smallStyle(),
      ),
      const SizedBox(height: 10),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _kOutlineSoft),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(children: rows),
      ),
    ],
  );
}

// =============================================================================
// SECTION BUILDERS — RECAP
// =============================================================================

class _RecapPoint {
  final String title;
  final String body;
  final IconData icon;
  const _RecapPoint({
    required this.title,
    required this.body,
    required this.icon,
  });
}

const List<_RecapPoint> _kRecap = <_RecapPoint>[
  _RecapPoint(
    title: 'Intents describe; Actions do.',
    body:
        'Intents are immutable data; Actions are the only place that '
        'mutates state. Keep them separate and the rest of the framework '
        'becomes natural.',
    icon: Icons.south_east,
  ),
  _RecapPoint(
    title: 'Shortcuts is one source among many.',
    body:
        'Buttons, menus, gestures, and remote commands all invoke the same '
        'Intent. The Actions tree is the single point of truth.',
    icon: Icons.alt_route,
  ),
  _RecapPoint(
    title: 'Focus path = action lookup path.',
    body:
        'Dispatch follows focus, not parent-of-Shortcuts. If nothing is '
        'focused, no actions fire — wrap with Focus(autofocus: true) where '
        'appropriate.',
    icon: Icons.center_focus_strong_outlined,
  ),
  _RecapPoint(
    title: 'Subclass at the dispatcher.',
    body:
        'When you need cross-cutting logic (logging, analytics, '
        'permissions), subclass ActionDispatcher rather than each Action.',
    icon: Icons.dashboard_customize_outlined,
  ),
  _RecapPoint(
    title: 'Prefer SingleActivator in new code.',
    body:
        'It is more precise, supports platform-aware flags, and reads '
        'symbolically rather than as a key set.',
    icon: Icons.keyboard_command_key,
  ),
  _RecapPoint(
    title: 'Use CallbackAction for one-offs.',
    body:
        'Don\'t subclass Action just to run three lines of code; '
        'CallbackAction is the lambda equivalent.',
    icon: Icons.code,
  ),
  _RecapPoint(
    title: 'Make isEnabled meaningful.',
    body:
        'It surfaces command availability in menus, toolbars, and even '
        'screen readers. Call notifyActionListeners when state changes.',
    icon: Icons.check_circle_outline,
  ),
  _RecapPoint(
    title: 'Test by invoking, not by typing.',
    body:
        'Unit tests should call Action.invoke or Actions.invoke(context, '
        'intent). Skip the key-event simulation layer when possible.',
    icon: Icons.science_outlined,
  ),
];

Widget _buildRecapItem(_RecapPoint p, int index) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kOutlineSoft),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFFE0F2FE),
            borderRadius: BorderRadius.circular(9),
            border: Border.all(color: const Color(0xFFBAE6FD)),
          ),
          alignment: Alignment.center,
          child: Icon(p.icon, color: const Color(0xFF075985), size: 17),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                p.title,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                  color: _kInk,
                ),
              ),
              const SizedBox(height: 4),
              Text(p.body, style: _bodyStyle()),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildRecapSection() {
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < _kRecap.length; i += 2) {
    final _RecapPoint a = _kRecap[i];
    final _RecapPoint? b = i + 1 < _kRecap.length ? _kRecap[i + 1] : null;
    rows.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _buildRecapItem(a, i)),
            const SizedBox(width: 10),
            if (b != null)
              Expanded(child: _buildRecapItem(b, i + 1))
            else
              const Expanded(child: SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
  return _buildCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildPanelHeader(
          eyebrow: 'RECAP',
          title: 'Eight things to remember',
          lead:
              'Compressed take-aways from the whole demo — the things you '
              'should reach for on day-one of using Actions/Intents.',
          tint: const Color(0xFFD1FAE5),
          tintInk: const Color(0xFF065F46),
          icon: Icons.task_alt,
        ),
        const SizedBox(height: 14),
        ...rows,
      ],
    ),
  );
}

// =============================================================================
// HEADER — top-of-page hero
// =============================================================================

Widget _buildHero() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF0F172A),
          Color(0xFF1E40AF),
        ],
      ),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33000000),
          offset: Offset(0, 12),
          blurRadius: 22,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.14),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
              ),
              child: const Text(
                'FLUTTER FRAMEWORK',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.6,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFBBF24),
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text(
                'ACTIONS / INTENTS',
                style: TextStyle(
                  color: Color(0xFF78350F),
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.4,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Text(
          'Decoupling input from behavior',
          style: _displayStyle().copyWith(color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(
          'A visual deep dive on Flutter\'s Actions/Intents framework — '
          'Intent, Action<T>, Actions, Shortcuts, ShortcutActivator, '
          'LogicalKeySet, SingleActivator, CallbackAction, '
          'ActionDispatcher — and why they make commands composable.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.85),
            fontSize: 14.5,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: <Widget>[
            _buildHeroStat('Intents', '${_kShortcutRecords.length}'),
            const SizedBox(width: 18),
            _buildHeroStat('Recipes', '${_kRecipes.length}'),
            const SizedBox(width: 18),
            _buildHeroStat('Concepts', '${_kConcepts.length}'),
            const SizedBox(width: 18),
            _buildHeroStat('Pitfalls', '${_kPitfalls.length}'),
            const SizedBox(width: 18),
            _buildHeroStat('Glossary', '${_kGlossary.length}'),
          ],
        ),
      ],
    ),
  );
}

Widget _buildHeroStat(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w800,
          height: 1.0,
        ),
      ),
      const SizedBox(height: 2),
      Text(
        label,
        style: TextStyle(
          color: Colors.white.withOpacity(0.7),
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
    ],
  );
}

// =============================================================================
// FOOTER
// =============================================================================

Widget _buildFooter() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    decoration: BoxDecoration(
      color: const Color(0xFFEEF2F9),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kOutlineSoft),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Icon(Icons.info_outline, size: 16, color: _kMuted),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            'This demo file is hand-authored to be analyzer-clean and visually '
            'self-contained. The Shortcuts/Actions tree is real but no key '
            'simulation is performed — interact via Actions.invoke from a '
            'host app to fire the intents.',
            style: _smallStyle(),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// TOP-LEVEL BUILD FUNCTION
// =============================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Actions / Intents — Visual Deep Demo',
    theme: ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: _kPalette.background,
      visualDensity: VisualDensity.standard,
      fontFamily: 'Roboto',
      colorScheme: ColorScheme.light(
        primary: _kPalette.primary,
        onPrimary: _kPalette.primaryInk,
        secondary: _kPalette.secondary,
        onSecondary: _kPalette.secondaryInk,
        surface: _kPalette.surface,
        onSurface: _kPalette.ink,
      ),
    ),
    home: Scaffold(
      backgroundColor: _kPalette.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildHero(),
              const SizedBox(height: _kBetweenSections),
              _buildDossierSection(),
              const SizedBox(height: _kBetweenSections),
              _buildAnatomySection(),
              const SizedBox(height: _kBetweenSections),
              _buildKeyMapSection(),
              const SizedBox(height: _kBetweenSections),
              _buildRecipesSection(),
              const SizedBox(height: _kBetweenSections),
              _buildActivatorComparisonSection(),
              const SizedBox(height: _kBetweenSections),
              _buildConceptsSection(),
              const SizedBox(height: _kBetweenSections),
              _buildRawCompareSection(),
              const SizedBox(height: _kBetweenSections),
              _buildLiveDemoTree(),
              const SizedBox(height: _kBetweenSections),
              _buildPitfallsSection(),
              const SizedBox(height: _kBetweenSections),
              _buildGlossarySection(),
              const SizedBox(height: _kBetweenSections),
              _buildRecapSection(),
              const SizedBox(height: _kBetweenSections),
              _buildFooter(),
            ],
          ),
        ),
      ),
    ),
  );
}
