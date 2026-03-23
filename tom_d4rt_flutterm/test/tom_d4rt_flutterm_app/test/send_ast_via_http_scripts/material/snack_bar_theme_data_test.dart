// ignore_for_file: avoid_print
// D4rt test script: Tests SnackBarThemeData from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.deepPurple.shade700,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget buildInfoCard(String label, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildThemedSnackBarPreview(
  String label,
  String description,
  SnackBarThemeData themeData,
  String snackBarMessage,
  BuildContext context,
) {
  print('Building themed SnackBar preview: $label');
  return Theme(
    data: Theme.of(context).copyWith(snackBarTheme: themeData),
    child: Builder(
      builder: (BuildContext themedContext) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(20),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(themedContext).hideCurrentSnackBar();
                  ScaffoldMessenger.of(themedContext).showSnackBar(
                    SnackBar(
                      content: Text(snackBarMessage),
                      action: SnackBarAction(
                        label: 'ACTION',
                        onPressed: () {
                          print('Action pressed on: $label');
                        },
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
                child: Text('Show SnackBar'),
              ),
            ],
          ),
        );
      },
    ),
  );
}

Widget buildColorSwatch(String name, Color color, Color textOnColor) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.grey.shade400),
    ),
    child: Text(
      name,
      style: TextStyle(
        color: textOnColor,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget buildThemePropertyDisplay(
  String property,
  String valueDisplay,
  Color indicatorColor,
) {
  print('Displaying theme property: $property');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: indicatorColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade400),
          ),
        ),
        SizedBox(width: 10),
        Text(
          property,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            valueDisplay,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    ),
  );
}

Widget buildSnackBarVisualDemo(
  String title,
  Color bgColor,
  Color actionColor,
  double elevation,
  ShapeBorder shape,
  SnackBarBehavior behavior,
) {
  print('Building visual demo: $title');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6),
        Material(
          color: bgColor,
          elevation: elevation,
          shape: shape,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'SnackBar message content',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'ACTION',
                    style: TextStyle(
                      color: actionColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Behavior: ${behavior == SnackBarBehavior.floating ? "floating" : "fixed"}',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
        ),
      ],
    ),
  );
}

Widget buildElevationCompare(double elevation, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    child: Material(
      elevation: elevation,
      color: color,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Text(
              'Elevation: ${elevation.toStringAsFixed(1)}',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            Spacer(),
            Text(
              'Shadow depth',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildShapeDemo(String label, ShapeBorder shape, Color color) {
  print('Building shape demo: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    child: Material(
      color: color,
      shape: shape,
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    ),
  );
}

Widget buildWidthConfigDemo(
  String label,
  double? width,
  EdgeInsets margin,
  Color color,
) {
  print('Building width config demo: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 4),
        Container(
          width: width,
          margin: margin,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: width == null ? MainAxisSize.max : MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  'Snackbar content',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              SizedBox(width: 8),
              Text(
                'ACTION',
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 2),
        Text(
          width == null ? 'Width: full' : 'Width: ${width.toInt()}px',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
        ),
      ],
    ),
  );
}

Widget buildBehaviorComparison(String behavior, bool isFloating) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: isFloating ? Colors.blue.shade50 : Colors.green.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: isFloating ? Colors.blue.shade300 : Colors.green.shade300,
      ),
    ),
    child: Row(
      children: [
        Icon(
          isFloating ? Icons.open_with : Icons.dock,
          color: isFloating ? Colors.blue.shade700 : Colors.green.shade700,
          size: 24,
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                behavior,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: isFloating ? Colors.blue.shade700 : Colors.green.shade700,
                ),
              ),
              SizedBox(height: 2),
              Text(
                isFloating
                    ? 'Floats above content with margins'
                    : 'Fixed at screen bottom edge',
                style: TextStyle(
                  fontSize: 12,
                  color: isFloating ? Colors.blue.shade600 : Colors.green.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildContentStylePreview(
  String label,
  TextStyle textStyle,
  Color bgColor,
) {
  print('Building content style preview: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            'Sample content text',
            style: textStyle,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.white70, fontSize: 11),
        ),
      ],
    ),
  );
}

Widget main() {
  print('SnackBarThemeData Deep Demo');
  print('===========================');
  print('Demonstrating SnackBarThemeData properties and configurations');

  return MaterialApp(
    title: 'SnackBarThemeData Deep Demo',
    theme: ThemeData(
      primarySwatch: Colors.deepPurple,
      scaffoldBackgroundColor: Colors.grey.shade100,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('SnackBarThemeData Deep Demo'),
        backgroundColor: Colors.deepPurple.shade700,
        foregroundColor: Colors.white,
      ),
      body: Builder(
        builder: (BuildContext context) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1: SnackBarThemeData Overview
                buildSectionHeader('SnackBarThemeData Overview'),
                buildInfoCard(
                  'Purpose',
                  'SnackBarThemeData defines the default visual properties for SnackBar widgets throughout an application.',
                ),
                buildInfoCard(
                  'Usage',
                  'Set in ThemeData.snackBarTheme to apply consistent styling to all SnackBars without individual configuration.',
                ),
                buildInfoCard(
                  'Inheritance',
                  'Individual SnackBar properties override theme defaults when specified directly.',
                ),
                buildInfoCard(
                  'Key Properties',
                  'backgroundColor, actionTextColor, contentTextStyle, elevation, shape, behavior, width, insetPadding, showCloseIcon, closeIconColor.',
                ),
                SizedBox(height: 8),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Theme Integration',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'SnackBarThemeData centralizes SnackBar styling allowing consistent appearance across the entire application without repetitive inline configuration.',
                        style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                      ),
                      SizedBox(height: 12),
                      buildThemePropertyDisplay(
                        'backgroundColor',
                        'Background color of SnackBar',
                        Colors.grey.shade800,
                      ),
                      buildThemePropertyDisplay(
                        'actionTextColor',
                        'Color for action button text',
                        Colors.amber,
                      ),
                      buildThemePropertyDisplay(
                        'contentTextStyle',
                        'TextStyle for content',
                        Colors.white,
                      ),
                      buildThemePropertyDisplay(
                        'elevation',
                        'Shadow depth',
                        Colors.grey.shade500,
                      ),
                      buildThemePropertyDisplay(
                        'shape',
                        'Border shape',
                        Colors.deepPurple,
                      ),
                    ],
                  ),
                ),

                // Section 2: backgroundColor
                buildSectionHeader('backgroundColor'),
                buildInfoCard(
                  'Description',
                  'The backgroundColor property sets the default background color for all SnackBars using this theme.',
                ),
                buildInfoCard(
                  'Default',
                  'If not specified, uses ColorScheme.inverseSurface from the current theme.',
                ),
                buildInfoCard(
                  'Contrast',
                  'Ensure sufficient contrast with content text and action buttons for readability.',
                ),
                SizedBox(height: 8),
                buildThemedSnackBarPreview(
                  'Dark Grey Background',
                  'Classic dark grey SnackBar theme',
                  SnackBarThemeData(
                    backgroundColor: Colors.grey.shade800,
                  ),
                  'Dark grey themed SnackBar',
                  context,
                ),
                buildThemedSnackBarPreview(
                  'Deep Purple Background',
                  'Branded purple background',
                  SnackBarThemeData(
                    backgroundColor: Colors.deepPurple.shade700,
                  ),
                  'Deep purple themed SnackBar',
                  context,
                ),
                buildThemedSnackBarPreview(
                  'Teal Background',
                  'Vibrant teal color theme',
                  SnackBarThemeData(
                    backgroundColor: Colors.teal.shade600,
                  ),
                  'Teal themed SnackBar',
                  context,
                ),
                buildThemedSnackBarPreview(
                  'Indigo Background',
                  'Rich indigo color',
                  SnackBarThemeData(
                    backgroundColor: Colors.indigo.shade700,
                  ),
                  'Indigo themed SnackBar',
                  context,
                ),
                buildThemedSnackBarPreview(
                  'Blue Grey Background',
                  'Neutral blue-grey tone',
                  SnackBarThemeData(
                    backgroundColor: Colors.blueGrey.shade700,
                  ),
                  'Blue grey themed SnackBar',
                  context,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Background Color Palette',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: [
                          buildColorSwatch('Grey.800', Colors.grey.shade800, Colors.white),
                          buildColorSwatch('Grey.900', Colors.grey.shade900, Colors.white),
                          buildColorSwatch('Purple', Colors.deepPurple.shade700, Colors.white),
                          buildColorSwatch('Indigo', Colors.indigo.shade700, Colors.white),
                          buildColorSwatch('Teal', Colors.teal.shade700, Colors.white),
                          buildColorSwatch('Brown', Colors.brown.shade700, Colors.white),
                        ],
                      ),
                    ],
                  ),
                ),

                // Section 3: actionTextColor
                buildSectionHeader('actionTextColor'),
                buildInfoCard(
                  'Description',
                  'The actionTextColor property sets the default text color for SnackBarAction buttons.',
                ),
                buildInfoCard(
                  'Purpose',
                  'Ensures action buttons stand out from content text for clear user interaction.',
                ),
                buildInfoCard(
                  'Default',
                  'If not specified, uses ColorScheme.inversePrimary from the current theme.',
                ),
                SizedBox(height: 8),
                buildThemedSnackBarPreview(
                  'Amber Action Color',
                  'High visibility amber action buttons',
                  SnackBarThemeData(
                    backgroundColor: Colors.grey.shade800,
                    actionTextColor: Colors.amber,
                  ),
                  'Amber action demo',
                  context,
                ),
                buildThemedSnackBarPreview(
                  'Cyan Action Color',
                  'Bright cyan for modern look',
                  SnackBarThemeData(
                    backgroundColor: Colors.grey.shade900,
                    actionTextColor: Colors.cyanAccent,
                  ),
                  'Cyan action demo',
                  context,
                ),
                buildThemedSnackBarPreview(
                  'Light Green Action',
                  'Fresh green action color',
                  SnackBarThemeData(
                    backgroundColor: Colors.grey.shade800,
                    actionTextColor: Colors.lightGreenAccent,
                  ),
                  'Light green action demo',
                  context,
                ),
                buildThemedSnackBarPreview(
                  'Pink Action Color',
                  'Vibrant pink accent',
                  SnackBarThemeData(
                    backgroundColor: Colors.grey.shade800,
                    actionTextColor: Colors.pinkAccent,
                  ),
                  'Pink action demo',
                  context,
                ),
                buildThemedSnackBarPreview(
                  'Orange Action Color',
                  'Warning-style orange',
                  SnackBarThemeData(
                    backgroundColor: Colors.blueGrey.shade800,
                    actionTextColor: Colors.orangeAccent,
                  ),
                  'Orange action demo',
                  context,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Action Color Samples on Dark Background',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text('AMBER', style: TextStyle(color: Colors.amber)),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text('CYAN', style: TextStyle(color: Colors.cyanAccent)),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text('GREEN', style: TextStyle(color: Colors.lightGreenAccent)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text('PINK', style: TextStyle(color: Colors.pinkAccent)),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text('ORANGE', style: TextStyle(color: Colors.orangeAccent)),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text('YELLOW', style: TextStyle(color: Colors.yellow)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Section 4: contentTextStyle
                buildSectionHeader('contentTextStyle'),
                buildInfoCard(
                  'Description',
                  'The contentTextStyle property defines the default TextStyle for SnackBar content text.',
                ),
                buildInfoCard(
                  'Control',
                  'Allows setting fontSize, fontWeight, fontFamily, letterSpacing, and color.',
                ),
                buildInfoCard(
                  'Accessibility',
                  'Ensure font size is readable (minimum 14sp recommended) with proper contrast.',
                ),
                SizedBox(height: 8),
                buildContentStylePreview(
                  'Default 14sp',
                  TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  Colors.grey.shade800,
                ),
                buildContentStylePreview(
                  'Bold 16sp',
                  TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  Colors.grey.shade800,
                ),
                buildContentStylePreview(
                  'Light 15sp',
                  TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                  Colors.grey.shade700,
                ),
                buildContentStylePreview(
                  'Italic 14sp',
                  TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                  Colors.blueGrey.shade700,
                ),
                buildContentStylePreview(
                  'Spaced 14sp',
                  TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    letterSpacing: 1.5,
                  ),
                  Colors.indigo.shade700,
                ),
                SizedBox(height: 8),
                buildThemedSnackBarPreview(
                  'Custom Content Style Theme',
                  'Bold text with increased size',
                  SnackBarThemeData(
                    backgroundColor: Colors.grey.shade800,
                    contentTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                  'Custom styled content',
                  context,
                ),
                buildThemedSnackBarPreview(
                  'Light Weight Content',
                  'Lighter font weight style',
                  SnackBarThemeData(
                    backgroundColor: Colors.blueGrey.shade800,
                    contentTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  'Light weight content style',
                  context,
                ),

                // Section 5: elevation
                buildSectionHeader('elevation'),
                buildInfoCard(
                  'Description',
                  'The elevation property controls the shadow depth beneath the SnackBar.',
                ),
                buildInfoCard(
                  'Range',
                  'Typical values range from 0 (no shadow) to 24 (maximum elevation).',
                ),
                buildInfoCard(
                  'Material Design',
                  'Default SnackBar elevation is 6.0 per Material Design guidelines.',
                ),
                buildInfoCard(
                  'Floating',
                  'Floating SnackBars often use higher elevation for visual separation.',
                ),
                SizedBox(height: 8),
                buildElevationCompare(0, Colors.grey.shade800),
                buildElevationCompare(2, Colors.grey.shade800),
                buildElevationCompare(4, Colors.grey.shade800),
                buildElevationCompare(6, Colors.grey.shade800),
                buildElevationCompare(8, Colors.grey.shade800),
                buildElevationCompare(12, Colors.grey.shade800),
                SizedBox(height: 12),
                buildThemedSnackBarPreview(
                  'Zero Elevation Theme',
                  'Flat appearance with no shadow',
                  SnackBarThemeData(
                    backgroundColor: Colors.grey.shade800,
                    elevation: 0,
                  ),
                  'Zero elevation SnackBar',
                  context,
                ),
                buildThemedSnackBarPreview(
                  'High Elevation Theme',
                  'Prominent shadow for emphasis',
                  SnackBarThemeData(
                    backgroundColor: Colors.grey.shade800,
                    elevation: 12,
                    behavior: SnackBarBehavior.floating,
                  ),
                  'High elevation SnackBar',
                  context,
                ),

                // Section 6: shape
                buildSectionHeader('shape'),
                buildInfoCard(
                  'Description',
                  'The shape property defines the border shape of the SnackBar container.',
                ),
                buildInfoCard(
                  'Types',
                  'Common shapes include RoundedRectangleBorder, StadiumBorder, and BeveledRectangleBorder.',
                ),
                buildInfoCard(
                  'Floating Requirement',
                  'Custom shapes are most visible with floating behavior due to visible borders.',
                ),
                SizedBox(height: 8),
                buildShapeDemo(
                  'Rectangle (default)',
                  RoundedRectangleBorder(),
                  Colors.grey.shade800,
                ),
                buildShapeDemo(
                  'Rounded 8px',
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  Colors.grey.shade800,
                ),
                buildShapeDemo(
                  'Rounded 16px',
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  Colors.grey.shade800,
                ),
                buildShapeDemo(
                  'Stadium',
                  StadiumBorder(),
                  Colors.indigo.shade700,
                ),
                buildShapeDemo(
                  'Beveled',
                  BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  Colors.teal.shade700,
                ),
                SizedBox(height: 12),
                buildThemedSnackBarPreview(
                  'Rounded Theme',
                  'Rounded corners shape',
                  SnackBarThemeData(
                    backgroundColor: Colors.grey.shade800,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  'Rounded shape SnackBar',
                  context,
                ),
                buildThemedSnackBarPreview(
                  'Stadium Border Theme',
                  'Pill-shaped SnackBar',
                  SnackBarThemeData(
                    backgroundColor: Colors.deepPurple.shade700,
                    behavior: SnackBarBehavior.floating,
                    shape: StadiumBorder(),
                  ),
                  'Stadium shape SnackBar',
                  context,
                ),
                buildThemedSnackBarPreview(
                  'Bordered Shape Theme',
                  'Shape with visible border',
                  SnackBarThemeData(
                    backgroundColor: Colors.grey.shade800,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.amber, width: 2),
                    ),
                  ),
                  'Bordered SnackBar',
                  context,
                ),

                // Section 7: behavior (fixed/floating)
                buildSectionHeader('behavior (fixed/floating)'),
                buildInfoCard(
                  'Description',
                  'The behavior property controls whether SnackBar is fixed or floating.',
                ),
                buildInfoCard(
                  'Fixed',
                  'SnackBar is attached to the bottom edge of the screen with no margins.',
                ),
                buildInfoCard(
                  'Floating',
                  'SnackBar floats above content with margins and rounded corners visible.',
                ),
                buildInfoCard(
                  'Recommendation',
                  'Floating is preferred for modern Material Design 3 applications.',
                ),
                SizedBox(height: 8),
                buildBehaviorComparison('SnackBarBehavior.fixed', false),
                buildBehaviorComparison('SnackBarBehavior.floating', true),
                SizedBox(height: 12),
                buildSnackBarVisualDemo(
                  'Fixed Behavior Visual',
                  Colors.grey.shade800,
                  Colors.amber,
                  0,
                  RoundedRectangleBorder(),
                  SnackBarBehavior.fixed,
                ),
                buildSnackBarVisualDemo(
                  'Floating Behavior Visual',
                  Colors.grey.shade800,
                  Colors.amber,
                  6,
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  SnackBarBehavior.floating,
                ),
                SizedBox(height: 8),
                buildThemedSnackBarPreview(
                  'Fixed Behavior Theme',
                  'Traditional fixed positioning',
                  SnackBarThemeData(
                    backgroundColor: Colors.grey.shade800,
                    behavior: SnackBarBehavior.fixed,
                  ),
                  'Fixed behavior demo',
                  context,
                ),
                buildThemedSnackBarPreview(
                  'Floating Behavior Theme',
                  'Modern floating positioning',
                  SnackBarThemeData(
                    backgroundColor: Colors.grey.shade800,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  'Floating behavior demo',
                  context,
                ),
                buildThemedSnackBarPreview(
                  'Floating with High Margin',
                  'Floating with custom inset padding',
                  SnackBarThemeData(
                    backgroundColor: Colors.indigo.shade700,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    insetPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                  'High margin floating',
                  context,
                ),

                // Section 8: width configurations
                buildSectionHeader('width Configurations'),
                buildInfoCard(
                  'Description',
                  'The width property sets the maximum width of floating SnackBars.',
                ),
                buildInfoCard(
                  'Requirement',
                  'Width only applies when behavior is SnackBarBehavior.floating.',
                ),
                buildInfoCard(
                  'Center Alignment',
                  'When width is set, SnackBar is center-aligned horizontally.',
                ),
                buildInfoCard(
                  'Responsive',
                  'Use MediaQuery to calculate responsive widths based on screen size.',
                ),
                SizedBox(height: 8),
                buildWidthConfigDemo(
                  'Full Width (default)',
                  null,
                  EdgeInsets.zero,
                  Colors.grey.shade800,
                ),
                buildWidthConfigDemo(
                  'Fixed 300px',
                  300,
                  EdgeInsets.symmetric(horizontal: 8),
                  Colors.grey.shade800,
                ),
                buildWidthConfigDemo(
                  'Fixed 400px',
                  400,
                  EdgeInsets.symmetric(horizontal: 8),
                  Colors.grey.shade800,
                ),
                buildWidthConfigDemo(
                  'Fixed 250px Narrow',
                  250,
                  EdgeInsets.symmetric(horizontal: 8),
                  Colors.indigo.shade700,
                ),
                SizedBox(height: 12),
                buildThemedSnackBarPreview(
                  'Narrow Width Theme',
                  'Floating SnackBar with narrow width',
                  SnackBarThemeData(
                    backgroundColor: Colors.grey.shade800,
                    behavior: SnackBarBehavior.floating,
                    width: 280,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  'Narrow width demo',
                  context,
                ),
                buildThemedSnackBarPreview(
                  'Medium Width Theme',
                  'Balanced width for most content',
                  SnackBarThemeData(
                    backgroundColor: Colors.grey.shade800,
                    behavior: SnackBarBehavior.floating,
                    width: 360,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  'Medium width demo',
                  context,
                ),
                buildThemedSnackBarPreview(
                  'Wide Width Theme',
                  'Extra wide for longer messages',
                  SnackBarThemeData(
                    backgroundColor: Colors.teal.shade700,
                    behavior: SnackBarBehavior.floating,
                    width: 450,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  'Wide width demo',
                  context,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 12),
                  padding: EdgeInsets.all(16),
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
                          Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Width Best Practices',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        '- Use width property only with floating behavior\n'
                        '- Consider tablet/desktop layouts requiring centered SnackBars\n'
                        '- Ensure width accommodates action button without truncation\n'
                        '- For mobile, full width often works better\n'
                        '- Calculate responsive widths using MediaQuery.of(context).size.width',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.blue.shade800,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                // Combined Theme Examples
                buildSectionHeader('Combined Theme Examples'),
                buildInfoCard(
                  'Overview',
                  'Combining multiple SnackBarThemeData properties creates cohesive SnackBar styling.',
                ),
                SizedBox(height: 8),
                buildThemedSnackBarPreview(
                  'Modern Material 3',
                  'Floating, rounded, elevated with branded colors',
                  SnackBarThemeData(
                    backgroundColor: Colors.grey.shade900,
                    actionTextColor: Colors.tealAccent,
                    contentTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    elevation: 8,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  'Modern Material 3 themed',
                  context,
                ),
                buildThemedSnackBarPreview(
                  'Minimal Flat Design',
                  'No elevation, subtle colors',
                  SnackBarThemeData(
                    backgroundColor: Colors.blueGrey.shade100,
                    actionTextColor: Colors.blueGrey.shade800,
                    contentTextStyle: TextStyle(
                      color: Colors.blueGrey.shade900,
                      fontSize: 14,
                    ),
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  'Minimal flat theme',
                  context,
                ),
                buildThemedSnackBarPreview(
                  'Bold Accent Theme',
                  'Strong color with high visibility action',
                  SnackBarThemeData(
                    backgroundColor: Colors.deepPurple.shade800,
                    actionTextColor: Colors.amberAccent,
                    contentTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    elevation: 6,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  'Bold accent themed',
                  context,
                ),
                buildThemedSnackBarPreview(
                  'Compact Pill Style',
                  'Stadium shape with narrow width',
                  SnackBarThemeData(
                    backgroundColor: Colors.indigo.shade600,
                    actionTextColor: Colors.white,
                    contentTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    elevation: 4,
                    behavior: SnackBarBehavior.floating,
                    width: 300,
                    shape: StadiumBorder(),
                  ),
                  'Compact pill themed',
                  context,
                ),
                buildThemedSnackBarPreview(
                  'Warning Style Theme',
                  'Amber background for warnings',
                  SnackBarThemeData(
                    backgroundColor: Colors.amber.shade700,
                    actionTextColor: Colors.white,
                    contentTextStyle: TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    elevation: 4,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  'Warning themed',
                  context,
                ),
                buildThemedSnackBarPreview(
                  'Error Style Theme',
                  'Red background for errors',
                  SnackBarThemeData(
                    backgroundColor: Colors.red.shade700,
                    actionTextColor: Colors.white,
                    contentTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    elevation: 6,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  'Error themed',
                  context,
                ),
                buildThemedSnackBarPreview(
                  'Success Style Theme',
                  'Green background for success',
                  SnackBarThemeData(
                    backgroundColor: Colors.green.shade700,
                    actionTextColor: Colors.white,
                    contentTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    elevation: 6,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  'Success themed',
                  context,
                ),

                SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'SnackBarThemeData Deep Demo Complete',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Explored: Overview, backgroundColor, actionTextColor, contentTextStyle, elevation, shape, behavior, width',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    ),
  );
}
