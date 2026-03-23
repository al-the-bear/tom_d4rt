// ignore_for_file: avoid_print
// D4rt test script: Tests Ink widget decoration from material
import 'package:flutter/material.dart';

Widget _buildSectionHeader(String title) {
  print('Section: $title');
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 24, bottom: 12),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: Color(0xFF1565C0),
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Color(0x401565C0),
          blurRadius: 8,
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

Widget _buildSubSectionHeader(String title) {
  return Padding(
    padding: EdgeInsets.only(top: 16, bottom: 8, left: 4),
    child: Text(
      title,
      style: TextStyle(
        color: Color(0xFF1565C0),
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _buildInfoCard(String title, String description) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE0E0E0), width: 1),
    ),
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
          style: TextStyle(fontSize: 13, color: Color(0xFF616161), height: 1.4),
        ),
      ],
    ),
  );
}

Widget _buildPropertyRow(String property, String type, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          child: Text(
            property,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1565C0),
            ),
          ),
        ),
        Container(
          width: 80,
          child: Text(
            type,
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF7B1FA2),
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 13, color: Color(0xFF424242)),
          ),
        ),
      ],
    ),
  );
}

Widget _buildLabeledInk(String label, Widget inkWidget) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4, bottom: 4),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF757575),
            ),
          ),
        ),
        inkWidget,
      ],
    ),
  );
}

Widget _buildNoteBox(String text) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFFFCC02), width: 1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.info_outline, size: 18, color: Color(0xFFF57F17)),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF5D4037),
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBasicInkDecorations() {
  print('  Building basic Ink with BoxDecoration');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildInfoCard(
        'Ink with BoxDecoration',
        'The Ink widget paints a Decoration on a Material widget. '
            'Unlike Container decorations, Ink decorations allow ink splashes '
            'to render correctly on top of them.',
      ),
      _buildLabeledInk(
        'Simple color fill with border radius',
        Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              color: Color(0xFF42A5F5),
              borderRadius: BorderRadius.circular(12),
            ),
            width: double.infinity,
            height: 60,
            child: Center(
              child: Text(
                'Basic Ink - Color Fill',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
      _buildLabeledInk(
        'Rounded rectangle with subtle color',
        Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              color: Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(20),
            ),
            width: double.infinity,
            height: 50,
            child: Center(
              child: Text(
                'Rounded Ink',
                style: TextStyle(color: Color(0xFF2E7D32), fontSize: 14),
              ),
            ),
          ),
        ),
      ),
      _buildLabeledInk(
        'No border radius (sharp corners)',
        Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(color: Color(0xFFFCE4EC)),
            width: double.infinity,
            height: 50,
            child: Center(
              child: Text(
                'Sharp Corners Ink',
                style: TextStyle(color: Color(0xFFC62828), fontSize: 14),
              ),
            ),
          ),
        ),
      ),
      _buildLabeledInk(
        'Circle shape',
        Center(
          child: Material(
            color: Colors.transparent,
            child: Ink(
              decoration: BoxDecoration(
                color: Color(0xFFE3F2FD),
                shape: BoxShape.circle,
              ),
              width: 80,
              height: 80,
              child: Center(
                child: Icon(Icons.star, color: Color(0xFF1565C0), size: 32),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildGradientInkDecorations() {
  print('  Building Ink with gradient decorations');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildInfoCard(
        'Ink with Gradients',
        'Ink supports all standard gradient types in BoxDecoration: '
            'LinearGradient, RadialGradient, and SweepGradient.',
      ),
      _buildLabeledInk(
        'Linear gradient (left to right)',
        Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            width: double.infinity,
            height: 60,
            child: Center(
              child: Text(
                'Linear Gradient',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
      _buildLabeledInk(
        'Diagonal gradient with three colors',
        Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFE91E63),
                  Color(0xFF9C27B0),
                  Color(0xFF3F51B5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            width: double.infinity,
            height: 60,
            child: Center(
              child: Text(
                'Three-Color Gradient',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
      _buildLabeledInk(
        'Radial gradient',
        Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Color(0xFFFFEB3B),
                  Color(0xFFFF9800),
                  Color(0xFFF44336),
                ],
                center: Alignment.center,
                radius: 0.8,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            width: double.infinity,
            height: 80,
            child: Center(
              child: Text(
                'Radial Gradient',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      _buildLabeledInk(
        'Sweep gradient',
        Center(
          child: Material(
            color: Colors.transparent,
            child: Ink(
              decoration: BoxDecoration(
                gradient: SweepGradient(
                  colors: [
                    Color(0xFFF44336),
                    Color(0xFFFF9800),
                    Color(0xFFFFEB3B),
                    Color(0xFF4CAF50),
                    Color(0xFF2196F3),
                    Color(0xFF9C27B0),
                    Color(0xFFF44336),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              width: 100,
              height: 100,
              child: Center(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.palette,
                      color: Color(0xFF616161),
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      _buildLabeledInk(
        'Gradient with stops',
        Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF00BCD4),
                  Color(0xFF00BCD4),
                  Color(0xFFB2EBF2),
                ],
                stops: [0.0, 0.6, 1.0],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            width: double.infinity,
            height: 50,
            child: Center(
              child: Text(
                'Gradient with stops [0.0, 0.6, 1.0]',
                style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 14),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildBorderAndShadowInk() {
  print('  Building Ink with borders and shadows');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildInfoCard(
        'Ink with Borders and Shadows',
        'BoxDecoration on Ink supports border and boxShadow properties '
            'for visual depth and framing effects.',
      ),
      _buildLabeledInk(
        'Thin border',
        Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xFF1565C0), width: 1.5),
            ),
            width: double.infinity,
            height: 55,
            child: Center(
              child: Text(
                'Thin Blue Border',
                style: TextStyle(color: Color(0xFF1565C0), fontSize: 14),
              ),
            ),
          ),
        ),
      ),
      _buildLabeledInk(
        'Thick border with color fill',
        Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              color: Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xFFE65100), width: 3),
            ),
            width: double.infinity,
            height: 55,
            child: Center(
              child: Text(
                'Thick Orange Border',
                style: TextStyle(
                  color: Color(0xFFE65100),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
      _buildLabeledInk(
        'Box shadow elevation effect',
        Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Color(0x40000000),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            width: double.infinity,
            height: 60,
            child: Center(
              child: Text(
                'Shadow Elevation',
                style: TextStyle(color: Color(0xFF424242), fontSize: 14),
              ),
            ),
          ),
        ),
      ),
      _buildLabeledInk(
        'Multiple shadows',
        Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Color(0x301565C0),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
                BoxShadow(
                  color: Color(0x201565C0),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            width: double.infinity,
            height: 60,
            child: Center(
              child: Text(
                'Multiple Blue Shadows',
                style: TextStyle(color: Color(0xFF1565C0), fontSize: 14),
              ),
            ),
          ),
        ),
      ),
      _buildLabeledInk(
        'Border + shadow + gradient',
        Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF7B1FA2), Color(0xFFAB47BC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFCE93D8), width: 2),
              boxShadow: [
                BoxShadow(
                  color: Color(0x407B1FA2),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            width: double.infinity,
            height: 65,
            child: Center(
              child: Text(
                'Combined: Border + Shadow + Gradient',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildInkWithInkWell() {
  print('  Building Ink inside Material with InkWell');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildInfoCard(
        'Ink + InkWell Splash Rendering',
        'The primary purpose of Ink is to ensure that ink splash effects '
            'from InkWell render ON TOP of the decoration. Without Ink, a '
            'Container decoration would paint over the splash.',
      ),
      _buildNoteBox(
        'Tap these items to see the ink splash render correctly on top of the decoration.',
      ),
      _buildLabeledInk(
        'Ink with InkWell - blue gradient',
        Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () {
                print('    Tapped blue gradient Ink');
              },
              borderRadius: BorderRadius.circular(12),
              splashColor: Color(0x40FFFFFF),
              highlightColor: Color(0x20FFFFFF),
              child: Container(
                width: double.infinity,
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(Icons.touch_app, color: Color(0xFFFFFFFF), size: 24),
                    SizedBox(width: 12),
                    Text(
                      'Tap me - splash over gradient',
                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      _buildLabeledInk(
        'Ink with InkWell - solid color',
        Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              color: Color(0xFF4CAF50),
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () {
                print('    Tapped green solid Ink');
              },
              borderRadius: BorderRadius.circular(12),
              splashColor: Color(0x40FFFFFF),
              child: Container(
                width: double.infinity,
                height: 55,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Color(0xFFFFFFFF),
                      size: 22,
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Green Ink with splash',
                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      _buildLabeledInk(
        'Ink with InkWell - bordered',
        Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              color: Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFFFA000), width: 2),
            ),
            child: InkWell(
              onTap: () {
                print('    Tapped bordered Ink');
              },
              borderRadius: BorderRadius.circular(12),
              splashColor: Color(0x30FFA000),
              highlightColor: Color(0x15FFA000),
              child: Container(
                width: double.infinity,
                height: 55,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber,
                      color: Color(0xFFF57F17),
                      size: 22,
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Bordered Ink with amber splash',
                      style: TextStyle(color: Color(0xFFF57F17), fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      _buildLabeledInk(
        'Ink circle with InkWell',
        Center(
          child: Material(
            color: Colors.transparent,
            child: Ink(
              decoration: BoxDecoration(
                color: Color(0xFFE91E63),
                shape: BoxShape.circle,
              ),
              width: 80,
              height: 80,
              child: InkWell(
                onTap: () {
                  print('    Tapped circle Ink');
                },
                customBorder: CircleBorder(),
                splashColor: Color(0x40FFFFFF),
                child: Center(
                  child: Icon(
                    Icons.favorite,
                    color: Color(0xFFFFFFFF),
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildContainerVsInkComparison() {
  print('  Building Container vs Ink comparison');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildInfoCard(
        'Container vs Ink Comparison',
        'Container with BoxDecoration paints the decoration OVER the ink splash. '
            'Ink paints the decoration as part of the Material, so splashes render on top.',
      ),
      _buildNoteBox(
        'Side-by-side comparison: Top uses Container (splash hidden behind decoration), '
        'Bottom uses Ink (splash visible on top of decoration).',
      ),
      _buildSubSectionHeader('Using Container (splash hidden)'),
      Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            print(
              '    Tapped Container side - splash is hidden behind decoration',
            );
          },
          child: Container(
            width: double.infinity,
            height: 65,
            decoration: BoxDecoration(
              color: Color(0xFF1565C0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Container - splash HIDDEN',
                style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 14),
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 12),
      _buildSubSectionHeader('Using Ink (splash visible)'),
      Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            color: Color(0xFF1565C0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () {
              print('    Tapped Ink side - splash is visible on top');
            },
            borderRadius: BorderRadius.circular(12),
            splashColor: Color(0x40FFFFFF),
            highlightColor: Color(0x20FFFFFF),
            child: Container(
              width: double.infinity,
              height: 65,
              child: Center(
                child: Text(
                  'Ink - splash VISIBLE',
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 14),
                ),
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 12),
      _buildSubSectionHeader('With gradient - Container (hidden splash)'),
      Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            print('    Tapped gradient Container');
          },
          child: Container(
            width: double.infinity,
            height: 65,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE91E63), Color(0xFFFF5722)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Gradient Container - splash HIDDEN',
                style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 14),
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 12),
      _buildSubSectionHeader('With gradient - Ink (visible splash)'),
      Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE91E63), Color(0xFFFF5722)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () {
              print('    Tapped gradient Ink');
            },
            borderRadius: BorderRadius.circular(12),
            splashColor: Color(0x40FFFFFF),
            highlightColor: Color(0x20FFFFFF),
            child: Container(
              width: double.infinity,
              height: 65,
              child: Center(
                child: Text(
                  'Gradient Ink - splash VISIBLE',
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 14),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildShapesAndSizes() {
  print('  Building Ink shapes and sizes demo');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildInfoCard(
        'Ink Shapes and Sizes',
        'Ink supports explicit width and height, plus BoxShape for circle vs rectangle. '
            'The decoration shape is controlled by the BoxDecoration shape property.',
      ),
      _buildSubSectionHeader('Various sizes'),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Material(
            color: Colors.transparent,
            child: Ink(
              decoration: BoxDecoration(
                color: Color(0xFF42A5F5),
                borderRadius: BorderRadius.circular(6),
              ),
              width: 60,
              height: 40,
              child: Center(
                child: Text(
                  '60x40',
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 11),
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: Ink(
              decoration: BoxDecoration(
                color: Color(0xFF66BB6A),
                borderRadius: BorderRadius.circular(8),
              ),
              width: 80,
              height: 60,
              child: Center(
                child: Text(
                  '80x60',
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 11),
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: Ink(
              decoration: BoxDecoration(
                color: Color(0xFFEF5350),
                borderRadius: BorderRadius.circular(10),
              ),
              width: 100,
              height: 80,
              child: Center(
                child: Text(
                  '100x80',
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 11),
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 16),
      _buildSubSectionHeader('Circle shapes'),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Material(
            color: Colors.transparent,
            child: Ink(
              decoration: BoxDecoration(
                color: Color(0xFFAB47BC),
                shape: BoxShape.circle,
              ),
              width: 50,
              height: 50,
              child: Center(
                child: Text(
                  'S',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: Ink(
              decoration: BoxDecoration(
                color: Color(0xFF5C6BC0),
                shape: BoxShape.circle,
              ),
              width: 70,
              height: 70,
              child: Center(
                child: Text(
                  'M',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: Ink(
              decoration: BoxDecoration(
                color: Color(0xFF26A69A),
                shape: BoxShape.circle,
              ),
              width: 90,
              height: 90,
              child: Center(
                child: Text(
                  'L',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 16),
      _buildSubSectionHeader('High border radius'),
      Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            color: Color(0xFFFF7043),
            borderRadius: BorderRadius.circular(30),
          ),
          width: double.infinity,
          height: 60,
          child: Center(
            child: Text(
              'Stadium shape (high border radius)',
              style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 14),
            ),
          ),
        ),
      ),
      SizedBox(height: 8),
      _buildSubSectionHeader('Asymmetric border radius'),
      Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            color: Color(0xFF78909C),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(4),
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(24),
            ),
          ),
          width: double.infinity,
          height: 60,
          child: Center(
            child: Text(
              'Asymmetric corners',
              style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 14),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildPaddingAndChildren() {
  print('  Building Ink with padding and child widgets');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildInfoCard(
        'Ink with Padding and Children',
        'Ink accepts a padding property that insets the child within the decoration. '
            'Children can be any widget, including complex layouts.',
      ),
      _buildLabeledInk(
        'Ink with padding: 16',
        Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              color: Color(0xFFE8EAF6),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFF3F51B5), width: 1),
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Padded Ink Content',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A237E),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'This child has 16px padding from the decoration edge.',
                  style: TextStyle(fontSize: 13, color: Color(0xFF3F51B5)),
                ),
              ],
            ),
          ),
        ),
      ),
      _buildLabeledInk(
        'Ink with asymmetric padding',
        Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              color: Color(0xFFF3E5F5),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              children: [
                Icon(Icons.format_quote, color: Color(0xFF7B1FA2), size: 28),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Horizontal: 24px, Vertical: 12px padding',
                    style: TextStyle(fontSize: 13, color: Color(0xFF4A148C)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      _buildLabeledInk(
        'Ink with complex child layout',
        Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF004D40), Color(0xFF00695C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Color(0x30FFFFFF),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person,
                      color: Color(0xFFFFFFFF),
                      size: 28,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Complex Child Layout',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Avatar + text column inside padded Ink',
                        style: TextStyle(
                          color: Color(0xB3FFFFFF),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: Color(0x80FFFFFF), size: 24),
              ],
            ),
          ),
        ),
      ),
      _buildLabeledInk(
        'Nested children with spacing',
        Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              color: Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFE65100), width: 1),
            ),
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.wb_sunny, color: Color(0xFFE65100), size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Morning Stats',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFE65100),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Temperature',
                      style: TextStyle(fontSize: 13, color: Color(0xFF795548)),
                    ),
                    Text(
                      '24 C',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFE65100),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Humidity',
                      style: TextStyle(fontSize: 13, color: Color(0xFF795548)),
                    ),
                    Text(
                      '65%',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFE65100),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildGridDecorationStyles() {
  print('  Building grid of Ink decoration styles');
  List<Map<String, dynamic>> gridItems = [
    {
      'label': 'Solid',
      'color': Color(0xFFFFFFFF),
      'decoration': BoxDecoration(
        color: Color(0xFF1565C0),
        borderRadius: BorderRadius.circular(8),
      ),
    },
    {
      'label': 'Bordered',
      'color': Color(0xFF212121),
      'decoration': BoxDecoration(
        color: Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFF1565C0), width: 2),
      ),
    },
    {
      'label': 'Shadow',
      'color': Color(0xFF212121),
      'decoration': BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
    },
    {
      'label': 'Gradient',
      'color': Color(0xFFFFFFFF),
      'decoration': BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE91E63), Color(0xFFFF5722)],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    },
    {
      'label': 'Circle',
      'color': Color(0xFFFFFFFF),
      'decoration': BoxDecoration(
        color: Color(0xFF4CAF50),
        shape: BoxShape.circle,
      ),
    },
    {
      'label': 'Stadium',
      'color': Color(0xFFFFFFFF),
      'decoration': BoxDecoration(
        color: Color(0xFF9C27B0),
        borderRadius: BorderRadius.circular(30),
      ),
    },
    {
      'label': 'Outline',
      'color': Color(0xFF212121),
      'decoration': BoxDecoration(
        color: Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFF9E9E9E), width: 1),
      ),
    },
    {
      'label': 'Radial',
      'color': Color(0xFF212121),
      'decoration': BoxDecoration(
        gradient: RadialGradient(
          colors: [Color(0xFFFFEB3B), Color(0xFFFF9800)],
          radius: 0.9,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    },
    {
      'label': 'Dark',
      'color': Color(0xFFFFFFFF),
      'decoration': BoxDecoration(
        color: Color(0xFF212121),
        borderRadius: BorderRadius.circular(8),
      ),
    },
  ];

  List<Widget> rows = [];
  int idx = 0;
  while (idx < gridItems.length) {
    List<Widget> rowChildren = [];
    int colCount = 0;
    while (colCount < 3 && idx < gridItems.length) {
      Map<String, dynamic> item = gridItems[idx];
      String label = item['label'];
      BoxDecoration dec = item['decoration'];
      Color textCol = item['color'];
      bool isCircle = (dec.shape == BoxShape.circle);

      Widget inkWidget;
      if (isCircle) {
        inkWidget = Material(
          color: Colors.transparent,
          child: Ink(
            decoration: dec,
            width: 70,
            height: 70,
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: textCol,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      } else {
        inkWidget = Material(
          color: Colors.transparent,
          child: Ink(
            decoration: dec,
            width: 100,
            height: 70,
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: textCol,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      }

      rowChildren.add(
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(4),
            child: Center(child: inkWidget),
          ),
        ),
      );
      idx = idx + 1;
      colCount = colCount + 1;
    }
    rows.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: rowChildren,
        ),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildInfoCard(
        'Decoration Style Gallery',
        'A grid showing various decoration styles that can be applied to Ink widgets.',
      ),
      Column(children: rows),
    ],
  );
}

Widget _buildPropertyReference() {
  print('  Building property reference section');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildInfoCard(
        'Ink Widget Property Reference',
        'Complete list of Ink widget properties and their usage.',
      ),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFE0E0E0), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  child: Text(
                    'Property',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF212121),
                    ),
                  ),
                ),
                Container(
                  width: 80,
                  child: Text(
                    'Type',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF212121),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF212121),
                    ),
                  ),
                ),
              ],
            ),
            Divider(color: Color(0xFFBDBDBD)),
            _buildPropertyRow(
              'child',
              'Widget',
              'The widget below this widget in the tree',
            ),
            _buildPropertyRow(
              'decoration',
              'Decoration',
              'The decoration to paint (typically BoxDecoration)',
            ),
            _buildPropertyRow(
              'width',
              'double',
              'The explicit width for the Ink',
            ),
            _buildPropertyRow(
              'height',
              'double',
              'The explicit height for the Ink',
            ),
            _buildPropertyRow(
              'padding',
              'EdgeInsets',
              'Empty space to inscribe inside the decoration',
            ),
            _buildPropertyRow(
              'color',
              'Color',
              'Convenience for BoxDecoration color property',
            ),
            _buildPropertyRow(
              'image',
              'DecorationImage',
              'Image to paint inside the decoration',
            ),
          ],
        ),
      ),
      SizedBox(height: 12),
      _buildSubSectionHeader('Key BoxDecoration Properties Used with Ink'),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFE0E0E0), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPropertyRow(
              'color',
              'Color',
              'Background color of the decoration',
            ),
            _buildPropertyRow(
              'gradient',
              'Gradient',
              'Linear, radial, or sweep gradient fill',
            ),
            _buildPropertyRow(
              'border',
              'Border',
              'Border lines around the decoration',
            ),
            _buildPropertyRow(
              'borderRadius',
              'BorderRadius',
              'Corner rounding for rectangle shapes',
            ),
            _buildPropertyRow(
              'boxShadow',
              'List',
              'Shadow effects beneath the decoration',
            ),
            _buildPropertyRow(
              'shape',
              'BoxShape',
              'BoxShape.rectangle or BoxShape.circle',
            ),
            _buildPropertyRow(
              'image',
              'DecorationImage',
              'Background image for the decoration',
            ),
          ],
        ),
      ),
      SizedBox(height: 12),
      _buildNoteBox(
        'Ink.color is a shorthand: Ink(color: c) is equivalent to '
        'Ink(decoration: BoxDecoration(color: c)). '
        'You cannot specify both color and decoration simultaneously.',
      ),
      _buildNoteBox(
        'Ink must be a descendant of a Material widget. If used outside '
        'of Material, it will throw an error at runtime. '
        'The Material widget provides the canvas for the ink reactions.',
      ),
    ],
  );
}

Widget _buildDebugSection() {
  print('  === Debug Output Summary ===');
  print('  Ink widget properties:');
  print('    - child: Widget placed inside the Ink');
  print('    - decoration: BoxDecoration for painting');
  print('    - width: explicit width constraint');
  print('    - height: explicit height constraint');
  print('    - padding: EdgeInsets for child inset');
  print('    - color: shorthand for decoration color');
  print('  BoxDecoration properties used:');
  print('    - color, gradient, border, borderRadius');
  print('    - boxShadow, shape, image');
  print('  Key difference: Ink vs Container');
  print('    - Container: decoration paints OVER Ink splash');
  print('    - Ink: decoration paints as Material, splash on TOP');
  print('  Supported gradient types:');
  print('    - LinearGradient');
  print('    - RadialGradient');
  print('    - SweepGradient');
  print('  Supported shapes:');
  print('    - BoxShape.rectangle (default)');
  print('    - BoxShape.circle');

  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.terminal, color: Color(0xFF4CAF50), size: 18),
            SizedBox(width: 8),
            Text(
              'Debug Output (see console)',
              style: TextStyle(
                color: Color(0xFF4CAF50),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          'print() statements executed during build:',
          style: TextStyle(color: Color(0xFF90A4AE), fontSize: 12),
        ),
        SizedBox(height: 6),
        Text(
          '> Ink Decoration Test executing\n'
          '> Section: Basic Ink Decorations\n'
          '> Section: Gradient Decorations\n'
          '> Section: Border and Shadow\n'
          '> Section: Ink + InkWell Splash\n'
          '> Section: Container vs Ink\n'
          '> Section: Shapes and Sizes\n'
          '> Section: Padding and Children\n'
          '> Section: Decoration Gallery\n'
          '> Section: Property Reference\n'
          '> Section: Debug Output\n'
          '> Ink Decoration Test completed',
          style: TextStyle(color: Color(0xFF80CBC4), fontSize: 11, height: 1.5),
        ),
        SizedBox(height: 10),
        Divider(color: Color(0xFF455A64)),
        SizedBox(height: 6),
        Text(
          'Ink widget key facts:',
          style: TextStyle(
            color: Color(0xFFFFCC80),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4),
        Text(
          '- Ink paints decoration INTO Material for correct splash order\n'
          '- Must be a descendant of a Material widget\n'
          '- color property is shorthand for BoxDecoration(color: ...)\n'
          '- Cannot specify both color and decoration\n'
          '- InkWell/InkResponse splashes render on top of Ink\n'
          '- Container decorations paint over splashes (incorrect)\n'
          '- Supports all BoxDecoration features: gradients, borders, shadows',
          style: TextStyle(color: Color(0xFFB0BEC5), fontSize: 11, height: 1.5),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== Ink Decoration Visual Demo ===');
  print('Testing Ink widget with various BoxDecoration styles');
  print('Ink paints decoration on Material so ink splashes render on top');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('Ink Decoration Demo'),
        backgroundColor: Color(0xFF1565C0),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(
              'Ink Widget Overview',
              'The Ink widget paints a Decoration (typically BoxDecoration) '
                  'on a Material widget. This ensures that ink splashes and highlights '
                  'from InkWell or InkResponse render correctly ON TOP of the decoration, '
                  'rather than being hidden behind it as with a Container.',
            ),
            _buildNoteBox(
              'Ink must always be a descendant of a Material widget. The decoration '
              'is painted into the Material, which means the ink reactions (splash, '
              'highlight) can composite correctly above the decoration.',
            ),
            _buildSectionHeader('1. Basic Ink with BoxDecoration'),
            _buildBasicInkDecorations(),
            _buildSectionHeader('2. Ink with Gradient Decorations'),
            _buildGradientInkDecorations(),
            _buildSectionHeader('3. Ink with Border and Shadow'),
            _buildBorderAndShadowInk(),
            _buildSectionHeader('4. Ink with InkWell Splash'),
            _buildInkWithInkWell(),
            _buildSectionHeader('5. Container vs Ink Comparison'),
            _buildContainerVsInkComparison(),
            _buildSectionHeader('6. Ink Shapes and Sizes'),
            _buildShapesAndSizes(),
            _buildSectionHeader('7. Ink with Padding and Children'),
            _buildPaddingAndChildren(),
            _buildSectionHeader('8. Decoration Style Gallery'),
            _buildGridDecorationStyles(),
            _buildSectionHeader('9. Property Reference'),
            _buildPropertyReference(),
            _buildSectionHeader('10. Debug Output'),
            _buildDebugSection(),
            SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}
