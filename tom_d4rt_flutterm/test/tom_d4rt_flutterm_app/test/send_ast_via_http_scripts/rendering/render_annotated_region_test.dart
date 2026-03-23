// ignore_for_file: avoid_print
// Deep demo: RenderAnnotatedRegion / AnnotatedRegion<SystemUiOverlayStyle>
// Tests annotating regions of the render tree with system UI overlay data
// Demonstrates light/dark styles, custom configs, sized behavior, nesting, layout contexts

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('[render_annotated_region_test] build() called');

  // Light system UI overlay style
  SystemUiOverlayStyle lightStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.grey,
  );
  print('[render_annotated_region_test] lightStyle created: statusBarIconBrightness=dark');

  // Dark system UI overlay style
  SystemUiOverlayStyle darkStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Color(0xFF1A1A2E),
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: Color(0xFF16213E),
  );
  print('[render_annotated_region_test] darkStyle created: statusBarIconBrightness=light');

  // Custom accent style - blue tinted
  SystemUiOverlayStyle blueAccentStyle = SystemUiOverlayStyle(
    statusBarColor: Color(0x330D47A1),
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Color(0xFF0D47A1),
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: Color(0xFF1565C0),
  );
  print('[render_annotated_region_test] blueAccentStyle created');

  // Custom accent style - green tinted
  SystemUiOverlayStyle greenAccentStyle = SystemUiOverlayStyle(
    statusBarColor: Color(0x331B5E20),
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Color(0xFF1B5E20),
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: Color(0xFF2E7D32),
  );
  print('[render_annotated_region_test] greenAccentStyle created');

  // Custom accent style - orange tinted
  SystemUiOverlayStyle orangeAccentStyle = SystemUiOverlayStyle(
    statusBarColor: Color(0x33E65100),
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Color(0xFFE65100),
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: Color(0xFFEF6C00),
  );
  print('[render_annotated_region_test] orangeAccentStyle created');

  // Custom accent style - purple tinted
  SystemUiOverlayStyle purpleAccentStyle = SystemUiOverlayStyle(
    statusBarColor: Color(0x334A148C),
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Color(0xFF4A148C),
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: Color(0xFF6A1B9A),
  );
  print('[render_annotated_region_test] purpleAccentStyle created');

  // Helper: gradient header
  Widget buildGradientHeader(String title, List<Color> colors) {
    print('[render_annotated_region_test] buildGradientHeader: $title');
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colors[0].withValues(alpha: 0.4),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  // Helper: section title with icon
  Widget buildSectionTitle(String title, IconData icon, Color color) {
    print('[render_annotated_region_test] buildSectionTitle: $title');
    return Padding(
      padding: EdgeInsets.only(top: 24, bottom: 12),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper: info card with shadow
  Widget buildInfoCard(String label, String description, Color accent) {
    print('[render_annotated_region_test] buildInfoCard: $label');
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border(left: BorderSide(color: accent, width: 4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(fontSize: 13, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }

  // Helper: style preview chip
  Widget buildStylePreviewChip(String name, Color statusColor, Color navColor, Brightness iconBrightness) {
    print('[render_annotated_region_test] buildStylePreviewChip: $name');
    Color iconColor = iconBrightness == Brightness.light ? Colors.white : Colors.black;
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: Row(
        children: [
          // Status bar preview
          Container(
            width: 80,
            height: 24,
            decoration: BoxDecoration(
              color: statusColor == Colors.transparent ? Colors.grey[200] : statusColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.signal_cellular_4_bar, size: 10, color: iconColor),
                  SizedBox(width: 2),
                  Icon(Icons.wifi, size: 10, color: iconColor),
                  SizedBox(width: 2),
                  Icon(Icons.battery_full, size: 10, color: iconColor),
                ],
              ),
            ),
          ),
          SizedBox(width: 10),
          // Nav bar preview
          Container(
            width: 80,
            height: 24,
            decoration: BoxDecoration(
              color: navColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back, size: 10, color: iconColor),
                  SizedBox(width: 6),
                  Icon(Icons.circle_outlined, size: 10, color: iconColor),
                  SizedBox(width: 6),
                  Icon(Icons.crop_square, size: 10, color: iconColor),
                ],
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // Section 1: AnnotatedRegion with Light Style
  // -------------------------------------------------------------------
  print('[render_annotated_region_test] Building Section 1: Light Style');
  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildGradientHeader(
        'RenderAnnotatedRegion Demo',
        [Color(0xFF6A11CB), Color(0xFF2575FC)],
      ),
      SizedBox(height: 8),
      buildInfoCard(
        'What is AnnotatedRegion?',
        'AnnotatedRegion<T> annotates the render tree layer with data of type T. '
            'The most common use is AnnotatedRegion<SystemUiOverlayStyle> which '
            'sets the status bar and navigation bar appearance on mobile platforms.',
        Color(0xFF6A11CB),
      ),
      buildSectionTitle('1. Light System UI Overlay Style', Icons.light_mode, Colors.amber[800]!),
      AnnotatedRegion(
        value: lightStyle,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
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
                  Icon(Icons.wb_sunny, color: Colors.amber[700], size: 28),
                  SizedBox(width: 10),
                  Text(
                    'Light Style Applied',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              buildStylePreviewChip(
                'Status: dark icons on light bg',
                Colors.transparent,
                Colors.white,
                Brightness.dark,
              ),
              buildInfoCard(
                'Configuration',
                'statusBarColor: transparent\n'
                    'statusBarIconBrightness: dark\n'
                    'systemNavigationBarColor: white\n'
                    'systemNavigationBarIconBrightness: dark',
                Colors.amber[800]!,
              ),
              Text(
                'This wraps child content with a light overlay annotation. '
                    'Status bar icons appear dark on a light background.',
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  // -------------------------------------------------------------------
  // Section 2: AnnotatedRegion with Dark Style
  // -------------------------------------------------------------------
  print('[render_annotated_region_test] Building Section 2: Dark Style');
  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle('2. Dark System UI Overlay Style', Icons.dark_mode, Color(0xFF1A1A2E)),
      AnnotatedRegion(
        value: darkStyle,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFF1A1A2E),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF1A1A2E).withValues(alpha: 0.4),
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
                  Icon(Icons.nightlight_round, color: Colors.amber[300], size: 28),
                  SizedBox(width: 10),
                  Text(
                    'Dark Style Applied',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              buildStylePreviewChip(
                'Status: light icons on dark bg',
                Colors.transparent,
                Color(0xFF1A1A2E),
                Brightness.light,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Color(0xFF16213E),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Configuration',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.amber[300],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'statusBarColor: transparent\n'
                          'statusBarIconBrightness: light\n'
                          'systemNavigationBarColor: #1A1A2E\n'
                          'systemNavigationBarIconBrightness: light',
                      style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),
              Text(
                'This wraps child content with a dark overlay annotation. '
                    'Status bar icons appear light on a dark background.',
                style: TextStyle(fontSize: 13, color: Colors.grey[400]),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  // -------------------------------------------------------------------
  // Section 3: Custom SystemUiOverlayStyle Configurations
  // -------------------------------------------------------------------
  print('[render_annotated_region_test] Building Section 3: Custom Configs');
  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle('3. Custom Style Configurations', Icons.palette, Colors.deepPurple),
      buildInfoCard(
        'Custom Styles',
        'SystemUiOverlayStyle allows full customization of statusBarColor, '
            'systemNavigationBarColor, icon brightness, and divider colors.',
        Colors.deepPurple,
      ),
      // Blue accent region
      AnnotatedRegion(
        value: blueAccentStyle,
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Blue Accent Region', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 4),
              Text('Nav bar: #0D47A1, Divider: #1565C0', style: TextStyle(fontSize: 12, color: Colors.blue[100])),
            ],
          ),
        ),
      ),
      // Green accent region
      AnnotatedRegion(
        value: greenAccentStyle,
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1B5E20), Color(0xFF388E3C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Green Accent Region', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 4),
              Text('Nav bar: #1B5E20, Divider: #2E7D32', style: TextStyle(fontSize: 12, color: Colors.green[100])),
            ],
          ),
        ),
      ),
      // Orange accent region
      AnnotatedRegion(
        value: orangeAccentStyle,
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE65100), Color(0xFFF57C00)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Orange Accent Region', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 4),
              Text('Nav bar: #E65100, Divider: #EF6C00', style: TextStyle(fontSize: 12, color: Colors.orange[100])),
            ],
          ),
        ),
      ),
      // Purple accent region
      AnnotatedRegion(
        value: purpleAccentStyle,
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4A148C), Color(0xFF7B1FA2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Purple Accent Region', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 4),
              Text('Nav bar: #4A148C, Divider: #6A1B9A', style: TextStyle(fontSize: 12, color: Colors.purple[100])),
            ],
          ),
        ),
      ),
    ],
  );

  // -------------------------------------------------------------------
  // Section 4: sized=true vs sized=false
  // -------------------------------------------------------------------
  print('[render_annotated_region_test] Building Section 4: sized parameter');
  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle('4. sized=true vs sized=false', Icons.aspect_ratio, Colors.teal),
      buildInfoCard(
        'sized parameter',
        'When sized=true (default), the annotation is limited to the size of '
            'this widget. When sized=false, the annotation extends to the full '
            'screen, regardless of the widget\'s layout bounds.',
        Colors.teal,
      ),
      // sized = true (default)
      Row(
        children: [
          Expanded(
            child: AnnotatedRegion(
              value: lightStyle,
              sized: true,
              child: Container(
                height: 120,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.teal[300]!, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_box, color: Colors.teal[700], size: 24),
                    SizedBox(height: 6),
                    Text(
                      'sized: true',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.teal[800]),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Annotation scoped to widget bounds',
                      style: TextStyle(fontSize: 11, color: Colors.teal[600]),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          // sized = false
          Expanded(
            child: AnnotatedRegion(
              value: darkStyle,
              sized: false,
              child: Container(
                height: 120,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFF1A1A2E),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xFF16213E), width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.fullscreen, color: Colors.amber[300], size: 24),
                    SizedBox(height: 6),
                    Text(
                      'sized: false',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Annotation extends to full screen',
                      style: TextStyle(fontSize: 11, color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 10),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.teal[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.teal[200]!, width: 1),
        ),
        child: Text(
          'When sized=false, even a small widget annotates the entire screen. '
              'This is useful when you want a deeply nested widget to control the '
              'system chrome for the whole page.',
          style: TextStyle(fontSize: 12, color: Colors.teal[800]),
        ),
      ),
    ],
  );

  // -------------------------------------------------------------------
  // Section 5: Nested AnnotatedRegion (inner overrides outer)
  // -------------------------------------------------------------------
  print('[render_annotated_region_test] Building Section 5: Nesting');
  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle('5. Nested AnnotatedRegion Widgets', Icons.layers, Colors.indigo),
      buildInfoCard(
        'Nesting Behavior',
        'When AnnotatedRegion widgets are nested, the innermost annotation '
            'overrides the outer one for the overlapping region. The system uses '
            'the topmost (closest to the root) hit-testable annotation.',
        Colors.indigo,
      ),
      // Outer region - light
      AnnotatedRegion(
        value: lightStyle,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.indigo[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.indigo[200]!, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.layers_outlined, color: Colors.indigo[400], size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Outer: Light Style',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.indigo[700]),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'This outer region applies the light overlay style.',
                style: TextStyle(fontSize: 12, color: Colors.indigo[500]),
              ),
              SizedBox(height: 12),
              // Inner region - dark (overrides)
              AnnotatedRegion(
                value: darkStyle,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Color(0xFF1A1A2E),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.amber[300]!, width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.layers, color: Colors.amber[300], size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Inner: Dark Style (Overrides)',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.amber[300]),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'This inner region overrides the outer light style with dark. '
                            'The system chrome will use the dark configuration for this area.',
                        style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                      ),
                      SizedBox(height: 10),
                      // Deepest nested region - blue accent
                      AnnotatedRegion(
                        value: blueAccentStyle,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF0D47A1), Color(0xFF1565C0)],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Deepest: Blue Accent (Overrides All)',
                                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Three levels deep: light -> dark -> blue accent',
                                style: TextStyle(fontSize: 11, color: Colors.blue[100]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Back to outer light style region here.',
                style: TextStyle(fontSize: 12, color: Colors.indigo[500]),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  // -------------------------------------------------------------------
  // Section 6: AnnotatedRegion in Different Layout Contexts
  // -------------------------------------------------------------------
  print('[render_annotated_region_test] Building Section 6: Layout Contexts');

  // Simulated AppBar area
  Widget appBarAreaDemo = Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          // Simulated status bar area
          AnnotatedRegion(
            value: darkStyle,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Color(0xFF1A1A2E),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('9:41', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600)),
                  Row(
                    children: [
                      Icon(Icons.signal_cellular_4_bar, size: 12, color: Colors.white),
                      SizedBox(width: 4),
                      Icon(Icons.wifi, size: 12, color: Colors.white),
                      SizedBox(width: 4),
                      Icon(Icons.battery_full, size: 12, color: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Simulated AppBar
          AnnotatedRegion(
            value: darkStyle,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              color: Color(0xFF16213E),
              child: Row(
                children: [
                  Icon(Icons.arrow_back, color: Colors.white, size: 22),
                  SizedBox(width: 16),
                  Text(
                    'AppBar Area Context',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                  Spacer(),
                  Icon(Icons.more_vert, color: Colors.white, size: 22),
                ],
              ),
            ),
          ),
          // Tag
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            color: Colors.grey[100],
            child: Text(
              'AnnotatedRegion wraps the AppBar + status bar area with dark style',
              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    ),
  );

  // Simulated body area
  Widget bodyAreaDemo = Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey[300]!, width: 1),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AnnotatedRegion(
        value: lightStyle,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Body Area Context',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[800]),
              ),
              SizedBox(height: 8),
              Text(
                'The body area uses a light AnnotatedRegion. Content here '
                    'includes lists, cards, forms, and other primary interface elements.',
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
              SizedBox(height: 12),
              // Sample list items in body
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.article, color: Colors.blue[400], size: 20),
                    SizedBox(width: 10),
                    Text('Sample list item in body', style: TextStyle(fontSize: 13)),
                  ],
                ),
              ),
              SizedBox(height: 6),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.photo, color: Colors.green[400], size: 20),
                    SizedBox(width: 10),
                    Text('Another body item with light style', style: TextStyle(fontSize: 13)),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'AnnotatedRegion wraps the body area with light style',
                style: TextStyle(fontSize: 11, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  // Simulated bottom nav area
  Widget bottomNavAreaDemo = Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 6,
          offset: Offset(0, -2),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          // Tag
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            color: Colors.grey[100],
            child: Text(
              'AnnotatedRegion wraps bottom nav with a matched navigation bar color',
              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
            ),
          ),
          // Simulated bottom nav
          AnnotatedRegion(
            value: SystemUiOverlayStyle(
              systemNavigationBarColor: Color(0xFF0D47A1),
              systemNavigationBarIconBrightness: Brightness.light,
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12),
              color: Color(0xFF0D47A1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.home, color: Colors.white, size: 22),
                      Text('Home', style: TextStyle(fontSize: 10, color: Colors.white)),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.search, color: Colors.white70, size: 22),
                      Text('Search', style: TextStyle(fontSize: 10, color: Colors.white70)),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.person, color: Colors.white70, size: 22),
                      Text('Profile', style: TextStyle(fontSize: 10, color: Colors.white70)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Simulated system nav bar
          Container(
            width: double.infinity,
            height: 20,
            color: Color(0xFF0D47A1),
            child: Center(
              child: Container(
                width: 100,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle('6. Layout Contexts', Icons.view_quilt, Colors.blue[800]!),
      buildInfoCard(
        'Layout Placement',
        'AnnotatedRegion is typically placed around the AppBar (dark style), '
            'body (light style), or bottom navigation (matching nav bar color). '
            'Each region independently controls its system chrome appearance.',
        Colors.blue[800]!,
      ),
      appBarAreaDemo,
      bodyAreaDemo,
      bottomNavAreaDemo,
    ],
  );

  // -------------------------------------------------------------------
  // Section 7: Visual Comparison of System Chrome Styles
  // -------------------------------------------------------------------
  print('[render_annotated_region_test] Building Section 7: Visual Comparison');
  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSectionTitle('7. System Chrome Style Comparison', Icons.compare, Colors.deepOrange),
      buildInfoCard(
        'Side-by-Side Comparison',
        'Compare how different SystemUiOverlayStyle configurations affect '
            'the appearance of status bar and navigation bar elements.',
        Colors.deepOrange,
      ),
      // Comparison grid
      Row(
        children: [
          Expanded(
            child: AnnotatedRegion(
              value: lightStyle,
              child: Container(
                height: 140,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.signal_cellular_4_bar, size: 9, color: Colors.black87),
                            SizedBox(width: 3),
                            Icon(Icons.wifi, size: 9, color: Colors.black87),
                            SizedBox(width: 3),
                            Icon(Icons.battery_full, size: 9, color: Colors.black87),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Light', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey[800])),
                    SizedBox(height: 4),
                    Text('Dark icons\nWhite nav bar\nGrey divider', style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: AnnotatedRegion(
              value: darkStyle,
              child: Container(
                height: 140,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFF1A1A2E),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFF16213E),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.signal_cellular_4_bar, size: 9, color: Colors.white),
                            SizedBox(width: 3),
                            Icon(Icons.wifi, size: 9, color: Colors.white),
                            SizedBox(width: 3),
                            Icon(Icons.battery_full, size: 9, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Dark', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 4),
                    Text('Light icons\nDark nav bar\nDark divider', style: TextStyle(fontSize: 10, color: Colors.grey[400])),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 8),
      Row(
        children: [
          Expanded(
            child: AnnotatedRegion(
              value: blueAccentStyle,
              child: Container(
                height: 140,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFF0D47A1), Color(0xFF1976D2)]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFF0D47A1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.signal_cellular_4_bar, size: 9, color: Colors.white),
                            SizedBox(width: 3),
                            Icon(Icons.wifi, size: 9, color: Colors.white),
                            SizedBox(width: 3),
                            Icon(Icons.battery_full, size: 9, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Blue', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 4),
                    Text('Light icons\nBlue nav bar\nBlue divider', style: TextStyle(fontSize: 10, color: Colors.blue[100])),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: AnnotatedRegion(
              value: greenAccentStyle,
              child: Container(
                height: 140,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF388E3C)]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFF1B5E20),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.signal_cellular_4_bar, size: 9, color: Colors.white),
                            SizedBox(width: 3),
                            Icon(Icons.wifi, size: 9, color: Colors.white),
                            SizedBox(width: 3),
                            Icon(Icons.battery_full, size: 9, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Green', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 4),
                    Text('Light icons\nGreen nav bar\nGreen divider', style: TextStyle(fontSize: 10, color: Colors.green[100])),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 8),
      Row(
        children: [
          Expanded(
            child: AnnotatedRegion(
              value: orangeAccentStyle,
              child: Container(
                height: 140,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFFE65100), Color(0xFFF57C00)]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFFE65100),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.signal_cellular_4_bar, size: 9, color: Colors.white),
                            SizedBox(width: 3),
                            Icon(Icons.wifi, size: 9, color: Colors.white),
                            SizedBox(width: 3),
                            Icon(Icons.battery_full, size: 9, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Orange', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 4),
                    Text('Light icons\nOrange nav\nOrange divider', style: TextStyle(fontSize: 10, color: Colors.orange[100])),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: AnnotatedRegion(
              value: purpleAccentStyle,
              child: Container(
                height: 140,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFF4A148C), Color(0xFF7B1FA2)]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFF4A148C),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.signal_cellular_4_bar, size: 9, color: Colors.white),
                            SizedBox(width: 3),
                            Icon(Icons.wifi, size: 9, color: Colors.white),
                            SizedBox(width: 3),
                            Icon(Icons.battery_full, size: 9, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Purple', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 4),
                    Text('Light icons\nPurple nav\nPurple divider', style: TextStyle(fontSize: 10, color: Colors.purple[100])),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 16),
      // Summary footer
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'RenderAnnotatedRegion Summary',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              'AnnotatedRegion<SystemUiOverlayStyle> is the declarative way to '
                  'control system chrome appearance. It replaces imperative calls to '
                  'SystemChrome.setSystemUIOverlayStyle() and automatically responds '
                  'to widget lifecycle and navigation transitions.',
              style: TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ],
        ),
      ),
    ],
  );

  // -------------------------------------------------------------------
  // Assemble all sections
  // -------------------------------------------------------------------
  print('[render_annotated_region_test] Assembling all sections into ScrollView');

  Widget result = SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        section1,
        section2,
        section3,
        section4,
        section5,
        section6,
        section7,
        SizedBox(height: 32),
      ],
    ),
  );

  print('[render_annotated_region_test] build() complete - returning widget tree');
  return result;
}
