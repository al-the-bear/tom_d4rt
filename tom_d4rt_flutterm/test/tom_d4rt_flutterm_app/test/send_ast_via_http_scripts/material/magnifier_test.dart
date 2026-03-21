// D4rt test script: Tests Magnifier from material
import 'package:flutter/material.dart';

// Helper: section header with icon and gradient background
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
        Expanded(
          child: Text(title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
        ),
      ],
    ),
  );
}

// Helper: info card with label and description
Widget buildInfoCard(String label, String description, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.25)),
    ),
    child: Row(
      children: [
        Container(
          width: 6,
          height: 36,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: color)),
              SizedBox(height: 2),
              Text(description,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper: colorful grid content for magnifier to sit over
Widget buildColorfulContent(double width, double height) {
  return SizedBox(
    width: width,
    height: height,
    child: Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(child: Container(color: Colors.red.shade300)),
              Expanded(child: Container(color: Colors.blue.shade300)),
              Expanded(child: Container(color: Colors.green.shade300)),
              Expanded(child: Container(color: Colors.orange.shade300)),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(child: Container(color: Colors.purple.shade300)),
              Expanded(child: Container(color: Colors.teal.shade300)),
              Expanded(child: Container(color: Colors.pink.shade300)),
              Expanded(child: Container(color: Colors.amber.shade300)),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(child: Container(color: Colors.cyan.shade300)),
              Expanded(child: Container(color: Colors.lime.shade300)),
              Expanded(child: Container(color: Colors.indigo.shade300)),
              Expanded(child: Container(color: Colors.brown.shade300)),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper: magnifier demo card with label and subtitle
Widget buildMagnifierCard(String label, String subtitle, Widget content) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.grey.shade800)),
        SizedBox(height: 2),
        Text(subtitle,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
        SizedBox(height: 8),
        content,
      ],
    ),
  );
}

// Helper: rich text content with styled words and icons
Widget buildRichTextContent(double width, double height) {
  return SizedBox(
    width: width,
    height: height,
    child: Container(
      color: Colors.grey.shade100,
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('The quick brown fox jumps',
              style: TextStyle(fontSize: 14, color: Colors.brown.shade700)),
          SizedBox(height: 4),
          Text('over the lazy dog.',
              style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.blue.shade700)),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 16),
              SizedBox(width: 4),
              Icon(Icons.favorite, color: Colors.red, size: 16),
              SizedBox(width: 4),
              Icon(Icons.thumb_up, color: Colors.green, size: 16),
              SizedBox(width: 8),
              Text('Magnify this!',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple)),
            ],
          ),
          SizedBox(height: 4),
          Text('ABCDEFGHIJKLMNOPQRSTUVWXYZ',
              style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 2,
                  color: Colors.grey.shade800)),
        ],
      ),
    ),
  );
}

// Helper: icon grid content for magnification demos
Widget buildIconGridContent(double width, double height) {
  return SizedBox(
    width: width,
    height: height,
    child: Container(
      color: Colors.blueGrey.shade50,
      padding: EdgeInsets.all(4),
      child: Wrap(
        spacing: 6,
        runSpacing: 6,
        children: [
          Icon(Icons.home, color: Colors.blue, size: 20),
          Icon(Icons.settings, color: Colors.grey, size: 20),
          Icon(Icons.person, color: Colors.green, size: 20),
          Icon(Icons.mail, color: Colors.red, size: 20),
          Icon(Icons.phone, color: Colors.orange, size: 20),
          Icon(Icons.camera, color: Colors.purple, size: 20),
          Icon(Icons.music_note, color: Colors.pink, size: 20),
          Icon(Icons.search, color: Colors.teal, size: 20),
          Icon(Icons.bookmark, color: Colors.amber, size: 20),
          Icon(Icons.delete, color: Colors.redAccent, size: 20),
          Icon(Icons.edit, color: Colors.indigo, size: 20),
          Icon(Icons.cloud, color: Colors.lightBlue, size: 20),
          Icon(Icons.wifi, color: Colors.cyan, size: 20),
          Icon(Icons.lock, color: Colors.brown, size: 20),
          Icon(Icons.flash_on, color: Colors.yellow.shade800, size: 20),
        ],
      ),
    ),
  );
}

dynamic build(BuildContext context) {
  print('--- Magnifier Deep Demo Test ---');
  print('Testing Magnifier widget from material library');
  print('Magnifier provides a magnifying glass effect with loupe border and shadow');

  final List<Widget> sections = [];

  // ── Section 1: Introduction ──
  print('Section 1: Introduction and overview');
  sections.add(buildSectionHeader(
      'Magnifier Widget Demo', Icons.search, Colors.indigo));
  sections.add(buildInfoCard('Widget',
      'Magnifier - Material Design magnifying glass effect', Colors.indigo));
  sections.add(buildInfoCard('Purpose',
      'Used for text selection magnification with loupe border and shadow', Colors.blue));
  sections.add(buildInfoCard('Key Properties',
      'size, borderRadius, filmColor, shadows, additionalFocalPointOffset', Colors.teal));
  sections.add(buildInfoCard('MagnifierDecoration',
      'ShapeDecoration subclass with opacity control for the magnifier chrome', Colors.deepPurple));

  // ── Section 2: Basic Magnifier with default settings ──
  print('Section 2: Basic Magnifier with default settings');
  sections.add(buildSectionHeader(
      'Basic Magnifier', Icons.zoom_in, Colors.blue));
  sections.add(buildInfoCard('Default Settings',
      'Magnifier with factory defaults placed over colorful content', Colors.blue));

  sections.add(buildMagnifierCard(
    'Default Magnifier',
    'Size 77.37 x 37.9, standard loupe appearance with rounded border',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 160,
        child: Stack(
          children: [
            buildColorfulContent(double.infinity, 160),
            Center(
              child: Text('Magnified Area',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(blurRadius: 3, color: Colors.black)
                      ])),
            ),
            Positioned(
              left: 80,
              top: 55,
              child: Magnifier(),
            ),
          ],
        ),
      ),
    ),
  ));

  sections.add(buildMagnifierCard(
    'Magnifier Over Text',
    'Default magnifier positioned over rich text content',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 120,
        child: Stack(
          children: [
            buildRichTextContent(double.infinity, 120),
            Positioned(
              left: 60,
              top: 30,
              child: Magnifier(),
            ),
          ],
        ),
      ),
    ),
  ));

  // ── Section 3: Magnifier with different sizes ──
  print('Section 3: Magnifier size variations');
  sections.add(buildSectionHeader(
      'Size Variations', Icons.aspect_ratio, Colors.purple));
  sections.add(buildInfoCard('size Property',
      'Controls the dimensions of the magnifier lens via Size(width, height)', Colors.purple));

  sections.add(buildMagnifierCard(
    'Small Magnifier (50 x 50)',
    'Compact magnifier suitable for precise text selection',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 120,
        child: Stack(
          children: [
            buildColorfulContent(double.infinity, 120),
            Positioned(
              left: 100,
              top: 30,
              child: Magnifier(size: Size(50, 50)),
            ),
          ],
        ),
      ),
    ),
  ));

  sections.add(buildMagnifierCard(
    'Medium Magnifier (80 x 80)',
    'Balanced size for general use magnification',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 140,
        child: Stack(
          children: [
            buildColorfulContent(double.infinity, 140),
            Positioned(
              left: 90,
              top: 25,
              child: Magnifier(size: Size(80, 80)),
            ),
          ],
        ),
      ),
    ),
  ));

  sections.add(buildMagnifierCard(
    'Large Magnifier (120 x 120)',
    'Oversized magnifier showing more content area',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 170,
        child: Stack(
          children: [
            buildColorfulContent(double.infinity, 170),
            Positioned(
              left: 70,
              top: 20,
              child: Magnifier(size: Size(120, 120)),
            ),
          ],
        ),
      ),
    ),
  ));

  sections.add(buildMagnifierCard(
    'Wide Magnifier (160 x 40)',
    'Horizontally stretched magnifier for line-level text viewing',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 120,
        child: Stack(
          children: [
            buildRichTextContent(double.infinity, 120),
            Positioned(
              left: 40,
              top: 35,
              child: Magnifier(size: Size(160, 40)),
            ),
          ],
        ),
      ),
    ),
  ));

  sections.add(buildMagnifierCard(
    'Tall Magnifier (40 x 100)',
    'Vertically stretched magnifier for column content',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 140,
        child: Stack(
          children: [
            buildIconGridContent(double.infinity, 140),
            Positioned(
              left: 120,
              top: 15,
              child: Magnifier(size: Size(40, 100)),
            ),
          ],
        ),
      ),
    ),
  ));

  // ── Section 4: Magnifier with different borderRadius values ──
  print('Section 4: Border radius variations');
  sections.add(buildSectionHeader(
      'Border Radius Variations', Icons.rounded_corner, Colors.deepOrange));
  sections.add(buildInfoCard('borderRadius Property',
      'Controls corner rounding of the magnifier shape - round vs square', Colors.deepOrange));

  sections.add(buildMagnifierCard(
    'Fully Round (Radius 40)',
    'Default pill-shaped magnifier with large radius',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 130,
        child: Stack(
          children: [
            buildColorfulContent(double.infinity, 130),
            Positioned(
              left: 80,
              top: 30,
              child: Magnifier(
                size: Size(80, 80),
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
            ),
          ],
        ),
      ),
    ),
  ));

  sections.add(buildMagnifierCard(
    'Square Corners (Radius 0)',
    'Sharp rectangular magnifier with no rounding',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 130,
        child: Stack(
          children: [
            buildColorfulContent(double.infinity, 130),
            Positioned(
              left: 80,
              top: 30,
              child: Magnifier(
                size: Size(80, 80),
                borderRadius: BorderRadius.all(Radius.circular(0)),
              ),
            ),
          ],
        ),
      ),
    ),
  ));

  sections.add(buildMagnifierCard(
    'Slightly Rounded (Radius 8)',
    'Subtle corner rounding for a modern look',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 130,
        child: Stack(
          children: [
            buildColorfulContent(double.infinity, 130),
            Positioned(
              left: 80,
              top: 30,
              child: Magnifier(
                size: Size(80, 80),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    ),
  ));

  sections.add(buildMagnifierCard(
    'Asymmetric Radius',
    'Different radius for top-left (20) and bottom-right (4)',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 130,
        child: Stack(
          children: [
            buildColorfulContent(double.infinity, 130),
            Positioned(
              left: 80,
              top: 30,
              child: Magnifier(
                size: Size(80, 80),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ));

  // ── Section 5: Magnifier with filmColor tints ──
  print('Section 5: Film color tints');
  sections.add(buildSectionHeader(
      'Film Color Tints', Icons.color_lens, Colors.teal));
  sections.add(buildInfoCard('filmColor Property',
      'Applies a colored overlay on the magnified content for tinting', Colors.teal));

  sections.add(buildMagnifierCard(
    'Blue Film Tint',
    'filmColor: blue with alpha 0.3',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 130,
        child: Stack(
          children: [
            buildColorfulContent(double.infinity, 130),
            Positioned(
              left: 80,
              top: 25,
              child: Magnifier(
                size: Size(90, 80),
                filmColor: Colors.blue.withValues(alpha: 0.3),
              ),
            ),
          ],
        ),
      ),
    ),
  ));

  sections.add(buildMagnifierCard(
    'Amber Film Tint',
    'filmColor: amber with alpha 0.3',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 130,
        child: Stack(
          children: [
            buildRichTextContent(double.infinity, 130),
            Positioned(
              left: 80,
              top: 25,
              child: Magnifier(
                size: Size(90, 80),
                filmColor: Colors.amber.withValues(alpha: 0.3),
              ),
            ),
          ],
        ),
      ),
    ),
  ));

  sections.add(buildMagnifierCard(
    'Green Film Tint',
    'filmColor: green with alpha 0.25',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 130,
        child: Stack(
          children: [
            buildIconGridContent(double.infinity, 130),
            Positioned(
              left: 80,
              top: 25,
              child: Magnifier(
                size: Size(90, 80),
                filmColor: Colors.green.withValues(alpha: 0.25),
              ),
            ),
          ],
        ),
      ),
    ),
  ));

  sections.add(buildMagnifierCard(
    'Heavy Red Film Tint',
    'filmColor: red with alpha 0.5 for dramatic effect',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 130,
        child: Stack(
          children: [
            buildColorfulContent(double.infinity, 130),
            Positioned(
              left: 80,
              top: 25,
              child: Magnifier(
                size: Size(90, 80),
                filmColor: Colors.red.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    ),
  ));

  // ── Section 6: Shadow configurations ──
  print('Section 6: Shadow configurations');
  sections.add(buildSectionHeader(
      'Shadow Configurations', Icons.layers, Colors.blueGrey));
  sections.add(buildInfoCard('shadows Property',
      'List of BoxShadow controlling the magnifier drop shadow appearance', Colors.blueGrey));
  sections.add(buildInfoCard('MagnifierDecoration',
      'ShapeDecoration subclass with opacity used internally by RawMagnifier', Colors.grey));

  sections.add(buildMagnifierCard(
    'Subtle Shadow',
    'Light shadow with low blur and spread',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 130,
        child: Stack(
          children: [
            buildColorfulContent(double.infinity, 130),
            Positioned(
              left: 80,
              top: 25,
              child: Magnifier(
                size: Size(90, 80),
                shadows: [
                  BoxShadow(
                    blurRadius: 2,
                    offset: Offset(0, 1),
                    spreadRadius: 0.5,
                    color: Colors.black.withValues(alpha: 0.1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ));

  sections.add(buildMagnifierCard(
    'Heavy Shadow',
    'Deep shadow with large blur and spread for elevated effect',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 140,
        child: Stack(
          children: [
            buildColorfulContent(double.infinity, 140),
            Positioned(
              left: 75,
              top: 25,
              child: Magnifier(
                size: Size(90, 80),
                shadows: [
                  BoxShadow(
                    blurRadius: 12,
                    offset: Offset(0, 6),
                    spreadRadius: 2,
                    color: Colors.black.withValues(alpha: 0.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ));

  sections.add(buildMagnifierCard(
    'Multi-Layer Shadow',
    'Two overlapping shadows for a realistic depth effect',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 140,
        child: Stack(
          children: [
            buildRichTextContent(double.infinity, 140),
            Positioned(
              left: 75,
              top: 30,
              child: Magnifier(
                size: Size(90, 80),
                shadows: [
                  BoxShadow(
                    blurRadius: 8,
                    offset: Offset(0, 4),
                    spreadRadius: 1,
                    color: Colors.black.withValues(alpha: 0.25),
                  ),
                  BoxShadow(
                    blurRadius: 2,
                    offset: Offset(0, 1),
                    spreadRadius: 0,
                    color: Colors.black.withValues(alpha: 0.15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ));

  sections.add(buildMagnifierCard(
    'Colored Shadow',
    'Blue-tinted shadow for a themed magnifier appearance',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 140,
        child: Stack(
          children: [
            buildColorfulContent(double.infinity, 140),
            Positioned(
              left: 75,
              top: 30,
              child: Magnifier(
                size: Size(90, 80),
                shadows: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: Offset(0, 4),
                    spreadRadius: 1,
                    color: Colors.blue.withValues(alpha: 0.35),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ));

  sections.add(buildMagnifierCard(
    'No Shadow',
    'Empty shadows list for a flat magnifier without elevation',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 130,
        child: Stack(
          children: [
            buildColorfulContent(double.infinity, 130),
            Positioned(
              left: 80,
              top: 25,
              child: Magnifier(
                size: Size(90, 80),
                shadows: [],
              ),
            ),
          ],
        ),
      ),
    ),
  ));

  // ── Section 7: additionalFocalPointOffset ──
  print('Section 7: Focal point offset variations');
  sections.add(buildSectionHeader(
      'Focal Point Offset', Icons.control_camera, Colors.orange));
  sections.add(buildInfoCard('additionalFocalPointOffset',
      'Shifts the magnification center relative to the magnifier position', Colors.orange));

  sections.add(buildMagnifierCard(
    'No Offset (Default)',
    'additionalFocalPointOffset: Offset.zero',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 130,
        child: Stack(
          children: [
            buildColorfulContent(double.infinity, 130),
            Center(
              child: Text('CENTER',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(blurRadius: 2, color: Colors.black)
                      ])),
            ),
            Positioned(
              left: 100,
              top: 40,
              child: Magnifier(
                size: Size(80, 60),
                additionalFocalPointOffset: Offset.zero,
              ),
            ),
          ],
        ),
      ),
    ),
  ));

  sections.add(buildMagnifierCard(
    'Offset Right (+20, 0)',
    'Focal point shifted 20 pixels to the right',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 130,
        child: Stack(
          children: [
            buildColorfulContent(double.infinity, 130),
            Positioned(
              left: 100,
              top: 40,
              child: Magnifier(
                size: Size(80, 60),
                additionalFocalPointOffset: Offset(20, 0),
              ),
            ),
          ],
        ),
      ),
    ),
  ));

  sections.add(buildMagnifierCard(
    'Offset Down (0, +15)',
    'Focal point shifted 15 pixels downward',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 130,
        child: Stack(
          children: [
            buildRichTextContent(double.infinity, 130),
            Positioned(
              left: 100,
              top: 35,
              child: Magnifier(
                size: Size(80, 60),
                additionalFocalPointOffset: Offset(0, 15),
              ),
            ),
          ],
        ),
      ),
    ),
  ));

  sections.add(buildMagnifierCard(
    'Diagonal Offset (-15, -10)',
    'Focal point shifted up-left diagonally',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 130,
        child: Stack(
          children: [
            buildColorfulContent(double.infinity, 130),
            Positioned(
              left: 100,
              top: 40,
              child: Magnifier(
                size: Size(80, 60),
                additionalFocalPointOffset: Offset(-15, -10),
              ),
            ),
          ],
        ),
      ),
    ),
  ));

  sections.add(buildMagnifierCard(
    'Large Offset (+30, +25)',
    'Significant focal point displacement for off-center viewing',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 130,
        child: Stack(
          children: [
            buildIconGridContent(double.infinity, 130),
            Positioned(
              left: 90,
              top: 35,
              child: Magnifier(
                size: Size(80, 60),
                additionalFocalPointOffset: Offset(30, 25),
              ),
            ),
          ],
        ),
      ),
    ),
  ));

  // ── Section 8: Different content types ──
  print('Section 8: Magnifier over different content types');
  sections.add(buildSectionHeader(
      'Over Different Content', Icons.grid_view, Colors.green));
  sections.add(buildInfoCard('Content Variety',
      'Demonstrates magnifier appearance over text, icons, and colored patterns', Colors.green));

  sections.add(buildMagnifierCard(
    'Over Gradient Background',
    'Magnifier positioned over a smooth linear gradient',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 130,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 130,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple,
                    Colors.blue,
                    Colors.cyan,
                    Colors.teal,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Positioned(
              left: 100,
              top: 30,
              child: Magnifier(size: Size(90, 70)),
            ),
          ],
        ),
      ),
    ),
  ));

  sections.add(buildMagnifierCard(
    'Over Dense Text',
    'Magnifier on fine print text to show text magnification',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 130,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 130,
              color: Colors.white,
              padding: EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                      style: TextStyle(fontSize: 9, color: Colors.black87)),
                  Text('Sed do eiusmod tempor incididunt ut labore et dolore.',
                      style: TextStyle(fontSize: 9, color: Colors.black87)),
                  Text('Ut enim ad minim veniam, quis nostrud exercitation.',
                      style: TextStyle(fontSize: 9, color: Colors.black87)),
                  Text('Duis aute irure dolor in reprehenderit in voluptate.',
                      style: TextStyle(fontSize: 9, color: Colors.black87)),
                  Text('Excepteur sint occaecat cupidatat non proident sunt.',
                      style: TextStyle(fontSize: 9, color: Colors.black87)),
                  Text('In culpa qui officia deserunt mollit anim id est.',
                      style: TextStyle(fontSize: 9, color: Colors.black87)),
                  Text('Curabitur pretium tincidunt lacus in fermentum.',
                      style: TextStyle(fontSize: 9, color: Colors.black87)),
                ],
              ),
            ),
            Positioned(
              left: 80,
              top: 30,
              child: Magnifier(size: Size(100, 60)),
            ),
          ],
        ),
      ),
    ),
  ));

  sections.add(buildMagnifierCard(
    'Over Icon Grid',
    'Magnifier floating above a grid of colorful icons',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 130,
        child: Stack(
          children: [
            buildIconGridContent(double.infinity, 130),
            Positioned(
              left: 70,
              top: 25,
              child: Magnifier(size: Size(100, 80)),
            ),
          ],
        ),
      ),
    ),
  ));

  sections.add(buildMagnifierCard(
    'Over Striped Pattern',
    'Magnifier on alternating color stripes for high contrast',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 130,
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: 130,
              child: Column(
                children: [
                  Expanded(child: Container(color: Colors.red.shade200)),
                  Expanded(child: Container(color: Colors.white)),
                  Expanded(child: Container(color: Colors.blue.shade200)),
                  Expanded(child: Container(color: Colors.white)),
                  Expanded(child: Container(color: Colors.green.shade200)),
                  Expanded(child: Container(color: Colors.white)),
                  Expanded(child: Container(color: Colors.orange.shade200)),
                ],
              ),
            ),
            Positioned(
              left: 90,
              top: 25,
              child: Magnifier(size: Size(90, 80)),
            ),
          ],
        ),
      ),
    ),
  ));

  // ── Section 9: Stacked magnifier compositions ──
  print('Section 9: Stacked magnifier compositions');
  sections.add(buildSectionHeader(
      'Magnifier Compositions', Icons.layers_outlined, Colors.deepPurple));
  sections.add(buildInfoCard('Visual Concept',
      'Multiple magnifiers positioned at different locations showing the effect', Colors.deepPurple));

  sections.add(buildMagnifierCard(
    'Twin Magnifiers',
    'Two magnifiers positioned side by side over content',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 150,
        child: Stack(
          children: [
            buildColorfulContent(double.infinity, 150),
            Center(
              child: Text('TWIN VIEW',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(blurRadius: 3, color: Colors.black)
                      ])),
            ),
            Positioned(
              left: 40,
              top: 40,
              child: Magnifier(size: Size(70, 60)),
            ),
            Positioned(
              left: 180,
              top: 40,
              child: Magnifier(size: Size(70, 60)),
            ),
          ],
        ),
      ),
    ),
  ));

  sections.add(buildMagnifierCard(
    'Diagonal Triple',
    'Three magnifiers positioned diagonally across the content',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 160,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Colors.yellow.shade200,
                    Colors.orange.shade300,
                    Colors.red.shade400,
                    Colors.purple.shade500,
                  ],
                  radius: 1.2,
                ),
              ),
            ),
            Positioned(
              left: 20,
              top: 15,
              child: Magnifier(size: Size(60, 50)),
            ),
            Positioned(
              left: 110,
              top: 55,
              child: Magnifier(size: Size(60, 50)),
            ),
            Positioned(
              left: 200,
              top: 95,
              child: Magnifier(size: Size(60, 50)),
            ),
          ],
        ),
      ),
    ),
  ));

  sections.add(buildMagnifierCard(
    'Mixed Sizes Composition',
    'Small, medium, and large magnifiers in one view',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 170,
        child: Stack(
          children: [
            buildColorfulContent(double.infinity, 170),
            Positioned(
              left: 20,
              top: 60,
              child: Magnifier(size: Size(40, 40)),
            ),
            Positioned(
              left: 100,
              top: 35,
              child: Magnifier(size: Size(80, 80)),
            ),
            Positioned(
              left: 210,
              top: 20,
              child: Magnifier(size: Size(60, 120)),
            ),
          ],
        ),
      ),
    ),
  ));

  // ── Section 10: Opacity via Opacity widget wrapping ──
  print('Section 10: Magnifier with opacity levels');
  sections.add(buildSectionHeader(
      'Opacity / Transparency', Icons.opacity, Colors.cyan));
  sections.add(buildInfoCard('Glass Transparency',
      'Wrapping Magnifier in Opacity widget to show different transparency levels', Colors.cyan));

  sections.add(buildMagnifierCard(
    'Full Opacity (1.0)',
    'Fully opaque magnifier - standard appearance',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 120,
        child: Stack(
          children: [
            buildColorfulContent(double.infinity, 120),
            Positioned(
              left: 90,
              top: 20,
              child: Opacity(
                opacity: 1.0,
                child: Magnifier(size: Size(90, 70)),
              ),
            ),
          ],
        ),
      ),
    ),
  ));

  sections.add(buildMagnifierCard(
    '75% Opacity (0.75)',
    'Slightly transparent magnifier showing content bleed-through',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 120,
        child: Stack(
          children: [
            buildColorfulContent(double.infinity, 120),
            Positioned(
              left: 90,
              top: 20,
              child: Opacity(
                opacity: 0.75,
                child: Magnifier(size: Size(90, 70)),
              ),
            ),
          ],
        ),
      ),
    ),
  ));

  sections.add(buildMagnifierCard(
    '50% Opacity (0.5)',
    'Semi-transparent magnifier glass',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 120,
        child: Stack(
          children: [
            buildColorfulContent(double.infinity, 120),
            Positioned(
              left: 90,
              top: 20,
              child: Opacity(
                opacity: 0.5,
                child: Magnifier(size: Size(90, 70)),
              ),
            ),
          ],
        ),
      ),
    ),
  ));

  sections.add(buildMagnifierCard(
    '25% Opacity (0.25)',
    'Nearly invisible magnifier for subtle overlays',
    ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: double.infinity,
        height: 120,
        child: Stack(
          children: [
            buildColorfulContent(double.infinity, 120),
            Positioned(
              left: 90,
              top: 20,
              child: Opacity(
                opacity: 0.25,
                child: Magnifier(size: Size(90, 70)),
              ),
            ),
          ],
        ),
      ),
    ),
  ));

  // ── Section 11: Summary ──
  print('Section 11: Summary');
  sections.add(buildSectionHeader(
      'Summary', Icons.check_circle_outline, Colors.green.shade700));
  sections.add(buildInfoCard('Magnifier',
      'Material Design magnifier with loupe border and shadow for text selection', Colors.green.shade700));
  sections.add(buildInfoCard('size',
      'Controls lens dimensions - accepts Size(width, height)', Colors.blue));
  sections.add(buildInfoCard('borderRadius',
      'Controls corner rounding - from square (0) to fully round', Colors.purple));
  sections.add(buildInfoCard('filmColor',
      'Applies tinted overlay on magnified content (Color with alpha)', Colors.teal));
  sections.add(buildInfoCard('shadows',
      'List of BoxShadow for drop shadow depth and appearance', Colors.blueGrey));
  sections.add(buildInfoCard('additionalFocalPointOffset',
      'Shifts magnification center - Offset(dx, dy) from default position', Colors.orange));
  sections.add(buildInfoCard('MagnifierDecoration',
      'ShapeDecoration subclass with opacity control for RawMagnifier', Colors.deepPurple));
  sections.add(buildInfoCard('Usage Context',
      'Primarily used in text selection UIs with gesture detection integration', Colors.grey));

  print('--- Magnifier Deep Demo Test Complete ---');
  print('Total sections rendered: 11');
  print('Demonstrated: size, borderRadius, filmColor, shadows, offset, opacity');

  return SingleChildScrollView(
    padding: EdgeInsets.symmetric(vertical: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: sections,
    ),
  );
}
