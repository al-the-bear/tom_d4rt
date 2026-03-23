// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ExpensiveAndroidViewController from services
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ExpensiveAndroidViewController test executing');
  print('=' * 50);

  // ExpensiveAndroidViewController - Virtual Display mode
  print('\nExpensiveAndroidViewController:');
  print('Android view controller using Virtual Display');
  print('Higher fidelity but more resource intensive');

  // Extends AndroidViewController
  print('\nExtends AndroidViewController:');
  print('Specialized for Virtual Display mode');
  print('"Expensive" refers to resource cost');

  // Virtual Display mode
  print('\nVirtual Display mode:');
  print('- Creates virtual screen for native view');
  print('- Full Android View capabilities');
  print('- Correct touch/gesture handling');
  print('- Higher memory usage');
  print('- More GPU resources');

  // vs Texture Layer mode
  print('\nVirtual Display vs Texture Layer:');
  print('');
  print('Virtual Display (this):');
  print('  - Full view functionality');
  print('  - Correct compositor behavior');
  print('  - Higher resource usage');
  print('');
  print('Texture Layer:');
  print('  - Lower resource usage');
  print('  - Some view features limited');
  print('  - Better performance');

  // When to use
  print('\nWhen to use:');
  print('- WebView with complex interactions');
  print('- Views requiring animations');
  print('- When texture mode has issues');
  print('- Full Android View functionality');

  // Lifecycle
  print('\nLifecycle:');
  print('create(): Initialize virtual display');
  print('setSize(): Resize virtual display');
  print('dispatchPointerEvent(): Forward touches');
  print('dispose(): Release resources');

  // Performance considerations
  print('\nPerformance considerations:');
  print('- More texture memory');
  print('- Additional composition step');
  print('- Background rendering overhead');
  print('- Use sparingly');

  // Type hierarchy
  print('\nType hierarchy:');
  print('PlatformViewController');
  print('  \u2514\u2500 AndroidViewController');
  print('      \u2514\u2500 ExpensiveAndroidViewController');

  // Explain purpose
  print('\nExpensiveAndroidViewController purpose:');
  print('- Virtual Display based embedding');
  print('- Full Android View functionality');
  print('- Higher fidelity rendering');
  print('- Use when texture mode insufficient');
  print('- Resource-intensive option');

  print('\n' + '=' * 50);
  print('ExpensiveAndroidViewController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ExpensiveAndroidViewController Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Extends: AndroidViewController'),
      Text('Mode: Virtual Display'),
      Text('Resources: Higher usage'),
      Text('Purpose: Full view functionality'),
    ],
  );
}
