// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RawScrollbarState from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawScrollbarState test executing');
  print('=' * 50);

  // === Test RawScrollbarState ===
  print('\nRawScrollbarState manages scrollbar rendering');

  // Describe the class
  print('\n--- Understanding RawScrollbarState ---');
  print('State<T extends RawScrollbar>');
  print('Mixes in TickerProviderStateMixin<T>');
  print('Provides default scrollbar gestures');

  // Key properties
  print('\n--- Key properties ---');
  print('scrollbarPainter: ScrollbarPainter');
  print('showScrollbar: bool (always visible?)');
  print('enableGestures: bool (interactive?)');

  // ScrollbarPainter
  print('\n--- scrollbarPainter ---');
  print('@protected late final ScrollbarPainter');
  print('Initialized in initState()');
  print('Subclasses customize via updateScrollbarPainter()');

  // Gesture handling
  print('\n--- Gesture handling ---');
  print('Drag scrollbar thumb');
  print('Tap scrollbar track');
  print('replaceGestureRecognizers() for dynamic');

  // Key methods
  print('\n--- replaceGestureRecognizers() ---');
  print('Updates gesture recognizers during layout');
  print('Used by subclasses for scroll direction');

  // Animation
  print('\n--- Fade animation ---');
  print('_fadeoutAnimationController: controls fade');
  print('_fadeoutOpacityAnimation: curved animation');
  print('widget.fadeDuration: animation duration');

  // showScrollbar getter
  print('\n--- showScrollbar getter ---');
  print('Override to depend on theme');
  print('Default: widget.thumbVisibility ?? false');

  // Related classes
  print('\n--- Related classes ---');
  print('RawScrollbar: the widget');
  print('Scrollbar: Material scrollbar');
  print('CupertinoScrollbar: iOS scrollbar');
  print('ScrollbarPainter: paints scrollbar');


  // Customization
  print('\n--- Subclass customization ---');
  print('Override showScrollbar getter');
  print('Override enableGestures getter');
  print('Call updateScrollbarPainter()');

  // Fade behavior
  print('\n--- Fade behavior ---');
  print('Fades in on scroll');
  print('Fades out after timeout');
  print('Always visible if thumbVisibility');

  print('\n' + '=' * 50);
  print('RawScrollbarState test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RawScrollbarState Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: State<RawScrollbar>'),
      Text('Key: scrollbarPainter'),
      Text('Mixin: TickerProviderStateMixin'),
    ],
  );
}
