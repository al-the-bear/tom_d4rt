// D4rt test script: Tests SelectionHandler from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

dynamic build(BuildContext context) {
  print('SelectionHandler test executing');

  // ========== SelectionHandler is a mixin - test via SelectableRegion ==========
  print('--- SelectionHandler overview ---');
  print('  SelectionHandler is a mixin for handling selection');
  print('  Applied to classes that participate in text selection');
  print('  Key methods: pushHandleLayers, dispatchSelectionEvent');

  // ========== SelectableRegion widget (uses SelectionHandler) ==========
  print('--- SelectableRegion widget ---');
  final focusNode = FocusNode();
  final selectionRegistrar = SelectionContainer.maybeOf(context);
  print('  FocusNode created: ${focusNode.runtimeType}');
  print('  SelectionRegistrar from context: $selectionRegistrar');

  // ========== SelectionRegistrar and SelectionRegistrant ==========
  print('--- Selection registration system ---');
  print('  SelectionRegistrar: manages selection registrants');
  print('  SelectionRegistrant: participates in selection');
  print('  SelectionHandler: handles selection events');

  // ========== Key selection-related types ==========
  print('--- Key selection types ---');
  print('  SelectionResult enum values:');
  for (final result in SelectionResult.values) {
    print('    ${result.name}: ${result.index}');
  }
  print('  Total result values: ${SelectionResult.values.length}');

  // ========== SelectionEvent types that handlers process ==========
  print('--- SelectionEvent types processed by handlers ---');
  final events = <SelectionEvent>[
    SelectAllSelectionEvent(),
    ClearSelectionEvent(),
    SelectionEdgeUpdateEvent.forStart(globalPosition: Offset(10.0, 10.0)),
    SelectionEdgeUpdateEvent.forEnd(globalPosition: Offset(100.0, 100.0)),
    SelectWordSelectionEvent(globalPosition: Offset(50.0, 50.0)),
  ];
  print('  Event types:');
  for (final event in events) {
    print('    ${event.runtimeType}: type=${event.type}');
  }

  // ========== SelectionGeometry for handler state ==========
  print('--- SelectionGeometry states ---');
  final geometries = [
    (SelectionStatus.none, false, 'No selection'),
    (SelectionStatus.collapsed, false, 'Cursor only'),
    (SelectionStatus.uncollapsed, true, 'Has selection'),
  ];
  for (final (status, hasContent, desc) in geometries) {
    final geo = SelectionGeometry(status: status, hasContent: hasContent);
    print('    $desc: status=${geo.status}, hasContent=${geo.hasContent}');
  }

  // ========== LayerLink for selection handles ==========
  print('--- LayerLink for handles ---');
  final startHandleLink = LayerLink();
  final endHandleLink = LayerLink();
  print('  startHandleLink created: ${startHandleLink.runtimeType}');
  print('  endHandleLink created: ${endHandleLink.runtimeType}');
  print('  Links are used for positioning selection handles');

  // ========== Selection points ==========
  print('--- SelectionPoint for handle positions ---');
  final startPoint = SelectionPoint(
    localPosition: Offset(0.0, 0.0),
    lineHeight: 16.0,
    handleType: TextSelectionHandleType.left,
  );
  final endPoint = SelectionPoint(
    localPosition: Offset(100.0, 0.0),
    lineHeight: 16.0,
    handleType: TextSelectionHandleType.right,
  );
  final collapsedPoint = SelectionPoint(
    localPosition: Offset(50.0, 0.0),
    lineHeight: 16.0,
    handleType: TextSelectionHandleType.collapsed,
  );
  print('  Start point: ${startPoint.localPosition}, handle: ${startPoint.handleType}');
  print('  End point: ${endPoint.localPosition}, handle: ${endPoint.handleType}');
  print('  Collapsed point: ${collapsedPoint.localPosition}, handle: ${collapsedPoint.handleType}');

  // ========== TextSelectionHandleType ==========
  print('--- TextSelectionHandleType values ---');
  for (final handleType in TextSelectionHandleType.values) {
    print('    ${handleType.name}: ${handleType.index}');
  }

  // ========== SelectedContent from handlers ==========
  print('--- SelectedContent from handlers ---');
  final content = SelectedContent(plainText: 'Selected text from handler');
  print('  plainText: ${content.plainText}');
  print('  length: ${content.plainText.length}');

  // ========== Selection area and container ==========
  print('--- SelectionContainer overview ---');
  print('  SelectionContainer provides SelectionRegistrar');
  print('  Child widgets register to participate in selection');
  print('  SelectionHandler coordinates selection state');

  // ========== FocusNode for selection ==========
  print('--- FocusNode management ---');
  print('  focusNode.hasFocus: ${focusNode.hasFocus}');
  print('  focusNode.hasPrimaryFocus: ${focusNode.hasPrimaryFocus}');
  print('  focusNode.canRequestFocus: ${focusNode.canRequestFocus}');

  // ========== Cleanup ==========
  focusNode.dispose();
  print('  FocusNode disposed');

  print('SelectionHandler test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('SelectionHandler Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('SelectionHandler is a mixin'),
          Text('SelectionResult values: ${SelectionResult.values.length}'),
          Text('Event types tested: ${events.length}'),
          Text('Handle types: ${TextSelectionHandleType.values.length}'),
          Text('Start point handle: ${startPoint.handleType}'),
          Text('End point handle: ${endPoint.handleType}'),
          Text('Collapsed handle: ${collapsedPoint.handleType}'),
          Text('SelectedContent: ${content.plainText}'),
        ],
      ),
    ),
  );
}
