// ignore_for_file: avoid_print
// IOSSystemContextMenuItemCustom – comprehensive deep demo
// Sunset Orange / Peach palette – creating custom items in the iOS system
// context menu alongside the standard Cut/Copy/Paste entries.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── palette ───────────────────────────────────────────────────────────
  const Color cxSunset = Color(0xFFFF6D00);
  const Color cxPeach = Color(0xFFFFF3E0);
  const Color cxOnSunset = Color(0xFFFFFFFF);
  const Color cxDeepOrange = Color(0xFFBF360C);
  const Color cxLightPeach = Color(0xFFFFF9F2);
  const Color cxTextDark = Color(0xFF3E2723);
  const Color cxAccent = Color(0xFFFF9100);
  const Color cxMuted = Color(0xFFBCAAA4);

  // ─── helpers ───────────────────────────────────────────────────────────
  Widget cxHeader(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [cxSunset, cxDeepOrange],
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
                  color: cxOnSunset)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: cxOnSunset.withValues(alpha: 0.85))),
        ],
      ),
    );
  }

  Widget cxSection(String heading, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: cxLightPeach,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cxSunset.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: cxSunset.withValues(alpha: 0.08),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Text(heading,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: cxDeepOrange)),
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

  Widget cxBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('● ',
              style: TextStyle(color: cxAccent, fontSize: 11)),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 12, color: cxTextDark, height: 1.4)),
          ),
        ],
      ),
    );
  }

  Widget cxCodeBlock(String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF3E1508),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(code,
          style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: cxPeach,
              height: 1.5)),
    );
  }

  Widget cxKeyValue(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(key,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: cxDeepOrange)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: cxTextDark)),
          ),
        ],
      ),
    );
  }

  Widget cxHighlight(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cxAccent.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: cxAccent.withValues(alpha: 0.25)),
      ),
      child: Text(text,
          style: const TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: cxDeepOrange,
              height: 1.4)),
    );
  }

  Widget cxDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Divider(color: cxMuted.withValues(alpha: 0.4), height: 1),
    );
  }

  Widget cxCompare(String label, String desc) {
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
              color: cxSunset,
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
                          color: cxDeepOrange)),
                  TextSpan(
                      text: desc,
                      style:
                          const TextStyle(fontSize: 11, color: cxTextDark)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget cxNumberedStep(int step, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: cxSunset,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Text('$step',
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: cxOnSunset)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(text,
                  style: const TextStyle(
                      fontSize: 12, color: cxTextDark, height: 1.4)),
            ),
          ),
        ],
      ),
    );
  }

  // ─── main layout ───────────────────────────────────────────────────────
  return Container(
    color: cxPeach,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── header ──
          cxHeader(
            'IOSSystemContextMenuItemCustom',
            'Custom context menu items for iOS – extending the system '
                'toolbar with app-specific actions beyond Cut, Copy, Paste',
          ),

          // ── 1. class overview ──
          cxSection('1 · Class Identity & Purpose', [
            cxKeyValue('Class', 'IOSSystemContextMenuItemCustom'),
            cxKeyValue('Platform', 'iOS (Cupertino)'),
            cxKeyValue('Purpose',
                'Create app-specific context menu items alongside '
                'system-defined actions'),
            cxKeyValue('Toolbar',
                'CupertinoAdaptiveTextSelectionToolbar'),
            cxDivider(),
            cxBullet(
                'IOSSystemContextMenuItemCustom represents a developer-defined '
                'action in the iOS context menu. Unlike the built-in Copy, Cut, '
                'or Paste items, custom items carry arbitrary labels and '
                'callbacks.'),
            cxBullet(
                'This class enables rich text-editing experiences where '
                'domain-specific actions (Define, Translate, Share link) '
                'appear naturally in the context menu.'),
            cxCodeBlock(
                '// A custom context menu item on iOS\n'
                '// Defined via ContextMenuButtonItem with a custom label\n'
                'ContextMenuButtonItem(\n'
                '  label: \'Translate\',\n'
                '  onPressed: () {\n'
                '    // Handle translation logic\n'
                '  },\n'
                ')'),
          ]),

          // ── 2. custom item anatomy ──
          cxSection('2 · Custom Item Anatomy', [
            cxHighlight(
                'A custom context menu item has three components: a label '
                '(displayed text), an optional icon or type identifier, and '
                'an onPressed callback. The item renders in the same visual '
                'style as system items to maintain iOS consistency.'),
            cxBullet(
                'Label: the text shown in the context menu button (e.g., '
                '"Translate", "Define", "Share Link").'),
            cxBullet(
                'Type: ContextMenuButtonType.custom (distinguishes it from '
                'system-defined types like .copy, .cut, .paste).'),
            cxBullet(
                'onPressed: a VoidCallback invoked when the user taps '
                'the item. The menu auto-dismisses after the tap.'),
            cxDivider(),
            cxKeyValue('Label', 'Required: the display text'),
            cxKeyValue('Type', 'ContextMenuButtonType.custom'),
            cxKeyValue('onPressed', 'Required: action callback'),
            cxKeyValue('Enabled', 'Controlled by onPressed being null or not'),
          ]),

          // ── 3. ContextMenuButtonItem ──
          cxSection('3 · ContextMenuButtonItem Builder Pattern', [
            cxBullet(
                'Custom items are created using ContextMenuButtonItem, the '
                'same class used for system items but with the type set '
                'to ContextMenuButtonType.custom.'),
            cxBullet(
                'The contextMenuBuilder callback on TextField receives the '
                'EditableTextState, from which you can read the selection '
                'and text value.'),
            cxCodeBlock(
                '// Creating a custom context menu item\n'
                'final customItem = ContextMenuButtonItem(\n'
                '  label: \'Define Word\',\n'
                '  type: ContextMenuButtonType.custom,\n'
                '  onPressed: () {\n'
                '    final selection = editableState\n'
                '        .textEditingValue.selection;\n'
                '    final word = selection.textInside(\n'
                '        editableState.textEditingValue.text);\n'
                '    print(\'Define: \$word\');\n'
                '    editableState.hideToolbar();\n'
                '  },\n'
                ');'),
            cxDivider(),
            cxBullet(
                'Call editableState.hideToolbar() in the callback to dismiss '
                'the menu programmatically if it does not auto-dismiss.'),
          ]),

          // ── 4. adding custom items step by step ──
          cxSection('4 · Adding Custom Items Step-by-Step', [
            cxNumberedStep(1,
                'Define your TextField or CupertinoTextField with a '
                'contextMenuBuilder parameter.'),
            cxNumberedStep(2,
                'In the builder, access editableTextState for selection data.'),
            cxNumberedStep(3,
                'Create ContextMenuButtonItem instances for each custom action.'),
            cxNumberedStep(4,
                'Build the toolbar using AdaptiveTextSelectionToolbar.buttonItems '
                'with both system and custom items.'),
            cxNumberedStep(5,
                'Return the toolbar widget from the builder.'),
            cxDivider(),
            cxCodeBlock(
                'TextField(\n'
                '  contextMenuBuilder: (context, editableTextState) {\n'
                '    // Step 2: access selection\n'
                '    final sel = editableTextState.textEditingValue.selection;\n'
                '    // Step 3: create items\n'
                '    final items = <ContextMenuButtonItem>[\n'
                '      ...editableTextState.contextMenuButtonItems,\n'
                '      ContextMenuButtonItem(\n'
                '        label: \'Highlight\',\n'
                '        type: ContextMenuButtonType.custom,\n'
                '        onPressed: () {\n'
                '          final text = sel.textInside(\n'
                '              editableTextState.textEditingValue.text);\n'
                '          print(\'Highlight: \$text\');\n'
                '        },\n'
                '      ),\n'
                '    ];\n'
                '    // Step 4-5: build and return toolbar\n'
                '    return AdaptiveTextSelectionToolbar.buttonItems(\n'
                '      anchors: editableTextState.contextMenuAnchors,\n'
                '      buttonItems: items,\n'
                '    );\n'
                '  },\n'
                ')'),
          ]),

          // ── 5. mixing system and custom items ──
          cxSection('5 · Mixing System & Custom Items', [
            cxBullet(
                'editableTextState.contextMenuButtonItems returns the default '
                'system items (Copy, Cut, Paste, Select All) based on the '
                'current selection state.'),
            cxBullet(
                'You can prepend, append, or interleave custom items with '
                'the system items for a seamless experience.'),
            cxBullet(
                'Items with null onPressed are automatically hidden from '
                'the toolbar.'),
            cxDivider(),
            cxCodeBlock(
                '// Append a "Share" item after system items\n'
                'final items = [\n'
                '  ...editableTextState.contextMenuButtonItems,\n'
                '  ContextMenuButtonItem(\n'
                '    label: \'Share\',\n'
                '    type: ContextMenuButtonType.custom,\n'
                '    onPressed: () => shareText(selectedText),\n'
                '  ),\n'
                '];\n'
                '\n'
                '// Or insert before system items\n'
                'final items2 = [\n'
                '  ContextMenuButtonItem(\n'
                '    label: \'AI Rewrite\',\n'
                '    type: ContextMenuButtonType.custom,\n'
                '    onPressed: () => aiRewrite(selectedText),\n'
                '  ),\n'
                '  ...editableTextState.contextMenuButtonItems,\n'
                '];'),
          ]),

          // ── 6. positioning and overflow ──
          cxSection('6 · Positioning & Overflow Handling', [
            cxBullet(
                'The iOS context menu toolbar has limited horizontal space. '
                'When items overflow, a chevron arrow appears to reveal '
                'additional pages of items.'),
            cxBullet(
                'Custom items increase the total item count and may cause '
                'the toolbar to paginate. The system handles pagination '
                'automatically.'),
            cxBullet(
                'Item order determines which items appear on the first page '
                'vs hidden behind the pagination chevron.'),
            cxDivider(),
            cxKeyValue('Default capacity', '~5-6 items per page on iPhone'),
            cxKeyValue('Overflow', 'Chevron arrow for next page'),
            cxKeyValue('Item order', 'List order = left-to-right display'),
          ]),

          // ── 7. comparison with built-in items ──
          cxSection('7 · Custom vs Built-in Item Comparison', [
            cxCompare('Built-in (Copy/Cut/Paste)',
                'System-defined type, auto-visible based on selection state'),
            cxCompare('Custom item',
                'Developer-defined label and callback, manually controlled'),
            cxCompare('Built-in visibility',
                'Handled by framework (e.g., Copy hidden when no selection)'),
            cxCompare('Custom visibility',
                'Developer must set onPressed to null to hide'),
            cxDivider(),
            cxBullet(
                'Custom items render identically to built-in items in the '
                'Cupertino toolbar, maintaining the native look and feel.'),
            cxBullet(
                'The only visual difference is the label text you provide; '
                'the button style, font, and press animation are identical.'),
          ]),

          // ── 8. conditional custom items ──
          cxSection('8 · Conditional Custom Items', [
            cxBullet(
                'Custom items can be conditionally shown based on the '
                'selection content, field state, or app-level logic.'),
            cxBullet(
                'Check the selected text in the builder to decide whether '
                'to include context-sensitive actions (e.g., "Open URL" only '
                'when a URL is selected).'),
            cxCodeBlock(
                '// Conditional: show "Open Link" only for URL selections\n'
                'final sel = editableTextState.textEditingValue.selection;\n'
                'final text = sel.textInside(\n'
                '    editableTextState.textEditingValue.text);\n'
                'final isUrl = Uri.tryParse(text)?.hasScheme ?? false;\n'
                '\n'
                'final items = [\n'
                '  ...editableTextState.contextMenuButtonItems,\n'
                '  if (isUrl)\n'
                '    ContextMenuButtonItem(\n'
                '      label: \'Open Link\',\n'
                '      type: ContextMenuButtonType.custom,\n'
                '      onPressed: () => launchUrl(Uri.parse(text)),\n'
                '    ),\n'
                '];'),
            cxDivider(),
            cxBullet(
                'Conditional items make the context menu intelligent and '
                'context-aware, providing relevant actions based on what '
                'the user has selected.'),
          ]),

          // ── 9. SelectableText custom menus ──
          cxSection('9 · Custom Items in SelectableText', [
            cxBullet(
                'SelectableText also supports contextMenuBuilder, allowing '
                'custom items even in read-only text displays.'),
            cxBullet(
                'In SelectableText, Cut and Paste are already hidden; '
                'only Copy and Select All appear by default. Custom items '
                'supplement these.'),
            cxCodeBlock(
                'SelectableText(\n'
                '  \'Long-press to see custom menu\',\n'
                '  contextMenuBuilder: (context, editableTextState) {\n'
                '    return AdaptiveTextSelectionToolbar.buttonItems(\n'
                '      anchors: editableTextState.contextMenuAnchors,\n'
                '      buttonItems: [\n'
                '        ...editableTextState.contextMenuButtonItems,\n'
                '        ContextMenuButtonItem(\n'
                '          label: \'Bookmark\',\n'
                '          type: ContextMenuButtonType.custom,\n'
                '          onPressed: () {\n'
                '            print(\'Bookmarked selection\');\n'
                '          },\n'
                '        ),\n'
                '      ],\n'
                '    );\n'
                '  },\n'
                ')'),
          ]),

          // ── 10. platform adaptivity ──
          cxSection('10 · Platform-Adaptive Custom Items', [
            cxBullet(
                'AdaptiveTextSelectionToolbar.buttonItems automatically '
                'renders items in the platform-appropriate style: Cupertino '
                'on iOS, Material on Android, desktop menus on desktop.'),
            cxBullet(
                'A single contextMenuBuilder implementation works across '
                'all platforms; the visual rendering adapts automatically.'),
            cxBullet(
                'Custom items use the same adaptive rendering, so "Translate" '
                'looks Cupertino on iOS and Material on Android.'),
            cxDivider(),
            cxKeyValue('iOS', 'Cupertino callout bar style'),
            cxKeyValue('Android', 'Material floating toolbar style'),
            cxKeyValue('Desktop', 'Standard dropdown context menu style'),
            cxKeyValue('Web', 'Overlay menu matching target platform'),
          ]),

          // ── 11. multiple custom items ──
          cxSection('11 · Multiple Custom Items Pattern', [
            cxBullet(
                'You can add as many custom items as needed. The toolbar '
                'paginates automatically when space runs out.'),
            cxCodeBlock(
                '// Multiple custom items for a note-taking app\n'
                'final customItems = [\n'
                '  ContextMenuButtonItem(\n'
                '    label: \'Highlight\',\n'
                '    type: ContextMenuButtonType.custom,\n'
                '    onPressed: () => highlightSelection(),\n'
                '  ),\n'
                '  ContextMenuButtonItem(\n'
                '    label: \'Add Note\',\n'
                '    type: ContextMenuButtonType.custom,\n'
                '    onPressed: () => addNoteToSelection(),\n'
                '  ),\n'
                '  ContextMenuButtonItem(\n'
                '    label: \'Translate\',\n'
                '    type: ContextMenuButtonType.custom,\n'
                '    onPressed: () => translateSelection(),\n'
                '  ),\n'
                '  ContextMenuButtonItem(\n'
                '    label: \'Web Search\',\n'
                '    type: ContextMenuButtonType.custom,\n'
                '    onPressed: () => searchWeb(selectedText),\n'
                '  ),\n'
                '];'),
            cxDivider(),
            cxBullet(
                'Order matters: items listed first appear on the first page '
                'of the toolbar. Place the most-used items first.'),
          ]),

          // ── 12. replacing system items ──
          cxSection('12 · Replacing System Items Entirely', [
            cxBullet(
                'To completely replace the system menu, do not spread '
                'contextMenuButtonItems. Build only your custom items.'),
            cxBullet(
                'This is useful for specialized editors where Cut/Copy/Paste '
                'have domain-specific meanings.'),
            cxCodeBlock(
                '// Replacing all system items with custom ones\n'
                'TextField(\n'
                '  contextMenuBuilder: (context, editableTextState) {\n'
                '    return AdaptiveTextSelectionToolbar.buttonItems(\n'
                '      anchors: editableTextState.contextMenuAnchors,\n'
                '      buttonItems: [\n'
                '        ContextMenuButtonItem(\n'
                '          label: \'Custom Action A\',\n'
                '          onPressed: () => actionA(),\n'
                '        ),\n'
                '        ContextMenuButtonItem(\n'
                '          label: \'Custom Action B\',\n'
                '          onPressed: () => actionB(),\n'
                '        ),\n'
                '      ],\n'
                '    );\n'
                '  },\n'
                ')'),
            cxDivider(),
            cxHighlight(
                'Caution: removing all system items (especially Copy/Paste) '
                'may confuse users. Consider including at least Copy and '
                'Paste unless there is a strong design reason not to.'),
          ]),

          // ── 13. edge cases ──
          cxSection('13 · Edge Cases & Boundary Conditions', [
            cxBullet(
                'Custom item with null onPressed: the item is not rendered '
                'in the toolbar; the framework filters out disabled items.'),
            cxBullet(
                'Empty label: technically allowed but renders as a blank '
                'button, creating a confusing UI.'),
            cxBullet(
                'Very long label: the toolbar truncates or wraps the text '
                'depending on available space; keep labels concise.'),
            cxBullet(
                'Async operations in onPressed: the callback is synchronous '
                '(VoidCallback); fire-and-forget async work or show a '
                'loading indicator separately.'),
            cxBullet(
                'Multiple simultaneous context menus: only one context menu '
                'is shown at a time; opening a new one dismisses the previous.'),
            cxDivider(),
            cxBullet(
                'Hot reload: the contextMenuBuilder is re-evaluated on each '
                'menu show, so hot reload updates custom items immediately.'),
          ]),

          // ── 14. testing strategies ──
          cxSection('14 · Testing Custom Context Menu Items', [
            cxBullet(
                'Verify the custom item appears by finding its label text '
                'in the widget tree after triggering the context menu.'),
            cxBullet(
                'Tap the custom item and verify the expected side effect '
                '(state change, navigation, etc.).'),
            cxCodeBlock(
                'testWidgets(\'custom context menu item appears\',\n'
                '    (WidgetTester tester) async {\n'
                '  await tester.pumpWidget(MaterialApp(\n'
                '    home: Scaffold(\n'
                '      body: TextField(\n'
                '        controller: TextEditingController(\n'
                '          text: \'Some text here\',\n'
                '        ),\n'
                '        contextMenuBuilder: (ctx, state) {\n'
                '          return AdaptiveTextSelectionToolbar.buttonItems(\n'
                '            anchors: state.contextMenuAnchors,\n'
                '            buttonItems: [\n'
                '              ...state.contextMenuButtonItems,\n'
                '              ContextMenuButtonItem(\n'
                '                label: \'My Action\',\n'
                '                onPressed: () {},\n'
                '              ),\n'
                '            ],\n'
                '          );\n'
                '        },\n'
                '      ),\n'
                '    ),\n'
                '  ));\n'
                '  await tester.longPress(find.byType(TextField));\n'
                '  await tester.pump();\n'
                '  expect(find.text(\'My Action\'), findsOneWidget);\n'
                '});'),
          ]),

          // ── 15. accessibility ──
          cxSection('15 · Accessibility for Custom Items', [
            cxBullet(
                'Custom items automatically get accessibility labels matching '
                'their label text.'),
            cxBullet(
                'VoiceOver reads the label as "My Action, button" when '
                'navigating the context menu.'),
            cxBullet(
                'For better accessibility, use descriptive labels like '
                '"Translate to Spanish" instead of just "Translate".'),
            cxDivider(),
            cxKeyValue('Semantic label', 'Derived from the label property'),
            cxKeyValue('A11y trait', 'Button (automatic)'),
            cxKeyValue('Hint', 'Not customizable via ContextMenuButtonItem'),
          ]),

          // ── 16. iOS-specific considerations ──
          cxSection('16 · iOS Platform-Specific Notes', [
            cxBullet(
                'On iOS, the context menu has a distinct visual style: '
                'rounded pill shape, blurred background, and haptic feedback.'),
            cxBullet(
                'Custom items match this styling automatically when using '
                'AdaptiveTextSelectionToolbar.'),
            cxBullet(
                'If you build a fully custom toolbar widget (not using the '
                'adaptive builder), you are responsible for matching the '
                'Cupertino style if consistency is desired.'),
            cxDivider(),
            cxHighlight(
                'Apple Human Interface Guidelines recommend keeping context '
                'menu items minimal and relevant. Add only items that '
                'directly relate to the selected text content.'),
          ]),

          // ── 17. API summary ──
          cxSection('17 · Quick API Reference', [
            cxKeyValue('Class', 'IOSSystemContextMenuItemCustom'),
            cxKeyValue('Builder', 'ContextMenuButtonItem(label: ..., onPressed: ...)'),
            cxKeyValue('Type', 'ContextMenuButtonType.custom'),
            cxKeyValue('Toolbar', 'AdaptiveTextSelectionToolbar.buttonItems'),
            cxKeyValue('Integration', 'TextField.contextMenuBuilder'),
            cxDivider(),
            cxCodeBlock(
                '// Complete custom item integration\n'
                'TextField(\n'
                '  contextMenuBuilder: (ctx, state) {\n'
                '    return AdaptiveTextSelectionToolbar.buttonItems(\n'
                '      anchors: state.contextMenuAnchors,\n'
                '      buttonItems: [\n'
                '        ...state.contextMenuButtonItems,\n'
                '        ContextMenuButtonItem(\n'
                '          label: \'Custom Action\',\n'
                '          type: ContextMenuButtonType.custom,\n'
                '          onPressed: () { /* action */ },\n'
                '        ),\n'
                '      ],\n'
                '    );\n'
                '  },\n'
                ')'),
          ]),

          // ── footer ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            color: cxSunset.withValues(alpha: 0.06),
            child: const Text(
              'IOSSystemContextMenuItemCustom · Sunset Orange Deep Demo',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: cxMuted,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    ),
  );
}
