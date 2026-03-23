// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests GappedRangeSliderTrackShape from material
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

Widget _buildInfoCard(
  String title,
  String description,
  IconData icon,
  Color accentColor,
) {
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
      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color),
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
      Text(label, style: TextStyle(fontSize: 9, color: Color(0xFF757575))),
    ],
  );
}

Widget _buildDefaultRangeSliderSection() {
  print('Building default RangeSlider reference section');
  RangeValues defaultRange = RangeValues(0.2, 0.8);
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
              'Default RangeSlider (No Custom Track)',
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
          'Standard RangeSlider using built-in track shape for reference comparison.',
          style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
        ),
        SizedBox(height: 12),
        RangeSlider(
          values: defaultRange,
          min: 0.0,
          max: 1.0,
          divisions: 10,
          labels: RangeLabels('Start', 'End'),
          onChanged: (RangeValues v) {
            print('Default slider changed');
          },
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLabeledBox('Min: 0.0', Color(0xFF1976D2)),
            _buildLabeledBox('Range: 0.2 - 0.8', Color(0xFF388E3C)),
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
            'This default RangeSlider uses the platform track shape. Compare with the gapped version below.',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF616161),
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildGappedTrackSection() {
  print('Building GappedRangeSliderTrackShape section');
  RangeValues gappedRange = RangeValues(0.3, 0.7);
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
                'GappedRangeSliderTrackShape Applied',
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
          'RangeSlider with a visible gap painted between the two thumbs using GappedRangeSliderTrackShape.',
          style: TextStyle(fontSize: 12, color: Color(0xFF6A1B9A)),
        ),
        SizedBox(height: 12),
        SliderTheme(
          data: SliderThemeData(
            rangeTrackShape: GappedRangeSliderTrackShape(),
            activeTrackColor: Color(0xFF7B1FA2),
            inactiveTrackColor: Color(0xFFCE93D8),
            overlayColor: Color(0x297B1FA2),
            rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 12),
          ),
          child: RangeSlider(
            values: gappedRange,
            min: 0.0,
            max: 1.0,
            divisions: 20,
            labels: RangeLabels('0.3', '0.7'),
            onChanged: (RangeValues v) {
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
                'Notice the gap between the two thumb positions. This is the key visual feature of GappedRangeSliderTrackShape.',
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

Widget _buildColorSchemeSliders() {
  print('Building color scheme sliders');
  List<Map<String, dynamic>> schemes = [
    {
      'name': 'Ocean Blue',
      'active': Color(0xFF0277BD),
      'inactive': Color(0xFF81D4FA),
      'overlay': Color(0x290277BD),
      'values': RangeValues(0.15, 0.65),
      'bg': Color(0xFFE1F5FE),
      'border': Color(0xFF0277BD),
    },
    {
      'name': 'Forest Green',
      'active': Color(0xFF2E7D32),
      'inactive': Color(0xFFA5D6A7),
      'overlay': Color(0x292E7D32),
      'values': RangeValues(0.25, 0.75),
      'bg': Color(0xFFE8F5E9),
      'border': Color(0xFF2E7D32),
    },
    {
      'name': 'Sunset Orange',
      'active': Color(0xFFE65100),
      'inactive': Color(0xFFFFCC80),
      'overlay': Color(0x29E65100),
      'values': RangeValues(0.1, 0.9),
      'bg': Color(0xFFFFF3E0),
      'border': Color(0xFFE65100),
    },
    {
      'name': 'Berry Pink',
      'active': Color(0xFFC2185B),
      'inactive': Color(0xFFF48FB1),
      'overlay': Color(0x29C2185B),
      'values': RangeValues(0.35, 0.85),
      'bg': Color(0xFFFCE4EC),
      'border': Color(0xFFC2185B),
    },
    {
      'name': 'Slate Teal',
      'active': Color(0xFF00695C),
      'inactive': Color(0xFF80CBC4),
      'overlay': Color(0x2900695C),
      'values': RangeValues(0.2, 0.6),
      'bg': Color(0xFFE0F2F1),
      'border': Color(0xFF00695C),
    },
  ];

  List<Widget> items = [];
  int idx = 0;
  while (idx < schemes.length) {
    Map<String, dynamic> s = schemes[idx];
    print('  Color scheme: ' + (s['name'] as String));
    items.add(
      Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: s['bg'] as Color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: s['border'] as Color, width: 1),
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
                    color: s['active'] as Color,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  s['name'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: s['active'] as Color,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                rangeTrackShape: GappedRangeSliderTrackShape(),
                activeTrackColor: s['active'] as Color,
                inactiveTrackColor: s['inactive'] as Color,
                overlayColor: s['overlay'] as Color,
                rangeThumbShape: RoundRangeSliderThumbShape(
                  enabledThumbRadius: 10,
                ),
              ),
              child: RangeSlider(
                values: s['values'] as RangeValues,
                min: 0.0,
                max: 1.0,
                onChanged: (RangeValues v) {
                  print('Color scheme slider changed');
                },
              ),
            ),
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildColorSwatch('Active', s['active'] as Color),
                _buildColorSwatch('Inactive', s['inactive'] as Color),
                _buildColorSwatch('Border', s['border'] as Color),
              ],
            ),
          ],
        ),
      ),
    );
    idx = idx + 1;
  }

  return Column(children: items);
}

Widget _buildTrackHeightSliders() {
  print('Building track height variations');
  List<Map<String, dynamic>> heights = [
    {
      'label': 'Thin Track (2px)',
      'height': 2.0,
      'values': RangeValues(0.2, 0.7),
    },
    {
      'label': 'Default Track (4px)',
      'height': 4.0,
      'values': RangeValues(0.25, 0.75),
    },
    {
      'label': 'Medium Track (8px)',
      'height': 8.0,
      'values': RangeValues(0.3, 0.8),
    },
    {
      'label': 'Thick Track (12px)',
      'height': 12.0,
      'values': RangeValues(0.15, 0.65),
    },
    {
      'label': 'Extra Thick (16px)',
      'height': 16.0,
      'values': RangeValues(0.1, 0.9),
    },
    {
      'label': 'Massive Track (24px)',
      'height': 24.0,
      'values': RangeValues(0.35, 0.85),
    },
  ];

  List<Widget> items = [];
  int idx = 0;
  while (idx < heights.length) {
    Map<String, dynamic> h = heights[idx];
    double trackHeight = h['height'] as double;
    print('  Track height: $trackHeight');
    items.add(
      Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFBDBDBD), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  h['label'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF424242),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Color(0xFFE8EAF6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Height: $trackHeight',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF3F51B5),
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                rangeTrackShape: GappedRangeSliderTrackShape(),
                trackHeight: trackHeight,
                activeTrackColor: Color(0xFF3F51B5),
                inactiveTrackColor: Color(0xFFC5CAE9),
                overlayColor: Color(0x293F51B5),
                rangeThumbShape: RoundRangeSliderThumbShape(
                  enabledThumbRadius: 10 + (trackHeight / 4),
                ),
              ),
              child: RangeSlider(
                values: h['values'] as RangeValues,
                min: 0.0,
                max: 1.0,
                onChanged: (RangeValues v) {
                  print('Track height slider changed');
                },
              ),
            ),
          ],
        ),
      ),
    );
    idx = idx + 1;
  }

  return Column(children: items);
}

Widget _buildComparisonSection() {
  print('Building track shape comparison section');
  RangeValues comparisonValues = RangeValues(0.3, 0.7);

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF455A64), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Track Shape Comparison',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color(0xFF263238),
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Compare the standard RoundedRectRangeSliderTrackShape with GappedRangeSliderTrackShape side by side.',
          style: TextStyle(fontSize: 11, color: Color(0xFF607D8B)),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFECEFF1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Color(0xFF1565C0),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    'RoundedRectRangeSliderTrackShape',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1565C0),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              SliderTheme(
                data: SliderThemeData(
                  rangeTrackShape: RoundedRectRangeSliderTrackShape(),
                  trackHeight: 8.0,
                  activeTrackColor: Color(0xFF1565C0),
                  inactiveTrackColor: Color(0xFF90CAF9),
                  rangeThumbShape: RoundRangeSliderThumbShape(
                    enabledThumbRadius: 12,
                  ),
                ),
                child: RangeSlider(
                  values: comparisonValues,
                  min: 0.0,
                  max: 1.0,
                  onChanged: (RangeValues v) {
                    print('Rounded rect slider changed');
                  },
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Standard track: continuous fill between thumbs, no gap.',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF546E7A),
                  fontStyle: FontStyle.italic,
                ),
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
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Color(0xFFC62828),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 6),
                  Text(
                    'GappedRangeSliderTrackShape',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFC62828),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              SliderTheme(
                data: SliderThemeData(
                  rangeTrackShape: GappedRangeSliderTrackShape(),
                  trackHeight: 8.0,
                  activeTrackColor: Color(0xFFC62828),
                  inactiveTrackColor: Color(0xFFEF9A9A),
                  rangeThumbShape: RoundRangeSliderThumbShape(
                    enabledThumbRadius: 12,
                  ),
                ),
                child: RangeSlider(
                  values: comparisonValues,
                  min: 0.0,
                  max: 1.0,
                  onChanged: (RangeValues v) {
                    print('Gapped rect slider changed');
                  },
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Gapped track: visible gap in the track between the two thumbs.',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFFC62828),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Color(0xFFFFB300), width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lightbulb_outline, color: Color(0xFFFFB300), size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'The GappedRangeSliderTrackShape paints the active portions of the track on the left and right sides of the slider but leaves a gap between the two thumbs. This creates a more distinct visual separation between the selected range boundaries.',
                  style: TextStyle(fontSize: 11, color: Color(0xFF795548)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildPropertyInfoSection() {
  print('Building property information section');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE8EAF6), Color(0xFFE3F2FD)],
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
            Icon(Icons.description, color: Color(0xFF5C6BC0), size: 20),
            SizedBox(width: 8),
            Text(
              'GappedRangeSliderTrackShape Properties',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF283593),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        _buildInfoCard(
          'Track Shape Type',
          'GappedRangeSliderTrackShape extends RangeSliderTrackShape. It paints the range slider track with a visible gap in the center between the two thumbs.',
          Icons.category,
          Color(0xFF5C6BC0),
        ),
        _buildInfoCard(
          'Usage via SliderThemeData',
          'Apply it by setting SliderThemeData.rangeTrackShape to an instance of GappedRangeSliderTrackShape(). Then wrap your RangeSlider in a SliderTheme widget.',
          Icons.settings,
          Color(0xFF00897B),
        ),
        _buildInfoCard(
          'Gap Behavior',
          'When both thumbs are at the same position, the gap is minimal. As the thumbs move apart, the gap between them becomes more visible creating a clear visual distinction.',
          Icons.swap_horiz,
          Color(0xFFEF6C00),
        ),
        _buildInfoCard(
          'Track Painting',
          'The shape paints the inactive portion of the track on both sides and the active track segments adjacent to each thumb, but leaves the middle uncolored or with a gap effect.',
          Icons.brush,
          Color(0xFFC62828),
        ),
        _buildInfoCard(
          'Compatibility',
          'Works with all RangeSlider configurations including divisions, labels, and custom thumb shapes. Combine with RoundRangeSliderThumbShape for a polished look.',
          Icons.check_circle_outline,
          Color(0xFF2E7D32),
        ),
        _buildInfoCard(
          'Track Height',
          'Respects the trackHeight property from SliderThemeData. Increasing the track height makes the gap more visually prominent and easier to see.',
          Icons.height,
          Color(0xFF6A1B9A),
        ),
      ],
    ),
  );
}

Widget _buildAdditionalDemoSliders() {
  print('Building additional demo sliders');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFF9C4),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFF9A825), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.star, color: Color(0xFFF9A825), size: 20),
            SizedBox(width: 8),
            Text(
              'Additional Configuration Examples',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF57F17),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'Narrow range with tight gap',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF795548),
          ),
        ),
        SizedBox(height: 4),
        SliderTheme(
          data: SliderThemeData(
            rangeTrackShape: GappedRangeSliderTrackShape(),
            trackHeight: 6.0,
            activeTrackColor: Color(0xFFFF6F00),
            inactiveTrackColor: Color(0xFFFFE0B2),
            rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 9),
          ),
          child: RangeSlider(
            values: RangeValues(0.45, 0.55),
            min: 0.0,
            max: 1.0,
            divisions: 20,
            onChanged: (RangeValues v) {
              print('Narrow range slider changed');
            },
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Wide range with large gap',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF795548),
          ),
        ),
        SizedBox(height: 4),
        SliderTheme(
          data: SliderThemeData(
            rangeTrackShape: GappedRangeSliderTrackShape(),
            trackHeight: 10.0,
            activeTrackColor: Color(0xFF4527A0),
            inactiveTrackColor: Color(0xFFD1C4E9),
            rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 12),
          ),
          child: RangeSlider(
            values: RangeValues(0.1, 0.9),
            min: 0.0,
            max: 1.0,
            divisions: 10,
            onChanged: (RangeValues v) {
              print('Wide range slider changed');
            },
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Left-biased range',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF795548),
          ),
        ),
        SizedBox(height: 4),
        SliderTheme(
          data: SliderThemeData(
            rangeTrackShape: GappedRangeSliderTrackShape(),
            trackHeight: 6.0,
            activeTrackColor: Color(0xFF00838F),
            inactiveTrackColor: Color(0xFFB2EBF2),
            rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 10),
          ),
          child: RangeSlider(
            values: RangeValues(0.05, 0.35),
            min: 0.0,
            max: 1.0,
            onChanged: (RangeValues v) {
              print('Left-biased slider changed');
            },
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Right-biased range',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF795548),
          ),
        ),
        SizedBox(height: 4),
        SliderTheme(
          data: SliderThemeData(
            rangeTrackShape: GappedRangeSliderTrackShape(),
            trackHeight: 6.0,
            activeTrackColor: Color(0xFFAD1457),
            inactiveTrackColor: Color(0xFFF8BBD0),
            rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 10),
          ),
          child: RangeSlider(
            values: RangeValues(0.65, 0.95),
            min: 0.0,
            max: 1.0,
            onChanged: (RangeValues v) {
              print('Right-biased slider changed');
            },
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Overlapping thumbs (minimum gap)',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF795548),
          ),
        ),
        SizedBox(height: 4),
        SliderTheme(
          data: SliderThemeData(
            rangeTrackShape: GappedRangeSliderTrackShape(),
            trackHeight: 8.0,
            activeTrackColor: Color(0xFF37474F),
            inactiveTrackColor: Color(0xFFB0BEC5),
            rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 11),
          ),
          child: RangeSlider(
            values: RangeValues(0.49, 0.51),
            min: 0.0,
            max: 1.0,
            divisions: 100,
            onChanged: (RangeValues v) {
              print('Overlapping thumbs slider changed');
            },
          ),
        ),
      ],
    ),
  );
}

Widget _buildDebugSection() {
  print('Building debug info section');
  print('--- GappedRangeSliderTrackShape Debug Info ---');
  print('Shape type: GappedRangeSliderTrackShape');
  print('Extends: RangeSliderTrackShape');
  print('Used with: SliderThemeData.rangeTrackShape');
  print('Applicable to: RangeSlider widget');
  print('Comparison Target: RoundedRectRangeSliderTrackShape');
  print('Gap behavior: Visible gap between thumbs');
  print('Track height: Configurable via SliderThemeData.trackHeight');
  print('Active color: Configurable via SliderThemeData.activeTrackColor');
  print('Inactive color: Configurable via SliderThemeData.inactiveTrackColor');
  print('--- End Debug Info ---');

  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0xFF4CAF50), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.bug_report, color: Color(0xFF4CAF50), size: 18),
            SizedBox(width: 8),
            Text(
              'Debug Information',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4CAF50),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        _buildDebugLine('Shape', 'GappedRangeSliderTrackShape'),
        _buildDebugLine('Parent', 'RangeSliderTrackShape'),
        _buildDebugLine('Theme Property', 'rangeTrackShape'),
        _buildDebugLine('Widget', 'RangeSlider'),
        _buildDebugLine('Gap Effect', 'Between thumbs'),
        _buildDebugLine('Comparison', 'RoundedRectRangeSliderTrackShape'),
        _buildDebugLine('Track Height', 'Configurable'),
        _buildDebugLine('Active Track', 'Painted near thumbs'),
        _buildDebugLine('Inactive Track', 'Painted on extremes'),
        _buildDebugLine('Center Gap', 'Unpainted region'),
      ],
    ),
  );
}

Widget _buildDebugLine(String key, String value) {
  return Padding(
    padding: EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Text(
          key + ': ',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF80CBC4),
            fontFamily: 'monospace',
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFFB0BEC5),
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== GappedRangeSliderTrackShape Visual Demo ===');
  print(
    'Demonstrating the gapped range slider track shape with multiple configurations',
  );
  print('Widget: GappedRangeSliderTrackShape');
  print('Category: material / SliderTrackShape');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('GappedRangeSliderTrackShape Demo'),
        backgroundColor: Color(0xFF4A148C),
        foregroundColor: Color(0xFFFFFFFF),
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              '1. Default RangeSlider Reference',
              Color(0xFF1565C0),
            ),
            SizedBox(height: 10),
            _buildDefaultRangeSliderSection(),
            SizedBox(height: 24),

            _buildSectionHeader(
              '2. GappedRangeSliderTrackShape',
              Color(0xFF7B1FA2),
            ),
            SizedBox(height: 10),
            _buildGappedTrackSection(),
            SizedBox(height: 24),

            _buildSectionHeader('3. Color Scheme Gallery', Color(0xFF00695C)),
            SizedBox(height: 10),
            _buildColorSchemeSliders(),
            SizedBox(height: 24),

            _buildSectionHeader(
              '4. Track Height Variations',
              Color(0xFF3F51B5),
            ),
            SizedBox(height: 10),
            _buildTrackHeightSliders(),
            SizedBox(height: 24),

            _buildSectionHeader('5. Shape Comparison', Color(0xFF455A64)),
            SizedBox(height: 10),
            _buildComparisonSection(),
            SizedBox(height: 24),

            _buildSectionHeader(
              '6. Additional Configurations',
              Color(0xFFF57F17),
            ),
            SizedBox(height: 10),
            _buildAdditionalDemoSliders(),
            SizedBox(height: 24),

            _buildSectionHeader('7. Property Information', Color(0xFF5C6BC0)),
            SizedBox(height: 10),
            _buildPropertyInfoSection(),
            SizedBox(height: 24),

            _buildSectionHeader('8. Debug Info', Color(0xFF2E7D32)),
            SizedBox(height: 10),
            _buildDebugSection(),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}
