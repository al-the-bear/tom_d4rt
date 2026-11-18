// ignore_for_file: avoid_print
// D4rt test script: ActionIconTheme, ElevatedButtonTheme, TextButtonTheme,
// FloatingActionButtonTheme, CheckboxTheme, RadioTheme, SwitchTheme,
// ButtonThemeData (material, addtests2).
//
// Each theme widget is built around a child, its data read back, and its
// `of(context)` asked for what the ambient theme gives here.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== button themes ===');
  final action = ActionIconTheme(
    data: ActionIconThemeData(
      backButtonIconBuilder: (context) => const Icon(Icons.arrow_back_ios),
    ),
    child: const SizedBox(),
  );
  print(
    'action has back builder: ${action.data.backButtonIconBuilder != null}',
  );
  print('action of: ${ActionIconTheme.of(context) == null}');

  final elevated = ElevatedButtonTheme(
    data: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
    ),
    child: const SizedBox(),
  );
  print('elevated has style: ${elevated.data.style != null}');
  print('elevated of: ${ElevatedButtonTheme.of(context).runtimeType}');

  final text = TextButtonTheme(
    data: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Colors.indigo),
    ),
    child: const SizedBox(),
  );
  print('text has style: ${text.data.style != null}');

  final fab = FloatingActionButtonTheme(
    data: const FloatingActionButtonThemeData(elevation: 9),
    child: const SizedBox(),
  );
  print('fab elevation: ${fab.data.elevation}');

  final checkbox = CheckboxTheme(
    data: const CheckboxThemeData(splashRadius: 12),
    child: const SizedBox(),
  );
  print('checkbox splashRadius: ${checkbox.data.splashRadius}');

  final radio = RadioTheme(
    data: const RadioThemeData(splashRadius: 14),
    child: const SizedBox(),
  );
  print('radio splashRadius: ${radio.data.splashRadius}');

  final switchTheme = SwitchTheme(
    data: const SwitchThemeData(splashRadius: 16),
    child: const SizedBox(),
  );
  print('switch splashRadius: ${switchTheme.data.splashRadius}');

  const buttonTheme = ButtonThemeData(minWidth: 120, height: 44);
  print('button theme: ${buttonTheme.minWidth} x ${buttonTheme.height}');
  final copied = buttonTheme.copyWith(height: 50);
  print('button theme copy height: ${copied.height}');
  print('button theme textTheme: ${buttonTheme.textTheme}');

  return ElevatedButtonTheme(
    data: elevated.data,
    child: Center(
      child: ElevatedButton(onPressed: () {}, child: const Text('themed')),
    ),
  );
}
