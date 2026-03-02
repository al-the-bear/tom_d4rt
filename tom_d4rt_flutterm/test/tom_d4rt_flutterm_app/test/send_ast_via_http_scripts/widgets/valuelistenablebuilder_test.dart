// D4rt test script: Tests ValueListenableBuilder and ListenableBuilder from Flutter widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ValueListenableBuilder and ListenableBuilder test executing');

  // Test ValueListenableBuilder<int> with ValueNotifier
  final intNotifier = ValueNotifier<int>(0);
  print('ValueNotifier<int>(0) created');
  final vlb1 = ValueListenableBuilder<int>(
    valueListenable: intNotifier,
    builder: (BuildContext context, int value, Widget? child) {
      return Text('Int value: $value');
    },
  );
  print('ValueListenableBuilder<int> created');

  // Test ValueListenableBuilder<String> with ValueNotifier
  final stringNotifier = ValueNotifier<String>('hello');
  print('ValueNotifier<String>(hello) created');
  final vlb2 = ValueListenableBuilder<String>(
    valueListenable: stringNotifier,
    builder: (BuildContext context, String value, Widget? child) {
      return Text('String value: $value');
    },
  );
  print('ValueListenableBuilder<String> created');

  // Test ValueListenableBuilder with child parameter
  final boolNotifier = ValueNotifier<bool>(true);
  print('ValueNotifier<bool>(true) created');
  final vlb3 = ValueListenableBuilder<bool>(
    valueListenable: boolNotifier,
    builder: (BuildContext context, bool value, Widget? child) {
      return Row(children: [
        Icon(value ? Icons.check : Icons.close),
        child ?? SizedBox.shrink(),
      ]);
    },
    child: Text('Static child'),
  );
  print('ValueListenableBuilder<bool> with child created');

  // Test ValueListenableBuilder<double>
  final doubleNotifier = ValueNotifier<double>(0.75);
  print('ValueNotifier<double>(0.75) created');
  final vlb4 = ValueListenableBuilder<double>(
    valueListenable: doubleNotifier,
    builder: (BuildContext context, double value, Widget? child) {
      return Opacity(opacity: value, child: Container(width: 80, height: 40, color: Colors.blue));
    },
  );
  print('ValueListenableBuilder<double> created');

  // Test ListenableBuilder with ValueNotifier
  final listenableNotifier = ValueNotifier<int>(42);
  print('ValueNotifier<int>(42) for ListenableBuilder created');
  final lb1 = ListenableBuilder(
    listenable: listenableNotifier,
    builder: (BuildContext context, Widget? child) {
      return Text('Listenable value');
    },
  );
  print('ListenableBuilder created');

  // Test ListenableBuilder with child
  final lb2 = ListenableBuilder(
    listenable: ValueNotifier<String>('world'),
    builder: (BuildContext context, Widget? child) {
      return Container(
        padding: EdgeInsets.all(8),
        color: Colors.green,
        child: child,
      );
    },
    child: Text('Listenable child'),
  );
  print('ListenableBuilder with child created');

  print('ValueListenableBuilder and ListenableBuilder test completed');
  return Column(children: [
    vlb1,
    vlb2,
    vlb3,
    vlb4,
    lb1,
    lb2,
  ]);
}
