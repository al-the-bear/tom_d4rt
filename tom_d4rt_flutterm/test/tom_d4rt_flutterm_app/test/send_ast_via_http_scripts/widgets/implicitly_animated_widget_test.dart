// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ImplicitlyAnimatedWidget from widgets
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ImplicitlyAnimatedWidget test executing');
  print('=' * 50);

  // === ImplicitlyAnimatedWidget class tests ===
  // ImplicitlyAnimatedWidget is an abstract StatefulWidget base class
  // for widgets that automatically animate when their properties change.

  // Test 1: Class structure
  print('\nTest 1: Class structure');
  print('abstract class ImplicitlyAnimatedWidget extends StatefulWidget');
  print('Creates ImplicitlyAnimatedWidgetState');

  // Test 2: Constructor parameters
  print('\nTest 2: Constructor parameters');
  print('curve: Curve (default: Curves.linear)');
  print('duration: Duration (required)');
  print('onEnd: VoidCallback? (optional)');

  // Test 3: Common subclasses
  print('\nTest 3: Common subclasses');
  final subclasses = [
    'AnimatedContainer',
    'AnimatedOpacity',
    'AnimatedPadding',
    'AnimatedAlign',
    'AnimatedPositioned',
    'AnimatedDefaultTextStyle',
    'AnimatedPhysicalModel',
    'AnimatedTheme',
  ];
  for (final s in subclasses) {
    print('  - $s');
  }

  // Test 4: Test AnimatedContainer (concrete subclass)
  print('\nTest 4: AnimatedContainer example');
  final container = AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeInOut,
    width: 100,
    height: 100,
    color: Colors.blue,
  );
  print('duration: ${container.duration}');
  print('curve: ${container.curve}');
  print('Type: ${container.runtimeType}');

  // Test 5: Test AnimatedOpacity (concrete subclass)
  print('\nTest 5: AnimatedOpacity example');
  const opacity = AnimatedOpacity(
    duration: Duration(milliseconds: 200),
    opacity: 0.5,
    child: SizedBox.shrink(),
  );
  print('duration: ${opacity.duration}');
  print('opacity: ${opacity.opacity}');
  print('Type: ${opacity.runtimeType}');

  // Test 6: Duration property
  print('\nTest 6: Duration property');
  final durations = [
    const Duration(milliseconds: 100),
    const Duration(milliseconds: 250),
    const Duration(milliseconds: 500),
    const Duration(seconds: 1),
  ];
  for (final d in durations) {
    print('  ${d.inMilliseconds}ms');
  }

  // Test 7: Curve options
  print('\nTest 7: Curve options');
  final curves = [
    ('Curves.linear', Curves.linear),
    ('Curves.easeIn', Curves.easeIn),
    ('Curves.easeOut', Curves.easeOut),
    ('Curves.easeInOut', Curves.easeInOut),
    ('Curves.bounceOut', Curves.bounceOut),
  ];
  for (final (name, curve) in curves) {
    print('  $name: ${curve.runtimeType}');
  }

  // Test 8: onEnd callback
  print('\nTest 8: onEnd callback');
  print('onEnd is called when animation completes');
  print('Useful for chaining animations or side effects');

  // Test 9: debugFillProperties
  print('\nTest 9: debugFillProperties');
  final builder = DiagnosticPropertiesBuilder();
  container.debugFillProperties(builder);
  print('Has duration property: ${builder.properties.any((p) => p.name == "duration")}');

  // Test 10: Type checking
  print('\nTest 10: Type hierarchy');
  print('AnimatedContainer is ImplicitlyAnimatedWidget: ${container is ImplicitlyAnimatedWidget}');
  print('AnimatedContainer is StatefulWidget: ${container is StatefulWidget}');
  print('AnimatedContainer is Widget: ${container is Widget}');

  print('\n' + '=' * 50);
  print('ImplicitlyAnimatedWidget test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ImplicitlyAnimatedWidget Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Tests: 10 categories executed'),
      Text('Type: Abstract StatefulWidget'),
      Text('Props: curve, duration, onEnd'),
      Text('Purpose: Auto-animate property changes'),
    ],
  );
}
