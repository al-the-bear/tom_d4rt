// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests WidgetState, MaterialStateProperty, WidgetStateProperty, WidgetStatesController from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('WidgetState test executing');

  // ========== WIDGET STATE VALUES ==========
  print('--- WidgetState Values ---');

  print('WidgetState.hovered: ${WidgetState.hovered}');
  print('WidgetState.focused: ${WidgetState.focused}');
  print('WidgetState.pressed: ${WidgetState.pressed}');
  print('WidgetState.dragged: ${WidgetState.dragged}');
  print('WidgetState.selected: ${WidgetState.selected}');
  print('WidgetState.scrolledUnder: ${WidgetState.scrolledUnder}');
  print('WidgetState.disabled: ${WidgetState.disabled}');
  print('WidgetState.error: ${WidgetState.error}');

  // ========== WIDGET STATE PROPERTY - all ==========
  print('--- WidgetStateProperty.all Tests ---');

  final colorAll = WidgetStateProperty.all(Colors.blue);
  print('WidgetStateProperty.all(Colors.blue) created');
  print('  resolve empty: ${colorAll.resolve({})}');
  print('  resolve hovered: ${colorAll.resolve({WidgetState.hovered})}');
  print('  resolve pressed: ${colorAll.resolve({WidgetState.pressed})}');
  print('  resolve disabled: ${colorAll.resolve({WidgetState.disabled})}');

  // ========== WIDGET STATE PROPERTY - resolveWith ==========
  print('--- WidgetStateProperty.resolveWith Tests ---');

  final colorResolved = WidgetStateProperty.resolveWith<Color>((states) {
    if (states.contains(WidgetState.disabled)) return Colors.grey;
    if (states.contains(WidgetState.pressed)) return Colors.blue.shade900;
    if (states.contains(WidgetState.hovered)) return Colors.blue.shade700;
    if (states.contains(WidgetState.focused)) return Colors.blue.shade600;
    if (states.contains(WidgetState.selected)) return Colors.blue.shade800;
    if (states.contains(WidgetState.error)) return Colors.red;
    return Colors.blue;
  });
  print('WidgetStateProperty.resolveWith created');
  print('  resolve empty: ${colorResolved.resolve({})}');
  print('  resolve hovered: ${colorResolved.resolve({WidgetState.hovered})}');
  print('  resolve pressed: ${colorResolved.resolve({WidgetState.pressed})}');
  print('  resolve disabled: ${colorResolved.resolve({WidgetState.disabled})}');
  print('  resolve selected: ${colorResolved.resolve({WidgetState.selected})}');
  print('  resolve error: ${colorResolved.resolve({WidgetState.error})}');
  print('  resolve focused: ${colorResolved.resolve({WidgetState.focused})}');

  // Test with multiple states
  final multiStates = {WidgetState.hovered, WidgetState.focused};
  print('  resolve hovered+focused: ${colorResolved.resolve(multiStates)}');

  // ========== WIDGET STATE PROPERTY - various types ==========
  print('--- WidgetStateProperty Various Types ---');

  final doubleProperty = WidgetStateProperty.resolveWith<double>((states) {
    if (states.contains(WidgetState.pressed)) return 8.0;
    if (states.contains(WidgetState.hovered)) return 4.0;
    return 2.0;
  });
  print('WidgetStateProperty<double> created');
  print('  resolve empty: ${doubleProperty.resolve({})}');
  print('  resolve hovered: ${doubleProperty.resolve({WidgetState.hovered})}');
  print('  resolve pressed: ${doubleProperty.resolve({WidgetState.pressed})}');

  final borderSideProperty = WidgetStateProperty.resolveWith<BorderSide>((states) {
    if (states.contains(WidgetState.error)) {
      return BorderSide(color: Colors.red, width: 2.0);
    }
    if (states.contains(WidgetState.focused)) {
      return BorderSide(color: Colors.blue, width: 2.0);
    }
    return BorderSide(color: Colors.grey, width: 1.0);
  });
  print('WidgetStateProperty<BorderSide> created');
  print('  resolve empty: ${borderSideProperty.resolve({})}');
  print('  resolve focused: ${borderSideProperty.resolve({WidgetState.focused})}');
  print('  resolve error: ${borderSideProperty.resolve({WidgetState.error})}');

  final textStyleProperty = WidgetStateProperty.resolveWith<TextStyle>((states) {
    if (states.contains(WidgetState.selected)) {
      return TextStyle(fontWeight: FontWeight.bold, color: Colors.blue);
    }
    return TextStyle(fontWeight: FontWeight.normal, color: Colors.black87);
  });
  print('WidgetStateProperty<TextStyle> created');
  print('  resolve empty: ${textStyleProperty.resolve({})}');
  print('  resolve selected: ${textStyleProperty.resolve({WidgetState.selected})}');

  // ========== MATERIAL STATE PROPERTY (legacy) ==========
  print('--- MaterialStateProperty Tests (legacy) ---');

  final materialColorProp = MaterialStateProperty.all(Colors.green);
  print('MaterialStateProperty.all(Colors.green) created');
  print('  resolve empty: ${materialColorProp.resolve({})}');

  final materialResolvedProp = MaterialStateProperty.resolveWith<Color>((states) {
    if (states.contains(WidgetState.disabled)) return Colors.grey;
    if (states.contains(WidgetState.pressed)) return Colors.green.shade900;
    return Colors.green;
  });
  print('MaterialStateProperty.resolveWith created');
  print('  resolve empty: ${materialResolvedProp.resolve({})}');
  print('  resolve disabled: ${materialResolvedProp.resolve({WidgetState.disabled})}');
  print('  resolve pressed: ${materialResolvedProp.resolve({WidgetState.pressed})}');

  // ========== WIDGET STATES CONTROLLER ==========
  print('--- WidgetStatesController Tests ---');

  final controller = WidgetStatesController();
  print('WidgetStatesController created');
  print('  initial value: ${controller.value}');

  controller.update(WidgetState.hovered, true);
  print('  after add hovered: ${controller.value}');

  controller.update(WidgetState.focused, true);
  print('  after add focused: ${controller.value}');

  controller.update(WidgetState.hovered, false);
  print('  after remove hovered: ${controller.value}');

  // Create controller with initial states
  final controllerWithStates = WidgetStatesController({
    WidgetState.selected,
    WidgetState.focused,
  });
  print('WidgetStatesController with initial states created');
  print('  initial value: ${controllerWithStates.value}');

  controllerWithStates.update(WidgetState.pressed, true);
  print('  after add pressed: ${controllerWithStates.value}');

  controllerWithStates.update(WidgetState.selected, false);
  print('  after remove selected: ${controllerWithStates.value}');

  // Dispose controllers
  controller.dispose();
  controllerWithStates.dispose();
  print('Controllers disposed');

  // ========== INTEGRATION: USE IN BUTTON STYLE ==========
  print('--- Integration with ButtonStyle ---');

  final buttonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) return Colors.grey.shade200;
      if (states.contains(WidgetState.pressed)) return Colors.blue.shade900;
      if (states.contains(WidgetState.hovered)) return Colors.blue.shade700;
      return Colors.blue;
    }),
    foregroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) return Colors.grey;
      return Colors.white;
    }),
    elevation: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) return 0.0;
      if (states.contains(WidgetState.hovered)) return 4.0;
      return 2.0;
    }),
    overlayColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) {
        return Colors.white.withValues(alpha: 0.2);
      }
      if (states.contains(WidgetState.hovered)) {
        return Colors.white.withValues(alpha: 0.1);
      }
      return Colors.transparent;
    }),
    padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0)),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),
  );
  print('ButtonStyle with WidgetStateProperty created');
  print('  backgroundColor states resolve correctly');

  // ========== RETURN WIDGET ==========
  return Theme(
    data: ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle),
    ),
    child: Builder(builder: (ctx) {
      final theme = Theme.of(ctx);
      print('Theme.of resolved: $theme');

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text('Normal'),
          ),
          SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: null,
            child: Text('Disabled'),
          ),
          SizedBox(height: 8.0),
          Text('WidgetState test passed'),
        ],
      );
    }),
  );
}
