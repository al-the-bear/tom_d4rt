// Fa6 reproducer — two-bridged-mixin shape:
//   class _MyRO extends RenderBox with
//       ContainerRenderObjectMixin<RenderBox, _PD>,
//       RenderBoxContainerDefaultsMixin<RenderBox, _PD>
//
// This is the most common composite shape in the corpus. Existing
// infrastructure handles it via hand-written `_InterpretedRenderBoxContainer`
// (d4rt_runtime_registrations.dart line 2811-2900) — Option 1 closure for
// this specific pair. Verifies that the proxy walk continues to satisfy
// framework casts to both mixins for an interpreted subclass.
//
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class _PD extends ContainerBoxParentData<RenderBox> {}

class _MultiChildHostWidget extends MultiChildRenderObjectWidget {
  const _MultiChildHostWidget({super.children});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderMultiChildHost();
  }
}

class _RenderMultiChildHost extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _PD>,
        RenderBoxContainerDefaultsMixin<RenderBox, _PD> {
  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! _PD) {
      child.parentData = _PD();
    }
  }

  @override
  void performLayout() {
    var width = 0.0;
    var height = 0.0;
    var child = firstChild;
    while (child != null) {
      child.layout(constraints, parentUsesSize: true);
      final pd = child.parentData! as _PD;
      pd.offset = Offset(0, height);
      width = width < child.size.width ? child.size.width : width;
      height += child.size.height;
      child = pd.nextSibling;
    }
    size = constraints.constrain(Size(width, height));
    print('[fa6-2mix] performLayout childCount=$childCount size=$size');
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }
}

dynamic build(BuildContext context) {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Center(
        child: _MultiChildHostWidget(
          children: <Widget>[
            SizedBox(width: 80, height: 24, child: ColoredBox(color: Colors.indigo)),
            SizedBox(width: 60, height: 24, child: ColoredBox(color: Colors.teal)),
            SizedBox(width: 100, height: 24, child: ColoredBox(color: Colors.orange)),
          ],
        ),
      ),
    ),
  );
}
