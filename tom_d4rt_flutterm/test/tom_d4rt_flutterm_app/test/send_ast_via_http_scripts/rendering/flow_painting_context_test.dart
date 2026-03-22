// D4rt test script: Deep demo for FlowPaintingContext
// FlowPaintingContext - painting context for Flow widget delegates
//
// FlowPaintingContext is an abstract class provided by Flutter's rendering
// library. It acts as the interface given to a FlowDelegate's paintChildren
// method, providing methods to query child sizes and paint children with
// Matrix4 transforms. This enables efficient repositioning without relayout.
//
// ════════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';
import 'dart:math' as math;

// ════════════════════════════════════════════════════════════════════════════
// SECTION 1: FlowPaintingContext Purpose
// ════════════════════════════════════════════════════════════════════════════
//
// FlowPaintingContext serves as the bridge between FlowDelegate and the
// rendering layer. When you implement FlowDelegate.paintChildren(), you
// receive a FlowPaintingContext that lets you:
//   - Query the overall size of the Flow widget
//   - Get the size of any child widget
//   - Paint children at arbitrary positions using Matrix4 transforms
//
// The key advantage is that painting with transforms does NOT trigger a
// re-layout. This makes Flow ideal for animations where only child
// positions change, not their sizes.
//
// ════════════════════════════════════════════════════════════════════════════

class PurposeExplanationWidget extends StatefulWidget {
  PurposeExplanationWidget({Key? key}) : super(key: key);

  @override
  State<PurposeExplanationWidget> createState() =>
      _PurposeExplanationWidgetState();
}

class _PurposeExplanationWidgetState extends State<PurposeExplanationWidget> {
  int _expandedIndex = -1;

  List<Map<String, String>> _getPurposeItems() {
    return [
      {
        'title': 'Bridge to Rendering',
        'description':
            'FlowPaintingContext connects FlowDelegate to the render layer, '
                'providing direct access to child measurement and painting operations.',
      },
      {
        'title': 'Transform-Based Positioning',
        'description':
            'Instead of using layout constraints, children are positioned via '
                'Matrix4 transforms passed to paintChild(). This bypasses relayout.',
      },
      {
        'title': 'Performance Optimization',
        'description':
            'Because transforms dont affect layout, animations can update '
                'positions at 60fps without triggering expensive layout passes.',
      },
      {
        'title': 'Child Size Access',
        'description':
            'The context provides getChildSize() to query laid-out dimensions, '
                'enabling delegates to compute dynamic positioning.',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    var items = _getPurposeItems();
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF64B5F6), width: 2),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF90CAF9).withValues(alpha: 0.3),
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
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF1976D2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.lightbulb_outline, color: Colors.white, size: 24),
              ),
              SizedBox(width: 12),
              Text(
                'FlowPaintingContext Purpose',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'FlowPaintingContext is the abstract interface passed to '
            'FlowDelegate.paintChildren(). It encapsulates the rendering '
            'operations needed to paint Flow children efficiently.',
            style: TextStyle(fontSize: 14, color: Color(0xFF1565C0)),
          ),
          SizedBox(height: 16),
          ...List.generate(items.length, (index) {
            var item = items[index];
            var isExpanded = _expandedIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _expandedIndex = isExpanded ? -1 : index;
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isExpanded ? Color(0xFF42A5F5) : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isExpanded ? Color(0xFF1E88E5) : Color(0xFF90CAF9),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_right,
                          color: isExpanded ? Colors.white : Color(0xFF1976D2),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item['title'] ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color:
                                  isExpanded ? Colors.white : Color(0xFF0D47A1),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (isExpanded) ...[
                      SizedBox(height: 8),
                      Text(
                        item['description'] ?? '',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// SECTION 2: paintChild Method
// ════════════════════════════════════════════════════════════════════════════
//
// void paintChild(int childIndex, {Matrix4? transform})
//
// This is the core method of FlowPaintingContext. It paints the child at
// the given index using the optional Matrix4 transform. If no transform is
// provided, the child is painted at the origin (0, 0).
//
// The transform parameter allows:
//   - Translation (moving the child)
//   - Rotation
//   - Scaling
//   - Skewing
//   - Any combination via matrix composition
//
// Important: Each child should only be painted once per paint cycle.
//
// ════════════════════════════════════════════════════════════════════════════

class PaintChildDemoWidget extends StatefulWidget {
  PaintChildDemoWidget({Key? key}) : super(key: key);

  @override
  State<PaintChildDemoWidget> createState() => _PaintChildDemoWidgetState();
}

class _PaintChildDemoWidgetState extends State<PaintChildDemoWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  int _selectedTransformType = 0;
  bool _isAnimating = false;

  List<String> _transformTypes = [
    'Translation Only',
    'Rotation Only',
    'Scale Only',
    'Combined Transform',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
    _controller?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller?.reverse();
      } else if (status == AnimationStatus.dismissed) {
        if (_isAnimating) {
          _controller?.forward();
        }
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
      _isAnimating = !_isAnimating;
      if (_isAnimating) {
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
      margin: EdgeInsets.only(bottom: 16),
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
                child: Icon(Icons.brush, color: Colors.white, size: 24),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'paintChild Method',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE65100),
                  ),
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
            'Select a transform type to see how paintChild positions children:',
            style: TextStyle(fontSize: 14, color: Color(0xFF795548)),
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(_transformTypes.length, (index) {
              var isSelected = _selectedTransformType == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTransformType = index;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? Color(0xFFFF9800) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Color(0xFFFFB74D)),
                  ),
                  child: Text(
                    _transformTypes[index],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : Color(0xFFE65100),
                    ),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 16),
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xFFFFCC80)),
            ),
            child: AnimatedBuilder(
              animation: _controller!,
              builder: (context, child) {
                return Flow(
                  delegate: _PaintChildFlowDelegate(
                    animationValue: _controller?.value ?? 0,
                    transformType: _selectedTransformType,
                  ),
                  children: [
                    _buildFlowChild(0, Color(0xFFE91E63)),
                    _buildFlowChild(1, Color(0xFF9C27B0)),
                    _buildFlowChild(2, Color(0xFF3F51B5)),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 12),
          Center(
            child: ElevatedButton.icon(
              onPressed: _toggleAnimation,
              icon: Icon(_isAnimating ? Icons.pause : Icons.play_arrow),
              label: Text(_isAnimating ? 'Pause' : 'Animate'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF9800),
                foregroundColor: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 12),
          _buildTransformExplanation(),
        ],
      ),
    );
  }

  Widget _buildFlowChild(int index, Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          '${index + 1}',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildTransformExplanation() {
    var explanations = [
      'Translation: Matrix4.translationValues(x, y, 0) moves the child.',
      'Rotation: Matrix4.rotationZ(angle) rotates around the Z axis.',
      'Scale: Matrix4.diagonal3Values(sx, sy, 1) scales uniformly.',
      'Combined: Multiply matrices for translation + rotation + scale.',
    ];
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFFFFE0B2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Color(0xFFE65100), size: 20),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              explanations[_selectedTransformType],
              style: TextStyle(fontSize: 12, color: Color(0xFF795548)),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaintChildFlowDelegate extends FlowDelegate {
  final double animationValue;
  final int transformType;

  _PaintChildFlowDelegate({
    required this.animationValue,
    required this.transformType,
  });

  @override
  void paintChildren(FlowPaintingContext context) {
    var childCount = context.childCount;
    var flowSize = context.size;

    for (var i = 0; i < childCount; i++) {
      var childSize = context.getChildSize(i);
      if (childSize == null) continue;

      var transform = _computeTransform(i, childCount, flowSize, childSize);
      context.paintChild(i, transform: transform);
    }
  }

  Matrix4 _computeTransform(int index, int count, Size flowSize, Size childSize) {
    var baseX = 20.0 + index * 60;
    var baseY = (flowSize.height - childSize.height) / 2;
    var animOffset = animationValue * 40;

    switch (transformType) {
      case 0: // Translation only
        return Matrix4.translationValues(
          baseX + animOffset * (index % 2 == 0 ? 1 : -1),
          baseY + math.sin(animationValue * math.pi * 2) * 20,
          0,
        );
      case 1: // Rotation only
        var angle = animationValue * math.pi * 2 * (index % 2 == 0 ? 1 : -1);
        var transform = Matrix4.translationValues(baseX + 20, baseY + 20, 0);
        transform.rotateZ(angle);
        transform.translate(-20.0, -20.0);
        return transform;
      case 2: // Scale only
        var scale = 0.5 + animationValue * 0.5;
        var transform = Matrix4.translationValues(baseX, baseY, 0);
        transform.scale(scale, scale);
        return transform;
      case 3: // Combined
        var angle = animationValue * math.pi * 0.5;
        var scale = 0.8 + animationValue * 0.4;
        var transform = Matrix4.translationValues(
          baseX + animOffset,
          baseY + math.sin(animationValue * math.pi) * 30,
          0,
        );
        transform.rotateZ(angle);
        transform.scale(scale, scale);
        return transform;
      default:
        return Matrix4.translationValues(baseX, baseY, 0);
    }
  }

  @override
  bool shouldRepaint(_PaintChildFlowDelegate oldDelegate) {
    return animationValue != oldDelegate.animationValue ||
        transformType != oldDelegate.transformType;
  }
}

// ════════════════════════════════════════════════════════════════════════════
// SECTION 3: size Property
// ════════════════════════════════════════════════════════════════════════════
//
// Size get size
//
// Returns the overall size of the Flow widget itself. This is determined
// by the Flow's parent constraints and any sizing widgets wrapping it.
// The delegate uses this to compute where to position children relative
// to the available space.
//
// Common use cases:
//   - Centering children within the flow
//   - Computing radial layouts (knowing the center point)
//   - Distributing children evenly across available width/height
//
// ════════════════════════════════════════════════════════════════════════════

class SizePropertyDemoWidget extends StatefulWidget {
  SizePropertyDemoWidget({Key? key}) : super(key: key);

  @override
  State<SizePropertyDemoWidget> createState() => _SizePropertyDemoWidgetState();
}

class _SizePropertyDemoWidgetState extends State<SizePropertyDemoWidget> {
  double _flowWidth = 300;
  double _flowHeight = 120;
  String _sizeInfo = 'Adjust sliders to change Flow size';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
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
                child: Icon(Icons.aspect_ratio, color: Colors.white, size: 24),
              ),
              SizedBox(width: 12),
              Text(
                'size Property',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20),
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
              'Size get size // Returns the Flow widget dimensions',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                color: Color(0xFFA5D6A7),
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text('Width:', style: TextStyle(color: Color(0xFF2E7D32))),
              Expanded(
                child: Slider(
                  value: _flowWidth,
                  min: 150,
                  max: 350,
                  activeColor: Color(0xFF4CAF50),
                  onChanged: (value) {
                    setState(() {
                      _flowWidth = value;
                    });
                  },
                ),
              ),
              Text(
                '${_flowWidth.toInt()}',
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
              ),
            ],
          ),
          Row(
            children: [
              Text('Height:', style: TextStyle(color: Color(0xFF2E7D32))),
              Expanded(
                child: Slider(
                  value: _flowHeight,
                  min: 80,
                  max: 200,
                  activeColor: Color(0xFF4CAF50),
                  onChanged: (value) {
                    setState(() {
                      _flowHeight = value;
                    });
                  },
                ),
              ),
              Text(
                '${_flowHeight.toInt()}',
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
              ),
            ],
          ),
          SizedBox(height: 12),
          Center(
            child: Container(
              width: _flowWidth,
              height: _flowHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFF66BB6A), width: 2),
              ),
              child: Flow(
                delegate: _SizeAwareFlowDelegate(
                  onSizeReported: (size) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        setState(() {
                          _sizeInfo = 'Flow size: ${size.width.toInt()} x ${size.height.toInt()}';
                        });
                      }
                    });
                  },
                ),
                children: [
                  _buildSizeChild(Color(0xFF66BB6A)),
                  _buildSizeChild(Color(0xFF43A047)),
                  _buildSizeChild(Color(0xFF2E7D32)),
                  _buildSizeChild(Color(0xFF1B5E20)),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Color(0xFFC8E6C9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _sizeInfo,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1B5E20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSizeChild(Color color) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _SizeAwareFlowDelegate extends FlowDelegate {
  final void Function(Size) onSizeReported;

  _SizeAwareFlowDelegate({required this.onSizeReported});

  @override
  void paintChildren(FlowPaintingContext context) {
    var flowSize = context.size;
    onSizeReported(flowSize);

    var childCount = context.childCount;
    var spacing = flowSize.width / (childCount + 1);

    for (var i = 0; i < childCount; i++) {
      var childSize = context.getChildSize(i);
      if (childSize == null) continue;

      var x = spacing * (i + 1) - childSize.width / 2;
      var y = (flowSize.height - childSize.height) / 2;

      context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
    }
  }

  @override
  bool shouldRepaint(_SizeAwareFlowDelegate oldDelegate) => false;
}

// ════════════════════════════════════════════════════════════════════════════
// SECTION 4: getChildSize Method
// ════════════════════════════════════════════════════════════════════════════
//
// Size? getChildSize(int i)
//
// Returns the laid-out size of the child at index i. This is essential for
// computing transforms that properly position children based on their
// actual dimensions. Returns null if the child hasn't been laid out yet.
//
// Usage example:
//   var childSize = context.getChildSize(i);
//   var centerX = childSize.width / 2;
//   var centerY = childSize.height / 2;
//
// ════════════════════════════════════════════════════════════════════════════

class GetChildSizeDemoWidget extends StatefulWidget {
  GetChildSizeDemoWidget({Key? key}) : super(key: key);

  @override
  State<GetChildSizeDemoWidget> createState() => _GetChildSizeDemoWidgetState();
}

class _GetChildSizeDemoWidgetState extends State<GetChildSizeDemoWidget> {
  List<Size> _childSizes = [];
  int _highlightedChild = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Color(0xFFF3E5F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFBA68C8), width: 2),
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
                child: Icon(Icons.straighten, color: Colors.white, size: 24),
              ),
              SizedBox(width: 12),
              Text(
                'getChildSize Method',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C),
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
              'Size? getChildSize(int i) // Returns child dimensions',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                color: Color(0xFFCE93D8),
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Children with varying sizes (tap to highlight):',
            style: TextStyle(fontSize: 14, color: Color(0xFF6A1B9A)),
          ),
          SizedBox(height: 12),
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xFFCE93D8)),
            ),
            child: Flow(
              delegate: _ChildSizeFlowDelegate(
                onSizesCalculated: (sizes) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted && _childSizes.length != sizes.length) {
                      setState(() {
                        _childSizes = sizes;
                      });
                    }
                  });
                },
                highlightedIndex: _highlightedChild,
              ),
              children: [
                _buildVariableSizeChild(0, 30, 30, Color(0xFFE91E63)),
                _buildVariableSizeChild(1, 50, 40, Color(0xFF9C27B0)),
                _buildVariableSizeChild(2, 40, 50, Color(0xFF673AB7)),
                _buildVariableSizeChild(3, 60, 35, Color(0xFF3F51B5)),
                _buildVariableSizeChild(4, 35, 45, Color(0xFF2196F3)),
              ],
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Reported child sizes:',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF4A148C),
            ),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(_childSizes.length, (index) {
              var size = _childSizes[index];
              var isHighlighted = _highlightedChild == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _highlightedChild = isHighlighted ? -1 : index;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isHighlighted ? Color(0xFF9C27B0) : Color(0xFFE1BEE7),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Child $index: ${size.width.toInt()}x${size.height.toInt()}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isHighlighted ? Colors.white : Color(0xFF4A148C),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildVariableSizeChild(int index, double width, double height, Color color) {
    var isHighlighted = _highlightedChild == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _highlightedChild = isHighlighted ? -1 : index;
        });
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
          border: isHighlighted
              ? Border.all(color: Colors.yellow, width: 3)
              : null,
          boxShadow: isHighlighted
              ? [BoxShadow(color: Colors.yellow.withValues(alpha: 0.5), blurRadius: 8)]
              : null,
        ),
        child: Center(
          child: Text(
            '$index',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class _ChildSizeFlowDelegate extends FlowDelegate {
  final void Function(List<Size>) onSizesCalculated;
  final int highlightedIndex;

  _ChildSizeFlowDelegate({
    required this.onSizesCalculated,
    required this.highlightedIndex,
  });

  @override
  void paintChildren(FlowPaintingContext context) {
    var childCount = context.childCount;
    var sizes = <Size>[];
    var currentX = 10.0;

    for (var i = 0; i < childCount; i++) {
      var childSize = context.getChildSize(i);
      if (childSize == null) continue;

      sizes.add(childSize);
      var y = (context.size.height - childSize.height) / 2;
      context.paintChild(i, transform: Matrix4.translationValues(currentX, y, 0));
      currentX += childSize.width + 15;
    }

    onSizesCalculated(sizes);
  }

  @override
  bool shouldRepaint(_ChildSizeFlowDelegate oldDelegate) {
    return highlightedIndex != oldDelegate.highlightedIndex;
  }
}

// ════════════════════════════════════════════════════════════════════════════
// SECTION 5: Transform Usage
// ════════════════════════════════════════════════════════════════════════════
//
// Matrix4 transforms are the heart of Flow's positioning system. The
// FlowPaintingContext accepts any valid Matrix4, enabling complex
// positioning scenarios.
//
// Common transform patterns:
//   - Circular/radial layouts
//   - Stacked/overlapping cards
//   - Fan-out menus
//   - 3D perspective effects
//   - Animated position changes
//
// ════════════════════════════════════════════════════════════════════════════

class TransformUsageDemoWidget extends StatefulWidget {
  TransformUsageDemoWidget({Key? key}) : super(key: key);

  @override
  State<TransformUsageDemoWidget> createState() =>
      _TransformUsageDemoWidgetState();
}

class _TransformUsageDemoWidgetState extends State<TransformUsageDemoWidget>
    with SingleTickerProviderStateMixin {
  int _selectedLayout = 0;
  AnimationController? _animController;

  List<Map<String, dynamic>> _layouts = [
    {'name': 'Circular', 'icon': Icons.donut_large},
    {'name': 'Stacked', 'icon': Icons.layers},
    {'name': 'Fan Out', 'icon': Icons.open_in_full},
    {'name': 'Wave', 'icon': Icons.waves},
  ];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: Duration(milliseconds: 3000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
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
                child: Icon(Icons.transform, color: Colors.white, size: 24),
              ),
              SizedBox(width: 12),
              Text(
                'Transform Usage',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF006064),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Matrix4 transforms enable complex positioning without relayout:',
            style: TextStyle(fontSize: 14, color: Color(0xFF00838F)),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(_layouts.length, (index) {
              var layout = _layouts[index];
              var isSelected = _selectedLayout == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedLayout = index;
                  });
                },
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isSelected ? Color(0xFF00BCD4) : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(0xFF4DD0E1), width: 2),
                      ),
                      child: Icon(
                        layout['icon'] as IconData,
                        color: isSelected ? Colors.white : Color(0xFF00838F),
                        size: 22,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      layout['name'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: Color(0xFF006064),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          SizedBox(height: 16),
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFF80DEEA)),
            ),
            child: AnimatedBuilder(
              animation: _animController!,
              builder: (context, child) {
                return Flow(
                  delegate: _TransformLayoutDelegate(
                    layoutType: _selectedLayout,
                    animationValue: _animController?.value ?? 0,
                  ),
                  children: List.generate(8, (index) {
                    return _buildTransformChild(index);
                  }),
                );
              },
            ),
          ),
          SizedBox(height: 12),
          _buildLayoutCodeSnippet(),
        ],
      ),
    );
  }

  Widget _buildTransformChild(int index) {
    var colors = [
      Color(0xFFE91E63),
      Color(0xFF9C27B0),
      Color(0xFF673AB7),
      Color(0xFF3F51B5),
      Color(0xFF2196F3),
      Color(0xFF00BCD4),
      Color(0xFF009688),
      Color(0xFF4CAF50),
    ];
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: colors[index % colors.length],
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: colors[index % colors.length].withValues(alpha: 0.4),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          '${index + 1}',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildLayoutCodeSnippet() {
    var snippets = [
      'angle = 2 * pi * i / childCount;\nx = centerX + radius * cos(angle);\ny = centerY + radius * sin(angle);',
      'x = baseX + i * offsetX;\ny = baseY + i * offsetY;\n// Cards stack with slight offset',
      'angle = startAngle + i * spreadAngle;\n// Rotate around anchor point',
      'y = baseY + sin(animValue + i * phase) * amplitude;\n// Sine wave animation',
    ];
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFF263238),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        snippets[_selectedLayout],
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11,
          color: Color(0xFF80DEEA),
        ),
      ),
    );
  }
}

class _TransformLayoutDelegate extends FlowDelegate {
  final int layoutType;
  final double animationValue;

  _TransformLayoutDelegate({
    required this.layoutType,
    required this.animationValue,
  });

  @override
  void paintChildren(FlowPaintingContext context) {
    var childCount = context.childCount;
    var flowSize = context.size;
    var centerX = flowSize.width / 2;
    var centerY = flowSize.height / 2;

    for (var i = 0; i < childCount; i++) {
      var childSize = context.getChildSize(i);
      if (childSize == null) continue;

      var transform = _computeLayoutTransform(
        i,
        childCount,
        centerX,
        centerY,
        childSize,
      );
      context.paintChild(i, transform: transform);
    }
  }

  Matrix4 _computeLayoutTransform(
    int index,
    int count,
    double centerX,
    double centerY,
    Size childSize,
  ) {
    switch (layoutType) {
      case 0: // Circular
        var angle = (2 * math.pi * index / count) + (animationValue * 2 * math.pi);
        var radius = 60.0;
        var x = centerX + radius * math.cos(angle) - childSize.width / 2;
        var y = centerY + radius * math.sin(angle) - childSize.height / 2;
        return Matrix4.translationValues(x, y, 0);

      case 1: // Stacked
        var baseX = centerX - childSize.width / 2 + (index - count / 2) * 8;
        var baseY = centerY - childSize.height / 2 - index * 4;
        var hoverOffset = math.sin(animationValue * 2 * math.pi + index * 0.5) * 5;
        return Matrix4.translationValues(baseX, baseY + hoverOffset, 0);

      case 2: // Fan out
        var startAngle = -math.pi / 4;
        var spreadAngle = math.pi / 2 / (count - 1);
        var angle = startAngle + index * spreadAngle;
        var openAmount = 0.5 + 0.5 * math.sin(animationValue * 2 * math.pi);
        var effectiveAngle = angle * openAmount;
        var pivotX = centerX;
        var pivotY = centerY + 60;
        var transform = Matrix4.identity();
        transform.translate(pivotX, pivotY);
        transform.rotateZ(effectiveAngle);
        transform.translate(-childSize.width / 2, -80.0);
        return transform;

      case 3: // Wave
        var phase = index * 0.4;
        var amplitude = 30.0;
        var waveY = math.sin(animationValue * 2 * math.pi + phase) * amplitude;
        var spacing = (context.size.width - 50) / count;
        var x = 25 + index * spacing;
        var y = centerY + waveY - childSize.height / 2;
        return Matrix4.translationValues(x, y, 0);

      default:
        return Matrix4.translationValues(index * 40.0, centerY, 0);
    }
  }

  @override
  Size get size => Size.zero;

  @override
  bool shouldRepaint(_TransformLayoutDelegate oldDelegate) {
    return layoutType != oldDelegate.layoutType ||
        animationValue != oldDelegate.animationValue;
  }
}

// ════════════════════════════════════════════════════════════════════════════
// SECTION 6: Practical Examples
// ════════════════════════════════════════════════════════════════════════════

class PracticalExamplesWidget extends StatefulWidget {
  PracticalExamplesWidget({Key? key}) : super(key: key);

  @override
  State<PracticalExamplesWidget> createState() => _PracticalExamplesWidgetState();
}

class _PracticalExamplesWidgetState extends State<PracticalExamplesWidget> {
  List<Map<String, String>> _examples = [
    {
      'title': 'Menu Animation',
      'description': 'Circular FAB menu that expands/collapses with smooth animations',
    },
    {
      'title': 'Card Stack',
      'description': 'Tinder-style card deck with swipe gestures',
    },
    {
      'title': 'Photo Gallery',
      'description': 'Scattered photo layout with rotation and overlap',
    },
    {
      'title': 'Loading Indicator',
      'description': 'Custom spinner with orbiting dots',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFFFD54F), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFFFFC107),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.code, color: Colors.white, size: 24),
              ),
              SizedBox(width: 12),
              Text(
                'Practical Examples',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF6F00),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          ...List.generate(_examples.length, (index) {
            var example = _examples[index];
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFFFFE082)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFF3E0),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF6F00),
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
                          example['title'] ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFE65100),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          example['description'] ?? '',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF795548),
                          ),
                        ),
                      ],
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
}

// ════════════════════════════════════════════════════════════════════════════
// SECTION 7: Summary Panel
// ════════════════════════════════════════════════════════════════════════════

class SummaryWidget extends StatelessWidget {
  SummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A237E), Color(0xFF283593)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.check_circle, color: Color(0xFF69F0AE), size: 28),
              SizedBox(width: 12),
              Text(
                'FlowPaintingContext Summary',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildSummaryItem(
            'paintChild(i, transform:)',
            'Paints child i with Matrix4 transform',
          ),
          _buildSummaryItem(
            'size',
            'Returns the Flow widget dimensions',
          ),
          _buildSummaryItem(
            'getChildSize(i)',
            'Returns laid-out size of child i',
          ),
          _buildSummaryItem(
            'childCount',
            'Number of children in the Flow',
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Key benefit: Transforms reposition children without triggering '
              'layout, enabling smooth 60fps animations.',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String property, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: EdgeInsets.only(top: 6, right: 8),
            decoration: BoxDecoration(
              color: Color(0xFF64FFDA),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: property,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      color: Color(0xFF80CBC4),
                    ),
                  ),
                  TextSpan(
                    text: ' - $description',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.8),
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
// MAIN APPLICATION
// ════════════════════════════════════════════════════════════════════════════

class FlowPaintingContextDemo extends StatelessWidget {
  FlowPaintingContextDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlowPaintingContext Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF00BCD4)),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('FlowPaintingContext'),
          backgroundColor: Color(0xFF00BCD4),
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeaderBanner(),
              SizedBox(height: 16),
              PurposeExplanationWidget(),
              PaintChildDemoWidget(),
              SizePropertyDemoWidget(),
              GetChildSizeDemoWidget(),
              TransformUsageDemoWidget(),
              PracticalExamplesWidget(),
              SummaryWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderBanner() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00BCD4), Color(0xFF0097A7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF00BCD4).withValues(alpha: 0.3),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.auto_awesome, color: Colors.white, size: 32),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FlowPaintingContext',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Painting context for Flow widget delegates',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'FlowPaintingContext is the abstract interface used by FlowDelegate '
              'to paint children with Matrix4 transforms. It provides access to '
              'the Flow size and individual child sizes, enabling efficient '
              'transform-based positioning without triggering relayout.',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(FlowPaintingContextDemo());
}
