// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextSelectionGestureDetectorBuilder from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextSelectionGestureDetectorBuilder test executing');
  print('=' * 50);

  // Overview
  print('TextSelectionGestureDetectorBuilder overview:');
  print('  - Builds TextSelectionGestureDetector for EditableText');
  print('  - Handles common text selection gestures');
  print('  - Subclassable for custom behavior');
  print('  - Works with TextSelectionGestureDetectorBuilderDelegate');

  // Constructor
  print('\nConstructor:');
  print('  TextSelectionGestureDetectorBuilder({required delegate})');
  print('  - delegate: TextSelectionGestureDetectorBuilderDelegate');

  // Key properties
  print('\nKey properties:');
  print('  - delegate: The builder\'s delegate');
  print('  - editableText: EditableTextState from delegate');
  print('  - renderEditable: RenderEditable from EditableText');
  print('  - shouldShowSelectionToolbar: bool');

  // Gesture handlers (overridable)
  print('\nGesture handlers (overridable):');
  print('  - onTapDown(TapDragDownDetails)');
  print('  - onTapUp(TapDragUpDetails)');
  print('  - onForcePressStart(ForcePressDetails)');
  print('  - onForcePressEnd(ForcePressDetails)');
  print('  - onSingleTapUp(TapDragUpDetails)');
  print('  - onSingleTapCancel()');
  print('  - onSingleLongTapStart(LongPressStartDetails)');
  print('  - onSingleLongTapMoveUpdate(LongPressMoveUpdateDetails)');
  print('  - onSingleLongTapEnd(LongPressEndDetails)');
  print('  - onDoubleTapDown(TapDragDownDetails)');
  print('  - onDragSelectionStart(DragStartDetails)');
  print('  - onDragSelectionUpdate(DragStartDetails, DragUpdateDetails)');
  print('  - onDragSelectionEnd(DragEndDetails)');

  // Build method
  print('\nbuildGestureDetector method:');
  print('  Widget buildGestureDetector({');
  print('    Key? key,');
  print('    HitTestBehavior? behavior,');
  print('    required Widget child,');
  print('  })');
  print('  - Returns TextSelectionGestureDetector with configured callbacks');

  // Platform-specific behavior
  print('\nPlatform-specific behavior:');
  print('  - iOS: Force press handling');
  print('  - Android: Long press selection');
  print('  - Desktop: Click and drag selection');

  // Subclassing pattern
  print('\nSubclassing pattern:');
  print('  - Material TextField customizes in _TextFieldSelectionGestureDetectorBuilder');
  print('  - Override handlers to change behavior');
  print('  - Call super.method() for default behavior');

  // Consecutive tap handling
  print('\nConsecutive tap handling:');
  print('  - Double tap: select word');
  print('  - Triple tap: select paragraph/line');
  print('  - Platform-specific behavior');

  print('\n' + '=' * 50);
  print('TextSelectionGestureDetectorBuilder test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TextSelectionGestureDetectorBuilder Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Concrete class'),
      Text('Method: buildGestureDetector'),
      Text('Pattern: Subclassable gesture handling'),
    ],
  );
}
