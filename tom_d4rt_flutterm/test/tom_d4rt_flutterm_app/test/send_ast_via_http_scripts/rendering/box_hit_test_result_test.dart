// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep demo for BoxHitTestResult - result of hit testing on RenderBox
//
// BoxHitTestResult is a specialized HitTestResult for collecting hits during
// RenderBox hit testing. It provides methods for:
//   - add(): Add BoxHitTestEntry directly
//   - addWithPaintOffset(): Transform position by offset before testing child
//   - addWithPaintTransform(): Transform position by matrix before testing child
//   - path property: Get list of HitTestEntry in order (front to back)
//   - wrap/unwrap: Wrap existing result for child testing
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ═══════════════════════════════════════════════════════════════════════════
// COLOR PALETTE
// ═══════════════════════════════════════════════════════════════════════════

Color _kPrimary100 = Color(0xFFC8E6C9);
Color _kPrimary200 = Color(0xFFA5D6A7);
Color _kPrimary300 = Color(0xFF81C784);
Color _kPrimary400 = Color(0xFF66BB6A);
Color _kPrimary500 = Color(0xFF4CAF50);
Color _kPrimary600 = Color(0xFF43A047);
Color _kPrimary700 = Color(0xFF388E3C);
Color _kPrimary800 = Color(0xFF2E7D32);
Color _kPrimary900 = Color(0xFF1B5E20);

Color _kSecondary600 = Color(0xFF1E88E5);
Color _kSecondary800 = Color(0xFF1565C0);

Color _kError400 = Color(0xFFEF5350);

Color _kSurface = Color(0xFFFAFAFA);
Color _kSurfaceVariant = Color(0xFFF5F5F5);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildSectionHeader(String title, IconData icon) {
  return Container(
    margin: EdgeInsets.only(top: 24, bottom: 16),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kPrimary700, _kPrimary600],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: _kPrimary700.withAlpha(80),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSubsectionHeader(String title) {
  return Padding(
    padding: EdgeInsets.only(top: 16, bottom: 8),
    child: Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: _kPrimary500,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: _kPrimary800,
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoCard(String title, String description, IconData icon) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kSurface,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kPrimary200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kPrimary100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: _kPrimary700, size: 24),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: _kPrimary900,
                ),
              ),
              SizedBox(height: 6),
              Text(
                description,
                style: TextStyle(fontSize: 13, color: _kPrimary700, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeBlock(String title, String code) {
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Color(0xFF2D2D2D),
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: [
              Icon(Icons.code, color: _kPrimary400, size: 18),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  color: _kPrimary300,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Color(0xFFD4D4D4),
              height: 1.6,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPropertyDisplay(String label, String value, {Color? valueColor}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: _kPrimary600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13,
              color: valueColor ?? _kPrimary900,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildResultCard(String title, List<Widget> children) {
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kPrimary300),
      boxShadow: [
        BoxShadow(
          color: _kPrimary200.withAlpha(60),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: _kPrimary800,
          ),
        ),
        SizedBox(height: 12),
        ...children,
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MOCK RENDER BOX FOR DEMONSTRATIONS
// ═══════════════════════════════════════════════════════════════════════════

class _MockRenderBox extends RenderBox {
  final String name;
  final Size boxSize;

  _MockRenderBox({required this.name, required this.boxSize});

  @override
  void performLayout() {
    size = boxSize;
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    print('_MockRenderBox "$name" hit test at position: $position');
    if (size.contains(position)) {
      result.add(BoxHitTestEntry(this, position));
      return true;
    }
    return false;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // No-op for testing
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// CUSTOM PAINTER FOR VISUALIZATIONS
// ═══════════════════════════════════════════════════════════════════════════

class _HitTestPathPainter extends CustomPainter {
  final List<String> pathItems;
  final Color pathColor;

  _HitTestPathPainter({required this.pathItems, required this.pathColor});

  @override
  void paint(Canvas canvas, Size size) {
    if (pathItems.isEmpty) return;

    var boxPaint = Paint()
      ..color = pathColor.withAlpha(40)
      ..style = PaintingStyle.fill;

    var borderPaint = Paint()
      ..color = pathColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    var linePaint = Paint()
      ..color = pathColor.withAlpha(150)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    double boxWidth = 120;
    double boxHeight = 40;
    double startX = 20;
    double y = 20;
    double spacing = 60;

    for (int i = 0; i < pathItems.length; i++) {
      double x = startX + i * (boxWidth + spacing);

      var rect = Rect.fromLTWH(x, y, boxWidth, boxHeight);
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(8)),
        boxPaint,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(8)),
        borderPaint,
      );

      var textPainter = TextPainter(
        text: TextSpan(
          text: pathItems[i],
          style: TextStyle(
            color: pathColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(maxWidth: boxWidth - 10);
      textPainter.paint(
        canvas,
        Offset(x + (boxWidth - textPainter.width) / 2, y + (boxHeight - textPainter.height) / 2),
      );

      if (i < pathItems.length - 1) {
        double arrowStartX = x + boxWidth;
        double arrowEndX = x + boxWidth + spacing;
        double arrowY = y + boxHeight / 2;

        canvas.drawLine(
          Offset(arrowStartX, arrowY),
          Offset(arrowEndX - 10, arrowY),
          linePaint,
        );

        var arrowPath = Path()
          ..moveTo(arrowEndX - 10, arrowY - 6)
          ..lineTo(arrowEndX, arrowY)
          ..lineTo(arrowEndX - 10, arrowY + 6);
        canvas.drawPath(arrowPath, linePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TransformVisualizationPainter extends CustomPainter {
  final Offset originalPosition;
  final Offset transformedPosition;
  final String transformType;

  _TransformVisualizationPainter({
    required this.originalPosition,
    required this.transformedPosition,
    required this.transformType,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var originalPaint = Paint()
      ..color = _kSecondary600
      ..style = PaintingStyle.fill;

    var transformedPaint = Paint()
      ..color = _kPrimary600
      ..style = PaintingStyle.fill;

    var linePaint = Paint()
      ..color = Colors.grey.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (double x = 0; x <= size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
    for (double y = 0; y <= size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    double scaleX = size.width / 200;
    double scaleY = size.height / 200;
    Offset scaledOriginal = Offset(originalPosition.dx * scaleX, originalPosition.dy * scaleY);
    Offset scaledTransformed = Offset(transformedPosition.dx * scaleX, transformedPosition.dy * scaleY);

    canvas.drawCircle(scaledOriginal, 12, originalPaint);
    _drawLabel(canvas, 'Original', scaledOriginal + Offset(15, -8), _kSecondary800);

    var arrowPaint = Paint()
      ..color = _kError400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawLine(scaledOriginal, scaledTransformed, arrowPaint);

    canvas.drawCircle(scaledTransformed, 12, transformedPaint);
    _drawLabel(canvas, 'Transformed', scaledTransformed + Offset(15, -8), _kPrimary800);

    _drawLabel(canvas, transformType, Offset(size.width / 2 - 40, size.height - 20), Colors.grey.shade700);
  }

  void _drawLabel(Canvas canvas, String text, Offset position, Color color) {
    var textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w500),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, position);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CoordinateSystemPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var gridPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    var axisPaint = Paint()
      ..color = _kPrimary600
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    var fillPaint = Paint()
      ..color = _kPrimary100.withAlpha(100)
      ..style = PaintingStyle.fill;

    for (double x = 0; x <= size.width; x += 20) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y <= size.height; y += 20) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    canvas.drawLine(Offset(0, 0), Offset(size.width, 0), axisPaint);
    canvas.drawLine(Offset(0, 0), Offset(0, size.height), axisPaint);

    var childRect = Rect.fromLTWH(size.width * 0.3, size.height * 0.3,
        size.width * 0.5, size.height * 0.4);
    canvas.drawRect(childRect, fillPaint);

    var childBorderPaint = Paint()
      ..color = _kPrimary500
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(childRect, childBorderPaint);

    _drawLabel(canvas, 'Parent (0,0)', Offset(5, 5), _kPrimary800);
    _drawLabel(canvas, 'Child', Offset(childRect.left + 10, childRect.top + 10), _kPrimary700);
  }

  void _drawLabel(Canvas canvas, String text, Offset position, Color color) {
    var textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w600),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, position);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 1: BOXHITTESTRESULT CREATION
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildCreationSection() {
  print('=== BoxHitTestResult Creation Section ===');

  var basicResult = BoxHitTestResult();
  print('Created empty BoxHitTestResult: $basicResult');
  print('  path.isEmpty: ${basicResult.path.isEmpty}');

  var resultWithEntry = BoxHitTestResult();
  var mockBox = _MockRenderBox(name: 'TestBox', boxSize: Size(100, 100));
  resultWithEntry.add(BoxHitTestEntry(mockBox, Offset(50, 50)));
  print('Created result with one entry: ${resultWithEntry.path.length} entries');

  var parentResult = HitTestResult();
  var wrappedResult = BoxHitTestResult.wrap(parentResult);
  print('Created wrapped BoxHitTestResult: ${wrappedResult.runtimeType}');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader('1. BoxHitTestResult Creation', Icons.add_box_outlined),
      _buildInfoCard(
        'What is BoxHitTestResult?',
        'BoxHitTestResult is a specialized HitTestResult that collects BoxHitTestEntry objects during hit testing of RenderBox widgets. It provides coordinate transformation methods essential for nested hit testing.',
        Icons.info_outline,
      ),
      _buildSubsectionHeader('Basic Instantiation'),
      _buildCodeBlock(
        'Creating Empty Result',
        '''// Create a new empty BoxHitTestResult
final result = BoxHitTestResult();

// Initially, the path is empty
print(result.path.isEmpty);  // true
print(result.path.length);   // 0''',
      ),
      _buildResultCard('Empty Result Properties', [
        _buildPropertyDisplay('path.isEmpty', '${basicResult.path.isEmpty}'),
        _buildPropertyDisplay('path.length', '${basicResult.path.length}'),
        _buildPropertyDisplay('runtimeType', '${basicResult.runtimeType}'),
      ]),
      _buildSubsectionHeader('Result with Entry'),
      _buildCodeBlock(
        'Creating and Adding Entry',
        '''// Create result and mock RenderBox
final result = BoxHitTestResult();
final renderBox = MyRenderBox();

// Add a hit test entry
result.add(BoxHitTestEntry(renderBox, Offset(50, 50)));

// Now path contains one entry
print(result.path.length);  // 1''',
      ),
      _buildResultCard('Result After Adding Entry', [
        _buildPropertyDisplay('path.length', '${resultWithEntry.path.length}'),
        _buildPropertyDisplay('path.isNotEmpty', '${resultWithEntry.path.isNotEmpty}'),
        _buildPropertyDisplay('First entry type', '${resultWithEntry.path.first.runtimeType}'),
      ]),
      _buildSubsectionHeader('Wrap Constructor'),
      _buildCodeBlock(
        'Wrapping Existing HitTestResult',
        '''// Often used when delegating to child hit testing
final parentResult = HitTestResult();
final boxResult = BoxHitTestResult.wrap(parentResult);

// Both share the same underlying path
// Entries added to boxResult appear in parentResult''',
      ),
      _buildInfoCard(
        'When to use wrap()',
        'Use BoxHitTestResult.wrap() when you need to perform box-specific hit testing but want entries to be added to an existing HitTestResult. This is common when a non-box render object contains box children.',
        Icons.wrap_text,
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 2: ADD METHOD
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildAddMethodSection() {
  print('=== Add Method Section ===');

  var result = BoxHitTestResult();
  var box1 = _MockRenderBox(name: 'Box1', boxSize: Size(100, 100));
  var box2 = _MockRenderBox(name: 'Box2', boxSize: Size(80, 80));
  var box3 = _MockRenderBox(name: 'Box3', boxSize: Size(60, 60));

  result.add(BoxHitTestEntry(box1, Offset(10, 10)));
  print('Added Box1 at (10, 10)');
  result.add(BoxHitTestEntry(box2, Offset(20, 20)));
  print('Added Box2 at (20, 20)');
  result.add(BoxHitTestEntry(box3, Offset(30, 30)));
  print('Added Box3 at (30, 30)');

  print('Total entries: ${result.path.length}');
  for (int i = 0; i < result.path.length; i++) {
    var entry = result.path.elementAt(i);
    print('  Entry $i: ${entry.runtimeType}');
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader('2. add() Method', Icons.add_circle_outline),
      _buildInfoCard(
        'Adding Hit Test Entries',
        'The add() method appends a BoxHitTestEntry to the result path. Entries are stored in hit order - the first entry added is the top-most (front) widget that was hit.',
        Icons.playlist_add,
      ),
      _buildSubsectionHeader('Basic Usage'),
      _buildCodeBlock(
        'Adding Entries',
        '''final result = BoxHitTestResult();

// Create entries with target and local position
result.add(BoxHitTestEntry(renderBox1, Offset(10, 10)));
result.add(BoxHitTestEntry(renderBox2, Offset(20, 20)));
result.add(BoxHitTestEntry(renderBox3, Offset(30, 30)));

// Path now contains 3 entries
print(result.path.length);  // 3''',
      ),
      _buildResultCard('After Adding 3 Entries', [
        _buildPropertyDisplay('path.length', '${result.path.length}'),
        _buildPropertyDisplay('Entry 0 (first hit)', 'BoxHitTestEntry @ (10, 10)'),
        _buildPropertyDisplay('Entry 1', 'BoxHitTestEntry @ (20, 20)'),
        _buildPropertyDisplay('Entry 2 (last hit)', 'BoxHitTestEntry @ (30, 30)'),
      ]),
      _buildSubsectionHeader('Entry Order Visualization'),
      Container(
        height: 80,
        margin: EdgeInsets.symmetric(vertical: 12),
        child: CustomPaint(
          painter: _HitTestPathPainter(
            pathItems: ['Box1 (front)', 'Box2', 'Box3 (back)'],
            pathColor: _kPrimary600,
          ),
          size: Size.infinite,
        ),
      ),
      _buildInfoCard(
        'Understanding Entry Order',
        'Entries are added in hit traversal order. The first entry is typically the visually topmost widget. When processing events, you iterate through path to find which widgets should handle the event.',
        Icons.layers,
      ),
      _buildCodeBlock(
        'Iterating Through Path',
        '''// Process entries front-to-back
for (final entry in result.path) {
  if (entry is BoxHitTestEntry) {
    print("Hit: \${entry.target} at \${entry.localPosition}");
  }
}''',
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 3: ADDWITHPAINTOFFSET
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildAddWithPaintOffsetSection() {
  print('=== addWithPaintOffset Section ===');

  var result = BoxHitTestResult();
  var childBox = _MockRenderBox(name: 'ChildBox', boxSize: Size(100, 100));

  Offset paintOffset = Offset(50, 30);
  Offset tapPosition = Offset(80, 60);
  Offset transformedPosition = tapPosition - paintOffset;

  print('Paint offset: $paintOffset');
  print('Tap position: $tapPosition');
  print('Transformed position: $transformedPosition');

  bool hitTestCallback(BoxHitTestResult r, Offset pos) {
    print('Hit test callback called with position: $pos');
    if (childBox.size.contains(pos)) {
      r.add(BoxHitTestEntry(childBox, pos));
      return true;
    }
    return false;
  }

  bool hasHit = result.addWithPaintOffset(
    offset: paintOffset,
    position: tapPosition,
    hitTest: hitTestCallback,
  );
  print('addWithPaintOffset returned: $hasHit');
  print('Result path length: ${result.path.length}');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader('3. addWithPaintOffset()', Icons.transform),
      _buildInfoCard(
        'Position Transformation with Offset',
        'addWithPaintOffset() subtracts a paint offset from the hit position before passing it to the child hit test. This is essential for widgets that paint their children at an offset (like Positioned or Padding).',
        Icons.straighten,
      ),
      _buildSubsectionHeader('How It Works'),
      _buildCodeBlock(
        'Method Signature',
        '''bool addWithPaintOffset({
  required Offset? offset,
  required Offset position,
  required BoxHitTest hitTest,
})

// If offset is null, position is passed unchanged
// Otherwise: childPosition = position - offset''',
      ),
      _buildSubsectionHeader('Visual Demonstration'),
      Container(
        height: 180,
        margin: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: _kPrimary300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: CustomPaint(
          painter: _TransformVisualizationPainter(
            originalPosition: tapPosition,
            transformedPosition: transformedPosition,
            transformType: 'Offset: (-50, -30)',
          ),
          size: Size.infinite,
        ),
      ),
      _buildResultCard('Offset Transformation Example', [
        _buildPropertyDisplay('Paint Offset', '$paintOffset'),
        _buildPropertyDisplay('Tap Position', '$tapPosition'),
        _buildPropertyDisplay('Transformed', '$transformedPosition'),
        _buildPropertyDisplay('Formula', 'position - offset'),
        _buildPropertyDisplay('Hit Detected', '$hasHit'),
      ]),
      _buildSubsectionHeader('Practical Example'),
      _buildCodeBlock(
        'Using in RenderBox.hitTest',
        '''@override
bool hitTest(BoxHitTestResult result, {required Offset position}) {
  // Test child that is painted at offset (50, 30)
  bool isHit = result.addWithPaintOffset(
    offset: Offset(50, 30),
    position: position,
    hitTest: (BoxHitTestResult result, Offset transformed) {
      return child?.hitTest(result, position: transformed) ?? false;
    },
  );
  
  if (isHit || hitTestSelf(position)) {
    result.add(BoxHitTestEntry(this, position));
    return true;
  }
  return false;
}''',
      ),
      _buildInfoCard(
        'Null Offset Handling',
        'If the offset parameter is null, the position is passed directly to the hit test callback without transformation. This is useful for conditional offsetting.',
        Icons.block,
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 4: ADDWITHPAINTTRANSFORM
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildAddWithPaintTransformSection() {
  print('=== addWithPaintTransform Section ===');

  var result = BoxHitTestResult();
  var childBox = _MockRenderBox(name: 'TransformedChild', boxSize: Size(100, 100));

  Matrix4 transform = Matrix4.identity()
    ..setEntry(0, 0, 2.0)
    ..setEntry(1, 1, 2.0)
    ..rotateZ(0.5);

  Offset tapPosition = Offset(100, 100);

  Matrix4 inverseTransform = Matrix4.tryInvert(transform) ?? Matrix4.identity();

  print('Transform matrix: scale(2) + rotateZ(0.5)');
  print('Inverse transform: $inverseTransform');
  print('Tap position: $tapPosition');
  print('Transform determinant: ${transform.determinant()}');

  bool hitTestCallback(BoxHitTestResult r, Offset pos) {
    print('Hit test callback with transformed position: $pos');
    r.add(BoxHitTestEntry(childBox, pos));
    return true;
  }

  bool hasHit = result.addWithPaintTransform(
    transform: transform,
    position: tapPosition,
    hitTest: hitTestCallback,
  );
  print('addWithPaintTransform returned: $hasHit');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader('4. addWithPaintTransform()', Icons.threesixty),
      _buildInfoCard(
        'Matrix Transformation',
        'addWithPaintTransform() applies the inverse of a Matrix4 transform to the hit position. This handles complex transformations like rotation, scaling, and perspective.',
        Icons.grid_on,
      ),
      _buildSubsectionHeader('Method Overview'),
      _buildCodeBlock(
        'Method Signature',
        '''bool addWithPaintTransform({
  required Matrix4? transform,
  required Offset position,
  required BoxHitTest hitTest,
})

// 1. Computes inverse of transform
// 2. Transforms position using inverse
// 3. Calls hitTest with transformed position
// 4. Adds transform to result path for event routing''',
      ),
      _buildSubsectionHeader('Transform Matrix Example'),
      _buildResultCard('Scale + Rotate Transform', [
        _buildPropertyDisplay('Scale', '2.0x in both axes'),
        _buildPropertyDisplay('Rotation', '0.5 radians (~28.6 deg)'),
        _buildPropertyDisplay('Tap Position', '$tapPosition'),
        _buildPropertyDisplay('Has Hit', '$hasHit'),
        _buildPropertyDisplay('Entries Added', '${result.path.length}'),
      ]),
      _buildCodeBlock(
        'Practical Usage - Rotated Child',
        '''@override
bool hitTest(BoxHitTestResult result, {required Offset position}) {
  // Child is painted with rotation and scale
  final Matrix4 transform = Matrix4.identity()
    ..translate(center.dx, center.dy)
    ..rotateZ(angle)
    ..scale(scale)
    ..translate(-center.dx, -center.dy);
  
  return result.addWithPaintTransform(
    transform: transform,
    position: position,
    hitTest: (BoxHitTestResult result, Offset local) {
      return child?.hitTest(result, position: local) ?? false;
    },
  );
}''',
      ),
      _buildInfoCard(
        'Transform Invertibility',
        'If the transform matrix is not invertible (determinant is 0), the hit test returns false immediately. This can happen with degenerate transforms like scale(0, 0).',
        Icons.warning_amber_outlined,
      ),
      _buildSubsectionHeader('Null Transform Handling'),
      _buildCodeBlock(
        'Null Transform Behavior',
        '''// When transform is null, acts like addWithPaintOffset(offset: null)
result.addWithPaintTransform(
  transform: null,  // No transformation applied
  position: position,
  hitTest: myHitTest,
);

// Position passed unchanged to hitTest callback''',
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 5: PATH PROPERTY
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildPathPropertySection() {
  print('=== Path Property Section ===');

  var result = BoxHitTestResult();
  var boxes = <_MockRenderBox>[];

  for (int i = 0; i < 5; i++) {
    var box = _MockRenderBox(name: 'PathBox$i', boxSize: Size(100 - i * 10, 100 - i * 10));
    boxes.add(box);
    result.add(BoxHitTestEntry(box, Offset(10.0 * i, 10.0 * i)));
    print('Added PathBox$i to path');
  }

  print('Path length: ${result.path.length}');
  print('Path type: ${result.path.runtimeType}');

  int index = 0;
  for (var entry in result.path) {
    print('Path[$index]: ${entry.runtimeType}, target: ${(entry as BoxHitTestEntry).target}');
    index++;
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader('5. path Property', Icons.route),
      _buildInfoCard(
        'Accessing Hit Test Path',
        'The path property returns an Iterable<HitTestEntry> containing all entries that were hit, in order from front (first added) to back (last added).',
        Icons.linear_scale,
      ),
      _buildSubsectionHeader('Path Structure'),
      _buildCodeBlock(
        'Path Property',
        '''// Returns all entries in hit order
Iterable<HitTestEntry> get path;

// path is read-only - modifications go through add methods
print(result.path.length);
print(result.path.first);
print(result.path.last);''',
      ),
      _buildResultCard('Path Contents (5 Entries)', [
        _buildPropertyDisplay('path.length', '${result.path.length}'),
        _buildPropertyDisplay('Entry 0', 'PathBox0 @ (0, 0)'),
        _buildPropertyDisplay('Entry 1', 'PathBox1 @ (10, 10)'),
        _buildPropertyDisplay('Entry 2', 'PathBox2 @ (20, 20)'),
        _buildPropertyDisplay('Entry 3', 'PathBox3 @ (30, 30)'),
        _buildPropertyDisplay('Entry 4', 'PathBox4 @ (40, 40)'),
      ]),
      _buildSubsectionHeader('Path Visualization'),
      Container(
        height: 80,
        margin: EdgeInsets.symmetric(vertical: 12),
        child: CustomPaint(
          painter: _HitTestPathPainter(
            pathItems: ['Entry 0', 'Entry 1', 'Entry 2', 'Entry 3', 'Entry 4'],
            pathColor: _kSecondary600,
          ),
          size: Size.infinite,
        ),
      ),
      _buildSubsectionHeader('Iterating the Path'),
      _buildCodeBlock(
        'Processing Path Entries',
        '''// Forward iteration (front to back)
for (final entry in result.path) {
  if (entry is BoxHitTestEntry) {
    final box = entry.target as RenderBox;
    final position = entry.localPosition;
    handleHit(box, position);
  }
}

// Get specific entry
final firstEntry = result.path.first;
final lastEntry = result.path.last;
final thirdEntry = result.path.elementAt(2);''',
      ),
      _buildInfoCard(
        'Path Immutability',
        'While the path itself is mutable through add methods, you cannot directly modify, remove, or reorder entries. The path represents the actual hit test traversal.',
        Icons.lock_outline,
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 6: HITTESTENTRY ENTRIES
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildHitTestEntrySection() {
  print('=== HitTestEntry Section ===');

  var result = BoxHitTestResult();
  var box = _MockRenderBox(name: 'EntryDemoBox', boxSize: Size(150, 100));
  var localPosition = Offset(75, 50);

  var entry = BoxHitTestEntry(box, localPosition);
  result.add(entry);

  print('Created BoxHitTestEntry:');
  print('  target: ${entry.target}');
  print('  localPosition: ${entry.localPosition}');
  print('  transform: ${entry.transform}');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader('6. HitTestEntry Entries', Icons.view_in_ar),
      _buildInfoCard(
        'BoxHitTestEntry Structure',
        'BoxHitTestEntry extends HitTestEntry<RenderBox> and adds localPosition - the position where the hit occurred in the RenderBox local coordinate system.',
        Icons.category,
      ),
      _buildSubsectionHeader('Entry Properties'),
      _buildCodeBlock(
        'BoxHitTestEntry Members',
        '''class BoxHitTestEntry extends HitTestEntry<RenderBox> {
  // The RenderBox that was hit
  RenderBox get target;
  
  // Position in target local coordinates
  final Offset localPosition;
  
  // Cumulative transform from global to local
  Matrix4? get transform;
}''',
      ),
      _buildResultCard('Example Entry', [
        _buildPropertyDisplay('target.runtimeType', '${entry.target.runtimeType}'),
        _buildPropertyDisplay('localPosition', '${entry.localPosition}'),
        _buildPropertyDisplay('localPosition.dx', '${entry.localPosition.dx}'),
        _buildPropertyDisplay('localPosition.dy', '${entry.localPosition.dy}'),
        _buildPropertyDisplay('transform', '${entry.transform ?? "null (identity)"}'),
      ]),
      _buildSubsectionHeader('Entry Creation'),
      _buildCodeBlock(
        'Creating Entries',
        '''// Direct creation (rare - usually done internally)
final entry = BoxHitTestEntry(renderBox, Offset(50, 50));

// Typical usage - created by add methods
result.add(BoxHitTestEntry(this, position));

// Or implicitly via addWithPaintOffset/Transform
result.addWithPaintOffset(
  offset: offset,
  position: position,
  hitTest: (result, pos) {
    // Entry created here with transformed pos
    result.add(BoxHitTestEntry(child, pos));
    return true;
  },
);''',
      ),
      _buildSubsectionHeader('Transform Accumulation'),
      _buildInfoCard(
        'Transform Property',
        'The transform property accumulates all transforms applied during hit testing. This is used to convert global positions back to local coordinates when handling events.',
        Icons.transform,
      ),
      _buildCodeBlock(
        'Using Entry Transform',
        '''// Get entry from path
final entry = result.path.first as BoxHitTestEntry;

// Access the accumulated transform
final Matrix4? transform = entry.transform;

// Convert global position to local
if (transform != null) {
  final global = Offset(100, 100);
  final local = MatrixUtils.transformPoint(
    Matrix4.tryInvert(transform)!,
    global,
  );
}''',
      ),
      _buildSubsectionHeader('Coordinate System'),
      Container(
        height: 160,
        margin: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: _kPrimary300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: CustomPaint(
          painter: _CoordinateSystemPainter(),
          size: Size.infinite,
        ),
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION 7: WRAP/UNWRAP
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildWrapUnwrapSection() {
  print('=== Wrap/Unwrap Section ===');

  var originalResult = HitTestResult();
  var wrappedResult = BoxHitTestResult.wrap(originalResult);

  var box1 = _MockRenderBox(name: 'WrapDemoBox1', boxSize: Size(100, 100));
  var box2 = _MockRenderBox(name: 'WrapDemoBox2', boxSize: Size(80, 80));

  wrappedResult.add(BoxHitTestEntry(box1, Offset(25, 25)));
  print('Added entry through wrapped result');
  print('Original result path length: ${originalResult.path.length}');
  print('Wrapped result path length: ${wrappedResult.path.length}');

  wrappedResult.add(BoxHitTestEntry(box2, Offset(40, 40)));
  print('After second entry:');
  print('  Original path length: ${originalResult.path.length}');
  print('  Wrapped path length: ${wrappedResult.path.length}');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader('7. Wrap/Unwrap Pattern', Icons.wrap_text),
      _buildInfoCard(
        'BoxHitTestResult.wrap()',
        'The wrap() constructor creates a BoxHitTestResult that shares its path with an existing HitTestResult. Entries added to the wrapped result appear in both.',
        Icons.link,
      ),
      _buildSubsectionHeader('Wrap Constructor'),
      _buildCodeBlock(
        'Creating Wrapped Result',
        '''// Parent has a generic HitTestResult
final parentResult = HitTestResult();

// Child needs BoxHitTestResult for box-specific methods
final boxResult = BoxHitTestResult.wrap(parentResult);

// Entries added to boxResult appear in both
boxResult.add(BoxHitTestEntry(myBox, position));
print(parentResult.path.length);  // 1
print(boxResult.path.length);     // 1''',
      ),
      _buildResultCard('Shared Path Demonstration', [
        _buildPropertyDisplay('After 2 entries:', ''),
        _buildPropertyDisplay('  original.path.length', '${originalResult.path.length}'),
        _buildPropertyDisplay('  wrapped.path.length', '${wrappedResult.path.length}'),
        _buildPropertyDisplay('Same underlying path?', 'Yes - shared reference'),
      ]),
      _buildSubsectionHeader('Use Cases'),
      _buildCodeBlock(
        'Common Wrap Scenarios',
        '''// Scenario 1: RenderSliver with box child
class MyRenderSliver extends RenderSliver {
  @override
  bool hitTest(SliverHitTestResult result, ...) {
    // Need to test RenderBox child
    final boxResult = BoxHitTestResult.wrap(result);
    return boxChild.hitTest(boxResult, position: localPos);
  }
}

// Scenario 2: Custom hit testing delegation
void delegateHitTest(HitTestResult result, Offset pos) {
  final boxResult = BoxHitTestResult.wrap(result);
  for (final child in boxChildren) {
    boxResult.addWithPaintOffset(
      offset: child.paintOffset,
      position: pos,
      hitTest: child.hitTest,
    );
  }
}''',
      ),
      _buildInfoCard(
        'Path Identity',
        'Both the original and wrapped result reference the same underlying path collection. This is efficient and ensures consistent event routing across the widget tree.',
        Icons.merge_type,
      ),
      _buildSubsectionHeader('Wrapped vs New'),
      _buildResultCard('Comparison', [
        _buildPropertyDisplay('Wrapped', 'Shares path with parent'),
        _buildPropertyDisplay('', 'Adds to existing traversal'),
        _buildPropertyDisplay('', 'Memory efficient'),
        _buildPropertyDisplay('New', 'Independent path'),
        _buildPropertyDisplay('', 'Starts fresh traversal'),
        _buildPropertyDisplay('', 'Used at hit test root'),
      ]),
      _buildSubsectionHeader('Unwrapping Pattern'),
      _buildCodeBlock(
        'Unwrap Example',
        '''// When you have a BoxHitTestResult but need base HitTestResult
// Simply use the same result - BoxHitTestResult IS a HitTestResult

BoxHitTestResult boxResult = BoxHitTestResult();
HitTestResult baseResult = boxResult;  // Upcasting works

// For the reverse, use wrap:
HitTestResult base = someHitTestResult;
BoxHitTestResult box = BoxHitTestResult.wrap(base);''',
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN APP
// ═══════════════════════════════════════════════════════════════════════════

void main() {
  print('');
  print('══════════════════════════════════════════════════════════════════');
  print('  BoxHitTestResult Deep Demo');
  print('  Result of hit testing on RenderBox');
  print('══════════════════════════════════════════════════════════════════');
  print('');

  runApp(BoxHitTestResultDemoApp());
}

class BoxHitTestResultDemoApp extends StatelessWidget {
  const BoxHitTestResultDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BoxHitTestResult Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: _kSurfaceVariant,
        fontFamily: 'Roboto',
      ),
      home: BoxHitTestResultDemoScreen(),
    );
  }
}

class BoxHitTestResultDemoScreen extends StatelessWidget {
  const BoxHitTestResultDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('Building BoxHitTestResultDemoScreen');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _kPrimary700,
        elevation: 4,
        title: Row(
          children: [
            Icon(Icons.ads_click, color: Colors.white),
            SizedBox(width: 12),
            Text(
              'BoxHitTestResult Demo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              print('Info button pressed');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIntroductionCard(),
            _buildCreationSection(),
            _buildAddMethodSection(),
            _buildAddWithPaintOffsetSection(),
            _buildAddWithPaintTransformSection(),
            _buildPathPropertySection(),
            _buildHitTestEntrySection(),
            _buildWrapUnwrapSection(),
            _buildSummarySection(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

Widget _buildIntroductionCard() {
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kPrimary600, _kPrimary500],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: _kPrimary700.withAlpha(100),
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
                color: Colors.white.withAlpha(50),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.touch_app, color: Colors.white, size: 32),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BoxHitTestResult',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Result of hit testing on RenderBox',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(220),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'BoxHitTestResult collects the render objects that were hit during a hit test. It provides transformation methods to properly map positions through nested coordinate systems.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withAlpha(240),
            height: 1.5,
          ),
        ),
        SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildFeatureChip('Hit Collection'),
            _buildFeatureChip('Offset Transform'),
            _buildFeatureChip('Matrix Transform'),
            _buildFeatureChip('Path Iteration'),
            _buildFeatureChip('Result Wrapping'),
          ],
        ),
      ],
    ),
  );
}

Widget _buildFeatureChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withAlpha(40),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withAlpha(60)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 12,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget _buildSummarySection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionHeader('Summary', Icons.summarize),
      _buildResultCard('Key Takeaways', [
        _buildPropertyDisplay('Purpose', 'Collect hit test entries for RenderBox'),
        _buildPropertyDisplay('add()', 'Directly add BoxHitTestEntry'),
        _buildPropertyDisplay('addWithPaintOffset()', 'Subtract offset before testing'),
        _buildPropertyDisplay('addWithPaintTransform()', 'Apply inverse matrix transform'),
        _buildPropertyDisplay('path', 'Iterate entries front-to-back'),
        _buildPropertyDisplay('wrap()', 'Share path with parent result'),
      ]),
      _buildCodeBlock(
        'Complete Example',
        '''class MyRenderBox extends RenderBox {
  RenderBox? child;
  Offset paintOffset = Offset(10, 10);
  
  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    // First test child with offset transformation
    bool childHit = result.addWithPaintOffset(
      offset: paintOffset,
      position: position,
      hitTest: (BoxHitTestResult r, Offset pos) {
        return child?.hitTest(r, position: pos) ?? false;
      },
    );
    
    // Then test self
    if (childHit || size.contains(position)) {
      result.add(BoxHitTestEntry(this, position));
      return true;
    }
    
    return false;
  }
}''',
      ),
      _buildInfoCard(
        'Best Practices',
        '1. Always test children before self for proper z-ordering\n2. Use appropriate transform method based on your painting\n3. Use wrap() when delegating from non-box parents\n4. Check path order when debugging hit test issues',
        Icons.tips_and_updates,
      ),
      _buildSubsectionHeader('Related Classes'),
      _buildResultCard('Hit Test Family', [
        _buildPropertyDisplay('HitTestResult', 'Base class for all hit test results'),
        _buildPropertyDisplay('BoxHitTestResult', 'For RenderBox hit testing'),
        _buildPropertyDisplay('SliverHitTestResult', 'For RenderSliver hit testing'),
        _buildPropertyDisplay('HitTestEntry', 'Base entry in hit path'),
        _buildPropertyDisplay('BoxHitTestEntry', 'Entry with localPosition'),
      ]),
    ],
  );
}
