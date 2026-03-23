// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests InkWell widget from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('InkWell test executing');

  // Test basic InkWell with child
  final basicInkWell = InkWell(
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: Text('Basic InkWell'),
    ),
    onTap: () {
      print('Basic InkWell tapped');
    },
  );
  print('Basic InkWell with onTap created');

  // Test InkWell with onTap, onDoubleTap, onLongPress
  final multipleCallbacks = InkWell(
    child: Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.blue.shade100,
      child: Text('Multiple Callbacks'),
    ),
    onTap: () => print('onTap'),
    onDoubleTap: () => print('onDoubleTap'),
    onLongPress: () => print('onLongPress'),
  );
  print('InkWell with multiple callbacks created');

  // Test InkWell with custom splash and highlight colors
  final customColors = InkWell(
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: Text('Custom Colors'),
    ),
    splashColor: Colors.red.withOpacity(0.5),
    highlightColor: Colors.orange.withOpacity(0.3),
    onTap: () {},
  );
  print('InkWell with custom splashColor and highlightColor created');

  // Test InkWell with focusColor and hoverColor
  final focusHover = InkWell(
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: Text('Focus/Hover Colors'),
    ),
    focusColor: Colors.green.withOpacity(0.3),
    hoverColor: Colors.purple.withOpacity(0.2),
    onTap: () {},
  );
  print('InkWell with focusColor and hoverColor created');

  // Test InkWell with borderRadius
  final withBorderRadius = InkWell(
    borderRadius: BorderRadius.circular(20.0),
    child: Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text('Rounded InkWell'),
    ),
    onTap: () {},
  );
  print('InkWell with borderRadius=20.0 created');

  // Test InkWell with customBorder
  final withCustomBorder = InkWell(
    customBorder: StadiumBorder(),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: ShapeDecoration(
        color: Colors.teal.shade100,
        shape: StadiumBorder(),
      ),
      child: Text('Stadium Border'),
    ),
    onTap: () {},
  );
  print('InkWell with StadiumBorder created');

  // Test InkWell with splashFactory
  final noSplash = InkWell(
    splashFactory: NoSplash.splashFactory,
    child: Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.amber.shade100,
      child: Text('No Splash'),
    ),
    onTap: () {},
  );
  print('InkWell with NoSplash.splashFactory created');

  // Test InkWell with enabled/disabled
  final enabledWell = InkWell(
    child: Container(padding: EdgeInsets.all(16.0), child: Text('Enabled')),
    onTap: () => print('Enabled tapped'),
  );
  print('InkWell enabled (onTap provided) created');

  final disabledWell = InkWell(
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: Text('Disabled (no onTap)'),
    ),
    // no onTap = disabled
  );
  print('InkWell disabled (no onTap) created');

  // Test InkWell with onTapDown and onTapUp
  final tapDownUp = InkWell(
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: Text('TapDown/TapUp'),
    ),
    onTapDown: (details) => print('TapDown at ${details.localPosition}'),
    onTapUp: (details) => print('TapUp at ${details.localPosition}'),
    onTap: () => print('Tap complete'),
  );
  print('InkWell with onTapDown and onTapUp created');

  // Test InkWell with onTapCancel
  final tapCancel = InkWell(
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: Text('With TapCancel'),
    ),
    onTap: () {},
    onTapCancel: () => print('Tap cancelled'),
  );
  print('InkWell with onTapCancel created');

  // Test InkWell with canRequestFocus
  final withFocus = InkWell(
    canRequestFocus: true,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: Text('Can Request Focus'),
    ),
    onTap: () {},
  );
  print('InkWell with canRequestFocus=true created');

  // Test InkWell with autofocus
  final autoFocus = InkWell(
    autofocus: true,
    child: Container(padding: EdgeInsets.all(16.0), child: Text('Autofocus')),
    onTap: () {},
  );
  print('InkWell with autofocus=true created');

  // Test InkWell with excludeFromSemantics
  final excludeSemantics = InkWell(
    excludeFromSemantics: true,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: Text('Excluded from Semantics'),
    ),
    onTap: () {},
  );
  print('InkWell with excludeFromSemantics=true created');

  print('InkWell test completed');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        basicInkWell,
        SizedBox(height: 8.0),
        multipleCallbacks,
        SizedBox(height: 8.0),
        customColors,
        SizedBox(height: 8.0),
        focusHover,
        SizedBox(height: 8.0),
        withBorderRadius,
        SizedBox(height: 8.0),
        withCustomBorder,
        SizedBox(height: 8.0),
        noSplash,
        SizedBox(height: 8.0),
        enabledWell,
        SizedBox(height: 8.0),
        disabledWell,
        SizedBox(height: 8.0),
        tapDownUp,
        SizedBox(height: 8.0),
        tapCancel,
        SizedBox(height: 8.0),
        withFocus,
        SizedBox(height: 8.0),
        autoFocus,
        SizedBox(height: 8.0),
        excludeSemantics,
      ],
    ),
  );
}
