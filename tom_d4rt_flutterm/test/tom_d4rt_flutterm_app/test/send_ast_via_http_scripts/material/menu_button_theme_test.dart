// D4rt test script: Tests MenuButtonTheme InheritedWidget from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.teal.shade700,
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

Widget buildDescriptionBox(String text) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.teal.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 14, color: Colors.teal.shade900),
    ),
  );
}

Widget buildOverviewSection() {
  print('Building overview section for MenuButtonTheme');
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
            Icon(Icons.palette, color: Colors.teal, size: 28),
            SizedBox(width: 12),
            Text(
              'MenuButtonTheme',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        buildDescriptionBox(
          'MenuButtonTheme is an InheritedWidget that provides MenuButtonThemeData to its '
          'descendant widgets. It enables consistent theming of MenuItemButton widgets '
          'without explicitly passing theme data to each button. Descendants can access '
          'the theme using MenuButtonTheme.of(context).',
        ),
        SizedBox(height: 12),
        buildInfoCard('Type', 'InheritedWidget'),
        buildInfoCard('Data Type', 'MenuButtonThemeData'),
        buildInfoCard('Access Method', 'MenuButtonTheme.of(context)'),
        buildInfoCard('Purpose', 'Propagate menu button styles down the widget tree'),
      ],
    ),
  );
}

Widget buildBasicThemeWrappingSection() {
  print('Building MenuButtonTheme wrapping MenuItemButtons');
  ButtonStyle primaryStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.hovered)) {
        return Colors.teal.shade200;
      }
      return Colors.teal.shade50;
    }),
    foregroundColor: WidgetStateProperty.all(Colors.teal.shade900),
    padding: WidgetStateProperty.all(
      EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    ),
  );

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
          'MenuButtonTheme Wrapping MenuItemButtons',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'All children inherit the theme automatically',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        MenuButtonTheme(
          data: MenuButtonThemeData(style: primaryStyle),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.teal.shade200),
            ),
            child: Column(
              children: [
                MenuItemButton(
                  onPressed: () {
                    print('Wrapped item 1 pressed');
                  },
                  leadingIcon: Icon(Icons.folder, color: Colors.teal.shade700),
                  child: Text('Documents'),
                ),
                MenuItemButton(
                  onPressed: () {
                    print('Wrapped item 2 pressed');
                  },
                  leadingIcon: Icon(Icons.image, color: Colors.teal.shade700),
                  child: Text('Images'),
                ),
                MenuItemButton(
                  onPressed: () {
                    print('Wrapped item 3 pressed');
                  },
                  leadingIcon: Icon(Icons.video_library, color: Colors.teal.shade700),
                  child: Text('Videos'),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12),
        buildInfoCard('Theme Scope', 'All MenuItemButton descendants'),
        buildInfoCard('Inheritance', 'Automatic via InheritedWidget'),
      ],
    ),
  );
}

Widget buildNestedThemeOverridesSection() {
  print('Building nested MenuButtonTheme overrides section');
  ButtonStyle outerStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.blue.shade100),
    foregroundColor: WidgetStateProperty.all(Colors.blue.shade900),
  );

  ButtonStyle innerStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.orange.shade100),
    foregroundColor: WidgetStateProperty.all(Colors.orange.shade900),
  );

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
          'Nested MenuButtonTheme Overrides',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Inner themes override outer themes',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        MenuButtonTheme(
          data: MenuButtonThemeData(style: outerStyle),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    MenuItemButton(
                      onPressed: () {
                        print('Outer themed item 1');
                      },
                      leadingIcon: Icon(Icons.cloud, color: Colors.blue),
                      child: Text('Cloud Storage'),
                    ),
                    MenuItemButton(
                      onPressed: () {
                        print('Outer themed item 2');
                      },
                      leadingIcon: Icon(Icons.backup, color: Colors.blue),
                      child: Text('Backup'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Nested Override Zone:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange.shade800,
                ),
              ),
              SizedBox(height: 8),
              MenuButtonTheme(
                data: MenuButtonThemeData(style: innerStyle),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      MenuItemButton(
                        onPressed: () {
                          print('Inner themed item 1');
                        },
                        leadingIcon: Icon(Icons.warning, color: Colors.orange),
                        child: Text('Warnings'),
                      ),
                      MenuItemButton(
                        onPressed: () {
                          print('Inner themed item 2');
                        },
                        leadingIcon: Icon(Icons.error, color: Colors.orange),
                        child: Text('Errors'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        buildInfoCard('Outer Theme', 'Blue styling'),
        buildInfoCard('Inner Theme', 'Orange styling (overrides)'),
      ],
    ),
  );
}

Widget buildThemeOfContextSection() {
  print('Building MenuButtonTheme.of(context) usage section');
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
          'MenuButtonTheme.of(context) Usage',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Access theme data from any descendant widget',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        buildDescriptionBox(
          'Use MenuButtonTheme.of(context) to retrieve the nearest MenuButtonThemeData '
          'from the widget tree. This is useful when you need to access or modify '
          'theme properties in nested widgets or custom button implementations.',
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'MenuButtonThemeData? themeData = \n'
            '    MenuButtonTheme.of(context);\n\n'
            'ButtonStyle? style = themeData?.style;\n'
            'print(style);',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              color: Colors.green.shade300,
            ),
          ),
        ),
        SizedBox(height: 12),
        buildInfoCard('Method', 'MenuButtonTheme.of(context)'),
        buildInfoCard('Returns', 'MenuButtonThemeData'),
        buildInfoCard('Null Safety', 'Returns default if no theme found'),
      ],
    ),
  );
}

Widget buildMultipleThemedSectionsSection() {
  print('Building multiple themed sections');
  ButtonStyle fileStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.green.shade100),
    foregroundColor: WidgetStateProperty.all(Colors.green.shade900),
  );

  ButtonStyle editStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.purple.shade100),
    foregroundColor: WidgetStateProperty.all(Colors.purple.shade900),
  );

  ButtonStyle viewStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.cyan.shade100),
    foregroundColor: WidgetStateProperty.all(Colors.cyan.shade900),
  );

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
          'Multiple Themed Sections',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Different sections with distinct themes',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'File Menu',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade800),
                  ),
                  SizedBox(height: 8),
                  MenuButtonTheme(
                    data: MenuButtonThemeData(style: fileStyle),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green.shade300),
                      ),
                      child: Column(
                        children: [
                          MenuItemButton(
                            onPressed: () {
                              print('New file');
                            },
                            child: Text('New'),
                          ),
                          MenuItemButton(
                            onPressed: () {
                              print('Open file');
                            },
                            child: Text('Open'),
                          ),
                          MenuItemButton(
                            onPressed: () {
                              print('Save file');
                            },
                            child: Text('Save'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Edit Menu',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple.shade800),
                  ),
                  SizedBox(height: 8),
                  MenuButtonTheme(
                    data: MenuButtonThemeData(style: editStyle),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.purple.shade300),
                      ),
                      child: Column(
                        children: [
                          MenuItemButton(
                            onPressed: () {
                              print('Cut');
                            },
                            child: Text('Cut'),
                          ),
                          MenuItemButton(
                            onPressed: () {
                              print('Copy');
                            },
                            child: Text('Copy'),
                          ),
                          MenuItemButton(
                            onPressed: () {
                              print('Paste');
                            },
                            child: Text('Paste'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'View Menu',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyan.shade800),
                  ),
                  SizedBox(height: 8),
                  MenuButtonTheme(
                    data: MenuButtonThemeData(style: viewStyle),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.cyan.shade300),
                      ),
                      child: Column(
                        children: [
                          MenuItemButton(
                            onPressed: () {
                              print('Zoom in');
                            },
                            child: Text('Zoom In'),
                          ),
                          MenuItemButton(
                            onPressed: () {
                              print('Zoom out');
                            },
                            child: Text('Zoom Out'),
                          ),
                          MenuItemButton(
                            onPressed: () {
                              print('Full screen');
                            },
                            child: Text('Fullscreen'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        buildInfoCard('File Theme', 'Green styling'),
        buildInfoCard('Edit Theme', 'Purple styling'),
        buildInfoCard('View Theme', 'Cyan styling'),
      ],
    ),
  );
}

Widget buildInheritanceDemonstrationSection() {
  print('Building inheritance demonstration section');
  ButtonStyle rootStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return Colors.deepPurple.shade300;
      }
      if (states.contains(WidgetState.hovered)) {
        return Colors.deepPurple.shade100;
      }
      return Colors.deepPurple.shade50;
    }),
    foregroundColor: WidgetStateProperty.all(Colors.deepPurple.shade900),
    textStyle: WidgetStateProperty.all(
      TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
    ),
    padding: WidgetStateProperty.all(
      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  );

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
          'Inheritance Demonstration',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Theme propagates through multiple widget layers',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        MenuButtonTheme(
          data: MenuButtonThemeData(style: rootStyle),
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.deepPurple.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Root Theme Level',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade800,
                  ),
                ),
                SizedBox(height: 8),
                MenuItemButton(
                  onPressed: () {
                    print('Root level item');
                  },
                  leadingIcon: Icon(Icons.home, color: Colors.deepPurple),
                  child: Text('Root Item'),
                ),
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.deepPurple.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'First Nested Level',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.deepPurple.shade700,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 8),
                      MenuItemButton(
                        onPressed: () {
                          print('Nested level 1 item');
                        },
                        leadingIcon: Icon(Icons.folder, color: Colors.deepPurple),
                        child: Text('Nested Item 1'),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade50,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Second Nested Level',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.deepPurple.shade600,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 6),
                            MenuItemButton(
                              onPressed: () {
                                print('Nested level 2 item');
                              },
                              leadingIcon: Icon(Icons.description, color: Colors.deepPurple),
                              child: Text('Deeply Nested'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12),
        buildInfoCard('Inheritance', 'Flows through all nested containers'),
        buildInfoCard('Scope', 'All descendants receive same theme'),
      ],
    ),
  );
}

Widget buildThemeMergingConceptSection() {
  print('Building theme merging concept section');
  ButtonStyle baseStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.grey.shade200),
    padding: WidgetStateProperty.all(EdgeInsets.all(12)),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  ButtonStyle mergedStyle = baseStyle.copyWith(
    foregroundColor: WidgetStateProperty.all(Colors.indigo.shade800),
    textStyle: WidgetStateProperty.all(
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  );

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
          'Theme Merging Concept',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Combining base styles with additional properties',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Base Style Only',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  MenuButtonTheme(
                    data: MenuButtonThemeData(style: baseStyle),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: MenuItemButton(
                        onPressed: () {
                          print('Base style item');
                        },
                        child: Text('Base Item'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Merged Style',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  MenuButtonTheme(
                    data: MenuButtonThemeData(style: mergedStyle),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.indigo.shade300),
                      ),
                      child: MenuItemButton(
                        onPressed: () {
                          print('Merged style item');
                        },
                        child: Text('Merged Item'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        buildDescriptionBox(
          'Use copyWith() on ButtonStyle to create merged styles. The merged style '
          'inherits properties from the base style and adds or overrides specific properties. '
          'This pattern is useful for creating variations of a base theme.',
        ),
        SizedBox(height: 12),
        buildInfoCard('Base Properties', 'background, padding, shape'),
        buildInfoCard('Merged Additions', 'foregroundColor, textStyle'),
      ],
    ),
  );
}

Widget buildInteractiveThemedMenusSection() {
  print('Building interactive themed menus section');
  List<Map<String, dynamic>> menuCategories = [
    {
      'name': 'Account',
      'color': Colors.blue,
      'items': ['Profile', 'Settings', 'Logout'],
      'icons': [Icons.person, Icons.settings, Icons.logout],
    },
    {
      'name': 'Tools',
      'color': Colors.green,
      'items': ['Calculator', 'Notes', 'Calendar'],
      'icons': [Icons.calculate, Icons.note, Icons.calendar_today],
    },
    {
      'name': 'Help',
      'color': Colors.orange,
      'items': ['FAQ', 'Support', 'About'],
      'icons': [Icons.help, Icons.support, Icons.info],
    },
  ];

  List<Widget> categoryWidgets = [];
  int i = 0;
  for (i = 0; i < menuCategories.length; i = i + 1) {
    Map<String, dynamic> category = menuCategories[i];
    String name = category['name'] as String;
    MaterialColor color = category['color'] as MaterialColor;
    List<String> items = category['items'] as List<String>;
    List<IconData> icons = category['icons'] as List<IconData>;

    ButtonStyle categoryStyle = ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return color.shade300;
        }
        if (states.contains(WidgetState.hovered)) {
          return color.shade100;
        }
        return color.shade50;
      }),
      foregroundColor: WidgetStateProperty.all(color.shade900),
    );

    List<Widget> itemWidgets = [];
    int j = 0;
    for (j = 0; j < items.length; j = j + 1) {
      String item = items[j];
      IconData icon = icons[j];
      itemWidgets.add(
        MenuItemButton(
          onPressed: () {
            print('$name -> $item pressed');
          },
          leadingIcon: Icon(icon, color: color.shade700, size: 20),
          child: Text(item),
        ),
      );
    }

    categoryWidgets.add(
      Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: color.shade700,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              MenuButtonTheme(
                data: MenuButtonThemeData(style: categoryStyle),
                child: Container(
                  decoration: BoxDecoration(
                    color: color.shade50,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    border: Border.all(color: color.shade200),
                  ),
                  child: Column(children: itemWidgets),
                ),
              ),
            ],
          ),
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
          'Interactive Themed Menus',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Dynamic menu categories with individual themes',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: categoryWidgets,
        ),
        SizedBox(height: 12),
        buildInfoCard('Categories', '3 themed sections'),
        buildInfoCard('Interaction', 'Hover and press states'),
      ],
    ),
  );
}

Widget buildThemeComparisonGridSection() {
  print('Building theme comparison grid section');
  List<Map<String, dynamic>> themeVariants = [
    {
      'name': 'Default',
      'style': ButtonStyle(),
    },
    {
      'name': 'Rounded',
      'style': ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
      ),
    },
    {
      'name': 'Bold Text',
      'style': ButtonStyle(
        textStyle: WidgetStateProperty.all(
          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    },
    {
      'name': 'Compact',
      'style': ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
        minimumSize: WidgetStateProperty.all(Size(0, 32)),
      ),
    },
    {
      'name': 'Elevated',
      'style': ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.white),
        elevation: WidgetStateProperty.all(4),
        shadowColor: WidgetStateProperty.all(Colors.black26),
      ),
    },
    {
      'name': 'Outlined',
      'style': ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        side: WidgetStateProperty.all(BorderSide(color: Colors.teal, width: 2)),
        foregroundColor: WidgetStateProperty.all(Colors.teal.shade800),
      ),
    },
  ];

  List<Widget> themeCards = [];
  int i = 0;
  for (i = 0; i < themeVariants.length; i = i + 1) {
    Map<String, dynamic> variant = themeVariants[i];
    String name = variant['name'] as String;
    ButtonStyle style = variant['style'] as ButtonStyle;

    themeCards.add(
      Container(
        width: 150,
        margin: EdgeInsets.all(4),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: MenuButtonTheme(
                data: MenuButtonThemeData(style: style),
                child: MenuItemButton(
                  onPressed: () {
                    print('$name variant pressed');
                  },
                  child: Text('Sample'),
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
          'Theme Comparison Grid',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Side-by-side comparison of different theme styles',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: themeCards,
        ),
        SizedBox(height: 12),
        buildInfoCard('Variants', '6 different theme styles'),
        buildInfoCard('Purpose', 'Visual comparison of style options'),
      ],
    ),
  );
}

Widget buildFullMenuWithThemedStylingSection() {
  print('Building full menu with themed styling section');
  ButtonStyle mainMenuStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return Colors.teal.shade400;
      }
      if (states.contains(WidgetState.hovered)) {
        return Colors.teal.shade200;
      }
      return Colors.teal.shade100;
    }),
    foregroundColor: WidgetStateProperty.all(Colors.teal.shade900),
    padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
    textStyle: WidgetStateProperty.all(
      TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
    ),
  );

  ButtonStyle subMenuStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.hovered)) {
        return Colors.grey.shade200;
      }
      return Colors.white;
    }),
    foregroundColor: WidgetStateProperty.all(Colors.grey.shade800),
    padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 12, vertical: 10)),
  );

  ButtonStyle actionStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return Colors.red.shade400;
      }
      if (states.contains(WidgetState.hovered)) {
        return Colors.red.shade100;
      }
      return Colors.red.shade50;
    }),
    foregroundColor: WidgetStateProperty.all(Colors.red.shade900),
  );

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
          'Full Menu with Themed Styling',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Complete menu layout with multiple theme zones',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal.shade700,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(11),
                    topRight: Radius.circular(11),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.menu, color: Colors.white),
                    SizedBox(width: 12),
                    Text(
                      'Application Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              MenuButtonTheme(
                data: MenuButtonThemeData(style: mainMenuStyle),
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      MenuItemButton(
                        onPressed: () {
                          print('Dashboard selected');
                        },
                        leadingIcon: Icon(Icons.dashboard, color: Colors.teal.shade700),
                        trailingIcon: Icon(Icons.arrow_forward_ios, size: 14),
                        child: Text('Dashboard'),
                      ),
                      MenuItemButton(
                        onPressed: () {
                          print('Projects selected');
                        },
                        leadingIcon: Icon(Icons.folder_open, color: Colors.teal.shade700),
                        trailingIcon: Icon(Icons.arrow_forward_ios, size: 14),
                        child: Text('Projects'),
                      ),
                      MenuItemButton(
                        onPressed: () {
                          print('Reports selected');
                        },
                        leadingIcon: Icon(Icons.assessment, color: Colors.teal.shade700),
                        trailingIcon: Icon(Icons.arrow_forward_ios, size: 14),
                        child: Text('Reports'),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(height: 1, color: Colors.grey.shade300),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              MenuButtonTheme(
                data: MenuButtonThemeData(style: subMenuStyle),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      MenuItemButton(
                        onPressed: () {
                          print('Preferences selected');
                        },
                        leadingIcon: Icon(Icons.tune, size: 20),
                        child: Text('Preferences'),
                      ),
                      MenuItemButton(
                        onPressed: () {
                          print('Account selected');
                        },
                        leadingIcon: Icon(Icons.person, size: 20),
                        child: Text('Account'),
                      ),
                      MenuItemButton(
                        onPressed: () {
                          print('Notifications selected');
                        },
                        leadingIcon: Icon(Icons.notifications, size: 20),
                        child: Text('Notifications'),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(height: 1, color: Colors.grey.shade300),
              MenuButtonTheme(
                data: MenuButtonThemeData(style: actionStyle),
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: MenuItemButton(
                    onPressed: () {
                      print('Sign out selected');
                    },
                    leadingIcon: Icon(Icons.logout, color: Colors.red.shade700),
                    child: Text('Sign Out'),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        buildInfoCard('Main Menu', 'Teal themed primary items'),
        buildInfoCard('Settings', 'Neutral submenu styling'),
        buildInfoCard('Actions', 'Red themed danger action'),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('Building MenuButtonTheme InheritedWidget demo');
  return Scaffold(
    appBar: AppBar(
      title: Text('MenuButtonTheme Demo'),
      backgroundColor: Colors.teal.shade700,
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionHeader('1. Overview of MenuButtonTheme'),
          buildOverviewSection(),
          buildSectionHeader('2. MenuButtonTheme Wrapping MenuItemButtons'),
          buildBasicThemeWrappingSection(),
          buildSectionHeader('3. Nested MenuButtonTheme Overrides'),
          buildNestedThemeOverridesSection(),
          buildSectionHeader('4. MenuButtonTheme.of(context) Usage'),
          buildThemeOfContextSection(),
          buildSectionHeader('5. Multiple Themed Sections'),
          buildMultipleThemedSectionsSection(),
          buildSectionHeader('6. Inheritance Demonstration'),
          buildInheritanceDemonstrationSection(),
          buildSectionHeader('7. Theme Merging Concept'),
          buildThemeMergingConceptSection(),
          buildSectionHeader('8. Interactive Themed Menus'),
          buildInteractiveThemedMenusSection(),
          buildSectionHeader('9. Theme Comparison Grid'),
          buildThemeComparisonGridSection(),
          buildSectionHeader('10. Full Menu with Themed Styling'),
          buildFullMenuWithThemedStylingSection(),
          SizedBox(height: 32),
        ],
      ),
    ),
  );
}
