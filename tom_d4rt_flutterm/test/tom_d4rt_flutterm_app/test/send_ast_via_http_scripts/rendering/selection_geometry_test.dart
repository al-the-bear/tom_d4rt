// D4rt test script: Tests SelectionGeometry from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectionGeometry test executing');

  // ========== Basic SelectionGeometry creation ==========
  print('--- Basic SelectionGeometry ---');
  final geometry1 = SelectionGeometry(
    status: SelectionStatus.uncollapsed,
    hasContent: true,
  );
  print('  created: ${geometry1.runtimeType}');
  print('  status: ${geometry1.status}');
  print('  hasContent: ${geometry1.hasContent}');

  // ========== With start and end selection points ==========
  print('--- With selection points ---');
  final startPoint = SelectionPoint(
    localPosition: Offset(10.0, 20.0),
    lineHeight: 16.0,
    handleType: TextSelectionHandleType.left,
  );
  final endPoint = SelectionPoint(
    localPosition: Offset(100.0, 20.0),
    lineHeight: 16.0,
    handleType: TextSelectionHandleType.right,
  );
  final geometryWithPoints = SelectionGeometry(
    status: SelectionStatus.uncollapsed,
    hasContent: true,
    startSelectionPoint: startPoint,
    endSelectionPoint: endPoint,
  );
  print('  startSelectionPoint: ${geometryWithPoints.startSelectionPoint}');
  print('  endSelectionPoint: ${geometryWithPoints.endSelectionPoint}');
  print(
    '  start localPosition: ${geometryWithPoints.startSelectionPoint?.localPosition}',
  );
  print(
    '  end localPosition: ${geometryWithPoints.endSelectionPoint?.localPosition}',
  );

  // ========== SelectionStatus enumeration ==========
  print('--- SelectionStatus values ---');
  for (final status in SelectionStatus.values) {
    print('  ${status.name}: ${status.index}');
  }
  print('  Total status values: ${SelectionStatus.values.length}');

  // ========== Different status values ==========
  print('--- Different status values ---');
  final noneGeometry = SelectionGeometry(
    status: SelectionStatus.none,
    hasContent: false,
  );
  final uncollapsedGeometry = SelectionGeometry(
    status: SelectionStatus.uncollapsed,
    hasContent: true,
  );
  final collapsedGeometry = SelectionGeometry(
    status: SelectionStatus.collapsed,
    hasContent: false,
  );
  print('  none status: ${noneGeometry.status}');
  print('  uncollapsed status: ${uncollapsedGeometry.status}');
  print('  collapsed status: ${collapsedGeometry.status}');

  // ========== hasContent variations ==========
  print('--- hasContent variations ---');
  final withContent = SelectionGeometry(
    status: SelectionStatus.uncollapsed,
    hasContent: true,
  );
  final withoutContent = SelectionGeometry(
    status: SelectionStatus.none,
    hasContent: false,
  );
  print('  withContent.hasContent: ${withContent.hasContent}');
  print('  withoutContent.hasContent: ${withoutContent.hasContent}');

  // ========== SelectionPoint details ==========
  print('--- SelectionPoint details ---');
  final point1 = SelectionPoint(
    localPosition: Offset(50.0, 100.0),
    lineHeight: 20.0,
    handleType: TextSelectionHandleType.collapsed,
  );
  print('  localPosition: ${point1.localPosition}');
  print('  lineHeight: ${point1.lineHeight}');
  print('  handleType: ${point1.handleType}');

  // ========== TextSelectionHandleType enumeration ==========
  print('--- TextSelectionHandleType values ---');
  for (final handleType in TextSelectionHandleType.values) {
    print('  ${handleType.name}: ${handleType.index}');
  }
  print('  Total handle types: ${TextSelectionHandleType.values.length}');

  // ========== Multiple geometries ==========
  print('--- Multiple geometries ---');
  final geometries = [
    SelectionGeometry(status: SelectionStatus.none, hasContent: false),
    SelectionGeometry(status: SelectionStatus.collapsed, hasContent: false),
    SelectionGeometry(status: SelectionStatus.uncollapsed, hasContent: true),
  ];
  print('  Created ${geometries.length} geometries');
  for (var i = 0; i < geometries.length; i++) {
    print(
      '  [$i] status: ${geometries[i].status}, hasContent: ${geometries[i].hasContent}',
    );
  }

  // ========== CopyWith ==========
  print('--- CopyWith ---');
  final original = SelectionGeometry(
    status: SelectionStatus.uncollapsed,
    hasContent: true,
    startSelectionPoint: startPoint,
    endSelectionPoint: endPoint,
  );
  final copied = original.copyWith(status: SelectionStatus.collapsed);
  print('  original.status: ${original.status}');
  print('  copied.status: ${copied.status}');
  print('  original.hasContent: ${original.hasContent}');
  print('  copied.hasContent: ${copied.hasContent}');

  // ========== Equality and HashCode ==========
  print('--- Equality and HashCode ---');
  final geoA = SelectionGeometry(
    status: SelectionStatus.none,
    hasContent: false,
  );
  final geoB = SelectionGeometry(
    status: SelectionStatus.none,
    hasContent: false,
  );
  print('  geoA == geoA: ${geoA == geoA}');
  print('  geoA == geoB: ${geoA == geoB}');
  print('  geoA.hashCode: ${geoA.hashCode}');
  print('  geoB.hashCode: ${geoB.hashCode}');

  // ========== ToString ==========
  print('--- ToString ---');
  print('  geometry1.toString(): ${geometry1.toString()}');

  print('SelectionGeometry test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SelectionGeometry Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Status: ${geometry1.status}'),
          Text('HasContent: ${geometry1.hasContent}'),
          Text('Status values: ${SelectionStatus.values.length}'),
          Text('Handle types: ${TextSelectionHandleType.values.length}'),
          Text('CopyWith works: ${original.status} -> ${copied.status}'),
          Text('Geometries created: ${geometries.length}'),
        ],
      ),
    ),
  );
}
