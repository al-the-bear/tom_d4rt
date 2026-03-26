// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SemanticsUpdate from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

dynamic build(BuildContext context) {
  print('SemanticsUpdate test executing');
  print('=' * 50);

  // SemanticsUpdate overview
  print('\nSemanticsUpdate overview:');
  print('Purpose: Opaque batch of semantics tree updates from dart:ui');
  print('Created by: SemanticsUpdateBuilder');
  print('Key API: dispose()');
  print('Used internally by the framework to send semantics data');

  // Create a SemanticsUpdateBuilder
  final builder = ui.SemanticsUpdateBuilder();
  print('\nSemanticsUpdateBuilder created');
  print('runtimeType: ${builder.runtimeType}');
  print('is SemanticsUpdateBuilder: ${builder is ui.SemanticsUpdateBuilder}');

  // Build an update without nodes
  try {
    final update = builder.build();
    print('\nSemanticsUpdate built (no nodes)');
    print('runtimeType: ${update.runtimeType}');
    print('is SemanticsUpdate: ${update is ui.SemanticsUpdate}');
    update.dispose();
    print('Disposed successfully');
  } catch (e) {
    print('Build without nodes: $e');
  }

  // SemanticsNode - closely related
  print('\n--- Related: SemanticsNode ---');
  final node = SemanticsNode();
  print('Created SemanticsNode');
  print('id: ${node.id}');
  print('depth: ${node.depth}');
  print('rect: ${node.rect}');
  print('isInvisible: ${node.isInvisible}');
  print('isMergedIntoParent: ${node.isMergedIntoParent}');
  print('isPartOfNodeMerging: ${node.isPartOfNodeMerging}');
  print('hasChildren: ${node.hasChildren}');
  print('childrenCount: ${node.childrenCount}');
  print('runtimeType: ${node.runtimeType}');

  // SemanticsNode with rect
  final node2 = SemanticsNode();
  node2.rect = ui.Rect.fromLTWH(10, 20, 200, 100);
  print('\nSemanticsNode with rect:');
  print('rect: ${node2.rect}');
  print('isInvisible: ${node2.isInvisible}');

  // SemanticsConfiguration
  print('\n--- Related: SemanticsConfiguration ---');
  final config = SemanticsConfiguration();
  print('isSemanticBoundary: ${config.isSemanticBoundary}');
  print('isMergingSemanticsOfDescendants: ${config.isMergingSemanticsOfDescendants}');
  config.isSemanticBoundary = true;
  print('After setting isSemanticBoundary: ${config.isSemanticBoundary}');

  // SemanticsProperties
  print('\n--- Related: SemanticsProperties ---');
  final props = SemanticsProperties(label: 'Test', enabled: true, checked: false);
  print('label: ${props.label}');
  print('enabled: ${props.enabled}');
  print('checked: ${props.checked}');
  print('runtimeType: ${props.runtimeType}');

  // SemanticsAction constants
  print('\n--- SemanticsAction flags ---');
  print('tap: ${ui.SemanticsAction.tap}');
  print('longPress: ${ui.SemanticsAction.longPress}');
  print('scrollLeft: ${ui.SemanticsAction.scrollLeft}');
  print('scrollRight: ${ui.SemanticsAction.scrollRight}');
  print('scrollUp: ${ui.SemanticsAction.scrollUp}');
  print('scrollDown: ${ui.SemanticsAction.scrollDown}');
  print('increase: ${ui.SemanticsAction.increase}');
  print('decrease: ${ui.SemanticsAction.decrease}');

  print('\n' + '=' * 50);
  print('SemanticsUpdate test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SemanticsUpdate Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('SemanticsUpdateBuilder: created'),
      Text('SemanticsUpdate: built & disposed'),
      Text('SemanticsNode id: ${node.id}'),
      Text('SemanticsConfiguration: boundary=${config.isSemanticBoundary}'),
      Text('SemanticsProperties: label=${props.label}'),
      Text('SemanticsAction: tap, longPress, scroll...'),
    ],
  );
}
