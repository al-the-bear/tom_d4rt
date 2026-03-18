// D4rt test script: Tests viewport and scroll related rendering classes
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Rendering viewport test executing');

  // ========== VIEWPORTOFFSET ==========
  print('--- ViewportOffset Tests ---');

  // Test ViewportOffset.fixed
  final fixedOffset = ViewportOffset.fixed(100.0);
  print('ViewportOffset.fixed(100): pixels=${fixedOffset.pixels}');

  // Test ViewportOffset.zero
  final zeroOffset = ViewportOffset.zero();
  print('ViewportOffset.zero(): pixels=${zeroOffset.pixels}');

  // Test hasPixels
  print('hasPixels (fixed): ${fixedOffset.hasPixels}');

  // Test pixels property
  print('pixels: ${fixedOffset.pixels}');

  // Test userScrollDirection
  print('userScrollDirection: ${fixedOffset.userScrollDirection}');

  // Test allowImplicitScrolling
  print('allowImplicitScrolling: ${fixedOffset.allowImplicitScrolling}');

  // Test applyViewportDimension
  final applyResult = fixedOffset.applyViewportDimension(200.0);
  print('applyViewportDimension(200): $applyResult');

  // Test applyContentDimensions
  final contentResult = fixedOffset.applyContentDimensions(0.0, 500.0);
  print('applyContentDimensions(0, 500): $contentResult');

  // ========== VIEWCONFIGURATION ==========
  print('--- ViewConfiguration Tests ---');

  // Note: ViewConfiguration has been deprecated in favor of other APIs

  // ========== BOXPARENTDATA ==========
  print('--- BoxParentData Tests ---');

  final parentData = BoxParentData();
  print('BoxParentData created: offset=${parentData.offset}');

  // Test setting offset
  parentData.offset = Offset(10.0, 20.0);
  print('After setting offset: ${parentData.offset}');

  // ========== FLEX PARENT DATA ==========
  print('--- FlexParentData Tests ---');

  // Note: Cannot directly test FlexParentData without RenderFlex

  // ========== STACKPARENTDATA ==========
  print('--- StackParentData Tests ---');

  final stackParentData = StackParentData();
  print('StackParentData created');

  stackParentData.top = 10.0;
  stackParentData.left = 20.0;
  stackParentData.right = null;
  stackParentData.bottom = null;
  stackParentData.width = 100.0;
  stackParentData.height = 80.0;
  print(
    'StackParentData: top=${stackParentData.top}, left=${stackParentData.left}',
  );
  print('  width=${stackParentData.width}, height=${stackParentData.height}');

  // Test isPositioned
  print('isPositioned: ${stackParentData.isPositioned}');

  // ========== CUSTOM PAINTER ==========
  print('--- CustomPainter abstract info ---');
  // CustomPainter is abstract but we can show its usage

  print('Rendering viewport test completed');

  // Return a visual representation using scroll-related widgets
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Viewport & Rendering Tests',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            Text(
              'ViewportOffset.fixed(100):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('pixels: 100.0'),
            SizedBox(height: 8.0),

            Text(
              'ViewportOffset.zero():',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('pixels: 0.0'),
            SizedBox(height: 16.0),

            Text(
              'BoxParentData Offset:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Stack(
              children: [
                Container(
                  width: 200.0,
                  height: 100.0,
                  color: Color(0xFFE3F2FD),
                ),
                Positioned(
                  left: 10.0,
                  top: 20.0,
                  child: Container(
                    width: 50.0,
                    height: 40.0,
                    color: Color(0xFF2196F3),
                    child: Center(
                      child: Text(
                        'Offset',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'StackParentData Positioning:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              width: 200.0,
              height: 150.0,
              color: Color(0xFFFFF3E0),
              child: Stack(
                children: [
                  Positioned(
                    top: 10.0,
                    left: 10.0,
                    width: 60.0,
                    height: 40.0,
                    child: Container(
                      color: Color(0xFFE53935),
                      child: Center(
                        child: Text(
                          'TL',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10.0,
                    right: 10.0,
                    width: 60.0,
                    height: 40.0,
                    child: Container(
                      color: Color(0xFF4CAF50),
                      child: Center(
                        child: Text(
                          'TR',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10.0,
                    left: 10.0,
                    width: 60.0,
                    height: 40.0,
                    child: Container(
                      color: Color(0xFF2196F3),
                      child: Center(
                        child: Text(
                          'BL',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10.0,
                    right: 10.0,
                    width: 60.0,
                    height: 40.0,
                    child: Container(
                      color: Color(0xFFFF9800),
                      child: Center(
                        child: Text(
                          'BR',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 60.0,
                      height: 40.0,
                      color: Color(0xFF9C27B0),
                      child: Center(
                        child: Text(
                          'Center',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            Text(
              'Scrollable Viewport Demo:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 100.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  10,
                  (index) => Container(
                    width: 80.0,
                    margin: EdgeInsets.all(4.0),
                    color: Color(
                      0xFF2196F3,
                    ).withValues(alpha: 0.5 + (index % 5) * 0.1),
                    child: Center(
                      child: Text(
                        'Item $index',
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
