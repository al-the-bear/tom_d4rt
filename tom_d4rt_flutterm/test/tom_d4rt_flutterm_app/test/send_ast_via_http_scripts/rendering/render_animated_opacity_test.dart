// Deep demo: RenderAnimatedOpacity via AnimatedOpacity and FadeTransition
// RenderAnimatedOpacity efficiently animates the opacity of its child
// by avoiding repainting the child when only the opacity changes.
// Widget-level wrappers: AnimatedOpacity, FadeTransition

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

Widget _buildHeader(String title, String subtitle) {
  print('[header] Building header: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1A237E), Color(0xFF283593)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      children: [
        Icon(Icons.opacity, size: 48, color: Colors.white),
        SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withAlpha(200),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title, IconData icon) {
  print('[section] $title');
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFF283593).withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Color(0xFF1A237E), size: 20),
        ),
        SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A237E),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoCard(String label, String description, IconData icon) {
  print('[info] $label: $description');
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Row(
      children: [
        Icon(icon, color: Color(0xFF5C6BC0), size: 22),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xFF1A237E),
                ),
              ),
              SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Color(0xFF616161)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Builds a single opacity swatch with a label and visual content
Widget _buildOpacitySwatch(double opacity, Color color, String label) {
  print('[swatch] opacity=$opacity label=$label');
  return Column(
    children: [
      AnimatedOpacity(
        opacity: opacity,
        duration: Duration(milliseconds: 500),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: color.withAlpha(80),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '${(opacity * 100).toInt()}%',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 6),
      Text(
        label,
        style: TextStyle(fontSize: 10, color: Color(0xFF757575)),
      ),
    ],
  );
}

// Builds an opacity comparison row showing same content at varying opacities
Widget _buildOpacityComparisonRow(String contentLabel, Widget child) {
  print('[comparison] Building comparison row for: $contentLabel');
  List<double> opacities = [0.0, 0.25, 0.5, 0.75, 1.0];
  List<Widget> items = [];
  for (int i = 0; i < opacities.length; i++) {
    double op = opacities[i];
    print('[comparison] Adding item at opacity $op');
    items.add(
      Expanded(
        child: Column(
          children: [
            AnimatedOpacity(
              opacity: op,
              duration: Duration(milliseconds: 400),
              child: child,
            ),
            SizedBox(height: 4),
            Text(
              op.toString(),
              style: TextStyle(fontSize: 10, color: Color(0xFF9E9E9E)),
            ),
          ],
        ),
      ),
    );
  }
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0xFFE8EAF6)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contentLabel,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF3949AB),
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: items,
        ),
      ],
    ),
  );
}

// Builds a gradient container used as opacity target
Widget _buildGradientBox(List<Color> colors, double size) {
  print('[gradient] Building gradient box size=$size');
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: colors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

// Builds a layered stack where semi-transparent elements overlap
Widget _buildLayeredOverlap() {
  print('[layered] Building layered overlap section');
  return Container(
    height: 200,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        // Background pattern
        Positioned(
          left: 20,
          top: 20,
          child: AnimatedOpacity(
            opacity: 0.9,
            duration: Duration(milliseconds: 300),
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE53935), Color(0xFFEF5350)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'Back Layer\n0.9',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        // Middle layer
        Positioned(
          left: 80,
          top: 40,
          child: AnimatedOpacity(
            opacity: 0.6,
            duration: Duration(milliseconds: 300),
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'Mid Layer\n0.6',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        // Front layer
        Positioned(
          right: 20,
          bottom: 10,
          child: AnimatedOpacity(
            opacity: 0.35,
            duration: Duration(milliseconds: 300),
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF43A047), Color(0xFF66BB6A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'Front Layer\n0.35',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// Builds a visual opacity scale/gradient bar
Widget _buildOpacityScale() {
  print('[scale] Building visual opacity scale');
  List<Widget> bars = [];
  for (int i = 0; i <= 20; i++) {
    double opacity = i / 20.0;
    print('[scale] bar segment opacity=$opacity');
    bars.add(
      Expanded(
        child: AnimatedOpacity(
          opacity: opacity,
          duration: Duration(milliseconds: 200),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xFF1A237E),
            ),
          ),
        ),
      ),
    );
  }
  return Column(
    children: [
      Container(
        height: 50,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(children: bars),
      ),
      SizedBox(height: 6),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('0%', style: TextStyle(fontSize: 10, color: Color(0xFF9E9E9E))),
          Text('25%', style: TextStyle(fontSize: 10, color: Color(0xFF9E9E9E))),
          Text('50%', style: TextStyle(fontSize: 10, color: Color(0xFF9E9E9E))),
          Text('75%', style: TextStyle(fontSize: 10, color: Color(0xFF9E9E9E))),
          Text('100%', style: TextStyle(fontSize: 10, color: Color(0xFF9E9E9E))),
        ],
      ),
    ],
  );
}

// Builds a FadeTransition demonstration card
Widget _buildFadeTransitionCard(
  String title,
  String description,
  double opacity,
  Widget content,
) {
  print('[fade-transition] $title at opacity $opacity');
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE8EAF6)),
      boxShadow: [
        BoxShadow(
          color: Color(0x0F000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF1A237E),
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Color(0xFF283593).withAlpha(25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'opacity: $opacity',
                style: TextStyle(fontSize: 11, color: Color(0xFF3949AB)),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
        ),
        SizedBox(height: 10),
        Center(
          child: AnimatedOpacity(
            opacity: opacity,
            duration: Duration(milliseconds: 600),
            child: content,
          ),
        ),
      ],
    ),
  );
}

// Builds different content types to demonstrate opacity on various visuals
Widget _buildContentTypeDemo(String label, IconData icon, Color color) {
  print('[content-type] $label');
  return Container(
    width: 80,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 28),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 10, color: color),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('[build] RenderAnimatedOpacity deep demo starting');
  print('[build] AnimatedOpacity wraps RenderAnimatedOpacity at the render layer');
  print('[build] FadeTransition also uses RenderAnimatedOpacity internally');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        _buildHeader(
          'RenderAnimatedOpacity',
          'Efficient opacity animation at the render layer.\n'
              'Widget wrappers: AnimatedOpacity & FadeTransition',
        ),
        SizedBox(height: 16),

        // Info cards
        _buildInfoCard(
          'RenderAnimatedOpacity',
          'A render object that animates opacity without repainting children',
          Icons.animation,
        ),
        _buildInfoCard(
          'AnimatedOpacity',
          'Implicit animation widget — automatically animates when opacity changes',
          Icons.auto_awesome,
        ),
        _buildInfoCard(
          'FadeTransition',
          'Explicit animation widget — driven by an Animation<double> controller',
          Icons.swap_horiz,
        ),

        SizedBox(height: 8),

        // Section 1: Opacity values side by side
        _buildSectionTitle('Opacity Values Comparison', Icons.compare),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFE8EAF6)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildOpacitySwatch(0.0, Color(0xFF1A237E), 'Invisible'),
              _buildOpacitySwatch(0.25, Color(0xFF283593), 'Faint'),
              _buildOpacitySwatch(0.5, Color(0xFF3949AB), 'Half'),
              _buildOpacitySwatch(0.75, Color(0xFF5C6BC0), 'Visible'),
              _buildOpacitySwatch(1.0, Color(0xFF7986CB), 'Full'),
            ],
          ),
        ),

        SizedBox(height: 16),

        // Section 2: Opacity on different content types
        _buildSectionTitle('Opacity on Content Types', Icons.category),

        // Text at various opacities
        _buildOpacityComparisonRow(
          'Text Content',
          Text(
            'Hello',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A237E),
            ),
          ),
        ),

        // Icons at various opacities
        _buildOpacityComparisonRow(
          'Icon Content',
          Icon(Icons.star, size: 32, color: Color(0xFFFFA000)),
        ),

        // Image placeholder at various opacities
        _buildOpacityComparisonRow(
          'Image Placeholder',
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFF8D6E63),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.image, color: Colors.white, size: 20),
          ),
        ),

        // Gradient containers at various opacities
        _buildOpacityComparisonRow(
          'Gradient Container',
          _buildGradientBox(
            [Color(0xFFE91E63), Color(0xFFFF5252)],
            40.0,
          ),
        ),

        SizedBox(height: 16),

        // Section 3: FadeTransition examples
        _buildSectionTitle('FadeTransition Examples', Icons.swap_horiz),

        _buildFadeTransitionCard(
          'Fully Visible',
          'FadeTransition with animation value 1.0',
          1.0,
          Container(
            width: 120,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF7B1FA2), Color(0xFFAB47BC)],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Fade 1.0',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),

        _buildFadeTransitionCard(
          'Three Quarters',
          'FadeTransition with animation value 0.75',
          0.75,
          Container(
            width: 120,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00897B), Color(0xFF4DB6AC)],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Fade 0.75',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),

        _buildFadeTransitionCard(
          'Half Opacity',
          'FadeTransition with animation value 0.5',
          0.5,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.visibility, color: Color(0xFF1565C0), size: 28),
              SizedBox(width: 8),
              Text(
                'Semi-visible',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1565C0),
                ),
              ),
            ],
          ),
        ),

        _buildFadeTransitionCard(
          'Nearly Invisible',
          'FadeTransition with animation value 0.1',
          0.1,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xFFFF6F00),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Almost gone',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        SizedBox(height: 16),

        // Section 4: Layered overlapping elements
        _buildSectionTitle('Layered Overlapping Elements', Icons.layers),
        _buildLayeredOverlap(),

        SizedBox(height: 16),

        // Section 5: Visual opacity scale
        _buildSectionTitle('Opacity Scale / Gradient', Icons.gradient),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFE8EAF6)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Continuous Opacity Gradient',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xFF1A237E),
                ),
              ),
              SizedBox(height: 4),
              Text(
                '21 steps from fully transparent (0%) to fully opaque (100%)',
                style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
              ),
              SizedBox(height: 12),
              _buildOpacityScale(),
            ],
          ),
        ),

        SizedBox(height: 16),

        // Section 6: Content type specific demos
        _buildSectionTitle('Content Type Gallery', Icons.grid_view),

        // Row of content types at full opacity
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFE8EAF6)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Full Opacity (1.0)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color(0xFF1A237E),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildContentTypeDemo('Text', Icons.text_fields, Color(0xFF1565C0)),
                  _buildContentTypeDemo('Icon', Icons.emoji_emotions, Color(0xFFEF6C00)),
                  _buildContentTypeDemo('Shape', Icons.crop_square, Color(0xFF2E7D32)),
                  _buildContentTypeDemo('Image', Icons.photo, Color(0xFF6A1B9A)),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 10),

        // Same row at half opacity
        AnimatedOpacity(
          opacity: 0.5,
          duration: Duration(milliseconds: 500),
          child: Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFE8EAF6)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Half Opacity (0.5)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color(0xFF1A237E),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildContentTypeDemo('Text', Icons.text_fields, Color(0xFF1565C0)),
                    _buildContentTypeDemo('Icon', Icons.emoji_emotions, Color(0xFFEF6C00)),
                    _buildContentTypeDemo('Shape', Icons.crop_square, Color(0xFF2E7D32)),
                    _buildContentTypeDemo('Image', Icons.photo, Color(0xFF6A1B9A)),
                  ],
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 10),

        // Same row at low opacity
        AnimatedOpacity(
          opacity: 0.15,
          duration: Duration(milliseconds: 500),
          child: Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFE8EAF6)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Near Invisible (0.15)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color(0xFF1A237E),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildContentTypeDemo('Text', Icons.text_fields, Color(0xFF1565C0)),
                    _buildContentTypeDemo('Icon', Icons.emoji_emotions, Color(0xFFEF6C00)),
                    _buildContentTypeDemo('Shape', Icons.crop_square, Color(0xFF2E7D32)),
                    _buildContentTypeDemo('Image', Icons.photo, Color(0xFF6A1B9A)),
                  ],
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 16),

        // Section 7: Practical use cases
        _buildSectionTitle('Practical Use Cases', Icons.lightbulb_outline),

        // Disabled button effect
        Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFE8EAF6)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Disabled State Pattern',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xFF1A237E),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Use opacity to indicate enabled/disabled states',
                style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      AnimatedOpacity(
                        opacity: 1.0,
                        duration: Duration(milliseconds: 300),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFF1A237E),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Enabled',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      Text('1.0', style: TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
                    ],
                  ),
                  Column(
                    children: [
                      AnimatedOpacity(
                        opacity: 0.4,
                        duration: Duration(milliseconds: 300),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFF1A237E),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Disabled',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      Text('0.4', style: TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        // Loading placeholder effect
        Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFE8EAF6)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Loading Placeholder Pattern',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xFF1A237E),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Shimmer-like effect using opacity on placeholder content',
                style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
              ),
              SizedBox(height: 12),
              AnimatedOpacity(
                opacity: 0.3,
                duration: Duration(milliseconds: 800),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 16,
                      margin: EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Color(0xFFBDBDBD),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 16,
                      margin: EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Color(0xFFBDBDBD),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Color(0xFFBDBDBD),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Watermark overlay effect
        Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFE8EAF6)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Watermark Overlay Pattern',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xFF1A237E),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Semi-transparent text overlaid on content',
                style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
              ),
              SizedBox(height: 12),
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0D47A1), Color(0xFF1976D2), Color(0xFF42A5F5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        'Main Content',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Center(
                      child: AnimatedOpacity(
                        opacity: 0.15,
                        duration: Duration(milliseconds: 300),
                        child: Transform.rotate(
                          angle: -0.3,
                          child: Text(
                            'DRAFT',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 8,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 16),

        // Footer summary
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFE8EAF6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.check_circle, color: Color(0xFF1A237E), size: 32),
              SizedBox(height: 8),
              Text(
                'RenderAnimatedOpacity Demo Complete',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Demonstrated: opacity values, content types, FadeTransition,\n'
                    'layered overlaps, opacity scale, and practical patterns',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Color(0xFF5C6BC0)),
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
      ],
    ),
  );
}
