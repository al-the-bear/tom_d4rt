// D4rt test script: Deep demo for FlowPaintingContext
// FlowPaintingContext - context for painting Flow layouts
// ignore_for_file: avoid_print, deprecated_member_use, prefer_interpolation_to_compose_strings, prefer_final_fields
import 'package:flutter/material.dart';
import 'dart:math' as math;

// ════════════════════════════════════════════════════════════════════════════
// SECTION 1: FlowPaintingContext Overview
// ════════════════════════════════════════════════════════════════════════════
//
// FlowPaintingContext is an abstract class in Flutter's rendering library
// that serves as the interface between a FlowDelegate and the rendering
// layer. When implementing FlowDelegate.paintChildren(), you receive a
// FlowPaintingContext that provides:
//
//   - The overall size of the Flow widget via the size property
//   - The number of children via the childCount property
//   - Child sizes via the getChildSize(int) method
//   - Child painting via the paintChild(int, {Matrix4? transform}) method
//
// The key advantage of Flow and FlowPaintingContext is that painting with
// transforms does NOT trigger a re-layout. This makes Flow ideal for
// animations where only child positions change, not their sizes.
//
// FlowPaintingContext is abstract because the actual implementation is
// provided by RenderFlow, which passes a concrete context to delegates.
//
// ════════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('FlowPaintingContext deep demo executing');
  print('=' * 60);
  
  // Section 1: Overview
  print('\n--- SECTION 1: FlowPaintingContext Overview ---');
  print('FlowPaintingContext is an abstract class that provides:');
  print('  - size: Size of the Flow widget');
  print('  - childCount: Number of children');
  print('  - getChildSize(int i): Size of child at index i');
  print('  - paintChild(int i, {Matrix4? transform}): Paint child');
  print('');
  print('Purpose:');
  print('  Bridges FlowDelegate and the rendering layer');
  print('  Enables transform-based positioning without relayout');
  print('  Provides efficient repaint-only updates');
  
  // Section 2: paintChild Method
  print('\n--- SECTION 2: paintChild Method ---');
  print('Signature: void paintChild(int childIndex, {Matrix4? transform})');
  print('');
  print('Parameters:');
  print('  childIndex: Index of child to paint (0 to childCount-1)');
  print('  transform: Optional Matrix4 for positioning');
  print('');
  print('Behavior:');
  print('  - If transform is null, child paints at origin (0,0)');
  print('  - Transform can include translation, rotation, scale, skew');
  print('  - Each child should only be painted once per paint cycle');
  print('  - Invalid index throws assertion error');
  print('');
  print('Transform examples:');
  print('  Matrix4.translationValues(100, 50, 0) - Move to (100, 50)');
  print('  Matrix4.rotationZ(math.pi / 4) - Rotate 45 degrees');
  print('  Matrix4.diagonal3Values(2.0, 2.0, 1.0) - Scale 2x');
  
  // Section 3: getChildSize Method
  print('\n--- SECTION 3: getChildSize Method ---');
  print('Signature: Size? getChildSize(int childIndex)');
  print('');
  print('Returns:');
  print('  - Size of the child widget at given index');
  print('  - Returns null if child has not been laid out');
  print('');
  print('Usage:');
  print('  Size? size = context.getChildSize(0);');
  print('  if (size != null) {');
  print('    double width = size.width;');
  print('    double height = size.height;');
  print('  }');
  print('');
  print('Important:');
  print('  - Children are laid out with unconstrained constraints');
  print('  - Child sizes are determined during layout, not paint');
  print('  - Use getChildSize for dynamic positioning calculations');
  
  // Section 4: size Property
  print('\n--- SECTION 4: size Property ---');
  print('Signature: Size get size');
  print('');
  print('Returns:');
  print('  - The size of the Flow widget itself');
  print('  - Determined by Flow constraints and delegate');
  print('');
  print('Usage:');
  print('  Size flowSize = context.size;');
  print('  double centerX = flowSize.width / 2;');
  print('  double centerY = flowSize.height / 2;');
  print('');
  print('Common patterns:');
  print('  - Center children: (size.width - childWidth) / 2');
  print('  - Bottom-align: size.height - childHeight');
  print('  - Spacing: size.width / (childCount + 1)');
  
  // Section 5: Visual Flow Layout Examples
  print('\n--- SECTION 5: Visual Flow Layout Examples ---');
  print('');
  print('Example 1: Horizontal Layout');
  print('  for (int i = 0; i < context.childCount; i++) {');
  print('    double x = i * 50.0;');
  print('    context.paintChild(i, transform:');
  print('      Matrix4.translationValues(x, 0, 0));');
  print('  }');
  print('');
  print('Example 2: Circular Layout');
  print('  double radius = 80.0;');
  print('  double angleStep = 2 * math.pi / context.childCount;');
  print('  for (int i = 0; i < context.childCount; i++) {');
  print('    double angle = i * angleStep;');
  print('    double x = center.dx + radius * math.cos(angle);');
  print('    double y = center.dy + radius * math.sin(angle);');
  print('    context.paintChild(i, transform:');
  print('      Matrix4.translationValues(x, y, 0));');
  print('  }');
  print('');
  print('Example 3: Stacked Layout');
  print('  for (int i = 0; i < context.childCount; i++) {');
  print('    double offset = i * 10.0;');
  print('    context.paintChild(i, transform:');
  print('      Matrix4.translationValues(offset, offset, 0));');
  print('  }');
  
  // Section 6: Transformation Matrix Usage
  print('\n--- SECTION 6: Transformation Matrix Usage ---');
  print('');
  print('Matrix4 provides various factory constructors:');
  print('');
  print('Translation:');
  print('  Matrix4.translationValues(x, y, z)');
  print('  Matrix4.identity()..translate(x, y, z)');
  print('');
  print('Rotation:');
  print('  Matrix4.rotationZ(radians) - Around Z axis (2D rotation)');
  print('  Matrix4.rotationX(radians) - Around X axis (3D tilt)');
  print('  Matrix4.rotationY(radians) - Around Y axis (3D flip)');
  print('');
  print('Scale:');
  print('  Matrix4.diagonal3Values(sx, sy, sz)');
  print('  Matrix4.identity()..scale(factor)');
  print('');
  print('Combined transforms (order matters):');
  print('  var transform = Matrix4.identity()');
  print('    ..translate(cx, cy)');
  print('    ..rotateZ(angle)');
  print('    ..translate(-cx, -cy);');
  print('');
  print('Rotate around point (cx, cy):');
  print('  1. Translate point to origin');
  print('  2. Apply rotation');
  print('  3. Translate back');
  
  print('\n' + '=' * 60);
  print('FlowPaintingContext deep demo completed');
  
  return Scaffold(
    appBar: AppBar(
      title: Text('FlowPaintingContext Demo'),
      backgroundColor: Color(0xFF3F51B5),
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _OverviewSection(),
          SizedBox(height: 20),
          _PaintChildSection(),
          SizedBox(height: 20),
          _GetChildSizeSection(),
          SizedBox(height: 20),
          _SizePropertySection(),
          SizedBox(height: 20),
          _VisualExamplesSection(),
          SizedBox(height: 20),
          _TransformationMatrixSection(),
          SizedBox(height: 20),
          _InteractiveFlowDemo(),
          SizedBox(height: 20),
          _AnimatedFlowDemo(),
          SizedBox(height: 40),
        ],
      ),
    ),
  );
}

// ════════════════════════════════════════════════════════════════════════════
// Overview Section Widget
// ════════════════════════════════════════════════════════════════════════════

class _OverviewSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF3F51B5), Color(0xFF5C6BC0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.white, size: 28),
              SizedBox(width: 12),
              Text(
                'FlowPaintingContext Overview',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'FlowPaintingContext is an abstract interface passed to FlowDelegate.paintChildren(). '
            'It encapsulates all rendering operations needed to paint Flow children efficiently.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          SizedBox(height: 16),
          _buildPropertyItem('size', 'Size of the Flow widget'),
          _buildPropertyItem('childCount', 'Number of children'),
          _buildPropertyItem('getChildSize(int)', 'Get child dimensions'),
          _buildPropertyItem('paintChild(int, {Matrix4?})', 'Paint with transform'),
        ],
      ),
    );
  }
  
  Widget _buildPropertyItem(String name, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: EdgeInsets.only(top: 6, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: name,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFEB3B),
                    ),
                  ),
                  TextSpan(
                    text: ' - \$description',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// paintChild Method Section
// ════════════════════════════════════════════════════════════════════════════

class _PaintChildSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFFFB74D), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFFFF9800),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.brush, color: Colors.white),
              ),
              SizedBox(width: 12),
              Text(
                'paintChild Method',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE65100),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFF263238),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'void paintChild(int childIndex, {Matrix4? transform})',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                color: Color(0xFF80CBC4),
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'The paintChild method renders a child at the specified index using '
            'an optional Matrix4 transformation. If no transform is provided, '
            'the child is painted at the origin (0, 0).',
            style: TextStyle(fontSize: 14, color: Color(0xFF5D4037)),
          ),
          SizedBox(height: 12),
          _buildParameterInfo('childIndex', 'Index of child (0 to childCount-1)'),
          _buildParameterInfo('transform', 'Optional Matrix4 for positioning'),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFFFE0B2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.lightbulb_outline, color: Color(0xFFE65100)),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Each child should only be painted once per paint cycle.',
                    style: TextStyle(fontSize: 13, color: Color(0xFF795548)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildParameterInfo(String name, String desc) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Color(0xFFFF9800),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              name,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 8),
          Text(desc, style: TextStyle(fontSize: 13, color: Color(0xFF6D4C41))),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// getChildSize Method Section
// ════════════════════════════════════════════════════════════════════════════

class _GetChildSizeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF81C784), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.straighten, color: Colors.white),
              ),
              SizedBox(width: 12),
              Text(
                'getChildSize Method',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFF263238),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Size? getChildSize(int childIndex)',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                color: Color(0xFFA5D6A7),
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Returns the laid-out size of the child at the given index. '
            'Returns null if the child has not been laid out.',
            style: TextStyle(fontSize: 14, color: Color(0xFF33691E)),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFC8E6C9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Usage Example:',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
                ),
                SizedBox(height: 8),
                Text(
                  'Size? childSize = context.getChildSize(0);\n'
                  'if (childSize != null) {\n'
                  '  double centerX = (context.size.width - childSize.width) / 2;\n'
                  '  context.paintChild(0, transform:\n'
                  '    Matrix4.translationValues(centerX, 0, 0));\n'
                  '}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// size Property Section
// ════════════════════════════════════════════════════════════════════════════

class _SizePropertySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF64B5F6), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF2196F3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.aspect_ratio, color: Colors.white),
              ),
              SizedBox(width: 12),
              Text(
                'size Property',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1565C0),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFF263238),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Size get size',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                color: Color(0xFF90CAF9),
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Returns the size of the Flow widget itself. This is determined '
            'by the constraints passed to the Flow and any size overrides '
            'in the FlowDelegate.getSize() method.',
            style: TextStyle(fontSize: 14, color: Color(0xFF1565C0)),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              _buildSizeUsageCard('Center', '(size.width - childW) / 2'),
              SizedBox(width: 8),
              _buildSizeUsageCard('Bottom', 'size.height - childH'),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              _buildSizeUsageCard('Spacing', 'size.width / (n + 1)'),
              SizedBox(width: 8),
              _buildSizeUsageCard('Padding', 'size.width - padding * 2'),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildSizeUsageCard(String title, String formula) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xFFBBDEFB),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Color(0xFF0D47A1),
              ),
            ),
            SizedBox(height: 4),
            Text(
              formula,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                color: Color(0xFF1565C0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// Visual Flow Layout Examples Section
// ════════════════════════════════════════════════════════════════════════════

class _VisualExamplesSection extends StatefulWidget {
  @override
  State<_VisualExamplesSection> createState() => _VisualExamplesSectionState();
}

class _VisualExamplesSectionState extends State<_VisualExamplesSection> {
  int _selectedLayout = 0;
  
  List<String> _layoutNames = [
    'Horizontal',
    'Vertical',
    'Circular',
    'Diagonal',
    'Grid',
  ];
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFCE4EC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFF48FB1), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFFE91E63),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.grid_view, color: Colors.white),
              ),
              SizedBox(width: 12),
              Text(
                'Visual Flow Layout Examples',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC2185B),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(_layoutNames.length, (index) {
              bool isSelected = _selectedLayout == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedLayout = index;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? Color(0xFFE91E63) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Color(0xFFE91E63)),
                  ),
                  child: Text(
                    _layoutNames[index],
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.white : Color(0xFFC2185B),
                    ),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 16),
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xFFF8BBD0)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Flow(
                delegate: _VisualLayoutDelegate(layoutType: _selectedLayout),
                children: List.generate(6, (index) {
                  return Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          _getChildColor(index),
                          _getChildColor(index).withValues(alpha: 0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: _getChildColor(index).withValues(alpha: 0.4),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '\${index + 1}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          SizedBox(height: 12),
          _buildLayoutDescription(),
        ],
      ),
    );
  }
  
  Color _getChildColor(int index) {
    List<Color> colors = [
      Color(0xFFE91E63),
      Color(0xFF9C27B0),
      Color(0xFF673AB7),
      Color(0xFF3F51B5),
      Color(0xFF2196F3),
      Color(0xFF00BCD4),
    ];
    return colors[index % colors.length];
  }
  
  Widget _buildLayoutDescription() {
    List<String> descriptions = [
      'Horizontal: Children spaced evenly along x-axis',
      'Vertical: Children stacked along y-axis',
      'Circular: Children arranged in a circle',
      'Diagonal: Children positioned diagonally',
      'Grid: Children in 3x2 grid pattern',
    ];
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFFF8BBD0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, size: 18, color: Color(0xFFC2185B)),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              descriptions[_selectedLayout],
              style: TextStyle(fontSize: 12, color: Color(0xFF880E4F)),
            ),
          ),
        ],
      ),
    );
  }
}

class _VisualLayoutDelegate extends FlowDelegate {
  int layoutType;
  
  _VisualLayoutDelegate({required this.layoutType});
  
  @override
  void paintChildren(FlowPaintingContext context) {
    int count = context.childCount;
    Size flowSize = context.size;
    
    for (int i = 0; i < count; i++) {
      Size? childSize = context.getChildSize(i);
      if (childSize == null) continue;
      
      Matrix4 transform = _computeTransform(i, count, flowSize, childSize);
      context.paintChild(i, transform: transform);
    }
  }
  
  Matrix4 _computeTransform(int index, int count, Size flowSize, Size childSize) {
    double x = 0;
    double y = 0;
    
    switch (layoutType) {
      case 0: // Horizontal
        double spacing = (flowSize.width - childSize.width) / (count - 1);
        x = index * spacing;
        y = (flowSize.height - childSize.height) / 2;
        break;
      case 1: // Vertical
        x = (flowSize.width - childSize.width) / 2;
        double spacing = (flowSize.height - childSize.height) / (count - 1);
        y = index * spacing;
        break;
      case 2: // Circular
        double centerX = flowSize.width / 2;
        double centerY = flowSize.height / 2;
        double radius = math.min(centerX, centerY) - childSize.width / 2 - 10;
        double angle = (index * 2 * math.pi / count) - math.pi / 2;
        x = centerX + radius * math.cos(angle) - childSize.width / 2;
        y = centerY + radius * math.sin(angle) - childSize.height / 2;
        break;
      case 3: // Diagonal
        double stepX = (flowSize.width - childSize.width) / (count - 1);
        double stepY = (flowSize.height - childSize.height) / (count - 1);
        x = index * stepX;
        y = index * stepY;
        break;
      case 4: // Grid
        int cols = 3;
        int row = index ~/ cols;
        int col = index % cols;
        double cellWidth = flowSize.width / cols;
        double cellHeight = flowSize.height / 2;
        x = col * cellWidth + (cellWidth - childSize.width) / 2;
        y = row * cellHeight + (cellHeight - childSize.height) / 2;
        break;
    }
    
    return Matrix4.translationValues(x, y, 0);
  }
  
  @override
  bool shouldRepaint(_VisualLayoutDelegate oldDelegate) {
    return oldDelegate.layoutType != layoutType;
  }
}

// ════════════════════════════════════════════════════════════════════════════
// Transformation Matrix Usage Section
// ════════════════════════════════════════════════════════════════════════════

class _TransformationMatrixSection extends StatefulWidget {
  @override
  State<_TransformationMatrixSection> createState() => _TransformationMatrixSectionState();
}

class _TransformationMatrixSectionState extends State<_TransformationMatrixSection> {
  double _rotation = 0;
  double _scale = 1.0;
  double _translateX = 0;
  double _translateY = 0;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFF3E5F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFCE93D8), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF9C27B0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.transform, color: Colors.white),
              ),
              SizedBox(width: 12),
              Text(
                'Transformation Matrix Usage',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7B1FA2),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xFFE1BEE7)),
            ),
            child: Center(
              child: Flow(
                delegate: _TransformDelegate(
                  rotation: _rotation,
                  scale: _scale,
                  translateX: _translateX,
                  translateY: _translateY,
                ),
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF9C27B0), Color(0xFFE040FB)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF9C27B0).withValues(alpha: 0.4),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(Icons.star, color: Colors.white, size: 32),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          _buildSliderRow('Rotation', _rotation, -math.pi, math.pi, (v) {
            setState(() => _rotation = v);
          }),
          _buildSliderRow('Scale', _scale, 0.5, 2.0, (v) {
            setState(() => _scale = v);
          }),
          _buildSliderRow('Translate X', _translateX, -50, 50, (v) {
            setState(() => _translateX = v);
          }),
          _buildSliderRow('Translate Y', _translateY, -30, 30, (v) {
            setState(() => _translateY = v);
          }),
          SizedBox(height: 12),
          Center(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _rotation = 0;
                  _scale = 1.0;
                  _translateX = 0;
                  _translateY = 0;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF9C27B0),
              ),
              child: Text('Reset', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSliderRow(String label, double value, double min, double max, ValueChanged<double> onChanged) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(fontSize: 12, color: Color(0xFF7B1FA2)),
            ),
          ),
          Expanded(
            child: Slider(
              value: value,
              min: min,
              max: max,
              activeColor: Color(0xFF9C27B0),
              onChanged: onChanged,
            ),
          ),
          SizedBox(
            width: 50,
            child: Text(
              value.toStringAsFixed(2),
              style: TextStyle(fontSize: 10, fontFamily: 'monospace'),
            ),
          ),
        ],
      ),
    );
  }
}

class _TransformDelegate extends FlowDelegate {
  double rotation;
  double scale;
  double translateX;
  double translateY;
  
  _TransformDelegate({
    required this.rotation,
    required this.scale,
    required this.translateX,
    required this.translateY,
  });
  
  @override
  void paintChildren(FlowPaintingContext context) {
    Size flowSize = context.size;
    Size? childSize = context.getChildSize(0);
    if (childSize == null) return;
    
    double cx = flowSize.width / 2;
    double cy = flowSize.height / 2;
    
    Matrix4 transform = Matrix4.identity()
      ..translate(cx, cy)
      ..translate(translateX, translateY)
      ..rotateZ(rotation)
      ..scale(scale)
      ..translate(-childSize.width / 2, -childSize.height / 2);
    
    context.paintChild(0, transform: transform);
  }
  
  @override
  bool shouldRepaint(_TransformDelegate oldDelegate) {
    return oldDelegate.rotation != rotation ||
           oldDelegate.scale != scale ||
           oldDelegate.translateX != translateX ||
           oldDelegate.translateY != translateY;
  }
}

// ════════════════════════════════════════════════════════════════════════════
// Interactive Flow Demo
// ════════════════════════════════════════════════════════════════════════════

class _InteractiveFlowDemo extends StatefulWidget {
  @override
  State<_InteractiveFlowDemo> createState() => _InteractiveFlowDemoState();
}

class _InteractiveFlowDemoState extends State<_InteractiveFlowDemo> {
  List<Offset> _positions = [
    Offset(20, 20),
    Offset(100, 40),
    Offset(180, 20),
    Offset(60, 100),
    Offset(140, 100),
  ];
  int _draggingIndex = -1;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFE0F7FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF4DD0E1), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF00BCD4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.touch_app, color: Colors.white),
              ),
              SizedBox(width: 12),
              Text(
                'Interactive Flow Demo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00838F),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Drag the items to reposition them using Flow transforms',
            style: TextStyle(fontSize: 13, color: Color(0xFF006064)),
          ),
          SizedBox(height: 12),
          GestureDetector(
            onPanStart: _onPanStart,
            onPanUpdate: _onPanUpdate,
            onPanEnd: _onPanEnd,
            child: Container(
              height: 160,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFF80DEEA)),
              ),
              child: Flow(
                delegate: _InteractiveFlowDelegate(positions: _positions),
                children: List.generate(5, (index) {
                  return Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: _getInteractiveColor(index),
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: _getInteractiveColor(index).withValues(alpha: 0.4),
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        String.fromCharCode(65 + index),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Color _getInteractiveColor(int index) {
    List<Color> colors = [
      Color(0xFF00BCD4),
      Color(0xFF009688),
      Color(0xFF4CAF50),
      Color(0xFF8BC34A),
      Color(0xFFCDDC39),
    ];
    return colors[index % colors.length];
  }
  
  void _onPanStart(DragStartDetails details) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset localPos = box.globalToLocal(details.globalPosition);
    localPos = localPos - Offset(16, 16 + 80);
    
    for (int i = _positions.length - 1; i >= 0; i--) {
      Offset pos = _positions[i];
      double distance = (localPos - pos - Offset(22, 22)).distance;
      if (distance < 30) {
        _draggingIndex = i;
        break;
      }
    }
  }
  
  void _onPanUpdate(DragUpdateDetails details) {
    if (_draggingIndex >= 0) {
      setState(() {
        Offset newPos = _positions[_draggingIndex] + details.delta;
        newPos = Offset(
          newPos.dx.clamp(0, 200),
          newPos.dy.clamp(0, 116),
        );
        _positions[_draggingIndex] = newPos;
      });
    }
  }
  
  void _onPanEnd(DragEndDetails details) {
    _draggingIndex = -1;
  }
}

class _InteractiveFlowDelegate extends FlowDelegate {
  List<Offset> positions;
  
  _InteractiveFlowDelegate({required this.positions});
  
  @override
  void paintChildren(FlowPaintingContext context) {
    for (int i = 0; i < context.childCount; i++) {
      if (i < positions.length) {
        Offset pos = positions[i];
        context.paintChild(i, transform: Matrix4.translationValues(pos.dx, pos.dy, 0));
      }
    }
  }
  
  @override
  bool shouldRepaint(_InteractiveFlowDelegate oldDelegate) {
    return true;
  }
}

// ════════════════════════════════════════════════════════════════════════════
// Animated Flow Demo
// ════════════════════════════════════════════════════════════════════════════

class _AnimatedFlowDemo extends StatefulWidget {
  @override
  State<_AnimatedFlowDemo> createState() => _AnimatedFlowDemoState();
}

class _AnimatedFlowDemoState extends State<_AnimatedFlowDemo>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  bool _isRunning = false;
  int _animationType = 0;
  
  List<String> _animationTypes = ['Wave', 'Pulse', 'Orbit', 'Bounce'];
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
    _controller?.addStatusListener((status) {
      if (status == AnimationStatus.completed && _isRunning) {
        _controller?.repeat();
      }
    });
  }
  
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
  
  void _toggleAnimation() {
    setState(() {
      _isRunning = !_isRunning;
      if (_isRunning) {
        _controller?.forward();
      } else {
        _controller?.stop();
        _controller?.reset();
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF673AB7), Color(0xFF9C27B0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.animation, color: Colors.white, size: 28),
              SizedBox(width: 12),
              Text(
                'Animated Flow Demo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Transform-based animations without relayout',
            style: TextStyle(fontSize: 13, color: Colors.white70),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(_animationTypes.length, (index) {
              bool isSelected = _animationType == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _animationType = index;
                    if (_isRunning) {
                      _controller?.reset();
                      _controller?.forward();
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.white24,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    _animationTypes[index],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Color(0xFF673AB7) : Colors.white,
                    ),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 16),
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: AnimatedBuilder(
              animation: _controller!,
              builder: (ctx, child) {
                return Flow(
                  delegate: _AnimatedFlowDelegate(
                    animationValue: _controller?.value ?? 0,
                    animationType: _animationType,
                  ),
                  children: List.generate(8, (index) {
                    double hue = (index * 45) % 360;
                    return Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: HSVColor.fromAHSV(1, hue.toDouble(), 0.7, 0.9).toColor(),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
          SizedBox(height: 12),
          Center(
            child: ElevatedButton.icon(
              onPressed: _toggleAnimation,
              icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
              label: Text(_isRunning ? 'Stop' : 'Start'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Color(0xFF673AB7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedFlowDelegate extends FlowDelegate {
  double animationValue;
  int animationType;
  
  _AnimatedFlowDelegate({
    required this.animationValue,
    required this.animationType,
  });
  
  @override
  void paintChildren(FlowPaintingContext context) {
    int count = context.childCount;
    Size flowSize = context.size;
    
    for (int i = 0; i < count; i++) {
      Size? childSize = context.getChildSize(i);
      if (childSize == null) continue;
      
      Matrix4 transform = _computeAnimatedTransform(
        i, count, flowSize, childSize, animationValue,
      );
      context.paintChild(i, transform: transform);
    }
  }
  
  Matrix4 _computeAnimatedTransform(
    int index, int count, Size flowSize, Size childSize, double t,
  ) {
    double x = 0;
    double y = 0;
    double rotation = 0;
    double scale = 1.0;
    
    double centerX = flowSize.width / 2;
    double centerY = flowSize.height / 2;
    
    switch (animationType) {
      case 0: // Wave
        double spacing = flowSize.width / (count + 1);
        x = (index + 1) * spacing - childSize.width / 2;
        double phase = (t * 2 * math.pi) + (index * 0.5);
        y = centerY + math.sin(phase) * 30 - childSize.height / 2;
        break;
      case 1: // Pulse
        double spacing = flowSize.width / (count + 1);
        x = (index + 1) * spacing - childSize.width / 2;
        y = centerY - childSize.height / 2;
        double phase = (t * 2 * math.pi) + (index * 0.7);
        scale = 0.7 + 0.3 * ((math.sin(phase) + 1) / 2);
        break;
      case 2: // Orbit
        double radius = math.min(centerX, centerY) - childSize.width / 2 - 10;
        double baseAngle = (index * 2 * math.pi / count);
        double animAngle = baseAngle + (t * 2 * math.pi);
        x = centerX + radius * math.cos(animAngle) - childSize.width / 2;
        y = centerY + radius * math.sin(animAngle) - childSize.height / 2;
        rotation = animAngle + math.pi / 2;
        break;
      case 3: // Bounce
        double spacing = flowSize.width / (count + 1);
        x = (index + 1) * spacing - childSize.width / 2;
        double phase = (t + (index * 0.1)) % 1.0;
        double bounce = math.sin(phase * math.pi);
        bounce = bounce * bounce;
        y = flowSize.height - childSize.height - 10 - (bounce * 60);
        break;
    }
    
    Matrix4 transform = Matrix4.identity();
    
    if (rotation != 0 || scale != 1.0) {
      double cx = x + childSize.width / 2;
      double cy = y + childSize.height / 2;
      transform
        ..translate(cx, cy)
        ..rotateZ(rotation)
        ..scale(scale)
        ..translate(-childSize.width / 2, -childSize.height / 2);
    } else {
      transform.translate(x, y);
    }
    
    return transform;
  }
  
  @override
  bool shouldRepaint(_AnimatedFlowDelegate oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
           oldDelegate.animationType != animationType;
  }
}
