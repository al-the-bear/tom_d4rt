// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PageRouteBuilder from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PageRouteBuilder test executing');
  print('=' * 50);

  // === Test PageRouteBuilder class ===
  print('\nPageRouteBuilder creates custom page routes');

  // Create PageRouteBuilder
  print('\n--- Testing creation ---');
  final route = PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return Container(
        color: Colors.white,
        child: Center(child: Text('Page content')),
      );
    },
  );
  print('Created PageRouteBuilder');
  print('route.runtimeType: ${route.runtimeType}');

  // Test transitionDuration
  print('\n--- Testing transitionDuration ---');
  print('route.transitionDuration: ${route.transitionDuration}');
  print('Default: 300ms');

  // Test reverseTransitionDuration
  print('\n--- Testing reverseTransitionDuration ---');
  print('route.reverseTransitionDuration: ${route.reverseTransitionDuration}');
  print('Default: 300ms');

  // Test opaque
  print('\n--- Testing opaque ---');
  print('route.opaque: ${route.opaque}');
  print('Default: true');

  // Test barrierDismissible
  print('\n--- Testing barrierDismissible ---');
  print('route.barrierDismissible: ${route.barrierDismissible}');
  print('Default: false');

  // Test maintainState
  print('\n--- Testing maintainState ---');
  print('route.maintainState: ${route.maintainState}');
  print('Default: true');

  // Create with custom transition
  print('\n--- Testing custom transition ---');
  final fadeRoute = PageRouteBuilder(
    pageBuilder: (ctx, anim, secAnim) => Text('Fade page'),
    transitionsBuilder: (ctx, anim, secAnim, child) {
      return FadeTransition(opacity: anim, child: child);
    },
    transitionDuration: Duration(milliseconds: 500),
  );
  print('Created with FadeTransition');
  print('transitionDuration: ${fadeRoute.transitionDuration}');

  // Test with Navigator.push
  print('\n--- Testing with Navigator ---');
  print('Navigator.push(context, PageRouteBuilder(...))');
  print('Pushes custom animated route');

  // Test inheritance
  print('\n--- Testing inheritance ---');
  print('route is PageRoute: ${route is PageRoute}');
  print('route is ModalRoute: ${route is ModalRoute}');

  print('\n' + '=' * 50);
  print('PageRouteBuilder test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PageRouteBuilder Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('transitionDuration: ${route.transitionDuration}'),
      Text('opaque: ${route.opaque}'),
      Text('maintainState: ${route.maintainState}'),
    ],
  );
}
