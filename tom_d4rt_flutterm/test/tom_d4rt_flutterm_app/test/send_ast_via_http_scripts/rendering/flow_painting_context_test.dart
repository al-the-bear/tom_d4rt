// D4rt test script: Tests FlowPaintingContext from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FlowPaintingContext test executing');

  // ========== FlowPaintingContext is abstract - test via Flow widget ==========
  print('--- FlowPaintingContext (abstract) ---');
  print('  FlowPaintingContext is an abstract class used by FlowDelegate');
  print('  Testing via FlowDelegate implementation');

  // ========== Custom FlowDelegate to access FlowPaintingContext ==========
  print('--- Custom FlowDelegate ---');
  int paintCallCount = 0;
  Size? lastSize;
  int? lastChildCount;

  final delegate = _TestFlowDelegate(
    onPaint: (FlowPaintingContext flowContext, Size size, int childCount) {
      paintCallCount++;
      lastSize = size;
      lastChildCount = childCount;
    },
  );
  print('  delegate created: ${delegate.runtimeType}');
  print('  shouldRepaint: ${delegate.shouldRepaint(delegate)}');

  // ========== FlowDelegate methods ==========
  print('--- FlowDelegate methods ---');
  print(
    '  getSize returns: ${delegate.getSize(BoxConstraints.loose(Size(200.0, 200.0)))}',
  );
  print(
    '  getConstraintsForChild: ${delegate.getConstraintsForChild(0, BoxConstraints.loose(Size(100.0, 100.0)))}',
  );

  // ========== Create Flow widget to trigger FlowPaintingContext ==========
  print('--- Flow widget with delegate ---');
  final flowWidget = Flow(
    delegate: _SimpleFlowDelegate(),
    children: [
      Container(width: 40.0, height: 40.0, color: Color(0xFF2196F3)),
      Container(width: 40.0, height: 40.0, color: Color(0xFF4CAF50)),
      Container(width: 40.0, height: 40.0, color: Color(0xFFFF5722)),
    ],
  );
  print('  Flow widget created');
  print('  children count: 3');

  // ========== FlowDelegate with different layouts ==========
  print('--- Different FlowDelegate layouts ---');
  final horizontalDelegate = _HorizontalFlowDelegate();
  print('  horizontal delegate: ${horizontalDelegate.runtimeType}');

  final verticalDelegate = _VerticalFlowDelegate();
  print('  vertical delegate: ${verticalDelegate.runtimeType}');

  // ========== FlowDelegate shouldRepaint ==========
  print('--- shouldRepaint tests ---');
  final delegateA = _SimpleFlowDelegate();
  final delegateB = _SimpleFlowDelegate();
  print(
    '  delegateA.shouldRepaint(delegateA): ${delegateA.shouldRepaint(delegateA)}',
  );
  print(
    '  delegateA.shouldRepaint(delegateB): ${delegateA.shouldRepaint(delegateB)}',
  );

  // ========== FlowDelegate getSize ==========
  print('--- getSize tests ---');
  final constraints = BoxConstraints(maxWidth: 300.0, maxHeight: 200.0);
  print(
    '  getSize with constrained: ${_SimpleFlowDelegate().getSize(constraints)}',
  );
  print(
    '  getSize with loose: ${_SimpleFlowDelegate().getSize(BoxConstraints.loose(Size(400.0, 300.0)))}',
  );

  print('FlowPaintingContext test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'FlowPaintingContext Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('FlowPaintingContext is abstract'),
          Text('Tested via FlowDelegate'),
          SizedBox(height: 8.0),
          Container(
            height: 60.0,
            child: Flow(
              delegate: _HorizontalFlowDelegate(),
              children: [
                Container(width: 40.0, height: 40.0, color: Color(0xFF2196F3)),
                Container(width: 40.0, height: 40.0, color: Color(0xFF4CAF50)),
                Container(width: 40.0, height: 40.0, color: Color(0xFFFF5722)),
              ],
            ),
          ),
          Text('Horizontal Flow Layout'),
        ],
      ),
    ),
  );
}

class _TestFlowDelegate extends FlowDelegate {
  final void Function(FlowPaintingContext, Size, int) onPaint;
  _TestFlowDelegate({required this.onPaint});

  @override
  void paintChildren(FlowPaintingContext context) {
    onPaint(context, context.size, 0);
    for (int i = 0; i < 3; i++) {
      context.paintChild(i);
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}

class _SimpleFlowDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    for (int i = 0; i < 3; i++) {
      context.paintChild(
        i,
        transform: Matrix4.translationValues(i * 50.0, 0.0, 0.0),
      );
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}

class _HorizontalFlowDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    double dx = 0.0;
    for (int i = 0; i < 3; i++) {
      context.paintChild(
        i,
        transform: Matrix4.translationValues(dx, 10.0, 0.0),
      );
      dx += 50.0;
    }
  }

  @override
  Size getSize(BoxConstraints constraints) => Size(150.0, 60.0);

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}

class _VerticalFlowDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    double dy = 0.0;
    for (int i = 0; i < 3; i++) {
      context.paintChild(i, transform: Matrix4.translationValues(0.0, dy, 0.0));
      dy += 50.0;
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}
