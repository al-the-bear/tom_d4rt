// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RoundSliderTickMarkShape from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.teal.shade700,
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

Widget buildSliderWithTickMarks(
  String label,
  Color activeColor,
  int divisions,
  double initialValue,
  double tickMarkRadius,
) {
  print('Building slider with tick marks: $label, divisions: $divisions');
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
          'Divisions: $divisions, Tick Radius: $tickMarkRadius',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: tickMarkRadius),
            activeTrackColor: activeColor,
            inactiveTrackColor: activeColor.withAlpha(60),
            activeTickMarkColor: Colors.white,
            inactiveTickMarkColor: activeColor.withAlpha(120),
            thumbColor: activeColor,
            trackHeight: 4,
          ),
          child: Slider(
            value: initialValue,
            min: 0,
            max: 100,
            divisions: divisions,
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

Widget buildSliderWithCustomTickColors(
  String label,
  Color activeTickColor,
  Color inactiveTickColor,
  Color trackColor,
  int divisions,
  double value,
) {
  print('Building slider with custom tick colors: $label');
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
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: activeTickColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 4),
            Text(
              'Active',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
            SizedBox(width: 12),
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: inactiveTickColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 4),
            Text(
              'Inactive',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
          ],
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 2.5),
            activeTrackColor: trackColor,
            inactiveTrackColor: trackColor.withAlpha(80),
            activeTickMarkColor: activeTickColor,
            inactiveTickMarkColor: inactiveTickColor,
            thumbColor: trackColor,
            trackHeight: 6,
          ),
          child: Slider(
            value: value,
            min: 0,
            max: 100,
            divisions: divisions,
            onChanged: (double val) {},
          ),
        ),
      ],
    ),
  );
}

Widget buildSliderWithVariousDivisions(
  String label,
  int divisions,
  Color primaryColor,
  double tickRadius,
) {
  print('Building slider with $divisions divisions');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: primaryColor.withAlpha(80)),
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
                color: primaryColor.withAlpha(30),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '$divisions divisions',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: tickRadius),
            activeTrackColor: primaryColor,
            inactiveTrackColor: primaryColor.withAlpha(60),
            activeTickMarkColor: Colors.white,
            inactiveTickMarkColor: primaryColor.withAlpha(150),
            thumbColor: primaryColor,
            trackHeight: 5,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
          ),
          child: Slider(
            value: 50,
            min: 0,
            max: 100,
            divisions: divisions,
            onChanged: (double val) {},
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Step size: ${(100 / divisions).toStringAsFixed(1)}',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

Widget buildSliderThemeShowcase(
  String themeName,
  SliderThemeData themeData,
  int divisions,
  double value,
  String description,
) {
  print('Building themed slider: $themeName');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withAlpha(30),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          themeName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
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
            divisions: divisions,
            onChanged: (double val) {},
          ),
        ),
      ],
    ),
  );
}

Widget buildTickMarkRadiusComparison(
  String label,
  double radius,
  Color color,
) {
  print('Building tick mark radius comparison: $radius');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(50)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: radius * 4,
              height: radius * 4,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8),
            Text(
              '$label (radius: $radius)',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        SliderTheme(
          data: SliderThemeData(
            tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: radius),
            activeTrackColor: color,
            inactiveTrackColor: color.withAlpha(60),
            activeTickMarkColor: Colors.white,
            inactiveTickMarkColor: color.withAlpha(120),
            thumbColor: color,
            trackHeight: 4,
          ),
          child: Slider(
            value: 40,
            min: 0,
            max: 100,
            divisions: 10,
            onChanged: (double val) {},
          ),
        ),
      ],
    ),
  );
}

Widget buildDivisionCountDemo(int count, Color color) {
  print('Building division count demo: $count');
  String getDivisionLabel(int c) {
    if (c <= 4) return 'Few';
    if (c <= 10) return 'Medium';
    if (c <= 20) return 'Many';
    return 'Dense';
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$count Divisions',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: color.withAlpha(30),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                getDivisionLabel(count),
                style: TextStyle(fontSize: 10, color: color),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        SliderTheme(
          data: SliderThemeData(
            tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 2),
            activeTrackColor: color,
            inactiveTrackColor: color.withAlpha(60),
            activeTickMarkColor: Colors.white,
            inactiveTickMarkColor: color.withAlpha(100),
            thumbColor: color,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7),
            trackHeight: 4,
          ),
          child: Slider(
            value: 50,
            min: 0,
            max: 100,
            divisions: count,
            onChanged: (double val) {},
          ),
        ),
      ],
    ),
  );
}

Widget buildColorSchemeSlider(
  String name,
  Color activeTrack,
  Color inactiveTrack,
  Color activeTick,
  Color inactiveTick,
  Color thumb,
) {
  print('Building color scheme slider: $name');
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
          name,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            buildColorDot(activeTrack, 'Track'),
            SizedBox(width: 12),
            buildColorDot(activeTick, 'Active Tick'),
            SizedBox(width: 12),
            buildColorDot(inactiveTick, 'Inactive Tick'),
          ],
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 2.5),
            activeTrackColor: activeTrack,
            inactiveTrackColor: inactiveTrack,
            activeTickMarkColor: activeTick,
            inactiveTickMarkColor: inactiveTick,
            thumbColor: thumb,
            trackHeight: 6,
          ),
          child: Slider(
            value: 60,
            min: 0,
            max: 100,
            divisions: 10,
            onChanged: (double val) {},
          ),
        ),
      ],
    ),
  );
}

Widget buildColorDot(Color color, String label) {
  return Row(
    children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade400, width: 0.5),
        ),
      ),
      SizedBox(width: 4),
      Text(
        label,
        style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
      ),
    ],
  );
}

Widget buildSliderWithLabelsAndTicks(
  String title,
  List<String> labels,
  Color color,
  double value,
) {
  print('Building labeled slider: $title');
  int divisions = labels.length - 1;
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
        SliderTheme(
          data: SliderThemeData(
            tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 3),
            activeTrackColor: color,
            inactiveTrackColor: color.withAlpha(60),
            activeTickMarkColor: Colors.white,
            inactiveTickMarkColor: color.withAlpha(120),
            thumbColor: color,
            trackHeight: 6,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
          ),
          child: Slider(
            value: value,
            min: 0,
            max: 100,
            divisions: divisions,
            onChanged: (double val) {},
          ),
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: labels
              .map(
                (lbl) => Text(
                  lbl,
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                ),
              )
              .toList(),
        ),
      ],
    ),
  );
}

Widget buildDisabledSliderWithTicks(
  String label,
  Color color,
  int divisions,
  bool enabled,
) {
  print('Building disabled slider: $label, enabled: $enabled');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: enabled ? Colors.white : Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: enabled ? Colors.grey.shade300 : Colors.grey.shade400,
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
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: enabled ? Colors.green.shade100 : Colors.red.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                enabled ? 'ENABLED' : 'DISABLED',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: enabled ? Colors.green.shade700 : Colors.red.shade700,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 2),
            activeTrackColor: color,
            inactiveTrackColor: color.withAlpha(60),
            activeTickMarkColor: Colors.white,
            inactiveTickMarkColor: color.withAlpha(100),
            disabledActiveTrackColor: Colors.grey.shade400,
            disabledInactiveTrackColor: Colors.grey.shade300,
            disabledActiveTickMarkColor: Colors.grey.shade500,
            disabledInactiveTickMarkColor: Colors.grey.shade400,
            disabledThumbColor: Colors.grey.shade500,
            thumbColor: color,
            trackHeight: 4,
          ),
          child: Slider(
            value: 50,
            min: 0,
            max: 100,
            divisions: divisions,
            onChanged: enabled ? (double val) {} : null,
          ),
        ),
      ],
    ),
  );
}

Widget build(BuildContext context) {
  print('Building RoundSliderTickMarkShape demo');
  print('RoundSliderTickMarkShape is the default tick mark shape for sliders with divisions');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('RoundSliderTickMarkShape Demo'),
        backgroundColor: Colors.teal.shade700,
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildInfoCard(
                'Component',
                'RoundSliderTickMarkShape - Default round tick marks for discrete sliders',
              ),
              buildInfoCard(
                'Primary Use',
                'Display visual indicators at division points on slider track',
              ),
              buildInfoCard(
                'Key Property',
                'tickMarkRadius - Controls the size of each tick mark',
              ),

              buildSectionHeader('1. Slider with Divisions and Tick Marks'),
              buildSliderWithTickMarks(
                'Standard Tick Marks',
                Colors.blue,
                10,
                50,
                2,
              ),
              buildSliderWithTickMarks(
                'More Divisions',
                Colors.green,
                20,
                35,
                2,
              ),
              buildSliderWithTickMarks(
                'Larger Tick Radius',
                Colors.orange,
                8,
                60,
                3.5,
              ),
              buildSliderWithTickMarks(
                'Small Tick Radius',
                Colors.purple,
                15,
                75,
                1.5,
              ),

              buildSectionHeader('2. Tick Mark Radius Comparison'),
              buildTickMarkRadiusComparison('Extra Small', 1, Colors.indigo),
              buildTickMarkRadiusComparison('Small', 1.5, Colors.blue),
              buildTickMarkRadiusComparison('Default', 2, Colors.teal),
              buildTickMarkRadiusComparison('Medium', 2.5, Colors.green),
              buildTickMarkRadiusComparison('Large', 3, Colors.orange),
              buildTickMarkRadiusComparison('Extra Large', 4, Colors.red),

              buildSectionHeader('3. Active/Inactive Tick Colors'),
              buildSliderWithCustomTickColors(
                'White Active / Gray Inactive',
                Colors.white,
                Colors.grey.shade400,
                Colors.blue,
                10,
                40,
              ),
              buildSliderWithCustomTickColors(
                'Yellow Active / Dark Inactive',
                Colors.yellow,
                Colors.brown.shade300,
                Colors.brown,
                8,
                65,
              ),
              buildSliderWithCustomTickColors(
                'Cyan Active / Navy Inactive',
                Colors.cyan,
                Colors.indigo.shade300,
                Colors.indigo,
                12,
                30,
              ),
              buildSliderWithCustomTickColors(
                'Pink Active / Purple Inactive',
                Colors.pink.shade200,
                Colors.purple.shade200,
                Colors.purple,
                6,
                80,
              ),

              buildSectionHeader('4. SliderTheme Configuration'),
              buildSliderThemeShowcase(
                'Material Design Theme',
                SliderThemeData(
                  tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 2),
                  activeTrackColor: Colors.blue,
                  inactiveTrackColor: Colors.blue.shade100,
                  activeTickMarkColor: Colors.white,
                  inactiveTickMarkColor: Colors.blue.shade300,
                  thumbColor: Colors.blue,
                  trackHeight: 4,
                ),
                10,
                50,
                'Standard Material Design slider appearance',
              ),
              buildSliderThemeShowcase(
                'iOS Style Theme',
                SliderThemeData(
                  tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 1.5),
                  activeTrackColor: Colors.green.shade400,
                  inactiveTrackColor: Colors.grey.shade300,
                  activeTickMarkColor: Colors.white.withAlpha(180),
                  inactiveTickMarkColor: Colors.grey.shade400,
                  thumbColor: Colors.white,
                  trackHeight: 3,
                ),
                12,
                60,
                'Clean iOS-inspired slider styling',
              ),
              buildSliderThemeShowcase(
                'Dark Mode Theme',
                SliderThemeData(
                  tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 2.5),
                  activeTrackColor: Colors.cyan,
                  inactiveTrackColor: Colors.grey.shade800,
                  activeTickMarkColor: Colors.cyan.shade200,
                  inactiveTickMarkColor: Colors.grey.shade600,
                  thumbColor: Colors.cyan,
                  trackHeight: 5,
                ),
                8,
                45,
                'Dark theme with cyan accent colors',
              ),
              buildSliderThemeShowcase(
                'High Contrast Theme',
                SliderThemeData(
                  tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 3),
                  activeTrackColor: Colors.black,
                  inactiveTrackColor: Colors.grey.shade400,
                  activeTickMarkColor: Colors.white,
                  inactiveTickMarkColor: Colors.black,
                  thumbColor: Colors.black,
                  trackHeight: 6,
                ),
                6,
                70,
                'High contrast for accessibility',
              ),
              buildSliderThemeShowcase(
                'Minimal Theme',
                SliderThemeData(
                  tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 1),
                  activeTrackColor: Colors.grey.shade600,
                  inactiveTrackColor: Colors.grey.shade300,
                  activeTickMarkColor: Colors.grey.shade400,
                  inactiveTickMarkColor: Colors.grey.shade400,
                  thumbColor: Colors.grey.shade700,
                  trackHeight: 2,
                ),
                15,
                35,
                'Subtle minimalist design',
              ),

              buildSectionHeader('5. Various Division Counts'),
              buildDivisionCountDemo(2, Colors.red),
              buildDivisionCountDemo(4, Colors.orange),
              buildDivisionCountDemo(5, Colors.amber),
              buildDivisionCountDemo(10, Colors.green),
              buildDivisionCountDemo(20, Colors.teal),
              buildDivisionCountDemo(25, Colors.blue),
              buildDivisionCountDemo(50, Colors.indigo),

              buildSectionHeader('6. Color Scheme Variations'),
              buildColorSchemeSlider(
                'Ocean Theme',
                Colors.blue.shade600,
                Colors.blue.shade200,
                Colors.white,
                Colors.blue.shade300,
                Colors.blue.shade700,
              ),
              buildColorSchemeSlider(
                'Forest Theme',
                Colors.green.shade700,
                Colors.green.shade200,
                Colors.yellow.shade200,
                Colors.green.shade400,
                Colors.green.shade800,
              ),
              buildColorSchemeSlider(
                'Sunset Theme',
                Colors.orange.shade600,
                Colors.orange.shade200,
                Colors.red.shade200,
                Colors.orange.shade400,
                Colors.deepOrange,
              ),
              buildColorSchemeSlider(
                'Lavender Theme',
                Colors.purple.shade500,
                Colors.purple.shade100,
                Colors.pink.shade100,
                Colors.purple.shade300,
                Colors.purple.shade600,
              ),
              buildColorSchemeSlider(
                'Monochrome Theme',
                Colors.grey.shade700,
                Colors.grey.shade300,
                Colors.white,
                Colors.grey.shade500,
                Colors.grey.shade800,
              ),

              buildSectionHeader('7. Labeled Sliders with Tick Marks'),
              buildSliderWithLabelsAndTicks(
                'Volume Control',
                ['Mute', 'Low', 'Med', 'High', 'Max'],
                Colors.blue,
                50,
              ),
              buildSliderWithLabelsAndTicks(
                'Temperature Setting',
                ['Cold', 'Cool', 'Normal', 'Warm', 'Hot'],
                Colors.red,
                60,
              ),
              buildSliderWithLabelsAndTicks(
                'Speed Rating',
                ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
                Colors.green,
                40,
              ),
              buildSliderWithLabelsAndTicks(
                'Brightness',
                ['Off', '25%', '50%', '75%', '100%'],
                Colors.amber,
                75,
              ),

              buildSectionHeader('8. Enabled vs Disabled States'),
              buildDisabledSliderWithTicks('Enabled Slider', Colors.teal, 10, true),
              buildDisabledSliderWithTicks('Disabled Slider', Colors.teal, 10, false),
              buildDisabledSliderWithTicks('Enabled Blue Slider', Colors.blue, 8, true),
              buildDisabledSliderWithTicks('Disabled Blue Slider', Colors.blue, 8, false),

              buildSectionHeader('9. Practical Use Cases'),
              buildSliderWithVariousDivisions(
                'Rating Scale (1-5)',
                5,
                Colors.amber,
                3,
              ),
              buildSliderWithVariousDivisions(
                'Percentage Steps (10%)',
                10,
                Colors.green,
                2,
              ),
              buildSliderWithVariousDivisions(
                'Fine Control (5%)',
                20,
                Colors.blue,
                1.5,
              ),
              buildSliderWithVariousDivisions(
                'Quarter Steps (25%)',
                4,
                Colors.orange,
                3.5,
              ),

              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.teal.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'RoundSliderTickMarkShape Summary',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade700,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'RoundSliderTickMarkShape is the default tick mark shape for Flutter sliders '
                      'when divisions are specified. Each tick mark appears as a small circle '
                      'positioned along the track. The tickMarkRadius property controls the size '
                      'of each dot. Combined with SliderThemeData, you can customize active and '
                      'inactive tick colors, track appearance, and overall slider theming.',
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
                          label: Text('tickMarkRadius'),
                          backgroundColor: Colors.teal.shade100,
                        ),
                        Chip(
                          label: Text('activeTickMarkColor'),
                          backgroundColor: Colors.teal.shade100,
                        ),
                        Chip(
                          label: Text('inactiveTickMarkColor'),
                          backgroundColor: Colors.teal.shade100,
                        ),
                        Chip(
                          label: Text('divisions'),
                          backgroundColor: Colors.teal.shade100,
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
