// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep demo for PersistentHeaderShowOnScreenConfiguration from rendering
//
// PersistentHeaderShowOnScreenConfiguration defines how persistent headers
// reveal themselves when showOnScreen is invoked. It controls the extent
// range that determines header visibility during programmatic scrolling.
//
// Key properties:
//   - minShowOnScreenExtent: Minimum pixels to reveal
//   - maxShowOnScreenExtent: Maximum pixels to reveal
//   - Controls gradual header reveal behavior
//
// Use cases:
//   - App bars with controlled reveal
//   - Pinned headers in custom scroll views
//   - Accessibility-driven header exposure
//   - Programmatic scroll-to-item scenarios
//
// Related classes:
//   - RenderSliverPersistentHeader: Uses this configuration
//   - SliverPersistentHeader: Widget that creates the render object
//   - SliverAppBar: Common consumer of persistent headers
//   - RenderViewportBase: Coordinates showOnScreen calls
//
// This demo visualizes configuration effects on header visibility.

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
        colors: [Color(0xFF7B1FA2), Color(0xFFBA68C8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF7B1FA2).withAlpha(100),
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.view_day, size: 48, color: Colors.white),
        SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
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
            color: Color(0xFFCE93D8).withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Color(0xFF7B1FA2), size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF7B1FA2),
            ),
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
          width: 150,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF7B1FA2),
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? Color(0xFF9C27B0),
              fontSize: 13,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDiagramBox(String label, Color color, {IconData? icon, double width = 100}) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color, width: 2),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) Icon(icon, color: color, size: 20),
        if (icon != null) SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildArrow({bool vertical = false, Color color = Colors.grey}) {
  if (vertical) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 2, height: 20, color: color),
        Icon(Icons.arrow_drop_down, color: color, size: 20),
      ],
    );
  }
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(width: 20, height: 2, color: color),
      Icon(Icons.arrow_right, color: color, size: 20),
    ],
  );
}

Widget _buildExtentIndicator(String label, double value, Color color) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(100)),
    ),
    child: Row(
      children: [
        Icon(Icons.straighten, color: color, size: 18),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: color,
            fontSize: 12,
          ),
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '${value.toStringAsFixed(0)}px',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 1: CONFIGURATION BASICS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildConfigurationBasicsSection() {
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
        _buildSectionTitle('Configuration Basics', Icons.settings),
        Text(
          'PersistentHeaderShowOnScreenConfiguration is an immutable data class '
          'that specifies how much of a persistent header should be revealed '
          'when showOnScreen is called. It provides fine-grained control over '
          'the reveal animation extent range.',
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
                'Configuration Structure',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A),
                ),
              ),
              SizedBox(height: 16),
              _buildDiagramBox(
                'PersistentHeader\nShowOnScreenConfiguration',
                Color(0xFF7B1FA2),
                icon: Icons.tune,
                width: 180,
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildArrow(vertical: true, color: Color(0xFFAB47BC)),
                  SizedBox(width: 60),
                  _buildArrow(vertical: true, color: Color(0xFFAB47BC)),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPropertyBox('minShowOnScreen\nExtent', Color(0xFF43A047)),
                  SizedBox(width: 20),
                  _buildPropertyBox('maxShowOnScreen\nExtent', Color(0xFF1E88E5)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildInfoRow('Class Type', 'Immutable configuration object'),
        _buildInfoRow('Purpose', 'Controls header reveal behavior'),
        _buildInfoRow('Default', 'minExtent=negInfinity, maxExtent=infinity'),
        _buildInfoRow('Equality', 'Value-based equality comparison'),
      ],
    ),
  );
}

Widget _buildPropertyBox(String label, Color color) {
  return Container(
    width: 110,
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color, width: 1.5),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: color,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 2: MIN SHOW ON SCREEN EXTENT
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildMinShowOnScreenExtentSection() {
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
        _buildSectionTitle('minShowOnScreenExtent', Icons.vertical_align_bottom),
        Text(
          'The minimum number of pixels of the persistent header that must '
          'be visible when showOnScreen is invoked. This ensures at least '
          'this much of the header appears, providing a baseline visibility.',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.minimize, color: Color(0xFF2E7D32), size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Minimum Extent Behavior',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              _buildMinExtentDiagram(),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildExtentIndicator('Minimum Extent', 56, Color(0xFF43A047)),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Color(0xFFF57F17), size: 18),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Setting minShowOnScreenExtent to negativeInfinity allows the header '
                  'to remain fully collapsed during showOnScreen calls.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFF57F17),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        _buildInfoRow('Default Value', 'double.negativeInfinity'),
        _buildInfoRow('Type', 'double'),
        _buildInfoRow('Constraint', 'Must be <= maxShowOnScreenExtent'),
      ],
    ),
  );
}

Widget _buildMinExtentDiagram() {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Header\nExtent',
            style: TextStyle(fontSize: 10, color: Color(0xFF2E7D32)),
          ),
          SizedBox(width: 8),
          Container(
            width: 180,
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF81C784)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 30,
                    color: Color(0xFF43A047).withAlpha(60),
                    child: Center(
                      child: Text(
                        'minExtent Zone',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF2E7D32),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 30,
                  child: Container(
                    height: 2,
                    color: Color(0xFF43A047),
                  ),
                ),
                Positioned(
                  right: 4,
                  bottom: 32,
                  child: Text(
                    'min threshold',
                    style: TextStyle(
                      fontSize: 8,
                      color: Color(0xFF43A047),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 3: MAX SHOW ON SCREEN EXTENT
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildMaxShowOnScreenExtentSection() {
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
        _buildSectionTitle('maxShowOnScreenExtent', Icons.vertical_align_top),
        Text(
          'The maximum number of pixels of the persistent header that will '
          'be revealed when showOnScreen is called. This caps how much of '
          'the header gets exposed, even if more space is available.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.maximize, color: Color(0xFF1565C0), size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Maximum Extent Behavior',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1565C0),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              _buildMaxExtentDiagram(),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildExtentIndicator('Maximum Extent', 200, Color(0xFF1E88E5)),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFE8EAF6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.all_inclusive, color: Color(0xFF3949AB), size: 18),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Setting maxShowOnScreenExtent to double.infinity allows '
                  'the header to fully expand when space permits.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF3949AB),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        _buildInfoRow('Default Value', 'double.infinity'),
        _buildInfoRow('Type', 'double'),
        _buildInfoRow('Constraint', 'Must be >= minShowOnScreenExtent'),
      ],
    ),
  );
}

Widget _buildMaxExtentDiagram() {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Header\nExtent',
            style: TextStyle(fontSize: 10, color: Color(0xFF1565C0)),
          ),
          SizedBox(width: 8),
          Container(
            width: 180,
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF90CAF9)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: Container(
                    height: 50,
                    color: Color(0xFF1E88E5).withAlpha(60),
                    child: Center(
                      child: Text(
                        'maxExtent Zone',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF1565C0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 50,
                  child: Container(
                    height: 2,
                    color: Color(0xFF1E88E5),
                  ),
                ),
                Positioned(
                  right: 4,
                  top: 54,
                  child: Text(
                    'max threshold',
                    style: TextStyle(
                      fontSize: 8,
                      color: Color(0xFF1E88E5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 4: SHOW ON SCREEN SEMANTICS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildShowOnScreenSemanticsSection() {
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
        _buildSectionTitle('showOnScreen Semantics', Icons.visibility),
        Text(
          'When scrollable content needs to ensure a widget is visible, '
          'showOnScreen propagates through the render tree. For persistent '
          'headers, this configuration determines how much of the header '
          'is revealed during this process.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFFCE4EC),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'showOnScreen Call Flow',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC2185B),
                ),
              ),
              SizedBox(height: 16),
              _buildShowOnScreenFlowDiagram(),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.touch_app, color: Color(0xFF6A1B9A), size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Trigger Scenarios',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6A1B9A),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              _buildTriggerRow('Focus change', 'TextField receives focus'),
              _buildTriggerRow('Accessibility', 'Screen reader navigation'),
              _buildTriggerRow('Programmatic', 'Scrollable.ensureVisible()'),
              _buildTriggerRow('Semantics', 'Semantic actions request'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildShowOnScreenFlowDiagram() {
  return Column(
    children: [
      _buildFlowStep('RenderObject.showOnScreen()', Color(0xFFE91E63), Icons.play_arrow),
      _buildArrow(vertical: true, color: Color(0xFFE91E63)),
      _buildFlowStep('Viewport processes request', Color(0xFFE91E63), Icons.grid_view),
      _buildArrow(vertical: true, color: Color(0xFFE91E63)),
      _buildFlowStep('Header checks configuration', Color(0xFF9C27B0), Icons.settings),
      _buildArrow(vertical: true, color: Color(0xFF9C27B0)),
      _buildFlowStep('Clamp to [min, max] extent', Color(0xFF7B1FA2), Icons.swap_vert),
      _buildArrow(vertical: true, color: Color(0xFF7B1FA2)),
      _buildFlowStep('Reveal header amount', Color(0xFF4A148C), Icons.visibility),
    ],
  );
}

Widget _buildFlowStep(String label, Color color, IconData icon) {
  return Container(
    width: 200,
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color, width: 1.5),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTriggerRow(String trigger, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: Color(0xFF9C27B0),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        SizedBox(
          width: 90,
          child: Text(
            trigger,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 11,
              color: Color(0xFF6A1B9A),
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF8E24AA),
            ),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 5: CUSTOM CONFIGURATIONS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildCustomConfigurationsSection() {
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
        _buildSectionTitle('Custom Configurations', Icons.tune),
        Text(
          'Different app bar behaviors require different configurations. '
          'Here are common patterns for customizing header reveal behavior '
          'to match specific UX requirements.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        _buildConfigExample(
          'Always Collapsed',
          'Keep header minimal during showOnScreen',
          'min: 56, max: 56',
          Color(0xFFE65100),
          Icons.unfold_less,
        ),
        SizedBox(height: 12),
        _buildConfigExample(
          'Always Expanded',
          'Fully reveal header on any showOnScreen',
          'min: 200, max: 200',
          Color(0xFF00695C),
          Icons.unfold_more,
        ),
        SizedBox(height: 12),
        _buildConfigExample(
          'Flexible Range',
          'Allow partial reveal based on space',
          'min: 56, max: 150',
          Color(0xFF1565C0),
          Icons.swap_vert,
        ),
        SizedBox(height: 12),
        _buildConfigExample(
          'No Constraints',
          'Default behavior, reveal as needed',
          'min: -inf, max: inf',
          Color(0xFF6A1B9A),
          Icons.all_inclusive,
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFECEFF1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Configuration Selection Tips',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF37474F),
                  fontSize: 13,
                ),
              ),
              SizedBox(height: 8),
              _buildTipRow('Use fixed values for consistent UX'),
              _buildTipRow('Match minExtent to toolbar height'),
              _buildTipRow('Consider accessibility requirements'),
              _buildTipRow('Test with keyboard navigation'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildConfigExample(String name, String description, String values, Color color, IconData icon) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
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
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            values,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTipRow(String tip) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Icon(Icons.check_circle_outline, size: 14, color: Color(0xFF546E7A)),
        SizedBox(width: 8),
        Text(
          tip,
          style: TextStyle(fontSize: 12, color: Color(0xFF546E7A)),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 6: HEADER VISIBILITY STATES
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildHeaderVisibilityStatesSection() {
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
        _buildSectionTitle('Header Visibility States', Icons.layers),
        Text(
          'A persistent header transitions between visibility states '
          'as the user scrolls and as showOnScreen requests are processed. '
          'The configuration bounds determine achievable states.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE8EAF6), Color(0xFFC5CAE9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'State Transition Diagram',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF283593),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStateBox('Collapsed', Color(0xFFE53935), Icons.compress),
                  _buildStateBox('Partial', Color(0xFFFB8C00), Icons.unfold_less),
                  _buildStateBox('Expanded', Color(0xFF43A047), Icons.unfold_more),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildArrow(color: Color(0xFF5C6BC0)),
                  SizedBox(width: 20),
                  _buildArrow(color: Color(0xFF5C6BC0)),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'showOnScreen triggers state changes within configured bounds',
                style: TextStyle(
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF3949AB),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildVisibilityConstraintRow(
          'Below minExtent',
          'Header scrolls to minShowOnScreenExtent',
          Color(0xFFE53935),
        ),
        SizedBox(height: 8),
        _buildVisibilityConstraintRow(
          'Within range',
          'Header maintains current position',
          Color(0xFFFB8C00),
        ),
        SizedBox(height: 8),
        _buildVisibilityConstraintRow(
          'Above maxExtent',
          'Header scrolls to maxShowOnScreenExtent',
          Color(0xFF43A047),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFE0F2F1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: Color(0xFF00695C), size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Visibility Best Practices',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00695C),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Consider user expectations when configuring visibility. '
                'Most users expect app bars to remain visible during focus '
                'changes. Test with assistive technologies to ensure '
                'configurations work well for all users.',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF00695C),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildStateBox(String label, Color color, IconData icon) {
  return Container(
    width: 80,
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color, width: 2),
      boxShadow: [
        BoxShadow(
          color: color.withAlpha(40),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 22),
        SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _buildVisibilityConstraintRow(String state, String behavior, Color color) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 10),
        SizedBox(
          width: 100,
          child: Text(
            state,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Text(
            behavior,
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF546E7A),
            ),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN WIDGET
// ═══════════════════════════════════════════════════════════════════════════════

Widget buildPersistentHeaderShowOnScreenConfigurationDemo() {
  return Container(
    color: Color(0xFFF5F5F5),
    child: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(
            'PersistentHeaderShowOnScreenConfiguration',
            'Controls persistent header reveal behavior during showOnScreen calls',
          ),
          SizedBox(height: 20),
          _buildConfigurationBasicsSection(),
          SizedBox(height: 16),
          _buildMinShowOnScreenExtentSection(),
          SizedBox(height: 16),
          _buildMaxShowOnScreenExtentSection(),
          SizedBox(height: 16),
          _buildShowOnScreenSemanticsSection(),
          SizedBox(height: 16),
          _buildCustomConfigurationsSection(),
          SizedBox(height: 16),
          _buildHeaderVisibilityStatesSection(),
          SizedBox(height: 16),
          _buildApiReferenceSection(),
          SizedBox(height: 20),
          _buildFooterSection(),
        ],
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// API REFERENCE SECTION
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildApiReferenceSection() {
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
        _buildSectionTitle('API Reference', Icons.code),
        _buildApiCard(
          'Constructor',
          [
            'PersistentHeaderShowOnScreenConfiguration({',
            '  double minShowOnScreenExtent,',
            '  double maxShowOnScreenExtent,',
            '})',
          ],
          Color(0xFF7B1FA2),
        ),
        SizedBox(height: 12),
        _buildApiCard(
          'Properties',
          [
            'minShowOnScreenExtent -> double',
            'maxShowOnScreenExtent -> double',
          ],
          Color(0xFF1565C0),
        ),
        SizedBox(height: 12),
        _buildApiCard(
          'Operators',
          [
            'operator ==(Object other) -> bool',
            'hashCode -> int',
          ],
          Color(0xFF43A047),
        ),
        SizedBox(height: 12),
        _buildApiCard(
          'Usage Context',
          [
            'RenderSliverPersistentHeader.showOnScreenConfiguration',
            'SliverPersistentHeaderDelegate.showOnScreenConfiguration',
          ],
          Color(0xFFE65100),
        ),
      ],
    ),
  );
}

Widget _buildApiCard(String title, List<String> items, Color color) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(12),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(50)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 14,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items.map((item) => Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text(
                item,
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: Color(0xFFB0BEC5),
                ),
              ),
            )).toList(),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// FOOTER SECTION
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildFooterSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF6A1B9A), Color(0xFF9C27B0)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Icon(Icons.auto_awesome, color: Colors.white, size: 32),
        SizedBox(height: 12),
        Text(
          'Configuration Summary',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'PersistentHeaderShowOnScreenConfiguration provides precise control over '
          'header visibility during programmatic scroll operations. Use it to ensure '
          'consistent user experience across different interaction modes.',
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withAlpha(220),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFooterStat('2', 'Properties'),
            SizedBox(width: 24),
            _buildFooterStat('4', 'Use Cases'),
            SizedBox(width: 24),
            _buildFooterStat('3', 'States'),
          ],
        ),
      ],
    ),
  );
}

Widget _buildFooterStat(String value, String label) {
  return Column(
    children: [
      Text(
        value,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: Colors.white.withAlpha(180),
        ),
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// ENTRY POINT
// ═══════════════════════════════════════════════════════════════════════════════

void main() {
  runApp(
    MaterialApp(
      title: 'PersistentHeaderShowOnScreenConfiguration Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Color(0xFF7B1FA2),
      ),
      home: Scaffold(
        body: buildPersistentHeaderShowOnScreenConfigurationDemo(),
      ),
    ),
  );
}
