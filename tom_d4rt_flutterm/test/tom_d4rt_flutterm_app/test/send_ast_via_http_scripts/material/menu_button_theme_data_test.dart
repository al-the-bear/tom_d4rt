// D4rt test script: Tests MenuButtonThemeData from material
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

Widget buildDescriptionBox(String text) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.blue.shade200),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 14, color: Colors.blue.shade900),
    ),
  );
}

Widget buildOverviewSection() {
  print('Building overview section for MenuButtonThemeData');
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
            Icon(Icons.menu, color: Colors.indigo, size: 28),
            SizedBox(width: 12),
            Text(
              'MenuButtonThemeData',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        buildDescriptionBox(
          'MenuButtonThemeData defines the visual properties for MenuItemButton widgets. '
          'It allows consistent theming of menu items across an app, including style, colors, '
          'padding, shape, and other visual attributes.',
        ),
        SizedBox(height: 12),
        buildInfoCard('Widget', 'MenuItemButton'),
        buildInfoCard('Theme Wrapper', 'MenuButtonTheme'),
        buildInfoCard('Purpose', 'Consistent menu item styling'),
        buildInfoCard('Usage', 'ThemeData.menuButtonTheme or MenuButtonTheme'),
      ],
    ),
  );
}

Widget buildDefaultMenuItemButton() {
  print('Building default MenuItemButton appearance');
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
          'Default MenuItemButton Appearance',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'MenuItemButton with default theme settings',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              MenuItemButton(
                onPressed: () {
                  print('Default menu item 1 pressed');
                },
                leadingIcon: Icon(Icons.home),
                child: Text('Home'),
              ),
              MenuItemButton(
                onPressed: () {
                  print('Default menu item 2 pressed');
                },
                leadingIcon: Icon(Icons.settings),
                child: Text('Settings'),
              ),
              MenuItemButton(
                onPressed: () {
                  print('Default menu item 3 pressed');
                },
                leadingIcon: Icon(Icons.info),
                child: Text('About'),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        buildInfoCard('Style', 'Default platform style'),
        buildInfoCard('Padding', 'Standard menu padding'),
      ],
    ),
  );
}

Widget buildThemedMenuItemButton() {
  print('Building themed MenuItemButton with custom style');
  ButtonStyle customStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.hovered)) {
        return Colors.indigo.shade100;
      }
      return Colors.transparent;
    }),
    foregroundColor: WidgetStateProperty.all(Colors.indigo.shade800),
    textStyle: WidgetStateProperty.all(
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    ),
    padding: WidgetStateProperty.all(
      EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  MenuButtonThemeData themeData = MenuButtonThemeData(style: customStyle);

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
          'Themed MenuItemButton',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'MenuItemButton with custom MenuButtonThemeData applied',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        MenuButtonTheme(
          data: themeData,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.indigo.shade200),
            ),
            child: Column(
              children: [
                MenuItemButton(
                  onPressed: () {
                    print('Themed menu item 1');
                  },
                  leadingIcon: Icon(Icons.dashboard, color: Colors.indigo),
                  child: Text('Dashboard'),
                ),
                MenuItemButton(
                  onPressed: () {
                    print('Themed menu item 2');
                  },
                  leadingIcon: Icon(Icons.analytics, color: Colors.indigo),
                  child: Text('Analytics'),
                ),
                MenuItemButton(
                  onPressed: () {
                    print('Themed menu item 3');
                  },
                  leadingIcon: Icon(Icons.account_circle, color: Colors.indigo),
                  child: Text('Profile'),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12),
        buildInfoCard('Custom Style', 'Applied via MenuButtonThemeData'),
        buildInfoCard('Hover Color', 'Indigo shade 100'),
      ],
    ),
  );
}

Widget buildBackgroundColorTheming() {
  print('Building background color theming section');
  List<MaterialColor> bgColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
  ];
  List<String> labels = ['Alerts', 'Success', 'Information', 'Warnings'];
  List<IconData> icons = [
    Icons.warning,
    Icons.check_circle,
    Icons.info,
    Icons.notifications,
  ];

  List<Widget> menuItems = [];
  int i = 0;
  for (i = 0; i < bgColors.length; i = i + 1) {
    MaterialColor color = bgColors[i];
    String label = labels[i];
    IconData icon = icons[i];

    ButtonStyle style = ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return color.shade200;
        }
        return color.shade100;
      }),
      foregroundColor: WidgetStateProperty.all(color.shade900),
    );

    menuItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: MenuButtonTheme(
          data: MenuButtonThemeData(style: style),
          child: MenuItemButton(
            onPressed: () {
              print('Background themed item: $label');
            },
            leadingIcon: Icon(icon, color: color.shade700),
            child: Text(label),
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
          'Background Color Theming',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Each MenuItemButton with distinct background colors',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Column(children: menuItems),
        SizedBox(height: 12),
        buildInfoCard('Property', 'backgroundColor in ButtonStyle'),
        buildInfoCard('Hover Effect', 'Darker shade on hover'),
      ],
    ),
  );
}

Widget buildForegroundTextColorTheming() {
  print('Building foreground/text color theming section');

  List<Color> fgColors = [
    Colors.purple.shade800,
    Colors.teal.shade800,
    Colors.brown.shade800,
    Colors.pink.shade800,
  ];
  List<String> menuLabels = ['Premium', 'Eco-Friendly', 'Classic', 'Trendy'];
  List<IconData> menuIcons = [Icons.star, Icons.eco, Icons.style, Icons.trending_up];

  List<Widget> items = [];
  int j = 0;
  for (j = 0; j < fgColors.length; j = j + 1) {
    Color fg = fgColors[j];
    String lbl = menuLabels[j];
    IconData ico = menuIcons[j];

    ButtonStyle fgStyle = ButtonStyle(
      foregroundColor: WidgetStateProperty.all(fg),
      textStyle: WidgetStateProperty.all(
        TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
      iconColor: WidgetStateProperty.all(fg),
    );

    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: MenuButtonTheme(
          data: MenuButtonThemeData(style: fgStyle),
          child: MenuItemButton(
            onPressed: () {
              print('Foreground themed item: $lbl');
            },
            leadingIcon: Icon(ico),
            child: Text(lbl),
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
          'Foreground/Text Color Theming',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Different text and icon colors for menu items',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Column(children: items),
        SizedBox(height: 12),
        buildInfoCard('Properties', 'foregroundColor, iconColor, textStyle'),
        buildInfoCard('Effect', 'Consistent text and icon coloring'),
      ],
    ),
  );
}

Widget buildPaddingCustomization() {
  print('Building padding customization section');

  List<EdgeInsets> paddings = [
    EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    EdgeInsets.symmetric(horizontal: 32, vertical: 20),
    EdgeInsets.all(24),
  ];
  List<String> paddingLabels = ['Compact', 'Standard', 'Spacious', 'Uniform'];

  List<Widget> paddedItems = [];
  int k = 0;
  for (k = 0; k < paddings.length; k = k + 1) {
    EdgeInsets pad = paddings[k];
    String padLabel = paddingLabels[k];

    ButtonStyle paddedStyle = ButtonStyle(
      padding: WidgetStateProperty.all(pad),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return Colors.cyan.shade100;
        }
        return Colors.cyan.shade50;
      }),
    );

    paddedItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.cyan.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: MenuButtonTheme(
          data: MenuButtonThemeData(style: paddedStyle),
          child: MenuItemButton(
            onPressed: () {
              print('Padding: $padLabel');
            },
            child: Text('$padLabel Padding'),
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
          'Padding Customization',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Different padding values affecting menu item size',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Column(children: paddedItems),
        SizedBox(height: 12),
        buildInfoCard('Property', 'padding in ButtonStyle'),
        buildInfoCard('Use Case', 'Touch targets, visual density'),
      ],
    ),
  );
}

Widget buildShapeBorderRadiusTheming() {
  print('Building shape/border radius theming section');

  List<OutlinedBorder> shapes = [
    RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    StadiumBorder(),
  ];
  List<String> shapeLabels = ['Square', 'Rounded', 'Pill', 'Stadium'];
  List<MaterialColor> shapeColors = [
    Colors.deepOrange,
    Colors.lightGreen,
    Colors.deepPurple,
    Colors.amber,
  ];

  List<Widget> shapedItems = [];
  int m = 0;
  for (m = 0; m < shapes.length; m = m + 1) {
    OutlinedBorder shape = shapes[m];
    String shapeLabel = shapeLabels[m];
    MaterialColor shapeColor = shapeColors[m];

    ButtonStyle shapedStyle = ButtonStyle(
      shape: WidgetStateProperty.all(shape),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return shapeColor.shade200;
        }
        return shapeColor.shade100;
      }),
      foregroundColor: WidgetStateProperty.all(shapeColor.shade900),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
    );

    shapedItems.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        child: MenuButtonTheme(
          data: MenuButtonThemeData(style: shapedStyle),
          child: MenuItemButton(
            onPressed: () {
              print('Shape: $shapeLabel');
            },
            leadingIcon: Icon(Icons.shape_line, color: shapeColor.shade700),
            child: Text('$shapeLabel Shape'),
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
          'Shape / Border Radius Theming',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Various border shapes for menu items',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Column(children: shapedItems),
        SizedBox(height: 12),
        buildInfoCard('Property', 'shape in ButtonStyle'),
        buildInfoCard('Options', 'RoundedRectangleBorder, StadiumBorder, etc'),
      ],
    ),
  );
}

Widget buildMultipleThemedMenuButtons() {
  print('Building multiple themed menu buttons section');

  ButtonStyle fileMenuStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.hovered)) {
        return Colors.blue.shade100;
      }
      return Colors.blue.shade50;
    }),
    foregroundColor: WidgetStateProperty.all(Colors.blue.shade800),
  );

  ButtonStyle editMenuStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.hovered)) {
        return Colors.green.shade100;
      }
      return Colors.green.shade50;
    }),
    foregroundColor: WidgetStateProperty.all(Colors.green.shade800),
  );

  ButtonStyle viewMenuStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.hovered)) {
        return Colors.orange.shade100;
      }
      return Colors.orange.shade50;
    }),
    foregroundColor: WidgetStateProperty.all(Colors.orange.shade800),
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
          'Multiple Themed Menu Buttons',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Different sections with distinct menu themes',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade200),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade700,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(9),
                          topRight: Radius.circular(9),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.folder, color: Colors.white, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'File',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MenuButtonTheme(
                      data: MenuButtonThemeData(style: fileMenuStyle),
                      child: Column(
                        children: [
                          MenuItemButton(
                            onPressed: () {},
                            leadingIcon: Icon(Icons.note_add),
                            child: Text('New'),
                          ),
                          MenuItemButton(
                            onPressed: () {},
                            leadingIcon: Icon(Icons.folder_open),
                            child: Text('Open'),
                          ),
                          MenuItemButton(
                            onPressed: () {},
                            leadingIcon: Icon(Icons.save),
                            child: Text('Save'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green.shade200),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green.shade700,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(9),
                          topRight: Radius.circular(9),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.edit, color: Colors.white, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'Edit',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MenuButtonTheme(
                      data: MenuButtonThemeData(style: editMenuStyle),
                      child: Column(
                        children: [
                          MenuItemButton(
                            onPressed: () {},
                            leadingIcon: Icon(Icons.undo),
                            child: Text('Undo'),
                          ),
                          MenuItemButton(
                            onPressed: () {},
                            leadingIcon: Icon(Icons.redo),
                            child: Text('Redo'),
                          ),
                          MenuItemButton(
                            onPressed: () {},
                            leadingIcon: Icon(Icons.content_cut),
                            child: Text('Cut'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange.shade200),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade700,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(9),
                          topRight: Radius.circular(9),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.visibility, color: Colors.white, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'View',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MenuButtonTheme(
                      data: MenuButtonThemeData(style: viewMenuStyle),
                      child: Column(
                        children: [
                          MenuItemButton(
                            onPressed: () {},
                            leadingIcon: Icon(Icons.zoom_in),
                            child: Text('Zoom In'),
                          ),
                          MenuItemButton(
                            onPressed: () {},
                            leadingIcon: Icon(Icons.zoom_out),
                            child: Text('Zoom Out'),
                          ),
                          MenuItemButton(
                            onPressed: () {},
                            leadingIcon: Icon(Icons.fullscreen),
                            child: Text('Full'),
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
      ],
    ),
  );
}

Widget buildMenuButtonThemeWrapping() {
  print('Building MenuButtonTheme wrapping MenuItems section');

  ButtonStyle wrappedStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return Colors.purple.shade300;
      }
      if (states.contains(WidgetState.hovered)) {
        return Colors.purple.shade100;
      }
      return Colors.purple.shade50;
    }),
    foregroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return Colors.white;
      }
      return Colors.purple.shade800;
    }),
    textStyle: WidgetStateProperty.all(
      TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
    ),
    padding: WidgetStateProperty.all(
      EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    elevation: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.hovered)) {
        return 2.0;
      }
      return 0.0;
    }),
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
          'MenuButtonTheme Wrapping MenuItems',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'A single theme wrapper applying styles to all children',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.purple.shade200),
          ),
          child: MenuButtonTheme(
            data: MenuButtonThemeData(style: wrappedStyle),
            child: Column(
              children: [
                MenuItemButton(
                  onPressed: () {
                    print('Wrapped item: Account');
                  },
                  leadingIcon: Icon(Icons.person),
                  trailingIcon: Icon(Icons.arrow_forward_ios, size: 14),
                  child: Text('Account Settings'),
                ),
                SizedBox(height: 8),
                MenuItemButton(
                  onPressed: () {
                    print('Wrapped item: Privacy');
                  },
                  leadingIcon: Icon(Icons.lock),
                  trailingIcon: Icon(Icons.arrow_forward_ios, size: 14),
                  child: Text('Privacy Options'),
                ),
                SizedBox(height: 8),
                MenuItemButton(
                  onPressed: () {
                    print('Wrapped item: Notifications');
                  },
                  leadingIcon: Icon(Icons.notifications),
                  trailingIcon: Icon(Icons.arrow_forward_ios, size: 14),
                  child: Text('Notifications'),
                ),
                SizedBox(height: 8),
                MenuItemButton(
                  onPressed: () {
                    print('Wrapped item: Help');
                  },
                  leadingIcon: Icon(Icons.help),
                  trailingIcon: Icon(Icons.arrow_forward_ios, size: 14),
                  child: Text('Help & Support'),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12),
        buildInfoCard('Pattern', 'Single theme wrapper for consistency'),
        buildInfoCard('Benefit', 'DRY - styles defined once'),
      ],
    ),
  );
}

Widget buildSideBySideThemeComparison() {
  print('Building side-by-side theme comparison section');

  ButtonStyle lightThemeStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.hovered)) {
        return Colors.grey.shade200;
      }
      return Colors.grey.shade100;
    }),
    foregroundColor: WidgetStateProperty.all(Colors.grey.shade900),
    padding: WidgetStateProperty.all(
      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  );

  ButtonStyle darkThemeStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.hovered)) {
        return Colors.grey.shade700;
      }
      return Colors.grey.shade800;
    }),
    foregroundColor: WidgetStateProperty.all(Colors.grey.shade100),
    padding: WidgetStateProperty.all(
      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  );

  ButtonStyle accentThemeStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.hovered)) {
        return Colors.teal.shade200;
      }
      return Colors.teal.shade100;
    }),
    foregroundColor: WidgetStateProperty.all(Colors.teal.shade900),
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
          'Side-by-Side Theme Comparison',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Light, Dark, and Accent themes compared',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Light Theme',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: MenuButtonTheme(
                      data: MenuButtonThemeData(style: lightThemeStyle),
                      child: Column(
                        children: [
                          MenuItemButton(
                            onPressed: () {},
                            leadingIcon: Icon(Icons.home),
                            child: Text('Home'),
                          ),
                          MenuItemButton(
                            onPressed: () {},
                            leadingIcon: Icon(Icons.search),
                            child: Text('Search'),
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
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Dark Theme',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade100,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      border: Border.all(color: Colors.grey.shade700),
                    ),
                    child: MenuButtonTheme(
                      data: MenuButtonThemeData(style: darkThemeStyle),
                      child: Column(
                        children: [
                          MenuItemButton(
                            onPressed: () {},
                            leadingIcon: Icon(Icons.home, color: Colors.grey.shade300),
                            child: Text('Home'),
                          ),
                          MenuItemButton(
                            onPressed: () {},
                            leadingIcon: Icon(Icons.search, color: Colors.grey.shade300),
                            child: Text('Search'),
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
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade700,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Accent Theme',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      border: Border.all(color: Colors.teal.shade300),
                    ),
                    child: MenuButtonTheme(
                      data: MenuButtonThemeData(style: accentThemeStyle),
                      child: Column(
                        children: [
                          MenuItemButton(
                            onPressed: () {},
                            leadingIcon: Icon(Icons.home, color: Colors.teal.shade700),
                            child: Text('Home'),
                          ),
                          MenuItemButton(
                            onPressed: () {},
                            leadingIcon: Icon(Icons.search, color: Colors.teal.shade700),
                            child: Text('Search'),
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
        buildInfoCard('Purpose', 'Visual comparison of theme styles'),
        buildInfoCard('Use Case', 'Testing themes before deployment'),
      ],
    ),
  );
}

Widget buildPropertySummary() {
  print('Building property summary section');

  List<Map<String, String>> properties = [
    {'name': 'style', 'type': 'ButtonStyle?', 'desc': 'Visual styling for menu buttons'},
    {'name': 'backgroundColor', 'type': 'WidgetStateProperty<Color?>', 'desc': 'Background fill color'},
    {'name': 'foregroundColor', 'type': 'WidgetStateProperty<Color?>', 'desc': 'Text and icon color'},
    {'name': 'padding', 'type': 'WidgetStateProperty<EdgeInsetsGeometry?>', 'desc': 'Inner spacing'},
    {'name': 'shape', 'type': 'WidgetStateProperty<OutlinedBorder?>', 'desc': 'Border shape'},
    {'name': 'textStyle', 'type': 'WidgetStateProperty<TextStyle?>', 'desc': 'Text appearance'},
    {'name': 'iconColor', 'type': 'WidgetStateProperty<Color?>', 'desc': 'Icon fill color'},
  ];

  List<Widget> propCards = [];
  int p = 0;
  for (p = 0; p < properties.length; p = p + 1) {
    Map<String, String> prop = properties[p];
    propCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.indigo.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.indigo.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              child: Text(
                prop['name'] ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
                  fontSize: 13,
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    prop['type'] ?? '',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    prop['desc'] ?? '',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                  ),
                ],
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
          'MenuButtonThemeData Properties',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Key properties available in MenuButtonThemeData',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Column(children: propCards),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('MenuButtonThemeData test executing');
  print('Class: MenuButtonThemeData');
  print('Package: material');
  print('Description: Theme data for MenuItemButton appearance');

  return Scaffold(
    backgroundColor: Colors.grey.shade200,
    appBar: AppBar(
      title: Text('MenuButtonThemeData Demo'),
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionHeader('1. Overview of MenuButtonThemeData'),
          buildOverviewSection(),
          buildSectionHeader('2. Default MenuItemButton Appearance'),
          buildDefaultMenuItemButton(),
          buildSectionHeader('3. Themed MenuItemButton with Custom Style'),
          buildThemedMenuItemButton(),
          buildSectionHeader('4. Background Color Theming'),
          buildBackgroundColorTheming(),
          buildSectionHeader('5. Foreground/Text Color Theming'),
          buildForegroundTextColorTheming(),
          buildSectionHeader('6. Padding Customization'),
          buildPaddingCustomization(),
          buildSectionHeader('7. Shape/Border Radius Theming'),
          buildShapeBorderRadiusTheming(),
          buildSectionHeader('8. Multiple Themed Menu Buttons'),
          buildMultipleThemedMenuButtons(),
          buildSectionHeader('9. MenuButtonTheme Wrapping MenuItems'),
          buildMenuButtonThemeWrapping(),
          buildSectionHeader('10. Side-by-Side Theme Comparison'),
          buildSideBySideThemeComparison(),
          buildSectionHeader('11. Property Summary'),
          buildPropertySummary(),
          SizedBox(height: 32),
          Center(
            child: Text(
              'MenuButtonThemeData Demo Complete',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    ),
  );
}
