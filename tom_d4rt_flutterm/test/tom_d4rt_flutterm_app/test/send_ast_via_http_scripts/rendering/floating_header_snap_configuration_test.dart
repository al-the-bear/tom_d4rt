// D4rt test script: Deep demo for FloatingHeaderSnapConfiguration from rendering
//
// FloatingHeaderSnapConfiguration configures floating header snapping behavior.
// It controls how SliverPersistentHeader widgets snap between collapsed and
// expanded states when scrolling stops mid-transition.
//
// Key responsibilities:
//   - Provides vsync for animation coordination
//   - Defines animation curve for smooth transitions
//   - Sets duration for snap animations
//   - Integrates with SliverPersistentHeader scroll mechanics
//
// Related classes:
//   - SliverPersistentHeader: Uses this configuration
//   - SliverPersistentHeaderDelegate: Provides snap configuration
//   - OverScrollHeaderStretchConfiguration: Related stretch config
//   - PersistentHeaderShowOnScreenConfiguration: Show behavior config
//
// Use cases:
//   - Custom app bars with snap behavior
//   - Collapsible headers in scrollable lists
//   - Smooth header animations on scroll stop
//   - Enhanced user experience with header transitions
//
// This demo visualizes FloatingHeaderSnapConfiguration properties and behavior.

import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildHeader(String title, String subtitle) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF6A1B9A), Color(0xFFAB47BC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF6A1B9A).withAlpha(100),
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.vertical_align_top, size: 48, color: Colors.white),
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
          style: TextStyle(fontSize: 14, color: Colors.white.withAlpha(200)),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFFAB47BC).withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Color(0xFF6A1B9A), size: 20),
        ),
        SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6A1B9A),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF6A1B9A),
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? Color(0xFF7B1FA2),
              fontSize: 13,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPropertyBox(String label, String value, Color color, IconData icon) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(80), width: 1.5),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 24),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: color.withAlpha(180),
            fontSize: 11,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 1: CONFIGURATION OVERVIEW
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildConfigurationOverviewSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Configuration Overview', Icons.settings),
        Text(
          'FloatingHeaderSnapConfiguration defines the snapping behavior for '
          'floating SliverPersistentHeader widgets. When the user stops scrolling '
          'with a floating header partially visible, this configuration determines '
          'how the header animates to its final position.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Configuration Architecture',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPropertyBox('vsync', 'TickerProvider', Color(0xFF1565C0), Icons.sync),
                  _buildPropertyBox('curve', 'Curves.ease', Color(0xFF2E7D32), Icons.show_chart),
                  _buildPropertyBox('duration', '300ms', Color(0xFFE65100), Icons.timer),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildInfoRow('Class Type', 'Immutable configuration object'),
        _buildInfoRow('Package', 'flutter/rendering.dart'),
        _buildInfoRow('Primary Use', 'SliverPersistentHeaderDelegate.snapConfiguration'),
        _buildInfoRow('Floating Mode', 'Enables snap only when floating=true'),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 2: VSYNC PROPERTY
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildVsyncPropertySection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('vsync Property', Icons.sync),
        Text(
          'The vsync property provides a TickerProvider that coordinates animation '
          'timing with the display refresh rate. This ensures smooth 60fps or 120fps '
          'animations by synchronizing frame callbacks with the hardware.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'VSync Flow Diagram',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildVsyncStageBox('TickerProvider', Icons.precision_manufacturing, Color(0xFF1565C0)),
                  _buildVsyncArrow(),
                  _buildVsyncStageBox('Ticker', Icons.play_arrow, Color(0xFF2E7D32)),
                  _buildVsyncArrow(),
                  _buildVsyncStageBox('Animation', Icons.animation, Color(0xFFE65100)),
                ],
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.lightbulb, color: Color(0xFF2E7D32), size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Common vsync sources: State with TickerProviderStateMixin, '
                        'SingleTickerProviderStateMixin, or custom TickerProvider',
                        style: TextStyle(fontSize: 12, color: Color(0xFF1B5E20)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildInfoRow('Type', 'TickerProvider'),
        _buildInfoRow('Required', 'Yes - must be provided'),
        _buildInfoRow('Lifecycle', 'Must outlive the header'),
        _buildInfoRow('Best Practice', 'Use State with TickerProviderStateMixin'),
      ],
    ),
  );
}

Widget _buildVsyncStageBox(String label, IconData icon, Color color) {
  return Container(
    width: 90,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color, width: 1.5),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 22),
        SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 10,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildVsyncArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4),
    child: Icon(Icons.arrow_forward, color: Color(0xFF90CAF9), size: 20),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 3: CURVE PROPERTY
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildCurvePropertySection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('curve Property', Icons.show_chart),
        Text(
          'The curve property defines the easing function for the snap animation. '
          'Different curves create different visual effects - from smooth ease-in-out '
          'to bouncy elastic effects. Defaults to Curves.ease.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Common Animation Curves',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20),
                ),
              ),
              SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  _buildCurveChip('ease', Color(0xFF2E7D32)),
                  _buildCurveChip('easeIn', Color(0xFF1565C0)),
                  _buildCurveChip('easeOut', Color(0xFF6A1B9A)),
                  _buildCurveChip('easeInOut', Color(0xFFE65100)),
                  _buildCurveChip('linear', Color(0xFF455A64)),
                  _buildCurveChip('bounceOut', Color(0xFFC62828)),
                  _buildCurveChip('elasticOut', Color(0xFF00838F)),
                  _buildCurveChip('decelerate', Color(0xFF4E342E)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFFFE082)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.tips_and_updates, color: Color(0xFFF57F17), size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Curve Selection Tips',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF57F17),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              _buildInfoRow('Standard UX', 'Curves.ease or easeInOut'),
              _buildInfoRow('Playful Feel', 'Curves.bounceOut or elasticOut'),
              _buildInfoRow('Quick Snap', 'Curves.easeOut with short duration'),
            ],
          ),
        ),
        SizedBox(height: 12),
        _buildInfoRow('Type', 'Curve'),
        _buildInfoRow('Default', 'Curves.ease'),
        _buildInfoRow('Optional', 'Yes - uses default if not specified'),
      ],
    ),
  );
}

Widget _buildCurveChip(String name, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color.withAlpha(100)),
    ),
    child: Text(
      name,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 4: DURATION PROPERTY
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildDurationPropertySection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('duration Property', Icons.timer),
        Text(
          'The duration property sets how long the snap animation takes to complete. '
          'Shorter durations feel snappier while longer durations feel smoother. '
          'The default is 300 milliseconds.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Duration Comparison',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE65100),
                ),
              ),
              SizedBox(height: 16),
              _buildDurationBar('Fast', '100-150ms', 0.25, Color(0xFF4CAF50)),
              SizedBox(height: 8),
              _buildDurationBar('Default', '300ms', 0.5, Color(0xFF2196F3)),
              SizedBox(height: 8),
              _buildDurationBar('Smooth', '400-500ms', 0.75, Color(0xFF9C27B0)),
              SizedBox(height: 8),
              _buildDurationBar('Slow', '600ms+', 1.0, Color(0xFFFF5722)),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.speed, color: Color(0xFF1565C0), size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Duration affects perceived responsiveness. Faster animations '
                  '(150-300ms) feel more responsive, while slower animations '
                  '(400ms+) feel more elegant.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF0D47A1)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        _buildInfoRow('Type', 'Duration'),
        _buildInfoRow('Default', 'Duration(milliseconds: 300)'),
        _buildInfoRow('Optional', 'Yes - uses default if not specified'),
      ],
    ),
  );
}

Widget _buildDurationBar(String label, String time, double fillPercent, Color color) {
  return Row(
    children: [
      SizedBox(
        width: 60,
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: color,
            fontSize: 12,
          ),
        ),
      ),
      Expanded(
        child: Container(
          height: 20,
          decoration: BoxDecoration(
            color: Colors.grey.withAlpha(30),
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: fillPercent,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ),
      SizedBox(width: 8),
      SizedBox(
        width: 70,
        child: Text(
          time,
          style: TextStyle(
            fontSize: 11,
            color: Color(0xFF546E7A),
          ),
        ),
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 5: SLIVER PERSISTENT HEADER DEMOS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildSliverPersistentHeaderSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('SliverPersistentHeader Integration', Icons.view_headline),
        Text(
          'FloatingHeaderSnapConfiguration is used with SliverPersistentHeader through '
          'the delegate\'s snapConfiguration property. The header must have floating '
          'set to true for snap behavior to work.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Header Configuration Flow',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C),
                ),
              ),
              SizedBox(height: 16),
              _buildFlowStep('1', 'Create SnapConfiguration', 'FloatingHeaderSnapConfiguration(vsync: this)', Color(0xFF1565C0)),
              _buildFlowConnector(),
              _buildFlowStep('2', 'Implement Delegate', 'SliverPersistentHeaderDelegate subclass', Color(0xFF2E7D32)),
              _buildFlowConnector(),
              _buildFlowStep('3', 'Override snapConfiguration', 'Return the configuration getter', Color(0xFFE65100)),
              _buildFlowConnector(),
              _buildFlowStep('4', 'Use SliverPersistentHeader', 'Set floating: true, delegate: myDelegate', Color(0xFF6A1B9A)),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFEDE7F6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.code, color: Color(0xFF512DA8), size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Delegate Requirements',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF512DA8),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              _buildInfoRow('floating', 'Must be true for snap'),
              _buildInfoRow('snapConfiguration', 'Override to return config'),
              _buildInfoRow('maxExtent', 'Header expanded height'),
              _buildInfoRow('minExtent', 'Header collapsed height'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildFlowStep(String number, String title, String description, Color color) {
  return Row(
    children: [
      Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            number,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
      SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 13,
              ),
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF546E7A),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildFlowConnector() {
  return Padding(
    padding: EdgeInsets.only(left: 13),
    child: Container(
      width: 2,
      height: 16,
      color: Color(0xFFBDBDBD),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 6: SNAP ANIMATIONS VISUAL
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildSnapAnimationsVisualSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Snap Animation Visual', Icons.animation),
        Text(
          'The snap animation triggers when scrolling stops with the header '
          'partially visible. Based on the current scroll extent, the header '
          'animates to either fully expanded or fully collapsed state.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFE8EAF6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Snap Behavior Diagram',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A237E),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSnapStateVisual('Expanded', 1.0, Color(0xFF4CAF50)),
                  _buildSnapStateVisual('Mid (>50%)', 0.65, Color(0xFFFF9800)),
                  _buildSnapStateVisual('Mid (<50%)', 0.35, Color(0xFFFF9800)),
                  _buildSnapStateVisual('Collapsed', 0.0, Color(0xFFF44336)),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSnapDirectionIndicator('Snaps Up', Icons.arrow_upward, Color(0xFF4CAF50)),
                  SizedBox(width: 40),
                  _buildSnapDirectionIndicator('Snaps Down', Icons.arrow_downward, Color(0xFFF44336)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFE0F7FA),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.rule, color: Color(0xFF00838F), size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Snap Threshold Logic',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00838F),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              _buildInfoRow('> 50% visible', 'Snaps to fully expanded'),
              _buildInfoRow('< 50% visible', 'Snaps to fully collapsed'),
              _buildInfoRow('Velocity check', 'Fast scroll may override threshold'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSnapStateVisual(String label, double fillPercent, Color color) {
  return Column(
    children: [
      Container(
        width: 50,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey.withAlpha(30),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.withAlpha(60)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 50,
              height: 80 * fillPercent,
              decoration: BoxDecoration(
                color: color.withAlpha(180),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                  topLeft: Radius.circular(fillPercent == 1.0 ? 5 : 0),
                  topRight: Radius.circular(fillPercent == 1.0 ? 5 : 0),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 6),
      Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Widget _buildSnapDirectionIndicator(String label, IconData icon, Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: color.withAlpha(25),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 18),
      ),
      SizedBox(width: 6),
      Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: color,
          fontSize: 12,
        ),
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 7: MULTIPLE CONFIGURATIONS COMPARISON
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildMultipleConfigurationsSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Configuration Comparison', Icons.compare),
        Text(
          'Different curve and duration combinations create distinct user experiences. '
          'Choose configurations based on your app\'s design language and user expectations.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        _buildConfigCard(
          'Standard Configuration',
          'Curves.ease, 300ms',
          'Balanced feel suitable for most applications',
          Color(0xFF1565C0),
          Icons.check_circle,
        ),
        SizedBox(height: 12),
        _buildConfigCard(
          'Snappy Configuration',
          'Curves.easeOut, 150ms',
          'Quick and responsive for power users',
          Color(0xFF2E7D32),
          Icons.flash_on,
        ),
        SizedBox(height: 12),
        _buildConfigCard(
          'Smooth Configuration',
          'Curves.easeInOutCubic, 400ms',
          'Elegant transitions for premium feel',
          Color(0xFF6A1B9A),
          Icons.auto_awesome,
        ),
        SizedBox(height: 12),
        _buildConfigCard(
          'Playful Configuration',
          'Curves.bounceOut, 500ms',
          'Fun bounce effect for casual apps',
          Color(0xFFE65100),
          Icons.sports_basketball,
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFFCE4EC),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFF48FB1)),
          ),
          child: Row(
            children: [
              Icon(Icons.warning_amber, color: Color(0xFFC2185B), size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Avoid overly long durations (>600ms) as they can make '
                  'the interface feel sluggish and unresponsive.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF880E4F)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildConfigCard(String title, String params, String description, Color color, IconData icon) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withAlpha(12),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(50)),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withAlpha(25),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 2),
              Text(
                params,
                style: TextStyle(
                  fontSize: 12,
                  color: color.withAlpha(180),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF546E7A),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader(
          'FloatingHeaderSnapConfiguration',
          'Configuration for floating header snapping behavior',
        ),
        SizedBox(height: 20),
        _buildConfigurationOverviewSection(),
        SizedBox(height: 16),
        _buildVsyncPropertySection(),
        SizedBox(height: 16),
        _buildCurvePropertySection(),
        SizedBox(height: 16),
        _buildDurationPropertySection(),
        SizedBox(height: 16),
        _buildSliverPersistentHeaderSection(),
        SizedBox(height: 16),
        _buildSnapAnimationsVisualSection(),
        SizedBox(height: 16),
        _buildMultipleConfigurationsSection(),
        SizedBox(height: 24),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.check_circle, color: Color(0xFF6A1B9A), size: 32),
              SizedBox(height: 8),
              Text(
                'FloatingHeaderSnapConfiguration Deep Demo Complete',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Snap configuration architecture visualized',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF7B1FA2),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
