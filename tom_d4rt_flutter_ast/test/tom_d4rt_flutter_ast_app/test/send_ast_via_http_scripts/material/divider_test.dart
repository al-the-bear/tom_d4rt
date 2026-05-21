// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Divider and VerticalDivider widgets from material
// Deep Demo: Visual demonstration of Divider parameters, themes, and real-world usage
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Divider Deep Demo executing');

  // ============================================================
  // SECTION 1: What is a Divider — concept cards
  // ============================================================
  print('=== Section 1: What is a Divider ===');

  final conceptCards = <Widget>[];

  // Concept card 1: Definition
  conceptCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueGrey.shade50, Colors.blue.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.blueGrey.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.horizontal_rule, size: 48.0, color: Colors.blueGrey),
          SizedBox(height: 12.0),
          Text(
            'Divider',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Divider(color: Colors.blueGrey.shade400, thickness: 1.0),
          SizedBox(height: 4.0),
          Text(
            'A thin horizontal line\nthat separates content',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.blueGrey.shade700,
            ),
          ),
        ],
      ),
    ),
  );

  // Concept card 2: height vs thickness
  conceptCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber.shade50, Colors.orange.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.orange.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.straighten, size: 48.0, color: Colors.orange),
          SizedBox(height: 12.0),
          Text(
            'height vs thickness',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'height = total vertical box\nthickness = visible stroke',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.orange.shade800,
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            height: 36.0,
            color: Colors.orange.withValues(alpha: 0.1),
            child: Center(
              child: Divider(color: Colors.orange.shade700, thickness: 4.0),
            ),
          ),
        ],
      ),
    ),
  );

  // Concept card 3: indent
  conceptCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade50, Colors.teal.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.teal.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.format_indent_increase, size: 48.0, color: Colors.teal),
          SizedBox(height: 12.0),
          Text(
            'indent / endIndent',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Inset the line from the\nleading and trailing edges',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.teal.shade800,
            ),
          ),
          SizedBox(height: 8.0),
          Divider(
            color: Colors.teal.shade600,
            thickness: 2.0,
            indent: 24.0,
            endIndent: 24.0,
          ),
        ],
      ),
    ),
  );

  // Concept card 4: Material guideline
  conceptCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade50, Colors.deepPurple.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.deepPurple.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.design_services,
              size: 48.0, color: Colors.deepPurple),
          SizedBox(height: 12.0),
          Text(
            'Material Guideline',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Use sparingly; whitespace\noften separates better',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.deepPurple.shade800,
            ),
          ),
        ],
      ),
    ),
  );

  print('Created ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Thickness gallery
  // ============================================================
  print('=== Section 2: Thickness Gallery ===');

  final thicknessSamples = <Map<String, dynamic>>[
    {'label': 'hairline', 'thickness': 0.5, 'color': Colors.grey.shade400},
    {'label': 'default', 'thickness': 1.0, 'color': Colors.grey.shade600},
    {'label': 'medium', 'thickness': 2.0, 'color': Colors.blueGrey},
    {'label': 'thick', 'thickness': 4.0, 'color': Colors.indigo},
    {'label': 'bold', 'thickness': 6.0, 'color': Colors.deepPurple},
    {'label': 'heavy', 'thickness': 10.0, 'color': Colors.black87},
  ];

  final thicknessWidgets = <Widget>[];
  for (final sample in thicknessSamples) {
    final thickness = sample['thickness'] as double;
    final color = sample['color'] as Color;
    final label = sample['label'] as String;
    print('Divider thickness=$thickness label=$label');

    thicknessWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey.shade200, width: 1.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4.0,
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Text(
                  'thickness: ${thickness.toStringAsFixed(1)}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Divider(thickness: thickness, color: color, height: 16.0),
          ],
        ),
      ),
    );
  }
  print('Created ${thicknessWidgets.length} thickness widgets');

  // ============================================================
  // SECTION 3: Indent / endIndent gallery
  // ============================================================
  print('=== Section 3: Indent Gallery ===');

  final indentSamples = <Map<String, dynamic>>[
    {
      'label': 'no indent',
      'indent': 0.0,
      'endIndent': 0.0,
      'icon': Icons.format_align_justify,
    },
    {
      'label': 'leading indent (32)',
      'indent': 32.0,
      'endIndent': 0.0,
      'icon': Icons.format_indent_increase,
    },
    {
      'label': 'trailing indent (32)',
      'indent': 0.0,
      'endIndent': 32.0,
      'icon': Icons.format_indent_decrease,
    },
    {
      'label': 'symmetric (24/24)',
      'indent': 24.0,
      'endIndent': 24.0,
      'icon': Icons.swap_horiz,
    },
    {
      'label': 'wide symmetric (64/64)',
      'indent': 64.0,
      'endIndent': 64.0,
      'icon': Icons.center_focus_strong,
    },
    {
      'label': 'asymmetric (16/72)',
      'indent': 16.0,
      'endIndent': 72.0,
      'icon': Icons.format_align_left,
    },
  ];

  final indentWidgets = <Widget>[];
  for (int i = 0; i < indentSamples.length; i++) {
    final s = indentSamples[i];
    final indent = s['indent'] as double;
    final endIndent = s['endIndent'] as double;
    final icon = s['icon'] as IconData;
    final label = s['label'] as String;
    print('Divider indent=$indent endIndent=$endIndent label=$label');

    indentWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.lightBlue.shade50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.lightBlue.shade200, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 28.0,
                  height: 28.0,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue.shade900,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Icon(icon, color: Colors.lightBlue.shade700, size: 18.0),
                SizedBox(width: 8.0),
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue.shade900,
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Container(
              color: Colors.white,
              child: Divider(
                thickness: 3.0,
                color: Colors.lightBlue.shade700,
                indent: indent,
                endIndent: endIndent,
                height: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${indentWidgets.length} indent widgets');

  // ============================================================
  // SECTION 4: Coloured & themed dividers (DividerTheme)
  // ============================================================
  print('=== Section 4: Colored & Themed Dividers ===');

  final colorPalette = <Map<String, dynamic>>[
    {'name': 'red', 'color': Colors.red},
    {'name': 'purple', 'color': Colors.purple},
    {'name': 'indigo', 'color': Colors.indigo},
    {'name': 'blue', 'color': Colors.blue},
    {'name': 'teal', 'color': Colors.teal},
    {'name': 'green', 'color': Colors.green},
    {'name': 'orange', 'color': Colors.orange},
    {'name': 'brown', 'color': Colors.brown},
  ];

  final colorWidgets = <Widget>[];
  for (final entry in colorPalette) {
    final color = entry['color'] as Color;
    final name = entry['name'] as String;
    print('Colored divider $name');

    colorWidgets.add(
      Container(
        width: 170.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 14.0,
                  height: 14.0,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
                SizedBox(width: 6.0),
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: color,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.0),
            Divider(color: color, thickness: 2.0, height: 10.0),
            SizedBox(height: 2.0),
            Divider(color: color, thickness: 0.5, height: 6.0),
          ],
        ),
      ),
    );
  }

  // Themed divider demo using DividerTheme / DividerThemeData
  final themedDividerPanel = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.pink.shade50, Colors.red.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.pink.shade200, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.brush, color: Colors.pink.shade700, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'DividerTheme / DividerThemeData',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                color: Colors.pink.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'A DividerTheme overrides defaults for child Dividers '
          'without setting parameters on each one.',
          style: TextStyle(fontSize: 12.0, color: Colors.pink.shade800),
        ),
        SizedBox(height: 12.0),
        DividerTheme(
          data: DividerThemeData(
            color: Colors.pink.shade400,
            thickness: 3.0,
            space: 24.0,
            indent: 16.0,
            endIndent: 16.0,
          ),
          child: Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'These three dividers share one theme:',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey.shade700,
                  ),
                ),
                Divider(),
                Text('Item A'),
                Divider(),
                Text('Item B'),
                Divider(),
                Text('Item C'),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: Colors.pink.shade100),
          ),
          child: Text(
            'DividerThemeData(color: pink, thickness: 3, '
            'space: 24, indent: 16, endIndent: 16)',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: Colors.pink.shade900,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created ${colorWidgets.length} color tiles + 1 themed panel');

  // ============================================================
  // SECTION 5: Real-world Settings list using Dividers
  // ============================================================
  print('=== Section 5: Real-world Settings List ===');

  final settingsItems = <Map<String, dynamic>>[
    {
      'icon': Icons.person,
      'title': 'Profile',
      'subtitle': 'Name, email, phone',
      'color': Colors.blue,
    },
    {
      'icon': Icons.notifications,
      'title': 'Notifications',
      'subtitle': 'Push, email, SMS',
      'color': Colors.orange,
    },
    {
      'icon': Icons.lock,
      'title': 'Privacy & Security',
      'subtitle': 'Password, 2FA, sessions',
      'color': Colors.red,
    },
    {
      'icon': Icons.palette,
      'title': 'Appearance',
      'subtitle': 'Theme, font size',
      'color': Colors.purple,
    },
    {
      'icon': Icons.language,
      'title': 'Language',
      'subtitle': 'English (US)',
      'color': Colors.teal,
    },
    {
      'icon': Icons.help,
      'title': 'Help & Support',
      'subtitle': 'Docs, contact us',
      'color': Colors.green,
    },
    {
      'icon': Icons.info,
      'title': 'About',
      'subtitle': 'Version 1.0.0',
      'color': Colors.blueGrey,
    },
  ];

  final settingsChildren = <Widget>[];
  for (int i = 0; i < settingsItems.length; i++) {
    final item = settingsItems[i];
    final icon = item['icon'] as IconData;
    final title = item['title'] as String;
    final subtitle = item['subtitle'] as String;
    final color = item['color'] as Color;

    settingsChildren.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        child: Row(
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(icon, color: color, size: 22.0),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
      ),
    );

    // Insert a divider between items (not after last)
    if (i < settingsItems.length - 1) {
      settingsChildren.add(
        Divider(
          height: 1.0,
          thickness: 1.0,
          indent: 66.0,
          endIndent: 12.0,
          color: Colors.grey.shade300,
        ),
      );
    }
  }

  final settingsPanel = Container(
    margin: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 10.0,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade400, Colors.indigo.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(14.0)),
          ),
          child: Row(
            children: [
              Icon(Icons.settings, color: Colors.white, size: 24.0),
              SizedBox(width: 10.0),
              Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
        ...settingsChildren,
      ],
    ),
  );
  print('Created settings panel with ${settingsItems.length} rows '
      'separated by Dividers');

  // ============================================================
  // SECTION 6: Recipe steps list — Divider with custom color/thickness
  // ============================================================
  print('=== Section 6: Recipe Steps with Dividers ===');

  final recipeSteps = <Map<String, dynamic>>[
    {
      'n': 1,
      'title': 'Mise en place',
      'desc': 'Chop onions, garlic, and tomatoes.',
      'duration': '5 min',
    },
    {
      'n': 2,
      'title': 'Sauté aromatics',
      'desc': 'Heat olive oil, add onions until translucent.',
      'duration': '7 min',
    },
    {
      'n': 3,
      'title': 'Build the sauce',
      'desc': 'Add tomatoes, simmer, season with salt and herbs.',
      'duration': '20 min',
    },
    {
      'n': 4,
      'title': 'Cook the pasta',
      'desc': 'Boil pasta in salted water until al dente.',
      'duration': '10 min',
    },
    {
      'n': 5,
      'title': 'Combine and plate',
      'desc': 'Toss pasta with sauce, top with basil and cheese.',
      'duration': '3 min',
    },
  ];

  final recipeChildren = <Widget>[];
  for (int i = 0; i < recipeSteps.length; i++) {
    final step = recipeSteps[i];
    final n = step['n'] as int;
    final title = step['title'] as String;
    final desc = step['desc'] as String;
    final duration = step['duration'] as String;

    recipeChildren.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepOrange.shade300, Colors.red.shade400],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepOrange.withValues(alpha: 0.3),
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '$n',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            color: Colors.deepOrange.shade900,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: Colors.deepOrange.shade50,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          duration,
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange.shade800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    desc,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    if (i < recipeSteps.length - 1) {
      recipeChildren.add(
        Divider(
          color: Colors.deepOrange.shade200,
          thickness: 1.5,
          height: 1.0,
          indent: 60.0,
          endIndent: 14.0,
        ),
      );
    }
  }

  final recipePanel = Container(
    margin: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.orange.shade50,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.deepOrange.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange.shade400, Colors.red.shade500],
            ),
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(14.0)),
          ),
          child: Row(
            children: [
              Icon(Icons.restaurant_menu, color: Colors.white, size: 24.0),
              SizedBox(width: 10.0),
              Text(
                'Tomato Pasta Recipe',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
        ...recipeChildren,
      ],
    ),
  );
  print('Created recipe panel with ${recipeSteps.length} steps');

  // ============================================================
  // SECTION 7: VerticalDivider in Row layouts
  // ============================================================
  print('=== Section 7: VerticalDivider in Rows ===');

  final stats = <Map<String, dynamic>>[
    {
      'label': 'Posts',
      'value': '128',
      'icon': Icons.article,
      'color': Colors.blue,
    },
    {
      'label': 'Followers',
      'value': '4.2k',
      'icon': Icons.people,
      'color': Colors.green,
    },
    {
      'label': 'Following',
      'value': '312',
      'icon': Icons.person_add,
      'color': Colors.orange,
    },
    {
      'label': 'Likes',
      'value': '9.7k',
      'icon': Icons.favorite,
      'color': Colors.red,
    },
  ];

  final statTiles = <Widget>[];
  for (int i = 0; i < stats.length; i++) {
    final s = stats[i];
    final color = s['color'] as Color;
    statTiles.add(
      Expanded(
        child: Column(
          children: [
            Icon(s['icon'] as IconData, color: color, size: 22.0),
            SizedBox(height: 6.0),
            Text(
              s['value'] as String,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: color,
              ),
            ),
            SizedBox(height: 2.0),
            Text(
              s['label'] as String,
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
    if (i < stats.length - 1) {
      statTiles.add(
        VerticalDivider(
          color: Colors.grey.shade300,
          thickness: 1.0,
          width: 1.0,
          indent: 6.0,
          endIndent: 6.0,
        ),
      );
    }
  }

  final statsRow = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.symmetric(vertical: 14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade200, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 8.0,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: IntrinsicHeight(child: Row(children: statTiles)),
  );

  // Editor toolbar with VerticalDividers between groups
  final toolbar = Container(
    margin: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.blueGrey.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.blueGrey.shade200, width: 1.0),
    ),
    child: SizedBox(
      height: 56.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: Icon(Icons.format_bold), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.format_italic), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.format_underline), onPressed: () {}),
          VerticalDivider(
            indent: 12.0,
            endIndent: 12.0,
            thickness: 1.5,
            color: Colors.blueGrey.shade300,
          ),
          IconButton(
              icon: Icon(Icons.format_align_left), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.format_align_center), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.format_align_right), onPressed: () {}),
          VerticalDivider(
            indent: 12.0,
            endIndent: 12.0,
            thickness: 1.5,
            color: Colors.blueGrey.shade300,
          ),
          IconButton(
              icon: Icon(Icons.format_list_bulleted), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.format_list_numbered), onPressed: () {}),
        ],
      ),
    ),
  );

  // Two side-by-side panels separated by a styled VerticalDivider
  final sideBySide = Container(
    margin: EdgeInsets.all(12.0),
    height: 140.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo.shade50, Colors.blue.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius:
                  BorderRadius.horizontal(left: Radius.circular(12.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.dashboard, color: Colors.indigo, size: 32.0),
                SizedBox(height: 6.0),
                Text(
                  'Overview',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade900,
                  ),
                ),
                Text(
                  'Top-level metrics',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.indigo.shade700,
                  ),
                ),
              ],
            ),
          ),
        ),
        VerticalDivider(
          color: Colors.indigo.shade300,
          thickness: 3.0,
          width: 3.0,
          indent: 14.0,
          endIndent: 14.0,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple.shade50, Colors.purple.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius:
                  BorderRadius.horizontal(right: Radius.circular(12.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.show_chart,
                    color: Colors.deepPurple, size: 32.0),
                SizedBox(height: 6.0),
                Text(
                  'Trends',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade900,
                  ),
                ),
                Text(
                  'Weekly trajectory',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.deepPurple.shade700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
  print('Created stats row, editor toolbar, and side-by-side panel');

  // ============================================================
  // SECTION 8: Code examples
  // ============================================================
  print('=== Section 8: Code Examples ===');

  final codePanel = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade300, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Divider — Usage Patterns',
              style: TextStyle(
                color: Colors.cyan.shade300,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Default Divider — 16dp tall box, 1dp line\n'
            'Divider();\n'
            '\n'
            '// Explicit thickness and color\n'
            'Divider(\n'
            '  height: 24,\n'
            '  thickness: 2,\n'
            '  color: Colors.blueGrey,\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.green.shade300,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Indented divider — typical for list items\n'
            'Divider(\n'
            '  height: 1,\n'
            '  indent: 64,\n'
            '  endIndent: 16,\n'
            '  color: Colors.grey.shade300,\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.amber.shade300,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// VerticalDivider — needs IntrinsicHeight or fixed height\n'
            'IntrinsicHeight(\n'
            '  child: Row(\n'
            '    children: [\n'
            '      Expanded(child: leftPanel),\n'
            '      VerticalDivider(width: 1, thickness: 1),\n'
            '      Expanded(child: rightPanel),\n'
            '    ],\n'
            '  ),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.purple.shade200,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// DividerTheme — set once, applies to descendants\n'
            'DividerTheme(\n'
            '  data: DividerThemeData(\n'
            '    color: Colors.pink,\n'
            '    thickness: 3,\n'
            '    space: 24,\n'
            '  ),\n'
            '  child: Column(children: [Divider(), Divider()]),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.lightBlueAccent.shade100,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created code examples panel');

  // ============================================================
  // SECTION 9: Summary panel
  // ============================================================
  print('=== Section 9: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade100, Colors.cyan.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Key Takeaways',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        _buildSummaryItem(
          Icons.straighten,
          'height vs thickness',
          'height = layout box; thickness = visible stroke',
          Colors.indigo,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.format_indent_increase,
          'indent / endIndent',
          'Inset the line from leading and trailing edges',
          Colors.teal,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.palette,
          'color',
          'Default is Theme dividerColor; override per Divider',
          Colors.pink,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.brush,
          'DividerTheme',
          'Theme once, apply to many; avoids repetition',
          Colors.deepPurple,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.view_week,
          'VerticalDivider',
          'Needs bounded vertical space (IntrinsicHeight / fixed)',
          Colors.orange,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.lightbulb,
          'Use sparingly',
          'Whitespace often groups content better than a line',
          Colors.amber.shade800,
        ),
      ],
    ),
  );
  print('Created summary panel');

  print('Divider Deep Demo completed successfully');

  // ============================================================
  // Return complete visual layout
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header banner
        Container(
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.blue, Colors.cyan],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18.0),
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withValues(alpha: 0.3),
                blurRadius: 12.0,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(Icons.horizontal_rule,
                  size: 60.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'Divider Widget',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Lines that group and separate content',
                style: TextStyle(fontSize: 14.0, color: Colors.white70),
              ),
              SizedBox(height: 12.0),
              Divider(
                color: Colors.white.withValues(alpha: 0.6),
                thickness: 2.0,
                indent: 40.0,
                endIndent: 40.0,
              ),
              SizedBox(height: 4.0),
              Text(
                'height · thickness · indent · endIndent · color',
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.white70,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),

        // Section 1
        Text(
          '1. What is a Divider?',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: conceptCards),
        SizedBox(height: 28.0),

        // Section 2
        Text(
          '2. Thickness Gallery',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        ...thicknessWidgets,
        SizedBox(height: 28.0),

        // Section 3
        Text(
          '3. Indent / endIndent Gallery',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        ...indentWidgets,
        SizedBox(height: 28.0),

        // Section 4
        Text(
          '4. Colored & Themed Dividers',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: colorWidgets),
        SizedBox(height: 12.0),
        themedDividerPanel,
        SizedBox(height: 28.0),

        // Section 5
        Text(
          '5. Real-world Settings List',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        settingsPanel,
        SizedBox(height: 28.0),

        // Section 6
        Text(
          '6. Recipe Steps Timeline',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        recipePanel,
        SizedBox(height: 28.0),

        // Section 7
        Text(
          '7. VerticalDivider in Row Layouts',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Text(
          'Profile stats (Row + VerticalDivider between cells):',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700),
        ),
        statsRow,
        Text(
          'Editor toolbar (grouped buttons separated by VerticalDivider):',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700),
        ),
        toolbar,
        Text(
          'Side-by-side panels (thick VerticalDivider as accent):',
          style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700),
        ),
        sideBySide,
        SizedBox(height: 28.0),

        // Section 8
        Text(
          '8. Code Examples',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        codePanel,
        SizedBox(height: 28.0),

        // Section 9
        Text(
          '9. Summary',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        summaryPanel,
        SizedBox(height: 24.0),
      ],
    ),
  );
}

// Helper: Build summary item
Widget _buildSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.8),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11.5, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
