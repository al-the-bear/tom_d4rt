// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests StackParentData, FlexParentData, BoxParentData, SliverGridParentData concepts
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('ParentData test executing');

  // ========== BOX PARENT DATA ==========
  print('--- BoxParentData Tests ---');

  final boxParentData = BoxParentData();
  print('BoxParentData created: ${boxParentData.runtimeType}');
  print('  offset: ${boxParentData.offset}');

  boxParentData.offset = Offset(10.0, 20.0);
  print('After setting offset: ${boxParentData.offset}');

  boxParentData.offset = Offset(50.0, 100.0);
  print('After setting offset again: ${boxParentData.offset}');

  boxParentData.offset = Offset.zero;
  print('After setting offset to zero: ${boxParentData.offset}');

  // ========== STACK PARENT DATA ==========
  print('--- StackParentData Tests ---');

  final stackData = StackParentData();
  print('StackParentData created: ${stackData.runtimeType}');

  // Set positioning properties
  stackData.top = 10.0;
  stackData.left = 20.0;
  stackData.right = null;
  stackData.bottom = null;
  stackData.width = 100.0;
  stackData.height = 80.0;
  print('StackParentData set:');
  print('  top: ${stackData.top}');
  print('  left: ${stackData.left}');
  print('  right: ${stackData.right}');
  print('  bottom: ${stackData.bottom}');
  print('  width: ${stackData.width}');
  print('  height: ${stackData.height}');
  print('  isPositioned: ${stackData.isPositioned}');

  // All null = not positioned
  final stackDataEmpty = StackParentData();
  print('StackParentData(empty) isPositioned: ${stackDataEmpty.isPositioned}');

  // Only right and bottom
  final stackDataRB = StackParentData();
  stackDataRB.right = 30.0;
  stackDataRB.bottom = 40.0;
  print('StackParentData(right=30, bottom=40):');
  print('  right: ${stackDataRB.right}');
  print('  bottom: ${stackDataRB.bottom}');
  print('  isPositioned: ${stackDataRB.isPositioned}');

  // ========== FLEX PARENT DATA ==========
  print('--- FlexParentData Tests ---');

  // FlexParentData is used by RenderFlex children
  // It extends BoxParentData and adds flex/fit properties
  final flexData = FlexParentData();
  print('FlexParentData created: ${flexData.runtimeType}');
  print('  flex: ${flexData.flex}');
  print('  fit: ${flexData.fit}');

  flexData.flex = 2;
  print('After setting flex=2: ${flexData.flex}');

  flexData.fit = FlexFit.tight;
  print('After setting fit=tight: ${flexData.fit}');

  flexData.fit = FlexFit.loose;
  print('After setting fit=loose: ${flexData.fit}');

  // offset from BoxParentData
  flexData.offset = Offset(5.0, 10.0);
  print('FlexParentData offset: ${flexData.offset}');

  // ========== FLEX FIT ENUM ==========
  print('--- FlexFit values ---');
  print('FlexFit.tight: ${FlexFit.tight}');
  print('FlexFit.loose: ${FlexFit.loose}');

  // ========== MULTI CHILD LAYOUT PARENT DATA ==========
  print('--- MultiChildLayoutParentData Tests ---');

  final multiChildData = MultiChildLayoutParentData();
  print('MultiChildLayoutParentData created: ${multiChildData.runtimeType}');
  print('  id: ${multiChildData.id}');
  print('  offset: ${multiChildData.offset}');

  multiChildData.id = 'header';
  print('After setting id=header: ${multiChildData.id}');

  multiChildData.offset = Offset(0.0, 50.0);
  print('After setting offset: ${multiChildData.offset}');

  // ========== SLIVER PHYSICAL PARENT DATA ==========
  print('--- SliverPhysicalParentData Tests ---');

  final sliverPhysData = SliverPhysicalParentData();
  print('SliverPhysicalParentData created: ${sliverPhysData.runtimeType}');
  print('  paintOffset: ${sliverPhysData.paintOffset}');

  sliverPhysData.paintOffset = Offset(0.0, 100.0);
  print('After setting paintOffset: ${sliverPhysData.paintOffset}');

  // ========== SLIVER LOGICAL PARENT DATA ==========
  print('--- SliverLogicalParentData Tests ---');

  final sliverLogData = SliverLogicalParentData();
  print('SliverLogicalParentData created: ${sliverLogData.runtimeType}');
  print('  layoutOffset: ${sliverLogData.layoutOffset}');

  sliverLogData.layoutOffset = 200.0;
  print('After setting layoutOffset: ${sliverLogData.layoutOffset}');

  // ========== RELATIVE RECT ==========
  print('--- RelativeRect Tests ---');

  final relRect = RelativeRect.fromLTRB(10.0, 20.0, 30.0, 40.0);
  print('RelativeRect.fromLTRB(10,20,30,40):');
  print('  left: ${relRect.left}');
  print('  top: ${relRect.top}');
  print('  right: ${relRect.right}');
  print('  bottom: ${relRect.bottom}');

  final relRectFill = RelativeRect.fill;
  print('RelativeRect.fill:');
  print('  left: ${relRectFill.left}');
  print('  top: ${relRectFill.top}');
  print('  right: ${relRectFill.right}');
  print('  bottom: ${relRectFill.bottom}');

  final relRectFromSize = RelativeRect.fromSize(
    Rect.fromLTWH(10, 20, 100, 80),
    Size(200, 150),
  );
  print('RelativeRect.fromSize:');
  print('  left: ${relRectFromSize.left}');
  print('  top: ${relRectFromSize.top}');
  print('  right: ${relRectFromSize.right}');
  print('  bottom: ${relRectFromSize.bottom}');

  final relRectFromRect = RelativeRect.fromRect(
    Rect.fromLTWH(10, 20, 100, 80),
    Rect.fromLTWH(0, 0, 200, 150),
  );
  print('RelativeRect.fromRect:');
  print('  left: ${relRectFromRect.left}');
  print('  top: ${relRectFromRect.top}');

  // RelativeRect methods
  final shifted = relRect.shift(Offset(5.0, 5.0));
  print('RelativeRect.shift(5,5): left=${shifted.left}, top=${shifted.top}');

  final inflated = relRect.inflate(2.0);
  print('RelativeRect.inflate(2): left=${inflated.left}, top=${inflated.top}');

  final deflated = relRect.deflate(1.0);
  print('RelativeRect.deflate(1): left=${deflated.left}, top=${deflated.top}');

  final rect = relRect.toRect(Rect.fromLTWH(0, 0, 200, 150));
  print('RelativeRect.toRect: $rect');

  final size = relRect.toSize(Size(200, 150));
  print('RelativeRect.toSize: $size');

  // ========== POSITIONED WIDGET USAGE ==========
  print('--- Positioned widget with parent data ---');

  final positioned = Positioned(
    left: 10,
    top: 20,
    width: 100,
    height: 80,
    child: Text('Positioned child'),
  );
  print('Positioned widget created: ${positioned.runtimeType}');
  print('  left: ${positioned.left}');
  print('  top: ${positioned.top}');
  print('  width: ${positioned.width}');
  print('  height: ${positioned.height}');

  print('ParentData test completed');
  return Text('ParentData test passed');
}
