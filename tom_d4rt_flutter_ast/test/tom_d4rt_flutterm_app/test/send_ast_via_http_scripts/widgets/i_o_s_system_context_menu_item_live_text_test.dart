// ignore_for_file: avoid_print
// IOSSystemContextMenuItemLiveText – comprehensive deep demo
// Electric Purple / Lavender palette – iOS Live Text: camera-based OCR
// recognition integrated into the text selection context menu.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── palette ───────────────────────────────────────────────────────────
  const Color ltPurple = Color(0xFF7B1FA2);
  const Color ltLavender = Color(0xFFF3E5F5);
  const Color ltOnPurple = Color(0xFFFFFFFF);
  const Color ltDeep = Color(0xFF4A0072);
  const Color ltLightLav = Color(0xFFF9F0FC);
  const Color ltTextDark = Color(0xFF2E1040);
  const Color ltAccent = Color(0xFFBA68C8);
  const Color ltMuted = Color(0xFFCE93D8);

  // ─── helpers ───────────────────────────────────────────────────────────
  Widget ltHeader(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [ltPurple, ltDeep],
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
                  color: ltOnPurple)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: ltOnPurple.withValues(alpha: 0.85))),
        ],
      ),
    );
  }

  Widget ltSection(String heading, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: ltLightLav,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ltPurple.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: ltPurple.withValues(alpha: 0.08),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Text(heading,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: ltPurple)),
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

  Widget ltBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('◆ ',
              style: TextStyle(color: ltAccent, fontSize: 11)),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 12, color: ltTextDark, height: 1.4)),
          ),
        ],
      ),
    );
  }

  Widget ltCodeBlock(String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF1A0030),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(code,
          style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: ltLavender,
              height: 1.5)),
    );
  }

  Widget ltKeyValue(String key, String value) {
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
                    color: ltDeep)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: ltTextDark)),
          ),
        ],
      ),
    );
  }

  Widget ltHighlight(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ltAccent.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: ltAccent.withValues(alpha: 0.25)),
      ),
      child: Text(text,
          style: const TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: ltDeep,
              height: 1.4)),
    );
  }

  Widget ltDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Divider(color: ltMuted.withValues(alpha: 0.4), height: 1),
    );
  }

  Widget ltInfoRow(String icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ltPurple.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(icon,
                style: const TextStyle(fontSize: 12, color: ltPurple)),
          ),
          const SizedBox(width: 8),
          Text(label,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: ltDeep)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: ltTextDark)),
          ),
        ],
      ),
    );
  }

  Widget ltStep(String number, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ltPurple,
            ),
            child: Text(number,
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: ltOnPurple)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: ltDeep)),
                const SizedBox(height: 2),
                Text(desc,
                    style: const TextStyle(
                        fontSize: 11,
                        color: ltTextDark,
                        height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── main layout ───────────────────────────────────────────────────────
  return Container(
    color: ltLavender,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── header ──
          ltHeader(
            'IOSSystemContextMenuItemLiveText',
            'iOS Live Text – camera-based OCR recognition that inserts '
                'recognized text directly into text fields',
          ),

          // ── 1. what is live text ──
          ltSection('1 · What is Live Text?', [
            ltBullet(
                'Live Text is an iOS feature (introduced iOS 15) that uses '
                'on-device machine learning to recognize text in camera '
                'frames and images.'),
            ltBullet(
                'When integrated into a text field context menu, it opens '
                'the device camera and scans for text in real time.'),
            ltBullet(
                'Recognized text is inserted at the current cursor position '
                'or replaces the current selection.'),
            ltHighlight(
                'Live Text uses VisionKit and the Neural Engine to perform '
                'OCR entirely on-device, with no network connection required. '
                'This ensures user privacy is maintained.'),
          ]),

          // ── 2. class identity ──
          ltSection('2 · Class Identity & Role', [
            ltKeyValue('Class', 'IOSSystemContextMenuItemLiveText'),
            ltKeyValue('Platform', 'iOS 15+ only'),
            ltKeyValue('Menu label', '"Scan Text" or localized equivalent'),
            ltKeyValue('Framework', 'VisionKit (UITextFromCameraAction)'),
            ltKeyValue('Toolbar',
                'CupertinoAdaptiveTextSelectionToolbar'),
            ltDivider(),
            ltBullet(
                'This menu item represents the "Scan Text" button that '
                'appears in the iOS context menu when the device has a camera '
                'and supports the VisionKit text recognition APIs.'),
            ltBullet(
                'It enables users to point their camera at text in the '
                'physical world and insert it directly into a text field.'),
          ]),

          // ── 3. how live text works ──
          ltSection('3 · How Live Text OCR Works', [
            ltStep('1', 'Camera Opens',
                'Tapping "Scan Text" opens an inline camera viewfinder '
                'positioned below the text field.'),
            ltStep('2', 'Real-Time Recognition',
                'VisionKit runs continuous text recognition on camera '
                'frames. Recognized text is highlighted with a yellow '
                'overlay in the viewfinder.'),
            ltStep('3', 'Text Selection',
                'The user can select specific recognized text by tapping '
                'or dragging over the highlighted regions.'),
            ltStep('4', 'Text Insertion',
                'The selected text is inserted into the text field at '
                'the cursor position or replaces the current selection.'),
            ltStep('5', 'Camera Closes',
                'The inline viewfinder closes and the text field retains '
                'focus with the newly inserted text.'),
          ]),

          // ── 4. hardware requirements ──
          ltSection('4 · Hardware & Software Requirements', [
            ltKeyValue('iOS Version', '15.0 or later'),
            ltKeyValue('Processor', 'A12 Bionic or later (Neural Engine)'),
            ltKeyValue('Camera', 'Rear-facing camera required'),
            ltKeyValue('Supported Devices',
                'iPhone XS/XR (2018) and newer'),
            ltDivider(),
            ltBullet(
                'Devices without a Neural Engine (e.g., iPhone X, iPhone 8) '
                'do not show the Live Text menu item.'),
            ltBullet(
                'iPad models with A12+ chips also support Live Text.'),
            ltBullet(
                'The feature requires camera permission, which is requested '
                'when the user first taps the "Scan Text" button.'),
            ltCodeBlock(
                '// Device capability check (native iOS)\n'
                '// UITextFromCamera.isSupported → Bool\n'
                '// Returns true only on A12+ devices with iOS 15+'),
          ]),

          // ── 5. when live text appears ──
          ltSection('5 · Visibility Conditions', [
            ltBullet(
                'The Live Text item appears when ALL conditions are met:'),
            ltKeyValue('Editable field',
                'The field must be writable (not read-only)'),
            ltKeyValue('Device support',
                'A12+ chip with camera available'),
            ltKeyValue('iOS 15+',
                'The minimum OS version that includes VisionKit OCR'),
            ltDivider(),
            ltBullet(
                'Unlike Cut/Copy, Live Text does NOT require an existing '
                'selection. It works with a collapsed caret too.'),
            ltBullet(
                'In read-only fields (SelectableText, readOnly: true), '
                'Live Text is hidden because text cannot be inserted.'),
            ltBullet(
                'Live Text is shown regardless of whether the clipboard '
                'has content or not – it operates independently.'),
          ]),

          // ── 6. Flutter integration ──
          ltSection('6 · Flutter Framework Integration', [
            ltBullet(
                'Flutter does not directly invoke VisionKit. Instead, the '
                'Live Text button is provided by the iOS platform layer.'),
            ltBullet(
                'When Flutter renders a CupertinoAdaptiveTextSelectionToolbar, '
                'the native iOS system inserts the "Scan Text" item if '
                'the device supports it.'),
            ltCodeBlock(
                '// Flutter does not control Live Text directly.\n'
                '// The CupertinoAdaptiveTextSelectionToolbar\n'
                '// delegates to the iOS system which auto-adds\n'
                '// the "Scan Text" item when supported.\n'
                '//\n'
                '// In custom contextMenuBuilder implementations,\n'
                '// you must include the system buttons to preserve\n'
                '// Live Text availability.'),
            ltDivider(),
            ltBullet(
                'If you build a fully custom context menu without using '
                'CupertinoAdaptiveTextSelectionToolbar, the Live Text '
                'item will not appear automatically.'),
          ]),

          // ── 7. recognized text types ──
          ltSection('7 · What Live Text Can Recognize', [
            ltInfoRow('A', 'Latin:', 'English, French, German, Spanish, etc.'),
            ltInfoRow('B', 'CJK:', 'Chinese, Japanese, Korean (iOS 16+)'),
            ltInfoRow('C', 'Cyrillic:', 'Russian, Ukrainian (iOS 16+)'),
            ltInfoRow('D', 'Arabic:', 'Arabic, Hebrew (iOS 16+)'),
            ltDivider(),
            ltBullet(
                'Live Text recognizes printed text only – handwriting '
                'recognition is limited to very clean handwriting.'),
            ltBullet(
                'Recognized formats include phone numbers, URLs, email '
                'addresses, and dates – these may trigger data detectors.'),
            ltBullet(
                'Barcode and QR code recognition is available but does '
                'not apply to the text field insertion use case.'),
          ]),

          // ── 8. context menu positioning ──
          ltSection('8 · Menu Positioning & Layout', [
            ltBullet(
                'The "Scan Text" item appears as a secondary-level item '
                'in the callout bar, often requiring the user to tap the '
                'chevron (arrow) to reveal it.'),
            ltBullet(
                'Primary items: Cut, Copy, Paste, Select All. Secondary '
                'items: Look Up, Translate, Scan Text, Share.'),
            ltBullet(
                'On newer iOS versions, Scan Text may appear with a camera '
                'icon next to the label for visual distinction.'),
            ltDivider(),
            ltKeyValue('Icon', 'Camera glyph (SF Symbol: text.viewfinder)'),
            ltKeyValue('Position', 'Secondary row of callout bar'),
            ltKeyValue('Label', '"Scan Text" (localized)'),
          ]),

          // ── 9. camera viewfinder behavior ──
          ltSection('9 · Inline Camera Viewfinder', [
            ltBullet(
                'When activated, the camera viewfinder slides up from the '
                'bottom of the screen as a half-sheet.'),
            ltBullet(
                'The text field remains visible above the viewfinder, and '
                'inserted text appears in real time.'),
            ltBullet(
                'The viewfinder has a yellow tint behind recognized text '
                'regions, providing clear visual feedback.'),
            ltBullet(
                'The user can dismiss the viewfinder by tapping outside it '
                'or by pressing the close button.'),
            ltHighlight(
                'The viewfinder uses the rear-facing camera by default. '
                'There is no option to switch to the selfie camera for '
                'Live Text scanning.'),
          ]),

          // ── 10. privacy ──
          ltSection('10 · Privacy & Security', [
            ltBullet(
                'All OCR processing runs on-device via the Neural Engine. '
                'No images or recognized text are sent to Apple servers.'),
            ltBullet(
                'Camera frames are processed in real time and immediately '
                'discarded after recognition.'),
            ltBullet(
                'The app must request camera permission (NSCameraUsage'
                'Description) for Live Text to function.'),
            ltDivider(),
            ltKeyValue('Processing', 'On-device (Neural Engine)'),
            ltKeyValue('Network', 'Not required'),
            ltKeyValue('Data retention', 'None – frames are not stored'),
            ltKeyValue('Permission', 'Camera access required'),
          ]),

          // ── 11. custom contextMenuBuilder ──
          ltSection('11 · Preserving Live Text in Custom Menus', [
            ltBullet(
                'When building a custom contextMenuBuilder, include the '
                'system-provided buttons to retain Live Text support.'),
            ltCodeBlock(
                '// Preserve Live Text in custom menus\n'
                'TextField(\n'
                '  contextMenuBuilder: (context, editableTextState) {\n'
                '    // Use buttonItems to get system defaults\n'
                '    final buttonItems =\n'
                '        editableTextState.contextMenuButtonItems;\n'
                '    // Add custom items alongside system items\n'
                '    return AdaptiveTextSelectionToolbar.buttonItems(\n'
                '      anchors: editableTextState.contextMenuAnchors,\n'
                '      buttonItems: [\n'
                '        ...buttonItems,  // includes Live Text\n'
                '        ContextMenuButtonItem(\n'
                '          label: \'Custom Action\',\n'
                '          onPressed: () { /* custom logic */ },\n'
                '        ),\n'
                '      ],\n'
                '    );\n'
                '  },\n'
                ')'),
            ltDivider(),
            ltBullet(
                'If you replace all buttonItems with your own, Live Text '
                'will not be available because it cannot be added manually.'),
          ]),

          // ── 12. comparison with other input methods ──
          ltSection('12 · Comparison with Other Input Methods', [
            ltInfoRow('T', 'Keyboard:', 'Manual typing, always available'),
            ltInfoRow('V', 'Paste:', 'From clipboard, requires prior copy'),
            ltInfoRow('M', 'Dictation:', 'Voice-to-text, uses microphone'),
            ltInfoRow('S', 'Scan Text:', 'Camera OCR, requires camera'),
            ltDivider(),
            ltBullet(
                'Live Text fills a unique niche: transferring printed text '
                'from the physical world without manual transcription.'),
            ltBullet(
                'Common use cases include scanning business cards, receipts, '
                'serial numbers, and printed addresses.'),
          ]),

          // ── 13. platform exclusivity ──
          ltSection('13 · Platform Exclusivity', [
            ltBullet(
                'Live Text / "Scan Text" is exclusively an iOS platform '
                'feature. It is NOT available on Android, macOS, Windows, '
                'Linux, or web.'),
            ltBullet(
                'Android has a similar feature (Google Lens integration) '
                'but it is not exposed as a system context menu item in '
                'the same way.'),
            ltBullet(
                'On macOS, Live Text exists in Preview and Quick Look but '
                'is not integrated into NSTextField context menus.'),
            ltDivider(),
            ltKeyValue('iOS', 'Available as context menu item'),
            ltKeyValue('iPadOS', 'Available as context menu item'),
            ltKeyValue('macOS', 'Not in text field menus'),
            ltKeyValue('Android', 'Not available (Google Lens is separate)'),
            ltKeyValue('Web', 'Not available'),
          ]),

          // ── 14. supported text fields ──
          ltSection('14 · Supported Text Input Widgets', [
            ltBullet(
                'TextField – Live Text appears when using default or '
                'CupertinoAdaptiveTextSelectionToolbar menu.'),
            ltBullet(
                'CupertinoTextField – Full support including native styling.'),
            ltBullet(
                'EditableText – Depends on contextMenuBuilder implementation.'),
            ltBullet(
                'SelectableText – NOT supported (read-only, no insertion).'),
            ltDivider(),
            ltCodeBlock(
                '// CupertinoTextField with Live Text support\n'
                'CupertinoTextField(\n'
                '  placeholder: \'Tap to type or scan text...\',\n'
                '  // Live Text auto-appears in context menu\n'
                '  // on A12+ devices with iOS 15+\n'
                ')'),
          ]),

          // ── 15. edge cases ──
          ltSection('15 · Edge Cases & Limitations', [
            ltBullet(
                'Camera Permission Denied: if the user denies camera access, '
                'the "Scan Text" item still appears but tapping it shows '
                'a permission alert.'),
            ltBullet(
                'Low Light: recognition accuracy drops significantly in '
                'poor lighting conditions. The viewfinder shows no feedback '
                'when text cannot be recognized.'),
            ltBullet(
                'Handwriting: only very clear, printed-style handwriting '
                'is recognized. Cursive and stylized text fails.'),
            ltBullet(
                'Rotated Text: text at extreme angles (>45 degrees) may '
                'not be recognized properly.'),
            ltBullet(
                'Performance: on older A12 devices, recognition may have '
                'noticeable lag compared to A14+ devices.'),
          ]),

          // ── 16. accessibility ──
          ltSection('16 · VoiceOver & Accessibility', [
            ltBullet(
                'The "Scan Text" item is announced by VoiceOver as '
                '"Scan Text, button" in the context menu.'),
            ltBullet(
                'When the viewfinder opens, VoiceOver announces "Camera '
                'active, point at text" to guide blind users.'),
            ltBullet(
                'Recognized text regions are announced as they appear, '
                'though the feature is inherently visual and less useful '
                'for screen reader users.'),
            ltDivider(),
            ltKeyValue('A11y label', '"Scan Text"'),
            ltKeyValue('A11y trait', 'Button'),
            ltKeyValue('A11y hint', '"Insert text from camera"'),
          ]),

          // ── 17. API summary ──
          ltSection('17 · Quick API Reference', [
            ltKeyValue('Class', 'IOSSystemContextMenuItemLiveText'),
            ltKeyValue('Platform', 'iOS 15+ with A12+ chip'),
            ltKeyValue('Action', 'Camera OCR → text insertion'),
            ltKeyValue('Visibility', 'Editable field on supported device'),
            ltKeyValue('Permission', 'Camera access required'),
            ltKeyValue('Processing', 'On-device Neural Engine'),
            ltDivider(),
            ltCodeBlock(
                '// Live Text is system-managed. Flutter exposes it\n'
                '// through the platform channel automatically when\n'
                '// using CupertinoAdaptiveTextSelectionToolbar.\n'
                '//\n'
                '// To detect device support:\n'
                '// There is no Flutter API for this; the iOS system\n'
                '// simply hides the item on unsupported hardware.'),
          ]),

          // ── footer ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            color: ltPurple.withValues(alpha: 0.06),
            child: const Text(
              'IOSSystemContextMenuItemLiveText · Electric Purple Deep Demo',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: ltMuted,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    ),
  );
}
