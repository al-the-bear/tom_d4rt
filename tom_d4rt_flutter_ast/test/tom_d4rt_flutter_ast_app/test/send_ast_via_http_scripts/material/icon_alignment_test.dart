// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests IconAlignment from material
// Deep Demo: Visual demonstration of icon alignment in buttons and input fields
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IconAlignment Deep Demo executing');

  // ============================================================
  // SECTION 1: IconAlignment Overview
  // ============================================================
  print('=== Section 1: IconAlignment Overview ===');

  // Demonstrate all enum values
  final alignments = [
    IconAlignment.start,
    IconAlignment.end,
  ];

  print('IconAlignment.start: ${IconAlignment.start}');
  print('IconAlignment.end: ${IconAlignment.end}');
  print('Total enum values: ${alignments.length}');

  // Enum index values
  for (final alignment in alignments) {
    print('${alignment.name}: index=${alignment.index}');
  }

  final overviewCards = <Widget>[];
  final alignmentDescriptions = {
    IconAlignment.start: {
      'title': 'Start',
      'description': 'Icon appears at the start of the button (leading edge). For LTR, this means left side.',
      'icon': Icons.format_align_left,
      'color': Colors.blue,
      'position': 'Leading',
    },
    IconAlignment.end: {
      'title': 'End',
      'description': 'Icon appears at the end of the button (trailing edge). For LTR, this means right side.',
      'icon': Icons.format_align_right,
      'color': Colors.green,
      'position': 'Trailing',
    },
  };

  for (final alignment in alignments) {
    final data = alignmentDescriptions[alignment]!;
    final color = data['color'] as Color;

    overviewCards.add(
      Container(
        width: 320.0,
        margin: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withValues(alpha: 0.15), color.withValues(alpha: 0.05)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: color.withValues(alpha: 0.5), width: 2.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.25),
              blurRadius: 12.0,
              offset: Offset(0.0, 6.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  topRight: Radius.circular(18.0),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.3),
                          blurRadius: 8.0,
                        ),
                      ],
                    ),
                    child: Icon(data['icon'] as IconData, color: color, size: 28.0),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'IconAlignment.${alignment.name}',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            '${data['position']} Position',
                            style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.w600,
                              color: color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['description'] as String,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Visual demonstration
                  Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: alignment == IconAlignment.start
                          ? [
                              Icon(Icons.star, color: color, size: 20.0),
                              SizedBox(width: 8.0),
                              Text('Button Label', style: TextStyle(fontWeight: FontWeight.w500)),
                            ]
                          : [
                              Text('Button Label', style: TextStyle(fontWeight: FontWeight.w500)),
                              SizedBox(width: 8.0),
                              Icon(Icons.star, color: color, size: 20.0),
                            ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${overviewCards.length} overview cards');

  // ============================================================
  // SECTION 2: ElevatedButton with IconAlignment
  // ============================================================
  print('=== Section 2: ElevatedButton Examples ===');

  final elevatedButtons = <Widget>[];
  final buttonConfigs = [
    {'label': 'Upload File', 'icon': Icons.upload_file, 'color': Colors.blue},
    {'label': 'Download', 'icon': Icons.download, 'color': Colors.green},
    {'label': 'Settings', 'icon': Icons.settings, 'color': Colors.orange},
    {'label': 'Share', 'icon': Icons.share, 'color': Colors.purple},
  ];

  for (final config in buttonConfigs) {
    final label = config['label'] as String;
    final icon = config['icon'] as IconData;
    final color = config['color'] as Color;
    print('ElevatedButton: $label');

    elevatedButtons.add(
      Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.15),
              blurRadius: 8.0,
              offset: Offset(0.0, 2.0),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 12.0),
            // Start alignment
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(icon),
              label: Text(label),
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
                minimumSize: Size(160.0, 44.0),
              ),
              iconAlignment: IconAlignment.start,
            ),
            SizedBox(height: 8.0),
            Text('start', style: TextStyle(fontSize: 10.0, color: Colors.grey)),
            SizedBox(height: 12.0),
            // End alignment
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(icon),
              label: Text(label),
              style: ElevatedButton.styleFrom(
                backgroundColor: color.withValues(alpha: 0.8),
                foregroundColor: Colors.white,
                minimumSize: Size(160.0, 44.0),
              ),
              iconAlignment: IconAlignment.end,
            ),
            SizedBox(height: 8.0),
            Text('end', style: TextStyle(fontSize: 10.0, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
  print('Created ${elevatedButtons.length} elevated button examples');

  // ============================================================
  // SECTION 3: TextButton with IconAlignment
  // ============================================================
  print('=== Section 3: TextButton Examples ===');

  final textButtons = <Widget>[];
  final textButtonConfigs = [
    {'label': 'Learn More', 'icon': Icons.arrow_forward, 'color': Colors.blue},
    {'label': 'View Details', 'icon': Icons.info, 'color': Colors.teal},
    {'label': 'Cancel', 'icon': Icons.close, 'color': Colors.red},
    {'label': 'Retry', 'icon': Icons.refresh, 'color': Colors.orange},
  ];

  for (final config in textButtonConfigs) {
    final label = config['label'] as String;
    final icon = config['icon'] as IconData;
    final color = config['color'] as Color;
    print('TextButton: $label');

    textButtons.add(
      Container(
        width: 180.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            TextButton.icon(
              onPressed: () {},
              icon: Icon(icon, size: 18.0),
              label: Text(label),
              style: TextButton.styleFrom(
                foregroundColor: color,
              ),
              iconAlignment: IconAlignment.start,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'IconAlignment.start',
                style: TextStyle(
                  fontSize: 9.0,
                  fontFamily: 'monospace',
                  color: color,
                ),
              ),
            ),
            SizedBox(height: 12.0),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(icon, size: 18.0),
              label: Text(label),
              style: TextButton.styleFrom(
                foregroundColor: color,
              ),
              iconAlignment: IconAlignment.end,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'IconAlignment.end',
                style: TextStyle(
                  fontSize: 9.0,
                  fontFamily: 'monospace',
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${textButtons.length} text button examples');

  // ============================================================
  // SECTION 4: OutlinedButton with IconAlignment
  // ============================================================
  print('=== Section 4: OutlinedButton Examples ===');

  final outlinedButtons = <Widget>[];
  final outlinedConfigs = [
    {'label': 'Add to Cart', 'icon': Icons.shopping_cart, 'color': Colors.blue},
    {'label': 'Bookmark', 'icon': Icons.bookmark_border, 'color': Colors.amber},
    {'label': 'Print', 'icon': Icons.print, 'color': Colors.grey},
    {'label': 'Export', 'icon': Icons.exit_to_app, 'color': Colors.green},
  ];

  for (final config in outlinedConfigs) {
    final label = config['label'] as String;
    final icon = config['icon'] as IconData;
    final color = config['color'] as Color;
    print('OutlinedButton: $label');

    outlinedButtons.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(icon),
                label: Text(label),
                style: OutlinedButton.styleFrom(
                  foregroundColor: color,
                  side: BorderSide(color: color),
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
                iconAlignment: IconAlignment.start,
              ),
            ),
            SizedBox(width: 8.0),
            Container(
              width: 50.0,
              alignment: Alignment.center,
              child: Text(
                'vs',
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(icon),
                label: Text(label),
                style: OutlinedButton.styleFrom(
                  foregroundColor: color,
                  side: BorderSide(color: color),
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
                iconAlignment: IconAlignment.end,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${outlinedButtons.length} outlined button examples');

  // ============================================================
  // SECTION 5: FilledButton with IconAlignment
  // ============================================================
  print('=== Section 5: FilledButton Examples ===');

  final filledButtons = <Widget>[];
  final filledConfigs = [
    {'label': 'Get Started', 'icon': Icons.rocket_launch, 'color': Colors.deepPurple},
    {'label': 'Subscribe', 'icon': Icons.notifications_active, 'color': Colors.pink},
    {'label': 'Save Changes', 'icon': Icons.save, 'color': Colors.green},
    {'label': 'Continue', 'icon': Icons.arrow_forward_ios, 'color': Colors.blue},
  ];

  for (final config in filledConfigs) {
    final label = config['label'] as String;
    final icon = config['icon'] as IconData;
    final color = config['color'] as Color;
    print('FilledButton: $label');

    filledButtons.add(
      Container(
        width: 220.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withValues(alpha: 0.1), color.withValues(alpha: 0.05)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            // Start alignment
            FilledButton.icon(
              onPressed: () {},
              icon: Icon(icon),
              label: Text(label),
              style: FilledButton.styleFrom(
                backgroundColor: color,
                minimumSize: Size(double.infinity, 44.0),
              ),
              iconAlignment: IconAlignment.start,
            ),
            SizedBox(height: 6.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back, size: 12.0, color: Colors.grey.shade500),
                SizedBox(width: 4.0),
                Text(
                  'Icon at Start',
                  style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            // End alignment
            FilledButton.icon(
              onPressed: () {},
              icon: Icon(icon),
              label: Text(label),
              style: FilledButton.styleFrom(
                backgroundColor: color.withValues(alpha: 0.75),
                minimumSize: Size(double.infinity, 44.0),
              ),
              iconAlignment: IconAlignment.end,
            ),
            SizedBox(height: 6.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Icon at End',
                  style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600),
                ),
                SizedBox(width: 4.0),
                Icon(Icons.arrow_forward, size: 12.0, color: Colors.grey.shade500),
              ],
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${filledButtons.length} filled button examples');

  // ============================================================
  // SECTION 6: Direction-Aware Behavior (RTL/LTR)
  // ============================================================
  print('=== Section 6: Direction-Aware Behavior ===');

  final directionCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.purple.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.language, color: Colors.indigo, size: 28.0),
            SizedBox(width: 12.0),
            Text(
              'Text Direction Awareness',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'IconAlignment respects text directionality. In RTL layouts, '
          'start and end positions are mirrored automatically.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 20.0),
        // LTR Example
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      'LTR (Left-to-Right)',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'English, Spanish, etc.',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey.shade500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.0),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_back),
                            label: Text('Back'),
                            iconAlignment: IconAlignment.start,
                          ),
                          SizedBox(height: 4.0),
                          Text('start = Left', style: TextStyle(fontSize: 10.0, color: Colors.grey)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_forward),
                            label: Text('Next'),
                            iconAlignment: IconAlignment.end,
                          ),
                          SizedBox(height: 4.0),
                          Text('end = Right', style: TextStyle(fontSize: 10.0, color: Colors.grey)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        // RTL Example
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      'RTL (Right-to-Left)',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'Arabic, Hebrew, etc.',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey.shade500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.0),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_forward),
                            label: Text('السابق'),
                            iconAlignment: IconAlignment.start,
                          ),
                          SizedBox(height: 4.0),
                          Text('start = Right', style: TextStyle(fontSize: 10.0, color: Colors.grey)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_back),
                            label: Text('التالي'),
                            iconAlignment: IconAlignment.end,
                          ),
                          SizedBox(height: 4.0),
                          Text('end = Left', style: TextStyle(fontSize: 10.0, color: Colors.grey)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created direction-aware card');

  // ============================================================
  // SECTION 7: Common UI Patterns
  // ============================================================
  print('=== Section 7: Common UI Patterns ===');

  final patternsCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.amber.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.lightbulb, color: Colors.amber.shade700, size: 28.0),
            SizedBox(width: 12.0),
            Text(
              'Common UI Patterns',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        // Navigation pattern
        Container(
          margin: EdgeInsets.only(bottom: 12.0),
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Navigation Buttons',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_back),
                    label: Text('Previous'),
                    iconAlignment: IconAlignment.start,
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward),
                    label: Text('Next'),
                    iconAlignment: IconAlignment.end,
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                'Tip: Back button uses start, forward button uses end',
                style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        // Download/action pattern
        Container(
          margin: EdgeInsets.only(bottom: 12.0),
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Action Buttons',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.download),
                      label: Text('Download'),
                      iconAlignment: IconAlignment.start,
                      style: FilledButton.styleFrom(backgroundColor: Colors.green),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.send),
                      label: Text('Send'),
                      iconAlignment: IconAlignment.end,
                      style: FilledButton.styleFrom(backgroundColor: Colors.blue),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                'Tip: Receiving actions use start, sending actions use end',
                style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        // Dropdown/expand pattern
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dropdown & Expand',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 8.0),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.expand_more),
                  label: Text('Show More Options'),
                  iconAlignment: IconAlignment.end,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Tip: Dropdown indicators typically go at end position',
                style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created patterns card');

  // ============================================================
  // SECTION 8: API Reference Summary
  // ============================================================
  print('=== Section 8: API Reference Summary ===');

  final apiItems = [
    {
      'signature': 'IconAlignment.start',
      'description': 'Positions icon at the start (leading) edge of the button',
      'icon': Icons.first_page,
    },
    {
      'signature': 'IconAlignment.end',
      'description': 'Positions icon at the end (trailing) edge of the button',
      'icon': Icons.last_page,
    },
    {
      'signature': 'IconAlignment.values',
      'description': 'Static list: [IconAlignment.start, IconAlignment.end]',
      'icon': Icons.list,
    },
    {
      'signature': 'alignment.name',
      'description': 'Returns string name: "start" or "end"',
      'icon': Icons.label,
    },
    {
      'signature': 'alignment.index',
      'description': '0 for start, 1 for end',
      'icon': Icons.tag,
    },
    {
      'signature': 'ButtonStyleButton.iconAlignment',
      'description': 'Property found on ElevatedButton, TextButton, OutlinedButton, FilledButton',
      'icon': Icons.smart_button,
    },
  ];

  final apiCards = <Widget>[];
  for (final api in apiItems) {
    apiCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.teal.shade100),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                api['icon'] as IconData,
                color: Colors.teal.shade600,
                size: 20.0,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    api['signature'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade800,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    api['description'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final apiSummaryCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.teal.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.api, color: Colors.teal.shade700, size: 28.0),
            SizedBox(width: 12.0),
            Text(
              'API Reference',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        ...apiCards,
      ],
    ),
  );
  print('Created API summary card');

  // ============================================================
  // Final Layout Assembly
  // ============================================================
  print('IconAlignment Deep Demo completed successfully');

  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        // Header
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.green],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.format_align_left, size: 36.0, color: Colors.white),
                  SizedBox(width: 16.0),
                  Icon(Icons.smart_button, size: 48.0, color: Colors.white),
                  SizedBox(width: 16.0),
                  Icon(Icons.format_align_right, size: 36.0, color: Colors.white),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'IconAlignment Deep Demo',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black38, blurRadius: 4.0)],
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Control icon position in Material Design buttons',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),

        // Section 1: Overview
        SizedBox(height: 24.0),
        _buildSectionHeader('Section 1: Enum Overview', Icons.info_outline),
        Wrap(
          alignment: WrapAlignment.center,
          children: overviewCards,
        ),

        // Section 2: ElevatedButton
        SizedBox(height: 32.0),
        _buildSectionHeader('Section 2: ElevatedButton', Icons.upload),
        Wrap(
          alignment: WrapAlignment.center,
          children: elevatedButtons,
        ),

        // Section 3: TextButton
        SizedBox(height: 32.0),
        _buildSectionHeader('Section 3: TextButton', Icons.text_fields),
        Wrap(
          alignment: WrapAlignment.center,
          children: textButtons,
        ),

        // Section 4: OutlinedButton
        SizedBox(height: 32.0),
        _buildSectionHeader('Section 4: OutlinedButton', Icons.crop_square),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(children: outlinedButtons),
        ),

        // Section 5: FilledButton
        SizedBox(height: 32.0),
        _buildSectionHeader('Section 5: FilledButton', Icons.rectangle),
        Wrap(
          alignment: WrapAlignment.center,
          children: filledButtons,
        ),

        // Section 6: Direction-Aware
        SizedBox(height: 32.0),
        _buildSectionHeader('Section 6: RTL/LTR Support', Icons.language),
        directionCard,

        // Section 7: Patterns
        SizedBox(height: 32.0),
        _buildSectionHeader('Section 7: Common Patterns', Icons.lightbulb),
        patternsCard,

        // Section 8: API Reference
        SizedBox(height: 32.0),
        _buildSectionHeader('Section 8: API Reference', Icons.api),
        apiSummaryCard,

        SizedBox(height: 32.0),
      ],
    ),
  );
}

// Helper: Build section header
Widget _buildSectionHeader(String title, IconData icon) {
  print('Section: $title');
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      children: [
        Icon(icon, color: Colors.grey.shade700),
        SizedBox(width: 8.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    ),
  );
}
