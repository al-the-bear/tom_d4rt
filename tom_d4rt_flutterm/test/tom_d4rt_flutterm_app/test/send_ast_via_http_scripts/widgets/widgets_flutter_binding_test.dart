// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests WidgetsFlutterBinding from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('WidgetsFlutterBinding test executing');
  print('=' * 50);

  // WidgetsFlutterBinding is the concrete binding
  print('WidgetsFlutterBinding overview:');
  print('  - Concrete class extending BindingBase');
  print('  - Includes all widget-related mixins');
  print('  - Created automatically by runApp()');

  // Mixin hierarchy
  print('\nMixin hierarchy:');
  print('  class WidgetsFlutterBinding extends BindingBase with');
  print('    GestureBinding,');
  print('    SchedulerBinding,');
  print('    ServicesBinding,');
  print('    PaintingBinding,');
  print('    SemanticsBinding,');
  print('    RendererBinding,');
  print('    WidgetsBinding { }');

  // ensureInitialized
  print('\nensureInitialized():');
  print('  static WidgetsBinding ensureInitialized()');
  print('  - Returns existing or creates new binding');
  print('  - Called automatically by runApp');
  print('  - Call manually before using binding APIs');

  // Access
  print('\nAccessing the binding:');
  final binding = WidgetsFlutterBinding.ensureInitialized();
  print('  binding: $binding');
  print('  runtimeType: ${binding.runtimeType}');

  // Same instance
  print('\nSingleton behavior:');
  final binding2 = WidgetsFlutterBinding.ensureInitialized();
  print('  Same instance: ${identical(binding, binding2)}');

  // Via WidgetsBinding.instance
  print('\nAlso accessible via:');
  print('  WidgetsBinding.instance');
  print('  Same: ${identical(binding, WidgetsBinding.instance)}');

  // Common pre-runApp uses
  print('\nCommon pre-runApp uses:');
  print('  void main() async {');
  print('    WidgetsFlutterBinding.ensureInitialized();');
  print('    await Firebase.initializeApp();');
  print('    await Hive.initFlutter();');
  print('    runApp(MyApp());');
  print('  }');

  // Window/view access
  print('\nView access:');
  print('  renderViews: ${binding.renderViews.length} view(s)');
  print('  platformDispatcher.views available');

  // Service extensions (debug mode)
  print('\nService extensions (debug):');
  print('  - debugDumpApp');
  print('  - debugDumpRenderTree');
  print('  - debugDumpLayerTree');
  print('  - showPerformanceOverlay');

  print('\n' + '=' * 50);
  print('WidgetsFlutterBinding test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'WidgetsFlutterBinding Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: concrete BindingBase'),
      Text('Pattern: ensureInitialized()'),
      Text('Contains: all widget bindings'),
    ],
  );
}
