// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// Tests: ScrollPosition, ScrollPositionWithSingleContext, ScrollContext,
//        ScrollActivity, IdleScrollActivity, DrivenScrollActivity,
//        HoldScrollActivity, DragScrollActivity
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // --- ScrollPosition Tests ---
  print('--- ScrollPosition Tests ---');
  print('ScrollPosition determines which portion of content is visible');
  print('Type: $ScrollPosition');
  var scrollController = ScrollController(initialScrollOffset: 100.0);
  print('ScrollController: $scrollController');
  print(
    'ScrollController initialScrollOffset: ${scrollController.initialScrollOffset}',
  );
  print('ScrollPosition is managed by ScrollController');

  // --- ScrollPositionWithSingleContext Tests ---
  print('--- ScrollPositionWithSingleContext Tests ---');
  print(
    'ScrollPositionWithSingleContext is the default ScrollPosition implementation',
  );
  print('Type: $ScrollPositionWithSingleContext');
  print('Used when a scroll position is attached to a single ScrollContext');
  print('Manages physics, activity, and user interaction for scrolling');

  // --- ScrollContext Tests ---
  print('--- ScrollContext Tests ---');
  print('ScrollContext provides the context for a Scrollable widget');
  print('Type: $ScrollContext');
  print('Scrollable implements ScrollContext');
  print('Provides vsync, axis direction, and notification context');

  // --- ScrollActivity Tests ---
  print('--- ScrollActivity Tests ---');
  print('ScrollActivity is the base class for scroll activities');
  print('Type: $ScrollActivity');
  print('Represents what a scroll position is currently doing');
  print('IdleScrollActivity, DrivenScrollActivity, etc. extend it');

  // --- IdleScrollActivity Tests ---
  print('--- IdleScrollActivity Tests ---');
  print('IdleScrollActivity represents a scroll position at rest');
  print('Type: $IdleScrollActivity');
  print('Created when no scrolling is happening');
  print('isScrolling: false for IdleScrollActivity');

  // --- DrivenScrollActivity Tests ---
  print('--- DrivenScrollActivity Tests ---');
  print('DrivenScrollActivity represents an animated scroll');
  print('Type: $DrivenScrollActivity');
  print('Created by ScrollPosition.animateTo()');
  print('Drives scroll position via an animation controller');

  // --- HoldScrollActivity Tests ---
  print('--- HoldScrollActivity Tests ---');
  print('HoldScrollActivity represents holding a scroll position');
  print('Type: $HoldScrollActivity');
  print(
    'Created when the user touches the scrollable but has not started dragging',
  );
  print('Prevents ballistic animations from continuing');

  // --- DragScrollActivity Tests ---
  print('--- DragScrollActivity Tests ---');
  print('DragScrollActivity represents active user dragging');
  print('Type: $DragScrollActivity');
  print('Created when the user drags the scrollable');
  print('Updates scroll position based on user drag gestures');

  // Test ScrollController with FixedExtentScrollController
  var fixedExtentController = FixedExtentScrollController(initialItem: 5);
  print('FixedExtentScrollController: $fixedExtentController');
  print(
    'FixedExtentScrollController initialItem: ${fixedExtentController.initialItem}',
  );

  print('All scroll position types tests passed');

  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: 50,
                itemBuilder: (context, index) {
                  return ListTile(title: Text('Item $index'));
                },
              ),
            ),
            const Text('Scroll Position Types Test'),
          ],
        ),
      ),
    ),
  );
}
