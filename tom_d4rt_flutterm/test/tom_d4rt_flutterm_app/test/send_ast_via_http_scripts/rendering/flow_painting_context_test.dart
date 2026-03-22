// D4rt test script: Deep demo for FlowPaintingContext from rendering
//
// FlowPaintingContext - context for painting Flow widget children.
// It provides methods for querying child information and painting
// children with arbitrary transformations during the paint phase.
//
// Key responsibilities:
//   - Provides Flow widget size via size property
//   - Reports child count via childCount property
//   - Gets child sizes via getChildSize(int) method
//   - Paints children via paintChild(int, {Matrix4? transform})
//
// Related classes:
//   - FlowDelegate: Abstract class implementing layout and paint logic
//   - Flow: Widget that positions children using FlowDelegate
//   - RenderFlow: RenderObject that implements Flow
//   - FlowParentData: ParentData for Flow children
//
// Use cases:
//   - Animated grid layouts
//   - Radial menus
//   - Staggered animations
//   - Complex positioning without relayout
//
// This demo visualizes the FlowPaintingContext APIs and capabilities.

// ignore_for_file: avoid_print, deprecated_member_use, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'dart:math' as math;

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
        Icon(Icons.gesture, size: 48, color: Colors.white),
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

Widget _buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        color: Color(0xFF80CBC4),
      ),
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

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 1: FLOW PAINTING CONTEXT OVERVIEW
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildOverviewSection() {
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
        _buildSectionTitle('FlowPaintingContext Overview', Icons.layers),
        Text(
          'FlowPaintingContext is an abstract class that serves as the interface '
          'between FlowDelegate and the rendering system. It provides essential '
          'information about children and methods for painting them with transforms.',
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
                'Context Architecture',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C),
                ),
              ),
              SizedBox(height: 16),
              _buildDiagramBox(
                'FlowDelegate',
                Color(0xFF7B1FA2),
                icon: Icons.settings,
                width: 130,
              ),
              SizedBox(height: 8),
              _buildArrow(vertical: true, color: Color(0xFFAB47BC)),
              SizedBox(height: 8),
              _buildDiagramBox(
                'FlowPaintingContext',
                Color(0xFF6A1B9A),
                icon: Icons.gesture,
                width: 150,
              ),
              SizedBox(height: 8),
              _buildArrow(vertical: true, color: Color(0xFFAB47BC)),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDiagramBox('size', Color(0xFF00897B), icon: Icons.crop_square),
                  SizedBox(width: 8),
                  _buildDiagramBox('childCount', Color(0xFF00897B), icon: Icons.numbers),
                  SizedBox(width: 8),
                  _buildDiagramBox('paintChild', Color(0xFF00897B), icon: Icons.brush),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildInfoRow('Abstract Class', 'FlowPaintingContext'),
        _buildInfoRow('Implementor', 'RenderFlow (internal)'),
        _buildInfoRow('Consumer', 'FlowDelegate.paintChildren()'),
        _buildInfoRow('Purpose', 'Paint children with transforms'),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 2: PAINT CHILD METHOD
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildPaintChildSection() {
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
        _buildSectionTitle('paintChild Method', Icons.brush),
        Text(
          'The paintChild method is the primary API for painting Flow children. '
          'It accepts a child index and an optional Matrix4 transform that '
          'positions and transforms the child without triggering layout.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 16),
        _buildCodeBlock(
          'void paintChild(int childIndex, {Matrix4? transform})\n\n'
          '// Parameters:\n'
          '//   childIndex: 0 to childCount-1\n'
          '//   transform: Optional positioning matrix',
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.lightbulb, color: Color(0xFF2E7D32), size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Key Behaviors',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              _buildInfoRow('Null transform', 'Child paints at origin (0,0)'),
              _buildInfoRow('Invalid index', 'Throws RangeError'),
              _buildInfoRow('Paint order', 'Children paint in order called'),
              _buildInfoRow('Duplicate paint', 'Same child can paint multiple times'),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Paint Call Flow',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE65100),
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDiagramBox('paintChild()', Color(0xFFF57C00), icon: Icons.play_arrow),
                  _buildArrow(color: Color(0xFFFFB74D)),
                  _buildDiagramBox('Apply Matrix', Color(0xFFFF9800), icon: Icons.transform),
                  _buildArrow(color: Color(0xFFFFB74D)),
                  _buildDiagramBox('Paint Child', Color(0xFFFFB300), icon: Icons.brush),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 3: FLOW DELEGATE DEMOS
// ═══════════════════════════════════════════════════════════════════════════════

class CircularFlowDelegate extends FlowDelegate {
  CircularFlowDelegate({required this.animation}) : super(repaint: animation);
  
  Animation<double> animation;

  @override
  void paintChildren(FlowPaintingContext context) {
    int n = context.childCount;
    Size size = context.size;
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = math.min(centerX, centerY) - 40;
    
    for (int i = 0; i < n; i++) {
      Size? childSize = context.getChildSize(i);
      if (childSize == null) continue;
      
      double angle = 2 * math.pi * i / n + animation.value * 2 * math.pi;
      double x = centerX + radius * math.cos(angle) - childSize.width / 2;
      double y = centerY + radius * math.sin(angle) - childSize.height / 2;
      
      Matrix4 transform = Matrix4.translationValues(x, y, 0);
      context.paintChild(i, transform: transform);
    }
  }

  @override
  bool shouldRepaint(CircularFlowDelegate oldDelegate) {
    return animation != oldDelegate.animation;
  }
}

class WaveFlowDelegate extends FlowDelegate {
  WaveFlowDelegate({required this.animation}) : super(repaint: animation);
  
  Animation<double> animation;

  @override
  void paintChildren(FlowPaintingContext context) {
    double dx = 0;
    for (int i = 0; i < context.childCount; i++) {
      Size? childSize = context.getChildSize(i);
      if (childSize == null) continue;
      
      double phase = animation.value * 2 * math.pi + i * 0.5;
      double dy = math.sin(phase) * 30 + 50;
      
      Matrix4 transform = Matrix4.translationValues(dx, dy, 0);
      context.paintChild(i, transform: transform);
      
      dx += childSize.width + 8;
    }
  }

  @override
  bool shouldRepaint(WaveFlowDelegate oldDelegate) {
    return animation != oldDelegate.animation;
  }
}

Widget _buildFlowDelegateSection() {
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
        _buildSectionTitle('Flow Delegate Demos', Icons.animation),
        Text(
          'FlowDelegate implementations use FlowPaintingContext in paintChildren() '
          'to position children. The context provides child sizes and allows '
          'painting with Matrix4 transforms for efficient animations.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 16),
        _buildCodeBlock(
          'class CircularFlowDelegate extends FlowDelegate {\n'
          '  @override\n'
          '  void paintChildren(FlowPaintingContext context) {\n'
          '    for (int i = 0; i < context.childCount; i++) {\n'
          '      Size? childSize = context.getChildSize(i);\n'
          '      double angle = 2 * pi * i / context.childCount;\n'
          '      Matrix4 transform = Matrix4.translationValues(\n'
          '        centerX + radius * cos(angle),\n'
          '        centerY + radius * sin(angle),\n'
          '        0,\n'
          '      );\n'
          '      context.paintChild(i, transform: transform);\n'
          '    }\n'
          '  }\n'
          '}',
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.category, color: Color(0xFF1565C0), size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Delegate Types',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1565C0),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              _buildInfoRow('CircularFlowDelegate', 'Arranges children in a circle'),
              _buildInfoRow('WaveFlowDelegate', 'Creates wave motion effect'),
              _buildInfoRow('GridFlowDelegate', 'Positions in grid pattern'),
              _buildInfoRow('SpiralFlowDelegate', 'Creates spiral arrangement'),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 4: CHILD TRANSFORMATION
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildChildTransformationSection() {
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
        _buildSectionTitle('Child Transformation', Icons.transform),
        Text(
          'The Matrix4 transform parameter enables complex child positioning. '
          'Transformations include translation, rotation, scaling, and '
          'combinations thereof, all without triggering re-layout.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFEDE7F6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Transform Types',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4527A0),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTransformDemo('Translate', Icons.open_with, Color(0xFF1E88E5)),
                  _buildTransformDemo('Rotate', Icons.rotate_right, Color(0xFF43A047)),
                  _buildTransformDemo('Scale', Icons.zoom_out_map, Color(0xFFE53935)),
                  _buildTransformDemo('Skew', Icons.compare_arrows, Color(0xFF8E24AA)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildCodeBlock(
          '// Translation\n'
          'Matrix4.translationValues(100, 50, 0)\n\n'
          '// Rotation around Z axis\n'
          'Matrix4.rotationZ(math.pi / 4)\n\n'
          '// Scale (2x)\n'
          'Matrix4.diagonal3Values(2.0, 2.0, 1.0)\n\n'
          '// Combined transforms\n'
          'Matrix4.identity()\n'
          '  ..translate(100.0, 50.0)\n'
          '  ..rotateZ(math.pi / 4)\n'
          '  ..scale(1.5)',
        ),
      ],
    ),
  );
}

Widget _buildTransformDemo(String label, IconData icon, Color color) {
  return Column(
    children: [
      Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color.withAlpha(30),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color, width: 2),
        ),
        child: Icon(icon, color: color, size: 24),
      ),
      SizedBox(height: 4),
      Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 5: OPACITY AND POSITIONING
// ═══════════════════════════════════════════════════════════════════════════════

class FadeFlowDelegate extends FlowDelegate {
  FadeFlowDelegate({required this.animation}) : super(repaint: animation);
  
  Animation<double> animation;

  @override
  void paintChildren(FlowPaintingContext context) {
    for (int i = 0; i < context.childCount; i++) {
      Size? childSize = context.getChildSize(i);
      if (childSize == null) continue;
      
      double spacing = 60;
      double dx = i * spacing;
      
      Matrix4 transform = Matrix4.translationValues(dx, 40, 0);
      context.paintChild(i, transform: transform);
    }
  }

  @override
  bool shouldRepaint(FadeFlowDelegate oldDelegate) {
    return animation != oldDelegate.animation;
  }
}

Widget _buildOpacityPositioningSection() {
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
        _buildSectionTitle('Opacity and Positioning', Icons.opacity),
        Text(
          'While FlowPaintingContext does not directly support opacity, '
          'children can use Opacity or FadeTransition widgets. Positioning '
          'is handled entirely through Matrix4 transforms in paintChild.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFE0F7FA),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'Positioning Strategies',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF006064),
                ),
              ),
              SizedBox(height: 16),
              _buildPositioningRow('Absolute', 'Direct translation values', Icons.place),
              SizedBox(height: 8),
              _buildPositioningRow('Relative', 'Based on parent size', Icons.aspect_ratio),
              SizedBox(height: 8),
              _buildPositioningRow('Calculated', 'Based on child sizes', Icons.calculate),
              SizedBox(height: 8),
              _buildPositioningRow('Animated', 'Using animation values', Icons.animation),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildCodeBlock(
          '// Apply opacity through child widget\n'
          'Flow(\n'
          '  delegate: myDelegate,\n'
          '  children: items.map((item) {\n'
          '    return Opacity(\n'
          '      opacity: item.opacity,\n'
          '      child: item.widget,\n'
          '    );\n'
          '  }).toList(),\n'
          ')',
        ),
      ],
    ),
  );
}

Widget _buildPositioningRow(String title, String description, IconData icon) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Color(0xFF00838F).withAlpha(30),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, color: Color(0xFF00838F), size: 16),
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
                color: Color(0xFF00838F),
                fontSize: 12,
              ),
            ),
            Text(
              description,
              style: TextStyle(
                color: Color(0xFF4DD0E1),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 6: MATRIX TRANSFORMS
// ═══════════════════════════════════════════════════════════════════════════════

class RotatingFlowDelegate extends FlowDelegate {
  RotatingFlowDelegate({required this.animation}) : super(repaint: animation);
  
  Animation<double> animation;

  @override
  void paintChildren(FlowPaintingContext context) {
    Size size = context.size;
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    
    for (int i = 0; i < context.childCount; i++) {
      Size? childSize = context.getChildSize(i);
      if (childSize == null) continue;
      
      double rotation = animation.value * 2 * math.pi + i * math.pi / 4;
      double scale = 0.8 + 0.2 * math.sin(animation.value * 2 * math.pi);
      
      Matrix4 transform = Matrix4.identity()
        ..translate(centerX, centerY)
        ..rotateZ(rotation)
        ..scale(scale)
        ..translate(-childSize.width / 2, -childSize.height / 2);
      
      context.paintChild(i, transform: transform);
    }
  }

  @override
  bool shouldRepaint(RotatingFlowDelegate oldDelegate) {
    return animation != oldDelegate.animation;
  }
}

Widget _buildMatrixTransformsSection() {
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
        _buildSectionTitle('Matrix Transforms', Icons.grid_on),
        Text(
          'Matrix4 provides 4x4 transformation matrices for 3D transforms '
          'projected to 2D. Key operations include translation, rotation, '
          'scaling, and perspective transforms.',
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
                'Matrix4 Operations',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFAD1457),
                ),
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildMatrixOperation('translate()', Color(0xFF1976D2)),
                  _buildMatrixOperation('rotateX()', Color(0xFF388E3C)),
                  _buildMatrixOperation('rotateY()', Color(0xFF388E3C)),
                  _buildMatrixOperation('rotateZ()', Color(0xFF388E3C)),
                  _buildMatrixOperation('scale()', Color(0xFFE64A19)),
                  _buildMatrixOperation('setEntry()', Color(0xFF7B1FA2)),
                  _buildMatrixOperation('multiply()', Color(0xFF00838F)),
                  _buildMatrixOperation('invert()', Color(0xFF5D4037)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildCodeBlock(
          '// 3D rotation effect with perspective\n'
          'Matrix4 transform = Matrix4.identity()\n'
          '  ..setEntry(3, 2, 0.001)  // Perspective\n'
          '  ..rotateY(animation.value * pi)\n'
          '  ..translate(x, y);\n\n'
          '// Chain multiple transforms\n'
          'Matrix4 combined = Matrix4.identity()\n'
          '  ..translate(centerX, centerY)\n'
          '  ..rotateZ(angle)\n'
          '  ..scale(scaleFactor)\n'
          '  ..translate(-pivotX, -pivotY);',
        ),
      ],
    ),
  );
}

Widget _buildMatrixOperation(String operation, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color, width: 1),
    ),
    child: Text(
      operation,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 7: MULTIPLE CHILD LAYOUTS
// ═══════════════════════════════════════════════════════════════════════════════

class GridFlowDelegate extends FlowDelegate {
  GridFlowDelegate({required this.columns});
  
  int columns;

  @override
  void paintChildren(FlowPaintingContext context) {
    double spacing = 8;
    double maxWidth = context.size.width;
    double itemWidth = (maxWidth - (columns - 1) * spacing) / columns;
    
    for (int i = 0; i < context.childCount; i++) {
      Size? childSize = context.getChildSize(i);
      if (childSize == null) continue;
      
      int row = i ~/ columns;
      int col = i % columns;
      
      double dx = col * (itemWidth + spacing);
      double dy = row * (childSize.height + spacing);
      
      Matrix4 transform = Matrix4.translationValues(dx, dy, 0);
      context.paintChild(i, transform: transform);
    }
  }

  @override
  bool shouldRepaint(GridFlowDelegate oldDelegate) {
    return columns != oldDelegate.columns;
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return constraints.biggest;
  }
}

class StackFlowDelegate extends FlowDelegate {
  StackFlowDelegate({required this.offsetStep});
  
  double offsetStep;

  @override
  void paintChildren(FlowPaintingContext context) {
    for (int i = 0; i < context.childCount; i++) {
      double offset = i * offsetStep;
      Matrix4 transform = Matrix4.translationValues(offset, offset, 0);
      context.paintChild(i, transform: transform);
    }
  }

  @override
  bool shouldRepaint(StackFlowDelegate oldDelegate) {
    return offsetStep != oldDelegate.offsetStep;
  }
}

class RadialMenuDelegate extends FlowDelegate {
  RadialMenuDelegate({required this.animation, required this.startAngle})
      : super(repaint: animation);
  
  Animation<double> animation;
  double startAngle;

  @override
  void paintChildren(FlowPaintingContext context) {
    Size size = context.size;
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double maxRadius = math.min(centerX, centerY) * 0.8;
    double radius = maxRadius * animation.value;
    
    for (int i = 0; i < context.childCount; i++) {
      Size? childSize = context.getChildSize(i);
      if (childSize == null) continue;
      
      double angle = startAngle + (math.pi / (context.childCount - 1)) * i;
      double dx = centerX + radius * math.cos(angle) - childSize.width / 2;
      double dy = centerY + radius * math.sin(angle) - childSize.height / 2;
      
      double scale = animation.value;
      
      Matrix4 transform = Matrix4.identity()
        ..translate(dx + childSize.width / 2, dy + childSize.height / 2)
        ..scale(scale)
        ..translate(-childSize.width / 2, -childSize.height / 2);
      
      context.paintChild(i, transform: transform);
    }
  }

  @override
  bool shouldRepaint(RadialMenuDelegate oldDelegate) {
    return animation != oldDelegate.animation ||
           startAngle != oldDelegate.startAngle;
  }
}

Widget _buildMultipleChildLayoutsSection() {
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
        _buildSectionTitle('Multiple Child Layouts', Icons.view_module),
        Text(
          'FlowPaintingContext supports various layout patterns through '
          'different delegate implementations. Common patterns include '
          'grids, stacks, radial menus, and custom animated arrangements.',
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
                'Layout Patterns',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF303F9F),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildLayoutPattern('Grid', Icons.grid_view, Color(0xFF3F51B5)),
                  _buildLayoutPattern('Stack', Icons.layers, Color(0xFF009688)),
                  _buildLayoutPattern('Radial', Icons.radio_button_checked, Color(0xFFFF5722)),
                  _buildLayoutPattern('Spiral', Icons.gesture, Color(0xFF9C27B0)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildCodeBlock(
          '// Grid layout delegate\n'
          'class GridFlowDelegate extends FlowDelegate {\n'
          '  GridFlowDelegate({required this.columns});\n'
          '  int columns;\n\n'
          '  @override\n'
          '  void paintChildren(FlowPaintingContext context) {\n'
          '    for (int i = 0; i < context.childCount; i++) {\n'
          '      int row = i ~/ columns;\n'
          '      int col = i % columns;\n'
          '      double dx = col * (width + spacing);\n'
          '      double dy = row * (height + spacing);\n'
          '      context.paintChild(i, transform:\n'
          '        Matrix4.translationValues(dx, dy, 0));\n'
          '    }\n'
          '  }\n'
          '}',
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFF1F8E9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.tips_and_updates, color: Color(0xFF558B2F), size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Best Practices',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF558B2F),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              _buildInfoRow('Cache calculations', 'Store positions when independent of animation'),
              _buildInfoRow('Check null sizes', 'getChildSize can return null'),
              _buildInfoRow('Use shouldRepaint', 'Return true only when needed'),
              _buildInfoRow('Optimize repaints', 'Use repaint listenable for animations'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildLayoutPattern(String label, IconData icon, Color color) {
  return Column(
    children: [
      Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: color.withAlpha(30),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color, width: 2),
        ),
        child: Icon(icon, color: color, size: 28),
      ),
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
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('FlowPaintingContext deep demo executing');
  print('=' * 60);
  
  print('\n--- FlowPaintingContext Overview ---');
  print('FlowPaintingContext is an abstract class providing:');
  print('  - size: Size of the Flow widget');
  print('  - childCount: Number of children to paint');
  print('  - getChildSize(int): Size of child at index');
  print('  - paintChild(int, {Matrix4?}): Paint child with transform');
  print('');
  
  print('--- paintChild Method Details ---');
  print('paintChild(int childIndex, {Matrix4? transform})');
  print('  - childIndex: 0 to childCount-1');
  print('  - transform: Optional 4x4 transformation matrix');
  print('  - Null transform paints at origin (0,0)');
  print('  - Invalid index throws RangeError');
  print('');
  
  print('--- Flow Delegate Pattern ---');
  print('class MyFlowDelegate extends FlowDelegate {');
  print('  @override');
  print('  void paintChildren(FlowPaintingContext context) {');
  print('    for (int i = 0; i < context.childCount; i++) {');
  print('      Size? childSize = context.getChildSize(i);');
  print('      Matrix4 transform = Matrix4.translationValues(x, y, 0);');
  print('      context.paintChild(i, transform: transform);');
  print('    }');
  print('  }');
  print('}');
  print('');
  
  print('--- Matrix4 Transform Examples ---');
  print('Translation: Matrix4.translationValues(100, 50, 0)');
  print('Rotation Z:  Matrix4.rotationZ(math.pi / 4)');
  print('Scale:       Matrix4.diagonal3Values(2.0, 2.0, 1.0)');
  print('Combined:    Matrix4.identity()');
  print('               ..translate(100.0, 50.0)');
  print('               ..rotateZ(angle)');
  print('               ..scale(factor)');
  print('');
  
  print('--- Layout Patterns ---');
  print('Grid:    position = (col * width, row * height)');
  print('Circle:  position = (r*cos(angle), r*sin(angle))');
  print('Wave:    position = (x, sin(phase)*amplitude)');
  print('Stack:   position = (i*offset, i*offset)');
  print('Radial:  expanding arc menu arrangement');
  print('');
  
  print('--- Performance Benefits ---');
  print('1. No relayout when transforms change');
  print('2. Only paint phase updates');
  print('3. Efficient for animations');
  print('4. Direct matrix compositing');
  print('');

  return Scaffold(
    backgroundColor: Color(0xFFF5F5F5),
    appBar: AppBar(
      title: Text('FlowPaintingContext Demo'),
      backgroundColor: Color(0xFF6A1B9A),
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          _buildHeader(
            'FlowPaintingContext',
            'Context for painting Flow widget children with transforms',
          ),
          SizedBox(height: 20),
          _buildOverviewSection(),
          SizedBox(height: 16),
          _buildPaintChildSection(),
          SizedBox(height: 16),
          _buildFlowDelegateSection(),
          SizedBox(height: 16),
          _buildChildTransformationSection(),
          SizedBox(height: 16),
          _buildOpacityPositioningSection(),
          SizedBox(height: 16),
          _buildMatrixTransformsSection(),
          SizedBox(height: 16),
          _buildMultipleChildLayoutsSection(),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF6A1B9A).withAlpha(20),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFF6A1B9A).withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Color(0xFF6A1B9A), size: 24),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'FlowPaintingContext enables efficient, transform-based '
                    'child positioning without triggering layout recalculations.',
                    style: TextStyle(
                      color: Color(0xFF6A1B9A),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    ),
  );
}
