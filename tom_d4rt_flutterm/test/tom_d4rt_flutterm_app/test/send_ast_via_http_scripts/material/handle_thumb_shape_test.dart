// D4rt test script: Tests Slider thumb shape configurations from material
import 'package:flutter/material.dart';

Widget _buildSectionHeader(String title, Color bgColor) {
  print('Section: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: bgColor.withValues(alpha: 0.4),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Text(
      title,
      style: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    ),
  );
}

Widget _buildInfoCard(String title, String description, IconData icon, Color accentColor) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accentColor.withValues(alpha: 0.3), width: 1),
      boxShadow: [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: accentColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: accentColor, size: 24),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF212121),
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF616161),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildLabeledBox(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color, width: 1),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    ),
  );
}

Widget _buildColorSwatch(String label, Color color) {
  return Column(
    children: [
      Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.4),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
      ),
      SizedBox(height: 4),
      Text(
        label,
        style: TextStyle(fontSize: 9, color: Color(0xFF757575)),
      ),
    ],
  );
}

Widget _buildPropertyRow(String name, String value, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF424242),
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _buildDefaultSliderSection() {
  print('Building default Slider section - showing default thumb');
  double defaultVal = 0.5;
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0), width: 1),
      boxShadow: [
        BoxShadow(
          color: Color(0x0D000000),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.tune, color: Color(0xFF1976D2), size: 20),
            SizedBox(width: 8),
            Text(
              'Default Slider (Built-in Thumb)',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1976D2),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Standard Slider with the default RoundSliderThumbShape. The default enabledThumbRadius is 10.0.',
          style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
        ),
        SizedBox(height: 12),
        Slider(
          value: defaultVal,
          min: 0.0,
          max: 1.0,
          divisions: 10,
          label: 'Default',
          onChanged: (double v) {
            print('Default slider changed');
          },
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLabeledBox('Min: 0.0', Color(0xFF1976D2)),
            _buildLabeledBox('Value: 0.5', Color(0xFF388E3C)),
            _buildLabeledBox('Max: 1.0', Color(0xFF1976D2)),
          ],
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'The default thumb uses RoundSliderThumbShape with enabledThumbRadius of 10.0 and disabledThumbRadius of null (which defaults to enabledThumbRadius).',
            style: TextStyle(fontSize: 11, color: Color(0xFF616161), fontStyle: FontStyle.italic),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCustomThumbRadiusSection() {
  print('Building custom enabledThumbRadius section');
  double customVal = 0.7;
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF388E3C), width: 1),
      boxShadow: [
        BoxShadow(
          color: Color(0x1A388E3C),
          blurRadius: 8,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.radio_button_checked, color: Color(0xFF388E3C), size: 22),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Custom enabledThumbRadius: 16',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF388E3C),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Slider with RoundSliderThumbShape where enabledThumbRadius is set to 16.0 for a larger thumb.',
          style: TextStyle(fontSize: 12, color: Color(0xFF2E7D32)),
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: 16,
            ),
            activeTrackColor: Color(0xFF388E3C),
            inactiveTrackColor: Color(0xFFA5D6A7),
            thumbColor: Color(0xFF1B5E20),
            overlayColor: Color(0x29388E3C),
          ),
          child: Slider(
            value: customVal,
            min: 0.0,
            max: 1.0,
            divisions: 20,
            label: '0.7',
            onChanged: (double v) {
              print('Custom radius slider changed');
            },
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.info_outline, color: Color(0xFF388E3C), size: 16),
            SizedBox(width: 6),
            Expanded(
              child: Text(
                'The thumb appears 60% larger than the default. enabledThumbRadius controls the circle radius when the slider is enabled.',
                style: TextStyle(fontSize: 11, color: Color(0xFF2E7D32)),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLabeledBox('Radius: 16', Color(0xFF388E3C)),
            _buildLabeledBox('Default: 10', Color(0xFF757575)),
          ],
        ),
      ],
    ),
  );
}

Widget _buildThumbSizeComparisonSection() {
  print('Building thumb size comparison - tiny to large');

  List<Map<String, dynamic>> sizes = [
    {'label': 'Tiny (4)', 'radius': 4.0, 'value': 0.3, 'color': Color(0xFF0288D1)},
    {'label': 'Small (7)', 'radius': 7.0, 'value': 0.4, 'color': Color(0xFF00796B)},
    {'label': 'Default (10)', 'radius': 10.0, 'value': 0.5, 'color': Color(0xFF7B1FA2)},
    {'label': 'Medium (14)', 'radius': 14.0, 'value': 0.6, 'color': Color(0xFFC62828)},
    {'label': 'Large (18)', 'radius': 18.0, 'value': 0.7, 'color': Color(0xFFE65100)},
    {'label': 'Extra Large (24)', 'radius': 24.0, 'value': 0.8, 'color': Color(0xFF283593)},
  ];

  List<Widget> sliderWidgets = [];
  int i = 0;
  while (i < sizes.length) {
    Map<String, dynamic> entry = sizes[i];
    String label = entry['label'];
    double radius = entry['radius'];
    double val = entry['value'];
    Color color = entry['color'];
    print('  Thumb size: $label, radius: $radius');

    sliderWidgets.add(
      Padding(
        padding: EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'r=$radius',
                    style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            SliderTheme(
              data: SliderThemeData(
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: radius,
                ),
                activeTrackColor: color,
                inactiveTrackColor: color.withValues(alpha: 0.25),
                thumbColor: color,
                overlayColor: color.withValues(alpha: 0.16),
              ),
              child: Slider(
                value: val,
                min: 0.0,
                max: 1.0,
                onChanged: (double v) {
                  print('Size comparison slider changed');
                },
              ),
            ),
          ],
        ),
      ),
    );
    i = i + 1;
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFBDBDBD), width: 1),
      boxShadow: [
        BoxShadow(
          color: Color(0x0D000000),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows, color: Color(0xFF424242), size: 22),
            SizedBox(width: 8),
            Text(
              'Thumb Size Comparison (Tiny to Large)',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF424242),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Comparing enabledThumbRadius values from 4 to 24 across multiple sliders.',
          style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
        ),
        SizedBox(height: 14),
        Column(children: sliderWidgets),
      ],
    ),
  );
}

Widget _buildColoredThumbSection() {
  print('Building sliders with custom thumb + track colors');

  List<Map<String, dynamic>> themes = [
    {
      'name': 'Deep Ocean',
      'activeTrack': Color(0xFF0277BD),
      'inactiveTrack': Color(0xFF81D4FA),
      'thumb': Color(0xFF01579B),
      'overlay': Color(0x290277BD),
      'value': 0.4,
      'radius': 12.0,
    },
    {
      'name': 'Crimson Fire',
      'activeTrack': Color(0xFFC62828),
      'inactiveTrack': Color(0xFFEF9A9A),
      'thumb': Color(0xFFB71C1C),
      'overlay': Color(0x29C62828),
      'value': 0.6,
      'radius': 14.0,
    },
    {
      'name': 'Royal Purple',
      'activeTrack': Color(0xFF6A1B9A),
      'inactiveTrack': Color(0xFFCE93D8),
      'thumb': Color(0xFF4A148C),
      'overlay': Color(0x296A1B9A),
      'value': 0.5,
      'radius': 13.0,
    },
    {
      'name': 'Golden Amber',
      'activeTrack': Color(0xFFFF8F00),
      'inactiveTrack': Color(0xFFFFE082),
      'thumb': Color(0xFFFF6F00),
      'overlay': Color(0x29FF8F00),
      'value': 0.7,
      'radius': 11.0,
    },
  ];

  List<Widget> items = [];
  int j = 0;
  while (j < themes.length) {
    Map<String, dynamic> t = themes[j];
    String name = t['name'];
    Color activeTrack = t['activeTrack'];
    Color inactiveTrack = t['inactiveTrack'];
    Color thumb = t['thumb'];
    Color overlay = t['overlay'];
    double val = t['value'];
    double radius = t['radius'];
    print('  Color theme: $name, thumbRadius: $radius');

    items.add(
      Container(
        margin: EdgeInsets.only(bottom: 14),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: activeTrack.withValues(alpha: 0.3), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: activeTrack,
                  ),
                ),
                Row(
                  children: [
                    _buildColorSwatch('Track', activeTrack),
                    SizedBox(width: 8),
                    _buildColorSwatch('Thumb', thumb),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: radius,
                ),
                activeTrackColor: activeTrack,
                inactiveTrackColor: inactiveTrack,
                thumbColor: thumb,
                overlayColor: overlay,
              ),
              child: Slider(
                value: val,
                min: 0.0,
                max: 1.0,
                onChanged: (double v) {
                  print('Color themed slider changed: $name');
                },
              ),
            ),
          ],
        ),
      ),
    );
    j = j + 1;
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFCE4EC), Color(0xFFF3E5F5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFCE93D8), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.palette, color: Color(0xFF6A1B9A), size: 22),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Custom Thumb + Track Colors',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Sliders with varying thumb colors, track colors, and radii via SliderThemeData.',
          style: TextStyle(fontSize: 12, color: Color(0xFF7B1FA2)),
        ),
        SizedBox(height: 14),
        Column(children: items),
      ],
    ),
  );
}

Widget _buildEnabledVsDisabledSection() {
  print('Building enabled vs disabled thumb radius comparison');

  double enabledRadius = 14.0;
  double disabledRadius = 8.0;

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF546E7A), width: 1),
      boxShadow: [
        BoxShadow(
          color: Color(0x0D000000),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.toggle_on, color: Color(0xFF546E7A), size: 22),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Enabled vs Disabled Thumb Radius',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF546E7A),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'RoundSliderThumbShape supports separate radius for enabled and disabled states.',
          style: TextStyle(fontSize: 12, color: Color(0xFF78909C)),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFF4CAF50), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enabled Slider (radius: 14)',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2E7D32),
                ),
              ),
              SizedBox(height: 8),
              SliderTheme(
                data: SliderThemeData(
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: enabledRadius,
                    disabledThumbRadius: disabledRadius,
                  ),
                  activeTrackColor: Color(0xFF4CAF50),
                  inactiveTrackColor: Color(0xFFC8E6C9),
                  thumbColor: Color(0xFF2E7D32),
                  overlayColor: Color(0x294CAF50),
                ),
                child: Slider(
                  value: 0.65,
                  min: 0.0,
                  max: 1.0,
                  onChanged: (double v) {
                    print('Enabled slider changed');
                  },
                ),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  _buildLabeledBox('enabledThumbRadius: 14', Color(0xFF2E7D32)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFEFEBE9),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFF8D6E63), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Disabled Slider (radius: 8)',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5D4037),
                ),
              ),
              SizedBox(height: 8),
              SliderTheme(
                data: SliderThemeData(
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: enabledRadius,
                    disabledThumbRadius: disabledRadius,
                  ),
                  disabledActiveTrackColor: Color(0xFF8D6E63),
                  disabledInactiveTrackColor: Color(0xFFD7CCC8),
                  disabledThumbColor: Color(0xFF795548),
                ),
                child: Slider(
                  value: 0.65,
                  min: 0.0,
                  max: 1.0,
                  onChanged: null,
                ),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  _buildLabeledBox('disabledThumbRadius: 8', Color(0xFF5D4037)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Key difference:',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF424242)),
              ),
              SizedBox(height: 4),
              Text(
                'When disabled (onChanged is null), the thumb shrinks from radius 14 to radius 8. This provides a visual hint that the slider is not interactive.',
                style: TextStyle(fontSize: 11, color: Color(0xFF616161), fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildElevationSection() {
  print('Building thumb elevation section');

  List<Map<String, dynamic>> elevations = [
    {'label': 'No elevation (0)', 'elevation': 0.0, 'pressed': 0.0, 'color': Color(0xFF37474F), 'value': 0.3},
    {'label': 'Subtle (1)', 'elevation': 1.0, 'pressed': 4.0, 'color': Color(0xFF00695C), 'value': 0.4},
    {'label': 'Default (1)', 'elevation': 1.0, 'pressed': 6.0, 'color': Color(0xFF1565C0), 'value': 0.5},
    {'label': 'Medium (4)', 'elevation': 4.0, 'pressed': 8.0, 'color': Color(0xFF6A1B9A), 'value': 0.6},
    {'label': 'High (8)', 'elevation': 8.0, 'pressed': 12.0, 'color': Color(0xFFD84315), 'value': 0.7},
    {'label': 'Very High (12)', 'elevation': 12.0, 'pressed': 16.0, 'color': Color(0xFFC62828), 'value': 0.8},
  ];

  List<Widget> elevationWidgets = [];
  int k = 0;
  while (k < elevations.length) {
    Map<String, dynamic> e = elevations[k];
    String label = e['label'];
    double elev = e['elevation'];
    double pressed = e['pressed'];
    Color color = e['color'];
    double val = e['value'];
    print('  Elevation: $label, elev=$elev, pressed=$pressed');

    elevationWidgets.add(
      Padding(
        padding: EdgeInsets.only(bottom: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'elev=$elev',
                        style: TextStyle(fontSize: 9, color: color),
                      ),
                    ),
                    SizedBox(width: 4),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'pressed=$pressed',
                        style: TextStyle(fontSize: 9, color: color),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 4),
            SliderTheme(
              data: SliderThemeData(
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: 12,
                  elevation: elev,
                  pressedElevation: pressed,
                ),
                activeTrackColor: color,
                inactiveTrackColor: color.withValues(alpha: 0.25),
                thumbColor: color,
                overlayColor: color.withValues(alpha: 0.16),
              ),
              child: Slider(
                value: val,
                min: 0.0,
                max: 1.0,
                onChanged: (double v) {
                  print('Elevation slider changed: $label');
                },
              ),
            ),
          ],
        ),
      ),
    );
    k = k + 1;
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE3F2FD), Color(0xFFE8EAF6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF5C6BC0), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.layers, color: Color(0xFF3949AB), size: 22),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Thumb Elevation Values',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3949AB),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Elevation and pressedElevation properties of RoundSliderThumbShape control the shadow depth of the thumb.',
          style: TextStyle(fontSize: 12, color: Color(0xFF3F51B5)),
        ),
        SizedBox(height: 14),
        Column(children: elevationWidgets),
        SizedBox(height: 6),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'elevation is the shadow at rest. pressedElevation is the shadow when the user presses the thumb. Higher values produce a more prominent shadow.',
            style: TextStyle(fontSize: 11, color: Color(0xFF616161), fontStyle: FontStyle.italic),
          ),
        ),
      ],
    ),
  );
}

Widget _buildMultipleThemedSlidersSection() {
  print('Building multiple themed sliders section');

  List<Map<String, dynamic>> configs = [
    {
      'name': 'Compact Teal',
      'radius': 8.0,
      'disabledRadius': 5.0,
      'elevation': 2.0,
      'pressedElevation': 6.0,
      'activeColor': Color(0xFF00897B),
      'inactiveColor': Color(0xFF80CBC4),
      'thumbColor': Color(0xFF004D40),
      'value': 0.35,
    },
    {
      'name': 'Bold Red',
      'radius': 16.0,
      'disabledRadius': 10.0,
      'elevation': 4.0,
      'pressedElevation': 10.0,
      'activeColor': Color(0xFFD32F2F),
      'inactiveColor': Color(0xFFEF9A9A),
      'thumbColor': Color(0xFFB71C1C),
      'value': 0.55,
    },
    {
      'name': 'Soft Lavender',
      'radius': 11.0,
      'disabledRadius': 7.0,
      'elevation': 1.0,
      'pressedElevation': 3.0,
      'activeColor': Color(0xFF7E57C2),
      'inactiveColor': Color(0xFFD1C4E9),
      'thumbColor': Color(0xFF4527A0),
      'value': 0.72,
    },
    {
      'name': 'Warm Amber',
      'radius': 13.0,
      'disabledRadius': 9.0,
      'elevation': 3.0,
      'pressedElevation': 8.0,
      'activeColor': Color(0xFFFF8F00),
      'inactiveColor': Color(0xFFFFE082),
      'thumbColor': Color(0xFFE65100),
      'value': 0.48,
    },
    {
      'name': 'Steel Blue',
      'radius': 10.0,
      'disabledRadius': 6.0,
      'elevation': 2.0,
      'pressedElevation': 5.0,
      'activeColor': Color(0xFF455A64),
      'inactiveColor': Color(0xFFB0BEC5),
      'thumbColor': Color(0xFF263238),
      'value': 0.62,
    },
  ];

  List<Widget> configWidgets = [];
  int m = 0;
  while (m < configs.length) {
    Map<String, dynamic> cfg = configs[m];
    String name = cfg['name'];
    double radius = cfg['radius'];
    double disRad = cfg['disabledRadius'];
    double elev = cfg['elevation'];
    double pressElev = cfg['pressedElevation'];
    Color activeColor = cfg['activeColor'];
    Color inactiveColor = cfg['inactiveColor'];
    Color thumbColor = cfg['thumbColor'];
    double val = cfg['value'];

    print('  Themed: $name, r=$radius, dis=$disRad, e=$elev, pe=$pressElev');

    configWidgets.add(
      Container(
        margin: EdgeInsets.only(bottom: 14),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: activeColor.withValues(alpha: 0.4), width: 1),
          boxShadow: [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: activeColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: activeColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'r=$radius  dis=$disRad  e=$elev  pe=$pressElev',
                    style: TextStyle(fontSize: 9, color: activeColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            SliderTheme(
              data: SliderThemeData(
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: radius,
                  disabledThumbRadius: disRad,
                  elevation: elev,
                  pressedElevation: pressElev,
                ),
                activeTrackColor: activeColor,
                inactiveTrackColor: inactiveColor,
                thumbColor: thumbColor,
                overlayColor: activeColor.withValues(alpha: 0.16),
              ),
              child: Slider(
                value: val,
                min: 0.0,
                max: 1.0,
                onChanged: (double v) {
                  print('Themed slider changed: $name');
                },
              ),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildColorSwatch('Active', activeColor),
                _buildColorSwatch('Inactive', inactiveColor),
                _buildColorSwatch('Thumb', thumbColor),
              ],
            ),
          ],
        ),
      ),
    );
    m = m + 1;
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFBDBDBD), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.style, color: Color(0xFF424242), size: 22),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Multiple Themed Sliders',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF424242),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Each slider uses a unique combination of enabledThumbRadius, disabledThumbRadius, elevation, and pressedElevation.',
          style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
        ),
        SizedBox(height: 14),
        Column(children: configWidgets),
      ],
    ),
  );
}

Widget _buildPositionShowcaseSection() {
  print('Building sliders at different positions');

  List<Map<String, dynamic>> positions = [
    {'label': 'Start (0.0)', 'value': 0.0, 'color': Color(0xFF1565C0)},
    {'label': 'Quarter (0.25)', 'value': 0.25, 'color': Color(0xFF2E7D32)},
    {'label': 'Half (0.5)', 'value': 0.5, 'color': Color(0xFFF57F17)},
    {'label': 'Three-Quarter (0.75)', 'value': 0.75, 'color': Color(0xFFE65100)},
    {'label': 'End (1.0)', 'value': 1.0, 'color': Color(0xFFC62828)},
  ];

  List<Widget> posWidgets = [];
  int p = 0;
  while (p < positions.length) {
    Map<String, dynamic> pos = positions[p];
    String label = pos['label'];
    double val = pos['value'];
    Color color = pos['color'];
    print('  Position: $label');

    posWidgets.add(
      Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.4),
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            SliderTheme(
              data: SliderThemeData(
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: 12,
                  elevation: 3.0,
                  pressedElevation: 8.0,
                ),
                activeTrackColor: color,
                inactiveTrackColor: color.withValues(alpha: 0.2),
                thumbColor: color,
                overlayColor: color.withValues(alpha: 0.16),
              ),
              child: Slider(
                value: val,
                min: 0.0,
                max: 1.0,
                onChanged: (double v) {
                  print('Position slider changed: $label');
                },
              ),
            ),
          ],
        ),
      ),
    );
    p = p + 1;
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFF3E0), Color(0xFFFFF8E1)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFFFA726), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.linear_scale, color: Color(0xFFE65100), size: 22),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Sliders at Different Positions',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE65100),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'The thumb appearance at various positions from start to end. Notice how active vs inactive track changes.',
          style: TextStyle(fontSize: 12, color: Color(0xFFF57C00)),
        ),
        SizedBox(height: 14),
        Column(children: posWidgets),
      ],
    ),
  );
}

Widget _buildPropertyReferenceSection() {
  print('Building property reference section');

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF1976D2), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0x1A1976D2),
          blurRadius: 8,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, color: Color(0xFF1976D2), size: 22),
            SizedBox(width: 8),
            Text(
              'RoundSliderThumbShape Property Reference',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1976D2),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Constructor Parameters',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1565C0)),
              ),
              SizedBox(height: 8),
              _buildPropertyRow('enabledThumbRadius', 'double (default: 10.0)', Color(0xFF2E7D32)),
              Divider(color: Color(0xFFE0E0E0), height: 12),
              _buildPropertyRow('disabledThumbRadius', 'double? (default: null)', Color(0xFFE65100)),
              Divider(color: Color(0xFFE0E0E0), height: 12),
              _buildPropertyRow('elevation', 'double (default: 1.0)', Color(0xFF1565C0)),
              Divider(color: Color(0xFFE0E0E0), height: 12),
              _buildPropertyRow('pressedElevation', 'double (default: 6.0)', Color(0xFFC62828)),
            ],
          ),
        ),
        SizedBox(height: 12),
        _buildInfoCard(
          'enabledThumbRadius',
          'The radius of the thumb circle when the slider is enabled. Defaults to 10.0. Determines the visual size of the draggable thumb.',
          Icons.circle,
          Color(0xFF2E7D32),
        ),
        _buildInfoCard(
          'disabledThumbRadius',
          'The radius of the thumb when the slider is disabled (onChanged is null). When null, defaults to the enabledThumbRadius value.',
          Icons.do_not_disturb,
          Color(0xFFE65100),
        ),
        _buildInfoCard(
          'elevation',
          'The resting elevation of the thumb. Defaults to 1.0. Controls the shadow depth at rest. Set to 0 for a flat thumb with no shadow.',
          Icons.layers,
          Color(0xFF1565C0),
        ),
        _buildInfoCard(
          'pressedElevation',
          'The elevation when the thumb is pressed. Defaults to 6.0. A higher pressedElevation gives tactile feedback by lifting the thumb shadow on press.',
          Icons.touch_app,
          Color(0xFFC62828),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFF90CAF9), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Usage via SliderThemeData',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1565C0)),
              ),
              SizedBox(height: 6),
              Text(
                'Apply RoundSliderThumbShape via:\n'
                '  SliderTheme(\n'
                '    data: SliderThemeData(\n'
                '      thumbShape: RoundSliderThumbShape(\n'
                '        enabledThumbRadius: 14,\n'
                '        disabledThumbRadius: 8,\n'
                '        elevation: 2,\n'
                '        pressedElevation: 8,\n'
                '      ),\n'
                '    ),\n'
                '    child: Slider(...),\n'
                '  )',
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: Color(0xFF37474F),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFFFCC80), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Additional SliderThemeData Properties',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFFE65100)),
              ),
              SizedBox(height: 8),
              _buildPropertyRow('thumbColor', 'Color - thumb fill', Color(0xFFE65100)),
              _buildPropertyRow('activeTrackColor', 'Color - left of thumb', Color(0xFF2E7D32)),
              _buildPropertyRow('inactiveTrackColor', 'Color - right of thumb', Color(0xFF757575)),
              _buildPropertyRow('overlayColor', 'Color - press ripple', Color(0xFF1565C0)),
              _buildPropertyRow('disabledThumbColor', 'Color - disabled fill', Color(0xFF9E9E9E)),
              _buildPropertyRow('disabledActiveTrackColor', 'Color - disabled left', Color(0xFF9E9E9E)),
              _buildPropertyRow('disabledInactiveTrackColor', 'Color - disabled right', Color(0xFF9E9E9E)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildDebugOutputSection() {
  print('=== Debug Output Summary ===');
  print('RoundSliderThumbShape properties:');
  print('  enabledThumbRadius: double (default 10.0)');
  print('  disabledThumbRadius: double? (default null => enabledThumbRadius)');
  print('  elevation: double (default 1.0)');
  print('  pressedElevation: double (default 6.0)');
  print('---');
  print('Thumb sizes demonstrated: 4, 7, 10, 14, 18, 24');
  print('Elevation values demonstrated: 0, 1, 2, 3, 4, 8, 12');
  print('PressedElevation values demonstrated: 0, 3, 4, 5, 6, 8, 10, 12, 16');
  print('Color themes: Deep Ocean, Crimson Fire, Royal Purple, Golden Amber');
  print('Themed configs: Compact Teal, Bold Red, Soft Lavender, Warm Amber, Steel Blue');
  print('Positions shown: 0.0, 0.25, 0.5, 0.75, 1.0');
  print('=== End Debug Output ===');

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.terminal, color: Color(0xFF4FC3F7), size: 20),
            SizedBox(width: 8),
            Text(
              'Debug Output (print statements)',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4FC3F7),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'print() calls logged during build:\n'
          '  - Section headers for each demo area\n'
          '  - Thumb radius values for each size comparison\n'
          '  - Color theme names and radii\n'
          '  - Elevation and pressedElevation for each config\n'
          '  - Themed slider configuration details\n'
          '  - Position labels for position showcase\n'
          '  - Property reference summary',
          style: TextStyle(
            fontSize: 11,
            fontFamily: 'monospace',
            color: Color(0xFF80CBC4),
            height: 1.5,
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFF37474F),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'All print() output goes to the D4rt console.\n'
            'Check the console to verify each section built successfully.',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFFB0BEC5),
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== Slider Thumb Shape Demo ===');
  print('Testing RoundSliderThumbShape and thumb customization');
  print('Properties: enabledThumbRadius, disabledThumbRadius, elevation, pressedElevation');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('Slider Thumb Shape Demo'),
        backgroundColor: Color(0xFF1565C0),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Introduction info cards
            _buildSectionHeader('Slider Thumb Shape Overview', Color(0xFF1565C0)),
            SizedBox(height: 10),
            _buildInfoCard(
              'RoundSliderThumbShape',
              'The default shape used for the Slider thumb in Material Design. A circular thumb drawn on top of the slider track.',
              Icons.circle,
              Color(0xFF1565C0),
            ),
            _buildInfoCard(
              'Customization via SliderThemeData',
              'Set thumbShape in SliderThemeData to a RoundSliderThumbShape with custom radius, elevation, and pressed elevation.',
              Icons.tune,
              Color(0xFF2E7D32),
            ),
            _buildInfoCard(
              'Key Properties',
              'enabledThumbRadius (size when enabled), disabledThumbRadius (size when disabled), elevation (shadow at rest), pressedElevation (shadow when pressed).',
              Icons.settings,
              Color(0xFF6A1B9A),
            ),
            SizedBox(height: 20),

            // Section 2: Default Slider
            _buildSectionHeader('Default Slider', Color(0xFF1976D2)),
            SizedBox(height: 10),
            _buildDefaultSliderSection(),
            SizedBox(height: 20),

            // Section 3: Custom enabledThumbRadius
            _buildSectionHeader('Custom enabledThumbRadius', Color(0xFF388E3C)),
            SizedBox(height: 10),
            _buildCustomThumbRadiusSection(),
            SizedBox(height: 20),

            // Section 4: Thumb Size Comparison
            _buildSectionHeader('Thumb Size Comparison (Tiny to Large)', Color(0xFF424242)),
            SizedBox(height: 10),
            _buildThumbSizeComparisonSection(),
            SizedBox(height: 20),

            // Section 5: Custom thumb + track colors
            _buildSectionHeader('Custom Thumb + Track Colors', Color(0xFF6A1B9A)),
            SizedBox(height: 10),
            _buildColoredThumbSection(),
            SizedBox(height: 20),

            // Section 6: Enabled vs Disabled Thumb Radius
            _buildSectionHeader('Enabled vs Disabled Thumb Radius', Color(0xFF546E7A)),
            SizedBox(height: 10),
            _buildEnabledVsDisabledSection(),
            SizedBox(height: 20),

            // Section 7: Elevation values
            _buildSectionHeader('Thumb Elevation Values', Color(0xFF3949AB)),
            SizedBox(height: 10),
            _buildElevationSection(),
            SizedBox(height: 20),

            // Section 8: Multiple themed sliders
            _buildSectionHeader('Multiple Themed Configurations', Color(0xFF455A64)),
            SizedBox(height: 10),
            _buildMultipleThemedSlidersSection(),
            SizedBox(height: 20),

            // Section 9: Sliders at different positions
            _buildSectionHeader('Thumb at Different Positions', Color(0xFFE65100)),
            SizedBox(height: 10),
            _buildPositionShowcaseSection(),
            SizedBox(height: 20),

            // Section 10: Property reference
            _buildSectionHeader('Property Reference', Color(0xFF1565C0)),
            SizedBox(height: 10),
            _buildPropertyReferenceSection(),
            SizedBox(height: 20),

            // Section 11: Debug output
            _buildSectionHeader('Debug Output', Color(0xFF263238)),
            SizedBox(height: 10),
            _buildDebugOutputSection(),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}
