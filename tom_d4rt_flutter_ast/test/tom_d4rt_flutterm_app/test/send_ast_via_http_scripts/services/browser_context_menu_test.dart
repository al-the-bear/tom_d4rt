// ignore_for_file: avoid_print
// D4rt deep demo: BrowserContextMenu — controlling the browser's native
// right-click context menu in Flutter web applications.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Coral / Salmon palette ───
  const Color coral = Color(0xFFFF7F50);
  const Color salmon = Color(0xFFFA8072);
  const Color deepCoral = Color(0xFFCD5B45);
  const Color paleSalmon = Color(0xFFFFF0EE);
  const Color darkCoral = Color(0xFF8B3A2A);
  const Color peach = Color(0xFFFFDAB9);
  const Color rosewood = Color(0xFF65000B);
  const Color blush = Color(0xFFDE5D83);
  const Color sienna = Color(0xFFA0522D);
  const Color shell = Color(0xFFFFF5EE);

  print('[bc] ===== BROWSER CONTEXT MENU DEEP DEMO =====');

  // ─── Local helpers ───

  Widget bcBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [darkCoral, deepCoral],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: darkCoral.withValues(alpha: 0.35),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: rosewood,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: coral, width: 1.5),
            ),
            child: Center(
              child: Text(number,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3)),
          ),
        ],
      ),
    );
  }

  Widget bcNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: shell,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: peach.withValues(alpha: 0.5)),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: darkCoral.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget bcCode(String label, String detail) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: paleSalmon.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(6),
        border: Border(left: BorderSide(color: coral, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: darkCoral,
                  fontFamily: 'monospace')),
          const SizedBox(width: 8),
          Expanded(
            child: Text(detail,
                style: TextStyle(fontSize: 12, color: deepCoral)),
          ),
        ],
      ),
    );
  }

  Widget bcCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: peach.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: darkCoral.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: coral.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: darkCoral)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget bcRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? coral.withValues(alpha: 0.06) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: peach.withValues(alpha: 0.4)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? darkCoral : deepCoral)),
          );
        }).toList(),
      ),
    );
  }

  Widget bcFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? darkCoral : deepCoral,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(steps[i],
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600)),
        ),
      );
      if (i < steps.length - 1) {
        items.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Icon(Icons.east, size: 12, color: salmon),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  // ━━━━━━ SECTION 1: What is BrowserContextMenu? ━━━━━━
  print('[bc-01] Section 1: What is BrowserContextMenu?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bcBanner('01', 'What Is BrowserContextMenu?'),
      bcNote(
        'BrowserContextMenu is a Flutter service class for controlling the '
        'browser\'s native right-click context menu in web applications. By '
        'default, right-clicking in a Flutter web app shows the browser\'s '
        'context menu (Copy, Paste, Inspect, etc.). This class lets you '
        'disable it so you can show your own custom context menu instead.',
      ),
      bcCard(
        'Browser Menu vs Custom Menu',
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: paleSalmon,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: salmon),
                ),
                child: Column(
                  children: [
                    Icon(Icons.web, size: 24, color: deepCoral),
                    const SizedBox(height: 6),
                    Text('Browser Default',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: deepCoral)),
                    const SizedBox(height: 6),
                    _bcMenuItem('Back', Icons.arrow_back, deepCoral),
                    _bcMenuItem('Forward', Icons.arrow_forward, deepCoral),
                    _bcMenuItem('Reload', Icons.refresh, deepCoral),
                    _bcMenuItem('Copy', Icons.copy, deepCoral),
                    _bcMenuItem('Inspect', Icons.code, deepCoral),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: shell,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: coral),
                ),
                child: Column(
                  children: [
                    Icon(Icons.widgets, size: 24, color: coral),
                    const SizedBox(height: 6),
                    Text('Custom Flutter',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: coral)),
                    const SizedBox(height: 6),
                    _bcMenuItem('Edit', Icons.edit, coral),
                    _bcMenuItem('Share', Icons.share, coral),
                    _bcMenuItem('Delete', Icons.delete, coral),
                    _bcMenuItem('Properties', Icons.info, coral),
                    _bcMenuItem('Export', Icons.download, coral),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 2: Enable/disable API ━━━━━━
  print('[bc-02] Section 2: Enable/disable API');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bcBanner('02', 'The Enable / Disable API'),
      bcNote(
        'BrowserContextMenu provides two static methods: '
        'disableContextMenu() and enableContextMenu(). These control whether '
        'the browser\'s native right-click menu appears. On non-web platforms, '
        'these methods are no-ops.',
      ),
      bcCard(
        'API Surface',
        Column(
          children: [
            bcRow(['Method', 'Effect', 'Returns'], isHeader: true),
            bcRow(['disableContextMenu()', 'Suppresses browser menu', 'Future<void>']),
            bcRow(['enableContextMenu()', 'Restores browser menu', 'Future<void>']),
            bcRow(['enabled (getter)', 'Current state', 'bool']),
          ],
        ),
      ),
      bcCard(
        'Usage Pattern',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paleSalmon,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('// Disable browser context menu:',
                  style: TextStyle(
                      fontSize: 11, fontFamily: 'monospace', color: sienna)),
              Text('BrowserContextMenu.disableContextMenu();',
                  style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'monospace',
                      color: darkCoral,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('// Re-enable later:',
                  style: TextStyle(
                      fontSize: 11, fontFamily: 'monospace', color: sienna)),
              Text('BrowserContextMenu.enableContextMenu();',
                  style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'monospace',
                      color: darkCoral,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: Web-only behavior ━━━━━━
  print('[bc-03] Section 3: Web-only behavior');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bcBanner('03', 'Web-Only Behavior'),
      bcNote(
        'BrowserContextMenu only affects Flutter web builds. On Android, iOS, '
        'macOS, Windows, and Linux, calling these methods has no effect. This '
        'makes it safe to call unconditionally without platform checks.',
      ),
      bcCard(
        'Platform Behavior',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _bcPlatformBadge('Web', true, coral)),
                const SizedBox(width: 6),
                Expanded(child: _bcPlatformBadge('Android', false, salmon)),
                const SizedBox(width: 6),
                Expanded(child: _bcPlatformBadge('iOS', false, salmon)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(child: _bcPlatformBadge('macOS', false, salmon)),
                const SizedBox(width: 6),
                Expanded(child: _bcPlatformBadge('Windows', false, salmon)),
                const SizedBox(width: 6),
                Expanded(child: _bcPlatformBadge('Linux', false, salmon)),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Safe to call on all platforms — no-op on non-web.',
                style: TextStyle(fontSize: 11, color: darkCoral),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: Rich text editor use case ━━━━━━
  print('[bc-04] Section 4: Rich text editor');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bcBanner('04', 'Use Case: Rich Text Editor'),
      bcNote(
        'A web-based rich text editor needs its own context menu with '
        'formatting options. The browser\'s default menu would break the UX.',
      ),
      bcCard(
        'Editor Context Menu',
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paleSalmon.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: coral.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: peach),
                ),
                child: Text(
                  'The quick brown fox jumps over the lazy dog. '
                  'Selected text appears highlighted in the editor.',
                  style: TextStyle(fontSize: 12, color: darkCoral),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: darkCoral.withValues(alpha: 0.15),
                      blurRadius: 8,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _bcCustomItem('Bold', Icons.format_bold, coral),
                    _bcCustomItem('Italic', Icons.format_italic, coral),
                    _bcCustomItem('Underline', Icons.format_underlined, coral),
                    Divider(height: 1, color: peach),
                    _bcCustomItem('Cut', Icons.content_cut, deepCoral),
                    _bcCustomItem('Copy', Icons.copy, deepCoral),
                    _bcCustomItem('Paste', Icons.paste, deepCoral),
                    Divider(height: 1, color: peach),
                    _bcCustomItem('Add Link', Icons.link, sienna),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: Canvas/drawing app ━━━━━━
  print('[bc-05] Section 5: Canvas/drawing app');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bcBanner('05', 'Use Case: Canvas Drawing App'),
      bcNote(
        'Drawing and design tools on the web use right-click for tool-specific '
        'actions (color picker, layer options, shape properties). The browser\'s '
        'context menu must be disabled to capture right-click events.',
      ),
      bcCard(
        'Drawing App Right-Click',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: peach),
              ),
              child: Stack(
                children: [
                  Positioned(left: 20, top: 20,
                    child: Container(width: 40, height: 40,
                        decoration: BoxDecoration(
                          color: coral.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(20)))),
                  Positioned(left: 60, top: 30,
                    child: Container(width: 60, height: 30,
                        color: salmon.withValues(alpha: 0.3))),
                  Positioned(right: 20, bottom: 10,
                    child: Icon(Icons.mouse, size: 16, color: deepCoral)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: darkCoral.withValues(alpha: 0.12),
                          blurRadius: 6,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _bcCustomItem('Color Picker', Icons.palette, coral),
                        _bcCustomItem('Send to Back', Icons.flip_to_back, deepCoral),
                        _bcCustomItem('Bring to Front', Icons.flip_to_front, deepCoral),
                        _bcCustomItem('Group', Icons.group_work, sienna),
                        _bcCustomItem('Delete Shape', Icons.delete_outline, blush),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Right-click on canvas shows drawing-specific options. '
                    'Browser menu would show Back, Forward, Reload — useless.',
                    style: TextStyle(fontSize: 11, color: deepCoral),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: Image viewer ━━━━━━
  print('[bc-06] Section 6: Image viewer');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bcBanner('06', 'Use Case: Image Viewer / Gallery'),
      bcNote(
        'Image viewing apps want to prevent "Save Image As" from the '
        'browser context menu (for copyright protection) and show custom '
        'options like zoom, rotate, or share.',
      ),
      bcCard(
        'Gallery Context Menu',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [coral.withValues(alpha: 0.1), salmon.withValues(alpha: 0.1)],
                ),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: peach),
              ),
              child: Center(
                child: Icon(Icons.photo_library, size: 36, color: coral.withValues(alpha: 0.5)),
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                _bcActionChip('Zoom In', Icons.zoom_in, coral),
                const SizedBox(width: 4),
                _bcActionChip('Rotate', Icons.rotate_right, salmon),
                const SizedBox(width: 4),
                _bcActionChip('Share', Icons.share, deepCoral),
                const SizedBox(width: 4),
                _bcActionChip('Info', Icons.info_outline, sienna),
              ],
            ),
            const SizedBox(height: 6),
            Text('Browser "Save Image As" disabled → protects content',
                style: TextStyle(fontSize: 10, color: darkCoral)),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: ContextMenuController integration ━━━━━━
  print('[bc-07] Section 7: ContextMenuController');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bcBanner('07', 'Integration with ContextMenuController'),
      bcNote(
        'Flutter\'s ContextMenuController manages custom context menu overlays. '
        'When combined with BrowserContextMenu.disableContextMenu(), you get '
        'full control: browser menu suppressed, Flutter menu shown instead.',
      ),
      bcCard(
        'Integration Pattern',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bcFlow(['Disable browser menu', 'Listen right-click',
                'Show ContextMenu', 'Handle action', 'Dismiss']),
            const SizedBox(height: 12),
            bcRow(['Component', 'Role', 'Layer'], isHeader: true),
            bcRow(['BrowserContextMenu', 'Suppress native menu', 'Platform']),
            bcRow(['GestureDetector', 'Capture right-click', 'Widget']),
            bcRow(['ContextMenuController', 'Show/hide overlay', 'Widget']),
            bcRow(['ContextMenuButtonItem', 'Menu item data', 'Model']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: Right-click gesture handling ━━━━━━
  print('[bc-08] Section 8: Right-click gestures');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bcBanner('08', 'Right-Click Gesture Handling'),
      bcNote(
        'Once the browser menu is disabled, you need to capture right-click '
        'events. Use onSecondaryTapDown on GestureDetector or Listener\'s '
        'onPointerDown with button check.',
      ),
      bcCard(
        'Gesture Approaches',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bcCode('GestureDetector.onSecondaryTapDown',
                'Simplest approach — fires on right-click with position'),
            bcCode('GestureDetector.onSecondaryTapUp',
                'Same but fires on release, with position'),
            bcCode('Listener.onPointerDown',
                'Low-level — check event.buttons for secondary button'),
            bcCode('ContextMenuRegion',
                'Higher-level wrapper for complete context menu flow'),
          ],
        ),
      ),
      bcCard(
        'Event Flow',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bcEventStep(1, 'Right-click detected', 'Browser event fires', coral),
            _bcEventStep(2, 'Browser menu suppressed', 'preventDefault() called', deepCoral),
            _bcEventStep(3, 'Flutter event fires', 'onSecondaryTapDown(details)', salmon),
            _bcEventStep(4, 'Position captured', 'details.globalPosition', sienna),
            _bcEventStep(5, 'Custom menu shown', 'ContextMenuController.show()', darkCoral),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: Mobile long-press ━━━━━━
  print('[bc-09] Section 9: Mobile long-press');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bcBanner('09', 'Mobile Browser Long-Press'),
      bcNote(
        'On mobile browsers, long-press triggers the browser\'s context menu. '
        'BrowserContextMenu.disableContextMenu() also suppresses this. '
        'You can then show a custom long-press menu using GestureDetector.',
      ),
      bcCard(
        'Mobile vs Desktop Triggers',
        Column(
          children: [
            bcRow(['Platform', 'Trigger', 'Default Action'], isHeader: true),
            bcRow(['Desktop Chrome', 'Right-click', 'Browser context menu']),
            bcRow(['Desktop Firefox', 'Right-click', 'Browser context menu']),
            bcRow(['Mobile Chrome', 'Long-press', 'Copy/Share/Select']),
            bcRow(['Mobile Safari', 'Long-press', 'Preview/Copy/Share']),
            bcRow(['iPad Safari', 'Long-press / Ctrl-click', 'Callout menu']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: Accessibility ━━━━━━
  print('[bc-10] Section 10: Accessibility');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bcBanner('10', 'Accessibility Implications'),
      bcNote(
        'Disabling the browser context menu removes access to browser-provided '
        'accessibility features like text-to-speech, dictionary lookup, and '
        'translation. Custom menus should replicate essential functionality.',
      ),
      bcCard(
        'Accessibility Checklist',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bcA11yItem('Copy/Paste',
                'Must provide in custom menu', Icons.copy, true),
            _bcA11yItem('Select All',
                'Common keyboard shortcut still works', Icons.select_all, true),
            _bcA11yItem('Spell Check',
                'Browser spell check may be lost', Icons.spellcheck, false),
            _bcA11yItem('Translate',
                'Browser translate feature lost', Icons.translate, false),
            _bcA11yItem('Inspect',
                'Devs can use F12 instead', Icons.code, true),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: Hybrid approach ━━━━━━
  print('[bc-11] Section 11: Hybrid approach');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bcBanner('11', 'Hybrid Approach — Selective Disabling'),
      bcNote(
        'You don\'t have to disable the browser menu globally. Disable it '
        'only for specific widgets (canvas, editor) and let it work normally '
        'elsewhere. Toggle with enable/disable around focus changes.',
      ),
      bcCard(
        'Selective Strategy',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: paleSalmon.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            children: [
                              Text('Normal Area',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF2E7D32))),
                              Text('Browser menu OK',
                                  style: TextStyle(fontSize: 9,
                                      color: const Color(0xFF388E3C))),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFEBEE),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            children: [
                              Text('Editor Area',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFFC62828))),
                              Text('Custom menu',
                                  style: TextStyle(fontSize: 9,
                                      color: const Color(0xFFD32F2F))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text('FocusNode.addListener → toggle browser menu on focus change',
                      style: TextStyle(fontSize: 10, color: darkCoral)),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: SelectionArea integration ━━━━━━
  print('[bc-12] Section 12: SelectionArea');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bcBanner('12', 'SelectionArea & Text Selection on Web'),
      bcNote(
        'Flutter\'s SelectionArea widget provides text selection with a '
        'built-in context menu. On web, it automatically manages the browser '
        'context menu — disabling the native one and showing Flutter\'s. '
        'This is the recommended approach for text-heavy content.',
      ),
      bcCard(
        'SelectionArea Behavior',
        Column(
          children: [
            bcRow(['Widget', 'Browser Menu', 'Custom Menu'], isHeader: true),
            bcRow(['SelectionArea', 'Auto-disabled', 'Built-in Flutter']),
            bcRow(['SelectableText', 'Needs manual disable', 'Via contextMenuBuilder']),
            bcRow(['TextField', 'Auto-managed', 'Built-in edit menu']),
            bcRow(['Plain Text widget', 'Browser default', 'Need manual setup']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: Security considerations ━━━━━━
  print('[bc-13] Section 13: Security');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bcBanner('13', 'Security & Content Protection'),
      bcNote(
        'Disabling the context menu is NOT a security measure. Users can still '
        'access content via DevTools, keyboard shortcuts, or JavaScript console. '
        'It\'s a UX improvement, not a DRM solution.',
      ),
      bcCard(
        'What It Does / Does Not Protect',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bcSecurityRow('Right-click save image', true, 'Prevented'),
            _bcSecurityRow('DevTools access', false, 'Still possible (F12)'),
            _bcSecurityRow('Ctrl+S / Cmd+S', false, 'Browser save still works'),
            _bcSecurityRow('View source', false, 'Always available'),
            _bcSecurityRow('Screenshot', false, 'OS-level, not preventable'),
            _bcSecurityRow('Accidental right-click', true, 'Better UX'),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: Browser differences ━━━━━━
  print('[bc-14] Section 14: Browser differences');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bcBanner('14', 'Browser-Specific Differences'),
      bcNote(
        'Different browsers have slightly different context menu behavior '
        'and respect for preventDefault(). Most modern browsers honor it, '
        'but some settings or extensions can override.',
      ),
      bcCard(
        'Browser Compatibility',
        Column(
          children: [
            bcRow(['Browser', 'DisableMenu', 'Notes'], isHeader: true),
            bcRow(['Chrome', 'Full support', 'Most reliable']),
            bcRow(['Firefox', 'Full support', 'User can override in settings']),
            bcRow(['Safari', 'Full support', 'Including iPad/iPhone']),
            bcRow(['Edge', 'Full support', 'Chromium-based']),
            bcRow(['Brave', 'Full support', 'May block some scripts']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Testing ━━━━━━
  print('[bc-15] Section 15: Testing');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bcBanner('15', 'Testing Context Menu Behavior'),
      bcNote(
        'Testing browser context menu suppression requires web-specific '
        'integration tests. Widget tests cannot simulate browser events. '
        'Use Flutter web integration test driver for verification.',
      ),
      bcCard(
        'Test Strategies',
        Column(
          children: [
            bcRow(['Test Type', 'Can Test', 'How'], isHeader: true),
            bcRow(['Widget test', 'API calls', 'Verify disable/enable called']),
            bcRow(['Integration', 'Full behavior', 'Web driver + right-click']),
            bcRow(['Manual', 'Visual check', 'Right-click in browser']),
            bcRow(['Unit', 'State tracking', 'Mock BrowserContextMenu']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[bc-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      bcBanner('16', 'Summary Dashboard'),
      bcCard(
        'BrowserContextMenu — Complete',
        Column(
          children: [
            bcRow(['Topic', 'Section', 'Insight'], isHeader: true),
            bcRow(['What', 'S01', 'Controls browser right-click menu']),
            bcRow(['API', 'S02', 'disable/enable/enabled']),
            bcRow(['Platform', 'S03', 'Web-only, no-op elsewhere']),
            bcRow(['Editor', 'S04', 'Custom formatting menu']),
            bcRow(['Canvas', 'S05', 'Drawing tool actions']),
            bcRow(['Gallery', 'S06', 'Prevent save, add zoom/rotate']),
            bcRow(['Controller', 'S07', 'ContextMenuController integration']),
            bcRow(['Gestures', 'S08', 'secondary tap, pointer down']),
            bcRow(['Mobile', 'S09', 'Long-press suppression']),
            bcRow(['A11y', 'S10', 'Must replicate lost features']),
            bcRow(['Hybrid', 'S11', 'Selective per-widget disable']),
            bcRow(['Selection', 'S12', 'SelectionArea auto-manages']),
            bcRow(['Security', 'S13', 'UX only, not DRM']),
            bcRow(['Browsers', 'S14', 'All modern browsers supported']),
            bcRow(['Testing', 'S15', 'Web integration tests needed']),
          ],
        ),
      ),
      bcCard(
        'Coral / Salmon Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _bcColorSwatch('Coral', coral),
            _bcColorSwatch('Salmon', salmon),
            _bcColorSwatch('Deep', deepCoral),
            _bcColorSwatch('Sienna', sienna),
            _bcColorSwatch('Dark', darkCoral),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [darkCoral, deepCoral],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('BrowserContextMenu — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'From disabling the browser menu through rich text editors, '
              'canvas apps, gallery viewers, accessibility, hybrid approaches, '
              'and browser compatibility — the full web context menu story.',
              style: TextStyle(color: peach, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[bc] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('BrowserContextMenu — Web Menus'),
        backgroundColor: darkCoral,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFFFF8F6),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            section1, section2, section3, section4,
            section5, section6, section7, section8,
            section9, section10, section11, section12,
            section13, section14, section15, section16,
          ],
        ),
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════
// Top-level helpers
// ═══════════════════════════════════════════════════

Widget _bcMenuItem(String label, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 3),
    child: Row(
      children: [
        Icon(icon, size: 13, color: color),
        const SizedBox(width: 6),
        Text(label,
            style: TextStyle(fontSize: 11, color: color)),
      ],
    ),
  );
}

Widget _bcCustomItem(String label, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
    child: Row(
      children: [
        Icon(icon, size: 15, color: color),
        const SizedBox(width: 8),
        Text(label,
            style: TextStyle(fontSize: 12, color: color)),
      ],
    ),
  );
}

Widget _bcPlatformBadge(String name, bool active, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: active
          ? color.withValues(alpha: 0.1)
          : const Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(
        color: active ? color : const Color(0xFFE0E0E0),
      ),
    ),
    child: Column(
      children: [
        Text(name,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: active ? color : const Color(0xFF9E9E9E))),
        Text(active ? 'Active' : 'No-op',
            style: TextStyle(
                fontSize: 8,
                color: active ? color : const Color(0xFFBDBDBD))),
      ],
    ),
  );
}

Widget _bcActionChip(String label, IconData icon, Color color) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(height: 2),
          Text(label,
              style: TextStyle(fontSize: 8, color: color)),
        ],
      ),
    ),
  );
}

Widget _bcEventStep(int num, String title, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text('$num',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: color)),
              Text(desc,
                  style: const TextStyle(
                      fontSize: 10, color: Color(0xFF8B3A2A))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _bcA11yItem(String feature, String note, IconData icon, bool ok) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Icon(icon, size: 16,
            color: ok ? const Color(0xFF4CAF50) : const Color(0xFFE53935)),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(feature,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF8B3A2A))),
              Text(note,
                  style: const TextStyle(
                      fontSize: 10, color: Color(0xFFCD5B45))),
            ],
          ),
        ),
        Text(ok ? '✓' : '⚠',
            style: TextStyle(
                fontSize: 14,
                color: ok ? const Color(0xFF4CAF50) : const Color(0xFFE53935))),
      ],
    ),
  );
}

Widget _bcSecurityRow(String item, bool blocked, String note) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Icon(
          blocked ? Icons.shield : Icons.shield_outlined,
          size: 14,
          color: blocked ? const Color(0xFF4CAF50) : const Color(0xFFE53935),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(item,
              style: const TextStyle(fontSize: 11, color: Color(0xFF8B3A2A))),
        ),
        Text(note,
            style: TextStyle(
                fontSize: 10,
                color: blocked ? const Color(0xFF2E7D32) : const Color(0xFFC62828))),
      ],
    ),
  );
}

Widget _bcColorSwatch(String name, Color color) {
  return Column(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
      const SizedBox(height: 3),
      Text(name, style: const TextStyle(fontSize: 8)),
    ],
  );
}
