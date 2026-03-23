// ignore_for_file: avoid_print
// D4rt test script: Tests PopupMenuEntry from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.fromLTRB(8, 16, 8, 8),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color, color.withValues(alpha: 0.7)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 22),
        SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget buildConceptCard(String title, String description, Color accentColor) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accentColor.withValues(alpha: 0.3)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 6,
              height: 24,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: accentColor.withValues(alpha: 0.9),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          description,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700, height: 1.4),
        ),
      ],
    ),
  );
}

Widget buildPropertyCard(
  String propertyName,
  String propertyType,
  String description,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            propertyType,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                propertyName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildMenuEntryTypeCard(
  String typeName,
  String description,
  IconData icon,
  Color color,
  List<String> features,
) {
  print('Building menu entry type card: $typeName');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.25)),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.1),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    typeName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        ...features.map((feature) => Padding(
          padding: EdgeInsets.only(bottom: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.check_circle, size: 16, color: color),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  feature,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
              ),
            ],
          ),
        )),
      ],
    ),
  );
}

Widget buildSimulatedPopupMenu(
  String title,
  Color headerColor,
  List<Widget> menuItems,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    width: 260,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.15),
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: headerColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: headerColor,
            ),
          ),
        ),
        Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
        ...menuItems,
        SizedBox(height: 4),
      ],
    ),
  );
}

Widget buildSimulatedMenuItem(
  String text,
  IconData? leadingIcon,
  bool enabled,
  Color textColor,
  Color? backgroundColor,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: backgroundColor ?? Colors.transparent,
    ),
    child: Row(
      children: [
        if (leadingIcon != null) ...[
          Icon(
            leadingIcon,
            size: 20,
            color: enabled ? textColor : Colors.grey.shade400,
          ),
          SizedBox(width: 12),
        ],
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: enabled ? textColor : Colors.grey.shade400,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        if (!enabled)
          Icon(Icons.block, size: 14, color: Colors.grey.shade400),
      ],
    ),
  );
}

Widget buildSimulatedDivider(double height, Color color) {
  return Container(
    height: height,
    margin: EdgeInsets.symmetric(vertical: 4),
    color: color,
  );
}

Widget buildSimulatedCheckedItem(
  String text,
  bool checked,
  bool enabled,
  Color checkColor,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: checked
              ? Icon(
                  Icons.check,
                  size: 20,
                  color: enabled ? checkColor : Colors.grey.shade400,
                )
              : null,
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: enabled ? Colors.black87 : Colors.grey.shade400,
              fontWeight: checked ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildHeightDemoCard(
  String label,
  double height,
  Color color,
  String description,
) {
  print('Building height demo: $label with height $height');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          width: 60,
          height: height.clamp(20.0, 80.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: color),
          ),
          child: Center(
            child: Text(
              '${height.toInt()}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildRepresentsSection() {
  print('Building represents property section');
  
  List<Map<String, dynamic>> representsExamples = [
    {
      'type': 'bool',
      'label': 'Boolean Value',
      'example': 'true/false for toggle options',
      'icon': Icons.toggle_on,
      'color': Colors.green,
    },
    {
      'type': 'int',
      'label': 'Integer Value',
      'example': 'Numeric ID or index selection',
      'icon': Icons.tag,
      'color': Colors.blue,
    },
    {
      'type': 'String',
      'label': 'String Value',
      'example': 'Named action or command',
      'icon': Icons.text_fields,
      'color': Colors.orange,
    },
    {
      'type': 'enum',
      'label': 'Enum Value',
      'example': 'Typed selection from options',
      'icon': Icons.list_alt,
      'color': Colors.purple,
    },
    {
      'type': 'Object',
      'label': 'Custom Object',
      'example': 'Complex data with multiple fields',
      'icon': Icons.data_object,
      'color': Colors.teal,
    },
    {
      'type': 'null',
      'label': 'Nullable Value',
      'example': 'Optional selection, can be null',
      'icon': Icons.block,
      'color': Colors.grey,
    },
  ];
  
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader(
        'The represents Property',
        Icons.assignment,
        Colors.deepPurple,
      ),
      buildConceptCard(
        'What does represents mean?',
        'The represents property in PopupMenuEntry indicates what value will be '
        'returned when this menu entry is selected. For items like PopupMenuItem, '
        'this is the generic type T. For dividers, represents returns null since '
        'they cannot be selected.',
        Colors.deepPurple,
      ),
      SizedBox(height: 8),
      ...representsExamples.map((example) => Container(
        margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (example['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: (example['color'] as Color).withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: (example['color'] as Color).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                example['icon'] as IconData,
                color: example['color'] as Color,
                size: 22,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: example['color'] as Color,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          example['type'] as String,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        example['label'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    example['example'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    ],
  );
}

Widget buildHeightPropertySection() {
  print('Building height property section');
  
  List<Map<String, dynamic>> heightExamples = [
    {
      'label': 'Default PopupMenuItem',
      'height': 48.0,
      'color': Colors.blue,
      'description': 'Standard height for text menu items',
    },
    {
      'label': 'PopupMenuDivider (default)',
      'height': 16.0,
      'color': Colors.grey,
      'description': 'Default height for divider elements',
    },
    {
      'label': 'PopupMenuDivider (custom)',
      'height': 24.0,
      'color': Colors.orange,
      'description': 'Custom height divider for more spacing',
    },
    {
      'label': 'CheckedPopupMenuItem',
      'height': 48.0,
      'color': Colors.green,
      'description': 'Standard height with check indicator',
    },
    {
      'label': 'Compact MenuItem',
      'height': 36.0,
      'color': Colors.purple,
      'description': 'Smaller height for dense menus',
    },
    {
      'label': 'Large MenuItem',
      'height': 64.0,
      'color': Colors.teal,
      'description': 'Larger height for icon + subtitle content',
    },
  ];
  
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader(
        'The height Property',
        Icons.height,
        Colors.indigo,
      ),
      buildConceptCard(
        'Why height matters in PopupMenuEntry',
        'The height property defines the vertical size of each popup menu entry. '
        'Different entry types have different default heights. PopupMenuItem uses '
        'kMinInteractiveDimension (48.0), while PopupMenuDivider defaults to 16.0. '
        'Custom heights help create visual hierarchy and improve readability.',
        Colors.indigo,
      ),
      SizedBox(height: 8),
      ...heightExamples.map((example) => buildHeightDemoCard(
        example['label'] as String,
        example['height'] as double,
        example['color'] as Color,
        example['description'] as String,
      )),
    ],
  );
}

Widget buildPopupMenuItemSection() {
  print('Building PopupMenuItem implementation section');
  
  List<Map<String, dynamic>> menuItems = [
    {
      'text': 'Copy',
      'icon': Icons.copy,
      'enabled': true,
      'shortcut': 'Ctrl+C',
      'color': Colors.blue,
    },
    {
      'text': 'Paste',
      'icon': Icons.paste,
      'enabled': true,
      'shortcut': 'Ctrl+V',
      'color': Colors.green,
    },
    {
      'text': 'Cut',
      'icon': Icons.cut,
      'enabled': true,
      'shortcut': 'Ctrl+X',
      'color': Colors.orange,
    },
    {
      'text': 'Delete',
      'icon': Icons.delete,
      'enabled': false,
      'shortcut': 'Del',
      'color': Colors.red,
    },
    {
      'text': 'Select All',
      'icon': Icons.select_all,
      'enabled': true,
      'shortcut': 'Ctrl+A',
      'color': Colors.purple,
    },
  ];
  
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader(
        'PopupMenuItem Implementation',
        Icons.menu_open,
        Colors.blue,
      ),
      buildConceptCard(
        'The standard menu item widget',
        'PopupMenuItem<T> is the most common implementation of PopupMenuEntry. It '
        'represents a single selectable menu item with a generic value T. When tapped, '
        'it returns its value to the PopupMenuButton. Supports custom child widgets, '
        'enabled state, and optional padding.',
        Colors.blue,
      ),
      buildPropertyCard(
        'value',
        'T?',
        'The value returned when this item is selected',
        Colors.blue,
      ),
      buildPropertyCard(
        'onTap',
        'VoidCallback?',
        'Called when the item is tapped, before closing',
        Colors.green,
      ),
      buildPropertyCard(
        'enabled',
        'bool',
        'Whether this item can be selected (default: true)',
        Colors.orange,
      ),
      buildPropertyCard(
        'child',
        'Widget?',
        'The content of the menu item widget',
        Colors.purple,
      ),
      SizedBox(height: 12),
      buildSimulatedPopupMenu(
        'Edit Actions',
        Colors.blue,
        menuItems.map((item) => Container(
          margin: EdgeInsets.symmetric(vertical: 1, horizontal: 4),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: item['enabled'] as bool
                ? Colors.transparent
                : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Icon(
                item['icon'] as IconData,
                size: 20,
                color: item['enabled'] as bool
                    ? (item['color'] as Color)
                    : Colors.grey.shade400,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  item['text'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    color: item['enabled'] as bool
                        ? Colors.black87
                        : Colors.grey.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                item['shortcut'] as String,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        )).toList(),
      ),
    ],
  );
}

Widget buildPopupMenuDividerSection() {
  print('Building PopupMenuDivider section');
  
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader(
        'PopupMenuDivider',
        Icons.horizontal_rule,
        Colors.grey.shade700,
      ),
      buildConceptCard(
        'Visual separator for menu groups',
        'PopupMenuDivider is a horizontal line that creates visual separation between '
        'groups of menu items. It extends PopupMenuEntry but cannot be selected. The '
        'represents property always returns null. Height defaults to 16.0 but can be '
        'customized via the height parameter.',
        Colors.grey.shade700,
      ),
      buildPropertyCard(
        'height',
        'double',
        'The height of the divider area (default: 16.0)',
        Colors.grey.shade700,
      ),
      SizedBox(height: 12),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: buildSimulatedPopupMenu(
              'With Dividers',
              Colors.grey.shade700,
              [
                buildSimulatedMenuItem('New File', Icons.add, true, Colors.black87, null),
                buildSimulatedMenuItem('Open', Icons.folder_open, true, Colors.black87, null),
                buildSimulatedDivider(1, Colors.grey.shade300),
                buildSimulatedMenuItem('Save', Icons.save, true, Colors.black87, null),
                buildSimulatedMenuItem('Save As', Icons.save_as, true, Colors.black87, null),
                buildSimulatedDivider(1, Colors.grey.shade300),
                buildSimulatedMenuItem('Export', Icons.upload, false, Colors.black87, null),
              ],
            ),
          ),
          Expanded(
            child: buildSimulatedPopupMenu(
              'Without Dividers',
              Colors.grey.shade700,
              [
                buildSimulatedMenuItem('New File', Icons.add, true, Colors.black87, null),
                buildSimulatedMenuItem('Open', Icons.folder_open, true, Colors.black87, null),
                buildSimulatedMenuItem('Save', Icons.save, true, Colors.black87, null),
                buildSimulatedMenuItem('Save As', Icons.save_as, true, Colors.black87, null),
                buildSimulatedMenuItem('Export', Icons.upload, false, Colors.black87, null),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

Widget buildCheckedPopupMenuItemSection() {
  print('Building CheckedPopupMenuItem section');
  
  List<Map<String, dynamic>> settingsItems = [
    {'text': 'Auto-save', 'checked': true, 'enabled': true},
    {'text': 'Dark mode', 'checked': true, 'enabled': true},
    {'text': 'Notifications', 'checked': false, 'enabled': true},
    {'text': 'Sync (Premium)', 'checked': false, 'enabled': false},
    {'text': 'Analytics', 'checked': true, 'enabled': true},
  ];
  
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader(
        'CheckedPopupMenuItem',
        Icons.check_box,
        Colors.green,
      ),
      buildConceptCard(
        'Menu item with checkmark indicator',
        'CheckedPopupMenuItem<T> displays a leading checkmark when checked is true. '
        'Ideal for toggle settings or multi-selection scenarios. Inherits from '
        'PopupMenuItem and adds the checked property to show/hide the check icon. '
        'Text shifts right to make room for the checkmark column.',
        Colors.green,
      ),
      buildPropertyCard(
        'checked',
        'bool',
        'Whether to show the checkmark (default: false)',
        Colors.green,
      ),
      buildPropertyCard(
        'child',
        'Widget?',
        'The content displayed after the check area',
        Colors.blue,
      ),
      SizedBox(height: 12),
      buildSimulatedPopupMenu(
        'Settings',
        Colors.green,
        settingsItems.map((item) => buildSimulatedCheckedItem(
          item['text'] as String,
          item['checked'] as bool,
          item['enabled'] as bool,
          Colors.green,
        )).toList(),
      ),
    ],
  );
}

Widget buildCustomMenuEntriesSection() {
  print('Building custom menu entries section');
  
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader(
        'Custom Menu Entry Content Types',
        Icons.widgets,
        Colors.deepOrange,
      ),
      buildConceptCard(
        'Extending PopupMenuEntry for custom layouts',
        'PopupMenuEntry is an abstract class that can be extended to create custom '
        'menu items with unique layouts. Common customizations include icon+text '
        'combinations, subtitle text, color indicators, avatar entries, and complex '
        'multi-line content. The child widget of PopupMenuItem accepts any widget.',
        Colors.deepOrange,
      ),
      SizedBox(height: 8),
      buildMenuEntryTypeCard(
        'Icon + Text Entry',
        'Leading icon with descriptive text',
        Icons.menu,
        Colors.blue,
        [
          'Icon positioned at leading edge',
          'Primary text describes action',
          'Optional trailing shortcut hint',
        ],
      ),
      buildMenuEntryTypeCard(
        'Avatar + Text Entry',
        'User avatar or image with name',
        Icons.person,
        Colors.purple,
        [
          'CircleAvatar or Image widget',
          'User name as primary text',
          'Optional status or subtitle',
        ],
      ),
      buildMenuEntryTypeCard(
        'Color Swatch Entry',
        'Color indicator with label',
        Icons.palette,
        Colors.orange,
        [
          'Color preview container',
          'Color name or hex code',
          'Selection indicator when active',
        ],
      ),
      buildMenuEntryTypeCard(
        'Multi-line Entry',
        'Title with subtitle description',
        Icons.notes,
        Colors.teal,
        [
          'Bold title text',
          'Secondary description line',
          'Taller height to accommodate content',
        ],
      ),
      buildMenuEntryTypeCard(
        'Toggle Entry',
        'Switch control in menu item',
        Icons.toggle_on,
        Colors.green,
        [
          'Text label for setting',
          'Switch widget at trailing edge',
          'Immediate visual feedback',
        ],
      ),
      SizedBox(height: 12),
      buildCustomEntryExamples(),
    ],
  );
}

Widget buildCustomEntryExamples() {
  print('Building custom entry visual examples');
  
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Visual Examples',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.deepOrange,
          ),
        ),
        SizedBox(height: 8),
        buildSimulatedPopupMenu(
          'User Selection',
          Colors.purple,
          [
            buildAvatarMenuItem('John Smith', 'Online', Colors.green),
            buildAvatarMenuItem('Jane Doe', 'Away', Colors.orange),
            buildAvatarMenuItem('Bob Wilson', 'Offline', Colors.grey),
          ],
        ),
        SizedBox(height: 8),
        buildSimulatedPopupMenu(
          'Theme Colors',
          Colors.orange,
          [
            buildColorSwatchItem('Ocean Blue', Colors.blue),
            buildColorSwatchItem('Forest Green', Colors.green),
            buildColorSwatchItem('Sunset Orange', Colors.orange),
            buildColorSwatchItem('Royal Purple', Colors.purple),
          ],
        ),
      ],
    ),
  );
}

Widget buildAvatarMenuItem(String name, String status, Color statusColor) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Row(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.purple.shade100,
              child: Text(
                name.substring(0, 1),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                status,
                style: TextStyle(
                  fontSize: 11,
                  color: statusColor,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildColorSwatchItem(String colorName, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey.shade300),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            colorName,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Icon(
          Icons.check,
          size: 18,
          color: color,
        ),
      ],
    ),
  );
}

Widget buildPopupMenuEntryConcept() {
  print('Building PopupMenuEntry concept section');
  
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader(
        'PopupMenuEntry Concept',
        Icons.account_tree,
        Colors.indigo,
      ),
      buildConceptCard(
        'Abstract Base Class for Popup Menus',
        'PopupMenuEntry<T> is an abstract class that serves as the base for all items '
        'displayed in a popup menu. It extends StatefulWidget and defines the contract that '
        'all menu entries must implement: a height property and a represents getter. '
        'This enables the popup menu to calculate layout and handle selection uniformly.',
        Colors.indigo,
      ),
      buildConceptCard(
        'Generic Type T',
        'The generic type T defines what value type the menu entry represents. When '
        'a PopupMenuItem<T> is selected, it returns its value of type T. This allows '
        'type-safe handling of menu selections. For example, PopupMenuItem<String> '
        'returns a String value, while PopupMenuItem<int> returns an integer.',
        Colors.green,
      ),
      buildConceptCard(
        'Key Properties',
        'Every PopupMenuEntry must define: (1) height - the vertical size of the entry '
        'in logical pixels, and (2) represents - the value this entry represents when '
        'selected, or null if not selectable (like dividers).',
        Colors.orange,
      ),
      SizedBox(height: 12),
      buildMenuEntryTypeCard(
        'PopupMenuItem<T>',
        'Standard selectable menu item',
        Icons.list_alt,
        Colors.blue,
        [
          'Returns value T when selected',
          'Default height: 48.0 (kMinInteractiveDimension)',
          'Supports enabled/disabled state',
          'Customizable child widget content',
        ],
      ),
      buildMenuEntryTypeCard(
        'PopupMenuDivider',
        'Non-selectable visual separator',
        Icons.remove,
        Colors.grey.shade600,
        [
          'represents returns null (not selectable)',
          'Default height: 16.0',
          'Creates visual grouping of items',
          'Renders as horizontal line',
        ],
      ),
      buildMenuEntryTypeCard(
        'CheckedPopupMenuItem<T>',
        'Menu item with check indicator',
        Icons.check_circle_outline,
        Colors.green,
        [
          'Extends PopupMenuItem<T>',
          'Shows checkmark when checked is true',
          'Ideal for toggle settings',
          'Text indented for check column',
        ],
      ),
    ],
  );
}

Widget buildLivePopupMenuDemo() {
  print('Building live popup menu demo');
  
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionHeader(
        'Live PopupMenu Example',
        Icons.play_circle_fill,
        Colors.teal,
      ),
      buildConceptCard(
        'Interactive Popup Menu',
        'This section shows how PopupMenuButton integrates with various '
        'PopupMenuEntry types to create a functional dropdown menu. The menu '
        'combines PopupMenuItem, PopupMenuDivider, and CheckedPopupMenuItem '
        'in a single cohesive menu structure.',
        Colors.teal,
      ),
      SizedBox(height: 12),
      Center(
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                'Tap the button to open menu',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 16),
              PopupMenuButton<String>(
                onSelected: (value) {
                  print('Selected menu item: $value');
                },
                itemBuilder: (context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'new',
                    child: Row(
                      children: [
                        Icon(Icons.add, size: 20, color: Colors.blue),
                        SizedBox(width: 12),
                        Text('New Document'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'open',
                    child: Row(
                      children: [
                        Icon(Icons.folder_open, size: 20, color: Colors.orange),
                        SizedBox(width: 12),
                        Text('Open File'),
                      ],
                    ),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<String>(
                    value: 'save',
                    child: Row(
                      children: [
                        Icon(Icons.save, size: 20, color: Colors.green),
                        SizedBox(width: 12),
                        Text('Save'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'export',
                    enabled: false,
                    child: Row(
                      children: [
                        Icon(Icons.upload, size: 20),
                        SizedBox(width: 12),
                        Text('Export (Premium)'),
                      ],
                    ),
                  ),
                  PopupMenuDivider(height: 8),
                  CheckedPopupMenuItem<String>(
                    value: 'autosave',
                    checked: true,
                    child: Text('Auto-save'),
                  ),
                  CheckedPopupMenuItem<String>(
                    value: 'darkmode',
                    checked: false,
                    child: Text('Dark Mode'),
                  ),
                ],
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.menu, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Open Menu',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget buildApp() {
  print('=== PopupMenuEntry Deep Demo ===');
  print('Building comprehensive PopupMenuEntry showcase');
  
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'PopupMenuEntry Demo',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.indigo,
        brightness: Brightness.light,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('PopupMenuEntry Deep Demo'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: Container(
        color: Colors.grey.shade100,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.indigo, Colors.indigo.shade700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PopupMenuEntry<T>',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Abstract base class for all popup menu entries',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              buildPopupMenuEntryConcept(),
              SizedBox(height: 16),
              buildPopupMenuItemSection(),
              SizedBox(height: 16),
              buildPopupMenuDividerSection(),
              SizedBox(height: 16),
              buildCheckedPopupMenuItemSection(),
              SizedBox(height: 16),
              buildRepresentsSection(),
              SizedBox(height: 16),
              buildHeightPropertySection(),
              SizedBox(height: 16),
              buildCustomMenuEntriesSection(),
              SizedBox(height: 16),
              buildLivePopupMenuDemo(),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ),
  );
}

void main() {
  print('Starting PopupMenuEntry demonstration');
  print('PopupMenuEntry is the abstract base for popup menu items');
  
  runApp(buildApp());
  
  print('Application built successfully');
  print('Demonstrated: concept, PopupMenuItem, PopupMenuDivider, CheckedPopupMenuItem');
  print('Demonstrated: represents property, height property, custom entries');
}
