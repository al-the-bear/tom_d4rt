// ignore_for_file: avoid_print
// IOSSystemContextMenuItem – comprehensive deep demo
// Ruby / Rose palette – sealed base class for all iOS system
// context menu items in the text selection toolbar.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── palette ───────────────────────────────────────────────────────────
  const Color cmRuby = Color(0xFFB71C1C);
  const Color cmRose = Color(0xFFFFEBEE);
  const Color cmOnRuby = Color(0xFFFFFFFF);
  const Color cmDark = Color(0xFF7F0000);
  const Color cmLightRose = Color(0xFFFFF5F5);
  const Color cmTextDark = Color(0xFF3B1010);
  const Color cmAccent = Color(0xFFE53935);
  const Color cmMuted = Color(0xFFEF9A9A);

  // ─── helpers ───────────────────────────────────────────────────────────
  Widget cmHeader(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [cmRuby, cmDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: cmOnRuby)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: cmOnRuby.withValues(alpha: 0.85))),
        ],
      ),
    );
  }

  Widget cmSection(String heading, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: cmLightRose,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cmRuby.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: cmRuby.withValues(alpha: 0.07),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Text(heading,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: cmRuby)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 12),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children),
          ),
        ],
      ),
    );
  }

  Widget cmBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('◆ ',
              style: TextStyle(color: cmAccent, fontSize: 11)),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 12, color: cmTextDark, height: 1.4)),
          ),
        ],
      ),
    );
  }

  Widget cmCodeBlock(String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF2A0808),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(code,
          style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: cmRose,
              height: 1.5)),
    );
  }

  Widget cmKeyValue(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(key,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: cmDark)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: cmTextDark)),
          ),
        ],
      ),
    );
  }

  Widget cmHighlight(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cmAccent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: cmAccent.withValues(alpha: 0.22)),
      ),
      child: Text(text,
          style: const TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: cmDark,
              height: 1.4)),
    );
  }

  Widget cmDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Divider(color: cmMuted.withValues(alpha: 0.4), height: 1),
    );
  }

  Widget cmInfoRow(String icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: cmRuby.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(icon,
                style: const TextStyle(fontSize: 12, color: cmRuby)),
          ),
          const SizedBox(width: 8),
          Text(label,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: cmDark)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: cmTextDark)),
          ),
        ],
      ),
    );
  }

  Widget cmCompare(String label, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 4, right: 8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: cmRuby,
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: '$label: ',
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: cmDark)),
                  TextSpan(
                      text: desc,
                      style: const TextStyle(
                          fontSize: 11, color: cmTextDark)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── main layout ───────────────────────────────────────────────────────
  return Container(
    color: cmRose,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── header ──
          cmHeader(
            'IOSSystemContextMenuItem',
            'Sealed base class for all iOS system context menu items – '
                'defines the contract that Cut, Copy, Paste, Select All, '
                'Look Up, Search Web, Share, and others must follow',
          ),

          // ── 1. sealed class identity ──
          cmSection('1 · Sealed Class Design', [
            cmKeyValue('Class', 'IOSSystemContextMenuItem'),
            cmKeyValue('Modifier', 'sealed (restricts subclassing)'),
            cmKeyValue('Platform', 'iOS / iPadOS'),
            cmKeyValue('Role', 'Base type for system menu items'),
            cmDivider(),
            cmBullet(
                'IOSSystemContextMenuItem is a SEALED class. Only classes '
                'defined in the same library can extend or implement it.'),
            cmBullet(
                'This means the set of possible subclasses is CLOSED and '
                'known at compile time, enabling exhaustive pattern matching.'),
            cmBullet(
                'External code cannot create custom IOSSystemContextMenuItem '
                'subclasses — it can only use the pre-defined ones.'),
          ]),

          // ── 2. sealed class hierarchy ──
          cmSection('2 · Complete Subclass Hierarchy', [
            cmCompare('IOSSystemContextMenuItemCopy',
                'Copies selected text to clipboard'),
            cmCompare('IOSSystemContextMenuItemCut',
                'Cuts selected text to clipboard'),
            cmCompare('IOSSystemContextMenuItemPaste',
                'Pastes clipboard content into field'),
            cmCompare('IOSSystemContextMenuItemSelectAll',
                'Selects all text in the field'),
            cmCompare('IOSSystemContextMenuItemLookUp',
                'Opens inline dictionary/Wikipedia'),
            cmCompare('IOSSystemContextMenuItemSearchWeb',
                'Opens Safari web search'),
            cmCompare('IOSSystemContextMenuItemShare',
                'Opens system share sheet'),
            cmCompare('IOSSystemContextMenuItemLiveText',
                'Camera OCR text insertion'),
            cmDivider(),
            cmBullet(
                'All subclasses are final (cannot be further subclassed).'),
            cmBullet(
                'Each subclass maps to exactly one iOS system context menu action.'),
          ]),

          // ── 3. the title property ──
          cmSection('3 · The title Property', [
            cmBullet(
                'The sole property defined on IOSSystemContextMenuItem is title.'),
            cmBullet(
                'title is an optional String? — when null, the system default '
                'label is used (e.g., "Copy", "Paste", localized).'),
            cmBullet(
                'When title is provided, it overrides the system default '
                'label in the callout bar.'),
            cmCodeBlock(
                '// Sealed class definition:\n'
                'sealed class IOSSystemContextMenuItem\n'
                '    with Diagnosticable {\n'
                '  const IOSSystemContextMenuItem({this.title});\n'
                '  final String? title;\n'
                '}\n'
                '\n'
                '// Usage:\n'
                'const item = IOSSystemContextMenuItemCopy();\n'
                'item.title; // null → system default "Copy"\n'
                '\n'
                'const custom = IOSSystemContextMenuItemCopy(\n'
                '  title: \'Duplicate\',\n'
                ');\n'
                'custom.title; // "Duplicate"'),
            cmDivider(),
            cmKeyValue('Property', 'title (String?)'),
            cmKeyValue('Default', 'null (platform-managed label)'),
            cmKeyValue('Setter', 'None (final, immutable)'),
          ]),

          // ── 4. sealed class benefits ──
          cmSection('4 · Why Sealed?', [
            cmBullet(
                'Exhaustive switch/case: Dart guarantees all subclasses are '
                'handled when switching over IOSSystemContextMenuItem.'),
            cmBullet(
                'Compile-time safety: adding a new subclass forces all switch '
                'statements to be updated, preventing runtime surprises.'),
            cmBullet(
                'Closed set: the framework knows exactly which menu items '
                'exist, preventing invalid or unsupported items.'),
            cmCodeBlock(
                '// Exhaustive pattern matching:\n'
                'String describe(IOSSystemContextMenuItem item) {\n'
                '  return switch (item) {\n'
                '    IOSSystemContextMenuItemCopy() => \'Copy\',\n'
                '    IOSSystemContextMenuItemCut() => \'Cut\',\n'
                '    IOSSystemContextMenuItemPaste() => \'Paste\',\n'
                '    IOSSystemContextMenuItemSelectAll() => \'Select All\',\n'
                '    IOSSystemContextMenuItemLookUp() => \'Look Up\',\n'
                '    IOSSystemContextMenuItemSearchWeb() => \'Search Web\',\n'
                '    IOSSystemContextMenuItemShare() => \'Share\',\n'
                '    IOSSystemContextMenuItemLiveText() => \'Live Text\',\n'
                '  }; // No default needed — exhaustive!\n'
                '}'),
            cmHighlight(
                'If Apple/Flutter adds a new menu item type and the framework '
                'adds a new subclass, every exhaustive switch will produce a '
                'compile error until updated — this is the key safety benefit.'),
          ]),

          // ── 5. Diagnosticable mixin ──
          cmSection('5 · Diagnosticable Mixin', [
            cmBullet(
                'IOSSystemContextMenuItem mixes in Diagnosticable, giving '
                'all subclasses debug inspection capabilities.'),
            cmBullet(
                'debugFillProperties() adds the title property to the '
                'diagnostics tree for devtools and toString() output.'),
            cmCodeBlock(
                '// Diagnosticable debug output:\n'
                'final item = IOSSystemContextMenuItemCopy(\n'
                '  title: \'Duplicate\',\n'
                ');\n'
                '\n'
                'final builder = DiagnosticPropertiesBuilder();\n'
                'item.debugFillProperties(builder);\n'
                '// builder.properties contains:\n'
                '//   StringProperty(\'title\', \'Duplicate\')\n'
                '\n'
                'print(item.toString());\n'
                '// IOSSystemContextMenuItemCopy(title: "Duplicate")'),
            cmDivider(),
            cmKeyValue('Mixin', 'Diagnosticable'),
            cmKeyValue('Method', 'debugFillProperties(builder)'),
            cmKeyValue('Properties', 'title (StringProperty)'),
          ]),

          // ── 6. const construction ──
          cmSection('6 · Const Construction', [
            cmBullet(
                'Both the base class and all subclasses support const constructors.'),
            cmBullet(
                'Const instances are canonicalized: identical arguments produce '
                'identical objects at compile time.'),
            cmCodeBlock(
                '// Const canonicalization:\n'
                'const a = IOSSystemContextMenuItemCopy();\n'
                'const b = IOSSystemContextMenuItemCopy();\n'
                'identical(a, b); // true\n'
                '\n'
                'const c = IOSSystemContextMenuItemCopy(title: \'X\');\n'
                'const d = IOSSystemContextMenuItemCopy(title: \'X\');\n'
                'identical(c, d); // true\n'
                '\n'
                '// Non-const:\n'
                'final e = IOSSystemContextMenuItemCopy();\n'
                'final f = IOSSystemContextMenuItemCopy();\n'
                'identical(e, f); // false (distinct instances)'),
            cmDivider(),
            cmBullet(
                'Always prefer const when declaring menu items that do not '
                'change — it reduces memory allocations.'),
          ]),

          // ── 7. equality semantics ──
          cmSection('7 · Equality & hashCode', [
            cmBullet(
                'IOSSystemContextMenuItemCut and IOSSystemContextMenuItemCopy '
                'are NEVER equal, even if both have null titles.'),
            cmBullet(
                'Equality is class identity + title value. Two instances of '
                'the same subclass with the same title are equal.'),
            cmCodeBlock(
                '// Equality:\n'
                'const copy1 = IOSSystemContextMenuItemCopy();\n'
                'const copy2 = IOSSystemContextMenuItemCopy();\n'
                'copy1 == copy2; // true (same type, same null title)\n'
                '\n'
                'const cut = IOSSystemContextMenuItemCut();\n'
                'copy1 == cut; // false (different types)\n'
                '\n'
                'const copy3 = IOSSystemContextMenuItemCopy(\n'
                '  title: \'Dup\',\n'
                ');\n'
                'copy1 == copy3; // false (different title values)'),
            cmDivider(),
            cmKeyValue('== operator', 'Type + title equality'),
            cmKeyValue('hashCode', 'Consistent with =='),
          ]),

          // ── 8. building menu item lists ──
          cmSection('8 · Building Menu Item Lists', [
            cmBullet(
                'Because IOSSystemContextMenuItem is the base type, you can '
                'create typed lists of mixed menu items.'),
            cmCodeBlock(
                '// Typed list of menu items:\n'
                'const items = <IOSSystemContextMenuItem>[\n'
                '  IOSSystemContextMenuItemCut(),\n'
                '  IOSSystemContextMenuItemCopy(),\n'
                '  IOSSystemContextMenuItemPaste(),\n'
                '  IOSSystemContextMenuItemSelectAll(),\n'
                '  IOSSystemContextMenuItemLookUp(),\n'
                '  IOSSystemContextMenuItemSearchWeb(),\n'
                '  IOSSystemContextMenuItemShare(),\n'
                '];\n'
                '\n'
                'for (final item in items) {\n'
                '  print(\'\${item.runtimeType}: \${item.title}\');\n'
                '}'),
            cmDivider(),
            cmBullet(
                'This pattern is useful for configuration, testing, or '
                'building custom toolbar layouts.'),
          ]),

          // ── 9. primary vs secondary items ──
          cmSection('9 · Primary vs Secondary Menu Items', [
            cmInfoRow('1', 'Cut:', 'Primary row (editable, selection)'),
            cmInfoRow('1', 'Copy:', 'Primary row (any selection)'),
            cmInfoRow('1', 'Paste:', 'Primary row (editable, clipboard)'),
            cmInfoRow('1', 'Select All:', 'Primary row (non-empty field)'),
            cmInfoRow('2', 'Look Up:', 'Secondary row (any selection)'),
            cmInfoRow('2', 'Translate:', 'Secondary row (any selection)'),
            cmInfoRow('2', 'Search Web:', 'Secondary row (any selection)'),
            cmInfoRow('2', 'Share:', 'Secondary row (any selection)'),
            cmDivider(),
            cmBullet(
                'Primary items appear on the first page of the callout bar. '
                'Secondary items require tapping the chevron arrow.'),
            cmBullet(
                'The IOSSystemContextMenuItem class itself does not encode '
                'primary vs secondary — that is decided by the platform.'),
          ]),

          // ── 10. runtime type checking ──
          cmSection('10 · Runtime Type Checking', [
            cmBullet(
                'Because the class is sealed, you can use is-checks to '
                'identify the specific subclass.'),
            cmCodeBlock(
                '// Type checking:\n'
                'void handleItem(IOSSystemContextMenuItem item) {\n'
                '  if (item is IOSSystemContextMenuItemCopy) {\n'
                '    // handle copy\n'
                '  } else if (item is IOSSystemContextMenuItemCut) {\n'
                '    // handle cut\n'
                '  }\n'
                '  // ... or use switch for exhaustive matching\n'
                '}\n'
                '\n'
                '// runtimeType:\n'
                'const item = IOSSystemContextMenuItemCopy();\n'
                'item.runtimeType; // IOSSystemContextMenuItemCopy'),
            cmDivider(),
            cmBullet(
                'Prefer switch over if-else chains — the compiler enforces '
                'exhaustiveness for sealed types.'),
          ]),

          // ── 11. where it fits in Flutter ──
          cmSection('11 · Flutter Architecture Context', [
            cmBullet(
                'IOSSystemContextMenuItem lives in the widgets library, '
                'not in cupertino or material.'),
            cmBullet(
                'The CupertinoAdaptiveTextSelectionToolbar uses these items '
                'to build the iOS-native callout bar.'),
            cmBullet(
                'EditableText generates the list of IOSSystemContextMenuItems '
                'based on the current state (selection, clipboard, editability).'),
            cmCodeBlock(
                '// Architecture stack:\n'
                '// EditableText (framework)\n'
                '//   → generates List<ContextMenuButtonItem>\n'
                '//   → CupertinoAdaptiveTextSelectionToolbar\n'
                '//     → maps to IOSSystemContextMenuItem instances\n'
                '//     → renders iOS-native callout bar\n'
                '//       → each button triggers a system action'),
            cmDivider(),
            cmKeyValue('Library', 'package:flutter/widgets.dart'),
            cmKeyValue('Consumer', 'CupertinoAdaptiveTextSelectionToolbar'),
            cmKeyValue('Producer', 'EditableText (via contextMenuBuilder)'),
          ]),

          // ── 12. immutability ──
          cmSection('12 · Immutability Guarantees', [
            cmBullet(
                'IOSSystemContextMenuItem has only one field (title) and it is final.'),
            cmBullet(
                'All subclasses are final — they cannot add mutable fields.'),
            cmBullet(
                'This makes the class safe for use in const lists, '
                'compile-time constants, and concurrent code.'),
            cmHighlight(
                'The immutable design means menu items can be freely shared, '
                'cached, and compared without defensive copying. A menu item '
                'list is a snapshot — it never changes after creation.'),
          ]),

          // ── 13. Diagnosticable details ──
          cmSection('13 · DiagnosticPropertiesBuilder Details', [
            cmBullet(
                'Each subclass inherits debugFillProperties from the base '
                'class, which adds the title as a StringProperty.'),
            cmCodeBlock(
                '// DiagnosticsProperty output for each subclass:\n'
                'final copy = IOSSystemContextMenuItemCopy();\n'
                'final cut = IOSSystemContextMenuItemCut(\n'
                '  title: \'Remove\',\n'
                ');\n'
                '\n'
                'final b1 = DiagnosticPropertiesBuilder();\n'
                'copy.debugFillProperties(b1);\n'
                '// → StringProperty(\'title\', null)\n'
                '\n'
                'final b2 = DiagnosticPropertiesBuilder();\n'
                'cut.debugFillProperties(b2);\n'
                '// → StringProperty(\'title\', \'Remove\')'),
            cmDivider(),
            cmBullet(
                'This is useful in Flutter DevTools where you can inspect '
                'the entire widget tree and see each menu item title.'),
          ]),

          // ── 14. pattern matching styles ──
          cmSection('14 · Pattern Matching Styles', [
            cmCodeBlock(
                '// Dart 3 pattern matching with sealed class:\n'
                '\n'
                '// Style 1: switch expression\n'
                'final label = switch (item) {\n'
                '  IOSSystemContextMenuItemCopy(title: final t) =>\n'
                '    t ?? \'Copy\',\n'
                '  IOSSystemContextMenuItemCut(title: final t) =>\n'
                '    t ?? \'Cut\',\n'
                '  _ => \'Other\',\n'
                '};\n'
                '\n'
                '// Style 2: if-case\n'
                'if (item case IOSSystemContextMenuItemPaste(\n'
                '  title: final pasteTitle,\n'
                ')) {\n'
                '  print(\'Paste: \$pasteTitle\');\n'
                '}'),
            cmDivider(),
            cmBullet(
                'Dart 3 patterns destructure the title field directly, '
                'avoiding explicit type casts.'),
          ]),

          // ── 15. comparison with Android ──
          cmSection('15 · iOS vs Android Menu Systems', [
            cmKeyValue('iOS', 'Sealed IOSSystemContextMenuItem class'),
            cmKeyValue('Android', 'No equivalent sealed class in Flutter'),
            cmKeyValue('iOS rendering', 'Native callout bar (UIMenuController)'),
            cmKeyValue('Android rendering', 'ActionMode toolbar or popup'),
            cmDivider(),
            cmBullet(
                'On Android, Flutter uses ContextMenuButtonItem with '
                'ContextMenuButtonType enum instead of sealed classes.'),
            cmBullet(
                'The iOS approach is more type-safe: a sealed class prevents '
                'invalid menu item types at compile time.'),
            cmBullet(
                'Android has different system actions: PROCESS_TEXT intents '
                'allow third-party apps to add custom menu items.'),
          ]),

          // ── 16. quick API reference ──
          cmSection('16 · Quick API Reference', [
            cmKeyValue('Class', 'IOSSystemContextMenuItem (sealed)'),
            cmKeyValue('Property', 'title (String?)'),
            cmKeyValue('Mixin', 'Diagnosticable'),
            cmKeyValue('Constructor', 'const IOSSystemContextMenuItem({title})'),
            cmKeyValue('Subclasses', '8 final subclasses'),
            cmDivider(),
            cmCodeBlock(
                '// All known subclasses:\n'
                'const items = <IOSSystemContextMenuItem>[\n'
                '  IOSSystemContextMenuItemCopy(),\n'
                '  IOSSystemContextMenuItemCut(),\n'
                '  IOSSystemContextMenuItemPaste(),\n'
                '  IOSSystemContextMenuItemSelectAll(),\n'
                '  IOSSystemContextMenuItemLookUp(),\n'
                '  IOSSystemContextMenuItemSearchWeb(),\n'
                '  IOSSystemContextMenuItemShare(),\n'
                '  IOSSystemContextMenuItemLiveText(),\n'
                '];'),
          ]),

          // ── footer ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            color: cmRuby.withValues(alpha: 0.06),
            child: const Text(
              'IOSSystemContextMenuItem · Ruby Deep Demo',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: cmMuted,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    ),
  );
}
