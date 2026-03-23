// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ButtonBarThemeData from material
import 'package:flutter/material.dart';

// Helper to build section title
Widget buildSectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.only(top: 24, bottom: 8, left: 16, right: 16),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.teal.shade800,
      ),
    ),
  );
}

// Helper to build description
Widget buildDescription(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13,
        color: Colors.grey.shade600,
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}

// Helper to build info box
Widget buildInfoBox(String text, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(70)),
    ),
    child: Row(
      children: [
        Icon(Icons.info_outline, color: color, size: 18),
        SizedBox(width: 8),
        Expanded(
          child: Text(text, style: TextStyle(fontSize: 12, color: color)),
        ),
      ],
    ),
  );
}

// Helper: property card showing a theme data configuration
Widget buildThemeDataCard({
  required String title,
  required String description,
  required ButtonBarThemeData themeData,
  List<Widget>? buttons,
}) {
  List<Widget> defaultButtons = buttons ?? [
    TextButton(onPressed: () {}, child: Text('Cancel')),
    ElevatedButton(onPressed: () {}, child: Text('OK')),
  ];

  List<Widget> propertyChips = [];
  if (themeData.alignment != null) {
    String alignName = themeData.alignment.toString().split('.').last;
    propertyChips.add(_buildChip('alignment', alignName));
  }
  if (themeData.mainAxisSize != null) {
    String sizeName = themeData.mainAxisSize.toString().split('.').last;
    propertyChips.add(_buildChip('mainAxisSize', sizeName));
  }
  if (themeData.buttonMinWidth != null) {
    propertyChips.add(_buildChip('buttonMinWidth', themeData.buttonMinWidth.toString()));
  }
  if (themeData.buttonHeight != null) {
    propertyChips.add(_buildChip('buttonHeight', themeData.buttonHeight.toString()));
  }
  if (themeData.buttonPadding != null) {
    propertyChips.add(_buildChip('buttonPadding', 'custom'));
  }
  if (themeData.overflowDirection != null) {
    String dirName = themeData.overflowDirection.toString().split('.').last;
    propertyChips.add(_buildChip('overflowDirection', dirName));
  }

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 2),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.teal.shade700,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 4),
          child: Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),
        ),
        if (propertyChips.isNotEmpty)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Wrap(children: propertyChips),
          ),
        Divider(height: 1),
        ButtonBarTheme(
          data: themeData,
          child: ButtonBar(
            children: defaultButtons,
          ),
        ),
        SizedBox(height: 8),
      ],
    ),
  );
}

// Helper: property chip
Widget _buildChip(String label, String value) {
  return Container(
    margin: EdgeInsets.only(right: 6, bottom: 6),
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.teal.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: TextStyle(fontSize: 10, color: Colors.teal.shade400)),
        SizedBox(width: 4),
        Text(value, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.teal.shade700)),
      ],
    ),
  );
}

// Helper: comparison row
Widget buildComparisonRow(String property, String defaultVal, String customVal) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(property, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(defaultVal, style: TextStyle(fontSize: 11, color: Colors.grey.shade700)),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(customVal, style: TextStyle(fontSize: 11, color: Colors.teal.shade700)),
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== ButtonBarThemeData Deep Demo ===');
  debugPrint('Demonstrating ButtonBarThemeData property configurations');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade700, Colors.teal.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ButtonBarThemeData Demo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Visual representation of all ButtonBarThemeData properties',
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Deprecated - use OverflowBar instead',
                  style: TextStyle(fontSize: 11, color: Colors.brown.shade800),
                ),
              ),
            ],
          ),
        ),

        // Section 1: Alignment Property
        buildSectionTitle('1. Alignment Property'),
        buildDescription('ButtonBarThemeData.alignment sets the horizontal alignment of buttons'),

        buildThemeDataCard(
          title: 'alignment: start',
          description: 'Buttons aligned to the left',
          themeData: ButtonBarThemeData(alignment: MainAxisAlignment.start),
        ),
        buildThemeDataCard(
          title: 'alignment: center',
          description: 'Buttons centered within the bar',
          themeData: ButtonBarThemeData(alignment: MainAxisAlignment.center),
        ),
        buildThemeDataCard(
          title: 'alignment: end (default)',
          description: 'Buttons aligned to the right',
          themeData: ButtonBarThemeData(alignment: MainAxisAlignment.end),
        ),
        buildThemeDataCard(
          title: 'alignment: spaceBetween',
          description: 'Even spacing between buttons',
          themeData: ButtonBarThemeData(alignment: MainAxisAlignment.spaceBetween),
          buttons: [
            TextButton(onPressed: () {}, child: Text('Cancel')),
            OutlinedButton(onPressed: () {}, child: Text('Draft')),
            ElevatedButton(onPressed: () {}, child: Text('OK')),
          ],
        ),
        buildThemeDataCard(
          title: 'alignment: spaceEvenly',
          description: 'Equal spacing around all buttons',
          themeData: ButtonBarThemeData(alignment: MainAxisAlignment.spaceEvenly),
          buttons: [
            TextButton(onPressed: () {}, child: Text('A')),
            TextButton(onPressed: () {}, child: Text('B')),
            TextButton(onPressed: () {}, child: Text('C')),
            TextButton(onPressed: () {}, child: Text('D')),
          ],
        ),

        // Section 2: Button Padding
        buildSectionTitle('2. Button Padding'),
        buildDescription('buttonPadding controls spacing between individual buttons'),

        buildThemeDataCard(
          title: 'No padding (EdgeInsets.zero)',
          description: 'Buttons packed tightly together',
          themeData: ButtonBarThemeData(
            buttonPadding: EdgeInsets.zero,
          ),
          buttons: [
            ElevatedButton(onPressed: () {}, child: Text('A')),
            ElevatedButton(onPressed: () {}, child: Text('B')),
            ElevatedButton(onPressed: () {}, child: Text('C')),
          ],
        ),
        buildThemeDataCard(
          title: 'Horizontal padding: 8',
          description: 'Moderate horizontal spacing',
          themeData: ButtonBarThemeData(
            buttonPadding: EdgeInsets.symmetric(horizontal: 8),
          ),
          buttons: [
            ElevatedButton(onPressed: () {}, child: Text('A')),
            ElevatedButton(onPressed: () {}, child: Text('B')),
            ElevatedButton(onPressed: () {}, child: Text('C')),
          ],
        ),
        buildThemeDataCard(
          title: 'Large padding: 20',
          description: 'Wide spacing between buttons',
          themeData: ButtonBarThemeData(
            buttonPadding: EdgeInsets.symmetric(horizontal: 20),
          ),
          buttons: [
            ElevatedButton(onPressed: () {}, child: Text('A')),
            ElevatedButton(onPressed: () {}, child: Text('B')),
            ElevatedButton(onPressed: () {}, child: Text('C')),
          ],
        ),
        buildThemeDataCard(
          title: 'Both axes padding: 12',
          description: 'Padding on all sides around each button',
          themeData: ButtonBarThemeData(
            buttonPadding: EdgeInsets.all(12),
          ),
          buttons: [
            ElevatedButton(onPressed: () {}, child: Text('Wide')),
            ElevatedButton(onPressed: () {}, child: Text('Spacing')),
          ],
        ),

        // Section 3: Button Min Width
        buildSectionTitle('3. Button Min Width'),
        buildDescription('buttonMinWidth sets a minimum width for all buttons'),

        buildThemeDataCard(
          title: 'buttonMinWidth: 40',
          description: 'Very small minimum width, buttons are compact',
          themeData: ButtonBarThemeData(buttonMinWidth: 40),
          buttons: [
            TextButton(onPressed: () {}, child: Text('A')),
            TextButton(onPressed: () {}, child: Text('B')),
            TextButton(onPressed: () {}, child: Text('C')),
            TextButton(onPressed: () {}, child: Text('D')),
          ],
        ),
        buildThemeDataCard(
          title: 'buttonMinWidth: 100',
          description: 'Medium minimum width for uniform button sizing',
          themeData: ButtonBarThemeData(buttonMinWidth: 100),
          buttons: [
            ElevatedButton(onPressed: () {}, child: Text('Yes')),
            ElevatedButton(onPressed: () {}, child: Text('No')),
          ],
        ),
        buildThemeDataCard(
          title: 'buttonMinWidth: 150',
          description: 'Large minimum width, all buttons are wide',
          themeData: ButtonBarThemeData(buttonMinWidth: 150),
          buttons: [
            ElevatedButton(onPressed: () {}, child: Text('Accept')),
            OutlinedButton(onPressed: () {}, child: Text('Decline')),
          ],
        ),

        // Section 4: Button Height
        buildSectionTitle('4. Button Height'),
        buildDescription('buttonHeight sets minimum height for all buttons'),

        buildThemeDataCard(
          title: 'buttonHeight: 36 (default-like)',
          description: 'Standard button height',
          themeData: ButtonBarThemeData(buttonHeight: 36),
        ),
        buildThemeDataCard(
          title: 'buttonHeight: 48',
          description: 'Taller touch-friendly buttons',
          themeData: ButtonBarThemeData(buttonHeight: 48),
        ),
        buildThemeDataCard(
          title: 'buttonHeight: 60',
          description: 'Extra tall buttons for emphasis',
          themeData: ButtonBarThemeData(buttonHeight: 60),
          buttons: [
            ElevatedButton(onPressed: () {}, child: Text('Tall Button')),
            TextButton(onPressed: () {}, child: Text('Cancel')),
          ],
        ),

        // Section 5: Main Axis Size
        buildSectionTitle('5. Main Axis Size'),
        buildDescription('mainAxisSize controls if ButtonBar expands or shrinks'),

        buildThemeDataCard(
          title: 'mainAxisSize: max (expand)',
          description: 'ButtonBar takes full available width',
          themeData: ButtonBarThemeData(mainAxisSize: MainAxisSize.max),
        ),
        buildThemeDataCard(
          title: 'mainAxisSize: min (shrink)',
          description: 'ButtonBar only as wide as needed',
          themeData: ButtonBarThemeData(mainAxisSize: MainAxisSize.min),
        ),

        // Section 6: Overflow Direction
        buildSectionTitle('6. Overflow Direction'),
        buildDescription('overflowDirection controls layout when buttons overflow'),

        buildThemeDataCard(
          title: 'overflowDirection: horizontal',
          description: 'Buttons overflow horizontally',
          themeData: ButtonBarThemeData(overflowDirection: VerticalDirection.down),
          buttons: [
            ElevatedButton(onPressed: () {}, child: Text('Action 1')),
            ElevatedButton(onPressed: () {}, child: Text('Action 2')),
            ElevatedButton(onPressed: () {}, child: Text('Action 3')),
          ],
        ),
        buildThemeDataCard(
          title: 'overflowDirection: up',
          description: 'Overflow stacks upward',
          themeData: ButtonBarThemeData(overflowDirection: VerticalDirection.up),
          buttons: [
            ElevatedButton(onPressed: () {}, child: Text('Action 1')),
            ElevatedButton(onPressed: () {}, child: Text('Action 2')),
            ElevatedButton(onPressed: () {}, child: Text('Action 3')),
          ],
        ),

        // Section 7: Combined Properties
        buildSectionTitle('7. Combined Properties'),
        buildDescription('Multiple properties applied together'),

        buildThemeDataCard(
          title: 'Centered, Wide, Padded',
          description: 'alignment + buttonMinWidth + buttonPadding',
          themeData: ButtonBarThemeData(
            alignment: MainAxisAlignment.center,
            buttonMinWidth: 120,
            buttonPadding: EdgeInsets.symmetric(horizontal: 12),
          ),
          buttons: [
            ElevatedButton(onPressed: () {}, child: Text('Accept')),
            OutlinedButton(onPressed: () {}, child: Text('Reject')),
          ],
        ),
        buildThemeDataCard(
          title: 'Start, Tall, Tight',
          description: 'alignment:start + buttonHeight:50 + padding:zero',
          themeData: ButtonBarThemeData(
            alignment: MainAxisAlignment.start,
            buttonHeight: 50,
            buttonPadding: EdgeInsets.zero,
          ),
          buttons: [
            ElevatedButton(onPressed: () {}, child: Text('Tall Start')),
            TextButton(onPressed: () {}, child: Text('Cancel')),
          ],
        ),
        buildThemeDataCard(
          title: 'SpaceBetween, Min, Wide Buttons',
          description: 'Full featured configuration',
          themeData: ButtonBarThemeData(
            alignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            buttonMinWidth: 90,
            buttonHeight: 44,
            buttonPadding: EdgeInsets.symmetric(horizontal: 4),
          ),
          buttons: [
            TextButton(onPressed: () {}, child: Text('Skip')),
            OutlinedButton(onPressed: () {}, child: Text('Draft')),
            ElevatedButton(onPressed: () {}, child: Text('Submit')),
          ],
        ),

        // Section 8: Comparison Table
        buildSectionTitle('8. Default vs Custom Comparison'),
        buildDescription('Comparing default ButtonBar with themed ButtonBar'),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Property Comparison',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(flex: 2, child: SizedBox()),
                  Expanded(
                    child: Text('Default', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text('Custom', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.teal.shade700)),
                  ),
                ],
              ),
              SizedBox(height: 4),
              buildComparisonRow('alignment', 'end', 'center'),
              buildComparisonRow('mainAxisSize', 'max', 'min'),
              buildComparisonRow('buttonMinWidth', '64.0', '120.0'),
              buildComparisonRow('buttonHeight', '36.0', '48.0'),
              buildComparisonRow('buttonPadding', '8.0 horiz', '16.0 horiz'),
              buildComparisonRow('overflow', 'down', 'down'),
            ],
          ),
        ),

        // Section 9: Theme Data in Practice
        buildSectionTitle('9. Practical Theme Configurations'),
        buildDescription('Real-world theme configurations for common UI patterns'),

        buildThemeDataCard(
          title: 'Dialog Pattern',
          description: 'End-aligned with default padding, standard for dialogs',
          themeData: ButtonBarThemeData(
            alignment: MainAxisAlignment.end,
            buttonPadding: EdgeInsets.symmetric(horizontal: 8),
          ),
          buttons: [
            TextButton(onPressed: () {}, child: Text('Cancel')),
            ElevatedButton(onPressed: () {}, child: Text('Confirm')),
          ],
        ),
        buildThemeDataCard(
          title: 'Card Action Pattern',
          description: 'Start-aligned actions in a card footer',
          themeData: ButtonBarThemeData(
            alignment: MainAxisAlignment.start,
            buttonPadding: EdgeInsets.symmetric(horizontal: 4),
          ),
          buttons: [
            TextButton(onPressed: () {}, child: Text('Share')),
            TextButton(onPressed: () {}, child: Text('Like')),
            TextButton(onPressed: () {}, child: Text('Comment')),
          ],
        ),
        buildThemeDataCard(
          title: 'Wizard Navigation Pattern',
          description: 'SpaceBetween with wide buttons for step navigation',
          themeData: ButtonBarThemeData(
            alignment: MainAxisAlignment.spaceBetween,
            buttonMinWidth: 100,
            buttonHeight: 44,
          ),
          buttons: [
            OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.arrow_back),
              label: Text('Back'),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward),
              label: Text('Next'),
            ),
          ],
        ),

        // Summary
        buildSectionTitle('10. Summary'),
        buildInfoBox(
          'ButtonBarThemeData configures alignment, padding, sizing, and overflow '
          'behavior for ButtonBar widgets in its subtree.',
          Colors.teal,
        ),
        buildInfoBox(
          'Key properties: alignment, mainAxisSize, buttonMinWidth, buttonHeight, '
          'buttonPadding, buttonTextTheme, overflowDirection.',
          Colors.blue,
        ),
        buildInfoBox(
          'Apply via ButtonBarTheme widget or set on ThemeData.buttonBarTheme for '
          'app-wide configuration.',
          Colors.indigo,
        ),

        SizedBox(height: 40),
      ],
    ),
  );
}
