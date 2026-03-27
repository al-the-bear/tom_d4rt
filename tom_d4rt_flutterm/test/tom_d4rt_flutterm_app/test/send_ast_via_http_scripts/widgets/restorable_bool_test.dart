// Generated print-only test for RestorableBool
// ignore_for_file: avoid_print, unused_local_variable
import 'package:flutter/widgets.dart';

/// Print-only test for RestorableBool
/// This test prints class structure and API information.
class RestorableBoolTest {
  dynamic build(BuildContext context) {
  print('=' * 50);
  print('RestorableBool PRINT-ONLY TEST');
  print('=' * 50);

  // Class definition
  print('\n--- RestorableBool class ---');
  print('class RestorableBool');
  print('  extends _RestorablePrimitiveValue<bool>');
  print('Purpose: Restorable non-nullable boolean');

  // Constructor
  print('\n--- Constructor ---');
  print('RestorableBool(bool defaultValue)');
  print('Requires non-null default');

  // Properties
  print('\n--- Properties (inherited) ---');
  print('value: bool (get/set)');
  print('enabled: bool - restoration active');

  // Test instance
  print('\n--- Test RestorableBool ---');
  final restorableBool = RestorableBool(false);
  print('RestorableBool(false)');
  print('Initial value: ${restorableBool.value}');
  
  restorableBool.value = true;
  print('After setting true: ${restorableBool.value}');
  
  restorableBool.value = false;
  print('After setting false: ${restorableBool.value}');

  // State restoration usage
  print('\n--- In StatefulWidget ---');
  print('class _MyState extends State<MyWidget>');
  print('    with RestorationMixin {');
  print('  final _isEnabled = RestorableBool(false);');
  print('');
  print('  @override');
  print('  String get restorationId => "my_widget";');
  print('');
  print('  @override');
  print('  void restoreState(bucket, init) {');
  print('    registerForRestoration(_isEnabled, "enabled");');
  print('  }');
  print('}');

  // Listenable
  print('\n--- Listenable behavior ---');
  print('Notifies listeners on value change');
  print('Use with ListenableBuilder');
  print('Or addListener/removeListener');

  // Serialization
  print('\n--- Serialization ---');
  print('Stored as primitive bool');
  print('Automatic encode/decode');

  // Related classes
  print('\n--- Related classes ---');
  print('RestorableBoolN: nullable version');
  print('RestorableInt, RestorableDouble');
  print('RestorableString, RestorableEnum');

  // Cleanup
  print('\n--- Cleanup ---');
  restorableBool.dispose();
  print('dispose() called');

  print('\n' + '=' * 50);
  print('END RestorableBool PRINT-ONLY TEST');
  print('=' * 50);
  return const SizedBox.shrink();
  }
}
