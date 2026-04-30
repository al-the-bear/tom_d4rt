// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PopupMenuDivider from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.fromLTRB(8, 16, 8, 8),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [color, color.withValues(alpha: 0.7)]),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget buildInfoCard(String label, String value, Color accentColor) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: accentColor.withValues(alpha: 0.3)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 4,
          height: 40,
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(2),
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
                  fontSize: 13,
                  color: accentColor,
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildPropertyCard(
  String property,
  String type,
  String description,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(6),
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
            type,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                property,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildDividerDemo(
  String label,
  String description,
  Color themeColor,
  List<PopupMenuEntry<String>> Function(BuildContext) itemBuilder,
  IconData icon,
) {
  print('Building divider demo: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade200),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: themeColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: themeColor, size: 24),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, color: themeColor),
          onSelected: (String value) {
            print('Selected: $value from $label');
          },
          itemBuilder: itemBuilder,
        ),
      ],
    ),
  );
}

Widget buildComparisonCard(
  String title,
  String description,
  IconData icon,
  Color color,
) {
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
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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

Widget buildThemedDividerDemo(
  String label,
  Color primaryColor,
  Color backgroundColor,
  double dividerHeight,
) {
  print('Building themed divider demo: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: primaryColor.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: primaryColor.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.palette, color: primaryColor, size: 22),
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
                  color: primaryColor,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Divider height: ${dividerHeight}px',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        Theme(
          data: ThemeData(
            dividerColor: primaryColor,
            popupMenuTheme: PopupMenuThemeData(color: backgroundColor),
          ),
          child: PopupMenuButton<String>(
            icon: Icon(Icons.arrow_drop_down, color: primaryColor),
            onSelected: (String value) {
              print('Themed popup selected: $value');
            },
            itemBuilder: (BuildContext ctx) {
              return [
                PopupMenuItem<String>(
                  value: 'theme_opt1',
                  child: Text(
                    'Theme Option 1',
                    style: TextStyle(color: primaryColor),
                  ),
                ),
                PopupMenuDivider(height: dividerHeight),
                PopupMenuItem<String>(
                  value: 'theme_opt2',
                  child: Text(
                    'Theme Option 2',
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ];
            },
          ),
        ),
      ],
    ),
  );
}

Widget buildNestedMenuDemo(
  String label,
  String description,
  Color color,
  int nestLevel,
) {
  print('Building nested menu demo: $label (level $nestLevel)');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withValues(alpha: 0.3)),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.1),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withValues(alpha: 0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.layers, color: Colors.white, size: 22),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Nest Level: $nestLevel',
                  style: TextStyle(fontSize: 10, color: color),
                ),
              ),
            ],
          ),
        ),
        PopupMenuButton<String>(
          icon: Icon(Icons.menu, color: color),
          onSelected: (String value) {
            print('Nested menu selected: $value');
          },
          itemBuilder: (BuildContext ctx) {
            return [
              PopupMenuItem<String>(
                value: 'parent1',
                child: Row(
                  children: [
                    Icon(Icons.folder, size: 18),
                    SizedBox(width: 8),
                    Text('Parent Category'),
                  ],
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem<String>(
                value: 'child1',
                child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      Icon(Icons.subdirectory_arrow_right, size: 16),
                      SizedBox(width: 4),
                      Text('Sub-item 1'),
                    ],
                  ),
                ),
              ),
              PopupMenuItem<String>(
                value: 'child2',
                child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      Icon(Icons.subdirectory_arrow_right, size: 16),
                      SizedBox(width: 4),
                      Text('Sub-item 2'),
                    ],
                  ),
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem<String>(
                value: 'parent2',
                child: Row(
                  children: [
                    Icon(Icons.folder, size: 18),
                    SizedBox(width: 8),
                    Text('Another Category'),
                  ],
                ),
              ),
            ];
          },
        ),
      ],
    ),
  );
}

Widget buildInteractiveMenuTile(
  String label,
  IconData leadingIcon,
  Color color,
  List<String> options,
) {
  print('Building interactive menu tile: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(leadingIcon, color: color, size: 22),
      ),
      title: Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(
        '${options.length} options available',
        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
      ),
      trailing: PopupMenuButton<String>(
        icon: Icon(Icons.more_horiz, color: color),
        onSelected: (String value) {
          print('Interactive tile selected: $value from $label');
        },
        itemBuilder: (BuildContext ctx) {
          List<PopupMenuEntry<String>> items = [];
          for (int i = 0; i < options.length; i++) {
            items.add(
              PopupMenuItem<String>(value: options[i], child: Text(options[i])),
            );
            if (i < options.length - 1 && (i + 1) % 3 == 0) {
              items.add(PopupMenuDivider());
            }
          }
          return items;
        },
      ),
    ),
  );
}

Widget buildDividerThicknessDemo(String label, double height, Color color) {
  print('Building divider thickness demo: $label ($height px)');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              '${height.toInt()}',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 14,
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              SizedBox(height: 2),
              Text(
                'Height: ${height}px',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        PopupMenuButton<String>(
          icon: Icon(Icons.expand_more, color: color),
          onSelected: (String value) {
            print('Thickness demo selected: $value');
          },
          itemBuilder: (BuildContext ctx) {
            return [
              PopupMenuItem<String>(
                value: 'above',
                child: Text('Above Divider'),
              ),
              PopupMenuDivider(height: height),
              PopupMenuItem<String>(
                value: 'below',
                child: Text('Below Divider'),
              ),
            ];
          },
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== PopupMenuDivider Deep Demo Test ===');
  print('Testing PopupMenuDivider - horizontal divider for popup menus');

  return MaterialApp(
    title: 'PopupMenuDivider Demo',
    theme: ThemeData(
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: Colors.grey.shade100,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('PopupMenuDivider Demo'),
        backgroundColor: Colors.indigo,
        elevation: 2,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.settings, color: Colors.white),
            onSelected: (String value) {
              print('AppBar menu selected: $value');
            },
            itemBuilder: (BuildContext ctx) {
              return [
                PopupMenuItem<String>(
                  value: 'settings',
                  child: Row(
                    children: [
                      Icon(Icons.settings, size: 18),
                      SizedBox(width: 8),
                      Text('Settings'),
                    ],
                  ),
                ),
                PopupMenuDivider(),
                PopupMenuItem<String>(
                  value: 'help',
                  child: Row(
                    children: [
                      Icon(Icons.help, size: 18),
                      SizedBox(width: 8),
                      Text('Help'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'about',
                  child: Row(
                    children: [
                      Icon(Icons.info, size: 18),
                      SizedBox(width: 8),
                      Text('About'),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Overview of PopupMenuDivider
            buildSectionHeader(
              '1. Overview of PopupMenuDivider',
              Icons.horizontal_rule,
              Colors.indigo,
            ),
            buildInfoCard(
              'What is PopupMenuDivider?',
              'PopupMenuDivider is a widget that creates a horizontal divider line '
                  'inside a popup menu. It extends PopupMenuEntry<Never> and provides '
                  'visual separation between groups of menu items.',
              Colors.indigo,
            ),
            buildPropertyCard(
              'height',
              'double',
              'The height of the divider entry. Default is _kMenuDividerHeight (16.0). '
                  'This includes the divider line itself plus padding above and below.',
              Colors.indigo,
            ),
            buildPropertyCard(
              'represents',
              'Null',
              'Inherits from PopupMenuEntry. The value represented is null since dividers '
                  'cannot be selected.',
              Colors.indigo,
            ),
            buildPropertyCard(
              'enabled',
              'bool',
              'Always returns false since dividers are not interactive elements.',
              Colors.indigo,
            ),
            buildInfoCard(
              'Widget Type',
              'PopupMenuDivider uses a Divider widget internally to render the horizontal '
                  'line. The Divider inherits its color from the theme\'s dividerColor.',
              Colors.indigo,
            ),

            // Section 2: Default divider in menus
            buildSectionHeader(
              '2. Default Divider in Menus',
              Icons.view_list,
              Colors.teal,
            ),
            buildDividerDemo(
              'Default Divider Demo',
              'Standard PopupMenuDivider with default height',
              Colors.teal,
              (BuildContext ctx) {
                return [
                  PopupMenuItem<String>(
                    value: 'view',
                    child: Row(
                      children: [
                        Icon(Icons.visibility, size: 18),
                        SizedBox(width: 8),
                        Text('View'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, size: 18),
                        SizedBox(width: 8),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<String>(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, size: 18, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Delete', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ];
              },
              Icons.list,
            ),
            buildDividerDemo(
              'File Actions Menu',
              'Divider separating file operations',
              Colors.teal,
              (BuildContext ctx) {
                return [
                  PopupMenuItem<String>(value: 'new', child: Text('New File')),
                  PopupMenuItem<String>(value: 'open', child: Text('Open...')),
                  PopupMenuItem<String>(value: 'save', child: Text('Save')),
                  PopupMenuDivider(),
                  PopupMenuItem<String>(value: 'close', child: Text('Close')),
                ];
              },
              Icons.insert_drive_file,
            ),
            buildInfoCard(
              'Usage Pattern',
              'Place PopupMenuDivider() between PopupMenuItem widgets in the itemBuilder '
                  'list. No special configuration needed for the default appearance.',
              Colors.teal,
            ),

            // Section 3: Custom height divider
            buildSectionHeader(
              '3. Custom Height Divider',
              Icons.height,
              Colors.orange,
            ),
            buildDividerThicknessDemo('Thin Divider (8px)', 8.0, Colors.orange),
            buildDividerThicknessDemo(
              'Default Divider (16px)',
              16.0,
              Colors.orange,
            ),
            buildDividerThicknessDemo(
              'Medium Divider (24px)',
              24.0,
              Colors.orange,
            ),
            buildDividerThicknessDemo(
              'Thick Divider (32px)',
              32.0,
              Colors.orange,
            ),
            buildDividerThicknessDemo(
              'Extra Thick (48px)',
              48.0,
              Colors.orange,
            ),
            buildInfoCard(
              'Height Parameter',
              'PopupMenuDivider(height: value) sets the total height of the divider entry. '
                  'This includes padding around the divider line. Larger values add more '
                  'vertical space between menu sections.',
              Colors.orange,
            ),

            // Section 4: Divider between groups
            buildSectionHeader(
              '4. Divider Between Groups',
              Icons.view_module,
              Colors.purple,
            ),
            buildDividerDemo(
              'Edit Menu Groups',
              'Grouped by action type with dividers',
              Colors.purple,
              (BuildContext ctx) {
                return [
                  PopupMenuItem<String>(
                    value: 'undo',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Undo'),
                        Text(
                          'Ctrl+Z',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'redo',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Redo'),
                        Text(
                          'Ctrl+Y',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<String>(
                    value: 'cut',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Cut'),
                        Text(
                          'Ctrl+X',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'copy',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Copy'),
                        Text(
                          'Ctrl+C',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'paste',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Paste'),
                        Text(
                          'Ctrl+V',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<String>(
                    value: 'select_all',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Select All'),
                        Text(
                          'Ctrl+A',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ];
              },
              Icons.content_cut,
            ),
            buildDividerDemo(
              'User Account Menu',
              'Profile, settings, and logout grouped',
              Colors.purple,
              (BuildContext ctx) {
                return [
                  PopupMenuItem<String>(
                    value: 'profile',
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.purple.shade100,
                          child: Icon(
                            Icons.person,
                            size: 16,
                            color: Colors.purple,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text('Profile'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'account',
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_circle,
                          size: 24,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 8),
                        Text('Account Settings'),
                      ],
                    ),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<String>(
                    value: 'preferences',
                    child: Row(
                      children: [
                        Icon(Icons.tune, size: 24, color: Colors.grey),
                        SizedBox(width: 8),
                        Text('Preferences'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'notifications',
                    child: Row(
                      children: [
                        Icon(Icons.notifications, size: 24, color: Colors.grey),
                        SizedBox(width: 8),
                        Text('Notifications'),
                      ],
                    ),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout, size: 24, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Logout', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ];
              },
              Icons.account_box,
            ),
            buildInfoCard(
              'Grouping Strategy',
              'Use dividers to separate related actions: history operations (undo/redo), '
                  'clipboard operations (cut/copy/paste), and destructive actions (delete/logout).',
              Colors.purple,
            ),

            // Section 5: Divider with theme styling
            buildSectionHeader(
              '5. Divider with Theme Styling',
              Icons.palette,
              Colors.pink,
            ),
            buildThemedDividerDemo(
              'Blue Theme',
              Colors.blue,
              Colors.blue.shade50,
              16.0,
            ),
            buildThemedDividerDemo(
              'Green Theme',
              Colors.green,
              Colors.green.shade50,
              20.0,
            ),
            buildThemedDividerDemo(
              'Amber Theme',
              Colors.amber.shade700,
              Colors.amber.shade50,
              18.0,
            ),
            buildThemedDividerDemo(
              'Red Theme',
              Colors.red,
              Colors.red.shade50,
              16.0,
            ),
            buildThemedDividerDemo(
              'Deep Purple Theme',
              Colors.deepPurple,
              Colors.deepPurple.shade50,
              24.0,
            ),
            buildInfoCard(
              'Theme Integration',
              'PopupMenuDivider uses Theme.of(context).dividerColor for its line color. '
                  'Wrap popup buttons in Theme widget to customize divider appearance. '
                  'The divider automatically inherits the theme\'s color scheme.',
              Colors.pink,
            ),

            // Section 6: Multiple dividers in menu
            buildSectionHeader(
              '6. Multiple Dividers in Menu',
              Icons.format_line_spacing,
              Colors.cyan,
            ),
            buildDividerDemo(
              'Multi-Section Settings',
              'Four groups separated by three dividers',
              Colors.cyan,
              (BuildContext ctx) {
                return [
                  PopupMenuItem<String>(
                    value: 'display',
                    child: Text('Display Settings'),
                  ),
                  PopupMenuItem<String>(value: 'theme', child: Text('Theme')),
                  PopupMenuDivider(),
                  PopupMenuItem<String>(value: 'audio', child: Text('Audio')),
                  PopupMenuItem<String>(value: 'video', child: Text('Video')),
                  PopupMenuDivider(),
                  PopupMenuItem<String>(
                    value: 'network',
                    child: Text('Network'),
                  ),
                  PopupMenuItem<String>(
                    value: 'privacy',
                    child: Text('Privacy'),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<String>(value: 'about', child: Text('About')),
                ];
              },
              Icons.settings,
            ),
            buildDividerDemo(
              'Document Actions',
              'Create, modify, share, and remove sections',
              Colors.cyan,
              (BuildContext ctx) {
                return [
                  PopupMenuItem<String>(
                    value: 'new_doc',
                    child: Row(
                      children: [
                        Icon(Icons.add, size: 18, color: Colors.green),
                        SizedBox(width: 8),
                        Text('New Document'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'import',
                    child: Row(
                      children: [
                        Icon(Icons.file_upload, size: 18, color: Colors.blue),
                        SizedBox(width: 8),
                        Text('Import'),
                      ],
                    ),
                  ),
                  PopupMenuDivider(height: 12),
                  PopupMenuItem<String>(
                    value: 'rename',
                    child: Row(
                      children: [
                        Icon(Icons.drive_file_rename_outline, size: 18),
                        SizedBox(width: 8),
                        Text('Rename'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'duplicate',
                    child: Row(
                      children: [
                        Icon(Icons.content_copy, size: 18),
                        SizedBox(width: 8),
                        Text('Duplicate'),
                      ],
                    ),
                  ),
                  PopupMenuDivider(height: 12),
                  PopupMenuItem<String>(
                    value: 'share',
                    child: Row(
                      children: [
                        Icon(Icons.share, size: 18, color: Colors.indigo),
                        SizedBox(width: 8),
                        Text('Share'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'export',
                    child: Row(
                      children: [
                        Icon(
                          Icons.file_download,
                          size: 18,
                          color: Colors.indigo,
                        ),
                        SizedBox(width: 8),
                        Text('Export'),
                      ],
                    ),
                  ),
                  PopupMenuDivider(height: 12),
                  PopupMenuItem<String>(
                    value: 'archive',
                    child: Row(
                      children: [
                        Icon(Icons.archive, size: 18, color: Colors.orange),
                        SizedBox(width: 8),
                        Text('Archive'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'trash',
                    child: Row(
                      children: [
                        Icon(Icons.delete_forever, size: 18, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Move to Trash'),
                      ],
                    ),
                  ),
                ];
              },
              Icons.description,
            ),
            buildInfoCard(
              'Multiple Dividers Pattern',
              'Use consistent divider heights throughout the menu. Group related items '
                  'together and separate distinct action categories with dividers.',
              Colors.cyan,
            ),

            // Section 7: Divider vs other separators
            buildSectionHeader(
              '7. Divider vs Other Separators',
              Icons.compare,
              Colors.amber,
            ),
            buildComparisonCard(
              'PopupMenuDivider',
              'Official Material Design separator for popup menus. Inherits theme colors, '
                  'consistent padding, and proper accessibility support.',
              Icons.horizontal_rule,
              Colors.green,
            ),
            buildComparisonCard(
              'Custom Container Divider',
              'Using a PopupMenuItem with a Container/Divider child. More flexible but '
                  'may have inconsistent height and selection behavior.',
              Icons.check_box_outline_blank,
              Colors.orange,
            ),
            buildComparisonCard(
              'Spacing with Empty Items',
              'Using PopupMenuItem with empty height. Not recommended as it may be '
                  'selectable and lacks the visual line indicator.',
              Icons.space_bar,
              Colors.red,
            ),
            buildDividerDemo(
              'Comparison Demo',
              'Standard PopupMenuDivider implementation',
              Colors.amber,
              (BuildContext ctx) {
                return [
                  PopupMenuItem<String>(
                    value: 'item1',
                    child: Text('Standard Item 1'),
                  ),
                  PopupMenuItem<String>(
                    value: 'item2',
                    child: Text('Standard Item 2'),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<String>(
                    value: 'item3',
                    child: Text('Standard Item 3'),
                  ),
                  PopupMenuItem<String>(
                    value: 'item4',
                    child: Text('Standard Item 4'),
                  ),
                ];
              },
              Icons.compare_arrows,
            ),
            buildInfoCard(
              'Best Practice',
              'Always use PopupMenuDivider for separating menu sections. It ensures '
                  'consistent appearance, proper height, non-selectable behavior, and '
                  'seamless theme integration.',
              Colors.amber,
            ),

            // Section 8: Divider in nested menus
            buildSectionHeader(
              '8. Divider in Nested Menus',
              Icons.account_tree,
              Colors.deepOrange,
            ),
            buildNestedMenuDemo(
              'Categories with Subcategories',
              'Visual hierarchy using indentation and dividers',
              Colors.deepOrange,
              1,
            ),
            buildNestedMenuDemo(
              'Multi-Level Navigation',
              'Parent and child items separated logically',
              Colors.deepOrange,
              2,
            ),
            buildDividerDemo(
              'Submenu Simulation',
              'Dividers indicating menu sections',
              Colors.deepOrange,
              (BuildContext ctx) {
                return [
                  PopupMenuItem<String>(
                    value: 'nav_home',
                    enabled: false,
                    child: Text(
                      'NAVIGATION',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  PopupMenuItem<String>(value: 'home', child: Text('Home')),
                  PopupMenuItem<String>(
                    value: 'dashboard',
                    child: Text('Dashboard'),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<String>(
                    value: 'tools_header',
                    enabled: false,
                    child: Text(
                      'TOOLS',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  PopupMenuItem<String>(value: 'editor', child: Text('Editor')),
                  PopupMenuItem<String>(
                    value: 'analyzer',
                    child: Text('Analyzer'),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<String>(
                    value: 'actions_header',
                    enabled: false,
                    child: Text(
                      'ACTIONS',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  PopupMenuItem<String>(value: 'run', child: Text('Run')),
                  PopupMenuItem<String>(value: 'build', child: Text('Build')),
                ];
              },
              Icons.menu_book,
            ),
            buildInfoCard(
              'Nested Menu Pattern',
              'Combine dividers with disabled header items to create clear visual sections. '
                  'Use indentation for sub-items and dividers between major categories.',
              Colors.deepOrange,
            ),

            // Section 9: Thin and thick dividers
            buildSectionHeader(
              '9. Thin and Thick Dividers',
              Icons.line_weight,
              Colors.blueGrey,
            ),
            buildDividerThicknessDemo('Ultra Thin (4px)', 4.0, Colors.blueGrey),
            buildDividerThicknessDemo('Slim (8px)', 8.0, Colors.blueGrey),
            buildDividerThicknessDemo('Standard (16px)', 16.0, Colors.blueGrey),
            buildDividerThicknessDemo(
              'Comfortable (20px)',
              20.0,
              Colors.blueGrey,
            ),
            buildDividerThicknessDemo('Spacious (28px)', 28.0, Colors.blueGrey),
            buildDividerThicknessDemo(
              'Very Spacious (36px)',
              36.0,
              Colors.blueGrey,
            ),
            buildInfoCard(
              'Height Guidelines',
              'Use thinner dividers (8-12px) for compact menus with many items. '
                  'Standard height (16px) works for most use cases. Larger heights (24-48px) '
                  'create more pronounced section breaks for complex menus.',
              Colors.blueGrey,
            ),
            buildDividerDemo(
              'Mixed Heights Demo',
              'Different heights for different separations',
              Colors.blueGrey,
              (BuildContext ctx) {
                return [
                  PopupMenuItem<String>(
                    value: 'primary1',
                    child: Text('Primary Action 1'),
                  ),
                  PopupMenuItem<String>(
                    value: 'primary2',
                    child: Text('Primary Action 2'),
                  ),
                  PopupMenuDivider(height: 24),
                  PopupMenuItem<String>(
                    value: 'secondary1',
                    child: Text('Secondary Action 1'),
                  ),
                  PopupMenuItem<String>(
                    value: 'secondary2',
                    child: Text('Secondary Action 2'),
                  ),
                  PopupMenuDivider(height: 8),
                  PopupMenuItem<String>(
                    value: 'tertiary',
                    child: Text('Tertiary Action'),
                  ),
                ];
              },
              Icons.format_size,
            ),

            // Section 10: Interactive menu with dividers
            buildSectionHeader(
              '10. Interactive Menu with Dividers',
              Icons.touch_app,
              Colors.green,
            ),
            buildInteractiveMenuTile(
              'Task Manager',
              Icons.task_alt,
              Colors.green,
              [
                'View Tasks',
                'Add Task',
                'Filter',
                'Sort by Date',
                'Sort by Priority',
                'Archive Completed',
              ],
            ),
            buildInteractiveMenuTile(
              'Calendar Events',
              Icons.calendar_month,
              Colors.blue,
              [
                'Today',
                'This Week',
                'This Month',
                'Add Event',
                'Reminders',
                'Settings',
              ],
            ),
            buildInteractiveMenuTile('Messages', Icons.message, Colors.purple, [
              'Inbox',
              'Sent',
              'Drafts',
              'Compose',
              'Search',
              'Archive',
            ]),
            buildInteractiveMenuTile(
              'Media Library',
              Icons.photo_library,
              Colors.orange,
              ['Photos', 'Videos', 'Albums', 'Upload', 'Sync', 'Storage Info'],
            ),
            buildDividerDemo(
              'Interactive Actions Menu',
              'Full featured menu with icons and states',
              Colors.green,
              (BuildContext ctx) {
                return [
                  PopupMenuItem<String>(
                    value: 'quick_action',
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(
                            Icons.flash_on,
                            size: 16,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text('Quick Action'),
                      ],
                    ),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<String>(
                    value: 'view_all',
                    child: Row(
                      children: [
                        Icon(Icons.grid_view, size: 18),
                        SizedBox(width: 8),
                        Expanded(child: Text('View All')),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'favorites',
                    child: Row(
                      children: [
                        Icon(Icons.star, size: 18, color: Colors.amber),
                        SizedBox(width: 8),
                        Expanded(child: Text('Favorites')),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('12', style: TextStyle(fontSize: 11)),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'recent',
                    child: Row(
                      children: [
                        Icon(Icons.history, size: 18),
                        SizedBox(width: 8),
                        Expanded(child: Text('Recent')),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('5', style: TextStyle(fontSize: 11)),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<String>(
                    value: 'settings',
                    child: Row(
                      children: [
                        Icon(Icons.settings, size: 18, color: Colors.grey),
                        SizedBox(width: 8),
                        Text('Settings'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'help',
                    child: Row(
                      children: [
                        Icon(Icons.help_outline, size: 18, color: Colors.grey),
                        SizedBox(width: 8),
                        Text('Help & Support'),
                      ],
                    ),
                  ),
                ];
              },
              Icons.menu,
            ),
            buildInfoCard(
              'Interactive Menu Best Practices',
              'Combine dividers with clear visual cues: icons for actions, badges for counts, '
                  'arrows for navigation. Group related items and use dividers to separate '
                  'distinct functional areas.',
              Colors.green,
            ),

            // Bonus: Advanced patterns
            buildSectionHeader(
              'Bonus: Advanced Divider Patterns',
              Icons.stars,
              Colors.red,
            ),
            buildDividerDemo(
              'Action Categories',
              'Primary, secondary, and danger zones',
              Colors.red,
              (BuildContext ctx) {
                return [
                  PopupMenuItem<String>(
                    enabled: false,
                    value: 'primary_label',
                    child: Text(
                      'PRIMARY ACTIONS',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'create',
                    child: Row(
                      children: [
                        Icon(Icons.add_circle, color: Colors.blue, size: 18),
                        SizedBox(width: 8),
                        Text('Create New'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'open',
                    child: Row(
                      children: [
                        Icon(Icons.folder_open, color: Colors.blue, size: 18),
                        SizedBox(width: 8),
                        Text('Open'),
                      ],
                    ),
                  ),
                  PopupMenuDivider(height: 20),
                  PopupMenuItem<String>(
                    enabled: false,
                    value: 'secondary_label',
                    child: Text(
                      'SECONDARY ACTIONS',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'duplicate',
                    child: Row(
                      children: [
                        Icon(Icons.copy, size: 18),
                        SizedBox(width: 8),
                        Text('Duplicate'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'rename',
                    child: Row(
                      children: [
                        Icon(Icons.edit, size: 18),
                        SizedBox(width: 8),
                        Text('Rename'),
                      ],
                    ),
                  ),
                  PopupMenuDivider(height: 20),
                  PopupMenuItem<String>(
                    enabled: false,
                    value: 'danger_label',
                    child: Text(
                      'DANGER ZONE',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete_forever, color: Colors.red, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Delete Permanently',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ];
              },
              Icons.warning,
            ),
            buildDividerDemo(
              'Status-Based Menu',
              'Items grouped by current state',
              Colors.red,
              (BuildContext ctx) {
                return [
                  PopupMenuItem<String>(
                    enabled: false,
                    value: 'active_header',
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'ACTIVE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'task_1',
                    child: Text('Running Task 1'),
                  ),
                  PopupMenuItem<String>(
                    value: 'task_2',
                    child: Text('Running Task 2'),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<String>(
                    enabled: false,
                    value: 'pending_header',
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'PENDING',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'task_3',
                    child: Text('Queued Task 3'),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<String>(
                    enabled: false,
                    value: 'completed_header',
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'COMPLETED',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'task_4',
                    child: Text('Finished Task 4'),
                  ),
                  PopupMenuItem<String>(
                    value: 'task_5',
                    child: Text('Finished Task 5'),
                  ),
                ];
              },
              Icons.checklist,
            ),

            // Summary section
            buildSectionHeader('Summary', Icons.summarize, Colors.indigo),
            buildInfoCard(
              'Key Takeaways',
              'PopupMenuDivider creates horizontal separators in popup menus. '
                  'Default height is 16px but can be customized with height parameter. '
                  'Dividers inherit color from theme dividerColor. '
                  'Use dividers to group related menu items logically. '
                  'Combine with disabled header items for section labels. '
                  'Supports multiple dividers for complex menu structures.',
              Colors.indigo,
            ),
            buildInfoCard(
              'Common Use Cases',
              'Separating action categories (edit, view, delete). '
                  'Grouping settings by type (display, audio, network). '
                  'Distinguishing primary actions from secondary ones. '
                  'Creating danger zones for destructive actions. '
                  'Building hierarchical menu structures.',
              Colors.indigo,
            ),

            SizedBox(height: 32),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.indigo.shade200),
                ),
                child: Text(
                  'PopupMenuDivider Demo Complete',
                  style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    ),
  );
}
