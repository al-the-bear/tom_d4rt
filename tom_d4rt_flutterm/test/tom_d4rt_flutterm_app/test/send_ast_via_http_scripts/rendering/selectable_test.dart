// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Selectable from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Selectable test executing');
  print('=' * 50);

  // Selectable is a mixin that implements SelectionHandler
  print('\nSelectable:');
  print('Type: mixin');
  print('Implements: SelectionHandler');
  print('Purpose: Adds selection capability to a render object');
  print('Cannot be instantiated directly');

  // Key methods from Selectable
  print('\nSelectable mixin members:');
  print('  getTransformTo(RenderObject? ancestor) -> Matrix4');
  print('  size -> Size');
  print('  boundingBoxes -> List<Rect>');
  print('  dispose()');

  // Inherited from SelectionHandler
  print('\nInherited from SelectionHandler:');
  print('  pushHandleLayers(LayerLink? start, LayerLink? end)');
  print('  getSelectedContent() -> SelectedContent?');
  print('  getSelection() -> SelectedContentRange?');
  print('  dispatchSelectionEvent(SelectionEvent) -> SelectionResult');
  print('  contentLength -> int');

  // SelectionHandler is a ValueListenable<SelectionGeometry>
  print('\nSelectionHandler extends ValueListenable<SelectionGeometry>:');
  print('  value -> SelectionGeometry');
  print('  addListener(VoidCallback)');
  print('  removeListener(VoidCallback)');

  // Usage pattern
  print('\nUsage pattern:');
  print('  class MySelectableRenderObject extends RenderBox');
  print('    with Selectable {');
  print('    // implement required members');
  print('  }');

  // Relationship to SelectionRegistrant
  print('\nRelated: SelectionRegistrant mixin');
  print('  SelectionRegistrant requires Selectable (mixin on Selectable)');
  print('  Auto-registers with a SelectionRegistrar');

  // Selection flow
  print('\nSelection flow:');
  print('  1. SelectionRegistrar adds Selectable');
  print('  2. SelectionEvent dispatched to Selectable');
  print('  3. Selectable updates its SelectionGeometry');
  print('  4. Listeners notified of changes');
  print('  5. getSelectedContent() returns selected text');

  // Concrete implementations
  print('\nConcrete implementations in Flutter:');
  print('  RenderParagraph uses Selectable for text selection');
  print('  Custom render objects can mix in Selectable');
  print('  SelectableText widget provides widget-level API');

  // boundingBoxes
  print('\nboundingBoxes:');
  print('  Returns List<Rect> of all selectable regions');
  print('  Used for hit testing and selection overlay positioning');

  print('\n==================================================');
  print('Selectable test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Selectable Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Mixin'),
      Text('Implements: SelectionHandler'),
      Text('Members: getTransformTo, size, boundingBoxes'),
      Text('Purpose: Add selection to render objects'),
    ],
  );
}
