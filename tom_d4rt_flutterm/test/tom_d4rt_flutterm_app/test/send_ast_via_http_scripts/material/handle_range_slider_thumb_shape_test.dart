// D4rt test script: Tests HandleRangeSliderThumbShape from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    margin: EdgeInsets.only(top: 20.0, bottom: 8.0, left: 8.0, right: 8.0),
    decoration: BoxDecoration(
      color: Color(0xFF1565C0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget buildSubHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    margin: EdgeInsets.only(top: 12.0, bottom: 6.0, left: 12.0, right: 12.0),
    decoration: BoxDecoration(
      color: Color(0xFF42A5F5),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
  );
}

Widget buildInfoCard(String label, String detail) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: Color(0xFFBDBDBD), width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 140.0,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF424242),
            ),
          ),
        ),
        Expanded(
          child: Text(
            detail,
            style: TextStyle(fontSize: 13.0, color: Color(0xFF616161)),
          ),
        ),
      ],
    ),
  );
}

Widget buildPropertyRow(String property, String value, String description) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: Color(0xFFE0E0E0), width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          width: 160.0,
          child: Text(
            property,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1565C0),
            ),
          ),
        ),
        Container(
          width: 100.0,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: Color(0xFF2E7D32),
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 11.0, color: Color(0xFF757575)),
          ),
        ),
      ],
    ),
  );
}

Widget buildColorSwatch(Color color, String label) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
    child: Column(
      children: [
        Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Color(0xFF9E9E9E), width: 1.0),
          ),
        ),
        SizedBox(height: 4.0),
        Text(label, style: TextStyle(fontSize: 10.0, color: Color(0xFF616161))),
      ],
    ),
  );
}

Widget buildDemoLabel(String text) {
  return Padding(
    padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 2.0),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        color: Color(0xFF37474F),
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}

Widget buildRangeSliderCard(String title, Widget slider, Color borderColor) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: borderColor, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w600,
            color: Color(0xFF37474F),
          ),
        ),
        SizedBox(height: 8.0),
        slider,
      ],
    ),
  );
}

Widget buildNoteBox(String text, Color bgColor) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 12.0, color: Color(0xFF424242)),
    ),
  );
}

dynamic build(BuildContext context) {
  print('--- HandleRangeSliderThumbShape Demo ---');
  print('Demonstrating RangeSlider thumb shapes and customization');
  print('Using RoundRangeSliderThumbShape and SliderThemeData');

  RangeValues defaultRange = RangeValues(0.2, 0.8);
  RangeValues lowRange = RangeValues(0.1, 0.3);
  RangeValues midRange = RangeValues(0.4, 0.6);
  RangeValues highRange = RangeValues(0.7, 0.9);
  RangeValues wideRange = RangeValues(0.05, 0.95);
  RangeValues narrowRange = RangeValues(0.45, 0.55);

  print('Default range: 0.2 - 0.8');
  print('Low range: 0.1 - 0.3');
  print('Mid range: 0.4 - 0.6');
  print('High range: 0.7 - 0.9');
  print('Wide range: 0.05 - 0.95');
  print('Narrow range: 0.45 - 0.55');

  RoundRangeSliderThumbShape defaultThumb = RoundRangeSliderThumbShape();
  RoundRangeSliderThumbShape smallThumb = RoundRangeSliderThumbShape(
    enabledThumbRadius: 8.0,
  );
  RoundRangeSliderThumbShape largeThumb = RoundRangeSliderThumbShape(
    enabledThumbRadius: 16.0,
  );
  RoundRangeSliderThumbShape tinyThumb = RoundRangeSliderThumbShape(
    enabledThumbRadius: 5.0,
    disabledThumbRadius: 3.0,
  );
  RoundRangeSliderThumbShape hugeThumb = RoundRangeSliderThumbShape(
    enabledThumbRadius: 20.0,
    disabledThumbRadius: 14.0,
  );
  RoundRangeSliderThumbShape mediumThumb = RoundRangeSliderThumbShape(
    enabledThumbRadius: 12.0,
    disabledThumbRadius: 8.0,
  );

  print('Created 6 thumb shape configurations');
  print('Default thumb radius: 10.0');
  print('Small thumb radius: 8.0');
  print('Large thumb radius: 16.0');
  print('Tiny thumb radius: 5.0 (disabled: 3.0)');
  print('Huge thumb radius: 20.0 (disabled: 14.0)');
  print('Medium thumb radius: 12.0 (disabled: 8.0)');

  SliderThemeData blueTheme = SliderThemeData(
    rangeThumbShape: defaultThumb,
    activeTrackColor: Color(0xFF1565C0),
    inactiveTrackColor: Color(0xFFBBDEFB),
    thumbColor: Color(0xFF0D47A1),
    overlayColor: Color(0x291565C0),
    activeTickMarkColor: Color(0xFF1565C0),
    inactiveTickMarkColor: Color(0xFFBBDEFB),
  );

  SliderThemeData greenTheme = SliderThemeData(
    rangeThumbShape: smallThumb,
    activeTrackColor: Color(0xFF2E7D32),
    inactiveTrackColor: Color(0xFFC8E6C9),
    thumbColor: Color(0xFF1B5E20),
    overlayColor: Color(0x292E7D32),
    activeTickMarkColor: Color(0xFF2E7D32),
    inactiveTickMarkColor: Color(0xFFC8E6C9),
  );

  SliderThemeData orangeTheme = SliderThemeData(
    rangeThumbShape: largeThumb,
    activeTrackColor: Color(0xFFE65100),
    inactiveTrackColor: Color(0xFFFFCCBC),
    thumbColor: Color(0xFFBF360C),
    overlayColor: Color(0x29E65100),
    activeTickMarkColor: Color(0xFFE65100),
    inactiveTickMarkColor: Color(0xFFFFCCBC),
  );

  SliderThemeData purpleTheme = SliderThemeData(
    rangeThumbShape: mediumThumb,
    activeTrackColor: Color(0xFF6A1B9A),
    inactiveTrackColor: Color(0xFFE1BEE7),
    thumbColor: Color(0xFF4A148C),
    overlayColor: Color(0x296A1B9A),
    activeTickMarkColor: Color(0xFF6A1B9A),
    inactiveTickMarkColor: Color(0xFFE1BEE7),
  );

  SliderThemeData tealTheme = SliderThemeData(
    rangeThumbShape: tinyThumb,
    activeTrackColor: Color(0xFF00695C),
    inactiveTrackColor: Color(0xFFB2DFDB),
    thumbColor: Color(0xFF004D40),
    overlayColor: Color(0x2900695C),
    activeTickMarkColor: Color(0xFF00695C),
    inactiveTickMarkColor: Color(0xFFB2DFDB),
  );

  SliderThemeData redTheme = SliderThemeData(
    rangeThumbShape: hugeThumb,
    activeTrackColor: Color(0xFFC62828),
    inactiveTrackColor: Color(0xFFFFCDD2),
    thumbColor: Color(0xFFB71C1C),
    overlayColor: Color(0x29C62828),
    activeTickMarkColor: Color(0xFFC62828),
    inactiveTickMarkColor: Color(0xFFFFCDD2),
  );

  SliderThemeData pinkOverlayTheme = SliderThemeData(
    rangeThumbShape: defaultThumb,
    activeTrackColor: Color(0xFFAD1457),
    inactiveTrackColor: Color(0xFFF8BBD0),
    thumbColor: Color(0xFF880E4F),
    overlayColor: Color(0x44AD1457),
    overlappingShapeStrokeColor: Color(0xFFFFFFFF),
  );

  SliderThemeData indigoOverlayTheme = SliderThemeData(
    rangeThumbShape: mediumThumb,
    activeTrackColor: Color(0xFF283593),
    inactiveTrackColor: Color(0xFFC5CAE9),
    thumbColor: Color(0xFF1A237E),
    overlayColor: Color(0x44283593),
    overlappingShapeStrokeColor: Color(0xFFFFEB3B),
  );

  print('Created 8 slider theme configurations');
  print('Blue theme: deep blue tones with default thumb');
  print('Green theme: green tones with small thumb');
  print('Orange theme: orange tones with large thumb');
  print('Purple theme: purple tones with medium thumb');
  print('Teal theme: teal tones with tiny thumb');
  print('Red theme: red tones with huge thumb');
  print('Pink overlay theme: pink with enhanced overlay');
  print('Indigo overlay theme: indigo with yellow stroke');

  return Scaffold(
    appBar: AppBar(
      title: Text('RangeSlider Thumb Shape Demo'),
      backgroundColor: Color(0xFF1565C0),
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section 1: Default RangeSlider thumb appearance
          buildSectionHeader('1. Default RangeSlider Thumb Appearance'),
          buildNoteBox(
            'The default RangeSlider uses RoundRangeSliderThumbShape with enabledThumbRadius of 10.0. '
            'Each thumb can be dragged independently to select a range.',
            Color(0xFFE3F2FD),
          ),
          buildDemoLabel('Default RangeSlider with standard thumb shape'),
          buildRangeSliderCard(
            'Default Thumb Shape (radius: 10.0)',
            RangeSlider(
              values: defaultRange,
              min: 0.0,
              max: 1.0,
              onChanged: null,
            ),
            Color(0xFF1565C0),
          ),
          buildDemoLabel('Default range slider at low values'),
          buildRangeSliderCard(
            'Low Range (0.1 - 0.3)',
            RangeSlider(values: lowRange, min: 0.0, max: 1.0, onChanged: null),
            Color(0xFF1565C0),
          ),
          buildDemoLabel('Default range slider at high values'),
          buildRangeSliderCard(
            'High Range (0.7 - 0.9)',
            RangeSlider(values: highRange, min: 0.0, max: 1.0, onChanged: null),
            Color(0xFF1565C0),
          ),
          buildInfoCard('Default Thumb Radius', '10.0 logical pixels'),
          buildInfoCard('Default Shape', 'RoundRangeSliderThumbShape (circle)'),
          buildInfoCard('Thumb Count', 'Two thumbs: start and end'),

          // Section 2: Custom thumb colors via SliderThemeData
          buildSectionHeader('2. Custom Thumb Colors via SliderThemeData'),
          buildNoteBox(
            'SliderThemeData allows customization of thumb color, active/inactive track colors, '
            'overlay color, and tick mark colors for RangeSliders.',
            Color(0xFFE8F5E9),
          ),
          buildDemoLabel('Blue themed RangeSlider'),
          buildRangeSliderCard(
            'Blue Theme - Deep Blue Thumbs',
            SliderTheme(
              data: blueTheme,
              child: RangeSlider(
                values: defaultRange,
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFF1565C0),
          ),
          buildDemoLabel('Green themed RangeSlider'),
          buildRangeSliderCard(
            'Green Theme - Forest Green Thumbs',
            SliderTheme(
              data: greenTheme,
              child: RangeSlider(
                values: midRange,
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFF2E7D32),
          ),
          buildDemoLabel('Orange themed RangeSlider'),
          buildRangeSliderCard(
            'Orange Theme - Burnt Orange Thumbs',
            SliderTheme(
              data: orangeTheme,
              child: RangeSlider(
                values: highRange,
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFFE65100),
          ),
          buildDemoLabel('Purple themed RangeSlider'),
          buildRangeSliderCard(
            'Purple Theme - Deep Purple Thumbs',
            SliderTheme(
              data: purpleTheme,
              child: RangeSlider(
                values: lowRange,
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFF6A1B9A),
          ),
          buildInfoCard('thumbColor', 'Sets the color of both range thumbs'),
          buildInfoCard(
            'activeTrackColor',
            'Color of the track between the two thumbs',
          ),
          buildInfoCard(
            'inactiveTrackColor',
            'Color of the track outside the two thumbs',
          ),

          // Section 3: Different thumb radius via RoundRangeSliderThumbShape
          buildSectionHeader('3. Different Thumb Radius Configurations'),
          buildNoteBox(
            'RoundRangeSliderThumbShape accepts enabledThumbRadius and optional disabledThumbRadius. '
            'The enabled radius is used when onChanged is not null, disabled when it is null.',
            Color(0xFFFFF3E0),
          ),
          buildDemoLabel('Tiny thumb (radius: 5.0)'),
          buildRangeSliderCard(
            'Tiny Thumb - enabledThumbRadius: 5.0',
            SliderTheme(
              data: tealTheme,
              child: RangeSlider(
                values: defaultRange,
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFF00695C),
          ),
          buildDemoLabel('Small thumb (radius: 8.0)'),
          buildRangeSliderCard(
            'Small Thumb - enabledThumbRadius: 8.0',
            SliderTheme(
              data: greenTheme,
              child: RangeSlider(
                values: defaultRange,
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFF2E7D32),
          ),
          buildDemoLabel('Default thumb (radius: 10.0)'),
          buildRangeSliderCard(
            'Default Thumb - enabledThumbRadius: 10.0',
            SliderTheme(
              data: blueTheme,
              child: RangeSlider(
                values: defaultRange,
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFF1565C0),
          ),
          buildDemoLabel('Medium thumb (radius: 12.0)'),
          buildRangeSliderCard(
            'Medium Thumb - enabledThumbRadius: 12.0',
            SliderTheme(
              data: purpleTheme,
              child: RangeSlider(
                values: defaultRange,
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFF6A1B9A),
          ),
          buildDemoLabel('Large thumb (radius: 16.0)'),
          buildRangeSliderCard(
            'Large Thumb - enabledThumbRadius: 16.0',
            SliderTheme(
              data: orangeTheme,
              child: RangeSlider(
                values: defaultRange,
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFFE65100),
          ),
          buildDemoLabel('Huge thumb (radius: 20.0)'),
          buildRangeSliderCard(
            'Huge Thumb - enabledThumbRadius: 20.0',
            SliderTheme(
              data: redTheme,
              child: RangeSlider(
                values: defaultRange,
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFFC62828),
          ),

          // Section 4: Multiple themed RangeSliders
          buildSectionHeader('4. Multiple Themed RangeSliders'),
          buildNoteBox(
            'Combining different theme configurations to demonstrate the variety of visual '
            'customizations available for RangeSlider thumbs.',
            Color(0xFFF3E5F5),
          ),
          buildDemoLabel('Wide range with teal theme'),
          buildRangeSliderCard(
            'Teal Wide Range (0.05 - 0.95)',
            SliderTheme(
              data: tealTheme,
              child: RangeSlider(
                values: wideRange,
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFF00695C),
          ),
          buildDemoLabel('Narrow range with red theme'),
          buildRangeSliderCard(
            'Red Narrow Range (0.45 - 0.55)',
            SliderTheme(
              data: redTheme,
              child: RangeSlider(
                values: narrowRange,
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFFC62828),
          ),
          buildDemoLabel('Mid range with purple theme'),
          buildRangeSliderCard(
            'Purple Mid Range (0.4 - 0.6)',
            SliderTheme(
              data: purpleTheme,
              child: RangeSlider(
                values: midRange,
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFF6A1B9A),
          ),
          buildDemoLabel('Low range with orange theme'),
          buildRangeSliderCard(
            'Orange Low Range (0.1 - 0.3)',
            SliderTheme(
              data: orangeTheme,
              child: RangeSlider(
                values: lowRange,
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFFE65100),
          ),
          buildDemoLabel('High range with green theme'),
          buildRangeSliderCard(
            'Green High Range (0.7 - 0.9)',
            SliderTheme(
              data: greenTheme,
              child: RangeSlider(
                values: highRange,
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFF2E7D32),
          ),

          // Section 5: Overlay colors and shapes
          buildSectionHeader('5. RangeSlider Overlay Colors and Shapes'),
          buildNoteBox(
            'The overlay is the semi-transparent circle that appears when a thumb is pressed. '
            'overlayColor and overlappingShapeStrokeColor control these visual elements.',
            Color(0xFFEDE7F6),
          ),
          buildDemoLabel('Pink overlay theme'),
          buildRangeSliderCard(
            'Pink Overlay - Enhanced Overlay Visibility',
            SliderTheme(
              data: pinkOverlayTheme,
              child: RangeSlider(
                values: defaultRange,
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFFAD1457),
          ),
          buildDemoLabel('Indigo with yellow overlapping stroke'),
          buildRangeSliderCard(
            'Indigo Overlay - Yellow Overlapping Stroke',
            SliderTheme(
              data: indigoOverlayTheme,
              child: RangeSlider(
                values: narrowRange,
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFF283593),
          ),
          buildDemoLabel('Blue overlay with wide spread'),
          buildRangeSliderCard(
            'Blue Overlay - Wide Spread Range',
            SliderTheme(
              data: blueTheme,
              child: RangeSlider(
                values: wideRange,
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFF1565C0),
          ),
          buildInfoCard(
            'overlayColor',
            'Semi-transparent color shown on thumb press',
          ),
          buildInfoCard(
            'overlappingShapeStrokeColor',
            'Stroke color when thumbs overlap or are close',
          ),

          // Section 6: Comparison of enabledThumbRadius and disabledThumbRadius
          buildSectionHeader('6. Enabled vs Disabled Thumb Radius Comparison'),
          buildNoteBox(
            'When disabledThumbRadius is specified, the thumb shrinks to that size when the slider '
            'is disabled (onChanged is null). If not specified, it defaults to enabledThumbRadius.',
            Color(0xFFE0F7FA),
          ),
          buildSubHeader('Tiny Thumb Configuration'),
          buildPropertyRow(
            'enabledThumbRadius',
            '5.0',
            'Very small active thumb',
          ),
          buildPropertyRow(
            'disabledThumbRadius',
            '3.0',
            'Even smaller when disabled',
          ),
          buildRangeSliderCard(
            'Tiny Thumb Disabled State',
            SliderTheme(
              data: tealTheme,
              child: RangeSlider(
                values: midRange,
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFF00695C),
          ),
          buildSubHeader('Medium Thumb Configuration'),
          buildPropertyRow(
            'enabledThumbRadius',
            '12.0',
            'Slightly larger than default',
          ),
          buildPropertyRow(
            'disabledThumbRadius',
            '8.0',
            'Shrinks noticeably when disabled',
          ),
          buildRangeSliderCard(
            'Medium Thumb Disabled State',
            SliderTheme(
              data: purpleTheme,
              child: RangeSlider(
                values: midRange,
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFF6A1B9A),
          ),
          buildSubHeader('Huge Thumb Configuration'),
          buildPropertyRow(
            'enabledThumbRadius',
            '20.0',
            'Very large active thumb',
          ),
          buildPropertyRow(
            'disabledThumbRadius',
            '14.0',
            'Still prominent when disabled',
          ),
          buildRangeSliderCard(
            'Huge Thumb Disabled State',
            SliderTheme(
              data: redTheme,
              child: RangeSlider(
                values: midRange,
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFFC62828),
          ),
          buildSubHeader('Default Thumb (no explicit disabled radius)'),
          buildPropertyRow(
            'enabledThumbRadius',
            '10.0',
            'Standard default size',
          ),
          buildPropertyRow(
            'disabledThumbRadius',
            'null',
            'Falls back to enabledThumbRadius',
          ),
          buildRangeSliderCard(
            'Default Thumb Disabled State',
            SliderTheme(
              data: blueTheme,
              child: RangeSlider(
                values: midRange,
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFF1565C0),
          ),

          // Section 7: RangeSliders at different value positions
          buildSectionHeader('7. RangeSliders at Different Value Positions'),
          buildNoteBox(
            'Demonstrating how thumb positions change with different RangeValues. '
            'The active track (between thumbs) adjusts accordingly.',
            Color(0xFFFCE4EC),
          ),
          buildDemoLabel('Very low range'),
          buildRangeSliderCard(
            'Range: 0.05 - 0.15',
            SliderTheme(
              data: blueTheme,
              child: RangeSlider(
                values: RangeValues(0.05, 0.15),
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFF1565C0),
          ),
          buildDemoLabel('Low-mid range'),
          buildRangeSliderCard(
            'Range: 0.2 - 0.4',
            SliderTheme(
              data: greenTheme,
              child: RangeSlider(
                values: RangeValues(0.2, 0.4),
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFF2E7D32),
          ),
          buildDemoLabel('Center range'),
          buildRangeSliderCard(
            'Range: 0.35 - 0.65',
            SliderTheme(
              data: purpleTheme,
              child: RangeSlider(
                values: RangeValues(0.35, 0.65),
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFF6A1B9A),
          ),
          buildDemoLabel('High-mid range'),
          buildRangeSliderCard(
            'Range: 0.6 - 0.8',
            SliderTheme(
              data: orangeTheme,
              child: RangeSlider(
                values: RangeValues(0.6, 0.8),
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFFE65100),
          ),
          buildDemoLabel('Very high range'),
          buildRangeSliderCard(
            'Range: 0.85 - 0.95',
            SliderTheme(
              data: redTheme,
              child: RangeSlider(
                values: RangeValues(0.85, 0.95),
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFFC62828),
          ),
          buildDemoLabel('Full span range'),
          buildRangeSliderCard(
            'Range: 0.0 - 1.0',
            SliderTheme(
              data: tealTheme,
              child: RangeSlider(
                values: RangeValues(0.0, 1.0),
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFF00695C),
          ),
          buildDemoLabel('Adjacent thumbs near center'),
          buildRangeSliderCard(
            'Range: 0.49 - 0.51',
            SliderTheme(
              data: pinkOverlayTheme,
              child: RangeSlider(
                values: RangeValues(0.49, 0.51),
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFFAD1457),
          ),
          buildDemoLabel('Quarter-based range'),
          buildRangeSliderCard(
            'Range: 0.25 - 0.75',
            SliderTheme(
              data: indigoOverlayTheme,
              child: RangeSlider(
                values: RangeValues(0.25, 0.75),
                min: 0.0,
                max: 1.0,
                onChanged: null,
              ),
            ),
            Color(0xFF283593),
          ),

          // Section 8: Divisions with thumb shapes
          buildSectionHeader('8. RangeSliders with Divisions'),
          buildNoteBox(
            'Adding divisions to RangeSliders creates discrete snap points. '
            'The thumbs will snap to evenly spaced positions along the track.',
            Color(0xFFFFF8E1),
          ),
          buildDemoLabel('5 divisions with blue theme'),
          buildRangeSliderCard(
            '5 Divisions - Coarse Steps',
            SliderTheme(
              data: blueTheme,
              child: RangeSlider(
                values: RangeValues(0.2, 0.8),
                min: 0.0,
                max: 1.0,
                divisions: 5,
                onChanged: null,
              ),
            ),
            Color(0xFF1565C0),
          ),
          buildDemoLabel('10 divisions with green theme'),
          buildRangeSliderCard(
            '10 Divisions - Medium Steps',
            SliderTheme(
              data: greenTheme,
              child: RangeSlider(
                values: RangeValues(0.3, 0.7),
                min: 0.0,
                max: 1.0,
                divisions: 10,
                onChanged: null,
              ),
            ),
            Color(0xFF2E7D32),
          ),
          buildDemoLabel('20 divisions with orange theme'),
          buildRangeSliderCard(
            '20 Divisions - Fine Steps',
            SliderTheme(
              data: orangeTheme,
              child: RangeSlider(
                values: RangeValues(0.15, 0.85),
                min: 0.0,
                max: 1.0,
                divisions: 20,
                onChanged: null,
              ),
            ),
            Color(0xFFE65100),
          ),

          // Section 9: Property / info reference section
          buildSectionHeader('9. Property and API Reference'),
          buildNoteBox(
            'Complete reference for RoundRangeSliderThumbShape and related SliderThemeData properties '
            'used to customize RangeSlider thumb appearance.',
            Color(0xFFE8EAF6),
          ),
          buildSubHeader('RoundRangeSliderThumbShape Properties'),
          buildPropertyRow(
            'enabledThumbRadius',
            'double',
            'Radius of the thumb when the slider is enabled (default: 10.0)',
          ),
          buildPropertyRow(
            'disabledThumbRadius',
            'double?',
            'Radius when disabled; defaults to enabledThumbRadius if null',
          ),
          buildPropertyRow(
            'elevation',
            '1.0',
            'Default elevation of the thumb shadow',
          ),
          buildPropertyRow(
            'pressedElevation',
            '6.0',
            'Elevation when the thumb is pressed',
          ),

          buildSubHeader('SliderThemeData Thumb Properties'),
          buildPropertyRow(
            'rangeThumbShape',
            'RangeSliderThumbShape',
            'Shape used for range slider thumbs',
          ),
          buildPropertyRow(
            'thumbColor',
            'Color',
            'Fill color of the thumb circle',
          ),
          buildPropertyRow(
            'overlayColor',
            'Color',
            'Semi-transparent overlay on press',
          ),
          buildPropertyRow(
            'overlappingShapeStrokeColor',
            'Color',
            'Stroke when thumbs overlap',
          ),

          buildSubHeader('SliderThemeData Track Properties'),
          buildPropertyRow(
            'activeTrackColor',
            'Color',
            'Track color between the two thumbs',
          ),
          buildPropertyRow(
            'inactiveTrackColor',
            'Color',
            'Track color outside the two thumbs',
          ),
          buildPropertyRow(
            'trackHeight',
            'double',
            'Height of the slider track (default: 2.0)',
          ),

          buildSubHeader('SliderThemeData Tick Mark Properties'),
          buildPropertyRow(
            'activeTickMarkColor',
            'Color',
            'Tick mark color in active region',
          ),
          buildPropertyRow(
            'inactiveTickMarkColor',
            'Color',
            'Tick mark color in inactive region',
          ),
          buildPropertyRow(
            'rangeTickMarkShape',
            'RangeSliderTickMarkShape',
            'Shape of tick marks for range sliders',
          ),

          buildSubHeader('RangeSlider Widget Properties'),
          buildPropertyRow(
            'values',
            'RangeValues',
            'Current start and end values of the range',
          ),
          buildPropertyRow(
            'min',
            'double',
            'Minimum allowed value (default: 0.0)',
          ),
          buildPropertyRow(
            'max',
            'double',
            'Maximum allowed value (default: 1.0)',
          ),
          buildPropertyRow(
            'divisions',
            'int?',
            'Number of discrete intervals for snapping',
          ),
          buildPropertyRow(
            'labels',
            'RangeLabels?',
            'Text labels shown above thumbs',
          ),
          buildPropertyRow(
            'onChanged',
            'ValueChanged?',
            'Callback when range changes; null disables slider',
          ),

          buildSubHeader('Color Reference Swatches'),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                buildColorSwatch(Color(0xFF0D47A1), 'Blue'),
                buildColorSwatch(Color(0xFF1B5E20), 'Green'),
                buildColorSwatch(Color(0xFFBF360C), 'Orange'),
                buildColorSwatch(Color(0xFF4A148C), 'Purple'),
                buildColorSwatch(Color(0xFF004D40), 'Teal'),
                buildColorSwatch(Color(0xFFB71C1C), 'Red'),
                buildColorSwatch(Color(0xFF880E4F), 'Pink'),
                buildColorSwatch(Color(0xFF1A237E), 'Indigo'),
              ],
            ),
          ),

          // Section 10: Summary and notes
          buildSectionHeader('10. Summary and Notes'),
          buildNoteBox(
            'RoundRangeSliderThumbShape is the default and most common thumb shape for RangeSlider widgets. '
            'It renders a filled circle with configurable radius, elevation, and shadow. '
            'Custom colors and overlay effects are applied via SliderThemeData wrapping.',
            Color(0xFFE8F5E9),
          ),
          buildInfoCard('Primary Class', 'RoundRangeSliderThumbShape'),
          buildInfoCard('Parent Class', 'RangeSliderThumbShape'),
          buildInfoCard('Default Radius', '10.0 logical pixels'),
          buildInfoCard('Theme Wrapper', 'SliderTheme with SliderThemeData'),
          buildInfoCard('Range Type', 'RangeValues(start, end)'),
          buildInfoCard(
            'Disabled Behavior',
            'Uses disabledThumbRadius or falls back to enabledThumbRadius',
          ),
          buildInfoCard(
            'Overlay Effect',
            'Semi-transparent circle on touch/press via overlayColor',
          ),
          buildInfoCard('Elevation', 'Subtle shadow that increases on press'),
          buildInfoCard(
            'Customization Scope',
            'Shape, size, color, overlay, track, tick marks',
          ),
          buildInfoCard(
            'Use Cases',
            'Price range filters, time range selection, data range picking',
          ),
          buildNoteBox(
            'Note: HandleRangeSliderThumbShape is not a standard Flutter class. '
            'This demo uses RoundRangeSliderThumbShape which is the built-in implementation '
            'of RangeSliderThumbShape for circular thumb rendering in RangeSlider widgets.',
            Color(0xFFFFF9C4),
          ),

          SizedBox(height: 32.0),
        ],
      ),
    ),
  );
}
