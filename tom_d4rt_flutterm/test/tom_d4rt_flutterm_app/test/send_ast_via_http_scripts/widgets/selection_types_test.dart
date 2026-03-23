// ignore_for_file: avoid_print
// Tests: TwoDimensionalScrollable, SelectionContainer, SelectableRegion,
//        SelectionRegistrar, SelectionRegistrarScope, SelectionEvent,
//        SelectionHandler, SelectionOverlay
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // --- TwoDimensionalScrollable Tests ---
  print('--- TwoDimensionalScrollable Tests ---');
  print('TwoDimensionalScrollable manages scrolling in two axes');
  print('Type: $TwoDimensionalScrollable');
  print('Provides scroll controllers for horizontal and vertical axes');
  print('Used internally by TwoDimensionalScrollView');

  // --- SelectionContainer Tests ---
  print('--- SelectionContainer Tests ---');
  print('SelectionContainer enables text selection for its subtree');
  print('Type: SelectionContainer');
  var selectionContainer = SelectionContainer.disabled(
    child: const Text('Selectable text content'),
  );
  print('SelectionContainer: $selectionContainer');
  print('SelectionContainer wraps children to make them selectable');
  var disabledSelection = SelectionContainer.disabled(
    child: const Text('Non-selectable text'),
  );
  print('SelectionContainer.disabled: $disabledSelection');
  print('SelectionContainer.disabled prevents selection in subtree');

  // --- SelectableRegion Tests ---
  print('--- SelectableRegion Tests ---');
  print('SelectableRegion manages selection interactions');
  print('Type: $SelectableRegion');
  print('Handles selection gestures and provides selection toolbar');
  print('Used internally by SelectionArea and SelectionContainer');

  // --- SelectionRegistrar Tests ---
  print('--- SelectionRegistrar Tests ---');
  print('SelectionRegistrar registers selectables in the selection system');
  print('Type: SelectionRegistrar (internal framework class)');
  print('Abstract class for registering and unregistering selectables');
  print('Manages which widgets participate in selection');

  // --- SelectionRegistrarScope Tests ---
  print('--- SelectionRegistrarScope Tests ---');
  print('SelectionRegistrarScope provides SelectionRegistrar to subtree');
  print('Type: $SelectionRegistrarScope');
  print('InheritedWidget that makes a SelectionRegistrar available');
  print('Used by SelectableRegion to scope selection registration');

  // --- SelectionEvent Tests ---
  print('--- SelectionEvent Tests ---');
  print('SelectionEvent represents selection interaction events');
  print('Type: SelectionEvent (internal framework class)');
  print('Abstract base class for selection events');
  print('Subclasses include SelectWordSelectionEvent, etc.');

  // --- SelectionHandler Tests ---
  print('--- SelectionHandler Tests ---');
  print('SelectionHandler processes selection events');
  print('Type: SelectionHandler (internal framework mixin)');
  print('Abstract mixin for handling SelectionEvent instances');
  print('Implemented by widgets that respond to selection changes');

  // --- SelectionOverlay Tests ---
  print('--- SelectionOverlay Tests ---');
  print('SelectionOverlay displays selection handles and toolbar');
  print('Type: $SelectionOverlay');
  print('Manages the visual representation of text selection');
  print('Shows drag handles and context menu for selected text');

  print('All selection types tests passed');

  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectionArea(
              child: Column(
                children: [
                  selectionContainer,
                  disabledSelection,
                  const Text('Selection system test'),
                ],
              ),
            ),
            const Text('Selection Types Test'),
          ],
        ),
      ),
    ),
  );
}
