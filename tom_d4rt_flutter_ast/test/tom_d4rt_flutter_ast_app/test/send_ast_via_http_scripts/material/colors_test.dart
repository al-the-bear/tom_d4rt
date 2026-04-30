// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Material Colors from material
import 'package:flutter/material.dart';

// Helper to build a section header
Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(top: 20, bottom: 10),
    decoration: BoxDecoration(
      color: Color(0xFF37474F),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFFFFFF),
      ),
    ),
  );
}

// Helper: single color swatch box
Widget buildColorBox(Color color, String label, {bool darkText = false}) {
  return Container(
    width: 70,
    height: 50,
    margin: EdgeInsets.all(2),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: Color(0x33000000), width: 0.5),
    ),
    child: Center(
      child: Text(
        label,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w500,
          color: darkText ? Color(0xFF212121) : Color(0xFFFFFFFF),
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

// Helper: build a full swatch row for a MaterialColor
Widget buildSwatchRow(String name, MaterialColor swatch) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF424242),
          ),
        ),
        SizedBox(height: 4),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              buildColorBox(swatch.shade50, '50', darkText: true),
              buildColorBox(swatch.shade100, '100', darkText: true),
              buildColorBox(swatch.shade200, '200', darkText: true),
              buildColorBox(swatch.shade300, '300'),
              buildColorBox(swatch.shade400, '400'),
              buildColorBox(swatch.shade500, '500'),
              buildColorBox(swatch.shade600, '600'),
              buildColorBox(swatch.shade700, '700'),
              buildColorBox(swatch.shade800, '800'),
              buildColorBox(swatch.shade900, '900'),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper: build accent swatch row
Widget buildAccentRow(String name, MaterialAccentColor accent) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF424242),
          ),
        ),
        SizedBox(height: 4),
        Row(
          children: [
            buildColorBox(accent.shade100, 'A100', darkText: true),
            buildColorBox(accent.shade200, 'A200'),
            buildColorBox(accent.shade400, 'A400'),
            buildColorBox(accent.shade700, 'A700'),
          ],
        ),
      ],
    ),
  );
}

// Helper: color info card
Widget buildColorInfoCard(String name, Color color, String hexValue) {
  bool isDark = ThemeData.estimateBrightnessForColor(color) == Brightness.dark;
  return Container(
    width: 140,
    margin: EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    padding: EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: isDark ? Color(0xFFFFFFFF) : Color(0xFF212121),
          ),
        ),
        SizedBox(height: 4),
        Text(
          hexValue,
          style: TextStyle(
            fontSize: 11,
            color: isDark ? Color(0xB3FFFFFF) : Color(0xB3000000),
          ),
        ),
      ],
    ),
  );
}

// Helper: large color display card
Widget buildLargeColorCard(String name, Color color, String description) {
  bool isDark = ThemeData.estimateBrightnessForColor(color) == Brightness.dark;
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? Color(0xFFFFFFFF) : Color(0xFF212121),
          ),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(
            fontSize: 13,
            color: isDark ? Color(0xCCFFFFFF) : Color(0xCC000000),
          ),
        ),
      ],
    ),
  );
}

// Helper: gradient demonstration
Widget buildGradientCard(String name, List<Color> colors) {
  return Container(
    width: double.infinity,
    height: 60,
    margin: EdgeInsets.symmetric(vertical: 4),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: colors),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Center(
      child: Text(
        name,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(0xFFFFFFFF),
          shadows: [
            Shadow(color: Color(0x80000000), blurRadius: 4),
          ],
        ),
      ),
    ),
  );
}

// Helper: color palette grid
Widget buildColorPaletteGrid(String title, List<Color> colors, List<String> labels) {
  List<Widget> items = [];
  for (int i = 0; i < colors.length && i < labels.length; i++) {
    items.add(buildColorBox(colors[i], labels[i],
        darkText: ThemeData.estimateBrightnessForColor(colors[i]) == Brightness.light));
  }
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF424242),
          ),
        ),
        SizedBox(height: 4),
        Wrap(children: items),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== Material Colors Deep Demo ===');
  debugPrint('Displaying the full Material Design color palette');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('Material Colors Gallery'),
        backgroundColor: Color(0xFF37474F),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Primary Colors
            buildSectionHeader('1. Primary Color Swatches'),
            buildSwatchRow('Red', Colors.red),
            buildSwatchRow('Pink', Colors.pink),
            buildSwatchRow('Purple', Colors.purple),
            buildSwatchRow('Deep Purple', Colors.deepPurple),
            buildSwatchRow('Indigo', Colors.indigo),
            buildSwatchRow('Blue', Colors.blue),
            buildSwatchRow('Light Blue', Colors.lightBlue),
            buildSwatchRow('Cyan', Colors.cyan),
            Text('Section 1: Primary colors (warm + cool) rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 2: More Primary Swatches
            buildSectionHeader('2. More Primary Swatches'),
            buildSwatchRow('Teal', Colors.teal),
            buildSwatchRow('Green', Colors.green),
            buildSwatchRow('Light Green', Colors.lightGreen),
            buildSwatchRow('Lime', Colors.lime),
            buildSwatchRow('Yellow', Colors.yellow),
            buildSwatchRow('Amber', Colors.amber),
            buildSwatchRow('Orange', Colors.orange),
            buildSwatchRow('Deep Orange', Colors.deepOrange),
            Text('Section 2: Primary colors (nature) rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 3: Neutral Swatches
            buildSectionHeader('3. Neutral Swatches'),
            buildSwatchRow('Brown', Colors.brown),
            buildSwatchRow('Grey', Colors.grey),
            buildSwatchRow('Blue Grey', Colors.blueGrey),
            Text('Section 3: Neutral swatches rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 4: Accent Colors
            buildSectionHeader('4. Accent Colors'),
            buildAccentRow('Red Accent', Colors.redAccent),
            buildAccentRow('Pink Accent', Colors.pinkAccent),
            buildAccentRow('Purple Accent', Colors.purpleAccent),
            buildAccentRow('Deep Purple Accent', Colors.deepPurpleAccent),
            buildAccentRow('Indigo Accent', Colors.indigoAccent),
            buildAccentRow('Blue Accent', Colors.blueAccent),
            buildAccentRow('Light Blue Accent', Colors.lightBlueAccent),
            buildAccentRow('Cyan Accent', Colors.cyanAccent),
            buildAccentRow('Teal Accent', Colors.tealAccent),
            buildAccentRow('Green Accent', Colors.greenAccent),
            buildAccentRow('Light Green Accent', Colors.lightGreenAccent),
            buildAccentRow('Lime Accent', Colors.limeAccent),
            buildAccentRow('Yellow Accent', Colors.yellowAccent),
            buildAccentRow('Amber Accent', Colors.amberAccent),
            buildAccentRow('Orange Accent', Colors.orangeAccent),
            buildAccentRow('Deep Orange Accent', Colors.deepOrangeAccent),
            Text('Section 4: Accent colors rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 5: Special Colors
            buildSectionHeader('5. Special Named Colors'),
            buildLargeColorCard(
              'Colors.black',
              Colors.black,
              'Pure black (#000000) - used for text and borders',
            ),
            buildLargeColorCard(
              'Colors.white',
              Colors.white,
              'Pure white (#FFFFFF) - used for backgrounds',
            ),
            buildLargeColorCard(
              'Colors.transparent (shown on grey)',
              Color(0xFFE0E0E0),
              'Colors.transparent - fully transparent, displayed on grey for visibility',
            ),
            Text('Section 5: Special colors rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 6: Color Info Cards
            buildSectionHeader('6. Color Reference Cards'),
            Wrap(
              children: [
                buildColorInfoCard('Red 500', Colors.red, '#F44336'),
                buildColorInfoCard('Blue 500', Colors.blue, '#2196F3'),
                buildColorInfoCard('Green 500', Colors.green, '#4CAF50'),
                buildColorInfoCard('Yellow 500', Colors.yellow, '#FFEB3B'),
                buildColorInfoCard('Purple 500', Colors.purple, '#9C27B0'),
                buildColorInfoCard('Orange 500', Colors.orange, '#FF9800'),
                buildColorInfoCard('Teal 500', Colors.teal, '#009688'),
                buildColorInfoCard('Pink 500', Colors.pink, '#E91E63'),
                buildColorInfoCard('Indigo 500', Colors.indigo, '#3F51B5'),
                buildColorInfoCard('Cyan 500', Colors.cyan, '#00BCD4'),
                buildColorInfoCard('Amber 500', Colors.amber, '#FFC107'),
                buildColorInfoCard('Brown 500', Colors.brown, '#795548'),
                buildColorInfoCard('Grey 500', Colors.grey, '#9E9E9E'),
                buildColorInfoCard('Blue Grey', Colors.blueGrey, '#607D8B'),
              ],
            ),
            Text('Section 6: Color reference cards rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 7: Gradient Demonstrations
            buildSectionHeader('7. Color Gradients'),
            buildGradientCard('Red Gradient', [
              Colors.red.shade100, Colors.red.shade300,
              Colors.red.shade500, Colors.red.shade700, Colors.red.shade900,
            ]),
            buildGradientCard('Blue Gradient', [
              Colors.blue.shade100, Colors.blue.shade300,
              Colors.blue.shade500, Colors.blue.shade700, Colors.blue.shade900,
            ]),
            buildGradientCard('Green Gradient', [
              Colors.green.shade100, Colors.green.shade300,
              Colors.green.shade500, Colors.green.shade700, Colors.green.shade900,
            ]),
            buildGradientCard('Purple Gradient', [
              Colors.purple.shade100, Colors.purple.shade300,
              Colors.purple.shade500, Colors.purple.shade700, Colors.purple.shade900,
            ]),
            buildGradientCard('Orange Gradient', [
              Colors.orange.shade100, Colors.orange.shade300,
              Colors.orange.shade500, Colors.orange.shade700, Colors.orange.shade900,
            ]),
            buildGradientCard('Teal Gradient', [
              Colors.teal.shade100, Colors.teal.shade300,
              Colors.teal.shade500, Colors.teal.shade700, Colors.teal.shade900,
            ]),
            buildGradientCard('Warm Spectrum', [
              Colors.red, Colors.orange, Colors.yellow,
            ]),
            buildGradientCard('Cool Spectrum', [
              Colors.blue, Colors.cyan, Colors.teal,
            ]),
            buildGradientCard('Full Rainbow', [
              Colors.red, Colors.orange, Colors.yellow,
              Colors.green, Colors.blue, Colors.indigo, Colors.purple,
            ]),
            Text('Section 7: Gradients rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 8: Themed Palettes
            buildSectionHeader('8. Themed Palettes'),
            buildColorPaletteGrid('Earth Tones', [
              Color(0xFF8D6E63), Color(0xFFA1887F), Color(0xFF6D4C41),
              Color(0xFF795548), Color(0xFF4E342E), Color(0xFFD7CCC8),
              Color(0xFFBCAAA4), Color(0xFF3E2723),
            ], ['Sand', 'Clay', 'Brown', 'Mocha', 'Espresso', 'Cream', 'Taupe', 'Umber']),
            buildColorPaletteGrid('Ocean Theme', [
              Color(0xFF006064), Color(0xFF00838F), Color(0xFF0097A7),
              Color(0xFF00ACC1), Color(0xFF00BCD4), Color(0xFF26C6DA),
              Color(0xFF4DD0E1), Color(0xFF80DEEA),
            ], ['Deep', 'Dark', 'Medium', 'Ocean', 'Cyan', 'Shallow', 'Surf', 'Foam']),
            buildColorPaletteGrid('Sunset Theme', [
              Color(0xFFBF360C), Color(0xFFD84315), Color(0xFFE64A19),
              Color(0xFFF4511E), Color(0xFFFF5722), Color(0xFFFF6E40),
              Color(0xFFFF9E80), Color(0xFFFFCCBC),
            ], ['Dusk', 'Fire', 'Blaze', 'Flame', 'Ember', 'Glow', 'Peach', 'Dawn']),
            buildColorPaletteGrid('Forest Theme', [
              Color(0xFF1B5E20), Color(0xFF2E7D32), Color(0xFF388E3C),
              Color(0xFF43A047), Color(0xFF4CAF50), Color(0xFF66BB6A),
              Color(0xFF81C784), Color(0xFFA5D6A7),
            ], ['Pines', 'Fern', 'Moss', 'Leaf', 'Green', 'Sage', 'Mint', 'Spring']),
            Text('Section 8: Themed palettes rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 9: Black/White Opacity Variations
            buildSectionHeader('9. Black and White Opacity'),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Black with opacity:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Row(children: [
                    buildColorBox(Color(0xFF000000), '100%'),
                    buildColorBox(Color(0xCC000000), '80%'),
                    buildColorBox(Color(0x99000000), '60%'),
                    buildColorBox(Color(0x66000000), '40%', darkText: true),
                    buildColorBox(Color(0x33000000), '20%', darkText: true),
                    buildColorBox(Color(0x1A000000), '10%', darkText: true),
                  ]),
                  SizedBox(height: 12),
                  Text('White with opacity:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Container(
                    color: Color(0xFF424242),
                    padding: EdgeInsets.all(4),
                    child: Row(children: [
                      buildColorBox(Color(0xFFFFFFFF), '100%', darkText: true),
                      buildColorBox(Color(0xCCFFFFFF), '80%', darkText: true),
                      buildColorBox(Color(0x99FFFFFF), '60%', darkText: true),
                      buildColorBox(Color(0x66FFFFFF), '40%'),
                      buildColorBox(Color(0x33FFFFFF), '20%'),
                      buildColorBox(Color(0x1AFFFFFF), '10%'),
                    ]),
                  ),
                ],
              ),
            ),
            Text('Section 9: Opacity variations rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Section 10: Color Usage Examples
            buildSectionHeader('10. Color Usage Examples'),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFE0E0E0)),
              ),
              child: Column(
                children: [
                  _buildStatusRow(Colors.green, 'Success / Online'),
                  SizedBox(height: 8),
                  _buildStatusRow(Colors.red, 'Error / Offline'),
                  SizedBox(height: 8),
                  _buildStatusRow(Colors.orange, 'Warning / Away'),
                  SizedBox(height: 8),
                  _buildStatusRow(Colors.blue, 'Info / Active'),
                  SizedBox(height: 8),
                  _buildStatusRow(Colors.grey, 'Disabled / Inactive'),
                ],
              ),
            ),
            Text('Section 10: Color usage examples rendered', style: TextStyle(fontSize: 10, color: Colors.grey)),

            // Summary
            buildSectionHeader('Color Gallery Summary'),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1A237E), Color(0xFF4A148C)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Material Colors Displayed:', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('- 18 primary color swatches (10 shades each)', style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 13)),
                  Text('- 16 accent color swatches (4 shades each)', style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 13)),
                  Text('- Special colors (black, white, transparent)', style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 13)),
                  Text('- 14 reference cards with hex values', style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 13)),
                  Text('- 9 gradient demonstrations', style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 13)),
                  Text('- 4 themed palettes (Earth, Ocean, Sunset, Forest)', style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 13)),
                  Text('- Black/white opacity variations', style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 13)),
                  Text('- Status color usage examples', style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 13)),
                ],
              ),
            ),
            Text('=== Material Colors Deep Demo Complete ===', style: TextStyle(fontSize: 10, color: Colors.grey)),

            SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}

// Top-level helper: status row with colored dot
Widget _buildStatusRow(Color color, String label) {
  return Row(
    children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
      SizedBox(width: 8),
      Text(label, style: TextStyle(fontSize: 13)),
    ],
  );
}
