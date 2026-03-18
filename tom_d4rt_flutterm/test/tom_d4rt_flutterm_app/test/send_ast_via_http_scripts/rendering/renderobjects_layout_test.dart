// D4rt test script: Tests RenderFlex, RenderWrap, RenderTable, RenderFlow, RenderListBody
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('RenderObjects layout test executing');

  // ========== RENDER FLEX ==========
  print('--- RenderFlex Tests ---');

  final flexH = RenderFlex(direction: Axis.horizontal);
  print('RenderFlex(horizontal) created: ${flexH.runtimeType}');
  print('  direction: ${flexH.direction}');
  print('  mainAxisAlignment: ${flexH.mainAxisAlignment}');
  print('  crossAxisAlignment: ${flexH.crossAxisAlignment}');
  print('  mainAxisSize: ${flexH.mainAxisSize}');

  final flexV = RenderFlex(direction: Axis.vertical);
  print('RenderFlex(vertical) direction: ${flexV.direction}');

  final flexFull = RenderFlex(
    direction: Axis.horizontal,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    textDirection: TextDirection.ltr,
    verticalDirection: VerticalDirection.down,
  );
  print('RenderFlex(full params):');
  print('  mainAxisAlignment: ${flexFull.mainAxisAlignment}');
  print('  crossAxisAlignment: ${flexFull.crossAxisAlignment}');
  print('  mainAxisSize: ${flexFull.mainAxisSize}');
  print('  textDirection: ${flexFull.textDirection}');
  print('  verticalDirection: ${flexFull.verticalDirection}');

  // Modify properties
  flexH.direction = Axis.vertical;
  print('After direction change: ${flexH.direction}');
  flexH.mainAxisAlignment = MainAxisAlignment.end;
  print('After mainAxisAlignment change: ${flexH.mainAxisAlignment}');

  // ========== RENDER WRAP ==========
  print('--- RenderWrap Tests ---');

  final wrap = RenderWrap();
  print('RenderWrap() created: ${wrap.runtimeType}');
  print('  direction: ${wrap.direction}');
  print('  alignment: ${wrap.alignment}');
  print('  spacing: ${wrap.spacing}');
  print('  runAlignment: ${wrap.runAlignment}');
  print('  runSpacing: ${wrap.runSpacing}');
  print('  crossAxisAlignment: ${wrap.crossAxisAlignment}');

  final wrapCustom = RenderWrap(
    direction: Axis.vertical,
    alignment: WrapAlignment.center,
    spacing: 8.0,
    runAlignment: WrapAlignment.spaceBetween,
    runSpacing: 4.0,
    crossAxisAlignment: WrapCrossAlignment.center,
    textDirection: TextDirection.ltr,
    verticalDirection: VerticalDirection.down,
  );
  print('RenderWrap(custom):');
  print('  direction: ${wrapCustom.direction}');
  print('  alignment: ${wrapCustom.alignment}');
  print('  spacing: ${wrapCustom.spacing}');
  print('  runAlignment: ${wrapCustom.runAlignment}');
  print('  runSpacing: ${wrapCustom.runSpacing}');
  print('  crossAxisAlignment: ${wrapCustom.crossAxisAlignment}');

  // Modify properties
  wrap.spacing = 12.0;
  print('After spacing change: ${wrap.spacing}');
  wrap.runSpacing = 6.0;
  print('After runSpacing change: ${wrap.runSpacing}');

  // ========== RENDER TABLE ==========
  print('--- RenderTable Tests ---');

  final table = RenderTable(columns: 3, textDirection: TextDirection.ltr);
  print('RenderTable(3 columns) created: ${table.runtimeType}');
  print('  columns: ${table.columns}');
  print('  rows: ${table.rows}');
  print('  textDirection: ${table.textDirection}');

  final tableWithDefaults = RenderTable(
    columns: 2,
    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    textDirection: TextDirection.ltr,
  );
  print('RenderTable(2 cols, middle align):');
  print('  columns: ${tableWithDefaults.columns}');
  print(
    '  defaultVerticalAlignment: ${tableWithDefaults.defaultVerticalAlignment}',
  );

  // Modify columns
  table.columns = 4;
  print('After columns change to 4: ${table.columns}');

  // ========== RENDER FLOW ==========
  print('--- RenderFlow Tests ---');

  // Note: RenderFlow requires a FlowDelegate, which is abstract.
  // We cannot instantiate RenderFlow without providing a concrete delegate.
  // This is a known limitation for bridge testing.
  print('RenderFlow requires a FlowDelegate (abstract class)');
  print('Cannot construct RenderFlow without a concrete FlowDelegate subclass');
  print(
    'Limitation: FlowDelegate has abstract methods that must be overridden',
  );

  // ========== RENDER LIST BODY ==========
  print('--- RenderListBody Tests ---');

  final listBody = RenderListBody(axisDirection: AxisDirection.down);
  print('RenderListBody(down) created: ${listBody.runtimeType}');
  print('  axisDirection: ${listBody.axisDirection}');
  print('  mainAxis: ${listBody.mainAxis}');

  final listBodyRight = RenderListBody(axisDirection: AxisDirection.right);
  print('RenderListBody(right) axisDirection: ${listBodyRight.axisDirection}');
  print('  mainAxis: ${listBodyRight.mainAxis}');

  // ========== AXIS DIRECTION HELPERS ==========
  print('--- AxisDirection helpers ---');
  print('AxisDirection.up: ${AxisDirection.up}');
  print('AxisDirection.down: ${AxisDirection.down}');
  print('AxisDirection.left: ${AxisDirection.left}');
  print('AxisDirection.right: ${AxisDirection.right}');
  print(
    'axisDirectionToAxis(down): ${axisDirectionToAxis(AxisDirection.down)}',
  );
  print(
    'axisDirectionToAxis(right): ${axisDirectionToAxis(AxisDirection.right)}',
  );

  // Note: Cannot call layout() or paint() on orphan render objects
  print('Note: render objects not laid out - no parent render tree attached');

  print('RenderObjects layout test completed');
  return Text('RenderObjects layout test passed');
}
