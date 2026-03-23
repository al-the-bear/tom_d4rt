// ignore_for_file: avoid_print
// D4rt test script: Tests PopupMenuItemState from material
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

Widget buildMenuItemDemo(
  String label,
  String description,
  Color themeColor,
  Widget menuItemWidget,
) {
  print('Building menu item demo: $label');
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
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: themeColor,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 8),
        menuItemWidget,
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

Widget buildLifecycleCard(
  String phase,
  String description,
  IconData icon,
  Color color,
  int order,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$order',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 14,
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Icon(icon, color: color, size: 20),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                phase,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
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

Widget buildPopupMenuWithItems(
  String label,
  List<String> items,
  Color color,
  IconData buttonIcon,
) {
  print('Building popup menu with items: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(buttonIcon, color: color, size: 22),
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
              Text(
                '${items.length} items available',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        PopupMenuButton<String>(
          icon: Icon(Icons.arrow_drop_down, color: color),
          onSelected: (String value) {
            print('Selected from $label: $value');
          },
          itemBuilder: (BuildContext context) {
            return items.map((String item) {
              return PopupMenuItem<String>(value: item, child: Text(item));
            }).toList();
          },
        ),
      ],
    ),
  );
}

Widget buildTapHandlerDemo(String label, String tapAction, Color color) {
  print('Building tap handler demo: $label');
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
        Icon(Icons.touch_app, color: color, size: 24),
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
                'Action: $tapAction',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, color: color),
          onSelected: (String value) {
            print('Tap handler - $tapAction: $value');
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'action_tap',
                onTap: () {
                  print('onTap triggered for: $label');
                },
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: color, size: 18),
                    SizedBox(width: 8),
                    Text(tapAction),
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

Widget buildContextAccessCard(String contextType, String usage, Color color) {
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
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(Icons.code, color: color, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                contextType,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: color,
                ),
              ),
              SizedBox(height: 2),
              Text(
                usage,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildWidgetReferenceCard(
  String widgetName,
  String relationship,
  IconData icon,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widgetName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              Text(
                relationship,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: color.withValues(alpha: 0.5),
          size: 14,
        ),
      ],
    ),
  );
}

Widget buildStateManagementCard(
  String concept,
  String explanation,
  Color color,
  IconData icon,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.withValues(alpha: 0.08), color.withValues(alpha: 0.02)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.15)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                concept,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              SizedBox(height: 4),
              Text(
                explanation,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildCustomBehaviorCard(
  String behavior,
  String implementation,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.3)),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.1),
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
            Icon(Icons.settings_suggest, color: color, size: 18),
            SizedBox(width: 8),
            Text(
              behavior,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            implementation,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade700,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildAnimationStateCard(
  String animationType,
  String description,
  Duration duration,
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
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.animation, color: color, size: 22),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                animationType,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Duration: ${duration.inMilliseconds}ms',
                  style: TextStyle(
                    fontSize: 10,
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildMultipleItemStateRow(
  List<Map<String, dynamic>> items,
  Color baseColor,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    child: Row(
      children: items.asMap().entries.map((entry) {
        int index = entry.key;
        Map<String, dynamic> item = entry.value;
        Color itemColor =
            Color.lerp(
              baseColor,
              baseColor.withValues(alpha: 0.5),
              index / items.length,
            ) ??
            baseColor;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: index < items.length - 1 ? 4 : 0),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: itemColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: itemColor.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                Icon(item['icon'] as IconData, color: itemColor, size: 20),
                SizedBox(height: 4),
                Text(
                  item['label'] as String,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    ),
  );
}

Widget buildInteractiveShowcase(
  String title,
  String description,
  Color primaryColor,
  Color secondaryColor,
  List<PopupMenuEntry<String>> Function(BuildContext) itemBuilder,
) {
  print('Building interactive showcase: $title');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          primaryColor.withValues(alpha: 0.08),
          secondaryColor.withValues(alpha: 0.05),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: primaryColor.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.2),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(Icons.star, color: primaryColor, size: 24),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: primaryColor,
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
              icon: Icon(Icons.expand_more, color: primaryColor, size: 28),
              onSelected: (String value) {
                print('Interactive showcase selected: $value');
              },
              itemBuilder: itemBuilder,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildEnabledDisabledDemo(String label, bool enabled, Color color) {
  print('Building enabled/disabled demo: $label, enabled=$enabled');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    padding: EdgeInsets.all(12),
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
          width: 10,
          height: 10,
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
                enabled ? 'Item is enabled' : 'Item is disabled',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
              ),
            ],
          ),
        ),
        PopupMenuButton<String>(
          icon: Icon(
            Icons.more_vert,
            color: enabled ? color : Colors.grey.shade400,
          ),
          onSelected: (String value) {
            print('Selected: $value');
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'item',
                enabled: enabled,
                child: Text(label),
              ),
            ];
          },
        ),
      ],
    ),
  );
}

Widget buildHeightPaddingDemo(
  String label,
  double height,
  EdgeInsets padding,
  Color color,
) {
  print('Building height/padding demo: $label');
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
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              Text(
                'H: ${height.toInt()}',
                style: TextStyle(
                  fontSize: 10,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'P: ${padding.horizontal.toInt()}',
                style: TextStyle(fontSize: 10, color: color),
              ),
            ],
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, color: color),
          onSelected: (String value) {
            print('Height/padding demo selected: $value');
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'custom',
                height: height,
                padding: padding,
                child: Text(label),
              ),
            ];
          },
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('PopupMenuItemState deep test starting');
  print('Testing state management for popup menu items');

  Color primaryColor = Colors.indigo;
  Color secondaryColor = Colors.teal;
  Color accentColor = Colors.deepOrange;
  Color highlightColor = Colors.purple;

  return Scaffold(
    backgroundColor: Colors.grey.shade100,
    appBar: AppBar(
      title: Text('PopupMenuItemState Test'),
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section 1: Overview of PopupMenuItemState
          buildSectionHeader(
            '1. Overview of PopupMenuItemState',
            Icons.info_outline,
            primaryColor,
          ),
          buildInfoCard(
            'Class Definition',
            'PopupMenuItemState<T, W extends PopupMenuItem<T>> is the State class for PopupMenuItem widget, managing item state and interaction',
            primaryColor,
          ),
          buildInfoCard(
            'Type Parameter T',
            'Represents the type of value the popup menu item holds when selected',
            primaryColor,
          ),
          buildInfoCard(
            'Type Parameter W',
            'Extends PopupMenuItem<T> to allow subclassing with custom item types',
            primaryColor,
          ),
          buildInfoCard(
            'Inheritance',
            'Extends State<W> providing standard state lifecycle and widget access',
            primaryColor,
          ),
          buildStatePropertyCard(
            'widget',
            'W',
            'Reference to the associated PopupMenuItem widget instance',
            primaryColor,
          ),
          buildStatePropertyCard(
            'context',
            'BuildContext',
            'Build context for accessing theme, media query, and inherited widgets',
            primaryColor,
          ),
          buildStatePropertyCard(
            'mounted',
            'bool',
            'Whether the State object is currently in a tree',
            primaryColor,
          ),

          // Section 2: handleTap method
          buildSectionHeader(
            '2. handleTap Method',
            Icons.touch_app,
            secondaryColor,
          ),
          buildMethodCard(
            'handleTap()',
            'void',
            'Called when the menu item is tapped. Triggers onTap callback and pops the menu with the item value',
            secondaryColor,
          ),
          buildTapHandlerDemo(
            'Confirm Selection',
            'Confirms user selection',
            secondaryColor,
          ),
          buildTapHandlerDemo(
            'Delete Item',
            'Deletes the selected item',
            Colors.red,
          ),
          buildTapHandlerDemo(
            'Edit Entry',
            'Opens editor for entry',
            Colors.blue,
          ),
          buildTapHandlerDemo(
            'Share Content',
            'Shares selected content',
            Colors.green,
          ),
          buildInfoCard(
            'Pop Navigation',
            'handleTap calls Navigator.pop<T>(context, widget.value) to close menu and return value',
            secondaryColor,
          ),
          buildInfoCard(
            'onTap Callback',
            'If widget.onTap is not null, it is invoked before the menu closes',
            secondaryColor,
          ),

          // Section 3: Build context access
          buildSectionHeader(
            '3. Build Context Access',
            Icons.code,
            accentColor,
          ),
          buildContextAccessCard(
            'Theme Access',
            'Theme.of(context) retrieves current theme data for styling',
            accentColor,
          ),
          buildContextAccessCard(
            'MediaQuery Access',
            'MediaQuery.of(context) provides device metrics and settings',
            accentColor,
          ),
          buildContextAccessCard(
            'DefaultTextStyle',
            'DefaultTextStyle.of(context) gets inherited text styling',
            accentColor,
          ),
          buildContextAccessCard(
            'Localizations',
            'Localizations.of(context, Type) accesses localized resources',
            accentColor,
          ),
          buildContextAccessCard(
            'Navigator',
            'Navigator.of(context) for navigation operations',
            accentColor,
          ),
          buildContextAccessCard(
            'PopupMenuTheme',
            'PopupMenuTheme.of(context) accesses popup-specific theming',
            accentColor,
          ),
          buildInfoCard(
            'Context Propagation',
            'The build context flows through the widget tree enabling child widgets to access ancestor data',
            accentColor,
          ),

          // Section 4: Widget reference
          buildSectionHeader(
            '4. Widget Reference',
            Icons.widgets,
            highlightColor,
          ),
          buildWidgetReferenceCard(
            'PopupMenuItem<T>',
            'The widget this state manages',
            Icons.square,
            highlightColor,
          ),
          buildWidgetReferenceCard(
            'PopupMenuButton<T>',
            'Parent button that shows menu containing items',
            Icons.smart_button,
            highlightColor,
          ),
          buildWidgetReferenceCard(
            '_PopupMenu<T>',
            'Internal route widget containing all items',
            Icons.menu,
            highlightColor,
          ),
          buildWidgetReferenceCard(
            'ListTile',
            'Default child wrapper for menu item content',
            Icons.list,
            highlightColor,
          ),
          buildInfoCard(
            'widget.child',
            'Accesses the child widget provided to PopupMenuItem',
            highlightColor,
          ),
          buildInfoCard(
            'widget.value',
            'Accesses the value returned when this item is selected',
            highlightColor,
          ),
          buildInfoCard(
            'widget.enabled',
            'Checks if the menu item is enabled for interaction',
            highlightColor,
          ),
          buildInfoCard(
            'widget.height',
            'Gets the custom height configured for this item',
            highlightColor,
          ),
          buildInfoCard(
            'widget.padding',
            'Gets the edge insets for content padding',
            highlightColor,
          ),

          // Section 5: Lifecycle methods
          buildSectionHeader(
            '5. Lifecycle Methods',
            Icons.refresh,
            Colors.cyan,
          ),
          buildLifecycleCard(
            'initState()',
            'Called when State is first created, initialize state variables here',
            Icons.play_arrow,
            Colors.cyan,
            1,
          ),
          buildLifecycleCard(
            'didChangeDependencies()',
            'Called when dependencies change, after initState',
            Icons.change_circle,
            Colors.cyan,
            2,
          ),
          buildLifecycleCard(
            'build()',
            'Called to construct the widget tree, may be called frequently',
            Icons.construction,
            Colors.cyan,
            3,
          ),
          buildLifecycleCard(
            'didUpdateWidget()',
            'Called when parent passes new widget configuration',
            Icons.update,
            Colors.cyan,
            4,
          ),
          buildLifecycleCard(
            'deactivate()',
            'Called when State is removed from tree temporarily',
            Icons.pause_circle,
            Colors.cyan,
            5,
          ),
          buildLifecycleCard(
            'dispose()',
            'Called when State is permanently removed, cleanup here',
            Icons.stop_circle,
            Colors.cyan,
            6,
          ),
          buildInfoCard(
            'setState()',
            'Call to request rebuild when state changes. Only call when mounted is true.',
            Colors.cyan,
          ),

          // Section 6: State management in menus
          buildSectionHeader(
            '6. State Management in Menus',
            Icons.account_tree,
            Colors.amber.shade700,
          ),
          buildStateManagementCard(
            'Selection State',
            'Menu items track whether they are currently selected or hovered',
            Colors.amber.shade700,
            Icons.check_circle,
          ),
          buildStateManagementCard(
            'Enabled State',
            'Items can be enabled or disabled affecting interaction and appearance',
            Colors.amber.shade700,
            Icons.toggle_on,
          ),
          buildStateManagementCard(
            'Focus State',
            'Keyboard navigation moves focus between menu items',
            Colors.amber.shade700,
            Icons.center_focus_strong,
          ),
          buildStateManagementCard(
            'Hover State',
            'Mouse hover changes item appearance with visual feedback',
            Colors.amber.shade700,
            Icons.mouse,
          ),
          buildPopupMenuWithItems(
            'File Operations',
            ['New', 'Open', 'Save', 'Save As', 'Close'],
            Colors.amber.shade700,
            Icons.folder,
          ),
          buildPopupMenuWithItems(
            'Edit Actions',
            ['Cut', 'Copy', 'Paste', 'Delete', 'Select All'],
            Colors.orange,
            Icons.edit,
          ),
          buildPopupMenuWithItems(
            'View Options',
            ['Zoom In', 'Zoom Out', 'Fit to Screen', 'Full Screen'],
            Colors.deepOrange,
            Icons.visibility,
          ),

          // Section 7: Custom state behavior
          buildSectionHeader(
            '7. Custom State Behavior',
            Icons.tune,
            Colors.pink,
          ),
          buildCustomBehaviorCard(
            'Custom onTap Handler',
            'onTap: () => performAction()',
            Colors.pink,
          ),
          buildCustomBehaviorCard(
            'Conditional Enabling',
            'enabled: canPerformAction()',
            Colors.pink,
          ),
          buildCustomBehaviorCard(
            'Dynamic Value',
            'value: computeValue()',
            Colors.pink,
          ),
          buildCustomBehaviorCard(
            'Custom Height',
            'height: kMinInteractiveDimension * 1.5',
            Colors.pink,
          ),
          buildCustomBehaviorCard(
            'Custom Padding',
            'padding: EdgeInsets.symmetric(horizontal: 24)',
            Colors.pink,
          ),
          buildEnabledDisabledDemo('Active Item', true, Colors.pink),
          buildEnabledDisabledDemo('Inactive Item', false, Colors.pink),
          buildHeightPaddingDemo(
            'Standard Height',
            48.0,
            EdgeInsets.symmetric(horizontal: 16),
            Colors.pink,
          ),
          buildHeightPaddingDemo(
            'Tall Item',
            72.0,
            EdgeInsets.symmetric(horizontal: 24),
            Colors.pink.shade300,
          ),
          buildHeightPaddingDemo(
            'Compact Item',
            36.0,
            EdgeInsets.symmetric(horizontal: 12),
            Colors.pink.shade700,
          ),

          // Section 8: Animation state
          buildSectionHeader(
            '8. Animation State',
            Icons.animation,
            Colors.deepPurple,
          ),
          buildAnimationStateCard(
            'Menu Open Animation',
            'Scale and fade animation when popup appears',
            Duration(milliseconds: 300),
            Colors.deepPurple,
          ),
          buildAnimationStateCard(
            'Menu Close Animation',
            'Reverse animation when popup dismisses',
            Duration(milliseconds: 200),
            Colors.deepPurple,
          ),
          buildAnimationStateCard(
            'Hover Transition',
            'Background color change on mouse hover',
            Duration(milliseconds: 100),
            Colors.deepPurple,
          ),
          buildAnimationStateCard(
            'Press Feedback',
            'Ink splash animation on tap',
            Duration(milliseconds: 150),
            Colors.deepPurple,
          ),
          buildAnimationStateCard(
            'Focus Ring',
            'Border highlight on keyboard focus',
            Duration(milliseconds: 50),
            Colors.deepPurple,
          ),
          buildInfoCard(
            'AnimationController',
            'Internal animation is managed by the popup menu route, not individual items',
            Colors.deepPurple,
          ),
          buildInfoCard(
            'CurvedAnimation',
            'Popup uses easeOutCubic curve for smooth appearance',
            Colors.deepPurple,
          ),

          // Section 9: Multiple item states
          buildSectionHeader(
            '9. Multiple Item States',
            Icons.grid_view,
            Colors.brown,
          ),
          buildMultipleItemStateRow([
            {'icon': Icons.add, 'label': 'Add'},
            {'icon': Icons.remove, 'label': 'Remove'},
            {'icon': Icons.edit, 'label': 'Edit'},
            {'icon': Icons.delete, 'label': 'Delete'},
          ], Colors.brown),
          buildMultipleItemStateRow([
            {'icon': Icons.home, 'label': 'Home'},
            {'icon': Icons.work, 'label': 'Work'},
            {'icon': Icons.favorite, 'label': 'Favorites'},
          ], Colors.teal),
          buildMultipleItemStateRow([
            {'icon': Icons.folder, 'label': 'Folder'},
            {'icon': Icons.file_copy, 'label': 'File'},
            {'icon': Icons.cloud, 'label': 'Cloud'},
            {'icon': Icons.devices, 'label': 'Device'},
            {'icon': Icons.share, 'label': 'Share'},
          ], Colors.indigo),
          buildPopupMenuWithItems(
            'Sort By',
            ['Name', 'Date', 'Size', 'Type', 'Modified'],
            Colors.brown,
            Icons.sort,
          ),
          buildPopupMenuWithItems(
            'Filter',
            ['All', 'Images', 'Videos', 'Documents', 'Audio'],
            Colors.brown.shade600,
            Icons.filter_list,
          ),
          buildInfoCard(
            'State Independence',
            'Each PopupMenuItem has its own independent State instance',
            Colors.brown,
          ),
          buildInfoCard(
            'State Coordination',
            'Parent PopupMenuButton coordinates state across all items',
            Colors.brown,
          ),

          // Section 10: Interactive state showcase
          buildSectionHeader(
            '10. Interactive State Showcase',
            Icons.star,
            Colors.red,
          ),
          buildInteractiveShowcase(
            'Document Actions',
            'Common document operations with full state management',
            Colors.red,
            Colors.orange,
            (BuildContext context) {
              print('Building document actions menu');
              return [
                PopupMenuItem<String>(
                  value: 'new_doc',
                  child: Row(
                    children: [
                      Icon(Icons.add_box, color: Colors.green, size: 20),
                      SizedBox(width: 12),
                      Text('New Document'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'open_doc',
                  child: Row(
                    children: [
                      Icon(Icons.folder_open, color: Colors.blue, size: 20),
                      SizedBox(width: 12),
                      Text('Open'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'save_doc',
                  child: Row(
                    children: [
                      Icon(Icons.save, color: Colors.orange, size: 20),
                      SizedBox(width: 12),
                      Text('Save'),
                    ],
                  ),
                ),
                PopupMenuDivider(),
                PopupMenuItem<String>(
                  value: 'print_doc',
                  child: Row(
                    children: [
                      Icon(Icons.print, color: Colors.grey, size: 20),
                      SizedBox(width: 12),
                      Text('Print'),
                    ],
                  ),
                ),
              ];
            },
          ),
          buildInteractiveShowcase(
            'Account Settings',
            'User profile and account management options',
            Colors.blue,
            Colors.indigo,
            (BuildContext context) {
              print('Building account settings menu');
              return [
                PopupMenuItem<String>(
                  value: 'profile',
                  child: Row(
                    children: [
                      Icon(Icons.person, color: Colors.blue, size: 20),
                      SizedBox(width: 12),
                      Text('View Profile'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'settings',
                  child: Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: Colors.grey.shade700,
                        size: 20,
                      ),
                      SizedBox(width: 12),
                      Text('Settings'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'notifications',
                  child: Row(
                    children: [
                      Icon(Icons.notifications, color: Colors.amber, size: 20),
                      SizedBox(width: 12),
                      Text('Notifications'),
                    ],
                  ),
                ),
                PopupMenuDivider(),
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.red, size: 20),
                      SizedBox(width: 12),
                      Text('Sign Out'),
                    ],
                  ),
                ),
              ];
            },
          ),
          buildInteractiveShowcase(
            'Media Controls',
            'Playback and media management with stateful items',
            Colors.purple,
            Colors.deepPurple,
            (BuildContext context) {
              print('Building media controls menu');
              return [
                PopupMenuItem<String>(
                  value: 'play',
                  child: Row(
                    children: [
                      Icon(Icons.play_arrow, color: Colors.green, size: 20),
                      SizedBox(width: 12),
                      Text('Play'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'pause',
                  child: Row(
                    children: [
                      Icon(Icons.pause, color: Colors.orange, size: 20),
                      SizedBox(width: 12),
                      Text('Pause'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'stop',
                  child: Row(
                    children: [
                      Icon(Icons.stop, color: Colors.red, size: 20),
                      SizedBox(width: 12),
                      Text('Stop'),
                    ],
                  ),
                ),
                PopupMenuDivider(),
                PopupMenuItem<String>(
                  value: 'shuffle',
                  child: Row(
                    children: [
                      Icon(Icons.shuffle, color: Colors.purple, size: 20),
                      SizedBox(width: 12),
                      Text('Shuffle'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'repeat',
                  child: Row(
                    children: [
                      Icon(Icons.repeat, color: Colors.blue, size: 20),
                      SizedBox(width: 12),
                      Text('Repeat'),
                    ],
                  ),
                ),
              ];
            },
          ),
          buildInteractiveShowcase(
            'Calendar Options',
            'Date and event management actions',
            Colors.teal,
            Colors.cyan,
            (BuildContext context) {
              print('Building calendar options menu');
              return [
                PopupMenuItem<String>(
                  value: 'today',
                  child: Row(
                    children: [
                      Icon(Icons.today, color: Colors.teal, size: 20),
                      SizedBox(width: 12),
                      Text('Go to Today'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'add_event',
                  child: Row(
                    children: [
                      Icon(Icons.add_circle, color: Colors.green, size: 20),
                      SizedBox(width: 12),
                      Text('New Event'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'view_week',
                  child: Row(
                    children: [
                      Icon(Icons.view_week, color: Colors.blue, size: 20),
                      SizedBox(width: 12),
                      Text('Week View'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'view_month',
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_view_month,
                        color: Colors.indigo,
                        size: 20,
                      ),
                      SizedBox(width: 12),
                      Text('Month View'),
                    ],
                  ),
                ),
              ];
            },
          ),

          // Additional showcase items
          buildMenuItemDemo(
            'Text Style Demo',
            'PopupMenuItems can contain any widget as child',
            Colors.green,
            PopupMenuButton<String>(
              icon: Icon(Icons.text_format, color: Colors.green),
              onSelected: (String value) {
                print('Text style selected: $value');
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'bold',
                    child: Text(
                      'Bold',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'italic',
                    child: Text(
                      'Italic',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'underline',
                    child: Text(
                      'Underline',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                ];
              },
            ),
          ),

          // Summary section
          buildSectionHeader('Summary', Icons.summarize, Colors.blueGrey),
          buildInfoCard(
            'Key Takeaways',
            'PopupMenuItemState manages the internal state of each menu item including tap handling, enabled state, and build lifecycle',
            Colors.blueGrey,
          ),
          buildInfoCard(
            'Generic Type Safety',
            'The dual type parameters T and W ensure type-safe value handling and widget subclassing',
            Colors.blueGrey,
          ),
          buildInfoCard(
            'Integration Pattern',
            'State class works with PopupMenuButton and Navigator to provide seamless menu interaction',
            Colors.blueGrey,
          ),

          SizedBox(height: 24),

          // Footer
          Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  'PopupMenuItemState<T, W extends PopupMenuItem<T>>',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Flutter Material Library - D4rt Test Script',
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          SizedBox(height: 16),
        ],
      ),
    ),
  );
}
