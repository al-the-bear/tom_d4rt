// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// render_ignore_pointer_test.dart
// Deep demo: RenderIgnorePointer via the IgnorePointer widget
// IgnorePointer makes its subtree invisible to hit testing.
// Unlike AbsorbPointer (which catches events), IgnorePointer lets them
// pass through to widgets behind/below in the stack.

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RenderIgnorePointer Deep Demo ===');
  print('IgnorePointer makes subtree invisible to hit testing');
  print('Events pass through to widgets below (unlike AbsorbPointer)');

  return SingleChildScrollView(
    child: Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: 24.0),

          // Section 1: ignoring: true — buttons visible but untappable
          _buildSectionTitle('1. IgnorePointer(ignoring: true)'),
          _buildIgnoringTrueSection(context),
          SizedBox(height: 24.0),

          // Section 2: ignoring: false — buttons work normally
          _buildSectionTitle('2. IgnorePointer(ignoring: false)'),
          _buildIgnoringFalseSection(context),
          SizedBox(height: 24.0),

          // Section 3: IgnorePointer vs AbsorbPointer comparison
          _buildSectionTitle('3. IgnorePointer vs AbsorbPointer'),
          _buildComparisonSection(context),
          SizedBox(height: 24.0),

          // Section 4: ignoringSemantics parameter
          _buildSectionTitle('4. ignoringSemantics Parameter'),
          _buildIgnoringSemanticsSection(context),
          SizedBox(height: 24.0),

          // Section 5: Stacked widgets — tap reaches bottom layer
          _buildSectionTitle('5. Stacked Widgets Pass-Through'),
          _buildStackedPassThroughSection(context),
          SizedBox(height: 24.0),

          // Section 6: Practical patterns
          _buildSectionTitle('6. Practical Patterns'),
          _buildPracticalPatternsSection(context),
          SizedBox(height: 24.0),

          // Section 7: IgnorePointer + Opacity combination
          _buildSectionTitle('7. IgnorePointer + Opacity'),
          _buildOpacityCombinationSection(context),
          SizedBox(height: 24.0),

          // Section 8: Nested IgnorePointer scenarios
          _buildSectionTitle('8. Nested IgnorePointer'),
          _buildNestedSection(context),
          SizedBox(height: 24.0),

          // Section 9: Interaction audit matrix
          _buildSectionTitle('9. Interaction Audit Matrix'),
          _buildInteractionAuditSection(context),
          SizedBox(height: 32.0),

          _buildFooter(),
        ],
      ),
    ),
  );
}

// -- Header --
Widget _buildHeader() {
  print('[header] Building gradient header');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 28.0, horizontal: 20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE94560), Color(0xFFF5A623), Color(0xFFE94560)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x55E94560),
          blurRadius: 18.0,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'RenderIgnorePointer',
          style: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Hit-test invisibility — events pass through',
          style: TextStyle(fontSize: 14.0, color: Color(0xDDFFFFFF)),
        ),
      ],
    ),
  );
}

// -- Section title --
Widget _buildSectionTitle(String title) {
  print('[section] $title');
  return Container(
    margin: EdgeInsets.only(bottom: 12.0),
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [Color(0xFF533483), Color(0xFF0F3460)]),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0x44FFFFFF), width: 1.0),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.w600,
        color: Color(0xFFE0E0E0),
      ),
    ),
  );
}

// -- Helper: labeled card --
Widget _buildCard(String label, Widget child) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 12.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFF1A1A2E),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0x33FFFFFF), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w600,
            color: Color(0xFFE94560),
          ),
        ),
        SizedBox(height: 10.0),
        child,
      ],
    ),
  );
}

// -- Helper: demo button --
Widget _buildDemoButton(String label, Color color) {
  return ElevatedButton(
    onPressed: () {
      print('[button] Tapped: $label');
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),
    child: Text(label),
  );
}

// ============================================================
// Section 1: ignoring: true — buttons visible but untappable
// ============================================================
Widget _buildIgnoringTrueSection(BuildContext context) {
  print('[s1] IgnorePointer ignoring=true: buttons visible but NOT tappable');
  return _buildCard(
    'ignoring: true — buttons are rendered but cannot receive taps',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'These buttons look normal but tapping them does nothing:',
          style: TextStyle(color: Color(0xAAFFFFFF), fontSize: 13.0),
        ),
        SizedBox(height: 10.0),
        IgnorePointer(
          ignoring: true,
          child: Row(
            children: [
              _buildDemoButton('Button A', Color(0xFF4CAF50)),
              SizedBox(width: 10.0),
              _buildDemoButton('Button B', Color(0xFF2196F3)),
              SizedBox(width: 10.0),
              _buildDemoButton('Button C', Color(0xFFFF9800)),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'IgnorePointer(ignoring: true) wraps the row above.',
          style: TextStyle(color: Color(0x88FFFFFF), fontSize: 12.0),
        ),
        SizedBox(height: 6.0),
        Text(
          'The buttons still paint but hit-test returns nothing.',
          style: TextStyle(color: Color(0x88FFFFFF), fontSize: 12.0),
        ),
      ],
    ),
  );
}

// ============================================================
// Section 2: ignoring: false — buttons work normally
// ============================================================
Widget _buildIgnoringFalseSection(BuildContext context) {
  print('[s2] IgnorePointer ignoring=false: buttons tappable as normal');
  return _buildCard(
    'ignoring: false — buttons respond to taps normally',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Same layout but ignoring is false — taps work:',
          style: TextStyle(color: Color(0xAAFFFFFF), fontSize: 13.0),
        ),
        SizedBox(height: 10.0),
        IgnorePointer(
          ignoring: false,
          child: Row(
            children: [
              _buildDemoButton('Active A', Color(0xFF4CAF50)),
              SizedBox(width: 10.0),
              _buildDemoButton('Active B', Color(0xFF2196F3)),
              SizedBox(width: 10.0),
              _buildDemoButton('Active C', Color(0xFFFF9800)),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'IgnorePointer(ignoring: false) has no effect on hit testing.',
          style: TextStyle(color: Color(0x88FFFFFF), fontSize: 12.0),
        ),
      ],
    ),
  );
}

// ============================================================
// Section 3: IgnorePointer vs AbsorbPointer comparison
// ============================================================
Widget _buildComparisonSection(BuildContext context) {
  print('[s3] Comparing IgnorePointer vs AbsorbPointer behavior');
  return Column(
    children: [
      _buildCard(
        'IgnorePointer — events PASS THROUGH to widgets below',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80.0,
              child: Stack(
                children: [
                  // Bottom layer: a tappable area
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        print('[s3] Bottom layer tapped UNDER IgnorePointer');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF2E7D32),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Bottom Layer (tappable)',
                          style: TextStyle(color: Colors.white, fontSize: 14.0),
                        ),
                      ),
                    ),
                  ),
                  // Top layer: IgnorePointer wrapping a semi-transparent overlay
                  Positioned.fill(
                    child: IgnorePointer(
                      ignoring: true,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0x55E94560),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'IgnorePointer overlay — taps go to bottom',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Tap goes THROUGH to the green bottom layer.',
              style: TextStyle(color: Color(0xAAFFFFFF), fontSize: 12.0),
            ),
          ],
        ),
      ),
      _buildCard(
        'AbsorbPointer — events are CAUGHT and consumed',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80.0,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        print(
                          '[s3] Bottom layer tapped UNDER AbsorbPointer — should NOT happen',
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF2E7D32),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Bottom Layer (blocked by AbsorbPointer)',
                          style: TextStyle(color: Colors.white, fontSize: 14.0),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: AbsorbPointer(
                      absorbing: true,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0x559C27B0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'AbsorbPointer overlay — taps caught here',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Tap is ABSORBED — bottom layer never receives it.',
              style: TextStyle(color: Color(0xAAFFFFFF), fontSize: 12.0),
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================
// Section 4: ignoringSemantics parameter
// ============================================================
Widget _buildIgnoringSemanticsSection(BuildContext context) {
  print('[s4] ignoringSemantics controls accessibility tree visibility');
  return Column(
    children: [
      _buildCard(
        'ignoringSemantics: true — removed from semantics tree',
        IgnorePointer(
          ignoring: true,
          ignoringSemantics: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This text is ignored by hit testing AND screen readers.',
                style: TextStyle(color: Color(0xAAFFFFFF), fontSize: 13.0),
              ),
              SizedBox(height: 8.0),
              _buildDemoButton('Semantically Hidden', Color(0xFF795548)),
            ],
          ),
        ),
      ),
      _buildCard(
        'ignoringSemantics: false — visible in semantics tree',
        IgnorePointer(
          ignoring: true,
          ignoringSemantics: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This text is ignored for taps but still read by screen readers.',
                style: TextStyle(color: Color(0xAAFFFFFF), fontSize: 13.0),
              ),
              SizedBox(height: 8.0),
              _buildDemoButton('Semantically Visible', Color(0xFF00897B)),
            ],
          ),
        ),
      ),
      _buildCard(
        'Default ignoringSemantics (null) — follows ignoring value',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IgnorePointer(
              ignoring: true,
              child: _buildDemoButton('Default Semantics', Color(0xFF5C6BC0)),
            ),
            SizedBox(height: 8.0),
            Text(
              'When ignoringSemantics is null, it defaults to the value of ignoring.',
              style: TextStyle(color: Color(0x88FFFFFF), fontSize: 12.0),
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================
// Section 5: Stacked widgets — tap reaches bottom layer
// ============================================================
Widget _buildStackedPassThroughSection(BuildContext context) {
  print(
    '[s5] Stacked scenario: IgnorePointer on top layer lets taps reach bottom',
  );
  return _buildCard(
    'Three-layer stack — middle layer uses IgnorePointer',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 160.0,
          child: Stack(
            children: [
              // Layer 0: background with tap detector
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    print('[s5] Layer 0 (red background) tapped');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFB71C1C),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'Layer 0 — Red Background (tappable)',
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                  ),
                ),
              ),
              // Layer 1: middle with IgnorePointer
              Positioned(
                top: 20.0,
                left: 20.0,
                right: 20.0,
                bottom: 40.0,
                child: IgnorePointer(
                  ignoring: true,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0x881565C0),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Color(0x66FFFFFF), width: 1.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Layer 1 — IgnorePointer (pass-through)',
                      style: TextStyle(color: Colors.white, fontSize: 13.0),
                    ),
                  ),
                ),
              ),
              // Layer 2: top corner button
              Positioned(
                top: 8.0,
                right: 8.0,
                child: GestureDetector(
                  onTap: () {
                    print('[s5] Layer 2 (top-right icon) tapped');
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFFF6F00),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.star, color: Colors.white, size: 20.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Tapping the blue middle area goes through to the red background.',
          style: TextStyle(color: Color(0xAAFFFFFF), fontSize: 12.0),
        ),
        Text(
          'The orange star in the corner remains tappable (not under IgnorePointer).',
          style: TextStyle(color: Color(0xAAFFFFFF), fontSize: 12.0),
        ),
      ],
    ),
  );
}

// ============================================================
// Section 6: Practical patterns
// ============================================================
Widget _buildPracticalPatternsSection(BuildContext context) {
  print('[s6] Practical IgnorePointer patterns');
  return Column(
    children: [
      // 6a: Disabled button overlay
      _buildCard(
        '6a. Disabled Button Overlay',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Use IgnorePointer to disable a form section without changing widget state:',
              style: TextStyle(color: Color(0xAAFFFFFF), fontSize: 12.0),
            ),
            SizedBox(height: 10.0),
            IgnorePointer(
              ignoring: true,
              child: Opacity(
                opacity: 0.4,
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Disabled Input',
                        labelStyle: TextStyle(color: Color(0x88FFFFFF)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0x44FFFFFF)),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDemoButton('Submit', Color(0xFF4CAF50)),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: _buildDemoButton('Cancel', Color(0xFFF44336)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'IgnorePointer + Opacity(0.4) creates a disabled form look.',
              style: TextStyle(color: Color(0x88FFFFFF), fontSize: 12.0),
            ),
          ],
        ),
      ),
      // 6b: Transparent overlay
      _buildCard(
        '6b. Transparent Overlay',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Transparent decoration overlay that does not block interaction:',
              style: TextStyle(color: Color(0xAAFFFFFF), fontSize: 12.0),
            ),
            SizedBox(height: 10.0),
            SizedBox(
              height: 80.0,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Center(
                      child: _buildDemoButton(
                        'Still Tappable',
                        Color(0xFF7B1FA2),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: IgnorePointer(
                      ignoring: true,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0x22FFFFFF), Color(0x00FFFFFF)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              'Gradient overlay is purely decorative — taps pass through.',
              style: TextStyle(color: Color(0x88FFFFFF), fontSize: 12.0),
            ),
          ],
        ),
      ),
      // 6c: Loading state
      _buildCard(
        '6c. Loading State Overlay',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Block interaction during loading without AbsorbPointer:',
              style: TextStyle(color: Color(0xAAFFFFFF), fontSize: 12.0),
            ),
            SizedBox(height: 10.0),
            SizedBox(
              height: 100.0,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildDemoButton('Process Data', Color(0xFF0288D1)),
                        SizedBox(height: 8.0),
                        _buildDemoButton('Delete Item', Color(0xFFD32F2F)),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: IgnorePointer(
                      ignoring: false,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xAA000000),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                Color(0xFFE94560),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'Loading...',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              'When ignoring is false the overlay BLOCKS taps (acts as barrier).',
              style: TextStyle(color: Color(0x88FFFFFF), fontSize: 12.0),
            ),
            Text(
              'Set ignoring: true to let taps through when loading finishes.',
              style: TextStyle(color: Color(0x88FFFFFF), fontSize: 12.0),
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================
// Section 7: IgnorePointer + Opacity combination
// ============================================================
Widget _buildOpacityCombinationSection(BuildContext context) {
  print(
    '[s7] Combining IgnorePointer with Opacity for visual + interaction disabling',
  );
  return Column(
    children: [
      _buildCard(
        'Full opacity but ignored — visible, no interaction',
        IgnorePointer(
          ignoring: true,
          child: Opacity(
            opacity: 1.0,
            child: Row(
              children: [
                _buildDemoButton('Looks Normal', Color(0xFF4CAF50)),
                SizedBox(width: 8.0),
                _buildDemoButton('Cannot Tap', Color(0xFF2196F3)),
              ],
            ),
          ),
        ),
      ),
      _buildCard(
        'Reduced opacity + ignored — visually disabled',
        IgnorePointer(
          ignoring: true,
          child: Opacity(
            opacity: 0.35,
            child: Row(
              children: [
                _buildDemoButton('Faded Out', Color(0xFF4CAF50)),
                SizedBox(width: 8.0),
                _buildDemoButton('Untappable', Color(0xFF2196F3)),
              ],
            ),
          ),
        ),
      ),
      _buildCard(
        'Zero opacity + ignored — completely hidden',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IgnorePointer(
              ignoring: true,
              child: Opacity(
                opacity: 0.0,
                child: _buildDemoButton('Invisible', Color(0xFFF44336)),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Button above is invisible and does not receive taps.',
              style: TextStyle(color: Color(0xAAFFFFFF), fontSize: 12.0),
            ),
          ],
        ),
      ),
      _buildCard(
        'Graduated opacity scale with IgnorePointer',
        Column(
          children: [
            _buildOpacityRow('Opacity 1.0', 1.0, Color(0xFF009688)),
            _buildOpacityRow('Opacity 0.7', 0.7, Color(0xFF00796B)),
            _buildOpacityRow('Opacity 0.4', 0.4, Color(0xFF004D40)),
            _buildOpacityRow('Opacity 0.1', 0.1, Color(0xFF00251A)),
          ],
        ),
      ),
    ],
  );
}

Widget _buildOpacityRow(String label, double opacity, Color color) {
  print('[s7] Opacity row: $label');
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: IgnorePointer(
      ignoring: true,
      child: Opacity(
        opacity: opacity,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  '$label — ignored',
                  style: TextStyle(color: Colors.white, fontSize: 13.0),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ============================================================
// Section 8: Nested IgnorePointer scenarios
// ============================================================
Widget _buildNestedSection(BuildContext context) {
  print('[s8] Nested IgnorePointer scenarios');
  return Column(
    children: [
      _buildCard(
        'Outer ignoring=true, inner ignoring=false — still blocked',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IgnorePointer(
              ignoring: true,
              child: Column(
                children: [
                  Text(
                    'Outer IgnorePointer blocks everything below it:',
                    style: TextStyle(color: Color(0xAAFFFFFF), fontSize: 12.0),
                  ),
                  SizedBox(height: 8.0),
                  IgnorePointer(
                    ignoring: false,
                    child: _buildDemoButton(
                      'Inner NOT Ignored',
                      Color(0xFF1976D2),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Even though inner says ignoring=false, the outer blocks it.',
              style: TextStyle(color: Color(0x88FFFFFF), fontSize: 12.0),
            ),
          ],
        ),
      ),
      _buildCard(
        'Outer ignoring=false, inner ignoring=true — inner blocked only',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IgnorePointer(
              ignoring: false,
              child: Column(
                children: [
                  _buildDemoButton('Outer Active', Color(0xFF388E3C)),
                  SizedBox(height: 8.0),
                  IgnorePointer(
                    ignoring: true,
                    child: _buildDemoButton('Inner Blocked', Color(0xFFC62828)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Outer button works. Inner button is ignored by its own IgnorePointer.',
              style: TextStyle(color: Color(0x88FFFFFF), fontSize: 12.0),
            ),
          ],
        ),
      ),
      _buildCard(
        'Triple nesting: true > false > true',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IgnorePointer(
              ignoring: true,
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFE94560), width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Text(
                      'Level 1: ignoring=true',
                      style: TextStyle(
                        color: Color(0xFFE94560),
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(height: 6.0),
                    IgnorePointer(
                      ignoring: false,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF4CAF50),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Level 2: ignoring=false',
                              style: TextStyle(
                                color: Color(0xFF4CAF50),
                                fontSize: 12.0,
                              ),
                            ),
                            SizedBox(height: 6.0),
                            IgnorePointer(
                              ignoring: true,
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xFF2196F3),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Level 3: ignoring=true',
                                      style: TextStyle(
                                        color: Color(0xFF2196F3),
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    SizedBox(height: 4.0),
                                    _buildDemoButton(
                                      'Deeply Nested',
                                      Color(0xFF5C6BC0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Level 1 blocks everything — nothing below is tappable.',
              style: TextStyle(color: Color(0x88FFFFFF), fontSize: 12.0),
            ),
          ],
        ),
      ),
      _buildCard(
        'Sibling IgnorePointers — independent scope',
        Row(
          children: [
            Expanded(
              child: IgnorePointer(
                ignoring: true,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Color(0x22E94560),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Ignored',
                        style: TextStyle(
                          color: Color(0xFFE94560),
                          fontSize: 12.0,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      _buildDemoButton('No Tap', Color(0xFF880E4F)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: IgnorePointer(
                ignoring: false,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Color(0x224CAF50),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Active',
                        style: TextStyle(
                          color: Color(0xFF4CAF50),
                          fontSize: 12.0,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      _buildDemoButton('Tappable', Color(0xFF2E7D32)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildInteractionAuditSection(BuildContext context) {
  print('[s9] Interaction audit matrix');
  return _buildCard(
    'Audit common pass-through patterns before release',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Checklist: verify visible state, hit-test behavior, and semantics impact together.',
          style: TextStyle(color: Color(0xAAFFFFFF), fontSize: 12.0),
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0x223F51B5),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Icon(Icons.visibility, color: Color(0xFF90CAF9)),
                    SizedBox(height: 4),
                    Text('Visible layer', style: TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0x224CAF50),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Icon(Icons.touch_app, color: Color(0xFFA5D6A7)),
                    SizedBox(height: 4),
                    Text('Receives tap', style: TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0x22EF5350),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Icon(Icons.record_voice_over, color: Color(0xFFFFCDD2)),
                    SizedBox(height: 4),
                    Text('In semantics', style: TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// -- Footer --
Widget _buildFooter() {
  print('[footer] RenderIgnorePointer demo complete');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [Color(0xFF0F3460), Color(0xFF533483)]),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        Text(
          'RenderIgnorePointer Summary',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          'IgnorePointer: subtree invisible to hit test, events pass through',
          style: TextStyle(color: Color(0xAAFFFFFF), fontSize: 12.0),
        ),
        SizedBox(height: 4.0),
        Text(
          'AbsorbPointer: subtree blocked, events consumed (not forwarded)',
          style: TextStyle(color: Color(0xAAFFFFFF), fontSize: 12.0),
        ),
        SizedBox(height: 4.0),
        Text(
          'ignoringSemantics: controls accessibility tree independently',
          style: TextStyle(color: Color(0xAAFFFFFF), fontSize: 12.0),
        ),
        SizedBox(height: 4.0),
        Text(
          'Combine with Opacity for visual + interaction disabling',
          style: TextStyle(color: Color(0xAAFFFFFF), fontSize: 12.0),
        ),
        SizedBox(height: 4.0),
        Text(
          'Outer IgnorePointer(ignoring: true) overrides inner settings',
          style: TextStyle(color: Color(0xAAFFFFFF), fontSize: 12.0),
        ),
      ],
    ),
  );
}
