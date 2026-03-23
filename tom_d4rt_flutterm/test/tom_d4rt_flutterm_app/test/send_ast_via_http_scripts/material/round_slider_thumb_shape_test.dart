// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RoundSliderThumbShape from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.indigo.shade700,
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

Widget buildSliderWithRoundThumb(
  String label,
  Color activeColor,
  Color thumbColor,
  double initialValue,
  double enabledRadius,
) {
  print('Building slider with round thumb: $label');
  return Container(
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
          label,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Enabled Radius: $enabledRadius',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: enabledRadius),
            activeTrackColor: activeColor,
            inactiveTrackColor: activeColor.withAlpha(60),
            thumbColor: thumbColor,
            trackHeight: 4,
          ),
          child: Slider(
            value: initialValue,
            min: 0,
            max: 100,
            onChanged: (double val) {},
          ),
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '0',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            ),
            Text(
              'Value: ${initialValue.toInt()}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: activeColor,
              ),
            ),
            Text(
              '100',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildSliderWithDisabledRadius(
  String label,
  Color activeColor,
  double enabledRadius,
  double disabledRadius,
  bool isEnabled,
) {
  print('Building slider with disabled radius: $label, enabled: $isEnabled');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: isEnabled ? Colors.white : Colors.grey.shade200,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: isEnabled ? Colors.grey.shade300 : Colors.grey.shade400,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isEnabled ? Colors.green.shade100 : Colors.red.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                isEnabled ? 'ENABLED' : 'DISABLED',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: isEnabled ? Colors.green.shade700 : Colors.red.shade700,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Enabled: $enabledRadius, Disabled: $disabledRadius',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: enabledRadius,
              disabledThumbRadius: disabledRadius,
            ),
            activeTrackColor: activeColor,
            inactiveTrackColor: activeColor.withAlpha(60),
            disabledActiveTrackColor: Colors.grey.shade400,
            disabledInactiveTrackColor: Colors.grey.shade300,
            disabledThumbColor: Colors.grey.shade500,
            trackHeight: 4,
          ),
          child: Slider(
            value: 50,
            min: 0,
            max: 100,
            onChanged: isEnabled ? (double val) {} : null,
          ),
        ),
      ],
    ),
  );
}

Widget buildSliderWithElevation(
  String label,
  Color activeColor,
  double elevation,
  double pressedElevation,
  double thumbRadius,
) {
  print('Building slider with elevation: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withAlpha(40),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Elevation: $elevation, Pressed: $pressedElevation',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: thumbRadius,
              elevation: elevation,
              pressedElevation: pressedElevation,
            ),
            activeTrackColor: activeColor,
            inactiveTrackColor: activeColor.withAlpha(60),
            thumbColor: activeColor,
            trackHeight: 4,
          ),
          child: Slider(
            value: 60,
            min: 0,
            max: 100,
            onChanged: (double val) {},
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.info_outline, size: 14, color: Colors.grey.shade600),
            SizedBox(width: 4),
            Expanded(
              child: Text(
                'Press and hold to see elevated shadow effect',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildColorfulThumbSlider(
  String label,
  Color thumbColor,
  Color overlayColor,
  double value,
) {
  print('Building colorful thumb slider: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: thumbColor.withAlpha(100)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: thumbColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: thumbColor.withAlpha(80),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
            activeTrackColor: thumbColor,
            inactiveTrackColor: thumbColor.withAlpha(40),
            thumbColor: thumbColor,
            overlayColor: overlayColor.withAlpha(40),
            trackHeight: 6,
          ),
          child: Slider(
            value: value,
            min: 0,
            max: 100,
            onChanged: (double val) {},
          ),
        ),
      ],
    ),
  );
}

Widget buildThemeCustomizedSlider(
  String label,
  SliderThemeData themeData,
  double value,
  String description,
) {
  print('Building theme customized slider: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: themeData,
          child: Slider(
            value: value,
            min: 0,
            max: 100,
            onChanged: (double val) {},
          ),
        ),
      ],
    ),
  );
}

Widget buildComparisonSliders(
  String title,
  List<double> radiusValues,
  Color baseColor,
) {
  print('Building comparison sliders: $title');
  return Container(
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
          title,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        ...radiusValues.map((radius) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  child: Text(
                    '${radius.toInt()}px',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
                Expanded(
                  child: SliderTheme(
                    data: SliderThemeData(
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: radius),
                      activeTrackColor: baseColor,
                      inactiveTrackColor: baseColor.withAlpha(40),
                      thumbColor: baseColor,
                      trackHeight: 3,
                    ),
                    child: Slider(
                      value: 50,
                      min: 0,
                      max: 100,
                      onChanged: (double val) {},
                    ),
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

void main() {
  print('=== RoundSliderThumbShape Deep Demo ===');
  print('Testing the default round thumb shape for Slider');

  runApp(
    MaterialApp(
      title: 'RoundSliderThumbShape Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey.shade100,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('RoundSliderThumbShape Demo'),
          backgroundColor: Colors.indigo.shade700,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildInfoCard(
                'Widget:',
                'RoundSliderThumbShape - The default round thumb shape for Slider',
              ),
              buildInfoCard(
                'Purpose:',
                'Provides a circular thumb that users can drag to select values',
              ),
              buildInfoCard(
                'Key Properties:',
                'enabledThumbRadius, disabledThumbRadius, elevation, pressedElevation',
              ),

              buildSectionHeader('Basic Sliders with Round Thumb'),
              buildSliderWithRoundThumb(
                'Default Round Thumb',
                Colors.indigo,
                Colors.indigo,
                40,
                10,
              ),
              buildSliderWithRoundThumb(
                'Blue Slider',
                Colors.blue,
                Colors.blue.shade700,
                55,
                10,
              ),
              buildSliderWithRoundThumb(
                'Green Slider',
                Colors.green,
                Colors.green.shade700,
                70,
                10,
              ),
              buildSliderWithRoundThumb(
                'Orange Slider',
                Colors.orange,
                Colors.orange.shade700,
                35,
                10,
              ),
              buildSliderWithRoundThumb(
                'Purple Slider',
                Colors.purple,
                Colors.purple.shade700,
                80,
                10,
              ),

              buildSectionHeader('enabledThumbRadius Variations'),
              buildComparisonSliders(
                'Thumb Radius Comparison',
                [6, 8, 10, 12, 14, 16, 20],
                Colors.teal,
              ),
              buildSliderWithRoundThumb(
                'Extra Small Thumb (6px)',
                Colors.cyan,
                Colors.cyan.shade700,
                45,
                6,
              ),
              buildSliderWithRoundThumb(
                'Small Thumb (8px)',
                Colors.lightBlue,
                Colors.lightBlue.shade700,
                50,
                8,
              ),
              buildSliderWithRoundThumb(
                'Standard Thumb (10px)',
                Colors.blue,
                Colors.blue.shade700,
                55,
                10,
              ),
              buildSliderWithRoundThumb(
                'Medium Thumb (12px)',
                Colors.indigo,
                Colors.indigo.shade700,
                60,
                12,
              ),
              buildSliderWithRoundThumb(
                'Large Thumb (14px)',
                Colors.deepPurple,
                Colors.deepPurple.shade700,
                65,
                14,
              ),
              buildSliderWithRoundThumb(
                'Extra Large Thumb (18px)',
                Colors.purple,
                Colors.purple.shade700,
                70,
                18,
              ),
              buildSliderWithRoundThumb(
                'Huge Thumb (24px)',
                Colors.pink,
                Colors.pink.shade700,
                75,
                24,
              ),

              buildSectionHeader('disabledThumbRadius Variations'),
              buildSliderWithDisabledRadius(
                'Enabled State - Normal Size',
                Colors.blue,
                12,
                8,
                true,
              ),
              buildSliderWithDisabledRadius(
                'Disabled State - Reduced Size',
                Colors.blue,
                12,
                8,
                false,
              ),
              buildSliderWithDisabledRadius(
                'Enabled - Large Thumb',
                Colors.green,
                16,
                10,
                true,
              ),
              buildSliderWithDisabledRadius(
                'Disabled - Large Thumb Shrinks',
                Colors.green,
                16,
                10,
                false,
              ),
              buildSliderWithDisabledRadius(
                'Enabled - Same Size',
                Colors.orange,
                12,
                12,
                true,
              ),
              buildSliderWithDisabledRadius(
                'Disabled - Same Size (No Change)',
                Colors.orange,
                12,
                12,
                false,
              ),
              buildSliderWithDisabledRadius(
                'Tiny Disabled Thumb',
                Colors.red,
                14,
                4,
                false,
              ),

              buildSectionHeader('Elevation Settings'),
              buildSliderWithElevation(
                'No Elevation',
                Colors.grey,
                0,
                0,
                10,
              ),
              buildSliderWithElevation(
                'Low Elevation (1.0)',
                Colors.blue,
                1,
                2,
                10,
              ),
              buildSliderWithElevation(
                'Default Elevation (2.0)',
                Colors.indigo,
                2,
                6,
                10,
              ),
              buildSliderWithElevation(
                'Medium Elevation (4.0)',
                Colors.purple,
                4,
                8,
                12,
              ),
              buildSliderWithElevation(
                'High Elevation (6.0)',
                Colors.deepPurple,
                6,
                12,
                14,
              ),
              buildSliderWithElevation(
                'Very High Elevation (8.0)',
                Colors.pink,
                8,
                16,
                16,
              ),

              buildSectionHeader('pressedElevation Effects'),
              buildSliderWithElevation(
                'No Pressed Effect',
                Colors.teal,
                2,
                2,
                10,
              ),
              buildSliderWithElevation(
                'Subtle Press (4.0)',
                Colors.cyan,
                2,
                4,
                10,
              ),
              buildSliderWithElevation(
                'Standard Press (6.0)',
                Colors.lightBlue,
                2,
                6,
                10,
              ),
              buildSliderWithElevation(
                'Strong Press (10.0)',
                Colors.blue,
                2,
                10,
                12,
              ),
              buildSliderWithElevation(
                'Dramatic Press (16.0)',
                Colors.indigo,
                2,
                16,
                14,
              ),
              buildSliderWithElevation(
                'Maximum Press (24.0)',
                Colors.deepPurple,
                4,
                24,
                16,
              ),

              buildSectionHeader('Thumb Colors'),
              buildColorfulThumbSlider(
                'Red Thumb',
                Colors.red,
                Colors.red,
                30,
              ),
              buildColorfulThumbSlider(
                'Pink Thumb',
                Colors.pink,
                Colors.pink,
                40,
              ),
              buildColorfulThumbSlider(
                'Purple Thumb',
                Colors.purple,
                Colors.purple,
                50,
              ),
              buildColorfulThumbSlider(
                'Deep Purple Thumb',
                Colors.deepPurple,
                Colors.deepPurple,
                60,
              ),
              buildColorfulThumbSlider(
                'Indigo Thumb',
                Colors.indigo,
                Colors.indigo,
                70,
              ),
              buildColorfulThumbSlider(
                'Blue Thumb',
                Colors.blue,
                Colors.blue,
                55,
              ),
              buildColorfulThumbSlider(
                'Light Blue Thumb',
                Colors.lightBlue,
                Colors.lightBlue,
                45,
              ),
              buildColorfulThumbSlider(
                'Cyan Thumb',
                Colors.cyan,
                Colors.cyan,
                65,
              ),
              buildColorfulThumbSlider(
                'Teal Thumb',
                Colors.teal,
                Colors.teal,
                35,
              ),
              buildColorfulThumbSlider(
                'Green Thumb',
                Colors.green,
                Colors.green,
                75,
              ),
              buildColorfulThumbSlider(
                'Light Green Thumb',
                Colors.lightGreen,
                Colors.lightGreen,
                80,
              ),
              buildColorfulThumbSlider(
                'Lime Thumb',
                Colors.lime,
                Colors.lime,
                25,
              ),
              buildColorfulThumbSlider(
                'Yellow Thumb',
                Colors.yellow.shade700,
                Colors.yellow,
                85,
              ),
              buildColorfulThumbSlider(
                'Amber Thumb',
                Colors.amber,
                Colors.amber,
                90,
              ),
              buildColorfulThumbSlider(
                'Orange Thumb',
                Colors.orange,
                Colors.orange,
                20,
              ),
              buildColorfulThumbSlider(
                'Deep Orange Thumb',
                Colors.deepOrange,
                Colors.deepOrange,
                15,
              ),
              buildColorfulThumbSlider(
                'Brown Thumb',
                Colors.brown,
                Colors.brown,
                50,
              ),
              buildColorfulThumbSlider(
                'Grey Thumb',
                Colors.grey,
                Colors.grey,
                60,
              ),
              buildColorfulThumbSlider(
                'Blue Grey Thumb',
                Colors.blueGrey,
                Colors.blueGrey,
                40,
              ),

              buildSectionHeader('SliderTheme Customization'),
              buildThemeCustomizedSlider(
                'Minimal Theme',
                SliderThemeData(
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
                  activeTrackColor: Colors.grey.shade600,
                  inactiveTrackColor: Colors.grey.shade300,
                  thumbColor: Colors.grey.shade700,
                  trackHeight: 2,
                ),
                40,
                'Simple grey styling with thin track',
              ),
              buildThemeCustomizedSlider(
                'Bold Theme',
                SliderThemeData(
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 16,
                    elevation: 4,
                    pressedElevation: 10,
                  ),
                  activeTrackColor: Colors.red.shade600,
                  inactiveTrackColor: Colors.red.shade200,
                  thumbColor: Colors.red.shade700,
                  trackHeight: 8,
                ),
                65,
                'Large thumb with thick track and shadows',
              ),
              buildThemeCustomizedSlider(
                'Gradient-like Theme',
                SliderThemeData(
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
                  activeTrackColor: Colors.purple,
                  inactiveTrackColor: Colors.pink.shade200,
                  thumbColor: Colors.deepPurple,
                  overlayColor: Colors.purple.withAlpha(30),
                  trackHeight: 5,
                ),
                55,
                'Purple active with pink inactive track',
              ),
              buildThemeCustomizedSlider(
                'Dark Theme',
                SliderThemeData(
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 10,
                    elevation: 2,
                  ),
                  activeTrackColor: Colors.white,
                  inactiveTrackColor: Colors.white.withAlpha(80),
                  thumbColor: Colors.white,
                  overlayColor: Colors.white.withAlpha(20),
                  trackHeight: 4,
                ),
                70,
                'White on dark - for dark mode interfaces',
              ),
              buildThemeCustomizedSlider(
                'Neon Theme',
                SliderThemeData(
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 14,
                    elevation: 6,
                    pressedElevation: 12,
                  ),
                  activeTrackColor: Colors.greenAccent.shade400,
                  inactiveTrackColor: Colors.greenAccent.shade100,
                  thumbColor: Colors.greenAccent.shade700,
                  overlayColor: Colors.greenAccent.withAlpha(50),
                  trackHeight: 6,
                ),
                45,
                'Bright neon green with glow effect',
              ),
              buildThemeCustomizedSlider(
                'Soft Theme',
                SliderThemeData(
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 10,
                    elevation: 1,
                  ),
                  activeTrackColor: Colors.blue.shade300,
                  inactiveTrackColor: Colors.blue.shade100,
                  thumbColor: Colors.blue.shade400,
                  overlayColor: Colors.blue.withAlpha(20),
                  trackHeight: 4,
                ),
                35,
                'Soft blue tones for gentle interfaces',
              ),
              buildThemeCustomizedSlider(
                'High Contrast Theme',
                SliderThemeData(
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 12,
                    elevation: 3,
                  ),
                  activeTrackColor: Colors.black,
                  inactiveTrackColor: Colors.grey.shade400,
                  thumbColor: Colors.black,
                  overlayColor: Colors.black.withAlpha(20),
                  trackHeight: 6,
                ),
                60,
                'Black and white for accessibility',
              ),
              buildThemeCustomizedSlider(
                'Golden Theme',
                SliderThemeData(
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 14,
                    elevation: 4,
                    pressedElevation: 8,
                  ),
                  activeTrackColor: Colors.amber.shade600,
                  inactiveTrackColor: Colors.amber.shade200,
                  thumbColor: Colors.amber.shade700,
                  overlayColor: Colors.amber.withAlpha(40),
                  trackHeight: 5,
                ),
                80,
                'Premium golden appearance',
              ),
              buildThemeCustomizedSlider(
                'Ocean Theme',
                SliderThemeData(
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 11,
                    elevation: 2,
                  ),
                  activeTrackColor: Colors.cyan.shade600,
                  inactiveTrackColor: Colors.cyan.shade200,
                  thumbColor: Colors.teal.shade600,
                  overlayColor: Colors.cyan.withAlpha(30),
                  trackHeight: 4,
                ),
                50,
                'Cool ocean-inspired colors',
              ),
              buildThemeCustomizedSlider(
                'Sunset Theme',
                SliderThemeData(
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 12,
                    elevation: 3,
                    pressedElevation: 8,
                  ),
                  activeTrackColor: Colors.orange.shade600,
                  inactiveTrackColor: Colors.red.shade200,
                  thumbColor: Colors.deepOrange,
                  overlayColor: Colors.orange.withAlpha(40),
                  trackHeight: 5,
                ),
                75,
                'Warm sunset gradient colors',
              ),
              buildThemeCustomizedSlider(
                'Forest Theme',
                SliderThemeData(
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 10,
                    elevation: 2,
                  ),
                  activeTrackColor: Colors.green.shade700,
                  inactiveTrackColor: Colors.green.shade200,
                  thumbColor: Colors.green.shade800,
                  overlayColor: Colors.green.withAlpha(30),
                  trackHeight: 4,
                ),
                55,
                'Natural forest green tones',
              ),
              buildThemeCustomizedSlider(
                'Lavender Theme',
                SliderThemeData(
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 11,
                    elevation: 2,
                  ),
                  activeTrackColor: Colors.purple.shade400,
                  inactiveTrackColor: Colors.purple.shade100,
                  thumbColor: Colors.purple.shade500,
                  overlayColor: Colors.purple.withAlpha(25),
                  trackHeight: 4,
                ),
                65,
                'Calming lavender purple shades',
              ),
              buildThemeCustomizedSlider(
                'Industrial Theme',
                SliderThemeData(
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 8,
                    elevation: 1,
                  ),
                  activeTrackColor: Colors.blueGrey.shade600,
                  inactiveTrackColor: Colors.blueGrey.shade300,
                  thumbColor: Colors.blueGrey.shade700,
                  overlayColor: Colors.blueGrey.withAlpha(30),
                  trackHeight: 3,
                ),
                45,
                'Professional industrial appearance',
              ),
              buildThemeCustomizedSlider(
                'Cherry Theme',
                SliderThemeData(
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 13,
                    elevation: 3,
                    pressedElevation: 7,
                  ),
                  activeTrackColor: Colors.red.shade400,
                  inactiveTrackColor: Colors.pink.shade100,
                  thumbColor: Colors.red.shade600,
                  overlayColor: Colors.red.withAlpha(35),
                  trackHeight: 5,
                ),
                70,
                'Vibrant cherry red styling',
              ),

              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.indigo.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'RoundSliderThumbShape Summary',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo.shade700,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'RoundSliderThumbShape is the default thumb shape for Flutter sliders. '
                      'It supports customization of radius for enabled and disabled states, '
                      'as well as elevation and pressed elevation for shadow effects. '
                      'Combined with SliderThemeData, it allows for highly customized slider appearances.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Chip(
                          label: Text('enabledThumbRadius'),
                          backgroundColor: Colors.indigo.shade100,
                        ),
                        Chip(
                          label: Text('disabledThumbRadius'),
                          backgroundColor: Colors.indigo.shade100,
                        ),
                        Chip(
                          label: Text('elevation'),
                          backgroundColor: Colors.indigo.shade100,
                        ),
                        Chip(
                          label: Text('pressedElevation'),
                          backgroundColor: Colors.indigo.shade100,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ),
  );
}
