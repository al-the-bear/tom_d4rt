// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// Deep demo: RenderAnimatedSize / AnimatedSize widget
// Tests AnimatedSize with various durations, curves, alignments,
// clip behaviors, nesting, and reverseDuration configurations.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

Widget _buildHeader(String title, String subtitle) {
  print('Building header: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 28, horizontal: 20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA), Color(0xFFAB47BC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
      boxShadow: [
        BoxShadow(
          color: Color(0x406A1B9A),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 6),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xCCFFFFFF),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(IconData icon, String title) {
  print('Building section: $title');
  return Padding(
    padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 12),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0x1A6A1B9A),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Color(0xFF6A1B9A), size: 22),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF311B92),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCard(Widget child) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: child,
  );
}

Widget _buildLabel(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Color(0xFF616161),
      ),
    ),
  );
}

Widget _buildColorBox(Color color, double width, double height) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
  );
}

// Section 1: Different child content with various sizes
Widget _buildVariousSizesSection() {
  print('Section 1: AnimatedSize with various child sizes');

  Widget sizeDemo(String label, double w, double h, Color color) {
    print('  Size demo: $label (${w}x$h)');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        AnimatedSize(
          duration: Duration(milliseconds: 600),
          child: _buildColorBox(color, w, h),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sizeDemo('Small child (60x40)', 60, 40, Color(0xFFE1BEE7)),
        sizeDemo('Medium child (140x80)', 140, 80, Color(0xFFCE93D8)),
        sizeDemo('Wide child (250x50)', 250, 50, Color(0xFFBA68C8)),
        sizeDemo('Tall child (80x160)', 80, 160, Color(0xFFAB47BC)),
        sizeDemo('Large child (200x120)', 200, 120, Color(0xFF9C27B0)),
      ],
    ),
  );
}

// Section 2: Different durations
Widget _buildDurationsSection() {
  print('Section 2: AnimatedSize with different durations');

  Widget durationDemo(String label, int ms, Color color) {
    print('  Duration demo: $label ($ms ms)');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        AnimatedSize(
          duration: Duration(milliseconds: ms),
          child: Container(
            width: 180,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '${ms}ms',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        durationDemo('Ultra fast (100ms)', 100, Color(0xFFD32F2F)),
        durationDemo('Fast (300ms)', 300, Color(0xFFE64A19)),
        durationDemo('Medium (500ms)', 500, Color(0xFFF57C00)),
        durationDemo('Slow (1000ms)', 1000, Color(0xFFFFA000)),
        durationDemo('Very slow (2000ms)', 2000, Color(0xFFFFCA28)),
      ],
    ),
  );
}

// Section 3: Different Curve values
Widget _buildCurvesSection() {
  print('Section 3: AnimatedSize with different Curve values');

  Widget curveDemo(String label, Curve curve, Color color) {
    print('  Curve demo: $label');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        AnimatedSize(
          duration: Duration(milliseconds: 800),
          curve: curve,
          child: Container(
            width: 160,
            height: 55,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withOpacity(0.6)],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        curveDemo('Curves.linear', Curves.linear, Color(0xFF1565C0)),
        curveDemo('Curves.easeIn', Curves.easeIn, Color(0xFF0277BD)),
        curveDemo('Curves.easeOut', Curves.easeOut, Color(0xFF00838F)),
        curveDemo('Curves.bounceOut', Curves.bounceOut, Color(0xFF00695C)),
        curveDemo('Curves.elasticOut', Curves.elasticOut, Color(0xFF2E7D32)),
      ],
    ),
  );
}

// Section 4: Different Alignment values
Widget _buildAlignmentSection() {
  print('Section 4: AnimatedSize with different Alignment values');

  Widget alignDemo(String label, Alignment alignment, Color color) {
    print('  Alignment demo: $label');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFBDBDBD)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: AnimatedSize(
            duration: Duration(milliseconds: 700),
            alignment: alignment,
            child: Container(
              width: 120,
              height: 50,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        alignDemo('topLeft', Alignment.topLeft, Color(0xFFE91E63)),
        alignDemo('topCenter', Alignment.topCenter, Color(0xFFC2185B)),
        alignDemo('center', Alignment.center, Color(0xFF880E4F)),
        alignDemo('bottomRight', Alignment.bottomRight, Color(0xFFAD1457)),
        alignDemo('centerLeft', Alignment.centerLeft, Color(0xFFD81B60)),
      ],
    ),
  );
}

// Section 5: clipBehavior options
Widget _buildClipBehaviorSection() {
  print('Section 5: AnimatedSize with clipBehavior options');

  Widget clipDemo(String label, Clip clipBehavior, Color color) {
    print('  ClipBehavior demo: $label');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFE0E0E0)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: AnimatedSize(
            duration: Duration(milliseconds: 600),
            clipBehavior: clipBehavior,
            child: Container(
              width: 180,
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withOpacity(0.5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  label.replaceAll('Clip.', ''),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        clipDemo('Clip.none', Clip.none, Color(0xFF5D4037)),
        clipDemo('Clip.hardEdge', Clip.hardEdge, Color(0xFF4E342E)),
        clipDemo('Clip.antiAlias', Clip.antiAlias, Color(0xFF6D4C41)),
        clipDemo('Clip.antiAliasWithSaveLayer', Clip.antiAliasWithSaveLayer, Color(0xFF795548)),
      ],
    ),
  );
}

// Section 6: Nested AnimatedSize containers
Widget _buildNestedSection() {
  print('Section 6: Nested AnimatedSize containers');

  Widget nestedExample(String label, Color outerColor, Color innerColor, double outerW, double outerH, double innerW, double innerH) {
    print('  Nested demo: $label');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        AnimatedSize(
          duration: Duration(milliseconds: 800),
          curve: Curves.easeInOut,
          child: Container(
            width: outerW,
            height: outerH,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: outerColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: outerColor.withOpacity(0.3),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: AnimatedSize(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOut,
              child: Container(
                width: innerW,
                height: innerH,
                decoration: BoxDecoration(
                  color: innerColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Inner',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }

  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        nestedExample('Small in Large', Color(0xFF1A237E), Color(0xFF3F51B5), 220, 140, 80, 50),
        nestedExample('Medium in Medium', Color(0xFF004D40), Color(0xFF009688), 180, 120, 100, 60),
        nestedExample('Large in Slim', Color(0xFFBF360C), Color(0xFFFF5722), 250, 90, 160, 40),
        nestedExample('Triple nest simulation', Color(0xFF4A148C), Color(0xFF7B1FA2), 200, 150, 120, 80),
      ],
    ),
  );
}

// Section 7: reverseDuration parameter
Widget _buildReverseDurationSection() {
  print('Section 7: AnimatedSize with reverseDuration parameter');

  Widget reverseDemo(String label, int forwardMs, int reverseMs, Color color) {
    print('  ReverseDuration demo: $label (forward=${forwardMs}ms, reverse=${reverseMs}ms)');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        AnimatedSize(
          duration: Duration(milliseconds: forwardMs),
          reverseDuration: Duration(milliseconds: reverseMs),
          curve: Curves.easeInOut,
          child: Container(
            width: 170,
            height: 65,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.35),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Fwd: ${forwardMs}ms',
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Rev: ${reverseMs}ms',
                    style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        reverseDemo('Fast forward, slow reverse', 200, 1000, Color(0xFF00796B)),
        reverseDemo('Slow forward, fast reverse', 1000, 200, Color(0xFF00695C)),
        reverseDemo('Equal durations', 500, 500, Color(0xFF004D40)),
        reverseDemo('Very fast both', 100, 100, Color(0xFF00897B)),
        reverseDemo('Very slow forward, instant reverse', 2000, 50, Color(0xFF26A69A)),
      ],
    ),
  );
}

// Section 8: Combined configurations
Widget _buildCombinedSection() {
  print('Section 8: Combined AnimatedSize configurations');

  Widget combinedExample(String label, int durationMs, Curve curve, Alignment alignment, Clip clip, Color color, double w, double h) {
    print('  Combined demo: $label');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        Container(
          width: double.infinity,
          height: h + 30,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFE0E0E0)),
            borderRadius: BorderRadius.circular(8),
            color: Color(0xFFFAFAFA),
          ),
          child: AnimatedSize(
            duration: Duration(milliseconds: durationMs),
            curve: curve,
            alignment: alignment,
            clipBehavior: clip,
            child: Container(
              width: w,
              height: h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withOpacity(0.65)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(Icons.auto_awesome, color: Colors.white, size: 24),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        combinedExample(
          'Bounce + topLeft + hardEdge',
          900, Curves.bounceOut, Alignment.topLeft, Clip.hardEdge,
          Color(0xFFFF6F00), 150, 70,
        ),
        combinedExample(
          'EaseIn + center + antiAlias',
          600, Curves.easeIn, Alignment.center, Clip.antiAlias,
          Color(0xFF6A1B9A), 180, 60,
        ),
        combinedExample(
          'Linear + bottomRight + none',
          400, Curves.linear, Alignment.bottomRight, Clip.none,
          Color(0xFF1B5E20), 130, 80,
        ),
        combinedExample(
          'ElasticOut + centerLeft + saveLayer',
          1200, Curves.elasticOut, Alignment.centerLeft, Clip.antiAliasWithSaveLayer,
          Color(0xFFC62828), 200, 55,
        ),
      ],
    ),
  );
}

// Section 9: AnimatedSize wrapping text content
Widget _buildTextContentSection() {
  print('Section 9: AnimatedSize wrapping text content');

  Widget textDemo(String label, String text, double maxWidth, Color bgColor) {
    print('  Text content demo: $label');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        AnimatedSize(
          duration: Duration(milliseconds: 700),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topLeft,
          child: Container(
            constraints: BoxConstraints(maxWidth: maxWidth),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textDemo(
          'Short text',
          'Hello!',
          200,
          Color(0xFF37474F),
        ),
        textDemo(
          'Medium text',
          'AnimatedSize smoothly transitions between different sizes.',
          250,
          Color(0xFF455A64),
        ),
        textDemo(
          'Long wrapped text',
          'RenderAnimatedSize is the render object behind AnimatedSize. It animates its size to match its child over a given duration and curve, providing smooth layout transitions.',
          280,
          Color(0xFF546E7A),
        ),
      ],
    ),
  );
}

// Section 10: AnimatedSize with icon and decoration variations
Widget _buildIconDecorationsSection() {
  print('Section 10: AnimatedSize with icon and decoration variations');

  Widget iconDemo(String label, IconData icon, double size, Color color, Color bgColor) {
    print('  Icon decoration demo: $label');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        AnimatedSize(
          duration: Duration(milliseconds: 550),
          curve: Curves.decelerate,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [bgColor.withOpacity(0.7), bgColor],
                radius: 1.2,
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: bgColor.withOpacity(0.3),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: size, color: color),
                SizedBox(width: 10),
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        iconDemo('Star icon', Icons.star, 28, Colors.white, Color(0xFFFF8F00)),
        iconDemo('Rocket icon', Icons.rocket_launch, 32, Colors.white, Color(0xFF1565C0)),
        iconDemo('Heart icon', Icons.favorite, 24, Colors.white, Color(0xFFD32F2F)),
        iconDemo('Lightning icon', Icons.flash_on, 30, Colors.white, Color(0xFFF9A825)),
        iconDemo('Leaf icon', Icons.eco, 26, Colors.white, Color(0xFF2E7D32)),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== RenderAnimatedSize / AnimatedSize Deep Demo ===');
  print('Building all sections...');

  return SingleChildScrollView(
    child: Container(
      color: Color(0xFFF3E5F5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(
            'RenderAnimatedSize Demo',
            'AnimatedSize widget — animates its size to match its child over time',
          ),

          // Section 1: Various child sizes
          _buildSectionTitle(Icons.aspect_ratio, '1. Various Child Sizes'),
          _buildVariousSizesSection(),

          // Section 2: Different durations
          _buildSectionTitle(Icons.timer, '2. Different Durations'),
          _buildDurationsSection(),

          // Section 3: Curve values
          _buildSectionTitle(Icons.show_chart, '3. Curve Values'),
          _buildCurvesSection(),

          // Section 4: Alignment values
          _buildSectionTitle(Icons.format_align_center, '4. Alignment Values'),
          _buildAlignmentSection(),

          // Section 5: clipBehavior options
          _buildSectionTitle(Icons.content_cut, '5. Clip Behavior Options'),
          _buildClipBehaviorSection(),

          // Section 6: Nested AnimatedSize
          _buildSectionTitle(Icons.layers, '6. Nested AnimatedSize'),
          _buildNestedSection(),

          // Section 7: reverseDuration
          _buildSectionTitle(Icons.swap_horiz, '7. Reverse Duration'),
          _buildReverseDurationSection(),

          // Section 8: Combined configurations
          _buildSectionTitle(Icons.tune, '8. Combined Configurations'),
          _buildCombinedSection(),

          // Section 9: Text content wrapping
          _buildSectionTitle(Icons.text_fields, '9. Text Content Wrapping'),
          _buildTextContentSection(),

          // Section 10: Icon and decoration variations
          _buildSectionTitle(Icons.palette, '10. Icons and Decorations'),
          _buildIconDecorationsSection(),

          // Footer
          SizedBox(height: 24),
          Center(
            child: Text(
              'End of RenderAnimatedSize Demo',
              style: TextStyle(
                color: Color(0xFF9E9E9E),
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(height: 32),
        ],
      ),
    ),
  );
}
