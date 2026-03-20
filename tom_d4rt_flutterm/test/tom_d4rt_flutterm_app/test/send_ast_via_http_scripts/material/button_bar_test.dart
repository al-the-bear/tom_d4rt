// D4rt test script: Tests ButtonBar from material
// ignore_for_file: deprecated_member_use
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
        color: Colors.brown.shade800,
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

// Helper to build a ButtonBar demo
Widget buildButtonBarDemo({
  required String title,
  required String description,
  required Widget buttonBar,
  Color? backgroundColor,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: backgroundColor ?? Colors.white,
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
              color: Colors.brown.shade700,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          ),
        ),
        Divider(height: 1),
        buttonBar,
        SizedBox(height: 8),
      ],
    ),
  );
}

// Helper to build a labeled alignment card
Widget buildAlignmentCard(String alignmentName, MainAxisAlignment alignment) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.brown.shade100),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.brown.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(9),
              topRight: Radius.circular(9),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.align_horizontal_left, size: 14, color: Colors.brown),
              SizedBox(width: 6),
              Text(
                alignmentName,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.brown.shade700,
                ),
              ),
            ],
          ),
        ),
        ButtonBar(
          alignment: alignment,
          children: [
            TextButton(onPressed: () {}, child: Text('Cancel')),
            ElevatedButton(onPressed: () {}, child: Text('OK')),
          ],
        ),
      ],
    ),
  );
}

// Helper to build property chip
Widget buildPropertyChip(String label, String value) {
  return Container(
    margin: EdgeInsets.only(right: 6, bottom: 6),
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.brown.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.brown.shade200),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 10, color: Colors.brown.shade400),
        ),
        SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Colors.brown.shade700,
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== ButtonBar Deep Demo ===');
  debugPrint('Demonstrating ButtonBar with various configurations');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.brown.shade700, Colors.brown.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ButtonBar Demo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Horizontal arrangement of buttons with alignment controls',
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

        // Section 1: Alignment Variations
        buildSectionTitle('1. Alignment Variations'),
        buildDescription('ButtonBar supports all MainAxisAlignment values'),

        buildAlignmentCard('MainAxisAlignment.start', MainAxisAlignment.start),
        buildAlignmentCard('MainAxisAlignment.center', MainAxisAlignment.center),
        buildAlignmentCard('MainAxisAlignment.end', MainAxisAlignment.end),
        buildAlignmentCard('MainAxisAlignment.spaceBetween', MainAxisAlignment.spaceBetween),
        buildAlignmentCard('MainAxisAlignment.spaceAround', MainAxisAlignment.spaceAround),
        buildAlignmentCard('MainAxisAlignment.spaceEvenly', MainAxisAlignment.spaceEvenly),

        // Section 2: Different Button Types
        buildSectionTitle('2. Different Button Types'),
        buildDescription('ButtonBar with various button widget types'),

        buildButtonBarDemo(
          title: 'TextButton Only',
          description: 'Flat text-style buttons in ButtonBar',
          buttonBar: ButtonBar(
            children: [
              TextButton(onPressed: () {}, child: Text('Skip')),
              TextButton(onPressed: () {}, child: Text('Later')),
              TextButton(onPressed: () {}, child: Text('Accept')),
            ],
          ),
        ),
        buildButtonBarDemo(
          title: 'ElevatedButton Only',
          description: 'Raised elevated buttons in ButtonBar',
          buttonBar: ButtonBar(
            children: [
              ElevatedButton(onPressed: () {}, child: Text('Cancel')),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: Text('Save'),
              ),
            ],
          ),
        ),
        buildButtonBarDemo(
          title: 'OutlinedButton Only',
          description: 'Outlined border buttons in ButtonBar',
          buttonBar: ButtonBar(
            children: [
              OutlinedButton(onPressed: () {}, child: Text('Details')),
              OutlinedButton(onPressed: () {}, child: Text('Share')),
              OutlinedButton(onPressed: () {}, child: Text('Download')),
            ],
          ),
        ),
        buildButtonBarDemo(
          title: 'Mixed Button Types',
          description: 'Combining different button types',
          buttonBar: ButtonBar(
            children: [
              TextButton(onPressed: () {}, child: Text('Cancel')),
              OutlinedButton(onPressed: () {}, child: Text('Draft')),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: Text('Submit'),
              ),
            ],
          ),
        ),

        // Section 3: Button Count Scenarios
        buildSectionTitle('3. Button Count Scenarios'),
        buildDescription('ButtonBar with different numbers of buttons'),

        buildButtonBarDemo(
          title: 'Single Button',
          description: 'Just one action button',
          buttonBar: ButtonBar(
            children: [
              ElevatedButton(onPressed: () {}, child: Text('Done')),
            ],
          ),
        ),
        buildButtonBarDemo(
          title: 'Two Buttons',
          description: 'Classic cancel/confirm pattern',
          buttonBar: ButtonBar(
            children: [
              TextButton(onPressed: () {}, child: Text('Cancel')),
              ElevatedButton(onPressed: () {}, child: Text('Confirm')),
            ],
          ),
        ),
        buildButtonBarDemo(
          title: 'Three Buttons',
          description: 'Multi-action layout',
          buttonBar: ButtonBar(
            children: [
              TextButton(onPressed: () {}, child: Text('Skip')),
              OutlinedButton(onPressed: () {}, child: Text('Save Draft')),
              ElevatedButton(onPressed: () {}, child: Text('Publish')),
            ],
          ),
        ),
        buildButtonBarDemo(
          title: 'Four Buttons',
          description: 'Extended action set',
          buttonBar: ButtonBar(
            children: [
              TextButton(onPressed: () {}, child: Text('Delete')),
              TextButton(onPressed: () {}, child: Text('Archive')),
              OutlinedButton(onPressed: () {}, child: Text('Preview')),
              ElevatedButton(onPressed: () {}, child: Text('Send')),
            ],
          ),
        ),

        // Section 4: Button Height
        buildSectionTitle('4. Button Minimum Height'),
        buildDescription('buttonMinHeight controls minimum button height'),

        buildButtonBarDemo(
          title: 'Default Height',
          description: 'Uses default minimum button height',
          buttonBar: ButtonBar(
            children: [
              ElevatedButton(onPressed: () {}, child: Text('Default')),
              TextButton(onPressed: () {}, child: Text('Cancel')),
            ],
          ),
        ),
        buildButtonBarDemo(
          title: 'Height: 52',
          description: 'Taller buttons with buttonMinHeight: 52',
          buttonBar: ButtonBar(
            buttonMinWidth: 100,
            buttonHeight: 52,
            children: [
              ElevatedButton(onPressed: () {}, child: Text('Tall')),
              TextButton(onPressed: () {}, child: Text('Cancel')),
            ],
          ),
        ),

        // Section 5: Main Axis Size
        buildSectionTitle('5. Main Axis Size'),
        buildDescription('mainAxisSize controls whether ButtonBar expands to fill width'),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.brown.shade100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    buildPropertyChip('mainAxisSize', 'max'),
                  ],
                ),
              ),
              Container(
                color: Colors.blue.shade50,
                child: ButtonBar(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextButton(onPressed: () {}, child: Text('A')),
                    TextButton(onPressed: () {}, child: Text('B')),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.brown.shade100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    buildPropertyChip('mainAxisSize', 'min'),
                  ],
                ),
              ),
              Container(
                color: Colors.green.shade50,
                child: ButtonBar(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(onPressed: () {}, child: Text('A')),
                    TextButton(onPressed: () {}, child: Text('B')),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Section 6: Button Padding
        buildSectionTitle('6. Button Padding'),
        buildDescription('buttonPadding controls spacing between buttons'),

        buildButtonBarDemo(
          title: 'Default Padding',
          description: 'Default button padding',
          buttonBar: ButtonBar(
            children: [
              ElevatedButton(onPressed: () {}, child: Text('One')),
              ElevatedButton(onPressed: () {}, child: Text('Two')),
              ElevatedButton(onPressed: () {}, child: Text('Three')),
            ],
          ),
        ),
        buildButtonBarDemo(
          title: 'No Padding',
          description: 'buttonPadding: EdgeInsets.zero',
          buttonBar: ButtonBar(
            buttonPadding: EdgeInsets.zero,
            children: [
              ElevatedButton(onPressed: () {}, child: Text('One')),
              ElevatedButton(onPressed: () {}, child: Text('Two')),
              ElevatedButton(onPressed: () {}, child: Text('Three')),
            ],
          ),
        ),
        buildButtonBarDemo(
          title: 'Large Padding',
          description: 'buttonPadding: EdgeInsets.symmetric(horizontal: 16)',
          buttonBar: ButtonBar(
            buttonPadding: EdgeInsets.symmetric(horizontal: 16),
            children: [
              ElevatedButton(onPressed: () {}, child: Text('One')),
              ElevatedButton(onPressed: () {}, child: Text('Two')),
              ElevatedButton(onPressed: () {}, child: Text('Three')),
            ],
          ),
        ),

        // Section 7: Dialog-style Usage
        buildSectionTitle('7. Dialog-style Usage'),
        buildDescription('ButtonBar as commonly used in dialog layouts'),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 4)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(24, 20, 24, 8),
                child: Text(
                  'Delete Item?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24, 0, 24, 16),
                child: Text(
                  'This action cannot be undone. Are you sure you want to delete this item?',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
              ),
              ButtonBar(
                children: [
                  TextButton(onPressed: () {}, child: Text('Cancel')),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 4)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(24, 20, 24, 8),
                child: Text(
                  'Save Changes?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24, 0, 24, 16),
                child: Text(
                  'You have unsaved changes. Would you like to save them before leaving?',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
              ),
              ButtonBar(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text('Discard', style: TextStyle(color: Colors.red)),
                  ),
                  OutlinedButton(onPressed: () {}, child: Text('Cancel')),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Section 8: Styled Buttons in ButtonBar
        buildSectionTitle('8. Styled Buttons in ButtonBar'),
        buildDescription('Custom-styled buttons with icons within ButtonBar'),

        buildButtonBarDemo(
          title: 'Icon Buttons',
          description: 'Buttons with icons in ButtonBar',
          buttonBar: ButtonBar(
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.close),
                label: Text('Close'),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.check),
                label: Text('Confirm'),
              ),
            ],
          ),
        ),
        buildButtonBarDemo(
          title: 'Colored Buttons',
          description: 'Different background colors for emphasis',
          buttonBar: ButtonBar(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black87,
                ),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: Text('Save'),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: Text('Publish'),
              ),
            ],
          ),
        ),
        buildButtonBarDemo(
          title: 'Rounded Buttons',
          description: 'Buttons with large border radius',
          buttonBar: ButtonBar(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: Text('Round A'),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                child: Text('Round B'),
              ),
            ],
          ),
        ),

        // Section 9: Summary
        buildSectionTitle('9. Summary'),
        buildInfoBox(
          'ButtonBar arranges its children in a horizontal row with configurable '
          'alignment and spacing.',
          Colors.brown,
        ),
        buildInfoBox(
          'Key properties: alignment, mainAxisSize, buttonMinWidth, '
          'buttonHeight, buttonPadding, overflowDirection.',
          Colors.blue,
        ),
        buildInfoBox(
          'ButtonBar is deprecated in favor of OverflowBar, which provides '
          'overflow layout behavior when buttons exceed available width.',
          Colors.orange,
        ),
        buildInfoBox(
          'Common usage pattern: dialog action bars with cancel/confirm buttons, '
          'alignment typically MainAxisAlignment.end.',
          Colors.green,
        ),

        SizedBox(height: 40),
      ],
    ),
  );
}
