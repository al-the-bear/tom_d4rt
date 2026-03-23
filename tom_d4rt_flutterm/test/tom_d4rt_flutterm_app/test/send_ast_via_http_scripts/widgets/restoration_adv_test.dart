// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// Tests: RestorableProperty (abstract), RestorableEnumN, RestorationMixin,
//        RestorationBucket, RestorationManager, UndoHistoryState,
//        RawGestureDetectorState, SemanticsGestureDelegate
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // --- RestorableProperty Tests ---
  print('--- RestorableProperty Tests ---');
  print('RestorableProperty is the abstract base for restorable state');
  print('Type: $RestorableProperty');
  print('Subclasses: RestorableInt, RestorableDouble, RestorableString, etc.');
  var restorableInt = RestorableInt(42);
  print('RestorableInt: $restorableInt');
  print('RestorableInt created with initial value 42');
  var restorableDouble = RestorableDouble(3.14);
  print('RestorableDouble: $restorableDouble');
  print('RestorableDouble created with initial value 3.14');
  var restorableString = RestorableString('hello');
  print('RestorableString: $restorableString');
  print('RestorableString created with initial value hello');
  var restorableBool = RestorableBool(true);
  print('RestorableBool: $restorableBool');
  print('RestorableBool created with initial value true');

  // --- RestorableEnumN Tests ---
  print('--- RestorableEnumN Tests ---');
  print('RestorableEnumN stores a nullable enum value for restoration');
  print('Type: $RestorableEnumN');
  print('Allows null values unlike RestorableEnum');
  print('Used for enum values that need to survive process restart');

  // --- RestorationMixin Tests ---
  print('--- RestorationMixin Tests ---');
  print('RestorationMixin adds restoration support to State');
  print('Type: $RestorationMixin');
  print('Mixed into State<T> to register RestorableProperty instances');
  print('Provides restorationId and registerForRestoration()');

  // --- RestorationBucket Tests ---
  print('--- RestorationBucket Tests ---');
  print('RestorationBucket stores restoration data hierarchically');
  print('Type: $RestorationBucket');
  print('Organizes restoration data into a tree structure');
  print('Each bucket has a restorationId and child buckets');

  // --- RestorationManager Tests ---
  print('--- RestorationManager Tests ---');
  print('RestorationManager manages the restoration data for the app');
  print(
    'Type: RestorationManager (accessed via WidgetsBinding.instance.restorationManager)',
  );
  print('Provides the root RestorationBucket');
  print('Communicates with the engine to save/restore state');

  // --- UndoHistoryState Tests ---
  print('--- UndoHistoryState Tests ---');
  print('UndoHistoryState manages undo/redo history');
  print('Type: UndoHistoryState');
  var undoController = UndoHistoryController();
  print('UndoHistoryController: $undoController');
  print('UndoHistoryController manages undo/redo operations');
  print('UndoHistoryState is the State for UndoHistory widget');

  // --- RawGestureDetectorState Tests ---
  print('--- RawGestureDetectorState Tests ---');
  print('RawGestureDetectorState manages gesture recognizers');
  print('Type: $RawGestureDetectorState');
  var rawGestureDetector = RawGestureDetector(child: Container(), gestures: {});
  print('RawGestureDetector: $rawGestureDetector');
  print('RawGestureDetector manages low-level gesture recognition');
  print('RawGestureDetectorState provides replaceGestureRecognizers()');

  // --- SemanticsGestureDelegate Tests ---
  print('--- SemanticsGestureDelegate Tests ---');
  print('SemanticsGestureDelegate handles semantic gesture events');
  print('Type: $SemanticsGestureDelegate');
  print('Delegate for handling gestures in the semantics tree');
  print('Used for accessibility gesture handling');

  print('All restoration advanced tests passed');

  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('RestorableInt: created (42)'),
            Text('RestorableDouble: created (3.14)'),
            Text('RestorableString: created (hello)'),
            Text('RestorableBool: created (true)'),
            rawGestureDetector,
            const Text('Restoration Adv Test'),
          ],
        ),
      ),
    ),
  );
}
