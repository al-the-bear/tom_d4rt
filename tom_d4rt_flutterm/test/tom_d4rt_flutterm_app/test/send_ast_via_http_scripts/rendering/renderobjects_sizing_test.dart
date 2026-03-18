// D4rt test script: Tests RenderAspectRatio, RenderFittedBox, RenderLimitedBox, RenderIntrinsicWidth, RenderIntrinsicHeight
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('RenderObjects sizing test executing');

  // ========== RENDER ASPECT RATIO ==========
  print('--- RenderAspectRatio Tests ---');

  final aspectRatio16x9 = RenderAspectRatio(aspectRatio: 16.0 / 9.0);
  print('RenderAspectRatio(16:9) created: ${aspectRatio16x9.runtimeType}');
  print('  aspectRatio: ${aspectRatio16x9.aspectRatio}');

  final aspectRatio1x1 = RenderAspectRatio(aspectRatio: 1.0);
  print('RenderAspectRatio(1:1) aspectRatio: ${aspectRatio1x1.aspectRatio}');

  final aspectRatio4x3 = RenderAspectRatio(aspectRatio: 4.0 / 3.0);
  print('RenderAspectRatio(4:3) aspectRatio: ${aspectRatio4x3.aspectRatio}');

  // Modify aspectRatio
  aspectRatio16x9.aspectRatio = 2.0;
  print('After setting aspectRatio to 2.0: ${aspectRatio16x9.aspectRatio}');

  // ========== RENDER FITTED BOX ==========
  print('--- RenderFittedBox Tests ---');

  final fittedBoxDefault = RenderFittedBox();
  print('RenderFittedBox() created: ${fittedBoxDefault.runtimeType}');
  print('  fit: ${fittedBoxDefault.fit}');
  print('  alignment: ${fittedBoxDefault.alignment}');
  print('  clipBehavior: ${fittedBoxDefault.clipBehavior}');

  final fittedBoxContain = RenderFittedBox(
    fit: BoxFit.contain,
    alignment: Alignment.center,
  );
  print('RenderFittedBox(contain, center):');
  print('  fit: ${fittedBoxContain.fit}');
  print('  alignment: ${fittedBoxContain.alignment}');

  final fittedBoxCover = RenderFittedBox(
    fit: BoxFit.cover,
    alignment: Alignment.topLeft,
    clipBehavior: Clip.hardEdge,
  );
  print('RenderFittedBox(cover, topLeft, hardEdge):');
  print('  fit: ${fittedBoxCover.fit}');
  print('  alignment: ${fittedBoxCover.alignment}');
  print('  clipBehavior: ${fittedBoxCover.clipBehavior}');

  final fittedBoxFill = RenderFittedBox(
    fit: BoxFit.fill,
    textDirection: TextDirection.ltr,
  );
  print('RenderFittedBox(fill) fit: ${fittedBoxFill.fit}');

  // Modify properties
  fittedBoxDefault.fit = BoxFit.scaleDown;
  print('After setting fit to scaleDown: ${fittedBoxDefault.fit}');

  // ========== BOX FIT ENUM ==========
  print('--- BoxFit enum values ---');
  print('BoxFit.fill: ${BoxFit.fill}');
  print('BoxFit.contain: ${BoxFit.contain}');
  print('BoxFit.cover: ${BoxFit.cover}');
  print('BoxFit.fitWidth: ${BoxFit.fitWidth}');
  print('BoxFit.fitHeight: ${BoxFit.fitHeight}');
  print('BoxFit.none: ${BoxFit.none}');
  print('BoxFit.scaleDown: ${BoxFit.scaleDown}');

  // ========== RENDER LIMITED BOX ==========
  print('--- RenderLimitedBox Tests ---');

  final limitedBox = RenderLimitedBox();
  print('RenderLimitedBox() created: ${limitedBox.runtimeType}');
  print('  maxWidth: ${limitedBox.maxWidth}');
  print('  maxHeight: ${limitedBox.maxHeight}');

  final limitedBoxCustom = RenderLimitedBox(maxWidth: 200.0, maxHeight: 150.0);
  print('RenderLimitedBox(200x150):');
  print('  maxWidth: ${limitedBoxCustom.maxWidth}');
  print('  maxHeight: ${limitedBoxCustom.maxHeight}');

  // Modify properties
  limitedBox.maxWidth = 300.0;
  print('After setting maxWidth to 300: ${limitedBox.maxWidth}');
  limitedBox.maxHeight = 250.0;
  print('After setting maxHeight to 250: ${limitedBox.maxHeight}');

  // ========== RENDER INTRINSIC WIDTH ==========
  print('--- RenderIntrinsicWidth Tests ---');

  final intrinsicWidth = RenderIntrinsicWidth();
  print('RenderIntrinsicWidth() created: ${intrinsicWidth.runtimeType}');
  print('  stepWidth: ${intrinsicWidth.stepWidth}');
  print('  stepHeight: ${intrinsicWidth.stepHeight}');

  final intrinsicWidthCustom = RenderIntrinsicWidth(
    stepWidth: 50.0,
    stepHeight: 25.0,
  );
  print('RenderIntrinsicWidth(50, 25):');
  print('  stepWidth: ${intrinsicWidthCustom.stepWidth}');
  print('  stepHeight: ${intrinsicWidthCustom.stepHeight}');

  // Modify properties
  intrinsicWidth.stepWidth = 100.0;
  print('After setting stepWidth to 100: ${intrinsicWidth.stepWidth}');

  // ========== RENDER INTRINSIC HEIGHT ==========
  print('--- RenderIntrinsicHeight Tests ---');

  final intrinsicHeight = RenderIntrinsicHeight();
  print('RenderIntrinsicHeight() created: ${intrinsicHeight.runtimeType}');

  // RenderIntrinsicHeight has no special configuration properties
  // It sizes its child to the child's intrinsic height
  print('Note: RenderIntrinsicHeight sizes child to intrinsic height');

  // Note: Cannot call layout() or paint() on orphan render objects
  print('Note: render objects not laid out - no parent render tree attached');

  print('RenderObjects sizing test completed');
  return Container(child: Text('RenderObjects sizing test passed'));
}
