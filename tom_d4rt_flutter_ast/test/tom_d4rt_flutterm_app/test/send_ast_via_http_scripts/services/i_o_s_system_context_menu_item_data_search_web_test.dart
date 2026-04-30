// ignore_for_file: avoid_print
// Deep demo: IOSSystemContextMenuItemDataSearchWeb — iOS search-web context menu
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// Color palette: Rose Gold / Soft Pink
// ─────────────────────────────────────────────────────────────
const Color _swRoseGold = Color(0xFFAD1457);
const Color _swSoftPink = Color(0xFFFCE4EC);
const Color _swDeepPink = Color(0xFF880E4F);
const Color _swMedRose = Color(0xFFC2185B);
const Color _swLightRose = Color(0xFFF8BBD0);
const Color _swWhite = Color(0xFFFFFFFF);
const Color _swGray = Color(0xFF616161);
const Color _swDarkGray = Color(0xFF37474F);
const Color _swAppleBlue = Color(0xFF007AFF);
const Color _swSystemTeal = Color(0xFF00BCD4);

// ─────────────────────────────────────────────────────────────
// Helper builders
// ─────────────────────────────────────────────────────────────
Widget _swSection(String title, List<Widget> children) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _swWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _swLightRose, width: 1.5),
      boxShadow: const [
        BoxShadow(color: Color(0x1A000000), blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _swRoseGold,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(title,
              style: const TextStyle(
                  color: _swWhite, fontSize: 15, fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

Widget _swLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text,
        style: const TextStyle(
            color: _swDeepPink, fontSize: 13, fontWeight: FontWeight.w600)),
  );
}

Widget _swBody(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(color: _swGray, fontSize: 12.5, height: 1.5)),
  );
}

Widget _swChip(String label, Color color) {
  return Container(
    margin: const EdgeInsets.only(right: 6, bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Text(label,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
  );
}

Widget _swInfoRow(String key, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(key,
              style: const TextStyle(
                  color: _swDeepPink, fontSize: 12, fontWeight: FontWeight.w600)),
        ),
        Expanded(
          child: Text(value,
              style: const TextStyle(color: _swGray, fontSize: 12)),
        ),
      ],
    ),
  );
}

Widget _swDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    height: 1,
    color: _swLightRose.withValues(alpha: 0.5),
  );
}

// ─────────────────────────────────────────────────────────────
// Entry point
// ─────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('═══════════════════════════════════════════════════════');
  print('  IOSSystemContextMenuItemDataSearchWeb — Deep Demo');
  print('  iOS system context menu: search the web');
  print('═══════════════════════════════════════════════════════');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: _swSoftPink,
      appBarTheme: const AppBarTheme(
        backgroundColor: _swRoseGold,
        foregroundColor: _swWhite,
        elevation: 3,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('IOSSystemContextMenuItemDataSearchWeb'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            _buildBanner(),
            _buildWhatIsIt(),
            _buildIOSContextMenuArchitecture(),
            _buildSystemMenuItemCatalog(),
            _buildSearchWebSpecifics(),
            _buildSelectionToSearchPipeline(),
            _buildUIMenuHierarchy(),
            _buildContextMenuSimulation(),
            _buildPlatformComparison(),
            _buildLocalization(),
            _buildIntegrationWithFlutter(),
            _buildSummary(),
          ],
        ),
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 1 — Banner
// ═══════════════════════════════════════════════════════════════
Widget _buildBanner() {
  print('[Section 1] Banner');
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [_swRoseGold, _swMedRose],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(color: Color(0x40AD1457), blurRadius: 12, offset: Offset(0, 4)),
      ],
    ),
    child: Column(
      children: [
        const Icon(Icons.search, size: 52, color: _swWhite),
        const SizedBox(height: 12),
        const Text('IOSSystemContextMenuItemData\nSearchWeb',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: _swWhite, fontSize: 20, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            color: _swWhite.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'iOS System Context Menu · Search the Web',
            style: TextStyle(color: _swWhite, fontSize: 12),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _swChip('services', _swWhite),
            _swChip('iOS', _swWhite),
            _swChip('ContextMenu', _swWhite),
          ],
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 2 — What Is It?
// ═══════════════════════════════════════════════════════════════
Widget _buildWhatIsIt() {
  print('[Section 2] What is IOSSystemContextMenuItemDataSearchWeb?');
  return _swSection('What Is It?', [
    _swBody(
      'IOSSystemContextMenuItemDataSearchWeb is a data class that represents '
      'the "Search Web" item in the iOS system context menu. When the user '
      'selects text in a TextField or SelectableText and long-presses, iOS '
      'shows a context menu with system-provided items. "Search Web" is one '
      'of those built-in items.',
    ),
    _swDivider(),
    _swLabel('Class Hierarchy'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _swSoftPink,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _swBody('IOSSystemContextMenuItemData  (abstract base)'),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: _swBody('├─ IOSSystemContextMenuItemDataCopy'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: _swBody('├─ IOSSystemContextMenuItemDataCut'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: _swBody('├─ IOSSystemContextMenuItemDataPaste'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: _swBody('├─ IOSSystemContextMenuItemDataSelectAll'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: _swBody('├─ IOSSystemContextMenuItemDataSearchWeb  ◄'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: _swBody('├─ IOSSystemContextMenuItemDataShare'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: _swBody('└─ IOSSystemContextMenuItemDataLookUp'),
          ),
        ],
      ),
    ),
    _swDivider(),
    _swBody(
      'This class is part of the Flutter services layer that bridges '
      'the gap between Flutter\'s cross-platform text editing and iOS\'s '
      'native UIMenuController system context menu items.',
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 3 — iOS Context Menu Architecture
// ═══════════════════════════════════════════════════════════════
Widget _buildIOSContextMenuArchitecture() {
  print('[Section 3] iOS context menu architecture');

  Widget archLayer(String label, String detail, Color color, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                        color: color, fontSize: 13, fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(detail,
                    style: const TextStyle(color: _swGray, fontSize: 11.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  return _swSection('iOS Context Menu Architecture', [
    _swBody(
      'On iOS, the system context menu is managed by UIMenuController (iOS 13–15) '
      'and UIEditMenuInteraction (iOS 16+). Flutter integrates with both APIs to '
      'provide native-feeling text editing menus.',
    ),
    _swDivider(),
    archLayer('UIEditMenuInteraction',
        'iOS 16+ API: modern menu presentation with configuration blocks',
        _swAppleBlue, Icons.edit),
    archLayer('UIMenuController',
        'Legacy API (iOS 13–15): global singleton that shows/hides context menus',
        _swSystemTeal, Icons.menu_open),
    archLayer('UIMenuElement / UIAction',
        'Individual menu items with title, image, and action handler',
        _swMedRose, Icons.touch_app),
    archLayer('Flutter SystemContextMenu',
        'Flutter widget that requests the native iOS system context menu via platform channels',
        _swRoseGold, Icons.widgets),
    _swDivider(),
    _swLabel('How Flutter Requests the System Menu'),
    _swBody(
      '1. User long-presses selected text in a Flutter TextField\n'
      '2. Flutter sends a "show system context menu" message to the platform\n'
      '3. iOS creates a UIEditMenuInteraction with the available actions\n'
      '4. The system menu appears with Cut, Copy, Paste, Search Web, etc.\n'
      '5. When user taps an action, the platform sends back the action ID\n'
      '6. Flutter receives the callback and processes the action',
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 4 — System Menu Item Catalog
// ═══════════════════════════════════════════════════════════════
Widget _buildSystemMenuItemCatalog() {
  print('[Section 4] System context menu item catalog');

  Widget menuItem(String title, IconData icon, Color color, String description,
      {bool isHighlighted = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isHighlighted ? color.withValues(alpha: 0.12) : _swWhite,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isHighlighted ? color : _swLightRose,
          width: isHighlighted ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(title,
                        style: TextStyle(
                            color: color,
                            fontSize: 13,
                            fontWeight: FontWeight.w700)),
                    if (isHighlighted) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text('THIS DEMO',
                            style: TextStyle(
                                color: _swWhite,
                                fontSize: 9,
                                fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(description,
                    style: const TextStyle(color: _swGray, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  return _swSection('System Context Menu Items', [
    _swBody(
      'iOS provides a set of built-in context menu items for text editing. '
      'Flutter wraps each as an IOSSystemContextMenuItemData subclass:',
    ),
    _swDivider(),
    menuItem('Cut', Icons.content_cut, _swDarkGray,
        'Removes selected text and places it on the clipboard'),
    menuItem('Copy', Icons.copy, _swDarkGray,
        'Places selected text on the clipboard'),
    menuItem('Paste', Icons.paste, _swDarkGray,
        'Inserts clipboard content at the cursor position'),
    menuItem('Select All', Icons.select_all, _swDarkGray,
        'Selects all text in the current field'),
    menuItem('Search Web', Icons.search, _swRoseGold,
        'Opens Safari search for the selected text',
        isHighlighted: true),
    menuItem('Share...', Icons.share, _swAppleBlue,
        'Opens the iOS share sheet for the selected text'),
    menuItem('Look Up', Icons.auto_stories, _swSystemTeal,
        'Opens the iOS dictionary/Wikipedia look-up for selected text'),
    _swDivider(),
    _swBody(
      'Not all items appear in every context. The system decides which items '
      'are relevant based on the current selection state and text field '
      'capabilities (read-only vs editable, has selection vs no selection).',
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 5 — Search Web Specifics
// ═══════════════════════════════════════════════════════════════
Widget _buildSearchWebSpecifics() {
  print('[Section 5] SearchWeb specifics');
  return _swSection('Search Web — Details', [
    _swBody(
      'The "Search Web" menu item is specifically designed to take selected '
      'text and perform a web search using the user\'s default browser '
      '(typically Safari on iOS). This is handled entirely by the OS.',
    ),
    _swDivider(),
    _swLabel('Properties'),
    _swInfoRow('type', 'IOSSystemContextMenuItemType.searchWeb'),
    _swInfoRow('availability', 'Requires text selection (not empty)'),
    _swInfoRow('handler', 'System-managed — opens Safari with search query'),
    _swInfoRow('localization', 'Automatically localized by iOS to device language'),
    _swInfoRow('icon', 'SF Symbol: magnifyingglass (system-provided)'),
    _swDivider(),
    _swLabel('When Does It Appear?'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _swSoftPink,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildConditionRow(true, 'Text is selected in the field'),
          _buildConditionRow(true, 'Device has web browser capability'),
          _buildConditionRow(true, 'System context menu is requested (not custom)'),
          _buildConditionRow(false, 'No text is selected (cursor only)'),
          _buildConditionRow(false, 'Custom menu explicitly excludes it'),
          _buildConditionRow(false, 'iOS version < 13'),
        ],
      ),
    ),
    _swDivider(),
    _swLabel('URL Construction'),
    _swBody(
      'When the user taps "Search Web", iOS constructs a search URL:\n\n'
      '  https://www.google.com/search?q=<selected_text>\n\n'
      'The exact search engine depends on the user\'s Safari settings. '
      'The selected text is URL-encoded before being appended to the query.',
    ),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _swAppleBlue.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _swAppleBlue.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.travel_explore, size: 24, color: _swAppleBlue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Search Engine Integration',
                    style: TextStyle(
                        color: _swAppleBlue,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                _swBody(
                  'Google (default), Bing, Yahoo, DuckDuckGo, Ecosia — '
                  'depends on Settings → Safari → Search Engine',
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ]);
}

Widget _buildConditionRow(bool met, String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Icon(
          met ? Icons.check_circle : Icons.cancel,
          size: 16,
          color: met ? const Color(0xFF43A047) : const Color(0xFFE53935),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text,
              style: TextStyle(
                color: met ? const Color(0xFF43A047) : const Color(0xFFE53935),
                fontSize: 12,
              )),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 6 — Selection to Search Pipeline
// ═══════════════════════════════════════════════════════════════
Widget _buildSelectionToSearchPipeline() {
  print('[Section 6] Selection to search pipeline');

  Widget pipeStep(int step, String label, String detail, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text('$step',
                  style: const TextStyle(
                      color: _swWhite, fontSize: 14, fontWeight: FontWeight.w800)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                        color: color, fontSize: 13, fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(detail,
                    style: const TextStyle(color: _swGray, fontSize: 11.5)),
              ],
            ),
          ),
          Icon(icon, size: 20, color: color.withValues(alpha: 0.5)),
        ],
      ),
    );
  }

  return _swSection('Selection → Search Pipeline', [
    _swBody(
      'The journey from text selection to web search involves multiple '
      'layers across Flutter and iOS:',
    ),
    _swDivider(),
    pipeStep(1, 'User selects text',
        'Double-tap or drag handles to select text in EditableText',
        Icons.text_fields, _swRoseGold),
    Container(
      margin: const EdgeInsets.only(left: 18, bottom: 6),
      height: 16,
      width: 2,
      color: _swLightRose,
    ),
    pipeStep(2, 'Long-press shows menu',
        'Flutter sends SystemContextMenu.show() via platform channel',
        Icons.menu, _swMedRose),
    Container(
      margin: const EdgeInsets.only(left: 18, bottom: 6),
      height: 16,
      width: 2,
      color: _swLightRose,
    ),
    pipeStep(3, 'iOS presents UIEditMenuInteraction',
        'System creates menu with applicable items based on selection',
        Icons.phone_iphone, _swAppleBlue),
    Container(
      margin: const EdgeInsets.only(left: 18, bottom: 6),
      height: 16,
      width: 2,
      color: _swLightRose,
    ),
    pipeStep(4, 'User taps "Search Web"',
        'iOS captures the action and reads selected text from the first responder',
        Icons.touch_app, _swSystemTeal),
    Container(
      margin: const EdgeInsets.only(left: 18, bottom: 6),
      height: 16,
      width: 2,
      color: _swLightRose,
    ),
    pipeStep(5, 'Safari opens with search',
        'iOS opens Safari (or in-app SFSafariViewController) with the query',
        Icons.open_in_browser, const Color(0xFF43A047)),
    _swDivider(),
    _swBody(
      'Flutter\'s role is to request the system menu and process any callbacks '
      'that come back. The "Search Web" action is entirely handled by iOS and '
      'does not send any callback to Flutter — the app simply opens Safari.',
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 7 — UIMenu Hierarchy
// ═══════════════════════════════════════════════════════════════
Widget _buildUIMenuHierarchy() {
  print('[Section 7] UIMenu hierarchy visualization');
  return _swSection('iOS UIMenu Hierarchy', [
    _swBody(
      'iOS organizes context menu items in a UIMenu hierarchy. Flutter maps '
      'the IOSSystemContextMenuItemData types to this hierarchy:',
    ),
    _swDivider(),
    // Visual tree
    Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _swSoftPink,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMenuTreeItem('UIMenu (root)', Icons.folder_open, _swDeepPink, 0),
          _buildMenuTreeItem('UIMenu: "Edit"', Icons.folder, _swMedRose, 1),
          _buildMenuTreeItem('UIAction: "Cut"', Icons.content_cut, _swDarkGray, 2),
          _buildMenuTreeItem('UIAction: "Copy"', Icons.copy, _swDarkGray, 2),
          _buildMenuTreeItem('UIAction: "Paste"', Icons.paste, _swDarkGray, 2),
          _buildMenuTreeItem('UIAction: "Select All"', Icons.select_all, _swDarkGray, 2),
          _buildMenuTreeItem('UIMenu: "Learn"', Icons.folder, _swMedRose, 1),
          _buildMenuTreeItem('UIAction: "Look Up"', Icons.auto_stories, _swSystemTeal, 2),
          _buildMenuTreeItem('UIAction: "Search Web" ★', Icons.search, _swRoseGold, 2,
              isHighlighted: true),
          _buildMenuTreeItem('UIMenu: "Share"', Icons.folder, _swMedRose, 1),
          _buildMenuTreeItem('UIAction: "Share..."', Icons.share, _swAppleBlue, 2),
        ],
      ),
    ),
    _swDivider(),
    _swBody(
      '"Search Web" lives in the "Learn" submenu alongside "Look Up". '
      'On iOS, these menus are presented as a flat list unless there are '
      'too many items, in which case submenus appear as expandable groups.',
    ),
    _swLabel('Menu Presentation Styles'),
    _swInfoRow('Compact', 'Horizontal pill bar above/below selection (default)'),
    _swInfoRow('Expanded', 'When more items than fit in compact view'),
    _swInfoRow('Contextual', 'With preview when 3D Touch / Haptic Touch is used'),
  ]);
}

Widget _buildMenuTreeItem(String label, IconData icon, Color color, int indent,
    {bool isHighlighted = false}) {
  return Padding(
    padding: EdgeInsets.only(left: indent * 20.0, bottom: 4),
    child: Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 6),
        if (isHighlighted)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: color),
            ),
            child: Text(label,
                style: TextStyle(
                    color: color, fontSize: 12, fontWeight: FontWeight.w700)),
          )
        else
          Text(label,
              style: TextStyle(color: color, fontSize: 12)),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 8 — Context Menu Simulation
// ═══════════════════════════════════════════════════════════════
Widget _buildContextMenuSimulation() {
  print('[Section 8] Simulated iOS context menu');
  return _swSection('Context Menu Simulation', [
    _swBody(
      'Below is a visual simulation of how the iOS system context menu '
      'appears when text is selected in a Flutter text field:',
    ),
    _swDivider(),
    // Simulated text field with selected text
    Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _swDarkGray.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // iOS-style context menu bubble
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2E),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x40000000),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildMenuButton('Cut', false),
                  _buildMenuSeparator(),
                  _buildMenuButton('Copy', false),
                  _buildMenuSeparator(),
                  _buildMenuButton('Paste', false),
                  _buildMenuSeparator(),
                  _buildMenuButton('Search Web', true),
                  _buildMenuSeparator(),
                  _buildMenuButton('▶', false),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Caret pointer
          Center(
            child: CustomPaint(
              size: const Size(16, 8),
              painter: _CaretPainter(),
            ),
          ),
          const SizedBox(height: 4),
          // Text with selection highlight
          RichText(
            text: TextSpan(
              style: const TextStyle(color: _swDarkGray, fontSize: 15, height: 1.6),
              children: [
                const TextSpan(text: 'The quick brown fox '),
                TextSpan(
                  text: 'jumps over',
                  style: TextStyle(
                    backgroundColor: _swAppleBlue.withValues(alpha: 0.25),
                    color: _swDarkGray,
                  ),
                ),
                const TextSpan(text: ' the lazy dog. '),
                const TextSpan(
                    text: 'This is a sample text field demonstrating '
                        'iOS text selection with system context menu.'),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Selection handles
          Row(
            children: [
              const SizedBox(width: 130),
              Container(
                width: 2,
                height: 20,
                color: _swAppleBlue,
              ),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: _swAppleBlue,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 62),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: _swAppleBlue,
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 2,
                height: 20,
                color: _swAppleBlue,
              ),
            ],
          ),
        ],
      ),
    ),
    _swDivider(),
    _swBody(
      'The dark bubble above the selected text is the iOS-style compact menu. '
      '"Search Web" is highlighted as the item this demo focuses on. The blue '
      'selection handles and highlight show the selected "jumps over" text that '
      'would be sent as the search query.',
    ),
    // What happens when tapped
    _swLabel('After Tapping "Search Web"'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _swAppleBlue.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _swAppleBlue.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.open_in_browser, size: 20, color: _swAppleBlue),
              const SizedBox(width: 8),
              const Expanded(
                child: Text('Safari opens with: "jumps over" search',
                    style: TextStyle(
                        color: _swAppleBlue,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _swWhite,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _swAppleBlue.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                const Icon(Icons.lock, size: 12, color: Color(0xFF43A047)),
                const SizedBox(width: 4),
                const Expanded(
                  child: Text(
                    'google.com/search?q=jumps+over',
                    style: TextStyle(color: _swGray, fontSize: 11),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ]);
}

Widget _buildMenuButton(String label, bool highlighted) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: highlighted ? _swAppleBlue.withValues(alpha: 0.3) : Colors.transparent,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(label,
        style: TextStyle(
          color: highlighted ? _swWhite : const Color(0xFFE5E5EA),
          fontSize: 13,
          fontWeight: highlighted ? FontWeight.w700 : FontWeight.w500,
        )),
  );
}

Widget _buildMenuSeparator() {
  return Container(
    width: 1,
    height: 24,
    color: const Color(0xFF48484A),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 9 — Platform Comparison
// ═══════════════════════════════════════════════════════════════
Widget _buildPlatformComparison() {
  print('[Section 9] Platform comparison');
  return _swSection('Platform Comparison', [
    _swBody(
      'Context menu behavior differs significantly across platforms. '
      '"Search Web" is iOS-specific — other platforms handle text search '
      'differently:',
    ),
    _swDivider(),
    // Comparison cards
    _buildPlatformCard(
      'iOS',
      Icons.phone_iphone,
      _swRoseGold,
      [
        'Built-in "Search Web" in system menu',
        'Opens Safari with selected text',
        'Localized by the OS automatically',
        'Part of UIEditMenuInteraction',
      ],
    ),
    _buildPlatformCard(
      'Android',
      Icons.android,
      const Color(0xFF43A047),
      [
        'No exact equivalent to "Search Web"',
        '"Web Search" via PROCESS_TEXT intent',
        'Third-party apps can register as handlers',
        'Uses ActionMode with floating toolbar',
      ],
    ),
    _buildPlatformCard(
      'macOS',
      Icons.laptop_mac,
      _swDarkGray,
      [
        '"Search with Google" in right-click menu',
        'Opens default browser, not necessarily Safari',
        'NSTextView provides built-in search action',
        'Keyboard shortcut: ⌘⇧L for Look Up',
      ],
    ),
    _buildPlatformCard(
      'Web',
      Icons.public,
      _swAppleBlue,
      [
        'No system context menu item for search',
        'Browser provides its own right-click menu',
        'Flutter Web uses custom context menus',
        'Search functionality must be implemented manually',
      ],
    ),
    _buildPlatformCard(
      'Windows / Linux',
      Icons.desktop_windows,
      _swSystemTeal,
      [
        'No built-in "Search Web" in text menus',
        'Applications implement their own search',
        'System clipboard can be used to search manually',
        'Some desktop environments have search shortcuts',
      ],
    ),
  ]);
}

Widget _buildPlatformCard(
    String platform, IconData icon, Color color, List<String> features) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 8),
          Text(platform,
              style: TextStyle(
                  color: color, fontSize: 14, fontWeight: FontWeight.w700)),
        ]),
        const SizedBox(height: 8),
        ...features.map((f) => Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• ',
                      style: TextStyle(color: color, fontSize: 12)),
                  Expanded(
                    child: Text(f,
                        style: const TextStyle(color: _swGray, fontSize: 11.5)),
                  ),
                ],
              ),
            )),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 10 — Localization
// ═══════════════════════════════════════════════════════════════
Widget _buildLocalization() {
  print('[Section 10] Localization of Search Web');
  return _swSection('Localization', [
    _swBody(
      'The "Search Web" label is provided by iOS and is automatically '
      'localized to the device language. Flutter does not need to provide '
      'translations — the system handles it.',
    ),
    _swDivider(),
    _swLabel('Label in Different Languages'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _swSoftPink,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildLocaleRow('🇺🇸', 'English', 'Search Web'),
          _buildLocaleRow('🇩🇪', 'Deutsch', 'Im Web suchen'),
          _buildLocaleRow('🇫🇷', 'Français', 'Rechercher sur le Web'),
          _buildLocaleRow('🇪🇸', 'Español', 'Buscar en la web'),
          _buildLocaleRow('🇯🇵', '日本語', 'Webを検索'),
          _buildLocaleRow('🇨🇳', '中文', '搜索网页'),
          _buildLocaleRow('🇰🇷', '한국어', '웹에서 검색'),
          _buildLocaleRow('🇵🇹', 'Português', 'Pesquisar na Web'),
          _buildLocaleRow('🇮🇹', 'Italiano', 'Cerca sul web'),
          _buildLocaleRow('🇷🇺', 'Русский', 'Найти в интернете'),
        ],
      ),
    ),
    _swDivider(),
    _swBody(
      'Since this is a system-provided string, Flutter developers do not '
      'need to add l10n entries for this text. The OS provides the correct '
      'translation automatically based on the device locale settings.',
    ),
  ]);
}

Widget _buildLocaleRow(String flag, String language, String label) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Text(flag, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 10),
        SizedBox(
          width: 80,
          child: Text(language,
              style: const TextStyle(color: _swGray, fontSize: 12)),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _swWhite,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: _swLightRose),
            ),
            child: Text(label,
                style: const TextStyle(
                    color: _swDeepPink,
                    fontSize: 12,
                    fontWeight: FontWeight.w500)),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════
// Section 11 — Integration with Flutter
// ═══════════════════════════════════════════════════════════════
Widget _buildIntegrationWithFlutter() {
  print('[Section 11] Integration with Flutter widgets');
  return _swSection('Integration with Flutter', [
    _swBody(
      'Flutter widgets that support the system context menu include TextField, '
      'SelectableText, and CupertinoTextField. The SearchWeb item is included '
      'when using the system context menu on iOS.',
    ),
    _swDivider(),
    _swLabel('Widgets That Support System Menu'),
    // Widget cards
    Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _swRoseGold.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _swRoseGold.withValues(alpha: 0.2)),
              ),
              child: Column(
                children: [
                  const Icon(Icons.text_fields, size: 28, color: _swRoseGold),
                  const SizedBox(height: 6),
                  const Text('TextField',
                      style: TextStyle(
                          color: _swRoseGold,
                          fontSize: 12,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  _swBody('Material text input.\nFull edit capabilities.\nSystem menu on long-press.'),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _swAppleBlue.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _swAppleBlue.withValues(alpha: 0.2)),
              ),
              child: Column(
                children: [
                  const Icon(Icons.text_snippet, size: 28, color: _swAppleBlue),
                  const SizedBox(height: 6),
                  const Text('SelectableText',
                      style: TextStyle(
                          color: _swAppleBlue,
                          fontSize: 12,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  _swBody('Read-only selection.\nNo edit items shown.\nSearch Web appears.'),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _swSystemTeal.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _swSystemTeal.withValues(alpha: 0.2)),
              ),
              child: Column(
                children: [
                  const Icon(Icons.phone_iphone, size: 28, color: _swSystemTeal),
                  const SizedBox(height: 6),
                  const Text('CupertinoTextField',
                      style: TextStyle(
                          color: _swSystemTeal,
                          fontSize: 12,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  _swBody('iOS-styled field.\nNative look & feel.\nFull system menu.'),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    _swDivider(),
    _swLabel('Controlling System Menu Items'),
    _swBody(
      'Developers can customize which system items appear by using '
      'contextMenuBuilder on TextField or SelectableText. However, '
      '"Search Web" can only be excluded by not requesting the system '
      'menu at all — individual system items cannot be filtered.',
    ),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _swSoftPink,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _swBody('// Using system context menu (includes Search Web):'),
          _swBody('SystemContextMenu.editableText(editableTextState: state)'),
          const SizedBox(height: 8),
          _swBody('// Custom menu (no Search Web):'),
          _swBody('AdaptiveTextSelectionToolbar.editableText('),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: _swBody('editableTextState: state,'),
          ),
          _swBody(')'),
        ],
      ),
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Section 12 — Summary
// ═══════════════════════════════════════════════════════════════
Widget _buildSummary() {
  print('[Section 12] Summary');
  print('IOSSystemContextMenuItemDataSearchWeb deep demo complete.');
  return _swSection('Summary', [
    _swBody(
      'IOSSystemContextMenuItemDataSearchWeb represents the "Search Web" '
      'action in the iOS system text editing context menu. It is one of '
      'several system-provided items that Flutter surfaces through the '
      'SystemContextMenu API on iOS.',
    ),
    _swDivider(),
    _swLabel('Key Takeaways'),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _swRoseGold.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _swBody('✦ iOS-specific system context menu item'),
          _swBody('✦ Opens Safari with selected text as search query'),
          _swBody('✦ Automatically localized by the OS'),
          _swBody('✦ Part of the IOSSystemContextMenuItemData hierarchy'),
          _swBody('✦ Appears in UIEditMenuInteraction (iOS 16+) and UIMenuController (legacy)'),
          _swBody('✦ Works with TextField, SelectableText, and CupertinoTextField'),
          _swBody('✦ No Flutter callback — action is handled entirely by iOS'),
          _swBody('✦ Cannot be individually filtered from the system menu'),
        ],
      ),
    ),
    _swDivider(),
    Wrap(
      children: [
        _swChip('iOS System Menu', _swRoseGold),
        _swChip('Search Web', _swMedRose),
        _swChip('UIEditMenuInteraction', _swAppleBlue),
        _swChip('Text Selection', _swSystemTeal),
        _swChip('Platform-Specific', _swDeepPink),
      ],
    ),
  ]);
}

// ═══════════════════════════════════════════════════════════════
// Custom painter — caret/arrow pointing down from context menu
// ═══════════════════════════════════════════════════════════════
class _CaretPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2C2C2E)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
