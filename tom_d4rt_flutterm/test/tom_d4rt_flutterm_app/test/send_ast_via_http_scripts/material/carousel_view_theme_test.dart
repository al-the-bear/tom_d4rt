// D4rt test script: Tests CarouselViewTheme from material
import 'package:flutter/material.dart';

// Helper for section header
Widget buildSectionHeader(String title, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.fromLTRB(8, 16, 8, 8),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color, color.withValues(alpha: 0.7)],
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        SizedBox(width: 8),
        Text(title, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

// Helper for themed carousel item
Widget buildThemedItem(int index, Color bgColor, Color textColor, double radius) {
  return Container(
    width: 120,
    margin: EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(radius),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.view_carousel, color: textColor, size: 22),
          SizedBox(height: 4),
          Text('Item ${index + 1}', style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
}

// Helper for theme inheritance level card
Widget buildInheritanceLevelCard(String level, String description, Color color, IconData icon) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border(left: BorderSide(color: color, width: 4)),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 22),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(level, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: color)),
              Text(description, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper for nested theme visual
Widget buildNestedThemeVisual(String outerLabel, Color outerColor, String innerLabel, Color innerColor) {
  return Container(
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: outerColor.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: outerColor, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.layers_outlined, color: outerColor, size: 18),
            SizedBox(width: 6),
            Text(outerLabel, style: TextStyle(color: outerColor, fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 70,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (ctx, i) {
              return buildThemedItem(i, outerColor.withValues(alpha: 0.15), outerColor, 8);
            },
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: innerColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: innerColor, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.layers, color: innerColor, size: 18),
                  SizedBox(width: 6),
                  Text(innerLabel, style: TextStyle(color: innerColor, fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              ),
              SizedBox(height: 6),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (ctx, i) {
                    return buildThemedItem(i, innerColor.withValues(alpha: 0.2), innerColor, 12);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper for theme property comparison row
Widget buildPropertyComparisonRow(String property, String defaultVal, String themeVal, String localVal) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      children: [
        Expanded(flex: 3, child: Text(property, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
        Expanded(flex: 2, child: Text(defaultVal, style: TextStyle(fontSize: 10, color: Colors.grey))),
        Expanded(flex: 2, child: Text(themeVal, style: TextStyle(fontSize: 10, color: Colors.blue))),
        Expanded(flex: 2, child: Text(localVal, style: TextStyle(fontSize: 10, color: Colors.orange))),
      ],
    ),
  );
}

// Helper for theme scope badge
Widget buildScopeBadge(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    margin: EdgeInsets.symmetric(horizontal: 3),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== CarouselViewTheme Visual Test ===');
  debugPrint('Demonstrating theme inheritance and nested themes for CarouselView');

  debugPrint('Testing theme scoping and inheritance');
  debugPrint('Testing nested theme overrides');
  debugPrint('Testing default theme fallbacks');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('CarouselView Theme Demo'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section 1: Theme Inheritance Concept
            buildSectionHeader('Theme Inheritance', Icons.account_tree, Colors.indigo),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'CarouselViewTheme wraps a subtree with carousel styling. Inner themes override outer themes.',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            buildInheritanceLevelCard('MaterialApp Theme', 'App-wide default for all carousels', Colors.blue, Icons.apps),
            buildInheritanceLevelCard('CarouselViewTheme', 'Scoped override for a widget subtree', Colors.green, Icons.layers),
            buildInheritanceLevelCard('Widget Properties', 'Direct properties on CarouselView widget', Colors.orange, Icons.settings),

            // Section 2: Nested Themes
            buildSectionHeader('Nested Themes', Icons.layers, Colors.teal),
            buildNestedThemeVisual('Outer Theme (Blue)', Colors.blue, 'Inner Theme (Purple)', Colors.purple),
            SizedBox(height: 6),
            buildNestedThemeVisual('Outer Theme (Green)', Colors.green, 'Inner Theme (Orange)', Colors.orange),
            SizedBox(height: 6),
            buildNestedThemeVisual('Outer Theme (Indigo)', Colors.indigo, 'Inner Theme (Red)', Colors.red),

            // Section 3: Theme Scoping Visualization
            buildSectionHeader('Theme Scoping', Icons.crop_free, Colors.purple),
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Widget Tree Scoping', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  SizedBox(height: 8),
                  // Simulated widget tree
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            buildScopeBadge('MaterialApp', Colors.blue),
                            Text(' (blue theme)', style: TextStyle(fontSize: 10, color: Colors.grey)),
                          ],
                        ),
                        SizedBox(height: 4),
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.green.shade200),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    buildScopeBadge('CarouselViewTheme', Colors.green),
                                    Text(' (green override)', style: TextStyle(fontSize: 10, color: Colors.grey)),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: SizedBox(
                                    height: 50,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 4,
                                      itemBuilder: (ctx, i) {
                                        return Container(
                                          width: 70,
                                          margin: EdgeInsets.symmetric(horizontal: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade200,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Center(child: Text('G${i + 1}', style: TextStyle(fontSize: 11, color: Colors.green.shade800))),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 6),
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.orange.shade200),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    buildScopeBadge('CarouselViewTheme', Colors.orange),
                                    Text(' (orange override)', style: TextStyle(fontSize: 10, color: Colors.grey)),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: SizedBox(
                                    height: 50,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 4,
                                      itemBuilder: (ctx, i) {
                                        return Container(
                                          width: 70,
                                          margin: EdgeInsets.symmetric(horizontal: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.orange.shade200,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Center(child: Text('O${i + 1}', style: TextStyle(fontSize: 11, color: Colors.orange.shade800))),
                                        );
                                      },
                                    ),
                                  ),
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
            ),

            // Section 4: Property Resolution Table
            buildSectionHeader('Property Resolution', Icons.table_chart, Colors.brown),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Expanded(flex: 3, child: Text('Property', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                  Expanded(flex: 2, child: Text('Default', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey))),
                  Expanded(flex: 2, child: Text('Theme', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blue))),
                  Expanded(flex: 2, child: Text('Local', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.orange))),
                ],
              ),
            ),
            buildPropertyComparisonRow('backgroundColor', 'surface', 'blue.100', 'red.200'),
            buildPropertyComparisonRow('elevation', '0', '4', '8'),
            buildPropertyComparisonRow('shape', 'rect', 'rounded(12)', 'rounded(20)'),
            buildPropertyComparisonRow('itemExtent', '100', '140', '200'),
            buildPropertyComparisonRow('overlayColor', 'primary/12', 'blue/20', 'red/30'),
            buildPropertyComparisonRow('shrinkExtent', '0', '60', '80'),

            // Section 5: Different Theme Styles
            buildSectionHeader('Distinct Theme Styles', Icons.style, Colors.deepOrange),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Each carousel uses a different theme configuration applied through CarouselViewTheme',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),

            // Minimal theme
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Minimal Theme', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  Text('Low elevation, subtle colors, no decoration', style: TextStyle(fontSize: 11, color: Colors.grey)),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (ctx, i) {
                        return Container(
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(child: Text('Slide ${i + 1}', style: TextStyle(fontSize: 11, color: Colors.grey.shade700))),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Elevated theme
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Elevated Theme', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  Text('High elevation with strong shadows', style: TextStyle(fontSize: 11, color: Colors.grey)),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (ctx, i) {
                        return Container(
                          width: 110,
                          margin: EdgeInsets.symmetric(horizontal: 6),
                          child: Material(
                            elevation: 8,
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue.shade400,
                            child: Center(child: Text('Card ${i + 1}', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold))),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Rounded pill theme
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Rounded Pill Theme', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  Text('Fully rounded items creating pill-shaped cards', style: TextStyle(fontSize: 11, color: Colors.grey)),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (ctx, i) {
                        return Container(
                          width: 120,
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            color: Colors.pink.shade200.withValues(alpha: 0.6 + (i % 3) * 0.13),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(child: Text('Pill ${i + 1}', style: TextStyle(fontSize: 11, color: Colors.pink.shade900, fontWeight: FontWeight.bold))),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Dark glass theme
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dark Glass Theme', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white)),
                  Text('Semi-transparent overlays on dark background', style: TextStyle(fontSize: 11, color: Colors.grey.shade400)),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (ctx, i) {
                        return Container(
                          width: 110,
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08 + (i % 3) * 0.04),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.auto_awesome, color: Colors.white.withValues(alpha: 0.7), size: 20),
                                Text('Glass ${i + 1}', style: TextStyle(fontSize: 11, color: Colors.white.withValues(alpha: 0.8))),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Section 6: Theme Data Copy With
            buildSectionHeader('copyWith Pattern', Icons.copy, Colors.cyan),
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.cyan.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Theme modification via copyWith', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.only(right: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            children: [
                              Text('Original', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.blue)),
                              SizedBox(height: 4),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade200,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(child: Text('Blue', style: TextStyle(fontSize: 10, color: Colors.white))),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_forward, size: 16),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            children: [
                              Text('copyWith(bg)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.green)),
                              SizedBox(height: 4),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.green.shade200,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(child: Text('Green', style: TextStyle(fontSize: 10, color: Colors.white))),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_forward, size: 16),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.only(left: 4),
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            children: [
                              Text('copyWith(all)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.red)),
                              SizedBox(height: 4),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.red.shade200,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(child: Text('Red+Round', style: TextStyle(fontSize: 10, color: Colors.white))),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
                  colors: [Colors.indigo.shade50, Colors.purple.shade50],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Theme Features Demonstrated:', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      Chip(label: Text('Inheritance', style: TextStyle(fontSize: 10)), backgroundColor: Colors.blue.shade100),
                      Chip(label: Text('Nesting', style: TextStyle(fontSize: 10)), backgroundColor: Colors.teal.shade100),
                      Chip(label: Text('Scoping', style: TextStyle(fontSize: 10)), backgroundColor: Colors.purple.shade100),
                      Chip(label: Text('Resolution', style: TextStyle(fontSize: 10)), backgroundColor: Colors.brown.shade100),
                      Chip(label: Text('Distinct Styles', style: TextStyle(fontSize: 10)), backgroundColor: Colors.orange.shade100),
                      Chip(label: Text('copyWith', style: TextStyle(fontSize: 10)), backgroundColor: Colors.cyan.shade100),
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
