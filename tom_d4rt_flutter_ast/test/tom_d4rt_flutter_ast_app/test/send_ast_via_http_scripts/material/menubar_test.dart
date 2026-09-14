// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element
// D4rt test script: Deep Demo - Desktop Menubar Showcase
// Theme: "Desktop Menubar Showcase" - a field guide to the Flutter menu
// system covering MenuBar, SubmenuButton, MenuItemButton,
// MenuAcceleratorLabel, MenuAcceleratorCallbackBinding, MenuController,
// MenuStyle, MenuAnchor, and the surrounding menu APIs. Open-state panels
// are rendered as static Containers so the showcase remains a pure
// snapshot (no interactivity, no controllers, no async).
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  // ==========================================================================
  // SECTION DATA: menubar inventory rows
  // ==========================================================================

  final menubarTopLevel = <Map<String, dynamic>>[
    {'label': 'File', 'mnemonic': 'F', 'items': 6, 'hasSubmenus': true},
    {'label': 'Edit', 'mnemonic': 'E', 'items': 5, 'hasSubmenus': false},
    {'label': 'View', 'mnemonic': 'V', 'items': 4, 'hasSubmenus': true},
    {'label': 'Tools', 'mnemonic': 'T', 'items': 3, 'hasSubmenus': true},
    {'label': 'Help', 'mnemonic': 'H', 'items': 2, 'hasSubmenus': false},
  ];

  // ==========================================================================
  // SECTION DATA: file menu items with shortcuts and accelerators
  // ==========================================================================

  final fileMenuItems = <Map<String, dynamic>>[
    {'label': '&New File', 'shortcut': 'Ctrl+N', 'leading': 'note_add'},
    {'label': '&Open...', 'shortcut': 'Ctrl+O', 'leading': 'folder_open'},
    {'label': '&Save', 'shortcut': 'Ctrl+S', 'leading': 'save'},
    {'label': 'Save &As...', 'shortcut': 'Ctrl+Shift+S', 'leading': 'save_as'},
    {'label': '&Print...', 'shortcut': 'Ctrl+P', 'leading': 'print'},
    {'label': 'E&xit', 'shortcut': 'Alt+F4', 'leading': 'logout'},
  ];

  // ==========================================================================
  // SECTION DATA: nested submenu tree (recent files)
  // ==========================================================================

  final recentFiles = <Map<String, dynamic>>[
    {'name': 'main.dart', 'path': 'lib/main.dart', 'mod': '2m ago'},
    {'name': 'menubar_test.dart', 'path': 'test/material', 'mod': '5m ago'},
    {'name': 'class_test.dart', 'path': 'test/animation', 'mod': '12m ago'},
    {'name': 'README.md', 'path': '/', 'mod': '1h ago'},
  ];

  // ==========================================================================
  // SECTION DATA: MenuStyle theming variants
  // ==========================================================================

  final menuStyleVariants = <Map<String, dynamic>>[
    {
      'name': 'default',
      'background': const Color(0xFFFFFFFF),
      'elevation': 2.0,
      'padding': 4.0,
      'border': const Color(0xFFE0E0E0),
    },
    {
      'name': 'frosted',
      'background': const Color(0xFFF5F5F7),
      'elevation': 6.0,
      'padding': 6.0,
      'border': const Color(0xFFB0BEC5),
    },
    {
      'name': 'midnight',
      'background': const Color(0xFF263238),
      'elevation': 10.0,
      'padding': 8.0,
      'border': const Color(0xFF455A64),
    },
    {
      'name': 'ocean',
      'background': const Color(0xFF0D47A1),
      'elevation': 14.0,
      'padding': 10.0,
      'border': const Color(0xFF1976D2),
    },
  ];

  // ==========================================================================
  // SECTION DATA: MenuAnchor alignment placements
  // ==========================================================================

  final anchorPlacements = <Map<String, dynamic>>[
    {'name': 'topLeft', 'x': 0.0, 'y': 0.0, 'desc': 'Anchor flag origin'},
    {
      'name': 'topCenter',
      'x': 0.5,
      'y': 0.0,
      'desc': 'Drop-down under a centered widget',
    },
    {
      'name': 'topRight',
      'x': 1.0,
      'y': 0.0,
      'desc': 'Window menu in macOS-style header',
    },
    {
      'name': 'centerLeft',
      'x': 0.0,
      'y': 0.5,
      'desc': 'Side rail flyout',
    },
    {
      'name': 'centerRight',
      'x': 1.0,
      'y': 0.5,
      'desc': 'Inspector context flyout',
    },
    {
      'name': 'bottomLeft',
      'x': 0.0,
      'y': 1.0,
      'desc': 'Status bar action menu',
    },
  ];

  // ==========================================================================
  // SECTION DATA: comparison of submenu vs menu item vs accelerator
  // ==========================================================================

  final widgetComparison = <Map<String, dynamic>>[
    {
      'widget': 'MenuBar',
      'role': 'Horizontal bar',
      'children': 'SubmenuButton list',
      'opens': 'On hover/click',
    },
    {
      'widget': 'SubmenuButton',
      'role': 'Group entry',
      'children': 'menuChildren',
      'opens': 'Nested panel',
    },
    {
      'widget': 'MenuItemButton',
      'role': 'Leaf action',
      'children': 'leading/trailing',
      'opens': 'Triggers onPressed',
    },
    {
      'widget': 'MenuAcceleratorLabel',
      'role': 'Mnemonic label',
      'children': 'String with &',
      'opens': 'Alt+letter focus',
    },
    {
      'widget': 'MenuAnchor',
      'role': 'Custom anchor',
      'children': 'builder/menuChildren',
      'opens': 'controller.open()',
    },
    {
      'widget': 'MenuController',
      'role': 'Imperative control',
      'children': '-',
      'opens': 'open() / close()',
    },
  ];

  // ==========================================================================
  // SECTION DATA: glossary of menu API terms
  // ==========================================================================

  final glossary = <Map<String, dynamic>>[
    {
      'term': 'Accelerator',
      'def':
          'Letter prefixed with & in a label; triggered via Alt+letter. '
          'Rendered by MenuAcceleratorLabel.',
    },
    {
      'term': 'Mnemonic',
      'def':
          'Synonym for accelerator letter. The first un-escaped & in '
          'the label string defines it.',
    },
    {
      'term': 'MenuAcceleratorCallbackBinding',
      'def':
          'Inherited widget injected by MenuItemButton to wire its '
          'onPressed into the accelerator label.',
    },
    {
      'term': 'MenuController',
      'def':
          'Imperative handle (open(), close(), isOpen) for a MenuAnchor. '
          'Lives alongside the widget, not inside it.',
    },
    {
      'term': 'MenuStyle',
      'def':
          'ButtonStyle-like bag of WidgetStateProperty values: '
          'backgroundColor, elevation, padding, alignment, shape...',
    },
  ];

  // ==========================================================================
  // SECTION DATA: recipe cards
  // ==========================================================================

  final recipes = <Map<String, dynamic>>[
    {
      'title': 'Classic File Menu',
      'snippet':
          'MenuBar(children: [SubmenuButton(menuChildren: [MenuItemButton...])])',
      'note': 'Mirror the OS file menu with shortcuts and dividers.',
    },
    {
      'title': 'Nested Recent Files',
      'snippet':
          'SubmenuButton(menuChildren: [SubmenuButton(menuChildren: [...])])',
      'note': 'Submenu nesting renders the chevron and unfolds sideways.',
    },
    {
      'title': 'Accelerator Toolbar',
      'snippet': 'MenuAcceleratorLabel("&Save") under MenuItemButton',
      'note': 'Underlines S; Alt+S triggers MenuItemButton.onPressed.',
    },
    {
      'title': 'Custom Anchor Flyout',
      'snippet':
          'MenuAnchor(controller: c, builder: (...) => IconButton(...))',
      'note': 'MenuController gives imperative open()/close() without UI.',
    },
    {
      'title': 'Themed Menu Surface',
      'snippet':
          'SubmenuButton(menuStyle: MenuStyle(backgroundColor: WidgetStatePropertyAll(...)))',
      'note': 'WidgetStateProperty values apply across hover/pressed states.',
    },
  ];

  // ==========================================================================
  // MENUBAR INSTANCES (analyzer surface coverage)
  // ==========================================================================

  final menuControllerA = MenuController();
  final menuControllerB = MenuController();

  final fileMenuBar = MenuBar(
    children: [
      SubmenuButton(
        menuChildren: [
          MenuItemButton(
            leadingIcon: const Icon(Icons.note_add, size: 16.0),
            shortcut: const SingleActivator(LogicalKeyboardKey.keyN,
                control: true),
            child: const MenuAcceleratorLabel('&New File'),
            onPressed: () {},
          ),
          MenuItemButton(
            leadingIcon: const Icon(Icons.folder_open, size: 16.0),
            child: const MenuAcceleratorLabel('&Open...'),
            onPressed: () {},
          ),
          const Divider(),
          MenuItemButton(
            leadingIcon: const Icon(Icons.save, size: 16.0),
            child: const MenuAcceleratorLabel('&Save'),
            onPressed: () {},
          ),
          MenuItemButton(
            leadingIcon: const Icon(Icons.save_as, size: 16.0),
            child: const MenuAcceleratorLabel('Save &As...'),
            onPressed: () {},
          ),
          SubmenuButton(
            menuChildren: [
              MenuItemButton(
                  child: const Text('main.dart'), onPressed: () {}),
              MenuItemButton(
                  child: const Text('menubar_test.dart'), onPressed: () {}),
              MenuItemButton(
                  child: const Text('README.md'), onPressed: () {}),
            ],
            child: const Text('Recent'),
          ),
          const Divider(),
          MenuItemButton(
            leadingIcon: const Icon(Icons.logout, size: 16.0),
            child: const MenuAcceleratorLabel('E&xit'),
            onPressed: () {},
          ),
        ],
        child: const MenuAcceleratorLabel('&File'),
      ),
      SubmenuButton(
        menuChildren: [
          MenuItemButton(
              child: const MenuAcceleratorLabel('&Undo'), onPressed: () {}),
          MenuItemButton(
              child: const MenuAcceleratorLabel('&Redo'), onPressed: () {}),
          const Divider(),
          MenuItemButton(
              child: const MenuAcceleratorLabel('&Cut'), onPressed: () {}),
          MenuItemButton(
              child: const MenuAcceleratorLabel('Cop&y'), onPressed: () {}),
          MenuItemButton(
              child: const MenuAcceleratorLabel('&Paste'), onPressed: () {}),
        ],
        child: const MenuAcceleratorLabel('&Edit'),
      ),
      SubmenuButton(
        menuChildren: [
          MenuItemButton(
              child: const MenuAcceleratorLabel('&Zoom In'),
              onPressed: () {}),
          MenuItemButton(
              child: const MenuAcceleratorLabel('Zoom &Out'),
              onPressed: () {}),
          SubmenuButton(
            menuChildren: [
              MenuItemButton(
                  child: const Text('Light'), onPressed: () {}),
              MenuItemButton(
                  child: const Text('Dark'), onPressed: () {}),
              MenuItemButton(
                  child: const Text('High Contrast'), onPressed: () {}),
            ],
            child: const Text('Theme'),
          ),
        ],
        child: const MenuAcceleratorLabel('&View'),
      ),
      SubmenuButton(
        menuChildren: [
          MenuItemButton(
              child: const Text('Analyze'), onPressed: () {}),
          MenuItemButton(
              child: const Text('Format'), onPressed: () {}),
          MenuItemButton(
              child: const Text('Refactor'), onPressed: () {}),
        ],
        child: const MenuAcceleratorLabel('&Tools'),
      ),
      SubmenuButton(
        menuChildren: [
          MenuItemButton(
              child: const Text('About'), onPressed: () {}),
          MenuItemButton(
              child: const Text('Documentation'), onPressed: () {}),
        ],
        child: const MenuAcceleratorLabel('&Help'),
      ),
    ],
  );

  final styledMenuBar = MenuBar(
    style: MenuStyle(
      backgroundColor:
          const WidgetStatePropertyAll<Color>(Color(0xFFE3F2FD)),
      elevation: const WidgetStatePropertyAll<double>(4.0),
      padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0)),
    ),
    children: [
      SubmenuButton(
        menuChildren: [
          MenuItemButton(child: const Text('Option 1'), onPressed: () {}),
          MenuItemButton(child: const Text('Option 2'), onPressed: () {}),
        ],
        child: const Text('Styled'),
      ),
    ],
  );

  final menuAnchorInstance = MenuAnchor(
    controller: menuControllerA,
    menuChildren: [
      MenuItemButton(child: const Text('Anchor item 1'), onPressed: () {}),
      MenuItemButton(child: const Text('Anchor item 2'), onPressed: () {}),
    ],
    builder: (BuildContext ctx, MenuController controller, Widget? child) {
      return const SizedBox.shrink();
    },
  );

  final anchorChildName = menuAnchorInstance.runtimeType.toString();
  final controllerOpenA = menuControllerA.isOpen;
  final controllerOpenB = menuControllerB.isOpen;

  // ==========================================================================
  // BUILD THE SHOWCASE UI
  // ==========================================================================

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Desktop Menubar Showcase',
    theme: ThemeData(
      primarySwatch: Colors.indigo,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ============================================================
              // HERO HEADER
              // ============================================================
              _heroHeader(),
              const SizedBox(height: 24.0),

              // ============================================================
              // CONCEPT OVERVIEW
              // ============================================================
              _conceptOverview(),
              const SizedBox(height: 24.0),

              // ============================================================
              // SECTION 1: MENUBAR INVENTORY
              // ============================================================
              _section1MenubarInventory(menubarTopLevel, fileMenuBar),
              const SizedBox(height: 20.0),

              // ============================================================
              // SECTION 2: SUBMENUBUTTON & MENUITEMBUTTON
              // ============================================================
              _section2SubmenuAndItems(fileMenuItems),
              const SizedBox(height: 20.0),

              // ============================================================
              // SECTION 3: NESTED SUBMENUS
              // ============================================================
              _section3NestedSubmenus(recentFiles),
              const SizedBox(height: 20.0),

              // ============================================================
              // SECTION 4: MENUACCELERATORLABEL + CALLBACK BINDING
              // ============================================================
              _section4Accelerators(),
              const SizedBox(height: 20.0),

              // ============================================================
              // SECTION 5: MENUSTYLE THEMING
              // ============================================================
              _section5MenuStyle(menuStyleVariants, styledMenuBar),
              const SizedBox(height: 20.0),

              // ============================================================
              // SECTION 6: MENUANCHOR PLACEMENTS
              // ============================================================
              _section6MenuAnchor(anchorPlacements, anchorChildName),
              const SizedBox(height: 20.0),

              // ============================================================
              // SECTION 7: MENUCONTROLLER STATE
              // ============================================================
              _section7MenuController(controllerOpenA, controllerOpenB),
              const SizedBox(height: 20.0),

              // ============================================================
              // SECTION 8: WIDGET COMPARISON TABLE
              // ============================================================
              _section8Comparison(widgetComparison),
              const SizedBox(height: 20.0),

              // ============================================================
              // SECTION 9: RECIPE CARDS
              // ============================================================
              _section9Recipes(recipes),
              const SizedBox(height: 20.0),

              // ============================================================
              // SECTION 10: GLOSSARY PANEL
              // ============================================================
              _section10Glossary(glossary),
              const SizedBox(height: 24.0),

              // ============================================================
              // EPILOGUE
              // ============================================================
              _epilogue(),
              const SizedBox(height: 12.0),
              Center(
                child: Text(
                  'Deep Demo • Desktop Menubar Showcase • Flutter Material',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFF78909C),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================================
// HERO HEADER
// ============================================================================

Widget _heroHeader() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF3949AB), Color(0xFF5C6BC0), Color(0xFF7986CB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: const [
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Icon(Icons.menu_open,
                  color: Color(0xFFFFFFFF), size: 28.0),
            ),
            const SizedBox(width: 14.0),
            const Expanded(
              child: Text(
                'Desktop Menubar Showcase',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        const Text(
          'A field guide to MenuBar, SubmenuButton, MenuItemButton, '
          'MenuAcceleratorLabel, MenuAnchor, MenuController, and MenuStyle.',
          style: TextStyle(fontSize: 15.0, color: Color(0xFFE8EAF6)),
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _heroChip('MenuBar'),
            _heroChip('SubmenuButton'),
            _heroChip('MenuItemButton'),
            _heroChip('MenuAcceleratorLabel'),
            _heroChip('MenuAnchor'),
            _heroChip('MenuController'),
            _heroChip('MenuStyle'),
          ],
        ),
      ],
    ),
  );
}

Widget _heroChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: const Color(0x33FFFFFF),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: const Color(0x55FFFFFF), width: 1.0),
    ),
    child: Text(
      label,
      style: const TextStyle(
        fontSize: 12.0,
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

// ============================================================================
// CONCEPT OVERVIEW
// ============================================================================

Widget _conceptOverview() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: const Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFF9FA8DA), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.lightbulb_outline,
                color: Color(0xFF283593), size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'Mental Model',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'Flutter\'s desktop menu API layers responsibilities cleanly. A '
          'MenuBar is the horizontal strip. Each top-level entry is a '
          'SubmenuButton that owns a flyout of MenuItemButtons. Item labels '
          'can be MenuAcceleratorLabels carrying mnemonic & markers. '
          'MenuStyle paints the surface; MenuAnchor and MenuController '
          'unlock custom triggers and imperative open/close.',
          style: TextStyle(fontSize: 14.0, height: 1.5),
        ),
        const SizedBox(height: 12.0),
        const Text(
          'Composition order (outer to inner):',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
        ),
        const SizedBox(height: 6.0),
        _overviewBullet('MenuBar — horizontal container'),
        _overviewBullet('SubmenuButton — top-level group entry'),
        _overviewBullet('MenuItemButton — clickable leaf row'),
        _overviewBullet('MenuAcceleratorLabel — & mnemonic renderer'),
        _overviewBullet('MenuStyle — surface styling bag'),
        _overviewBullet('MenuAnchor + MenuController — custom trigger'),
      ],
    ),
  );
}

Widget _overviewBullet(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('• ', style: TextStyle(fontSize: 14.0)),
        Expanded(
          child: Text(text, style: const TextStyle(fontSize: 13.0)),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 1: MENUBAR INVENTORY
// Palette: indigo / blue
// ============================================================================

Widget _section1MenubarInventory(
  List<Map<String, dynamic>> menubarTopLevel,
  MenuBar realBar,
) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: const Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFF90CAF9), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SECTION 1: MenuBar Inventory',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D47A1),
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Top-level entries that decorate the desktop bar.',
          style: TextStyle(fontSize: 12.0, color: Color(0xFF455A64)),
        ),
        const SizedBox(height: 14.0),
        // Mock rendering of the menubar strip
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: const Color(0xFFBBDEFB), width: 1.0),
          ),
          child: Row(
            children: [
              for (final m in menubarTopLevel)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 6.0),
                  child: Row(
                    children: [
                      _acceleratorChar(m['mnemonic'] as String),
                      Text(
                        (m['label'] as String).replaceFirst('&', ''),
                        style: const TextStyle(fontSize: 13.0),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        // Inventory table
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: const [
                  Expanded(
                    flex: 2,
                    child: Text('Entry',
                        style: TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('Mnemonic',
                        style: TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('Items',
                        style: TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('Nested',
                        style: TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const Divider(height: 12.0),
              for (final m in menubarTopLevel)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(m['label'] as String,
                            style: const TextStyle(fontSize: 12.0)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 22.0,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3F51B5),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            m['mnemonic'] as String,
                            style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('${m['items']}',
                            style: const TextStyle(
                                fontSize: 12.0, fontFamily: 'monospace')),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          (m['hasSubmenus'] as bool) ? 'yes' : 'no',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: (m['hasSubmenus'] as bool)
                                ? const Color(0xFF2E7D32)
                                : const Color(0xFF757575),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        // The real (offscreen) MenuBar instance gets a sentinel
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFBBDEFB),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              const Icon(Icons.check_circle,
                  color: Color(0xFF1565C0), size: 18.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Constructed: ${realBar.runtimeType} '
                  '(children: ${realBar.children.length})',
                  style: const TextStyle(
                      fontSize: 12.0, fontFamily: 'monospace'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        _recipeCard(
          'Classic MenuBar',
          'MenuBar(children: [SubmenuButton(...), SubmenuButton(...)])',
          'Mirror the OS file menu with shortcuts and dividers.',
          const Color(0xFF1565C0),
        ),
      ],
    ),
  );
}

Widget _acceleratorChar(String letter) {
  return Container(
    margin: const EdgeInsets.only(right: 2.0),
    child: Text(
      letter,
      style: const TextStyle(
        fontSize: 13.0,
        decoration: TextDecoration.underline,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1A237E),
      ),
    ),
  );
}

// ============================================================================
// SECTION 2: SUBMENUBUTTON & MENUITEMBUTTON
// Palette: teal / cyan
// ============================================================================

Widget _section2SubmenuAndItems(List<Map<String, dynamic>> fileMenuItems) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: const Color(0xFFE0F2F1),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFF4DB6AC), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SECTION 2: SubmenuButton & MenuItemButton',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF004D40),
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'A simulated "open" File menu drawn statically. In real Flutter '
          'this surface is rendered by SubmenuButton when its trigger is '
          'activated; here we draw the same layout as a snapshot.',
          style: TextStyle(fontSize: 12.0, color: Color(0xFF455A64)),
        ),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trigger button mock
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00897B),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: const Text(
                    'File',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                    ),
                  ),
                ),
                const SizedBox(height: 4.0),
                Container(
                  width: 0.0,
                  height: 12.0,
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                          color: const Color(0xFF00897B), width: 2.0),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 24.0),
            // Fake open menu
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                      color: const Color(0xFFB2DFDB), width: 1.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 8.0,
                      offset: Offset(0.0, 4.0),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    for (final item in fileMenuItems) _menuItemRow(item),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        _recipeCard(
          'MenuItemButton with shortcut',
          'MenuItemButton(leadingIcon: Icon(...), shortcut: '
              'SingleActivator(...), child: ..., onPressed: () {})',
          'leadingIcon, child, trailingIcon and shortcut compose the row.',
          const Color(0xFF00695C),
        ),
      ],
    ),
  );
}

Widget _menuItemRow(Map<String, dynamic> item) {
  final iconMap = <String, IconData>{
    'note_add': Icons.note_add,
    'folder_open': Icons.folder_open,
    'save': Icons.save,
    'save_as': Icons.save_as,
    'print': Icons.print,
    'logout': Icons.logout,
  };
  final icon = iconMap[item['leading'] as String] ?? Icons.circle;
  final rawLabel = item['label'] as String;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    child: Row(
      children: [
        Icon(icon, size: 16.0, color: const Color(0xFF00695C)),
        const SizedBox(width: 10.0),
        Expanded(child: _acceleratorText(rawLabel, const Color(0xFF263238))),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: const Color(0xFFE0F2F1),
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
                color: const Color(0xFF80CBC4), width: 1.0),
          ),
          child: Text(
            item['shortcut'] as String,
            style: const TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              color: Color(0xFF00695C),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _acceleratorText(String raw, Color color) {
  final spans = <TextSpan>[];
  var i = 0;
  while (i < raw.length) {
    final ch = raw[i];
    if (ch == '&' && i + 1 < raw.length) {
      final next = raw[i + 1];
      spans.add(TextSpan(
        text: next,
        style: TextStyle(
          color: color,
          fontSize: 13.0,
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.w600,
        ),
      ));
      i += 2;
    } else {
      spans.add(TextSpan(
        text: ch,
        style: TextStyle(color: color, fontSize: 13.0),
      ));
      i += 1;
    }
  }
  return RichText(text: TextSpan(children: spans));
}

// ============================================================================
// SECTION 3: NESTED SUBMENUS
// Palette: green
// ============================================================================

Widget _section3NestedSubmenus(List<Map<String, dynamic>> recentFiles) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: const Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFF81C784), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SECTION 3: Nested Submenus',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B5E20),
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'SubmenuButton inside SubmenuButton produces a sideways flyout. '
          'The chevron icon hints at the nested submenu; the inner surface '
          'opens to the right and inherits MenuStyle from the parent.',
          style: TextStyle(fontSize: 12.0, color: Color(0xFF455A64)),
        ),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Parent menu
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                      color: const Color(0xFFC8E6C9), width: 1.0),
                ),
                child: Column(
                  children: [
                    _nestedRow('New', false, const Color(0xFF1B5E20)),
                    _nestedRow('Open', false, const Color(0xFF1B5E20)),
                    _nestedRow('Recent Files', true,
                        const Color(0xFF1B5E20), highlight: true),
                    _nestedRow('Save', false, const Color(0xFF1B5E20)),
                    _nestedRow('Exit', false, const Color(0xFF1B5E20)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            const Icon(Icons.arrow_forward,
                color: Color(0xFF388E3C), size: 22.0),
            const SizedBox(width: 12.0),
            // Nested submenu (recent files)
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                      color: const Color(0xFFA5D6A7), width: 1.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 6.0,
                      offset: Offset(0.0, 3.0),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    for (final r in recentFiles)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Row(
                          children: [
                            const Icon(Icons.insert_drive_file,
                                size: 14.0, color: Color(0xFF388E3C)),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Text(
                                r['name'] as String,
                                style: const TextStyle(fontSize: 12.0),
                              ),
                            ),
                            Text(
                              r['mod'] as String,
                              style: const TextStyle(
                                fontSize: 10.0,
                                color: Color(0xFF757575),
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        _recipeCard(
          'Nested submenu',
          'SubmenuButton(menuChildren: [SubmenuButton(menuChildren: [...])])',
          'Chevron auto-renders; nested panel opens sideways.',
          const Color(0xFF2E7D32),
        ),
      ],
    ),
  );
}

Widget _nestedRow(String label, bool hasChevron, Color color,
    {bool highlight = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    color: highlight ? const Color(0xFFC8E6C9) : null,
    child: Row(
      children: [
        Expanded(
          child: Text(label, style: TextStyle(fontSize: 13.0, color: color)),
        ),
        if (hasChevron)
          const Icon(Icons.chevron_right, size: 16.0, color: Color(0xFF388E3C)),
      ],
    ),
  );
}

// ============================================================================
// SECTION 4: MENUACCELERATORLABEL + CALLBACK BINDING
// Palette: amber / orange
// ============================================================================

Widget _section4Accelerators() {
  final samples = <Map<String, dynamic>>[
    {'label': '&File', 'mnemonic': 'F', 'rendered': 'File'},
    {'label': '&Edit', 'mnemonic': 'E', 'rendered': 'Edit'},
    {'label': '&Save', 'mnemonic': 'S', 'rendered': 'Save'},
    {'label': 'Save &As...', 'mnemonic': 'A', 'rendered': 'Save As...'},
    {'label': 'Cop&y', 'mnemonic': 'y', 'rendered': 'Copy'},
    {'label': '&&Ampersand', 'mnemonic': '-', 'rendered': '&Ampersand'},
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFFFFB74D), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SECTION 4: MenuAcceleratorLabel & Callback Binding',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE65100),
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'A MenuAcceleratorLabel parses an & marker in the source string '
          'and underlines the next character as the mnemonic. The '
          'MenuAcceleratorCallbackBinding inherited widget gives the label '
          'access to the MenuItemButton.onPressed it should fire when the '
          'Alt+letter shortcut is pressed.',
          style: TextStyle(fontSize: 12.0, color: Color(0xFF5D4037)),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Row(
                children: const [
                  Expanded(
                    flex: 2,
                    child: Text('Source',
                        style: TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text('Rendered',
                        style: TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text('Mnemonic',
                        style: TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const Divider(height: 12.0),
              for (final s in samples)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          s['label'] as String,
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: _acceleratorText(
                            s['label'] as String, const Color(0xFFE65100)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 24.0,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF8F00),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            s['mnemonic'] as String,
                            style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        // Callback binding diagram
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFE0B2),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'MenuAcceleratorCallbackBinding flow',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Color(0xFF6D4C41),
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  _flowNode('Alt+S', const Color(0xFFFFB300)),
                  const Icon(Icons.arrow_forward,
                      color: Color(0xFF8D6E63), size: 18.0),
                  _flowNode('MenuAcceleratorLabel', const Color(0xFFFF8F00)),
                  const Icon(Icons.arrow_forward,
                      color: Color(0xFF8D6E63), size: 18.0),
                  _flowNode(
                      'CallbackBinding.of', const Color(0xFFEF6C00)),
                  const Icon(Icons.arrow_forward,
                      color: Color(0xFF8D6E63), size: 18.0),
                  _flowNode('onPressed()', const Color(0xFFE65100)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        _recipeCard(
          'Accelerator label',
          'MenuAcceleratorLabel("&Save")',
          'Underlines S; Alt+S triggers the bound MenuItemButton.onPressed.',
          const Color(0xFFE65100),
        ),
      ],
    ),
  );
}

Widget _flowNode(String label, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4.0),
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 10.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

// ============================================================================
// SECTION 5: MENUSTYLE THEMING
// Palette: purple
// ============================================================================

Widget _section5MenuStyle(
  List<Map<String, dynamic>> variants,
  MenuBar styledBar,
) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: const Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFFCE93D8), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SECTION 5: MenuStyle Theming',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6A1B9A),
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'MenuStyle is a ButtonStyle-like container of WidgetStateProperty '
          'values. backgroundColor, elevation, padding, alignment and shape '
          'are the most-used fields. Below: four palette presets rendered '
          'on top of identical menu rows.',
          style: TextStyle(fontSize: 12.0, color: Color(0xFF4A148C)),
        ),
        const SizedBox(height: 14.0),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12.0,
          crossAxisSpacing: 12.0,
          childAspectRatio: 1.4,
          children: [
            for (final v in variants) _styleVariantCard(v),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFE1BEE7),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              const Icon(Icons.palette,
                  color: Color(0xFF6A1B9A), size: 18.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Constructed styled MenuBar: ${styledBar.runtimeType} '
                  'with elevation ${styledBar.style?.elevation?.resolve(<WidgetState>{}) ?? "default"}',
                  style: const TextStyle(
                      fontSize: 12.0, fontFamily: 'monospace'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        _recipeCard(
          'Themed surface',
          'MenuStyle(backgroundColor: WidgetStatePropertyAll(Color(...)))',
          'Use WidgetStatePropertyAll for state-invariant values.',
          const Color(0xFF6A1B9A),
        ),
      ],
    ),
  );
}

Widget _styleVariantCard(Map<String, dynamic> v) {
  final background = v['background'] as Color;
  final isDark = background.computeLuminance() < 0.4;
  final textColor =
      isDark ? const Color(0xFFFFFFFF) : const Color(0xFF263238);
  return Container(
    padding: EdgeInsets.all(v['padding'] as double),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: v['border'] as Color, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: const Color(0x33000000),
          blurRadius: (v['elevation'] as double),
          offset: Offset(0.0, (v['elevation'] as double) / 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          v['name'] as String,
          style: TextStyle(
            color: textColor,
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6.0),
        _styleRow('New', textColor),
        _styleRow('Open', textColor),
        _styleRow('Save', textColor),
        const Spacer(),
        Text(
          'elev ${v['elevation']}  pad ${v['padding']}',
          style: TextStyle(
            color: textColor,
            fontSize: 10.0,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _styleRow(String label, Color textColor) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1.0),
    child: Row(
      children: [
        Icon(Icons.circle, size: 6.0, color: textColor),
        const SizedBox(width: 6.0),
        Text(label, style: TextStyle(color: textColor, fontSize: 11.0)),
      ],
    ),
  );
}

// ============================================================================
// SECTION 6: MENUANCHOR PLACEMENTS
// Palette: pink / red
// ============================================================================

Widget _section6MenuAnchor(
  List<Map<String, dynamic>> placements,
  String anchorTypeName,
) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFCE4EC),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFFF48FB1), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SECTION 6: MenuAnchor Placement',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFAD1457),
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'MenuAnchor decouples the trigger from the menu surface. The '
          'builder returns the anchor widget; alignmentOffset and '
          'menuChildren control where the menu appears relative to it.',
          style: TextStyle(fontSize: 12.0, color: Color(0xFF880E4F)),
        ),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placement grid - 3x3 alignment dot map
            Expanded(
              flex: 3,
              child: Container(
                height: 200.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                      color: const Color(0xFFF8BBD9), width: 1.0),
                ),
                child: Stack(
                  children: [
                    for (final p in placements)
                      Align(
                        alignment: Alignment(
                          (p['x'] as double) * 2.0 - 1.0,
                          (p['y'] as double) * 2.0 - 1.0,
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(6.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6.0, vertical: 3.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEC407A),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            p['name'] as String,
                            style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 14.0),
            // Description table
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final p in placements)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: Row(
                        children: [
                          Container(
                            width: 90.0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6.0, vertical: 3.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8BBD9),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              p['name'] as String,
                              style: const TextStyle(
                                fontSize: 11.0,
                                fontFamily: 'monospace',
                                color: Color(0xFFAD1457),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Text(
                              p['desc'] as String,
                              style: const TextStyle(fontSize: 11.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF8BBD9),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Constructed anchor type: $anchorTypeName',
            style: const TextStyle(
              fontSize: 12.0,
              fontFamily: 'monospace',
              color: Color(0xFFAD1457),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        _recipeCard(
          'Custom anchor flyout',
          'MenuAnchor(controller: c, builder: (...) => IconButton(...))',
          'controller.open() / close() drive visibility imperatively.',
          const Color(0xFFAD1457),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 7: MENUCONTROLLER STATE
// Palette: deep blue / cyan
// ============================================================================

Widget _section7MenuController(bool openA, bool openB) {
  final timeline = <Map<String, dynamic>>[
    {'t': 't=0', 'event': 'created', 'isOpen': false},
    {'t': 't=1', 'event': 'open()', 'isOpen': true},
    {'t': 't=2', 'event': 'hover→next', 'isOpen': true},
    {'t': 't=3', 'event': 'select', 'isOpen': true},
    {'t': 't=4', 'event': 'close()', 'isOpen': false},
  ];

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: const Color(0xFFE0F7FA),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFF4DD0E1), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SECTION 7: MenuController State',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF006064),
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'A MenuController exposes open(), close(), isOpen and a few '
          'imperative knobs. Below is a snapshot of two controllers and a '
          'fake timeline of state transitions.',
          style: TextStyle(fontSize: 12.0, color: Color(0xFF004D40)),
        ),
        const SizedBox(height: 14.0),
        Row(
          children: [
            Expanded(
              child: _controllerCard('controller A', openA,
                  const Color(0xFF00ACC1)),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: _controllerCard('controller B', openB,
                  const Color(0xFF00838F)),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Timeline (illustrative)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Color(0xFF006064),
                ),
              ),
              const SizedBox(height: 8.0),
              for (final s in timeline)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50.0,
                        child: Text(s['t'] as String,
                            style: const TextStyle(
                                fontSize: 11.0,
                                fontFamily: 'monospace',
                                color: Color(0xFF006064))),
                      ),
                      Expanded(
                        child: Text(s['event'] as String,
                            style: const TextStyle(fontSize: 12.0)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: (s['isOpen'] as bool)
                              ? const Color(0xFF00ACC1)
                              : const Color(0xFFB0BEC5),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          (s['isOpen'] as bool) ? 'OPEN' : 'closed',
                          style: const TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        _recipeCard(
          'Imperative menu control',
          'final c = MenuController(); c.open(); c.close();',
          'Pair with MenuAnchor to drive visibility from code.',
          const Color(0xFF006064),
        ),
      ],
    ),
  );
}

Widget _controllerCard(String label, bool isOpen, Color color) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 12.0,
              height: 12.0,
              decoration: BoxDecoration(
                color: isOpen ? color : const Color(0xFFCFD8DC),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              label,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          'isOpen: ${isOpen ? "true" : "false"}',
          style: const TextStyle(fontSize: 11.0, fontFamily: 'monospace'),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Created at script init; no UI mounted yet.',
          style: TextStyle(
            fontSize: 10.0,
            color: const Color(0xFF607D8B),
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 8: WIDGET COMPARISON TABLE
// Palette: slate / dark
// ============================================================================

Widget _section8Comparison(List<Map<String, dynamic>> rows) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: const Color(0xFFECEFF1),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFF90A4AE), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SECTION 8: API Comparison',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF263238),
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'At a glance: which widget owns which responsibility.',
          style: TextStyle(fontSize: 12.0, color: Color(0xFF455A64)),
        ),
        const SizedBox(height: 14.0),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 8.0),
                decoration: const BoxDecoration(
                  color: Color(0xFF455A64),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Row(
                  children: const [
                    Expanded(
                      flex: 2,
                      child: Text('Widget',
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text('Role',
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text('Children',
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text('Opens',
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              for (var i = 0; i < rows.length; i++)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 6.0),
                  color: i.isEven
                      ? const Color(0xFFF5F5F5)
                      : const Color(0xFFFFFFFF),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          rows[i]['widget'] as String,
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF263238),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          rows[i]['role'] as String,
                          style: const TextStyle(fontSize: 11.0),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          rows[i]['children'] as String,
                          style: const TextStyle(
                              fontSize: 11.0, fontFamily: 'monospace'),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          rows[i]['opens'] as String,
                          style: const TextStyle(fontSize: 11.0),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 9: RECIPE CARDS
// Palette: brown / sand
// ============================================================================

Widget _section9Recipes(List<Map<String, dynamic>> recipes) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: const Color(0xFFEFEBE9),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFFA1887F), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SECTION 9: Recipe Cards',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4E342E),
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Copy-paste blueprints for common menu compositions.',
          style: TextStyle(fontSize: 12.0, color: Color(0xFF6D4C41)),
        ),
        const SizedBox(height: 14.0),
        for (final r in recipes)
          _recipeCard(
            r['title'] as String,
            r['snippet'] as String,
            r['note'] as String,
            const Color(0xFF5D4037),
          ),
      ],
    ),
  );
}

Widget _recipeCard(String title, String snippet, String note, Color accent) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withOpacity(0.4), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: const Text(
                'RECIPE',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 9.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: const Color(0xFF263238),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            snippet,
            style: const TextStyle(
              color: Color(0xFFB0BEC5),
              fontSize: 11.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          note,
          style: const TextStyle(
              fontSize: 11.0,
              color: Color(0xFF455A64),
              fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 10: GLOSSARY
// Palette: dark navy
// ============================================================================

Widget _section10Glossary(List<Map<String, dynamic>> entries) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: const Color(0xFF1A237E),
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.menu_book, color: Color(0xFFFFFFFF), size: 22.0),
            SizedBox(width: 10.0),
            Text(
              'SECTION 10: Glossary',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        for (final e in entries)
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e['term'] as String,
                    style: const TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    e['def'] as String,
                    style: const TextStyle(
                        color: Color(0xFFC5CAE9),
                        fontSize: 12.0,
                        height: 1.4),
                  ),
                ],
              ),
            ),
          ),
      ],
    ),
  );
}

// ============================================================================
// EPILOGUE
// ============================================================================

Widget _epilogue() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF311B92), Color(0xFF512DA8), Color(0xFF673AB7)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Epilogue: When to reach for which menu API',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12.0),
        _epilogueItem('MenuBar',
            'Whenever you need a desktop-style horizontal menu strip.'),
        _epilogueItem('SubmenuButton',
            'For grouping related actions under a single top-level header.'),
        _epilogueItem('MenuItemButton',
            'For leaf actions; supports leadingIcon, shortcut and trailingIcon.'),
        _epilogueItem('MenuAcceleratorLabel',
            'Whenever a label needs Alt-letter mnemonic underlining.'),
        _epilogueItem('MenuAnchor + MenuController',
            'For custom triggers (icon, gesture, programmatic).'),
        _epilogueItem('MenuStyle',
            'To re-skin menu surfaces consistently across hover/pressed states.'),
        const SizedBox(height: 12.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'All menu surfaces shown here are static snapshots: the live '
            'open/close behavior requires a running MenuController bound '
            'into an interactive widget tree.',
            style: TextStyle(color: Color(0xFFEDE7F6), fontSize: 12.0),
          ),
        ),
      ],
    ),
  );
}

Widget _epilogueItem(String widgetName, String advice) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: const Color(0x55FFFFFF),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            widgetName,
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            advice,
            style: const TextStyle(color: Color(0xFFEDE7F6), fontSize: 12.0),
          ),
        ),
      ],
    ),
  );
}
