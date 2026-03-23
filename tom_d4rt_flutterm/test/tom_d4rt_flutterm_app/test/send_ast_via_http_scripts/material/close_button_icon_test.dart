// ignore_for_file: avoid_print
// D4rt test script: Tests CloseButtonIcon from material
import 'package:flutter/material.dart';

// Helper for section header
Widget buildSectionHeader(String title, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.fromLTRB(8, 16, 8, 8),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color, color.withValues(alpha: 0.7)],
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        SizedBox(width: 8),
        Text(title, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

// Helper for close button visual with different sizes
Widget buildCloseButtonSized(double size, Color iconColor, Color bgColor, String label) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
    child: Column(
      children: [
        Container(
          width: size + 16,
          height: size + 16,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(Icons.close, size: size, color: iconColor),
          ),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 9, color: Colors.grey)),
        Text('${size.toInt()}px', style: TextStyle(fontSize: 9, color: Colors.grey.shade400)),
      ],
    ),
  );
}

// Helper for close button in context
Widget buildCloseButtonContext(String context_, Color headerColor, Color closeColor, String description) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 4, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: headerColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Row(
            children: [
              Text(context_, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
              Spacer(),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: closeColor.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, size: 16, color: closeColor),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(12),
          child: Text(description, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        ),
      ],
    ),
  );
}

// Helper for color variation card
Widget buildColorVariationCard(String label, Color iconColor, Color bgColor, Color containerColor) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: containerColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.close, size: 20, color: iconColor),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              Text('icon: $iconColor / bg: $bgColor', style: TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
        ),
        Container(
          width: 20, height: 20,
          decoration: BoxDecoration(
            color: iconColor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: 4),
        Container(
          width: 20, height: 20,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade300),
          ),
        ),
      ],
    ),
  );
}

// Helper for dialog close button visual
Widget buildDialogCloseVisual(String title, Color bgColor, Color closeIconColor) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 8, offset: Offset(0, 4)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 12, 8, 0),
          child: Row(
            children: [
              Expanded(
                child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ),
              IconButton(
                icon: Icon(Icons.close, color: closeIconColor),
                onPressed: () {},
                iconSize: 22,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              Text(
                'Dialog content area demonstrating the close button position in a typical dialog layout.',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper for position demonstration
Widget buildPositionDemo(String label, Alignment alignment, Color color) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Stack(
        children: [
          Center(child: Text(label, style: TextStyle(fontSize: 9, color: Colors.grey))),
          Align(
            alignment: alignment,
            child: Container(
              margin: EdgeInsets.all(4),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, size: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  );
}

// Helper for tooltip style close button
Widget buildTooltipCloseButton(String tooltipText, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      children: [
        Text(tooltipText, style: TextStyle(fontSize: 12)),
        Spacer(),
        Tooltip(
          message: tooltipText,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.close, size: 18, color: color),
          ),
        ),
      ],
    ),
  );
}

// Helper for badge close button
Widget buildBadgeCloseVisual(String label, Color chipColor, Color closeColor) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
    padding: EdgeInsets.fromLTRB(12, 6, 4, 6),
    decoration: BoxDecoration(
      color: chipColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500)),
        SizedBox(width: 4),
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: closeColor,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.close, size: 12, color: Colors.white),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== CloseButtonIcon Visual Test ===');
  debugPrint('Demonstrating CloseButtonIcon in various contexts');

  debugPrint('Testing different sizes');
  debugPrint('Testing color combinations');
  debugPrint('Testing in dialogs, panels, chips');
  debugPrint('Testing button positions');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('CloseButton / CloseButtonIcon Demo'),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section 1: Size Variations
            buildSectionHeader('Size Variations', Icons.straighten, Colors.red),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'CloseButtonIcon provides the icon data for close buttons, shown at different sizes',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildCloseButtonSized(12, Colors.grey.shade700, Colors.grey.shade200, 'Tiny'),
                  buildCloseButtonSized(16, Colors.grey.shade700, Colors.grey.shade200, 'Small'),
                  buildCloseButtonSized(20, Colors.grey.shade700, Colors.grey.shade200, 'Default'),
                  buildCloseButtonSized(24, Colors.grey.shade700, Colors.grey.shade200, 'Medium'),
                  buildCloseButtonSized(32, Colors.grey.shade700, Colors.grey.shade200, 'Large'),
                  buildCloseButtonSized(40, Colors.grey.shade700, Colors.grey.shade200, 'XLarge'),
                ],
              ),
            ),

            // Section 2: Color Variations
            buildSectionHeader('Color Variations', Icons.palette, Colors.purple),
            buildColorVariationCard('Default (grey on light)', Colors.grey.shade700, Colors.grey.shade200, Colors.white),
            buildColorVariationCard('Red on pink', Colors.red, Colors.red.shade100, Colors.white),
            buildColorVariationCard('White on dark', Colors.white, Colors.grey.shade800, Colors.grey.shade100),
            buildColorVariationCard('Blue on light blue', Colors.blue, Colors.blue.shade100, Colors.white),
            buildColorVariationCard('Green on mint', Colors.green.shade700, Colors.green.shade100, Colors.white),
            buildColorVariationCard('Orange on yellow', Colors.orange, Colors.orange.shade100, Colors.white),
            buildColorVariationCard('Black on white', Colors.black, Colors.white, Colors.grey.shade100),
            buildColorVariationCard('Purple on lavender', Colors.purple, Colors.purple.shade100, Colors.white),
            buildColorVariationCard('Teal on light teal', Colors.teal, Colors.teal.shade100, Colors.white),
            buildColorVariationCard('Pink on light pink', Colors.pink, Colors.pink.shade100, Colors.white),

            // Section 3: In Context - Dialogs
            buildSectionHeader('Dialog Close Buttons', Icons.open_in_new, Colors.blue),
            buildDialogCloseVisual('Alert Dialog', Colors.white, Colors.grey.shade600),
            buildDialogCloseVisual('Settings Panel', Colors.grey.shade50, Colors.blue),
            buildDialogCloseVisual('Error Dialog', Colors.red.shade50, Colors.red),
            buildDialogCloseVisual('Info Sheet', Colors.blue.shade50, Colors.blue.shade700),

            // Section 4: In Context - Headers and Panels
            buildSectionHeader('Panel Close Buttons', Icons.web, Colors.green),
            buildCloseButtonContext('Navigation Drawer', Colors.blue.shade700, Colors.white, 'Close button in navigation drawer header to dismiss the panel.'),
            buildCloseButtonContext('Bottom Sheet', Colors.green.shade700, Colors.white, 'Close button in a bottom sheet header with drag handle alternative.'),
            buildCloseButtonContext('Snackbar', Colors.grey.shade800, Colors.white, 'Dismiss button for a snackbar or toast notification.'),
            buildCloseButtonContext('Search Bar', Colors.teal.shade700, Colors.white, 'Clear/close button in a search bar to dismiss search mode.'),

            // Section 5: Positions
            buildSectionHeader('Button Positions', Icons.grid_on, Colors.orange),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'CloseButton can be positioned at different corners of a container',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              child: Row(
                children: [
                  buildPositionDemo('Top Left', Alignment.topLeft, Colors.red),
                  buildPositionDemo('Top Right', Alignment.topRight, Colors.blue),
                  buildPositionDemo('Bot Left', Alignment.bottomLeft, Colors.green),
                  buildPositionDemo('Bot Right', Alignment.bottomRight, Colors.orange),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              child: Row(
                children: [
                  buildPositionDemo('Top Center', Alignment.topCenter, Colors.purple),
                  buildPositionDemo('Center', Alignment.center, Colors.pink),
                  buildPositionDemo('Bot Center', Alignment.bottomCenter, Colors.teal),
                ],
              ),
            ),

            // Section 6: Tooltip Variations
            buildSectionHeader('With Tooltips', Icons.info, Colors.teal),
            buildTooltipCloseButton('Close dialog', Colors.grey.shade600),
            buildTooltipCloseButton('Dismiss notification', Colors.orange),
            buildTooltipCloseButton('Remove item', Colors.red),
            buildTooltipCloseButton('Clear search', Colors.blue),
            buildTooltipCloseButton('Close panel', Colors.green),

            // Section 7: Badge/Chip Delete Buttons
            buildSectionHeader('Delete in Chips/Badges', Icons.label, Colors.indigo),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Close/delete icons used inside chips, tags, and badges',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  buildBadgeCloseVisual('Flutter', Colors.blue, Colors.blue.shade800),
                  buildBadgeCloseVisual('Dart', Colors.green, Colors.green.shade800),
                  buildBadgeCloseVisual('Material', Colors.purple, Colors.purple.shade800),
                  buildBadgeCloseVisual('Widget', Colors.orange, Colors.orange.shade800),
                  buildBadgeCloseVisual('Theme', Colors.teal, Colors.teal.shade800),
                  buildBadgeCloseVisual('Style', Colors.red, Colors.red.shade800),
                  buildBadgeCloseVisual('Design', Colors.indigo, Colors.indigo.shade800),
                  buildBadgeCloseVisual('Layout', Colors.pink, Colors.pink.shade800),
                  buildBadgeCloseVisual('State', Colors.amber.shade700, Colors.amber.shade900),
                  buildBadgeCloseVisual('Build', Colors.cyan, Colors.cyan.shade800),
                ],
              ),
            ),

            // Section 8: Background Contrast Grid
            buildSectionHeader('Background Contrast', Icons.contrast, Colors.blueGrey),
            Container(
              margin: EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 60,
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Center(child: Icon(Icons.close, color: Colors.black, size: 24)),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 60,
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(child: Icon(Icons.close, color: Colors.grey.shade700, size: 24)),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 60,
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade500,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(child: Icon(Icons.close, color: Colors.white, size: 24)),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 60,
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(child: Icon(Icons.close, color: Colors.white, size: 24)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 60,
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(child: Icon(Icons.close, color: Colors.white, size: 24)),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 60,
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(child: Icon(Icons.close, color: Colors.white, size: 24)),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 60,
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(child: Icon(Icons.close, color: Colors.white, size: 24)),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 60,
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(child: Icon(Icons.close, color: Colors.white, size: 24)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 60,
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(child: Icon(Icons.close, color: Colors.black, size: 24)),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 60,
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(child: Icon(Icons.close, color: Colors.white, size: 24)),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 60,
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(child: Icon(Icons.close, color: Colors.white, size: 24)),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 60,
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(child: Icon(Icons.close, color: Colors.white, size: 24)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Section 9: AppBar Close Buttons
            buildSectionHeader('AppBar Close Buttons', Icons.close, Colors.brown),
            Container(
              margin: EdgeInsets.all(8),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.close, color: Colors.white, size: 22),
                        SizedBox(width: 12),
                        Text('Full Screen Dialog', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                        Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: Text('SAVE', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                    ),
                    child: Center(child: Text('Dialog content area', style: TextStyle(fontSize: 12, color: Colors.grey))),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        Text('Filter Panel', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        Spacer(),
                        Container(
                          width: 30, height: 30,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.close, size: 18, color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                      border: Border(
                        left: BorderSide(color: Colors.grey.shade300),
                        right: BorderSide(color: Colors.grey.shade300),
                        bottom: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Center(child: Text('Filter content area', style: TextStyle(fontSize: 12, color: Colors.grey))),
                  ),
                ],
              ),
            ),

            // Summary
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red.shade50, Colors.pink.shade50],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Features Demonstrated:', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      Chip(label: Text('sizes', style: TextStyle(fontSize: 10)), backgroundColor: Colors.red.shade100),
                      Chip(label: Text('colors', style: TextStyle(fontSize: 10)), backgroundColor: Colors.purple.shade100),
                      Chip(label: Text('dialogs', style: TextStyle(fontSize: 10)), backgroundColor: Colors.blue.shade100),
                      Chip(label: Text('panels', style: TextStyle(fontSize: 10)), backgroundColor: Colors.green.shade100),
                      Chip(label: Text('positions', style: TextStyle(fontSize: 10)), backgroundColor: Colors.orange.shade100),
                      Chip(label: Text('tooltips', style: TextStyle(fontSize: 10)), backgroundColor: Colors.teal.shade100),
                      Chip(label: Text('chips', style: TextStyle(fontSize: 10)), backgroundColor: Colors.indigo.shade100),
                      Chip(label: Text('contrast', style: TextStyle(fontSize: 10)), backgroundColor: Colors.grey.shade200),
                      Chip(label: Text('appBars', style: TextStyle(fontSize: 10)), backgroundColor: Colors.brown.shade100),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    ),
  );
}
