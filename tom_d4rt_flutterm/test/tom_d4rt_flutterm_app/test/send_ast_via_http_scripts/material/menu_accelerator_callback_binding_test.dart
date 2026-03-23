// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests MenuAcceleratorCallbackBinding from material
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.indigo.shade700,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget buildInfoCard(String label, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildShortcutBadge(String shortcut, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: color.withAlpha(100)),
    ),
    child: Text(
      shortcut,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: color,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget buildAcceleratorOverview() {
  print('Building accelerator binding overview');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.keyboard, color: Colors.indigo.shade700, size: 28),
            SizedBox(width: 12),
            Text(
              'MenuAcceleratorCallbackBinding',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'InheritedWidget that binds keyboard accelerator callbacks to menu items. '
          'It enables underlined accelerator hints in menu labels and connects '
          'keyboard shortcuts to their corresponding menu actions.',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16),
        buildInfoCard('Type', 'InheritedWidget'),
        buildInfoCard(
          'Purpose',
          'Bind keyboard accelerators to menu callbacks',
        ),
        buildInfoCard('Key Feature', 'Alt+key navigation for menu items'),
        buildInfoCard('Usage', 'Wrap MenuBar or menu item tree'),
      ],
    ),
  );
}

Widget buildMenuItemWithShortcut(
  String label,
  String shortcut,
  IconData icon,
  Color color,
) {
  print('Building menu item: $label with shortcut $shortcut');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        buildShortcutBadge(shortcut, color),
      ],
    ),
  );
}

Widget buildBasicMenuBarDemo() {
  print('Building basic MenuBar with accelerators demo');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MenuBar with Accelerator Items',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Standard file menu pattern with keyboard shortcuts',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        MenuBar(
          children: [
            SubmenuButton(
              menuChildren: [
                MenuItemButton(
                  shortcut: SingleActivator(
                    LogicalKeyboardKey.keyN,
                    control: true,
                  ),
                  onPressed: () {
                    print('New file');
                  },
                  child: Text('New'),
                ),
                MenuItemButton(
                  shortcut: SingleActivator(
                    LogicalKeyboardKey.keyO,
                    control: true,
                  ),
                  onPressed: () {
                    print('Open file');
                  },
                  child: Text('Open'),
                ),
                MenuItemButton(
                  shortcut: SingleActivator(
                    LogicalKeyboardKey.keyS,
                    control: true,
                  ),
                  onPressed: () {
                    print('Save file');
                  },
                  child: Text('Save'),
                ),
                MenuItemButton(
                  shortcut: SingleActivator(
                    LogicalKeyboardKey.keyS,
                    control: true,
                    shift: true,
                  ),
                  onPressed: () {
                    print('Save As');
                  },
                  child: Text('Save As...'),
                ),
              ],
              child: Text('File'),
            ),
            SubmenuButton(
              menuChildren: [
                MenuItemButton(
                  shortcut: SingleActivator(
                    LogicalKeyboardKey.keyZ,
                    control: true,
                  ),
                  onPressed: () {
                    print('Undo');
                  },
                  child: Text('Undo'),
                ),
                MenuItemButton(
                  shortcut: SingleActivator(
                    LogicalKeyboardKey.keyY,
                    control: true,
                  ),
                  onPressed: () {
                    print('Redo');
                  },
                  child: Text('Redo'),
                ),
              ],
              child: Text('Edit'),
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'Simulated Menu Items:',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        buildMenuItemWithShortcut('New', 'Ctrl+N', Icons.add, Colors.blue),
        buildMenuItemWithShortcut(
          'Open',
          'Ctrl+O',
          Icons.folder_open,
          Colors.orange,
        ),
        buildMenuItemWithShortcut('Save', 'Ctrl+S', Icons.save, Colors.green),
        buildMenuItemWithShortcut(
          'Save As...',
          'Ctrl+Shift+S',
          Icons.save_as,
          Colors.teal,
        ),
      ],
    ),
  );
}

Widget buildShortcutLabelDisplay() {
  print('Building shortcut label display section');
  List<String> labels = ['New', 'Open', 'Save', 'Print', 'Exit'];
  List<String> shortcuts = ['Ctrl+N', 'Ctrl+O', 'Ctrl+S', 'Ctrl+P', 'Alt+F4'];
  List<IconData> icons = [
    Icons.insert_drive_file,
    Icons.folder_open,
    Icons.save,
    Icons.print,
    Icons.exit_to_app,
  ];
  List<MaterialColor> colors = [
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.purple,
    Colors.red,
  ];

  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < labels.length; i = i + 1) {
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors[i].shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colors[i].shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: colors[i].shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icons[i], color: colors[i].shade700, size: 20),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                labels[i],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: colors[i].shade800,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                shortcuts[i],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Shortcut Label Display',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'MenuItemButton displays shortcut labels when specified',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

Widget buildEditMenuWithShortcuts() {
  print('Building edit menu with shortcuts');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Edit Menu Shortcuts',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Common editing operations with standard keyboard shortcuts',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        buildMenuItemWithShortcut('Undo', 'Ctrl+Z', Icons.undo, Colors.blue),
        buildMenuItemWithShortcut(
          'Redo',
          'Ctrl+Y',
          Icons.redo,
          Colors.blue.shade700,
        ),
        SizedBox(height: 8),
        Divider(color: Colors.grey.shade300),
        SizedBox(height: 8),
        buildMenuItemWithShortcut(
          'Cut',
          'Ctrl+X',
          Icons.content_cut,
          Colors.orange,
        ),
        buildMenuItemWithShortcut(
          'Copy',
          'Ctrl+C',
          Icons.copy,
          Colors.orange.shade700,
        ),
        buildMenuItemWithShortcut('Paste', 'Ctrl+V', Icons.paste, Colors.green),
        SizedBox(height: 8),
        Divider(color: Colors.grey.shade300),
        SizedBox(height: 8),
        buildMenuItemWithShortcut(
          'Select All',
          'Ctrl+A',
          Icons.select_all,
          Colors.purple,
        ),
        buildMenuItemWithShortcut('Find', 'Ctrl+F', Icons.search, Colors.teal),
        buildMenuItemWithShortcut(
          'Replace',
          'Ctrl+H',
          Icons.find_replace,
          Colors.indigo,
        ),
      ],
    ),
  );
}

Widget buildSubmenuWithAccelerators() {
  print('Building submenu with accelerators');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Submenu with Accelerators',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Nested menu structure with keyboard shortcuts at each level',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        MenuBar(
          children: [
            SubmenuButton(
              menuChildren: [
                SubmenuButton(
                  menuChildren: [
                    MenuItemButton(
                      shortcut: SingleActivator(
                        LogicalKeyboardKey.digit1,
                        control: true,
                      ),
                      onPressed: () {
                        print('Recent 1');
                      },
                      child: Text('Document 1'),
                    ),
                    MenuItemButton(
                      shortcut: SingleActivator(
                        LogicalKeyboardKey.digit2,
                        control: true,
                      ),
                      onPressed: () {
                        print('Recent 2');
                      },
                      child: Text('Document 2'),
                    ),
                    MenuItemButton(
                      shortcut: SingleActivator(
                        LogicalKeyboardKey.digit3,
                        control: true,
                      ),
                      onPressed: () {
                        print('Recent 3');
                      },
                      child: Text('Document 3'),
                    ),
                  ],
                  child: Text('Recent Files'),
                ),
                SubmenuButton(
                  menuChildren: [
                    MenuItemButton(
                      onPressed: () {
                        print('Blank Document');
                      },
                      child: Text('Blank Document'),
                    ),
                    MenuItemButton(
                      onPressed: () {
                        print('Template');
                      },
                      child: Text('From Template'),
                    ),
                  ],
                  child: Text('New'),
                ),
                MenuItemButton(
                  shortcut: SingleActivator(
                    LogicalKeyboardKey.keyW,
                    control: true,
                  ),
                  onPressed: () {
                    print('Close');
                  },
                  child: Text('Close'),
                ),
              ],
              child: Text('File'),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.indigo.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Submenu Structure:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '📁 File\n'
                '  ├─ 📂 Recent Files\n'
                '  │   ├─ Document 1 (Ctrl+1)\n'
                '  │   ├─ Document 2 (Ctrl+2)\n'
                '  │   └─ Document 3 (Ctrl+3)\n'
                '  ├─ 📂 New\n'
                '  │   ├─ Blank Document\n'
                '  │   └─ From Template\n'
                '  └─ Close (Ctrl+W)',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: Colors.indigo.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildAcceleratorHintDemo() {
  print('Building accelerator hint demo');
  List<String> menuLabels = ['File', 'Edit', 'View', 'Help'];
  List<String> underlinePositions = ['F', 'E', 'V', 'H'];
  List<MaterialColor> menuColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
  ];

  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < menuLabels.length; i = i + 1) {
    String label = menuLabels[i];
    String underlineChar = underlinePositions[i];
    MaterialColor color = menuColors[i];

    items.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.shade50,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color.shade200),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label.substring(0, label.indexOf(underlineChar)),
              style: TextStyle(fontSize: 14, color: color.shade800),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: color.shade700, width: 2),
                ),
              ),
              child: Text(
                underlineChar,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color.shade900,
                ),
              ),
            ),
            Text(
              label.substring(label.indexOf(underlineChar) + 1),
              style: TextStyle(fontSize: 14, color: color.shade800),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Accelerator Hint Underlines',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Alt+letter accelerators shown with underlined characters',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Row(children: items),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.amber.shade700, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Press Alt to show accelerator underlines in menus',
                  style: TextStyle(fontSize: 12, color: Colors.amber.shade800),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildAcceleratorLabelShowcase() {
  print('Building accelerator label showcase');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MenuAcceleratorLabel Widget',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Displays menu label with underlined accelerator character',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Usage Example:',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'MenuAcceleratorLabel(\n'
                  '  "Open &File",\n'
                  '  // & precedes accelerator char\n'
                  ')',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'monospace',
                    color: Colors.green.shade300,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Rendered Examples:',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        _buildLabelExample('&New', 'N is underlined'),
        _buildLabelExample('&Open', 'O is underlined'),
        _buildLabelExample('&Save', 'S is underlined'),
        _buildLabelExample('Save &As', 'A is underlined'),
        _buildLabelExample('E&xit', 'x is underlined'),
      ],
    ),
  );
}

Widget _buildLabelExample(String label, String description) {
  String cleanLabel = label.replaceAll('&', '');
  int underlineIndex = label.indexOf('&');
  String underlineChar = '';
  if (underlineIndex >= 0 && underlineIndex < label.length - 1) {
    underlineChar = label[underlineIndex + 1];
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.indigo.shade50,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.indigo.shade200),
          ),
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
              children: _buildLabelSpans(cleanLabel, underlineChar),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ),
        Text(
          'Alt+${underlineChar.toUpperCase()}',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade700,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

List<TextSpan> _buildLabelSpans(String label, String underlineChar) {
  List<TextSpan> spans = [];
  int underlineIdx = label.toLowerCase().indexOf(underlineChar.toLowerCase());

  if (underlineIdx >= 0) {
    if (underlineIdx > 0) {
      spans.add(TextSpan(text: label.substring(0, underlineIdx)));
    }
    spans.add(
      TextSpan(
        text: label[underlineIdx],
        style: TextStyle(
          decoration: TextDecoration.underline,
          decorationColor: Colors.indigo.shade700,
          decorationThickness: 2,
          fontWeight: FontWeight.bold,
          color: Colors.indigo.shade800,
        ),
      ),
    );
    if (underlineIdx < label.length - 1) {
      spans.add(TextSpan(text: label.substring(underlineIdx + 1)));
    }
  } else {
    spans.add(TextSpan(text: label));
  }

  return spans;
}

Widget buildKeyboardShortcutGrid() {
  print('Building keyboard shortcut reference grid');
  List<Map<String, String>> shortcuts = [
    {'key': 'Ctrl+N', 'action': 'New File', 'category': 'File'},
    {'key': 'Ctrl+O', 'action': 'Open', 'category': 'File'},
    {'key': 'Ctrl+S', 'action': 'Save', 'category': 'File'},
    {'key': 'Ctrl+W', 'action': 'Close', 'category': 'File'},
    {'key': 'Ctrl+Z', 'action': 'Undo', 'category': 'Edit'},
    {'key': 'Ctrl+Y', 'action': 'Redo', 'category': 'Edit'},
    {'key': 'Ctrl+X', 'action': 'Cut', 'category': 'Edit'},
    {'key': 'Ctrl+C', 'action': 'Copy', 'category': 'Edit'},
    {'key': 'Ctrl+V', 'action': 'Paste', 'category': 'Edit'},
    {'key': 'Ctrl+A', 'action': 'Select All', 'category': 'Edit'},
    {'key': 'Ctrl+F', 'action': 'Find', 'category': 'Search'},
    {'key': 'Ctrl+H', 'action': 'Replace', 'category': 'Search'},
  ];

  Map<String, MaterialColor> colorMap = {
    'File': Colors.blue,
    'Edit': Colors.green,
    'Search': Colors.orange,
  };

  List<Widget> rows = [];
  int i = 0;
  for (i = 0; i < shortcuts.length; i = i + 1) {
    Map<String, String> shortcut = shortcuts[i];
    String key = shortcut['key'] ?? '';
    String action = shortcut['action'] ?? '';
    String category = shortcut['category'] ?? '';
    MaterialColor color = colorMap[category] ?? Colors.grey;

    rows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 3),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: i % 2 == 0 ? Colors.grey.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                key,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                action,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: color.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                category,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: color.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.keyboard_alt, color: Colors.indigo.shade700, size: 22),
            SizedBox(width: 8),
            Text(
              'Keyboard Shortcut Reference',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Common accelerators bound to menu actions',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: rows),
      ],
    ),
  );
}

Widget buildInteractiveMenuDemo() {
  print('Building interactive menu demo');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Interactive Menu Demo',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Full-featured menu bar with accelerator callbacks',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        MenuBar(
          style: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.indigo.shade50),
            elevation: WidgetStatePropertyAll(2.0),
          ),
          children: [
            SubmenuButton(
              menuChildren: [
                MenuItemButton(
                  shortcut: SingleActivator(
                    LogicalKeyboardKey.keyN,
                    control: true,
                  ),
                  leadingIcon: Icon(Icons.add, size: 18),
                  onPressed: () {
                    print('New');
                  },
                  child: Text('New'),
                ),
                MenuItemButton(
                  shortcut: SingleActivator(
                    LogicalKeyboardKey.keyO,
                    control: true,
                  ),
                  leadingIcon: Icon(Icons.folder_open, size: 18),
                  onPressed: () {
                    print('Open');
                  },
                  child: Text('Open'),
                ),
                MenuItemButton(
                  shortcut: SingleActivator(
                    LogicalKeyboardKey.keyS,
                    control: true,
                  ),
                  leadingIcon: Icon(Icons.save, size: 18),
                  onPressed: () {
                    print('Save');
                  },
                  child: Text('Save'),
                ),
                Divider(),
                MenuItemButton(
                  shortcut: SingleActivator(
                    LogicalKeyboardKey.keyQ,
                    control: true,
                  ),
                  leadingIcon: Icon(Icons.exit_to_app, size: 18),
                  onPressed: () {
                    print('Exit');
                  },
                  child: Text('Exit'),
                ),
              ],
              child: Text('File'),
            ),
            SubmenuButton(
              menuChildren: [
                MenuItemButton(
                  shortcut: SingleActivator(
                    LogicalKeyboardKey.keyZ,
                    control: true,
                  ),
                  leadingIcon: Icon(Icons.undo, size: 18),
                  onPressed: () {
                    print('Undo');
                  },
                  child: Text('Undo'),
                ),
                MenuItemButton(
                  shortcut: SingleActivator(
                    LogicalKeyboardKey.keyY,
                    control: true,
                  ),
                  leadingIcon: Icon(Icons.redo, size: 18),
                  onPressed: () {
                    print('Redo');
                  },
                  child: Text('Redo'),
                ),
                Divider(),
                MenuItemButton(
                  shortcut: SingleActivator(
                    LogicalKeyboardKey.keyX,
                    control: true,
                  ),
                  leadingIcon: Icon(Icons.content_cut, size: 18),
                  onPressed: () {
                    print('Cut');
                  },
                  child: Text('Cut'),
                ),
                MenuItemButton(
                  shortcut: SingleActivator(
                    LogicalKeyboardKey.keyC,
                    control: true,
                  ),
                  leadingIcon: Icon(Icons.copy, size: 18),
                  onPressed: () {
                    print('Copy');
                  },
                  child: Text('Copy'),
                ),
                MenuItemButton(
                  shortcut: SingleActivator(
                    LogicalKeyboardKey.keyV,
                    control: true,
                  ),
                  leadingIcon: Icon(Icons.paste, size: 18),
                  onPressed: () {
                    print('Paste');
                  },
                  child: Text('Paste'),
                ),
              ],
              child: Text('Edit'),
            ),
            SubmenuButton(
              menuChildren: [
                CheckboxMenuButton(
                  value: true,
                  onChanged: (bool? v) {
                    print('Toolbar: $v');
                  },
                  child: Text('Toolbar'),
                ),
                CheckboxMenuButton(
                  value: true,
                  onChanged: (bool? v) {
                    print('Status Bar: $v');
                  },
                  child: Text('Status Bar'),
                ),
                CheckboxMenuButton(
                  value: false,
                  onChanged: (bool? v) {
                    print('Sidebar: $v');
                  },
                  child: Text('Sidebar'),
                ),
              ],
              child: Text('View'),
            ),
            SubmenuButton(
              menuChildren: [
                MenuItemButton(
                  shortcut: SingleActivator(LogicalKeyboardKey.f1),
                  leadingIcon: Icon(Icons.help, size: 18),
                  onPressed: () {
                    print('Help');
                  },
                  child: Text('Help'),
                ),
                MenuItemButton(
                  leadingIcon: Icon(Icons.info, size: 18),
                  onPressed: () {
                    print('About');
                  },
                  child: Text('About'),
                ),
              ],
              child: Text('Help'),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green.shade700, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'MenuAcceleratorCallbackBinding automatically handles callback registration',
                  style: TextStyle(fontSize: 12, color: Colors.green.shade800),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildBindingInheritance() {
  print('Building binding inheritance diagram');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Binding Inheritance',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'How MenuAcceleratorCallbackBinding propagates through widget tree',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTreeNode('MaterialApp', 0, Colors.blue),
              _buildTreeNode(
                'MenuAcceleratorCallbackBinding',
                1,
                Colors.indigo,
              ),
              _buildTreeNode('Scaffold', 2, Colors.blue),
              _buildTreeNode('MenuBar', 3, Colors.green),
              _buildTreeNode('SubmenuButton (File)', 4, Colors.green),
              _buildTreeNode('MenuItemButton (New)', 5, Colors.orange),
              _buildTreeNode('MenuItemButton (Open)', 5, Colors.orange),
              _buildTreeNode('SubmenuButton (Edit)', 4, Colors.green),
              _buildTreeNode('MenuItemButton (Undo)', 5, Colors.orange),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.indigo.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.indigo.shade700, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Binding is inherited by all descendant menu items',
                  style: TextStyle(fontSize: 12, color: Colors.indigo.shade800),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildTreeNode(String label, int depth, MaterialColor color) {
  String indent = '';
  int d = 0;
  for (d = 0; d < depth; d = d + 1) {
    indent = '$indent  ';
  }
  String prefix = depth > 0 ? '└─ ' : '';

  return Container(
    margin: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Text(
          indent + prefix,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: Colors.grey.shade500,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: color.shade100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: color.shade800,
            ),
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('MenuAcceleratorCallbackBinding test executing');
  print('Class: MenuAcceleratorCallbackBinding');
  print('Package: material');
  print('Description: Binds keyboard accelerators to menu item callbacks');

  List<Widget> sections = [];

  sections.add(buildSectionHeader('1. Accelerator Binding Overview'));
  sections.add(buildAcceleratorOverview());

  sections.add(buildSectionHeader('2. MenuBar with Accelerators'));
  sections.add(buildBasicMenuBarDemo());

  sections.add(buildSectionHeader('3. Shortcut Label Display'));
  sections.add(buildShortcutLabelDisplay());

  sections.add(buildSectionHeader('4. Edit Menu Shortcuts'));
  sections.add(buildEditMenuWithShortcuts());

  sections.add(buildSectionHeader('5. Submenu with Accelerators'));
  sections.add(buildSubmenuWithAccelerators());

  sections.add(buildSectionHeader('6. Accelerator Hint Underlines'));
  sections.add(buildAcceleratorHintDemo());

  sections.add(buildSectionHeader('7. MenuAcceleratorLabel Widget'));
  sections.add(buildAcceleratorLabelShowcase());

  sections.add(buildSectionHeader('8. Keyboard Shortcut Reference'));
  sections.add(buildKeyboardShortcutGrid());

  sections.add(buildSectionHeader('9. Interactive Menu Demo'));
  sections.add(buildInteractiveMenuDemo());

  sections.add(buildSectionHeader('10. Binding Inheritance'));
  sections.add(buildBindingInheritance());

  print('MenuAcceleratorCallbackBinding test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: sections,
    ),
  );
}
