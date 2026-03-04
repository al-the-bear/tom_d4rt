// D4rt test script: Tests FocusScopeNode, FocusNode deep properties,
// FocusHighlightMode, FocusHighlightStrategy from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Focus properties test executing');

  // ========== FOCUSSCOPENODE ==========
  print('--- FocusScopeNode Tests ---');

  // FocusScopeNode defines a focus scope
  final scopeNode = FocusScopeNode();
  print('FocusScopeNode created');
  print('  hasFocus: ${scopeNode.hasFocus}');
  print('  isFirstFocus: ${scopeNode.isFirstFocus}');
  print('  canRequestFocus: ${scopeNode.canRequestFocus}');

  final namedScope = FocusScopeNode(debugLabel: 'myScope');
  print('Named FocusScopeNode: ${namedScope.debugLabel}');

  final skipScope = FocusScopeNode(skipTraversal: true);
  print('Skipped scope: skipTraversal=${skipScope.skipTraversal}');

  // ========== FOCUSHIGHLIGHTMODE ==========
  print('--- FocusHighlightMode Tests ---');

  print('FocusHighlightMode.touch: ${FocusHighlightMode.touch}');
  print('FocusHighlightMode.traditional: ${FocusHighlightMode.traditional}');
  print('FocusHighlightMode.values: ${FocusHighlightMode.values}');

  // ========== FOCUSHIGHLIGHTSTRATEGY ==========
  print('--- FocusHighlightStrategy Tests ---');

  print(
    'FocusHighlightStrategy.automatic: ${FocusHighlightStrategy.automatic}',
  );
  print(
    'FocusHighlightStrategy.alwaysTouch: ${FocusHighlightStrategy.alwaysTouch}',
  );
  print(
    'FocusHighlightStrategy.alwaysTraditional: ${FocusHighlightStrategy.alwaysTraditional}',
  );
  print('FocusHighlightStrategy.values: ${FocusHighlightStrategy.values}');

  // ========== FOCUSNODE ADVANCED ==========
  print('--- FocusNode Advanced Tests ---');

  // FocusNode with various options
  final node1 = FocusNode(debugLabel: 'node1', skipTraversal: true);
  print('FocusNode skipTraversal=true: ${node1.skipTraversal}');

  final node2 = FocusNode(canRequestFocus: false);
  print('FocusNode canRequestFocus=false: ${node2.canRequestFocus}');

  final node3 = FocusNode(descendantsAreFocusable: false);
  print(
    'FocusNode descendantsAreFocusable=false: ${node3.descendantsAreFocusable}',
  );

  final node4 = FocusNode(descendantsAreTraversable: false);
  print(
    'FocusNode descendantsAreTraversable=false: ${node4.descendantsAreTraversable}',
  );

  print('All focus properties tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Focus Properties Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'FocusScopeNode canRequestFocus: ${scopeNode.canRequestFocus}',
            ),
            Text(
              'FocusHighlightMode values: ${FocusHighlightMode.values.length}',
            ),
            Text(
              'FocusHighlightStrategy values: ${FocusHighlightStrategy.values.length}',
            ),
            SizedBox(height: 12.0),
            FocusScope(
              node: FocusScopeNode(debugLabel: 'testScope'),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Scoped field 1'),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    decoration: InputDecoration(labelText: 'Scoped field 2'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
