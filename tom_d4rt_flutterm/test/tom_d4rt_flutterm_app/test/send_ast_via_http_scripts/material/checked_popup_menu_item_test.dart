// ignore_for_file: avoid_print
// D4rt test script: Tests CheckedPopupMenuItem from material
import 'package:flutter/material.dart';

// Helper for section header
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

// Helper for a visual popup menu item representation
Widget buildPopupItemVisual(
  String text,
  bool checked,
  bool enabled,
  Color checkColor,
  Color textColor,
  Color bgColor,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: checked
              ? Icon(
                  Icons.check,
                  size: 18,
                  color: enabled ? checkColor : Colors.grey.shade400,
                )
              : SizedBox.shrink(),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: enabled ? textColor : Colors.grey.shade400,
              fontWeight: checked ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ),
        if (!enabled) Icon(Icons.block, size: 14, color: Colors.grey.shade400),
      ],
    ),
  );
}

// Helper for popup menu simulation
Widget buildPopupMenuSimulation(
  String title,
  Color headerColor,
  List<Widget> items,
) {
  return Container(
    margin: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.12),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: headerColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
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
        Divider(height: 1),
        ...items,
        SizedBox(height: 4),
      ],
    ),
  );
}

// Helper for icon-labeled menu item
Widget buildIconMenuItem(
  String text,
  IconData icon,
  bool checked,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 1, horizontal: 4),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: checked ? color.withValues(alpha: 0.05) : Colors.transparent,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: checked
              ? Icon(Icons.check, size: 16, color: color)
              : SizedBox.shrink(),
        ),
        SizedBox(width: 12),
        Icon(icon, size: 18, color: checked ? color : Colors.grey.shade600),
        SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: checked ? color : Colors.black87,
            fontWeight: checked ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}

// Helper for grouped items
Widget buildGroupedPopupItems(
  String groupLabel,
  List<String> items,
  List<bool> checked,
  Color color,
) {
  return Container(
    margin: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Text(
            groupLabel,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...List.generate(items.length, (i) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: checked[i]
                  ? color.withValues(alpha: 0.03)
                  : Colors.transparent,
              border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 18,
                  height: 18,
                  child: checked[i]
                      ? Icon(Icons.check, size: 16, color: color)
                      : SizedBox.shrink(),
                ),
                SizedBox(width: 12),
                Text(
                  items[i],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: checked[i]
                        ? FontWeight.w500
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

// Helper for check animation states
Widget buildCheckAnimationState(String label, double progress, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
    child: Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: color, width: 1.5),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    color: color.withValues(alpha: progress * 0.15),
                  ),
                ),
                if (progress > 0.3)
                  Center(
                    child: Icon(
                      Icons.check,
                      size: 16,
                      color: color.withValues(alpha: progress),
                    ),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12),
        Text(label, style: TextStyle(fontSize: 12)),
        Spacer(),
        Container(
          width: 80,
          height: 6,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(3),
          ),
          child: FractionallySizedBox(
            widthFactor: progress,
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Text(
          '${(progress * 100).toInt()}%',
          style: TextStyle(fontSize: 10, color: Colors.grey),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== CheckedPopupMenuItem Visual Test ===');
  debugPrint(
    'Demonstrating checked popup menu items in various configurations',
  );

  debugPrint('Testing checked vs unchecked states');
  debugPrint('Testing enabled vs disabled states');
  debugPrint('Testing grouped menu items');
  debugPrint('Testing menu item styling');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('CheckedPopupMenuItem Demo'),
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section 1: Basic Checked/Unchecked
            buildSectionHeader('Basic States', Icons.check_circle, Colors.teal),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'CheckedPopupMenuItem displays a check mark when selected in popup menus',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            buildPopupMenuSimulation('View Options', Colors.teal, [
              buildPopupItemVisual(
                'Show Grid',
                true,
                true,
                Colors.teal,
                Colors.black87,
                Colors.white,
              ),
              buildPopupItemVisual(
                'Show List',
                false,
                true,
                Colors.teal,
                Colors.black87,
                Colors.white,
              ),
              buildPopupItemVisual(
                'Show Details',
                true,
                true,
                Colors.teal,
                Colors.black87,
                Colors.white,
              ),
              buildPopupItemVisual(
                'Show Preview',
                false,
                true,
                Colors.teal,
                Colors.black87,
                Colors.white,
              ),
            ]),

            // Section 2: Enabled / Disabled
            buildSectionHeader(
              'Enabled / Disabled',
              Icons.toggle_on,
              Colors.orange,
            ),
            buildPopupMenuSimulation('Feature Flags', Colors.orange, [
              buildPopupItemVisual(
                'Feature A (available)',
                true,
                true,
                Colors.orange,
                Colors.black87,
                Colors.white,
              ),
              buildPopupItemVisual(
                'Feature B (available)',
                false,
                true,
                Colors.orange,
                Colors.black87,
                Colors.white,
              ),
              buildPopupItemVisual(
                'Feature C (locked)',
                true,
                false,
                Colors.grey,
                Colors.grey.shade400,
                Colors.grey.shade50,
              ),
              buildPopupItemVisual(
                'Feature D (locked)',
                false,
                false,
                Colors.grey,
                Colors.grey.shade400,
                Colors.grey.shade50,
              ),
            ]),

            // Section 3: Color Variations
            buildSectionHeader(
              'Color Variations',
              Icons.palette,
              Colors.purple,
            ),
            buildPopupMenuSimulation('Blue Check', Colors.blue, [
              buildPopupItemVisual(
                'Blue checked item',
                true,
                true,
                Colors.blue,
                Colors.black87,
                Colors.white,
              ),
              buildPopupItemVisual(
                'Blue unchecked item',
                false,
                true,
                Colors.blue,
                Colors.black87,
                Colors.white,
              ),
            ]),
            buildPopupMenuSimulation('Red Check', Colors.red, [
              buildPopupItemVisual(
                'Red checked item',
                true,
                true,
                Colors.red,
                Colors.black87,
                Colors.white,
              ),
              buildPopupItemVisual(
                'Red unchecked item',
                false,
                true,
                Colors.red,
                Colors.black87,
                Colors.white,
              ),
            ]),
            buildPopupMenuSimulation('Green Check', Colors.green, [
              buildPopupItemVisual(
                'Green checked item',
                true,
                true,
                Colors.green,
                Colors.black87,
                Colors.white,
              ),
              buildPopupItemVisual(
                'Green unchecked item',
                false,
                true,
                Colors.green,
                Colors.black87,
                Colors.white,
              ),
            ]),
            buildPopupMenuSimulation('Purple Check', Colors.purple, [
              buildPopupItemVisual(
                'Purple checked item',
                true,
                true,
                Colors.purple,
                Colors.black87,
                Colors.white,
              ),
              buildPopupItemVisual(
                'Purple unchecked item',
                false,
                true,
                Colors.purple,
                Colors.black87,
                Colors.white,
              ),
            ]),

            // Section 4: With Icons
            buildSectionHeader(
              'Menu Items with Icons',
              Icons.menu,
              Colors.blue,
            ),
            buildPopupMenuSimulation('Sort Options', Colors.blue, [
              buildIconMenuItem(
                'Sort by Name',
                Icons.sort_by_alpha,
                true,
                Colors.blue,
              ),
              buildIconMenuItem(
                'Sort by Date',
                Icons.calendar_today,
                false,
                Colors.blue,
              ),
              buildIconMenuItem(
                'Sort by Size',
                Icons.data_usage,
                false,
                Colors.blue,
              ),
              buildIconMenuItem(
                'Sort by Type',
                Icons.category,
                false,
                Colors.blue,
              ),
            ]),
            buildPopupMenuSimulation('Display Options', Colors.green, [
              buildIconMenuItem(
                'Compact View',
                Icons.view_compact,
                true,
                Colors.green,
              ),
              buildIconMenuItem(
                'Comfortable',
                Icons.view_comfortable,
                false,
                Colors.green,
              ),
              buildIconMenuItem(
                'Spacious',
                Icons.view_agenda,
                false,
                Colors.green,
              ),
            ]),

            // Section 5: Grouped Items
            buildSectionHeader('Grouped Menu Items', Icons.list, Colors.indigo),
            buildGroupedPopupItems(
              'Text Size',
              ['Small', 'Medium', 'Large', 'Extra Large'],
              [false, true, false, false],
              Colors.indigo,
            ),
            SizedBox(height: 4),
            buildGroupedPopupItems(
              'Language',
              ['English', 'German', 'French', 'Spanish'],
              [true, false, false, false],
              Colors.teal,
            ),
            SizedBox(height: 4),
            buildGroupedPopupItems(
              'Columns',
              ['1 Column', '2 Columns', '3 Columns'],
              [false, true, false],
              Colors.orange,
            ),

            // Section 6: Check Animation States
            buildSectionHeader(
              'Check Animation',
              Icons.animation,
              Colors.deepPurple,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Visual representation of the check mark appearing',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            buildCheckAnimationState('Hidden', 0.0, Colors.blue),
            buildCheckAnimationState('Appearing (30%)', 0.3, Colors.blue),
            buildCheckAnimationState('Growing (50%)', 0.5, Colors.blue),
            buildCheckAnimationState('Almost (80%)', 0.8, Colors.blue),
            buildCheckAnimationState('Complete (100%)', 1.0, Colors.blue),

            SizedBox(height: 8),
            buildCheckAnimationState('Red Hidden', 0.0, Colors.red),
            buildCheckAnimationState('Red Appearing', 0.4, Colors.red),
            buildCheckAnimationState('Red Complete', 1.0, Colors.red),

            // Section 7: Real-World Use Cases
            buildSectionHeader('Real-World Examples', Icons.apps, Colors.brown),

            // Filter menu example
            buildPopupMenuSimulation('Filter by Status', Colors.brown, [
              buildIconMenuItem('Active', Icons.play_arrow, true, Colors.green),
              buildIconMenuItem('Paused', Icons.pause, true, Colors.orange),
              buildIconMenuItem(
                'Completed',
                Icons.done_all,
                false,
                Colors.blue,
              ),
              buildIconMenuItem('Cancelled', Icons.cancel, false, Colors.red),
            ]),

            // Notification settings
            buildPopupMenuSimulation('Notification Channels', Colors.purple, [
              buildPopupItemVisual(
                'Email notifications',
                true,
                true,
                Colors.purple,
                Colors.black87,
                Colors.white,
              ),
              buildPopupItemVisual(
                'Push notifications',
                true,
                true,
                Colors.purple,
                Colors.black87,
                Colors.white,
              ),
              buildPopupItemVisual(
                'SMS notifications',
                false,
                true,
                Colors.purple,
                Colors.black87,
                Colors.white,
              ),
              buildPopupItemVisual(
                'In-app banners',
                true,
                true,
                Colors.purple,
                Colors.black87,
                Colors.white,
              ),
              buildPopupItemVisual(
                'Weekly digest',
                false,
                false,
                Colors.grey,
                Colors.grey.shade400,
                Colors.grey.shade50,
              ),
            ]),

            // Toolbar visibility
            buildPopupMenuSimulation('Toolbar Visibility', Colors.cyan, [
              buildIconMenuItem(
                'File Bar',
                Icons.insert_drive_file,
                true,
                Colors.cyan,
              ),
              buildIconMenuItem('Edit Bar', Icons.edit, true, Colors.cyan),
              buildIconMenuItem(
                'View Bar',
                Icons.visibility,
                false,
                Colors.cyan,
              ),
              buildIconMenuItem(
                'Format Bar',
                Icons.format_bold,
                true,
                Colors.cyan,
              ),
              buildIconMenuItem('Tools Bar', Icons.build, false, Colors.cyan),
              buildIconMenuItem('Help Bar', Icons.help, true, Colors.cyan),
            ]),

            // Section 8: Popup Menu Layout Comparison
            buildSectionHeader(
              'Layout Comparison',
              Icons.compare,
              Colors.blueGrey,
            ),
            Container(
              margin: EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: buildPopupMenuSimulation('Dense', Colors.blue, [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.check, size: 14, color: Colors.blue),
                            SizedBox(width: 8),
                            Text('Item A', style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 14),
                            SizedBox(width: 8),
                            Text('Item B', style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.check, size: 14, color: Colors.blue),
                            SizedBox(width: 8),
                            Text('Item C', style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: buildPopupMenuSimulation('Normal', Colors.green, [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.check, size: 18, color: Colors.green),
                            SizedBox(width: 12),
                            Text('Item A', style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 18),
                            SizedBox(width: 12),
                            Text('Item B', style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.check, size: 18, color: Colors.green),
                            SizedBox(width: 12),
                            Text('Item C', style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),

            // Summary
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal.shade50, Colors.cyan.shade50],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Features Demonstrated:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      Chip(
                        label: Text('checked', style: TextStyle(fontSize: 10)),
                        backgroundColor: Colors.green.shade100,
                      ),
                      Chip(
                        label: Text('enabled', style: TextStyle(fontSize: 10)),
                        backgroundColor: Colors.orange.shade100,
                      ),
                      Chip(
                        label: Text('colors', style: TextStyle(fontSize: 10)),
                        backgroundColor: Colors.purple.shade100,
                      ),
                      Chip(
                        label: Text('icons', style: TextStyle(fontSize: 10)),
                        backgroundColor: Colors.blue.shade100,
                      ),
                      Chip(
                        label: Text('groups', style: TextStyle(fontSize: 10)),
                        backgroundColor: Colors.indigo.shade100,
                      ),
                      Chip(
                        label: Text(
                          'animation',
                          style: TextStyle(fontSize: 10),
                        ),
                        backgroundColor: Colors.deepPurple.shade100,
                      ),
                      Chip(
                        label: Text('layout', style: TextStyle(fontSize: 10)),
                        backgroundColor: Colors.blueGrey.shade100,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    ),
  );
}
