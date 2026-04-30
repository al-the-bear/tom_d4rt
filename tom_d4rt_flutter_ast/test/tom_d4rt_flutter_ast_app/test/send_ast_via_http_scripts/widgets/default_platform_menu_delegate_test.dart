// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_element, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings, unnecessary_lambdas, dead_code, prefer_const_declarations
import 'package:flutter/material.dart';

// ============================================================================
// DEMO: DefaultPlatformMenuDelegate
//
// DefaultPlatformMenuDelegate is the default implementation of
// PlatformMenuDelegate that bridges Flutter's platform menu system to the
// underlying OS. It handles translating MenuItem/PlatformMenuBar definitions
// into native platform menus (macOS menu bar, etc.).
//
// This demo visualises the concepts behind platform menu delegation:
//   1. How menu hierarchies are structured (PlatformMenuBar → PlatformMenu → items)
//   2. How delegates translate abstract menu trees into native representations
//   3. Menu item types: PlatformMenuItemGroup, PlatformMenuItem, PlatformMenu
//   4. Shortcut activation and keyboard accelerator binding
//   5. Menu state management (enabled/disabled, checked state)
//   6. Dynamic menu updates and structural mutation
//   7. Platform menu lifecycle and disposal
//   8. Menu item callbacks and action routing
//   9. Nested submenu hierarchies with visual tree rendering
//
// We use only visual Flutter widgets (no actual native menu calls) to
// illustrate the delegation model, making this safe on all platforms.
// ============================================================================

// ---------------------------------------------------------------------------
// Colour palette – Green / Lime
// ---------------------------------------------------------------------------
const Color _pmPrimary = Color(0xFF388E3C);
const Color _pmPrimaryLight = Color(0xFF66BB6A);
const Color _pmAccent = Color(0xFFCDDC39);
const Color _pmAccentDark = Color(0xFFAFB42B);
const Color _pmSurface = Color(0xFFF1F8E9);
const Color _pmSurfaceDark = Color(0xFFDCEDC8);
const Color _pmOnPrimary = Color(0xFFFFFFFF);
const Color _pmTextDark = Color(0xFF1B5E20);
const Color _pmTextMedium = Color(0xFF558B2F);
const Color _pmDivider = Color(0xFFC5E1A5);
const Color _pmError = Color(0xFFD32F2F);
const Color _pmSuccess = Color(0xFF2E7D32);
const Color _pmDisabled = Color(0xFFBDBDBD);

// ---------------------------------------------------------------------------
// Data model for menu tree visualisation
// ---------------------------------------------------------------------------
class _PmMenuEntry {
  final String label;
  final String? shortcut;
  final bool enabled;
  final bool checked;
  final IconData? icon;
  final List<_PmMenuEntry> children;
  final bool isDivider;

  const _PmMenuEntry({
    this.label = '',
    this.shortcut,
    this.enabled = true,
    this.checked = false,
    this.icon,
    this.children = const [],
    this.isDivider = false,
  });
}

// ---------------------------------------------------------------------------
// Sample menu hierarchy representing a typical platform menu bar
// ---------------------------------------------------------------------------
const List<_PmMenuEntry> _pmSampleMenuBar = [
  _PmMenuEntry(
    label: 'File',
    icon: Icons.folder_outlined,
    children: [
      _PmMenuEntry(label: 'New', shortcut: '⌘N', icon: Icons.note_add_outlined),
      _PmMenuEntry(label: 'Open...', shortcut: '⌘O', icon: Icons.folder_open_outlined),
      _PmMenuEntry(label: 'Open Recent', icon: Icons.history, children: [
        _PmMenuEntry(label: 'project_alpha.dart'),
        _PmMenuEntry(label: 'main.dart'),
        _PmMenuEntry(label: 'pubspec.yaml'),
        _PmMenuEntry(isDivider: true),
        _PmMenuEntry(label: 'Clear Recent'),
      ]),
      _PmMenuEntry(isDivider: true),
      _PmMenuEntry(label: 'Save', shortcut: '⌘S', icon: Icons.save_outlined),
      _PmMenuEntry(label: 'Save As...', shortcut: '⇧⌘S', icon: Icons.save_as_outlined),
      _PmMenuEntry(isDivider: true),
      _PmMenuEntry(label: 'Close', shortcut: '⌘W'),
      _PmMenuEntry(label: 'Quit', shortcut: '⌘Q', icon: Icons.exit_to_app),
    ],
  ),
  _PmMenuEntry(
    label: 'Edit',
    icon: Icons.edit_outlined,
    children: [
      _PmMenuEntry(label: 'Undo', shortcut: '⌘Z', icon: Icons.undo),
      _PmMenuEntry(label: 'Redo', shortcut: '⇧⌘Z', icon: Icons.redo),
      _PmMenuEntry(isDivider: true),
      _PmMenuEntry(label: 'Cut', shortcut: '⌘X', icon: Icons.content_cut),
      _PmMenuEntry(label: 'Copy', shortcut: '⌘C', icon: Icons.content_copy),
      _PmMenuEntry(label: 'Paste', shortcut: '⌘V', icon: Icons.content_paste),
      _PmMenuEntry(isDivider: true),
      _PmMenuEntry(label: 'Select All', shortcut: '⌘A'),
      _PmMenuEntry(label: 'Find...', shortcut: '⌘F', icon: Icons.search),
    ],
  ),
  _PmMenuEntry(
    label: 'View',
    icon: Icons.visibility_outlined,
    children: [
      _PmMenuEntry(label: 'Toolbar', checked: true),
      _PmMenuEntry(label: 'Sidebar', checked: true),
      _PmMenuEntry(label: 'Status Bar', checked: false),
      _PmMenuEntry(isDivider: true),
      _PmMenuEntry(label: 'Zoom In', shortcut: '⌘+', icon: Icons.zoom_in),
      _PmMenuEntry(label: 'Zoom Out', shortcut: '⌘-', icon: Icons.zoom_out),
      _PmMenuEntry(label: 'Reset Zoom', shortcut: '⌘0'),
    ],
  ),
  _PmMenuEntry(
    label: 'Help',
    icon: Icons.help_outline,
    children: [
      _PmMenuEntry(label: 'Documentation', icon: Icons.menu_book_outlined),
      _PmMenuEntry(label: 'Release Notes', icon: Icons.new_releases_outlined),
      _PmMenuEntry(isDivider: true),
      _PmMenuEntry(label: 'About', icon: Icons.info_outline),
    ],
  ),
];

// ---------------------------------------------------------------------------
// Helper: build a colour-coded badge
// ---------------------------------------------------------------------------
Widget _pmBadge(String text, Color bg, Color fg) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(text, style: TextStyle(fontSize: 10, color: fg, fontWeight: FontWeight.w600)),
  );
}

// ---------------------------------------------------------------------------
// Helper: section title
// ---------------------------------------------------------------------------
Widget _pmSectionTitle(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8, top: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: _pmPrimary),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: _pmTextDark,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Expanded(child: Divider(color: _pmDivider, thickness: 1)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: info card
// ---------------------------------------------------------------------------
Widget _pmInfoCard(String title, String body, IconData icon, {Color? accent}) {
  final c = accent ?? _pmPrimary;
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: _pmSurface,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: c.withValues(alpha: 0.3)),
    ),
    padding: EdgeInsets.all(12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: c),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _pmTextDark)),
              SizedBox(height: 4),
              Text(body, style: TextStyle(fontSize: 12, color: _pmTextMedium, height: 1.4)),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: render a single menu item row
// ---------------------------------------------------------------------------
Widget _pmMenuItemRow(_PmMenuEntry entry, {int depth = 0}) {
  if (entry.isDivider) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0 + depth * 20.0),
      child: Divider(color: _pmDivider, height: 8, thickness: 1),
    );
  }
  final hasChildren = entry.children.isNotEmpty;
  return Container(
    margin: EdgeInsets.symmetric(vertical: 1),
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
      color: entry.enabled ? Colors.white : _pmSurface,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Row(
      children: [
        SizedBox(width: depth * 20.0),
        if (entry.icon != null) ...[
          Icon(entry.icon, size: 16, color: entry.enabled ? _pmPrimary : _pmDisabled),
          SizedBox(width: 8),
        ],
        if (entry.checked) ...[
          Icon(Icons.check, size: 14, color: _pmSuccess),
          SizedBox(width: 4),
        ],
        Expanded(
          child: Text(
            entry.label,
            style: TextStyle(
              fontSize: 13,
              color: entry.enabled ? _pmTextDark : _pmDisabled,
              fontWeight: hasChildren ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
        if (entry.shortcut != null)
          Text(entry.shortcut!, style: TextStyle(fontSize: 11, color: _pmTextMedium, fontFamily: 'monospace')),
        if (hasChildren) Icon(Icons.chevron_right, size: 16, color: _pmTextMedium),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: recursively render menu tree
// ---------------------------------------------------------------------------
List<Widget> _pmRenderMenuTree(List<_PmMenuEntry> entries, {int depth = 0}) {
  final widgets = <Widget>[];
  for (final entry in entries) {
    widgets.add(_pmMenuItemRow(entry, depth: depth));
    if (entry.children.isNotEmpty) {
      widgets.addAll(_pmRenderMenuTree(entry.children, depth: depth + 1));
    }
  }
  return widgets;
}

// ---------------------------------------------------------------------------
// Section 1: Platform Menu Delegate Overview
// ---------------------------------------------------------------------------
Widget _pmSection1Overview() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _pmSectionTitle('1 · Platform Menu Delegate Overview', Icons.account_tree_outlined),
      _pmInfoCard(
        'What is DefaultPlatformMenuDelegate?',
        'The default implementation of PlatformMenuDelegate that translates '
            'Flutter menu definitions (PlatformMenuBar, PlatformMenu, PlatformMenuItem) '
            'into native platform menu calls. On macOS it creates the application '
            'menu bar; on other platforms it provides a fallback.',
        Icons.description_outlined,
      ),
      _pmInfoCard(
        'Delegation pattern',
        'PlatformMenuBar.setMenus() calls the delegate\'s setMenus() method, '
            'which serialises the menu hierarchy into a platform channel message. '
            'The delegate holds a reference to the current menu structure and '
            'manages incremental updates.',
        Icons.swap_horiz,
        accent: _pmAccentDark,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _pmDivider),
        ),
        child: Column(
          children: [
            Row(
              children: [
                _pmBadge('PlatformMenuBar', _pmPrimary, _pmOnPrimary),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward, size: 14, color: _pmTextMedium),
                SizedBox(width: 4),
                _pmBadge('Delegate', _pmAccentDark, _pmOnPrimary),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward, size: 14, color: _pmTextMedium),
                SizedBox(width: 4),
                _pmBadge('Platform', Color(0xFF1565C0), _pmOnPrimary),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Menu definitions flow through the delegate to the platform layer',
              style: TextStyle(fontSize: 11, color: _pmTextMedium, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 2: Menu Hierarchy Visualisation
// ---------------------------------------------------------------------------
Widget _pmSection2Hierarchy() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _pmSectionTitle('2 · Menu Hierarchy Visualisation', Icons.list_alt),
      _pmInfoCard(
        'Menu tree structure',
        'A PlatformMenuBar contains a list of top-level PlatformMenu objects. '
            'Each PlatformMenu can contain PlatformMenuItem entries, dividers '
            '(PlatformMenuItemGroup separators), or nested sub-PlatformMenu objects '
            'for cascading menus.',
        Icons.account_tree,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _pmDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.menu, size: 16, color: _pmPrimary),
                SizedBox(width: 6),
                Text('Menu Bar', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: _pmTextDark)),
              ],
            ),
            Divider(color: _pmDivider, height: 8),
            ..._pmRenderMenuTree(_pmSampleMenuBar),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 3: Menu Item Types
// ---------------------------------------------------------------------------
Widget _pmSection3ItemTypes() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _pmSectionTitle('3 · Menu Item Types', Icons.category_outlined),
      _pmInfoCard(
        'PlatformMenuItem',
        'A leaf menu item with a label, optional shortcut, and an onSelected '
            'callback. When the user selects it, the callback fires through the '
            'delegate\'s channel.',
        Icons.touch_app_outlined,
      ),
      _pmInfoCard(
        'PlatformMenu (submenu)',
        'A menu that itself contains children—either items, groups, or further '
            'submenus. Visually rendered as a cascading flyout on macOS.',
        Icons.subdirectory_arrow_right,
        accent: _pmAccentDark,
      ),
      _pmInfoCard(
        'PlatformMenuItemGroup',
        'A logical grouping of items separated by dividers above and below. '
            'The delegate serialises these as separator entries in the platform data.',
        Icons.view_agenda_outlined,
        accent: Color(0xFF00796B),
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _pmSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _pmDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type comparison', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _pmTextDark)),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Icon(Icons.touch_app, size: 28, color: _pmPrimary),
                      SizedBox(height: 4),
                      Text('MenuItem', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _pmTextDark)),
                      Text('leaf action', style: TextStyle(fontSize: 10, color: _pmTextMedium)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Icon(Icons.folder, size: 28, color: _pmAccentDark),
                      SizedBox(height: 4),
                      Text('Menu', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _pmTextDark)),
                      Text('submenu', style: TextStyle(fontSize: 10, color: _pmTextMedium)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Icon(Icons.view_agenda, size: 28, color: Color(0xFF00796B)),
                      SizedBox(height: 4),
                      Text('Group', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _pmTextDark)),
                      Text('divider group', style: TextStyle(fontSize: 10, color: _pmTextMedium)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 4: Shortcut Binding & Accelerators
// ---------------------------------------------------------------------------
Widget _pmSection4Shortcuts() {
  final shortcuts = <Map<String, String>>[
    {'action': 'New', 'key': '⌘N', 'type': 'SingleActivator'},
    {'action': 'Save', 'key': '⌘S', 'type': 'SingleActivator'},
    {'action': 'Undo', 'key': '⌘Z', 'type': 'SingleActivator'},
    {'action': 'Redo', 'key': '⇧⌘Z', 'type': 'CharacterActivator'},
    {'action': 'Find', 'key': '⌘F', 'type': 'SingleActivator'},
    {'action': 'Select All', 'key': '⌘A', 'type': 'SingleActivator'},
    {'action': 'Quit', 'key': '⌘Q', 'type': 'SingleActivator'},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _pmSectionTitle('4 · Shortcut Binding & Accelerators', Icons.keyboard_outlined),
      _pmInfoCard(
        'MenuSerializableShortcut',
        'Each PlatformMenuItem can carry a MenuSerializableShortcut (typically '
            'SingleActivator or CharacterActivator). The delegate serialises the '
            'trigger key + modifiers into the platform channel data so the OS '
            'can display the accelerator string and dispatch the shortcut.',
        Icons.shortcut,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _pmDivider),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(flex: 3, child: Text('Action', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11, color: _pmTextDark))),
                Expanded(flex: 2, child: Text('Shortcut', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11, color: _pmTextDark))),
                Expanded(flex: 3, child: Text('Activator', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11, color: _pmTextDark))),
              ],
            ),
            Divider(color: _pmDivider, height: 8),
            ...shortcuts.map((s) => Padding(
              padding: EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  Expanded(flex: 3, child: Text(s['action']!, style: TextStyle(fontSize: 12, color: _pmTextDark))),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _pmSurfaceDark,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(s['key']!, style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: _pmPrimary, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  Expanded(flex: 3, child: Text(s['type']!, style: TextStyle(fontSize: 11, color: _pmTextMedium))),
                ],
              ),
            )),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 5: Menu State Management
// ---------------------------------------------------------------------------
Widget _pmSection5StateManagement() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _pmSectionTitle('5 · Menu State Management', Icons.toggle_on_outlined),
      _pmInfoCard(
        'Enabled / disabled items',
        'Items can be disabled by setting PlatformMenuItem.onSelected to null. '
            'The delegate serialises the enabled flag to the platform, which greys '
            'out the item and ignores clicks.',
        Icons.block,
        accent: _pmError,
      ),
      _pmInfoCard(
        'Checked state',
        'Some platforms support checked menu items (toggle-style). The delegate '
            'passes through a checked flag that renders as a checkmark next to the '
            'item text.',
        Icons.check_box_outlined,
        accent: _pmSuccess,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _pmDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('State examples', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _pmTextDark)),
            SizedBox(height: 8),
            _pmMenuItemRow(_PmMenuEntry(label: 'Enabled item', icon: Icons.check_circle_outline, enabled: true)),
            _pmMenuItemRow(_PmMenuEntry(label: 'Disabled item', icon: Icons.cancel_outlined, enabled: false)),
            _pmMenuItemRow(_PmMenuEntry(label: 'Checked item', checked: true, icon: Icons.visibility)),
            _pmMenuItemRow(_PmMenuEntry(label: 'Unchecked item', checked: false, icon: Icons.visibility_off)),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 6: Dynamic Menu Updates
// ---------------------------------------------------------------------------
Widget _pmSection6DynamicUpdates() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _pmSectionTitle('6 · Dynamic Menu Updates', Icons.refresh),
      _pmInfoCard(
        'Incremental mutations',
        'When PlatformMenuBar rebuilds with a modified menus list, the delegate '
            'compares the new tree to the previous one. Changed menus are '
            're-serialised and sent to the platform. Unchanged subtrees are skipped.',
        Icons.compare_arrows,
      ),
      _pmInfoCard(
        'setMenus() lifecycle',
        'Each call to delegate.setMenus() replaces the entire platform menu. '
            'The framework calls clearMenus() on dispose to remove the menu bar '
            'from the platform entirely.',
        Icons.loop,
        accent: _pmAccentDark,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _pmSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _pmDivider),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: _pmPrimary.withValues(alpha: 0.3)),
                        ),
                        child: Column(
                          children: [
                            Text('Before', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11, color: _pmPrimary)),
                            SizedBox(height: 4),
                            Text('File  Edit  View', style: TextStyle(fontSize: 11, color: _pmTextDark)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.arrow_forward, color: _pmAccentDark, size: 20),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: _pmAccentDark.withValues(alpha: 0.3)),
                        ),
                        child: Column(
                          children: [
                            Text('After', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11, color: _pmAccentDark)),
                            SizedBox(height: 4),
                            Text('File  Edit  View  Tools', style: TextStyle(fontSize: 11, color: _pmTextDark)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'setMenus() re-serialises the updated menu tree',
              style: TextStyle(fontSize: 11, color: _pmTextMedium, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 7: Platform Channel Serialisation
// ---------------------------------------------------------------------------
Widget _pmSection7Serialisation() {
  final channelFields = <Map<String, String>>[
    {'field': 'id', 'desc': 'Unique identifier per menu item'},
    {'field': 'label', 'desc': 'Displayed text of the item'},
    {'field': 'enabled', 'desc': 'Whether the item accepts clicks'},
    {'field': 'shortcutTrigger', 'desc': 'Key code for accelerator'},
    {'field': 'shortcutModifiers', 'desc': 'Modifier flags (ctrl, shift…)'},
    {'field': 'children', 'desc': 'Nested submenu entries'},
    {'field': 'isDivider', 'desc': 'Separator between groups'},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _pmSectionTitle('7 · Platform Channel Serialisation', Icons.code),
      _pmInfoCard(
        'Menu serialisation format',
        'The delegate flattens the menu tree into a Map<String, dynamic> '
            'hierarchy. Each node carries an id, label, enabled flag, shortcut '
            'data, and a children list. This map is sent via MethodChannel '
            'to the platform embedder.',
        Icons.data_object,
      ),
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _pmDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Serialised fields', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _pmTextDark)),
            Divider(color: _pmDivider, height: 12),
            ...channelFields.map((f) => Padding(
              padding: EdgeInsets.symmetric(vertical: 3),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: _pmSurfaceDark,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(f['field']!, style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: _pmPrimary, fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(width: 8),
                  Expanded(child: Text(f['desc']!, style: TextStyle(fontSize: 11, color: _pmTextMedium))),
                ],
              ),
            )),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 8: Callback Routing & Action Dispatch
// ---------------------------------------------------------------------------
Widget _pmSection8Callbacks() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _pmSectionTitle('8 · Callback Routing & Action Dispatch', Icons.call_split),
      _pmInfoCard(
        'onSelected callbacks',
        'Every PlatformMenuItem has an onSelected callback. When the native '
            'platform notifies Flutter that a menu item was selected (via platform '
            'channel), the delegate looks up the item by id and invokes its callback.',
        Icons.play_arrow_outlined,
      ),
      _pmInfoCard(
        'Action integration',
        'Menu items can also be backed by Intent/Action pairs. The delegate '
            'respects the action\'s isEnabled property to dynamically toggle menu '
            'item availability.',
        Icons.integration_instructions,
        accent: _pmAccentDark,
      ),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _pmDivider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Callback flow', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _pmTextDark)),
            SizedBox(height: 8),
            Row(
              children: [
                _pmBadge('User clicks', _pmPrimary, _pmOnPrimary),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward, size: 12, color: _pmTextMedium),
                SizedBox(width: 4),
                _pmBadge('Platform', Color(0xFF1565C0), _pmOnPrimary),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward, size: 12, color: _pmTextMedium),
                SizedBox(width: 4),
                _pmBadge('Channel', _pmAccentDark, _pmOnPrimary),
              ],
            ),
            SizedBox(height: 6),
            Row(
              children: [
                SizedBox(width: 40),
                Icon(Icons.arrow_forward, size: 12, color: _pmTextMedium),
                SizedBox(width: 4),
                _pmBadge('Delegate', Color(0xFF6A1B9A), _pmOnPrimary),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward, size: 12, color: _pmTextMedium),
                SizedBox(width: 4),
                _pmBadge('onSelected()', _pmSuccess, _pmOnPrimary),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 9: Complete Delegate Lifecycle
// ---------------------------------------------------------------------------
Widget _pmSection9Lifecycle() {
  final phases = <Map<String, dynamic>>[
    {'label': 'Widget mounts', 'icon': Icons.play_circle_outline, 'color': _pmSuccess, 'desc': 'PlatformMenuBar inserted into widget tree'},
    {'label': 'setMenus()', 'icon': Icons.upload, 'color': _pmPrimary, 'desc': 'Delegate serialises & sends to platform'},
    {'label': 'Update', 'icon': Icons.refresh, 'color': _pmAccentDark, 'desc': 'Menu tree changes → setMenus() called again'},
    {'label': 'User selects', 'icon': Icons.touch_app, 'color': Color(0xFF1565C0), 'desc': 'Platform notifies → callback invoked'},
    {'label': 'clearMenus()', 'icon': Icons.delete_outline, 'color': _pmError, 'desc': 'Widget disposes → menu removed from platform'},
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16),
      _pmSectionTitle('9 · Complete Delegate Lifecycle', Icons.timeline),
      _pmInfoCard(
        'Full lifecycle',
        'The delegate manages the entire lifespan of the platform menu: '
            'creation, updates, callback dispatch, and teardown. Understanding '
            'this lifecycle is essential for correct menu management.',
        Icons.autorenew,
      ),
      ...phases.map((p) {
        final color = p['color'] as Color;
        return Container(
          margin: EdgeInsets.only(bottom: 6),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border(left: BorderSide(color: color, width: 3)),
          ),
          child: Row(
            children: [
              Icon(p['icon'] as IconData, size: 20, color: color),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p['label'] as String, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: _pmTextDark)),
                    SizedBox(height: 2),
                    Text(p['desc'] as String, style: TextStyle(fontSize: 11, color: _pmTextMedium)),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
      SizedBox(height: 12),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_pmPrimary.withValues(alpha: 0.08), _pmAccent.withValues(alpha: 0.08)],
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _pmPrimary.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(Icons.menu_open, size: 32, color: _pmPrimary),
            SizedBox(height: 8),
            Text(
              'DefaultPlatformMenuDelegate',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: _pmTextDark),
            ),
            SizedBox(height: 4),
            Text(
              'Bridges Flutter\'s declarative PlatformMenuBar widget to the native '
              'platform menu system through structured serialisation and callback routing.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: _pmTextMedium, height: 1.4),
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// MAIN BUILD
// ============================================================================
dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Header ──────────────────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_pmPrimary, _pmPrimaryLight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.menu_open, color: _pmOnPrimary, size: 28),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'DefaultPlatformMenuDelegate',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _pmOnPrimary,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                'Platform menu bridge — translating declarative menu trees into native menus',
                style: TextStyle(fontSize: 12, color: _pmOnPrimary.withValues(alpha: 0.85)),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // ── Sections ────────────────────────────────────────────────────
        _pmSection1Overview(),
        _pmSection2Hierarchy(),
        _pmSection3ItemTypes(),
        _pmSection4Shortcuts(),
        _pmSection5StateManagement(),
        _pmSection6DynamicUpdates(),
        _pmSection7Serialisation(),
        _pmSection8Callbacks(),
        _pmSection9Lifecycle(),

        SizedBox(height: 24),
      ],
    ),
  );
}
