// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep demo for RenderAnimatedOpacityMixin from rendering
//
// RenderAnimatedOpacityMixin is a mixin that provides efficient animated
// opacity rendering for render objects. It optimizes rendering by skipping
// paint entirely when opacity is 0 (fully transparent) and removing the
// opacity layer when opacity is 1 (fully opaque). This mixin powers widgets
// like AnimatedOpacity and FadeTransition for smooth, performant fading.
//
// Key optimizations:
//   - Skips paint call when opacity is exactly 0
//   - Removes opacity layer when opacity is exactly 1
//   - Caches alpha value to avoid re-computation
//   - Manages alwaysNeedsCompositing based on current opacity
//
// Common use cases:
//   - Fade-in animations on widget appearance
//   - Cross-fade transitions between states
//   - Visibility toggling with animation
//   - Loading state transitions
//   - Skeleton screen fade-outs
//
// This demo visualizes the mixin behavior comprehensively.

import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// COLOR PALETTE
// ═══════════════════════════════════════════════════════════════════════════════

Color _kPrimary50 = Color(0xFFE8EAF6);
Color _kPrimary200 = Color(0xFF9FA8DA);
Color _kPrimary400 = Color(0xFF5C6BC0);
Color _kPrimary500 = Color(0xFF3F51B5);
Color _kPrimary600 = Color(0xFF3949AB);
Color _kPrimary700 = Color(0xFF303F9F);
Color _kPrimary800 = Color(0xFF283593);

Color _kSecondary600 = Color(0xFF00BCD4);

Color _kAccent500 = Color(0xFFFF7043);
Color _kAccent600 = Color(0xFFFF5722);
Color _kAccent700 = Color(0xFFF4511E);

Color _kSuccess500 = Color(0xFF66BB6A);
Color _kSuccess600 = Color(0xFF4CAF50);

Color _kWarning500 = Color(0xFFFFA726);
Color _kWarning600 = Color(0xFFFF9800);

Color _kError500 = Color(0xFFEF5350);
Color _kError600 = Color(0xFFF44336);

Color _kSlate50 = Color(0xFFF8FAFC);
Color _kSlate100 = Color(0xFFF1F5F9);
Color _kSlate200 = Color(0xFFE2E8F0);
Color _kSlate300 = Color(0xFFCBD5E1);
Color _kSlate400 = Color(0xFF94A3B8);
Color _kSlate500 = Color(0xFF64748B);
Color _kSlate600 = Color(0xFF475569);
Color _kSlate700 = Color(0xFF334155);
Color _kSlate800 = Color(0xFF1E293B);

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildMainHeader() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kPrimary800, _kPrimary600, _kPrimary400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: _kPrimary800.withAlpha(120),
          blurRadius: 20,
          offset: Offset(0, 10),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.opacity, color: Colors.white, size: 56),
        SizedBox(height: 16),
        Text(
          'RenderAnimatedOpacityMixin',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.0,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Efficient animated opacity rendering with smart optimizations',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withAlpha(200),
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(40),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'rendering library \u2022 mixin \u2022 performance-optimized',
            style: TextStyle(fontSize: 12, color: Colors.white.withAlpha(220)),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionCard({
  required String title,
  required String subtitle,
  required IconData icon,
  required Color iconColor,
  required List<Widget> children,
}) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kSlate200, width: 1),
      boxShadow: [
        BoxShadow(
          color: _kSlate400.withAlpha(30),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: iconColor.withAlpha(15),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _kSlate800,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 12, color: _kSlate500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoRow(IconData icon, Color color, String label, String value) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        Icon(icon, size: 16, color: color),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: _kSlate700,
          ),
        ),
        SizedBox(width: 6),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 13, color: _kSlate500),
          ),
        ),
      ],
    ),
  );
}

Widget _buildOpacityStageCard(
  String stage,
  String opacity,
  String behavior,
  Color color,
  IconData icon,
  double displayOpacity,
) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(60), width: 1),
    ),
    child: Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withAlpha((displayOpacity * 255).toInt()),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color.withAlpha(100), width: 1),
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    stage,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: color.withAlpha(30),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      opacity,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                behavior,
                style: TextStyle(fontSize: 12, color: _kSlate600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildComparisonRow(
  String label,
  String mixinValue,
  String naiveValue,
  Color mixinColor,
  Color naiveColor,
) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    decoration: BoxDecoration(
      color: _kSlate50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _kSlate700,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: mixinColor.withAlpha(20),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              mixinValue,
              style: TextStyle(
                fontSize: 11,
                color: mixinColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(width: 6),
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: naiveColor.withAlpha(20),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              naiveValue,
              style: TextStyle(
                fontSize: 11,
                color: naiveColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPatternCard(
  String name,
  String description,
  IconData icon,
  Color color,
  List<String> steps,
) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.withAlpha(12), color.withAlpha(5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(40), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withAlpha(25),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _kSlate800,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(fontSize: 11, color: _kSlate500),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        ...steps.map((step) {
          return Padding(
            padding: EdgeInsets.only(bottom: 4, left: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.arrow_forward, size: 12, color: color),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    step,
                    style: TextStyle(fontSize: 12, color: _kSlate600),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

Widget _buildCompositingStateCard(
  String state,
  String opacityRange,
  String description,
  bool needsCompositing,
  Color color,
) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(10),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(50), width: 1),
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: needsCompositing ? _kWarning500.withAlpha(30) : _kSuccess500.withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            needsCompositing ? Icons.layers : Icons.layers_clear,
            color: needsCompositing ? _kWarning600 : _kSuccess600,
            size: 20,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    state,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: _kSlate800,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: color.withAlpha(25),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      opacityRange,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 11, color: _kSlate600),
              ),
              SizedBox(height: 2),
              Text(
                needsCompositing
                    ? 'alwaysNeedsCompositing = true'
                    : 'alwaysNeedsCompositing = false',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: needsCompositing ? _kWarning600 : _kSuccess600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 8, bottom: 8),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kSlate800,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: Color(0xFFE2E8F0),
        height: 1.5,
      ),
    ),
  );
}

Widget _buildDivider() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 12),
    child: Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            _kSlate300,
            Colors.transparent,
          ],
        ),
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 1: OVERVIEW
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildOverviewSection() {
  print('--- Section 1: RenderAnimatedOpacityMixin Overview ---');
  print('Mixin purpose: efficient animated opacity rendering');
  print('Applied to: RenderObject subclasses that need animated opacity');
  print('Key optimization: avoids unnecessary repaints at opacity 0 and 1');
  print('Caches alpha: converts double opacity to int alpha once per change');

  return _buildSectionCard(
    title: 'Mixin Overview',
    subtitle: 'Purpose, optimization strategy, and repaint avoidance',
    icon: Icons.info_outline,
    iconColor: _kPrimary500,
    children: [
      _buildInfoRow(Icons.code, _kPrimary500, 'Type:', 'mixin on RenderObject'),
      _buildInfoRow(Icons.library_books, _kPrimary600, 'Library:', 'rendering'),
      _buildInfoRow(Icons.speed, _kPrimary700, 'Goal:', 'Minimize paint overhead during opacity animations'),
      _buildInfoRow(Icons.layers, _kPrimary400, 'Layer:', 'OpacityLayer (created only when needed)'),
      _buildDivider(),
      Text(
        'Core Optimization Strategy',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: _kSlate800,
        ),
      ),
      SizedBox(height: 8),
      _buildInfoRow(
        Icons.visibility_off,
        _kError500,
        'Opacity = 0:',
        'Paint is SKIPPED entirely \u2014 child never drawn',
      ),
      _buildInfoRow(
        Icons.visibility,
        _kSuccess500,
        'Opacity = 1:',
        'Layer REMOVED \u2014 child drawn directly without compositing',
      ),
      _buildInfoRow(
        Icons.tune,
        _kWarning500,
        '0 < Opacity < 1:',
        'OpacityLayer inserted \u2014 GPU handles blending',
      ),
      _buildDivider(),
      Text(
        'Type Hierarchy',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: _kSlate800,
        ),
      ),
      SizedBox(height: 6),
      _buildCodeBlock(
        'mixin RenderAnimatedOpacityMixin<T extends Layer>\n'
        '    on RenderObjectWithChildMixin<RenderBox> {\n'
        '  // Provides:\n'
        '  //   - opacity animation management\n'
        '  //   - alpha caching\n'
        '  //   - paint optimization\n'
        '  //   - compositing layer control\n'
        '}',
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 2: OPACITY ANIMATION LIFECYCLE
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildLifecycleSection() {
  print('--- Section 2: Opacity Animation Lifecycle ---');
  print('Stage 1: Hidden (opacity=0) - paint skipped, zero GPU cost');
  print('Stage 2: Fading in (0<opacity<0.5) - OpacityLayer active, blending');
  print('Stage 3: Nearly visible (0.5<=opacity<1) - layer still active');
  print('Stage 4: Fully visible (opacity=1) - layer removed, direct paint');
  print('Transition: 0 -> 1 means going from no-paint to layered to direct');

  return _buildSectionCard(
    title: 'Opacity Animation Lifecycle',
    subtitle: 'Stages from fully hidden to fully visible',
    icon: Icons.timeline,
    iconColor: _kSecondary600,
    children: [
      _buildOpacityStageCard(
        'Hidden',
        'opacity = 0.0',
        'Paint is completely skipped. No GPU resources consumed. '
            'The render object reports zero visual output.',
        _kError500,
        Icons.visibility_off,
        0.0,
      ),
      _buildOpacityStageCard(
        'Fading In',
        '0.0 < opacity < 0.5',
        'OpacityLayer is created and inserted into the layer tree. '
            'Alpha value is cached. GPU blends child with background.',
        _kWarning500,
        Icons.blur_on,
        0.3,
      ),
      _buildOpacityStageCard(
        'Nearly Visible',
        '0.5 <= opacity < 1.0',
        'Same OpacityLayer active but with higher alpha. '
            'alwaysNeedsCompositing remains true for smooth animation.',
        _kPrimary400,
        Icons.blur_circular,
        0.7,
      ),
      _buildOpacityStageCard(
        'Fully Visible',
        'opacity = 1.0',
        'OpacityLayer is REMOVED. Child paints directly without '
            'compositing overhead. Maximum rendering performance.',
        _kSuccess500,
        Icons.visibility,
        1.0,
      ),
      _buildDivider(),
      Text(
        'Animation Flow Diagram',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: _kSlate800,
        ),
      ),
      SizedBox(height: 6),
      _buildCodeBlock(
        'opacity=0        opacity=0.5       opacity=1\n'
        '  |                  |                  |\n'
        '  v                  v                  v\n'
        '[SKIP PAINT] --> [OPACITY LAYER] --> [DIRECT PAINT]\n'
        '  no GPU cost     GPU blending      no layer overhead\n'
        '  no compositing  compositing=true  compositing=false',
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 3: PERFORMANCE OPTIMIZATION
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildPerformanceSection() {
  print('--- Section 3: Performance Optimization ---');
  print('Skip paint at opacity 0: avoids entire subtree traversal');
  print('Remove layer at opacity 1: eliminates compositing cost');
  print('Alpha caching: int alpha from double opacity, computed once');
  print('Comparison: naive approach always creates OpacityLayer');
  print('Result: significant frame time savings at boundary values');

  return _buildSectionCard(
    title: 'Performance Optimization',
    subtitle: 'Skip paint at 0, remove layer at 1, alpha caching',
    icon: Icons.speed,
    iconColor: _kSuccess600,
    children: [
      Text(
        'Optimization Strategies',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: _kSlate800,
        ),
      ),
      SizedBox(height: 8),
      _buildInfoRow(
        Icons.block,
        _kError500,
        'Zero paint skip:',
        'When opacity == 0, paint() returns immediately. '
            'No layer creation, no child traversal.',
      ),
      _buildInfoRow(
        Icons.remove_circle_outline,
        _kSuccess500,
        'Layer removal:',
        'When opacity == 1, the OpacityLayer is dropped. '
            'Child renders as if no opacity wrapper exists.',
      ),
      _buildInfoRow(
        Icons.cached,
        _kPrimary500,
        'Alpha caching:',
        'Double-to-int conversion (opacity * 255) computed '
            'once when opacity changes, reused across frames.',
      ),
      _buildInfoRow(
        Icons.memory,
        _kWarning500,
        'Layer recycling:',
        'OpacityLayer instance is reused when opacity changes '
            'between frames, avoiding allocation overhead.',
      ),
      _buildDivider(),
      Text(
        'Mixin vs Naive Approach',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: _kSlate800,
        ),
      ),
      SizedBox(height: 8),
      Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: _kSlate100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                'Scenario',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _kSlate700,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                'Mixin',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _kSuccess600,
                ),
              ),
            ),
            SizedBox(width: 6),
            Expanded(
              flex: 3,
              child: Text(
                'Naive',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _kError600,
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 6),
      _buildComparisonRow(
        'Opacity = 0',
        'Skip paint entirely',
        'Create layer, paint child',
        _kSuccess600,
        _kError600,
      ),
      _buildComparisonRow(
        'Opacity = 1',
        'Direct paint, no layer',
        'Create layer at alpha 255',
        _kSuccess600,
        _kError600,
      ),
      _buildComparisonRow(
        'Opacity = 0.5',
        'Cached alpha, reuse layer',
        'Recompute each frame',
        _kSuccess600,
        _kError600,
      ),
      _buildComparisonRow(
        'Compositing',
        'Dynamic (only 0<o<1)',
        'Always compositing',
        _kSuccess600,
        _kError600,
      ),
      _buildComparisonRow(
        'Memory',
        'Lazy layer allocation',
        'Permanent layer overhead',
        _kSuccess600,
        _kError600,
      ),
      _buildDivider(),
      _buildCodeBlock(
        '// Simplified mixin paint logic:\n'
        'void paint(PaintingContext context, Offset offset) {\n'
        '  if (_alpha == 0) {\n'
        '    // OPTIMIZATION: skip paint entirely\n'
        '    return;\n'
        '  }\n'
        '  if (_alpha == 255) {\n'
        '    // OPTIMIZATION: paint directly\n'
        '    context.paintChild(child, offset);\n'
        '    return;\n'
        '  }\n'
        '  // Only create layer for partial opacity\n'
        '  context.pushOpacity(offset, _alpha, super.paint);\n'
        '}',
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 4: ALWAYS NEEDS COMPOSITING
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildCompositingSection() {
  print('--- Section 4: alwaysNeedsCompositing Behavior ---');
  print('Opacity = 0: alwaysNeedsCompositing = false (paint skipped)');
  print('0 < Opacity < 1: alwaysNeedsCompositing = true (layer needed)');
  print('Opacity = 1: alwaysNeedsCompositing = false (no layer)');
  print('Changes trigger markNeedsCompositingBitsUpdate()');
  print('Layer tree is rebuilt only when compositing state changes');

  return _buildSectionCard(
    title: 'alwaysNeedsCompositing',
    subtitle: 'Dynamic compositing based on opacity value',
    icon: Icons.layers,
    iconColor: _kWarning600,
    children: [
      _buildCompositingStateCard(
        'Fully Transparent',
        'opacity = 0.0',
        'Paint skipped entirely, no layer needed in the compositing tree.',
        false,
        _kError500,
      ),
      _buildCompositingStateCard(
        'Partially Visible',
        '0.0 < opacity < 1.0',
        'OpacityLayer required to composite child with reduced alpha.',
        true,
        _kWarning500,
      ),
      _buildCompositingStateCard(
        'Fully Opaque',
        'opacity = 1.0',
        'No layer needed, child paints directly into parent context.',
        false,
        _kSuccess500,
      ),
      _buildDivider(),
      Text(
        'Layer Management Flow',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: _kSlate800,
        ),
      ),
      SizedBox(height: 6),
      _buildCodeBlock(
        'set opacity(Animation<double> value) {\n'
        '  // When opacity animation changes:\n'
        '  // 1. Cache new alpha = (value * 255).round()\n'
        '  // 2. Update alwaysNeedsCompositing\n'
        '  // 3. markNeedsCompositingBitsUpdate()\n'
        '  // 4. markNeedsPaint()\n'
        '}\n'
        '\n'
        'bool get alwaysNeedsCompositing {\n'
        '  return child != null && _alpha != 0 && _alpha != 255;\n'
        '}',
      ),
      SizedBox(height: 8),
      _buildInfoRow(
        Icons.update,
        _kPrimary500,
        'Trigger:',
        'markNeedsCompositingBitsUpdate() called on opacity change',
      ),
      _buildInfoRow(
        Icons.account_tree,
        _kSecondary600,
        'Propagation:',
        'Compositing bits walk up the tree to the nearest repaint boundary',
      ),
      _buildInfoRow(
        Icons.recycling,
        _kSuccess500,
        'Efficiency:',
        'Layer is only created/destroyed at boundary transitions (0 and 1)',
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 5: INTEGRATION WITH ANIMATED OPACITY
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildIntegrationSection() {
  print('--- Section 5: Integration with AnimatedOpacity ---');
  print('AnimatedOpacity widget creates RenderAnimatedOpacity');
  print('RenderAnimatedOpacity uses RenderAnimatedOpacityMixin');
  print('Animation drives opacity property on the render object');
  print('FadeTransition also uses this mixin path');
  print('Widget tree: AnimatedOpacity -> RenderAnimatedOpacity (with mixin)');

  return _buildSectionCard(
    title: 'AnimatedOpacity Integration',
    subtitle: 'How the widget drives the render object mixin',
    icon: Icons.integration_instructions,
    iconColor: _kAccent600,
    children: [
      Text(
        'Widget to Render Object Flow',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: _kSlate800,
        ),
      ),
      SizedBox(height: 6),
      _buildCodeBlock(
        '// Widget layer:\n'
        'AnimatedOpacity(\n'
        '  opacity: _visible ? 1.0 : 0.0,\n'
        '  duration: Duration(milliseconds: 500),\n'
        '  child: MyWidget(),\n'
        ')\n'
        '\n'
        '// This creates RenderAnimatedOpacity which\n'
        '// uses RenderAnimatedOpacityMixin to optimize\n'
        '// the actual painting behavior.',
      ),
      _buildDivider(),
      Text(
        'Connection Chain',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: _kSlate800,
        ),
      ),
      SizedBox(height: 8),
      _buildInfoRow(
        Icons.widgets,
        _kAccent500,
        'Widget:',
        'AnimatedOpacity (implicit animation widget)',
      ),
      _buildInfoRow(
        Icons.settings_input_component,
        _kAccent600,
        'Element:',
        '_AnimatedOpacityState manages AnimationController',
      ),
      _buildInfoRow(
        Icons.view_in_ar,
        _kAccent700,
        'RenderObject:',
        'RenderAnimatedOpacity with RenderAnimatedOpacityMixin',
      ),
      _buildInfoRow(
        Icons.animation,
        _kPrimary500,
        'Animation:',
        'Implicit animation driven by AnimatedWidgetBaseState',
      ),
      _buildDivider(),
      Text(
        'Related Widgets',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: _kSlate800,
        ),
      ),
      SizedBox(height: 8),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _kPrimary50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _kPrimary200, width: 1),
        ),
        child: Column(
          children: [
            _buildInfoRow(
              Icons.opacity,
              _kPrimary500,
              'AnimatedOpacity:',
              'Implicit animation, opacity auto-animates on change',
            ),
            _buildInfoRow(
              Icons.swap_horiz,
              _kSecondary600,
              'FadeTransition:',
              'Explicit animation, takes Animation<double> directly',
            ),
            _buildInfoRow(
              Icons.layers,
              _kWarning500,
              'SliverAnimatedOpacity:',
              'Same mixin applied to sliver rendering context',
            ),
            _buildInfoRow(
              Icons.gradient,
              _kAccent500,
              'Opacity (widget):',
              'Static opacity, no animation, always creates layer',
            ),
          ],
        ),
      ),
      SizedBox(height: 8),
      _buildCodeBlock(
        '// FadeTransition (explicit animation):\n'
        'FadeTransition(\n'
        '  opacity: _animationController,\n'
        '  child: MyWidget(),\n'
        ')\n'
        '\n'
        '// Both use RenderAnimatedOpacityMixin\n'
        '// under the hood for optimized rendering.',
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 6: COMMON PATTERNS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildPatternsSection() {
  print('--- Section 6: Common Patterns ---');
  print('Pattern 1: Fade-in animation on widget entry');
  print('Pattern 2: Cross-fade between two widgets');
  print('Pattern 3: Visibility toggle with animation');
  print('Pattern 4: Loading state fade-out when data arrives');
  print('Pattern 5: Staggered fade-in for list items');
  print('Pattern 6: Conditional opacity based on state');

  return _buildSectionCard(
    title: 'Common Patterns',
    subtitle: 'Fade-in, cross-fade, visibility, loading transitions',
    icon: Icons.pattern,
    iconColor: _kPrimary600,
    children: [
      _buildPatternCard(
        'Fade-In Animation',
        'Widget appears with smooth opacity transition',
        Icons.flash_on,
        _kPrimary500,
        [
          'Set initial opacity to 0.0',
          'Trigger state change to set opacity to 1.0',
          'AnimatedOpacity animates 0 -> 1 over duration',
          'Mixin skips paint initially, adds layer, then removes layer',
        ],
      ),
      _buildPatternCard(
        'Cross-Fade Transition',
        'One widget fades out while another fades in',
        Icons.swap_horiz,
        _kSecondary600,
        [
          'AnimatedCrossFade uses two AnimatedOpacity internally',
          'Old child: opacity 1.0 -> 0.0 (fading out)',
          'New child: opacity 0.0 -> 1.0 (fading in)',
          'Both benefit from mixin optimizations at endpoints',
        ],
      ),
      _buildPatternCard(
        'Visibility Toggle',
        'Show/hide widget with animated opacity instead of removing',
        Icons.visibility,
        _kSuccess500,
        [
          'Keep widget in tree but animate opacity to 0',
          'Mixin skips paint at 0 (same visual as hidden)',
          'Toggle to 1 with smooth animation when needed',
          'Preserves widget state unlike Visibility widget removal',
        ],
      ),
      _buildPatternCard(
        'Loading State Fade',
        'Skeleton fades out, content fades in when data loads',
        Icons.hourglass_bottom,
        _kWarning500,
        [
          'Show skeleton/shimmer at opacity 1.0 while loading',
          'When data arrives, fade skeleton to 0.0',
          'Simultaneously fade content from 0.0 to 1.0',
          'Mixin ensures no GPU cost for fully faded-out skeleton',
        ],
      ),
      _buildPatternCard(
        'Staggered Fade-In',
        'List items appear one by one with delay',
        Icons.view_list,
        _kAccent500,
        [
          'Each item starts at opacity 0.0',
          'Stagger delays: item[i] starts after i * 100ms',
          'Each item independently benefits from mixin optimization',
          'Items at 0 skip paint; items at 1 have no layer overhead',
        ],
      ),
      _buildPatternCard(
        'Disabled State Opacity',
        'Reduce opacity for disabled interactive elements',
        Icons.do_not_disturb,
        _kSlate500,
        [
          'Animate opacity to 0.38 for disabled Material state',
          'Mixin manages the partial opacity layer efficiently',
          'On re-enable, animate back to 1.0 (layer removed)',
          'Smooth UX transition for enable/disable toggling',
        ],
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN BUILD
// ═══════════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('RenderAnimatedOpacityMixin deep demo executing');
  print('=' * 60);

  Widget overviewSection = _buildOverviewSection();
  Widget lifecycleSection = _buildLifecycleSection();
  Widget performanceSection = _buildPerformanceSection();
  Widget compositingSection = _buildCompositingSection();
  Widget integrationSection = _buildIntegrationSection();
  Widget patternsSection = _buildPatternsSection();

  print('=' * 60);
  print('RenderAnimatedOpacityMixin deep demo completed');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: _kSlate100,
      appBar: AppBar(
        title: Text('RenderAnimatedOpacityMixin'),
        backgroundColor: _kPrimary700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildMainHeader(),
            SizedBox(height: 20),
            overviewSection,
            lifecycleSection,
            performanceSection,
            compositingSection,
            integrationSection,
            patternsSection,
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _kPrimary50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _kPrimary200, width: 1),
              ),
              child: Column(
                children: [
                  Icon(Icons.check_circle, color: _kSuccess500, size: 32),
                  SizedBox(height: 8),
                  Text(
                    'RenderAnimatedOpacityMixin Demo Complete',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _kPrimary700,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Covered: overview, lifecycle, performance, compositing, '
                        'integration, and common patterns',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: _kSlate500),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}
