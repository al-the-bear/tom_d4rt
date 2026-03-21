// D4rt test script: Tests GappedSliderTrackShape from material
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

Widget _buildDefaultSliderSection() {
  print('Building default Slider reference section');
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
              'Default Slider (No Custom Track)',
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
          'Standard Slider using the built-in RoundedRectSliderTrackShape for baseline comparison.',
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
            'This default Slider uses RoundedRectSliderTrackShape. No gap is visible around the thumb. Compare with the gapped version below.',
            style: TextStyle(fontSize: 11, color: Color(0xFF616161), fontStyle: FontStyle.italic),
          ),
        ),
      ],
    ),
  );
}

Widget _buildGappedTrackSection() {
  print('Building GappedSliderTrackShape section');
  double gappedVal = 0.6;
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFF3E5F5), Color(0xFFEDE7F6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF7B1FA2), width: 1),
      boxShadow: [
        BoxShadow(
          color: Color(0x1A7B1FA2),
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
            Icon(Icons.space_bar, color: Color(0xFF7B1FA2), size: 22),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'GappedSliderTrackShape Applied',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7B1FA2),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Slider with a visible gap painted at the thumb position using GappedSliderTrackShape.',
          style: TextStyle(fontSize: 12, color: Color(0xFF6A1B9A)),
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            trackShape: GappedSliderTrackShape(),
            activeTrackColor: Color(0xFF7B1FA2),
            inactiveTrackColor: Color(0xFFCE93D8),
            overlayColor: Color(0x297B1FA2),
            thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: 12,
            ),
          ),
          child: Slider(
            value: gappedVal,
            min: 0.0,
            max: 1.0,
            divisions: 20,
            label: '0.6',
            onChanged: (double v) {
              print('Gapped slider changed');
            },
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.info_outline, color: Color(0xFF9C27B0), size: 16),
            SizedBox(width: 6),
            Expanded(
              child: Text(
                'Notice the gap at the thumb position. The track is split around the thumb, which is the key visual feature of GappedSliderTrackShape.',
                style: TextStyle(fontSize: 11, color: Color(0xFF6A1B9A)),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLabeledBox('Active', Color(0xFF7B1FA2)),
            _buildLabeledBox('Gap', Color(0xFFE91E63)),
            _buildLabeledBox('Inactive', Color(0xFFCE93D8)),
          ],
        ),
      ],
    ),
  );
}

Widget _buildColorThemedSlidersSection() {
  print('Building colored themed sliders section');

  List<Map<String, dynamic>> themes = [
    {
      'name': 'Ocean Blue',
      'active': Color(0xFF0288D1),
      'inactive': Color(0xFF81D4FA),
      'thumb': Color(0xFF01579B),
      'overlay': Color(0x290288D1),
      'value': 0.35,
    },
    {
      'name': 'Forest Green',
      'active': Color(0xFF2E7D32),
      'inactive': Color(0xFFA5D6A7),
      'thumb': Color(0xFF1B5E20),
      'overlay': Color(0x292E7D32),
      'value': 0.55,
    },
    {
      'name': 'Sunset Orange',
      'active': Color(0xFFE65100),
      'inactive': Color(0xFFFFCC80),
      'thumb': Color(0xFFBF360C),
      'overlay': Color(0x29E65100),
      'value': 0.75,
    },
    {
      'name': 'Rose Pink',
      'active': Color(0xFFC2185B),
      'inactive': Color(0xFFF48FB1),
      'thumb': Color(0xFF880E4F),
      'overlay': Color(0x29C2185B),
      'value': 0.45,
    },
    {
      'name': 'Deep Indigo',
      'active': Color(0xFF283593),
      'inactive': Color(0xFF9FA8DA),
      'thumb': Color(0xFF1A237E),
      'overlay': Color(0x29283593),
      'value': 0.65,
    },
  ];

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFBDBDBD), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.palette, color: Color(0xFF424242), size: 20),
            SizedBox(width: 8),
            Text(
              'Colored GappedSliderTrackShape Themes',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF424242),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Multiple sliders each using GappedSliderTrackShape with different color schemes.',
          style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
        ),
        SizedBox(height: 14),
        Column(
          children: themes.map((t) {
            print('  Theme: ' + (t['name'] as String));
            return Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFFAFAFA),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: (t['active'] as Color).withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: t['active'] as Color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        t['name'] as String,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: t['active'] as Color,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  SliderTheme(
                    data: SliderThemeData(
                      trackShape: GappedSliderTrackShape(),
                      activeTrackColor: t['active'] as Color,
                      inactiveTrackColor: t['inactive'] as Color,
                      thumbColor: t['thumb'] as Color,
                      overlayColor: t['overlay'] as Color,
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                    ),
                    child: Slider(
                      value: t['value'] as double,
                      min: 0.0,
                      max: 1.0,
                      divisions: 20,
                      onChanged: (double v) {
                        print('Color themed slider changed');
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildColorSwatch('Ocean', Color(0xFF0288D1)),
            _buildColorSwatch('Forest', Color(0xFF2E7D32)),
            _buildColorSwatch('Sunset', Color(0xFFE65100)),
            _buildColorSwatch('Rose', Color(0xFFC2185B)),
            _buildColorSwatch('Indigo', Color(0xFF283593)),
          ],
        ),
      ],
    ),
  );
}

Widget _buildTrackHeightsSection() {
  print('Building varying track heights section');

  List<Map<String, dynamic>> heights = [
    {'label': 'Thin (2px)', 'height': 2.0, 'value': 0.4, 'color': Color(0xFF00897B)},
    {'label': 'Default (4px)', 'height': 4.0, 'value': 0.5, 'color': Color(0xFF5C6BC0)},
    {'label': 'Medium (8px)', 'height': 8.0, 'value': 0.6, 'color': Color(0xFFEF6C00)},
    {'label': 'Thick (12px)', 'height': 12.0, 'value': 0.7, 'color': Color(0xFFAD1457)},
    {'label': 'Extra Thick (16px)', 'height': 16.0, 'value': 0.55, 'color': Color(0xFF6A1B9A)},
    {'label': 'Maximum (24px)', 'height': 24.0, 'value': 0.65, 'color': Color(0xFF1565C0)},
  ];

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE8EAF6), Color(0xFFF3E5F5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF9575CD), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.height, color: Color(0xFF5C6BC0), size: 22),
            SizedBox(width: 8),
            Text(
              'Varying Track Heights with Gap Effect',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5C6BC0),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'The gap effect becomes more prominent as the track height increases.',
          style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
        ),
        SizedBox(height: 14),
        Column(
          children: heights.map((h) {
            print('  Track height: ' + (h['label'] as String));
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: (h['color'] as Color).withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    h['label'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: h['color'] as Color,
                    ),
                  ),
                  SizedBox(height: 6),
                  SliderTheme(
                    data: SliderThemeData(
                      trackShape: GappedSliderTrackShape(),
                      trackHeight: h['height'] as double,
                      activeTrackColor: h['color'] as Color,
                      inactiveTrackColor: (h['color'] as Color).withValues(alpha: 0.3),
                      thumbColor: h['color'] as Color,
                      overlayColor: (h['color'] as Color).withValues(alpha: 0.15),
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                    ),
                    child: Slider(
                      value: h['value'] as double,
                      min: 0.0,
                      max: 1.0,
                      divisions: 20,
                      onChanged: (double v) {
                        print('Height slider changed');
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

Widget _buildComparisonSection() {
  print('Building comparison: RoundedRect vs Gapped');

  double comparisonVal = 0.5;

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF00897B), width: 1),
      boxShadow: [
        BoxShadow(
          color: Color(0x1A00897B),
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
            Icon(Icons.compare, color: Color(0xFF00897B), size: 22),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'RoundedRectSliderTrackShape vs GappedSliderTrackShape',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00897B),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFE0F2F1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RoundedRectSliderTrackShape (Standard)',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF00695C),
                ),
              ),
              SizedBox(height: 8),
              SliderTheme(
                data: SliderThemeData(
                  trackShape: RoundedRectSliderTrackShape(),
                  trackHeight: 6.0,
                  activeTrackColor: Color(0xFF00897B),
                  inactiveTrackColor: Color(0xFFB2DFDB),
                  thumbColor: Color(0xFF004D40),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                ),
                child: Slider(
                  value: comparisonVal,
                  min: 0.0,
                  max: 1.0,
                  divisions: 20,
                  onChanged: (double v) {
                    print('RoundedRect slider changed');
                  },
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Track is continuous under the thumb. No gap visible.',
                style: TextStyle(fontSize: 11, color: Color(0xFF004D40), fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFFCE4EC),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GappedSliderTrackShape (Gap at Thumb)',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFC62828),
                ),
              ),
              SizedBox(height: 8),
              SliderTheme(
                data: SliderThemeData(
                  trackShape: GappedSliderTrackShape(),
                  trackHeight: 6.0,
                  activeTrackColor: Color(0xFFC62828),
                  inactiveTrackColor: Color(0xFFEF9A9A),
                  thumbColor: Color(0xFFB71C1C),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                ),
                child: Slider(
                  value: comparisonVal,
                  min: 0.0,
                  max: 1.0,
                  divisions: 20,
                  onChanged: (double v) {
                    print('Gapped comparison slider changed');
                  },
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Track has a gap at the thumb position. Track segments are visually separated.',
                style: TextStyle(fontSize: 11, color: Color(0xFFB71C1C), fontStyle: FontStyle.italic),
              ),
            ],
          ),
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
                'Side-by-side with Thick Tracks (12px)',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF424242),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'RoundedRect:',
                style: TextStyle(fontSize: 11, color: Color(0xFF616161)),
              ),
              SliderTheme(
                data: SliderThemeData(
                  trackShape: RoundedRectSliderTrackShape(),
                  trackHeight: 12.0,
                  activeTrackColor: Color(0xFF3949AB),
                  inactiveTrackColor: Color(0xFFC5CAE9),
                  thumbColor: Color(0xFF1A237E),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
                ),
                child: Slider(
                  value: 0.5,
                  min: 0.0,
                  max: 1.0,
                  onChanged: (double v) {
                    print('Thick rounded rect slider changed');
                  },
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Gapped:',
                style: TextStyle(fontSize: 11, color: Color(0xFF616161)),
              ),
              SliderTheme(
                data: SliderThemeData(
                  trackShape: GappedSliderTrackShape(),
                  trackHeight: 12.0,
                  activeTrackColor: Color(0xFF3949AB),
                  inactiveTrackColor: Color(0xFFC5CAE9),
                  thumbColor: Color(0xFF1A237E),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
                ),
                child: Slider(
                  value: 0.5,
                  min: 0.0,
                  max: 1.0,
                  onChanged: (double v) {
                    print('Thick gapped slider changed');
                  },
                ),
              ),
              SizedBox(height: 6),
              Text(
                'The gap effect is much more visible with thicker tracks. Both sliders are at the same 0.5 value.',
                style: TextStyle(fontSize: 11, color: Color(0xFF616161), fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildDifferentValuesSection() {
  print('Building different slider values section');

  List<Map<String, dynamic>> positions = [
    {'label': 'Value: 0.0 (Minimum)', 'value': 0.0, 'color': Color(0xFF1565C0)},
    {'label': 'Value: 0.1', 'value': 0.1, 'color': Color(0xFF0277BD)},
    {'label': 'Value: 0.25', 'value': 0.25, 'color': Color(0xFF00838F)},
    {'label': 'Value: 0.5 (Center)', 'value': 0.5, 'color': Color(0xFF2E7D32)},
    {'label': 'Value: 0.75', 'value': 0.75, 'color': Color(0xFFEF6C00)},
    {'label': 'Value: 0.9', 'value': 0.9, 'color': Color(0xFFD84315)},
    {'label': 'Value: 1.0 (Maximum)', 'value': 1.0, 'color': Color(0xFFC62828)},
  ];

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE3F2FD), Color(0xFFFCE4EC)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF90CAF9), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.swap_horiz, color: Color(0xFF1565C0), size: 22),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Gap Movement: Different Slider Values',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1565C0),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Shows how the gap moves along the track as the thumb position changes from minimum to maximum.',
          style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
        ),
        SizedBox(height: 14),
        Column(
          children: positions.map((p) {
            print('  Position: ' + (p['label'] as String));
            return Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: (p['color'] as Color).withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['label'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: p['color'] as Color,
                    ),
                  ),
                  SizedBox(height: 4),
                  SliderTheme(
                    data: SliderThemeData(
                      trackShape: GappedSliderTrackShape(),
                      trackHeight: 6.0,
                      activeTrackColor: p['color'] as Color,
                      inactiveTrackColor: (p['color'] as Color).withValues(alpha: 0.25),
                      thumbColor: p['color'] as Color,
                      overlayColor: (p['color'] as Color).withValues(alpha: 0.12),
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 9),
                    ),
                    child: Slider(
                      value: p['value'] as double,
                      min: 0.0,
                      max: 1.0,
                      onChanged: (double v) {
                        print('Position slider changed');
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Color(0xFFFFA000), size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'At 0.0 and 1.0, the gap appears at the track edges. At 0.5, the gap is centered.',
                  style: TextStyle(fontSize: 11, color: Color(0xFF616161)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildDisabledAndEnabledSection() {
  print('Building disabled vs enabled slider section');

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFBDBDBD), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.toggle_on, color: Color(0xFF616161), size: 22),
            SizedBox(width: 8),
            Text(
              'Enabled vs Disabled Gapped Sliders',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF616161),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enabled',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2E7D32),
                ),
              ),
              SizedBox(height: 6),
              SliderTheme(
                data: SliderThemeData(
                  trackShape: GappedSliderTrackShape(),
                  trackHeight: 6.0,
                  activeTrackColor: Color(0xFF2E7D32),
                  inactiveTrackColor: Color(0xFFA5D6A7),
                  thumbColor: Color(0xFF1B5E20),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                ),
                child: Slider(
                  value: 0.6,
                  min: 0.0,
                  max: 1.0,
                  onChanged: (double v) {
                    print('Enabled slider changed');
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Disabled (onChanged: null)',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF9E9E9E),
                ),
              ),
              SizedBox(height: 6),
              SliderTheme(
                data: SliderThemeData(
                  trackShape: GappedSliderTrackShape(),
                  trackHeight: 6.0,
                  disabledActiveTrackColor: Color(0xFFBDBDBD),
                  disabledInactiveTrackColor: Color(0xFFE0E0E0),
                  disabledThumbColor: Color(0xFF9E9E9E),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                ),
                child: Slider(
                  value: 0.6,
                  min: 0.0,
                  max: 1.0,
                  onChanged: null,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Disabled sliders still show the gap but with muted colors and no interaction.',
          style: TextStyle(fontSize: 11, color: Color(0xFF757575), fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

Widget _buildPropertyInfoSection() {
  print('Building property and behavior information section');

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF5C6BC0), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.description, color: Color(0xFF5C6BC0), size: 22),
            SizedBox(width: 8),
            Text(
              'GappedSliderTrackShape Properties',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5C6BC0),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        _buildInfoCard(
          'Track Override',
          'GappedSliderTrackShape extends SliderTrackShape and overrides paint() to draw the active and inactive track segments with a gap around the thumb.',
          Icons.brush,
          Color(0xFF7B1FA2),
        ),
        _buildInfoCard(
          'SliderThemeData.trackShape',
          'Applied via SliderTheme by setting trackShape to GappedSliderTrackShape(). Works with regular Slider widget, not RangeSlider.',
          Icons.settings,
          Color(0xFF00897B),
        ),
        _buildInfoCard(
          'Gap Behavior',
          'The gap appears at the thumb position and moves with the thumb. Track segments on either side of the thumb do not connect under it.',
          Icons.space_bar,
          Color(0xFFEF6C00),
        ),
        _buildInfoCard(
          'Track Height',
          'Respects SliderThemeData.trackHeight. The gap is more visible with thicker tracks. Default track height is typically 4 logical pixels.',
          Icons.height,
          Color(0xFF1565C0),
        ),
        _buildInfoCard(
          'Color Interaction',
          'Uses activeTrackColor for the portion before the thumb and inactiveTrackColor for the portion after. Both are separated by the gap.',
          Icons.color_lens,
          Color(0xFFC62828),
        ),
        _buildInfoCard(
          'Disabled State',
          'When the slider is disabled (onChanged is null), the gap is still rendered but with disabledActiveTrackColor and disabledInactiveTrackColor.',
          Icons.block,
          Color(0xFF757575),
        ),
        _buildInfoCard(
          'Comparison with RoundedRectSliderTrackShape',
          'Unlike RoundedRectSliderTrackShape which draws a continuous track under the thumb, GappedSliderTrackShape splits the track into two visible segments.',
          Icons.compare_arrows,
          Color(0xFF283593),
        ),
        _buildInfoCard(
          'Comparison with GappedRangeSliderTrackShape',
          'GappedSliderTrackShape is for regular Slider, while GappedRangeSliderTrackShape is for RangeSlider with two thumbs. Conceptually similar but for different slider types.',
          Icons.difference,
          Color(0xFF4E342E),
        ),
      ],
    ),
  );
}

Widget _buildUsagePatternSection() {
  print('Building usage pattern section');

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFF3E0), Color(0xFFFFF8E1)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFFF8F00), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Color(0xFFFF8F00), size: 22),
            SizedBox(width: 8),
            Text(
              'Usage Pattern',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF8F00),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How to use GappedSliderTrackShape:',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF80CBC4),
                ),
              ),
              SizedBox(height: 8),
              Text(
                '1. Wrap Slider in SliderTheme',
                style: TextStyle(fontSize: 11, color: Color(0xFFB0BEC5)),
              ),
              SizedBox(height: 4),
              Text(
                '2. Set SliderThemeData.trackShape',
                style: TextStyle(fontSize: 11, color: Color(0xFFB0BEC5)),
              ),
              SizedBox(height: 4),
              Text(
                '   to GappedSliderTrackShape()',
                style: TextStyle(fontSize: 11, color: Color(0xFF80CBC4)),
              ),
              SizedBox(height: 4),
              Text(
                '3. Customize activeTrackColor,',
                style: TextStyle(fontSize: 11, color: Color(0xFFB0BEC5)),
              ),
              SizedBox(height: 4),
              Text(
                '   inactiveTrackColor, trackHeight',
                style: TextStyle(fontSize: 11, color: Color(0xFF80CBC4)),
              ),
              SizedBox(height: 4),
              Text(
                '4. Provide onChanged callback',
                style: TextStyle(fontSize: 11, color: Color(0xFFB0BEC5)),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Key: trackShape is the property on SliderThemeData that accepts SliderTrackShape subclass instances.',
          style: TextStyle(fontSize: 11, color: Color(0xFFE65100)),
        ),
      ],
    ),
  );
}

Widget _buildDivisionsShowcaseSection() {
  print('Building divisions showcase section');

  List<Map<String, dynamic>> divisionSets = [
    {'label': 'No Divisions (Continuous)', 'divisions': 0, 'value': 0.47, 'color': Color(0xFF1565C0)},
    {'label': '5 Divisions', 'divisions': 5, 'value': 0.4, 'color': Color(0xFF00838F)},
    {'label': '10 Divisions', 'divisions': 10, 'value': 0.5, 'color': Color(0xFF2E7D32)},
    {'label': '20 Divisions', 'divisions': 20, 'value': 0.55, 'color': Color(0xFFEF6C00)},
    {'label': '50 Divisions', 'divisions': 50, 'value': 0.62, 'color': Color(0xFFC62828)},
  ];

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF78909C), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.grid_on, color: Color(0xFF546E7A), size: 22),
            SizedBox(width: 8),
            Text(
              'Gapped Track with Different Divisions',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF546E7A),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Divisions create tick marks. The gap is present regardless of division count.',
          style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
        ),
        SizedBox(height: 14),
        Column(
          children: divisionSets.map((d) {
            int divCount = d['divisions'] as int;
            print('  Divisions: ' + (d['label'] as String));
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Color(0xFFFAFAFA),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    d['label'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: d['color'] as Color,
                    ),
                  ),
                  SizedBox(height: 4),
                  SliderTheme(
                    data: SliderThemeData(
                      trackShape: GappedSliderTrackShape(),
                      trackHeight: 6.0,
                      activeTrackColor: d['color'] as Color,
                      inactiveTrackColor: (d['color'] as Color).withValues(alpha: 0.25),
                      thumbColor: d['color'] as Color,
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 9),
                    ),
                    child: Slider(
                      value: d['value'] as double,
                      min: 0.0,
                      max: 1.0,
                      divisions: divCount > 0 ? divCount : null,
                      onChanged: (double v) {
                        print('Divisions slider changed');
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

Widget _buildDebugOutputSection() {
  print('=== GappedSliderTrackShape Debug Output ===');
  print('GappedSliderTrackShape extends SliderTrackShape');
  print('It paints a gap at the thumb position on the slider track');
  print('Configured via SliderThemeData.trackShape');
  print('Works with regular Slider widget');
  print('Respects trackHeight, activeTrackColor, inactiveTrackColor');
  print('Gap position moves with the thumb value');
  print('Disabled state uses disabledActiveTrackColor and disabledInactiveTrackColor');
  print('Compared to RoundedRectSliderTrackShape: adds visible gap');
  print('Compared to GappedRangeSliderTrackShape: for Slider not RangeSlider');
  print('=== End Debug Output ===');

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFF1B2631),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF2ECC71), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.terminal, color: Color(0xFF2ECC71), size: 22),
            SizedBox(width: 8),
            Text(
              'Debug Output (see console)',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2ECC71),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFF0D1117),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'print() output:',
                style: TextStyle(fontSize: 10, color: Color(0xFF8B949E)),
              ),
              SizedBox(height: 6),
              Text(
                '> GappedSliderTrackShape extends SliderTrackShape',
                style: TextStyle(fontSize: 11, color: Color(0xFF58A6FF), fontFamily: 'monospace'),
              ),
              SizedBox(height: 2),
              Text(
                '> Paints gap at thumb position',
                style: TextStyle(fontSize: 11, color: Color(0xFF58A6FF), fontFamily: 'monospace'),
              ),
              SizedBox(height: 2),
              Text(
                '> Configured via SliderThemeData.trackShape',
                style: TextStyle(fontSize: 11, color: Color(0xFF58A6FF), fontFamily: 'monospace'),
              ),
              SizedBox(height: 2),
              Text(
                '> Works with Slider, not RangeSlider',
                style: TextStyle(fontSize: 11, color: Color(0xFF58A6FF), fontFamily: 'monospace'),
              ),
              SizedBox(height: 2),
              Text(
                '> Gap moves with thumb value',
                style: TextStyle(fontSize: 11, color: Color(0xFF58A6FF), fontFamily: 'monospace'),
              ),
              SizedBox(height: 2),
              Text(
                '> Respects trackHeight and track colors',
                style: TextStyle(fontSize: 11, color: Color(0xFF58A6FF), fontFamily: 'monospace'),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== GappedSliderTrackShape Visual Demo ===');
  print('Demonstrating GappedSliderTrackShape for regular Slider widget');
  print('This track shape paints a gap at the thumb position');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('GappedSliderTrackShape Demo'),
        backgroundColor: Color(0xFF6A1B9A),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('1. Default Slider Reference', Color(0xFF1976D2)),
            SizedBox(height: 10),
            _buildDefaultSliderSection(),
            SizedBox(height: 24),
            _buildSectionHeader('2. GappedSliderTrackShape Applied', Color(0xFF7B1FA2)),
            SizedBox(height: 10),
            _buildGappedTrackSection(),
            SizedBox(height: 24),
            _buildSectionHeader('3. Color Themed Gapped Sliders', Color(0xFF00695C)),
            SizedBox(height: 10),
            _buildColorThemedSlidersSection(),
            SizedBox(height: 24),
            _buildSectionHeader('4. Varying Track Heights', Color(0xFF5C6BC0)),
            SizedBox(height: 10),
            _buildTrackHeightsSection(),
            SizedBox(height: 24),
            _buildSectionHeader('5. Track Shape Comparison', Color(0xFF00897B)),
            SizedBox(height: 10),
            _buildComparisonSection(),
            SizedBox(height: 24),
            _buildSectionHeader('6. Gap at Different Positions', Color(0xFF1565C0)),
            SizedBox(height: 10),
            _buildDifferentValuesSection(),
            SizedBox(height: 24),
            _buildSectionHeader('7. Enabled vs Disabled', Color(0xFF616161)),
            SizedBox(height: 10),
            _buildDisabledAndEnabledSection(),
            SizedBox(height: 24),
            _buildSectionHeader('8. Divisions Showcase', Color(0xFF546E7A)),
            SizedBox(height: 10),
            _buildDivisionsShowcaseSection(),
            SizedBox(height: 24),
            _buildSectionHeader('9. Usage Pattern', Color(0xFFFF8F00)),
            SizedBox(height: 10),
            _buildUsagePatternSection(),
            SizedBox(height: 24),
            _buildSectionHeader('10. Property Information', Color(0xFF5C6BC0)),
            SizedBox(height: 10),
            _buildPropertyInfoSection(),
            SizedBox(height: 24),
            _buildSectionHeader('11. Debug Output', Color(0xFF2E7D32)),
            SizedBox(height: 10),
            _buildDebugOutputSection(),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}
