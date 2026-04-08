// ignore_for_file: avoid_print
// IOSSystemContextMenuItemShare – comprehensive deep demo
// Slate / Silver palette – iOS "Share" context menu action:
// opens the system share sheet for selected text.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── palette ───────────────────────────────────────────────────────────
  const Color shSlate = Color(0xFF37474F);
  const Color shSilver = Color(0xFFECEFF1);
  const Color shOnSlate = Color(0xFFFFFFFF);
  const Color shDark = Color(0xFF1B252B);
  const Color shLightSilver = Color(0xFFF5F7F8);
  const Color shTextDark = Color(0xFF1C2830);
  const Color shAccent = Color(0xFF546E7A);
  const Color shMuted = Color(0xFF90A4AE);

  // ─── helpers ───────────────────────────────────────────────────────────
  Widget shHeader(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [shSlate, shDark],
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
                  color: shOnSlate)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: shOnSlate.withValues(alpha: 0.85))),
        ],
      ),
    );
  }

  Widget shSection(String heading, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: shLightSilver,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: shSlate.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: shSlate.withValues(alpha: 0.07),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Text(heading,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: shSlate)),
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

  Widget shBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('▪ ',
              style: TextStyle(color: shAccent, fontSize: 11)),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 12, color: shTextDark, height: 1.4)),
          ),
        ],
      ),
    );
  }

  Widget shCodeBlock(String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2530),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(code,
          style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: shSilver,
              height: 1.5)),
    );
  }

  Widget shKeyValue(String key, String value) {
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
                    color: shDark)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: shTextDark)),
          ),
        ],
      ),
    );
  }

  Widget shHighlight(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: shAccent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: shAccent.withValues(alpha: 0.2)),
      ),
      child: Text(text,
          style: const TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: shDark,
              height: 1.4)),
    );
  }

  Widget shDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Divider(color: shMuted.withValues(alpha: 0.4), height: 1),
    );
  }

  Widget shInfoRow(String icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: shSlate.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(icon,
                style: const TextStyle(fontSize: 12, color: shSlate)),
          ),
          const SizedBox(width: 8),
          Text(label,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: shDark)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: shTextDark)),
          ),
        ],
      ),
    );
  }

  Widget shCompare(String label, String desc) {
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
              color: shSlate,
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
                          color: shDark)),
                  TextSpan(
                      text: desc,
                      style: const TextStyle(
                          fontSize: 11, color: shTextDark)),
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
    color: shSilver,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── header ──
          shHeader(
            'IOSSystemContextMenuItemShare',
            'iOS "Share" context menu action – opens the system '
                'share sheet to send selected text via Messages, Mail, '
                'AirDrop, and third-party apps',
          ),

          // ── 1. class overview ──
          shSection('1 · Class Identity & Role', [
            shKeyValue('Class', 'IOSSystemContextMenuItemShare'),
            shKeyValue('Platform', 'iOS / iPadOS'),
            shKeyValue('Action', 'Opens UIActivityViewController'),
            shKeyValue('Toolbar',
                'CupertinoAdaptiveTextSelectionToolbar'),
            shDivider(),
            shBullet(
                'IOSSystemContextMenuItemShare represents the "Share..." '
                'button in the iOS text selection context menu.'),
            shBullet(
                'Tapping it presents the system share sheet '
                '(UIActivityViewController) with the selected text as '
                'the shareable content.'),
            shBullet(
                'The share sheet shows all available share destinations '
                'including AirDrop, Messages, Mail, Notes, and any '
                'third-party apps that accept text.'),
          ]),

          // ── 2. share flow ──
          shSection('2 · Share Action Flow', [
            shBullet(
                'Step 1: User selects text in a text field or SelectableText.'),
            shBullet(
                'Step 2: Context menu appears; user taps chevron for secondary items.'),
            shBullet(
                'Step 3: User taps "Share..." from the secondary row.'),
            shBullet(
                'Step 4: iOS presents UIActivityViewController as a modal sheet.'),
            shBullet(
                'Step 5: User picks a destination (AirDrop, Messages, etc.).'),
            shBullet(
                'Step 6: The selected text is passed to the chosen activity.'),
            shDivider(),
            shHighlight(
                'The share sheet is system-managed. The app has no control '
                'over which sharing options appear — that depends on installed '
                'apps and system extensions. The only input is the selected text.'),
          ]),

          // ── 3. share sheet anatomy ──
          shSection('3 · UIActivityViewController Anatomy', [
            shBullet(
                'Top row: AirDrop targets (nearby devices with AirDrop on).'),
            shBullet(
                'Second row: Favorites (Messages, Mail, user-pinned apps).'),
            shBullet(
                'Middle section: App suggestions based on usage frequency.'),
            shBullet(
                'Bottom section: System actions (Copy, Add to Reading List, '
                'Print, Assign to Contact, etc.).'),
            shDivider(),
            shKeyValue('Modal', 'Yes, covers bottom half of screen'),
            shKeyValue('Dismissible', 'Tap outside or Cancel button'),
            shKeyValue('Content type', 'NSString (the selected text)'),
          ]),

          // ── 4. visibility conditions ──
          shSection('4 · When Share Appears', [
            shBullet(
                'Share appears when text is selected (non-collapsed selection).'),
            shBullet(
                'Available in BOTH editable and read-only fields — Share '
                'does not modify the field content.'),
            shBullet(
                'Share does not require clipboard access, network, or any '
                'special permissions.'),
            shDivider(),
            shKeyValue('Selection required', 'Yes, non-collapsed'),
            shKeyValue('Editable required', 'No'),
            shKeyValue('Clipboard', 'Not involved (separate from Copy)'),
            shKeyValue('Permissions', 'None required'),
          ]),

          // ── 5. menu positioning ──
          shSection('5 · Context Menu Positioning', [
            shBullet(
                'Share is a SECONDARY item. The user must tap the chevron '
                'arrow to access the secondary row.'),
            shBullet(
                'Typical secondary row: Look Up, Translate, Search Web, '
                'Share, Scan Text.'),
            shDivider(),
            shKeyValue('Position', 'Secondary row of callout bar'),
            shKeyValue('Icon', 'None (text label "Share...")'),
            shKeyValue('Label', '"Share..." (with ellipsis, localized)'),
          ]),

          // ── 6. share destinations ──
          shSection('6 · Common Share Destinations', [
            shInfoRow('📱', 'AirDrop:', 'Send text to nearby Apple devices'),
            shInfoRow('💬', 'Messages:', 'Paste into iMessage/SMS'),
            shInfoRow('📧', 'Mail:', 'New email with text as body'),
            shInfoRow('📝', 'Notes:', 'Create or append to a note'),
            shInfoRow('📋', 'Reminders:', 'Create reminder with text'),
            shInfoRow('🔖', 'Books:', 'Highlight or notebook entry'),
            shDivider(),
            shBullet(
                'Third-party apps with share extensions: WhatsApp, Telegram, '
                'Slack, Twitter/X, LinkedIn, and many more.'),
            shBullet(
                'The order is personalized based on the user sharing history '
                'and frequency — iOS learns preferred destinations.'),
          ]),

          // ── 7. share vs copy ──
          shSection('7 · Share vs Copy', [
            shCompare('Copy', 'Writes text to system clipboard silently'),
            shCompare('Share', 'Opens modal sheet for destination selection'),
            shDivider(),
            shBullet(
                'Copy is instant and invisible. Share presents a full-screen '
                'modal that requires user interaction.'),
            shBullet(
                'Copy puts text on the clipboard for pasting. Share can send '
                'it to any app or service directly.'),
            shBullet(
                'Copy does not leave the current app. Share may open another '
                'app (e.g., composing a message in Messages).'),
            shHighlight(
                'Key difference: Copy stores text locally, Share transmits '
                'it to a destination. Both are non-destructive — neither '
                'modifies the original text.'),
          ]),

          // ── 8. Flutter integration ──
          shSection('8 · Flutter Framework Integration', [
            shBullet(
                'Share is auto-provided by the iOS system toolbar when text '
                'is selected. Flutter does not add it manually.'),
            shBullet(
                'In custom contextMenuBuilder, include system-provided '
                'buttonItems to retain Share.'),
            shCodeBlock(
                '// Preserve Share in custom menus:\n'
                'TextField(\n'
                '  contextMenuBuilder: (context, editableTextState) {\n'
                '    final items =\n'
                '        editableTextState.contextMenuButtonItems;\n'
                '    return AdaptiveTextSelectionToolbar.buttonItems(\n'
                '      anchors: editableTextState.contextMenuAnchors,\n'
                '      buttonItems: items, // includes Share\n'
                '    );\n'
                '  },\n'
                ')'),
            shDivider(),
            shBullet(
                'If you replace all buttonItems with custom actions, Share '
                'disappears. Flutter has no API to manually invoke the '
                'system share sheet from a context menu.'),
            shBullet(
                'For programmatic sharing, use the share_plus package or '
                'platform channels to invoke UIActivityViewController.'),
          ]),

          // ── 9. class properties ──
          shSection('9 · Class Properties & Constructor', [
            shCodeBlock(
                '// IOSSystemContextMenuItemShare is a final class\n'
                '// with a const constructor.\n'
                'const IOSSystemContextMenuItemShare({\n'
                '  super.title,  // optional custom label\n'
                '})\n'
                '\n'
                '// Usage:\n'
                'const item = IOSSystemContextMenuItemShare();\n'
                '// item.title → null (uses system default "Share...")\n'
                '\n'
                'const custom = IOSSystemContextMenuItemShare(\n'
                '  title: \'Send via...\',\n'
                ');\n'
                '// custom.title → "Send via..."'),
            shDivider(),
            shKeyValue('title', 'Optional String, null uses system default'),
            shKeyValue('Const', 'Yes, supports const construction'),
            shKeyValue('Mixin', 'Diagnosticable for debug inspection'),
            shKeyValue('Superclass', 'IOSSystemContextMenuItem'),
          ]),

          // ── 10. share sheet customization ──
          shSection('10 · Share Sheet Customization', [
            shBullet(
                'iOS allows apps to exclude specific activity types from '
                'the share sheet. However, the context menu Share does NOT '
                'allow this — it uses a default configuration.'),
            shBullet(
                'The excludedActivityTypes property of UIActivityViewController '
                'is only available when programmatically presenting it.'),
            shCodeBlock(
                '// Only available in programmatic sharing:\n'
                '// activityVC.excludedActivityTypes = [\n'
                '//   UIActivity.ActivityType.print,\n'
                '//   UIActivity.ActivityType.assignToContact,\n'
                '// ]\n'
                '//\n'
                '// Context menu Share always shows ALL activities.'),
            shDivider(),
            shBullet(
                'The user can customize the share sheet order by editing '
                'their favorites row (long-press to rearrange, "Edit Actions" '
                'button at the bottom).'),
          ]),

          // ── 11. AirDrop specifics ──
          shSection('11 · AirDrop Text Sharing', [
            shBullet(
                'When sharing text via AirDrop, the receiving device shows '
                'a notification with the text content.'),
            shBullet(
                'The recipient can accept (copies to clipboard or opens in '
                'Notes) or decline the transfer.'),
            shBullet(
                'AirDrop uses Bluetooth for discovery and Wi-Fi for the '
                'actual data transfer. No internet required.'),
            shDivider(),
            shKeyValue('Protocol', 'Bluetooth (discover) + Wi-Fi (transfer)'),
            shKeyValue('Range', 'Approximately 10 meters (30 feet)'),
            shKeyValue('Encryption', 'TLS encrypted in transit'),
          ]),

          // ── 12. platform differences ──
          shSection('12 · Platform Comparison', [
            shKeyValue('iOS', '"Share..." in secondary callout bar row'),
            shKeyValue('iPadOS', 'Same, may show popover instead of sheet'),
            shKeyValue('macOS', 'Share menu in menu bar or right-click'),
            shKeyValue('Android', 'Intent.ACTION_SEND via share button'),
            shKeyValue('Web', 'Navigator.share() API (limited support)'),
            shDivider(),
            shBullet(
                'On iPadOS, the share sheet may appear as a popover '
                'anchored to the text selection rather than a bottom sheet.'),
            shBullet(
                'On Android, sharing uses the Intent system with '
                'ACTION_SEND and EXTRA_TEXT, which is functionally similar.'),
          ]),

          // ── 13. VoiceOver accessibility ──
          shSection('13 · VoiceOver & Accessibility', [
            shBullet(
                'VoiceOver announces "Share, button" when focused.'),
            shBullet(
                'The accessibility hint is "Share the selected text."'),
            shBullet(
                'After activation, VoiceOver focus moves to the share sheet '
                'where each row and destination is separately focusable.'),
            shDivider(),
            shKeyValue('A11y label', '"Share"'),
            shKeyValue('A11y trait', 'Button'),
            shKeyValue('A11y hint', '"Share the selected text"'),
          ]),

          // ── 14. content types beyond text ──
          shSection('14 · Share Sheet Content Types', [
            shBullet(
                'From text context menu: content is always NSString (plain text).'),
            shBullet(
                'Rich text formatting (bold, italic) is NOT preserved — '
                'the share sheet receives the raw text content only.'),
            shBullet(
                'URLs within the text are not auto-detected. The entire '
                'selection is shared as a single plain text string.'),
            shHighlight(
                'If you need to share rich content (images, URLs, files), '
                'use programmatic sharing via UIActivityViewController '
                'rather than the text context menu Share action.'),
          ]),

          // ── 15. complete menu reference ──
          shSection('15 · Complete iOS Menu Item Reference', [
            shCompare('Cut', 'Clipboard write + delete (editable only)'),
            shCompare('Copy', 'Clipboard write (any field)'),
            shCompare('Paste', 'Clipboard read + insert (editable only)'),
            shCompare('Select All', 'Full text selection (any non-empty field)'),
            shCompare('Look Up', 'Inline dictionary/wiki (any field)'),
            shCompare('Translate', 'System translation (any field)'),
            shCompare('Search Web', 'Safari search (any field)'),
            shCompare('Share', 'Share sheet (any field with selection)'),
            shCompare('Scan Text', 'Camera OCR (editable only)'),
          ]),

          // ── 16. quick API reference ──
          shSection('16 · Quick API Reference', [
            shKeyValue('Class', 'IOSSystemContextMenuItemShare'),
            shKeyValue('Platform', 'iOS / iPadOS'),
            shKeyValue('Action', 'Opens UIActivityViewController'),
            shKeyValue('Visibility', 'Non-collapsed selection, any field'),
            shKeyValue('Modifies text', 'No'),
            shKeyValue('Modifies clipboard', 'No'),
            shKeyValue('Leaves app', 'May open another app'),
            shDivider(),
            shCodeBlock(
                '// Share is auto-included by the system toolbar.\n'
                'const item = IOSSystemContextMenuItemShare();\n'
                'print(item.title); // null (system default)\n'
                'print(item is IOSSystemContextMenuItem); // true\n'
                '\n'
                'const custom = IOSSystemContextMenuItemShare(\n'
                '  title: \'Share Text\',\n'
                ');'),
          ]),

          // ── footer ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            color: shSlate.withValues(alpha: 0.06),
            child: const Text(
              'IOSSystemContextMenuItemShare · Slate Deep Demo',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: shMuted,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    ),
  );
}
