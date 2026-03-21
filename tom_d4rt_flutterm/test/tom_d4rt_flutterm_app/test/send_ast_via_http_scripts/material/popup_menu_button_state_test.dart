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

Widget buildPopupMenuDemo(
  String label,
  String description,
  Color themeColor,
  List<PopupMenuEntry<String>> Function(BuildContext) itemBuilder,
  IconData icon,
) {
  print('Building popup menu demo: $label');
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

Widget buildStatePropertyCard(
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

Widget buildMethodCard(
  String methodName,
  String returnType,
  String description,
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
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                returnType,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 8),
            Text(
              methodName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          description,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

Widget buildPopupButtonWithChild(
  String label,
  Widget child,
  Color themeColor,
  List<PopupMenuEntry<String>> Function(BuildContext) itemBuilder,
) {
  print('Building popup with child: $label');
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
          child: Text(
            label,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),
        PopupMenuButton<String>(
          onSelected: (String value) {
            print('Child button selected: $value');
          },
          itemBuilder: itemBuilder,
          child: child,
        ),
      ],
    ),
  );
}

Widget buildPositionedPopupDemo(
  String label,
  PopupMenuPosition position,
  Color color,
) {
  print('Building positioned popup: $label with $position');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        Icon(Icons.location_on, color: color, size: 20),
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
                'Position: $position',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        PopupMenuButton<String>(
          position: position,
          icon: Icon(Icons.more_vert, color: color),
          onSelected: (String value) {
            print('Positioned popup selected: $value');
          },
          itemBuilder: (BuildContext ctx) {
            return [
              PopupMenuItem<String>(
                value: 'option1',
                child: Text('Option One'),
              ),
              PopupMenuItem<String>(
                value: 'option2',
                child: Text('Option Two'),
              ),
              PopupMenuItem<String>(
                value: 'option3',
                child: Text('Option Three'),
              ),
            ];
          },
        ),
      ],
    ),
  );
}

Widget buildOffsetPopupDemo(String label, Offset offset, Color color) {
  print('Building offset popup: $label with $offset');
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
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'dx:${offset.dx.toInt()}\ndy:${offset.dy.toInt()}',
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),
        PopupMenuButton<String>(
          offset: offset,
          icon: Icon(Icons.arrow_drop_down_circle, color: color),
          onSelected: (String value) {
            print('Offset popup selected: $value');
          },
          itemBuilder: (BuildContext ctx) {
            return [
              PopupMenuItem<String>(value: 'item_a', child: Text('Item A')),
              PopupMenuItem<String>(value: 'item_b', child: Text('Item B')),
            ];
          },
        ),
      ],
    ),
  );
}

Widget buildConstrainedPopupDemo(
  String label,
  BoxConstraints constraints,
  Color color,
) {
  print('Building constrained popup: $label');
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
                'minW:${constraints.minWidth.toInt()} maxW:${constraints.maxWidth.toInt()}',
                style: TextStyle(fontSize: 11, color: color),
              ),
            ],
          ),
        ),
        PopupMenuButton<String>(
          constraints: constraints,
          icon: Icon(Icons.view_column, color: color),
          onSelected: (String value) {
            print('Constrained popup selected: $value');
          },
          itemBuilder: (BuildContext ctx) {
            return [
              PopupMenuItem<String>(
                value: 'narrow',
                child: Text('Narrow Item'),
              ),
              PopupMenuItem<String>(
                value: 'medium',
                child: Text('Medium Width'),
              ),
              PopupMenuItem<String>(
                value: 'wide',
                child: Text('Wide Menu Item'),
              ),
            ];
          },
        ),
      ],
    ),
  );
}

Widget buildTooltipPopupDemo(String label, String tooltip, Color color) {
  print('Building tooltip popup: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(8),
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
                'Tooltip: "$tooltip"',
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
          tooltip: tooltip,
          icon: Icon(Icons.more_horiz, color: color),
          onSelected: (String v) {
            print('Tooltip popup selected: $v');
          },
          itemBuilder: (BuildContext ctx) {
            return [
              PopupMenuItem<String>(value: 'a', child: Text('Alpha')),
              PopupMenuItem<String>(value: 'b', child: Text('Beta')),
            ];
          },
        ),
      ],
    ),
  );
}

Widget buildEnabledStateDemo(String label, bool enabled, Color color) {
  print('Building enabled state demo: $label enabled=$enabled');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: enabled ? Colors.white : Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: enabled ? color.withValues(alpha: 0.3) : Colors.grey.shade300,
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: enabled ? Colors.green : Colors.grey,
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
                  color: enabled ? Colors.black87 : Colors.grey,
                ),
              ),
              Text(
                enabled ? 'Enabled - Tap to open' : 'Disabled - Cannot open',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
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
              PopupMenuItem<String>(value: 'x', child: Text('X Item')),
              PopupMenuItem<String>(value: 'y', child: Text('Y Item')),
            ];
          },
        ),
      ],
    ),
  );
}

Widget buildCustomIconDemo(
  String label,
  IconData iconData,
  double iconSize,
  Color color,
) {
  print('Building custom icon demo: $label');
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
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(iconData, color: color, size: 18),
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
              Text(
                'Icon size: ${iconSize.toInt()}',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        PopupMenuButton<String>(
          icon: Icon(iconData, color: color, size: iconSize),
          iconSize: iconSize,
          onSelected: (String v) {
            print('Custom icon popup: $v');
          },
          itemBuilder: (BuildContext ctx) {
            return [
              PopupMenuItem<String>(value: 'option', child: Text('Option')),
            ];
          },
        ),
      ],
    ),
  );
}

Widget buildItemBuilderShowcase(Color themeColor) {
  print('Building item builder showcase');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Custom Item Builders',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 8),
        Text(
          'itemBuilder provides BuildContext and returns List<PopupMenuEntry<T>>',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildItemBuilderCard(
                'Simple Items',
                Icons.list,
                Colors.blue,
                (BuildContext ctx) {
                  return [
                    PopupMenuItem<String>(
                      value: 's1',
                      child: Text('Simple One'),
                    ),
                    PopupMenuItem<String>(
                      value: 's2',
                      child: Text('Simple Two'),
                    ),
                    PopupMenuItem<String>(
                      value: 's3',
                      child: Text('Simple Three'),
                    ),
                  ];
                },
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _buildItemBuilderCard(
                'With Dividers',
                Icons.horizontal_rule,
                Colors.orange,
                (BuildContext ctx) {
                  return [
                    PopupMenuItem<String>(value: 'd1', child: Text('Group A')),
                    PopupMenuDivider(),
                    PopupMenuItem<String>(value: 'd2', child: Text('Group B')),
                    PopupMenuDivider(),
                    PopupMenuItem<String>(value: 'd3', child: Text('Group C')),
                  ];
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildItemBuilderCard(
                'With Icons',
                Icons.apps,
                Colors.purple,
                (BuildContext ctx) {
                  return [
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
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _buildItemBuilderCard(
                'Checked Items',
                Icons.check_box,
                Colors.green,
                (BuildContext ctx) {
                  return [
                    CheckedPopupMenuItem<String>(
                      value: 'c1',
                      checked: true,
                      child: Text('Checked'),
                    ),
                    CheckedPopupMenuItem<String>(
                      value: 'c2',
                      checked: false,
                      child: Text('Unchecked'),
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

Widget _buildItemBuilderCard(
  String label,
  IconData icon,
  Color color,
  List<PopupMenuEntry<String>> Function(BuildContext) builder,
) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 16),
            SizedBox(width: 6),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        PopupMenuButton<String>(
          icon: Icon(Icons.open_in_new, color: color, size: 20),
          onSelected: (String v) {
            print('Item builder card selected: $v');
          },
          itemBuilder: builder,
        ),
      ],
    ),
  );
}

Widget buildCallbackShowcase(Color color) {
  print('Building callback showcase');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Menu Callbacks',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 4),
        Text(
          'Various callbacks for menu lifecycle events',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        _buildCallbackRow(
          'onSelected',
          'Called when an item is selected',
          Colors.green,
          Icons.check_circle,
        ),
        _buildCallbackRow(
          'onCanceled',
          'Called when menu is dismissed without selection',
          Colors.red,
          Icons.cancel,
        ),
        _buildCallbackRow(
          'onOpened',
          'Called when the menu is opened',
          Colors.blue,
          Icons.open_in_browser,
        ),
        SizedBox(height: 12),
        Center(
          child: PopupMenuButton<String>(
            icon: Icon(Icons.touch_app, color: color, size: 28),
            onSelected: (String value) {
              print('CALLBACK: onSelected with value=$value');
            },
            onCanceled: () {
              print('CALLBACK: onCanceled');
            },
            onOpened: () {
              print('CALLBACK: onOpened');
            },
            itemBuilder: (BuildContext ctx) {
              return [
                PopupMenuItem<String>(
                  value: 'callback_test_1',
                  child: Text('Select This'),
                ),
                PopupMenuItem<String>(
                  value: 'callback_test_2',
                  child: Text('Or This'),
                ),
              ];
            },
          ),
        ),
      ],
    ),
  );
}

Widget _buildCallbackRow(
  String name,
  String description,
  Color color,
  IconData icon,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 18),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: color,
                ),
              ),
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

Widget buildMultiplePopupsShowcase() {
  print('Building multiple popups showcase');
  List<String> menuLabels = [
    'File Menu',
    'Edit Menu',
    'View Menu',
    'Tools Menu',
    'Help Menu',
  ];
  List<Color> menuColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
  ];
  List<IconData> menuIcons = [
    Icons.folder,
    Icons.edit,
    Icons.visibility,
    Icons.build,
    Icons.help,
  ];

  List<Widget> menuButtons = [];
  int i = 0;
  for (i = 0; i < menuLabels.length; i = i + 1) {
    int idx = i;
    menuButtons.add(
      Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          child: PopupMenuButton<String>(
            onSelected: (String v) {
              print('${menuLabels[idx]} selected: $v');
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: menuColors[idx].withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                children: [
                  Icon(menuIcons[idx], color: menuColors[idx], size: 20),
                  SizedBox(height: 4),
                  Text(
                    menuLabels[idx],
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: menuColors[idx],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            itemBuilder: (BuildContext ctx) {
              return [
                PopupMenuItem<String>(
                  value: '${menuLabels[idx]}_item1',
                  child: Text('${menuLabels[idx]} Item 1'),
                ),
                PopupMenuItem<String>(
                  value: '${menuLabels[idx]}_item2',
                  child: Text('${menuLabels[idx]} Item 2'),
                ),
                PopupMenuItem<String>(
                  value: '${menuLabels[idx]}_item3',
                  child: Text('${menuLabels[idx]} Item 3'),
                ),
              ];
            },
          ),
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Multiple Popup Menu Buttons',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 4),
        Text(
          'Menu bar style with multiple PopupMenuButtons',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Row(children: menuButtons),
      ],
    ),
  );
}

Widget buildInteractiveShowcase(Color themeColor) {
  print('Building interactive showcase');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          themeColor.withValues(alpha: 0.1),
          themeColor.withValues(alpha: 0.05),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: themeColor.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.touch_app, color: themeColor, size: 24),
            SizedBox(width: 8),
            Text(
              'Interactive Menu Showcase',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: themeColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Explore different PopupMenuButton configurations',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        _buildInteractiveCard(
          'Action Menu',
          'With icons and dividers',
          Icons.build_circle,
          Colors.blue,
          (BuildContext ctx) {
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
            ];
          },
        ),
        SizedBox(height: 8),
        _buildInteractiveCard(
          'Settings Menu',
          'Toggle options',
          Icons.settings,
          Colors.green,
          (BuildContext ctx) {
            return [
              CheckedPopupMenuItem<String>(
                value: 'notifications',
                checked: true,
                child: Text('Notifications'),
              ),
              CheckedPopupMenuItem<String>(
                value: 'dark_mode',
                checked: false,
                child: Text('Dark Mode'),
              ),
              CheckedPopupMenuItem<String>(
                value: 'auto_save',
                checked: true,
                child: Text('Auto Save'),
              ),
              PopupMenuDivider(),
              PopupMenuItem<String>(
                value: 'advanced',
                child: Text('Advanced Settings...'),
              ),
            ];
          },
        ),
        SizedBox(height: 8),
        _buildInteractiveCard(
          'Sort Menu',
          'Sorting options',
          Icons.sort,
          Colors.orange,
          (BuildContext ctx) {
            return [
              PopupMenuItem<String>(
                value: 'sort_name',
                child: Row(
                  children: [
                    Icon(Icons.sort_by_alpha, size: 18),
                    SizedBox(width: 12),
                    Text('Sort by Name'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'sort_date',
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, size: 18),
                    SizedBox(width: 12),
                    Text('Sort by Date'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'sort_size',
                child: Row(
                  children: [
                    Icon(Icons.data_usage, size: 18),
                    SizedBox(width: 12),
                    Text('Sort by Size'),
                  ],
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem<String>(
                value: 'reverse',
                child: Row(
                  children: [
                    Icon(Icons.swap_vert, size: 18),
                    SizedBox(width: 12),
                    Text('Reverse Order'),
                  ],
                ),
              ),
            ];
          },
        ),
        SizedBox(height: 8),
        _buildInteractiveCard(
          'Share Menu',
          'Social sharing',
          Icons.share,
          Colors.purple,
          (BuildContext ctx) {
            return [
              PopupMenuItem<String>(
                value: 'share_email',
                child: Row(
                  children: [
                    Icon(Icons.email, size: 18, color: Colors.red),
                    SizedBox(width: 12),
                    Text('Email'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'share_message',
                child: Row(
                  children: [
                    Icon(Icons.message, size: 18, color: Colors.green),
                    SizedBox(width: 12),
                    Text('Message'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'share_link',
                child: Row(
                  children: [
                    Icon(Icons.link, size: 18, color: Colors.blue),
                    SizedBox(width: 12),
                    Text('Copy Link'),
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

Widget _buildInteractiveCard(
  String title,
  String subtitle,
  IconData icon,
  Color color,
  List<PopupMenuEntry<String>> Function(BuildContext) builder,
) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
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
          width: 44,
          height: 44,
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
              Text(
                subtitle,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, color: color),
          onSelected: (String v) {
            print('Interactive card "$title" selected: $v');
          },
          itemBuilder: builder,
        ),
      ],
    ),
  );
}

Widget buildShowButtonMenuSection(Color color) {
  print('Building showButtonMenu section');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'showButtonMenu() Method',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 8),
        Text(
          'PopupMenuButtonState provides showButtonMenu() to programmatically open the menu. '
          'Access it via GlobalKey to trigger the menu from code.',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Usage Pattern:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'GlobalKey<PopupMenuButtonState<T>> key = GlobalKey();\n'
                  'PopupMenuButton<T>(key: key, ...);\n'
                  'key.currentState?.showButtonMenu();',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        buildMethodCard(
          'showButtonMenu()',
          'void',
          'Opens the popup menu programmatically. Shows the same menu that would appear on tap.',
          color,
        ),
      ],
    ),
  );
}

Widget buildStateOverview(Color color) {
  print('Building state overview');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PopupMenuButtonState<T> Overview',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 8),
        Text(
          'State class for PopupMenuButton that manages menu display and interaction.',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        buildStatePropertyCard(
          'widget',
          'PopupMenuButton<T>',
          'Reference to the associated PopupMenuButton widget',
          color,
        ),
        buildStatePropertyCard(
          'context',
          'BuildContext',
          'The build context for this state',
          color,
        ),
        buildStatePropertyCard(
          'mounted',
          'bool',
          'Whether this state is currently in the widget tree',
          color,
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.info, color: color, size: 20),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'The state manages showButtonMenu() which programmatically opens the popup menu.',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildMenuPositioningSection(Color color) {
  print('Building menu positioning section');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Menu Positioning Details',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 8),
        Text(
          'Control where the popup menu appears relative to the button.',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        buildPositionedPopupDemo(
          'Over Position',
          PopupMenuPosition.over,
          Colors.blue,
        ),
        buildPositionedPopupDemo(
          'Under Position',
          PopupMenuPosition.under,
          Colors.green,
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PopupMenuPosition enum values:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              SizedBox(height: 8),
              _buildEnumRow(
                'over',
                'Menu appears over the button',
                Colors.blue,
              ),
              _buildEnumRow(
                'under',
                'Menu appears below the button',
                Colors.green,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildEnumRow(String value, String description, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11,
              color: color,
            ),
          ),
        ),
        SizedBox(width: 10),
        Text(
          description,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
        ),
      ],
    ),
  );
}

Widget buildOffsetConstraintsSection(Color color) {
  print('Building offset and constraints section');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Offset & Constraints',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 8),
        Text(
          'Fine-tune menu position with offset and constrain menu dimensions.',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Text(
          'Offset Examples:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        SizedBox(height: 8),
        buildOffsetPopupDemo('No Offset', Offset(0, 0), Colors.grey),
        buildOffsetPopupDemo('Right Offset', Offset(20, 0), Colors.blue),
        buildOffsetPopupDemo('Down Offset', Offset(0, 15), Colors.green),
        buildOffsetPopupDemo('Diagonal Offset', Offset(10, 10), Colors.orange),
        SizedBox(height: 16),
        Text(
          'Constraints Examples:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        SizedBox(height: 8),
        buildConstrainedPopupDemo(
          'Narrow Menu',
          BoxConstraints(minWidth: 100, maxWidth: 150),
          Colors.purple,
        ),
        buildConstrainedPopupDemo(
          'Wide Menu',
          BoxConstraints(minWidth: 200, maxWidth: 300),
          Colors.teal,
        ),
        buildConstrainedPopupDemo(
          'Fixed Width',
          BoxConstraints(minWidth: 180, maxWidth: 180),
          Colors.indigo,
        ),
      ],
    ),
  );
}

Widget buildTooltipEnabledSection(Color color) {
  print('Building tooltip and enabled section');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tooltip & Enabled States',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 8),
        Text(
          'Provide accessibility hints and control button interactivity.',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Text(
          'Tooltip Examples:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        SizedBox(height: 8),
        buildTooltipPopupDemo('Menu Button', 'Open menu', Colors.blue),
        buildTooltipPopupDemo('Options', 'More options', Colors.green),
        buildTooltipPopupDemo('Actions', 'Available actions', Colors.orange),
        SizedBox(height: 16),
        Text(
          'Enabled States:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        SizedBox(height: 8),
        buildEnabledStateDemo('Active Menu Button', true, Colors.green),
        buildEnabledStateDemo('Disabled Menu Button', false, Colors.grey),
      ],
    ),
  );
}

Widget buildIconChildSection(Color color) {
  print('Building icon and child section');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Icon & Child Customization',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 8),
        Text(
          'Customize the button appearance with icons or custom child widgets.',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Text(
          'Icon Property:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        SizedBox(height: 8),
        buildCustomIconDemo(
          'More Vertical',
          Icons.more_vert,
          24,
          Colors.grey.shade700,
        ),
        buildCustomIconDemo(
          'More Horizontal',
          Icons.more_horiz,
          24,
          Colors.blue,
        ),
        buildCustomIconDemo('Menu Icon', Icons.menu, 24, Colors.green),
        buildCustomIconDemo('Large Icon', Icons.settings, 32, Colors.purple),
        buildCustomIconDemo(
          'Small Icon',
          Icons.arrow_drop_down,
          20,
          Colors.orange,
        ),
        SizedBox(height: 16),
        Text(
          'Child Property (replaces icon):',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        SizedBox(height: 8),
        buildPopupButtonWithChild(
          'Text Button',
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Open Menu',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Colors.blue,
          (BuildContext ctx) {
            return [
              PopupMenuItem<String>(value: 'a', child: Text('Option A')),
              PopupMenuItem<String>(value: 'b', child: Text('Option B')),
            ];
          },
        ),
        buildPopupButtonWithChild(
          'Chip Button',
          Chip(
            avatar: Icon(Icons.person, size: 18),
            label: Text('User Menu'),
            backgroundColor: Colors.green.shade50,
          ),
          Colors.green,
          (BuildContext ctx) {
            return [
              PopupMenuItem<String>(value: 'profile', child: Text('Profile')),
              PopupMenuItem<String>(value: 'settings', child: Text('Settings')),
              PopupMenuItem<String>(value: 'logout', child: Text('Logout')),
            ];
          },
        ),
        buildPopupButtonWithChild(
          'Icon + Text',
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add_circle, color: Colors.orange),
              SizedBox(width: 4),
              Text(
                'Add',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.arrow_drop_down, color: Colors.orange),
            ],
          ),
          Colors.orange,
          (BuildContext ctx) {
            return [
              PopupMenuItem<String>(value: 'new_file', child: Text('New File')),
              PopupMenuItem<String>(
                value: 'new_folder',
                child: Text('New Folder'),
              ),
              PopupMenuItem<String>(value: 'import', child: Text('Import...')),
            ];
          },
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('PopupMenuButtonState deep demo test executing');

  Color primaryColor = Colors.deepPurple;

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('PopupMenuButtonState<T> Demo'),
        backgroundColor: Colors.deepPurple.shade700,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (String value) {
              print('AppBar popup selected: $value');
            },
            itemBuilder: (BuildContext ctx) {
              return [
                PopupMenuItem<String>(value: 'refresh', child: Text('Refresh')),
                PopupMenuItem<String>(
                  value: 'settings',
                  child: Text('Settings'),
                ),
                PopupMenuDivider(),
                PopupMenuItem<String>(value: 'about', child: Text('About')),
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
            buildSectionHeader('1. Overview', Icons.info, primaryColor),
            buildInfoCard('Class', 'PopupMenuButtonState<T>', primaryColor),
            buildInfoCard(
              'Purpose',
              'State class for PopupMenuButton that manages menu lifecycle and provides showButtonMenu()',
              primaryColor,
            ),
            buildInfoCard(
              'Generic Type',
              'T represents the type of values for menu items',
              primaryColor,
            ),
            buildInfoCard(
              'Key Method',
              'showButtonMenu() - programmatically opens the popup menu',
              primaryColor,
            ),
            buildStateOverview(primaryColor),

            buildSectionHeader(
              '2. showButtonMenu() Method',
              Icons.play_arrow,
              Colors.green,
            ),
            buildShowButtonMenuSection(Colors.green),

            buildSectionHeader(
              '3. Menu Item Callbacks',
              Icons.touch_app,
              Colors.blue,
            ),
            buildCallbackShowcase(Colors.blue),

            buildSectionHeader(
              '4. Menu Positioning',
              Icons.place,
              Colors.orange,
            ),
            buildMenuPositioningSection(Colors.orange),

            buildSectionHeader(
              '5. Custom Item Builders',
              Icons.build,
              Colors.purple,
            ),
            buildItemBuilderShowcase(Colors.purple),

            buildSectionHeader(
              '6. Icon & Child Customization',
              Icons.palette,
              Colors.teal,
            ),
            buildIconChildSection(Colors.teal),

            buildSectionHeader(
              '7. Offset & Constraints',
              Icons.open_with,
              Colors.indigo,
            ),
            buildOffsetConstraintsSection(Colors.indigo),

            buildSectionHeader(
              '8. Tooltip & Enabled States',
              Icons.accessibility,
              Colors.brown,
            ),
            buildTooltipEnabledSection(Colors.brown),

            buildSectionHeader(
              '9. Multiple Popup Menus',
              Icons.apps,
              Colors.pink,
            ),
            buildMultiplePopupsShowcase(),

            buildSectionHeader(
              '10. Interactive Showcase',
              Icons.star,
              Colors.amber.shade700,
            ),
            buildInteractiveShowcase(Colors.amber.shade700),

            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryColor.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb, color: primaryColor, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Usage Tips',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  _buildTipRow(
                    'Use GlobalKey to access PopupMenuButtonState',
                    primaryColor,
                  ),
                  _buildTipRow(
                    'Call showButtonMenu() for programmatic menu control',
                    primaryColor,
                  ),
                  _buildTipRow(
                    'itemBuilder runs each time menu opens',
                    primaryColor,
                  ),
                  _buildTipRow(
                    'Use position for over/under placement',
                    primaryColor,
                  ),
                  _buildTipRow(
                    'Combine offset with position for fine control',
                    primaryColor,
                  ),
                  _buildTipRow(
                    'Set constraints to control menu dimensions',
                    primaryColor,
                  ),
                  _buildTipRow(
                    'Use child instead of icon for custom button appearance',
                    primaryColor,
                  ),
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

Widget _buildTipRow(String tip, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle_outline, color: color, size: 16),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            tip,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}
