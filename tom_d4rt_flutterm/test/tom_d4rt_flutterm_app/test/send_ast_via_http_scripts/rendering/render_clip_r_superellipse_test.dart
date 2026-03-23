// ignore_for_file: avoid_print
// Deep demo: RenderClipRSuperellipse / ClipRSuperellipse
// Demonstrates smooth superellipse clipping (iOS-style continuous corners)
// compared to standard ClipRRect rounded rectangles.

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RenderClipRSuperellipse Deep Demo ===');
  print('Building superellipse clipping showcase...');

  return SingleChildScrollView(
    child: Container(
      color: Color(0xFFF5F5F5),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: 24.0),

          // Section 1: Different border radii
          _buildSectionTitle(
            '1. ClipRSuperellipse with Different Border Radii',
          ),
          SizedBox(height: 12.0),
          _buildRadiiShowcase(),
          SizedBox(height: 32.0),

          // Section 2: Superellipse vs RRect comparison
          _buildSectionTitle('2. ClipRSuperellipse vs ClipRRect Comparison'),
          SizedBox(height: 12.0),
          _buildComparisonSection(),
          SizedBox(height: 32.0),

          // Section 3: Clip behaviors
          _buildSectionTitle(
            '3. ClipRSuperellipse with Different clipBehavior',
          ),
          SizedBox(height: 12.0),
          _buildClipBehaviorSection(),
          SizedBox(height: 32.0),

          // Section 4: Clipping gradients and patterns
          _buildSectionTitle('4. Clipping Gradients and Patterns'),
          SizedBox(height: 12.0),
          _buildGradientPatternSection(),
          SizedBox(height: 32.0),

          // Section 5: Asymmetric border radii
          _buildSectionTitle('5. Asymmetric Border Radii'),
          SizedBox(height: 12.0),
          _buildAsymmetricSection(),
          SizedBox(height: 32.0),

          // Section 6: Nested ClipRSuperellipse
          _buildSectionTitle('6. Nested ClipRSuperellipse'),
          SizedBox(height: 12.0),
          _buildNestedSection(),
          SizedBox(height: 32.0),

          // Section 7: Comparison with ClipOval and ClipRect
          _buildSectionTitle('7. Comparison: Superellipse vs Oval vs Rect'),
          SizedBox(height: 12.0),
          _buildClipTypeComparison(),
          SizedBox(height: 32.0),

          // Section 8: Complex compositions
          _buildSectionTitle('8. Complex Compositions'),
          SizedBox(height: 12.0),
          _buildComplexCompositions(),
          SizedBox(height: 32.0),

          _buildFooter(),
        ],
      ),
    ),
  );
}

Widget _buildHeader() {
  print('[Header] Building main header');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA), Color(0xFFAB47BC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'RenderClipRSuperellipse Demo',
          style: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Smooth superellipse clipping with iOS-style continuous corners',
          style: TextStyle(fontSize: 14.0, color: Color(0xDDFFFFFF)),
        ),
        SizedBox(height: 4.0),
        Text(
          'ClipRSuperellipse produces smoother corner curves than ClipRRect',
          style: TextStyle(fontSize: 12.0, color: Color(0xAAFFFFFF)),
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title) {
  print('[Section] $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF7B1FA2), Color(0xFFCE93D8)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
  );
}

// Section 1: Different border radii
Widget _buildRadiiShowcase() {
  print('[Radii] Building border radii showcase');
  List<double> radii = [0.0, 8.0, 16.0, 24.0, 32.0, 48.0];
  List<Widget> items = [];

  for (int i = 0; i < radii.length; i++) {
    double r = radii[i];
    print('[Radii] Creating sample with radius=$r');
    items.add(
      Column(
        children: [
          ClipRSuperellipse(
            borderRadius: BorderRadius.circular(r),
            child: Container(
              width: 90.0,
              height: 90.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF42A5F5), Color(0xFF1565C0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Icon(Icons.star, color: Colors.white, size: 32.0),
              ),
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'r=${r.toStringAsFixed(0)}',
            style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  return Wrap(spacing: 12.0, runSpacing: 12.0, children: items);
}

// Section 2: Side-by-side comparison
Widget _buildComparisonSection() {
  print('[Compare] Building superellipse vs rrect comparison');
  List<double> compareRadii = [16.0, 24.0, 32.0, 48.0];
  List<Widget> rows = [];

  for (int i = 0; i < compareRadii.length; i++) {
    double r = compareRadii[i];
    print('[Compare] Radius=$r - superellipse vs rrect');
    rows.add(
      Padding(
        padding: EdgeInsets.only(bottom: 12.0),
        child: Row(
          children: [
            // Superellipse
            Column(
              children: [
                ClipRSuperellipse(
                  borderRadius: BorderRadius.circular(r),
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    color: Color(0xFFE91E63),
                    child: Center(
                      child: Text(
                        'Super',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4.0),
                Text('Superellipse r=$r', style: TextStyle(fontSize: 10.0)),
              ],
            ),
            SizedBox(width: 20.0),
            // Standard RRect
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(r),
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    color: Color(0xFF3F51B5),
                    child: Center(
                      child: Text(
                        'RRect',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4.0),
                Text('ClipRRect r=$r', style: TextStyle(fontSize: 10.0)),
              ],
            ),
            SizedBox(width: 20.0),
            // Info
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xFFE8EAF6),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Notice the smoother, more continuous corner transition on the superellipse (left) vs the standard rounded rect (right).',
                  style: TextStyle(fontSize: 10.0, color: Color(0xFF283593)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Column(children: rows);
}

// Section 3: Clip behaviors
Widget _buildClipBehaviorSection() {
  print('[ClipBehavior] Building clip behavior showcase');

  List<Map<String, dynamic>> behaviors = [
    {'clip': Clip.none, 'label': 'Clip.none'},
    {'clip': Clip.hardEdge, 'label': 'Clip.hardEdge'},
    {'clip': Clip.antiAlias, 'label': 'Clip.antiAlias'},
    {
      'clip': Clip.antiAliasWithSaveLayer,
      'label': 'Clip.antiAliasWithSaveLayer',
    },
  ];

  List<Widget> items = [];
  for (int i = 0; i < behaviors.length; i++) {
    Clip clipValue = behaviors[i]['clip'];
    String label = behaviors[i]['label'];
    print('[ClipBehavior] Creating sample: $label');

    items.add(
      Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFBDBDBD), width: 1.0),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: ClipRSuperellipse(
              borderRadius: BorderRadius.circular(28.0),
              clipBehavior: clipValue,
              child: Container(
                width: 110.0,
                height: 110.0,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [Color(0xFFFF9800), Color(0xFFE65100)],
                    center: Alignment.topLeft,
                    radius: 1.5,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.auto_awesome,
                    color: Colors.white,
                    size: 36.0,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            label,
            style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  return Wrap(spacing: 16.0, runSpacing: 12.0, children: items);
}

// Section 4: Gradients and patterns
Widget _buildGradientPatternSection() {
  print('[Gradients] Building gradient and pattern clipping section');

  return Wrap(
    spacing: 14.0,
    runSpacing: 14.0,
    children: [
      // Linear gradient
      _buildGradientCard(
        'Linear',
        LinearGradient(
          colors: [Color(0xFFE040FB), Color(0xFF7C4DFF), Color(0xFF448AFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      // Radial gradient
      _buildGradientCard(
        'Radial',
        RadialGradient(
          colors: [Color(0xFFFFEB3B), Color(0xFFFF9800), Color(0xFFF44336)],
          center: Alignment.center,
          radius: 0.8,
        ),
      ),
      // Sweep gradient
      _buildGradientCard(
        'Sweep',
        SweepGradient(
          colors: [
            Color(0xFFF44336),
            Color(0xFFFF9800),
            Color(0xFFFFEB3B),
            Color(0xFF4CAF50),
            Color(0xFF2196F3),
            Color(0xFF9C27B0),
            Color(0xFFF44336),
          ],
          center: Alignment.center,
        ),
      ),
      // Checkerboard pattern
      _buildPatternCard('Checker'),
      // Striped pattern
      _buildStripeCard('Stripes'),
      // Dotted pattern
      _buildDotCard('Dots'),
    ],
  );
}

Widget _buildGradientCard(String label, Gradient gradient) {
  print('[Gradients] Building gradient card: $label');
  return Column(
    children: [
      ClipRSuperellipse(
        borderRadius: BorderRadius.circular(24.0),
        child: Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(gradient: gradient),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                shadows: [Shadow(blurRadius: 4.0, color: Color(0x88000000))],
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 4.0),
      Text(label, style: TextStyle(fontSize: 10.0)),
    ],
  );
}

Widget _buildPatternCard(String label) {
  print('[Pattern] Building checkerboard pattern card');
  List<Widget> squares = [];
  for (int row = 0; row < 5; row++) {
    for (int col = 0; col < 5; col++) {
      bool isDark = (row + col) % 2 == 0;
      squares.add(
        Positioned(
          left: col * 20.0,
          top: row * 20.0,
          child: Container(
            width: 20.0,
            height: 20.0,
            color: isDark ? Color(0xFF4CAF50) : Color(0xFFC8E6C9),
          ),
        ),
      );
    }
  }

  return Column(
    children: [
      ClipRSuperellipse(
        borderRadius: BorderRadius.circular(24.0),
        child: Container(
          width: 100.0,
          height: 100.0,
          child: Stack(children: squares),
        ),
      ),
      SizedBox(height: 4.0),
      Text(label, style: TextStyle(fontSize: 10.0)),
    ],
  );
}

Widget _buildStripeCard(String label) {
  print('[Pattern] Building stripe pattern card');
  List<Widget> stripes = [];
  for (int i = 0; i < 10; i++) {
    stripes.add(
      Container(
        height: 10.0,
        color: i % 2 == 0 ? Color(0xFF1976D2) : Color(0xFFBBDEFB),
      ),
    );
  }

  return Column(
    children: [
      ClipRSuperellipse(
        borderRadius: BorderRadius.circular(24.0),
        child: Container(
          width: 100.0,
          height: 100.0,
          child: Column(children: stripes),
        ),
      ),
      SizedBox(height: 4.0),
      Text(label, style: TextStyle(fontSize: 10.0)),
    ],
  );
}

Widget _buildDotCard(String label) {
  print('[Pattern] Building dot pattern card');
  List<Widget> dots = [];
  for (int row = 0; row < 4; row++) {
    for (int col = 0; col < 4; col++) {
      dots.add(
        Positioned(
          left: 8.0 + col * 24.0,
          top: 8.0 + row * 24.0,
          child: Container(
            width: 12.0,
            height: 12.0,
            decoration: BoxDecoration(
              color: Color(0xFFFF5722),
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    }
  }

  return Column(
    children: [
      ClipRSuperellipse(
        borderRadius: BorderRadius.circular(24.0),
        child: Container(
          width: 100.0,
          height: 100.0,
          color: Color(0xFFFFF3E0),
          child: Stack(children: dots),
        ),
      ),
      SizedBox(height: 4.0),
      Text(label, style: TextStyle(fontSize: 10.0)),
    ],
  );
}

// Section 5: Asymmetric border radii
Widget _buildAsymmetricSection() {
  print('[Asymmetric] Building asymmetric border radii section');

  List<Map<String, dynamic>> configs = [
    {
      'label': 'Top only',
      'radius': BorderRadius.only(
        topLeft: Radius.circular(32.0),
        topRight: Radius.circular(32.0),
      ),
      'color': Color(0xFF00BCD4),
    },
    {
      'label': 'Bottom only',
      'radius': BorderRadius.only(
        bottomLeft: Radius.circular(32.0),
        bottomRight: Radius.circular(32.0),
      ),
      'color': Color(0xFF009688),
    },
    {
      'label': 'Left only',
      'radius': BorderRadius.only(
        topLeft: Radius.circular(32.0),
        bottomLeft: Radius.circular(32.0),
      ),
      'color': Color(0xFF795548),
    },
    {
      'label': 'Diagonal TL+BR',
      'radius': BorderRadius.only(
        topLeft: Radius.circular(40.0),
        bottomRight: Radius.circular(40.0),
      ),
      'color': Color(0xFF607D8B),
    },
    {
      'label': 'Mixed sizes',
      'radius': BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(24.0),
        bottomLeft: Radius.circular(40.0),
        bottomRight: Radius.circular(16.0),
      ),
      'color': Color(0xFF9C27B0),
    },
    {
      'label': 'Elliptical',
      'radius': BorderRadius.only(
        topLeft: Radius.elliptical(40.0, 20.0),
        topRight: Radius.elliptical(40.0, 20.0),
        bottomLeft: Radius.elliptical(40.0, 20.0),
        bottomRight: Radius.elliptical(40.0, 20.0),
      ),
      'color': Color(0xFFE91E63),
    },
  ];

  List<Widget> items = [];
  for (int i = 0; i < configs.length; i++) {
    String label = configs[i]['label'];
    BorderRadius radius = configs[i]['radius'];
    Color color = configs[i]['color'];
    print('[Asymmetric] Building: $label');

    items.add(
      Column(
        children: [
          ClipRSuperellipse(
            borderRadius: radius,
            child: Container(
              width: 100.0,
              height: 100.0,
              color: color,
              child: Center(
                child: Icon(Icons.crop_square, color: Colors.white, size: 28.0),
              ),
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            label,
            style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  return Wrap(spacing: 14.0, runSpacing: 14.0, children: items);
}

// Section 6: Nested ClipRSuperellipse
Widget _buildNestedSection() {
  print('[Nested] Building nested superellipse section');

  return Column(
    children: [
      // Nested concentric
      Row(
        children: [
          _buildNestedConcentric(),
          SizedBox(width: 20.0),
          _buildNestedOffset(),
          SizedBox(width: 20.0),
          _buildNestedTriple(),
        ],
      ),
      SizedBox(height: 16.0),
      // Nested with different radii
      Row(
        children: [
          _buildNestedDecreasing(),
          SizedBox(width: 20.0),
          _buildNestedWithContent(),
        ],
      ),
    ],
  );
}

Widget _buildNestedConcentric() {
  print('[Nested] Building concentric nested example');
  return Column(
    children: [
      ClipRSuperellipse(
        borderRadius: BorderRadius.circular(32.0),
        child: Container(
          width: 130.0,
          height: 130.0,
          color: Color(0xFF1565C0),
          child: Center(
            child: ClipRSuperellipse(
              borderRadius: BorderRadius.circular(24.0),
              child: Container(
                width: 90.0,
                height: 90.0,
                color: Color(0xFF42A5F5),
                child: Center(
                  child: Icon(Icons.layers, color: Colors.white, size: 32.0),
                ),
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 4.0),
      Text('Concentric', style: TextStyle(fontSize: 10.0)),
    ],
  );
}

Widget _buildNestedOffset() {
  print('[Nested] Building offset nested example');
  return Column(
    children: [
      ClipRSuperellipse(
        borderRadius: BorderRadius.circular(28.0),
        child: Container(
          width: 130.0,
          height: 130.0,
          color: Color(0xFFAD1457),
          child: Stack(
            children: [
              Positioned(
                right: 0.0,
                bottom: 0.0,
                child: ClipRSuperellipse(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    width: 80.0,
                    height: 80.0,
                    color: Color(0xFFF48FB1),
                    child: Center(
                      child: Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 28.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 4.0),
      Text('Offset', style: TextStyle(fontSize: 10.0)),
    ],
  );
}

Widget _buildNestedTriple() {
  print('[Nested] Building triple nested example');
  return Column(
    children: [
      ClipRSuperellipse(
        borderRadius: BorderRadius.circular(36.0),
        child: Container(
          width: 130.0,
          height: 130.0,
          color: Color(0xFF2E7D32),
          child: Center(
            child: ClipRSuperellipse(
              borderRadius: BorderRadius.circular(24.0),
              child: Container(
                width: 100.0,
                height: 100.0,
                color: Color(0xFF66BB6A),
                child: Center(
                  child: ClipRSuperellipse(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      color: Color(0xFFA5D6A7),
                      child: Center(
                        child: Icon(
                          Icons.eco,
                          color: Color(0xFF1B5E20),
                          size: 24.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 4.0),
      Text('Triple', style: TextStyle(fontSize: 10.0)),
    ],
  );
}

Widget _buildNestedDecreasing() {
  print('[Nested] Building decreasing radius nested example');
  return Column(
    children: [
      ClipRSuperellipse(
        borderRadius: BorderRadius.circular(40.0),
        child: Container(
          width: 140.0,
          height: 140.0,
          color: Color(0xFFFF6F00),
          padding: EdgeInsets.all(12.0),
          child: ClipRSuperellipse(
            borderRadius: BorderRadius.circular(28.0),
            child: Container(
              color: Color(0xFFFFCA28),
              padding: EdgeInsets.all(10.0),
              child: ClipRSuperellipse(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  color: Color(0xFFFFF9C4),
                  child: Center(
                    child: Icon(
                      Icons.wb_sunny,
                      color: Color(0xFFFF6F00),
                      size: 30.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 4.0),
      Text('Decreasing radii', style: TextStyle(fontSize: 10.0)),
    ],
  );
}

Widget _buildNestedWithContent() {
  print('[Nested] Building nested with rich content');
  return Column(
    children: [
      ClipRSuperellipse(
        borderRadius: BorderRadius.circular(32.0),
        child: Container(
          width: 160.0,
          height: 140.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4A148C), Color(0xFF7B1FA2)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRSuperellipse(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  width: 120.0,
                  height: 40.0,
                  color: Color(0xCCFFFFFF),
                  child: Center(
                    child: Text(
                      'Header',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              ClipRSuperellipse(
                borderRadius: BorderRadius.circular(12.0),
                child: Container(
                  width: 120.0,
                  height: 40.0,
                  color: Color(0x88FFFFFF),
                  child: Center(
                    child: Text(
                      'Content',
                      style: TextStyle(color: Colors.white, fontSize: 11.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 4.0),
      Text('Rich content', style: TextStyle(fontSize: 10.0)),
    ],
  );
}

// Section 7: Clip type comparison
Widget _buildClipTypeComparison() {
  print('[ClipTypes] Building clip type comparison');

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      // ClipRSuperellipse
      Column(
        children: [
          ClipRSuperellipse(
            borderRadius: BorderRadius.circular(28.0),
            child: Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE91E63), Color(0xFFF44336)],
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.rounded_corner,
                  color: Colors.white,
                  size: 32.0,
                ),
              ),
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Superellipse',
            style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600),
          ),
          Text(
            'Smooth corners',
            style: TextStyle(fontSize: 9.0, color: Color(0xFF757575)),
          ),
        ],
      ),
      // ClipRRect
      Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(28.0),
            child: Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
                ),
              ),
              child: Center(
                child: Icon(Icons.crop_square, color: Colors.white, size: 32.0),
              ),
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'RRect',
            style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600),
          ),
          Text(
            'Standard corners',
            style: TextStyle(fontSize: 9.0, color: Color(0xFF757575)),
          ),
        ],
      ),
      // ClipOval
      Column(
        children: [
          ClipOval(
            child: Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4CAF50), Color(0xFF388E3C)],
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.circle_outlined,
                  color: Colors.white,
                  size: 32.0,
                ),
              ),
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Oval',
            style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600),
          ),
          Text(
            'Elliptical clip',
            style: TextStyle(fontSize: 9.0, color: Color(0xFF757575)),
          ),
        ],
      ),
      // ClipRect
      Column(
        children: [
          ClipRect(
            child: Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFF9800), Color(0xFFF57C00)],
                ),
              ),
              child: Center(
                child: Icon(Icons.crop_din, color: Colors.white, size: 32.0),
              ),
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Rect',
            style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600),
          ),
          Text(
            'Sharp corners',
            style: TextStyle(fontSize: 9.0, color: Color(0xFF757575)),
          ),
        ],
      ),
    ],
  );
}

// Section 8: Complex compositions
Widget _buildComplexCompositions() {
  print('[Complex] Building complex composition section');

  return Column(
    children: [
      // Card-like layout
      _buildCardComposition(),
      SizedBox(height: 16.0),
      // Grid composition
      _buildGridComposition(),
      SizedBox(height: 16.0),
      // Badge composition
      _buildBadgeComposition(),
    ],
  );
}

Widget _buildCardComposition() {
  print('[Complex] Building card composition');
  return ClipRSuperellipse(
    borderRadius: BorderRadius.circular(24.0),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image area
          Container(
            width: double.infinity,
            height: 120.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0D47A1),
                  Color(0xFF42A5F5),
                  Color(0xFF90CAF9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 16.0,
                  top: 16.0,
                  child: ClipRSuperellipse(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 4.0,
                      ),
                      color: Color(0xCCFFFFFF),
                      child: Text(
                        'Featured',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 16.0,
                  bottom: 16.0,
                  child: Text(
                    'Superellipse Card',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(blurRadius: 6.0, color: Color(0x66000000)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content area
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'iOS-style continuous corner clipping for cards',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8.0),
                Text(
                  'ClipRSuperellipse produces smoother corner transitions '
                  'compared to standard rounded rectangles, matching the '
                  'aesthetic used in iOS and modern design systems.',
                  style: TextStyle(fontSize: 12.0, color: Color(0xFF616161)),
                ),
                SizedBox(height: 12.0),
                Row(
                  children: [
                    ClipRSuperellipse(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 6.0,
                        ),
                        color: Color(0xFF1565C0),
                        child: Text(
                          'Action',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    ClipRSuperellipse(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 6.0,
                        ),
                        color: Color(0xFFE3F2FD),
                        child: Text(
                          'Details',
                          style: TextStyle(
                            color: Color(0xFF1565C0),
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildGridComposition() {
  print('[Complex] Building grid composition');
  List<Map<String, dynamic>> gridItems = [
    {'icon': Icons.music_note, 'color': Color(0xFFE91E63), 'label': 'Music'},
    {'icon': Icons.photo_camera, 'color': Color(0xFF9C27B0), 'label': 'Photos'},
    {'icon': Icons.videocam, 'color': Color(0xFF3F51B5), 'label': 'Videos'},
    {'icon': Icons.map, 'color': Color(0xFF00BCD4), 'label': 'Maps'},
    {'icon': Icons.settings, 'color': Color(0xFF607D8B), 'label': 'Settings'},
    {'icon': Icons.mail, 'color': Color(0xFF4CAF50), 'label': 'Mail'},
  ];

  List<Widget> items = [];
  for (int i = 0; i < gridItems.length; i++) {
    print('[Complex] Grid item: ${gridItems[i]['label']}');
    items.add(
      Column(
        children: [
          ClipRSuperellipse(
            borderRadius: BorderRadius.circular(18.0),
            child: Container(
              width: 64.0,
              height: 64.0,
              color: gridItems[i]['color'],
              child: Center(
                child: Icon(
                  gridItems[i]['icon'],
                  color: Colors.white,
                  size: 28.0,
                ),
              ),
            ),
          ),
          SizedBox(height: 4.0),
          Text(gridItems[i]['label'], style: TextStyle(fontSize: 10.0)),
        ],
      ),
    );
  }

  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFEEEEEE),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'iOS-style App Grid (Superellipse Icons)',
          style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 12.0),
        Wrap(spacing: 20.0, runSpacing: 12.0, children: items),
      ],
    ),
  );
}

Widget _buildBadgeComposition() {
  print('[Complex] Building badge composition');
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildBadge('Pro', Color(0xFFFF6F00), Color(0xFFFFCA28)),
      _buildBadge('New', Color(0xFF1B5E20), Color(0xFF66BB6A)),
      _buildBadge('Hot', Color(0xFFB71C1C), Color(0xFFEF5350)),
      _buildBadge('Top', Color(0xFF0D47A1), Color(0xFF42A5F5)),
      _buildBadge('VIP', Color(0xFF4A148C), Color(0xFFAB47BC)),
    ],
  );
}

Widget _buildBadge(String text, Color dark, Color light) {
  print('[Complex] Building badge: $text');
  return ClipRSuperellipse(
    borderRadius: BorderRadius.circular(16.0),
    child: Container(
      width: 56.0,
      height: 56.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [dark, light],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
      ),
    ),
  );
}

Widget _buildFooter() {
  print('[Footer] Building footer');
  print('=== RenderClipRSuperellipse Demo Complete ===');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        Text(
          'End of RenderClipRSuperellipse Demo',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Color(0xFF283593),
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'ClipRSuperellipse provides iOS-style continuous corner clipping '
          'for smoother, more natural rounded shapes.',
          style: TextStyle(fontSize: 11.0, color: Color(0xFF5C6BC0)),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
