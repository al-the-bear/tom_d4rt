// Deep demo: RenderBackdropFilter / BackdropFilter widget
// BackdropFilter applies a filter (blur, color matrix, etc.) to the area
// behind its child in the widget tree. It operates on the render layer
// via RenderBackdropFilter, compositing an ImageFilter over existing content.

import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';

// -- Helper: builds a colorful background with gradients, text, and icons
Widget _buildColorfulBackground() {
  print('[BackdropFilter] Building colorful background content');
  return Container(
    width: double.infinity,
    height: 300,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.deepPurple,
          Colors.indigo,
          Colors.blue,
          Colors.cyan,
          Colors.teal,
          Colors.green,
          Colors.lime,
          Colors.yellow,
          Colors.orange,
          Colors.red,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.star, size: 40, color: Colors.white),
            Icon(Icons.favorite, size: 40, color: Colors.pinkAccent),
            Icon(Icons.bolt, size: 40, color: Colors.amberAccent),
            Icon(Icons.diamond, size: 40, color: Colors.cyanAccent),
            Icon(Icons.rocket_launch, size: 40, color: Colors.white),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'Background Content',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'This text is behind the BackdropFilter',
          style: TextStyle(fontSize: 16, color: Colors.white70),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.circle, size: 30, color: Colors.redAccent),
            Icon(Icons.circle, size: 30, color: Colors.orangeAccent),
            Icon(Icons.circle, size: 30, color: Colors.yellowAccent),
            Icon(Icons.circle, size: 30, color: Colors.greenAccent),
            Icon(Icons.circle, size: 30, color: Colors.blueAccent),
            Icon(Icons.circle, size: 30, color: Colors.purpleAccent),
          ],
        ),
      ],
    ),
  );
}

// -- Helper: builds a grid pattern background
Widget _buildGridBackground() {
  print('[BackdropFilter] Building grid pattern background');
  return Container(
    width: double.infinity,
    height: 250,
    color: Colors.white,
    child: GridView.count(
      crossAxisCount: 8,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: List.generate(64, (index) {
        int row = index ~/ 8;
        int col = index % 8;
        bool isEven = (row + col) % 2 == 0;
        return Container(
          color: isEven
              ? Colors.primaries[index % Colors.primaries.length]
              : Colors.white,
        );
      }),
    ),
  );
}

// -- Helper: section header with gradient
Widget _buildSectionHeader(String title, IconData icon, List<Color> colors) {
  print('[BackdropFilter] Section: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: colors,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

// -- Helper: info card with shadow
Widget _buildInfoCard(String text) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 13, color: Colors.black87),
    ),
  );
}

// ============================================================
// Section 1: Blur sigma comparison
// ============================================================
Widget _buildBlurSigmaComparison() {
  print('[BackdropFilter] Building blur sigma comparison section');
  List<double> sigmaValues = [0.0, 2.0, 5.0, 10.0, 20.0];

  return Column(
    children: [
      _buildSectionHeader(
        '1. Blur Sigma Comparison',
        Icons.blur_on,
        [Colors.indigo, Colors.blue],
      ),
      SizedBox(height: 8),
      _buildInfoCard(
        'BackdropFilter with ImageFilter.blur at different sigma values. '
        'Higher sigma = more blur. Sigma 0 = no blur.',
      ),
      SizedBox(height: 8),
      ...sigmaValues.map((sigma) {
        print('[BackdropFilter]   sigma=$sigma');
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'sigmaX: $sigma, sigmaY: $sigma',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.indigo,
                ),
              ),
              SizedBox(height: 4),
              ClipRect(
                child: SizedBox(
                  height: 100,
                  child: Stack(
                    children: [
                      _buildColorfulBackground(),
                      Positioned.fill(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: sigma,
                            sigmaY: sigma,
                          ),
                          child: Container(
                            color: Colors.transparent,
                            alignment: Alignment.center,
                            child: Text(
                              'Sigma: $sigma',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 4),
            ],
          ),
        );
      }).toList(),
      SizedBox(height: 12),
    ],
  );
}

// ============================================================
// Section 2: BackdropFilter over colorful content
// ============================================================
Widget _buildOverColorfulContent() {
  print('[BackdropFilter] Building backdrop over colorful content section');
  return Column(
    children: [
      _buildSectionHeader(
        '2. Over Colorful Content',
        Icons.color_lens,
        [Colors.deepPurple, Colors.purple],
      ),
      SizedBox(height: 8),
      _buildInfoCard(
        'BackdropFilter blurs everything painted BEFORE it in the same Stack. '
        'The colorful gradient, text, and icons all get blurred.',
      ),
      SizedBox(height: 8),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ClipRect(
          child: SizedBox(
            height: 280,
            child: Stack(
              children: [
                // Rich colorful background
                Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        Colors.yellow,
                        Colors.orange,
                        Colors.red,
                        Colors.purple,
                        Colors.blue,
                      ],
                      radius: 1.2,
                      center: Alignment.center,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.ac_unit, size: 36, color: Colors.white),
                          Icon(Icons.eco, size: 36, color: Colors.white),
                          Icon(Icons.pets, size: 36, color: Colors.white),
                          Icon(Icons.music_note, size: 36, color: Colors.white),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Colorful Background Layer',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Gradients + Icons + Text',
                        style: TextStyle(fontSize: 15, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                // Partial blur overlay in center
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      width: 260,
                      height: 140,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          color: Colors.white.withValues(alpha: 0.15),
                          alignment: Alignment.center,
                          child: Text(
                            'Blurred Region',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 12),
    ],
  );
}

// ============================================================
// Section 3: BlendMode options
// ============================================================
Widget _buildBlendModeSection() {
  print('[BackdropFilter] Building blend mode section');

  List<BlendMode> modes = [
    BlendMode.srcOver,
    BlendMode.multiply,
    BlendMode.screen,
    BlendMode.overlay,
    BlendMode.colorDodge,
    BlendMode.colorBurn,
  ];

  return Column(
    children: [
      _buildSectionHeader(
        '3. BlendMode Options',
        Icons.blender,
        [Colors.teal, Colors.cyan],
      ),
      SizedBox(height: 8),
      _buildInfoCard(
        'BackdropFilter accepts a blendMode parameter that controls how '
        'the filtered backdrop composites with the child. Different blend '
        'modes produce dramatically different visual effects.',
      ),
      SizedBox(height: 8),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: modes.map((mode) {
          print('[BackdropFilter]   blendMode=$mode');
          return Container(
            width: 160,
            height: 130,
            margin: EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              children: [
                Text(
                  mode.toString().split('.').last,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.teal,
                  ),
                ),
                SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: 100,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.red, Colors.blue, Colors.green],
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.auto_awesome,
                              size: 32,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                            blendMode: mode,
                            child: Container(
                              color: Colors.transparent,
                              alignment: Alignment.center,
                              child: Text(
                                mode.toString().split('.').last,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
      SizedBox(height: 12),
    ],
  );
}

// ============================================================
// Section 4: Frosted glass effect
// ============================================================
Widget _buildFrostedGlassSection() {
  print('[BackdropFilter] Building frosted glass effect section');
  return Column(
    children: [
      _buildSectionHeader(
        '4. Frosted Glass Effect',
        Icons.window,
        [Colors.blueGrey, Colors.grey],
      ),
      SizedBox(height: 8),
      _buildInfoCard(
        'The classic frosted glass pattern: BackdropFilter with blur + '
        'a semi-transparent white/colored overlay. Common in iOS-style '
        'UIs and glassmorphism design.',
      ),
      SizedBox(height: 8),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ClipRect(
          child: SizedBox(
            height: 320,
            child: Stack(
              children: [
                // Background image-like content
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepOrange,
                        Colors.pink,
                        Colors.purple,
                        Colors.deepPurple,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.cloud, size: 48, color: Colors.white54),
                          Icon(Icons.sunny, size: 48, color: Colors.amber),
                          Icon(Icons.nightlight, size: 48, color: Colors.white54),
                        ],
                      ),
                      Text(
                        'Scenic Background',
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.landscape, size: 40, color: Colors.white38),
                          Icon(Icons.forest, size: 40, color: Colors.green),
                          Icon(Icons.water, size: 40, color: Colors.lightBlue),
                        ],
                      ),
                    ],
                  ),
                ),
                // Frosted glass card
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        width: 300,
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.lock, size: 40, color: Colors.white),
                            SizedBox(height: 12),
                            Text(
                              'Frosted Glass Card',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Semi-transparent overlay on blurred backdrop',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 12),
    ],
  );
}

// ============================================================
// Section 5: Stack layering demonstration
// ============================================================
Widget _buildStackLayeringSection() {
  print('[BackdropFilter] Building stack layering section');
  return Column(
    children: [
      _buildSectionHeader(
        '5. Stack Layering (Backdrop Concept)',
        Icons.layers,
        [Colors.brown, Colors.orange],
      ),
      SizedBox(height: 8),
      _buildInfoCard(
        'BackdropFilter only blurs content BELOW it in the Stack. '
        'Content added AFTER the BackdropFilter is not affected. '
        'This demonstrates the rendering order dependency.',
      ),
      SizedBox(height: 8),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ClipRect(
          child: SizedBox(
            height: 250,
            child: Stack(
              children: [
                // Layer 0: background pattern
                _buildGridBackground(),
                // Layer 1: some content that WILL be blurred
                Positioned(
                  left: 20,
                  top: 20,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Below filter (blurred)',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 60,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Also below (blurred)',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
                // Layer 2: the BackdropFilter (blurs layers 0 and 1)
                Positioned(
                  left: 40,
                  top: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 220,
                      height: 120,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            border: Border.all(color: Colors.white54),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'BackdropFilter here',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Layer 3: content ABOVE filter (NOT blurred)
                Positioned(
                  right: 30,
                  bottom: 20,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      'Above filter (sharp)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 12),
    ],
  );
}

// ============================================================
// Section 6: ClipRRect for rounded blurred areas
// ============================================================
Widget _buildClipRRectBlurSection() {
  print('[BackdropFilter] Building ClipRRect rounded blur section');

  List<double> radii = [0, 12, 24, 50];

  return Column(
    children: [
      _buildSectionHeader(
        '6. ClipRRect Rounded Blur Areas',
        Icons.rounded_corner,
        [Colors.green, Colors.lightGreen],
      ),
      SizedBox(height: 8),
      _buildInfoCard(
        'BackdropFilter requires clipping to define its affected area. '
        'ClipRRect creates rounded rectangular blur regions. Without '
        'clipping, the blur extends to the full ancestor clip.',
      ),
      SizedBox(height: 8),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ClipRect(
          child: SizedBox(
            height: 220,
            child: Stack(
              children: [
                _buildColorfulBackground(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: radii.map((radius) {
                    print('[BackdropFilter]   ClipRRect radius=$radius');
                    return Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          Text(
                            'r=$radius',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radius),
                            child: SizedBox(
                              width: 70,
                              height: 70,
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 8,
                                  sigmaY: 8,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius:
                                        BorderRadius.circular(radius),
                                    border: Border.all(
                                      color: Colors.white60,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 12),
    ],
  );
}

// ============================================================
// Section 7: Multiple overlapping BackdropFilters
// ============================================================
Widget _buildOverlappingFiltersSection() {
  print('[BackdropFilter] Building overlapping filters section');
  return Column(
    children: [
      _buildSectionHeader(
        '7. Overlapping BackdropFilters',
        Icons.filter_none,
        [Colors.deepOrange, Colors.red],
      ),
      SizedBox(height: 8),
      _buildInfoCard(
        'Multiple BackdropFilters can overlap. Each one blurs the content '
        'behind it, including already-blurred content from earlier filters. '
        'Overlapping regions receive cumulative blur.',
      ),
      SizedBox(height: 8),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ClipRect(
          child: SizedBox(
            height: 300,
            child: Stack(
              children: [
                // Complex background
                Container(
                  decoration: BoxDecoration(
                    gradient: SweepGradient(
                      colors: [
                        Colors.red,
                        Colors.orange,
                        Colors.yellow,
                        Colors.green,
                        Colors.blue,
                        Colors.purple,
                        Colors.red,
                      ],
                      center: Alignment.center,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.palette, size: 60, color: Colors.white),
                        SizedBox(height: 8),
                        Text(
                          'Colorful Backdrop',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'With sweep gradient',
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
                // Filter 1: top-left
                Positioned(
                  left: 20,
                  top: 30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      width: 160,
                      height: 160,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.blue, width: 2),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Filter 1\nsigma: 5',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Filter 2: overlapping center-right
                Positioned(
                  left: 120,
                  top: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      width: 160,
                      height: 160,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.red, width: 2),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Filter 2\nsigma: 8',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Filter 3: bottom region for triple overlap
                Positioned(
                  left: 60,
                  top: 140,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      width: 180,
                      height: 120,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.green, width: 2),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Filter 3 - sigma: 12\n(overlaps both)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Label for overlap region
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Overlap = cumulative blur',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 12),
    ],
  );
}

// ============================================================
// Section 8: Asymmetric blur + practical examples
// ============================================================
Widget _buildAsymmetricBlurSection() {
  print('[BackdropFilter] Building asymmetric blur section');
  return Column(
    children: [
      _buildSectionHeader(
        '8. Asymmetric Blur & Practical Patterns',
        Icons.tune,
        [Colors.pink, Colors.pinkAccent],
      ),
      SizedBox(height: 8),
      _buildInfoCard(
        'sigmaX and sigmaY can differ, creating directional blur. '
        'Also showing practical UI patterns: blurred app bar, '
        'blurred bottom sheet, and blurred dialog overlay.',
      ),
      SizedBox(height: 8),
      // Asymmetric blur examples
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            // Horizontal blur
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Horizontal (20, 0)',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      height: 100,
                      child: Stack(
                        children: [
                          _buildColorfulBackground(),
                          Positioned.fill(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 20,
                                sigmaY: 0,
                              ),
                              child: Container(color: Colors.transparent),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            // Vertical blur
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Vertical (0, 20)',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      height: 100,
                      child: Stack(
                        children: [
                          _buildColorfulBackground(),
                          Positioned.fill(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 0,
                                sigmaY: 20,
                              ),
                              child: Container(color: Colors.transparent),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 12),
      // Practical: blurred app bar simulation
      _buildInfoCard('Practical: Simulated blurred navigation bar'),
      SizedBox(height: 4),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: 180,
            child: Stack(
              children: [
                // Scrollable content behind
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.teal, Colors.blue, Colors.indigo],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      SizedBox(height: 60),
                      Center(
                        child: Text(
                          'Page Content',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Center(
                        child: Text(
                          'Scrollable items behind the nav bar',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.image, size: 30, color: Colors.white54),
                          Icon(Icons.article, size: 30, color: Colors.white54),
                          Icon(Icons.map, size: 30, color: Colors.white54),
                        ],
                      ),
                    ],
                  ),
                ),
                // Blurred top bar
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 50,
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        color: Colors.white.withValues(alpha: 0.2),
                        alignment: Alignment.center,
                        child: Text(
                          'Blurred App Bar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Blurred bottom bar
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 50,
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        color: Colors.white.withValues(alpha: 0.2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.home, color: Colors.white),
                            Icon(Icons.search, color: Colors.white),
                            Icon(Icons.person, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 16),
    ],
  );
}

// ============================================================
// Entry point
// ============================================================
dynamic build(BuildContext context) {
  print('[BackdropFilter] ========================================');
  print('[BackdropFilter] Deep Demo: RenderBackdropFilter');
  print('[BackdropFilter] BackdropFilter applies ImageFilter to the');
  print('[BackdropFilter] area behind its child via RenderBackdropFilter');
  print('[BackdropFilter] ========================================');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title header
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.indigo, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.blur_on, size: 32, color: Colors.white),
                  SizedBox(width: 12),
                  Text(
                    'RenderBackdropFilter',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'BackdropFilter applies an ImageFilter (typically blur) to '
                'everything painted before it in the same compositing layer. '
                'Under the hood, RenderBackdropFilter creates a '
                'BackdropFilterLayer in the render tree.',
                style: TextStyle(fontSize: 13, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),

        // All sections
        _buildBlurSigmaComparison(),
        _buildOverColorfulContent(),
        _buildBlendModeSection(),
        _buildFrostedGlassSection(),
        _buildStackLayeringSection(),
        _buildClipRRectBlurSection(),
        _buildOverlappingFiltersSection(),
        _buildAsymmetricBlurSection(),

        // Summary footer
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey.shade800, Colors.grey.shade600],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Summary',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '- BackdropFilter wraps a child and applies ImageFilter to the backdrop\n'
                '- ImageFilter.blur with sigmaX/sigmaY controls gaussian blur strength\n'
                '- blendMode affects how filtered content composites\n'
                '- Must be clipped (ClipRect/ClipRRect) to define the blur area\n'
                '- Only blurs content BELOW it in the same Stack\n'
                '- Overlapping filters produce cumulative effects\n'
                '- Common pattern: frosted glass = blur + semi-transparent overlay\n'
                '- RenderBackdropFilter creates BackdropFilterLayer in the render tree',
                style: TextStyle(fontSize: 12, color: Colors.white70, height: 1.6),
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
      ],
    ),
  );
}
