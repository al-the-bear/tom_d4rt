// ignore_for_file: avoid_print
// D4rt test script: Tests PopupMenuItem from material
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

Widget buildMenuItemCard(
  String title,
  String description,
  Widget child,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        SizedBox(height: 10),
        child,
      ],
    ),
  );
}

Widget buildPopupMenuItemBasicsSection() {
  print('Building PopupMenuItem basics section');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildInfoCard('Purpose', 'An item in a Material Design popup menu'),
      buildInfoCard('Super Class', 'PopupMenuEntry<T>'),
      buildInfoCard('Generic Type', 'T - the value type for item selection'),
      buildInfoCard('Used With', 'PopupMenuButton, showMenu()'),
      SizedBox(height: 8),
      buildMenuItemCard(
        'Basic PopupMenuItem Example',
        'A simple popup menu with basic text items',
        Row(
          children: [
            PopupMenuButton<String>(
              onSelected: (value) {
                print('Selected: $value');
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem<String>(
                    value: 'option1',
                    child: Text('Option 1'),
                  ),
                  PopupMenuItem<String>(
                    value: 'option2',
                    child: Text('Option 2'),
                  ),
                  PopupMenuItem<String>(
                    value: 'option3',
                    child: Text('Option 3'),
                  ),
                ];
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Open Menu',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                'Tap to open a basic popup menu',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 8),
      buildMenuItemCard(
        'PopupMenuItem Structure',
        'Visual representation of a popup menu item structure',
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    color: Colors.blue.shade100,
                    child: Text('value', style: TextStyle(fontSize: 12)),
                  ),
                  SizedBox(width: 8),
                  Text('The value when item is selected'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    color: Colors.green.shade100,
                    child: Text('child', style: TextStyle(fontSize: 12)),
                  ),
                  SizedBox(width: 8),
                  Text('The widget displayed in the item'),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    color: Colors.orange.shade100,
                    child: Text('onTap', style: TextStyle(fontSize: 12)),
                  ),
                  SizedBox(width: 8),
                  Text('Callback when item is tapped'),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget buildValuePropertySection() {
  print('Building value property section');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildInfoCard('Property', 'value of type T?'),
      buildInfoCard('Description', 'The value that will be returned when this item is selected'),
      buildInfoCard('Required', 'No, but recommended for identification'),
      SizedBox(height: 8),
      buildMenuItemCard(
        'String Value Menu',
        'Using String as the generic value type',
        PopupMenuButton<String>(
          onSelected: (value) {
            print('String value selected: $value');
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: 'copy',
                child: Row(
                  children: [
                    Icon(Icons.copy, size: 20),
                    SizedBox(width: 12),
                    Text('Copy'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'paste',
                child: Row(
                  children: [
                    Icon(Icons.paste, size: 20),
                    SizedBox(width: 12),
                    Text('Paste'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'cut',
                child: Row(
                  children: [
                    Icon(Icons.cut, size: 20),
                    SizedBox(width: 12),
                    Text('Cut'),
                  ],
                ),
              ),
            ];
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('String Values', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      SizedBox(height: 8),
      buildMenuItemCard(
        'Integer Value Menu',
        'Using int as the generic value type',
        PopupMenuButton<int>(
          onSelected: (value) {
            print('Integer value selected: $value');
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<int>(
                value: 1,
                child: Text('Priority 1 - High'),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: Text('Priority 2 - Medium'),
              ),
              PopupMenuItem<int>(
                value: 3,
                child: Text('Priority 3 - Low'),
              ),
            ];
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('Integer Values', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      SizedBox(height: 8),
      buildMenuItemCard(
        'Null Value Item',
        'Item without a value (returns null on selection)',
        PopupMenuButton<String>(
          onSelected: (value) {
            print('Value received: $value');
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: 'action1',
                child: Text('Action with value'),
              ),
              PopupMenuItem<String>(
                child: Text('Action without value (null)'),
              ),
            ];
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('Null Value Demo', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    ],
  );
}

Widget buildChildCustomizationSection() {
  print('Building child customization section');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildInfoCard('Property', 'child of type Widget'),
      buildInfoCard('Description', 'The widget to display as the menu item content'),
      buildInfoCard('Common Patterns', 'Text, Row with Icon and Text, ListTile'),
      SizedBox(height: 8),
      buildMenuItemCard(
        'Text Only Items',
        'Simple text children',
        PopupMenuButton<String>(
          onSelected: (value) {
            print('Text item selected: $value');
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: 'new',
                child: Text('New'),
              ),
              PopupMenuItem<String>(
                value: 'open',
                child: Text('Open'),
              ),
              PopupMenuItem<String>(
                value: 'save',
                child: Text('Save'),
              ),
            ];
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.blue.shade600,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('Text Items', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      SizedBox(height: 8),
      buildMenuItemCard(
        'Icon + Text Items',
        'Row layout with leading icon',
        PopupMenuButton<String>(
          onSelected: (value) {
            print('Icon item selected: $value');
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: 'home',
                child: Row(
                  children: [
                    Icon(Icons.home, color: Colors.blue),
                    SizedBox(width: 12),
                    Text('Home'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings, color: Colors.grey),
                    SizedBox(width: 12),
                    Text('Settings'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.person, color: Colors.green),
                    SizedBox(width: 12),
                    Text('Profile'),
                  ],
                ),
              ),
            ];
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.green.shade600,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('Icon Items', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      SizedBox(height: 8),
      buildMenuItemCard(
        'Rich Content Items',
        'Complex child widgets with multiple elements',
        PopupMenuButton<String>(
          onSelected: (value) {
            print('Rich item selected: $value');
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: 'premium',
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.star, color: Colors.amber),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Premium', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Unlock all features', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'basic',
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.person, color: Colors.grey),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Basic', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Free forever', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
            ];
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.amber.shade700,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('Rich Content', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    ],
  );
}

Widget buildEnabledStateSection() {
  print('Building enabled state section');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildInfoCard('Property', 'enabled of type bool'),
      buildInfoCard('Default', 'true'),
      buildInfoCard('Disabled Behavior', 'Item is grayed out and not tappable'),
      SizedBox(height: 8),
      buildMenuItemCard(
        'Mixed Enabled States',
        'Menu with both enabled and disabled items',
        PopupMenuButton<String>(
          onSelected: (value) {
            print('Selected enabled item: $value');
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: 'cut',
                enabled: true,
                child: Row(
                  children: [
                    Icon(Icons.cut, size: 20),
                    SizedBox(width: 12),
                    Text('Cut'),
                    Spacer(),
                    Text('Ctrl+X', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'copy',
                enabled: true,
                child: Row(
                  children: [
                    Icon(Icons.copy, size: 20),
                    SizedBox(width: 12),
                    Text('Copy'),
                    Spacer(),
                    Text('Ctrl+C', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'paste',
                enabled: false,
                child: Row(
                  children: [
                    Icon(Icons.paste, size: 20),
                    SizedBox(width: 12),
                    Text('Paste (Disabled)'),
                    Spacer(),
                    Text('Ctrl+V', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
            ];
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.red.shade600,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('Enabled States', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      SizedBox(height: 8),
      buildMenuItemCard(
        'All Disabled Items',
        'Menu where all items are disabled',
        PopupMenuButton<String>(
          onSelected: (value) {
            print('This should not print: $value');
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: 'delete',
                enabled: false,
                child: Text('Delete (Disabled)'),
              ),
              PopupMenuItem<String>(
                value: 'archive',
                enabled: false,
                child: Text('Archive (Disabled)'),
              ),
              PopupMenuItem<String>(
                value: 'restore',
                enabled: false,
                child: Text('Restore (Disabled)'),
              ),
            ];
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade600,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('All Disabled', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      SizedBox(height: 8),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.yellow.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.yellow.shade700),
        ),
        child: Row(
          children: [
            Icon(Icons.info, color: Colors.yellow.shade700),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Disabled items cannot be selected and will not trigger onSelected callback',
                style: TextStyle(fontSize: 13, color: Colors.yellow.shade900),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildHeightPropertySection() {
  print('Building height property section');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildInfoCard('Property', 'height of type double'),
      buildInfoCard('Default', 'kMinInteractiveDimension (48.0 logical pixels)'),
      buildInfoCard('Usage', 'Customize vertical size of menu items'),
      SizedBox(height: 8),
      buildMenuItemCard(
        'Default Height Items',
        'Items using the default 48.0 height',
        PopupMenuButton<String>(
          onSelected: (value) {
            print('Default height item: $value');
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: 'item1',
                child: Text('Default Height Item 1'),
              ),
              PopupMenuItem<String>(
                value: 'item2',
                child: Text('Default Height Item 2'),
              ),
            ];
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('Default Height', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      SizedBox(height: 8),
      buildMenuItemCard(
        'Custom Height Items',
        'Items with various custom heights',
        PopupMenuButton<String>(
          onSelected: (value) {
            print('Custom height item: $value');
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: 'small',
                height: 36,
                child: Text('Small Height (36)'),
              ),
              PopupMenuItem<String>(
                value: 'medium',
                height: 56,
                child: Text('Medium Height (56)'),
              ),
              PopupMenuItem<String>(
                value: 'large',
                height: 72,
                child: Row(
                  children: [
                    Icon(Icons.expand, color: Colors.blue),
                    SizedBox(width: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Large Height (72)'),
                        Text('With subtitle', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
            ];
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.cyan.shade700,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('Custom Heights', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      SizedBox(height: 8),
      buildMenuItemCard(
        'Compact Menu',
        'Items with reduced height for dense menus',
        PopupMenuButton<String>(
          onSelected: (value) {
            print('Compact item: $value');
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: 'a',
                height: 32,
                child: Text('Compact A'),
              ),
              PopupMenuItem<String>(
                value: 'b',
                height: 32,
                child: Text('Compact B'),
              ),
              PopupMenuItem<String>(
                value: 'c',
                height: 32,
                child: Text('Compact C'),
              ),
              PopupMenuItem<String>(
                value: 'd',
                height: 32,
                child: Text('Compact D'),
              ),
            ];
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.pink.shade600,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('Compact Menu', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    ],
  );
}

Widget buildOnTapCallbackSection() {
  print('Building onTap callback section');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildInfoCard('Property', 'onTap of type VoidCallback?'),
      buildInfoCard('Description', 'Called when the menu item is tapped'),
      buildInfoCard('Timing', 'Called before onSelected on PopupMenuButton'),
      buildInfoCard('Use Case', 'Side effects like analytics, logging, navigation'),
      SizedBox(height: 8),
      buildMenuItemCard(
        'onTap with Logging',
        'Items that log when tapped',
        PopupMenuButton<String>(
          onSelected: (value) {
            print('onSelected called with: $value');
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: 'action1',
                onTap: () {
                  print('onTap: Action 1 was tapped');
                },
                child: Text('Action 1 (logs on tap)'),
              ),
              PopupMenuItem<String>(
                value: 'action2',
                onTap: () {
                  print('onTap: Action 2 was tapped');
                },
                child: Text('Action 2 (logs on tap)'),
              ),
              PopupMenuItem<String>(
                value: 'action3',
                onTap: () {
                  print('onTap: Action 3 was tapped');
                },
                child: Text('Action 3 (logs on tap)'),
              ),
            ];
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('Tap Logging', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      SizedBox(height: 8),
      buildMenuItemCard(
        'onTap with Side Effects',
        'Items that perform actions when tapped',
        PopupMenuButton<String>(
          onSelected: (value) {
            print('Selected: $value');
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: 'clipboard',
                onTap: () {
                  Clipboard.setData(ClipboardData(text: 'Copied text'));
                  print('Text copied to clipboard');
                },
                child: Row(
                  children: [
                    Icon(Icons.copy, size: 20),
                    SizedBox(width: 12),
                    Text('Copy to Clipboard'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'vibrate',
                onTap: () {
                  HapticFeedback.selectionClick();
                  print('Haptic feedback triggered');
                },
                child: Row(
                  children: [
                    Icon(Icons.vibration, size: 20),
                    SizedBox(width: 12),
                    Text('Trigger Haptic'),
                  ],
                ),
              ),
            ];
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.brown,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('Side Effects', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      SizedBox(height: 8),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Callback Order:',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade900),
            ),
            SizedBox(height: 8),
            Text('1. onTap is called on the PopupMenuItem'),
            Text('2. Menu closes'),
            Text('3. onSelected is called on PopupMenuButton'),
          ],
        ),
      ),
    ],
  );
}

Widget buildMouseCursorSection() {
  print('Building mouse cursor section');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildInfoCard('Property', 'mouseCursor of type MouseCursor?'),
      buildInfoCard('Description', 'The cursor to show when hovering over the item'),
      buildInfoCard('Default', 'SystemMouseCursors.click when enabled'),
      SizedBox(height: 8),
      buildMenuItemCard(
        'Default Mouse Cursor',
        'Items with default click cursor',
        PopupMenuButton<String>(
          onSelected: (value) {
            print('Default cursor item: $value');
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: 'default1',
                child: Text('Default Cursor Item 1'),
              ),
              PopupMenuItem<String>(
                value: 'default2',
                child: Text('Default Cursor Item 2'),
              ),
            ];
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('Default Cursor', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      SizedBox(height: 8),
      buildMenuItemCard(
        'Custom Mouse Cursors',
        'Items with various mouse cursor styles',
        PopupMenuButton<String>(
          onSelected: (value) {
            print('Custom cursor item: $value');
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: 'pointer',
                mouseCursor: SystemMouseCursors.click,
                child: Row(
                  children: [
                    Icon(Icons.mouse, size: 18),
                    SizedBox(width: 12),
                    Text('Click Cursor (Default)'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'help',
                mouseCursor: SystemMouseCursors.help,
                child: Row(
                  children: [
                    Icon(Icons.help, size: 18),
                    SizedBox(width: 12),
                    Text('Help Cursor'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'text',
                mouseCursor: SystemMouseCursors.text,
                child: Row(
                  children: [
                    Icon(Icons.text_fields, size: 18),
                    SizedBox(width: 12),
                    Text('Text Cursor'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'move',
                mouseCursor: SystemMouseCursors.move,
                child: Row(
                  children: [
                    Icon(Icons.open_with, size: 18),
                    SizedBox(width: 12),
                    Text('Move Cursor'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'grab',
                mouseCursor: SystemMouseCursors.grab,
                child: Row(
                  children: [
                    Icon(Icons.pan_tool, size: 18),
                    SizedBox(width: 12),
                    Text('Grab Cursor'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'forbidden',
                mouseCursor: SystemMouseCursors.forbidden,
                child: Row(
                  children: [
                    Icon(Icons.block, size: 18),
                    SizedBox(width: 12),
                    Text('Forbidden Cursor'),
                  ],
                ),
              ),
            ];
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('Custom Cursors', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      SizedBox(height: 8),
      buildMenuItemCard(
        'Disabled Item Cursor',
        'Disabled items show basic cursor',
        PopupMenuButton<String>(
          onSelected: (value) {
            print('Item: $value');
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: 'enabled',
                enabled: true,
                mouseCursor: SystemMouseCursors.click,
                child: Text('Enabled - Click Cursor'),
              ),
              PopupMenuItem<String>(
                value: 'disabled',
                enabled: false,
                mouseCursor: SystemMouseCursors.basic,
                child: Text('Disabled - Basic Cursor'),
              ),
            ];
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade700,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('Enabled vs Disabled', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    ],
  );
}

Widget buildPaddingSection() {
  print('Building padding section');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildInfoCard('Property', 'padding of type EdgeInsets?'),
      buildInfoCard('Description', 'The internal padding around the child widget'),
      buildInfoCard('Default', 'EdgeInsets.symmetric(horizontal: 16.0)'),
      SizedBox(height: 8),
      buildMenuItemCard(
        'Default Padding',
        'Items with default horizontal padding',
        PopupMenuButton<String>(
          onSelected: (value) {
            print('Default padding item: $value');
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: 'item1',
                child: Text('Default Padding Item'),
              ),
              PopupMenuItem<String>(
                value: 'item2',
                child: Text('Another Default Padding'),
              ),
            ];
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('Default Padding', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      SizedBox(height: 8),
      buildMenuItemCard(
        'Custom Padding',
        'Items with various padding configurations',
        PopupMenuButton<String>(
          onSelected: (value) {
            print('Custom padding item: $value');
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: 'small',
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text('Small Padding (8, 4)'),
              ),
              PopupMenuItem<String>(
                value: 'large',
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: Text('Large Padding (32, 8)'),
              ),
              PopupMenuItem<String>(
                value: 'asymmetric',
                padding: EdgeInsets.only(left: 40, right: 8, top: 4, bottom: 4),
                child: Text('Asymmetric Padding'),
              ),
              PopupMenuItem<String>(
                value: 'all',
                padding: EdgeInsets.all(24),
                child: Text('Equal All Sides (24)'),
              ),
            ];
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.lightGreen,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('Custom Padding', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      SizedBox(height: 8),
      buildMenuItemCard(
        'Zero Padding',
        'Items with no internal padding',
        PopupMenuButton<String>(
          onSelected: (value) {
            print('Zero padding item: $value');
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: 'zero1',
                padding: EdgeInsets.zero,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Colors.blue.shade50,
                  child: Text('Zero Padding (custom bg)'),
                ),
              ),
              PopupMenuItem<String>(
                value: 'zero2',
                padding: EdgeInsets.zero,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Colors.green.shade50,
                  child: Text('Another Zero Padding'),
                ),
              ),
            ];
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.teal.shade600,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('Zero Padding', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      SizedBox(height: 8),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.purple.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.purple.shade200),
        ),
        child: Row(
          children: [
            Icon(Icons.tips_and_updates, color: Colors.purple),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Use zero padding when you need full control over the item layout with custom backgrounds',
                style: TextStyle(fontSize: 13, color: Colors.purple.shade900),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildTextStyleSection() {
  print('Building text style section');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildInfoCard('Property', 'textStyle of type TextStyle?'),
      buildInfoCard('Description', 'The text style for the default text content'),
      buildInfoCard('Applies To', 'DefaultTextStyle wrapper around child'),
      buildInfoCard('Inheritance', 'Inherits from PopupMenuTheme if not set'),
      SizedBox(height: 8),
      buildMenuItemCard(
        'Default Text Style',
        'Items using theme default styling',
        PopupMenuButton<String>(
          onSelected: (value) {
            print('Default style item: $value');
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: 'default1',
                child: Text('Default Theme Style'),
              ),
              PopupMenuItem<String>(
                value: 'default2',
                child: Text('Inherits from Theme'),
              ),
            ];
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.indigo.shade600,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('Default Style', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      SizedBox(height: 8),
      buildMenuItemCard(
        'Custom Text Styles',
        'Items with various custom text styling',
        PopupMenuButton<String>(
          onSelected: (value) {
            print('Custom style item: $value');
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: 'bold',
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16,
                ),
                child: Text('Bold Text'),
              ),
              PopupMenuItem<String>(
                value: 'italic',
                textStyle: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade700,
                  fontSize: 14,
                ),
                child: Text('Italic Text'),
              ),
              PopupMenuItem<String>(
                value: 'colored',
                textStyle: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                child: Text('Blue Colored Text'),
              ),
              PopupMenuItem<String>(
                value: 'large',
                textStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.red.shade700,
                  letterSpacing: 1.2,
                ),
                child: Text('Large Red Text'),
              ),
            ];
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.red.shade600,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('Custom Styles', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      SizedBox(height: 8),
      buildMenuItemCard(
        'Text Style with Font Family',
        'Items with custom font families',
        PopupMenuButton<String>(
          onSelected: (value) {
            print('Font family item: $value');
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: 'serif',
                textStyle: TextStyle(
                  fontFamily: 'serif',
                  fontSize: 15,
                  color: Colors.brown,
                ),
                child: Text('Serif Font Family'),
              ),
              PopupMenuItem<String>(
                value: 'monospace',
                textStyle: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14,
                  color: Colors.green.shade800,
                ),
                child: Text('Monospace Font'),
              ),
            ];
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.brown,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('Font Families', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      SizedBox(height: 8),
      buildMenuItemCard(
        'Disabled Item Text Style',
        'Style differences between enabled and disabled',
        PopupMenuButton<String>(
          onSelected: (value) {
            print('Style state item: $value');
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: 'enabled',
                enabled: true,
                textStyle: TextStyle(
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.w600,
                ),
                child: Text('Enabled Item (Blue Bold)'),
              ),
              PopupMenuItem<String>(
                value: 'disabled',
                enabled: false,
                textStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.normal,
                ),
                child: Text('Disabled Item (Grey)'),
              ),
            ];
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade600,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('Style States', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    ],
  );
}

Widget buildCombinedDemosSection() {
  print('Building combined demos section');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildInfoCard('Purpose', 'Demonstrating multiple properties together'),
      SizedBox(height: 8),
      buildMenuItemCard(
        'Full Feature Menu',
        'Items using all customization properties',
        PopupMenuButton<String>(
          onSelected: (value) {
            print('Full feature item: $value');
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: 'premium',
                height: 64,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                mouseCursor: SystemMouseCursors.click,
                textStyle: TextStyle(fontWeight: FontWeight.bold),
                onTap: () {
                  print('Premium item tapped');
                },
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.amber, Colors.orange],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.star, color: Colors.white),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Premium Plan'),
                        Text(
                          'All features unlocked',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'standard',
                height: 64,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                mouseCursor: SystemMouseCursors.click,
                textStyle: TextStyle(fontWeight: FontWeight.w500),
                onTap: () {
                  print('Standard item tapped');
                },
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.verified_user, color: Colors.blue),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Standard Plan'),
                        Text(
                          'Most popular choice',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'free',
                height: 64,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                enabled: false,
                mouseCursor: SystemMouseCursors.forbidden,
                textStyle: TextStyle(color: Colors.grey),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.person_outline, color: Colors.grey),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Free Plan'),
                        Text(
                          'Currently unavailable',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ];
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.deepPurple],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.menu, color: Colors.white),
                SizedBox(width: 8),
                Text('Full Feature Menu', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 8),
      buildMenuItemCard(
        'Action Menu',
        'Common action items with icons and shortcuts',
        PopupMenuButton<String>(
          onSelected: (value) {
            print('Action: $value');
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: 'undo',
                height: 44,
                padding: EdgeInsets.symmetric(horizontal: 16),
                onTap: () {
                  print('Undo action');
                },
                child: Row(
                  children: [
                    Icon(Icons.undo, size: 20, color: Colors.grey.shade700),
                    SizedBox(width: 16),
                    Expanded(child: Text('Undo')),
                    Text('Ctrl+Z', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'redo',
                height: 44,
                padding: EdgeInsets.symmetric(horizontal: 16),
                onTap: () {
                  print('Redo action');
                },
                child: Row(
                  children: [
                    Icon(Icons.redo, size: 20, color: Colors.grey.shade700),
                    SizedBox(width: 16),
                    Expanded(child: Text('Redo')),
                    Text('Ctrl+Y', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem<String>(
                value: 'selectAll',
                height: 44,
                padding: EdgeInsets.symmetric(horizontal: 16),
                onTap: () {
                  print('Select all action');
                },
                child: Row(
                  children: [
                    Icon(Icons.select_all, size: 20, color: Colors.grey.shade700),
                    SizedBox(width: 16),
                    Expanded(child: Text('Select All')),
                    Text('Ctrl+A', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
            ];
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade700,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('Edit Actions', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    ],
  );
}

Widget buildMain() {
  print('Building PopupMenuItem deep demo');
  
  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.indigo,
      useMaterial3: true,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('PopupMenuItem Deep Demo'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. PopupMenuItem Basics'),
            buildPopupMenuItemBasicsSection(),
            
            buildSectionHeader('2. Value Property'),
            buildValuePropertySection(),
            
            buildSectionHeader('3. Child Customization'),
            buildChildCustomizationSection(),
            
            buildSectionHeader('4. Enabled State'),
            buildEnabledStateSection(),
            
            buildSectionHeader('5. Height Property'),
            buildHeightPropertySection(),
            
            buildSectionHeader('6. onTap Callback'),
            buildOnTapCallbackSection(),
            
            buildSectionHeader('7. Mouse Cursor'),
            buildMouseCursorSection(),
            
            buildSectionHeader('8. Padding'),
            buildPaddingSection(),
            
            buildSectionHeader('9. Text Style'),
            buildTextStyleSection(),
            
            buildSectionHeader('10. Combined Demos'),
            buildCombinedDemosSection(),
            
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
  
  print('PopupMenuItem deep demo completed');
  return result;
}
