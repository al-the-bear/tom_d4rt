// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PopupMenuButtonState from material
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

Widget buildPopupButtonDemo(
  String label,
  String description,
  Color themeColor,
  List<PopupMenuEntry<String>> Function(BuildContext) itemBuilder,
) {
  print('Building popup button demo: $label');
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

Widget buildIconTextMenuDemo(
  String label,
  Color color,
  List<Map<String, dynamic>> items,
) {
  print('Building icon+text menu demo: $label');
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
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
          ),
        ),
        PopupMenuButton<String>(
          icon: Icon(Icons.menu, color: color),
          onSelected: (String val) {
            print('Icon menu selected: $val');
          },
          itemBuilder: (BuildContext ctx) {
            List<PopupMenuEntry<String>> entries = [];
            for (var item in items) {
              entries.add(
                PopupMenuItem<String>(
                  value: item['value'] as String,
                  child: Row(
                    children: [
                      Icon(item['icon'] as IconData, size: 20, color: color),
                      SizedBox(width: 12),
                      Text(item['text'] as String),
                    ],
                  ),
                ),
              );
            }
            return entries;
          },
        ),
      ],
    ),
  );
}

Widget buildTooltipDemo(String label, String tooltipText, Color color) {
  print('Building tooltip demo: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Icon(Icons.info_outline, color: color, size: 18),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              Text(
                'Tooltip: "$tooltipText"',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        PopupMenuButton<String>(
          tooltip: tooltipText,
          icon: Icon(Icons.help_outline, color: color),
          onSelected: (String v) {
            print('Tooltip popup selected: $v');
          },
          itemBuilder: (BuildContext ctx) {
            return [
              PopupMenuItem<String>(value: 'help_a', child: Text('Help Topic A')),
              PopupMenuItem<String>(value: 'help_b', child: Text('Help Topic B')),
            ];
          },
        ),
      ],
    ),
  );
}

Widget buildEnabledStateDemo(String label, bool enabled, Color color) {
  print('Building enabled state demo: $label (enabled: $enabled)');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: enabled ? Colors.white : Colors.grey.shade200,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: enabled ? color.withValues(alpha: 0.3) : Colors.grey.shade400,
      ),
    ),
    child: Row(
      children: [
        Icon(
          enabled ? Icons.check_circle : Icons.block,
          color: enabled ? color : Colors.grey,
          size: 20,
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
                  color: enabled ? Colors.black87 : Colors.grey,
                ),
              ),
              Text(
                enabled ? 'Button is enabled' : 'Button is disabled',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        PopupMenuButton<String>(
          enabled: enabled,
          icon: Icon(
            Icons.more_vert,
            color: enabled ? color : Colors.grey.shade400,
          ),
          onSelected: (String v) {
            print('Enabled state popup selected: $v');
          },
          itemBuilder: (BuildContext ctx) {
            return [
              PopupMenuItem<String>(value: 'action', child: Text('Perform Action')),
            ];
          },
        ),
      ],
    ),
  );
}

Widget buildInitialValueDemo(String label, String initialValue, Color color) {
  print('Building initial value demo: $label with initial=$initialValue');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            initialValue,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
          ),
        ),
        PopupMenuButton<String>(
          initialValue: initialValue,
          icon: Icon(Icons.arrow_drop_down, color: color),
          onSelected: (String v) {
            print('Initial value popup selected: $v (was $initialValue)');
          },
          itemBuilder: (BuildContext ctx) {
            return [
              PopupMenuItem<String>(value: 'small', child: Text('Small')),
              PopupMenuItem<String>(value: 'medium', child: Text('Medium')),
              PopupMenuItem<String>(value: 'large', child: Text('Large')),
            ];
          },
        ),
      ],
    ),
  );
}

Widget buildDividerDemo(String label, Color color) {
  print('Building divider demo: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              Text(
                'Menu with dividers between sections',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        PopupMenuButton<String>(
          icon: Icon(Icons.segment, color: color),
          onSelected: (String v) {
            print('Divider demo selected: $v');
          },
          itemBuilder: (BuildContext ctx) {
            return [
              PopupMenuItem<String>(value: 'view', child: Text('View')),
              PopupMenuItem<String>(value: 'edit', child: Text('Edit')),
              PopupMenuDivider(),
              PopupMenuItem<String>(value: 'share', child: Text('Share')),
              PopupMenuItem<String>(value: 'copy', child: Text('Copy Link')),
              PopupMenuDivider(height: 16),
              PopupMenuItem<String>(value: 'delete', child: Text('Delete')),
            ];
          },
        ),
      ],
    ),
  );
}

Widget buildCallbackDemo(String label, Color color, Function(String) onSelect) {
  print('Building callback demo: $label');
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
        Icon(Icons.touch_app, color: color, size: 20),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
          ),
        ),
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, color: color),
          onSelected: (String v) {
            onSelect(v);
          },
          itemBuilder: (BuildContext ctx) {
            return [
              PopupMenuItem<String>(value: 'callback_a', child: Text('Action A')),
              PopupMenuItem<String>(value: 'callback_b', child: Text('Action B')),
              PopupMenuItem<String>(value: 'callback_c', child: Text('Action C')),
            ];
          },
        ),
      ],
    ),
  );
}

Widget buildShowButtonMenuDemo(
  String label,
  Color color,
  GlobalKey<PopupMenuButtonState<String>> menuKey,
) {
  print('Building showButtonMenu demo: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withValues(alpha: 0.3)),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.1),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: color, size: 20),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Programmatically opens the popup menu using showButtonMenu()',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                print('Triggering showButtonMenu programmatically');
                menuKey.currentState?.showButtonMenu();
              },
              icon: Icon(Icons.open_in_new, size: 18),
              label: Text('Open Menu'),
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(width: 16),
            PopupMenuButton<String>(
              key: menuKey,
              icon: Icon(Icons.arrow_drop_down_circle, color: color),
              onSelected: (String v) {
                print('showButtonMenu demo selected: $v');
              },
              itemBuilder: (BuildContext ctx) {
                return [
                  PopupMenuItem<String>(
                    value: 'programmatic_1',
                    child: Text('Programmatic Option 1'),
                  ),
                  PopupMenuItem<String>(
                    value: 'programmatic_2',
                    child: Text('Programmatic Option 2'),
                  ),
                  PopupMenuItem<String>(
                    value: 'programmatic_3',
                    child: Text('Programmatic Option 3'),
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

dynamic build(BuildContext context) {
  print('PopupMenuButtonState deep demo starting');

  Color primaryColor = Colors.indigo;
  Color secondaryColor = Colors.teal;
  Color accentColor = Colors.deepOrange;
  Color successColor = Colors.green;
  Color warningColor = Colors.amber.shade700;

  GlobalKey<PopupMenuButtonState<String>> popupMenuKey1 =
      GlobalKey<PopupMenuButtonState<String>>();
  GlobalKey<PopupMenuButtonState<String>> popupMenuKey2 =
      GlobalKey<PopupMenuButtonState<String>>();

  print('Exploring PopupMenuButtonState class');
  print('PopupMenuButtonState is the State class for PopupMenuButton<T>');
  print('Key method: showButtonMenu() - programmatically opens the menu');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.indigo,
      useMaterial3: true,
    ),
    home: Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('PopupMenuButtonState Demo'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (String value) {
              print('AppBar popup selected: $value');
            },
            itemBuilder: (BuildContext ctx) {
              return [
                PopupMenuItem<String>(value: 'settings', child: Text('Settings')),
                PopupMenuItem<String>(value: 'about', child: Text('About')),
              ];
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildSectionHeader(
              'PopupMenuButtonState Overview',
              Icons.info_outline,
              primaryColor,
            ),
            buildInfoCard(
              'Class',
              'PopupMenuButtonState<T> extends State<PopupMenuButton<T>>',
              primaryColor,
            ),
            buildInfoCard(
              'Primary Method',
              'showButtonMenu() - Opens the popup menu programmatically',
              primaryColor,
            ),
            buildInfoCard(
              'Access Pattern',
              'Use GlobalKey<PopupMenuButtonState<T>> to call showButtonMenu()',
              primaryColor,
            ),

            buildSectionHeader(
              'PopupMenuButton Basics',
              Icons.menu_open,
              secondaryColor,
            ),
            buildPopupButtonDemo(
              'Simple Text Items',
              'Basic popup menu with text-only items',
              secondaryColor,
              (BuildContext ctx) {
                return [
                  PopupMenuItem<String>(value: 'item1', child: Text('First Item')),
                  PopupMenuItem<String>(value: 'item2', child: Text('Second Item')),
                  PopupMenuItem<String>(value: 'item3', child: Text('Third Item')),
                ];
              },
            ),
            buildPopupButtonDemo(
              'Multiple Menu Items',
              'Popup with many options',
              secondaryColor,
              (BuildContext ctx) {
                return [
                  PopupMenuItem<String>(value: 'opt_a', child: Text('Option A')),
                  PopupMenuItem<String>(value: 'opt_b', child: Text('Option B')),
                  PopupMenuItem<String>(value: 'opt_c', child: Text('Option C')),
                  PopupMenuItem<String>(value: 'opt_d', child: Text('Option D')),
                  PopupMenuItem<String>(value: 'opt_e', child: Text('Option E')),
                ];
              },
            ),
            buildPopupButtonDemo(
              'Single Item Menu',
              'Menu with just one option',
              secondaryColor,
              (BuildContext ctx) {
                return [
                  PopupMenuItem<String>(value: 'only', child: Text('Only Option')),
                ];
              },
            ),

            buildSectionHeader(
              'showButtonMenu() Demonstration',
              Icons.code,
              accentColor,
            ),
            buildInfoCard(
              'Method Signature',
              'void showButtonMenu()',
              accentColor,
            ),
            buildInfoCard(
              'Usage',
              'Call via GlobalKey: key.currentState?.showButtonMenu()',
              accentColor,
            ),
            buildShowButtonMenuDemo(
              'Programmatic Menu Opening #1',
              accentColor,
              popupMenuKey1,
            ),
            buildShowButtonMenuDemo(
              'Programmatic Menu Opening #2',
              Colors.purple,
              popupMenuKey2,
            ),

            buildSectionHeader(
              'Icons and Text in Menu Items',
              Icons.view_list,
              primaryColor,
            ),
            buildIconTextMenuDemo(
              'File Operations',
              primaryColor,
              [
                {'value': 'new', 'icon': Icons.add, 'text': 'New File'},
                {'value': 'open', 'icon': Icons.folder_open, 'text': 'Open'},
                {'value': 'save', 'icon': Icons.save, 'text': 'Save'},
                {'value': 'export', 'icon': Icons.ios_share, 'text': 'Export'},
              ],
            ),
            buildIconTextMenuDemo(
              'Edit Actions',
              secondaryColor,
              [
                {'value': 'cut', 'icon': Icons.content_cut, 'text': 'Cut'},
                {'value': 'copy', 'icon': Icons.content_copy, 'text': 'Copy'},
                {'value': 'paste', 'icon': Icons.content_paste, 'text': 'Paste'},
                {'value': 'delete', 'icon': Icons.delete, 'text': 'Delete'},
              ],
            ),
            buildIconTextMenuDemo(
              'View Options',
              accentColor,
              [
                {'value': 'zoom_in', 'icon': Icons.zoom_in, 'text': 'Zoom In'},
                {'value': 'zoom_out', 'icon': Icons.zoom_out, 'text': 'Zoom Out'},
                {'value': 'fullscreen', 'icon': Icons.fullscreen, 'text': 'Fullscreen'},
              ],
            ),
            buildIconTextMenuDemo(
              'Navigation',
              Colors.blue,
              [
                {'value': 'home', 'icon': Icons.home, 'text': 'Home'},
                {'value': 'back', 'icon': Icons.arrow_back, 'text': 'Back'},
                {'value': 'forward', 'icon': Icons.arrow_forward, 'text': 'Forward'},
                {'value': 'refresh', 'icon': Icons.refresh, 'text': 'Refresh'},
              ],
            ),

            buildSectionHeader(
              'Dividers in Menus',
              Icons.horizontal_rule,
              successColor,
            ),
            buildDividerDemo('Standard Dividers', successColor),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Multiple Section Dividers',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        Text(
                          'Organizing menu into logical groups',
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: Icon(Icons.layers, color: successColor),
                    onSelected: (String v) {
                      print('Multi-section selected: $v');
                    },
                    itemBuilder: (BuildContext ctx) {
                      return [
                        PopupMenuItem<String>(value: 'sec1_a', child: Text('Section 1 - A')),
                        PopupMenuItem<String>(value: 'sec1_b', child: Text('Section 1 - B')),
                        PopupMenuDivider(),
                        PopupMenuItem<String>(value: 'sec2_a', child: Text('Section 2 - A')),
                        PopupMenuItem<String>(value: 'sec2_b', child: Text('Section 2 - B')),
                        PopupMenuDivider(),
                        PopupMenuItem<String>(value: 'sec3_a', child: Text('Section 3 - A')),
                      ];
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: successColor.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Custom Height Dividers',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        Text(
                          'Dividers with varying heights',
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: Icon(Icons.space_bar, color: successColor),
                    onSelected: (String v) {
                      print('Custom height divider selected: $v');
                    },
                    itemBuilder: (BuildContext ctx) {
                      return [
                        PopupMenuItem<String>(value: 'top', child: Text('Top Item')),
                        PopupMenuDivider(height: 8),
                        PopupMenuItem<String>(value: 'middle', child: Text('Middle Item')),
                        PopupMenuDivider(height: 24),
                        PopupMenuItem<String>(value: 'bottom', child: Text('Bottom Item')),
                      ];
                    },
                  ),
                ],
              ),
            ),

            buildSectionHeader(
              'Tooltip Customization',
              Icons.message,
              warningColor,
            ),
            buildTooltipDemo('Default Tooltip', 'Show menu', warningColor),
            buildTooltipDemo('Custom Action Tooltip', 'View more options', Colors.brown),
            buildTooltipDemo('Descriptive Tooltip', 'Click to see available actions', Colors.cyan.shade700),
            buildTooltipDemo('Empty String Tooltip', '', Colors.pink),

            buildSectionHeader(
              'onSelected Callback',
              Icons.touch_app,
              primaryColor,
            ),
            buildCallbackDemo(
              'Logging Callback',
              primaryColor,
              (String value) {
                print('Logging callback received: $value');
              },
            ),
            buildCallbackDemo(
              'Action Dispatch Callback',
              secondaryColor,
              (String value) {
                print('Dispatching action for: $value');
              },
            ),
            buildCallbackDemo(
              'State Update Callback',
              accentColor,
              (String value) {
                print('Updating state with: $value');
              },
            ),

            buildSectionHeader(
              'initialValue Property',
              Icons.star,
              Colors.purple,
            ),
            buildInfoCard(
              'Purpose',
              'Highlights the item with matching value when menu opens',
              Colors.purple,
            ),
            buildInitialValueDemo('Size Selection (Small)', 'small', Colors.purple),
            buildInitialValueDemo('Size Selection (Medium)', 'medium', Colors.deepPurple),
            buildInitialValueDemo('Size Selection (Large)', 'large', Colors.purpleAccent.shade700),

            buildSectionHeader(
              'Enabled State',
              Icons.power_settings_new,
              Colors.red,
            ),
            buildEnabledStateDemo('Enabled Button', true, successColor),
            buildEnabledStateDemo('Disabled Button', false, Colors.grey),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: Colors.red, size: 20),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Conditionally Disabled',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        Text(
                          'Disabled based on some condition',
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    enabled: false,
                    icon: Icon(Icons.do_not_disturb, color: Colors.grey.shade400),
                    onSelected: (String v) {
                      print('This should not fire when disabled');
                    },
                    itemBuilder: (BuildContext ctx) {
                      return [
                        PopupMenuItem<String>(value: 'n/a', child: Text('Not Available')),
                      ];
                    },
                  ),
                ],
              ),
            ),

            buildSectionHeader(
              'Different Item Configurations',
              Icons.tune,
              Colors.blueGrey,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rich Content Items',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        Text(
                          'Items with custom widget content',
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: Icon(Icons.widgets, color: Colors.blueGrey),
                    onSelected: (String v) {
                      print('Rich content selected: $v');
                    },
                    itemBuilder: (BuildContext ctx) {
                      return [
                        PopupMenuItem<String>(
                          value: 'user',
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: Colors.blue.shade100,
                                child: Icon(Icons.person, size: 18, color: Colors.blue),
                              ),
                              SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('John Doe', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text('john@example.com', style: TextStyle(fontSize: 11)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        PopupMenuDivider(),
                        PopupMenuItem<String>(
                          value: 'settings',
                          child: Row(
                            children: [
                              Icon(Icons.settings, size: 20),
                              SizedBox(width: 12),
                              Text('Settings'),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'logout',
                          child: Row(
                            children: [
                              Icon(Icons.logout, size: 20, color: Colors.red),
                              SizedBox(width: 12),
                              Text('Logout', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ];
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blueGrey.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Status Indicators',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        Text(
                          'Items with colored status dots',
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: Icon(Icons.radio_button_checked, color: Colors.blueGrey),
                    onSelected: (String v) {
                      print('Status selected: $v');
                    },
                    itemBuilder: (BuildContext ctx) {
                      return [
                        PopupMenuItem<String>(
                          value: 'online',
                          child: Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text('Online'),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'away',
                          child: Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text('Away'),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'busy',
                          child: Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text('Busy'),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'offline',
                          child: Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text('Offline'),
                            ],
                          ),
                        ),
                      ];
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Badge Items',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        Text(
                          'Items with notification badges',
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: Icon(Icons.notifications, color: Colors.blueGrey),
                    onSelected: (String v) {
                      print('Badge item selected: $v');
                    },
                    itemBuilder: (BuildContext ctx) {
                      return [
                        PopupMenuItem<String>(
                          value: 'inbox',
                          child: Row(
                            children: [
                              Icon(Icons.inbox, size: 20),
                              SizedBox(width: 12),
                              Expanded(child: Text('Inbox')),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '5',
                                  style: TextStyle(color: Colors.white, fontSize: 11),
                                ),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'drafts',
                          child: Row(
                            children: [
                              Icon(Icons.drafts, size: 20),
                              SizedBox(width: 12),
                              Expanded(child: Text('Drafts')),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '2',
                                  style: TextStyle(color: Colors.white, fontSize: 11),
                                ),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'sent',
                          child: Row(
                            children: [
                              Icon(Icons.send, size: 20),
                              SizedBox(width: 12),
                              Expanded(child: Text('Sent')),
                            ],
                          ),
                        ),
                      ];
                    },
                  ),
                ],
              ),
            ),

            buildSectionHeader(
              'Usage Summary',
              Icons.lightbulb,
              Colors.orange,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.tips_and_updates, color: Colors.orange, size: 22),
                      SizedBox(width: 8),
                      Text(
                        'Key Takeaways',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.orange.shade800,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  _buildTipItem('Use GlobalKey to access PopupMenuButtonState', Colors.orange),
                  _buildTipItem('Call showButtonMenu() for programmatic menu control', Colors.orange),
                  _buildTipItem('itemBuilder runs each time the menu opens', Colors.orange),
                  _buildTipItem('Use PopupMenuDivider to separate menu sections', Colors.orange),
                  _buildTipItem('Set initialValue to highlight a specific item', Colors.orange),
                  _buildTipItem('Use enabled property to disable the button', Colors.orange),
                  _buildTipItem('Customize tooltip for accessibility', Colors.orange),
                  _buildTipItem('onSelected receives the value of selected item', Colors.orange),
                ],
              ),
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('PopupMenuButtonState deep demo completed');
  return result;
}

Widget _buildTipItem(String text, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle, color: color, size: 16),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
          ),
        ),
      ],
    ),
  );
}
