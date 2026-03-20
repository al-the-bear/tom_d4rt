// D4rt test script: Tests CardTheme / CardThemeData from material
import 'package:flutter/material.dart';

// Helper to build section title
Widget buildSectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.only(top: 24, bottom: 8, left: 16, right: 16),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.cyan.shade800,
      ),
    ),
  );
}

// Helper to build description
Widget buildDescription(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13,
        color: Colors.grey.shade600,
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}

// Helper to build info box
Widget buildInfoBox(String text, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(70)),
    ),
    child: Row(
      children: [
        Icon(Icons.info_outline, color: color, size: 18),
        SizedBox(width: 8),
        Expanded(
          child: Text(text, style: TextStyle(fontSize: 12, color: color)),
        ),
      ],
    ),
  );
}

// Helper: themed card demo
Widget buildCardDemo({
  required String title,
  required String description,
  required CardThemeData themeData,
  Widget? cardContent,
}) {
  Widget content = cardContent ?? Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Card Title', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        SizedBox(height: 4),
        Text(
          'This is sample content inside the card to show how the theme applies.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
      ],
    ),
  );

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 4),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.cyan.shade700,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),
        ),
        CardTheme(
          data: themeData,
          child: Card(child: content),
        ),
      ],
    ),
  );
}

// Helper: property chip
Widget buildPropertyChip(String label, String value) {
  return Container(
    margin: EdgeInsets.only(right: 6, bottom: 6),
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.cyan.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.cyan.shade200),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: TextStyle(fontSize: 10, color: Colors.cyan.shade400)),
        SizedBox(width: 4),
        Text(value, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.cyan.shade700)),
      ],
    ),
  );
}

// Helper: comparison card
Widget buildComparisonCard({
  required String leftTitle,
  required String rightTitle,
  required CardThemeData leftTheme,
  required CardThemeData rightTheme,
}) {
  Widget cardContent = Padding(
    padding: EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sample Card', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        SizedBox(height: 4),
        Text('Content inside card', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
      ],
    ),
  );

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(leftTitle, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.cyan.shade700)),
              SizedBox(height: 4),
              CardTheme(
                data: leftTheme,
                child: Card(child: cardContent),
              ),
            ],
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(rightTitle, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.orange.shade700)),
              SizedBox(height: 4),
              CardTheme(
                data: rightTheme,
                child: Card(child: cardContent),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper: color swatch
Widget buildColorSwatch(String label, Color color) {
  return Container(
    margin: EdgeInsets.only(right: 8, bottom: 8),
    child: Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1)),
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 9, color: Colors.grey.shade700)),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== CardThemeData Deep Demo ===');
  debugPrint('Demonstrating Card themes: elevation, color, shape, margin configurations');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan.shade700, Colors.cyan.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CardThemeData Demo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Card elevation, color, shape, margin, and clipBehavior themes',
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
            ],
          ),
        ),

        // Section 1: Elevation Variations
        buildSectionTitle('1. Elevation Variations'),
        buildDescription('CardThemeData with different elevation values'),

        buildCardDemo(
          title: 'Elevation: 0 (Flat)',
          description: 'No shadow at all',
          themeData: CardThemeData(elevation: 0),
        ),
        buildCardDemo(
          title: 'Elevation: 1 (Subtle)',
          description: 'Very subtle shadow',
          themeData: CardThemeData(elevation: 1),
        ),
        buildCardDemo(
          title: 'Elevation: 4 (Default)',
          description: 'Standard material elevation',
          themeData: CardThemeData(elevation: 4),
        ),
        buildCardDemo(
          title: 'Elevation: 8 (Raised)',
          description: 'More prominent shadow',
          themeData: CardThemeData(elevation: 8),
        ),
        buildCardDemo(
          title: 'Elevation: 16 (High)',
          description: 'Very prominent elevation',
          themeData: CardThemeData(elevation: 16),
        ),
        buildCardDemo(
          title: 'Elevation: 24 (Maximum)',
          description: 'Maximum material elevation',
          themeData: CardThemeData(elevation: 24),
        ),

        // Section 2: Color Variations
        buildSectionTitle('2. Color Variations'),
        buildDescription('CardThemeData with different card background colors'),

        buildCardDemo(
          title: 'White (Default)',
          description: 'Standard white card',
          themeData: CardThemeData(color: Colors.white),
        ),
        buildCardDemo(
          title: 'Light Blue',
          description: 'Soft blue tinted card',
          themeData: CardThemeData(color: Colors.blue.shade50),
        ),
        buildCardDemo(
          title: 'Light Green',
          description: 'Fresh green-tinted card',
          themeData: CardThemeData(color: Colors.green.shade50),
        ),
        buildCardDemo(
          title: 'Light Orange',
          description: 'Warm orange-tinted card',
          themeData: CardThemeData(color: Colors.orange.shade50),
        ),
        buildCardDemo(
          title: 'Dark Card',
          description: 'Dark background card for contrast',
          themeData: CardThemeData(
            color: Colors.grey.shade900,
            shadowColor: Colors.black54,
            elevation: 6,
          ),
          cardContent: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dark Card', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                SizedBox(height: 4),
                Text('Content with light text on dark background.', style: TextStyle(fontSize: 13, color: Colors.grey.shade400)),
              ],
            ),
          ),
        ),

        // Color palette display
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Card Color Palette', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              SizedBox(height: 12),
              Wrap(
                children: [
                  buildColorSwatch('White', Colors.white),
                  buildColorSwatch('Blue.50', Colors.blue.shade50),
                  buildColorSwatch('Green.50', Colors.green.shade50),
                  buildColorSwatch('Orange.50', Colors.orange.shade50),
                  buildColorSwatch('Purple.50', Colors.purple.shade50),
                  buildColorSwatch('Grey.900', Colors.grey.shade900),
                ],
              ),
            ],
          ),
        ),

        // Section 3: Shape Variations
        buildSectionTitle('3. Shape Variations'),
        buildDescription('CardThemeData with different border shapes'),

        buildCardDemo(
          title: 'Square Corners',
          description: 'BorderRadius.zero for sharp edges',
          themeData: CardThemeData(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
        ),
        buildCardDemo(
          title: 'Small Radius (4)',
          description: 'Slightly rounded corners',
          themeData: CardThemeData(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
        ),
        buildCardDemo(
          title: 'Medium Radius (12)',
          description: 'Standard rounded corners',
          themeData: CardThemeData(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        buildCardDemo(
          title: 'Large Radius (24)',
          description: 'Very rounded corners',
          themeData: CardThemeData(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          ),
        ),
        buildCardDemo(
          title: 'With Border',
          description: 'Outlined card with visible border',
          themeData: CardThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.cyan.shade300, width: 2),
            ),
            elevation: 0,
          ),
        ),
        buildCardDemo(
          title: 'Stadium Shape',
          description: 'StadiumBorder applied to card',
          themeData: CardThemeData(
            shape: StadiumBorder(),
            elevation: 2,
          ),
        ),
        buildCardDemo(
          title: 'Beveled Rectangle',
          description: 'BeveledRectangleBorder for angled corners',
          themeData: CardThemeData(
            shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),

        // Section 4: Margin Variations
        buildSectionTitle('4. Margin Variations'),
        buildDescription('CardThemeData with different margin values'),

        buildCardDemo(
          title: 'No Margin',
          description: 'margin: EdgeInsets.zero',
          themeData: CardThemeData(margin: EdgeInsets.zero),
        ),
        buildCardDemo(
          title: 'Small Margin (4)',
          description: 'Compact spacing around card',
          themeData: CardThemeData(margin: EdgeInsets.all(4)),
        ),
        buildCardDemo(
          title: 'Default Margin (8)',
          description: 'Standard card margin',
          themeData: CardThemeData(margin: EdgeInsets.all(8)),
        ),
        buildCardDemo(
          title: 'Large Margin (16)',
          description: 'Spacious margin around card',
          themeData: CardThemeData(margin: EdgeInsets.all(16)),
        ),
        buildCardDemo(
          title: 'Asymmetric Margin',
          description: 'Different margins on each side',
          themeData: CardThemeData(
            margin: EdgeInsets.only(left: 32, right: 8, top: 4, bottom: 4),
          ),
        ),

        // Section 5: Shadow Color
        buildSectionTitle('5. Shadow Color'),
        buildDescription('CardThemeData with custom shadow colors'),

        buildCardDemo(
          title: 'Default Shadow',
          description: 'Standard black shadow',
          themeData: CardThemeData(elevation: 8, shadowColor: Colors.black),
        ),
        buildCardDemo(
          title: 'Blue Shadow',
          description: 'Colored blue shadow for branding',
          themeData: CardThemeData(elevation: 8, shadowColor: Colors.blue.shade300),
        ),
        buildCardDemo(
          title: 'Red Shadow',
          description: 'Alert-style red shadow',
          themeData: CardThemeData(elevation: 8, shadowColor: Colors.red.shade300),
        ),
        buildCardDemo(
          title: 'Green Shadow',
          description: 'Success-style green shadow',
          themeData: CardThemeData(elevation: 8, shadowColor: Colors.green.shade300),
        ),
        buildCardDemo(
          title: 'No Shadow (transparent)',
          description: 'Elevation with transparent shadow',
          themeData: CardThemeData(elevation: 8, shadowColor: Colors.transparent),
        ),

        // Section 6: Side-by-Side Comparisons
        buildSectionTitle('6. Side-by-Side Comparisons'),
        buildDescription('Comparing different theme configurations'),

        buildComparisonCard(
          leftTitle: 'Flat (elev. 0)',
          rightTitle: 'Elevated (elev. 8)',
          leftTheme: CardThemeData(elevation: 0, color: Colors.grey.shade100),
          rightTheme: CardThemeData(elevation: 8),
        ),
        buildComparisonCard(
          leftTitle: 'Square',
          rightTitle: 'Rounded (24)',
          leftTheme: CardThemeData(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
          rightTheme: CardThemeData(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          ),
        ),
        buildComparisonCard(
          leftTitle: 'Filled',
          rightTitle: 'Outlined',
          leftTheme: CardThemeData(
            color: Colors.blue.shade50,
            elevation: 2,
          ),
          rightTheme: CardThemeData(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.blue.shade200, width: 1.5),
            ),
          ),
        ),

        // Section 7: Combined Themes
        buildSectionTitle('7. Combined Theme Configurations'),
        buildDescription('Multiple properties combined for real-world card styles'),

        buildCardDemo(
          title: 'Modern Card Style',
          description: 'Rounded, subtle elevation, clean look',
          themeData: CardThemeData(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          ),
          cardContent: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.cyan.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.article, color: Colors.cyan.shade700),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Modern Design', style: TextStyle(fontWeight: FontWeight.w600)),
                      Text('Clean and minimal', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        buildCardDemo(
          title: 'Outlined Card Style',
          description: 'No elevation, visible border, flat design',
          themeData: CardThemeData(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade300),
            ),
            margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          ),
          cardContent: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.eco, color: Colors.green.shade700),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Outlined Style', style: TextStyle(fontWeight: FontWeight.w600)),
                      Text('Flat with border', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        buildCardDemo(
          title: 'Elevated Colorful Card',
          description: 'High elevation with colored background',
          themeData: CardThemeData(
            elevation: 12,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.deepPurple.shade50,
            shadowColor: Colors.deepPurple.shade200,
            margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          ),
          cardContent: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.palette, color: Colors.deepPurple.shade700),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Colorful Card', style: TextStyle(fontWeight: FontWeight.w600)),
                      Text('Elevated with color', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Section 8: Theme via ThemeData
        buildSectionTitle('8. ThemeData Integration'),
        buildDescription('Setting card theme globally via ThemeData.cardTheme'),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Theme(
            data: ThemeData(
              cardTheme: CardThemeData(
                color: Colors.amber.shade50,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.amber.shade200),
                ),
              ),
            ),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Global Theme Card',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'This card inherits from ThemeData.cardTheme',
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Section 9: CardThemeData Properties Summary
        buildSectionTitle('9. CardThemeData Properties'),
        buildDescription('All available properties for customization'),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
            ],
          ),
          child: Wrap(
            children: [
              buildPropertyChip('color', 'Color'),
              buildPropertyChip('shadowColor', 'Color'),
              buildPropertyChip('surfaceTintColor', 'Color'),
              buildPropertyChip('elevation', 'double'),
              buildPropertyChip('shape', 'ShapeBorder'),
              buildPropertyChip('margin', 'EdgeInsets'),
              buildPropertyChip('clipBehavior', 'Clip'),
            ],
          ),
        ),

        // Summary
        buildSectionTitle('10. Summary'),
        buildInfoBox(
          'CardThemeData defines the default appearance for Card widgets: '
          'color, elevation, shape, margin, shadow, and clip behavior.',
          Colors.cyan,
        ),
        buildInfoBox(
          'Apply via CardTheme widget for subtree theming, or globally via '
          'ThemeData.cardTheme for app-wide card styling.',
          Colors.blue,
        ),
        buildInfoBox(
          'Cards support multiple shapes: RoundedRectangleBorder, '
          'StadiumBorder, BeveledRectangleBorder, CircleBorder.',
          Colors.green,
        ),
        buildInfoBox(
          'Combine elevation, shadowColor, and surfaceTintColor for '
          'Material 3 style elevated surfaces.',
          Colors.purple,
        ),

        SizedBox(height: 40),
      ],
    ),
  );
}
