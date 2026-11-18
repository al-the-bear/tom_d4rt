// ignore_for_file: avoid_print
// D4rt test script: RenderView, ViewConfiguration, Layer, RenderFlow
// (rendering, addtests1).
//
// RenderView is built for the current FlutterView, not attached: the root
// render view belongs to the binding. Layer is abstract; the script builds a
// concrete OffsetLayer and uses it as a Layer.
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class _RowFlow extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {}

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}

dynamic build(BuildContext context) {
  print('=== ViewConfiguration / RenderView ===');
  const configuration = ViewConfiguration(
    logicalConstraints: BoxConstraints(maxWidth: 400, maxHeight: 300),
    devicePixelRatio: 2,
  );
  print('dpr: ${configuration.devicePixelRatio}');
  print('logical max: ${configuration.logicalConstraints.maxWidth}');
  final renderView = RenderView(
    view: View.of(context),
    configuration: configuration,
  );
  print('render view config dpr: ${renderView.configuration.devicePixelRatio}');

  print('=== Layer ===');
  final Layer layer = OffsetLayer(offset: const Offset(3, 4));
  print('layer is offset layer: ${layer is OffsetLayer}');
  print('layer attached: ${layer.attached}');

  print('=== RenderFlow ===');
  final flow = RenderFlow(delegate: _RowFlow());
  print('flow children: ${flow.childCount}');
  print('flow clip: ${flow.clipBehavior}');
  return const Center(child: Text('view / layer / flow'));
}
