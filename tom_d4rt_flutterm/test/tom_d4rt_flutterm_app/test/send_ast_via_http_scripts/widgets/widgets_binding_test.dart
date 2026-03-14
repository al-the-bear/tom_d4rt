// D4rt test script: Tests WidgetsBinding from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WidgetsBinding test executing');

  // WidgetsBinding - Main binding for Flutter widget layer
  // Connects widgets framework to lower-level engine
  
  // Access the singleton instance
  final binding = WidgetsBinding.instance;
  print('WidgetsBinding.instance: $binding');
  print('runtimeType: ${binding.runtimeType}');
  
  // Key properties
  print('\nKey properties:');
  print('- buildOwner: Manages widget building');
  print('- focusManager: Manages focus state');
  print('- renderViewElement: Root element');
  print('- observers: WidgetsBindingObservers');
  
  // Binding hierarchy
  print('\nBinding hierarchy:');
  print('WidgetsBinding mixes:');
  print('- GestureBinding: Touch/gesture handling');
  print('- SchedulerBinding: Frame scheduling');
  print('- ServicesBinding: Platform channels');
  print('- PaintingBinding: Image decoding');
  print('- SemanticsBinding: Accessibility');
  print('- RendererBinding: Rendering');
  
  // Key methods
  print('\nKey methods:');
  print('- ensureInitialized(): Initialize binding');
  print('- attachRootWidget(Widget): Start app');
  print('- addObserver(WidgetsBindingObserver)');
  print('- removeObserver(WidgetsBindingObserver)');
  
  // Type hierarchy
  print('\nType hierarchy:');
  print('WidgetsBinding is a mixin on BindingBase');
  print('WidgetsFlutterBinding combines all bindings');
  print('runApp() creates WidgetsFlutterBinding');
  
  // Use cases
  print('\nUse cases:');
  print('- Access focusManager');
  print('- Add lifecycle observers');
  print('- Custom app bootstrapping');
  print('- Test binding setup');

  print('\nWidgetsBinding test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WidgetsBinding Tests'),
      Text('Main binding for widget layer'),
      Text('Combines Scheduler, Renderer, etc.'),
      Text('Access via WidgetsBinding.instance'),
    ],
  );
}
