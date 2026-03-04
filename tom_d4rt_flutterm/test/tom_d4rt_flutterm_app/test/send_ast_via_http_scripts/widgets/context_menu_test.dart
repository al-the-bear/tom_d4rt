// D4rt test script: Tests ContextMenuButtonItem, ContextMenuButtonType,
// AdaptiveTextSelectionToolbar
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ContextMenu test executing');

  // ========== ContextMenuButtonType ==========
  print('--- ContextMenuButtonType Tests ---');
  for (final type in ContextMenuButtonType.values) {
    print('ContextMenuButtonType: ${type.name}');
  }

  // ========== ContextMenuButtonItem ==========
  print('--- ContextMenuButtonItem Tests ---');
  final copyItem = ContextMenuButtonItem(
    onPressed: () => print('Copy pressed'),
    type: ContextMenuButtonType.copy,
  );
  print('ContextMenuButtonItem copy created');
  print('  type: ${copyItem.type}');

  final pasteItem = ContextMenuButtonItem(
    onPressed: () => print('Paste pressed'),
    type: ContextMenuButtonType.paste,
  );
  print('ContextMenuButtonItem paste created');

  final cutItem = ContextMenuButtonItem(
    onPressed: () => print('Cut pressed'),
    type: ContextMenuButtonType.cut,
  );
  print('ContextMenuButtonItem cut created');

  final selectAllItem = ContextMenuButtonItem(
    onPressed: () => print('SelectAll pressed'),
    type: ContextMenuButtonType.selectAll,
  );
  print('ContextMenuButtonItem selectAll created');

  final customItem = ContextMenuButtonItem(
    onPressed: () => print('Custom pressed'),
    type: ContextMenuButtonType.custom,
    label: 'Custom Action',
  );
  print('ContextMenuButtonItem custom: ${customItem.label}');

  // ========== AdaptiveTextSelectionToolbar ==========
  print('--- AdaptiveTextSelectionToolbar Tests ---');
  // AdaptiveTextSelectionToolbar.buttonItems
  final toolbar = AdaptiveTextSelectionToolbar.buttonItems(
    anchors: TextSelectionToolbarAnchors(
      primaryAnchor: Offset(100.0, 100.0),
    ),
    buttonItems: [copyItem, pasteItem, cutItem, selectAllItem],
  );
  print('AdaptiveTextSelectionToolbar created with 4 items');

  // TextSelectionToolbarAnchors
  final anchors = TextSelectionToolbarAnchors(
    primaryAnchor: Offset(50.0, 50.0),
    secondaryAnchor: Offset(200.0, 200.0),
  );
  print('TextSelectionToolbarAnchors created');
  print('  primary: ${anchors.primaryAnchor}');
  print('  secondary: ${anchors.secondaryAnchor}');

  print('All context menu tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ContextMenu Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('ContextMenuButtonType: ${ContextMenuButtonType.values.length} types'),
            Text('Created items: copy, paste, cut, selectAll, custom'),
            Text('AdaptiveTextSelectionToolbar created'),
          ],
        ),
      ),
    ),
  );
}
