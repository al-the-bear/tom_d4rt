// D4rt test script: Tests painting enums - TextOverflow, BoxFit, ImageRepeat,
// FilterQuality, TextWidthBasis, ClipBehavior, Axis, AxisDirection,
// ScrollDirection, GrowthDirection
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Painting enums test executing');

  // ========== TEXTOVERFLOW ==========
  print('--- TextOverflow Tests ---');
  print('TextOverflow.clip: ${TextOverflow.clip}');
  print('TextOverflow.fade: ${TextOverflow.fade}');
  print('TextOverflow.ellipsis: ${TextOverflow.ellipsis}');
  print('TextOverflow.visible: ${TextOverflow.visible}');
  print('TextOverflow.values: ${TextOverflow.values}');
  print('TextOverflow.ellipsis.name: ${TextOverflow.ellipsis.name}');

  // ========== BOXFIT ==========
  print('--- BoxFit Tests ---');
  print('BoxFit.fill: ${BoxFit.fill}');
  print('BoxFit.contain: ${BoxFit.contain}');
  print('BoxFit.cover: ${BoxFit.cover}');
  print('BoxFit.fitWidth: ${BoxFit.fitWidth}');
  print('BoxFit.fitHeight: ${BoxFit.fitHeight}');
  print('BoxFit.none: ${BoxFit.none}');
  print('BoxFit.scaleDown: ${BoxFit.scaleDown}');
  print('BoxFit.values count: ${BoxFit.values.length}');

  // ========== IMAGEREPEAT ==========
  print('--- ImageRepeat Tests ---');
  print('ImageRepeat.noRepeat: ${ImageRepeat.noRepeat}');
  print('ImageRepeat.repeat: ${ImageRepeat.repeat}');
  print('ImageRepeat.repeatX: ${ImageRepeat.repeatX}');
  print('ImageRepeat.repeatY: ${ImageRepeat.repeatY}');
  print('ImageRepeat.values count: ${ImageRepeat.values.length}');

  // ========== FILTERQUALITY ==========
  print('--- FilterQuality Tests ---');
  print('FilterQuality.none: ${FilterQuality.none}');
  print('FilterQuality.low: ${FilterQuality.low}');
  print('FilterQuality.medium: ${FilterQuality.medium}');
  print('FilterQuality.high: ${FilterQuality.high}');

  // ========== TEXTWIDTHBASIS ==========
  print('--- TextWidthBasis Tests ---');
  print('TextWidthBasis.parent: ${TextWidthBasis.parent}');
  print('TextWidthBasis.longestLine: ${TextWidthBasis.longestLine}');
  print('TextWidthBasis.values count: ${TextWidthBasis.values.length}');

  // ========== CLIPBEHAVIOR ==========
  print('--- Clip Tests ---');
  print('Clip.none: ${Clip.none}');
  print('Clip.hardEdge: ${Clip.hardEdge}');
  print('Clip.antiAlias: ${Clip.antiAlias}');
  print('Clip.antiAliasWithSaveLayer: ${Clip.antiAliasWithSaveLayer}');
  print('Clip.values count: ${Clip.values.length}');

  // ========== AXISDIRECTION ==========
  print('--- AxisDirection Tests ---');
  print('AxisDirection.up: ${AxisDirection.up}');
  print('AxisDirection.right: ${AxisDirection.right}');
  print('AxisDirection.down: ${AxisDirection.down}');
  print('AxisDirection.left: ${AxisDirection.left}');
  print('AxisDirection.values count: ${AxisDirection.values.length}');

  // ========== GROWTHDIRECTION ==========
  print('--- GrowthDirection Tests ---');
  print('GrowthDirection.forward: ${GrowthDirection.forward}');
  print('GrowthDirection.reverse: ${GrowthDirection.reverse}');
  print('GrowthDirection.values count: ${GrowthDirection.values.length}');

  // ========== SCROLLDIRECTION ==========
  print('--- ScrollDirection Tests ---');
  print('ScrollDirection.idle: ${ScrollDirection.idle}');
  print('ScrollDirection.forward: ${ScrollDirection.forward}');
  print('ScrollDirection.reverse: ${ScrollDirection.reverse}');
  print('ScrollDirection.values count: ${ScrollDirection.values.length}');

  print('All painting enums tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Painting Enums Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text('TextOverflow values: ${TextOverflow.values.length}'),
            Text('BoxFit values: ${BoxFit.values.length}'),
            Text('ImageRepeat values: ${ImageRepeat.values.length}'),
            Text('FilterQuality values: ${FilterQuality.values.length}'),
            Text('TextWidthBasis values: ${TextWidthBasis.values.length}'),
            Text('Clip values: ${Clip.values.length}'),
            Text('AxisDirection values: ${AxisDirection.values.length}'),
            Text('GrowthDirection values: ${GrowthDirection.values.length}'),
            Text('ScrollDirection values: ${ScrollDirection.values.length}'),
          ],
        ),
      ),
    ),
  );
}
