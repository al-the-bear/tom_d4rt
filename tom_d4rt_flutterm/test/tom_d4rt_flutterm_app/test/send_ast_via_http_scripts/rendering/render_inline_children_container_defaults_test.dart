// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// Deep demo: RenderInlineChildrenContainerDefaults
// Demonstrates inline children (WidgetSpan) rendered within text flow
// using TextParentData positioning and PlaceholderAlignment options.

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('[InlineChildrenContainerDefaults] build() called');
  print(
    '[InlineChildrenContainerDefaults] Building deep demo with inline widget spans',
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF0D0D0D),
      colorSchemeSeed: Colors.tealAccent,
    ),
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 28),

            // Section 1: Basic WidgetSpan with icons inline
            _buildSectionTitle('1. Text.rich with WidgetSpan Icons Inline'),
            SizedBox(height: 10),
            _buildIconsInlineSection(context),
            SizedBox(height: 28),

            // Section 2: WidgetSpan with chips/badges inline
            _buildSectionTitle('2. WidgetSpan with Chips & Badges Inline'),
            SizedBox(height: 10),
            _buildChipsBadgesSection(context),
            SizedBox(height: 28),

            // Section 3: Multiple WidgetSpans in one paragraph
            _buildSectionTitle('3. Multiple WidgetSpans in One Paragraph'),
            SizedBox(height: 10),
            _buildMultipleWidgetSpansSection(context),
            SizedBox(height: 28),

            // Section 4: PlaceholderAlignment values
            _buildSectionTitle('4. PlaceholderAlignment Values'),
            SizedBox(height: 10),
            _buildAlignmentValuesSection(context),
            SizedBox(height: 28),

            // Section 5: Baseline alignment
            _buildSectionTitle('5. WidgetSpan with Baseline Alignment'),
            SizedBox(height: 10),
            _buildBaselineAlignmentSection(context),
            SizedBox(height: 28),

            // Section 6: Mixed TextSpan and WidgetSpan complex layouts
            _buildSectionTitle('6. Mixed TextSpan & WidgetSpan Complex Layout'),
            SizedBox(height: 10),
            _buildMixedComplexSection(context),
            SizedBox(height: 28),

            // Section 7: Inline children in different text styles
            _buildSectionTitle('7. Inline Children with Varied Text Styles'),
            SizedBox(height: 10),
            _buildVariedStylesSection(context),
            SizedBox(height: 28),

            // Section 8: Inline widgets in selection-enabled text
            _buildSectionTitle('8. Inline Widgets in SelectableText'),
            SizedBox(height: 10),
            _buildSelectableTextSection(context),
            SizedBox(height: 28),

            // Section 9: Decorative inline compositions
            _buildSectionTitle('9. Decorative Inline Compositions'),
            SizedBox(height: 10),
            _buildDecorativeCompositionsSection(context),
            SizedBox(height: 28),

            // Section 10: Status bar style inline layout
            _buildSectionTitle('10. Status Bar Style Inline Layout'),
            SizedBox(height: 10),
            _buildStatusBarSection(context),
            SizedBox(height: 36),
          ],
        ),
      ),
    ),
  );
}

Widget _buildHeader() {
  print('[InlineChildrenContainerDefaults] Building header');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: LinearGradient(
        colors: [Color(0xFF004D40), Color(0xFF00897B), Color(0xFF4DB6AC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: Color(0x6600BFA5),
          blurRadius: 20,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'RenderInlineChildrenContainerDefaults',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.6,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Deep demo of inline children rendering within text flow.\n'
          'WidgetSpan embeds widgets inline, positioned via TextParentData.',
          style: TextStyle(fontSize: 14, color: Color(0xCCFFFFFF), height: 1.5),
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title) {
  print('[InlineChildrenContainerDefaults] Section: $title');
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      gradient: LinearGradient(
        colors: [Color(0xFF1A237E), Color(0xFF283593)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFFB3E5FC),
        letterSpacing: 0.3,
      ),
    ),
  );
}

// Section 1: Basic Text.rich with WidgetSpan embedding icons inline
Widget _buildIconsInlineSection(BuildContext context) {
  print('[InlineChildrenContainerDefaults] Building icons inline section');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFF1A1A2E),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF2A2A4A)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            style: TextStyle(fontSize: 16, color: Colors.white, height: 1.8),
            children: [
              TextSpan(text: 'Click the '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(Icons.settings, size: 20, color: Colors.tealAccent),
              ),
              TextSpan(text: ' settings icon to configure, or tap '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(Icons.favorite, size: 20, color: Colors.redAccent),
              ),
              TextSpan(text: ' to favorite this item.'),
            ],
          ),
        ),
        SizedBox(height: 14),
        Text.rich(
          TextSpan(
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFFB0BEC5),
              height: 1.7,
            ),
            children: [
              TextSpan(text: 'Press '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(
                  Icons.play_arrow,
                  size: 18,
                  color: Colors.greenAccent,
                ),
              ),
              TextSpan(text: ' to play, '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(Icons.pause, size: 18, color: Colors.orangeAccent),
              ),
              TextSpan(text: ' to pause, or '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(Icons.stop, size: 18, color: Colors.red),
              ),
              TextSpan(text: ' to stop playback.'),
            ],
          ),
        ),
      ],
    ),
  );
}

// Section 2: WidgetSpan with chips/badges inline
Widget _buildChipsBadgesSection(BuildContext context) {
  print('[InlineChildrenContainerDefaults] Building chips badges section');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFF1A1A2E),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF2A2A4A)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            style: TextStyle(fontSize: 15, color: Colors.white, height: 2.0),
            children: [
              TextSpan(text: 'This task is tagged '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'urgent',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ),
              TextSpan(text: ' and assigned to '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'team-alpha',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ),
              TextSpan(text: ' for review.'),
            ],
          ),
        ),
        SizedBox(height: 12),
        Text.rich(
          TextSpan(
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFFCFD8DC),
              height: 2.0,
            ),
            children: [
              TextSpan(text: 'Status: '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: Color(0xFF2E7D32),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, size: 14, color: Colors.white),
                      SizedBox(width: 4),
                      Text(
                        'Approved',
                        style: TextStyle(fontSize: 11, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              TextSpan(text: '  Priority: '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: Color(0xFFE65100),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'HIGH',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Section 3: Multiple WidgetSpans in one paragraph
Widget _buildMultipleWidgetSpansSection(BuildContext context) {
  print(
    '[InlineChildrenContainerDefaults] Building multiple widget spans section',
  );
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFF1A1A2E),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF2A2A4A)),
    ),
    child: Text.rich(
      TextSpan(
        style: TextStyle(fontSize: 15, color: Colors.white, height: 2.2),
        children: [
          TextSpan(text: 'The pipeline runs: '),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: _buildPipelineStage('Build', Colors.blueAccent, Icons.build),
          ),
          TextSpan(text: ' then '),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: _buildPipelineStage('Test', Colors.amber, Icons.science),
          ),
          TextSpan(text: ' then '),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: _buildPipelineStage(
              'Deploy',
              Colors.greenAccent,
              Icons.cloud_upload,
            ),
          ),
          TextSpan(text: ' and finally '),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: _buildPipelineStage(
              'Monitor',
              Colors.purpleAccent,
              Icons.monitor_heart,
            ),
          ),
          TextSpan(
            text:
                '. Each stage must pass before proceeding to the next step in the continuous delivery workflow.',
          ),
        ],
      ),
    ),
  );
}

Widget _buildPipelineStage(String label, Color color, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color.withOpacity(0.2),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withOpacity(0.5)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// Section 4: PlaceholderAlignment values
Widget _buildAlignmentValuesSection(BuildContext context) {
  print('[InlineChildrenContainerDefaults] Building alignment values section');

  List<Map<String, dynamic>> alignments = [
    {'name': 'top', 'alignment': PlaceholderAlignment.top},
    {'name': 'middle', 'alignment': PlaceholderAlignment.middle},
    {'name': 'bottom', 'alignment': PlaceholderAlignment.bottom},
    {'name': 'aboveBaseline', 'alignment': PlaceholderAlignment.aboveBaseline},
    {'name': 'belowBaseline', 'alignment': PlaceholderAlignment.belowBaseline},
  ];

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFF1A1A2E),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF2A2A4A)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < alignments.length; i++) ...[
          _buildAlignmentRow(
            alignments[i]['name'] as String,
            alignments[i]['alignment'] as PlaceholderAlignment,
          ),
          if (i < alignments.length - 1) SizedBox(height: 12),
        ],
      ],
    ),
  );
}

Widget _buildAlignmentRow(String name, PlaceholderAlignment alignment) {
  print('[InlineChildrenContainerDefaults] Alignment demo: $name');
  return Row(
    children: [
      SizedBox(
        width: 130,
        child: Text(
          name,
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF80CBC4),
            fontFamily: 'monospace',
          ),
        ),
      ),
      Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Color(0xFF0D1117),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text.rich(
            TextSpan(
              style: TextStyle(fontSize: 18, color: Colors.white),
              children: [
                TextSpan(text: 'Text '),
                WidgetSpan(
                  alignment: alignment,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.tealAccent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Icon(Icons.star, size: 16, color: Colors.black),
                    ),
                  ),
                ),
                TextSpan(text: ' here'),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

// Section 5: Baseline alignment
Widget _buildBaselineAlignmentSection(BuildContext context) {
  print(
    '[InlineChildrenContainerDefaults] Building baseline alignment section',
  );
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFF1A1A2E),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF2A2A4A)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Baseline alignment sits the widget on the text baseline:',
          style: TextStyle(fontSize: 13, color: Color(0xFF90A4AE)),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFF0D1117),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text.rich(
            TextSpan(
              style: TextStyle(fontSize: 22, color: Colors.white),
              children: [
                TextSpan(text: 'Price: '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Color(0xFF1B5E20),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '\$49.99',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TextSpan(text: ' per month'),
              ],
            ),
          ),
        ),
        SizedBox(height: 14),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFF0D1117),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text.rich(
            TextSpan(
              style: TextStyle(fontSize: 16, color: Color(0xFFB0BEC5)),
              children: [
                TextSpan(text: 'Score: '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                    decoration: BoxDecoration(
                      color: Color(0xFFFF6F00),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '98.7',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TextSpan(text: ' / 100 — '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: Icon(
                    Icons.emoji_events,
                    size: 22,
                    color: Colors.amber,
                  ),
                ),
                TextSpan(text: ' Excellent!'),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// Section 6: Mixed TextSpan and WidgetSpan complex layouts
Widget _buildMixedComplexSection(BuildContext context) {
  print('[InlineChildrenContainerDefaults] Building mixed complex section');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFF1A1A2E),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF2A2A4A)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            style: TextStyle(fontSize: 15, color: Colors.white, height: 2.0),
            children: [
              TextSpan(
                text: 'Important: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
              TextSpan(text: 'The system detected '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '3 errors',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TextSpan(text: ' and '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '12 warnings',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TextSpan(text: ' in the latest analysis run. Please review the '),
              TextSpan(
                text: 'diagnostics panel',
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  decoration: TextDecoration.underline,
                ),
              ),
              TextSpan(text: ' and fix issues marked with '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(
                  Icons.error_outline,
                  size: 16,
                  color: Colors.redAccent,
                ),
              ),
              TextSpan(text: ' before committing.'),
            ],
          ),
        ),
        SizedBox(height: 16),
        Text.rich(
          TextSpan(
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFFB0BEC5),
              height: 2.0,
            ),
            children: [
              TextSpan(text: 'Contributors: '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.teal,
                  child: Text(
                    'A',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ),
              TextSpan(text: ' Alice, '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.indigo,
                  child: Text(
                    'B',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ),
              TextSpan(text: ' Bob, '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.deepOrange,
                  child: Text(
                    'C',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ),
              TextSpan(text: ' Charlie — all reviewed and approved '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(
                  Icons.verified,
                  size: 16,
                  color: Colors.greenAccent,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Section 7: Inline children in different text styles
Widget _buildVariedStylesSection(BuildContext context) {
  print('[InlineChildrenContainerDefaults] Building varied styles section');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFF1A1A2E),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF2A2A4A)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Large heading style with inline widget
        Text.rich(
          TextSpan(
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            children: [
              TextSpan(text: 'Dashboard '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'BETA',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 14),
        // Medium body style with colored inline widgets
        Text.rich(
          TextSpan(
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFFCFD8DC),
              height: 1.8,
            ),
            children: [
              TextSpan(text: 'Memory usage is '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '42%',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TextSpan(text: ' and CPU is at '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '78%',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TextSpan(text: ' load.'),
            ],
          ),
        ),
        SizedBox(height: 14),
        // Small caption style with tiny inline indicators
        Text.rich(
          TextSpan(
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF78909C),
              height: 1.6,
            ),
            children: [
              TextSpan(text: 'Last updated 5 min ago '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              TextSpan(text: ' live  |  Region: '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(Icons.public, size: 12, color: Color(0xFF78909C)),
              ),
              TextSpan(text: ' eu-west-1'),
            ],
          ),
        ),
        SizedBox(height: 14),
        // Italic style with decorative inline elements
        Text.rich(
          TextSpan(
            style: TextStyle(
              fontSize: 15,
              fontStyle: FontStyle.italic,
              color: Color(0xFFB0BEC5),
              height: 1.8,
            ),
            children: [
              TextSpan(text: '"Simplicity is the ultimate sophistication" '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(
                  Icons.format_quote,
                  size: 18,
                  color: Color(0xFF546E7A),
                ),
              ),
              TextSpan(
                text: ' — Leonardo da Vinci',
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Section 8: Inline widgets in selection-enabled text
Widget _buildSelectableTextSection(BuildContext context) {
  print('[InlineChildrenContainerDefaults] Building selectable text section');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFF1A1A2E),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF2A2A4A)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Try selecting the text below — inline widgets flow with selection:',
          style: TextStyle(fontSize: 13, color: Color(0xFF90A4AE)),
        ),
        SizedBox(height: 12),
        SelectableText.rich(
          TextSpan(
            style: TextStyle(fontSize: 16, color: Colors.white, height: 2.0),
            children: [
              TextSpan(text: 'The Flutter framework supports '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Color(0xFF0277BD),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'WidgetSpan',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ),
              TextSpan(
                text:
                    ' for embedding arbitrary widgets inline. This works with ',
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(
                  Icons.touch_app,
                  size: 18,
                  color: Colors.tealAccent,
                ),
              ),
              TextSpan(text: ' gestures and '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(
                  Icons.select_all,
                  size: 18,
                  color: Colors.amberAccent,
                ),
              ),
              TextSpan(text: ' text selection seamlessly.'),
            ],
          ),
        ),
        SizedBox(height: 14),
        SelectableText.rich(
          TextSpan(
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFFB0BEC5),
              height: 1.8,
            ),
            children: [
              TextSpan(text: 'Version '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Color(0xFF37474F),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Color(0xFF546E7A)),
                  ),
                  child: Text(
                    '3.24.1',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.tealAccent,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ),
              TextSpan(text: ' released on March 2026 '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(
                  Icons.new_releases,
                  size: 16,
                  color: Colors.amberAccent,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Section 9: Decorative inline compositions
Widget _buildDecorativeCompositionsSection(BuildContext context) {
  print(
    '[InlineChildrenContainerDefaults] Building decorative compositions section',
  );
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFF1A1A2E),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF2A2A4A)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Rating inline display
        Text.rich(
          TextSpan(
            style: TextStyle(fontSize: 16, color: Colors.white, height: 2.0),
            children: [
              TextSpan(text: 'Customer rating: '),
              for (int i = 0; i < 5; i++)
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(
                    i < 4 ? Icons.star : Icons.star_half,
                    size: 18,
                    color: Colors.amber,
                  ),
                ),
              TextSpan(text: ' 4.5/5.0 (2,341 reviews)'),
            ],
          ),
        ),
        SizedBox(height: 14),
        // Progress inline display
        Text.rich(
          TextSpan(
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFFCFD8DC),
              height: 2.2,
            ),
            children: [
              TextSpan(text: 'Upload progress: '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: SizedBox(
                  width: 100,
                  height: 8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: 0.73,
                      backgroundColor: Color(0xFF37474F),
                      valueColor: AlwaysStoppedAnimation(Colors.tealAccent),
                    ),
                  ),
                ),
              ),
              TextSpan(text: ' 73% complete'),
            ],
          ),
        ),
        SizedBox(height: 14),
        // Color swatch inline display
        Text.rich(
          TextSpan(
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFFB0BEC5),
              height: 2.2,
            ),
            children: [
              TextSpan(text: 'Theme colors: '),
              for (Color c in [
                Colors.teal,
                Colors.indigo,
                Colors.amber,
                Colors.deepOrange,
                Colors.pink,
              ]) ...[
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Container(
                    width: 16,
                    height: 16,
                    margin: EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      color: c,
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(color: Colors.white24),
                    ),
                  ),
                ),
              ],
              TextSpan(text: ' (5 primary swatches)'),
            ],
          ),
        ),
        SizedBox(height: 14),
        // Keyboard shortcut inline display
        Text.rich(
          TextSpan(
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF90A4AE),
              height: 2.0,
            ),
            children: [
              TextSpan(text: 'Press '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: _buildKeyboardKey('Ctrl'),
              ),
              TextSpan(text: ' + '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: _buildKeyboardKey('Shift'),
              ),
              TextSpan(text: ' + '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: _buildKeyboardKey('P'),
              ),
              TextSpan(text: ' to open the command palette'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildKeyboardKey(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: Color(0xFF37474F),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: Color(0xFF546E7A)),
      boxShadow: [
        BoxShadow(
          color: Color(0x33000000),
          offset: Offset(0, 2),
          blurRadius: 0,
        ),
      ],
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11,
        color: Colors.white,
        fontFamily: 'monospace',
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// Section 10: Status bar style inline layout
Widget _buildStatusBarSection(BuildContext context) {
  print('[InlineChildrenContainerDefaults] Building status bar section');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFF1A1A2E),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF2A2A4A)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Simulated status bar using inline text
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Color(0xFF0D1117),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text.rich(
            TextSpan(
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF90A4AE),
                height: 1.8,
              ),
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(Icons.circle, size: 8, color: Colors.greenAccent),
                ),
                TextSpan(text: ' Connected  '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(
                    Icons.language,
                    size: 14,
                    color: Color(0xFF546E7A),
                  ),
                ),
                TextSpan(text: ' Dart 3.7  '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(
                    Icons.flutter_dash,
                    size: 14,
                    color: Color(0xFF546E7A),
                  ),
                ),
                TextSpan(text: ' Flutter 3.29  '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(Icons.memory, size: 14, color: Color(0xFF546E7A)),
                ),
                TextSpan(text: ' 256MB  '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(Icons.timer, size: 14, color: Color(0xFF546E7A)),
                ),
                TextSpan(text: ' 12ms'),
              ],
            ),
          ),
        ),
        SizedBox(height: 14),
        // Breadcrumb navigation inline
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Color(0xFF0D1117),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text.rich(
            TextSpan(
              style: TextStyle(fontSize: 14, color: Color(0xFFB0BEC5)),
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(Icons.home, size: 16, color: Colors.tealAccent),
                ),
                TextSpan(text: ' Home '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(
                    Icons.chevron_right,
                    size: 16,
                    color: Color(0xFF546E7A),
                  ),
                ),
                TextSpan(text: ' Projects '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(
                    Icons.chevron_right,
                    size: 16,
                    color: Color(0xFF546E7A),
                  ),
                ),
                TextSpan(text: ' Tom Agent '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(
                    Icons.chevron_right,
                    size: 16,
                    color: Color(0xFF546E7A),
                  ),
                ),
                TextSpan(
                  text: ' Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 14),
        // Tag cloud inline display
        Text.rich(
          TextSpan(
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF90A4AE),
              height: 2.4,
            ),
            children: [
              TextSpan(text: 'Tags: '),
              for (Map<String, dynamic> tag in [
                {'label': 'flutter', 'color': Color(0xFF0277BD)},
                {'label': 'dart', 'color': Color(0xFF00695C)},
                {'label': 'inline-rendering', 'color': Color(0xFF6A1B9A)},
                {'label': 'widget-span', 'color': Color(0xFFBF360C)},
                {'label': 'text-layout', 'color': Color(0xFF33691E)},
              ]) ...[
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Container(
                    margin: EdgeInsets.only(right: 6),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: (tag['color'] as Color).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: (tag['color'] as Color).withOpacity(0.6),
                      ),
                    ),
                    child: Text(
                      tag['label'] as String,
                      style: TextStyle(fontSize: 11, color: Colors.white70),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}
