// ignore_for_file: avoid_print
// D4rt deep demo: IOSSystemContextMenuItemData — data model for iOS-native
// system context menu items (copy, paste, look up, share, etc.).
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Ruby / Garnet palette ───
  const Color ruby = Color(0xFF9B111E);
  const Color garnet = Color(0xFF733635);
  const Color deepRuby = Color(0xFF6D0A14);
  const Color paleRuby = Color(0xFFFFF5F5);
  const Color crimson = Color(0xFFDC143C);
  const Color rosewood = Color(0xFF65000B);
  const Color blush = Color(0xFFFFD6D6);
  const Color claret = Color(0xFF7F1734);
  const Color darkRuby = Color(0xFF4A0A0F);
  const Color warmGold = Color(0xFFB8860B);

  print('[io] ===== IOS SYSTEM CONTEXT MENU ITEM DATA DEEP DEMO =====');

  // ─── Local helpers ───

  Widget ioBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [darkRuby, deepRuby],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: darkRuby.withValues(alpha: 0.35),
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
              color: ruby,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: blush, width: 1.5),
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

  Widget ioNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paleRuby,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: blush),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: darkRuby.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget ioCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: blush.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: darkRuby.withValues(alpha: 0.06),
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
              color: ruby.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: darkRuby)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget ioRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? ruby.withValues(alpha: 0.06) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: blush.withValues(alpha: 0.5)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? darkRuby : garnet)),
          );
        }).toList(),
      ),
    );
  }

  Widget ioFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? darkRuby : deepRuby,
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
          child: Icon(Icons.east, size: 12, color: ruby),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  Widget ioCode(String label, String detail) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: paleRuby.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(6),
        border: Border(left: BorderSide(color: ruby, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: darkRuby,
                  fontFamily: 'monospace')),
          const SizedBox(width: 8),
          Expanded(
            child: Text(detail,
                style: TextStyle(fontSize: 12, color: garnet)),
          ),
        ],
      ),
    );
  }

  // ━━━━━━ SECTION 1: What is IOSSystemContextMenuItemData? ━━━━━━
  print('[io-01] Section 1: What is IOSSystemContextMenuItemData?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ioBanner('01', 'What Is IOSSystemContextMenuItemData?'),
      ioNote(
        'IOSSystemContextMenuItemData is a data class representing a single '
        'item in the iOS system context menu — the native menu that appears '
        'when you long-press or double-tap text. Items include Copy, Paste, '
        'Cut, Look Up, Translate, Share, and custom actions. This class '
        'bridges Flutter\'s toolbar API to iOS\'s UIMenuController / UIEditMenuInteraction.',
      ),
      ioCard(
        'iOS Context Menu Anatomy',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: paleRuby,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.phone_iphone, size: 22, color: ruby),
                  const SizedBox(width: 8),
                  Text('iOS Text Selection Menu',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: darkRuby)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ioMenuItem('Cut', Icons.content_cut, ruby),
                  _ioMenuItem('Copy', Icons.copy, garnet),
                  _ioMenuItem('Paste', Icons.paste, deepRuby),
                  _ioMenuItem('Look Up', Icons.search, claret),
                  _ioMenuItem('Share…', Icons.share, rosewood),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 2: Data fields ━━━━━━
  print('[io-02] Section 2: Data fields');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ioBanner('02', 'Data Fields'),
      ioNote(
        'Each IOSSystemContextMenuItemData holds a label (display text) and '
        'an action identifier. The action links back to the Flutter handler '
        'that should execute when the item is tapped.',
      ),
      ioCard(
        'Field Reference',
        Column(
          children: [
            ioRow(['Field', 'Type', 'Purpose'], isHeader: true),
            ioRow(['label', 'String', 'Text shown to user']),
            ioRow(['action', 'String', 'Unique action identifier']),
            ioRow(['type', 'enum', 'System vs custom item type']),
          ],
        ),
      ),
      ioCard(
        'Action Identifiers',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ioCode('cut:', 'UIResponder standard cut action'),
            ioCode('copy:', 'UIResponder standard copy action'),
            ioCode('paste:', 'UIResponder standard paste action'),
            ioCode('selectAll:', 'Select all text action'),
            ioCode('_lookup:', 'Look Up / Define action'),
            ioCode('_share:', 'Share sheet action'),
            ioCode('_translate:', 'Translate action (iOS 15+)'),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: System vs custom items ━━━━━━
  print('[io-03] Section 3: System vs custom items');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ioBanner('03', 'System Items vs Custom Items'),
      ioNote(
        'System items are provided by iOS itself (Cut, Copy, Paste, etc.) '
        'and have fixed behavior and styling. Custom items are added by the '
        'app and have app-defined labels and handlers. The data class must '
        'distinguish between these two categories.',
      ),
      ioCard(
        'Comparison',
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: paleRuby,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: blush),
                ),
                child: Column(
                  children: [
                    Icon(Icons.phone_iphone, size: 22, color: ruby),
                    const SizedBox(height: 4),
                    Text('System Items',
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.bold, color: ruby)),
                    const SizedBox(height: 6),
                    _ioCompareItem('OS-provided', ruby),
                    _ioCompareItem('Fixed labels', ruby),
                    _ioCompareItem('Native styling', ruby),
                    _ioCompareItem('Standard actions', ruby),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: blush.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: garnet),
                ),
                child: Column(
                  children: [
                    Icon(Icons.extension, size: 22, color: garnet),
                    const SizedBox(height: 4),
                    Text('Custom Items',
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.bold, color: garnet)),
                    const SizedBox(height: 6),
                    _ioCompareItem('App-defined', garnet),
                    _ioCompareItem('Custom labels', garnet),
                    _ioCompareItem('Flutter callback', garnet),
                    _ioCompareItem('Custom actions', garnet),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: UIEditMenuInteraction ━━━━━━
  print('[io-04] Section 4: UIEditMenuInteraction (iOS 16+)');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ioBanner('04', 'UIEditMenuInteraction (iOS 16+)'),
      ioNote(
        'Starting in iOS 16, Apple replaced UIMenuController with '
        'UIEditMenuInteraction, providing a more modern menu presentation. '
        'IOSSystemContextMenuItemData abstracts over both APIs — the data '
        'model stays the same regardless of the underlying iOS version.',
      ),
      ioCard(
        'API Evolution',
        Column(
          children: [
            ioRow(['iOS Version', 'API', 'Presentation'], isHeader: true),
            ioRow(['< 16', 'UIMenuController', 'Black bubble above text']),
            ioRow(['>= 16', 'UIEditMenuInteraction', 'Modern rounded menu']),
            ioRow(['Flutter', 'IOSSystemContextMenuItemData', 'Abstraction layer']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: Toolbar interaction ━━━━━━
  print('[io-05] Section 5: Toolbar interaction');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ioBanner('05', 'Integration with SelectionToolbar'),
      ioNote(
        'Flutter\'s text selection toolbar on iOS can show either the default '
        'Material/Cupertino toolbar or delegate to the iOS system context menu '
        'via SystemContextMenu. When using the system menu, each toolbar item '
        'is represented as an IOSSystemContextMenuItemData.',
      ),
      ioCard(
        'Toolbar → System Menu Flow',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ioFlow(['Text selected', 'Build toolbar items',
                'IOSSystemContextMenuItemData', 'iOS system menu']),
            const SizedBox(height: 10),
            ioRow(['Step', 'Component', 'Responsibility'], isHeader: true),
            ioRow(['1', 'EditableText', 'Detects selection']),
            ioRow(['2', 'SelectionControls', 'Builds item list']),
            ioRow(['3', 'SystemContextMenu', 'Wraps as data items']),
            ioRow(['4', 'Platform channel', 'Sends to iOS']),
            ioRow(['5', 'iOS UIKit', 'Renders native menu']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: Standard system items ━━━━━━
  print('[io-06] Section 6: Standard system items');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ioBanner('06', 'Standard System Items'),
      ioNote(
        'iOS provides a set of standard context menu items that are shown '
        'based on the current state (selection, clipboard content, etc.). '
        'Each has a well-known action selector.',
      ),
      ioCard(
        'System Item Catalog',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ioSystemItem('Cut', 'cut:', 'Requires selection', Icons.content_cut, ruby),
            _ioSystemItem('Copy', 'copy:', 'Requires selection', Icons.copy, garnet),
            _ioSystemItem('Paste', 'paste:', 'Requires clipboard', Icons.paste, deepRuby),
            _ioSystemItem('Select All', 'selectAll:', 'Always available', Icons.select_all, claret),
            _ioSystemItem('Look Up', '_lookup:', 'Requires selection', Icons.search, rosewood),
            _ioSystemItem('Translate', '_translate:', 'iOS 15+', Icons.translate, darkRuby),
            _ioSystemItem('Share…', '_share:', 'Requires selection', Icons.share, garnet),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: Conditional visibility ━━━━━━
  print('[io-07] Section 7: Conditional visibility');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ioBanner('07', 'Conditional Visibility'),
      ioNote(
        'Not all items appear in every context. Cut/Copy require a non-empty '
        'selection. Paste requires clipboard content matching the pasteboard '
        'type. Look Up requires selection and language support. The data '
        'model carries visibility flags.',
      ),
      ioCard(
        'Visibility Rules',
        Column(
          children: [
            ioRow(['Item', 'Condition', 'Why'], isHeader: true),
            ioRow(['Cut', 'hasSelection && editable', 'Need text to cut']),
            ioRow(['Copy', 'hasSelection', 'Need text to copy']),
            ioRow(['Paste', 'hasClipboard && editable', 'Need content']),
            ioRow(['Select All', 'text.isNotEmpty', 'Need some text']),
            ioRow(['Look Up', 'hasSelection', 'Need word to define']),
            ioRow(['Share', 'hasSelection', 'Need content to share']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: Platform channel serialization ━━━━━━
  print('[io-08] Section 8: Serialization');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ioBanner('08', 'Platform Channel Serialization'),
      ioNote(
        'IOSSystemContextMenuItemData is serialized to a Map for transmission '
        'over the platform channel to the iOS engine. The map contains the '
        'label, action identifier, and item type. This is part of the '
        'SystemChannels.contextMenu protocol.',
      ),
      ioCard(
        'Serialization Format',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ioCode('{', ''),
            ioCode('  "label":', '"Copy"'),
            ioCode('  "action":', '"copy:"'),
            ioCode('  "type":', '"system" | "custom"'),
            ioCode('}', ''),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: paleRuby,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Multiple items are sent as a JSON array. The iOS side '
                'deserializes and constructs UIActions or UIMenuElements.',
                style: TextStyle(fontSize: 10, color: darkRuby),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: Custom item callbacks ━━━━━━
  print('[io-09] Section 9: Custom item callbacks');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ioBanner('09', 'Custom Item Callbacks'),
      ioNote(
        'When a custom item is tapped, iOS sends the action identifier back '
        'through the platform channel. Flutter matches the identifier to the '
        'registered callback and invokes it. This round-trip enables custom '
        'behavior while preserving native menu appearance.',
      ),
      ioCard(
        'Callback Round-Trip',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ioFlow(['Tap item', 'iOS → channel', 'Match action',
                'Invoke callback', 'Update UI']),
            const SizedBox(height: 10),
            ioRow(['Step', 'Thread', 'Action'], isHeader: true),
            ioRow(['1', 'Main (iOS)', 'User taps menu item']),
            ioRow(['2', 'Main (iOS)', 'UIAction invokes selector']),
            ioRow(['3', 'Platform channel', 'Action ID sent to Flutter']),
            ioRow(['4', 'UI (Flutter)', 'Callback invoked']),
            ioRow(['5', 'UI (Flutter)', 'State update / dismiss']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: BrowserContextMenu relationship ━━━━━━
  print('[io-10] Section 10: BrowserContextMenu relationship');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ioBanner('10', 'Relationship to BrowserContextMenu'),
      ioNote(
        'On Flutter web, BrowserContextMenu handles the browser\'s native '
        'right-click menu. On iOS, IOSSystemContextMenuItemData serves the '
        'same role — bridging Flutter\'s toolbar API to the platform\'s '
        'native context menu. Same pattern, different platform.',
      ),
      ioCard(
        'Cross-Platform Context Menu',
        Column(
          children: [
            ioRow(['Platform', 'Menu Class', 'Trigger'], isHeader: true),
            ioRow(['iOS', 'IOSSystemContextMenuItemData', 'Long-press']),
            ioRow(['Android', 'ActionMode toolbar', 'Long-press']),
            ioRow(['Web', 'BrowserContextMenu', 'Right-click']),
            ioRow(['macOS', 'NSMenu', 'Right-click']),
            ioRow(['Windows', 'Win32 context menu', 'Right-click']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: Menu ordering ━━━━━━
  print('[io-11] Section 11: Menu item ordering');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ioBanner('11', 'Menu Item Ordering'),
      ioNote(
        'The order of items in the context menu is determined by iOS for '
        'system items (following Apple HIG) and by the app for custom items. '
        'Custom items typically appear after system items. The data model '
        'preserves insertion order.',
      ),
      ioCard(
        'Default iOS Order',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ioOrderItem(1, 'Cut', 'System', ruby),
            _ioOrderItem(2, 'Copy', 'System', garnet),
            _ioOrderItem(3, 'Paste', 'System', deepRuby),
            _ioOrderItem(4, 'Select All', 'System', claret),
            _ioOrderItem(5, 'Look Up', 'System', rosewood),
            _ioOrderItem(6, 'Translate', 'System', darkRuby),
            _ioOrderItem(7, 'Share…', 'System', garnet),
            _ioOrderItem(8, '(Custom items)', 'App', warmGold),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: Accessibility ━━━━━━
  print('[io-12] Section 12: Accessibility');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ioBanner('12', 'Accessibility Support'),
      ioNote(
        'Because system context menu items render natively, they automatically '
        'get VoiceOver support, dynamic type sizing, and proper accessibility '
        'labels. Custom items inherit these traits when using the system menu. '
        'This is a key advantage over Flutter-rendered toolbars.',
      ),
      ioCard(
        'Accessibility Features',
        Column(
          children: [
            ioRow(['Feature', 'System Menu', 'Flutter Toolbar'], isHeader: true),
            ioRow(['VoiceOver', 'Automatic', 'Manual semantics']),
            ioRow(['Dynamic Type', 'Automatic', 'Manual sizing']),
            ioRow(['RTL support', 'Automatic', 'Manual layout']),
            ioRow(['High contrast', 'Automatic', 'Manual colors']),
            ioRow(['Reduce motion', 'Automatic', 'Manual animation']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: Localization ━━━━━━
  print('[io-13] Section 13: Localization');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ioBanner('13', 'Localization'),
      ioNote(
        'System item labels (Copy, Paste, etc.) are automatically localized '
        'by iOS into the device language. Custom items must be localized by '
        'the app. The data model carries the final localized label string.',
      ),
      ioCard(
        'Localized System Labels',
        Column(
          children: [
            ioRow(['Item', 'English', 'German', 'Japanese'], isHeader: true),
            ioRow(['Copy', 'Copy', 'Kopieren', 'コピー']),
            ioRow(['Paste', 'Paste', 'Einsetzen', 'ペースト']),
            ioRow(['Cut', 'Cut', 'Ausschneiden', 'カット']),
            ioRow(['Select All', 'Select All', 'Alle auswählen', 'すべてを選択']),
            ioRow(['Look Up', 'Look Up', 'Nachschlagen', '調べる']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: Menu dismissal ━━━━━━
  print('[io-14] Section 14: Menu dismissal');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ioBanner('14', 'Menu Dismissal'),
      ioNote(
        'The system context menu dismisses when: the user taps an item, taps '
        'outside the menu, scrolls the content, or the selection changes '
        'programmatically. The data model doesn\'t handle dismissal directly '
        '— iOS manages it, but Flutter must know when it\'s dismissed to '
        'update toolbar state.',
      ),
      ioCard(
        'Dismissal Triggers',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ioDismissItem('Item tap', 'Action fires then dismiss', Icons.touch_app, ruby),
            _ioDismissItem('Outside tap', 'Silent dismiss', Icons.exit_to_app, garnet),
            _ioDismissItem('Scroll', 'Content moved', Icons.swap_vert, deepRuby),
            _ioDismissItem('Selection change', 'Programmatic', Icons.deselect, claret),
            _ioDismissItem('Window resign', 'App backgrounded', Icons.visibility_off, rosewood),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Testing patterns ━━━━━━
  print('[io-15] Section 15: Testing');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ioBanner('15', 'Testing Context Menu Items'),
      ioNote(
        'Test IOSSystemContextMenuItemData by constructing instances, '
        'verifying serialization, and checking round-trip through the '
        'platform channel mock. Test visibility logic separately from '
        'the data model.',
      ),
      ioCard(
        'Test Scenarios',
        Column(
          children: [
            ioRow(['Test', 'What', 'Assert'], isHeader: true),
            ioRow(['Construction', 'Create with label/action', 'Fields set']),
            ioRow(['Serialization', 'toMap()', 'Valid JSON structure']),
            ioRow(['Round-trip', 'toMap → fromMap', 'Equal instance']),
            ioRow(['System type', 'Copy item', 'type == system']),
            ioRow(['Custom type', 'App item', 'type == custom']),
            ioRow(['Callback', 'Action invocation', 'Handler called']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[io-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ioBanner('16', 'Summary Dashboard'),
      ioCard(
        'IOSSystemContextMenuItemData — Complete',
        Column(
          children: [
            ioRow(['Topic', 'Section', 'Key Insight'], isHeader: true),
            ioRow(['What', 'S01', 'iOS native context menu items']),
            ioRow(['Fields', 'S02', 'label, action, type']),
            ioRow(['Types', 'S03', 'System vs custom items']),
            ioRow(['iOS 16+', 'S04', 'UIEditMenuInteraction API']),
            ioRow(['Toolbar', 'S05', 'SelectionToolbar integration']),
            ioRow(['System items', 'S06', 'Cut/Copy/Paste/Look Up/Share']),
            ioRow(['Visibility', 'S07', 'Conditional show/hide rules']),
            ioRow(['Wire format', 'S08', 'Platform channel Map']),
            ioRow(['Callbacks', 'S09', 'Action → handler round-trip']),
            ioRow(['Cross-plat', 'S10', 'BrowserContextMenu parallel']),
            ioRow(['Ordering', 'S11', 'System first, custom after']),
            ioRow(['A11y', 'S12', 'VoiceOver + Dynamic Type']),
            ioRow(['L10n', 'S13', 'Auto-localized system labels']),
            ioRow(['Dismissal', 'S14', 'Tap/scroll/background triggers']),
            ioRow(['Testing', 'S15', 'Serialization + round-trip']),
          ],
        ),
      ),
      ioCard(
        'Ruby / Garnet Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _ioColorSwatch('Ruby', ruby),
            _ioColorSwatch('Garnet', garnet),
            _ioColorSwatch('Deep', deepRuby),
            _ioColorSwatch('Claret', claret),
            _ioColorSwatch('Dark', darkRuby),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [darkRuby, deepRuby],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('IOSSystemContextMenuItemData — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'From system items through custom callbacks, serialization, '
              'accessibility, localization, and dismissal — the full iOS '
              'context menu data story.',
              style: TextStyle(color: blush, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[io] palette: $crimson, $warmGold');
  print('[io] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('IOSSystemContextMenuItemData Demo'),
        backgroundColor: darkRuby,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFFFF8F8),
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

Widget _ioMenuItem(String label, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Column(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(height: 2),
        Text(label,
            style: TextStyle(fontSize: 8, fontWeight: FontWeight.w600, color: color)),
      ],
    ),
  );
}

Widget _ioCompareItem(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 3),
    child: Row(
      children: [
        Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2.5),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(text, style: TextStyle(fontSize: 10, color: color)),
        ),
      ],
    ),
  );
}

Widget _ioSystemItem(String name, String action, String condition, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(child: Icon(icon, size: 16, color: color)),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 60,
          child: Text(name,
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.bold, color: color)),
        ),
        Expanded(
          child: Text(action,
              style: TextStyle(
                  fontSize: 9, fontFamily: 'monospace', color: color.withValues(alpha: 0.7))),
        ),
        Text(condition,
            style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.6))),
      ],
    ),
  );
}

Widget _ioOrderItem(int num, String label, String source, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text('$num',
                style: const TextStyle(
                    color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(label,
              style: TextStyle(fontSize: 11, color: color)),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(source,
              style: TextStyle(
                  fontSize: 9, fontWeight: FontWeight.w600, color: color)),
        ),
      ],
    ),
  );
}

Widget _ioDismissItem(String label, String desc, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(child: Icon(icon, size: 16, color: color)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      fontSize: 11, fontWeight: FontWeight.bold, color: color)),
              Text(desc,
                  style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.7))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _ioColorSwatch(String name, Color color) {
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
