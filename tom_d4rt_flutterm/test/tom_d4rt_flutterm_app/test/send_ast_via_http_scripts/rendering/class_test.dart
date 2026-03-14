// D4rt test script: Tests various rendering classes overview
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Rendering classes test executing');

  // ========== Core Layer Classes ==========
  print('--- Core Layer Classes ---');
  final offsetLayer = OffsetLayer();
  offsetLayer.offset = Offset(10.0, 20.0);
  print('  OffsetLayer: ${offsetLayer.runtimeType}, offset=${offsetLayer.offset}');

  final clipRectLayer = ClipRectLayer(clipRect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0));
  print('  ClipRectLayer: ${clipRectLayer.runtimeType}, rect=${clipRectLayer.clipRect}');

  final opacityLayer = OpacityLayer(alpha: 128);
  print('  OpacityLayer: ${opacityLayer.runtimeType}, alpha=${opacityLayer.alpha}');

  final transformLayer = TransformLayer(transform: Matrix4.identity());
  print('  TransformLayer: ${transformLayer.runtimeType}');

  // ========== Constraints Classes ==========
  print('--- Constraints Classes ---');
  final boxConstraints = BoxConstraints(
    minWidth: 50.0,
    maxWidth: 200.0,
    minHeight: 30.0,
    maxHeight: 150.0,
  );
  print('  BoxConstraints: minW=${boxConstraints.minWidth}, maxW=${boxConstraints.maxWidth}');
  print('    isTight: ${boxConstraints.isTight}');
  print('    isNormalized: ${boxConstraints.isNormalized}');

  final sliverConstraints = SliverConstraints(
    axisDirection: AxisDirection.down,
    growthDirection: GrowthDirection.forward,
    userScrollDirection: ScrollDirection.idle,
    scrollOffset: 0.0,
    precedingScrollExtent: 0.0,
    overlap: 0.0,
    remainingPaintExtent: 500.0,
    crossAxisExtent: 300.0,
    crossAxisDirection: AxisDirection.right,
    viewportMainAxisExtent: 600.0,
    remainingCacheExtent: 500.0,
    cacheOrigin: 0.0,
  );
  print('  SliverConstraints: remainingPaintExtent=${sliverConstraints.remainingPaintExtent}');

  // ========== ParentData Classes ==========
  print('--- ParentData Classes ---');
  final boxParentData = BoxParentData();
  boxParentData.offset = Offset(25.0, 50.0);
  print('  BoxParentData: offset=${boxParentData.offset}');

  final flexParentData = FlexParentData();
  flexParentData.flex = 2;
  flexParentData.fit = FlexFit.tight;
  print('  FlexParentData: flex=${flexParentData.flex}, fit=${flexParentData.fit}');

  final stackParentData = StackParentData();
  stackParentData.top = 10.0;
  stackParentData.left = 20.0;
  print('  StackParentData: top=${stackParentData.top}, left=${stackParentData.left}');

  // ========== Geometry Classes ==========
  print('--- Geometry Classes ---');
  final sliverGeometry = SliverGeometry(
    scrollExtent: 200.0,
    paintExtent: 150.0,
    maxPaintExtent: 200.0,
  );
  print('  SliverGeometry: scrollExtent=${sliverGeometry.scrollExtent}');
  print('    paintExtent: ${sliverGeometry.paintExtent}');
  print('    visible: ${sliverGeometry.visible}');

  final revealedOffset = RevealedOffset(offset: 100.0, rect: Rect.fromLTWH(0, 0, 50, 50));
  print('  RevealedOffset: offset=${revealedOffset.offset}, rect=${revealedOffset.rect}');

  // ========== Hit Test Classes ==========
  print('--- Hit Test Classes ---');
  final hitTestResult = BoxHitTestResult();
  print('  BoxHitTestResult: ${hitTestResult.runtimeType}');
  print('  path length: ${hitTestResult.path.length}');

  final sliverHitTestResult = SliverHitTestResult();
  print('  SliverHitTestResult: ${sliverHitTestResult.runtimeType}');

  // ========== Selection Classes ==========
  print('--- Selection Classes ---');
  final selectionPoint = SelectionPoint(
    localPosition: Offset(50.0, 25.0),
    lineHeight: 16.0,
    handleType: TextSelectionHandleType.left,
  );
  print('  SelectionPoint: position=${selectionPoint.localPosition}');
  print('    lineHeight: ${selectionPoint.lineHeight}');
  print('    handleType: ${selectionPoint.handleType}');

  final selectionGeometry = SelectionGeometry(
    startSelectionPoint: selectionPoint,
    endSelectionPoint: selectionPoint,
    status: SelectionStatus.uncollapsed,
  );
  print('  SelectionGeometry: status=${selectionGeometry.status}');
  print('    hasSelection: ${selectionGeometry.hasSelection}');

  // ========== Paint Context Classes ==========
  print('--- Paint & Layout Classes ---');
  final layerHandle = LayerHandle<OffsetLayer>();
  print('  LayerHandle: ${layerHandle.runtimeType}');
  print('  layer: ${layerHandle.layer}');

  final layerLink = LayerLink();
  print('  LayerLink: ${layerLink.runtimeType}');
  print('  leader: ${layerLink.leader}');

  // ========== Alignment & Positioning ==========
  print('--- Alignment & Positioning ---');
  print('  Alignment.center: ${Alignment.center}');
  print('  Alignment.topLeft: ${Alignment.topLeft}');
  print('  FractionalOffset.center: ${FractionalOffset.center}');
  print('  FractionalOffset.topLeft: ${FractionalOffset.topLeft}');

  // ========== Enumeration Classes ==========
  print('--- Enumeration Classes ---');
  print('  AxisDirection.values: ${AxisDirection.values.length} values');
  print('  GrowthDirection.values: ${GrowthDirection.values.length} values');
  print('  ScrollDirection.values: ${ScrollDirection.values.length} values');
  print('  TextSelectionHandleType.values: ${TextSelectionHandleType.values.length} values');
  print('  FlexFit.values: ${FlexFit.values.length} values');
  print('  MainAxisAlignment.values: ${MainAxisAlignment.values.length} values');
  print('  CrossAxisAlignment.values: ${CrossAxisAlignment.values.length} values');

  // ========== Table Classes ==========
  print('--- Table Classes ---');
  final tableBorder = TableBorder.all(
    color: Color(0xFF000000),
    width: 1.0,
  );
  print('  TableBorder: ${tableBorder.runtimeType}');
  print('    top: ${tableBorder.top}');
  print('    isUniform: ${tableBorder.isUniform}');

  print('Rendering classes test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Rendering Classes Overview',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('Layer Classes: OffsetLayer, ClipRect, Opacity, Transform'),
          Text('Constraints: BoxConstraints, SliverConstraints'),
          Text('ParentData: Box, Flex, Stack'),
          Text('Geometry: SliverGeometry, RevealedOffset'),
          Text('Hit Test: BoxHitTestResult, SliverHitTestResult'),
          Text('Selection: SelectionPoint, SelectionGeometry'),
          Text('Alignment: Alignment, FractionalOffset'),
          Text('Table: TableBorder'),
        ],
      ),
    ),
  );
}
