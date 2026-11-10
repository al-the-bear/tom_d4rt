// ignore_for_file: avoid_print
// D4rt test script: UiKitViewGestureBlockingPolicy (services, Flutter 3.47).
//
// The enum says when an iOS platform view blocks the gestures Flutter
// recognises over it. A UiKitView only renders on iOS, so the script
// configures one for each value without mounting it and lists the values.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String describePolicy(UiKitViewGestureBlockingPolicy policy) {
  switch (policy) {
    case UiKitViewGestureBlockingPolicy.eager:
      return 'blocks as soon as a touch begins';
    case UiKitViewGestureBlockingPolicy.waitUntilTouchesEnded:
      return 'blocks once the touches end';
    case UiKitViewGestureBlockingPolicy.doNotBlockGesture:
      return 'never blocks';
    case UiKitViewGestureBlockingPolicy.fallbackToPluginDefault:
      return 'uses the plugin default';
  }
}

dynamic build(BuildContext context) {
  print('=== UiKitViewGestureBlockingPolicy ===');
  final values = UiKitViewGestureBlockingPolicy.values;
  print('values: ${values.length}');
  final views = <UiKitView>[];
  for (final policy in values) {
    print('  ${policy.index} ${policy.name}: ${describePolicy(policy)}');
    views.add(
      UiKitView(viewType: 'demo/${policy.name}', gestureBlockingPolicy: policy),
    );
  }
  for (final view in views) {
    print('UiKitView ${view.viewType} -> ${view.gestureBlockingPolicy.name}');
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.all(12),
        child: Text(
          'UiKitViewGestureBlockingPolicy',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      for (final policy in values)
        ListTile(
          dense: true,
          title: Text(policy.name),
          subtitle: Text(describePolicy(policy)),
          trailing: Text('#${policy.index}'),
        ),
    ],
  );
}
