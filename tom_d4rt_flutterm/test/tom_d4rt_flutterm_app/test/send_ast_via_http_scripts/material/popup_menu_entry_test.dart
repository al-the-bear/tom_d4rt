// D4rt test script: Tests PopupMenuEntry abstract class from material
import 'package:flutter/material.dart';

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

Widget buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: Colors.green.shade300,
      ),
    ),
  );
}

Widget buildPopupMenuDemo(
  String title,
  String description,
  Color accentColor,
  List<PopupMenuEntry<String>> entries,
) {
  print('Building popup menu demo: ' + title);
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(20),
          blurRadius: 8,
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
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: accentColor.withAlpha(30),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.menu, color: accentColor, size: 24),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, color: accentColor),
              color: Colors.white,
              elevation: 8,
              onSelected: (String value) {
                print('Selected: ' + value);
              },
              itemBuilder: (BuildContext context) {
                return entries;
              },
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildHeightConceptDemo() {
  print('Building height concept demo');

  List<Map<String, dynamic>> heightExamples = [
    {'name': 'PopupMenuItem', 'height': 48.0, 'color': Colors.blue},
    {'name': 'PopupMenuDivider', 'height': 16.0, 'color': Colors.grey},
    {'name': 'CheckedPopupMenuItem', 'height': 48.0, 'color': Colors.green},
    {'name': 'Custom Entry (Small)', 'height': 32.0, 'color': Colors.orange},
    {'name': 'Custom Entry (Large)', 'height': 72.0, 'color': Colors.purple},
  ];

  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < heightExamples.length; i = i + 1) {
    Map<String, dynamic> example = heightExamples[i];
    Color color = example['color'] as Color;
    double height = example['height'] as double;
    String name = example['name'] as String;

    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              width: 150,
              child: Text(
                name,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: Container(
                height: height * 0.6,
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: color.withAlpha(60),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: color),
                ),
                child: Center(
                  child: Text(
                    height.toInt().toString() + 'px',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
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
          'Height Property Visualization',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Each entry type defines its own height',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

Widget buildRepresentsValueDemo() {
  print('Building represents value demo');

  List<Map<String, dynamic>> values = [
    {'value': 'edit', 'label': 'Edit', 'icon': Icons.edit, 'color': Colors.blue},
    {'value': 'copy', 'label': 'Copy', 'icon': Icons.copy, 'color': Colors.green},
    {'value': 'delete', 'label': 'Delete', 'icon': Icons.delete, 'color': Colors.red},
    {'value': 'share', 'label': 'Share', 'icon': Icons.share, 'color': Colors.orange},
    {'value': 'archive', 'label': 'Archive', 'icon': Icons.archive, 'color': Colors.purple},
  ];

  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < values.length; i = i + 1) {
    Map<String, dynamic> item = values[i];
    Color color = item['color'] as Color;
    IconData icon = item['icon'] as IconData;
    String label = item['label'] as String;
    String value = item['value'] as String;

    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withAlpha(60)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  Text(
                    'representedValue: "' + value + '"',
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'monospace',
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'T = String',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
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
          'Represents Value Property',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Generic type T represents the value returned on selection',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

Widget buildPopupMenuItemShowcase() {
  print('Building popup menu item showcase');

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
          'Standard PopupMenuItem Implementation',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.widgets, color: Colors.blue, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'PopupMenuItem<T>',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Most common entry type with simple text or custom child widget',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: PopupMenuButton<String>(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.menu, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Text Items',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: 'item1',
                      child: Text('Simple Item 1'),
                    ),
                    PopupMenuItem<String>(
                      value: 'item2',
                      child: Text('Simple Item 2'),
                    ),
                    PopupMenuItem<String>(
                      value: 'item3',
                      child: Text('Simple Item 3'),
                    ),
                  ];
                },
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: PopupMenuButton<String>(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.list, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Icon Items',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 18),
                          SizedBox(width: 12),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'copy',
                      child: Row(
                        children: [
                          Icon(Icons.copy, size: 18),
                          SizedBox(width: 12),
                          Text('Copy'),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 18, color: Colors.red),
                          SizedBox(width: 12),
                          Text('Delete', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ];
                },
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildDividerShowcase() {
  print('Building divider showcase');

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
          'PopupMenuDivider Entry',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.horizontal_rule, color: Colors.grey, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'PopupMenuDivider',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Separates groups of menu items with a horizontal line',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        PopupMenuButton<String>(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade700,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.segment, color: Colors.white, size: 18),
                SizedBox(width: 8),
                Text(
                  'Menu with Dividers',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ],
            ),
          ),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'cut',
                child: Row(
                  children: [
                    Icon(Icons.cut, size: 18),
                    SizedBox(width: 12),
                    Text('Cut'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'copy',
                child: Row(
                  children: [
                    Icon(Icons.copy, size: 18),
                    SizedBox(width: 12),
                    Text('Copy'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'paste',
                child: Row(
                  children: [
                    Icon(Icons.paste, size: 18),
                    SizedBox(width: 12),
                    Text('Paste'),
                  ],
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem<String>(
                value: 'select_all',
                child: Row(
                  children: [
                    Icon(Icons.select_all, size: 18),
                    SizedBox(width: 12),
                    Text('Select All'),
                  ],
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem<String>(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, size: 18, color: Colors.red),
                    SizedBox(width: 12),
                    Text('Delete', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ];
          },
        ),
        SizedBox(height: 12),
        buildCodeBlock(
          'PopupMenuDivider(height: 16)\n'
          '// Default height is 16 logical pixels\n'
          '// Extends PopupMenuEntry<Never>',
        ),
      ],
    ),
  );
}

Widget buildCheckedItemShowcase() {
  print('Building checked item showcase');

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
          'CheckedPopupMenuItem Entry',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.check_box, color: Colors.green, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'CheckedPopupMenuItem<T>',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Displays a checkmark when checked property is true',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            PopupMenuButton<String>(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.checklist, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'View Options',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ],
                ),
              ),
              itemBuilder: (BuildContext context) {
                return [
                  CheckedPopupMenuItem<String>(
                    value: 'grid',
                    checked: true,
                    child: Text('Grid View'),
                  ),
                  CheckedPopupMenuItem<String>(
                    value: 'list',
                    checked: false,
                    child: Text('List View'),
                  ),
                  CheckedPopupMenuItem<String>(
                    value: 'compact',
                    checked: false,
                    child: Text('Compact View'),
                  ),
                  PopupMenuDivider(),
                  CheckedPopupMenuItem<String>(
                    value: 'thumbnails',
                    checked: true,
                    child: Text('Show Thumbnails'),
                  ),
                  CheckedPopupMenuItem<String>(
                    value: 'details',
                    checked: true,
                    child: Text('Show Details'),
                  ),
                ];
              },
            ),
            SizedBox(width: 12),
            PopupMenuButton<String>(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.tune, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Filter',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ],
                ),
              ),
              itemBuilder: (BuildContext context) {
                return [
                  CheckedPopupMenuItem<String>(
                    value: 'images',
                    checked: true,
                    child: Text('Images'),
                  ),
                  CheckedPopupMenuItem<String>(
                    value: 'videos',
                    checked: true,
                    child: Text('Videos'),
                  ),
                  CheckedPopupMenuItem<String>(
                    value: 'documents',
                    checked: false,
                    child: Text('Documents'),
                  ),
                  CheckedPopupMenuItem<String>(
                    value: 'audio',
                    checked: false,
                    child: Text('Audio'),
                  ),
                ];
              },
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildCustomEntryDemo() {
  print('Building custom entry demo');

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
          'Custom PopupMenuEntry Implementation',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.build, color: Colors.orange, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Custom Entry',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Create custom entries by extending PopupMenuEntry<T>',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        buildCodeBlock(
          'class CustomPopupEntry<T> extends PopupMenuEntry<T> {\n'
          '  double get height => 72.0;\n'
          '  bool represents(T? value) => false;\n'
          '  \n'
          '  Widget build(BuildContext context) {\n'
          '    return Container(\n'
          '      height: height,\n'
          '      child: CustomContent(),\n'
          '    );\n'
          '  }\n'
          '}',
        ),
        SizedBox(height: 12),
        Text(
          'Required Overrides:',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        buildRequiredOverrideItem('height', 'Getter returning double', Colors.blue),
        buildRequiredOverrideItem('represents(T? value)', 'Method returning bool', Colors.green),
        buildRequiredOverrideItem('createState()', 'From StatefulWidget', Colors.purple),
      ],
    ),
  );
}

Widget buildRequiredOverrideItem(String name, String description, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      children: [
        Icon(Icons.code, size: 16, color: color),
        SizedBox(width: 8),
        Text(
          name,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),
        ),
      ],
    ),
  );
}

Widget buildSubtypesComparison() {
  print('Building subtypes comparison');

  List<Map<String, dynamic>> subtypes = [
    {
      'name': 'PopupMenuItem',
      'icon': Icons.article,
      'color': Colors.blue,
      'height': '48.0',
      'represents': 'true if value matches',
      'description': 'Standard menu item with text or custom child',
    },
    {
      'name': 'PopupMenuDivider',
      'icon': Icons.horizontal_rule,
      'color': Colors.grey,
      'height': 'configurable (default 16)',
      'represents': 'always false',
      'description': 'Visual separator between item groups',
    },
    {
      'name': 'CheckedPopupMenuItem',
      'icon': Icons.check_circle,
      'color': Colors.green,
      'height': '48.0',
      'represents': 'true if value matches',
      'description': 'Shows checkmark based on checked property',
    },
  ];

  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < subtypes.length; i = i + 1) {
    Map<String, dynamic> subtype = subtypes[i];
    Color color = subtype['color'] as Color;
    IconData icon = subtype['icon'] as IconData;
    String name = subtype['name'] as String;
    String height = subtype['height'] as String;
    String represents = subtype['represents'] as String;
    String description = subtype['description'] as String;

    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withAlpha(15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withAlpha(40)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: color.withAlpha(40),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                buildPropertyChip('height: ' + height, color),
                SizedBox(width: 8),
                buildPropertyChip('represents: ' + represents, color),
              ],
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
          'Entry Subtypes Comparison',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Built-in implementations of PopupMenuEntry',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

Widget buildPropertyChip(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    ),
  );
}

Widget buildMenuStructureDemo() {
  print('Building menu structure demo');

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
          'Entry in Menu Structure',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildStructureRow('PopupMenuButton', 0, Colors.indigo),
              buildStructureRow('itemBuilder: (context) {', 1, Colors.grey),
              buildStructureRow('return [', 2, Colors.grey),
              buildStructureRow('PopupMenuItem<T>', 3, Colors.blue),
              buildStructureRow('PopupMenuDivider', 3, Colors.grey),
              buildStructureRow('CheckedPopupMenuItem<T>', 3, Colors.green),
              buildStructureRow('CustomEntry<T>', 3, Colors.orange),
              buildStructureRow('];', 2, Colors.grey),
              buildStructureRow('}', 1, Colors.grey),
            ],
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Menu Flow',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        buildFlowStep('1', 'PopupMenuButton pressed', Colors.indigo),
        buildFlowStep('2', 'itemBuilder called with context', Colors.blue),
        buildFlowStep('3', 'Returns List<PopupMenuEntry<T>>', Colors.green),
        buildFlowStep('4', 'Each entry builds its widget', Colors.orange),
        buildFlowStep('5', 'Selection triggers onSelected', Colors.purple),
      ],
    ),
  );
}

Widget buildStructureRow(String text, int indent, Color color) {
  return Padding(
    padding: EdgeInsets.only(left: indent * 16.0, top: 2, bottom: 2),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: color,
        fontWeight: indent == 3 ? FontWeight.bold : FontWeight.normal,
      ),
    ),
  );
}

Widget buildFlowStep(String number, String text, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Text(
          text,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
      ],
    ),
  );
}

Widget buildInteractiveShowcase() {
  print('Building interactive showcase');

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
          'Interactive Entry Showcase',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Tap each button to see different entry configurations',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            buildInteractiveButton(
              'File Menu',
              Icons.folder,
              Colors.blue,
              [
                PopupMenuItem<String>(value: 'new', child: Text('New')),
                PopupMenuItem<String>(value: 'open', child: Text('Open')),
                PopupMenuItem<String>(value: 'save', child: Text('Save')),
                PopupMenuDivider(),
                PopupMenuItem<String>(value: 'export', child: Text('Export')),
                PopupMenuItem<String>(value: 'print', child: Text('Print')),
              ],
            ),
            buildInteractiveButton(
              'Edit Menu',
              Icons.edit,
              Colors.green,
              [
                PopupMenuItem<String>(value: 'undo', child: Text('Undo')),
                PopupMenuItem<String>(value: 'redo', child: Text('Redo')),
                PopupMenuDivider(),
                PopupMenuItem<String>(value: 'cut', child: Text('Cut')),
                PopupMenuItem<String>(value: 'copy', child: Text('Copy')),
                PopupMenuItem<String>(value: 'paste', child: Text('Paste')),
              ],
            ),
            buildInteractiveButton(
              'View Menu',
              Icons.visibility,
              Colors.purple,
              [
                CheckedPopupMenuItem<String>(value: 'toolbar', checked: true, child: Text('Toolbar')),
                CheckedPopupMenuItem<String>(value: 'sidebar', checked: true, child: Text('Sidebar')),
                CheckedPopupMenuItem<String>(value: 'statusbar', checked: false, child: Text('Status Bar')),
                PopupMenuDivider(),
                PopupMenuItem<String>(value: 'zoom_in', child: Text('Zoom In')),
                PopupMenuItem<String>(value: 'zoom_out', child: Text('Zoom Out')),
              ],
            ),
            buildInteractiveButton(
              'Format Menu',
              Icons.format_paint,
              Colors.orange,
              [
                PopupMenuItem<String>(value: 'bold', child: Row(children: [Icon(Icons.format_bold, size: 18), SizedBox(width: 8), Text('Bold')])),
                PopupMenuItem<String>(value: 'italic', child: Row(children: [Icon(Icons.format_italic, size: 18), SizedBox(width: 8), Text('Italic')])),
                PopupMenuItem<String>(value: 'underline', child: Row(children: [Icon(Icons.format_underline, size: 18), SizedBox(width: 8), Text('Underline')])),
                PopupMenuDivider(),
                PopupMenuItem<String>(value: 'align', child: Text('Alignment...')),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildInteractiveButton(
  String label,
  IconData icon,
  Color color,
  List<PopupMenuEntry<String>> items,
) {
  return PopupMenuButton<String>(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(60),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
    itemBuilder: (BuildContext context) {
      return items;
    },
    onSelected: (String value) {
      print(label + ' selected: ' + value);
    },
  );
}

Widget buildEntryPropertiesTable() {
  print('Building entry properties table');

  List<List<String>> rows = [
    ['height', 'double', 'Height of the entry in logical pixels'],
    ['represents(T? value)', 'bool', 'Whether entry represents given value'],
    ['enabled', 'bool', 'Whether the entry is interactive'],
    ['value', 'T?', 'The value returned when selected'],
    ['child', 'Widget?', 'The widget content of the entry'],
    ['onTap', 'VoidCallback?', 'Called when entry is tapped'],
    ['textStyle', 'TextStyle?', 'Text style for the entry content'],
    ['labelTextStyle', 'WidgetStateProperty?', 'Stateful label text style'],
    ['padding', 'EdgeInsets?', 'Content padding within entry'],
  ];

  List<Widget> tableRows = [];
  int i = 0;
  for (i = 0; i < rows.length; i = i + 1) {
    List<String> row = rows[i];
    bool isEven = (i % 2) == 0;

    tableRows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isEven ? Colors.grey.shade50 : Colors.white,
        ),
        child: Row(
          children: [
            Container(
              width: 140,
              child: Text(
                row[0],
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ),
            Container(
              width: 80,
              child: Text(
                row[1],
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.green.shade700,
                ),
              ),
            ),
            Expanded(
              child: Text(
                row[2],
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Text(
            'PopupMenuEntry Properties',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
          ),
          child: Row(
            children: [
              Container(
                width: 140,
                child: Text(
                  'Property',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: 80,
                child: Text(
                  'Type',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text(
                  'Description',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Column(children: tableRows),
      ],
    ),
  );
}

Widget buildUsageExamples() {
  print('Building usage examples');

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
          'Usage Examples',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        buildUsageExample(
          'Basic PopupMenuItem',
          'PopupMenuItem<String>(\n'
          '  value: \'option1\',\n'
          '  child: Text(\'Option 1\'),\n'
          ')',
          Colors.blue,
        ),
        SizedBox(height: 10),
        buildUsageExample(
          'Disabled Item',
          'PopupMenuItem<String>(\n'
          '  value: \'disabled\',\n'
          '  enabled: false,\n'
          '  child: Text(\'Disabled Option\'),\n'
          ')',
          Colors.grey,
        ),
        SizedBox(height: 10),
        buildUsageExample(
          'Item with Icon',
          'PopupMenuItem<String>(\n'
          '  value: \'settings\',\n'
          '  child: Row(\n'
          '    children: [\n'
          '      Icon(Icons.settings, size: 18),\n'
          '      SizedBox(width: 12),\n'
          '      Text(\'Settings\'),\n'
          '    ],\n'
          '  ),\n'
          ')',
          Colors.green,
        ),
        SizedBox(height: 10),
        buildUsageExample(
          'Checked Item',
          'CheckedPopupMenuItem<String>(\n'
          '  value: \'option\',\n'
          '  checked: true,\n'
          '  child: Text(\'Checked Option\'),\n'
          ')',
          Colors.purple,
        ),
      ],
    ),
  );
}

Widget buildUsageExample(String title, String code, Color color) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7),
              topRight: Radius.circular(7),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(7),
              bottomRight: Radius.circular(7),
            ),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Colors.green.shade300,
            ),
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('PopupMenuEntry deep demo test executing');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('PopupMenuEntry Demo'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. Overview'),
            buildInfoCard('Class', 'PopupMenuEntry<T>'),
            buildInfoCard('Type', 'Abstract base class'),
            buildInfoCard('Purpose', 'Base class for entries in popup menus'),
            buildInfoCard('Extends', 'StatefulWidget'),
            buildInfoCard('Generic Type', 'T - the type of value for selection'),
            buildInfoCard(
              'Key Methods',
              'height getter, represents(T? value) method',
            ),

            buildSectionHeader('2. Height Property'),
            buildInfoCard(
              'Definition',
              'Abstract getter returning the height in logical pixels',
            ),
            buildInfoCard(
              'Purpose',
              'Used to calculate popup menu total height',
            ),
            buildInfoCard('Standard Height', '48.0 for PopupMenuItem'),
            buildInfoCard('Divider Height', '16.0 for PopupMenuDivider'),
            buildHeightConceptDemo(),

            buildSectionHeader('3. Represents Value'),
            buildInfoCard(
              'Definition',
              'Abstract method bool represents(T? value)',
            ),
            buildInfoCard(
              'Purpose',
              'Determines if entry represents a given value',
            ),
            buildInfoCard(
              'Used For',
              'Initial value highlighting in menu',
            ),
            buildRepresentsValueDemo(),

            buildSectionHeader('4. PopupMenuItem'),
            buildPopupMenuItemShowcase(),

            buildSectionHeader('5. PopupMenuDivider'),
            buildDividerShowcase(),

            buildSectionHeader('6. CheckedPopupMenuItem'),
            buildCheckedItemShowcase(),

            buildSectionHeader('7. Custom Entry'),
            buildCustomEntryDemo(),

            buildSectionHeader('8. Subtypes Comparison'),
            buildSubtypesComparison(),

            buildSectionHeader('9. Menu Structure'),
            buildMenuStructureDemo(),

            buildSectionHeader('10. Interactive Showcase'),
            buildInteractiveShowcase(),

            buildSectionHeader('11. Properties Table'),
            buildEntryPropertiesTable(),

            buildSectionHeader('12. Usage Examples'),
            buildUsageExamples(),

            buildSectionHeader('13. Best Practices'),
            buildInfoCard(
              'Tip 1',
              'Use PopupMenuDivider to separate logical groups',
            ),
            buildInfoCard(
              'Tip 2',
              'CheckedPopupMenuItem for toggle/selection states',
            ),
            buildInfoCard(
              'Tip 3',
              'Set enabled to false for disabled items',
            ),
            buildInfoCard(
              'Tip 4',
              'Use generic type T for type-safe value handling',
            ),
            buildInfoCard(
              'Tip 5',
              'Custom entries should override height accurately',
            ),
            buildInfoCard(
              'Tip 6',
              'Implement represents correctly for initial selection',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('PopupMenuEntry deep demo completed');
  return result;
}
