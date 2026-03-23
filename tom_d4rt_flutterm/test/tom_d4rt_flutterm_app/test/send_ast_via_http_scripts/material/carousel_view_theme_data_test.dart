// ignore_for_file: avoid_print
// D4rt test script: Tests CarouselViewThemeData from material
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

// Helper for theme data property display card
Widget buildThemePropertyCard(
  String propertyName,
  String value,
  Color indicatorColor,
  IconData icon,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade200),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 2,
          offset: Offset(0, 1),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: indicatorColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: indicatorColor, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                propertyName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              Text(
                value,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper for a complete theme showcase
Widget buildThemeShowcase(
  String title,
  Color primaryColor,
  Color bgColor,
  Color itemColor,
  Color textColor,
  double elevation,
  double borderRadius,
  double itemExtent,
) {
  return Container(
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: primaryColor.withValues(alpha: 0.3), width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            Spacer(),
            Text(
              'elevation: $elevation',
              style: TextStyle(
                fontSize: 10,
                color: textColor.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 8,
            itemBuilder: (ctx, i) {
              return Container(
                width: itemExtent,
                margin: EdgeInsets.symmetric(horizontal: 3),
                child: Material(
                  elevation: elevation,
                  color: itemColor.withValues(alpha: 0.7 + (i % 3) * 0.1),
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image, color: textColor, size: 20),
                        Text(
                          '${i + 1}',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 6),
        Row(
          children: [
            Text(
              'itemExtent: $itemExtent',
              style: TextStyle(
                fontSize: 10,
                color: textColor.withValues(alpha: 0.5),
              ),
            ),
            SizedBox(width: 12),
            Text(
              'borderRadius: $borderRadius',
              style: TextStyle(
                fontSize: 10,
                color: textColor.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// Helper for elevation comparison strip
Widget buildElevationStrip(String label, Color color, List<double> elevations) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Row(
          children: elevations.map((e) {
            return Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: Material(
                  elevation: e,
                  borderRadius: BorderRadius.circular(8),
                  color: color,
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: Text(
                        'e:${e.toInt()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

// Helper for shape comparison
Widget buildShapeComparison(String label, Color color, double radius) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    child: Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (ctx, i) {
                return Container(
                  width: 80,
                  margin: EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.5 + (i % 3) * 0.15),
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  child: Center(
                    child: Text(
                      'r:${radius.toInt()}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper for color swatch display
Widget buildColorSwatch(String name, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: 8),
        Text(name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        Spacer(),
        Text('Color', style: TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== CarouselViewThemeData Visual Test ===');
  debugPrint('Demonstrating different carousel theme configurations');

  debugPrint('Testing background color configurations');
  debugPrint('Testing item extent values');
  debugPrint('Testing shape decorations');
  debugPrint('Testing elevation values');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('CarouselView Theme Data Demo'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section 1: Theme Data Properties Overview
            buildSectionHeader(
              'Theme Data Properties',
              Icons.palette,
              Colors.deepOrange,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'CarouselViewThemeData controls the visual appearance of carousel items',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            buildThemePropertyCard(
              'backgroundColor',
              'Background color for carousel items',
              Colors.blue,
              Icons.format_color_fill,
            ),
            buildThemePropertyCard(
              'elevation',
              'Shadow depth for carousel items (0-24)',
              Colors.grey,
              Icons.layers,
            ),
            buildThemePropertyCard(
              'shape',
              'Shape decoration (border radius, clips)',
              Colors.green,
              Icons.crop_square,
            ),
            buildThemePropertyCard(
              'overlayColor',
              'Color when user interacts with items',
              Colors.orange,
              Icons.touch_app,
            ),
            buildThemePropertyCard(
              'itemExtent',
              'Width of each carousel item',
              Colors.purple,
              Icons.width_normal,
            ),

            // Section 2: Background Color Themes
            buildSectionHeader(
              'Background Color Themes',
              Icons.color_lens,
              Colors.blue,
            ),
            buildThemeShowcase(
              'Light Theme',
              Colors.blue,
              Colors.blue.shade50,
              Colors.blue.shade100,
              Colors.blue.shade900,
              2,
              12,
              100,
            ),
            buildThemeShowcase(
              'Dark Theme',
              Colors.grey.shade800,
              Colors.grey.shade900,
              Colors.grey.shade700,
              Colors.white,
              4,
              12,
              100,
            ),
            buildThemeShowcase(
              'Warm Theme',
              Colors.orange,
              Colors.orange.shade50,
              Colors.orange.shade200,
              Colors.brown.shade800,
              3,
              12,
              100,
            ),
            buildThemeShowcase(
              'Cool Theme',
              Colors.teal,
              Colors.teal.shade50,
              Colors.teal.shade200,
              Colors.teal.shade900,
              2,
              12,
              100,
            ),
            buildThemeShowcase(
              'Purple Theme',
              Colors.deepPurple,
              Colors.deepPurple.shade50,
              Colors.deepPurple.shade200,
              Colors.deepPurple.shade900,
              3,
              12,
              100,
            ),

            // Section 3: Elevation Comparison
            buildSectionHeader(
              'Elevation Levels',
              Icons.layers,
              Colors.grey.shade700,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Different elevation values create different shadow depths',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            buildElevationStrip('Blue items', Colors.blue, [0, 2, 4, 8, 16]),
            SizedBox(height: 8),
            buildElevationStrip('Green items', Colors.green, [0, 1, 3, 6, 12]),
            SizedBox(height: 8),
            buildElevationStrip('Orange items', Colors.orange, [
              0,
              2,
              6,
              10,
              20,
            ]),
            SizedBox(height: 8),
            buildElevationStrip('Purple items', Colors.purple, [
              0,
              3,
              6,
              9,
              12,
            ]),

            // Section 4: Shape Decoration
            buildSectionHeader(
              'Shape Decoration',
              Icons.crop_square,
              Colors.green,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Border radius affects the shape of carousel items',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            buildShapeComparison('Sharp (0)', Colors.red, 0),
            buildShapeComparison('Subtle (4)', Colors.green, 4),
            buildShapeComparison('Rounded (8)', Colors.blue, 8),
            buildShapeComparison('More (16)', Colors.purple, 16),
            buildShapeComparison('Pill (24)', Colors.orange, 24),
            buildShapeComparison('Circle (40)', Colors.pink, 40),

            // Section 5: Item Extent
            buildSectionHeader(
              'Item Extent Values',
              Icons.straighten,
              Colors.purple,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Item extent controls the width of each carousel item',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            buildThemeShowcase(
              'Small Extent (60px)',
              Colors.red,
              Colors.red.shade50,
              Colors.red.shade200,
              Colors.red.shade900,
              2,
              8,
              60,
            ),
            buildThemeShowcase(
              'Medium Extent (100px)',
              Colors.green,
              Colors.green.shade50,
              Colors.green.shade200,
              Colors.green.shade900,
              2,
              8,
              100,
            ),
            buildThemeShowcase(
              'Large Extent (150px)',
              Colors.blue,
              Colors.blue.shade50,
              Colors.blue.shade200,
              Colors.blue.shade900,
              2,
              8,
              150,
            ),
            buildThemeShowcase(
              'Extra Large (200px)',
              Colors.purple,
              Colors.purple.shade50,
              Colors.purple.shade200,
              Colors.purple.shade900,
              2,
              8,
              200,
            ),

            // Section 6: Combined Theme Configurations
            buildSectionHeader(
              'Combined Themes',
              Icons.auto_awesome,
              Colors.amber.shade800,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Complete theme configurations combining all properties',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),

            // Material Design 3 style
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Material 3 Style',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (ctx, i) {
                        var colors = [
                          Colors.blue,
                          Colors.purple,
                          Colors.teal,
                          Colors.orange,
                          Colors.pink,
                          Colors.indigo,
                        ];
                        return Container(
                          width: 140,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          child: Material(
                            elevation: 1,
                            borderRadius: BorderRadius.circular(16),
                            color: colors[i].withValues(alpha: 0.12),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: colors[i].withValues(alpha: 0.2),
                                ),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.view_carousel,
                                      color: colors[i],
                                      size: 28,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'M3 Item',
                                      style: TextStyle(
                                        color: colors[i],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // iOS style
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'iOS Cupertino Style',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (ctx, i) {
                        return Container(
                          width: 120,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          child: Material(
                            elevation: 0,
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.phone_iphone,
                                      color: Colors.grey.shade700,
                                      size: 28,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'iOS ${i + 1}',
                                      style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Bold / vivid style
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bold Vivid Style',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (ctx, i) {
                        var vivid = [
                          Colors.redAccent,
                          Colors.yellowAccent,
                          Colors.greenAccent,
                          Colors.cyanAccent,
                          Colors.purpleAccent,
                          Colors.orangeAccent,
                        ];
                        return Container(
                          width: 110,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          child: Material(
                            elevation: 6,
                            borderRadius: BorderRadius.circular(20),
                            color: vivid[i],
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.flash_on,
                                    color: Colors.black,
                                    size: 28,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Bold ${i + 1}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Section 7: Color Swatches Used in Themes
            buildSectionHeader(
              'Theme Color Palette',
              Icons.palette,
              Colors.pink,
            ),
            buildColorSwatch('Primary Blue', Colors.blue),
            buildColorSwatch('Deep Purple', Colors.deepPurple),
            buildColorSwatch('Teal', Colors.teal),
            buildColorSwatch('Deep Orange', Colors.deepOrange),
            buildColorSwatch('Pink', Colors.pink),
            buildColorSwatch('Indigo', Colors.indigo),
            buildColorSwatch('Amber', Colors.amber),
            buildColorSwatch('Cyan', Colors.cyan),

            // Section 8: Theme Merge Visualization
            buildSectionHeader(
              'Theme Merging',
              Icons.merge_type,
              Colors.indigo,
            ),
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Theme Priority (lowest to highest):',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Default',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                              Text(
                                'Fallback values',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Theme',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                              Text(
                                'App theme data',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade100,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Local',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                              Text(
                                'Widget overrides',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
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
            ),

            // Summary
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepOrange.shade50, Colors.orange.shade50],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Theme Data Properties Demonstrated:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      Chip(
                        label: Text(
                          'Background Color',
                          style: TextStyle(fontSize: 10),
                        ),
                        backgroundColor: Colors.blue.shade100,
                      ),
                      Chip(
                        label: Text(
                          'Elevation',
                          style: TextStyle(fontSize: 10),
                        ),
                        backgroundColor: Colors.grey.shade200,
                      ),
                      Chip(
                        label: Text('Shape', style: TextStyle(fontSize: 10)),
                        backgroundColor: Colors.green.shade100,
                      ),
                      Chip(
                        label: Text(
                          'Item Extent',
                          style: TextStyle(fontSize: 10),
                        ),
                        backgroundColor: Colors.purple.shade100,
                      ),
                      Chip(
                        label: Text(
                          'Color Themes',
                          style: TextStyle(fontSize: 10),
                        ),
                        backgroundColor: Colors.orange.shade100,
                      ),
                      Chip(
                        label: Text(
                          'Theme Merge',
                          style: TextStyle(fontSize: 10),
                        ),
                        backgroundColor: Colors.indigo.shade100,
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
