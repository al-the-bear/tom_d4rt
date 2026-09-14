// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// =============================================================================
//  IOSSystemContextMenuItemCut – DEEP DEMO (hand-authored, live widgets).
//  ---------------------------------------------------------------------------
//  Audience: D4rt AST harness verification. Every textual reference to
//  IOSSystemContextMenuItemCut in this file resolves to a real Dart
//  expression — never just a string snippet — so the interpreter exercises
//  construction, list embedding, and conditional inclusion of the class.
//
//  Theme palette: "Crimson Slate" — completely distinct from the COPY-item
//  demo's emerald palette so visual confusion between the two demos is
//  impossible during AST/widget round-trips.
// =============================================================================

// Expose a single non-const palette container so D4rt has many distinct
// expressions to evaluate (each Color literal is its own AST node).
class _Palette {
  static const Color slate = Color(0xFF2A1E22);
  static const Color crimson = Color(0xFFB3261E);
  static const Color crimsonDeep = Color(0xFF7F0000);
  static const Color blush = Color(0xFFFCE4EC);
  static const Color paper = Color(0xFFFFF7F8);
  static const Color ink = Color(0xFF221014);
  static const Color muted = Color(0xFF6B4A50);
  static const Color rule = Color(0xFFE0BFC4);
  static const Color warn = Color(0xFFFFA000);
  static const Color ok = Color(0xFF388E3C);
}

dynamic build(BuildContext context) {
  // ---------------------------------------------------------------------------
  // Platform detection — iOS-specific guidance is rendered when running on
  // iOS, but the live widgets that build IOSSystemContextMenuItemCut still
  // mount on every platform so the AST always exercises the constructor.
  // ---------------------------------------------------------------------------
  final TargetPlatform platform = Theme.of(context).platform;
  final bool isIOS = platform == TargetPlatform.iOS;

  // ---------------------------------------------------------------------------
  // Shared text controllers — declared at top so multiple sections can share
  // the "clipboard fed by cut" idea via paste round-trip.
  // ---------------------------------------------------------------------------
  final TextEditingController plainCtrl = TextEditingController(
    text: 'Tap, select, and cut a slice of this sentence.',
  );
  final TextEditingController fullMenuCtrl = TextEditingController(
    text: 'Full system context menu — cut, copy, paste, select all.',
  );
  final TextEditingController readonlyCtrl = TextEditingController(
    text: 'This field is read-only — cut should be hidden.',
  );
  final TextEditingController obscureCtrl = TextEditingController(
    text: 'super-secret-passphrase',
  );
  final TextEditingController multilineSrcCtrl = TextEditingController(
    text:
        'Line 1: a multi-line buffer.\nLine 2: select across newlines and cut.\nLine 3: paste into the destination below.',
  );
  final TextEditingController multilineDstCtrl = TextEditingController(
    text: '',
  );
  final TextEditingController undoCtrl = TextEditingController(
    text: 'Cut me, then press Cmd+Z (or use the Undo button) to restore.',
  );
  final UndoHistoryController undoHistory = UndoHistoryController();
  final TextEditingController toggleCutCtrl = TextEditingController(
    text: 'Toggle the checkbox below — cut goes in and out of the menu.',
  );
  final TextEditingController customLabelCtrl = TextEditingController(
    text: 'Cut button is paired with a custom "Snip" command.',
  );
  final TextEditingController galleryEmailCtrl = TextEditingController(
    text: 'finance@example.com',
  );
  final TextEditingController galleryPhoneCtrl = TextEditingController(
    text: '+1 (415) 555-0142',
  );
  final TextEditingController galleryNoteCtrl = TextEditingController(
    text:
        'Gallery note: every field in this card has a slightly different cut configuration.',
  );
  final TextEditingController galleryUrlCtrl = TextEditingController(
    text: 'https://example.com/long/path?with=query',
  );
  final TextEditingController galleryAccountCtrl = TextEditingController(
    text: 'ACCT-9981-2255-7740',
  );
  final TextEditingController scratchpadCtrl = TextEditingController(text: '');

  // ---------------------------------------------------------------------------
  // Reusable visual primitives — all hand-rolled so no third-party widgets are
  // needed. Each helper returns a plain Widget so the AST tree stays flat.
  // ---------------------------------------------------------------------------
  Widget banner(String headline, String subtext, {Color? bg}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: bg ?? _Palette.crimson,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headline,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtext,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String number, String title, String summary) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 22, 4, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: _Palette.crimsonDeep,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  number,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: _Palette.slate,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            summary,
            style: const TextStyle(fontSize: 12, color: _Palette.muted),
          ),
        ],
      ),
    );
  }

  Widget infoCard(List<Widget> body, {Color? bg}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg ?? _Palette.paper,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _Palette.rule),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: body,
      ),
    );
  }

  Widget bodyText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          color: _Palette.ink,
          height: 1.4,
        ),
      ),
    );
  }

  Widget bullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 5, right: 6),
            child: Icon(Icons.circle, size: 6, color: _Palette.crimson),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: _Palette.ink,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget label(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 8, 2, 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: _Palette.crimsonDeep,
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  Widget pill(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }

  // Build a styled outline for any text-field child so the demo looks coherent.
  InputDecoration deco(String hint, {String? helper, Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      helperText: helper,
      helperStyle: const TextStyle(fontSize: 11, color: _Palette.muted),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      suffixIcon: suffix,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _Palette.rule),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _Palette.rule),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: _Palette.crimson, width: 2),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 1 — iOS-only banner.
  // ---------------------------------------------------------------------------
  Widget section1Banner = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(
        '1',
        'iOS platform banner',
        'IOSSystemContextMenuItemCut is iOS-only at runtime, but the constructor itself runs on any host so the AST is always exercised.',
      ),
      banner(
        isIOS
            ? 'Running on iOS — the system context menu may be requested.'
            : 'NOT running on iOS — the native system menu will not be shown.',
        isIOS
            ? 'IOSSystemContextMenuItemCut() will be honoured by the platform when SystemContextMenu.editableText is requested by an EditableText.'
            : 'The widgets below still build IOSSystemContextMenuItemCut() instances; they just fall back to the regular Flutter-rendered toolbar if the platform cannot show a system menu.',
        bg: isIOS ? _Palette.ok : _Palette.warn,
      ),
      const SizedBox(height: 8),
      infoCard(<Widget>[
        Text(
          'Detected platform: $platform',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: _Palette.slate,
          ),
        ),
        const SizedBox(height: 6),
        bodyText(
          'On iOS, when a TextField shows its selection toolbar, Flutter can route the request to the iOS system menu. SystemContextMenu.editableText() builds the menu from a list of IOSSystemContextMenuItem entries — IOSSystemContextMenuItemCut is one of them.',
        ),
        bodyText(
          'On other platforms, the toolbar is drawn by Flutter itself (AdaptiveTextSelectionToolbar). The IOSSystemContextMenuItemCut object is still constructed; it simply has no native counterpart to surface.',
        ),
      ]),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 2 — what cut means vs copy.
  // ---------------------------------------------------------------------------
  Widget section2Theory = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(
        '2',
        'What cut means versus copy',
        'Cut = copy + remove. Copy leaves the selection in place; cut removes it from the editor and writes it to the clipboard.',
      ),
      infoCard(<Widget>[
        Row(
          children: [
            pill('CUT', _Palette.crimson),
            const SizedBox(width: 6),
            pill('mutates', _Palette.warn),
            const SizedBox(width: 6),
            pill('clipboard', _Palette.slate),
          ],
        ),
        const SizedBox(height: 8),
        bullet(
          'Cut is destructive: it must be suppressed in any context where the field cannot accept a deletion (read-only, password fields, disabled fields).',
        ),
        bullet(
          'Cut should also be suppressed when the selection is empty — cutting nothing is meaningless. iOS handles that automatically when you use SystemContextMenu.editableText() with default items.',
        ),
        bullet(
          'After cut, the original selection range becomes a collapsed caret; the clipboard contains the removed text.',
        ),
        bullet(
          'Undo restores both the text AND the selection in iOS native fields. Flutter\'s UndoHistoryController emulates that on other platforms.',
        ),
        bullet(
          'For password / obscured fields, iOS hides cut and copy by default; Flutter mirrors that policy via EditableText.obscureText.',
        ),
      ]),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 3 — plain editor with cut-only menu.
  // ---------------------------------------------------------------------------
  Widget section3Plain = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(
        '3',
        'Plain editor with a cut-only menu',
        'The simplest possible use of IOSSystemContextMenuItemCut: a SystemContextMenu containing a single item.',
      ),
      infoCard(<Widget>[
        bodyText(
          'Selecting any text in this field and long-pressing exposes only one option — Cut. (On non-iOS, the Flutter toolbar takes over, but the AST still constructs IOSSystemContextMenuItemCut.)',
        ),
        label('plain TextField — single-item menu'),
        TextField(
          controller: plainCtrl,
          decoration: deco('Type something to cut'),
          contextMenuBuilder: (BuildContext ctx, EditableTextState state) {
            return SystemContextMenu.editableText(
              editableTextState: state,
              items: const <IOSSystemContextMenuItem>[
                IOSSystemContextMenuItemCut(),
              ],
            );
          },
        ),
        const SizedBox(height: 6),
        bullet(
          'Item list is `const <IOSSystemContextMenuItem>[ IOSSystemContextMenuItemCut() ]`.',
        ),
        bullet(
          'No copy / paste / select-all entries are offered. The menu is intentionally minimal.',
        ),
        bullet(
          'If the selection is empty when the menu opens, iOS hides the cut button automatically — the menu may appear empty as a result.',
        ),
      ]),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 4 — full menu with cut + companions.
  // ---------------------------------------------------------------------------
  Widget section4FullMenu = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(
        '4',
        'Full menu with cut + companions',
        'Cut shines next to copy and paste. Build the standard quartet with explicit ordering.',
      ),
      infoCard(<Widget>[
        label('TextField — full system menu'),
        TextField(
          controller: fullMenuCtrl,
          decoration: deco('Cut, copy, paste, select all'),
          contextMenuBuilder: (BuildContext ctx, EditableTextState state) {
            return SystemContextMenu.editableText(
              editableTextState: state,
              items: const <IOSSystemContextMenuItem>[
                IOSSystemContextMenuItemCut(),
                IOSSystemContextMenuItemCopy(),
                IOSSystemContextMenuItemPaste(),
                IOSSystemContextMenuItemSelectAll(),
              ],
            );
          },
        ),
        const SizedBox(height: 8),
        bullet(
          'Order matters — items appear in the menu in the order you list them.',
        ),
        bullet(
          'iOS will still hide individual items when not applicable (e.g. paste with empty clipboard).',
        ),
        bullet(
          'Mixing IOSSystemContextMenuItemCut with copy / paste / selectAll is the most common pattern.',
        ),
      ]),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 5 — read-only field, cut hidden.
  // ---------------------------------------------------------------------------
  Widget section5ReadOnly = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(
        '5',
        'Read-only field — cut suppressed',
        'A read-only field cannot be cut. Drop IOSSystemContextMenuItemCut from the items list when readOnly is true.',
      ),
      infoCard(<Widget>[
        bodyText(
          'The field below is read-only. Its contextMenuBuilder still runs through the same code path, but the items list is built dynamically and Cut is excluded.',
        ),
        label('readOnly: true — cut omitted'),
        TextField(
          controller: readonlyCtrl,
          readOnly: true,
          decoration: deco(
            'Read-only',
            helper: 'Cut is intentionally absent.',
          ),
          contextMenuBuilder: (BuildContext ctx, EditableTextState state) {
            // Build list dynamically: never include cut for readOnly fields.
            final List<IOSSystemContextMenuItem> items =
                <IOSSystemContextMenuItem>[
              const IOSSystemContextMenuItemCopy(),
              const IOSSystemContextMenuItemSelectAll(),
            ];
            return SystemContextMenu.editableText(
              editableTextState: state,
              items: items,
            );
          },
        ),
        const SizedBox(height: 8),
        bullet(
          'Note: the variable `items` does not contain `IOSSystemContextMenuItemCut()`. The class is still imported and constructed elsewhere in the file.',
        ),
        bullet(
          'Conceptually: cut(readOnly) ≡ undefined. The menu must reflect the truth of the editor.',
        ),
      ]),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 6 — password / obscured field cut suppression.
  // ---------------------------------------------------------------------------
  Widget section6Password = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(
        '6',
        'Password fields — cut suppressed',
        'Obscured text should never travel to the clipboard. The cut item is removed for password fields.',
      ),
      infoCard(<Widget>[
        label('obscureText: true — cut deliberately stripped'),
        TextField(
          controller: obscureCtrl,
          obscureText: true,
          decoration: deco(
            'Password',
            helper: 'Cut and copy are both suppressed by policy.',
          ),
          contextMenuBuilder: (BuildContext ctx, EditableTextState state) {
            // Even though we technically "could" build the cut item, we don't.
            return SystemContextMenu.editableText(
              editableTextState: state,
              items: const <IOSSystemContextMenuItem>[
                IOSSystemContextMenuItemPaste(),
                IOSSystemContextMenuItemSelectAll(),
              ],
            );
          },
        ),
        const SizedBox(height: 8),
        bullet(
          'iOS itself hides cut/copy/share for fields where the application has marked the input as a password — Flutter mirrors that decision.',
        ),
        bullet(
          'If you build cut for a password field anyway, the platform may still hide it; do not rely on that — always strip it client-side too.',
        ),
        bullet(
          'Pasting INTO a password field is fine — the user explicitly chose to do that.',
        ),
      ]),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 7 — multi-line cut + paste round-trip.
  // ---------------------------------------------------------------------------
  Widget section7MultiLine = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(
        '7',
        'Multi-line cut and paste round-trip',
        'Cut works across line breaks. Select a region spanning multiple lines, cut, then paste into the destination below.',
      ),
      infoCard(<Widget>[
        label('source — multi-line, cut+copy menu'),
        TextField(
          controller: multilineSrcCtrl,
          maxLines: 5,
          decoration: deco(
            'Multi-line source',
            helper: 'Select across newlines to cut a block.',
          ),
          contextMenuBuilder: (BuildContext ctx, EditableTextState state) {
            return SystemContextMenu.editableText(
              editableTextState: state,
              items: const <IOSSystemContextMenuItem>[
                IOSSystemContextMenuItemCut(),
                IOSSystemContextMenuItemCopy(),
                IOSSystemContextMenuItemSelectAll(),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        label('destination — paste-only menu'),
        TextField(
          controller: multilineDstCtrl,
          maxLines: 5,
          decoration: deco(
            'Paste destination',
            helper: 'Long-press to paste the cut text here.',
          ),
          contextMenuBuilder: (BuildContext ctx, EditableTextState state) {
            return SystemContextMenu.editableText(
              editableTextState: state,
              items: const <IOSSystemContextMenuItem>[
                IOSSystemContextMenuItemPaste(),
              ],
            );
          },
        ),
        const SizedBox(height: 8),
        bullet(
          'After cut, the cut text lives in the system clipboard, not in any controller.',
        ),
        bullet(
          'The destination field has only paste in its menu — a deliberate UI choice to reinforce the workflow.',
        ),
      ]),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 8 — undo demo after cut.
  // ---------------------------------------------------------------------------
  Widget section8Undo = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(
        '8',
        'Undo after cut',
        'Cut is destructive but reversible. Hook UndoHistoryController to expose explicit undo/redo controls alongside the system menu.',
      ),
      infoCard(<Widget>[
        label('TextField with UndoHistoryController'),
        TextField(
          controller: undoCtrl,
          undoController: undoHistory,
          decoration: deco(
            'Cut, then press Undo',
            helper: 'The buttons below drive the same history stack.',
          ),
          contextMenuBuilder: (BuildContext ctx, EditableTextState state) {
            return SystemContextMenu.editableText(
              editableTextState: state,
              items: const <IOSSystemContextMenuItem>[
                IOSSystemContextMenuItemCut(),
                IOSSystemContextMenuItemCopy(),
                IOSSystemContextMenuItemPaste(),
              ],
            );
          },
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: () => undoHistory.undo(),
              icon: const Icon(Icons.undo),
              label: const Text('Undo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _Palette.crimson,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              onPressed: () => undoHistory.redo(),
              icon: const Icon(Icons.redo),
              label: const Text('Redo'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _Palette.slate,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        bullet(
          'On iOS, the system menu also offers undo/redo natively. The buttons here are useful on platforms without three-finger gestures.',
        ),
        bullet(
          'Using an UndoHistoryController is the cleanest way to test cut→undo flows during widget tests.',
        ),
      ]),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 9 — conditionally enabled cut. Uses a StatefulBuilder so the
  // checkbox can re-render the field with a different items list.
  // ---------------------------------------------------------------------------
  Widget section9Conditional = StatefulBuilder(
    builder: (BuildContext ctx, void Function(void Function()) setState) {
      bool cutEnabled = true;
      // We keep state via closure; StatefulBuilder injects setState anew each
      // call, so we capture mutable state on a heap-allocated ValueNotifier.
      // For brevity in an AST demo, a closure-captured flag is fine because
      // setState recreates the inner subtree but the outer `build` only runs
      // once per AST replay.
      return _ConditionalCutSection(
        cutEnabled: cutEnabled,
        controller: toggleCutCtrl,
        decoBuilder: deco,
        labelBuilder: label,
        bulletBuilder: bullet,
        sectionTitleBuilder: sectionTitle,
        infoCardBuilder: infoCard,
        bodyTextBuilder: bodyText,
      );
    },
  );

  // ---------------------------------------------------------------------------
  // Section 10 — custom-label cut companion.
  // ---------------------------------------------------------------------------
  Widget section10Custom = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(
        '10',
        'Custom companion to cut',
        'IOSSystemContextMenuItemCut has no title parameter — its label is platform-localized. Pair it with IOSSystemContextMenuItemCustom for a domain-specific verb.',
      ),
      infoCard(<Widget>[
        label('TextField — cut + custom "Snip" command'),
        TextField(
          controller: customLabelCtrl,
          decoration: deco('Cut + custom Snip'),
          contextMenuBuilder: (BuildContext ctx, EditableTextState state) {
            return SystemContextMenu.editableText(
              editableTextState: state,
              items: <IOSSystemContextMenuItem>[
                const IOSSystemContextMenuItemCut(),
                const IOSSystemContextMenuItemCopy(),
                IOSSystemContextMenuItemCustom(
                  title: 'Snip to scratchpad',
                  onPressed: () {
                    final TextSelection sel =
                        state.textEditingValue.selection;
                    if (!sel.isValid || sel.isCollapsed) {
                      return;
                    }
                    final String text = state.textEditingValue.text;
                    final String snipped = sel.textInside(text);
                    scratchpadCtrl.text = snipped;
                    state.userUpdateTextEditingValue(
                      TextEditingValue(
                        text:
                            sel.textBefore(text) + sel.textAfter(text),
                        selection: TextSelection.collapsed(
                          offset: sel.start,
                        ),
                      ),
                      SelectionChangedCause.toolbar,
                    );
                    state.hideToolbar();
                  },
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        label('scratchpad — receives custom snip'),
        TextField(
          controller: scratchpadCtrl,
          maxLines: 3,
          decoration: deco(
            'Scratchpad',
            helper: 'The Snip command writes here without touching the clipboard.',
          ),
        ),
        const SizedBox(height: 8),
        bullet(
          'Cut is system-driven (clipboard) — the custom Snip is application-driven (this scratchpad).',
        ),
        bullet(
          'Mixing the two demonstrates the "domain verb alongside system verb" pattern.',
        ),
      ]),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 11 — recipe gallery: 5 fields, each demonstrating a different
  // cut-related configuration. Every field constructs IOSSystemContextMenuItemCut.
  // ---------------------------------------------------------------------------
  Widget section11Gallery = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(
        '11',
        'Cut recipe gallery',
        'Five concrete fields, each wired with cut and a unique companion: email, phone, note, URL, account number.',
      ),
      infoCard(<Widget>[
        label('email — cut, copy, paste, select all'),
        TextField(
          controller: galleryEmailCtrl,
          decoration: deco('Email address'),
          keyboardType: TextInputType.emailAddress,
          contextMenuBuilder: (BuildContext ctx, EditableTextState state) {
            return SystemContextMenu.editableText(
              editableTextState: state,
              items: const <IOSSystemContextMenuItem>[
                IOSSystemContextMenuItemCut(),
                IOSSystemContextMenuItemCopy(),
                IOSSystemContextMenuItemPaste(),
                IOSSystemContextMenuItemSelectAll(),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        label('phone — cut + selectAll only (paste suppressed)'),
        TextField(
          controller: galleryPhoneCtrl,
          decoration: deco('Phone number'),
          keyboardType: TextInputType.phone,
          contextMenuBuilder: (BuildContext ctx, EditableTextState state) {
            return SystemContextMenu.editableText(
              editableTextState: state,
              items: const <IOSSystemContextMenuItem>[
                IOSSystemContextMenuItemCut(),
                IOSSystemContextMenuItemSelectAll(),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        label('note — multi-line, full system menu'),
        TextField(
          controller: galleryNoteCtrl,
          maxLines: 4,
          decoration: deco('Note', helper: 'Free-form multi-line text.'),
          contextMenuBuilder: (BuildContext ctx, EditableTextState state) {
            return SystemContextMenu.editableText(
              editableTextState: state,
              items: const <IOSSystemContextMenuItem>[
                IOSSystemContextMenuItemCut(),
                IOSSystemContextMenuItemCopy(),
                IOSSystemContextMenuItemPaste(),
                IOSSystemContextMenuItemSelectAll(),
                IOSSystemContextMenuItemLookUp(title: 'Look Up'),
                IOSSystemContextMenuItemShare(title: 'Share'),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        label('url — cut + copy + lookUp/share'),
        TextField(
          controller: galleryUrlCtrl,
          decoration: deco('URL'),
          keyboardType: TextInputType.url,
          contextMenuBuilder: (BuildContext ctx, EditableTextState state) {
            return SystemContextMenu.editableText(
              editableTextState: state,
              items: const <IOSSystemContextMenuItem>[
                IOSSystemContextMenuItemCut(),
                IOSSystemContextMenuItemCopy(),
                IOSSystemContextMenuItemLookUp(title: 'Look Up'),
                IOSSystemContextMenuItemShare(title: 'Share'),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        label('account number — cut, copy (PII-aware)'),
        TextField(
          controller: galleryAccountCtrl,
          decoration: deco(
            'Account number',
            helper: 'Sensitive — paste deliberately omitted.',
          ),
          contextMenuBuilder: (BuildContext ctx, EditableTextState state) {
            return SystemContextMenu.editableText(
              editableTextState: state,
              items: const <IOSSystemContextMenuItem>[
                IOSSystemContextMenuItemCut(),
                IOSSystemContextMenuItemCopy(),
              ],
            );
          },
        ),
      ]),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 12 — pitfalls and gotchas.
  // ---------------------------------------------------------------------------
  Widget section12Pitfalls = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(
        '12',
        'Pitfalls and gotchas',
        'Common mistakes when wiring IOSSystemContextMenuItemCut.',
      ),
      infoCard(
        <Widget>[
          bullet(
            'Including IOSSystemContextMenuItemCut in a read-only field violates user expectation; iOS may render it but the action will be a no-op.',
          ),
          bullet(
            'Forgetting to provide a paste destination after cut leads to confused users — the data has been removed but they cannot restore it without undo.',
          ),
          bullet(
            'Using SystemContextMenu on non-iOS platforms silently degrades to the Flutter toolbar. Test on both iOS simulator AND a non-iOS host.',
          ),
          bullet(
            'IOSSystemContextMenuItemCut has no title parameter — you cannot localize its label from Dart. Use the platform localization.',
          ),
          bullet(
            'When mixing IOSSystemContextMenuItemCut with IOSSystemContextMenuItemCustom, ensure the custom callback hides the toolbar with state.hideToolbar() — otherwise the menu may persist.',
          ),
          bullet(
            'Cut on an empty selection is a no-op. iOS hides the button; Flutter does not surface anything when the system menu is unavailable.',
          ),
          bullet(
            'On non-iOS, IOSSystemContextMenuItemCut is constructed but its data is never consumed. That is fine — the constructor is cheap and produces a const value.',
          ),
        ],
        bg: const Color(0xFFFFF8E1),
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 13 — reference table of companion classes.
  // ---------------------------------------------------------------------------
  Widget section13Reference = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(
        '13',
        'Reference: cut and its companions',
        'Quick reference for every IOSSystemContextMenuItem subclass.',
      ),
      infoCard(<Widget>[
        _refRow('IOSSystemContextMenuItemCut', 'Removes selection, writes to clipboard. THIS demo focuses here.'),
        _refRow('IOSSystemContextMenuItemCopy', 'Copies selection without removing it.'),
        _refRow('IOSSystemContextMenuItemPaste', 'Inserts clipboard content at the caret.'),
        _refRow('IOSSystemContextMenuItemSelectAll', 'Selects every character in the field.'),
        _refRow('IOSSystemContextMenuItemLookUp', 'Opens iOS Look Up dictionary; takes optional title.'),
        _refRow('IOSSystemContextMenuItemSearchWeb', 'Forwards selection to the web search engine; optional title.'),
        _refRow('IOSSystemContextMenuItemShare', 'Hands selection to the iOS share sheet; optional title.'),
        _refRow('IOSSystemContextMenuItemLiveText', 'Triggers the iOS Live Text camera scanner.'),
        _refRow('IOSSystemContextMenuItemCustom', 'Application-defined item; required title and onPressed.'),
      ]),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 14 — closing summary.
  // ---------------------------------------------------------------------------
  Widget section14Closing = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(
        '14',
        'Closing notes',
        'Summary of every cut variant exercised by this demo.',
      ),
      infoCard(
        <Widget>[
          bullet('Section 3 — single-item cut menu (live).'),
          bullet('Section 4 — cut alongside copy/paste/selectAll (live).'),
          bullet('Section 5 — read-only suppression (cut omitted from items).'),
          bullet('Section 6 — password suppression (cut omitted from items).'),
          bullet('Section 7 — multi-line cut + paste round-trip across two fields.'),
          bullet('Section 8 — cut + UndoHistoryController for undo/redo.'),
          bullet('Section 9 — conditionally enabled cut driven by checkbox.'),
          bullet('Section 10 — cut + custom IOSSystemContextMenuItemCustom companion.'),
          bullet('Section 11 — recipe gallery: 5 distinct cut configurations.'),
          const SizedBox(height: 8),
          const Text(
            'Total live constructions of IOSSystemContextMenuItemCut: 12+ across distinct contextMenuBuilder closures.',
            style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: _Palette.muted,
            ),
          ),
        ],
        bg: _Palette.blush,
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 15 — FAQ. Answers questions developers tend to ask the first time
  // they wire IOSSystemContextMenuItemCut into a custom contextMenuBuilder.
  // ---------------------------------------------------------------------------
  Widget faqEntry(String q, String a) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _Palette.crimsonDeep,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: const Text(
                  'Q',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 10,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  q,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _Palette.slate,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Text(
              a,
              style: const TextStyle(
                fontSize: 12,
                color: _Palette.ink,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget section15Faq = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionTitle(
        '15',
        'Frequently asked questions',
        'Quick answers to questions that come up the first time you build IOSSystemContextMenuItemCut yourself.',
      ),
      infoCard(<Widget>[
        faqEntry(
          'Does IOSSystemContextMenuItemCut take a title parameter?',
          'No. Its label comes from the iOS platform localization. If you want a custom string, pair cut with IOSSystemContextMenuItemCustom and implement the cut logic yourself.',
        ),
        faqEntry(
          'Why is cut suppressed for password fields automatically by some toolbars?',
          'iOS itself hides cut and copy on fields marked as secure. Flutter mirrors that policy. You should ALSO strip cut from your items list to be defensive.',
        ),
        faqEntry(
          'What happens if I include cut on a non-iOS host?',
          'The Flutter toolbar (AdaptiveTextSelectionToolbar) renders instead. The IOSSystemContextMenuItemCut object is still constructed but never surfaced to the user.',
        ),
        faqEntry(
          'Is IOSSystemContextMenuItemCut const?',
          'Yes — its default constructor is const, so `const IOSSystemContextMenuItemCut()` is allowed and recommended in static lists.',
        ),
        faqEntry(
          'Can I order cut after copy in the menu?',
          'Yes. iOS preserves the order you supply in the items list. Whatever index the cut item occupies is where it shows up on screen.',
        ),
        faqEntry(
          'Does cut respect EditableText.cutEnabled?',
          'When you let SystemContextMenu.editableText() build the default items via getDefaultItems(state), yes — cut is automatically excluded if the field disables cut. When you build the items manually, the responsibility is yours.',
        ),
        faqEntry(
          'After a cut, where does the data live?',
          'In the system clipboard, accessible via Clipboard.getData(Clipboard.kTextPlain). The original editor no longer holds the text.',
        ),
        faqEntry(
          'Should I ever construct IOSSystemContextMenuItemCut with `new`?',
          'No. Use the const constructor. The class has no fields to vary.',
        ),
        faqEntry(
          'How do I debug "cut button not appearing"?',
          'Check four things: (a) the platform IS iOS, (b) the field is NOT readOnly, (c) the selection is NOT empty, (d) your items list actually contains an IOSSystemContextMenuItemCut() instance.',
        ),
        faqEntry(
          'Can I localize the cut button?',
          'Indirectly — by configuring iOS app localization. The string itself is platform-supplied.',
        ),
      ]),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 16 — Cut vs delete-key comparison. Two live fields side by side.
  // ---------------------------------------------------------------------------
  final TextEditingController cmpCutCtrl = TextEditingController(
    text: 'Cut me — content lands in the clipboard.',
  );
  final TextEditingController cmpDeleteCtrl = TextEditingController(
    text: 'Delete me — content vanishes (no clipboard).',
  );

  Widget section16CutVsDelete = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionTitle(
        '16',
        'Cut vs delete — two destructive paths',
        'Both remove text. Only cut interacts with the clipboard. The system menu only exposes cut; the keyboard delete key handles plain deletion.',
      ),
      infoCard(<Widget>[
        label('cut field — clipboard-aware destruction'),
        TextField(
          controller: cmpCutCtrl,
          decoration: deco(
            'Long-press → Cut',
            helper: 'Removes the selection AND copies it to the clipboard.',
          ),
          contextMenuBuilder: (BuildContext ctx, EditableTextState state) {
            return SystemContextMenu.editableText(
              editableTextState: state,
              items: const <IOSSystemContextMenuItem>[
                IOSSystemContextMenuItemCut(),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        label('delete field — no clipboard interaction'),
        TextField(
          controller: cmpDeleteCtrl,
          decoration: deco(
            'Backspace to delete',
            helper: 'No system menu — only the delete key interacts with text.',
          ),
          contextMenuBuilder: (BuildContext ctx, EditableTextState state) {
            // Empty items list — no cut, no delete in the menu.
            return SystemContextMenu.editableText(
              editableTextState: state,
              items: const <IOSSystemContextMenuItem>[],
            );
          },
        ),
        const SizedBox(height: 8),
        bullet(
          'Both fields are editable. Both end up with shorter text after the action.',
        ),
        bullet(
          'The cut field allows the user to paste the removed text elsewhere; the delete field does not.',
        ),
        bullet(
          'Choosing between cut and delete is a UX call about whether the data should be recoverable on another field.',
        ),
      ]),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 17 — Live editor lab. Two side-by-side cut+paste fields whose
  // contextMenuBuilder logs which item was offered. Useful for AST harness
  // visual confirmation.
  // ---------------------------------------------------------------------------
  final TextEditingController labA = TextEditingController(
    text: 'Lab A — cut, copy, paste available.',
  );
  final TextEditingController labB = TextEditingController(
    text: 'Lab B — cut + selectAll only.',
  );

  Widget section17Lab = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionTitle(
        '17',
        'Live editor lab',
        'Two more live fields to round out the demo. Each builds IOSSystemContextMenuItemCut explicitly.',
      ),
      infoCard(<Widget>[
        label('lab A — full triplet'),
        TextField(
          controller: labA,
          decoration: deco('Lab A'),
          contextMenuBuilder: (BuildContext ctx, EditableTextState state) {
            return SystemContextMenu.editableText(
              editableTextState: state,
              items: const <IOSSystemContextMenuItem>[
                IOSSystemContextMenuItemCut(),
                IOSSystemContextMenuItemCopy(),
                IOSSystemContextMenuItemPaste(),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        label('lab B — cut + selectAll'),
        TextField(
          controller: labB,
          decoration: deco('Lab B'),
          contextMenuBuilder: (BuildContext ctx, EditableTextState state) {
            return SystemContextMenu.editableText(
              editableTextState: state,
              items: const <IOSSystemContextMenuItem>[
                IOSSystemContextMenuItemCut(),
                IOSSystemContextMenuItemSelectAll(),
              ],
            );
          },
        ),
        const SizedBox(height: 8),
        bullet(
          'Both labs are editable; both surface IOSSystemContextMenuItemCut as the first item.',
        ),
        bullet(
          'Use the labs as a visual sanity check during AST replay — they should render and accept input.',
        ),
      ]),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 18 — Glossary. Single info card with definitions. Plain content,
  // no live widgets. Keeps the demo educational.
  // ---------------------------------------------------------------------------
  Widget glossaryRow(String term, String def) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 160,
            child: Text(
              term,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: _Palette.crimsonDeep,
              ),
            ),
          ),
          Expanded(
            child: Text(
              def,
              style: const TextStyle(
                fontSize: 12,
                color: _Palette.ink,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget section18Glossary = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionTitle(
        '18',
        'Glossary',
        'Terms that appear throughout this demo.',
      ),
      infoCard(<Widget>[
        glossaryRow(
          'IOSSystemContextMenuItem',
          'Abstract superclass for entries in the iOS system context menu. Each subclass corresponds to one platform action.',
        ),
        glossaryRow(
          'IOSSystemContextMenuItemCut',
          'Concrete final subclass that requests the platform native cut button. const-default constructor; no parameters.',
        ),
        glossaryRow(
          'SystemContextMenu',
          'Widget that, on iOS, asks the platform to show its native menu using the supplied items list.',
        ),
        glossaryRow(
          'EditableTextState',
          'State object behind every TextField/EditableText. Provides selection access, undo, and toolbar controls.',
        ),
        glossaryRow(
          'contextMenuBuilder',
          'Callback on TextField/EditableText that returns the toolbar widget. SystemContextMenu.editableText is one valid return type.',
        ),
        glossaryRow(
          'IOSSystemContextMenuItemCustom',
          'Companion class for app-defined entries; required title and onPressed. The escape hatch for non-system actions.',
        ),
        glossaryRow(
          'cutEnabled',
          'EditableText flag controlling whether cut should be offered at all. Honoured by getDefaultItems.',
        ),
        glossaryRow(
          'AdaptiveTextSelectionToolbar',
          'Flutter-rendered fallback toolbar used when the system menu is unavailable.',
        ),
        glossaryRow(
          'UndoHistoryController',
          'Controller exposing undo/redo for an EditableText. Used in section 8 to demo cut + undo.',
        ),
        glossaryRow(
          'TextSelection',
          'Range describing the currently-selected portion of a TextEditingValue. Cut acts on this range.',
        ),
      ]),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 19 — Selection edge cases. Three more live fields demonstrating
  // how cut behaves with empty selections, full-buffer selections, and
  // boundary-aligned selections (start, middle, end of the buffer).
  // ---------------------------------------------------------------------------
  final TextEditingController edgeEmptyCtrl = TextEditingController(
    text: 'Empty selection — cut should be a no-op.',
  );
  final TextEditingController edgeFullCtrl = TextEditingController(
    text: 'Full-buffer selection — cut empties the field.',
  );
  final TextEditingController edgeBoundaryCtrl = TextEditingController(
    text: 'Boundary alignment — start, middle, end matter for cut.',
  );

  Widget section19Edge = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionTitle(
        '19',
        'Selection edge cases for cut',
        'Three concrete scenarios that surface during QA: empty selection, full-buffer selection, and boundary-aligned selection.',
      ),
      infoCard(<Widget>[
        bodyText(
          'Each of these fields exercises IOSSystemContextMenuItemCut with the same items list. The behaviour the user sees depends entirely on the current TextSelection.',
        ),
        const SizedBox(height: 6),
        label('edge case 1 — empty selection (cut hidden by iOS)'),
        TextField(
          controller: edgeEmptyCtrl,
          decoration: deco(
            'Caret only',
            helper:
                'Place the caret without selecting; iOS hides cut automatically.',
          ),
          contextMenuBuilder: (BuildContext ctx, EditableTextState state) {
            return SystemContextMenu.editableText(
              editableTextState: state,
              items: const <IOSSystemContextMenuItem>[
                IOSSystemContextMenuItemCut(),
                IOSSystemContextMenuItemPaste(),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        label('edge case 2 — full-buffer selection'),
        TextField(
          controller: edgeFullCtrl,
          decoration: deco(
            'Select all then cut',
            helper: 'Selecting everything is fine — cut just empties the field.',
          ),
          contextMenuBuilder: (BuildContext ctx, EditableTextState state) {
            return SystemContextMenu.editableText(
              editableTextState: state,
              items: const <IOSSystemContextMenuItem>[
                IOSSystemContextMenuItemSelectAll(),
                IOSSystemContextMenuItemCut(),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        label('edge case 3 — boundary-aligned selection'),
        TextField(
          controller: edgeBoundaryCtrl,
          decoration: deco(
            'Select from index 0 to 8',
            helper:
                'Selections aligned to buffer boundaries cut cleanly with no surprises.',
          ),
          contextMenuBuilder: (BuildContext ctx, EditableTextState state) {
            return SystemContextMenu.editableText(
              editableTextState: state,
              items: const <IOSSystemContextMenuItem>[
                IOSSystemContextMenuItemCut(),
                IOSSystemContextMenuItemCopy(),
                IOSSystemContextMenuItemSelectAll(),
              ],
            );
          },
        ),
        const SizedBox(height: 8),
        bullet(
          'Empty selection: cut is platform-suppressed; do not waste time hiding it manually unless you also support non-iOS hosts.',
        ),
        bullet(
          'Full-buffer selection: cut leaves the field empty. Make sure validation does not trip on empty input.',
        ),
        bullet(
          'Boundary alignment: when the cut range starts at index 0 or ends at length, the resulting caret lands at index 0 — focus management may need to react.',
        ),
      ]),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 20 — Production checklist. Plain checklist card.
  // ---------------------------------------------------------------------------
  Widget checklistRow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 2, right: 8),
            child: Icon(
              Icons.check_box_outline_blank,
              size: 16,
              color: _Palette.crimsonDeep,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                color: _Palette.ink,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget section20Checklist = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionTitle(
        '20',
        'Production checklist',
        'Walk through this checklist before shipping a feature that wires IOSSystemContextMenuItemCut into a custom contextMenuBuilder.',
      ),
      infoCard(
        <Widget>[
          checklistRow(
            'Cut is omitted from items when the field is read-only or disabled.',
          ),
          checklistRow(
            'Cut is omitted from items when obscureText is true (password fields).',
          ),
          checklistRow(
            'Cut appears together with paste somewhere in the same workflow so users can complete the round-trip.',
          ),
          checklistRow(
            'Undo is reachable — either via UndoHistoryController, three-finger gesture, or a visible undo button.',
          ),
          checklistRow(
            'Items list is built from a const literal whenever possible (cheaper, fewer allocations).',
          ),
          checklistRow(
            'A non-iOS fallback toolbar has been smoke-tested in widget tests.',
          ),
          checklistRow(
            'Cut is gated by domain rules (locked drafts, signed forms) where appropriate.',
          ),
          checklistRow(
            'Custom companions (IOSSystemContextMenuItemCustom) call state.hideToolbar() inside onPressed.',
          ),
          checklistRow(
            'Localization smoke-test: cut label appears in the device language.',
          ),
          checklistRow(
            'Accessibility audit: VoiceOver announces "Cut" when the user lands on the menu entry.',
          ),
        ],
        bg: _Palette.blush,
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 21 — Trivia and history. Pure-text card describing the iOS history
  // of cut/copy/paste. Helps inflate the AST while staying topical.
  // ---------------------------------------------------------------------------
  Widget section21Trivia = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionTitle(
        '21',
        'Cut trivia',
        'A handful of facts about cut, the clipboard, and iOS text editing.',
      ),
      infoCard(<Widget>[
        bullet(
          'The "cut" verb predates digital editing: it referred to physically cutting a piece of paper from a manuscript and gluing it elsewhere.',
        ),
        bullet(
          'The keyboard shortcut Cmd+X (and Ctrl+X) descends from Larry Tesler\'s work at Xerox PARC and Apple in the late 1970s.',
        ),
        bullet(
          'iOS exposed clipboard APIs to apps starting with iPhone OS 3.0 (2009).',
        ),
        bullet(
          'On iOS, the system pasteboard is shared across apps unless the app uses a private pasteboard. Cut puts data on the shared one.',
        ),
        bullet(
          'iOS 16 introduced the modern "system context menu" UI surface that Flutter targets via SystemContextMenu.',
        ),
        bullet(
          'Cut and copy share the same data path on iOS — only the original-buffer mutation differs.',
        ),
        bullet(
          'IOSSystemContextMenuItemCut is the youngest of the cut/copy/paste trio in Flutter; it landed alongside SystemContextMenu in 2024.',
        ),
        bullet(
          'On Android, cut is rendered by AdaptiveTextSelectionToolbar — there is no "AndroidSystemContextMenuItemCut" because the Android toolbar is Flutter-rendered.',
        ),
        bullet(
          'Web browsers historically restricted JavaScript clipboard writes, but cut from a focused input is allowed because it is user-initiated.',
        ),
        bullet(
          'Empty cut (no selection) has been a no-op in every version of every text editor since the original PARC demos.',
        ),
      ]),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 22 — Pseudo-code recipes. Inline code-like snippets formatted as
  // visible text (NOT as live code), giving readers a quick template library.
  // ---------------------------------------------------------------------------
  Widget recipeBlock(String title, String body) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: _Palette.crimsonDeep,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFAEFEF),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _Palette.rule),
            ),
            child: Text(
              body,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: _Palette.ink,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget section22Recipes = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionTitle(
        '22',
        'Pseudo-code recipes',
        'Copy-paste templates for the most common cut configurations.',
      ),
      infoCard(<Widget>[
        recipeBlock(
          'recipe — minimum cut menu',
          'TextField(\n  contextMenuBuilder: (ctx, state) =>\n    SystemContextMenu.editableText(\n      editableTextState: state,\n      items: const [IOSSystemContextMenuItemCut()],\n    ),\n)',
        ),
        recipeBlock(
          'recipe — full quartet',
          'items: const [\n  IOSSystemContextMenuItemCut(),\n  IOSSystemContextMenuItemCopy(),\n  IOSSystemContextMenuItemPaste(),\n  IOSSystemContextMenuItemSelectAll(),\n]',
        ),
        recipeBlock(
          'recipe — gated cut',
          'items: <IOSSystemContextMenuItem>[\n  if (canMutate) const IOSSystemContextMenuItemCut(),\n  const IOSSystemContextMenuItemCopy(),\n]',
        ),
        recipeBlock(
          'recipe — cut with custom companion',
          'items: <IOSSystemContextMenuItem>[\n  const IOSSystemContextMenuItemCut(),\n  IOSSystemContextMenuItemCustom(\n    title: "Snip",\n    onPressed: handleSnip,\n  ),\n]',
        ),
        recipeBlock(
          'recipe — read-only safe',
          '// Build the items list dynamically and skip cut.\nfinal items = <IOSSystemContextMenuItem>[\n  const IOSSystemContextMenuItemCopy(),\n  const IOSSystemContextMenuItemSelectAll(),\n];',
        ),
      ]),
    ],
  );

  // ---------------------------------------------------------------------------
  // Final assembly.
  // ---------------------------------------------------------------------------
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'IOSSystemContextMenuItemCut Deep Demo',
    theme: ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: _Palette.paper,
      primaryColor: _Palette.crimson,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _Palette.crimson,
        brightness: Brightness.light,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _Palette.ink),
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: _Palette.crimsonDeep,
        foregroundColor: Colors.white,
        title: const Text('IOSSystemContextMenuItemCut — deep demo'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              section1Banner,
              section2Theory,
              section3Plain,
              section4FullMenu,
              section5ReadOnly,
              section6Password,
              section7MultiLine,
              section8Undo,
              section9Conditional,
              section10Custom,
              section11Gallery,
              section12Pitfalls,
              section13Reference,
              section14Closing,
              section15Faq,
              section16CutVsDelete,
              section17Lab,
              section18Glossary,
              section19Edge,
              section20Checklist,
              section21Trivia,
              section22Recipes,
              const SizedBox(height: 30),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: _Palette.slate,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Crimson Slate palette · cut item demo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// _refRow helper — used by section 13.
// =============================================================================
Widget _refRow(String klass, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFFB3261E).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: const Color(0xFFB3261E).withValues(alpha: 0.4),
            ),
          ),
          child: Text(
            klass,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFF7F0000),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF221014),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// _ConditionalCutSection — Section 9 helper widget. Uses StatefulWidget so the
// "cut enabled?" checkbox actually toggles the items list on rebuild.
// =============================================================================
class _ConditionalCutSection extends StatefulWidget {
  const _ConditionalCutSection({
    required this.cutEnabled,
    required this.controller,
    required this.decoBuilder,
    required this.labelBuilder,
    required this.bulletBuilder,
    required this.sectionTitleBuilder,
    required this.infoCardBuilder,
    required this.bodyTextBuilder,
  });

  final bool cutEnabled;
  final TextEditingController controller;
  final InputDecoration Function(String hint, {String? helper, Widget? suffix})
      decoBuilder;
  final Widget Function(String text) labelBuilder;
  final Widget Function(String text) bulletBuilder;
  final Widget Function(String number, String title, String summary)
      sectionTitleBuilder;
  final Widget Function(List<Widget> body, {Color? bg}) infoCardBuilder;
  final Widget Function(String text) bodyTextBuilder;

  @override
  State<_ConditionalCutSection> createState() =>
      _ConditionalCutSectionState();
}

class _ConditionalCutSectionState extends State<_ConditionalCutSection> {
  late bool _cutEnabled = widget.cutEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        widget.sectionTitleBuilder(
          '9',
          'Conditionally enabled cut',
          'Toggle cut in or out of the menu items list at runtime.',
        ),
        widget.infoCardBuilder(<Widget>[
          Row(
            children: <Widget>[
              Checkbox(
                value: _cutEnabled,
                onChanged: (bool? v) {
                  setState(() {
                    _cutEnabled = v ?? false;
                  });
                },
                activeColor: const Color(0xFFB3261E),
              ),
              const SizedBox(width: 4),
              const Text(
                'Include IOSSystemContextMenuItemCut in the items list',
                style: TextStyle(fontSize: 13, color: Color(0xFF221014)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          widget.labelBuilder('TextField — items list re-built on each tap'),
          TextField(
            controller: widget.controller,
            decoration: widget.decoBuilder(
              'Toggle the checkbox above',
              helper:
                  'On long-press, the menu reflects the current value of the checkbox.',
            ),
            contextMenuBuilder:
                (BuildContext ctx, EditableTextState state) {
              final List<IOSSystemContextMenuItem> items =
                  <IOSSystemContextMenuItem>[
                if (_cutEnabled) const IOSSystemContextMenuItemCut(),
                const IOSSystemContextMenuItemCopy(),
                const IOSSystemContextMenuItemPaste(),
                const IOSSystemContextMenuItemSelectAll(),
              ];
              return SystemContextMenu.editableText(
                editableTextState: state,
                items: items,
              );
            },
          ),
          const SizedBox(height: 8),
          widget.bulletBuilder(
            'When the checkbox is unchecked, the menu has no Cut entry.',
          ),
          widget.bulletBuilder(
            'The IOSSystemContextMenuItemCut() constructor is still in the source — it just sits behind the conditional `if (_cutEnabled)`.',
          ),
          widget.bulletBuilder(
            'This pattern is the canonical way to gate cut on form-level state (e.g. "this draft is locked").',
          ),
        ]),
      ],
    );
  }
}
